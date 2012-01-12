Unit MdProd;

Interface

Uses
  Forms, Db, XTFC, EtvDB, DBTables, LnTables, DiDate,
  Menus, Classes, Graphics, Controls, XMisc, EtvTable, XEFields, XDBTFC,
  LnkSet, EtvLook, EtvList,Nav, daDatMod;

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
    UnForming1TDeclarMovement: TXEListField;
    UnForming1TDeclarTareName: TXELookField;
    UnForming1TDeclarProdName: TXELookField;

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

    UnForming2: TLinkSource;
    UnForming2Declar: TLinkTable;
    UnForming2DeclarsDate: TDateField;
    UnForming2DeclarForeman: TIntegerField;
    UnForming2DeclarQualityInspector: TIntegerField;
    UnForming2DeclarID: TAutoIncField;
    UnForming2DeclarShift: TXEListField;
    UnForming2DeclarForemanName: TXELookField;
    UnForming2DeclarQualityInspectorName: TXELookField;

    UnForming2T: TLinkSource;
    UnForming2TDeclar: TLinkTable;
    UnForming2TDeclarID: TAutoIncField;
    UnForming2TDeclarIDH: TIntegerField;
    UnForming2TDeclarProd: TIntegerField;
    UnForming2TDeclarProdName: TXELookField;
    UnForming2TDeclarCategory1: TFloatField;
    UnForming2TDeclarCategory2: TFloatField;
    UnForming2TDeclarConcreteStrength: TFloatField;
    UnForming2TDeclarCategory4: TFloatField;
    UnForming2TDeclarConcreteStrength4: TFloatField;
    UnForming2TDeclarReject: TFloatField;
    UnForming2TDeclarBreakage: TFloatField;

    UnForming1C: TDBFormControl;
    UnForming2C: TDBFormControl;
    UnForming11: TLinkMenuItem;
    UnForming21: TLinkMenuItem;

    ProdLookup1: TLinkTable;
    ProdLookup1Kod: TIntegerField;
    ProdLookup1Name: TStringField;
    ProdLookup1UnitMName: TStringField;
    ProdLookup1Massa: TFloatField;
    ProdLookup1Sizes: TStringField;
    ProdLookup1Density: TSmallintField;
    ProdLookup2: TLinkQuery;
    ProdLookup2Sizes: TStringField;
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
    ProdLookup3: TLinkTable;
    ProdLookup3Kod: TIntegerField;
    ProdLookup3Name: TStringField;
    ProdLookup3UnitMName: TStringField;
    ProdLookup3Massa: TFloatField;
    ProdLookup3Sizes: TStringField;
    ProdLookup3Density: TSmallintField;
    ProdLookup4: TLinkQuery;
    ProdLookup4Sizes: TStringField;
    UnForming2DeclarShiftNum: TXEListField;
    UnForming2V: TLinkSource;
    UnForming2VDeclar: TLinkTable;
    UnForming2VDeclarID: TIntegerField;
    UnForming2VDeclarIDH: TIntegerField;
    UnForming2VDeclarsDate: TDateField;
    UnForming2VDeclarShiftNum: TSmallintField;
    UnForming2VDeclarShiftNumName: TStringField;
    UnForming2VDeclarShift: TSmallintField;
    UnForming2VDeclarShiftName: TStringField;
    UnForming2VDeclarForeman: TIntegerField;
    UnForming2VDeclarForemanName: TStringField;
    UnForming2VDeclarQualityInspector: TIntegerField;
    UnForming2VDeclarQualityInspectorName: TStringField;
    UnForming2VDeclarProd: TIntegerField;
    UnForming2VDeclarProdName: TStringField;
    UnForming2VDeclarDensity: TSmallintField;
    UnForming2VDeclarCategory1: TFloatField;
    UnForming2VDeclarCategory2: TFloatField;
    UnForming2VDeclarConcreteStrength: TFloatField;
    UnForming2VDeclarCategory4: TFloatField;
    UnForming2VDeclarConcreteStrength4: TFloatField;
    UnForming2VDeclarReject: TFloatField;
    UnForming2VDeclarBreakage: TFloatField;
    UnForming2VC: TDBFormControl;
    Unforming2V1: TLinkMenuItem;
    UnForming3: TLinkSource;
    UnForming3Declar: TLinkTable;
    UnForming3DeclarsDate: TDateField;
    UnForming3DeclarForeman: TIntegerField;
    UnForming3DeclarQualityInspector: TIntegerField;
    UnForming3DeclarID: TAutoIncField;
    UnForming3DeclarShiftNum: TXEListField;
    UnForming3DeclarShift: TXEListField;
    UnForming3DeclarForemanName: TXELookField;
    UnForming3DeclarQualityInspectorName: TXELookField;
    Forming3T: TLinkSource;
    Forming3TDeclar: TLinkTable;
    Forming3TDeclarIDH: TIntegerField;
    Forming3TDeclarPressNum: TSmallintField;
    Forming3TDeclarProd: TIntegerField;
    Forming3TDeclarAmount: TFloatField;
    Forming3TDeclarID: TAutoIncField;
    Forming3TDeclarProdName: TXELookField;
    UnForming3C: TDBFormControl;
    N31: TMenuItem;
    UnForming31: TLinkMenuItem;
    ProdLookup5: TLinkTable;
    ProdLookup5Kod: TIntegerField;
    ProdLookup5Name: TStringField;
    ProdLookup5UnitMName: TStringField;
    ProdLookup5Massa: TFloatField;
    ProdLookup5Sizes: TStringField;
    Moving3T: TLinkSource;
    Moving3TDeclar: TLinkTable;
    Moving3TDeclarIDH: TIntegerField;
    Moving3TDeclarProdFrom: TIntegerField;
    Moving3TDeclarProdTo: TIntegerField;
    Moving3TDeclarAmount: TFloatField;
    Moving3TDeclarID: TAutoIncField;
    Moving3TDeclarProdFromName: TXELookField;
    Moving3TDeclarProdToName: TXELookField;
    UnForming3T: TLinkSource;
    UnForming3TDeclar: TLinkTable;
    UnForming3TDeclarIDH: TIntegerField;
    UnForming3TDeclarProd: TIntegerField;
    UnForming3TDeclarShift1: TFloatField;
    UnForming3TDeclarShift2: TFloatField;
    UnForming3TDeclarID: TAutoIncField;
    UnForming3TDeclarProdName: TXELookField;
    UnForming3TDeclarTotal: TFloatField;
    Forming3V: TLinkSource;
    Forming3VDeclar: TLinkTable;
    Forming3VDeclarIDH: TIntegerField;
    Forming3VDeclarsDate: TDateField;
    Forming3VDeclarShiftNum: TSmallintField;
    Forming3VDeclarShiftNumName: TStringField;
    Forming3VDeclarShift: TSmallintField;
    Forming3VDeclarShiftName: TStringField;
    Forming3VDeclarForeman: TIntegerField;
    Forming3VDeclarForemanName: TStringField;
    Forming3VDeclarProd: TIntegerField;
    Forming3VDeclarProdName: TStringField;
    Forming3VDeclarPress1: TFloatField;
    Forming3VDeclarPress2: TFloatField;
    Forming3VDeclarPress3: TFloatField;
    Forming3VDeclarPress4: TFloatField;
    Forming3VDeclarPress5: TFloatField;
    Forming3VDeclarPress6: TFloatField;
    Forming3VDeclarPress7: TFloatField;
    Forming3VDeclarPress8: TFloatField;
    Forming3VDeclarPress9: TFloatField;
    Forming3VDeclarPress10: TFloatField;
    Forming3VDeclarPress11: TFloatField;
    Forming3VDeclarPress12: TFloatField;
    Forming3VDeclarTotal: TFloatField;
    Forming3VC: TDBFormControl;
    Forming3V1: TLinkMenuItem;
    UnForming3V: TLinkSource;
    UnForming3VC: TDBFormControl;
    UnForming3VDeclar: TLinkTable;
    UnForming3VDeclarID: TIntegerField;
    UnForming3VDeclarsDate: TDateField;
    UnForming3VDeclarShiftNum: TSmallintField;
    UnForming3VDeclarShiftNumName: TStringField;
    UnForming3VDeclarShift: TSmallintField;
    UnForming3VDeclarShiftName: TStringField;
    UnForming3VDeclarForeman: TIntegerField;
    UnForming3VDeclarForemanName: TStringField;
    UnForming3VDeclarQualityInspector: TIntegerField;
    UnForming3VDeclarQualityInspectorName: TStringField;
    UnForming3VDeclarP1105: TFloatField;
    UnForming3VDeclarP1202: TFloatField;
    UnForming3VDeclarP1151: TFloatField;
    UnForming3VDeclarP1170: TFloatField;
    UnForming3VDeclarP1021: TFloatField;
    UnForming3VDeclarP1107: TFloatField;
    UnForming3VDeclarP1251: TFloatField;
    UnForming3VDeclarP1061: TFloatField;
    UnForming3VDeclarP1999: TFloatField;
    UnForming3VDeclarP1950: TFloatField;
    UnForming3VDeclarPTotal: TFloatField;
    UnForming3VDeclarP1105_1151: TFloatField;
    UnForming3VDeclarP1105_1950: TFloatField;
    UnForming3VDeclarP1105_1999: TFloatField;
    UnForming3VDeclarP1151_1999: TFloatField;
    UnForming3VDeclarP1251_1998: TFloatField;
    UnForming3VDeclarP1999_1105: TFloatField;
    UnForming3VDeclarP1999_1151: TFloatField;
    UnForming3VDeclarP1999_1950: TFloatField;
    UnForming3VDeclarT1105: TFloatField;
    UnForming3VDeclarT1151: TFloatField;
    UnForming3VDeclarT1251: TFloatField;
    UnForming3VDeclarT1999: TFloatField;
    UnForming3VDeclarT1950: TFloatField;
    UnForming3V1: TLinkMenuItem;
    ProdDeclarDensity: TSmallintField;
    ProdLookupShop: TSmallintField;
    ProdLookupDensity: TSmallintField;
    UnForming3VDeclarP1151_1105: TFloatField;
    UnForming3VDeclarT1170: TFloatField;
    UnForming3VDeclarP1998: TFloatField;
    UnForming3VDeclarT1202: TFloatField;
    UnForming3VDeclarT1021: TFloatField;
    UnForming3VDeclarT1107: TFloatField;
    UnForming3VDeclarT1998: TFloatField;
    UnForming3VDeclarP1170_1998: TFloatField;
    UnForming3VDeclarP1998_1170: TFloatField;
    UnForming3VDeclarP1998_1251: TFloatField;
    UnForming3VDeclarP1998_1950: TFloatField;
    UnForming3VDeclarT1061: TFloatField;
    UnForming3VDeclarP1151_1950: TFloatField;
    UnForming3VDeclarP1251_1170: TFloatField;
    ProdPlan1: TLinkSource;
    ProdPlan1Declar: TLinkTable;
    ProdPlan1DeclarsDate: TDateField;
    ProdPlan1DeclarAmount: TFloatField;
    ProdPlan1DeclarID: TAutoIncField;
    ProdPlan1C: TDBFormControl;
    ProdPlan1_1: TLinkMenuItem;
    ProdPlan2: TLinkSource;
    ProdPlan2Declar: TLinkTable;
    ProdPlan2DeclarsDate: TDateField;
    ProdPlan2DeclarAmount: TFloatField;
    ProdPlan2DeclarID: TAutoIncField;
    ProdPlan2C: TDBFormControl;
    ProdPlan2_1: TLinkMenuItem;
    ProdPlan3: TLinkSource;
    ProdPlan3Declar: TLinkTable;
    ProdPlan3DeclarsDate: TDateField;
    ProdPlan3DeclarAmount: TFloatField;
    ProdPlan3DeclarID: TAutoIncField;
    Plan3C: TDBFormControl;
    ProdPlan3_1: TLinkMenuItem;
    UnForming2VDeclarProd2: TIntegerField;
    UnForming2VDeclarProd2Name: TStringField;
    UnForming2VDeclarProd4: TIntegerField;
    UnForming2VDeclarProd4Name: TStringField;
    UnForming2VDeclarProd5: TIntegerField;
    UnForming2VDeclarProd5Name: TStringField;
    UnForming2VDeclarProd6: TIntegerField;
    UnForming2VDeclarProd6Name: TStringField;
    ProdShedule: TLinkSource;
    ProdPlanOld1: TLinkMenuItem;
    ProdSheduleDeclar: TLinkTable;
    ProdSheduleDeclarID: TIntegerField;
    ProdSheduleDeclarsDate: TDateField;
    ProdSheduleDeclarAmountPlan1: TFloatField;
    ProdSheduleDeclarAmountPlanCum1: TFloatField;
    ProdSheduleDeclarAmountFact1: TFloatField;
    ProdSheduleDeclarAmountFactCum1: TFloatField;
    ProdSheduleDeclarSumPlan1: TFloatField;
    ProdSheduleDeclarSumPlanCum1: TFloatField;
    ProdSheduleDeclarSumFact1: TFloatField;
    ProdSheduleDeclarSumFactCum1: TFloatField;
    ProdSheduleDeclarAmountPlan2: TFloatField;
    ProdSheduleDeclarAmountPlanCum2: TFloatField;
    ProdSheduleDeclarAmountFact2: TFloatField;
    ProdSheduleDeclarAmountFactCum2: TFloatField;
    ProdSheduleDeclarSumPlan2: TFloatField;
    ProdSheduleDeclarSumPlanCum2: TFloatField;
    ProdSheduleDeclarSumFact2: TFloatField;
    ProdSheduleDeclarSumFactCum2: TFloatField;
    ProdSheduleDeclarAmountPlan3: TFloatField;
    ProdSheduleDeclarAmountPlanCum3: TFloatField;
    ProdSheduleDeclarAmountFact3: TFloatField;
    ProdSheduleDeclarAmountFactCum3: TFloatField;
    ProdSheduleDeclarSumPlan3: TFloatField;
    ProdSheduleDeclarSumPlanCum3: TFloatField;
    ProdSheduleDeclarSumFact3: TFloatField;
    ProdSheduleDeclarSumFactCum3: TFloatField;
    ProdSheduleC: TDBFormControl;
    ProdShedule1: TLinkMenuItem;
    ProdPriceAvgKoef: TLinkSource;
    ProdPriceAvgKoefDeclar: TLinkTable;
    ProdPriceAvgKoefDeclarID: TAutoIncField;
    ProdPriceAvgKoefDeclarPeriod: TDateField;
    ProdPriceAvgKoefDeclarShop: TSmallintField;
    ProdPriceAvgKoefDeclarProd: TIntegerField;
    ProdPriceAvgKoefDeclarTare1: TSmallintField;
    ProdPriceAvgKoefDeclarKTare1: TFloatField;
    ProdPriceAvgKoefDeclarTare2: TSmallintField;
    ProdPriceAvgKoefDeclarKTare2: TFloatField;
    ProdPriceAvgKoefDeclarProdName: TXELookField;
    ProdPriceAvgKoefDeclarTare1Name: TXELookField;
    ProdPriceAvgKoefDeclarTare2Name: TXELookField;
    ProdPriceAvgKoefDeclarShopName: TXELookField;
    ProdPriceAvgKoefC: TDBFormControl;
    ProdPriceAvgKoef1: TLinkMenuItem;
    ProdSheduleDeclarAmountFact1_3: TFloatField;
    ProdSheduleDeclarAmountFact1_4: TFloatField;
    ProdSheduleDeclarPrice1_3: TFloatField;
    ProdSheduleDeclarPrice1_4: TFloatField;
    ProdSheduleDeclarSumFact1_3: TFloatField;
    ProdSheduleDeclarSumFact1_4: TFloatField;
    ProdSheduleDeclarAmountFact2_1: TFloatField;
    ProdSheduleDeclarAmountFact2_2: TFloatField;
    ProdSheduleDeclarAmountFact2_4: TFloatField;
    ProdSheduleDeclarAmountFact2_5: TFloatField;
    ProdSheduleDeclarAmountFact2_6: TFloatField;
    ProdSheduleDeclarPrice2_1: TFloatField;
    ProdSheduleDeclarPrice2_2: TFloatField;
    ProdSheduleDeclarPrice2_4: TFloatField;
    ProdSheduleDeclarSumFact2_1: TFloatField;
    ProdSheduleDeclarSumFact2_2: TFloatField;
    ProdSheduleDeclarSumFact2_4: TFloatField;
    ProdSheduleDeclarAmountFact3_1: TFloatField;
    ProdSheduleDeclarAmountFact3_4: TFloatField;
    ProdSheduleDeclarAmountFact3_s: TFloatField;
    ProdSheduleDeclarAmountFact3_5: TFloatField;
    ProdSheduleDeclarPrice3_1: TFloatField;
    ProdSheduleDeclarPrice3_4: TFloatField;
    ProdSheduleDeclarSumFact3_1: TFloatField;
    ProdSheduleDeclarSumFact3_4: TFloatField;
    ProdSheduleDeclarSumFactCum: TFloatField;
    UnForming5: TLinkSource;
    UnForming5Declar: TLinkTable;
    UnForming5DeclarID: TAutoIncField;
    UnForming5DeclarsDate: TDateField;
    UnForming5DeclarForeman: TIntegerField;
    UnForming5DeclarQualityInspector: TIntegerField;
    UnForming5DeclarAdjuster: TIntegerField;
    UnForming5DeclarsUser: TStringField;
    UnForming5DeclarsTime: TDateTimeField;
    UnForming5DeclarShift: TXEListField;
    UnForming5DeclarForemanName: TXELookField;
    UnForming5DeclarQualityInspectorName: TXELookField;
    UnForming5DeclarShiftNum: TXEListField;
    UnForming5DeclarAdjusterName: TXELookField;
    UnForming5C: TDBFormControl;
    N51: TMenuItem;
    UnForming51: TLinkMenuItem;
    UnForming5T: TLinkSource;
    UnForming5TDeclar: TLinkTable;
    UnForming5TDeclarID: TAutoIncField;
    UnForming5TDeclarIDH: TIntegerField;
    UnForming5TDeclarLimeKiln: TSmallintField;
    UnForming5TDeclarProd: TIntegerField;
    UnForming5TDeclarAmount: TFloatField;
    UnForming5TDeclarTimeOut: TFloatField;
    UnForming5TDeclarTimeWork: TFloatField;
    UnForming5TDeclarTimeOutCause: TStringField;
    UnForming5TDeclarProdName: TXELookField;
    ProdLookup6: TLinkTable;
    ProdLookup6Kod: TIntegerField;
    ProdLookup6Name: TStringField;
    ProdLookup6UnitMName: TStringField;
    ProdLookup6Massa: TFloatField;
    UnForming5V: TLinkSource;
    UnForming5VDeclar: TLinkTable;
    UnForming5VDeclarID: TIntegerField;
    UnForming5VDeclarIDH: TIntegerField;
    UnForming5VDeclarsDate: TDateField;
    UnForming5VDeclarShiftNum: TSmallintField;
    UnForming5VDeclarShiftNumName: TStringField;
    UnForming5VDeclarShift: TSmallintField;
    UnForming5VDeclarShiftName: TStringField;
    UnForming5VDeclarForeman: TIntegerField;
    UnForming5VDeclarForemanName: TStringField;
    UnForming5VDeclarQualityInspector: TIntegerField;
    UnForming5VDeclarQualityInspectorName: TStringField;
    UnForming5VDeclarAdjuster: TIntegerField;
    UnForming5VDeclarAdjusterName: TStringField;
    UnForming5VDeclarLimeKiln: TSmallintField;
    UnForming5VDeclarProd: TIntegerField;
    UnForming5VDeclarProdName: TStringField;
    UnForming5VDeclarAmount: TFloatField;
    UnForming5VDeclarTimeOut: TFloatField;
    UnForming5VDeclarTimeWork: TFloatField;
    UnForming5VDeclarTimeOutCause: TStringField;
    UnForming5VC: TDBFormControl;
    UnForming5V1: TLinkMenuItem;
    ProdPlan5: TLinkSource;
    ProdPlan5Declar: TLinkTable;
    ProdPlan5DeclarID: TAutoIncField;
    ProdPlan5DeclarsDate: TDateField;
    ProdPlan5DeclarAmount: TFloatField;
    ProdPlan5C: TDBFormControl;
    ProdPlan51: TLinkMenuItem;
    ProdSheduleDeclarAmountDevCum1: TFloatField;
    ProdSheduleDeclarSumDevCum1: TFloatField;
    ProdSheduleDeclarAmountDevCum2: TFloatField;
    ProdSheduleDeclarSumDevCum2: TFloatField;
    ProdSheduleDeclarAmountDevCum3: TFloatField;
    ProdSheduleDeclarSumDevCum3: TFloatField;
    ProdSheduleDeclarSumPlanCum: TFloatField;
    ProdSheduleDeclarSumDevCum: TFloatField;
    ProdSheduleDeclarAmountFact1_s: TFloatField;
    ProdSheduleDeclarAmountFact1_s3: TFloatField;
    ProdSheduleDeclarAmountFact1_35: TFloatField;
    ProdGroupReport: TLinkSource;
    ProdGroupReportDeclar: TLinkTable;
    ProdGroupReportDeclarID: TIntegerField;
    ProdGroupReportDeclarProd: TIntegerField;
    ProdGroupReportDeclarProdName: TStringField;
    ProdGroupReportDeclarDensity: TSmallintField;
    ProdGroupReportDeclarConcreteStrength: TFloatField;
    ProdGroupReportDeclarLine: TSmallintField;
    ProdGroupReportDeclarUnitM: TSmallintField;
    ProdGroupReportDeclarUnitMName: TStringField;
    ProdGroupReportDeclarAmount: TFloatField;
    ProdGroupReportC: TDBFormControl;
    ProdGroupReport1: TLinkMenuItem;
    ProdLookupUnitMName1: TStringField;
    Forming2S: TLinkSource;
    Forming2SDeclar: TLinkTable;
    Forming2SC: TDBFormControl;
    Forming2S1: TLinkMenuItem;
    Forming2SDeclarsDate: TDateField;
    Forming2SDeclarAmount: TFloatField;
    Forming2SDeclarsUser: TStringField;
    Forming2SDeclarsTime: TDateTimeField;
    Forming2SDeclarID: TAutoIncField;
    Forming2SDeclarShiftNum: TXEListField;
    Forming2SDeclarShift: TXEListField;
    Forming2SDeclarForeman: TIntegerField;
    Forming2SDeclarForemanName: TXELookField;
    Forming2SDeclarProd: TIntegerField;
    Forming2SDeclarProdName: TXELookField;
    Forming1S: TLinkSource;
    Forming1SDeclar: TLinkTable;
    Forming1SDeclarsDate: TDateField;
    Forming1SDeclarForeman: TIntegerField;
    Forming1SDeclarForemanChief: TIntegerField;
    Forming1SDeclarProd: TIntegerField;
    Forming1SDeclarAmount: TFloatField;
    Forming1SDeclarsUser: TStringField;
    Forming1SDeclarsTime: TDateTimeField;
    Forming1SDeclarID: TAutoIncField;
    Forming1SDeclarShift: TXEListField;
    Forming1SDeclarShiftForemanName: TXELookField;
    Forming1SDeclarForemanChiefName: TXELookField;
    Forming1SDeclarLine: TXEListField;
    Forming1SC: TDBFormControl;
    Forming1S1: TLinkMenuItem;
    Forming1SDeclarProdName: TXELookField;
    Forming1SDeclarConcreteStrength: TFloatField;
    UnForming3VDeclarP1251_1950: TFloatField;
    UnForming3VDeclarTTotal: TFloatField;
    UnForming1VDeclarAmountTotal: TFloatField;
    Forming1SReport: TLinkSource;
    Forming1SReportDeclar: TLinkTable;
    Forming1SReportDeclarDateBeg: TDateField;
    Forming1SReportDeclarDateEnd: TDateField;
    Forming1SReportDeclarForeman: TIntegerField;
    Forming1SReportDeclarForemanName: TStringField;
    Forming1SReportDeclarLine: TSmallintField;
    Forming1SReportDeclarD400: TFloatField;
    Forming1SReportDeclarD500: TFloatField;
    Forming1SReportDeclarD600: TFloatField;
    Forming1SReportDeclarD700: TFloatField;
    Forming1SReportDeclarD450: TFloatField;
    Forming1SReportDeclarWD600: TFloatField;
    Forming1SReportDeclarTotalBlocks: TFloatField;
    Forming1SReportDeclarSD250: TFloatField;
    Forming1SReportDeclarSD300: TFloatField;
    Forming1SReportDeclarSD350: TFloatField;
    Forming1SReportDeclarSD400: TFloatField;
    Forming1SReportDeclarSDTotal: TFloatField;
    Forming1SReportDeclarTotal: TFloatField;
    Forming1SReportDeclarID: TAutoIncField;
    Forming1SReportC: TDBFormControl;
    Forming1SReport1: TLinkMenuItem;
    Forming1SReportDeclarD600H100: TFloatField;
    UnForming1Report: TLinkSource;
    UnForming1ReportDeclar: TLinkTable;
    UnForming1ReportDeclarID: TIntegerField;
    UnForming1ReportDeclarDateBeg: TDateField;
    UnForming1ReportDeclarDateEnd: TDateField;
    UnForming1ReportDeclarForeman: TIntegerField;
    UnForming1ReportDeclarForemanName: TStringField;
    UnForming1ReportDeclarD400_2: TFloatField;
    UnForming1ReportDeclarD400S_2: TFloatField;
    UnForming1ReportDeclarD400_4: TFloatField;
    UnForming1ReportDeclarD400S_4: TFloatField;
    UnForming1ReportDeclarD400FromS: TFloatField;
    UnForming1ReportDeclarD400OutB: TFloatField;
    UnForming1ReportDeclarD500_2: TFloatField;
    UnForming1ReportDeclarD500S_2: TFloatField;
    UnForming1ReportDeclarD500_4: TFloatField;
    UnForming1ReportDeclarD500S_4: TFloatField;
    UnForming1ReportDeclarD500FromS: TFloatField;
    UnForming1ReportDeclarD500OutB: TFloatField;
    UnForming1ReportDeclarD600_2: TFloatField;
    UnForming1ReportDeclarD600S_2: TFloatField;
    UnForming1ReportDeclarD600_4: TFloatField;
    UnForming1ReportDeclarD600S_4: TFloatField;
    UnForming1ReportDeclarD600FromS: TFloatField;
    UnForming1ReportDeclarD600OutB: TFloatField;
    UnForming1ReportDeclarD600H100_2: TFloatField;
    UnForming1ReportDeclarD600H100S_2: TFloatField;
    UnForming1ReportDeclarD600H100_4: TFloatField;
    UnForming1ReportDeclarD600H100S_4: TFloatField;
    UnForming1ReportDeclarD600H100FromS: TFloatField;
    UnForming1ReportDeclarD700_2: TFloatField;
    UnForming1ReportDeclarD700S_2: TFloatField;
    UnForming1ReportDeclarD700_4: TFloatField;
    UnForming1ReportDeclarD700S_4: TFloatField;
    UnForming1ReportDeclarD700FromS: TFloatField;
    UnForming1ReportDeclarD700OutB: TFloatField;
    UnForming1ReportDeclarD450_2: TFloatField;
    UnForming1ReportDeclarD450S_2: TFloatField;
    UnForming1ReportDeclarD450_4: TFloatField;
    UnForming1ReportDeclarD450S_4: TFloatField;
    UnForming1ReportDeclarD450FromS: TFloatField;
    UnForming1ReportDeclarWD600: TFloatField;
    UnForming1ReportDeclarWD600S: TFloatField;
    UnForming1ReportDeclarWD600FromS: TFloatField;
    UnForming1ReportDeclarTotalBlocks: TFloatField;
    UnForming1ReportDeclarTotalBlocksS: TFloatField;
    UnForming1ReportDeclarTotalBlocksFromS: TFloatField;
    UnForming1ReportDeclarTotalBlocksOutB: TFloatField;
    UnForming1ReportDeclarSD250: TFloatField;
    UnForming1ReportDeclarSD250S: TFloatField;
    UnForming1ReportDeclarSD300: TFloatField;
    UnForming1ReportDeclarSD300S: TFloatField;
    UnForming1ReportDeclarSD350: TFloatField;
    UnForming1ReportDeclarSD350S: TFloatField;
    UnForming1ReportDeclarSD350FromS: TFloatField;
    UnForming1ReportDeclarSD400: TFloatField;
    UnForming1ReportDeclarSD400S: TFloatField;
    UnForming1ReportDeclarSDTotal: TFloatField;
    UnForming1ReportDeclarSDTotalS: TFloatField;
    UnForming1ReportDeclarSDtotalFromS: TFloatField;
    UnForming1ReportDeclarTotal: TFloatField;
    UnForming1ReportDeclarTotalS: TFloatField;
    UnForming1ReportDeclarTotalFromS: TFloatField;
    UnForming1ReportDeclarTotalAll: TFloatField;
    UnForming1ReportC: TDBFormControl;
    UnForming1Report1: TLinkMenuItem;
    UnForming1ReportDeclarD400: TFloatField;
    UnForming1ReportDeclarD400S: TFloatField;
    UnForming1ReportDeclarD400T: TFloatField;
    UnForming1ReportDeclarD500: TFloatField;
    UnForming1ReportDeclarD500S: TFloatField;
    UnForming1ReportDeclarD500T: TFloatField;
    UnForming1ReportDeclarD600: TFloatField;
    UnForming1ReportDeclarD600S: TFloatField;
    UnForming1ReportDeclarD600T: TFloatField;
    UnForming1ReportDeclarD600H100: TFloatField;
    UnForming1ReportDeclarD600H100S: TFloatField;
    UnForming1ReportDeclarD600H100T: TFloatField;
    UnForming1ReportDeclarD700: TFloatField;
    UnForming1ReportDeclarD700S: TFloatField;
    UnForming1ReportDeclarD700T: TFloatField;
    UnForming1ReportDeclarD450: TFloatField;
    UnForming1ReportDeclarD450S: TFloatField;
    UnForming1ReportDeclarD450T: TFloatField;
    UnForming1ReportDeclarWD600T: TFloatField;
    UnForming1ReportDeclarTotalBlocksT: TFloatField;
    UnForming1ReportDeclarSD250T: TFloatField;
    UnForming1ReportDeclarSD300T: TFloatField;
    UnForming1ReportDeclarSD350T: TFloatField;
    UnForming1ReportDeclarSD400T: TFloatField;
    UnForming1ReportDeclarSDTotalT: TFloatField;
    UnForming1ReportDeclarTotalLine2: TFloatField;
    UnForming1ReportDeclarTotalLine2S: TFloatField;
    UnForming1ReportDeclarTotalLine2T: TFloatField;
    UnForming1ReportDeclarTotalLine4: TFloatField;
    UnForming1ReportDeclarTotalLine4S: TFloatField;
    UnForming1ReportDeclarTotalLine4T: TFloatField;
    UnForming1ReportDeclarTare: TSmallintField;
    UnForming1ReportDeclarTareName: TStringField;
    UnForming3VDeclarP1105_1107: TFloatField;
    UnForming3VDeclarP1105_1021: TFloatField;
    ProdPlan1DeclarAmountReal: TFloatField;
    ProdPlan2DeclarAmountReal: TFloatField;
    ProdPlan3DeclarAmountReal: TFloatField;
    ProdPlan5DeclarAmountReal: TFloatField;
    UnForming3VDeclarP1107_1999: TFloatField;
    UnForming3VDeclarHollowBrickTotal: TFloatField;
    UnForming3VDeclarSolidBrickTotal: TFloatField;
    ICProdLimeProtocols: TLinkSource;
    ICProdLimeProtocolsDeclar: TLinkTable;
    ICProdLimeProtocolsDeclarID: TIntegerField;
    ICProdLimeProtocolsDeclarsDate: TDateField;
    ICProdLimeProtocolsDeclarDateTimeChange: TDateTimeField;
    ICProdLimeProtocolsDeclarsDateTime: TDateTimeField;
    ICProdLimeProtocolsC: TDBFormControl;
    IC1: TMenuItem;
    ICProdLimeProtocols1: TLinkMenuItem;
    ICProdLime: TLinkSource;
    ICProdLimeDeclar: TLinkTable;
    ICProdLimeDeclarID: TIntegerField;
    ICProdLimeDeclarsDateTime: TDateTimeField;
    ICProdLimeDeclarInstantProductivity: TFloatField;
    ICProdLimeC: TDBFormControl;
    ICProdLime1: TLinkMenuItem;
    ICProdLimeHour2: TLinkSource;
    ICProdLimeHour2Declar: TLinkTable;
    ICProdLimeHour2DeclarID: TIntegerField;
    ICProdLimeHour2DeclarsDate: TDateField;
    ICProdLimeHour2DeclarHL1: TFloatField;
    ICProdLimeHour2DeclarHL2: TFloatField;
    ICProdLimeHour2DeclarHL3: TFloatField;
    ICProdLimeHour2DeclarHL4: TFloatField;
    ICProdLimeHour2DeclarHL5: TFloatField;
    ICProdLimeHour2DeclarHL6: TFloatField;
    ICProdLimeHour2DeclarHL7: TFloatField;
    ICProdLimeHour2DeclarHL8: TFloatField;
    ICProdLimeHour2DeclarHL9: TFloatField;
    ICProdLimeHour2DeclarHL10: TFloatField;
    ICProdLimeHour2DeclarHL11: TFloatField;
    ICProdLimeHour2DeclarHL12: TFloatField;
    ICProdLimeHour2DeclarHL13: TFloatField;
    ICProdLimeHour2DeclarHL14: TFloatField;
    ICProdLimeHour2DeclarHL15: TFloatField;
    ICProdLimeHour2DeclarHL16: TFloatField;
    ICProdLimeHour2DeclarHL17: TFloatField;
    ICProdLimeHour2DeclarHL18: TFloatField;
    ICProdLimeHour2DeclarHL19: TFloatField;
    ICProdLimeHour2DeclarHL20: TFloatField;
    ICProdLimeHour2DeclarHL21: TFloatField;
    ICProdLimeHour2DeclarHL22: TFloatField;
    ICProdLimeHour2DeclarHL23: TFloatField;
    ICProdLimeHour2DeclarLimeTotal: TFloatField;
    ICProdLimeHour2C: TDBFormControl;
    ICProdLimeHour21: TLinkMenuItem;
    ICProdLimeHour2DeclarHL24: TFloatField;
    ICProdLimeUpdate1: TMenuItem;
    ICGasForLime: TLinkSource;
    ICGasForLimeDeclar: TLinkTable;
    ICGasForLimeDeclarID: TIntegerField;
    ICGasForLimeDeclarsDateTime: TDateTimeField;
    ICGasForLimeC: TDBFormControl;
    ICGasForLime1: TLinkMenuItem;
    ICProdLimeHour2DeclarHG1: TIntegerField;
    ICProdLimeHour2DeclarRGF1: TFloatField;
    ICProdLimeHour2DeclarHG2: TIntegerField;
    ICProdLimeHour2DeclarRGF2: TFloatField;
    ICProdLimeHour2DeclarHG3: TIntegerField;
    ICProdLimeHour2DeclarRGF3: TFloatField;
    ICProdLimeHour2DeclarHG4: TIntegerField;
    ICProdLimeHour2DeclarRGF4: TFloatField;
    ICProdLimeHour2DeclarHG5: TIntegerField;
    ICProdLimeHour2DeclarRGF5: TFloatField;
    ICProdLimeHour2DeclarHG6: TIntegerField;
    ICProdLimeHour2DeclarRGF6: TFloatField;
    ICProdLimeHour2DeclarHG7: TIntegerField;
    ICProdLimeHour2DeclarRGF7: TFloatField;
    ICProdLimeHour2DeclarHG8: TIntegerField;
    ICProdLimeHour2DeclarRGF8: TFloatField;
    ICProdLimeHour2DeclarHG9: TIntegerField;
    ICProdLimeHour2DeclarRGF9: TFloatField;
    ICProdLimeHour2DeclarHG10: TIntegerField;
    ICProdLimeHour2DeclarRGF10: TFloatField;
    ICProdLimeHour2DeclarHG11: TIntegerField;
    ICProdLimeHour2DeclarRGF11: TFloatField;
    ICProdLimeHour2DeclarHG12: TIntegerField;
    ICProdLimeHour2DeclarRGF12: TFloatField;
    ICProdLimeHour2DeclarHG13: TIntegerField;
    ICProdLimeHour2DeclarRGF13: TFloatField;
    ICProdLimeHour2DeclarHG14: TIntegerField;
    ICProdLimeHour2DeclarRGF14: TFloatField;
    ICProdLimeHour2DeclarHG15: TIntegerField;
    ICProdLimeHour2DeclarRGF15: TFloatField;
    ICProdLimeHour2DeclarHG16: TIntegerField;
    ICProdLimeHour2DeclarRGF16: TFloatField;
    ICProdLimeHour2DeclarHG17: TIntegerField;
    ICProdLimeHour2DeclarRGF17: TFloatField;
    ICProdLimeHour2DeclarHG18: TIntegerField;
    ICProdLimeHour2DeclarRGF18: TFloatField;
    ICProdLimeHour2DeclarHG19: TIntegerField;
    ICProdLimeHour2DeclarRGF19: TFloatField;
    ICProdLimeHour2DeclarHG20: TIntegerField;
    ICProdLimeHour2DeclarRGF20: TFloatField;
    ICProdLimeHour2DeclarHG21: TIntegerField;
    ICProdLimeHour2DeclarRGF21: TFloatField;
    ICProdLimeHour2DeclarHG22: TIntegerField;
    ICProdLimeHour2DeclarRGF22: TFloatField;
    ICProdLimeHour2DeclarHG23: TIntegerField;
    ICProdLimeHour2DeclarRGF23: TFloatField;
    ICProdLimeHour2DeclarHG24: TIntegerField;
    ICProdLimeHour2DeclarRGF24: TFloatField;
    ICProdLimeHour2DeclarGasTotal: TIntegerField;
    ICProdLimeHour2DeclarRGFTotal: TFloatField;
    ICProdLimeDeclarCounterProdCum: TFloatField;
    ICProdLimeParameters: TLinkSource;
    ICProdLimeParametersDeclar: TLinkTable;
    ICProdLimeParametersDeclarsDateTime: TDateTimeField;
    ICProdLimeParametersDeclarActivity: TFloatField;
    ICProdLimeParametersDeclarHumidity: TFloatField;
    ICProdLimeParametersDeclarID: TAutoIncField;
    ICProdLimeParametersC: TDBFormControl;
    ICProdLimeParameters1: TLinkMenuItem;
    ICProdLimeHour2DeclarAct1: TFloatField;
    ICProdLimeHour2DeclarHum1: TFloatField;
    ICProdLimeHour2DeclarAct2: TFloatField;
    ICProdLimeHour2DeclarHum2: TFloatField;
    ICProdLimeHour2DeclarAct3: TFloatField;
    ICProdLimeHour2DeclarHum3: TFloatField;
    ICProdLimeHour2DeclarAct4: TFloatField;
    ICProdLimeHour2DeclarHum4: TFloatField;
    ICProdLimeHour2DeclarAct5: TFloatField;
    ICProdLimeHour2DeclarHum5: TFloatField;
    ICProdLimeHour2DeclarAct6: TFloatField;
    ICProdLimeHour2DeclarHum6: TFloatField;
    ICProdLimeHour2DeclarAct7: TFloatField;
    ICProdLimeHour2DeclarHum7: TFloatField;
    ICProdLimeHour2DeclarAct8: TFloatField;
    ICProdLimeHour2DeclarHum8: TFloatField;
    ICProdLimeHour2DeclarAct9: TFloatField;
    ICProdLimeHour2DeclarHum9: TFloatField;
    ICProdLimeHour2DeclarAct10: TFloatField;
    ICProdLimeHour2DeclarHum10: TFloatField;
    ICProdLimeHour2DeclarAct11: TFloatField;
    ICProdLimeHour2DeclarHum11: TFloatField;
    ICProdLimeHour2DeclarAct12: TFloatField;
    ICProdLimeHour2DeclarHum12: TFloatField;
    ICProdLimeHour2DeclarAct13: TFloatField;
    ICProdLimeHour2DeclarHum13: TFloatField;
    ICProdLimeHour2DeclarAct14: TFloatField;
    ICProdLimeHour2DeclarHum14: TFloatField;
    ICProdLimeHour2DeclarAct15: TFloatField;
    ICProdLimeHour2DeclarHum15: TFloatField;
    ICProdLimeHour2DeclarAct16: TFloatField;
    ICProdLimeHour2DeclarHum16: TFloatField;
    ICProdLimeHour2DeclarAct17: TFloatField;
    ICProdLimeHour2DeclarHum17: TFloatField;
    ICProdLimeHour2DeclarAct18: TFloatField;
    ICProdLimeHour2DeclarHum18: TFloatField;
    ICProdLimeHour2DeclarAct19: TFloatField;
    ICProdLimeHour2DeclarHum19: TFloatField;
    ICProdLimeHour2DeclarAct20: TFloatField;
    ICProdLimeHour2DeclarHum20: TFloatField;
    ICProdLimeHour2DeclarAct21: TFloatField;
    ICProdLimeHour2DeclarHum21: TFloatField;
    ICProdLimeHour2DeclarAct22: TFloatField;
    ICProdLimeHour2DeclarHum22: TFloatField;
    ICProdLimeHour2DeclarAct23: TFloatField;
    ICProdLimeHour2DeclarHum23: TFloatField;
    ICProdLimeHour2DeclarAct24: TFloatField;
    ICProdLimeHour2DeclarHum24: TFloatField;
    ICProdLimeHour2DeclarLimeAvg: TFloatField;
    ICProdLimeHour2DeclarLimeTotalHour: TIntegerField;
    UnForming3VDeclarP1107_1105: TFloatField;
    ICCogenerationPlant: TLinkSource;
    ICCogenerationPlantDeclar: TLinkTable;
    ICCogenerationPlantDeclarID: TAutoIncField;
    ICCogenerationPlantDeclarsDateTime: TDateTimeField;
    ICCogenerationPlantDeclarGasFlow: TIntegerField;
    ICCogenerationPlantDeclarState: TXEListField;
    ICCogenerationPlantC: TDBFormControl;
    ICCogenerationPlant1: TLinkMenuItem;
    ICTimeShedule5: TLinkSource;
    ICTimeShedule5Declar: TLinkTable;
    ICTimeShedule5DeclarID: TAutoIncField;
    ICTimeShedule5DeclarsDate: TDateField;
    ICTimeShedule5DeclarShiftNum: TXEListField;
    ICTimeShedule5DeclarShift: TXEListField;
    ICTimeShedule5DeclarForeman: TIntegerField;
    ICTimeShedule5DeclarForemanName: TXELookField;
    ICTimeShedule5C: TDBFormControl;
    ICTimeShedule5_1: TLinkMenuItem;
    ICProdLimeHour2DeclarForemanNight: TIntegerField;
    ICProdLimeHour2DeclarForemanNameNight: TStringField;
    ICProdLimeHour2DeclarLimeTotalNight: TFloatField;
    ICProdLimeHour2DeclarLimeTotalAvgNight: TFloatField;
    ICProdLimeHour2DeclarGasTotalNight: TIntegerField;
    ICProdLimeHour2DeclarRGFTotalNight: TFloatField;
    ICProdLimeHour2DeclarLimeTotalHourNight: TIntegerField;
    ICProdLimeHour2DeclarForemanDay: TIntegerField;
    ICProdLimeHour2DeclarForemanNameDay: TStringField;
    ICProdLimeHour2DeclarLimeTotalDay: TFloatField;
    ICProdLimeHour2DeclarLimeTotalAvgDay: TFloatField;
    ICProdLimeHour2DeclarGasTotalDay: TIntegerField;
    ICProdLimeHour2DeclarRGFTotalDay: TFloatField;
    ICProdLimeHour2DeclarLimeTotalHourDay: TIntegerField;
    ICProdLimeHour2DeclarShiftNumNight: TXEListField;
    ICProdLimeHour2DeclarShiftNumDay: TXEListField;
    ICProdLimeHour2DeclarActAvgNight: TFloatField;
    ICProdLimeHour2DeclarActAvgDay: TFloatField;
    ICProdLimeHour2DeclarActAvg: TFloatField;
    UnForming3VDeclarP1109: TFloatField;
    UnForming3VDeclarP1999_1109: TFloatField;
    UnForming3VDeclarT1109: TFloatField;
    ProdSheduleReal: TLinkSource;
    ProdSheduleRealDeclar: TLinkTable;
    ProdSheduleRealDeclarID: TIntegerField;
    ProdSheduleRealDeclarsDate: TDateField;
    ProdSheduleRealDeclarAmountPlanReal1: TFloatField;
    ProdSheduleRealDeclarAmountPlanRealCum1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1: TFloatField;
    ProdSheduleRealDeclarSumFactReal1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_CrushIns: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_CrusIns: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_5: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t1: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t4: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t5: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t6: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t6: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t13: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t13: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t35: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t35: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t36: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t36: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D400: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D400: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D450: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D450: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D500: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D500: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D600: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D600: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D700: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D700: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_Lintels: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_Lintels: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D350: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D350: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_D250: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_D250: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_Auto: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_Auto: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_Rail: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_Rail: TFloatField;
    ProdSheduleRealDeclarAmountFactRealCum1: TFloatField;
    ProdSheduleRealDeclarAmountDevRealCum1: TFloatField;
    ProdSheduleRealDeclarPrice1_3: TFloatField;
    ProdSheduleRealDeclarSumPlanReal1: TFloatField;
    ProdSheduleRealDeclarSumPlanRealCum1: TFloatField;
    ProdSheduleRealDeclarSumFactRealCum1: TFloatField;
    ProdSheduleRealDeclarSumDevRealCum1: TFloatField;
    ProdSheduleRealDeclarAmountPlanReal2: TFloatField;
    ProdSheduleRealDeclarAmountPlanRealCum2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_5: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t6: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t6: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t26: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t26: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t28: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t28: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t29: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t29: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t31: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t31: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t32: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t32: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D400_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D400_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D400_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D400_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D400_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D400_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D400: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D400: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D500_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D500_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D500_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D500_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D500_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D500_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D500: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D500: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D600_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D600_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D600_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D600_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D600_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D600_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D600: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D600: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D700_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D700_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D700_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D700_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D700: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D700: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D350_1: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D350_1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D350_2: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D350_2: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D350: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D350: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_Auto: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_Auto: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_Rail: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_Rail: TFloatField;
    ProdSheduleRealDeclarAmountFactRealCum2: TFloatField;
    ProdSheduleRealDeclarAmountDevRealCum2: TFloatField;
    ProdSheduleRealDeclarPrice2_1: TFloatField;
    ProdSheduleRealDeclarSumPlanReal2: TFloatField;
    ProdSheduleRealDeclarSumPlanRealCum2: TFloatField;
    ProdSheduleRealDeclarSumFactRealCum2: TFloatField;
    ProdSheduleRealDeclarSumDevRealCum2: TFloatField;
    ProdSheduleRealDeclarAmountPlanReal3: TFloatField;
    ProdSheduleRealDeclarAmountPlanRealCum3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3: TFloatField;
    ProdSheduleRealDeclarSumFactReal3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_4: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_35002: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_35002: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t1: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t1: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t3: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t19: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t19: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t24: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t24: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t34: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t34: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1021: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1021: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1105: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1105: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1106: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1106: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1107: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1107: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1109: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1109: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1126: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1126: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1151: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1151: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1170: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1170: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1202: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1202: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1251: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1251: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1252: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1252: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_Auto: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_Auto: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_Rail: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_Rail: TFloatField;
    ProdSheduleRealDeclarAmountFactRealCum3: TFloatField;
    ProdSheduleRealDeclarAmountDevRealCum3: TFloatField;
    ProdSheduleRealDeclarPrice3_1: TFloatField;
    ProdSheduleRealDeclarSumPlanReal3: TFloatField;
    ProdSheduleRealDeclarSumPlanRealCum3: TFloatField;
    ProdSheduleRealDeclarSumFactRealCum3: TFloatField;
    ProdSheduleRealDeclarSumDevRealCum3: TFloatField;
    ProdSheduleRealDeclarSumPlanRealCum: TFloatField;
    ProdSheduleRealDeclarSumFactRealCum: TFloatField;
    ProdSheduleRealDeclarSumDevRealCum: TFloatField;
    ProdSheduleRealC: TDBFormControl;
    ProdSheduleReal1: TLinkMenuItem;
    ProdSheduleRealDeclarAmountFactReal1_GRB: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_GRB: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_GShops: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_GShops: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_GExport: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_GExport: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_GRB: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_GRB: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_GShops: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_GShops: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_GExport: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_GExport: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_GRB: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_GRB: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_GShops: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_GShops: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_GExport: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_GExport: TFloatField;
    ProdSheduleRealDeclarAmountPlanReal5: TFloatField;
    ProdSheduleRealDeclarAmountPlanRealCum5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5: TFloatField;
    ProdSheduleRealDeclarSumFactReal5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_t8: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_t8: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_30003: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_30003: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_30004: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_30004: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_34100: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_34100: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_35100: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_35100: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_Auto: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_Auto: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_Rail: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_Rail: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_GRB: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_GRB: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_GShops: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_GShops: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_GExport: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_GExport: TFloatField;
    ProdSheduleRealDeclarAmountFactRealCum5: TFloatField;
    ProdSheduleRealDeclarAmountDevRealCum5: TFloatField;
    ProdSheduleRealDeclarPrice5_1: TFloatField;
    ProdSheduleRealDeclarSumPlanReal5: TFloatField;
    ProdSheduleRealDeclarSumPlanRealCum5: TFloatField;
    ProdSheduleRealDeclarSumFactRealCum5: TFloatField;
    ProdSheduleRealDeclarSumDevRealCum5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_t9: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_t9: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31001: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31001: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31213: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31213: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31003: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31003: TFloatField;
    ProdSheduleRealDeclarSumPlanReal: TFloatField;
    ProdSheduleRealDeclarSumFactReal: TFloatField;
    ProdSheduleRealDeclarSumDevReal: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t2: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t2: TFloatField;
    ProdPriceProcessID: TIntegerField;
    UnForming3VDeclarP1109_1999: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_t20: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_t20: TFloatField;
    UnForming3VDeclarP1502: TFloatField;
    UnForming3VDeclarP1521: TFloatField;
    UnForming3VDeclarP1997: TFloatField;
    UnForming3VDeclarT1502: TFloatField;
    UnForming3VDeclarT1521: TFloatField;
    UnForming3VDeclarT1997: TFloatField;
    UnForming3VDeclarP1502_P1997: TFloatField;
    UnForming3VDeclarP1521_P1997: TFloatField;
    UnForming3VDeclarP1997_P1502: TFloatField;
    UnForming3VDeclarP1997_P1521: TFloatField;
    UnForming3VDeclarP1202_1998: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1521: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1521: TFloatField;
    ProdSheduleRealDeclarAmountFactReal3_1522: TFloatField;
    ProdSheduleRealDeclarSumFactReal3_1522: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_30001: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_30001: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31402: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31402: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_t39: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_t39: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_t40: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_t40: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31302: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31302: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_t41: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_t41: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t5: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t5: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t13: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t13: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t15: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t15: TFloatField;
    Forming2DeclarConcreteStrength: TFloatField;
    Forming2ProcessConcreteStrength: TFloatField;
    Forming2DeclarProdName: TXELookField;
    UnForming2TDeclarCategory7: TFloatField;
    ProdSheduleDeclarAmountFact7_5: TFloatField;
    ProdSheduleDeclarSumFact7_5: TFloatField;
    ProdSheduleDeclarPrice2_7: TFloatField;
    UnForming3VDeclarP1251_1202: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31403: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31403: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31404: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31404: TFloatField;
    ProdSheduleRealDeclarAmountFactReal5_31405: TFloatField;
    ProdSheduleRealDeclarSumFactReal5_31405: TFloatField;
    ProdSheduleRealDeclarAmountFactReal1_t42: TFloatField;
    ProdSheduleRealDeclarSumFactReal1_t42: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t25: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t25: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t27: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t27: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_t43: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_t43: TFloatField;
    UnForming2DeclarTimeBeg: TTimeField;
    UnForming2DeclarTimeEnd: TTimeField;
    ProdSheduleDeclarAmountFact1_s4Saw: TFloatField;
    ProdSheduleDeclarSumFact1_s4Saw: TFloatField;
    ProdSheduleDeclarAmountFact1_s4: TFloatField;
    ProdSheduleDeclarSumFact1_s4: TFloatField;
    UnForming1ReportDeclarD400OutBSaw: TFloatField;
    UnForming1ReportDeclarD500OutBSaw: TFloatField;
    UnForming1ReportDeclarD600OutBSaw: TFloatField;
    UnForming1ReportDeclarD700OutBSaw: TFloatField;
    UnForming1ReportDeclarTotalBlocksOutBSaw: TFloatField;
    ProdSheduleDeclarAmountFact1_s3Saw: TFloatField;
    UnForming1ReportDeclarTotalBlocksFromSaw: TFloatField;
    UnForming1ReportDeclarD400FromSaw: TFloatField;
    UnForming1ReportDeclarD500FromSaw: TFloatField;
    UnForming1ReportDeclarD600FromSaw: TFloatField;
    UnForming1ReportDeclarD700FromSaw: TFloatField;
    UnForming3VDeclarP1998_1202: TFloatField;
    ICProdLimeParametersDeclarActivity1: TFloatField;
    ICProdLimeParametersDeclarHumidity1: TFloatField;
    ICProdLimeHour1Declar: TLinkTable;
    ICProdLimeHour1: TLinkSource;
    ICProdLimeHour1DeclarID: TIntegerField;
    ICProdLimeHour1DeclarsDate: TDateField;
    ICProdLimeHour1DeclarHL1: TFloatField;
    ICProdLimeHour1DeclarHG1: TIntegerField;
    ICProdLimeHour1DeclarRGF1: TFloatField;
    ICProdLimeHour1DeclarAct1: TFloatField;
    ICProdLimeHour1DeclarHum1: TFloatField;
    ICProdLimeHour1DeclarHL2: TFloatField;
    ICProdLimeHour1DeclarHG2: TIntegerField;
    ICProdLimeHour1DeclarRGF2: TFloatField;
    ICProdLimeHour1DeclarAct2: TFloatField;
    ICProdLimeHour1DeclarHum2: TFloatField;
    ICProdLimeHour1DeclarHL3: TFloatField;
    ICProdLimeHour1DeclarHG3: TIntegerField;
    ICProdLimeHour1DeclarRGF3: TFloatField;
    ICProdLimeHour1DeclarAct3: TFloatField;
    ICProdLimeHour1DeclarHum3: TFloatField;
    ICProdLimeHour1DeclarHL4: TFloatField;
    ICProdLimeHour1DeclarHG4: TIntegerField;
    ICProdLimeHour1DeclarRGF4: TFloatField;
    ICProdLimeHour1DeclarAct4: TFloatField;
    ICProdLimeHour1DeclarHum4: TFloatField;
    ICProdLimeHour1DeclarHL5: TFloatField;
    ICProdLimeHour1DeclarHG5: TIntegerField;
    ICProdLimeHour1DeclarRGF5: TFloatField;
    ICProdLimeHour1DeclarAct5: TFloatField;
    ICProdLimeHour1DeclarHum5: TFloatField;
    ICProdLimeHour1DeclarHL6: TFloatField;
    ICProdLimeHour1DeclarHG6: TIntegerField;
    ICProdLimeHour1DeclarRGF6: TFloatField;
    ICProdLimeHour1DeclarAct6: TFloatField;
    ICProdLimeHour1DeclarHum6: TFloatField;
    ICProdLimeHour1DeclarHL7: TFloatField;
    ICProdLimeHour1DeclarHG7: TIntegerField;
    ICProdLimeHour1DeclarRGF7: TFloatField;
    ICProdLimeHour1DeclarAct7: TFloatField;
    ICProdLimeHour1DeclarHum7: TFloatField;
    ICProdLimeHour1DeclarHL8: TFloatField;
    ICProdLimeHour1DeclarHG8: TIntegerField;
    ICProdLimeHour1DeclarRGF8: TFloatField;
    ICProdLimeHour1DeclarAct8: TFloatField;
    ICProdLimeHour1DeclarHum8: TFloatField;
    ICProdLimeHour1DeclarHL9: TFloatField;
    ICProdLimeHour1DeclarHG9: TIntegerField;
    ICProdLimeHour1DeclarRGF9: TFloatField;
    ICProdLimeHour1DeclarAct9: TFloatField;
    ICProdLimeHour1DeclarHum9: TFloatField;
    ICProdLimeHour1DeclarHL10: TFloatField;
    ICProdLimeHour1DeclarHG10: TIntegerField;
    ICProdLimeHour1DeclarRGF10: TFloatField;
    ICProdLimeHour1DeclarAct10: TFloatField;
    ICProdLimeHour1DeclarHum10: TFloatField;
    ICProdLimeHour1DeclarHL11: TFloatField;
    ICProdLimeHour1DeclarHG11: TIntegerField;
    ICProdLimeHour1DeclarRGF11: TFloatField;
    ICProdLimeHour1DeclarAct11: TFloatField;
    ICProdLimeHour1DeclarHum11: TFloatField;
    ICProdLimeHour1DeclarHL12: TFloatField;
    ICProdLimeHour1DeclarHG12: TIntegerField;
    ICProdLimeHour1DeclarRGF12: TFloatField;
    ICProdLimeHour1DeclarAct12: TFloatField;
    ICProdLimeHour1DeclarHum12: TFloatField;
    ICProdLimeHour1DeclarHL13: TFloatField;
    ICProdLimeHour1DeclarHG13: TIntegerField;
    ICProdLimeHour1DeclarRGF13: TFloatField;
    ICProdLimeHour1DeclarAct13: TFloatField;
    ICProdLimeHour1DeclarHum13: TFloatField;
    ICProdLimeHour1DeclarHL14: TFloatField;
    ICProdLimeHour1DeclarHG14: TIntegerField;
    ICProdLimeHour1DeclarRGF14: TFloatField;
    ICProdLimeHour1DeclarAct14: TFloatField;
    ICProdLimeHour1DeclarHum14: TFloatField;
    ICProdLimeHour1DeclarHL15: TFloatField;
    ICProdLimeHour1DeclarHG15: TIntegerField;
    ICProdLimeHour1DeclarRGF15: TFloatField;
    ICProdLimeHour1DeclarAct15: TFloatField;
    ICProdLimeHour1DeclarHum15: TFloatField;
    ICProdLimeHour1DeclarHL16: TFloatField;
    ICProdLimeHour1DeclarHG16: TIntegerField;
    ICProdLimeHour1DeclarRGF16: TFloatField;
    ICProdLimeHour1DeclarAct16: TFloatField;
    ICProdLimeHour1DeclarHum16: TFloatField;
    ICProdLimeHour1DeclarHL17: TFloatField;
    ICProdLimeHour1DeclarHG17: TIntegerField;
    ICProdLimeHour1DeclarRGF17: TFloatField;
    ICProdLimeHour1DeclarAct17: TFloatField;
    ICProdLimeHour1DeclarHum17: TFloatField;
    ICProdLimeHour1DeclarHL18: TFloatField;
    ICProdLimeHour1DeclarHG18: TIntegerField;
    ICProdLimeHour1DeclarRGF18: TFloatField;
    ICProdLimeHour1DeclarAct18: TFloatField;
    ICProdLimeHour1DeclarHum18: TFloatField;
    ICProdLimeHour1DeclarHL19: TFloatField;
    ICProdLimeHour1DeclarHG19: TIntegerField;
    ICProdLimeHour1DeclarRGF19: TFloatField;
    ICProdLimeHour1DeclarAct19: TFloatField;
    ICProdLimeHour1DeclarHum19: TFloatField;
    ICProdLimeHour1DeclarHL20: TFloatField;
    ICProdLimeHour1DeclarHG20: TIntegerField;
    ICProdLimeHour1DeclarRGF20: TFloatField;
    ICProdLimeHour1DeclarAct20: TFloatField;
    ICProdLimeHour1DeclarHum20: TFloatField;
    ICProdLimeHour1DeclarHL21: TFloatField;
    ICProdLimeHour1DeclarHG21: TIntegerField;
    ICProdLimeHour1DeclarRGF21: TFloatField;
    ICProdLimeHour1DeclarAct21: TFloatField;
    ICProdLimeHour1DeclarHum21: TFloatField;
    ICProdLimeHour1DeclarHL22: TFloatField;
    ICProdLimeHour1DeclarHG22: TIntegerField;
    ICProdLimeHour1DeclarRGF22: TFloatField;
    ICProdLimeHour1DeclarAct22: TFloatField;
    ICProdLimeHour1DeclarHum22: TFloatField;
    ICProdLimeHour1DeclarHL23: TFloatField;
    ICProdLimeHour1DeclarHG23: TIntegerField;
    ICProdLimeHour1DeclarRGF23: TFloatField;
    ICProdLimeHour1DeclarAct23: TFloatField;
    ICProdLimeHour1DeclarHum23: TFloatField;
    ICProdLimeHour1DeclarHL24: TFloatField;
    ICProdLimeHour1DeclarHG24: TIntegerField;
    ICProdLimeHour1DeclarRGF24: TFloatField;
    ICProdLimeHour1DeclarAct24: TFloatField;
    ICProdLimeHour1DeclarHum24: TFloatField;
    ICProdLimeHour1DeclarLimeTotal: TFloatField;
    ICProdLimeHour1DeclarLimeTotalAvg: TFloatField;
    ICProdLimeHour1DeclarGasTotal: TIntegerField;
    ICProdLimeHour1DeclarRGFTotal: TFloatField;
    ICProdLimeHour1DeclarActAvgTotal: TFloatField;
    ICProdLimeHour1DeclarLimeTotalHour: TIntegerField;
    ICProdLimeHour1DeclarShiftNumNight: TXEListField;
    ICProdLimeHour1DeclarForemanNight: TIntegerField;
    ICProdLimeHour1DeclarForemanNameNight: TStringField;
    ICProdLimeHour1DeclarLimeTotalNight: TFloatField;
    ICProdLimeHour1DeclarLimeTotalAvgNight: TFloatField;
    ICProdLimeHour1DeclarGasTotalNight: TIntegerField;
    ICProdLimeHour1DeclarRGFTotalNight: TFloatField;
    ICProdLimeHour1DeclarActAvgNight: TFloatField;
    ICProdLimeHour1DeclarLimeTotalHourNight: TIntegerField;
    ICProdLimeHour1DeclarShiftNumDay: TXEListField;
    ICProdLimeHour1DeclarForemanDay: TIntegerField;
    ICProdLimeHour1DeclarForemanNameDay: TStringField;
    ICProdLimeHour1DeclarLimeTotalDay: TFloatField;
    ICProdLimeHour1DeclarLimeTotalAvgDay: TFloatField;
    ICProdLimeHour1DeclarGasTotalDay: TIntegerField;
    ICProdLimeHour1DeclarRGFTotalDay: TFloatField;
    ICProdLimeHour1DeclarActAvgDay: TFloatField;
    ICProdLimeHour1DeclarLimeTotalHourDay: TIntegerField;
    ICProdLimeHour1C: TDBFormControl;
    ICProdLimeHour11: TLinkMenuItem;
    ProdPriceDPriceVAT: TFloatField;
    UnForming2TDeclarCategory3: TFloatField;
    UnForming2TDeclarToCategory7: TFloatField;
    UnForming2TDeclarCategory7_1: TFloatField;
    UnForming2TDeclarCategory7_2: TFloatField;
    UnForming2TDeclarCategory7_3: TFloatField;
    UnForming2TDeclarCategory7_4: TFloatField;
    UnForming2TDeclarConcreteStrength7: TFloatField;
    UnForming2TDeclarCategory7_6: TFloatField;
    UnForming2VDeclarProd3: TIntegerField;
    UnForming2VDeclarProd3Name: TStringField;
    UnForming2VDeclarCategory3: TFloatField;
    UnForming2VDeclarToCategory7: TFloatField;
    UnForming2VDeclarCategory7_1: TFloatField;
    UnForming2VDeclarCategory7_2: TFloatField;
    UnForming2VDeclarCategory7_3: TFloatField;
    UnForming2VDeclarCategory7_4: TFloatField;
    UnForming2VDeclarConcreteStrength7: TFloatField;
    UnForming2VDeclarCategory7_5: TFloatField;
    UnForming2VDeclarCategory7_6: TFloatField;
    ProdSheduleDeclarPrice2_3: TFloatField;
    ProdSheduleDeclarAmountFact2_3: TFloatField;
    ProdSheduleDeclarAmountFact2_To7: TFloatField;
    ProdSheduleDeclarAmountFact7_1: TFloatField;
    ProdSheduleDeclarAmountFact7_2: TFloatField;
    ProdSheduleDeclarAmountFact7_3: TFloatField;
    ProdSheduleDeclarAmountFact7_4: TFloatField;
    ProdSheduleDeclarAmountFact7_6: TFloatField;
    ProdSheduleDeclarSumFact2_3: TFloatField;
    ProdSheduleDeclarSumFact7_1: TFloatField;
    ProdSheduleDeclarSumFact7_2: TFloatField;
    ProdSheduleDeclarSumFact7_3: TFloatField;
    ProdSheduleDeclarSumFact7_4: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_3: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D400_3: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D400_3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D500_3: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D500_3: TFloatField;
    ProdSheduleRealDeclarAmountFactReal2_D600_3: TFloatField;
    ProdSheduleRealDeclarSumFactReal2_D600_3: TFloatField;
    ICGasForLimeDeclarGasFlow: TFloatField;
    Procedure PriceOnDate(InProd: Integer; InTare, InTPrice, InBaseTPrice: Smallint; InDate:String;
      var OutPrice:Double; var OutRateVat, OutBid,OutExtra:Double; var OutDate:TDateTime; var OutPriceGross:Double);
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
    procedure Forming3TDeclarNewRecord(DataSet: TDataSet);
    procedure UnForming3CCreateForm(Sender: TObject);
    procedure UnForming3TDeclarCalcFields(DataSet: TDataSet);
    procedure GridDblClick(Sender: TObject);
    procedure UnForming3VCCreateForm(Sender: TObject);
    procedure UnForming3VSetGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure UnForming3VSetGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure ProdSheduleCCreateForm(Sender: TObject);
    procedure GetProdSheduleReportClick(Sender: TObject);
    procedure GetProdSheduleRealReportClick(Sender: TObject);
    procedure GetProdGroupReportClick(Sender: TObject);
    procedure SetProdSheduleGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetProdSheduleGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure ProdSheduleCheckBoxClick(Sender: TObject);
    procedure ProdSheduleRealCheckBoxClick(Sender: TObject);
    procedure ProdSheduleRealRoundAmountSelectClick(Sender: TObject);
    procedure MasterChange(DataSet:TDataSet);
    procedure ModuleProdCreate(Sender: TObject);
    procedure Forming3TDeclarAfterPost(DataSet: TDataSet);
    procedure UnForming3DeclarAfterOpen(DataSet: TDataSet);
    procedure GetHeaderRectShedule(Sender: TObject; ACol: Integer; var IndexStart, Count: Integer);
    procedure GetHeaderRectLimeHour(Sender:TObject; ACol: Integer; var IndexStart, Count: Integer);
    procedure GetHeaderTextShedule(Sender: TObject; ACol: Integer; var Text: string);
    procedure GetHeaderTextLimeHour(Sender: TObject; ACol: Integer; var Text: string);
    procedure InitShopColumnsMarginInGridArray(Sender: TObject; aFormIndex: byte);
    procedure ProdGroupReportCCreateForm(Sender: TObject);
    procedure Forming2SCCreateForm(Sender: TObject);
    procedure Forming2SDeclarNewRecord(DataSet: TDataSet);
    procedure Forming1SReportCCreateForm(Sender: TObject); // Инициализация одноименного массива для прорисовки сложных заголовков
    procedure GetForming1SReportClick(Sender: TObject);
    procedure GetUnForming1ReportClick(Sender: TObject);
    procedure SetForming1SReportGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetForming1SReportGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure UnForming1ReportCCreateForm(Sender: TObject);
    procedure ICProdLimeCreateForm(Sender: TObject);
    procedure ICProdLimeHour1CCreateForm(Sender: TObject);
    procedure ICProdLimeHour2CCreateForm(Sender: TObject);
    procedure GetICProdLimeHour1Click(Sender: TObject);
    procedure GetICProdLimeHour2Click(Sender: TObject);
    procedure ICProdLimeUpdateClick(Sender: TObject);
    procedure SetICProdLimeHourGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetICProdLimeHourGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure ICProdLimeParametersCCreateForm(Sender: TObject);
    procedure ICProdLimeParametersDeclarNewRecord(DataSet: TDataSet);
    function ICTimeShedule5DeclarForemanNameFilter(Sender: TObject): String;
    procedure ICTimeShedule5DeclarNewRecord(DataSet: TDataSet);
    procedure ICProdLimeHour2DeclarsDateGetText(Sender: TField;var Text: String; DisplayText: Boolean);
    procedure ProdSheduleRealCCreateForm(Sender: TObject);
    procedure ProdSheduleRealDeclarBeforeOpen(DataSet: TDataSet);
    procedure ProdSheduleRealDeclarSumGetText(Sender: TField;var Text: String; DisplayText: Boolean);
  public
    DialTurnOverProd:TDialDate;
    { Public declarations }
  end;

