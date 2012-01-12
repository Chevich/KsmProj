unit BLabel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Gauges, RXCtrls, ComCtrls,dbtables;

type
  TFormBankLabel = class(TForm)
    Panel2: TPanel;
    Image1: TImage;
    ProgressBar1: TProgressBar;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inc(n:integer);
    procedure IncL(n:integer; s:string);
    procedure DBLogin(Database: TDatabase; LoginParams: TStrings);
  end;

var
  FormBankLabel: TFormBankLabel;

implementation
uses Login;
{$R *.DFM}
procedure TFormBankLabel.DBLogin(Database: TDatabase; LoginParams: TStrings);
  Var LoginForm:TLoginForm;
begin
  LoginForm:=TLoginForm.Create(self);
  with LoginForm do
    begin
      if LoginParams.Count>0 then UserName.Text:=LoginParams.Values['USER NAME'];
      Top:=FormBankLabel.Top+FormBankLabel.Height;
      Left:=FormBankLabel.Left+trunc((FormBankLabel.Width-Width)/2);
      if ShowModal=mrOk then begin
        LoginParams.Values['USER NAME'] := UserName.Text;
	LoginParams.Values['PASSWORD'] := Password.Text;
      end
      else begin
        ExitProcess(Application.Handle);
      end;
     free;
    end;
end;

procedure TFormBankLabel.Inc(n: integer);
begin
  ProgressBar1.Position:=ProgressBar1.Position+n*ProgressBar1.Step;
  Update;
end;

procedure TFormBankLabel.IncL(n: integer; s:string);
begin
  Inc(n);
end;

procedure TFormBankLabel.FormActivate(Sender: TObject);
begin
  Update;
end;

end.
