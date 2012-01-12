unit Shop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MBEForms, StdCtrls, SrcIndex, XDBForms, ExtCtrls, Grids, DBGrids,
  EtvGrid, XECtrls, ComCtrls, EtvPages, RXCtrls, XCtrls, ToolEdit,
  RXDBCtrl, EtvRXCtl, Mask, DBCtrls, EtvContr, EtvLook, EtvList;

type
  TFormShop = class(TMBEForm)
    LabelKod: TXLabel;
    EditKod: TXEDBEdit;
    LabelDate: TXLabel;
    sDateEdit: TXEDBDateEdit;
    LabelSumma: TXLabel;
    LabelBuyer: TXLabel;
    EditFIO: TXEDBEdit;
    LabelAddress: TXLabel;
    EditAddress: TXEDBEdit;
    LabelAdditInfo: TXLabel;
    EditAdditInfo: TXEDBEdit;
    XLabel1: TXLabel;
    SummaText: TEtvDBText;
    XEDBCombo1: TXEDBCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormShop: TFormShop;

implementation
uses XMisc;
{$R *.DFM}
Initialization
  RegisterAliasXForm('FormShop', TFormShop);
Finalization
  UnRegisterXForm(TFormShop);

end.
 