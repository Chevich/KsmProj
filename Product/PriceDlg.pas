unit PriceDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, RXCtrls, XCtrls, CurrEdit, Buttons, DBCtrls,
  EtvLook, XECtrls;

type
  TFormPriceDlg = class(TForm)
    XLabel14: TXLabel;
    EditDate: TDateEdit;
    XLabel1: TXLabel;
    EditKoeff: TCurrencyEdit;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    XLabel2: TXLabel;
    EditTare: TCurrencyEdit;
    XLabel3: TXLabel;
    EditTPrice: TCurrencyEdit;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBoxUpdateExistRecord: TCheckBox;
    XLabel4: TXLabel;
    EditKoeffRateVAT: TCurrencyEdit;
    XLabel5: TXLabel;
    EditExtra: TCurrencyEdit;
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPriceDlg: TFormPriceDlg;

implementation
uses MdProd;

{$R *.DFM}

procedure TFormPriceDlg.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_Return) then
    PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_Tab,0);
end;

end.
