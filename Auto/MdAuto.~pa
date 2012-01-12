unit MdAuto;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, XMisc, XTFC, XDBTFC, Db, LnkSet, DBTables, EtvTable,
  LnTables, BBEForms, EtvLook, XEFields, Menus, mdBase;

type
  TModuleAuto = class(TDataModule)
    TruckWayBill: TLinkSource;
    TruckWayBillDeclar: TLinkTable;
    TruckWayBillDeclarBillnum: TFloatField;
    TruckWayBillDeclarsDate: TDateField;
    TruckWayBillDeclarWorkMode: TSmallintField;
    TruckWayBillDeclarKod: TFloatField;
    TruckWayBillDeclarDriver: TIntegerField;
    TruckWayBillDeclarDriver2: TIntegerField;
    TruckWayBillDeclarAccompany: TStringField;
    TruckWayBillDeclarTruck: TIntegerField;
    TruckWayBillDeclarTrailer1: TSmallintField;
    TruckWayBillDeclarTrailer2: TSmallintField;
    TruckWayBillDeclarTimeScheduleON: TStringField;
    TruckWayBillDeclarTimeScheduleOFF: TStringField;
    TruckWayBillDeclarZeroRunON: TIntegerField;
    TruckWayBillDeclarZeroRunOFF: TIntegerField;
    TruckWayBillDeclarSpeedometerON: TIntegerField;
    TruckWayBillDeclarSpeedometerOFF: TIntegerField;
    TruckWayBillDeclarDateActualON: TDateField;
    TruckWayBillDeclarDateActualOFF: TDateField;
    TruckWayBillDeclarTimeActualON: TStringField;
    TruckWayBillDeclarTimeActualOFF: TStringField;
    TruckWayBillDeclarFuelKod: TSmallintField;
    TruckWayBillDeclarFuelIssue: TFloatField;
    TruckWayBillDeclarFuelRestOUT: TFloatField;
    TruckWayBillDeclarFuelRestIN: TFloatField;
    TruckWayBillDeclarFuelReturn: TFloatField;
    AutoC: TDBFormControl;
    AUFuel: TLinkSource;
    AUFuelDeclar: TLinkTable;
    AUFuelDeclarKod: TSmallintField;
    AUFuelDeclarName: TStringField;
    AUFuelDeclarUnitM: TSmallintField;
    AUFuelDeclarP: TSmallintField;
    AUFuelDeclarShortName: TStringField;
    AUFuelDeclarCoeff: TFloatField;
    AUGoods: TLinkSource;
    AUGoodsDeclar: TLinkTable;
    AUGoodsDeclarKod: TSmallintField;
    AUGoodsDeclarName: TStringField;
    AURoutes: TLinkSource;
    AURoutesDeclar: TLinkTable;
    AURoutesDeclarKod: TSmallintField;
    AURouteTemplates: TLinkSource;
    AURouteTemplatesDeclar: TLinkTable;
    AURouteTemplatesDeclarID: TIntegerField;
    AURouteTemplatesDeclarKod: TSmallintField;
    AURouteTemplatesDeclarAdds: TSmallintField;
    AURouteTemplatesDeclarLength: TFloatField;
    AURouteTemplatesDeclarRun: TFloatField;
    AURouteTemplatesDeclarName: TStringField;
    AUTemperature: TLinkSource;
    AUTemperatureDeclar: TLinkTable;
    AUTemperatureDeclarID: TIntegerField;
    AUTemperatureDeclarsDate: TDateField;
    AUTemperatureDeclarsTime: TTimeField;
    AUTemperatureDeclarsTemp: TSmallintField;
    AUTemperatureC: TDBFormControl;
    AURouteTemplatesC: TDBFormControl;
    AURoutesC: TDBFormControl;
    AUGoodsC: TDBFormControl;
    AUFuelC: TDBFormControl;
    TruckWayBillDeclarFuelSource: TSmallintField;
    TruckWayBillDeclarFuelKodName: TXELookField;
    AUWorkModes: TLinkSource;
    AUWorkModesDeclar: TLinkTable;
    AUWorkModesDeclarKod: TSmallintField;
    AUWorkModesDeclarName: TStringField;
    AUFuelFillTypes: TLinkSource;
    AUFuelFillTypesDeclar: TLinkTable;
    AUFuelFillTypesDeclarKod: TSmallintField;
    AUFuelFillTypesDeclarName: TStringField;
    TruckWayBillDeclarFuelSourceName: TEtvLookField;
    AUTransportModels: TLinkSource;
    AUTransportModelsDeclar: TLinkTable;
    AUTransportModelsDeclarGosNo: TStringField;
    AUTransportModelsDeclarInvNo: TIntegerField;
    AUTransportModelsDeclarName: TStringField;
    AUTransportModelsDeclarShop: TSmallintField;
    AUTransportModelsDeclarWay: TSmallintField;
    AUTransportModelsDeclarWeight: TFloatField;
    AUTransportModelsDeclarPower: TFloatField;
    AUTransportModelsDeclarVIN: TStringField;
    AUTransportModelsDeclarDateMade: TDateField;
    AUTransportModelsDeclarDateOn: TDateField;
    AUTransportModelsDeclarDateOff: TDateField;
    AUTransportModelsC: TDBFormControl;
    AULinNormAdd: TLinkSource;
    AULinNormAddC: TDBFormControl;
    AULinNormAddDeclar: TLinkTable;
    AULinNormAddDeclarKod: TSmallintField;
    AULinNormAddDeclarName: TStringField;
    AULinNormAddDeclarExtraMain: TFloatField;
    AULinNormAddDeclarExtraAdd: TFloatField;
    AUFuelFillTypesC: TDBFormControl;
    AUWorkModesC: TDBFormControl;
    TruckWayBillDeclarDriverName: TEtvLookField;
    TruckWayBillDeclarDriver2Name: TEtvLookField;
    AURoutesDeclarName: TStringField;
    AURoutesDeclarDiffNRG: TFloatField;
    AURoutesDeclarCat: TSmallintField;
    AURoutesDeclarAddPr: TSmallintField;
    AURoutesDeclarCost: TFloatField;
    AURoutesDeclarNormTKMRejs: TFloatField;
    AUDriverTasks: TLinkSource;
    AUDriverTasksDeclar: TLinkTable;
    AUDriverTasksDeclarID: TIntegerField;
    AUDriverTasksDeclarsDate: TDateField;
    AUDriverTasksDeclarShop: TSmallintField;
    AUDriverTasksDeclarRoute: TSmallintField;
    AUDriverTasksDeclarGood: TSmallintField;
    AUDriverTasksDeclarRunCol: TSmallintField;
    AUDriverTasksDeclarRunLength: TFloatField;
    AUDriverTasksDeclarShipWeight: TFloatField;
    AUDriverTasksDeclarOtherObj: TSmallintField;
    AUDriverTasksDeclarCostRiseCoeff: TFloatField;
    AUDriverTasksDeclarIdling: TFloatField;
    AUDriverTasksDeclarTrailer: TSmallintField;
    AUDriverTasksDeclarFuelCount: TFloatField;
    AUDriverTasksDeclarFuelLitres: TFloatField;
    TruckWayBillDeclarTruckName: TEtvLookField;
    TruckWayBillDeclarID: TIntegerField;
    Popup: TControlMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    AutoC1: TLinkMenuItem;
    TruckWayBillDeclarWorkModeName: TEtvLookField;
    AUTransportModelsDeclarGroupT: TSmallintField;
    AUTransportModelsDeclarID: TIntegerField;
    AUFuelConsumption: TLinkSource;
    AUFuelConsumptionDeclar: TLinkTable;
    AUFuelConsumptionDeclarID: TIntegerField;
    AUFuelConsumptionDeclarWayBill: TIntegerField;
    AUFuelConsumptionDeclarRoute: TSmallintField;
    AUFuelConsumptionDeclarNormAdd: TSmallintField;
    AUFuelConsumptionDeclarLength: TFloatField;
    AUFuelConsumptionDeclarPrPr: TSmallintField;
    AUFuelConsumptionDeclarRouteNo: TSmallintField;
    AUFuelConsumptionDeclarNormAddName: TEtvLookField;
    procedure TruckWayBillDeclarAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleAuto: TModuleAuto;

implementation
  uses Auto, mdWorkers;
{$R *.DFM}

procedure TModuleAuto.TruckWayBillDeclarAfterScroll(DataSet: TDataSet);
begin
  AUDriverTasksDeclar.Filtered:=False;
  if TruckWayBillDeclar.RecordCount>0 then
    AUDriverTasksDeclar.Filter:='ID='+TruckWayBillDeclarID.AsString
  else
    AUDriverTasksDeclar.Filter:='ID=-1';
  AUDriverTasksDeclar.Filtered:=True;
end;

end.
