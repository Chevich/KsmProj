unit ContrProd;

interface

uses
  Forms, BEForms, DBCtrls, EtvLook, XECtrls, StdCtrls, Mask, EtvContr,
  Controls, RXCtrls, XCtrls, DBIndex, 
  ExtCtrls, Grids, DBGrids, EtvGrid, ComCtrls, Classes, XMisc, SrcIndex,
  XDBForms, EtvPages;

type
  TFormContractProd = class(TBEForm)
    XLabel1: TXLabel;
    EditAutoInc: TXEDBEdit;
    XLabel2: TXLabel;
    EditContract: TXEDBEdit;
    XLabel3: TXLabel;
    EditProdName: TXEDBLookupCombo;
    XLabel4: TXLabel;
    EditAmount: TXEDBEdit;
    XLabel5: TXLabel;
    EditTPriceName: TXEDBLookupCombo;
    XLabel6: TXLabel;
    EditTareName: TXEDBLookupCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormContractProd: TFormContractProd;
}
implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormContractProd', TFormContractProd);
Finalization
  UnRegisterXForm(TFormContractProd);
end.
