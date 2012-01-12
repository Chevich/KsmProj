Unit XSplash;

Interface

Uses Classes, Forms, ExtCtrls;

Const scDefaultClass ='scDefault';

type

{ TXSplashForm }

  TXSplashClass = class of TXSplashForm;

  TXSplashForm = class(TForm)
  private
    FCountForms: Integer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    function GetHardLabel: String;virtual; abstract;
    procedure SetHardLabel(Const Value: String); virtual; abstract;
    function GetTaskLabel: String;virtual; abstract;
    procedure SetTaskLabel(Const Value: String); virtual; abstract;
    function GetAutsLabel: String; virtual; abstract;
    procedure SetAutsLabel(Const Value: String); virtual; abstract;
    function GetImage: TImage; virtual; abstract;
    function GetVisProgress: Boolean; virtual; abstract;
    procedure SetVisProgress(Value: Boolean); virtual; abstract;
    function GetProgress: Integer; virtual; abstract;
    procedure SetProgress(Value: Integer); virtual; abstract;
    function GetProgressCount: Integer; virtual;
    procedure SetProgressCount(Value: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure AutoSplash;
    property XHardLabel: String read GetHardLabel write SetHardLabel;
    property XTaskLabel: String read GetTaskLabel write SetTaskLabel;
    property XAutsLabel: String read GetAutsLabel write SetAutsLabel;
    property XImage: TImage read GetImage;
    property XProgress: Integer read GetProgress write SetProgress;
    property XProgressCount: Integer read GetProgressCount write SetProgressCount;
    property VisProgress: Boolean read GetVisProgress write SetVisProgress;
  end;

Var SystemSplashForm: TXSplashForm = nil;

Implementation

Uses Windows, Messages, Dialogs, XMisc;

Constructor TXSplashForm.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  ModalResult:=0;
  XProgress:=0;
  OnKeyDown:=FormKeyDown;
  SystemSplashForm:=Self;
end;
{
          HardLabel.Caption:=FOrgName;
          TaskLabel.Caption:=FTaskName;
          AutsLabel.Caption:=FAuthorsName;
}
Function TXSplashForm.GetProgressCount: Integer;
begin
  Result:=FCountForms;
end;

Procedure TXSplashForm.SetProgressCount(Value: Integer);
begin
  FCountForms:=Value;
end;

Procedure TXSplashForm.AutoSplash;
begin
  if Application.Terminated then Exit;
  IsAppActive:=False;
  Application.ProcessMessages;
  IsAppActive:=True;
  XProgress:=XProgress+5;
{  if XProgress>=XProgressCount then}
  PostMessage({HWND_BROADCAST}Application.Handle, wm_ActivateApp, Word(True), 0);
end;

Procedure TXSplashForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=vk_Escape then begin
    ModalResult:=0;
    MessageDlg('Работа приложения прервана', mtInformation, [mbOk], 0);
    if not (csDesigning in ComponentState) then begin
      Application.Terminate;
      Application.ProcessMessages;
{
      Application.Free;
      Application:=nil;
}
      {Halt;}
    end;
  end;
end;

end.
