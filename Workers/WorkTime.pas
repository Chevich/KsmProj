unit WorkTime;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, EtvLook, ToolEdit,
  RXDBCtrl, EtvRXCtl, Mask, EtvContr, RXCtrls, XCtrls;

type
  TFormWorkTime = class(TABEForm)
    XLabel1: TXLabel;
    EditID: TXEDBEdit;
    XLabel2: TXLabel;
    EditPeriod: TXEDBDateEdit;
    XLabel3: TXLabel;
    EditShopName: TXEDBLookupCombo;
    XLabel4: TXLabel;
    EditSectionName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    EditCategoryName: TXEDBLookupCombo;
    EditWorkFact: TXEDBEdit;
    EditEducationalHoliday: TXEDBEdit;
    XLabel8: TXLabel;
    EditHoliday: TXEDBEdit;
    EditImproveProf: TXEDBEdit;
    EditDisablement: TXEDBEdit;
    EditMissions: TXEDBEdit;
    XLabel12: TXLabel;
    XLabel13: TXLabel;
    XLabel15: TXLabel;
    XLabel16: TXLabel;
    XLabel17: TXLabel;
    EditStateDuty: TXEDBEdit;
    EditMotherDay: TXEDBEdit;
    EditDaysUpToCourt: TXEDBEdit;
    EditHolidayInitWorker: TXEDBEdit;
    EditHolidayInitAdmin: TXEDBEdit;
    EditAbsence: TXEDBEdit;
    EditFreeDays: TXEDBEdit;
    EditWorkHours: TXEDBEdit;
    EditOverTime: TXEDBEdit;
    EditNightTime: TXEDBEdit;
    EditEveningTime: TXEDBEdit;
    EditStandIdle: TXEDBEdit;
    EditDelay: TXEDBEdit;
    XLabel18: TXLabel;
    XLabel19: TXLabel;
    XLabel20: TXLabel;
    XLabel21: TXLabel;
    XLabel22: TXLabel;
    XLabel23: TXLabel;
    XLabel24: TXLabel;
    XLabel25: TXLabel;
    XLabel26: TXLabel;
    XLabel27: TXLabel;
    XLabel28: TXLabel;
    XLabel29: TXLabel;
    XLabel30: TXLabel;
    LabelCheck: TXDBLabel;
    XLabel6: TXLabel;
    LabelManDayTotal: TXDBLabel;
    XLabel7: TXLabel;
    XLabel9: TXLabel;
    LabelNumberOnAverage: TXDBLabel;
    XLabel10: TXLabel;
    LabelDaysInPeriod: TXDBLabel;
    XLabel11: TXLabel;
    EditAbsenceDebatable: TXEDBEdit;
    XLabel14: TXLabel;
    EditCheckUp: TXEDBEdit;
    XLabel31: TXLabel;
    LabelAverageNumber: TXDBLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormWorkTime: TFormWorkTime;

implementation
uses XMisc;

{$R *.DFM}
Initialization
  RegisterAliasXForm('FormWorkTime', TFormWorkTime);
Finalization
  UnRegisterXForm(TFormWorkTime);
end.
