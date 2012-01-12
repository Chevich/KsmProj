unit About;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, RXCtrls, ExtCtrls;

type
  TAboutForm = class(TForm)
    SecretPanel1: TSecretPanel;
    AppIcon: TImage;
    rxLabel5: TrxLabel;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    procedure AppIconDblClick(Sender: TObject);
    procedure SecretPanel1DblClick(Sender: TObject);
    procedure SecretPanel1Click(Sender: TObject);
    procedure AppIconClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var AboutForm:TAboutForm;

implementation

uses RxConst,etvPas,DataMod1;

{$R *.DFM}

procedure TAboutForm.AppIconDblClick(Sender: TObject);
begin
  SecretPanel1.Active := True;
end;

procedure TAboutForm.SecretPanel1DblClick(Sender: TObject);
begin
  SecretPanel1.Active := False;
end;

procedure TAboutForm.SecretPanel1Click(Sender: TObject);
begin
  SecretPanel1.Active := False;
end;

procedure TAboutForm.AppIconClick(Sender: TObject);
begin
  SecretPanel1.Active := True;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  Label3.Caption:='Alias: '+dm1.EtvDBGKSM.AliasName;
end;

end.