procedure GenerateTreeTable(Tree:TDataSet; TreeTable:TTable; aKod,aKodUp,aAmountDown:TField);
var ModuleProd: TModuleProd;
    OldSyncDataSet: boolean;
    ThisPrice,ThisPriceGross:double;
    ThisBid,ThisExtra,ThisRateVAT:Double;
    ThisDatePrice:TDateTime;
    aDate: TDateTime;

Const SetFlag:boolean=false;


Implementation
uses Dialogs,Math,Prod,Vg,MdCommon,SysUtils, Buttons, XECtrls, BEForms, MdInvc, MdWorkers, Invoice,SForm, RXCtrls, ExtCtrls,
     Windows,Messages,StdCtrls,ToolEdit,EtvContr,EtvDBFun,Misc,MdBase, ProdPlan, MdClientsAdd, UnForming1, UnForming3;

var SDate:TDateTime; { Дата для автоввода. Запоминаем в событии BeforePost }
                     { Дублируем в событии OnNewRecord                     }
    BtnHighlight,BtnTechParamsOnOff,BtnGetForming2Report,BtnGetCementMoveReport,BtnGetCementMoveReportWithCorrectionForError,
    BtnProdSheduleReport,BtnProdSheduleRealReport,BtnProdGroupReport,BtnForming1SReport,BtnUnForming1Report,
    BtnICProdLimeHour,BtnICProdLimeHour1,BtnICProdLimeUpdate,BtnSheduleRealRefreshReport: TBitBtn;
    AllLineBtn,Line1Btn,Line2Btn,Line4Btn:TSpeedButton;
    ReportDateBeg,ReportDateEnd,DateCementMoveReport,ProdSheduleDateBeg,ProdSheduleDateEnd,ProdGroupReportDateBeg,
    ICProdLimeHourDateBeg,ICProdLimeHourDateEnd,ProdSheduleRealDateBeg,ProdSheduleRealDateEnd,
    ICProdLimeHour1DateBeg,ICProdLimeHour1DateEnd,ProdGroupReportDateEnd,Forming1SReportDateBeg,Forming1SReportDateEnd,
    UnForming1ReportDateBeg,UnForming1ReportDateEnd: TDateEdit;
    DeclarTable,ProcessTable:TLinkTable; { Текущие датасеты для журналов формовки }
    ReportLine,ShopSelect,ShopRealSelect,DigitsSelect,DigitsRealSelect,RoundAmountRealSelect:TComboBox;
    CheckBoxPrice,CheckBoxSumReal,CheckBoxDetail,CheckBoxRealDetail,CheckBoxRealTareDetail,
    CheckBoxDeviation,CheckBoxRealDeviation,CheckBoxRealTransport,CheckBoxRealGeography: TCheckBox;
    aPriceVisible,aDetailVisible: boolean; { Флаги для вычислений сложных логических цепочек при работе с формой ProdShedule}
    // Границы в Grid'е колонок по цехам 2 индекс - стартовая колонка, 3 индекс - кол-во столбцов, 1 индекс: 1 - ПЛАН-ГРАФИК ПО ВЫПУСКУ, 2 - ПЛАН-ГРАФИК ПО ОТГРУЗКЕ
    ShopColumnsMarginInGrid: array[1..2,1..5,1..2] of byte; // Границы в Grid'е колонок по цехам 1 инд. - стартовая колонка, 2 инд. - кол-во столбцов, 3 инд -

