Unit MdProd;

Interface

Uses
  Forms, Db, XTFC, EtvDB, DBTables, LnTables, DiDate,
  Menus, Classes, Graphics, Controls, XMisc, EtvTable, XEFields, XDBTFC,
  LnkSet, EtvLook, EtvList;

type
  TModuleProd = class(TDataModule)
    TProd: TLinkSource;
    PopUp: TControlMenu;
    TProdDeclar: TLinkTable;
    TProdLookup: TLinkQuery;
    TProdLookupName: TStringField;
    TProdDeclarName: TStringField;
    GrProd: TLinkSource;
    GrProdDeclar: TLinkTable;
    SmallintField1: TSmallintField;
    GrProdLookup: TLinkQuery;
    SmallintField2: TSmallintField;
    GrProdDeclarKodTProd: TSmallintField;
    GrProdDeclarName: TStringField;
    GrProdDeclarTProdName: TXELookField;
    GrProdLookupName: TStringField;
    TProdC: TDBFormControl;
    GrProdC: TDBFormControl;
    FormPriceC: TDBFormControl;
    FormPrice: TLinkSource;
    FormPriceDeclar: TLinkTable;
    FormPriceDeclarKod: TSmallintField;
    FormPriceDeclarName: TStringField;
    FormPriceLookup: TLinkQuery;
    FormPriceLookupKod: TSmallintField;
    FormPriceLookupName: TStringField;
    TPriceC: TDBFormControl;
    TPrice: TLinkSource;
    TPriceDeclar: TLinkTable;
    TPriceDeclarKod: TSmallintField;
    TPriceDeclarName: TStringField;
    TPriceLookup: TLinkQuery;
    TPriceLookupKod: TSmallintField;
    TPriceLookupName: TStringField;
    IncPriceC: TDBFormControl;
    IncPrice: TLinkSource;
    IncPriceDeclar: TLinkTable;
    IncPriceLookup: TLinkQuery;
    IncPriceDeclarKod: TSmallintField;
    IncPriceDeclarName: TStringField;
    IncPriceLookupKod: TSmallintField;
    IncPriceLookupName: TStringField;
    ProdC: TDBFormControl;
    Prod: TLinkSource;
    ProdDeclar: TLinkTable;
    ProdLookup: TLinkTable;
    ProdDeclarWidth: TFloatField;
    ProdDeclarKod: TIntegerField;
    ProdDeclarName: TStringField;
    ProdDeclarUnitM: TSmallintField;
    ProdDeclarMassa: TFloatField;
    ProdDeclarSLength: TFloatField;
    ProdDeclarShop: TSmallintField;
    ProdDeclarUnitMName: TXELookField;
    ProdDeclarShopName: TXELookField;
    ProdPrice: TLinkSource;
    ProdPriceDeclar: TLinkTable;
    ProdPriceDeclarPrice: TFloatField;
    ProdPriceDeclarProd: TIntegerField;
    ProdPriceDeclarTare: TSmallintField;
    ProdPriceDeclarTPrice: TSmallintField;
    ProdPriceDeclarSDate: TDateField;
    ProdLookupKod: TIntegerField;
    ProdLookupName: TStringField;
    ProdPriceDeclarTareName: TXELookField;
    ProdPriceDeclarTPriceName: TXELookField;
    ProdPriceD: TLinkSource;
    ProdPriceDDeclar: TLinkTable;
    ProdPriceDProd: TIntegerField;
    ProdPriceDTare: TSmallintField;
    ProdPriceDTareName: TXELookField;
    ProdPriceDTPrice: TSmallintField;
    ProdPriceDTPriceName: TXELookField;
    ProdPriceDSDate: TDateField;
    ProdPriceDPrice: TFloatField;
    ProdPriceDeclarProdName: TXELookField;
    WorksC: TDBFormControl;
    Works: TLinkSource;
    WorksDeclar: TLinkTable;
    WorksLookupName: TStringField;
    Works1: TLinkMenuItem;
    WorksDeclarProd: TIntegerField;
    WorksDeclarProdName: TXELookField;
    ProdPlanC: TDBFormControl;
    ProdPlan: TLinkSource;
    ProdPlanDeclar: TLinkTable;
    ProdPlanDeclarProd: TIntegerField;
    ProdPlanDeclarDateP: TDateField;
    ProdPlanDeclarShop: TSmallintField;
    ProdPlanDeclarProdName: TXELookField;
    ProdPlanDeclarShopName: TXELookField;
    ProdIncPrice: TLinkSource;
    ProdIncPriceDeclar: TLinkTable;
    ProdIncPriceDeclarProd: TIntegerField;
    ProdIncPriceDeclarTare: TSmallintField;
    ProdIncPriceDeclarTPrice: TSmallintField;
    ProdIncPriceDeclarIncPrice: TSmallintField;
    ProdIncPriceDeclarPrice: TFloatField;
    ProdIncPriceDeclarProdName: TXELookField;
    ProdIncPriceDeclarTareName: TXELookField;
    ProdIncPriceDeclarTPriceName: TXELookField;
    ProdIncPriceDeclarIncPriceName: TXELookField;
    ProdIncPriceC: TDBFormControl;
    ProdDeclarHeight: TSmallintField;
    ProdDeclarVolume: TFloatField;
    ProdLookupUnitM: TSmallintField;
    ProdLookupMassa: TFloatField;
    TProdDeclarFullName: TStringField;
    GrProdDeclarStandard: TStringField;
    GrProdDeclarFullName: TStringField;
    ProdDeclarKodUp: TIntegerField;
    ProdDeclarFullName: TStringField;
    ProdDeclarStandard: TStringField;
    ProdDeclarKodUpName: TXELookField;
    ProdDeclarAmountDown: TIntegerField;
    ProdLookupKodUp: TIntegerField;
    ProdProcess: TLinkTable;
    ProdProcessKod: TIntegerField;
    ProdProcessName: TStringField;
    ProdProcessKodUp: TIntegerField;
    ProdTree: TLinkSource;
    ProdTreeDeclar: TLinkTable;
    ProdTreeKodUp: TIntegerField;
    ProdTreeKodDown: TIntegerField;
    ProdDeclarConversion: TFloatField;
    ProdPriceOnDate: TLinkQuery;
    ProdPriceOnDateThisPrice: TFloatField;
    ProdPlanD: TLinkSource;
    ProdPlanDeclarD: TLinkTable;
    ProdPlanDeclarDProd: TIntegerField;
    ProdPlanDeclarDDateP: TDateField;
    ProdPlanDeclarDShop: TSmallintField;
    ProdPlanDeclarDShopName: TXELookField;
    ProdDeclarSquare: TFloatField;
    ProdLookupAmountDown: TIntegerField;
    ProdPriceDBid: TFloatField;
    ProdPriceDeclarBid: TFloatField;
    ProdPriceOnDateThisBid: TFloatField;
    ProdDeclarDescription: TMemoField;
    TPriceDeclarCurrency: TSmallintField;
    TPriceDeclarCurrencyName: TXELookField;
    TPriceLookupCurrency: TSmallintField;
    ProdPriceProcess: TLinkQuery;
    ProdPriceProcessSDate: TDateField;
    ProdPriceProcessPrice: TFloatField;
    ProdPriceProcessProd: TIntegerField;
    ProdPriceProcessTare: TSmallintField;
    ProdPriceProcessTPrice: TSmallintField;
    TPriceLookupCurrencyName: TXELookField;
    ProdTareD: TLinkSource;
    ProdTareDeclar: TLinkTable;
    ProdTareDeclarProd: TIntegerField;
    ProdTareDeclarTare: TSmallintField;
    ProdTareDeclarTareName: TXELookField;
    ProdTareDLookup: TLinkQuery;
    ProdTareDLookupTare: TSmallintField;
    ProdTareDLookupTareName: TXELookField;
    ProdTareDProcess: TLinkQuery;
    ProdTareDProcessMainUp: TIntegerField;
    ProdTareDLookupProd: TIntegerField;
    ProdTareDLookupWeight: TFloatField;
    TPriceProcess: TLinkQuery;
    TPriceProcessKod: TSmallintField;
    TPriceProcessName: TStringField;
    TPriceProcessCurrency: TSmallintField;
    TPriceProcessCurrencyName: TStringField;
    TPriceProcessNameDop: TStringField;
    TPriceProcessGenitive: TStringField;
    TPriceProcessNominative: TStringField;
    ProdDeclarOldKod: TIntegerField;
    ProdPriceV1: TLinkSource;
    ProdPriceV1Declar: TLinkTable;
    ProdPriceV1DeclarProd: TIntegerField;
    ProdPriceV1DeclarProdName: TStringField;
    ProdPriceV1DeclarUnitM: TStringField;
    ProdPriceV1DeclarTare: TSmallintField;
    ProdPriceV1DeclarTareName: TStringField;
    ProdPriceV1DeclarSDate: TDateField;
    ProdPriceV1DeclarPrice: TFloatField;
    ProdPriceV1DeclarCourseUSD: TFloatField;
    ProdPriceV1DeclarPriceUSD: TFloatField;
    ProdPriceV1DeclarCourseRUS: TFloatField;
    ProdPriceV1DeclarPriceRUS: TFloatField;
    ProdPriceV1C: TDBFormControl;
    ProdOper: TLinkSource;
    ProdOperDeclar: TLinkTable;
    ProdOperDeclarKod: TSmallintField;
    ProdOperDeclarName: TStringField;
    ProdOperC: TDBFormControl;
    ProdOperLookup: TLinkQuery;
    ProdOperLookupKod: TSmallintField;
    ProdOperLookupName: TStringField;
    ProdMovement: TLinkSource;
    ProdMovementDeclar: TLinkTable;
    ProdMovementDeclarProd: TIntegerField;
    ProdMovementDeclarDate: TDateField;
    ProdMovementDeclarOper: TSmallintField;
    ProdMovementC: TDBFormControl;
    ProdMovementDeclarProdName: TXELookField;
    ProdMovementDeclarOperName: TXELookField;
    TurnOverProd: TLinkSource;
    TurnOverProdDeclar:TLinkTable;
    TurnOverProdDeclarProd: TIntegerField;
    TurnOverProdDeclarProdName: TXELookField;
    TurnOverProdC: TDBFormControl;
    TurnOverProdDeclarAmountBe: TFloatField;
    TurnOverProdDeclarAmountMake: TFloatField;
    TurnOverProdDeclarAmountReal: TFloatField;
    TurnOverProdDeclarAmountEn: TFloatField;
    TurnOverProdDeclarm3Be: TFloatField;
    TurnOverProdDeclarm3Make: TFloatField;
    TurnOverProdDeclarm3Real: TFloatField;
    TurnOverProdDeclarm3En: TFloatField;
    TurnOverProdDeclarm2Be: TFloatField;
    TurnOverProdDeclarm2Make: TFloatField;
    TurnOverProdDeclarm2Real: TFloatField;
    TurnOverProdDeclarm2En: TFloatField;
    TurnOverProdDeclarSumBe: TFloatField;
    TurnOverProdDeclarSumMake: TFloatField;
    TurnOverProdDeclarSumReal: TFloatField;
    TurnOverProdDeclarSumEn: TFloatField;
    ProdMovementDeclarDatePrice: TDateField;
    ProdMovementDeclarAmount: TFloatField;
    ProdMovementDeclarAutoInc: TAutoIncField;
    ProdMovementDeclarDateName: TXELookField;
    ProdMovementDeclarPrice: TFloatField;
    TurnOverProdDeclarAutoInc: TIntegerField;
    ProdPlanDeclarSPlan: TFloatField;
    ProdPlanDeclarDSPlan: TFloatField;
    WorksDeclarKodUp: TIntegerField;
    WorksDeclarShop: TIntegerField;
    WorksDeclarSetOfMasters: TSmallintField;
    WorksDeclarKodUpName: TXELookField;
    WorksDeclarKod: TIntegerField;
    WorksLookupKod: TIntegerField;
    WorksDeclarAmountDown: TIntegerField;
    WorkDay: TLinkSource;
    WorkDayDeclar: TLinkTable;
    ProdPriceDPriceBid: TFloatField;
    ProdReport_1: TLinkSource;
    ProdReport_1Declar: TLinkTable;
    ProdReport_1DeclarKod: TIntegerField;
    ProdReport_1C: TDBFormControl;
    ProdReport_11: TLinkMenuItem;
    ReportPanel: TLinkSource;
    ReportPanelDeclar: TLinkQuery;
    ReportPanelC: TDBFormControl;
    N6: TMenuItem;
    ReportPanel1: TLinkMenuItem;
    ProdReport_1DeclarIsPrint: TXEListField;
    ProdReport_1DeclarProd: TIntegerField;
    Equipment: TLinkSource;
    EquipmentDeclar: TLinkTable;
    EquipmentC: TDBFormControl;
    EquipmentDeclarKod: TIntegerField;
    EquipmentDeclarName: TStringField;
    EquipmentLookup: TLinkQuery;
    EquipmentLookupKod: TIntegerField;
    EquipmentLookupName: TStringField;
    EquipmentOp: TLinkSource;
    EquipmentOpDeclar: TLinkTable;
    EquipmentOpDeclarSDate: TDateField;
    EquipmentOpDeclarEquip: TIntegerField;
    EquipmentOpDeclarOper: TSmallintField;
    EquipmentOpDeclarAmount: TFloatField;
    EquipmentOpC: TDBFormControl;
    EquipmentOpDeclarEquipmentName: TXELookField;
    EquipmentOpDeclarOperName: TXELookField;
    EquipmentOpDeclarAutoInc: TAutoIncField;
    N7: TMenuItem;
    Equipment1: TLinkMenuItem;
    EquipmentOp1: TLinkMenuItem;
    EquipmentDeclarPrice: TFloatField;
    EquipmentV: TLinkSource;
    EquipmentVDeclar: TLinkTable;
    EquipmentVDeclarEquip: TIntegerField;
    EquipmentVDeclarAmountBeg: TFloatField;
    EquipmentVDeclarAmountIn: TFloatField;
    EquipmentVDeclarAmountOut: TFloatField;
    EquipmentVDeclarAmountEnd: TFloatField;
    EquipmentVDeclarSummaBeg: TFloatField;
    EquipmentVDeclarSummaIn: TFloatField;
    EquipmentVDeclarSummaOut: TFloatField;
    EquipmentVDeclarSummaEnd: TFloatField;
    EquipmentVDeclarEquipName: TStringField;
    EquipmentVDeclarPrice: TFloatField;
    EquipmentVC: TDBFormControl;
    EquipmentV1: TLinkMenuItem;
    FormingTotal1: TMenuItem;
    ProdTotalStoreV: TLinkSource;
    ProdTotalStoreC: TDBFormControl;
    ProdTotalStoreVDeclar: TLinkTable;
    ProdTotalStoreVDeclarProd: TIntegerField;
    ProdTotalStoreVDeclarsDate: TDateField;
    ProdTotalStoreVDeclarAmount: TFloatField;
    ProdTotalStoreVDeclarID: TAutoIncField;
    ProdTotalStoreVDeclarProdName: TXELookField;
    ProdTotalStore1: TLinkMenuItem;
    ProdPriceOnDateThisDate: TDateField;
    ProdLookupVolume: TFloatField;
    ProdTotalStoreVDeclarVolume: TFloatField;
    N9: TMenuItem;
    ProdTotalCompareStore: TLinkSource;
    ProdTotalCompareStoreDeclar : TLinkQuery;
    ProdTotalCompareStoreDeclarsDate: TDateField;
    ProdTotalCompareStoreDeclarProd: TIntegerField;
    ProdTotalCompareStoreDeclarProdName: TStringField;
    ProdTotalCompareStoreDeclarAmountTotal: TFloatField;
    ProdTotalCompareStoreDeclarAmountStore: TFloatField;
    ProdTotalCompareStoreDeclarDifference: TFloatField;
    ProdTotalCompareStoreC: TDBFormControl;
    ProdTotalCompareStore1: TLinkMenuItem;
    ProdTotalStore: TLinkSource;
    ProdTotalStoreDeclar: TLinkTable;
    ProdTotalStoreDeclarProd: TIntegerField;
    ProdTotalStoreDeclarsDate: TDateField;
    ProdTotalStoreDeclarAmount: TFloatField;
    ProdTotalStoreDeclarProdName: TXELookField;
    ProdTotalStoreVC: TDBFormControl;
    ProdTotalStoreV1: TLinkMenuItem;
    N8: TMenuItem;
    ProdReport_1DeclarProdName: TXELookField;
    ProdTotalStoreDeclarID: TAutoIncField;
    ProdPriceOnDateThisRateVAT: TFloatField;
    ProdPriceDRateVAT: TFloatField;
    ProdPriceDeclarRateVAT: TFloatField;
    ProdPriceProcessRateVAT: TFloatField;
    TPriceLookupIncTransport: TSmallintField;
    TProdDeclarKod: TSmallintField;
    TProdLookupKod: TSmallintField;
    ProdDeclarTProd: TSmallintField;
    ProdDeclarTProdName: TXELookField;
    ProdReport_2: TLinkSource;
    ProdReport_2Declar: TLinkTable;
    ProdReport_2Prod: TIntegerField;
    ProdReport_2Tare: TSmallintField;
    ProdReport_2ProdName: TXELookField;
    ProdReport_2C: TDBFormControl;
    ProdReport_2TareName: TXELookField;
    TPriceDeclarIncTransport: TXEListField;
    TPriceDeclarOverSea: TXEListField;
    ProdDeclarAccount: TStringField;
    ProdReport_21: TLinkMenuItem;
    ProdPriceProcessPriceRateVAT: TFloatField;
    ProdPriceDDeclarPriceGross: TFloatField;
    ProdPriceDeclarPriceGross: TFloatField;
    ProdReport_2DeclarIsPrint_1: TXEListField;
    ProdReport_2DeclarIsPrint_2: TXEListField;
    ProdPriceOnDateThisPriceGross: TFloatField;
    PriceDate: TLinkSource;
    PriceDateDeclar: TLinkTable;
    PriceDateLookup: TLinkQuery;
    PriceDateC: TDBFormControl;
    PriceDateDeclarDatePrice: TDateField;
    PriceDateDeclarNumPrice: TStringField;
    PriceDateLookupDatePrice: TDateField;
    PriceDateLookupNumPrice: TStringField;
    PriceDate1: TLinkMenuItem;
    ProdPriceDExtra: TFloatField;
    ProdPriceOnDateThisExtra: TFloatField;
    ReportPanelDeclarsDate: TDateField;
    ReportPanelDeclarKod: TIntegerField;
    ReportPanelDeclarOldKod: TIntegerField;
    ReportPanelDeclarName: TStringField;
    ReportPanelDeclarVolume: TFloatField;
    ReportPanelDeclarMassa: TFloatField;
    ReportPanelDeclarPriceFCAA: TFloatField;
    ReportPanelDeclarPriceFCAAVAT: TFloatField;
    ReportPanelDeclarPriceFCAAP: TFloatField;
    ReportPanelDeclarPriceFCAR: TFloatField;
    ReportPanelDeclarPriceFCARP: TFloatField;
    ReportPanelDeclarNum: TIntegerField;
    N2: TMenuItem;
    ProdProcessUnitM: TSmallintField;
    ProdProcessUnitMName: TXELookField;
    ProdProcessMassa: TFloatField;
    ProdProcessVolume: TFloatField;
    ProdProcessAmountDown: TIntegerField;
    ProdProcessFullName: TStringField;
    ProdLookupFullName: TStringField;
    WorkDayDeclarShift1: TFloatField;
    WorkDayDeclarShift2: TFloatField;
    WorkDayDeclarShift3: TFloatField;
    WorkDayDeclarShift4: TFloatField;
    WorkDayDeclarAmountDay: TFloatField;
    WorkDayDeclarsWork: TIntegerField;
    WorkDayDeclarsDate: TDateField;
    WorksLookupKodUp: TIntegerField;
    WorkDayDeclarKodUp: TIntegerField;
    WorkDayDeclarWorkName: TXELookField;
    ProdDeclarPhoto: TBlobField;
    WorkFact: TLinkSource;
    WorkFactDeclar: TLinkTable;
    WorkFactDeclarSWork: TIntegerField;
    WorkFactDeclarSDate: TDateField;
    WorkFactDeclarShift: TSmallintField;
    WorkFactDeclarAmount: TFloatField;
    WorkFactDeclarWorkName: TXELookField;
    WorksDeclarUnitM: TSmallintField;
    WorksDeclarName: TStringField;
    WorksDeclarUnitMName: TXELookField;
    ProdReport_2DeclarID: TIntegerField;
    CommodityRelease: TLinkSource;
    CommodityReleaseC: TDBFormControl;
    CommodityReleaseDeclar: TLinkTable;
    CommodityReleaseDeclarID: TAutoIncField;
    ProdReport_2Lookup: TLinkQuery;
    ProdReport_2LookupProd: TIntegerField;
    ProdReport_2LookupName: TStringField;
    CommodityReleaseDeclarProdName: TXELookField;
    CommodityReleaseDeclarsDate: TDateField;
    CommodityReleaseDeclarAmountOut: TFloatField;
    CommodityReleaseDeclarAmountReal: TFloatField;
    CommodityReleaseDeclarAmountCorr: TFloatField;
    CommodityReleaseDeclarPriceCorr: TFloatField;
    CommodityReleaseDeclarSumCorr: TFloatField;
    CommodityReleaseDeclarProdStandard: TIntegerField;
    CommodityReleaseDeclarProdStandardName: TXELookField;
    CommodityReleaseDeclarProdOut: TIntegerField;
    CommodityReleaseDeclarProdReal: TIntegerField;
    CommodityReleaseDeclarProdRealName: TXELookField;
    CommodityReleaseDeclarPriceCPCorr: TFloatField;
    CommodityReleaseDeclarSumCPCorr: TFloatField;
    ProdPriceDDeclarFlagCP: TXEListField;
    ProdLookupUnitMName: TStringField;
    CommodityRelease1: TLinkMenuItem;
    BaseTPrice: TLinkSource;
    BaseTPriceDeclar: TLinkTable;
    BaseTPriceDeclarKod: TSmallintField;
    BaseTPriceDeclarName: TStringField;
    BaseTPriceC: TDBFormControl;
    BaseTPrice1: TLinkMenuItem;
    BaseTPriceLookup: TLinkQuery;
    BaseTPriceLookupKod: TSmallintField;
    BaseTPriceLookupName: TStringField;
    ProdPriceDDeclarBaseTPrice: TSmallintField;
    ProdPriceDDeclarBaseTPriceName: TXELookField;
    ProdPriceProcessBaseTPrice: TSmallintField;
    ProdPriceDeclarBaseTPrice: TSmallintField;
    ProdPriceDeclarBaseTPriceName: TXELookField;
    ProdPriceCP: TLinkSource;
    ProdPriceCPDeclar: TLinkTable;
    ProdPriceCPDeclarProd: TIntegerField;
    ProdPriceCPDeclarSDate: TDateField;
    ProdPriceCPDeclarPrice: TFloatField;
    ProdPriceCPDeclarPriceGross: TFloatField;
    ProdPriceCPDeclarTPrice: TSmallintField;
    ProdPriceCPDeclarTPriceName: TXELookField;
    ProdPriceCPDeclarBaseTPrice: TSmallintField;
    ProdPriceCPDeclarBaseTPriceName: TXELookField;
    ProdPriceCPDeclarTare: TSmallintField;
    ProdPriceCPDeclarTareName: TXELookField;
    ProdPriceCPDeclarExtra: TFloatField;
    ProdPriceCPDeclarBid: TFloatField;
    ProdPriceCPDeclarRateVAT: TFloatField;
    ProdPriceCPDeclarPriceBid: TFloatField;
    ProdPriceCPDeclarFlagCP: TXEListField;
    ProdPriceCPDeclarProdName: TXELookField;
    WorkFactDeclarFlag: TSmallintField;
    WorkDayDeclarFlag: TSmallintField;
    WSetsOfMasters: TLinkSource;
    WSetsOfMastersDeclar: TLinkTable;
    WSetsOfMastersDeclarKod: TSmallintField;
    WSetsOfMastersDeclarTabNum1: TIntegerField;
    WSetsOfMastersDeclarTabNum2: TIntegerField;
    WSetsOfMastersDeclarTabNum3: TIntegerField;
    WSetsOfMastersDeclarTabNum4: TIntegerField;
    WSetsOfMastersDeclarWorkerName1: TXELookField;
    WSetsOfMastersDeclarWorkerName2: TXELookField;
    WSetsOfMastersDeclarWorkerName3: TXELookField;
    WSetsOfMastersDeclarWorkerName4: TXELookField;
    WsetsOfMastersC: TDBFormControl;
    WSetsOfMasters1: TLinkMenuItem;
    WSetsOfMastersDeclarWork: TIntegerField;
    WSetsOfMastersDeclarWorkName: TXELookField;
    WorksLookupAmountDown: TIntegerField;
    WorkReport: TLinkSource;
    WorkReportDeclar: TLinkTable;
    WorkReportDeclarID: TIntegerField;
    WorkReportDeclarKod: TIntegerField;
    WorkReportDeclarName: TStringField;
    WorkReportDeclarShift1: TFloatField;
    WorkReportDeclarShift1Period: TFloatField;
    WorkReportDeclarShift2: TFloatField;
    WorkReportDeclarShift2Period: TFloatField;
    WorkReportDeclarShift3: TFloatField;
    WorkReportDeclarShift3Period: TFloatField;
    WorkReportDeclarShift4: TFloatField;
    WorkReportDeclarShift4Period: TFloatField;
    WorkReportDeclarTotal: TFloatField;
    WorkReportDeclarTotalPeriod: TFloatField;
    WorkReportC: TDBFormControl;
    WorkReport1: TLinkMenuItem;
    ProdLookupUnitMNameFull: TStringField;
    WorksDeclarTare: TSmallintField;
    WorksDeclarTareName: TXELookField;
    WorkFactDeclarID: TAutoIncField;
    WorksDeclarProd2: TIntegerField;
    WorksDeclarProd2Name: TXELookField;
    WorkProd: TLinkSource;
    WorkProdDeclar: TLinkTable;
    WorkProdDeclarID: TAutoIncField;
    WorkProdDeclarsWork: TIntegerField;
    WorkProdDeclarsDate: TDateField;
    WorkProdDeclarShift: TSmallintField;
    WorkProdDeclarRemainsBeg: TFloatField;
    WorkProdDeclarProduce: TFloatField;
    WorkProdDeclarRealize: TFloatField;
    WorkProdDeclarRemainsEnd: TFloatField;
    WorkProdDeclarWorkName: TXELookField;
    WorkProdC: TDBFormControl;
    WorkProd1: TLinkMenuItem;
    WorkProdDeclarTransfer: TFloatField;
    Forming2: TLinkSource;
    Forming2Declar: TLinkTable;
    Forming2DeclarsDate: TDateField;
    Forming2DeclarMaker: TIntegerField;
    Forming2DeclarProd: TIntegerField;
    Forming2DeclarNumMassif: TSmallintField;
    Forming2DeclarDensityPrimarySlime: TFloatField;
    Forming2DeclarNumTankPrimarySlime: TSmallintField;
    Forming2DeclarDensityReversalSlime: TFloatField;
    Forming2DeclarNumTankReversalSlime: TSmallintField;
    Forming2DeclarNumTankAlSuspense: TSmallintField;
    Forming2DeclarConcentrationAlSuspense: TFloatField;
    Forming2DeclarAmountCement: TFloatField;
    Forming2DeclarAmountDryPrimarySlime: TFloatField;
    Forming2DeclarAmountDryReversalSlime: TFloatField;
    Forming2DeclarAmountDryAl: TFloatField;
    Forming2DeclarAmountAlSuspense: TFloatField;
    Forming2DeclarAmountH2O: TFloatField;
    Forming2DeclarWaterSolidRatio: TFloatField;
    Forming2DeclarNumForm: TSmallintField;
    Forming2DeclarFlowTest: TFloatField;
    Forming2DeclarTimeGrowth: TSmallintField;
    Forming2DeclarDeviationHeightForm: TFloatField;
    Forming2DeclarTimeMassifRipening: TSmallintField;
    Forming2DeclarNumAutoclaveGrill: TSmallintField;
    Forming2DeclarNote: TStringField;
    Forming2DeclarShiftForeman: TIntegerField;
    Forming2DeclarsUser: TStringField;
    Forming2DeclarsTime: TDateTimeField;
    Forming2DeclarShift: TXEListField;
    Forming2DeclarMakerName: TXELookField;
    Forming2DeclarShiftForemanName: TXELookField;
    Forming2DeclarProdName: TXELookField;
    Forming2DeclarAmountLimeSandBinder: TFloatField;
    Forming2DeclarID: TAutoIncField;
    Forming2C: TDBFormControl;
    Forming21: TLinkMenuItem;
    Forming2P1: TProcSubSource;
    Forming2Process: TLinkTable;
    Forming2ProcessID: TIntegerField;
    Forming2ProcesssDate: TDateField;
    Forming2ProcessMaker: TIntegerField;
    Forming2ProcessProd: TIntegerField;
    Forming2ProcessNumMassif: TSmallintField;
    Forming2ProcessDensityPrimarySlime: TFloatField;
    Forming2ProcessNumTankPrimarySlime: TSmallintField;
    Forming2ProcessDensityReversalSlime: TFloatField;
    Forming2ProcessNumTankReversalSlime: TSmallintField;
    Forming2ProcessNumTankAlSuspense: TSmallintField;
    Forming2ProcessConcentrationAlSuspense: TFloatField;
    Forming2ProcessAmountLimeSandBinder: TFloatField;
    Forming2ProcessAmountCement: TFloatField;
    Forming2ProcessAmountDryPrimarySlime: TFloatField;
    Forming2ProcessAmountDryReversalSlime: TFloatField;
    Forming2ProcessAmountDryAl: TFloatField;
    Forming2ProcessAmountAlSuspense: TFloatField;
    Forming2ProcessAmountH2O: TFloatField;
    Forming2ProcessWaterSolidRatio: TFloatField;
    Forming2ProcessNumForm: TSmallintField;
    Forming2ProcessFlowTest: TFloatField;
    Forming2ProcessTimeGrowth: TSmallintField;
    Forming2ProcessDeviationHeightForm: TFloatField;
    Forming2ProcessTimeMassifRipening: TSmallintField;
    Forming2ProcessNumAutoclaveGrill: TSmallintField;
    Forming2ProcessNote: TStringField;
    Forming2ProcessShiftForeman: TIntegerField;
    Forming2ProcesssUser: TStringField;
    Forming2ProcesssTime: TDateTimeField;
    Forming2ProcessMakerName: TXELookField;
    Forming2ProcessShiftForemanName: TXELookField;
    Forming2ProcessProdName: TXELookField;
    Forming2ProcessShift: TXEListField;
    Forming2DeclarVolume: TFloatField;
    Forming2ProcessVolume: TFloatField;
    Forming2DeclarVolumeEnd: TFloatField;
    Forming2ProcessVolumeEnd: TFloatField;
    Forming2DeclarH2OAlProportion: TFloatField;
    Forming2DeclarTemperatureBegMix: TFloatField;
    Forming2DeclarTemperatureOutgassing: TFloatField;
    Forming2DeclarTemperatureMassifEnd: TFloatField;
    Forming2ProcessH2OAlProportion: TFloatField;
    Forming2ProcessTemperatureBegMix: TFloatField;
    Forming2ProcessTemperatureOutgassing: TFloatField;
    Forming2ProcessTemperatureMassifEnd: TFloatField;
    Forming2DeclarShiftForemanCut: TIntegerField;
    Forming2DeclarShiftCut: TXEListField;
    Forming2DeclarShiftForemanCutName: TXELookField;
    Forming2ProcessShiftCut: TXEListField;
    Forming2ProcessShiftForemanCut: TIntegerField;
    Forming2ProcessShiftForemanCutName: TXELookField;
    Forming2DeclarDateCut: TDateField;
    Forming2ProcessDateCut: TDateField;
    Forming2Report: TLinkSource;
    Forming2ReportDeclar: TLinkTable;
    Forming2ReportDeclarID: TIntegerField;
    Forming2ReportDeclarsDate: TDateField;
    Forming2ReportDeclarShift: TSmallintField;
    Forming2ReportDeclarShiftName: TStringField;
    Forming2ReportDeclarMaker: TIntegerField;
    Forming2ReportDeclarMakerName: TStringField;
    Forming2ReportDeclarShiftForeman: TIntegerField;
    Forming2ReportDeclarShiftForemanName: TStringField;
    Forming2ReportDeclarProd: TIntegerField;
    Forming2ReportDeclarProdName: TStringField;
    Forming2ReportDeclarAmountMassif: TSmallintField;
    Forming2ReportDeclarAmountCement: TFloatField;
    Forming2ReportDeclarCementTotal: TFloatField;
    Forming2ReportDeclarVolumeTotal: TFloatField;
    Forming2ReportDeclarAlTotal: TFloatField;
    Forming2ReportC: TDBFormControl;
    Forming2Report1: TLinkMenuItem;
    N21: TMenuItem;
    Forming1: TLinkSource;
    Forming1Declar: TLinkTable;
    Forming1DeclarsDate: TDateField;
    Forming1DeclarMaker: TIntegerField;
    Forming1DeclarShiftForeman: TIntegerField;
    Forming1DeclarProd: TIntegerField;
    Forming1DeclarNumMassif: TSmallintField;
    Forming1DeclarVolume: TFloatField;
    Forming1DeclarVolumeEnd: TFloatField;
    Forming1DeclarWaterSolidRatio: TFloatField;
    Forming1DeclarDensityPrimarySlime: TFloatField;
    Forming1DeclarAmountLimeSandBinder: TFloatField;
    Forming1DeclarAmountPrimarySlime: TFloatField;
    Forming1DeclarAmountReversalSlime: TFloatField;
    Forming1DeclarAmountH2O: TFloatField;
    Forming1DeclarAmountCement: TFloatField;
    Forming1DeclarAmountAlSuspense: TFloatField;
    Forming1DeclarTimeMixing: TSmallintField;
    Forming1DeclarTemperatureBegMix: TFloatField;
    Forming1DeclarTemperatureOutgassing: TFloatField;
    Forming1DeclarTemperatureMassifEnd: TFloatField;
    Forming1DeclarFlowTest: TFloatField;
    Forming1DeclarNote: TStringField;
    Forming1DeclarsUser: TStringField;
    Forming1DeclarsTime: TDateTimeField;
    Forming1DeclarID: TAutoIncField;
    Forming1DeclarLine: TXEListField;
    Forming1DeclarShift: TXEListField;
    Forming1DeclarMakerName: TXELookField;
    Forming1DeclarShiftForemanName: TXELookField;
    Forming1DeclarProdName: TXELookField;
    Forming1C: TDBFormControl;
    N11: TMenuItem;
    Forming11: TLinkMenuItem;
    Forming1P1: TProcSubSource;
    Forming1Process: TLinkTable;
    Forming1ProcessID: TIntegerField;
    Forming1ProcesssDate: TDateField;
    Forming1ProcessMaker: TIntegerField;
    Forming1ProcessShiftForeman: TIntegerField;
    Forming1ProcessProd: TIntegerField;
    Forming1ProcessNumMassif: TSmallintField;
    Forming1ProcessVolume: TFloatField;
    Forming1ProcessVolumeEnd: TFloatField;
    Forming1ProcessWaterSolidRatio: TFloatField;
    Forming1ProcessDensityPrimarySlime: TFloatField;
    Forming1ProcessAmountLimeSandBinder: TFloatField;
    Forming1ProcessAmountPrimarySlime: TFloatField;
    Forming1ProcessAmountReversalSlime: TFloatField;
    Forming1ProcessAmountH2O: TFloatField;
    Forming1ProcessAmountCement: TFloatField;
    Forming1ProcessAmountAlSuspense: TFloatField;
    Forming1ProcessTimeMixing: TSmallintField;
    Forming1ProcessTemperatureBegMix: TFloatField;
    Forming1ProcessTemperatureOutgassing: TFloatField;
    Forming1ProcessTemperatureMassifEnd: TFloatField;
    Forming1ProcessFlowTest: TFloatField;
    Forming1ProcessNote: TStringField;
    Forming1ProcesssUser: TStringField;
    Forming1ProcesssTime: TDateTimeField;
    Forming1ProcessLine: TXEListField;
    Forming1ProcessShift: TXEListField;
    Forming1ProcessMakerName: TXELookField;
    Forming1ProcessShiftForemanName: TXELookField;
    Forming1ProcessProdName: TXELookField;
    Forming1DeclarNumAutoclaveGrill: TStringField;
    Forming1ProcessNumAutoclaveGrill: TStringField;
    Forming1DeclarConcreteStrength: TFloatField;
    Forming1ProcessConcreteStrength: TFloatField;
    Forming2ReportDeclarLimeSandBinderTotal: TFloatField;
    Forming2ReportDeclarDryPrimarySlimeTotal: TFloatField;
    Forming2ReportDeclarDryReversalSlimeTotal: TFloatField;
    Forming2ReportDeclarAlSuspenseTotal: TFloatField;
    Forming2ReportDeclarH2OTotal: TFloatField;
    Forming2ReportDeclarH2OInAlSuspenseTotal: TFloatField;
    Forming2ReportDeclarH2OTotalAll: TFloatField;
    Forming2ReportDeclarVolumeEndTotal: TFloatField;
    Forming2ReportDeclarRejectTotal: TFloatField;
    Forming1Report: TLinkSource;
    Forming1ReportDeclar: TLinkTable;
    Forming1ReportDeclarID: TIntegerField;
    Forming1ReportDeclarsDate: TDateField;
    Forming1ReportDeclarShift: TSmallintField;
    Forming1ReportDeclarShiftName: TStringField;
    Forming1ReportDeclarMaker: TIntegerField;
    Forming1ReportDeclarMakerName: TStringField;
    Forming1ReportDeclarShiftForeman: TIntegerField;
    Forming1ReportDeclarShiftForemanName: TStringField;
    Forming1ReportDeclarProd: TIntegerField;
    Forming1ReportDeclarProdName: TStringField;
    Forming1ReportDeclarAmountMassif: TSmallintField;
    Forming1ReportDeclarAmountCement: TFloatField;
    Forming1ReportDeclarCementTotal: TFloatField;
    Forming1ReportDeclarVolumeTotal: TFloatField;
    Forming1ReportDeclarVolumeEndTotal: TFloatField;
    Forming1ReportDeclarRejectTotal: TFloatField;
    Forming1ReportDeclarLimeSandBinderTotal: TFloatField;
    Forming1ReportDeclarPrimarySlimeTotal: TFloatField;
    Forming1ReportDeclarReversalSlimeTotal: TFloatField;
    Forming1ReportDeclarAlSuspenseTotal: TFloatField;
    Forming1ReportDeclarH2OTotal: TFloatField;
    Forming1ReportDeclarLine: TXEListField;
    Forming1ReportC: TDBFormControl;
    FormingReport11: TLinkMenuItem;
    StockRest: TLinkSource;
    StockRestDeclar: TLinkTable;
    StockRestDeclarsDate: TDateField;
    StockRestDeclarCement: TFloatField;
    StockRestDeclarID: TAutoIncField;
    StockRestC: TDBFormControl;
    StockRest1: TLinkMenuItem;
    Forming1DeclarAmountBlocks: TSmallintField;
    Forming1DeclarAmountRejectBlocks: TSmallintField;
    Forming1ProcessAmountBlocks: TSmallintField;
    Forming1ProcessAmountRejectBlocks: TSmallintField;
    ProdLookupWidth: TFloatField;
    ProdLookupsLength: TFloatField;
    ProdLookupHeight: TSmallintField;
    CementMoveReport: TLinkSource;
    CementMoveReportDeclar: TLinkTable;
    CementMoveReportDeclarID: TIntegerField;
    CementMoveReportDeclarsDate: TDateField;
    CementMoveReportDeclarRestBegin: TFloatField;
    CementMoveReportDeclarComingIn: TFloatField;
    CementMoveReportDeclarLine1: TFloatField;
    CementMoveReportDeclarLine2: TFloatField;
    CementMoveReportDeclarLine4: TFloatField;
    CementMoveReportDeclarTotalCeh1: TFloatField;
    CementMoveReportDeclarCeh2: TFloatField;
    CementMoveReportDeclarTotalCementForForming: TFloatField;
    CementMoveReportDeclarRestCalc: TFloatField;
    CementMoveReportDeclarRestCeh8: TFloatField;
    CementMoveReportDeclarDeviation: TFloatField;
    CementMoveReportDeclarNumHoppers: TStringField;
    CementMoveReportC: TDBFormControl;
    CementMoveReport1: TLinkMenuItem;
    Forming1DeclarVolumeStandard: TFloatField;
    Forming1ProcessVolumeStandard: TFloatField;
    Forming1ReportDeclarVolumeStandardTotal: TFloatField;
    Forming1ReportDeclarRejectTotal1: TFloatField;
    Forming1ReportDeclarRejectTotal2: TFloatField;
    Forming2DeclarAmountBlocks: TSmallintField;
    Forming2DeclarAmountRejectBlocks: TSmallintField;
    Forming2DeclarVolumeStandard: TFloatField;
    Forming2ProcessAmountBlocks: TSmallintField;
    Forming2ProcessAmountRejectBlocks: TSmallintField;
    Forming2ProcessVolumeStandard: TFloatField;
    ProdShop2V: TLinkSource;
    ProdShop2VDeclar: TLinkTable;
    ProdShop2VDeclarID: TIntegerField;
    ProdShop2VDeclarSize: TStringField;
    ProdShop2VDeclarHeight: TFloatField;
    ProdShop2VDeclarWidth: TSmallintField;
    ProdShop2VDeclarsLength: TFloatField;
    ProdShop2VDeclarVolOneBlock: TFloatField;
    ProdShop2VDeclarAmountBlocks: TSmallintField;
    ProdShop2VDeclarKod400: TIntegerField;
    ProdShop2VDeclarMassa400: TFloatField;
    ProdShop2VDeclarKod500: TIntegerField;
    ProdShop2VDeclarMassa500: TFloatField;
    ProdShop2VDeclarKod600: TIntegerField;
    ProdShop2VDeclarMassa600: TFloatField;
    ProdShop2VDeclarKod700: TIntegerField;
    ProdShop2VDeclarMassa700: TFloatField;
    ProdShop2VC: TDBFormControl;
    ProdShop2V1: TLinkMenuItem;
    Forming2ReportDeclarVolumeStandardTotal: TFloatField;
    Forming2ReportDeclarRejectTotal1: TFloatField;
    Forming2ReportDeclarRejectTotal2: TFloatField;
    Forming2Report2: TLinkSource;
    Forming2Report2Declar: TLinkTable;
    Forming2Report2DeclarDateCut: TDateField;
    Forming2Report2DeclarShiftCut: TSmallintField;
    Forming2Report2DeclarShiftCutName: TStringField;
    Forming2Report2DeclarShiftForemanCut: TIntegerField;
    Forming2Report2DeclarShiftForemanCutName: TStringField;
    Forming2Report2DeclarProd: TIntegerField;
    Forming2Report2DeclarProdName: TStringField;
    Forming2Report2DeclarAmountMassif: TSmallintField;
    Forming2Report2DeclarVolumeStandardTotal: TFloatField;
    Forming2Report2DeclarVolumeTotal: TFloatField;
    Forming2Report2DeclarVolumeEndTotal: TFloatField;
    Forming2Report2DeclarRejectTotal1: TFloatField;
    Forming2Report2DeclarRejectTotal2: TFloatField;
    Forming2Report2DeclarRejectTotal: TFloatField;
    Forming2Report2DeclarID: TIntegerField;
    Forming2Report2C: TDBFormControl;
    Forming2Report21: TLinkMenuItem;
    Forming1ReportDeclarRejectTotal3: TFloatField;
    UnForming1T: TLinkSource;
    UnForming1TDeclar: TLinkTable;
    UnForming1TDeclarProd: TIntegerField;
    UnForming1TDeclarConcreteStrength: TFloatField;
    UnForming1TDeclarTare: TSmallintField;
    UnForming1TDeclarAmountLine14: TFloatField;
    UnForming1TDeclarAmountLine2: TFloatField;
    UnForming1TDeclarIDH: TIntegerField;
    UnForming1TDeclarID: TAutoIncField;
    UnForming1: TLinkSource;
    UnForming1Declar: TLinkTable;
    UnForming1DeclarsDate: TDateField;
    UnForming1DeclarForeman: TIntegerField;
    UnForming1DeclarForemanChief: TIntegerField;
    UnForming1DeclarQualityInspector: TIntegerField;
    UnForming1DeclarForemanShipping: TIntegerField;
    UnForming1DeclarForemanPackage: TIntegerField;
    UnForming1DeclarID: TAutoIncField;
    UnForming1DeclarShift: TXEListField;
    UnForming1DeclarForemanName: TXELookField;
    UnForming1DeclarForemanChiefName: TXELookField;
    UnForming1DeclarQualityInspectorName: TXELookField;
    UnForming1DeclarForemanShippingName: TXELookField;
    UnForming1DeclarForemanPackageName: TXELookField;
    UnForming1TDeclarMovement: TXEListField;
    UnForming1TDeclarTareName: TXELookField;
    UnForming1TDeclarProdName: TXELookField;
    UnForming1C: TDBFormControl;
    UnForming11: TLinkMenuItem;
    ProdLookup1: TLinkTable;
    ProdLookup1Kod: TIntegerField;
    ProdLookup1Name: TStringField;
    ProdLookup1UnitMName: TStringField;
    ProdLookup1Massa: TFloatField;
    ProdLookup1Sizes: TStringField;
    ProdLookup1Density: TSmallintField;
    ProdLookup2: TLinkQuery;
    ProdLookup2Sizes: TStringField;
    ProdLookup3: TLinkQuery;
    ProdLookup3Sizes: TStringField;
    ProdLookup3Density: TSmallintField;
    UnForming1V: TLinkSource;
    UnForming1VDeclar: TLinkTable;
    UnForming1VDeclarID: TIntegerField;
    UnForming1VDeclarIDH: TIntegerField;
    UnForming1VDeclarForeman: TIntegerField;
    UnForming1VDeclarForemanName: TStringField;
    UnForming1VDeclarShift: TSmallintField;
    UnForming1VDeclarShiftName: TStringField;
    UnForming1VDeclarForemanChief: TIntegerField;
    UnForming1VDeclarForemanChiefName: TStringField;
    UnForming1VDeclarQualityInspector: TIntegerField;
    UnForming1VDeclarQualityInspectorName: TStringField;
    UnForming1VDeclarForemanShipping: TIntegerField;
    UnForming1VDeclarForemanShippingName: TStringField;
    UnForming1VDeclarForemanPackage: TIntegerField;
    UnForming1VDeclarForemanPackageName: TStringField;
    UnForming1VDeclarProd: TIntegerField;
    UnForming1VDeclarProdName: TStringField;
    UnForming1VDeclarDensity: TSmallintField;
    UnForming1VDeclarConcreteStrength: TFloatField;
    UnForming1VDeclarMovement: TSmallintField;
    UnForming1VDeclarMovementName: TStringField;
    UnForming1VDeclarTare: TSmallintField;
    UnForming1VDeclarTareName: TStringField;
    UnForming1VDeclarAmountLine14: TFloatField;
    UnForming1VDeclarAmountLine2: TFloatField;
    UnForming1VC: TDBFormControl;
    UnForming1V1: TLinkMenuItem;
    UnForming1VDeclarsDate: TDateField;
    Procedure PriceOnDate(InProd: Integer; InTare, InTPrice, InBaseTPrice: Smallint; InDate:String;
      var OutPrice:Double; var OutRateVat, OutBid,OutExtra:Real; var OutDate:TDateTime; var OutPriceGross:Double);
    Function GetMainUp(InProd:Integer):Integer;
    procedure TPriceLookupCalcFields(DataSet: TDataSet);
    function TareNameFilter(Sender: TObject): String;
    function TPriceNameFilter(Sender: TObject): String;
    procedure ProdTareDLookupCalcFields(DataSet: TDataSet);
    procedure ProdMovementCCreateForm(Sender: TObject);
    procedure ProdMovementDeclarCalcFields(DataSet: TDataSet);
    procedure ProdMovementDeclarNewRecord(DataSet: TDataSet);
    function ProdMovementDeclarDateNameFilter(Sender: TObject): String;
    procedure ProdMovementDeclarDateNameSetEditValue(Sender: TField; Text: String);
    procedure ProdMovementCActivateForm(Sender: TObject);
    procedure TurnOverProd1Click(Sender: TObject);
    procedure ProdMovementDeclarBeforePost(DataSet: TDataSet);
    procedure ProdPriceDDeclarCalcFields(DataSet: TDataSet);
    procedure ReportPanel1Click(Sender: TObject);
    procedure EquipmentV1Click(Sender: TObject);
    procedure EquipmentVCCreateForm(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure ProdTotalCompareStore1Click(Sender: TObject);
    procedure ReportPanelCCreateForm(Sender: TObject);
    procedure ProdTotalStoreDeclarNewRecord(DataSet: TDataSet);
    procedure ProdReport_2CCreateForm(Sender: TObject);
    procedure GenerateProdTreeClick(Sender: TObject);
    procedure ProdLookupCalcFields(DataSet: TDataSet);
    procedure WorkFactDeclarNewRecord(DataSet: TDataSet);
    procedure WorkDayDeclarBeforePost(DataSet: TDataSet);
    procedure ProdPlanCCreateForm(Sender: TObject);
    procedure WorkDayDeclarBeforeInsert(DataSet: TDataSet);
    procedure WorkDayDeclarBeforeDelete(DataSet: TDataSet);
    procedure ProdPriceDTareChange(Sender: TField);
    procedure WorkFactDeclarBeforePost(DataSet: TDataSet);
    procedure WorkFactDeclarBeforeDelete(DataSet: TDataSet);
    procedure WorkFactDeclarAfterPost(DataSet: TDataSet);
    procedure WorkDayDeclarAfterPost(DataSet: TDataSet);
    procedure WorkDayDeclarNewRecord(DataSet: TDataSet);
    procedure WorkReportCCreateForm(Sender: TObject);
    procedure WorkProdCCreateForm(Sender: TObject);
    procedure Forming2CCreateForm(Sender: TObject);
    procedure Forming2DeclarNewRecord(DataSet: TDataSet);
    procedure Forming2SetGridFont(Sender: TObject; Field: TField; Font: TFont);
    function Forming2DeclarMakerNameFilter(Sender: TObject): String;
    function Forming2DeclarShiftForemanNameFilter(Sender: TObject): String;
    procedure Forming2CActivateForm(Sender: TObject);
    procedure HighlightGridClick(Sender: TObject);
    procedure TechParamsOnOffGridClick(Sender: TObject);
    procedure Forming2ReportCCreateForm(Sender: TObject);
    procedure GetForming2ReportClick(Sender: TObject);
    procedure LineFilterClick(Sender: TObject);
    function Forming1DeclarMakerNameFilter(Sender: TObject): String;
    function Forming1DeclarShiftForemanNameFilter(Sender: TObject): String;
    procedure StockRestDeclarNewRecord(DataSet: TDataSet);
    procedure Forming1DeclarBeforePost(DataSet: TDataSet);
    procedure Forming1DeclarVolumeChange(Sender: TField);
    procedure Forming1DeclarAmountRejectBlocksChange(Sender: TField);
    procedure CementMoveReportCCreateForm(Sender: TObject);
    procedure GetCementMoveReportClick(Sender: TObject);
    procedure SetCementMoveReportGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetCementMoveReportGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure SetProdShopGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetProdShopGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure Forming1DeclarProdChange(Sender: TField);
    procedure ProdShop2VCCreateForm(Sender: TObject);
    procedure UnForming1CCreateForm(Sender: TObject);
    function UnForming1TDeclarTareNameFilter(Sender: TObject): String;
    procedure UnForming1TDeclarNewRecord(DataSet: TDataSet);
    procedure UnForming1VCCreateForm(Sender: TObject);
  public
    DialTurnOverProd:TDialDate;
    { Public declarations }
  end;

procedure GenerateTreeTable(Tree:TDataSet; TreeTable:TTable; aKod,aKodUp,aAmountDown:TField);
var ModuleProd: TModuleProd;
    OldSyncDataSet: boolean;
    ThisPrice,ThisPriceGross:double;
    ThisBid,ThisExtra,ThisRateVAT:Real;
    ThisDatePrice:TDateTime;
    aDate: TDateTime;

Const SetFlag:boolean=false;

Implementation
uses Dialogs,Prod,Vg,MdCommon,SysUtils, Buttons, XECtrls, BEForms, MdInvc, MdWorkers, Invoice,SForm,RXCtrls,ExtCtrls,
     Windows,Messages,StdCtrls,ToolEdit,EtvContr,EtvDBFun,Misc,MdBase, ProdPlan, MdClientsAdd, UnForming1;

var SDate:TDateTime; { Дата для автоввода. Запоминаем в событии BeforePost }
                     { Дублируем в событии OnNewRecord                     }
    BtnHighlight,BtnTechParamsOnOff,BtnGetForming2Report,BtnGetCementMoveReport,BtnGetCementMoveReportWithCorrectionForError: TBitBtn;
    AllLineBtn,Line1Btn,Line2Btn,Line4Btn:TSpeedButton;
    ReportDateBeg,ReportDateEnd,DateCementMoveReport: TDateEdit;
    DeclarTable,ProcessTable:TLinkTable; { Текущие датасеты для журналов формовки }
    ReportLine:TComboBox;

{$R *.DFM}

Procedure TModuleProd.PriceOnDate(InProd: Integer; InTare,InTPrice,InBaseTPrice: Smallint; InDate:String;
   var OutPrice:Double; var OutRateVat,OutBid,OutExtra:Real; var OutDate:TDateTime; var OutPriceGross:Double);
begin
  ProdPriceOnDate.Params.ParamByName('InProd').Value:=InProd;
  ProdPriceOnDate.Params.ParamByName('InTare').Value:=InTare;
  ProdPriceOnDate.Params.ParamByName('InTPrice').Value:=InTPrice;
  ProdPriceOnDate.Params.ParamByName('InBaseTPrice').Value:=InBaseTPrice;
  ProdPriceOnDate.Params.ParamByName('InDate').Value:=InDate;
  ProdPriceOnDate.Open;
  OutPrice:=ProdPriceOnDateThisPrice.Value;
  OutRateVAT:=ProdPriceOnDateThisRateVat.Value;
  OutBid:=ProdPriceOnDateThisBid.Value;
  OutExtra:=ProdPriceOnDateThisExtra.Value;
  OutDate:=ProdPriceOnDateThisDate.Value;
  OutPriceGross:=ProdPriceOnDateThisPriceGross.Value;
  ProdPriceOnDate.Close;
end;

Function TModuleProd.GetMainUp(InProd:Integer):Integer;
begin
  with ProdTareDProcess do begin
    ParamByName('InProd').Value:=InProd;
    Open;
    Result:=ProdTareDProcessMainUp.Value;
    Close;
  end;
end;

Procedure GenerateTreeTable(Tree:TDataSet; TreeTable:TTable; aKod,aKodUp,aAmountDown:TField);
const MaxLevel=50;
var Finds: variant;
    V: Variant;
    i,j,Level: ShortInt;
begin
  Finds:=VarArrayCreate([0, MaxLevel],varInteger);
  V:=VarArrayCreate([0, 1],varInteger);
  with TreeTable do begin
    Close;
    Exclusive:=true;
    EmptyTable;
    Open;
  end;
  Tree.DisableControls;
  TQuery(Tree).CachedUpdates:=true;
  Tree.First;
  while not Tree.Eof do begin
    if aAmountDown.Value=0 then begin { Формируем ProdTree только для листьев }
      Level:=0;
      Finds[0]:=aKod.Value;
      while aKodUp.Value<>null do
        if Tree.Locate('Kod',aKodUp.Value,[]) then begin
          Inc(Level);
          Finds[Level]:=aKod.Value;
        end else begin
          { Эта ветка не доходит до ствола, мы ее обрубаем }
          {ShowMessage('Неверная ссылка в дереве.'+#13+'Не найдено значение '+aKodUp.AsString);}
          Level:=0;
          Break;
        end;
      { Возвращаемся туда, откуда пришли }
      if Finds[0]<>aKod.Value then Tree.Locate('Kod',Finds[0],[]);
      for i:=0 to 0{Level-1} do
        for j:=i+1 to Level do begin
          V[0]:=Finds[j]; V[1]:=Finds[i];
          if TreeTable.Locate('KodUp;KodDown',V,[]) then begin
            { выходим из циклов по i и по j, т.к. дальше проверять бесполезно }
            Break;
            Break;
          end;
          TreeTable.AppendRecord([Finds[j],Finds[i]]);
        end;
    end;
    Tree.Next;
  end;
  TQuery(Tree).CachedUpdates:=false;
  Tree.EnableControls;
  {ShowMessage('Щас запущу ApplyUpdates!');}
  with TreeTable do begin
    ApplyUpdates;
    Close;
    Exclusive:=false;
    Open;
  end;
end;

Procedure TModuleProd.GenerateProdTreeClick(Sender: TObject);
begin
  ExecSQLText(EquipmentVDeclar.DataBaseName,'Call STA.GenerateProdTree()',false);
end;

procedure TModuleProd.TPriceLookupCalcFields(DataSet: TDataSet);
begin
{
  TPriceLookupNameDop.Value:=TPriceLookupCurrencyName.StringByLookName('NameDop');
  TPriceLookupGenitive.Value:=TPriceLookupCurrencyName.StringByLookName('Genitive1');
  TPriceLookupNominative.Value:=TPriceLookupCurrencyName.StringByLookName('Nominative');
}
end;

Function TModuleProd.TareNameFilter(Sender: TObject): String;
begin
  Result:='Prod='+IntToStr(GetMainUp(TEtvLookField(Sender).DataSet.FieldByName('Prod').Value))
end;

Function TModuleProd.TPriceNameFilter(Sender: TObject): String;
begin
  with TEtvLookField(Sender) do
    if (DataSet.FieldByName('Prod').AsInteger=46002) or (DataSet.FieldByName('Prod').AsInteger=46001) then
  Result:='Name='''+TEtvLookField(Sender).StringByLookName('Name')+'''';
end;

procedure TModuleProd.ProdTareDLookupCalcFields(DataSet: TDataSet);
begin
  ProdTareDLookupWeight.Value:=ProdTareDLookupTareName.ValueByLookName('Weight');
end;

procedure TModuleProd.ProdMovementCCreateForm(Sender: TObject);
begin
  TBEForm(ProdMovementC.Form).Grid.OnTitleClick:=ModuleInvoice.GridTitleClick;
end;

procedure TModuleProd.EquipmentVCCreateForm(Sender: TObject);
begin
  TBEForm(TDBFormControl(Sender).Form).Grid.TitleRows:=3;
  {TBEForm(EquipmentVC.Form).Grid.TitleRows:=3;}
end;

procedure TModuleProd.ProdMovementCActivateForm(Sender: TObject);
begin
  with ProdPriceProcess do
    if DataSource<>ProdMovement then begin
      Close;
      DataSource:=ProdMovement;
      Params.ParamByName('Prod').Clear;
      Params[0].Bound:=false;
      Params.ParamByName('Tare').Value:=1;
      Params.ParamByName('TPrice').Value:=1;
      Open;
    end;
end;

procedure TModuleProd.ProdMovementDeclarCalcFields(DataSet: TDataSet);
begin
  if (ProdMovementDeclarDatePrice.Value=0) or
     (ProdMovementDeclarProd.Value=0)
     {or (ProdMovementDeclarAmount.Value=0)}
     {or (ProdMovementDeclarTPrice.Value=0)}
     {or (DeclarTareD.Value=0)} then Exit;

  PriceOnDate(ProdMovementDeclarProd.Value,1{ProdMovementDeclarTare.Value},
              1{ProdMovementDeclarTPrice.Value},0,ProdMovementDeclarDatePrice.AsString,
                  ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
  ProdMovementDeclarPrice.Value:=ThisPrice;
end;

procedure TModuleProd.ProdMovementDeclarNewRecord(DataSet: TDataSet);
begin
  ProdMovementDeclarDate.Value:=FormStart.MainDate.Date;
  ProdMovementDeclarDatePrice.Value:=FormStart.MainDate.Date;
  ProdMoveMentDeclarOper.Value:=1;
end;

function TModuleProd.ProdMovementDeclarDateNameFilter(
  Sender: TObject): String;
begin
(*
  if (ProdMovementDeclarProd.AsString='')
    {or (DeclarTareD.AsString='') or (DeclarTPriceD.AsString='')}
  then begin
    ShowMessage('Недостаточно значений для формирования запроса');
    Abort;
  end;
  Result:='(Prod='+ProdMovementDeclarProd.AsString+') and (Tare=1'{+
    IntToStr(ModuleProd.GetAnalTare(DeclarTareD.Value))}
    +') and (TPrice=1'+{DeclarTPriceD.AsString+}')';
  *)
  if ProdMovementDeclar.State in [dsBrowse] then begin
    with ProdPriceProcess do
      if DataSource<>ProdMovement then begin
        Close;
        DataSource:=ProdMovement;
        Params[0].Bound:=false;
        Params.ParamByName('Tare').Value:=1;
        Params.ParamByName('TPrice').Value:=1;
        Open;
      end;
  end;

  if ProdMovementDeclar.State in [dsInsert,dsEdit] then begin
    with ProdPriceProcess do begin
      Close;
      DataSource:=nil;
      Params.ParamByName('Prod').Value:=ProdMovementDeclarProd.Value;
      Params.ParamByName('Tare').Value:=1;
      Params.ParamByName('TPrice').Value:=1;
      Open;
    end;
  end;
end;

Procedure TModuleProd.ProdMovementDeclarDateNameSetEditValue(
  Sender: TField; Text: String);
begin
  if not (Sender.DataSet.State in [dsEdit,dsInsert]) then Sender.DataSet.Edit;
  ProdMovementDeclarDatePrice.AsString:=Text;
end;

{ Глобальные переменные, чтобы не повторять ввод параметров заново }
var KodProdLabel: TRxLabel;
    EditProd:TEtvDBLookupCombo;
    LookSource:TDataSource;
    CheckBoxOTK,CheckBoxStore:TCheckBox;
    RadioGroupTotal: TRadioGroup;

Procedure TModuleProd.TurnOverProd1Click(Sender: TObject);
var lModalResult:TModalResult;
    S:string;
begin
  if not Assigned(DialTurnOverProd) then begin
    DialTurnOverProd:=TDialDate.Create(Application);
    with DialTurnOverProd do begin
      Width:=500;
      EditDateBeg.Date:=Now;
      EditDateEnd.Date:=Now;
      Bevel1.Width:=Width-23;
    end;

    KodProdLabel:=TRxLabel.Create(DialTurnOverProd);
    with KodProdLabel do begin
      Caption:='Код продукции';
      Left:=24;
      Top:=96;
      Parent:=DialTurnOverProd;
    end;
    {KodProd:=TCurrencyEdit.Create(DialTurnOverProd);}

    LookSource:=TDataSource.Create(DialTurnOverProd);
    LookSource.DataSet:=ProdMovementDeclarProdName.LookupDataSet;
    if not LookSource.DataSet.Active then LookSource.DataSet.Open;
    EditProd:=
      TEtvDBLookupCombo(EditForField(DialTurnOverProd,ProdMovementDeclarProdName,0,LookSource));
    with EditProd do begin
      Left:=104;
      Top:=KodProdLabel.Top;
      {Width:=100;
      DisplayFormat:='';}
      TabStop:=true;
      Parent:=DialTurnOverProd;
      TabOrder:=2;
    end;

    CheckBoxOTK:=TCheckBox.Create(DialTurnOverProd);
    with CheckBoxOTK do begin
      Width:=200;
      Caption:='С учетом актов ОТК';
      Checked:=false;
      Left:=24;
      Top:=120;
      TabStop:=true;
      Parent:=DialTurnOverProd;
      TabOrder:=3;
    end;

    RadioGroupTotal:=TRadioGroup.Create(DialTurnOverProd);
    with RadioGroupTotal do begin
      Caption:=' Параметры итогов ';
      Parent:=DialTurnOverProd;
      with Items do begin
        Add('Только итог');
        Add('Вся продукция');
        Add('Итоги по группам продукции');
      end;
      ItemIndex:=0;
      Width:=210;
      Left:=210;
      Top:=12;
      Height:=76;
      TabStop:=True;
      TabOrder:=3;
    end;

    CheckBoxStore:=TCheckBox.Create(DialTurnOverProd);
    with CheckBoxStore do begin
      Width:=200;
      Caption:='Без учета последней сверки';
      Hint:='Не включать в отчет корректировки по результатам '+#13+
            'последней проверки остатков на складах';
      Checked:=false;
      Left:=24;
      Top:=140;
      TabStop:=true;
      Parent:=DialTurnOverProd;
      TabOrder:=4;
    end;
  end;
  { Заголовок диалога }
  if TMenuItem(Sender).Name='TurnOverProd1' then begin
    DialTurnOverProd.Caption:='Обороты по продукции';
    CheckBoxOTK.Visible:=true;
    RadioGroupTotal.Visible:=true;
    CheckBoxStore.Visible:=true;
  end else begin
    DialTurnOverProd.Caption:='Формирование итогов по реализации за период';
    CheckBoxOTK.Visible:=false;
    CheckBoxStore.Visible:=false;
  end;

  lModalResult:=DialTurnOverProd.ShowModal;
  if lModalResult<>idOk then Abort;
  with DialTurnOverProd do
    if TMenuItem(Sender).Name='TurnOverProd1' then
      with TurnOverProdDeclar do
      try
        Close;
        if lModalResult=idOk then begin
          {
          ParamByName('DateBg').Value:=DateEditBe.Date;
          ParamByName('DateEn').Value:=DateEditEn.Date;
          }
          if EditProd.KeyValue=null then s:='null'
          else s:=VarToStr(EditProd.KeyValue);
          {ParamByName('Prod').Value:=EditProd.KeyValue;}
          {ParamByName('Detail').Value:=1-SmallInt(CheckBox.Checked);}

          ExecSQLText(TurnOverProdDeclar.DataBaseName,
          'Call STA.CalcRotateProduction('+''''+EditDateBeg.Text+''''+','+
          ''''+EditDateEnd.Text+''''+','+s+','+
                     { 0 , 1 или 2 }
            IntToStr(RadioGroupTotal.ItemIndex)+','+
            IntToStr(SmallInt(CheckBoxStore.Checked))+','+
            IntToStr(SmallInt(CheckBoxOTK.Checked))+')',false);
          TurnOverProdC.Caption:='Обороты продукции. Код '+EditProd.Text+'. Период '+
            EditDateBeg.Text+'-'+EditDateEnd.Text;
          Open;
        end;
      finally
        {DialTurnOverProd.Free;}
        {if lModalResult<>idOk then Abort;}
      end
    else begin {Формирование итогов по реализации за период}
      { Проверяем, есть ли хоть какие-нибудь данные за числа      }
      { DateEditBe - DateEditEn в таблице ProdTotal               }
      { и если есть, то предупреждаем пользователя                }

      if (GetFromSQLText(TurnOverProdDeclar.DataBaseName,
      'select Count(*) from STA.ProdTotal where (Oper=2) and (SDate between '''+
      EditDateBeg.Text+''' and '''+EditDateEnd.Text+''')',false)=0) or
      (MessageDlg('В таблице итогов найдены данные по реализации за указанный вами диапазон дат'+
      #13+EditDateBeg.Text+' - '+EditDateEnd.Text+#13+
      'Вы подтверждаете сделанный выбор?',mtConfirmation,[mbYes,mbNo],0)=idYes) then begin
        s:='Call STA.ProdRealizationToTotal('+''''+EditDateBeg.Text+''''+','+
         ''''+EditDateEnd.Text+''''+',';
        if EditProd.KeyValue=null then s:=s+'null)'
        else s:=s+VarToStr(EditProd.KeyValue)+')';
        ExecSQLText(TurnOverProdDeclar.DataBaseName,S,false);
      end;
    end;
end;

procedure TModuleProd.ProdMovementDeclarBeforePost(DataSet: TDataSet);
begin
  SDate:=ProdMovementDeclarDate.Value;
end;

procedure TModuleProd.ProdPriceDDeclarCalcFields(DataSet: TDataSet);
var aRound:integer;
begin
  if ProdPriceDTPriceName.ValueByLookName('Currency')=974 then begin
    aRound:=RoundRB(ProdPriceDSDate.AsDateTime,false);
    if (aRound=1) and (ProdPriceDBid.AsFloat>0) then aRound:=10;
    ProdPriceDPriceBid.Value:=
      ProdPriceDPrice.AsFloat*(1+ProdPriceDExtra.AsFloat/100)*(1+ProdPriceDBid.AsFloat/100)*ProdPriceDRateVAT.Value;
{
    if (ProdPriceDTPrice.Value in[1,2,3,34]) and (ProdPriceDSDate.AsString>'01.01.2000') then
      ProdPriceDPriceBid.Value:=ProdPriceDPriceBid.Value*1.2;
}
    if ProdPriceDPriceBid.Value<1000 then
      ProdPriceDPriceBid.Value:=MRound(ProdPriceDPriceBid.Value)
    else ProdPriceDPriceBid.Value:=MRound(ProdPriceDPriceBid.Value/aRound)*aRound
  end else begin
  end;
end;

Procedure TModuleProd.ReportPanel1Click(Sender: TObject);
var DlgOneDate: TDialDate;
begin
  DlgOneDate:=TDialDate.Create(Application);
  DlgOneDate.EditDateBeg.Date:=Date;
  with DlgOneDate do begin
    VisibleSecondDate(false,0);
    Caption:='Параметры отчета по панелям';
  end;
(*
  if InputQuery('Параметры отчета','Введите дату отчета', S) then begin
    ReportPanelC.Caption:='Справочник цен на панели по состоянию на '+S;
    with ReportPanelDeclar.ParamByName('InDate') do
      if AsString<>S then begin
        AsString:=S;
        ReportPanelDeclar.Close;
        {eportPanelDeclar.Open;}
      end;
      ReportPanelDeclar.ParamByName('InDate').Value:=StrToDate_(S);
  end else Abort;
*)
  if (DlgOneDate.ShowModal in [idOk,idYes]) and (DlgOneDate.EditDateBeg.Date>0) then
    with DlgOneDate do try
      with ReportPanelDeclar.ParamByName('InDate') do
        if Value<>DlgOneDate.EditDateBeg.Date then begin
          ReportPanelC.Caption:='Справочник цен на панели по состоянию на '+
            DlgOneDate.EditDateBeg.Text;
          Value:=DlgOneDate.EditDateBeg.Date;
          ReportPanelDeclar.Close;
          {eportPanelDeclar.Open;}
        end;
    finally
      DlgOneDate.Release;
    end
  else Abort;
end;

var DateBeg: TDateTime;
    DateEnd: TDateTime;
procedure TModuleProd.EquipmentV1Click(Sender: TObject);
var DlgOneDate: TDialDate;
begin
  if DateBeg=0 then DateBeg:=Date;
  if DateEnd=0 then DateEnd:=Date;
  DlgOneDate:=TDialDate.Create(Application);
  DlgOneDate.EditDateBeg.Date:=DateBeg;
  DlgOneDate.EditDateEnd.Date:=DateEnd;
  with DlgOneDate do begin
    {VisibleSecondDate(false);}
    Caption:='Укажите период расчета оборотки';
  end;
  if (DlgOneDate.ShowModal in [idOk,idYes]) and (DlgOneDate.EditDateBeg.Date>0) and
  (DlgOneDate.EditDateEnd.Date>0) and (DlgOneDate.EditDateEnd.Date>=DlgOneDate.EditDateBeg.Date) then
    if ((DlgOneDate.EditDateEnd.Date<>DateEnd) or (DlgOneDate.EditDateBeg.Date<>DateBeg)) then
      { проверили на старые значения }
      with DlgOneDate do try
        { Заголовок формы }
        EquipmentVC.Caption:='Обороты по оборудованию с '+EditDateBeg.Text+
                               ' по '+EditDateEnd.Text;
        DateBeg:=EditDateBeg.Date;
        DateEnd:=EditDateEnd.Date;
        { Закрыли таблицу со старыми значениями }
        EquipmentVDeclar.Close;
        { Запустили расчет }
        ExecSQLText(EquipmentVDeclar.DataBaseName,
         'Call STA.CalcRotateEquipment('''+EditDateBeg.Text+''','''+EditDateEnd.Text+''')',false);
        EquipmentVDeclarAmountBeg.DisplayLabel:='Кол-во на '+EditDateBeg.Text;
        EquipmentVDeclarAmountEnd.DisplayLabel:='Кол-во на '+EditDateEnd.Text;
        EquipmentVDeclarSummaBeg.DisplayLabel:='Сумма на '+EditDateBeg.Text;
        EquipmentVDeclarSummaEnd.DisplayLabel:='Сумма на '+EditDateEnd.Text;
        { Открыли таблицу с новыми значениями }
        EquipmentVDeclar.Close;
      finally
        DlgOneDate.Release;
      end
    else
  else Abort;
end;

Procedure TModuleProd.ProdTotalCompareStore1Click(Sender: TObject);
var DlgOneDate: TDialDate;
    DateParam: string;
begin
  {ProdTotalCompareStore(in inDate )
  Отчет по результатам инвентаризации на складах
  Запускается процедура, которая возвращает Select запрос
  }
  {if DateBeg=0 then DateBeg:=Date;}
  DlgOneDate:=TDialDate.Create(Application);
  DlgOneDate.VisibleSecondDate(false,0);
  DlgOneDate.EditDateBeg.Date:=DateBeg;
  with DlgOneDate do begin
    Caption:='';
  end;
  if (DlgOneDate.ShowModal in [idOk,idYes]) then
    { проверили на старые значения }
    with DlgOneDate do try
      DateBeg:=EditDateBeg.Date;
      if DateBeg=0 then DateParam:='NULL'
      else DateParam:=''''+EditDateBeg.Text+'''';
      ProdTotalCompareStoreC.Caption:='Отчет по результатам инвентаризации на складах на '+EditDateBeg.Text;
      { Закрыли таблицу со старыми значениями }
      ProdTotalCompareStoreDeclar.SQL.Clear;
      ProdTotalCompareStoreDeclar.SQL.Add('Call STA.ProdTotalCompareStore('+DateParam+')');
      { Открыли таблицу с новыми значениями }
      ProdTotalCompareStoreDeclar.Active:=true;
    finally
      DlgOneDate.Release;
    end
  else begin
    DlgOneDate.Release;
    Abort;
  end;
end;

Procedure TModuleProd.N9Click(Sender: TObject);
var DlgOneDate: TDialDate;
    DateParam: string;
begin
  { ProdFromStoreToTotal(in inDate)
  Корректировка выпуска продукции по результатам инвентаризации
  StoredProc'а. Ничего не возвращает }
  if DateBeg=0 then DateBeg:=Date;
  DlgOneDate:=TDialDate.Create(Application);
  DlgOneDate.VisibleSecondDate(false,0);
  {DlgOneDate.DateEditBe.Date:=DateBeg;}
  with DlgOneDate do begin
    Caption:='Корректировка выпуска продукции по результатам инвентаризации на дату';
  end;
  if (DlgOneDate.ShowModal in [idOk,idYes]) then
    { проверили на старые значения }
    with DlgOneDate do
    try
      DateBeg:=EditDateBeg.Date;
      if DateBeg=0 then DateParam:='NULL'
      else DateParam:=''''+EditDateBeg.Text+'''';
      ExecSQLText(EquipmentVDeclar.DataBaseName,
        'Call STA.ProdFromStoreToTotal('+DateParam+')',false);
    finally
      DlgOneDate.Release;
    end
  else begin
    DlgOneDate.Release;
    Abort;
  end;
end;

Procedure TModuleProd.ReportPanelCCreateForm(Sender: TObject);
begin
  TBEForm(ReportPanelC.Form).Grid.TitleRows:=3;
end;

Procedure TModuleProd.ProdTotalStoreDeclarNewRecord(DataSet: TDataSet);
begin
  ProdTotalStoreDeclarsDate.Value:=FormStart.MainDate.Date;
end;

procedure TModuleProd.ProdReport_2CCreateForm(Sender: TObject);
begin
  TBEForm(ProdReport_2C.Form).Grid.TitleRows:=2;
end;

procedure TModuleProd.ProdLookupCalcFields(DataSet: TDataSet);
begin
  if not ProdProcess.Active then ProdProcess.Open;
  if ProdProcess.Locate('Kod',ProdLookupKod.Value,[]) then begin
    ProdLookupUnitM.Value:=ProdProcessUnitM.Value;
    ProdLookupUnitMName.Value:=ProdProcessUnitMName.Value;
    ProdLookupMassa.Value:=ProdProcessMassa.Value;
    ProdLookupVolume.Value:=ProdProcessVolume.Value;
    ProdLookupFullName.Value:=ProdProcessFullName.Value;
  end;
end;

procedure TModuleProd.WorkFactDeclarNewRecord(DataSet: TDataSet);
var i:integer;
begin
  with WorkFactDeclar do
    if not VarIsEmpty(OldEditValues) then
      for i:=0 to FieldCount-1 do
        Fields[i].Value:=OldEditValues[i];
end;

procedure TModuleProd.WorkDayDeclarBeforePost(DataSet: TDataSet);
begin
  if WorkDayDeclarFlag.Value<>2 then
    WorkDayDeclarFlag.Value:=1; { Флаг для ведущей таблицы}
  aDate:=WorkDayDeclarsDate.AsDateTime;
end;

procedure TModuleProd.ProdPlanCCreateForm(Sender: TObject);
begin
  TFormProdPlan(TDBFormControl(Sender).Form).EtvDBGrid1.TitleRows:=2;
  {AMScaleForm(TFormProdPlan(ProdPlanC.Form));}
end;

procedure TModuleProd.WorkDayDeclarBeforeInsert(DataSet: TDataSet);
begin
(*
  ShowMessage('Режим вставки в данной таблице недоступен!');
  Abort;
*)
end;

procedure TModuleProd.WorkDayDeclarBeforeDelete(DataSet: TDataSet);
begin
  if WorkDayDeclarFlag.Value<>1 then begin
    WorkDayDeclar.Edit;
    WorkDayDeclarFlag.Value:=2;
    WorkDayDeclar.Post;
  end;
end;

Procedure TModuleProd.ProdPriceDTareChange(Sender: TField);
var aGetTare: smallint;
begin
  aGetTare:=GetFromSQLText(ProdPriceDDeclar.DataBaseName,
    'select GetTare('+TSmallintField(Sender).AsString+')',false);
  if TSmallintField(Sender).AsInteger<>aGetTare then
    TSmallintField(Sender).AsInteger:=aGetTare
end;

procedure TModuleProd.WorkFactDeclarBeforePost(DataSet: TDataSet);
begin
  if WorkFactDeclarFlag.Value<>2 then
    WorkFactDeclarFlag.Value:=1; { Флаг для ведущей таблицы}
end;

procedure TModuleProd.WorkFactDeclarBeforeDelete(DataSet: TDataSet);
begin
  if WorkFactDeclarFlag.Value<>1 then begin
    WorkFactDeclar.Edit;
    WorkFactDeclarFlag.Value:=2;
    WorkFactDeclar.Post;
  end;
end;

procedure TModuleProd.WorkFactDeclarAfterPost(DataSet: TDataSet);
begin
  WorkFactDeclar.Refresh;
end;

procedure TModuleProd.WorkDayDeclarAfterPost(DataSet: TDataSet);
begin
  WorkDayDeclar.Refresh;
end;

procedure TModuleProd.WorkDayDeclarNewRecord(DataSet: TDataSet);
begin
  WorkDayDeclarSDate.AsDateTime:=aDate;
end;

procedure TModuleProd.WorkReportCCreateForm(Sender: TObject);
begin
  ModuleClientsAdd.CreateReportForm(Sender);
end;

procedure TModuleProd.WorkProdCCreateForm(Sender: TObject);
begin
  TBEForm(TDBFormControl(Sender).Form).Grid.TitleRows:=2
end;

procedure TModuleProd.Forming2CCreateForm(Sender: TObject);
var ch:char;
begin
  if TDBFormControl(Sender).Name='Forming2C' then ch:='2' else ch:='1';
  with TBEForm(TDBFormControl(Sender).Form).Grid do begin
    TitleRows:=4;
    with Font do begin
      Name:='Arial Narrow';
    end;
    with TitleFont do begin
      Name:='Arial Narrow';
      Size:=7;
      Style:=[];
    end;
    Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
    with DataSource.DataSet do begin
      DisableControls;
      Last; { Обычно работаем в конце таблицы }
      Filter:='(sDate='''+FieldByName('sDate').AsString+''')'; { Накладываем фильтр на одну дату, чтобы быстрее выполнить FormatColumns }
      Filtered:=true;
      FormatColumns(true);
      Filtered:=false;
      Filter:='';
      Last;
      EnableControls;
    end;
    OnSetFont:=Forming2SetGridFont; // По умолчанию подсветка включена
  end;

  BtnHighlight:=TBitBtn.Create(TDBFormControl(Sender).Form);
  with BtnHighlight do begin
    Top:=0;
    Left:=125;
    Width:=80;
    Height:=22;
    Name:='BtnHighlight'+ch;
    Caption:='Подсветка';
    ShowHint:=true;
    Hint:='Подсветка переменных значений параметров.(Прорисовка таблицы медленнее)';
    Font.Name:='Arial Narrow';
    Font.Style:=[fsBold];
    Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
    OnClick:=HighlightGridClick;
  end;

  if ch='1' then begin { В журнале 1-го цеха 3 линии, делаем конпки, по нажатию на которые накладываем/снимаем фильтр по № линии }
    AllLineBtn:=TSpeedButton.Create(TDBFormControl(Sender).Form);
    with AllLineBtn do begin
      Top:=0;
      GroupIndex:=1;
      AllowAllUp:=true;
      Down:=true;
      Left:=BtnHighlight.Left+BtnHighlight.Width+8;
      Width:=40;
      Height:=22;
      Name:='AllLineBtn';
      Caption:='Все';
      ShowHint:=true;
      Hint:='Все линии';
      Font.Name:='Times New Roman';
      Font.Size:=12;
      Font.Style:=[fsBold];
      Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
      OnClick:=LineFilterClick;
    end;
    Line1Btn:=TSpeedButton.Create(TDBFormControl(Sender).Form);
    with Line1Btn do begin
      Top:=0;
      GroupIndex:=1;
      AllowAllUp:=true;
      Left:=AllLineBtn.Left+AllLineBtn.Width+4;
      Width:=30;
      Height:=22;
      Name:='Line1Btn';
      Caption:='1';
      ShowHint:=true;
      Hint:='Линия №1';
      Font.Name:='Lucida Console';
      Font.Size:=12;
      Font.Style:=[fsBold];
      Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
      OnClick:=LineFilterClick;
    end;
    Line2Btn:=TSpeedButton.Create(TDBFormControl(Sender).Form);
    with Line2Btn do begin
      Top:=0;
      GroupIndex:=1;
      AllowAllUp:=true;
      Left:=Line1Btn.Left+Line1Btn.Width+4;
      Width:=30;
      Height:=22;
      Name:='Line2Btn';
      Caption:='2';
      ShowHint:=true;
      Hint:='Линия №2';
      Font.Name:='Lucida Console';
      Font.Size:=12;
      Font.Style:=[fsBold];
      Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
      OnClick:=LineFilterClick;
    end;
    Line4Btn:=TSpeedButton.Create(TDBFormControl(Sender).Form);
    with Line4Btn do begin
      Top:=0;
      GroupIndex:=1;
      AllowAllUp:=true;
      Left:=Line2Btn.Left+Line2Btn.Width+4;
      Width:=30;
      Height:=22;
      Name:='Line4Btn';
      Caption:='4';
      ShowHint:=true;
      Hint:='Линия №4';
      Font.Name:='Lucida Console';
      Font.Size:=12;
      Font.Style:=[fsBold];
      Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
      OnClick:=LineFilterClick;
    end;
  end;

  if ch='2' then begin {В журнале 2-го цеха много технологических параметров, делаем кнопку, по которой их скрываем/показываем}
    BtnTechParamsOnOff:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnTechParamsOnOff do begin
      Top:=0;
      Left:=BtnHighlight.Left+BtnHighlight.Width+15;
      Width:=105;
      Height:=22;
      Name:='BtnTechParamsOnOff'+ch;
      Caption:='Техн.парам.вкл/выкл';
      ShowHint:=true;
      Hint:='Скрыть(показать) технологические параметры массивов';
      Font.Name:='Arial Narrow';
      Font.Style:=[fsBold];
      Parent:=TBEForm(TDBFormControl(Sender).Form).PageControl1TabPanel;
      OnClick:=TechParamsOnOffGridClick;
    end;
  end;
end;

Procedure TModuleProd.LineFilterClick(Sender: TObject);
var NumLine:string[1];
begin
  with TBEForm(TSpeedButton(Sender).Owner).Grid.DataSource.DataSet do begin
    DisableControls;
    Filtered:=False;
    NumLine:=Copy(TSpeedButton(Sender).Name,5,1);
    TSpeedButton(Sender).Down:=true;
    if NumLine<>'i' then begin
      Filter:='Line='+NumLine;
      Filtered:=true;
    end else Filter:='';
    EnableControls;
  end;
end;

Procedure TModuleProd.HighlightGridClick(Sender: TObject);
begin
  with TBEForm(TBitBtn(Sender).Owner).Grid do begin
    if Assigned(OnSetFont) then OnSetFont:=nil
    else OnSetFont:=Forming2SetGridFont;
    Repaint;
    SetFocus;
  end;
end;

Procedure TModuleProd.TechParamsOnOffGridClick(Sender: TObject);
var l: byte; { С 10 по 32 и 40(Note) index в массиве Fields - поля с технологическими параметрами }
    B:TBookMark;
    aSelectedField:TField; { Запоминаем текущий столбец в Grid'е }
begin
  with TBEForm(TBitBtn(Sender).Owner).Grid do begin
    with TTable(DataSource.DataSet) do begin
      B:=GetBookmark; (* may be need to remake by locate *)
      DisableControls;
      aSelectedField:=SelectedField;
      SelectedIndex:=0; { Устанавливаем временно SelectedIndex в 0, чтобы было меньше прорисовок }
      try
        Filter:='(sDate='''+FieldByName('sDate').AsString+''')'; { Накладываем фильтр на одну дату, чтобы быстрее выполнить FormatColumns }
        Filtered:=true;
        for l:=10 to 32{40} do if l in [10..32{,41}] then Fields[l].Visible:=not Fields[l].Visible;
        FormatColumns(true);
        Filtered:=false;
        Filter:='';
      finally
        GotoBookmark(B);
        SelectedField:=aSelectedField;
        EnableControls;
        FreeBookmark(B);
      end;
    end;
    SetFocus;
  end;
end;

procedure TModuleProd.Forming2DeclarNewRecord(DataSet: TDataSet);
var i,j:byte;
begin
  { Инициализация значений новой строки. Полностью заполняем значениями старой строки }
  with DeclarTable do begin
    if not VarIsEmpty(OldEditValues) then
      { 0 поле ID - AutoInc, заполнится само, поля Note,sUser,sTime, а также поля по расформовке пока не заполняем }
      for i:=1 to FieldCount-4 do
        if Fields[i] is TEtvLookField then begin
          { Определяем индекс ключевого поля для EtvLookField }
          j:=FieldByName(TEtvLookField(Fields[i]).KeyFields).Index;
          Fields[j].Value:=OldEditValues[j];
        end else if ((Fields[i].FieldName<>'TemperatureBegMix') or (DeclarTable=Forming2Declar)) and
        (Fields[i].FieldName<>'TemperatureOutgassing') and (Fields[i].FieldName<>'FlowTest') and (Fields[i].FieldName<>'Note') then with Fields[i] do
          try
            if (FieldName='NumMassif') then
              { Увеличиваем на 1 № массива}
              Value:=OldEditValues[i]+1
            else if (FieldName='Line') or (FieldName='Shift') or (FieldName='ShiftCut') then { Мерзкий тип - XEList, но иногда - полезный }
              case VarType(OldEditValues[i]) of
                3  : Value:=OldEditValues[i];     { В OldEditValues[i] сохранено как целое число}
                8  : AsString:=OldEditValues[i];  { В OldEditValues[i] сохранено как строка     }
              end
            else Value:=OldEditValues[i]
          except
          end;
  end;
  {Установка фокуса Grid'а на поля по-умолчанию: 1-й цех - № автоклавной решетки, 2-й цех - № формы }
  if DeclarTable=Forming1Declar then TBEForm(Screen.ActiveForm).Grid.SelectedField:=DeclarTable.FieldByName('NumAutoClaveGrill');
  if DeclarTable=Forming2Declar then TBEForm(Screen.ActiveForm).Grid.SelectedField:=DeclarTable.FieldByName('NumForm');
end;

procedure TModuleProd.Forming2SetGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if (Field.DataSet<>DeclarTable) then Exit;
  if (DeclarTable=Forming2Declar) and (Field.Index>39) then Exit; { Не все столбцы подсвечиваем }
  if (DeclarTable=Forming1Declar) and (Field.Index>27) then Exit; { Не все столбцы подсвечиваем }
  { Позиционирование в параллельном DataSet'е на одну запись выше }
  if (DeclarTable.FieldByName('ID').AsInteger>1) and (ProcessTable.FieldByName('ID').AsInteger<>DeclarTable.FieldByName('ID').AsInteger-1) then
    ProcessTable.Locate('ID',DeclarTable.FieldByName('ID').AsInteger-1,[]);
  if Field.Visible then
    { Если LookField, то легче сравнить ключевые поля }
    if ((Field is TEtvLookField) and (DeclarTable.FieldByName(Field.KeyFields).AsString<>ProcessTable.FieldByName(Field.KeyFields).AsString))
    or (not(Field is TEtvLookField) and (Field.AsString<>ProcessTable.FieldByName(Field.FieldName).AsString)) then begin
      Font.Style:=[fsBold];
      Font.Color:=$00400080 //близко к clPurple, но покраснее
    end;
end;

function TModuleProd.Forming2DeclarMakerNameFilter(Sender: TObject): String;
begin
  { Фильтруем таблицу работников на профессии инженер-технолог и оператор ПУ строит. изделий }
  { Обязательное условие DateOff=NULL иначе проявляются строки со значениями IS NULL }
  Result:='(Ceh=2) and ((Position=22493) or (Position=32493) or (Position=15952))';
end;

function TModuleProd.Forming1DeclarMakerNameFilter(Sender: TObject): String;
begin
  { Фильтруем таблицу работников на профессии лаборант и похожих (выбраны заранее коды) с пом. задачи по кадрам }
  { Обязательное условие DateOff=NULL иначе проявляются строки со значениями IS NULL }
  Result:='(Ceh=26) and ((Position=23309) or (Position=73612) or (Position=32014))';
end;

function TModuleProd.Forming2DeclarShiftForemanNameFilter(Sender: TObject): String;
begin
  Result:='(Ceh=2) and (Position=23416)';
end;

function TModuleProd.Forming1DeclarShiftForemanNameFilter(Sender: TObject): String;
begin
  { Фильтруем по профессии формовщик, крановщик, а лучшие из них - бригадиры }
  Result:='(Ceh=1) and ((Position=19399) or (Position=29399) or (Position=39399) or (Position=49399) or (Position=14171) or (Position=53790))';
end;

procedure TModuleProd.Forming2CActivateForm(Sender: TObject);
begin
  { Инициализация текущих DataSet'ов для прорисовки Grid'a с выделением переменных значений журналов}
  DeclarTable:=TLinkTable(TLinkSource(TXLinkSourceItem(TDBFormControl(Sender).Sources[0]).Source).LinkSets[0].DataSet);
  ProcessTable:=TLinkTable(TLinkSource(TXLinkSourceItem(TDBFormControl(Sender).Sources[0]).Source).LinkSets[1].DataSet);
  if not ProcessTable.Active then ProcessTable.Open;
end;

procedure TModuleProd.Forming2ReportCCreateForm(Sender: TObject);
var ch:char;
    ch2:string[1];
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    if Copy(TDBFormControl(Sender).Name,1,14)='Forming2Report' then ch:='2' else ch:='1';
    if Copy(TDBFormControl(Sender).Name,15,1)='2' then ch2:='2' else ch2:='';
    { Вставляем две даты и кнопку }
    ReportDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ReportDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ReportDateBeg'+ch+ch2;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
        //Text:='01.09.09'; - для начальной отладки
      {Parent:=PageControl1TabPanel;}
    end;
    ReportDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ReportDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ReportDateBeg.Left+ReportDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='ReportDateEnd'+ch+ch2;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      if Date=0 then Date:=Now;//ModuleBase.ConfigDeclarNextPeriod.AsDateTime-1;
        //Text:='07.09.09';
    end;
    if ch='1' then begin { Вставляем компонент для выбора номера линии }
      ReportLine:=TComboBox.Create(TDBFormControl(Sender).Form);
      with ReportLine do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=ReportDateEnd.Left+ReportDateEnd.Width+5;
        Width:=70;
        Height:=22;
        Name:='ReportLine'+ch;
        Font.Style:=[fsBold];
        Caption:='Линия';
        TabStop:=true;
        TabOrder:=2;
        Items.Add('Все');
        Items.Add('1 линия');
        Items.Add('2 линия');
        Items.Add('4 линия');
        ItemIndex:=0;
      end;
      { Корректируем ReportDateEnd.Left, чтобы следуюший компонент отработал правильно }
    end;

    BtnGetForming2Report:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnGetForming2Report do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      if ch='2' then Left:=ReportDateEnd.Left+ReportDateEnd.Width+5
      else Left:=ReportLine.Left+ReportLine.Width+5;
      Width:=41;
      Height:=22;
      Name:='BtnGetForming2Report';
      Caption:='Отчет';
      ShowHint:=true;
      if ch2='' then Hint:='формовке' else Hint:='резке';
      Hint:='Отчет по '+Hint+' цеха №'+ch+' за указанный период';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetForming2ReportClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=4;
      Font.Name:='Arial Narrow';
      Font.Size:=10;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      {TitleFont.Style:=[];}
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      {OnSetColor:=SetDefaultGridColor;}
      OnSetFont:=SetDefaultGridFont;
      MarkGridFontColor:=$00400080 //близко к clPurple, но покраснее
    end;
  end;
end;

Procedure TModuleProd.GetForming2ReportClick(Sender: TObject);
var Ch:char;
    Ch2:string[1];
    Ln:string[2];
    FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    if Copy(FC.Name,1,14)='Forming2Report' then ch:='2' else ch:='1';
    if Copy(FC.Name,15,1)='2' then ch2:='2' else ch2:='';
    if (ch='1') and (ReportLine.ItemIndex>0) then begin
      Ln:=IntToStr(ReportLine.ItemIndex);
      if Ln='3' then Ln:='4'; { 3-й линии нет, есть 4-я }
      Ln:=','+Ln;
    end else Ln:='';
    ExecSQLText(Forming2ReportDeclar.DataBaseName,'call STA.GetForming'+ch+'Report'+ch2+'('''+
      TDateEdit(FindComponent('ReportDateBeg'+ch+ch2)).Text+''','''+TDateEdit(FindComponent('ReportDateEnd'+ch+ch2)).Text+''''+Ln+')',false);
    FC.DefSource.DataSet.Refresh;
    if Ch2='' then FC.Caption:='формовке' else FC.Caption:='резке';
    FC.Caption:='Отчет по '+FC.Caption+' продукции цеха №'+ch+' с '+
      TDateEdit(FindComponent('ReportDateBeg'+ch+ch2)).Text+' по '+TDateEdit(FindComponent('ReportDateEnd'+ch+ch2)).Text;
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
  end;
end;

Procedure TModuleProd.StockRestDeclarNewRecord(DataSet: TDataSet);
var i:byte;
begin
  { Инициализация значений новой строки. Заполняем пока только дату }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) then
      { 0 поле ID - AutoInc, заполнится само }
      for i:=1 to FieldCount-2 do
        if not(Fields[i] is TEtvLookField) then with Fields[i] do
          try
            if (FieldName='sDate') then
              { Увеличиваем на 1 день дату}
              Value:=VarToDateTime(OldEditValues[i])+1
            else Value:=OldEditValues[i]
          except
          end;
    {Установка фокуса Grid'а на поле по-умолчанию: на поле "Cement" }
    TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('Cement');
  end;
  inherited;
end;

procedure TModuleProd.Forming1DeclarBeforePost(DataSet: TDataSet);
begin
  if DataSet.State in [dsEdit,dsInsert] then
    with DataSet,TEtvLookField(DataSet.FieldByName('ProdName')) do begin
      FieldByName('AmountBlocks').Value:=FieldByName('Volume').AsFloat/(ValueByLookName('Width')*ValueByLookName('sLength')*ValueByLookName('Height')/1000000000)
(*
      FieldByName('AmountBlocks').Value:=GetFromSQLText(Forming1Declar.DataBaseName,
        'select STA.GetAmountBlocks('+FieldByName('Volume').AsString+','+FieldByName('Prod').AsString+')',false);
*)
    end;
end;

procedure TModuleProd.Forming1DeclarVolumeChange(Sender: TField);
begin
  with Sender do
    with DataSet,TEtvLookField(DataSet.FieldByName('ProdName')) do
      FieldByName('AmountBlocks').Value:=FieldByName('Volume').AsFloat/(ValueByLookName('Width')*ValueByLookName('sLength')*ValueByLookName('Height')/1000000000);
end;

procedure TModuleProd.Forming1DeclarProdChange(Sender: TField);
begin
  with Sender do
    with DataSet,TEtvLookField(DataSet.FieldByName('ProdName')) do begin
      { Этот абзац только для цеха №1 }
      if (FindField('Line')<>nil) then if FieldByName('Line').Value=2 then
        if (FieldByName('Prod').AsInteger=2304) or (FieldByName('Prod').AsInteger=2027) or (FieldByName('Prod').AsInteger=2129) or (FieldByName('Prod').AsInteger=2306)
         then begin
          if (FieldByName('VolumeStandard').Value=null) then FieldByName('VolumeStandard').Value:=4.7;
          if (FieldByName('Volume').Value=null) then FieldByName('Volume').Value:=4.7;
          if (FieldByName('VolumeEnd').Value=null) then FieldByName('VolumeEnd').Value:=4.7;
        end else begin
          if (FieldByName('VolumeStandard').Value=null) then FieldByName('VolumeStandard').Value:=4.8;
          if (FieldByName('Volume').Value=null) then FieldByName('Volume').Value:=4.8;
          if (FieldByName('VolumeEnd').Value=null) then FieldByName('VolumeEnd').Value:=4.8;
        end;
      FieldByName('AmountBlocks').Value:=FieldByName('Volume').AsFloat/(ValueByLookName('Width')*ValueByLookName('sLength')*ValueByLookName('Height')/1000000000);
    end;
end;

procedure TModuleProd.Forming1DeclarAmountRejectBlocksChange(Sender: TField);
begin
(*
  { Объем после резки=Объем до резки-(Количество бракованных блоков*объем одного блока) }
  with Sender do
    with DataSet,TEtvLookField(DataSet.FieldByName('ProdName')) do
      FieldByName('VolumeEnd').Value:=FieldByName('Volume').AsFloat-
        (FieldByName('AmountRejectBlocks').AsInteger*(ValueByLookName('Width')*ValueByLookName('sLength')*ValueByLookName('Height')/1000000000))
*)
  {Формула через кол-во нормальных блоков V(end)=V*(A-A(брак))/A, где A - Amount of blocks }
  with Sender do
    with DataSet,TEtvLookField(DataSet.FieldByName('ProdName')) do
      FieldByName('VolumeEnd').Value:=
        FieldByName('Volume').AsFloat*((FieldByName('AmountBlocks').AsInteger-FieldByName('AmountRejectBlocks').AsInteger)/FieldByName('AmountBlocks').AsInteger)
end;

procedure TModuleProd.CementMoveReportCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем дату и кнопку }
    DateCementMoveReport:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with DateCementMoveReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='DateCementMoveReport';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      if Date=0 then Text:=ModuleBase.ConfigDeclarCurMonth.AsString;//Text:='01.10.09';
    end;

    BtnGetCementMoveReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnGetCementMoveReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=DateCementMoveReport.Left+DateCementMoveReport.Width+5;
      Width:=41;
      Height:=22;
      Name:='BtnGetCementMoveReport';
      Caption:='Отчет';
      ShowHint:=true;
      Hint:='Оборотная ведомость по движению цемента на основании данных по формовке продукции';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetCementMoveReportClick;
      TabStop:=true;
      TabOrder:=1;
    end;

    BtnGetCementMoveReportWithCorrectionForError:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnGetCementMoveReportWithCorrectionForError do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=BtnGetCementMoveReport.Left+BtnGetCementMoveReport.Width+5;
      Width:=90;
      Height:=22;
      Name:='BtnGetCementMoveReportWithCorrectionForError';
      Caption:='Учет погрешности';
      ShowHint:=true;
      Hint:='Расчет с учетом погрешности взвешивания от нормы: 1-я линия +1%, 2-я линия -1%, 4-я линия +2% ';
      Font.Name:='Arial Narrow';
      Font.Style:=[fsBold];
      OnClick:=GetCementMoveReportClick;
      TabStop:=true;
      TabOrder:=1;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=5;
      Font.Name:='Arial Narrow';
      Font.Size:=10;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=7;
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetCementMoveReportGridColor;
      OnSetFont:=SetCementMoveReportGridFont;//SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080 //близко к clPurple, но покраснее
    end;
  end;
end;

procedure TModuleProd.GetCementMoveReportClick(Sender: TObject);
var FC: TDBFormControl;
    Ch: char;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    if TBitBtn(Sender).Name='BtnGetCementMoveReport' then Ch:='0' else Ch:='1';
    FC:=TDBFormControl(FormControl);
    ExecSQLText(CementMoveReportDeclar.DataBaseName,'call STA.GetCementMoveReport('''+DateCementMoveReport.Text+''','+Ch+')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='Оборотная ведомость по движению цемента на основании данных по формовке продукции за '+DateCementMoveReport.Text;
    with Grid do begin
      FormatColumns(false);
      SetFocus;
    end;
  end;
end;

Procedure TModuleProd.SetCementMoveReportGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  if (Field.FieldName='RestBegin') or (Field.FieldName='ComingIn') or (Field.FieldName='TotalCementForForming')
    or (Field.FieldName='RestCalc') or (Field.FieldName='RestCeh8') or (Field.FieldName='Deviation') then Color:=$00DEF3FA;
end;

procedure TModuleProd.SetCementMoveReportGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  TXEDBGrid(Sender).SetDefaultGridFont(Sender,Field,Font);
  if (Field.FieldName='Deviation') then begin
    Font.Color:=TXEDBGrid(Sender).MarkGridFontColor;
    Font.Style:=[fsBold];
  end;
end;

Procedure TModuleProd.SetProdShopGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  if (Field.FieldName='Size') or (Copy(Field.FieldName,1,3)='Kod') then Color:=$00DEF3FA;
end;

procedure TModuleProd.SetProdShopGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  TXEDBGrid(Sender).SetDefaultGridFont(Sender,Field,Font);
  if (Field.FieldName='Size') or (Copy(Field.FieldName,1,3)='Kod') then begin
    if Field.FieldName='Size' then Font.Color:=TXEDBGrid(Sender).MarkGridFontColor;
    Font.Style:=[fsBold];
  end;
end;

procedure TModuleProd.ProdShop2VCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    with Grid do begin
      TitleRows:=4;
      Font.Name:='Arial Narrow';
      Font.Size:=10;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=8;
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      {FormatColumns(true); Не отрабатывает }
      {OnSetColor:=SetProdShopGridColor;}
      OnSetFont:=SetProdShopGridFont;
      MarkGridFontColor:=$00400080 //близко к clPurple, но покраснее
    end;
  end;
end;

procedure TModuleProd.UnForming1CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TFormUnForming1(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    Grid1.TitleRows:=3;
  end;
end;

function TModuleProd.UnForming1TDeclarTareNameFilter(Sender: TObject): String;
begin
  Result:='Tare=35'
end;

procedure TModuleProd.UnForming1TDeclarNewRecord(DataSet: TDataSet);
var i,j:byte;
begin
  { Инициализация значений новой строки. Полностью заполняем значениями старой строки }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) then
      { 0 поле ID - AutoInc, заполнится само, поля Note,sUser,sTime, а также поля по расформовке пока не заполняем }
      for i:=1 to FieldCount-5 do if Fields[i].FieldName<>'IDH' then
        if Fields[i] is TEtvLookField then begin
          { Определяем индекс ключевого поля для EtvLookField }
          j:=FieldByName(TEtvLookField(Fields[i]).KeyFields).Index;
          Fields[j].Value:=OldEditValues[j];
        end else with Fields[i] do
          try
            if (FieldName='Movement') then { Мерзкий тип - XEList, но иногда - полезный }
              case VarType(OldEditValues[i]) of
                3  : Value:=OldEditValues[i];     { В OldEditValues[i] сохранено как целое число}
                8  : AsString:=OldEditValues[i];  { В OldEditValues[i] сохранено как строка     }
              end
            else Value:=OldEditValues[i]
          except
          end;
  end;
end;

procedure TModuleProd.UnForming1VCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TFormUnForming1(TDBFormControl(Sender).Form) do begin
    with Grid do begin
      Color:=$00F8F8F8;
      TitleRows:=3;
      Font.Name:='Arial Narrow';
      TitleFont.Name:='Arial Narrow';
    end;
  end;
end;

end.
