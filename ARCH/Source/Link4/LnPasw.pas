unit LnPasw;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons;

type
  TLnPaswDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    User: TEdit;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LnPaswDlg: TLnPaswDlg;

implementation

{$R *.DFM}

procedure TLnPaswDlg.FormActivate(Sender: TObject);
begin
  if User.Text<>'' then Password.SetFocus;
end;

end.
 
