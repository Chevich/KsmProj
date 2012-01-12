unit UnForming1;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, EtvLook, EtvList,
  ToolEdit, RXDBCtrl, EtvRXCtl, RXCtrls, XCtrls, Mask, EtvContr, XMisc;

type
  TFormUnForming1 = class(TBBEForm)
    EditID: TXEDBEdit;
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    EditDate: TXEDBDateEdit;
    XLabel3: TXLabel;
    EditShift: TXEDBCombo;
    XLabel4: TXLabel;
    EditForemanName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    EditForemanChiefName: TXEDBLookupCombo;
    XLabel6: TXLabel;
    EditQualityInspectorName: TXEDBLookupCombo;
    XLabel7: TXLabel;
    EditForemanShippingName: TXEDBLookupCombo;
    XLabel8: TXLabel;
    EditForemanPackageName: TXEDBLookupCombo;
    Grid1: TXEDbGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUnForming1: TFormUnForming1;

implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormUnForming1', TFormUnForming1);
Finalization
  UnRegisterXForm(TFormUnForming1);
end.
