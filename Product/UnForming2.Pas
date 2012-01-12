unit UnForming2;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, EtvLook, EtvList,
  ToolEdit, RXDBCtrl, EtvRXCtl, RXCtrls, XCtrls, Mask, EtvContr, XMisc;

type
  TFormUnForming2 = class(TBBEForm)
    EditID: TXEDBEdit;
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    EditDate: TXEDBDateEdit;
    XLabel3: TXLabel;
    EditShift: TXEDBCombo;
    XLabel4: TXLabel;
    EditForemanName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    EditQualityInspectorName: TXEDBLookupCombo;
    Grid1: TXEDbGrid;
    XLabel6: TXLabel;
    EditShiftNum: TXEDBCombo;
    XLabel7: TXLabel;
    EditTimeBeg: TXEDBEdit;
    XLabel8: TXLabel;
    XEDBEdit1: TXEDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUnForming2: TFormUnForming2;

implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormUnForming2', TFormUnForming2);
Finalization
  UnRegisterXForm(TFormUnForming2);
end.
