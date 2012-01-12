unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TStartForm = class(TForm)
    MainMenu1: TMainMenu;
    FileMenuItem: TMenuItem;
    File1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure File1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StartForm: TStartForm;

implementation

Uses MdMaterials,Materials, MInvoice;
{$R *.DFM}

procedure TStartForm.File1Click(Sender: TObject);
begin
  FormMat.Show;
end;

procedure TStartForm.N1Click(Sender: TObject);
begin
  MInvoiceForm.Show
end;

end.
