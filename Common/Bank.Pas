unit Bank;

interface

uses
  ABEForms, StdCtrls, DBCtrls, EtvLook, XECtrls, Mask, EtvContr, Controls,
  RXCtrls, XCtrls, DBIndex, ExtCtrls, Grids,
  DBGrids, EtvGrid, ComCtrls, Classes, XMisc, SrcIndex, XDBForms, EtvPages;
  
type
  TFormBank = class(TABEForm)
    LabelKod: TXLabel;
    EditKod: TXEDBEdit;
    XLabel1: TXLabel;
    EditKodOtd: TXEDBEdit;
    XLabel2: TXLabel;
    EditName: TXEDBEdit;
    LabelCountry: TXLabel;
    EditCountry: TXEDBLookupCombo;
    LabelPlace: TXLabel;
    EditPlace: TXEDBLookupCombo;
    LabelPIndex: TXLabel;
    EditPIndex: TXEDBEdit;
    LabelPhone: TXLabel;
    EditPhones: TXEDBEdit;
    XLabel3: TXLabel;
    EditRKC: TXEDBEdit;
    XLabel4: TXLabel;
    EditCorrCount: TXEDBEdit;
    XLabel6: TXLabel;
    XEDBEdit1: TXEDBEdit;
    XLabel7: TXLabel;
    EditPhone: TXEDBEdit;
    XLabel8: TXLabel;
    EditFax: TXEDBEdit;
    XLabel9: TXLabel;
    XEDBEdit2: TXEDBEdit;
    XLabel10: TXLabel;
    XEDBEdit3: TXEDBEdit;
    XLabel11: TXLabel;
    XEDBEdit4: TXEDBEdit;
    XLabel5: TXLabel;
    XEDBEdit5: TXEDBEdit;
    XLabel12: TXLabel;
    EditID: TXEDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormBank: TFormBank;
}
implementation

uses MdCommon;

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormBank', TFormBank);
Finalization
  UnRegisterXForm(TFormBank);
end.
