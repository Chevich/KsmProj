unit EtvExp;

interface
{$I Etv.inc}

procedure RegisterExp;

implementation
uses Windows, Classes, SysUtils, forms, dialogs, EtvForms,
  Proxies, TypInfo, DsgnIntf, ToolIntf, ExptIntf, IStreams;

type

  TFormDBExpert = class(TIExpert)
    function GetName: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    procedure Execute; override;
  end;

TFormDBModule = class(TCustomModule)
public
  {procedure ValidateComponent(Component: TComponent); override;}
end;

resourcestring
  strFormDBSource =
    'unit %0:s;'#13#10 +
    ''#13#10 +
    'interface'#13#10 +
    ''#13#10 +
    'uses'#13#10 +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls,'#13#10 +
    '  Dialogs, DB, EtvForms;'#13#10 +
    ''#13#10 +
    'type'#13#10 +
    '  T%1:s = class(TFormDB)'#13#10 +
    '  private'#13#10 +
    '    { Private declarations }'#13#10 +
    '  public'#13#10 +
    '    { Public declarations }'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  %1:s: T%1:s;'#13#10 +
    ''#13#10 +
    'implementation'#13#10 +
    ''#13#10 +
    '{$R *.DFM}'#13#10 +
    ''#13#10 +
    'end.'#13#10 +
    '';
  strFormDBForm =
    'object %0:s: T%0:s'#13#10 +
    '  Left = 200'#13#10 +
    '  Top = 112'#13#10 +
    '  Width = 544'#13#10 +
    '  Height = 375'#13#10 +
    '  Caption = ''%0:s'''#13#10 +
    'end';

{ TDialogExpert }
function  TFormDBExpert.GetName: String;
begin
  Result := 'FormDB';
end;

function  TFormDBExpert.GetComment: String;
begin
  Result := 'Etv DB form';
end;

function  TFormDBExpert.GetGlyph: hIcon;
begin
  Result := 0;
end;

function  TFormDBExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

function  TFormDBExpert.GetState: TExpertState;
begin
  Result := [esEnabled];
end;

function  TFormDBExpert.GetIDString: String;
begin
  Result := 'Etv.FormDBExpert';
end;

function  TFormDBExpert.GetAuthor: String;
begin
  Result := 'Etv group';
end;

function  TFormDBExpert.GetPage: String;
begin
  Result := 'New';
end;

procedure TFormDBExpert.Execute;
var
  ISourceStream,  IFormStream: TIStreamAdapter;
  FormText, FormDFM: TStringStream;
  UnitIdent, FormIdent, FileName: String;
begin
  if ToolServices = nil then Exit;
  if ToolServices.GetNewModuleName(UnitIdent, FileName) then
  begin
    UnitIdent := AnsiLowerCase(UnitIdent);
    UnitIdent[1] := Upcase(UnitIdent[1]);
    FormIdent := 'Form' + Copy(UnitIdent, 5, MaxInt);
    FormText:= TStringStream.Create(Format(strFormDBForm,[FormIdent]));
    FormDFM:= TStringStream.Create('');
    ObjectTextToResource(FormText, FormDFM);
    FormDFM.Position := 0;
    {$IFDEF Delphi4}
    IFormStream:= TIStreamAdapter.Create(FormDFM);
    ISourceStream := TIStreamAdapter.Create(TStringStream.Create(
      Format(strFormDBSource, [UnitIdent,FormIdent])));
    ToolServices.CreateModule(FileName, ISourceStream, IFormStream,
      [cmAddToProject, cmShowSource, cmShowForm, cmUnNamed,cmMarkModified]);
    {$ELSE}
    IFormStream:= TIStreamAdapter.Create(FormDFM,False);
    try
      IFormStream.AddRef;
      ISourceStream := TIStreamAdapter.Create(TStringStream.Create(
        Format(strFormDBSource, [UnitIdent,FormIdent])),False);
      try
        ISourceStream.AddRef;
        ToolServices.CreateModule(FileName, ISourceStream, IFormStream,
          [cmAddToProject, cmShowSource, cmShowForm, cmUnNamed,
          cmMarkModified]);
      finally
        ISourceStream.Free;
      end;
    finally
      IFormStream.Free;
    end;
    {$ENDIF}
  end;
end;

procedure RegisterExp;
begin
  registerCustomModule(TFormDB, TFormDBModule);
  {$WARNINGS OFF}
  RegisterLibraryExpert(TFormDBExpert.Create);
  {$WARNINGS ON}
end;

            
end.