{$R *.DFM}

Procedure TModuleProd.PriceOnDate(InProd: Integer; InTare,InTPrice,InBaseTPrice: Smallint; InDate:String;
   var OutPrice:Double; var OutRateVat,OutBid,OutExtra:Double; var OutDate:TDateTime; var OutPriceGross:Double);
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
var aRound,aRoundBid:integer;
begin
  if ProdPriceDTPriceName.ValueByLookName('Currency')=974 then begin
    aRound:=RoundRB(ProdPriceDSDate.AsDateTime,false,false);
    aRoundBid:=RoundRB(ProdPriceDSDate.AsDateTime,true,true);
    if (aRound=1) and (ProdPriceDBid.AsFloat>0) then aRound:=10;
    ProdPriceDPriceVAT.Value:=ProdPriceDPrice.AsFloat*(1+ProdPriceDExtra.AsFloat/100)*ProdPriceDRateVAT.Value;
    ProdPriceDPriceBid.Value:=ProdPriceDPriceVAT.Value*(1+ProdPriceDBid.AsFloat/100);
{
    if (ProdPriceDTPrice.Value in[1,2,3,34]) and (ProdPriceDSDate.AsString>'01.01.2000') then
      ProdPriceDPriceBid.Value:=ProdPriceDPriceBid.Value*1.2;
}
    if ProdPriceDPriceBid.Value<1000 then begin
      ProdPriceDPriceVAT.Value:=MRound(ProdPriceDPriceVAT.Value);
      ProdPriceDPriceBid.Value:=MRound(ProdPriceDPriceBid.Value);
    end else begin
      ProdPriceDPriceVAT.Value:=MRound(ProdPriceDPriceVAT.Value);
      ProdPriceDPriceBid.Value:=MRound(ProdPriceDPriceBid.Value/aRoundBid)*aRoundBid;
    end;
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
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[0]) then
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
    'select GetTare('+TSmallintField(Sender).AsString+','''+Sender.DataSet.FieldByName('sDate').AsString+''')',false);
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
      Color:=clGray;
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
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
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
  Result:='(Ceh=2) and ((Position=22493) or (Position=32493) or (Position=15952) or (Position=62493) or (Position=25711))';
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
        Style:=csDropDownList;
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
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
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
    if FindField('Cement')<>nil then TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('Cement');
    if FindField('Amount')<>nil then TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('Amount');
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
var aGrid: TXEDBGrid;
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    TXEDBGrid(FindComponent('Grid1')).TitleRows:=4;
    TXEDBGrid(FindComponent('Grid1')).GridAcceptKey:=false;
    aGrid:=TXEDBGrid(FindComponent('Grid3'));
    if aGrid<>nil then aGrid.TitleRows:=3;
    Grid.OnDblClick:=GridDblClick;
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
    if (RecordCount>0) and not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
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
      Font.Size:=9;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=7;
      TotalFont.Style:=[fsBold];
      OnDblClick:=GridDblClick;
    end;
  end;
end;

procedure TModuleProd.Forming3TDeclarNewRecord(DataSet: TDataSet);
var i,j:byte;
begin
  { Инициализация значений новой строки. Полностью заполняем значениями старой строки }
  with TLinkTable(DataSet) do begin
    // RecordCount>0 - условие, чтобы на прессе №1 не дублировались значения с предыдущей смены
    if (RecordCount>0) then begin
      if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
        { 0 поля ID - AutoInc и IDH заполнятся сами, полe Amount пока не заполняем }
        { контролируем исключения из цикла по имени полей, т.к. в процессе работы индексы могут меняться }
        for i:=1 to FieldCount-1 do if (Fields[i].FieldName<>'IDH') and (Fields[i].FieldName<>'Amount') then
          if Fields[i] is TEtvLookField then begin
            { Определяем индекс ключевого поля для EtvLookField }
            j:=FieldByName(TEtvLookField(Fields[i]).KeyFields).Index;
            Fields[j].Value:=OldEditValues[j];
          end else Fields[i].Value:=OldEditValues[i]+Byte(Fields[i].FieldName='PressNum') { Прибавляем 1 к номеру пресса (поле с Index=2)}

    end else begin
      Fields.FieldByName('PressNum').Value:=1;
      Fields.FieldByName('Prod').Value:=1105;
    end;
    {Установка фокуса Grid'а на поле по-умолчанию: на поле "Amount" }
    TXEDBGrid(Screen.ActiveForm.ActiveControl).SelectedField:=FieldByName('Amount');
  end;
end;

procedure TModuleProd.UnForming3CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TFormUnForming3(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    Grid1.TitleRows:=3;
    TXEDBGrid(FindComponent('Grid1')).GridAcceptKey:=false;
  end;
end;

procedure TModuleProd.UnForming3TDeclarCalcFields(DataSet: TDataSet);
begin
  with DataSet do
    FieldByName('Total').AsFloat:=FieldByName('Shift1').AsFloat+FieldByName('Shift2').AsFloat
end;

procedure TModuleProd.GridDblClick(Sender: TObject);
  var FName: string;
  DS: TDataSource;
  aFC: TDBFormControl;
  aKeyField: string[5];
  aSearchField: string[5];
begin
  inherited;

  DS:=TXEDbGrid(Sender).DataSource; // Источник данных
  aSearchField:='ID';
  if (DS.Name='Forming3V') or (DS.Name='UnForming3V') then begin
    aFC:=UnForming3C;
    aKeyField:='ID';
  end else begin
    if DS.Name='UnForming1V' then aFC:=UnForming1C
    else
      if DS.Name='UnForming2V' then aFC:=UnForming2C
        else if DS.Name='UnForming5V' then aFC:=UnForming5C;
    aKeyField:='IDH';
  end;

  if DS.Name='ProdShedule' then begin
    case TXEDBGrid(Sender).SelectedField.Tag of
      1,11: aFC:=UnForming1C;
      2,12: aFC:=UnForming2C;
      3,13: aFC:=UnForming3C;
      0,4,10,14: Abort;
    end;
    aKeyField:='sDate';
    aSearchField:='sDate';
  end;

  // Общая часть для всех форм:
  if not Assigned(aFC.Form) or not aFC.Form.Active then aFC.Execute;
  if TLinkSource(aFC.DefSource).DataSet.Locate(aSearchField,DS.DataSet.FieldByName(aKeyField).Value,[]) then aFC.Execute;

(* попозже удалить, т.к. обобщено...
  if (DS.Name='Forming3V') or (DS.Name='UnForming3V') then begin
    if not Assigned(UnForming3C.Form) or not UnForming3C.Form.Active then UnForming3C.Execute;
    if UnForming3Declar.Locate('ID',DS.DataSet.FieldByName('ID').Value,[]) then UnForming3C.Execute;
  end;
  if DS.Name='UnForming1V' then begin
    if not Assigned(UnForming1C.Form) or not UnForming1C.Form.Active then UnForming1C.Execute;
    if UnForming1Declar.Locate('ID',DS.DataSet.FieldByName('IDH').Value,[]) then UnForming1C.Execute;
  end;
  if DS.Name='UnForming2V' then begin
    if not Assigned(UnForming2C.Form) or not UnForming2C.Form.Active then UnForming2C.Execute;
    if UnForming2Declar.Locate('ID',DS.DataSet.FieldByName('IDH').Value,[]) then UnForming2C.Execute;
  end;
*)
end;

procedure TModuleProd.UnForming3VCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    with Grid do begin
      Color:=$00F8F8F8;
      TitleRows:=3;
      Font.Name:='Arial Narrow';
      Font.Size:=9;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Style:=[];
      TitleFont.Size:=7;
      TotalFont.Style:=[fsBold];
      OnDblClick:=GridDblClick;
      OnSetColor:=UnForming3VSetGridColor;
      OnSetFont:=UnForming3VSetGridFont;
    end;
  end;
end;

Procedure TModuleProd.UnForming3VSetGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if Field.Tag=3 then begin
    Font.Color:=$00400080;
    Font.Style:=[fsBold];
  end;
end;

Procedure TModuleProd.UnForming3VSetGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  case Field.Tag of
    1: Color:=$00FAFEE7;
    2: Color:=$00DEEDDF;
    3: Color:=$00DEF3FA;
  end;
end;

procedure TModuleProd.ProdSheduleCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    ProdSheduleDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdSheduleDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ProdSheduleDateBeg';
      Hint:='Начальная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then Text:='01.01.12';
    end;

    ProdSheduleDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdSheduleDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdSheduleDateBeg.Left+ProdSheduleDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='ProdSheduleDateEnd';
      Hint:='Конечная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Text:='31.01.12';
    end;

    DigitsSelect:=TComboBox.Create(TDBFormControl(Sender).Form);
    with DigitsSelect do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdSheduleDateEnd.Left+ProdSheduleDateEnd.Width+5;
      Width:=78;
      Height:=22;
      Name:='DigitsSelect';
      Style:=csDropDownList;
      Font.Style:=[fsBold];
      Caption:='Разрядность сумм';
      TabStop:=true;
      TabOrder:=2;
      Items.Add('Рубли');
      Items.Add('Тыс.руб.');
      Items.Add('Млн.руб.');
      ItemIndex:=2;
    end;

    BtnProdSheduleReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnProdSheduleReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=DigitsSelect.Left+DigitsSelect.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnProdSheduleReport';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расчет плана-графика выпуска продукции';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetProdSheduleReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    CheckBoxPrice:=TCheckBox.Create(Form);
    with CheckBoxPrice do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=BtnProdSheduleReport.Left+BtnProdSheduleReport.Width+5;
      Width:=50;
      Height:=22;
      Name:='CheckBoxPrice';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по усредненным ценам на продукцию';
      Font.Style:=[fsBold];
      Caption:='Цены';
      TabStop:=true;
      TabOrder:=4;
      OnClick:=ProdSheduleCheckBoxClick;
    end;

    CheckBoxDetail:=TCheckBox.Create(Form);
    with CheckBoxDetail do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=CheckBoxPrice.Left+CheckBoxPrice.Width+5;
      Width:=125;
      Height:=22;
      Name:='CheckBoxDetail';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по КАЧЕСТВУ произведенной продукции';
      Font.Style:=[fsBold];
      Caption:='Детали по качеству';
      TabStop:=true;
      TabOrder:=5;
      OnClick:=ProdSheduleCheckBoxClick;
    end;

    CheckBoxDeviation:=TCheckBox.Create(Form);
    with CheckBoxDeviation do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=CheckBoxDetail.Left+CheckBoxDetail.Width+5;
      Width:=135;
      Height:=22;
      Name:='CheckBoxDeviation';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по отклонению от плана';
      Font.Style:=[fsBold];
      Caption:='Отклонения от плана';
      TabStop:=true;
      TabOrder:=6;
      OnClick:=ProdSheduleCheckBoxClick;
    end;

    ShopSelect:=TComboBox.Create(TDBFormControl(Sender).Form);
    with ShopSelect do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=CheckBoxDeviation.Left+CheckBoxDeviation.Width+5;
      Width:=78;
      Height:=22;
      Name:='ShopSelect';
      Style:=csDropDownList;
      Font.Style:=[fsBold];
      Caption:='Цех';
      TabStop:=true;
      TabOrder:=7;
      Items.Add('Все цеха');
      Items.Add('Цех №1');
      Items.Add('Цех №2');
      Items.Add('Цех №3');
      ItemIndex:=0;
      OnChange:=ProdSheduleCheckBoxClick;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=5;
      FixedCols:=1;
      SubHeader:=true;
      Font.Name:='Arial Narrow';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetProdSheduleGridColor;
      OnSetFont:=SetProdSheduleGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее
      OnDblClick:=GridDblClick;
      OnGetHeaderRect:=GetHeaderRectShedule;
      OnGetHeaderText:=GetHeaderTextShedule;
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
      Grid.Tag:=1;
      InitShopColumnsMarginInGridArray(Grid,1);
    end;
    // Работа с GridSheetPanel
  end;
end;

procedure TModuleProd.ProdSheduleRealCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    ProdSheduleRealDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdSheduleRealDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ProdSheduleRealDateBeg';
      Hint:='Начальная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then Text:='01.01.12';
    end;

    ProdSheduleRealDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdSheduleRealDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdSheduleRealDateBeg.Left+ProdSheduleRealDateBeg.Width+3;
      Width:=75;
      Height:=22;
      Name:='ProdSheduleRealDateEnd';
      Hint:='Конечная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Text:='31.01.12';
    end;
{
    DigitsRealSelect:=TComboBox.Create(TDBFormControl(Sender).Form);
    with DigitsRealSelect do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdSheduleRealDateEnd.Left+ProdSheduleRealDateEnd.Width+5;
      Width:=78;
      Height:=22;
      Name:='DigitsRealSelect';
      Style:=csDropDownList;
      Font.Style:=[fsBold];
      Hint:='Разрядность сумм';
      ShowHint:=true;
      TabStop:=true;
      TabOrder:=2;
      Items.Add('Рубли');
      Items.Add('Тыс.руб.');
      Items.Add('Млн.руб.');
      ItemIndex:=0;
    end;
}
    BtnProdSheduleRealReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnProdSheduleRealReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdSheduleRealDateEnd.Left+ProdSheduleRealDateEnd.Width+3;
      Width:=45;
      Height:=22;
      Name:='BtnProdSheduleRealReport';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расчет плана-графика отгрузки продукции';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetProdSheduleRealReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    RoundAmountRealSelect:=TComboBox.Create(TDBFormControl(Sender).Form);
    with RoundAmountRealSelect do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=BtnProdSheduleRealReport.Left+BtnProdSheduleRealReport.Width+3;
      {Left:=DigitsRealSelect.Left+DigitsRealSelect.Width+5;}
      Width:=60;
      Height:=22;
      Name:='RoundAmountRealSelect';
      Style:=csDropDownList;
      Font.Style:=[fsBold];
      Hint:='Точность натуральных значений отгрузки продукции';
      ShowHint:=true;
      TabStop:=true;
      TabOrder:=3;
      Items.Add('0');
      Items.Add('0.0');
      Items.Add('0.00');
      Items.Add('0.000');
      Items.Add('0.0000');
      ItemIndex:=0;
      OnChange:=ProdSheduleRealRoundAmountSelectClick;
    end;

    // CheckBox - для отображения подробной информации по видам продукции (Например, по блокам D400, D500, D600, D700)
    CheckBoxRealDetail:=TCheckBox.Create(Form);
    with CheckBoxRealDetail do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=RoundAmountRealSelect.Left+RoundAmountRealSelect.Width+3;
      Width:=72;
      Height:=22;
      Name:='CheckBoxRealDetail';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по видам отгруженной продукции';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='По видам';
      TabStop:=true;
      TabOrder:=4;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // CheckBox - для отображения подробной информации по видам упаковки (Например, навал, лента, поддон ПС-3)
    CheckBoxRealTareDetail:=TCheckBox.Create(Form);
    with CheckBoxRealTareDetail do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=CheckBoxRealDetail.Left+CheckBoxRealDetail.Width+3;
      Width:=88;
      Height:=22;
      Name:='CheckBoxRealTareDetail';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по упаковке отгруженной продукции';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='По упаковке';
      TabStop:=true;
      TabOrder:=5;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // CheckBox - для отображения информации по видам транспортировки
    CheckBoxRealTransport:=TCheckBox.Create(Form);
    with CheckBoxRealTransport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=CheckBoxRealTareDetail.Left+CheckBoxRealTareDetail.Width+3;
      Width:=133;
      Height:=22;
      Name:='CheckBoxRealTransport';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по виду транспортировки';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='По транспортировке';
      TabStop:=true;
      TabOrder:=6;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // CheckBox - для отображения информации по географии поставок
    CheckBoxRealGeography:=TCheckBox.Create(Form);
    with CheckBoxRealGeography do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=CheckBoxRealTransport.Left+CheckBoxRealTransport.Width+3;
      Width:=98;
      Height:=22;
      Name:='CheckBoxRealGeography';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по географии поставок';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='По географии';
      TabStop:=true;
      TabOrder:=7;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // CheckBox - для отображения информации отклонения от плана отгрузки
    CheckBoxRealDeviation:=TCheckBox.Create(Form);
    with CheckBoxRealDeviation do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=CheckBoxRealGeography.Left+CheckBoxRealGeography.Width+3;
      Width:=85;
      Height:=22;
      Name:='CheckBoxRealDeviation';
      ShowHint:=true;
      Hint:='Вкл./Выкл. столбцов по отклонению от плана';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='Отклонения';
      Checked:=true;
      TabStop:=true;
      TabOrder:=8;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // CheckBox - для отображения сумм по отгрузке продукции + цены на продукцию для плановых расчетов
    CheckBoxSumReal:=TCheckBox.Create(Form);
    with CheckBoxSumReal do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=2;
      Left:=CheckBoxRealDeviation.Left+CheckBoxRealDeviation.Width+3;
      Width:=55;
      Height:=22;
      Name:='CheckBoxSumReal';
      ShowHint:=true;
      Hint:='Вкл./Выкл. сумм на отгруженную продукцию';
      ParentFont:=false;
      Font.Name:='Arail Narrow';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='Суммы';
      TabStop:=true;
      TabOrder:=9;
      //OnClick:=ProdSheduleRealCheckBoxClick;
    end;

    // ComboBox - для выбора работы отдельно по одному подразделению
    ShopRealSelect:=TComboBox.Create(TDBFormControl(Sender).Form);
    with ShopRealSelect do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=1;
      Left:=CheckBoxSumReal.Left+CheckBoxSumReal.Width+5;
      Width:=83;
      Height:=22;
      Name:='ShopRealSelect';
      ShowHint:=true;
      Hint:='Выбор цеха для просмотра результатов отгрузки';
      Style:=csDropDownList;
      Font.Style:=[fsBold];
      //Font.Size:=7;
      Caption:='Цех';
      TabStop:=true;
      TabOrder:=10;
      Items.Add('Все цеха');
      Items.Add('Цех №1');
      Items.Add('Цех №2');
      Items.Add('Цех №3');
      Items.Add('Цеха №5,8');
      ItemIndex:=0;
      //OnChange:=ProdSheduleRealCheckBoxClick;
    end;

    BtnSheduleRealRefreshReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnSheduleRealRefreshReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ShopRealSelect.Left+ShopRealSelect.Width+3;
      Width:=65;
      Height:=22;
      Name:='BtnSheduleRealRefreshReport';
      Caption:='Обновить';
      ShowHint:=true;
      Hint:='Обновить отчет с учетом отмеченных групп столбцов';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      //Font.Size:=7;
      OnClick:=ProdSheduleRealCheckBoxClick;
      TabStop:=true;
      TabOrder:=11;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=5;
      FixedCols:=1;
      SubHeader:=true;
      Font.Name:='Arial Narrow';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetProdSheduleGridColor;
      OnSetFont:=SetProdSheduleGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее
      //OnDblClick:=GridDblClick;
      OnGetHeaderRect:=GetHeaderRectShedule;
      OnGetHeaderText:=GetHeaderTextShedule;
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
      Grid.Tag:=2;
      ReadOnly:=true;
      InitShopColumnsMarginInGridArray(Grid,2);
    end;
    // Работа с GridSheetPanel
  end;
end;

procedure TModuleProd.InitShopColumnsMarginInGridArray(Sender: TObject; aFormIndex: byte); // Инициализация одноименного массива для прорисовки сложных заголовков
var aCurTag,i: byte;
begin // Для формы План-График выпуска продукции
  // Инициализация вспом. массива данных для прорисовки сложных заголовков
  aCurTag:=0; // У sDate такой Tag
  with TXEDbGrid(Sender) do
    for i:=0 to Columns.Count-1 do begin
      if ((Columns[i].Field.Tag mod 10)<>aCurTag) or (i=Columns.Count-1) then begin
        // Инициализация кол-ва столбцов Grid'а по цеху aCurTag
        if aCurTag>=1 then
          ShopColumnsMarginInGrid[aFormIndex,aCurTag,2]:=i-ShopColumnsMarginInGrid[aFormIndex,aCurTag,1];
        if i=Columns.Count-1 then begin // Инициализация граничного значения массива и выход
          Inc(ShopColumnsMarginInGrid[aFormIndex,aCurTag,2]);
          Break;
        end;
        aCurTag:=Columns[i].Field.Tag mod 10;
        // Инициализация стартового столбца Grid'а по цеху 1
        {if aCurTag>3 then Break;}
        ShopColumnsMarginInGrid[aFormIndex,aCurTag,1]:=i;
      end;
    end;
end;

procedure TModuleProd.ProdSheduleCheckBoxClick(Sender: TObject);
var i: smallint;
    aItemIndex: smallint;
    aSubStr: string[30];
    B:TBookMark;
    aSelectedField:TField; { Запоминаем текущий столбец в Grid'е }
begin
  inherited;
  with ProdSheduleDeclar do begin
    B:=GetBookmark; (* may be need to remake by locate *)
    DisableControls;
    with TBEForm(ProdSheduleC.Form).Grid do begin
      aSelectedField:=SelectedField;
      SelectedIndex:=0; { Устанавливаем временно SelectedIndex в 0, чтобы было меньше прорисовок }
    end;

    with ShopSelect do begin // Обработка выбора цехов
      if ItemIndex=4 then aItemIndex:=5 // Цех №5, а ItemIndex=4, противоречие.
      else aItemIndex:=ItemIndex;
      for i:=2 to Fields.Count-1 do Fields[i].Visible:=(Fields[i].Tag mod 10=aItemIndex) or (aItemIndex=0);
    end;

    with CheckBoxDetail do begin // Обработка CheckBoxDetail
      if not Checked then begin
        Filter:='ID<999';
        Filtered:=true;
      end
      else begin
        Filtered:=false;
        Filter:='';
      end;
      for i:=0 to Fields.Count-1 do
        if ((Pos('AmountFact',Fields[i].FieldName)>0) or (Pos('SumFact',Fields[i].FieldName)>0)) and (Pos('_',Fields[i].FieldName)>0) then
          Fields[i].Visible:=Checked and Fields[i].Visible
    end;
    aSubStr:='Price'; // Столбцы с ценами
    for i:=0 to Fields.Count-1 do if (Pos(aSubStr,Fields[i].FieldName)>0) then
      Fields[i].Visible:=CheckBoxPrice.Checked and Fields[i].Visible;
    aSubStr:='Dev'; // Столбцы с отклонениями
    for i:=0 to Fields.Count-1 do if (Pos(aSubStr,Fields[i].FieldName)>0) then
      Fields[i].Visible:=CheckBoxDeviation.Checked and Fields[i].Visible;

    RefreshDataOnForm(nil,true);

    with TBEForm(TCheckBox(Sender).Owner).Grid do begin
      FormatColumns(true);
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
      InitShopColumnsMarginInGridArray(TBEForm(TCheckBox(Sender).Owner).Grid,1);
      GotoBookmark(B);
      SelectedField:=aSelectedField;
      EnableControls;
      SetFocus;
    end;
    FreeBookmark(B);
  end;
end;


procedure TModuleProd.ProdSheduleRealRoundAmountSelectClick(Sender: TObject);
var i:integer;
begin
  with ProdSheduleRealDeclar,RoundAmountRealSelect do
    for i:=0 to FieldCount-1 do
      if (Pos('AmountFact',Fields[i].FieldName)>0) or (Pos('AmountDev',Fields[i].FieldName)>0) then
        with TFloatField(Fields[i]) do
          DisplayFormat:='### ##'+Items[ItemIndex]+';-### ### ##'+Items[ItemIndex]+';#';
  TBEForm(TComboBox(Sender).Owner).Grid.FormatColumns(true);
end;

procedure TModuleProd.ProdSheduleRealCheckBoxClick(Sender: TObject);
var i: smallint;
    aItemIndex: byte;
    aSubStr: string[30];
    B:TBookMark;
    aSelectedField:TField; { Запоминаем текущий столбец в Grid'е }
begin
  inherited;
  with ProdSheduleRealDeclar do begin
    B:=GetBookmark; (* may be need to remake by locate *)
    DisableControls;
    // Вкл./Выкл. строки с итогами
    if CheckBoxRealTransport.Checked or CheckBoxSumReal.Checked or CheckBoxRealTareDetail.Checked
    or CheckBoxRealDetail.Checked or CheckBoxRealGeography.Checked then begin
      Filtered:=false;
      Filter:='';
    end else begin
      Filter:='ID<999';
      Filtered:=true;
    end;
    Last; // Встали на последнюю запись для анализа пустых столбцов для их непоказа. Fileds[i].Value<>0

    with TBEForm(ProdSheduleRealC.Form).Grid do begin
      aSelectedField:=SelectedField;
      SelectedIndex:=0; { Устанавливаем временно SelectedIndex в 0, чтобы было меньше прорисовок }
    end;

    // Обработка выбора цехов. Сначала делаем все поля видимыми.
    // Потом включаем их или выключаем в зависимости от установленных галочек
    with ShopRealSelect do begin
      if ItemIndex=4 then aItemIndex:=5 // Цех №5, а ItemIndex=4, противоречие.
      else aItemIndex:=ItemIndex;
      for i:=2 to Fields.Count-1 do Fields[i].Visible:=(Fields[i].Tag mod 10=aItemIndex) or (aItemIndex=0);
    end;

    // Обработка CheckBoxDetail
    for i:=0 to Fields.Count-1 do if Fields[i].Visible then begin
      // Обработка CheckBoxDetail
      if ((Pos('AmountFact',Fields[i].FieldName)>0) or (Pos('SumFact',Fields[i].FieldName)>0)) and (Pos('_',Fields[i].FieldName)>0)
        and (Pos('_t',Fields[i].FieldName)=0) and (Pos('_Auto',Fields[i].FieldName)=0) and (Pos('_Rail',Fields[i].FieldName)=0) and (Pos('_G',Fields[i].FieldName)=0) then
          Fields[i].Visible:=CheckBoxRealDetail.Checked and (Fields[i].Value<>0);
      // Обработка CheckBoxRealTareDetail
      if (Pos('_t',Fields[i].FieldName)>0) then
        Fields[i].Visible:=CheckBoxRealTareDetail.Checked and (Fields[i].Value<>0);
      // Обработка CheckBoxRealTransport
      if (Pos('Auto',Fields[i].FieldName)>0) or (Pos('Rail',Fields[i].FieldName)>0) then
        Fields[i].Visible:=CheckBoxRealTransport.Checked and (Fields[i].Value<>0);
      // Обработка CheckBoxRealGeography
      if (Pos('_G',Fields[i].FieldName)>0) then
        Fields[i].Visible:=CheckBoxRealGeography.Checked and (Fields[i].Value<>0);
      // Столбцы с отклонениями
      if (Pos('Dev',Fields[i].FieldName)>0) then
        Fields[i].Visible:=CheckBoxRealDeviation.Checked;
      // Обработка CheckBoxSumReal
      if (Pos('Sum',Fields[i].FieldName)>0) or (Pos('Price',Fields[i].FieldName)>0) then
        Fields[i].Visible:=CheckBoxSumReal.Checked and Fields[i].Visible;
    end;

    First; // Если не вполнить этот оператор, то глюки происходят
    RefreshDataOnForm(nil,true);
    with TBEForm(TBitBtn(Sender).Owner).Grid do begin
      FormatColumns(true);
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
      InitShopColumnsMarginInGridArray(TBEForm(TBitBtn(Sender).Owner).Grid,2);
      try
        GotoBookmark(B);
        SelectedField:=aSelectedField;
      finally
        EnableControls;
        SetFocus;
      end;
    end;
    FreeBookmark(B);
  end;
end;

Procedure TModuleProd.GetProdSheduleReportClick(Sender: TObject);
var FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    ExecSQLText(ProdSheduleDeclar.DataBaseName,'call STA.GetProdShedule('''+ProdSheduleDateBeg.Text+''','''+ProdSheduleDateEnd.Text+''','+
       FloatToStr(Power(1000,DigitsSelect.ItemIndex))+')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='ПЛАН-ГРАФИК ВЫПУСКА ПРОДУКЦИИ С '+ProdSheduleDateBeg.Text+' ПО '+ProdSheduleDateEnd.Text;
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
  end;
end;

Procedure TModuleProd.GetProdSheduleRealReportClick(Sender: TObject);
var FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    ExecSQLText(ProdSheduleRealDeclar.DataBaseName,'call STA.GetProdSheduleReal('''+ProdSheduleRealDateBeg.Text+''','''+ProdSheduleRealDateEnd.Text+''','+
       FloatToStr(Power(1000,{DigitsRealSelect.ItemIndex}0))+')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='ПЛАН-ГРАФИК ОТГРУЗКИ ПРОДУКЦИИ С '+ProdSheduleRealDateBeg.Text+' ПО '+ProdSheduleRealDateEnd.Text;
    (*
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
    *)
    ProdSheduleRealCheckBoxClick(Sender);
  end;
end;

Procedure TModuleProd.SetProdSheduleGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  case Field.Tag of
    1: Color:=$00FAFEE7;
    2,10: Color:=$00DEF3FA;
    3: Color:=$00DEEDDF;
    {4: Color:=$00CDE1EB;//$00BBF8FD;}
    4: Color:=$00DDE1F3;
    11,12,13,14,15: Color:=$00FFDDDD;
  end;
end;

Procedure TModuleProd.SetProdSheduleGridFont(Sender: TObject; Field: TField; Font: TFont);
var aProdSheduleDateEnd: TDateEdit;
    aGrid: TXEDBGrid;
begin
  if Sender.ClassName='TXEDbGrid' then aGrid:=TXEDbGrid(Sender)
  // TInplaceEditor
  else aGrid:=TXEDbGrid(TComponent(Sender).Owner);
  aProdSheduleDateEnd:=TDateEdit(TBEForm(aGrid.Owner).FindComponent(aGrid.DataSource.Name+'DateEnd'));
  if (Field.DataSet.FieldByName('sDate').AsDateTime>aProdSheduleDateEnd.Date) or
     ((Field.DataSet.FieldByName('sDate').AsDateTime=aProdSheduleDateEnd.Date) and (Pos('Cum',Field.FieldName)>0)) then begin
    Font.Color:=$0000005F;//$00400080;
    Font.Style:=[fsBold];
  end;
  if Field.Index in [0,1] then begin
    Font.Color:=clNavy;//$00400080;
    Font.Size:=11;
    Font.Style:=[fsBold];
  end;
end;

procedure TModuleProd.SetICProdLimeHourGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if (Pos('Total',Field.FieldName)>0) and (Pos('ActAvg',Field.FieldName)=0) then begin
    if (Pos('Gas',Field.FieldName)=0) {and (Pos('ActAvg',Field.FieldName)=0)} then
      Font.Color:=$0000005F
    else Font.Color:=clNavy;
    Font.Style:=[fsBold];
  end;
  //if Pos('Shift',Field.FieldName)>0 then Font.Style:=[fsBold];
end;

procedure TModuleProd.GetHeaderRectShedule(Sender:TObject; ACol: Integer; var IndexStart, Count: Integer);
var aShop,aForm: smallint;
begin
  with TXEDbGrid(Sender) do begin
    aShop:=Columns[ACol].Field.Tag mod 10;
    aForm:=Tag;
  end;
  if aShop in [1..5] then begin
    IndexStart:=ShopColumnsMarginInGrid[aForm,aShop,1];
    Count:=ShopColumnsMarginInGrid[aForm,aShop,2];
  end;
end;

procedure TModuleProd.GetHeaderTextShedule(Sender: TObject; ACol: Integer; var Text: string);
var aCeh:byte;
begin
  aCeh:=TXEDbGrid(Sender).Columns[ACol].Field.Tag mod 10;
  case aCeh of
    1..3: Text:='Цех № '+IntToStr(aCeh);
    5: Text:='Цеха № 5,8';
    4: Text:='Всего';
  end;
end;

procedure TModuleProd.GetHeaderRectLimeHour(Sender:TObject; ACol: Integer; var IndexStart, Count: Integer);
var aFieldName: string[25];
    aHour: byte;
    aLastChar,aPrevLastChar:char;
begin
  //aShop:=TXEDbGrid(Sender).Columns[ACol].Field.Tag mod 10;
  // Последний символ из FieldName
  aHour:=0;
  aFieldName:=TXEDbGrid(Sender).Columns[ACol].Field.FieldName;
  aLastChar:=aFieldName[ord(aFieldName[0])];
  aPrevLastChar:=aFieldName[ord(aFieldName[0])-1];
  if (aLastChar in ['0'..'9']) and (Pos('Total',aFieldName)=0) and (Pos('Night',aFieldName)=0) and (Pos('Day',aFieldName)=0) then begin // Один из часов работы или Total
    if aPrevLastChar in ['1','2'] then
      aHour:=StrToInt(aPrevLastChar)*10+StrToInt(aLastChar)
    else
      if aLastChar in ['1'..'9'] then
        aHour:=StrToInt(aLastChar)
      else aHour:=25; // для Total
    IndexStart:=aHour*5-4; // Пока по 3 столбца на каждый час, потом м.б. будет больше
    Count:=5;//-(aHour div 25);
  end;
  if (Pos('Total',aFieldName)>0) then begin
    IndexStart:=121;
    Count:=6;
  end;
  if (Pos('Night',aFieldName)>0) then begin
    IndexStart:=127;
    Count:=7;
  end;
  if (Pos('Day',aFieldName)>0) then begin
    IndexStart:=134;
    Count:=7;
  end;
  {
  if Pos('Total',aFieldName)>0 then begin
    IndexStart:=74;
    Count:=3;
  end;
}
{
  if aShop in [1..4] then begin
    IndexStart:=ShopColumnsMarginInGrid[aShop,1];
    Count:=ShopColumnsMarginInGrid[aShop,2];
  end;
}
end;

procedure TModuleProd.GetHeaderTextLimeHour(Sender: TObject; ACol: Integer; var Text: string);
var aHour:byte;
begin
  {aHour:=(TXEDbGrid(Sender).Columns[ACol].Field.Index+1) div 3;}
  if ACol<121 then
    aHour:=(ACol+3) div 5
  else begin
    if ACol in [121..127] then aHour:=25;
    if ACol in [128..133] then aHour:=26;
    if ACol in [134..140] then aHour:=27;
  end;
  //if TXEDbGrid(Sender).Columns[ACol].Field.Index>122 then aHour:=25;
  case aHour of
    1..24: Text:=IntToStr(aHour-1)+' - '+IntToStr(aHour){+'-й час'};
    25: Text:='За сутки';
    26: Text:='За ночную смену  (22:00-10:00)';
    27: Text:='За дневную смену (10:00-22:00)';
  end;
end;

Procedure TModuleProd.MasterChange(DataSet:TDataSet);
begin
  XNotifyEvent.GoSpellChild(TFormUnForming3(UnForming3C.Form).Grid1, xeSumExecute, Forming3T.DeclarLink, opInsert);
end;

procedure TModuleProd.ModuleProdCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  TEtvMasterDataLink(Forming3TDeclar.MasterLink).onMasterScroll:=MasterChange;
end;

procedure TModuleProd.Forming3TDeclarAfterPost(DataSet: TDataSet);
begin
  MasterChange(DataSet);
end;

procedure TModuleProd.UnForming3DeclarAfterOpen(DataSet: TDataSet);
begin
  MasterChange(DataSet);
end;

procedure TModuleProd.ProdGroupReportCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    ProdGroupReportDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdGroupReportDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ProdGroupReportDateBeg';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then Text:='01.01.12';
    end;

    ProdGroupReportDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ProdGroupReportDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdGroupReportDateBeg.Left+ProdGroupReportDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='ProdGroupReportDateEnd';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Text:='31.01.12';
    end;

    BtnProdGroupReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnProdGroupReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ProdGroupReportDateEnd.Left+ProdGroupReportDateEnd.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnProdGroupReport';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расчет выпуска продукции для расчета извести';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetProdGroupReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=4;
      {FixedCols:=1;
      SubHeader:=true;}
      Font.Name:='Arial';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      {OnSetColor:=SetProdSheduleGridColor;
      OnSetFont:=SetProdSheduleGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее}
    end;
  end;
end;

procedure TModuleProd.GetProdGroupReportClick(Sender: TObject);
var FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    ExecSQLText(ProdGroupReportDeclar.DataBaseName,'call STA.GetProdGroupReport('''+ProdGroupReportDateBeg.Text+''','''+ProdGroupReportDateEnd.Text+''')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='ОТЧЕТ ПО ВЫПУСКУ ПРОДУКЦИИ С '+ProdGroupReportDateBeg.Text+' ПО '+ProdGroupReportDateEnd.Text;
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
  end;
end;

procedure TModuleProd.Forming2SCCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    Grid.Color:=$00DEEDDF;
    {TXEDBGrid(FindComponent('Grid')).GridAcceptKey:=false;}
  end;
end;

procedure TModuleProd.Forming2SDeclarNewRecord(DataSet: TDataSet);
var i:byte;
begin
  { Инициализация значений новой строки. Заполняем пока только дату }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
      { 0 поле ID - AutoInc, заполнится само }
      for i:=1 to FieldCount-4 do
        if not(Fields[i] is TEtvLookField) then with Fields[i] do
          try
            Value:=OldEditValues[i]
          except
          end;
    {Установка фокуса Grid'а на поле по-умолчанию }
    if FindField('ProdName')<>nil then TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('ProdName');
  end;
  inherited;
end;

procedure TModuleProd.Forming1SReportCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    Forming1SReportDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with Forming1SReportDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='Forming1SReportDateBeg';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then Text:='01.01.12';
    end;

    Forming1SReportDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with Forming1SReportDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=Forming1SReportDateBeg.Left+Forming1SReportDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='Forming1SReportDateEnd';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Text:='31.01.12';
    end;

    BtnForming1SReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnForming1SReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=Forming1SReportDateEnd.Left+Forming1SReportDateEnd.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnForming1SReport';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Формовка продукции цеха №1';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetForming1SReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=4;
      {FixedCols:=1;
      SubHeader:=true;}
      Font.Name:='Arial';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetForming1SReportGridColor;
      OnSetFont:=SetForming1SReportGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее}
    end;
  end;
end;

procedure TModuleProd.GetForming1SReportClick(Sender: TObject);
var FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    ExecSQLText(ProdGroupReportDeclar.DataBaseName,'call STA.GetForming1SReport('''+Forming1SReportDateBeg.Text+''','''+Forming1SReportDateEnd.Text+''')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='ОТЧЕТ ПО ФОРМОВКЕ ПРОДУКЦИИ ПО СМЕННЫМ ДОНЕСЕНИЯМ ЦЕХА №1 С '+Forming1SReportDateBeg.Text+' ПО '+Forming1SReportDateEnd.Text;
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
  end;
end;

procedure TModuleProd.GetUnForming1ReportClick(Sender: TObject);
var FC: TDBFormControl;
begin
  with TBEForm(TComponent(Sender).Owner) do begin
    FC:=TDBFormControl(FormControl);
    ExecSQLText(ProdGroupReportDeclar.DataBaseName,'call STA.GetUnForming1Report('''+UnForming1ReportDateBeg.Text+''','''+UnForming1ReportDateEnd.Text+''')',false);
    FC.DefSource.DataSet.Refresh;
    FC.Caption:='ОТЧЕТ ПО РАСФОРМОВКЕ ПРОДУКЦИИ ПО СМЕННЫМ ДОНЕСЕНИЯМ ЦЕХА №1 С '+UnForming1ReportDateBeg.Text+' ПО '+UnForming1ReportDateEnd.Text;
    with Grid do begin
      FormatColumns(true);
      SetFocus;
    end;
  end;
end;

Procedure TModuleProd.SetForming1SReportGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  case Field.Tag of
    11: Color:=$00D3EBD3;
  end;
  if Field.DataSet.FieldByName('Foreman').Value>=99999 then Color:=$00D3EBD3;
end;

Procedure TModuleProd.SetForming1SReportGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if Field.DataSet.FieldByName('Foreman').Value>=99999 then begin
    Font.Color:=clNavy;
    Font.Style:=[fsBold];
  end;
end;

procedure TModuleProd.UnForming1ReportCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    UnForming1ReportDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with UnForming1ReportDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='UnForming1ReportDateBeg';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then Text:='01.01.12';
    end;

    UnForming1ReportDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with UnForming1ReportDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=UnForming1ReportDateBeg.Left+UnForming1ReportDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='UnForming1ReportDateEnd';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Text:='31.01.12';
    end;

    BtnUnForming1Report:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnUnForming1Report do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=UnForming1ReportDateEnd.Left+UnForming1ReportDateEnd.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnUnForming1Report';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расформовка продукции цеха №1 по сменным донесениям';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetUnForming1ReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=4;
      FixedCols:=3;
      {SubHeader:=true;}
      Font.Name:='Arial';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetForming1SReportGridColor;
      OnSetFont:=SetForming1SReportGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее}
    end;
  end;
end;

procedure TModuleProd.ICProdLimeCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    BtnICProdLimeUpdate:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnICProdLimeUpdate do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=105;
      Height:=22;
      Name:='BtnICProdLimeUpdate';
      Caption:='Обновить данные';
      ShowHint:=true;
      Hint:='Обновление данных по выпуску извести на основе данных промышленного контроля';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=ICProdLimeUpdateClick;
      TabStop:=true;
      TabOrder:=0;
    end;
    Grid.TitleRows:=5;
    Grid.Color:=$00DEEDDF;
    Grid.DataSource.DataSet.Last; // Позиционируемся на последнюю запись, где текущие данные
    {TXEDBGrid(FindComponent('Grid')).GridAcceptKey:=false;}
  end;
end;

procedure TModuleProd.ICProdLimeHour2CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    ICProdLimeHourDateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ICProdLimeHourDateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ICProdLimeHourDateBeg';
      Hint:='Начальная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then
        {if UserName<>'CEH5' then Text:='17.01.11'
        else} Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
    end;

    ICProdLimeHourDateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ICProdLimeHourDateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ICProdLimeHourDateBeg.Left+ICProdLimeHourDateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='ICProdLimeHourDateEnd';
      Hint:='Конечная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Date:=SysUtils.Date;// Текущая дата '28.02.11';
    end;

    BtnICProdLimeHour:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnICProdLimeHour do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ICProdLimeHourDateEnd.Left+ICProdLimeHourDateEnd.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnICProdLimeHour';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расчет почасового выпуска извести и расхода газа на основе данных промышленного контроля в цехе №5, печь №2';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetICProdLimeHour2Click;
      TabStop:=true;
      TabOrder:=3;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=5;
      FixedCols:=1;
      SubHeader:=true;
      Font.Name:='Arial Narrow';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetICProdLimeHourGridColor;
      OnSetFont:=SetICProdLimeHourGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее}
      OnGetHeaderRect:=GetHeaderRectLimeHour;
      OnGetHeaderText:=GetHeaderTextLimeHour;
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
    end;

(*
    with Grid do begin
      TitleRows:=5;
      FixedCols:=1;
      SubHeader:=true;
      Font.Name:='Arial Narrow';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetProdSheduleGridColor;
      OnSetFont:=SetProdSheduleGridFont; //SetDefaultGridFont;//SetCementMoveReportGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее
      OnDblClick:=GridDblClick;
      OnGetHeaderRect:=GetHeaderRectShedule;
      OnGetHeaderText:=GetHeaderTextShedule;
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
      InitShopColumnsMarginInGridArray;
    end;
*)
  end;
end;

procedure TModuleProd.ICProdLimeHour1CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    { Вставляем две даты и кнопку }
    ICProdLimeHour1DateBeg:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ICProdLimeHour1DateBeg do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=0;
      Width:=75;
      Height:=22;
      Name:='ICProdLimeHour1DateBeg';
      Hint:='Начальная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      //if Date=0 then Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
      // Для отладки
      if Date=0 then
        {if UserName<>'CEH5' then Text:='17.01.11'
        else} Date:=ModuleBase.ConfigDeclarCurMonth.AsDateTime;
    end;

    ICProdLimeHour1DateEnd:=TDateEdit.Create(TDBFormControl(Sender).Form);
    with ICProdLimeHour1DateEnd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ICProdLimeHour1DateBeg.Left+ICProdLimeHour1DateBeg.Width+5;
      Width:=75;
      Height:=22;
      Name:='ICProdLimeHour1DateEnd';
      Hint:='Конечная дата расчета';
      ShowHint:=true;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      //if Date=0 then Date:=IncMonth(ModuleBase.ConfigDeclarCurMonth.AsDateTime,1)-1;
      // Для отладки
      if Date=0 then Date:=SysUtils.Date;// Текущая дата '28.02.11';
    end;

    BtnICProdLimeHour1:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnICProdLimeHour1 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=ICProdLimeHour1DateEnd.Left+ICProdLimeHour1DateEnd.Width+5;
      Width:=45;
      Height:=22;
      Name:='BtnICProdLimeHour1';
      Caption:='Расчет';
      ShowHint:=true;
      Hint:='Расчет почасового выпуска извести и расхода газа на основе данных промышленного контроля в цехе №5, печь №1';
      Font.Name:='Arial';
      Font.Style:=[fsBold];
      OnClick:=GetICProdLimeHour1Click;
      TabStop:=true;
      TabOrder:=3;
    end;

    // Дебильный компонент TPanel. Пока не переключишь свойство AutoSize, то компоненты, туды вставленные, не отрисовываются
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
    with Grid do begin
      TitleRows:=5;
      FixedCols:=1;
      SubHeader:=true;
      Font.Name:='Arial Narrow';
      Font.Size:=11;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=9;
      TitleFont.Style:=[fsBold];
      Color:=$00F8F8F8;//$00FEFCF1;//$00FEFAE7;
      FormatColumns(true);
      OnSetColor:=SetICProdLimeHourGridColor;
      OnSetFont:=SetICProdLimeHourGridFont;
      MarkGridFontColor:=$00400080; //близко к clPurple, но покраснее}
      OnGetHeaderRect:=GetHeaderRectLimeHour;
      OnGetHeaderText:=GetHeaderTextLimeHour;
      // Инициализация вспом. массива данных для прорисовки сложных заголовков
    end;
  end;
end;

procedure TModuleProd.GetICProdLimeHour2Click(Sender: TObject);
var FC: TDBFormControl;
    //B:TBookMark; Вроде бы работает и так
    aSelectedField:TField; { Запоминаем текущий столбец в Grid'е }
    aSelectedIndex,aLeftCol: Integer;
begin
  with TBEForm(TBitBtn(Sender).Owner).Grid do begin
    with TLinkTable(DataSource.DataSet) do begin
      //B:=GetBookmark; (* may be need to remake by locate *)
      DisableControls;
      //aSelectedField:=SelectedField;
      aSelectedIndex:=SelectedIndex;
      aLeftCol:=LeftCol;
      //SelectedIndex:=0; { Устанавливаем временно SelectedIndex в 0, чтобы было меньше прорисовок }
      try // Перед расчетом обновляем данные
        ICProdLimeUpdateClick(Sender);
        ExecSQLText(ICProdLimeHour2Declar.DataBaseName,'call STA.GetICProdLimeHour('''+ICProdLimeHourDateBeg.Text+''','''+ICProdLimeHourDateEnd.Text+''')',false);
        Refresh;
        FormatColumns(true);
      finally
        //GotoBookmark(B);
        //SelectedField:=aSelectedField;
        SelectedIndex:=aSelectedIndex;
        LeftCol:=aLeftCol;
        EnableControls;
        //FreeBookmark(B);
      end;
    end;
    TBEForm(TBitBtn(Sender).Owner).Caption:=
      'ОТЧЕТ ПО ВЫПУСКУ ИЗВЕСТИ И РАСХОДУ ГАЗА ПО ДАННЫМ ПРОМЫШЛЕННОГО КОНТРОЛЯ В ЦЕХЕ №5, ПЕЧЬ №2 С '+ICProdLimeHourDateBeg.Text+' ПО '+ICProdLimeHourDateEnd.Text;
    SetFocus;
  end;
end;

procedure TModuleProd.GetICProdLimeHour1Click(Sender: TObject);
var FC: TDBFormControl;
    //B:TBookMark; Вроде бы работает и так
    aSelectedField:TField; { Запоминаем текущий столбец в Grid'е }
    aSelectedIndex,aLeftCol: Integer;
begin
  with TBEForm(TBitBtn(Sender).Owner).Grid do begin
    with TLinkTable(DataSource.DataSet) do begin
      //B:=GetBookmark; (* may be need to remake by locate *)
      DisableControls;
      //aSelectedField:=SelectedField;
      aSelectedIndex:=SelectedIndex;
      aLeftCol:=LeftCol;
      //SelectedIndex:=0; { Устанавливаем временно SelectedIndex в 0, чтобы было меньше прорисовок }
      try // Перед расчетом обновляем данные
        ICProdLimeUpdateClick(Sender);
        ExecSQLText(ICProdLimeHour1Declar.DataBaseName,'call STA.GetICProdLimeHour1('''+ICProdLimeHour1DateBeg.Text+''','''+ICProdLimeHour1DateEnd.Text+''')',false);
        Refresh;
        FormatColumns(true);
      finally
        //GotoBookmark(B);
        //SelectedField:=aSelectedField;
        SelectedIndex:=aSelectedIndex;
        LeftCol:=aLeftCol;
        EnableControls;
        //FreeBookmark(B);
      end;
    end;
    TBEForm(TBitBtn(Sender).Owner).Caption:=
      'ОТЧЕТ ПО ВЫПУСКУ ИЗВЕСТИ И РАСХОДУ ГАЗА ПО ДАННЫМ ПРОМЫШЛЕННОГО КОНТРОЛЯ В ЦЕХЕ №5, ПЕЧЬ №1 С '+ICProdLimeHour1DateBeg.Text+' ПО '+ICProdLimeHour1DateEnd.Text;
    SetFocus;
  end;
end;

Procedure TModuleProd.ICProdLimeUpdateClick(Sender: TObject);
begin
  {ModuleBase.KSMDataBase.StartTransaction;}
  // Отключаем обновляемые DataSet'ы, иначе - завис
  ICProdLimeDeclar.DisableControls;
  ICProdLimeDeclar.Close;
  ICProdLimeProtocolsDeclar.DisableControls;
  ICProdLimeProtocolsDeclar.Close;
  ICGasForLimeDeclar.DisableControls;
  ICGasForLimeDeclar.Close;

  ExecSQLText(ICProdLimeDeclar.DataBaseName,'Call STA.ICProdLimeUpdate()',false);
  // Подключаем опять обновляемые DataSet'ы
{
  ICGasForLimeDeclar.Open;
  ICGasForLimeDeclar.Last;
}
  ICGasForLimeDeclar.EnableControls;
{
  ICProdLimeProtocolsDeclar.Open;
  ICProdLimeProtocolsDeclar.Last;
}
  ICProdLimeProtocolsDeclar.EnableControls;
{
  ICProdLimeDeclar.Open;
  ICProdLimeDeclar.Last;
}
  ICProdLimeDeclar.EnableControls;
  {ModuleBase.KSMDataBase.Commit;}
  // Вызов был либо из формы с протоколами, либо из формы с данными, поэтому фокус передаем назад Grid'у
{
  if TBitBtn(Sender).Name='BtnICProdLimeUpdate' then
    TBEForm(TBitBtn(Sender).Owner).Grid.SetFocus;
}
end;

Procedure TModuleProd.SetICProdLimeHourGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  case Field.Tag of
    1: Color:=$00DEF3FA;     { Известь - желтенькая }
    2: Color:=$00FAFEE7;     { Газ - голубенький }
    3,10: Color:=$00EAF4EB;//$00DEEDDF;  { Удельная норма - серо-зелёная }
    4: Color:=clWhite;//$00EEF5FF;//$00DDE1F3;
    5: Color:=$00F1F3F3;//$00DCF5F5;//$00FAFAEB//clWhite;
    6: Color:=$00EEF5FF; // Часов работы
  end;
end;

procedure TModuleProd.ICProdLimeParametersCCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    Grid.Color:=$00DEEDDF;
    Grid.DataSource.DataSet.Last; // Позиционируемся на последнюю запись, где текущие данные
    Grid.DataSource.DataSet.DisableControls;
    Grid.DataSource.DataSet.Edit;   // Вызываем Edit, чтобы запомнить текущие значения для облегчения работы пользователя
    Grid.DataSource.DataSet.Cancel;
    Grid.DataSource.DataSet.EnableControls;
    TXEDBGrid(FindComponent('Grid')).GridAcceptKey:=false;
  end;
end;

procedure TModuleProd.ICProdLimeParametersDeclarNewRecord(DataSet: TDataSet);
begin
  { Инициализация значений новой строки. Надо увеличить DateTime на один час. Пока не знаю как. :) }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
      { 0 поле ID - AutoInc, заполнится само }
      try { Увеличиваем на 1 час время дату}
        Fields[1].Value:=VarToDateTime(OldEditValues[1])+StrToTime('01:00');
      except
      end;
    {Установка фокуса Grid'а на поле по-умолчанию: на поле "Cement" }
    if FindField('Activity1')<>nil then TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('Activity1');
  end;
  inherited;
end;

function TModuleProd.ICTimeShedule5DeclarForemanNameFilter(Sender: TObject): String;
begin
  Result:='(Ceh=5) and (Position=23416)';
end;

procedure TModuleProd.ICTimeShedule5DeclarNewRecord(DataSet: TDataSet);
begin
  { Инициализация значений новой строки. }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) and not VarIsEmpty(OldEditValues[1]) then
      { 0 поле ID - AutoInc, заполнится само }
      try
        if OldEditValues[2]=2 then begin // Была смена №2, значит Дата=Дата+1 и Смена=1
          Fields[1].Value:=VarToDateTime(OldEditValues[1]+1);
          Fields[2].Value:=1;
        end else begin // Была смена №1, значит Дата=Дата (прежняя) и Смена=2
          Fields[1].Value:=VarToDateTime(OldEditValues[1]);
          Fields[2].Value:=2;
        end;
      except
      end;
    {Установка фокуса Grid'а на поле по-умолчанию: на поле "Cement" }
    if FindField('ShiftNum')<>nil then TBEForm(Screen.ActiveForm).Grid.SelectedField:=FieldByName('ShiftNum');
  end;
  inherited;
end;

procedure TModuleProd.ICProdLimeHour2DeclarsDateGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  { Базовый тип цены - 11 - длительное хранение }
  if (Copy(Sender.AsString,7,2)='99') or (Copy(Sender.AsString,7,4)='2099') then
    if (Sender.AsString='11.11.99') or (Sender.AsString='12.12.99') then
      Text:='ИТОГО'
    else
  else Text:=Sender.AsString;
end;

procedure TModuleProd.ProdSheduleRealDeclarBeforeOpen(DataSet: TDataSet);
var i: integer;
begin
  with DataSet do
    for i:=0 to FieldCount-1 do begin
      if (Pos('Sum',Fields[i].FieldName)>0) then
        with TFloatField(Fields[i]) do begin
          DisplayFormat:='### ### ### ###;-### ### ### ###;#';
          DisplayWidth:=8;
          {OnGetText:=ProdSheduleRealDeclarSumGetText;}
        end;
      if (Pos('Price',Fields[i].FieldName)>0) then
        with TFloatField(Fields[i]) do begin
          DisplayFormat:='### ### ### ###;-### ### ### ###;#';
          DisplayWidth:=8;
        end;
      if (Pos('AmountFact',Fields[i].FieldName)>0) or (Pos('AmountDev',Fields[i].FieldName)>0) then
        with TFloatField(Fields[i]) do begin
          DisplayFormat:='### ##0;-### ### ##0;#';
          DisplayWidth:=5;
        end;
    end;
end;

procedure TModuleProd.ProdSheduleRealDeclarSumGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
   { DigitsRealSelect.ItemIndex: 0 - рубли, значение оставляем без изменений, 1 - делим на 1000, 2 - делим на 1000000 }
   if DigitsRealSelect.ItemIndex=0 then
     Text:=Sender.AsString
   else
     Text:=FloatToStr(TFloatField(Sender).AsFloat/1000);
end;

end.
