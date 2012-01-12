{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Scripting: MS Script control                  }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgMSScr;

interface
uses Classes, vgScript, MSScript;

type
  TScriptLanguage = (slVBScript, slJScript);

  TCustomMSSCScript = class(TCustomBaseScript)
  private
    FResetNeeded: Boolean;
    FAllowUI: Boolean;
    FLanguage: TScriptLanguage;
    FMainProc, FObjectName: string;
    FScriptControl: TScriptControl;
    function IsMainProcStored: Boolean;
    function IsObjectNameStored: Boolean;
    procedure SetLanguage(Value: TScriptLanguage);
    procedure SetMainProc(Value: string);
    procedure SetObjectName(Value: string);
  protected
    procedure DoBeginExecute; override;
    procedure DoEndExecute; override;
    function DoExecute(Params: Variant): Variant; override;
    procedure DoError;
    procedure DoLinesChanged; override;
    property ScriptControl: TScriptControl read FScriptControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecuteStatement(const Statement: string);
    { Properties }
    property AllowUI: Boolean read FAllowUI write FAllowUI default False;
    property Lines;
    property Language: TScriptLanguage read FLanguage write SetLanguage default slVBScript;
    property MainProc: string read FMainProc write SetMainProc stored IsMainProcStored;
    property ObjectName: string read FObjectName write SetObjectName stored IsObjectNameStored;
  end;

  TMSSCScript = class(TCustomMSSCScript)
  published
    property AllowUI;
    property Lines;
    property Language;
    property MainProc;
    property ObjectName;
    property OnCreateObject;
  end;

implementation
uses SysUtils, ActiveX, vgOleUtl;

const
  DefaultMainProc   = 'Main';
  DefaultObjectName = 'Script';
  Languages: array [TScriptLanguage] of string = ('VBScript', 'JScript');

constructor TCustomMSSCScript.Create(AOwner: TComponent);
begin
  inherited;
  FMainProc := DefaultMainProc;
  FObjectName := DefaultObjectName;
  FResetNeeded := True;
end;

destructor TCustomMSSCScript.Destroy;
begin
  FScriptControl.Free;
  inherited;
end;

procedure TCustomMSSCScript.DoError;
var
  Descr: string;
begin
  with FScriptControl.ErrorObject do
  begin
    Descr := Description;
    if Descr <> '' then
      raise EScriptError.Create(Format('%s'#13#10'%s (%d, %d)',
        [Source, Descr, Line, Column]), Line, Column) else
      raise EScriptError.Create(Exception(ExceptObject).Message, -1, -1);
  end;
end;

procedure TCustomMSSCScript.DoLinesChanged;
begin
  FResetNeeded := True;
end;

procedure TCustomMSSCScript.DoBeginExecute;
var
  Script: Variant;
begin
  if not Assigned(FScriptControl) then
    FScriptControl := TScriptControl.Create(nil);
  with FScriptControl do
  begin
    AllowUI := FAllowUI;
    Timeout := -1;
    UseSafeSubset := True;
    if FResetNeeded then
    begin
      Language := Languages[FLanguage];
      Reset;
      Script := DoCreateObject;
      if not VarIsNull(Script) then
        AddObject(FObjectName, VarToInterface(Script), True);
      AddCode(Lines.Text);
    end;
  end;
end;

procedure TCustomMSSCScript.DoEndExecute;
begin
  FScriptControl.Free;
  FScriptControl := nil;
end;

function TCustomMSSCScript.DoExecute(Params: Variant): Variant;
var
  Tmp: PSafeArray;
  Bounds: array [0..0] of TSafeArrayBound;
  I: Integer;
  V: Variant;
begin
  Bounds[0].lLbound := 0;
  if VarIsEmpty(Params) then
    Bounds[0].cElements := 0
  else if VarIsArray(Params) then
    Bounds[0].cElements := VarArrayHighBound(Params, 1)
  else
    Bounds[0].cElements := 1;

  Tmp := SafeArrayCreate(VT_VARIANT, 1, Bounds);
  try
    I := 0;
    if Bounds[0].cElements = 1 then
      SafeArrayPutElement(Tmp, I, Params)
    else for I := 0 to Bounds[0].cElements - 1 do
    begin
      V := Params[I];
      SafeArrayPutElement(Tmp, I, V)
    end;
    try
      IsMultithread := True;
      Result := FScriptControl.Run(FMainProc, Tmp);
    except
      DoError;
    end;
  finally
    SafeArrayDestroy(Tmp);
  end;
end;

procedure TCustomMSSCScript.ExecuteStatement(const Statement: string);
begin
  BeginExecute;
  try
    try
      IsMultithread := True;
      FScriptControl.ExecuteStatement(Statement);
    except
      DoError;
    end;
  finally
    EndExecute;
  end;
end;

function TCustomMSSCScript.IsMainProcStored: Boolean;
begin
  Result := FMainProc <> DefaultMainProc;
end;

function TCustomMSSCScript.IsObjectNameStored: Boolean;
begin
  Result := FObjectName <> DefaultObjectName;
end;

procedure TCustomMSSCScript.SetLanguage(Value: TScriptLanguage);
begin
  if FLanguage <> Value then
  begin
    FLanguage := Value;
    FResetNeeded := True;
  end;
end;

procedure TCustomMSSCScript.SetMainProc(Value: string);
begin
  if FMainProc <> Value then
  begin
    FMainProc := Value;
  end;
end;

procedure TCustomMSSCScript.SetObjectName(Value: string);
begin
  if FObjectName <> Value then
  begin
    FObjectName := Value;
    FResetNeeded := True;
  end;
end;

end.
