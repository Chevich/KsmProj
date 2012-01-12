{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Scripting: core                               }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgScript;

interface
uses Windows, SysUtils, Classes, ComObj;

type
{ TCustomScript }
  TCustomScript = class(TComponent)
  private
    FLines: TStrings;
    FRefCount: Integer;
    procedure LinesChanged(Sender: TObject);
    procedure SetLines(Value: TStrings);
  protected
    procedure DoBeginExecute; virtual;
    function DoCreateObject: OleVariant; virtual;
    procedure DoEndExecute; virtual;
    function DoExecute(Params: Variant): Variant; virtual;
    procedure DoLinesChanged; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(const Params: Variant): Variant;
    procedure BeginExecute;
    procedure EndExecute;
    { Properties }
    property Lines: TStrings read FLines write SetLines;
  end;

{ TCustomBaseScript }
  TCreateObjectEvent = procedure (Sender: TObject; var Obj: OleVariant) of object;

  TCustomBaseScript = class(TCustomScript)
  private
    FOnCreateObject: TCreateObjectEvent;
  protected
    function DoCreateObject: OleVariant; override;
  public
    { properties }
    property OnCreateObject: TCreateObjectEvent read FOnCreateObject write FOnCreateObject;
  end;

{ EScriptError }
  EScriptError = class(Exception)
  private
    FLine, FColumn: Integer;
  public
    constructor Create(const Msg: string; ALine, AColumn: Integer);
    property Line: Integer read FLine;
    property Column: Integer read FColumn;
  end;

implementation
uses ActiveX, vgUtils;

{ EScriptError }
constructor EScriptError.Create(const Msg: string; ALine, AColumn: Integer);
begin
  inherited Create(Msg);
  FLine := ALine;
  FColumn := AColumn;
end;

{ TCustomScript }
constructor TCustomScript.Create(AOwner: TComponent);
begin
  inherited;
  FLines := TStringList.Create;
  TStringList(FLines).OnChange := LinesChanged;
end;

destructor TCustomScript.Destroy;
begin
  FLines.Free;
  inherited;
end;

procedure TCustomScript.DoBeginExecute;
begin
end;

function TCustomScript.DoCreateObject: OleVariant;
begin
  Result := Null;
end;

procedure TCustomScript.DoEndExecute;
begin
end;

function TCustomScript.DoExecute(Params: Variant): Variant;
begin
  Result := Null;
end;

function TCustomScript.Execute(const Params: Variant): Variant;
begin
  BeginExecute;
  try
    Result := DoExecute(Params);
  finally
    EndExecute;
  end;
end;

procedure TCustomScript.BeginExecute;
begin
  if FRefCount = 0 then DoBeginExecute;
  Inc(FRefCount);
end;

procedure TCustomScript.EndExecute;
begin
  Dec(FRefCount);
  if FRefCount = 0 then DoEndExecute;
end;

procedure TCustomScript.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TCustomScript.LinesChanged(Sender: TObject);
begin
  DoLinesChanged;
end;

procedure TCustomScript.DoLinesChanged;
begin
end;

{ TCustomBaseScript }
function TCustomBaseScript.DoCreateObject: OleVariant;
begin
  Result := Null;
  if Assigned(FOnCreateObject) then FOnCreateObject(Self, Result);
end;

end.


