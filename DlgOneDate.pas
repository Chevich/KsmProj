unit DlgOneDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DiDate, StdCtrls, Buttons, Mask, ToolEdit, RXCtrls, ExtCtrls, CurrEdit, XCtrls;

type
  TDialogOneDate = class(TDialDate)
    CheckBoxCurBranch: TCheckBox;
    CheckBoxExpandAll: TCheckBox;
    CheckBoxFilterCondition: TCheckBox;
    BitBtn3: TBitBtn;
    LabelTPrice: TXLabel;
    EditTPrice: TCurrencyEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialogOneDate: TDialogOneDate;
implementation

{$R *.DFM}

end.
 