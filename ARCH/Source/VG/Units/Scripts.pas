unit Scripts;

interface

uses
  SysUtils, Classes;

type

  TScriptSource = class;

  TSentence = class
  private
    FPrefix: String;
    FText: TStrings;
    function GetSentence(Script: TStrings; var StrNum: Integer): Boolean;
    procedure SetText(AText: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    property Prefix: String read FPrefix;
    property Text: TStrings read FText write SetText;
  end;

  TSentenceEvent = procedure (Sender: TObject; Sentence: TSentence) of object;

  TScript = class(TComponent)
  private
    { Private declarations }
    FActive: Boolean;
    FIdent: String;
    FScriptSource: TScriptSource;
    FParams: array[0..1] of TStrings;
    FScript: TStrings;
    FValues: array[0..3] of TList;
    FOnExecute: TNotifyEvent;
    FOnExecSentence: TSentenceEvent;
    function CheckParam(ParamList: TStrings; AName: String): Integer;
    function GetValues(AName: String; Index: Integer): Variant;
    procedure ParamChanged(Sender: TObject);
    procedure SetScriptSource(Value: TScriptSource);
    procedure SetValues(AName: String; Index: Integer; AValue: Variant);
    procedure SetIdent(AIdent: String);
    procedure SetParams(Index: Integer; Params: TStrings);
    procedure SetScript(AScript: TStrings);
    { Protected declarations }
    procedure DoExecute; virtual;
    procedure DoExecSentence(Sentence: TSentence); virtual;
    procedure CheckScriptSource;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute; virtual;
    property Active: Boolean read FActive;
    property InputValues[AName: String]: Variant index 0 read GetValues write SetValues;
    property OutputValues[AName: String]: Variant index 1 read GetValues write SetValues;
  published
    { Published declarations }
    property Ident: String read FIdent write SetIdent;
    property Inputs: TStrings index 0 read FParams[0] write SetParams;
    property Outputs: TStrings index 1 read FParams[1] write SetParams;
    property Script: TStrings read FScript write SetScript;
    property ScriptSource: TScriptSource read FScriptSource write SetScriptSource;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnExecSentence: TSentenceEvent read FOnExecSentence write FOnExecSentence;
  end;

  TScriptEvent = procedure (Sender: TObject; Script: TScript) of object;

  TScriptSource = class(TComponent)
  private
  { Private declarations }
    FScripts: TList;
    FOnCreateScript: TScriptEvent;
    FOnLoadScript: TScriptEvent;
    function GetScriptCount: Integer;
    function GetScript(Index: Integer): TScript;
  protected
  { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CheckIdent(Script: TScript; AIdent: String);
    procedure DoLoadScript(Script: TScript); virtual;
    procedure InsertScript(Script: TScript);
    procedure RemoveScript(Script: TScript);
  public
  { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateScript(AIdent: String): TScript; virtual;
    function FindScript(AIdent: String): TScript;
    function LoadScript(AIdent: String): TScript;
    procedure UnLoadScript(AIdent: String);
    function IsScriptLoaded(AIdent: String): Boolean;
    function ScriptNeeded(AIdent: String): TScript;
    function ScriptByIdent(AIdent: String): TScript;
    property ScriptCount: Integer read GetScriptCount;
    property Scripts[Index: Integer]: TScript read GetScript;
  published
  { Published declarations }
    property OnCreateScript: TScriptEvent read FOnCreateScript write FOnCreateScript;
    property OnLoadScript: TScriptEvent read FOnLoadScript write FOnLoadScript;
  end;

procedure Register;

const
  eoc                     = 'go';

const
  SSentenceEndExpected    = 'Sentence end expected at line %d';
  SSentenceEmpty          = 'Sentence empty';
  SParamNotFound          = 'Parameter %s not found.';
  SScriptAlreadyActive    = 'Script %s already execing.';
  SScriptSourceNotFound   = 'Script source for script %s not found.';
  SScriptNotFound         = 'Script %s not found.';
  SScriptDupName          = 'Script with ident %s already exists.';
  SScriptExecFailure      = 'Can''t execute script %s:'#13#10'%s';

implementation
type
  PValueRec = ^TValueRec;
  TValueRec = record
    Value: Variant;
  end;

procedure Register;
begin
  RegisterComponents('VG System', [TScript, TScriptSource]);
end;

{ TSentence }
constructor TSentence.Create;
begin
  FText := TStringList.Create;
end;

destructor TSentence.Destroy;
begin
  FText.Free;
  inherited;
end;

function TSentence.GetSentence(Script: TStrings; var StrNum: Integer): Boolean;
  function GetString(S: TStrings; var Str: String; var StrNum: Integer): Boolean;
  begin
    Result := StrNum < S.Count;
    if Result then
    begin
      Str := Trim(S[StrNum]);
      Inc(StrNum);
    end;
  end;
var
  APrefix, AStr: String;
  AText: TStrings;
  Res, EndSentence: Boolean;
begin
  Result := False;
  AText := TStringList.Create;
  try
    repeat
      Res := GetString(Script, APrefix, StrNum);
      if Res and (APrefix <> '') then Break;
    until not Res;
    if not Res then Exit;

    EndSentence := False;
    repeat
      Res := GetString(Script, AStr, StrNum);
      if Res then
      begin
        EndSentence := (AnsiCompareText(AStr, eoc) = 0);
        if (AStr <> '') and not EndSentence then AText.Add(AStr);
      end;
    until not Res or EndSentence;

    if not Res then
    begin
      if not EndSentence then
        raise EInvalidOp.Create(Format(SSentenceEndExpected, [StrNum]));
    end;

    if (AText.Count = 0) then
      raise EInvalidOp.Create(SSentenceEmpty);

    FPrefix := APrefix;
    FText.Assign(AText);

    Result := True;
  finally
    AText.Free;
  end;
end;

procedure TSentence.SetText(AText: TStrings);
begin
  FText.Assign(AText);
end;

{ TScript }
constructor TScript.Create(AOwner: TComponent);
begin
  inherited;
  FParams[0] := TStringList.Create; FParams[1] := TStringList.Create;
  TStringList(FParams[0]).OnChange := ParamChanged;
  TStringList(FParams[1]).OnChange := ParamChanged;
  FValues[0] := TList.Create; FValues[1] := TList.Create;
  FValues[2] := TList.Create; FValues[3] := TList.Create;
  FScript := TStringList.Create;
end;

destructor TScript.Destroy;
begin
  SetScriptSource(nil);
  FParams[0].Clear; FParams[1].Clear;
  FParams[0].Free;  FParams[1].Free;
  FValues[0].Free;  FValues[1].Free;
  FValues[2].Free;  FValues[3].Free;
  FScript.Free;
  inherited;
end;

procedure TScript.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FScriptSource) then
    FScriptSource := nil;
end;

function TScript.CheckParam(ParamList: TStrings; AName: String): Integer;
begin
  Result := ParamList.IndexOf(AName);
  if (Result = -1) then raise EInvalidOp.Create(Format(SParamNotFound, [AName]));
end;

procedure TScript.CheckScriptSource;
begin
  if not Assigned(FScriptSource) then
    raise EInvalidOp.Create(Format(SScriptSourceNotFound, [Ident]));
end;

procedure TScript.DoExecute;
begin
  if Assigned(FOnExecute) then FOnExecute(Self);
end;

procedure TScript.DoExecSentence(Sentence: TSentence); 
begin
  if Assigned(FOnExecSentence) then FOnExecSentence(Self, Sentence);
end;

procedure TScript.Execute;
var
  Sentence: TSentence;
  StrNum: Integer;
begin
  if FActive then raise EInvalidOp.Create(Format(SScriptAlreadyActive, [Ident]));
  try
    FActive := True;
    CheckScriptSource;
    DoExecute;
    StrNum := 0;
    Sentence := TSentence.Create;
    try
      try
        while Sentence.GetSentence(Script, StrNum) do
          DoExecSentence(Sentence);
      finally
        Sentence.Free;
      end;
    except
      raise EInvalidOp.Create(
        Format(SScriptExecFailure, [Ident, Exception(ExceptObject).Message]));
    end;
  finally
    FActive := False;
  end;
end;

function TScript.GetValues(AName: String; Index: Integer): Variant;
var
  I: Integer;
  P: Pointer;
begin
  I := CheckParam(FParams[Index], AName);
  P := FValues[Index][I];
  Result := PValueRec(P)^.Value;
end;

procedure TScript.ParamChanged(Sender: TObject);
var
  I: Integer;
  ParamCount: Integer;
  Vals: TList;
  P: Pointer;
begin
  Vals := FValues[Integer(Sender = FParams[1])];
  for I := 0 to Vals.Count - 1 do
  begin
    P := Vals[I];
    ReAllocMem(P, 0);
  end;
  Vals.Clear;
  for I := 0 to TStrings(Sender).Count - 1 do
  begin
    GetMem(P, SizeOf(TValueRec));
    Vals.Add(P);
  end;
end;

procedure TScript.SetIdent(AIdent: String);
begin
  if (FIdent = AIdent) then Exit;
  if Assigned(FScriptSource) then FScriptSource.CheckIdent(Self, AIdent);
  FIdent := AIdent;
end;

procedure TScript.SetParams(Index: Integer; Params: TStrings);
begin
  FParams[Index].Assign(Params);
end;

procedure TScript.SetScript(AScript: TStrings);
begin
  FScript.Assign(AScript);
end;

procedure TScript.SetScriptSource(Value: TScriptSource);
begin
  if FScriptSource <> Value then
  begin
    if Assigned(FScriptSource) then FScriptSource.RemoveScript(Self);
    FScriptSource := Value;
    if Assigned(FScriptSource) then FScriptSource.InsertScript(Self);
  end;
end;

procedure TScript.SetValues(AName: String; Index: Integer; AValue: Variant);
var
  I: Integer;
  P: Pointer;
begin
  I := CheckParam(FParams[Index], AName);
  P := FValues[Index][I];
  PValueRec(P)^.Value := AValue;
end;

constructor TScriptSource.Create(AOwner: TComponent);
begin
  inherited;
  FScripts := TList.Create;
end;

destructor TScriptSource.Destroy;
begin
  FScripts.Free;
  inherited;
end;

procedure TScriptSource.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    I := FScripts.IndexOf(AComponent);
    if (I >= 0) then FScripts.Delete(I);
  end;
end;

procedure TScriptSource.DoLoadScript(Script: TScript);
begin
  if Assigned(FOnLoadscript) then FOnLoadScript(Self, Script);
end;

function TScriptSource.GetScript(Index: Integer): TScript;
begin
  Result := FScripts[Index];
end;

function TScriptSource.GetScriptCount: Integer;
begin
  Result := FScripts.Count;
end;

procedure TScriptSource.InsertScript(Script: TScript);
begin
  CheckIdent(Script, Script.Ident);
  FScripts.Add(Script);
  FreeNotification(Script);
end;

procedure TScriptSource.RemoveScript(Script: TScript);
begin
  FScripts.Remove(Script);
end;

procedure TScriptSource.CheckIdent(Script: TScript; AIdent: String);
var
  S: TScript;
begin
  S := FindScript(AIdent);
  if Assigned(S) and (S <> Script) then
    raise EInvalidOp.Create(Format(SScriptDupName, [AIdent]));
end;

function TScriptSource.CreateScript(AIdent: String): TScript;
begin
  Result := TScript.Create(Self);
  try
    Result.Ident := AIdent;
    Result.ScriptSource := Self;
    if Assigned(FOnCreateScript) then FOnCreateScript(Self, Result);
  except
    Result.Free;
    raise;
  end;
end;

function TScriptSource.FindScript(AIdent: String): TScript;
var
  I: Integer;
begin
  for I := 0 to FScripts.Count - 1 do
  begin
    Result := TScript(FScripts[I]);
    if (AnsiCompareText(Result.Ident, AIdent) = 0) then Exit;
  end;
  Result := nil;
end;

function TScriptSource.IsScriptLoaded(AIdent: String): Boolean;
begin
  Result := Assigned(FindScript(AIdent))
end;

function TScriptSource.LoadScript(AIdent: String): TScript;
begin
  Result := CreateScript(AIdent);
  try
    DoLoadScript(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TScriptSource.ScriptNeeded(AIdent: String): TScript;
begin
  Result := FindScript(AIdent);
  if not Assigned(Result) then Result := Loadscript(AIdent);
end;

function TScriptSource.ScriptByIdent(AIdent: String): TScript;
begin
  Result := FindScript(AIdent);
  if not Assigned(Result) then
    raise EInvalidOp.Create(Format(SScriptNotFound, [AIdent]));
end;

procedure TScriptSource.UnLoadScript(AIdent: String);
begin
  FindScript(AIdent).Free;
end;

end.
