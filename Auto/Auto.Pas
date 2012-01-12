unit Auto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, MdAuto, XMisc, BBEForms,
  ToolEdit, RXDBCtrl, EtvRXCtl, Mask, EtvContr, RXCtrls, XCtrls, EtvLook;

type
  TFormAuto = class(TBBEForm)
    XLabel1: TXLabel;
    EditBillNumber: TXEDBEdit;
    XLabel2: TXLabel;
    EditsDate: TXEDBDateEdit;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    EditKod: TXEDBEdit;
    XLabel5: TXLabel;
    XLabel6: TXLabel;
    XLabel7: TXLabel;
    EditAccompany: TXEDBEdit;
    GroupBox1: TGroupBox;
    XLabel9: TXLabel;
    XLabel8: TXLabel;
    EditTrailer1: TXEDBEdit;
    EditTrailer2: TXEDBEdit;
    XLabel10: TXLabel;
    EditDriverTask: TXEDbGrid;
    XLabel11: TXLabel;
    GroupBox2: TGroupBox;
    XLabel12: TXLabel;
    XLabel13: TXLabel;
    XLabel14: TXLabel;
    EditFuelIssue: TXEDBEdit;
    EditFuelRestOUT: TXEDBEdit;
    EditFuelRestIN: TXEDBEdit;
    EditFuelReturn: TXEDBEdit;
    XLabel15: TXLabel;
    XLabel16: TXLabel;
    GroupBox3: TGroupBox;
    XLabel17: TXLabel;
    XLabel18: TXLabel;
    XLabel19: TXLabel;
    EditTimeScheduleON: TXEDBEdit;
    EditTimeScheduleOFF: TXEDBEdit;
    EditZeroRunON: TXEDBEdit;
    EditZeroRunOFF: TXEDBEdit;
    EditSpeedometerON: TXEDBEdit;
    EditSpeedometerOFF: TXEDBEdit;
    XLabel20: TXLabel;
    XLabel21: TXLabel;
    EditTimeActualON: TXEDBEdit;
    EditTimeActualOFF: TXEDBEdit;
    XLabel22: TXLabel;
    EditDateActualON: TXEDBDateEdit;
    XLabel23: TXLabel;
    EditDateActualOFF: TXEDBDateEdit;
    EtvTabSheet1: TEtvTabSheet;
    XEDbGrid2: TXEDbGrid;
    EditFuelKod: TXEDBLookupCombo;
    EditWorkMode: TXEDBLookupCombo;
    EditFuelSource: TXEDBLookupCombo;
    EditDriverName: TXEDBLookupCombo;
    EditDriver2Name: TXEDBLookupCombo;
    EditTruckName: TXEDBLookupCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAuto: TFormAuto;

implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormAuto', TFormAuto);
//  IsPrintOn:=false;
Finalization
  UnRegisterXForm(TFormAuto);

end.
