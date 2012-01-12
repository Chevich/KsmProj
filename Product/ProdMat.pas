unit ProdMat;

interface

uses
  BEForms, DBCtrls, EtvContr, XECtrls, StdCtrls, Mask, ToolEdit, RXDBCtrl,
  EtvLook, Controls, RXCtrls, XCtrls, DBIndex, 
  ExtCtrls, Grids, DBGrids, EtvGrid, ComCtrls, Classes, XMisc,
  EtvRXCtl, SrcIndex, XDBForms, EtvPages;

type
  TFormProdMat = class(TBEForm)
    XLabel1: TXLabel;
    EditProdName: TXEDBLookupCombo;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    EditDateM: TXEDBDateEdit;
    XLabel4: TXLabel;
    EditWorkName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    EditNorm: TXEDBEdit;
    EditMatName: TXEDBLookupCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormProdMat: TFormProdMat;
}
implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormProdMat', TFormProdMat);
Finalization
  UnRegisterXForm(TFormProdMat);
end.
