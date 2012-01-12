unit login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RXCtrls;

type
  TLoginForm = class(TForm)
    Panel1: TPanel;
    okButton: TButton;
    CancelButton: TButton;
    Password: TEdit;
    UserName: TEdit;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    procedure FormActivate(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.DFM}

procedure TLoginForm.FormActivate(Sender: TObject);
begin
  if UserName.Text<>'' then SelectNext(UserName,true,true);
  if Assigned(Password.OnChange) then Password.OnChange(nil)
end;

procedure TLoginForm.PasswordChange(Sender: TObject);
begin
  okButton.Enabled:=(Trim(Password.Text)<>'') and (Trim(UserName.Text)<>'')
end;

end.
