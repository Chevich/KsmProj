unit DlgUnLock;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXCtrls, XCtrls, StdCtrls, Buttons, Mask, ToolEdit;

type
  TFormDlgUnLock = class(TForm)
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    XLabel5: TXLabel;
    LabelNum: TXLabel;
    LabelDate: TXLabel;
    Fam: TEdit;
    Im: TEdit;
    Otch: TEdit;
    NumInvoice: TEdit;
    XLabel8: TXLabel;
    EmpNo: TEdit;
    DateBorn: TDateEdit;
    DateWorkKSM: TDateEdit;
    DateInvoice: TDateEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var FormDlgUnLock: TFormDlgUnLock;

Implementation

{$R *.DFM}

procedure TFormDlgUnLock.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_Return) then
    PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_Tab,0);
end;

end.
