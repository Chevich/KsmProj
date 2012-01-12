unit MdInvc;
{ Value Added Tax - налог на добавленную стоимость (VAT=НДС) }
Interface

uses
  Forms, Db, XTFC, EtvDB, DBTables, LnTables, dbGrids,
  Menus, Classes, XMisc, EtvDBFun, XEFields, XECtrls, EtvRus,
  XDBTFC, LnkSet,
  EtvLook, EtvList, ppCtrls, ppBands, ppClass, ppDB, RxMemDS, ppDBPipe,
  ppDBBDE, ppMemo, ppStrtch, ppPrnabl, EtvPpCtl, ppRelatv, ppCache, ppComm,
  ppProd, ppReport, daDatMod, EtvTable, Math, Controls, Jpeg, ppModule;

type
  TModuleInvoice = class(TDataModule)
    Popup: TControlMenu;
    TTransportC: TDBFormControl;
    TTransport: TLinkSource;
    TTransportDeclar: TLinkTable;
    TTransportDeclarKod: TSmallintField;
    TTransportDeclarName: TStringField;
    TTransportLookup: TLinkQuery;
    TTransportLookupKod: TSmallintField;
    TTransportLookupName: TStringField;
    TTransport1: TLinkMenuItem;
    Dispatcher1: TLinkMenuItem;
    Allower1: TLinkMenuItem;
    AllowerC: TDBFormControl;
    Allower: TLinkSource;
    AllowerDeclar: TLinkTable;
    AllowerDeclarEmpNo: TIntegerField;
    AllowerDeclarName: TStringField;
    AllowerDeclarActive: TXEListField;
    Dispatcher: TLinkSource;
    DispatcherC: TDBFormControl;
    DispatcherDeclar: TLinkTable;
    AllowerLookup: TLinkQuery;
    DispatcherDeclarEmpNo: TIntegerField;
    DispatcherDeclarName: TStringField;
    DispatcherDeclarActive: TXEListField;
    DispatcherLookup: TLinkQuery;
    Stockman: TLinkSource;
    StockmanDeclar: TLinkTable;
    StockmanDeclarEmpNo: TIntegerField;
    StockmanDeclarDepot: TSmallintField;
    StockmanDeclarActive: TXEListField;
    StockManC: TDBFormControl;
    StockMan1: TLinkMenuItem;
    StockmanDeclarName: TStringField;
    StockmanDeclarDepotName: TXELookField;
    DispatcherLookupEmpNo: TIntegerField;
    DispatcherLookupName: TStringField;
    DispatcherLookupActive: TXEListField;
    AllowerLookupEmpNo: TIntegerField;
    AllowerLookupName: TStringField;
    AllowerLookupActive: TXEListField;
    StockmanLookup: TLinkQuery;
    StockmanLookupEmpNo: TIntegerField;
    StockmanLookupName: TStringField;
    StockmanLookupActive: TXEListField;
    TransPlant: TLinkSource;
    TransPlantDeclar: TLinkTable;
    TransPlantDeclarKod: TSmallintField;
    TransPlantDeclarName: TStringField;
    TransPlantC: TDBFormControl;
    TransPlant1: TLinkMenuItem;
    TransPlantLookupKod: TSmallintField;
    TransPlantLookupName: TStringField;
    TransPlantLookup: TLinkQuery;
    InvoiceProd: TLinkSource;
    InvoiceProdDeclar: TLinkTable;
    DeclarAmount: TFloatField;
    DeclarDatePrice: TDateField;
    DeclarPackage: TSmallintField;
    DeclarTare: TSmallintField;
    DeclarDefective: TFloatField;
    DeclarTPrice: TSmallintField;
    DeclarAutoInc: TAutoIncField;
    DeclarProd: TIntegerField;
    DeclarProdName: TXELookField;
    DeclarTPriceName: TXELookField;
    DeclarPrice: TFloatField;
    DeclarSumma: TFloatField;
    DeclarTareName: TXELookField;
    InvoiceProdC: TDBFormControl;
    Invoice: TLinkSource;
    InvoiceDeclar: TLinkTable;
    InvoiceDeclarSDate: TDateField;
    InvoiceDeclarTransport: TStringField;
    InvoiceDeclarTrailer1: TStringField;
    InvoiceDeclarKodSender: TIntegerField;
    InvoiceDeclarClient: TIntegerField;
    InvoiceDeclarDepot: TSmallintField;
    InvoiceDeclarPointUnloading: TStringField;
    InvoiceDeclarTTransport: TSmallintField;
    InvoiceDeclarTrustDate: TDateField;
    InvoiceDeclarTrust: TStringField;
    InvoiceDeclarStockman: TIntegerField;
    InvoiceDeclarTimeArrival: TTimeField;
    InvoiceDeclarTimeLeave: TTimeField;
    InvoiceDeclarLoadWork: TSmallintField;
    InvoiceDeclarAllower: TIntegerField;
    InvoiceDeclarTransPlant: TSmallintField;
    InvoiceDeclarAllowerName: TXELookField;
    InvoiceDeclarTTransportName: TXELookField;
    InvoiceDeclarTransPlantName: TXELookField;
    InvoiceDeclarSenderName: TXELookField;
    InvoiceDeclarCountSenderName: TXELookField;
    InvoiceDeclarOrgName: TXELookField;
    InvoiceDeclarCountOrgName: TXELookField;
    InvoiceDeclarDepotName: TXELookField;
    InvoiceDeclarDispatcherName: TXELookField;
    InvoiceDeclarTareName: TStringField;
    InvoiceDeclarMassaName: TStringField;
    InvoiceDeclarStockmanName: TXELookField;
    InvoiceC: TDBFormControl;
    Invoice1: TLinkMenuItem;
    InvoiceDeclarDriver: TStringField;
    InvoiceDeclarContract: TStringField;
    InvoiceDeclarSummaName: TStringField;
    InvoiceProdD: TLinkSource;
    InvoiceProdDDeclar: TLinkTable;
    DeclarAutoIncD: TAutoIncField;
    DeclarDatePriceD: TDateField;
    DeclarProdD: TIntegerField;
    DeclarProdNameD: TXELookField;
    DeclarAmountD: TFloatField;
    DeclarTPriceD: TSmallintField;
    DeclarTPriceNameD: TXELookField;
    DeclarDefectiveD: TFloatField;
    DeclarPriceD: TFloatField;
    DeclarSummaD: TFloatField;
    DeclarTareD: TSmallintField;
    DeclarTareNameD: TXELookField;
    DeclarPackageD: TSmallintField;
    InvoiceDeclarKodCountSender: TIntegerField;
    InvoiceDeclarKodCountOrg: TIntegerField;
    InvoiceDeclarDispatcher: TIntegerField;
    InvoiceProdP: TLinkSource;
    DeclarAutoIncP: TAutoIncField;
    DeclarDatePriceP: TDateField;
    DeclarProdP: TIntegerField;
    DeclarProdNameP: TXELookField;
    DeclarAmountP: TFloatField;
    DeclarWeightP: TFloatField;
    DeclarTPriceP: TSmallintField;
    DeclarTPriceNameP: TXELookField;
    DeclarDefectiveP: TFloatField;
    DeclarPriceP: TFloatField;
    DeclarSummaP: TFloatField;
    DeclarTareP: TSmallintField;
    DeclarTareNameP: TXELookField;
    DeclarPackageP: TSmallintField;
    DeclarClassCargoP: TSmallintField;
    LinkTable2: TLinkTable;
    AutoIncField2: TAutoIncField;
    DateField2: TDateField;
    SmallintField6: TSmallintField;
    EtvLookField4: TXELookField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    SmallintField7: TSmallintField;
    EtvLookField5: TXELookField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    SmallintField8: TSmallintField;
    EtvLookField6: TXELookField;
    SmallintField9: TSmallintField;
    SmallintField10: TSmallintField;
    InvoiceProdPDeclar: TLinkTable;
    DeclarPayClaimP: TIntegerField;
    DeclarPayClaimNameP: TXELookField;
    InvoiceCalculatedQuery: TLinkQuery;
    DeclarWeightD: TFloatField;
    DeclarWeight: TIntegerField;
    InvoiceDeclarTransportPay: TFloatField;
    InvoiceProcess: TLinkTable;
    DeclarPriceBid: TFloatField;
    DeclarPriceBidD: TFloatField;
    InvoiceDeclarKod: TStringField;
    InvoiceDeclarWayPaper: TStringField;
    InvoiceProdDeclarNumInvoice: TStringField;
    DeclarNumInvoiceD: TStringField;
    InvoiceProcessKod: TStringField;
    InvoiceProdPDeclarNumInvoice: TStringField;
    LinkTable2NumInvoice: TStringField;
    DeclarObjectD: TSmallintField;
    DeclarObject: TSmallintField;
    InvoiceDeclarSupported: TXEListField;
    DeclarDateName: TXELookField;
    InvoiceRail: TLinkSource;
    InvoiceRailDeclar: TLinkTable;
    InvoiceRailNumInvoice: TStringField;
    InvoiceRailStation: TStringField;
    InvoiceRailDirect: TSmallintField;
    InvoiceRailStationName: TXELookField;
    InvoiceRailDirectName: TXELookField;
    InvoiceRailBranch: TSmallintField;
    InvoiceRailBranchName: TXELookField;
    InvoiceDeclarTrustNum: TStringField;
    InvoiceRailDeclarColumn_4: TStringField;
    InvoiceRailDeclarColumn_20: TStringField;
    InvoiceRailDeclarGroupPos: TXEListField;
    InvoiceRailDeclarScheme: TXEListField;
    InvoiceCalculatedQuerySumma: TFloatField;
    InvoiceCalculatedQueryWeight: TFloatField;
    InvoiceCalculatedQueryTareAmount: TSmallintField;
    InvoiceCalculatedQueryTareName: TStringField;
    InvoiceCalculatedQueryCurrency: TSmallintField;
    InvoiceDeclarTareAmount: TSmallintField;
    InvoiceDeclarSumma: TFloatField;
    InvoiceDeclarMassa: TFloatField;
    InvoiceV: TLinkSource;
    InvoiceVC: TDBFormControl;
    InvoiceVDeclar: TLinkTable;
    InvoiceVDeclarNumInv: TStringField;
    InvoiceVDeclarSDate: TDateField;
    InvoiceVDeclarClient: TIntegerField;
    InvoiceVDeclarClientName: TStringField;
    InvoiceVDeclarDriver: TStringField;
    InvoiceVDeclarTrustNum: TStringField;
    InvoiceVDeclarTrustDate: TDateField;
    InvoiceVDeclarTrust: TStringField;
    InvoiceVDeclarStockMan: TIntegerField;
    InvoiceVDeclarStockManName: TStringField;
    InvoiceVDeclarDispatcher: TIntegerField;
    InvoiceVDeclarDispatcherName: TStringField;
    InvoiceVDeclarProd: TIntegerField;
    InvoiceVDeclarProdName: TStringField;
    InvoiceVDeclarProdMassa: TFloatField;
    InvoiceVDeclarUnitM: TSmallintField;
    InvoiceVDeclarUnitMName: TStringField;
    InvoiceVDeclarTPrice: TSmallintField;
    InvoiceVDeclarTPriceName: TStringField;
    InvoiceVDeclarTare: TSmallintField;
    InvoiceVDeclarTareName: TStringField;
    InvoiceVDeclarTareWeight: TFloatField;
    InvoiceVDeclarDatePrice: TDateField;
    InvoiceVDeclarAmount: TFloatField;
    InvoiceVDeclarPrice: TFloatField;
    InvoiceVDeclarSumma: TFloatField;
    InvoiceVDeclarPackage: TSmallintField;
    InvoiceVDeclarMassa: TFloatField;
    InvoiceV1: TLinkMenuItem;
    InvoiceVT: TLinkSource;
    InvoiceVTDeclar: TLinkTable;
    InvoiceVTC: TDBFormControl;
    InvoiceVDeclarSupported: TSmallintField;
    ShipmentTotal: TLinkSource;
    ShipmentTotalDeclar: TLinkTable;
    ShipmentTotalDeclarProdOrder: TFloatField;
    ShipmentTotalDeclarProd: TIntegerField;
    ShipmentTotalDeclarProdName: TStringField;
    ShipmentTotalDeclarAmount: TFloatField;
    ShipmentTotalDeclarSumma: TFloatField;
    ShipmentTotalC: TDBFormControl;
    RepAbroad: TppReport;
    PLInvoice: TppBDEPipeline;
    PLInvoiceRail: TppBDEPipeline;
    PLInvoiceProd: TppBDEPipeline;
    PLOrgBank: TppBDEPipeline;
    RepAbroadLabelSenderRail: TppLabel;
    EtvDBText4: TEtvPpDBText;
    EtvDBText5: TEtvPpDBText;
    EtvDBText6: TEtvPpDBText;
    EtvDBText7: TEtvPpDBText;
    EtvDBText9: TEtvPpDBText;
    EtvDBText10: TEtvPpDBText;
    EtvDbTextStockman: TEtvPpDBText;
    EtvDBText11: TEtvPpDBText;
    RepAbroadLabelDogNo: TppLabel;
    RepAbroadLabelStation: TppLabel;
    RepAbroadLabelSenderInfo: TppLabel;
    RepAbroadLabelClientInfo: TppLabel;
    RepAbroadLabelClientStation: TppLabel;
    RepAbroadvPpDBText3: TEtvPpDBText;
    RepAbroadLabelClientRail: TppLabel;
    RepAbroadMemoBoundaryStation: TppMemo;
    RepAbroadMemoProd: TppMemo;
    RepAbroadMemoTU: TppMemo;
    RepAbroadLabelPackage: TppLabel;
    RepAbroadLabelWeightProd: TppLabel;
    RepAbroadLabelWeightTare: TppLabel;
    RepAbroadLabel3: TppLabel;
    RepAbroadLabelPackageName: TppLabel;
    RepAbroadLabelWeightName: TppLabel;
    RepAbroadMemoDocs: TppMemo;
    RepAbroadMemoDefWeight: TppMemo;
    RepInside: TppReport;
    InvoiceProdDP1: TProcSubSource;
    InvoiceProdDProcess1: TLinkQuery;
    Nominative: TStringField;
    Genitive1: TStringField;
    NameDop: TStringField;
    InvoiceVDeclarTransPlant: TSmallintField;
    InvoiceVDeclarTransPlantName: TStringField;
    InvoiceVDeclarObject: TSmallintField;
    InvoiceVDeclarTransport: TStringField;
    Genitive2: TStringField;
    Nominative2: TStringField;
    NameDop2: TStringField;
    InvoiceVDeclarProdVolume: TFloatField;
    InvoiceVDeclarVolume: TFloatField;
    InvoiceRailOrgStation: TStringField;
    InvoiceDeclarCurrency: TSmallintField;
    InvoiceCalculatedQueryTareWeight: TFloatField;
    DeclarSDateD: TDateField;
    InvoiceRailDeclarSDate: TDateField;
    InvoiceRailDeclarDateShipment: TDateField;
    InvoiceVDeclarTTransport: TSmallintField;
    InvoiceVDeclarWayPaper: TStringField;
    InvoiceProcessSDate: TDateField;
    InvoiceDeclarSumma2: TFloatField;
    InvoiceVDeclarCurrency: TSmallintField;
    DeclarSDate: TDateField;
    InvoiceVDeclarAllower: TIntegerField;
    InvoiceVDeclarAllowerName: TStringField;
    InvoiceDeclarID: TAutoIncField;
    InvoiceDeclarTransportPayClose: TFloatField;
    InvoiceDeclarTransportCurrency: TSmallintField;
    InvoiceDeclarTransportCurrencyName: TXELookField;
    InvoiceDeclarTransportDate: TDateField;
    RateVATD: TFloatField;
    SummaVATD: TFloatField;
    SummaWVATD: TFloatField;
    InvoiceCalculatedQuerySummaWVAT: TFloatField;
    InvoiceDeclarSummaVATName: TStringField;
    DeclarDateModifyD: TDateField;
    InvoiceVDeclarDateModify: TDateField;
    InvoiceDeclarPayer: TIntegerField;
    InvoiceDeclarPayerName: TXELookField;
    InvoiceVDeclarINN: TStringField;
    InvoiceVDeclarRateVAT: TFloatField;
    InvoiceVDeclarSummaWVAT: TFloatField;
    InvoiceVDeclarSummaVAT: TFloatField;
    InvoiceVG: TLinkSource;
    InvoiceVGDeclar: TLinkTable;
    InvoiceVGDeclarDateInvoice: TDateField;
    InvoiceVGDeclarNumInv: TStringField;
    InvoiceVGC: TDBFormControl;
    InvoiceVG1: TLinkMenuItem;
    InvoiceVGDeclarSummaBy: TFloatField;
    InvoiceVGDeclarSummaWVAT20: TFloatField;
    InvoiceVGDeclarSummaVAT20: TFloatField;
    InvoiceVGDeclarSummaWVAT10: TFloatField;
    InvoiceVGDeclarSummaVAT10: TFloatField;
    InvoiceVGDeclarSummaBy0: TFloatField;
    InvoiceVGDeclarSummaExport: TFloatField;
    InvoiceVGDeclarClient: TIntegerField;
    InvoiceVGDeclarClientName: TStringField;
    InvoiceVGDeclarINN: TStringField;
    InvoiceVGP: TLinkSource;
    InvoiceVGPDeclar: TLinkTable;
    InvoiceVGPC: TDBFormControl;
    InvoiceVGP1: TLinkMenuItem;
    InvoiceVGPDeclarDateInvoice: TDateField;
    InvoiceVGPDeclarNumInv: TStringField;
    InvoiceVGPDeclarClient: TIntegerField;
    InvoiceVGPDeclarClientName: TStringField;
    InvoiceVGPDeclarINN: TStringField;
    InvoiceVGPDeclarSummaBy: TFloatField;
    InvoiceVGPDeclarSummaWVAT20: TFloatField;
    InvoiceVGPDeclarSummaVAT20: TFloatField;
    InvoiceVGPDeclarSummaWVAT10: TFloatField;
    InvoiceVGPDeclarSummaVAT10: TFloatField;
    InvoiceVGPDeclarSummaBy0: TFloatField;
    InvoiceVGPDeclarSummaExport: TFloatField;
    InvoiceVGPDeclarProd: TIntegerField;
    InvoiceVDeclarContract: TStringField;
    InvoiceVDeclarID: TIntegerField;
    RepInvCopy: TppReport;
    InvoiceAddSet: TRxMemoryData;
    InvoiceAddSetsDate: TStringField;
    InvoiceAddSetAutoName: TStringField;
    InvoiceAddSetWayPaper: TStringField;
    InvoiceAddSetLabContr: TStringField;
    InvoiceAddSetTransPlantName: TStringField;
    InvoiceAddSetTTransport: TStringField;
    InvoiceAddSetIsBarter: TStringField;
    InvoiceAddSetPayer: TStringField;
    InvoiceAddSetSenderName: TStringField;
    InvoiceAddSetClientName: TStringField;
    InvoiceAddSetTrustStr: TStringField;
    InvoiceAddSetCurrencyNameDop: TStringField;
    InvoiceAddSetAmount: TFloatField;
    InvoiceAddSetPrice: TFloatField;
    InvoiceAddSetMassa: TFloatField;
    PLInvoiceAdd: TppBDEPipeline;
    InvoiceAddSource: TDataSource;
    InvoiceAddSetAmountName: TStringField;
    InvoiceAddSetMassaNameAdd: TStringField;
    InvoiceVDeclarInvoiceID: TIntegerField;
    InvoiceVDeclarPayer: TIntegerField;
    InvoiceVDeclarIncTransport: TSmallintField;
    DeclarContractD: TStringField;
    InvoiceCalculatedQueryContract: TStringField;
    InvoiceVDeclarSummaClose: TFloatField;
    InvoiceVDeclarCountry: TSmallintField;
    InvoiceVDeclarCountryName: TStringField;
    InvoiceVTDeclarID: TIntegerField;
    InvoiceVTDeclarNumInv: TStringField;
    InvoiceVTDeclarSDate: TDateField;
    InvoiceVTDeclarClient: TIntegerField;
    InvoiceVTDeclarClientName: TStringField;
    InvoiceVTDeclarINN: TStringField;
    InvoiceVTDeclarDriver: TStringField;
    InvoiceVTDeclarTrustNum: TStringField;
    InvoiceVTDeclarTrustDate: TDateField;
    InvoiceVTDeclarTrust: TStringField;
    InvoiceVTDeclarStockMan: TIntegerField;
    InvoiceVTDeclarStockManName: TStringField;
    InvoiceVTDeclarDispatcher: TIntegerField;
    InvoiceVTDeclarDispatcherName: TStringField;
    InvoiceVTDeclarSupported: TSmallintField;
    InvoiceVTDeclarTransPlant: TSmallintField;
    InvoiceVTDeclarTransPlantName: TStringField;
    InvoiceVTDeclarProd: TIntegerField;
    InvoiceVTDeclarProdName: TStringField;
    InvoiceVTDeclarProdMassa: TFloatField;
    InvoiceVTDeclarProdVolume: TFloatField;
    InvoiceVTDeclarUnitM: TSmallintField;
    InvoiceVTDeclarUnitMName: TStringField;
    InvoiceVTDeclarTPrice: TSmallintField;
    InvoiceVTDeclarTPriceName: TStringField;
    InvoiceVTDeclarTPriceBy: TSmallintField;
    InvoiceVTDeclarTare: TSmallintField;
    InvoiceVTDeclarTareName: TStringField;
    InvoiceVTDeclarTareWeight: TFloatField;
    InvoiceVTDeclarDatePrice: TDateField;
    InvoiceVTDeclarDatePriceBy: TDateField;
    InvoiceVTDeclarCurrency: TSmallintField;
    InvoiceVTDeclarCourse: TFloatField;
    InvoiceVTDeclarAmount: TFloatField;
    InvoiceVTDeclarPrice: TFloatField;
    InvoiceVTDeclarPriceBy: TFloatField;
    InvoiceVTDeclarSummaWVAT: TFloatField;
    InvoiceVTDeclarRateVAT: TFloatField;
    InvoiceVTDeclarSummaVAT: TFloatField;
    InvoiceVTDeclarSumma: TFloatField;
    InvoiceVTDeclarSummaWVATBy: TFloatField;
    InvoiceVTDeclarRateVATBy: TFloatField;
    InvoiceVTDeclarSummaVATBy: TFloatField;
    InvoiceVTDeclarSummaBy: TFloatField;
    InvoiceVTDeclarAllower: TIntegerField;
    InvoiceVTDeclarAllowerName: TStringField;
    InvoiceVTDeclarPackage: TSmallintField;
    InvoiceVTDeclarMassa: TFloatField;
    InvoiceVTDeclarObject: TSmallintField;
    InvoiceVTDeclarTransport: TStringField;
    InvoiceVTDeclarTTransport: TSmallintField;
    InvoiceVTDeclarVolume: TFloatField;
    InvoiceVTDeclarWayPaper: TStringField;
    InvoiceVTDeclarDateModify: TDateField;
    InvoiceVTDeclarContract: TStringField;
    InvoiceVTDeclarInvoiceID: TIntegerField;
    InvoiceVTDeclarPayer: TIntegerField;
    InvoiceVTDeclarIncTransport: TSmallintField;
    InvoiceVTDeclarSummaClose: TFloatField;
    InvoiceVTDeclarSummaCloseBy: TFloatField;
    InvoiceVTC1: TLinkMenuItem;
    InvoiceVTDeclarCountry: TSmallintField;
    InvoiceVTDeclarCountryName: TStringField;
    InvoiceVTDeclarIsBarter: TSmallintField;
    InvoiceVTDeclarRailTarifBy: TFloatField;
    InvoiceDeclarsUser: TStringField;
    InvoiceDeclarsTime: TDateTimeField;
    InvoiceDeclarIsLock: TXEListField;
    InvoiceVDeclarIsLock: TSmallintField;
    InvoiceVDeclarProdAccount: TStringField;
    InvoiceVDeclarIsBarter: TSmallintField;
    InvoiceAddSetCountryProd: TStringField;
    InvoiceVBy: TLinkSource;
    InvoiceVByDeclar: TLinkTable;
    InvoiceVByDeclarID: TIntegerField;
    InvoiceVByDeclarNumInv: TStringField;
    InvoiceVByDeclarSDate: TDateField;
    InvoiceVByDeclarClient: TIntegerField;
    InvoiceVByDeclarClientName: TStringField;
    InvoiceVByDeclarINN: TStringField;
    InvoiceVByDeclarDriver: TStringField;
    InvoiceVByDeclarTrustNum: TStringField;
    InvoiceVByDeclarTrustDate: TDateField;
    InvoiceVByDeclarTrust: TStringField;
    InvoiceVByDeclarStockMan: TIntegerField;
    InvoiceVByDeclarStockManName: TStringField;
    InvoiceVByDeclarDispatcher: TIntegerField;
    InvoiceVByDeclarDispatcherName: TStringField;
    InvoiceVByDeclarSupported: TSmallintField;
    InvoiceVByDeclarTransPlant: TSmallintField;
    InvoiceVByDeclarTransPlantName: TStringField;
    InvoiceVByDeclarProd: TIntegerField;
    InvoiceVByDeclarProdName: TStringField;
    InvoiceVByDeclarProdMassa: TFloatField;
    InvoiceVByDeclarProdVolume: TFloatField;
    InvoiceVByDeclarUnitM: TSmallintField;
    InvoiceVByDeclarUnitMName: TStringField;
    InvoiceVByDeclarTPrice: TSmallintField;
    InvoiceVByDeclarTPriceName: TStringField;
    InvoiceVByDeclarTPriceBy: TSmallintField;
    InvoiceVByDeclarTare: TSmallintField;
    InvoiceVByDeclarTareName: TStringField;
    InvoiceVByDeclarTareWeight: TFloatField;
    InvoiceVByDeclarDatePrice: TDateField;
    InvoiceVByDeclarDatePriceBy: TDateField;
    InvoiceVByDeclarCurrency: TSmallintField;
    InvoiceVByDeclarCourse: TFloatField;
    InvoiceVByDeclarAmount: TFloatField;
    InvoiceVByDeclarPrice: TFloatField;
    InvoiceVByDeclarPriceBy: TFloatField;
    InvoiceVByDeclarSummaWVAT: TFloatField;
    InvoiceVByDeclarRateVAT: TFloatField;
    InvoiceVByDeclarSummaVAT: TFloatField;
    InvoiceVByDeclarSumma: TFloatField;
    InvoiceVByDeclarSummaWVATBy: TFloatField;
    InvoiceVByDeclarRateVATBy: TFloatField;
    InvoiceVByDeclarSummaVATBy: TFloatField;
    InvoiceVByDeclarSummaBy: TFloatField;
    InvoiceVByDeclarAllower: TIntegerField;
    InvoiceVByDeclarAllowerName: TStringField;
    InvoiceVByDeclarPackage: TSmallintField;
    InvoiceVByDeclarMassa: TFloatField;
    InvoiceVByDeclarObject: TSmallintField;
    InvoiceVByDeclarTransport: TStringField;
    InvoiceVByDeclarTTransport: TSmallintField;
    InvoiceVByDeclarVolume: TFloatField;
    InvoiceVByDeclarWayPaper: TStringField;
    InvoiceVByDeclarDateModify: TDateField;
    InvoiceVByDeclarContract: TStringField;
    InvoiceVByDeclarInvoiceID: TIntegerField;
    InvoiceVByDeclarPayer: TIntegerField;
    InvoiceVByDeclarIncTransport: TSmallintField;
    InvoiceVByDeclarSummaClose: TFloatField;
    InvoiceVByDeclarCountry: TSmallintField;
    InvoiceVByDeclarCountryName: TStringField;
    InvoiceVByDeclarIsLock: TSmallintField;
    InvoiceVByDeclarProdAccount: TStringField;
    InvoiceVByDeclarIsBarter: TSmallintField;
    InvoiceVByC: TDBFormControl;
    InvoiceVBy1: TLinkMenuItem;
    InvoiceVTDeclarIsLock: TSmallintField;
    InvoiceVTDeclarProdAccount: TStringField;
    InvoiceVTDeclarSummaByAndTarif: TFloatField;
    InvoiceVTDeclarSummaCloseByAndTarif: TFloatField;
    ppHeaderBand1: TppHeaderBand;
    ppShape4: TppShape;
    ppShape3: TppShape;
    ppShape2: TppShape;
    Shape1: TppShape;
    LabelSender: TppLabel;
    LabelRecipient: TppLabel;
    Label3: TppLabel;
    DBTextSenderINN: TEtvPpDBText;
    DBTextClientINN: TEtvPpDBText;
    Label4: TppLabel;
    DBTextSenderOKPO: TEtvPpDBText;
    DBTextClientOKPO: TEtvPpDBText;
    ppLine1: TppLine;
    Line1: TppLine;
    Label6: TppLabel;
    DBTextNumInvoice: TEtvPpDBText;
    DBTextDateInvoice: TEtvPpDBText;
    DBTextAutoName: TEtvPpDBText;
    DBTextTransport: TEtvPpDBText;
    DBTextWayPaperN: TEtvPpDBText;
    DBTextWayPaper: TEtvPpDBText;
    DBTextLabContr: TEtvPpDBText;
    DBTextContract: TEtvPpDBText;
    Label1: TppLabel;
    DBTextTransPlantName: TEtvPpDBText;
    ppLabel1: TppLabel;
    DBTextDriver: TEtvPpDBText;
    Label5: TppLabel;
    DBTextTTransport: TEtvPpDBText;
    ppLabel2: TppLabel;
    EtvPpDBText1: TEtvPpDBText;
    ppLabel3: TppLabel;
    EtvPpDBText2: TEtvPpDBText;
    ppLabel4: TppLabel;
    EtvPpDBText3: TEtvPpDBText;
    ppShape1: TppShape;
    ppLine2: TppLine;
    ppLine3: TppLine;
    DBTextPayer: TEtvPpDBText;
    DBTextSender: TEtvPpDBText;
    DBTextClient: TEtvPpDBText;
    ppLabel5: TppLabel;
    DBText: TEtvPpDBText;
    ppLabel6: TppLabel;
    EtvPpDBText4: TEtvPpDBText;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    EtvPpDBText5: TEtvPpDBText;
    ppLabel10: TppLabel;
    EtvPpDBText6: TEtvPpDBText;
    ppLabel12: TppLabel;
    ppLabel11: TppLabel;
    ppLine5: TppLine;
    ppLabel13: TppLabel;
    ppLine6: TppLine;
    ppLabel14: TppLabel;
    ppLine7: TppLine;
    ppLabel15: TppLabel;
    ppLine8: TppLine;
    ppLabel16: TppLabel;
    ppLine9: TppLine;
    ppLabel17: TppLabel;
    ppLine10: TppLine;
    ppLabel18: TppLabel;
    ppLine11: TppLine;
    ppLabel19: TppLabel;
    ppLine12: TppLine;
    ppLabel20: TppLabel;
    ppLine13: TppLine;
    ppLabel21: TppLabel;
    ppLine14: TppLine;
    ppLabel22: TppLabel;
    ppLine15: TppLine;
    ppLabel23: TppLabel;
    ppLine16: TppLine;
    ppLabel24: TppLabel;
    ppLine17: TppLine;
    ppLabel25: TppLabel;
    ppLine18: TppLine;
    ppLabel26: TppLabel;
    ppLine19: TppLine;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLine58: TppLine;
    ppLine59: TppLine;
    ppLine60: TppLine;
    ppLine61: TppLine;
    ppLine62: TppLine;
    EtvPpDBText33: TEtvPpDBText;
    ppLabel65: TppLabel;
    ppDBText1: TppDBText;
    ppDetailBand1: TppDetailBand;
    DBTextKodProd: TEtvPpDBText;
    DBTextProdName: TEtvPpDBText;
    EtvPpDBText7: TEtvPpDBText;
    EtvPpDBText8: TEtvPpDBText;
    EtvPpDBText9: TEtvPpDBText;
    EtvPpDBText10: TEtvPpDBText;
    EtvPpDBText11: TEtvPpDBText;
    EtvPpDBText12: TEtvPpDBText;
    EtvPpDBText13: TEtvPpDBText;
    EtvPpDBText14: TEtvPpDBText;
    EtvPpDBText15: TEtvPpDBText;
    ppLabel44: TppLabel;
    EtvPpDBText16: TEtvPpDBText;
    EtvPpDBText17: TEtvPpDBText;
    EtvPpDBText18: TEtvPpDBText;
    ppLine4: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppLine24: TppLine;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppLine27: TppLine;
    ppLine28: TppLine;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppLine54: TppLine;
    ppGroup2: TppGroup;
    ppGroupHeaderBand2: TppGroupHeaderBand;
    ppGroupFooterBand2: TppGroupFooterBand;
    ppLine53: TppLine;
    ppLine52: TppLine;
    ppLine51: TppLine;
    ppLine36: TppLine;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppDBCalc2: TppDBCalc;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppDBCalc3: TppDBCalc;
    ppLine42: TppLine;
    ppDBCalc4: TppDBCalc;
    ppLine43: TppLine;
    ppLine44: TppLine;
    ppDBCalc6: TppDBCalc;
    ppLine45: TppLine;
    ppLine46: TppLine;
    ppLine47: TppLine;
    ppLine48: TppLine;
    ppDBCalc5: TppDBCalc;
    ppLine50: TppLine;
    ppLine49: TppLine;
    ppLabel45: TppLabel;
    EtvPpDBText19: TEtvPpDBText;
    ppLabel46: TppLabel;
    EtvPpDBText20: TEtvPpDBText;
    ppLabel47: TppLabel;
    EtvPpDBText21: TEtvPpDBText;
    ppLabel48: TppLabel;
    EtvPpDBText22: TEtvPpDBText;
    ppLabel49: TppLabel;
    EtvPpDBText23: TEtvPpDBText;
    ppLabel50: TppLabel;
    EtvPpDBText24: TEtvPpDBText;
    ppLabel51: TppLabel;
    EtvPpDBText25: TEtvPpDBText;
    ppLabel52: TppLabel;
    EtvPpDBText26: TEtvPpDBText;
    ppLine55: TppLine;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    EtvPpDBText27: TEtvPpDBText;
    ppLine56: TppLine;
    ppLine57: TppLine;
    ppLabel55: TppLabel;
    EtvPpDBText28: TEtvPpDBText;
    ppMemo1: TppMemo;
    ppLabel56: TppLabel;
    ppLabel57: TppLabel;
    EtvPpDBText29: TEtvPpDBText;
    ppLabel58: TppLabel;
    EtvPpDBText30: TEtvPpDBText;
    ppLabel59: TppLabel;
    EtvPpDBText31: TEtvPpDBText;
    ppLabel60: TppLabel;
    EtvPpDBText32: TEtvPpDBText;
    ppLabel61: TppLabel;
    ppLabel62: TppLabel;
    ppLabel63: TppLabel;
    DBCalcAmount: TppDBCalc;
    ppLabel64: TppLabel;
    ppShape5: TppShape;
    InvoiceVDeclarPriceGross: TFloatField;
    InvoiceVDeclarSummaGross: TFloatField;
    InvoiceVDeclarOverSea: TSmallintField;
    InvoiceVDeclarsUser: TStringField;
    InvoiceVDeclarsTime: TDateTimeField;
    InvoiceVByDeclarOverSea: TSmallintField;
    InvoiceVByDeclarsUser: TStringField;
    InvoiceVByDeclarsTime: TDateTimeField;
    InvoiceVDeclarProdSquare: TFloatField;
    InvoiceVDeclarMassaNetto: TFloatField;
    InvoiceVDeclarsGroup: TSmallintField;
    InvoiceVDeclarSummaUnClose: TFloatField;
    InvoiceVTDeclarProdSquare: TFloatField;
    InvoiceVTDeclarRailTarifByAll: TFloatField;
    InvoiceVTDeclarsUser: TStringField;
    InvoiceVTDeclarsTime: TDateTimeField;
    InvoiceAddSetTareMessage: TStringField;
    InvoiceCalculatedQuerySummaClose: TFloatField;
    DeclarsUserD: TStringField;
    DeclarsTimeD: TDateTimeField;
    DeclarPriceB: TFloatField;
    DeclarSummaB: TFloatField;
    DeclarBidB: TFloatField;
    DeclarClientB: TIntegerField;
    DeclarCurrencyB: TSmallintField;
    DeclarRateVATB: TFloatField;
    N1: TMenuItem;
    N2: TMenuItem;
    InvoiceVTDeclarRailTarifWVATBy: TFloatField;
    InvoiceVTDeclarRailTarifWVATByAll: TFloatField;
    InvoiceVTDeclarSummaWVATByAndTarif: TFloatField;
    InvoiceVTDeclarOverSea: TSmallintField;
    InvoiceVTDeclarsGroup: TSmallintField;
    InvoiceVDeclarPlace: TIntegerField;
    InvoiceVDeclarTrailer1: TStringField;
    InvoiceVDeclarTrailer2: TStringField;
    InvoiceVDeclarBid: TFloatField;
    InvoiceVDeclarPlaceName: TStringField;
    InvoiceVDeclarPayerName: TStringField;
    InvoiceVDeclarStation: TStringField;
    InvoiceVDeclarStationName: TStringField;
    InvoiceVDeclarRegion: TIntegerField;
    InvoiceVDeclarRegionName: TStringField;
    InvoiceVByDeclarPayerName: TStringField;
    InvoiceVByDeclarCourseUSD: TFloatField;
    InvoiceVByDeclarProdSquare: TFloatField;
    InvoiceVByDeclarRateVATCurrentBy: TFloatField;
    InvoiceVByDeclarPriceGross: TFloatField;
    InvoiceVByDeclarPriceGrossBy: TFloatField;
    InvoiceVByDeclarPriceCurrentBy: TFloatField;
    InvoiceVByDeclarSummaGross: TFloatField;
    InvoiceVByDeclarSummaGrossBy: TFloatField;
    InvoiceVByDeclarSummaWVATCurrentBy: TFloatField;
    InvoiceVByDeclarSummaCurrentBy: TFloatField;
    InvoiceVByDeclarsGroup: TSmallintField;
    InvoiceVByDeclarStation: TStringField;
    InvoiceVByDeclarStationName: TStringField;
    InvoiceVByDeclarSummaUSD: TFloatField;
    InvoiceVDeclarRezident: TSmallintField;
    InvoiceVDeclarAmountCalc: TFloatField;
    InvoiceProdDDeclarDatePriceNum: TXELookField;
    InvoiceAddSetPayerKod: TIntegerField;
    InvoiceAddSetClientKod: TIntegerField;
    InvoiceAddSetPointUnloading: TStringField;
    DeclarPriceExtraD: TFloatField;
    DeclarExtraB: TFloatField;
    DeclarContractNameD: TXELookField;
    InvoiceDeclarContractName: TXELookField;
    FactureVAT: TLinkSource;
    FactureVATDeclar: TLinkTable;
    FactureVATDeclarID: TAutoIncField;
    FactureVATDeclarNumFacture: TStringField;
    FactureVATDeclarsDate: TDateField;
    FactureVATDeclarClient: TIntegerField;
    FactureVATC: TDBFormControl;
    FactureVATDeclarClientName: TXELookField;
    FactureVAT1: TLinkMenuItem;
    FactureVATProd: TLinkSource;
    FactureVATProdDeclar: TLinkTable;
    FactureVATProdDeclarID: TSmallintField;
    FactureVATProdDeclarNumInv: TStringField;
    FactureVATProdDeclarsDate: TDateField;
    FactureVATProdDeclarProd: TIntegerField;
    FactureVATProdDeclarProdName: TStringField;
    FactureVATProdDeclarSummaWVAT: TFloatField;
    FactureVATProdDeclarVAT: TFloatField;
    FactureVATProdDeclarSummaVAT: TFloatField;
    FactureVATProdDeclarSumma: TFloatField;
    FactureVATProdDeclarClient: TIntegerField;
    RepFactureVAT: TppReport;
    PLFactureVATProd: TppBDEPipeline;
    FactureVATDeclarSenderName: TXELookField;
    PLFactureVAT: TppBDEPipeline;
    FactureVATDeclarSender: TIntegerField;
    FactureVATDeclarSummaVATName: TStringField;
    FactureVATDeclarSummaName: TStringField;
    ppHeaderBand2: TppHeaderBand;
    ppDBText2: TppDBText;
    EtvPpDBText55: TEtvPpDBText;
    ppLabel68: TppLabel;
    EtvPpDBText56: TEtvPpDBText;
    ppLabel77: TppLabel;
    EtvPpDBText57: TEtvPpDBText;
    ppLabel78: TppLabel;
    EtvPpDBText58: TEtvPpDBText;
    ppLabel79: TppLabel;
    EtvPpDBText59: TEtvPpDBText;
    ppLabel80: TppLabel;
    EtvPpDBText60: TEtvPpDBText;
    ppLabel69: TppLabel;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppLabel74: TppLabel;
    ppLabel75: TppLabel;
    ppLabel81: TppLabel;
    ppLabel82: TppLabel;
    ppLine65: TppLine;
    ppLine66: TppLine;
    ppLabel83: TppLabel;
    ppLabel84: TppLabel;
    ppLabel85: TppLabel;
    ppLabel86: TppLabel;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppLabel89: TppLabel;
    ppLabel90: TppLabel;
    ppLabel91: TppLabel;
    ppLine67: TppLine;
    ppDetailBand2: TppDetailBand;
    EtvPpDBText37: TEtvPpDBText;
    EtvPpDBText38: TEtvPpDBText;
    EtvPpDBText39: TEtvPpDBText;
    EtvPpDBText40: TEtvPpDBText;
    EtvPpDBText41: TEtvPpDBText;
    EtvPpDBText42: TEtvPpDBText;
    EtvPpDBText43: TEtvPpDBText;
    EtvPpDBText44: TEtvPpDBText;
    EtvPpDBText45: TEtvPpDBText;
    ppLine64: TppLine;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ppLabel93: TppLabel;
    ppLabel94: TppLabel;
    EtvPpDBText46: TEtvPpDBText;
    EtvPpDBText47: TEtvPpDBText;
    ppLabel92: TppLabel;
    ppLine63: TppLine;
    ppLabel95: TppLabel;
    ppLabel96: TppLabel;
    ppLabel97: TppLabel;
    ppLine68: TppLine;
    ppLabel98: TppLabel;
    ppLabel99: TppLabel;
    ppLabel100: TppLabel;
    ppLine69: TppLine;
    ppLabel101: TppLabel;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppLine70: TppLine;
    ppLabel104: TppLabel;
    ppLabel105: TppLabel;
    ppLabel106: TppLabel;
    ppLabel107: TppLabel;
    ppLabel108: TppLabel;
    ppLabel109: TppLabel;
    ppLabel110: TppLabel;
    ppLabel111: TppLabel;
    ppLabel112: TppLabel;
    ppLabel76: TppLabel;
    FactureVATProdDeclarBegPeriod: TDateField;
    FactureVATProdDeclarEndPeriod: TDateField;
    FactureVATDeclarBegPeriod: TDateField;
    FactureVATDeclarEndPeriod: TDateField;
    ppLabel113: TppLabel;
    DeclarClassCargoD: TStringField;
    InvoiceProdDeclarClassCargo: TStringField;
    InvoiceAddSetPayerShort: TStringField;
    DeclarTareProdD: TStringField;
    AllowerDeclarTask: TSmallintField;
    AllowerLookupTask: TSmallintField;
    InvoiceVByDeclarRezident: TSmallintField;
    InvoiceVByDeclarAddress: TStringField;
    InvoiceVByDeclarCourseEuro: TFloatField;
    InvoiceVByDeclarPriceGrossBy1: TFloatField;
    InvoiceVByDeclarSummaGrossBy1: TFloatField;
    InvoiceVByDeclarRegion: TIntegerField;
    InvoiceVByDeclarRegionName: TStringField;
    InvoiceVByDeclarSummaEuro: TFloatField;
    InvoiceVByDeclarPlace: TIntegerField;
    InvoiceVByDeclarPlaceName: TStringField;
    InvoiceVByDeclarFlagCP: TSmallintField;
    InvoiceVByDeclarAmountCalc: TFloatField;
    InvoiceDeclarTransPlantStr: TStringField;
    LnQuery1: TLnQuery;
    DeclarBaseTPriceD: TSmallintField;
    InvoiceProdDDeclarBaseTPriceName: TXELookField;
    InvoiceVDeclarAddress: TStringField;
    InvoiceVDeclarBaseTPrice: TSmallintField;
    InvoiceVDeclarBaseTPriceName: TStringField;
    InvoiceVDeclarGetTare: TSmallintField;
    InvoiceVDeclarExtra: TFloatField;
    InvoiceVDeclarPriceComparable: TFloatField;
    InvoiceVDeclarSummaComparable: TFloatField;
    InvoiceVDeclarTareReturn: TXEListField;
    InvoiceVDeclarContractInvoice: TStringField;
    InvoiceVByDeclarContractInvoice: TStringField;
    InvoiceDeclarTransportClient: TIntegerField;
    InvoiceDeclarTransportClientName: TXELookField;
    InvoiceAddSetTransportClient: TStringField;
    InvoiceDeclarTransportClientStr: TStringField;
    InvoiceAddSetPayerINN: TStringField;
    InvoiceAddSetPayerOKPO: TStringField;
    InvoiceAddSetPayerLic: TStringField;
    InvoiceVByDeclarPriceComparable: TFloatField;
    InvoiceVByDeclarSummaComparable: TFloatField;
    InvoiceVByDeclarGetTare: TSmallintField;
    Facture: TLinkSource;
    FactureDeclar: TLinkTable;
    FactureDeclarID: TAutoIncField;
    FactureDeclarsDate: TDateField;
    FactureDeclarClient: TIntegerField;
    FactureDeclarClientStr: TStringField;
    FactureDeclarContract: TStringField;
    FactureDeclarClientName: TXELookField;
    FactureC: TDBFormControl;
    FactureProd: TLinkSource;
    FactureProdDeclar: TLinkTable;
    FactureProdDeclarID: TAutoIncField;
    FactureProdDeclarsDate: TDateField;
    FactureProdDeclarProd: TIntegerField;
    FactureProdDeclarTPrice: TSmallintField;
    FactureProdDeclarTare: TSmallintField;
    FactureProdDeclarBaseTPrice: TSmallintField;
    FactureProdDeclarDatePrice: TDateField;
    FactureProdDeclarClassCargo: TStringField;
    FactureProdDeclarAmount: TFloatField;
    FactureProdDeclarDefective: TFloatField;
    FactureProdDeclarProdName: TXELookField;
    FactureProdDeclarTPriceName: TXELookField;
    FactureProdDeclarTareName: TXELookField;
    FactureProdDeclarBaseTPriceName: TXELookField;
    FactureProdDeclarDateName: TXELookField;
    FactureProdDeclarPriceExtraCalc: TFloatField;
    FactureProdDeclarPriceCalc: TFloatField;
    FactureProdDeclarPriceBidCalc: TFloatField;
    FactureProdDeclarSummaWVAT: TFloatField;
    FactureProdDeclarWeight: TIntegerField;
    FactureProdDeclarRateVATCalc: TFloatField;
    FactureProdDeclarSummaVAT: TFloatField;
    FactureProdDeclarSummaCalc: TFloatField;
    FactureProdDeclarTareProd: TStringField;
    FactureDeclarNumInvoice: TStringField;
    FactureProdDeclarNumInvoice: TStringField;
    FactureProdDeclarPackage: TSmallintField;
    FactureDeclarSumma: TFloatField;
    FactureDeclarSummaVAT: TFloatField;
    FactureP1: TProcSubSource;
    FactureProcess: TLinkQuery;
    FactureProcessSumma: TFloatField;
    FactureProcessSummaVAT: TFloatField;
    RepFacture: TppReport;
    ppHeaderBand3: TppHeaderBand;
    ppDBText3: TppDBText;
    EtvPpDBText48: TEtvPpDBText;
    ppLabel114: TppLabel;
    EtvPpDBText51: TEtvPpDBText;
    ppLabel115: TppLabel;
    EtvPpDBText52: TEtvPpDBText;
    ppLabel117: TppLabel;
    ppLabel118: TppLabel;
    ppLabel119: TppLabel;
    ppLabel120: TppLabel;
    ppLabel121: TppLabel;
    ppLabel123: TppLabel;
    ppLabel124: TppLabel;
    ppLabel125: TppLabel;
    ppLine71: TppLine;
    ppLine72: TppLine;
    ppLabel126: TppLabel;
    ppLabel127: TppLabel;
    ppLabel128: TppLabel;
    ppLabel129: TppLabel;
    ppLabel130: TppLabel;
    ppLabel131: TppLabel;
    ppLabel132: TppLabel;
    ppLabel133: TppLabel;
    ppLabel134: TppLabel;
    ppLine73: TppLine;
    ppLabel135: TppLabel;
    ppDetailBand3: TppDetailBand;
    EtvPpDBText64: TEtvPpDBText;
    EtvPpDBText65: TEtvPpDBText;
    EtvPpDBText67: TEtvPpDBText;
    EtvPpDBText68: TEtvPpDBText;
    ppLine74: TppLine;
    ppGroup3: TppGroup;
    ppGroupHeaderBand3: TppGroupHeaderBand;
    ppGroupFooterBand3: TppGroupFooterBand;
    ppLabel136: TppLabel;
    ppLabel137: TppLabel;
    EtvPpDBText69: TEtvPpDBText;
    EtvPpDBText70: TEtvPpDBText;
    ppLabel138: TppLabel;
    ppLine75: TppLine;
    ppLabel139: TppLabel;
    ppLabel140: TppLabel;
    ppLabel141: TppLabel;
    ppLine76: TppLine;
    ppLabel142: TppLabel;
    ppLabel143: TppLabel;
    ppLabel150: TppLabel;
    ppLabel155: TppLabel;
    ppLabel156: TppLabel;
    PLFacture: TppBDEPipeline;
    PLFactureProd: TppBDEPipeline;
    FactureDeclarSender: TIntegerField;
    FactureDeclarSenderName: TXELookField;
    FactureDeclarSummaVATName: TStringField;
    FactureDeclarSummaName: TStringField;
    ppLabel158: TppLabel;
    ppLabel159: TppLabel;
    ppLabel160: TppLabel;
    ppShape6: TppShape;
    ppImage1: TppImage;
    ppLabel161: TppLabel;
    ppLabel162: TppLabel;
    ppDBText4: TppDBText;
    ppLabel163: TppLabel;
    ppDBCalc1: TppDBCalc;
    EtvPpDBText50: TEtvPpDBText;
    EtvPpDBText54: TEtvPpDBText;
    ppLabel164: TppLabel;
    EtvPpDBText61: TEtvPpDBText;
    EtvPpDBText62: TEtvPpDBText;
    ppLabel165: TppLabel;
    EtvPpDBText63: TEtvPpDBText;
    ppLabel166: TppLabel;
    ppDBCalc7: TppDBCalc;
    ppLabel122: TppLabel;
    ppLine82: TppLine;
    ppDBCalc8: TppDBCalc;
    ppLine81: TppLine;
    ppLabel167: TppLabel;
    ppLine77: TppLine;
    ppLine78: TppLine;
    ppLine79: TppLine;
    ppLine80: TppLine;
    ppLine83: TppLine;
    ppLine84: TppLine;
    ppLine85: TppLine;
    ppLine86: TppLine;
    ppLine87: TppLine;
    ppLine88: TppLine;
    ppLine89: TppLine;
    ppLine90: TppLine;
    ppLine91: TppLine;
    ppLine92: TppLine;
    ppLine93: TppLine;
    ppLine94: TppLine;
    ppLine95: TppLine;
    ppLine96: TppLine;
    ppLine97: TppLine;
    ppLine98: TppLine;
    ppLine99: TppLine;
    ppLine100: TppLine;
    ppLine101: TppLine;
    ppLine102: TppLine;
    ppLine103: TppLine;
    ppLine104: TppLine;
    ppLine105: TppLine;
    FactureDeclarContractName: TXELookField;
    ppLabel66: TppLabel;
    EtvPpDBText49: TEtvPpDBText;
    EtvPpDBText53: TEtvPpDBText;
    EtvPpDBText66: TEtvPpDBText;
    ppLabel67: TppLabel;
    ppLabel116: TppLabel;
    ppLabel144: TppLabel;
    EtvPpDBText71: TEtvPpDBText;
    FactureDeclarClientSaldo: TFloatField;
    InvoiceVByDeclarBaseTPrice: TSmallintField;
    InvoiceVByDeclarBaseTPriceName: TStringField;
    InvoiceAddSetBaseTPriceNameAdd: TStringField;
    InvoiceProdDDeclarNumDoc: TStringField;
    InvoiceProdDDeclarDate2: TDateField;
    InvoiceVByDeclarNumDoc: TStringField;
    InvoiceVByDeclarDate2: TDateField;
    InvoiceVDeclarNumDoc: TStringField;
    InvoiceVDeclarDate2: TDateField;
    InvoiceVTDeclarBaseTPrice: TSmallintField;
    InvoiceVTDeclarBaseTPriceName: TStringField;
    InvoiceVTDeclarRezident: TSmallintField;
    InvoiceVTDeclarAddress: TStringField;
    InvoiceVTDeclarPhones: TStringField;
    InvoiceVTDeclarPlace: TIntegerField;
    InvoiceVTDeclarPlaceName: TStringField;
    InvoiceVTDeclarPayerName: TStringField;
    InvoiceVTDeclarContractInvoice: TStringField;
    InvoiceVTDeclarPriceGross: TFloatField;
    InvoiceVTDeclarPriceGrossBy: TFloatField;
    InvoiceVTDeclarPriceGrossBy1: TFloatField;
    InvoiceVTDeclarPriceComparable: TFloatField;
    InvoiceVTDeclarSummaGross: TFloatField;
    InvoiceVTDeclarSummaGrossBy: TFloatField;
    InvoiceVTDeclarSummaGrossBy1: TFloatField;
    InvoiceVTDeclarSummaComparable: TFloatField;
    InvoiceVTDeclarRegion: TIntegerField;
    InvoiceVTDeclarRegionName: TStringField;
    InvoiceVTDeclarSubRegion: TIntegerField;
    InvoiceVTDeclarSubRegionName: TStringField;
    InvoiceVDeclarPhones: TStringField;
    InvoiceVDeclarPointUnloading: TStringField;
    InvoiceVDeclarSummaBid: TFloatField;
    InvoiceVDeclarSubRegion: TIntegerField;
    InvoiceVDeclarSubRegionName: TStringField;
    InvoiceVDeclarPriceBid: TFloatField;
    InvoiceVDeclarTActivity: TSmallintField;
    InvoiceVDeclarTOrg: TSmallintField;
    InvoiceVDeclarGoalPurchase: TSmallintField;
    InvoiceVDeclarGoalPurchaseName: TStringField;
    InvoiceDeclarGoalPurchase: TSmallintField;
    ContractDeclarGoalPurchaseName: TXELookField;
    InvoiceAddSetDepotName: TStringField;
    InvoiceVByDeclarPhones: TStringField;
    InvoiceVByDeclarGoalPurchase: TSmallintField;
    InvoiceVByDeclarGoalPurchaseName: TStringField;
    InvoiceVByDeclarTActivity: TSmallintField;
    InvoiceVByDeclarSubRegion: TIntegerField;
    InvoiceVByDeclarSubRegionName: TStringField;
    RepInvoice: TppReport;
    InvoiceAddSetProdName: TStringField;
    RepInvoiceRail: TppReport;
    ppTitleBand2: TppTitleBand;
    ppShape14: TppShape;
    ppShape15: TppShape;
    ppShape16: TppShape;
    ppLabel145: TppLabel;
    ppLabel146: TppLabel;
    ppLabel147: TppLabel;
    EtvPpDBText132: TEtvPpDBText;
    EtvPpDBText133: TEtvPpDBText;
    EtvPpDBTextNum1: TEtvPpDBText;
    EtvPpDBText137: TEtvPpDBText;
    ppLabel323: TppLabel;
    EtvPpDBText146: TEtvPpDBText;
    ppLabel324: TppLabel;
    EtvPpDBText147: TEtvPpDBText;
    ppShape17: TppShape;
    ppLine107: TppLine;
    ppLine167: TppLine;
    EtvPpDBText148: TEtvPpDBText;
    EtvPpDBText149: TEtvPpDBText;
    EtvPpDBText150: TEtvPpDBText;
    ppLabel325: TppLabel;
    EtvPpDBText151: TEtvPpDBText;
    ppLabel326: TppLabel;
    EtvPpDBText152: TEtvPpDBText;
    ppLabel330: TppLabel;
    EtvPpDBText154: TEtvPpDBText;
    ppLabel331: TppLabel;
    ppLabel332: TppLabel;
    ppLine168: TppLine;
    ppLabel333: TppLabel;
    ppLine227: TppLine;
    ppLabel334: TppLabel;
    ppLine228: TppLine;
    ppLabel335: TppLabel;
    ppLine229: TppLine;
    ppLabel336: TppLabel;
    ppLine230: TppLine;
    ppLabel337: TppLabel;
    ppLine231: TppLine;
    ppLabel338: TppLabel;
    ppLine232: TppLine;
    ppLabel339: TppLabel;
    ppLine233: TppLine;
    ppLabel340: TppLabel;
    ppLine234: TppLine;
    ppLabel341: TppLabel;
    ppLine235: TppLine;
    ppLabel342: TppLabel;
    ppLine236: TppLine;
    ppLabel343: TppLabel;
    ppLine237: TppLine;
    ppLabel345: TppLabel;
    ppLine239: TppLine;
    ppLabel346: TppLabel;
    ppLabel349: TppLabel;
    ppLabel350: TppLabel;
    ppLabel351: TppLabel;
    ppLabel352: TppLabel;
    ppLabel353: TppLabel;
    ppLabel354: TppLabel;
    ppLabel355: TppLabel;
    ppLabel356: TppLabel;
    ppLine241: TppLine;
    ppLine242: TppLine;
    ppLine243: TppLine;
    EtvPpDBText155: TEtvPpDBText;
    ppDBText6: TppDBText;
    ppLabel366: TppLabel;
    EtvPpDBText157: TEtvPpDBText;
    EtvPpDBText161: TEtvPpDBText;
    ppLabelTTN1: TppLabel;
    ppLabelCopy1: TppLabel;
    EtvPpDBText138: TEtvPpDBText;
    EtvPpDBText139: TEtvPpDBText;
    ppDetailBand5: TppDetailBand;
    EtvPpDBText162: TEtvPpDBText;
    EtvPpDBText163: TEtvPpDBText;
    EtvPpDBText164: TEtvPpDBText;
    EtvPpDBText165: TEtvPpDBText;
    EtvPpDBText166: TEtvPpDBText;
    EtvPpDBText167: TEtvPpDBText;
    EtvPpDBText168: TEtvPpDBText;
    EtvPpDBText169: TEtvPpDBText;
    EtvPpDBText170: TEtvPpDBText;
    EtvPpDBText171: TEtvPpDBText;
    EtvPpDBText172: TEtvPpDBText;
    EtvPpDBText173: TEtvPpDBText;
    EtvPpDBText174: TEtvPpDBText;
    ppLine246: TppLine;
    ppLine247: TppLine;
    ppLine248: TppLine;
    ppLine249: TppLine;
    ppLine250: TppLine;
    ppLine251: TppLine;
    ppLine252: TppLine;
    ppLine253: TppLine;
    ppLine254: TppLine;
    ppLine255: TppLine;
    ppLine256: TppLine;
    ppLine257: TppLine;
    ppLine259: TppLine;
    ppLine261: TppLine;
    ppLine262: TppLine;
    ppLine263: TppLine;
    EtvPpDBText175: TEtvPpDBText;
    ppGroup5: TppGroup;
    ppGroupHeaderBand5: TppGroupHeaderBand;
    ppGroupFooterBand5: TppGroupFooterBand;
    ppLine323: TppLine;
    ppLine324: TppLine;
    ppLine325: TppLine;
    ppLine326: TppLine;
    ppLine327: TppLine;
    ppLine328: TppLine;
    ppLine329: TppLine;
    ppDBCalc15: TppDBCalc;
    ppLine330: TppLine;
    ppLine331: TppLine;
    ppDBCalc16: TppDBCalc;
    ppLine332: TppLine;
    ppDBCalc17: TppDBCalc;
    ppLine333: TppLine;
    ppLine334: TppLine;
    ppDBCalc18: TppDBCalc;
    ppLine335: TppLine;
    ppLine336: TppLine;
    ppLine338: TppLine;
    ppDBCalc19: TppDBCalc;
    ppLine339: TppLine;
    ppLabel455: TppLabel;
    EtvPpDBText176: TEtvPpDBText;
    ppLabel456: TppLabel;
    EtvPpDBText177: TEtvPpDBText;
    ppLabel457: TppLabel;
    EtvPpDBText178: TEtvPpDBText;
    ppLabel458: TppLabel;
    EtvPpDBText179: TEtvPpDBText;
    ppLabel459: TppLabel;
    EtvPpDBText180: TEtvPpDBText;
    ppLabel460: TppLabel;
    EtvPpDBText181: TEtvPpDBText;
    ppLabel461: TppLabel;
    EtvPpDBText182: TEtvPpDBText;
    ppLabel462: TppLabel;
    EtvPpDBText183: TEtvPpDBText;
    ppLabel463: TppLabel;
    ppLabel465: TppLabel;
    EtvPpDBText185: TEtvPpDBText;
    ppLabel467: TppLabel;
    EtvPpDBText186: TEtvPpDBText;
    ppLabel468: TppLabel;
    EtvPpDBText187: TEtvPpDBText;
    ppLabel469: TppLabel;
    EtvPpDBText188: TEtvPpDBText;
    ppLabel470: TppLabel;
    EtvPpDBText189: TEtvPpDBText;
    ppLabel471: TppLabel;
    ppLabel472: TppLabel;
    EtvPpDBText190: TEtvPpDBText;
    ppLabel473: TppLabel;
    EtvPpDBText191: TEtvPpDBText;
    EtvPpDBText192: TEtvPpDBText;
    ppLine341: TppLine;
    EtvPpDBText142: TEtvPpDBText;
    EtvPpDBText143: TEtvPpDBText;
    EtvPpDBText144: TEtvPpDBText;
    EtvPpDBText145: TEtvPpDBText;
    InvoiceProdDDeclarTareAdd: TXEListField;
    InvoiceVDeclarTareAdd: TXEListField;
    InvoiceVByDeclarPriceBid: TFloatField;
    InvoiceVByDeclarSummaBid: TFloatField;
    InvoiceAddSetTareAmountName: TStringField;
    ppTitleBand1: TppTitleBand;
    ppShape8: TppShape;
    ppShape9: TppShape;
    ppShape10: TppShape;
    ppLabelKodUnn: TppLabel;
    EtvPpDBText72: TEtvPpDBText;
    EtvPpDBText73: TEtvPpDBText;
    EtvPpDBTextNum: TEtvPpDBText;
    EtvPpDBText77: TEtvPpDBText;
    EtvPpDBText78: TEtvPpDBText;
    EtvPpDBText79: TEtvPpDBText;
    EtvPpDBText80: TEtvPpDBText;
    EtvPpDBText81: TEtvPpDBText;
    ppLabel151: TppLabel;
    EtvPpDBText84: TEtvPpDBText;
    ppLabel152: TppLabel;
    EtvPpDBText85: TEtvPpDBText;
    ppLabel154: TppLabel;
    EtvPpDBText87: TEtvPpDBText;
    ppLabel157: TppLabel;
    EtvPpDBText88: TEtvPpDBText;
    ppLabel168: TppLabel;
    EtvPpDBText89: TEtvPpDBText;
    ppShape12: TppShape;
    ppLine108: TppLine;
    ppLine109: TppLine;
    EtvPpDBText90: TEtvPpDBText;
    EtvPpDBText91: TEtvPpDBText;
    EtvPpDBText92: TEtvPpDBText;
    ppLabel169: TppLabel;
    EtvPpDBText93: TEtvPpDBText;
    ppLabel170: TppLabel;
    EtvPpDBText94: TEtvPpDBText;
    ppLabel172: TppLabel;
    EtvPpDBText95: TEtvPpDBText;
    ppLabel174: TppLabel;
    EtvPpDBText96: TEtvPpDBText;
    ppLabel175: TppLabel;
    ppLabel176: TppLabel;
    ppLine110: TppLine;
    ppLabel177: TppLabel;
    ppLine111: TppLine;
    ppLabel178: TppLabel;
    ppLine112: TppLine;
    ppLabel179: TppLabel;
    ppLine113: TppLine;
    ppLabel180: TppLabel;
    ppLine114: TppLine;
    ppLabel181: TppLabel;
    ppLine115: TppLine;
    ppLabel182: TppLabel;
    ppLine116: TppLine;
    ppLabel183: TppLabel;
    ppLine117: TppLine;
    ppLabel184: TppLabel;
    ppLine118: TppLine;
    ppLabel185: TppLabel;
    ppLine119: TppLine;
    ppLabel186: TppLabel;
    ppLine120: TppLine;
    ppLabel187: TppLabel;
    ppLine121: TppLine;
    ppLabel189: TppLabel;
    ppLine123: TppLine;
    ppLabel190: TppLabel;
    ppLine124: TppLine;
    ppLabel191: TppLabel;
    ppLabel193: TppLabel;
    ppLabel194: TppLabel;
    ppLabel195: TppLabel;
    ppLabel196: TppLabel;
    ppLabel197: TppLabel;
    ppLabel198: TppLabel;
    ppLabel199: TppLabel;
    ppLabel200: TppLabel;
    ppLabel202: TppLabel;
    ppLabel206: TppLabel;
    ppLabel207: TppLabel;
    ppLine125: TppLine;
    ppLine126: TppLine;
    ppLine127: TppLine;
    ppLine128: TppLine;
    ppLine129: TppLine;
    EtvPpDBText97: TEtvPpDBText;
    ppDBText5: TppDBText;
    ppLabel149: TppLabel;
    ppLabel208: TppLabel;
    EtvPpDBText126: TEtvPpDBText;
    ppLabel230: TppLabel;
    EtvPpDBText127: TEtvPpDBText;
    EtvPpDBText82: TEtvPpDBText;
    EtvPpDBText131: TEtvPpDBText;
    ppLabelTTN: TppLabel;
    ppLabelCopy: TppLabel;
    PpDBTextZakazchikINN1: TEtvPpDBText;
    ppLine238: TppLine;
    ppLine240: TppLine;
    ppLine258: TppLine;
    ppLine260: TppLine;
    ppLine264: TppLine;
    ppLine265: TppLine;
    ppLine266: TppLine;
    ppLabel320: TppLabel;
    ppLabelGruzootpravitel: TppLabel;
    ppLabelGruzopoluchatel: TppLabel;
    ppLabelZakazchik: TppLabel;
    ppLabelKodOKULP: TppLabel;
    ppLabelLicense: TppLabel;
    PpDBTextDBTextZakazchikOKPO1: TEtvPpDBText;
    PpTextDBTextZakazchikLicence: TEtvPpDBText;
    ppDetailBand4: TppDetailBand;
    EtvPpDBText98: TEtvPpDBText;
    EtvPpDBText99: TEtvPpDBText;
    EtvPpDBText100: TEtvPpDBText;
    EtvPpDBText101: TEtvPpDBText;
    EtvPpDBText102: TEtvPpDBText;
    EtvPpDBText103: TEtvPpDBText;
    EtvPpDBText104: TEtvPpDBText;
    EtvPpDBText105: TEtvPpDBText;
    EtvPpDBText106: TEtvPpDBText;
    EtvPpDBText107: TEtvPpDBText;
    EtvPpDBText108: TEtvPpDBText;
    EtvPpDBText109: TEtvPpDBText;
    EtvPpDBText110: TEtvPpDBText;
    ppLine130: TppLine;
    ppLine131: TppLine;
    ppLine132: TppLine;
    ppLine133: TppLine;
    ppLine134: TppLine;
    ppLine135: TppLine;
    ppLine136: TppLine;
    ppLine137: TppLine;
    ppLine139: TppLine;
    ppLine140: TppLine;
    ppLine141: TppLine;
    ppLine142: TppLine;
    ppLine144: TppLine;
    ppLine145: TppLine;
    ppLine146: TppLine;
    ppLine147: TppLine;
    ppLine106: TppLine;
    EtvPpDBText76: TEtvPpDBText;
    EtvPpDBText141: TEtvPpDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLine172: TppLine;
    ppLine174: TppLine;
    ppLabel238: TppLabel;
    ppLabel239: TppLabel;
    ppLabel240: TppLabel;
    ppLabel256: TppLabel;
    ppShape11: TppShape;
    ppLine181: TppLine;
    ppLine182: TppLine;
    ppLabel257: TppLabel;
    ppLine183: TppLine;
    ppLine184: TppLine;
    ppLabel258: TppLabel;
    ppLine185: TppLine;
    ppLine186: TppLine;
    ppLine187: TppLine;
    ppLabel259: TppLabel;
    ppLabel260: TppLabel;
    ppLabel261: TppLabel;
    ppLine188: TppLine;
    ppLabel262: TppLabel;
    ppLine189: TppLine;
    ppLabel263: TppLabel;
    ppLine190: TppLine;
    ppLabel264: TppLabel;
    ppLine191: TppLine;
    ppLine192: TppLine;
    ppLine193: TppLine;
    ppLabel265: TppLabel;
    ppLine194: TppLine;
    ppLabel266: TppLabel;
    ppLabel267: TppLabel;
    ppLabel268: TppLabel;
    ppLabel269: TppLabel;
    ppLabel270: TppLabel;
    ppLabel271: TppLabel;
    ppLabel272: TppLabel;
    ppLabel273: TppLabel;
    ppLabel274: TppLabel;
    ppLabel275: TppLabel;
    ppLabel276: TppLabel;
    ppLabel277: TppLabel;
    ppLabel278: TppLabel;
    ppLabel279: TppLabel;
    ppShape13: TppShape;
    ppLine195: TppLine;
    ppLine197: TppLine;
    ppLine198: TppLine;
    ppLabel281: TppLabel;
    ppLine199: TppLine;
    ppLine200: TppLine;
    ppLine201: TppLine;
    ppLabel282: TppLabel;
    ppLabel283: TppLabel;
    ppLabel284: TppLabel;
    ppLine202: TppLine;
    ppLabel285: TppLabel;
    ppLine203: TppLine;
    ppLabel286: TppLabel;
    ppLine204: TppLine;
    ppLabel287: TppLabel;
    ppLine205: TppLine;
    ppLine206: TppLine;
    ppLine207: TppLine;
    ppLine208: TppLine;
    ppLabel289: TppLabel;
    ppLabel290: TppLabel;
    ppLabel291: TppLabel;
    ppLabel293: TppLabel;
    ppLabel294: TppLabel;
    ppLabel295: TppLabel;
    ppLabel296: TppLabel;
    ppLabel297: TppLabel;
    ppLabel298: TppLabel;
    ppLabel299: TppLabel;
    ppLabel300: TppLabel;
    ppLabel301: TppLabel;
    ppLabel302: TppLabel;
    ppLine196: TppLine;
    ppLine209: TppLine;
    ppLine210: TppLine;
    ppLabel280: TppLabel;
    ppLabel292: TppLabel;
    ppLabel303: TppLabel;
    ppLabel304: TppLabel;
    ppLine211: TppLine;
    ppLabel305: TppLabel;
    ppLabel306: TppLabel;
    ppLabel307: TppLabel;
    ppLine212: TppLine;
    ppLabel288: TppLabel;
    ppLabel308: TppLabel;
    ppLabel228: TppLabel;
    ppShape7: TppShape;
    ppLine166: TppLine;
    ppLabel232: TppLabel;
    ppLine169: TppLine;
    ppLabel233: TppLabel;
    ppLine170: TppLine;
    ppLabel234: TppLabel;
    ppLine171: TppLine;
    ppLabel235: TppLabel;
    ppLabel236: TppLabel;
    ppLabel237: TppLabel;
    ppLine173: TppLine;
    ppLabel241: TppLabel;
    ppLine175: TppLine;
    ppLabel242: TppLabel;
    ppLabel243: TppLabel;
    ppLine176: TppLine;
    ppLine177: TppLine;
    ppLabel244: TppLabel;
    ppLabel245: TppLabel;
    ppLine178: TppLine;
    ppLine179: TppLine;
    ppLabel246: TppLabel;
    ppLabel247: TppLabel;
    ppLabel248: TppLabel;
    ppLine180: TppLine;
    ppLabel249: TppLabel;
    ppLabel250: TppLabel;
    ppLabel251: TppLabel;
    ppLabel252: TppLabel;
    ppLabel253: TppLabel;
    ppLabel254: TppLabel;
    ppLabel255: TppLabel;
    ppLine213: TppLine;
    ppLine214: TppLine;
    ppLabel309: TppLabel;
    ppLabel310: TppLabel;
    ppLabel311: TppLabel;
    ppLine215: TppLine;
    ppLabel312: TppLabel;
    ppLine216: TppLine;
    ppLine217: TppLine;
    ppLine218: TppLine;
    ppLine219: TppLine;
    ppLabel313: TppLabel;
    ppLine221: TppLine;
    ppLine222: TppLine;
    ppLine223: TppLine;
    ppLabel314: TppLabel;
    ppLine220: TppLine;
    ppLine224: TppLine;
    ppLine225: TppLine;
    ppLine226: TppLine;
    ppLabel319: TppLabel;
    EtvPpDBText140: TEtvPpDBText;
    ppLabel209: TppLabel;
    ppGroup4: TppGroup;
    ppGroupHeaderBand4: TppGroupHeaderBand;
    ppGroupFooterBand4: TppGroupFooterBand;
    ppLine148: TppLine;
    ppLine149: TppLine;
    ppLine150: TppLine;
    ppLine151: TppLine;
    ppLine152: TppLine;
    ppLine153: TppLine;
    ppLine154: TppLine;
    ppDBCalc9: TppDBCalc;
    ppLine155: TppLine;
    ppLine156: TppLine;
    ppDBCalc10: TppDBCalc;
    ppLine157: TppLine;
    ppDBCalc11: TppDBCalc;
    ppLine158: TppLine;
    ppLine159: TppLine;
    ppDBCalc12: TppDBCalc;
    ppLine160: TppLine;
    ppLine161: TppLine;
    ppLine162: TppLine;
    ppLine163: TppLine;
    ppDBCalc13: TppDBCalc;
    ppLine164: TppLine;
    ppLabel210: TppLabel;
    EtvPpDBText112: TEtvPpDBText;
    ppLabel211: TppLabel;
    EtvPpDBText113: TEtvPpDBText;
    ppLabelTotalAmount: TppLabel;
    ppDBTextAmountName: TEtvPpDBText;
    ppLabel213: TppLabel;
    EtvPpDBText115: TEtvPpDBText;
    ppLabel214: TppLabel;
    EtvPpDBText116: TEtvPpDBText;
    ppLabel215: TppLabel;
    EtvPpDBText117: TEtvPpDBText;
    ppLabel216: TppLabel;
    EtvPpDBText118: TEtvPpDBText;
    ppLabel217: TppLabel;
    EtvPpDBText119: TEtvPpDBText;
    ppLabel218: TppLabel;
    ppLabel219: TppLabel;
    EtvPpDBText120: TEtvPpDBText;
    ppLabel220: TppLabel;
    EtvPpDBText121: TEtvPpDBText;
    ppLabel222: TppLabel;
    EtvPpDBText122: TEtvPpDBText;
    ppLabel223: TppLabel;
    EtvPpDBText123: TEtvPpDBText;
    ppLabel224: TppLabel;
    EtvPpDBText124: TEtvPpDBText;
    ppLabel225: TppLabel;
    EtvPpDBText125: TEtvPpDBText;
    ppLabel226: TppLabel;
    ppDBCalc14: TppDBCalc;
    ppLabel229: TppLabel;
    EtvPpDBTareMessage: TEtvPpDBText;
    ppLabel231: TppLabel;
    EtvPpDBText111: TEtvPpDBText;
    EtvPpDBText128: TEtvPpDBText;
    EtvPpDBText130: TEtvPpDBText;
    ppLabel318: TppLabel;
    ppLabel153: TppLabel;
    ppLine122: TppLine;
    ppLabel188: TppLabel;
    ppLine138: TppLine;
    ppLabel173: TppLabel;
    ppLabel192: TppLabel;
    ppLine143: TppLine;
    ppLine165: TppLine;
    ppLine267: TppLine;
    ppLine268: TppLine;
    ppLine269: TppLine;
    ppLine270: TppLine;
    ppLabelTPriceName: TppLabel;
    EtvPpDBTextTPriceName: TEtvPpDBText;
    ppLine244: TppLine;
    ppLine245: TppLine;
    ppLabel171: TppLabel;
    ppLine271: TppLine;
    ppLine272: TppLine;
    ppLabel201: TppLabel;
    ppLine273: TppLine;
    ppLine274: TppLine;
    ppLine275: TppLine;
    ppLabel203: TppLabel;
    EtvPpDBText75: TEtvPpDBText;
    EtvPpDBText83: TEtvPpDBText;
    InvoiceVDeclarDepot: TSmallintField;
    InvoiceVDeclarDepotName: TStringField;
    InvoiceVDeclarDifferBid: TFloatField;
    InvoiceVByDeclarDepot: TSmallintField;
    InvoiceVByDeclarDepotName: TStringField;
    InvoiceVByDeclarPointUnloading: TStringField;
    InvoiceVByDeclarDifferBid: TFloatField;
    InvoiceVTDeclarDepot: TSmallintField;
    InvoiceVTDeclarDepotName: TStringField;
    InvoiceVTDeclarPointUnloading: TStringField;
    InvoiceVTDeclarSummaBid: TFloatField;
    InvoiceVTDeclarDifferBid: TFloatField;
    ppLine276: TppLine;
    ppLabel148: TppLabel;
    ppLabel204: TppLabel;
    EtvPpDBText74: TEtvPpDBText;
    ppLine277: TppLine;
    ppLine278: TppLine;
    InvoiceVByDeclarTOrg: TSmallintField;
    ppLabelNote: TppLabel;
    ppLabelNoteRail: TppLabel;
    RepInsideHeaderBand1: TppHeaderBand;
    RepInsideDetailBand1: TppDetailBand;
    RepInsideLabel1: TppLabel;
    RepInsideSenderStation: TppLabel;
    RepInsideDBSenderStation: TEtvPpDBText;
    RepInsideOrgStation: TppLabel;
    RepInsideDBOrgStation: TEtvPpDBText;
    RepInsidevDBSenderName: TEtvPpDBText;
    RepInsidevDBSenderOrgStation: TEtvPpDBText;
    RepInsidevDBOrgName: TEtvPpDBText;
    RepInsidevDBOrgOrgStation: TEtvPpDBText;
    RepInsidevDBSenderAddress: TEtvPpDBText;
    RepInsidevDBSenderKodBn: TEtvPpDBText;
    RepInsidevDBSenderBCount: TEtvPpDBText;
    RepInsidevDBOrgAddress: TEtvPpDBText;
    RepInsidevDBSenderBankName: TEtvPpDBText;
    RepInsidevDBSenderBankPlaceName: TEtvPpDBText;
    RepInsideDBGroupPos: TEtvPpDBText;
    RepInsidevDBScheme: TEtvPpDBText;
    RepInsideProdName: TppLabel;
    RepInsidevPpDBText1: TEtvPpDBText;
    EtvPpDBText34: TEtvPpDBText;
    InvoiceVDeclarTOwnerShip: TXEListField;
    InvoiceVDeclarProdDensity: TSmallintField;
    InvoiceVDeclarProdShop: TSmallintField;
    InvoiceVDeclarProdShopName: TStringField;
    InvoiceVDeclarClassCargo: TStringField;
    ppLabelNoteBrickInFacture: TppLabel;
    InvoiceVDeclarCashSection: TXEListField;
    TrustType: TLinkSource;
    TrustTypeDeclar: TLinkTable;
    TrustTypeDeclarKod: TSmallintField;
    TrustTypeDeclarName: TStringField;
    TrustTypeDeclarNameDative: TStringField;
    TrustTypeDeclarVerb: TStringField;
    TrustTypeDeclarVerbAblative: TStringField;
    TrustTypeC: TDBFormControl;
    N3: TMenuItem;
    TrustType1: TLinkMenuItem;
    TrustTypeLookup: TLinkQuery;
    TrustTypeLookupKod: TSmallintField;
    TrustTypeLookupName: TStringField;
    TrustTypeLookupNameDative: TStringField;
    TrustTypeLookupVerb: TStringField;
    TrustTypeLookupVerbAblative: TStringField;
    InvoiceDeclarTrustType: TSmallintField;
    InvoiceDeclarTrustTypeName: TXELookField;
    InvoiceDeclarTrustWhom: TStringField;
    EtvPpDBText35: TEtvPpDBText;
    InvoiceVDeclarProdLength: TFloatField;
    InvoiceVDeclarProdHeight: TSmallintField;
    InvoiceVDeclarProdWidth: TFloatField;
    InvoiceVByDeclarProdLength: TFloatField;
    InvoiceVByDeclarProdHeight: TSmallintField;
    InvoiceVByDeclarProdWidth: TFloatField;
    InvoiceVByDeclarProdDensity: TSmallintField;
    InvoiceVByDeclarProdShop: TSmallintField;
    InvoiceVByDeclarProdShopName: TStringField;
    InvoiceVDeclarParentOrgName: TStringField;
    InvoiceProdDDeclarNote: TStringField;
    EtvPpDBText36: TEtvPpDBText;
    InvoiceVDeclarTActivityName: TStringField;
    InvoiceVByDeclarSummaBy2: TFloatField;
    InvoiceVDeclarNote: TStringField;
    InvoiceVByDeclarExtra: TFloatField;
    procedure InvoiceProdDeclarCalcFields(DataSet: TDataSet);
    procedure InvoiceProdDDeclarCalcFields(DataSet: TDataSet);
    procedure InvoiceDeclarCalcFields(DataSet: TDataSet);
    procedure InvoiceProdDProcessCalcFields(DataSet: TDataSet);
    procedure InvoiceProdDDeclarAfterPost(DataSet: TDataSet);
    procedure InvoiceProdPDeclarCalcFields(DataSet: TDataSet);
    procedure InvoiceCalculated(InNumInvoice: string; InDate:TDateTime; var Summa,SummaWVAT,
      TareWeight,Weight:Double;var TareAmount: smallint; var TareName:String;
       var Currency:smallint; var Contract: string; var SummaClose: Double);
    procedure InvoiceDeclarNewRecord(DataSet: TDataSet);
    procedure InvoiceProdDDeclarNewRecord(DataSet: TDataSet);
    procedure ModuleInvoiceCreate(Sender: TObject);
    procedure InvoiceDeclarSDateValidate(Sender: TField);
    procedure InvoiceDeclarClientValidate(Sender: TField);
    procedure InvoiceDeclarAfterPost(DataSet: TDataSet);
    procedure InvoiceDeclarBeforePost(DataSet: TDataSet);
    procedure InvoiceDeclarKodValidate(Sender: TField);
    function DeclarDateNameFilter(Sender: TObject): String;
    procedure DeclarDateNameSetEditValue(Sender: TField; Text: String);
    procedure InvoiceRailDeclarNewRecord(DataSet: TDataSet);
    procedure InvoiceRailDeclarBeforeInsert(DataSet: TDataSet);
    procedure InvoiceDeclarAfterScroll(DataSet: TDataSet);
    procedure RepAbroadBeforePrint(Sender: TObject);
    procedure RepInsideBeforePrint(Sender: TObject);
    procedure InvoiceDeclarOrgNameChange(Sender: TField);
    procedure InvoiceDeclarDriverChange(Sender: TField);
    procedure InvoiceCActivateForm(Sender: TObject);
    procedure InvoiceCCreateForm(Sender: TObject);
    procedure InvoiceDeclarKodChange(Sender: TField);
    procedure InvoiceProdDDeclarBeforePost(DataSet: TDataSet);
    procedure InvoiceVG1Click(Sender: TObject);
    procedure ppGroupFooterBand2BeforePrint(Sender: TObject);
    procedure PLInvoiceProdTraversal(Sender: TObject);
    procedure PLInvoiceProdFirst(Sender: TObject);
    procedure InvoiceProdDDeclarAfterScroll(DataSet: TDataSet);
    procedure InvoiceProdDDeclarBeforeInsert(DataSet: TDataSet);
    procedure N2Click(Sender: TObject);
    function DeclarContractNameDFilter(Sender: TObject): String;
    procedure FactureVATDataChange(Sender: TObject; Field: TField);
    procedure FactureVATDeclarNewRecord(DataSet: TDataSet);
    procedure FactureVATDeclarCalcFields(DataSet: TDataSet);
    procedure InvoiceVCCreateForm(Sender: TObject);
    procedure FactureProdDeclarAfterPost(DataSet: TDataSet);
    procedure FactureDeclarCalcFields(DataSet: TDataSet);
    procedure EtvPpDBText50GetText(Sender: TObject; var Text: String);
    procedure FactureDeclarAfterPost(DataSet: TDataSet);
    procedure EtvPpDBText51GetText(Sender: TObject; var Text: String);
    procedure FactureDeclarNewRecord(DataSet: TDataSet);
    procedure EtvPpDBText67GetText(Sender: TObject; var Text: String);
    procedure InvoiceDeclarContractChange(Sender: TField);
    function ContractDeclarGoalPurchaseNameFilter(Sender: TObject): String;
    procedure ppSummaryBand1BeforePrint(Sender: TObject);
    procedure RepInvoiceStartPage(Sender: TObject);
    procedure EtvPpDBText126GetText(Sender: TObject; var Text: String);
    procedure DeclarProdDChange(Sender: TField);
    procedure EtvPpDBText64GetText(Sender: TObject; var Text: String);
    procedure DeclarProdNameDGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure RepFactureBeforePrint(Sender: TObject);
    procedure EtvPpDBText100GetText(Sender: TObject; var Text: String);
    procedure InvoiceDeclarClientChange(Sender: TField);
    procedure FactureCActivateForm(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InvoiceDataChange(Sender: TObject; Field: TField);{ TDataChangeEvent;}
    procedure GridTitleClick(Column:TColumn);
    { Инициализирует дополнительные поля для вывода бланка накладной на печать }
    { aDataSet - текущий DataSet для Invoice }
    procedure InitInvoiceAdd(aDataSet:TDataSet);
    { Public declarations }
  end;

  TCClass = class(TControl); //used to resize

  Function NumberToWordsCurrency(aSumma: Double; aCurrency: Smallint):String;

var ModuleInvoice: TModuleInvoice;
    MyMetric: TLnUserMetric;
    MassaTara: String;
    OldTransport: SmallInt;
    CloneRegime: boolean=false; { Режим клонирования 0 - выключен, 1 - включен }
    {function ModuleInvoice: TModuleInvoice;}

    TareWeight,             { Вес тары          }
    Weight,                 { Вес               }
    SummaInvoice: Double;   { Сумма             }
    SummaWVAT: Double;      { Сумма с НДС (до 01.01.2000=Summa) }
    TareAmount:smallint;    { Кол-во тары       }
    TareName: string;       { Наименование тары }
    Currency: smallint;     { Код валюты        }
    Contract: string;       { Контракт (или неск. контрактов ч/з запятую по накладной) }
    SummaClose: Double;   { Накладная оплачена на сумму           }
    SumAmount: Double=0;  { Сумма по количеству в бланке накладной }
    UnitMStr: string[20];
    MassaNameAdd:string;
    InvoiceProdRowCount: smallint=0;
    RepInvoice2009: boolean=true; // С 01.05.2009 Введены в действие новые бланки накладных, где стало меньше инфо
                                  // Использую одну и ту же обработку шаблонов, там где надо, буду использовать тек. флаг

Implementation

Uses Windows, EtvPages, SForm, MdBase, MdCommon, MdProd, MdOrgs, Dialogs, EtvBor, Invoice, FactureVAT,
     SysUtils, BEForms, ppTypes, ppViewr, XApps, EtvContr, Misc, DiDate, MdGeography, MdContr, MdClientsAdd;

Var InvoiceChanged,
    InvoicePayerChanged,
    NumInvoiceChanged,      { флаг изменения номера документа       }
    SDateChanged: boolean;  { флаг изменения даты выписки документа }
    AutoRailRow: boolean;   { флаг автозаведения строки с ж/д тарифом (пустой) }
    MassaForOneRow: string;
    ResultDlg: word;
    II:integer=0;
    aNumInvoice: string[15]; { запоминаем значение для автоматического расчета нового номера }
    aPayerLookField: TXELookField;
    aPayer: integer;        { код плательщика по накладной }
    aFactureSummaVAT, aFactureSumma: double; { Переменные для инициализации сумм прописью }
    aClientNameField: string[10]; // Временное решение. ПРАВИЛЬНОЕ РЕШЕНИЕ. ПОЛЕ OrgName переименовать в ClientName везде аккуратно по проекту.

{$R *.DFM}

(*
function ModuleInvoice: TModuleInvoice;
begin
  if not Assigned(fModuleInvoice) then begin
    fModuleInvoice:=TModuleInvoice.Create(Application);
  end;
  Result:=fModuleInvoice;
end;
*)

Function NumberToWordsCurrency(aSumma: Double; aCurrency: Smallint):String;
var i:byte;
begin
  { Инициализация MyMetric }
  Result:='';
  for i:=1 to 3 do MyMetric[0,i]:='';
  with ModuleInvoice.InvoiceProdDProcess1 do begin
  {try}
    Close;
    Params.ParamByName('Currency').Value:=aCurrency;
    Open;
    with ModuleInvoice do begin
      MyMetric[0,1]:=' '+Nominative2.Value;
      MyMetric[0,2]:=' '+Genitive2.Value;
      MyMetric[0,3]:=' '+NameDop2.Value;
      MyMetric[1,1]:=' '+Nominative.Value;
      MyMetric[1,2]:=' '+Genitive1.Value;
      MyMetric[1,3]:=' '+NameDop.Value;
    end;
    Close;
  {except
    Exit;}
  end;
  Result:=NumberToWords(aSumma, mtSumUser, @MyMetric);
end;

Function InitNumInvoice:String;
var lPartSDate:String[4];
begin
  Result:='';
  with ModuleBase.QueriesDeclar,ModuleInvoice.InvoiceDeclarSDate do begin
    lPartSDate:=Copy(Text,1,2)+Copy(Text,4,2);
    SQL.Clear;
    SQL.Add('select max(kod) from STA.Invoice where kod like ''+'+
      lPartSDate+'__'' and (sDate='''+DateToStr(Date)+''')');
    Open;
    if Fields[0].AsString<>'' then
      Result:=IntToStr(StrToInt(Copy(Fields[0].AsString,2,6))+1)
    else Result:=lPartSDate+'01';
    if Length(Result)=5 then Result:='0'+Result;
    Result:='+'+Result;
    SQL.Clear;
  end;
end;

{ Контроль на дублирование № накладной+Дата выписки документа }
Function CheckDuplicationNumInvoiceSDate(NumInvoice,sDate: variant):boolean;
begin
  Result:=false;
  with ModuleInvoice do begin
    if not (InvoiceDeclar.State in [dsInsert,dsEdit]) then Exit;
    if not InvoiceProcess.Active then InvoiceProcess.Open;
    if InvoiceProcess.Locate('Kod;SDate',
      {VarArrayOf([InvoiceDeclarKod.Value,InvoiceDeclarSDate.Value]),[]) then begin}
      VarArrayOf([NumInvoice,SDate]),[]) then begin
      {
      MessageDlg('Поле: '+InvoiceDeclarKod.DisplayLabel+' '+InvoiceDeclarKod.Value+#13+
                 InvoiceDeclarSDate.DisplayLabel+' '+InvoiceDeclarSDate.AsString+#13+
                'Дублирование значений. Очистить поле и Продолжить работу?',mtWarning,[mbOk],0);
      }
      Result:=true;
    end;
  end;
end;

Procedure TModuleInvoice.InvoiceCalculated(InNumInvoice: string; InDate:TDateTime;
  var Summa,SummaWVAT,TareWeight,Weight:Double; var TareAmount: smallint;
  var TareName:String; var Currency: smallint; var Contract: string; var SummaClose:Double);
begin
  try
    InvoiceCalculatedQuery.Params.ParamByName('InNumInvoice').Value:=InNumInvoice;
    InvoiceCalculatedQuery.Params.ParamByName('InDate').Value:=InDate;
    InvoiceCalculatedQuery.Open;
    SummaInvoice:=InvoiceCalculatedQuerySumma.Value;
    SummaWVAT:=InvoiceCalculatedQuerySummaWVAT.Value;
    TareWeight:=InvoiceCalculatedQueryTareWeight.Value;
    Weight:=InvoiceCalculatedQueryWeight.Value;
    TareAmount:=InvoiceCalculatedQueryTareAmount.Value;
    TareName:=InvoiceCalculatedQueryTareName.Value;
    Currency:=InvoiceCalculatedQueryCurrency.Value;
    Contract:=InvoiceCalculatedQueryContract.Value;
    SummaClose:=InvoiceCalculatedQuerySummaClose.Value;
  finally
    InvoiceCalculatedQuery.Close;
  end;
end;

{ ЭТА ТАБЛИЦА ТОЛЬКО ДЛЯ ЧТЕНИЯ!!! }
Procedure TModuleInvoice.InvoiceProdDeclarCalcFields(DataSet: TDataSet);
begin
(*
  { Проверка на корректность содержания полей }
  if (DeclarDatePrice.Value=0) or
     (DeclarProd.Value=0) or
     (DeclarAmount.Value=0) or
     (DeclarTPrice.Value=0)
     {or (DeclarTareD.Value=0)} then Exit;

   ModuleProd.PriceOnDate(DeclarProd.Value,DeclarTare.Value,
                  DeclarTPrice.Value,DeclarDatePrice.AsString,
                  ThisPrice,ThisRateVAT,ThisBid,ThisDatePrice);
   if ThisPrice=0 then Exit;
   {DeclarDatePriceD.Value:=ThisDatePrice;}
   DeclarPrice.Value:=ThisPrice;
   DeclarPriceBid.Value:=ThisBid;
   if ThisPrice=0 then Exit;

   { Учитывая, что по частным лицам работает торговая надбавка }
   { Округление полученной цены до 1000 рублей  (aRound)       }
   if DeclarClient.AsInteger=0 then begin
     DeclarPrice.Value:=DeclarPrice.Value*(1+DeclarPriceBid.Value/100);
     if (DeclarPrice.AsInteger mod aRound)>0 then
       DeclarPrice.Value:=MRound(DeclarPrice.Value/aRound)*aRound;
   end;
   { Учитываем % некондиции }
   if DeclarDefective.Value>0 then
     DeclarPrice.Value:=DeclarPrice.Value*(1-DeclarDefective.Value/100);
   DeclarSumma.Value:=DeclarPrice.Value*DeclarAmount.Value;
   { Округление суммы по строке продукции до aRound, если валюта - BYB }
   if (DeclarTPriceName.StringByLookName('CurrencyName')='BYB') and
    (DeclarSumma.AsInteger mod aRound>0) then
      DeclarSumma.Value:=MRound(DeclarSumma.Value/aRound)*aRound;

   DeclarWeight.Value:=MRound(
     (StrToFloat('0'+TrimLeft(DeclarProdName.StringByLookName('Massa')))*DeclarAmount.Value+
     StrToFloat('0'+TrimLeft(DeclarTareName.StringByLookName('Weight')))*DeclarPackage.Value));
*)
end;

(* Старый вариант процедуры. 10.06.2006 начал делать новую версию
Procedure TModuleInvoice.InvoiceProdDDeclarCalcFields(DataSet: TDataSet);
begin
  { Для ТРАНСПОРТНЫХ УСЛУГ автоматом заполняем поле TPrice }
  { чтобы легче можно было определить условие для фильтра Lookup'ного DataSet'a }
  if ((DeclarProdD.Value=46001) or (DeclarProdD.Value=46002)) then begin
    if (DeclarTPriceD.IsNull) then begin
      DeclarTPriceD.AsVariant:=GetFromSQLText(InvoiceProdD.DataBaseName,
          'select GetTransportChargesType('''+DeclarNumInvoiceD.AsString+''','''
          +DeclarSDateD.AsString+''')',false);
    end;
    { Подцепляем фильтр к Lookup'ному полю DeclarTPriceNameD }
{
    if not Assigned(DeclarTPriceNameD.OnFilter) then
      DeclarTPriceNameD.OnFilter:=ModuleProd.TPriceNameFilter;
}
  end;
{
  else
    // Отцепляем фильтр от Lookup'ного поля DeclarTPriceNameD
    if Assigned(DeclarTPriceNameD.OnFilter) then DeclarTPriceNameD.OnFilter:=nil;
}
  { Проверка на корректность содержания полей }
  if ((DeclarDatePriceD.IsNull) or
     (DeclarProdD.IsNull) or
     {(DeclarAmountD.IsNull) or}
     (DeclarTPriceD.IsNull) or
     (DeclarTareD.IsNull))
     {or (DeclarTareD.Value=0)} then begin
    DeclarPriceD.Clear;
    DeclarSummaD.Clear;
    DeclarWeightD.Clear;
    Exit;
  end;

  ModuleProd.PriceOnDate(DeclarProdD.Value,DeclarTareD.Value,
    DeclarTPriceD.Value,DeclarBaseTPriceD.Value,DeclarDatePriceD.AsString,
    ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
  if (ThisPrice=0) and (ThisDatePrice=0) then begin
    DeclarPriceD.Clear;
    DeclarSummaD.Clear;
    DeclarWeightD.Clear;
    Exit;
  end;
  aRound:=RoundRB(DataSet.FieldByName('DateModify').AsDateTime,(InvoiceDeclarClient.Value=0));
  if {(DataSet.State in [dsEdit,dsInsert])} true then begin
    DeclarPriceD.Value:=ThisPrice;
    DeclarPriceBidD.Value:=ThisBid;
    DeclarPriceExtraD.Value:=ThisExtra;
    // LevLabel.Caption:=IntToStr(StrToInt(LevLabel.Caption)+1);
    // Ставка НДС
    if (InvoiceDeclarClient.Value=0) or
      (GetFromSQLText(InvoiceProdD.DataBaseName,
          'select GetClientIsShop('+IntToStr(aPayer)+')',false)=1) then
          RateVATD.Value:=0
    else RateVATD.Value:=(ThisRateVAT-1)*100;
    // Учитываем, что по частным лицам работает торговая надбавка
    // Округление полученной цены до aRound рублей
    if {DeclarClientD.AsInteger=0}(InvoiceDeclarClient.Value=0) then begin
    // С 1 января 2000 г. цена в справочнике без НДС, поэтому в формировании цены
    // мы добавляем НДС b
    //if DeclarSDateD.Value>=Date01012000 then k:=1.2 else k:=1;
      DeclarPriceD.Value:=DeclarPriceD.Value*(1+DeclarPriceBidD.Value/100)*ThisRateVAT{k};
     //DeclarPriceD.Value:=MRound(DeclarPriceD.Value*(1+DeclarPriceBidD.Value/100)*ThisRateVAT{k});
      if DeclarPriceD.Value>0 then
        DeclarPriceD.Value:=RoundSummaAll(DeclarPriceD.Value,974,DeclarDateModifyD.Value);
    end;
    // Учитываем % некондиции
    if (DeclarDefectiveD.Value<>0) then
      DeclarPriceD.Value:=DeclarPriceD.Value*(1-DeclarDefectiveD.Value/100);
  end;
  // Если валюта - белорусские рубли, то округляем до aRound иначе до 0.1
  if DeclarTPriceNameD.ValueByLookName('Currency')=974 then begin
    {if DeclarClientD.AsInteger=0 then
      DeclarSummaD.Value:=MRound(DeclarPriceD.Value*DeclarAmountD.AsFloat/1000)*1000
    else}
    // ОШИБКА ФУНКЦИИ ROUND!!!!!!!!!!!!!!!!!!!
    // if Frac(D)=0.5 then D:=D+0.01;
    // DeclarSummaD.Value:=Round(D)*aRound;
    if Abs(DeclarPriceD.AsFloat*(1+DeclarPriceExtraD.Value/100)*DeclarAmountD.AsFloat)>1000 then
      SummaWVATD.Value:=MRound((DeclarPriceD.AsFloat/aRound)*(1+DeclarPriceExtraD.Value/100)*DeclarAmountD.AsFloat)*aRound
    else SummaWVATD.Value:=MRound(DeclarPriceD.AsFloat*(1+DeclarPriceExtraD.Value/100)*DeclarAmountD.AsFloat);
    if {(DataSet.State in [dsEdit,dsInsert]) and} (Abs(SummaWVATD.Value)>0) then begin
{   ЭТО ПРИСОВОЕНИЕ ЕСТЬ ВЫШЕ. ПОПОЗЖЕ УДАЛИТЬ!
      // Ставка НДС 20%
      if (DeclarSDateD.Value>=Date01012000) and (InvoiceDeclarClient.Value<>0) then RateVATD.Value:=20
      else RateVATD.Value:=0;
}
      // Сумма c НДС
      DeclarSummaD.AsFloat:=SummaWVATD.Value*(1+RateVATD.Value/100);
      if Abs(DeclarSummaD.AsFloat)>1000 then // округление
        DeclarSummaD.AsFloat:=MRound(DeclarSummaD.AsFloat/aRound)*aRound
      else DeclarSummaD.AsFloat:=MRound(DeclarSummaD.AsFloat);
    end
  end else begin // Валюта - не рубли РБ
    SummaWVATD.Value:=RoundSummaAll(DeclarPriceD.Value*(1+DeclarPriceExtraD.Value/100)*DeclarAmountD.AsFloat,
                                    DeclarTPriceNameD.ValueByLookName('Currency'),DeclarSDateD.Value);
    {
    if DeclarSDateD.Value<Date01062002 then
      SummaWVATD.Value:=MRound(DeclarPriceD.Value*DeclarAmountD.AsFloat*10)/10
    else
      SummaWVATD.Value:=MRound(DeclarPriceD.Value*DeclarAmountD.AsFloat*100)/100;
    }
    if {(DataSet.State in [dsEdit,dsInsert])}true then begin
      DeclarSummaD.AsFloat:=RoundSummaAll(SummaWVATD.Value*ThisRateVAT,
                                          DeclarTPriceNameD.ValueByLookName('Currency'),DeclarSDateD.Value);
      //DeclarSummaD.AsFloat:=MRound(DeclarSummaD.AsFloat*10)/10;
    end;
  end;
  // Сумма НДС
  SummaVATD.Value:=DeclarSummaD.Value-SummaWVATD.Value;
  DeclarWeightD.Value:=MRound(
    (StrToFloat('0'+TrimLeft(DeclarProdNameD.StringByLookName('Massa')))*DeclarAmountD.Value+
    StrToFloat('0'+TrimLeft(DeclarTareNameD.StringByLookName('Weight')))*DeclarPackageD.Value));
  if DeclarPackageD.IsNull then DeclarTareProdD.Value:=''
  else DeclarTareProdD.Value:=FloatToStrF(DeclarAmountD.AsFloat/DeclarPackageD.AsFloat,ffGeneral,3,2);
end;
*)

Procedure TModuleInvoice.InvoiceProdDDeclarCalcFields(DataSet: TDataSet);
var aDateTime: TDateTime;
    i: integer;
begin
with TTable(DataSet) do try
  AutoCalcFields:=false;
  // Для выписки счетов-фактур
  if (FieldByName('Prod').Value=99007) and (FieldByName('DatePrice').IsNull) then begin
    //AutoCalcFields:=false;
    FieldByName('TPrice').Value:=1;
    FieldByName('Tare').Value:=0;
    FieldByName('BaseTPrice').Value:=0;
    FieldByName('DatePrice').AsString:='01.06.06';
    for i:=0 to Fields.Count-1 do
      if Fields[i].FieldKind=fkLookup then TFieldBorland(Fields[i]).CalcLookupValue;
    //AutoCalcFields:=true;
    if Assigned(MasterSource) and (MasterSource.DataSet.FindField('ClientSaldo')<>nil) then
      FieldByName('Amount').Value:=-MasterSource.DataSet.FieldByName('ClientSaldo').Value;
  end;
  // Для ТРАНСПОРТНЫХ УСЛУГ автоматом заполняем поле TPrice
  // чтобы легче можно было определить условие для фильтра Lookup'ного DataSet'a
  if ((FieldByName('Prod').Value=46001) or (FieldByName('Prod').Value=46002)) then begin
    if (FieldByName('TPrice').IsNull) then begin
      FieldByName('TPrice').AsVariant:=GetFromSQLText(InvoiceProdD.DataBaseName,
          'select GetTransportChargesType('''+FieldByName('NumInvoice').AsString+''','''
          +FieldByName('SDate').AsString+''')',false);
    end;
  end;
  // Проверка на корректность содержания полей
  if ((FieldByName('DatePrice').IsNull) or
     (FieldByName('Prod').IsNull) or
     //(DeclarAmountD.IsNull) or
     (FieldByName('TPrice').IsNull) or
     (FieldByName('Tare').IsNull))
     {or (DeclarTareD.Value=0)} then begin
    FieldByName('PriceCalc').Clear;
    FieldByName('SummaCalc').Clear;
    FieldByName('Weight').Clear;
    Exit;
  end;

  ModuleProd.PriceOnDate(FieldByName('Prod').Value,FieldByName('Tare').Value,
    FieldByName('TPrice').Value,FieldByName('BaseTPrice').Value,FieldByName('DatePrice').AsString,
    ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
  if (ThisPrice=0) and (ThisDatePrice=0) then begin
    FieldByName('PriceCalc').Clear;
    FieldByName('SummaCalc').Clear;
    FieldByName('Weight').Clear;
    Exit;
  end else
    if (FieldByName('Prod').AsInteger-90000 in [31..34]) and (State=dsInsert) then begin
    { По огромной просьбе трудящихся из состава диспетчеров по отгрузке                     }
    { Случай вычисления цены для залоговой тары NOT(для частников или магазина) до 07.06.11 }
      if (ThisDatePrice<StrToDate('07.06.2011')) and (MasterSource.DataSet.FieldByName('Client').Value<>0) and
         (Telf(MasterSource.DataSet.FieldByName(aClientNameField)).StringByLookName('INN')<>'500038966') and (ThisRateVAT=1) then
           ModuleProd.PriceOnDate(FieldByName('Prod').Value, FieldByName('Tare').Value,
             FieldByName('TPrice').Value,FieldByName('BaseTPrice').Value,DateToStr(ThisDatePrice-1),
               ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
      { После 07.06.11. Т.к. цену залоговой тары для магазинов пришлось вносить 06.06.11 }
      { !!! (ThisRateVAT=1.2)-УСЛОВИЕ НЕ РАБОТАЕТ!!! В переменной ThisRateVAT сидит значение 1.199999999999.... }
      { !!! и ни в какую не хочет принимать значение 1.2 }
      if (ThisDatePrice>=StrToDate('07.06.11')) and ((MasterSource.DataSet.FieldByName('Client').AsInteger=0)
        or (Telf(MasterSource.DataSet.FieldByName(aClientNameField)).StringByLookName('INN')='500038966')) and (ThisRateVAT>1) then
           ModuleProd.PriceOnDate(FieldByName('Prod').Value, FieldByName('Tare').Value,
             FieldByName('TPrice').Value,FieldByName('BaseTPrice').Value,DateToStr(ThisDatePrice-1),
               ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
    end;
  // Развилка на разные DataSet'ы: InvoiceProdD и FactureProd
  if FindField('DateModify')<>nil then aDateTime:=FieldByName('DateModify').AsDateTime
  else aDateTime:=FieldByName('sDate').AsDateTime;
  // Расчет aRound для ЦЕНЫ
  aRound:=RoundRB(aDateTime,(Assigned(MasterSource) and Assigned(MasterSource.DataSet)
    and (MasterSource.DataSet.FieldByName('Client').Value=0)),TRUE);
  if {(DataSet.State in [dsEdit,dsInsert])} true then begin
    FieldByName('PriceCalc').Value:=ThisPrice;
    FieldByName('PriceBidCalc').Value:=ThisBid;
    FieldByName('PriceExtraCalc').Value:=ThisExtra;
    //LevLabel.Caption:=IntToStr(StrToInt(LevLabel.Caption)+1);

    // Ставка НДС - развилка для накладных и счетов-фактур
    // Если клиент - частник или магазин, то ставка НДС - 0%.
    if (DataSet.Name='InvoiceProdDDeclar') and
      ((InvoiceDeclarClient.Value=0) or (GetFromSQLText(InvoiceProdD.DataBaseName,
          'select GetClientIsShop('+IntToStr(aPayer)+')',false)=1)) then
          FieldByName('RateVATCalc').Value:=0
    else FieldByName('RateVATCalc').Value:=(ThisRateVAT-1)*100;

    // Учитываем, что по частным лицам работает торговая надбавка
    // Округление полученной цены до aRound рублей
    if {DeclarClientD.AsInteger=0}(Assigned(MasterSource) and
      Assigned(MasterSource.DataSet) and (MasterSource.DataSet.FieldByName('Client').Value=0)) then begin
    // С 1 января 2000 г. цена в справочнике без НДС, поэтому в формировании цены
    // мы добавляем НДС b
    // if DeclarSDateD.Value>=Date01012000 then k:=1.2 else k:=1;
      FieldByName('PriceCalc').Value:=FieldByName('PriceCalc').Value*(1+ThisExtra/100)*
        (1+FieldByName('PriceBidCalc').Value/100)*ThisRateVAT;
      if FieldByName('PriceCalc').Value>0 then
        FieldByName('PriceCalc').Value:=
          RoundSummaAll(FieldByName('PriceCalc').Value,974,FieldByName('DateModify').Value,true,true);
    end else if Assigned(MasterSource) and Assigned(MasterSource.DataSet) and (Telf(FieldByName('TPriceName')).ValueByLookName('Currency')=974) then
      if FieldByName('PriceCalc').Value>0 then
        FieldByName('PriceCalc').Value:=
          RoundSummaAll(FieldByName('PriceCalc').Value,974,aDateTime{FieldByName('DateModify').Value},false,true);
    // Учитываем % некондиции
    if (FieldByName('Defective').AsInteger<>0) then
      FieldByName('PriceCalc').Value:=FieldByName('PriceCalc').Value*
       (1-FieldByName('Defective').Value/100);
  end;
  // Расчет aRound не для ЦЕНЫ, а для СУММЫ
  aRound:=RoundRB(aDateTime,(Assigned(MasterSource) and Assigned(MasterSource.DataSet) and (MasterSource.DataSet.FieldByName('Client').Value=0)),FALSE);

  // Если валюта - белорусские рубли, то округляем до aRound иначе до 0.1 }
  if Telf(FieldByName('TPriceName')).ValueByLookName('Currency')=974 then begin
    // ОШИБКА ФУНКЦИИ ROUND!!!!!!!!!!!!!!!!!!! }
    // if Frac(D)=0.5 then D:=D+0.01;}
    // DeclarSummaD.Value:=Round(D)*aRound;
    if Abs(FieldByName('PriceCalc').AsFloat*FieldByName('Amount').AsFloat)>1000 then
      // По частнику скидку(наценку) расчитали раньше, она уже сидит в цене
      if (Assigned(MasterSource) and Assigned(MasterSource.DataSet) and (MasterSource.DataSet.FieldByName('Client').Value=0)) then
        FieldByName('SummaWVAT').AsFloat:=MRound(FieldByName('PriceCalc').AsFloat/aRound*FieldByName('Amount').AsFloat)*aRound
      else
        FieldByName('SummaWVAT').AsFloat:=MRound(FieldByName('PriceCalc').AsFloat*
          // А по оптовым клиентам добавляем в расчет скидку(наценку)
          (1+FieldByName('PriceExtraCalc').Value/100)/aRound*FieldByName('Amount').AsFloat)*aRound
    else FieldByName('SummaWVAT').AsFloat:=MRound(FieldByName('PriceCalc').AsFloat*FieldByName('Amount').AsFloat);
    if Abs(FieldByName('SummaWVAT').Value)>0 then begin
      // Сумма c НДС
      FieldByName('SummaCalc').AsFloat:=FieldByName('SummaWVAT').Value*(1+FieldByName('RateVATCalc').Value/100);
      if Abs(FieldByName('SummaCalc').AsFloat)>1000 then // округление
        FieldByName('SummaCalc').AsFloat:=MRound(FieldByName('SummaCalc').AsFloat/aRound)*aRound
      else FieldByName('SummaCalc').AsFloat:=MRound(FieldByName('SummaCalc').AsFloat);
    end
  end else begin // Валюта - не рубли РБ
    FieldByName('SummaWVAT').Value:=
      RoundSummaAll(FieldByName('PriceCalc').Value*(1+FieldByName('PriceExtraCalc').Value/100)*FieldByName('Amount').AsFloat,
        Telf(FieldByName('TPriceName')).ValueByLookName('Currency'),FieldByName('SDate').Value,false,false);
    FieldByName('SummaCalc').AsFloat:=RoundSummaAll(FieldByName('SummaWVAT').Value*ThisRateVAT,
      Telf(FieldByName('TPriceName')).ValueByLookName('Currency'),FieldByName('SDate').Value,false,false);
  end;
  // Сумма НДС
  FieldByName('SummaVAT').Value:=FieldByName('SummaCalc').Value-FieldByName('SummaWVAT').Value;
  FieldByName('Weight').AsFloat:=MRound(
    (StrToFloat('0'+TrimLeft(Telf(FieldByName('ProdName')).StringByLookName('Massa')))*FieldByName('Amount').AsFloat+
    StrToFloat('0'+TrimLeft(Telf(FieldByName('TareName')).StringByLookName('Weight')))*FieldByName('Package').AsInteger))/1000.0;
  if (FieldByName('Package').IsNull) or (FieldByName('Package').AsInteger=0) then
     FieldByName('TareProd').Value:=''
  else FieldByName('TareProd').Value:=
    FloatToStrF(FieldByName('Amount').AsFloat/FieldByName('Package').AsFloat,ffGeneral,3,2);
(* Заготовка
  { Обработка для блоков длительного хранения }
  if FieldByName('DateName').AsString='23.11.09' then
    Telf(FieldByName('ProdName')).Values
*)
finally
  AutoCalcFields:=true;
end;
end;

Procedure TModuleInvoice.InvoiceDeclarCalcFields(DataSet: TDataSet);
begin
(*
  InvoiceCalculated(InvoiceDeclarKod.Value,InvoiceDeclarSDate.Value,
       Summa,TareWeight,Weight,TareAmount,TareName,Currency);
*)
  if DataSet.State=dsInsert then Exit;
  with DataSet do begin
    InvoiceCalculated(FieldByName('Kod').AsString,FieldByName('SDate').AsDateTime,
      SummaInvoice,SummaWVAT,TareWeight,Weight,TareAmount,TareName,Currency,Contract,SummaClose);
  { Поторопим InvoiceProdDDeclar }
(*
  with InvoiceProdDDeclar do begin
    {DisableControls;}
    if IndexName='InvoiceProdNumInvoice' then IndexFieldNames:='NumInvoice'
    else IndexName:='InvoiceProdNumInvoice';
    {EnableControls;}
  end;
*)
    { Инициализация aRound }
(*
    if FieldByName('SDate').AsDateTime<StrToDateTime('01.04.99') then aRound:=100
    else aRound:=1000;
*)  aRound:=RoundRB(FieldByName('SDate').AsDateTime,(InvoiceDeclarClient.Value=0),false);

    if SummaInvoice>0 then begin
      FieldByName('SummaName').AsString:=NumberToWordsCurrency(SummaInvoice, Currency);
      FieldByName('SummaVATName').AsString:=NumberToWordsCurrency(Round(SummaInvoice-SummaWVAT) div aRound, Currency);
    end else FieldByName('SummaName').AsString:='';
    FieldByName('MassaName').AsString:=NumberToWords(Weight/1000.0, mtBigWeight, nil);
    { Добавляем массу тары, если тара есть...}
    if TareWeight>0 then begin
      MassaTara:='  МАССА ТАРЫ '+FloatToStr(TareWeight)+' КГ.';
      with FieldByName('MassaName') do AsString:=AsString+MassaTara
    end else MassaTara:='';
    {FieldByName('Summa2').AsFloat:=FieldByName('Summa').AsFloat+FieldByName('TransportPay').AsFloat;}
    DataSet.FieldByName('SummaClose').AsFloat:=SummaClose;
    { Определяем LookField настоящего плательщика }
    if InvoiceDeclarPayer.IsNull then begin
      aPayer:=InvoiceDeclarClient.Value;
      aPayerLookField:=InvoiceDeclarOrgName;
    end else begin
      aPayer:=InvoiceDeclarPayer.Value;
      aPayerLookField:=InvoiceDeclarPayerName;
    end;
  end;
end;

Procedure TModuleInvoice.InvoiceProdDProcessCalcFields(DataSet: TDataSet);
begin
(*
  with ProdModule,ProdModule.ProdPriceProcess do begin
    { Определяем цену на текущую ПРОДУКЦИЮ в  }
    { текущей УПАКОВКЕ по текущему ТИПУ ЦЕНЫ на текущую ДАТУ }
    if not ProdModule.ProdPriceProcess.Active then
      ProdModule.ProdPriceProcess.Active:=true;
    FindNearest([ProcessProdD.Value,ProcessTareD.Value,
                 ProcessTPriceD.Value,ProcessDatePriceD.Value]);
    Next;
    if not ProdModule.ProdPriceProcess.EOF then begin
      Prior;
      Prior;
    end;
    if (ProcessProdD.Value=ProdPriceProcessProd.Value) and
      (ProcessTareD.Value=ProdPriceProcessTare.Value) and
      (ProcessTPriceD.Value=ProdPriceProcessTPrice.Value)and
      (ProcessDatePriceD.Value>=ProdPriceProcessSDate.Value) then begin
      ProcessPriceD.Value:=ProdPriceProcessPrice.Value;
      { Учитываем % некондиции }
      if ProcessDefectiveD.Value>0 then
        ProcessPriceD.Value:=
          ProcessPriceD.Value*ProcessDefectiveD.Value/100;
      ProcessSummaD.Value:=ProcessPriceD.Value*ProcessAmountD.Value;
    end;
    Val(ProcessProdNameD.ValueByName('Massa'),D,Code);
    ProcessWeightD.Value:=D*ProcessAmountD.Value;
  end;
  *)
end;

Procedure TModuleInvoice.InvoiceProdDDeclarAfterPost(DataSet: TDataSet);
begin
  InvoiceDeclar.Edit;
  InvoiceDeclarAfterScroll(nil);
  InvoiceDeclar.CheckBrowseMode;
end;

Procedure TModuleInvoice.InvoiceProdPDeclarCalcFields(DataSet: TDataSet);
begin
(*
  { Проверка на корректность содержания полей }
  if (DeclarDatePriceP.Value=0) or
     (DeclarProdP.Value=0) or
     (DeclarAmountP.Value=0) or
     (DeclarTPriceP.Value=0)
     {or (DeclarTareP.Value=0)} then Exit;

  with ProdModule, ProdModule.ProdPriceProcess do begin
    { Расчитываем вес продукции = (кол-во)*(масса ед.продукции)  }
    Val(DeclarProdNameP.ValueByName('Massa'),D,Code);
    DeclarWeightP.Value:=D*DeclarAmountP.Value;
    { Определяем цену на текущую ПРОДУКЦИЮ в  }
    { текущей УПАКОВКЕ по текущему ТИПУ ЦЕНЫ на текущую ДАТУ }
    if not ProdModule.ProdPriceProcess.Active then
      ProdModule.ProdPriceProcess.Active:=true;
    FindNearest([DeclarProdP.Value,DeclarTareP.Value,
                 DeclarTPriceP.Value,DeclarDatePriceP.Value]);
    Next;
    if not ProdModule.ProdPriceProcess.EOF then begin
      Prior;
      Prior;
    end;
    if (DeclarProdP.Value=ProdPriceProcessProd.Value) and
      (DeclarTareP.Value=ProdPriceProcessTare.Value) and
      (DeclarTPriceP.Value=ProdPriceProcessTPrice.Value)and
      (DeclarDatePriceP.Value>=ProdPriceProcessSDate.Value) then begin
      DeclarPriceP.Value:=ProdPriceProcessPrice.Value;
      { Учитываем % некондиции }
      if DeclarDefectiveP.Value>0 then
        DeclarPriceP.Value:=DeclarPriceP.Value*DeclarDefectiveP.Value/100;
      DeclarSummaP.Value:=DeclarPriceP.Value*DeclarAmountP.Value;
    end else DeclarPriceP.Value:=0;
  end;
  *)
end;

Procedure TModuleInvoice.InvoiceDeclarNewRecord(DataSet: TDataSet);
var b:byte;
    aNewNumInvoice: string[15];
begin
  try
    InvoiceDeclar.OnCalcFields:=nil;
    {
    with InvoiceDeclarKodSender do begin
      ReadOnly:=False;
      Value:=900000;
      ReadOnly:=True;
    end;
    with InvoiceDeclarKodCountSender do begin
      ReadOnly:=False;
      Value:=836;
      ReadOnly:=True;
    end;
    }
    { Блокировка повторной работы при переключении по Ctrl+Shift+Z }
    OldTRansport:=0;
    if TFormInvoice(InvoiceC.Form).LabelTransport.Visible=false then
      InvoiceDataChange(nil,nil);
    if (InvoiceDeclarKod.Value<>'') or (InvoiceDeclarSDate.Value<>0) then Exit;

    with InvoiceDeclarSDate do begin
      {ReadOnly:=False;}
      Value:=FormStart.MainDate.Date;
      {ReadOnly:=True;}
    end;
    InvoiceDeclar.FieldByName('TTransport').Value:=1;
    InvoiceDeclarDispatcher.Value:=ModuleBase.UsersDeclarEmpNo.Value;
    InvoiceDeclarSupported.Value:=1;
    {InvoiceDeclarClient.Value:=0;}

    if aNumInvoice<>'' then begin
      aNewNumInvoice:=IntToStr((StrToInt(aNumInvoice)+1));
      { Проблема с ведущими нулями }
      b:=Length(aNumInvoice)-Length(aNewNumInvoice);
      if b>0 then aNewNumInvoice:=Copy(aNumInvoice,1,b)+aNewNumInvoice;
      if not CheckDuplicationNumInvoiceSDate(aNewNumInvoice,InvoiceDeclarSDate.Value) then
        InvoiceDeclarKod.Value:=aNewNumInvoice;
    end;
    with TFormInvoice(InvoiceC.Form) do begin
      TEtvPageControl(DetailPages).DisableControl;
      DetailPages.ActivePage:=TabSheet2;
      TEtvPageControl(DetailPages).EnableControl;
    end;
  finally
    InvoiceDeclar.OnCalcFields:=InvoiceDeclarCalcFields;
  end;
end;

Procedure TModuleInvoice.InvoiceProdDDeclarNewRecord(DataSet: TDataSet);
begin
  InvoiceProdDDeclar.OnCalcFields:=nil;
  {DeclarTPriceNameD.OnFilter:=nil;}
  try
    DeclarDatePriceD.Value:=InvoiceDeclarSDate.Value;
    DeclarDateModifyD.Value:=InvoiceDeclarSDate.Value;
    DeclarDefectiveD.Value:=0;
    { Обработка белорусских клиентов от торговли и наоборот }
    if (aPayerLookField.ValueByLookName('Country')=30) and (DeclarTPriceD.Value=0) then begin
      { Клиент - торговая организация }
      if (aPayerLookField.ValueByLookName('TActivity')=22) then
        case InvoiceDeclarTTransport.Value of
          { Самовывоз }
          1: DeclarTPriceD.Value:=1;
          { Центровывоз }
          2: DeclarTPriceD.Value:=3; {3 - до 31.07.01 и с 15.08.01} {1 - c 31.07.01 по 15.08.01}
          { Ж/Д транспорт в пределах РБ }
          3: DeclarTPriceD.Value:=2; {2 - до 31.07.01 и с 15.08.01} {1 - c 31.07.01 по 15.08.01}
        end
      else { Клиент обычный }
        case InvoiceDeclarTTransport.Value of
          { Самовывоз }
          1: DeclarTPriceD.Value:=1;
          { Центровывоз }
          2: DeclarTPriceD.Value:=1;
          { Ж/Д транспорт в пределах РБ }
          3: DeclarTPriceD.Value:=34; {34 - до 31.07.01 и с 15.08.01} {1 - c 31.07.01 по 15.08.01}
        end;
      // Инициализация базового типа цены
      DeclarBaseTPriceD.Value:=0;
    end;
    if AutoRailRow then begin
      DeclarTareD.Value:=0;
      DeclarAmountD.Value:=0;
      DeclarProdD.Value:=46002;
    end;
  finally
    InvoiceProdDDeclar.OnCalcFields:=InvoiceProdDDeclarCalcFields;
    if AutoRailRow then InvoiceProdDDeclar.Post;
  end;
end;

Procedure TModuleInvoice.ModuleInvoiceCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  Invoice.OnDataChange:=InvoiceDataChange;
  DeclarTareNameD.OnFilter:=ModuleProd.TareNameFilter;
  FactureProdDeclarTareName.OnFilter:=ModuleProd.TareNameFilter;
  DeclarTPriceNameD.OnFilter:=ModuleProd.TPriceNameFilter;
  DataSetViewLabel(InvoiceVDeclar);
  {DataSetViewLabel(InvoiceVTDeclar);}
  {InvoiceProdDDeclar.Active:=true;}
  RepInside.Template.FileName:=DirShb+'\RepIns.RTM';
  RepInvCopy.Template.FileName:=DirShb+'\RepInvcCopy.RTM';
  RepInvoice.Template.FileName:=DirShb+'\RepInvoice.RTM';
  RepAbroad.Template.FileName:=DirShb+'\RepAbr.rtm';
  RepFacture.Template.FileName:=DirShb+'\RepFacture.rtm';
  RepFactureVAT.Template.FileName:=DirShb+'\RepFactureVAT.rtm';
  if not ModuleBase.IsProgrammers then InvoiceVTC1.Enabled:=false;
end;

Procedure TModuleInvoice.InvoiceDataChange(Sender: TObject; Field: TField);
var TTransportField: TSmallIntField;
    aPayerFieldName: string[9];
begin
  { Исключаем лишнюю работу }
  if (not((Assigned(Field) and (Field.FieldName='TTransport'))
    or ((Sender=nil) and (Field=nil))))
    and not(Assigned(Sender) and (Sender.ClassName='TLinkSource')) then Exit;

  { Идет обработка комбинации клавиш <Ctrl+Shift+Z> }
  if (Sender is TLinkSource) and (TLinkSource(Sender).DataSet.Tag=99) then Exit;

  with Invoice.DataSet,TFormInvoice(InvoiceC.Form) do begin
    { Определяем имя поля настоящего плательщика }
    if FieldByName('Payer').IsNull then aPayerFieldName:='OrgName'
    else aPayerFieldName:='PayerName';
    { Обработка LabelTrade из формы TFormInvoice }
    if TEtvLookField(FieldByName(aPayerFieldName)).ValueByLookName('TActivity')=22 then
      LabelTrade.Visible:=true
    else LabelTrade.Visible:=false;
    { Обработка замков на накладные }
    if InvoiceDeclarIsLock.Value=0 then begin
      ButtonLockOpen.Visible:=true;
      ButtonLockClose.Visible:=false;
    end else begin
      ButtonLockOpen.Visible:=false;
      ButtonLockClose.Visible:=true;
    end;

    TTransportField:=TSmallIntField(FieldByName('TTransport'));
    if OldTransport=TTransportField.Value then Exit;
                                                    { Условия для вызова самостоятельно }
    if (InvoiceC.Form=nil) and (Sender is TForm) then InvoiceC.Form:=TForm(Sender);
    if (((Invoice.DataSet.State=dsBrowse) or ((Sender=nil) and (Field=nil))) and
      (TTransportField.Value<>null)) or
      (Field=TTransportField) then begin
        if TTransportField.Value in [3,4] then begin
          LabelTransport.Caption:='ж/д квитанция №';
          LabelNumAdd.Caption:='Вагон №';
          {LabelTransport.Visible:=false;}
          LabelTransplantName.Visible:=false;
          LabelDriver.Visible:=false;
          LabelTrailer.Visible:=false;
          {EditTransport.Visible:=false;}
          EditTransPlantName.Visible:=false;
          EditTrailer.Visible:=false;
          EditDriver.Visible:=false;
          TabSheet3.TabVisible:=true;
          {TabSheet3.Visible:=true;}
          { Не показываем поля про доверенности }
          LabelTrustType.Visible:=false;
          EditTrustTypeName.Visible:=false;
          LabelTrustNum.Visible:=false;
          EditTrustNum.Visible:=false;
          LabelTrustDate.Visible:=false;
          EditTrustDate.Visible:=false;
          DBTextTrust.Visible:=false;
          LabelTrust.Visible:=false;
          EditTrust.Visible:=false;
          EditTrustWhom.Visible:=false;
          TrustWhomDBText.Visible:=false;
          {
          LabelDriver1.Visible:=false;
          EditDriver1.Visible:=false;
          }
          {}
          if TTransportField.Value=4 then begin
            MemoProd.Visible:=true;
            LabelNameProdRail.Visible:=true;
            GridBoundaryStations.Visible:=true;
            Label20.Visible:=true;
            EditColumn_20.Visible:=true;
            Label4.Visible:=true;
            EditColumn_4.Visible:=true;
            LabelDirection.Visible:=true;
            EditDirectName.Visible:=true;
          end else begin
            MemoProd.Visible:=false;
            LabelNameProdRail.Visible:=false;
            GridBoundaryStations.Visible:=false;
            Label20.Visible:=false;
            EditColumn_20.Visible:=false;
            Label4.Visible:=false;
            EditColumn_4.Visible:=false;
            LabelDirection.Visible:=false;
            EditDirectName.Visible:=false;
            if (State=dsInsert) then begin
              if FieldByName('Supported').AsInteger=1 then
                FieldByName('Supported').AsInteger:=0;
              with FieldByName('Kod') do if (AsString='') then AsString:=InitNumInvoice{'+'}{'?'}
            end;
          end;
        end else begin
          if DetailPages.ActivePage.Name='TabSheet3'
            then begin
              DetailPages.SendToPage(0);
              DetailPages.ActivePage:=TabSheet1;
              DetailPages.SendToPage(1);
              {TabSheet1.SetFocus;}
            end;
          {TabSheet3.Visible:=false;}
          TabSheet3.TabVisible:=false;
          LabelTransport.Caption:='Автомобиль';
          LabelNumAdd.Caption:='П/лист №';
          {LabelTransport.Visible:=True;}
          LabelTransplantName.Visible:=True;
          LabelDriver.Visible:=True;
          LabelTrailer.Visible:=True;
          {EditTransport.Visible:=True;}
          EditTransPlantName.Visible:=True;
          EditTrailer.Visible:=True;
          EditDriver.Visible:=True;
          MemoProd.Visible:=false;
          LabelNameProdRail.Visible:=false;
          if State=dsInsert then begin
            if FieldByName('Supported').AsInteger=0 then FieldByName('Supported').AsInteger:=1;
            with FieldByName('Kod') do
              if Copy(AsString,1,1)='+'{'?'} then AsString:='';
          end;
          { Показываем поля про доверенности }
          LabelTrustType.Visible:=true;
          EditTrustTypeName.Visible:=true;
          LabelTrustNum.Visible:=true;
          EditTrustNum.Visible:=true;
          LabelTrustDate.Visible:=true;
          EditTrustDate.Visible:=true;
          DBTextTrust.Visible:=true;
          LabelTrust.Visible:=true;
          EditTrust.Visible:=true;
          //EditTrustWhom.Visible:=true; -- Это поле по умолчанию невидимо.
          TrustWhomDBText.Visible:=true;
          {
          LabelDriver1.Visible:=true;
          EditDriver1.Visible:=true;
          }
          {}
        end;
      OldTransport:=TTransportField.Value;
    end;
  end;
end;

Procedure TModuleInvoice.GridTitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field.FieldName<>'ProdName' then Exit;
  with TXELookField(Column.Field) do
    if LookUpLevelUp<>'' then begin
      LookUpLevelUp:='';
      LookUpLevelDown:='';
      LookUpFilterField:='AmountDown';
      LookUpFilterKey:='0';
      Column.Title.Caption:='Продукция (ЛИСТЬЯ)';
    end else begin
      LookUpLevelUp:='KodUp';
      LookUpLevelDown:='AmountDown';
      LookUpFilterField:='';
      LookUpFilterKey:='';
      Column.Title.Caption:='Продукция (ДЕРЕВО)';
    end;
end;

{ Инициализирует дополнительные поля для вывода бланка накладной на печать }
Procedure TModuleInvoice.InitInvoiceAdd(aDataSet: TDataSet);

var EField:TEtvLookField;
    SenderName, ClientName, PayerName, TransportClientName, PointUnloading: string;
    ClientKod, PayerKod: Variant;
    ClientIsShop: boolean;
    aPos: byte;
    aKodBn: string[9]; { Код банка может быть Kod, а м.б. RKC из SprBank }

begin
  if not InvoiceAddSet.Active then InvoiceAddSet.Open;
  InvoiceAddSet.Edit;
  with aDataSet do begin
    { Инициализация длинных переменных }
    EField:=TEtvLookField(FieldByName('CountSenderName'));
    if EField.StringByLookName('RKC')='' then aKodBn:=EField.StringByLookName('KodBn') else aKodBn:=EField.StringByLookName('RKC');
    SenderName:=TEtvLookField(FieldByName('SenderName')).StringByLookName('FullName')+', '+
      TEtvLookField(FieldByName('SenderName')).StringByLookName('Address');

    if not RepInvoice2009 then // После 01.05.09 банковские реквизиты по клиентам, заказчикам, плательщикам печатать не надо
      SenderName:=SenderName+', р/с '+EField.StringByLookName('BCount')+' код '+aKodBn+' '+
        EField.StringByLookName('BankName')+', '+EField.StringByLookName('Address');
    PayerName:=TEtvLookField(FieldByName('PayerName')).StringByLookName('FullName')+', '+TEtvLookField(FieldByName('PayerName')).StringByLookName('Address');
    PayerKod:=FieldByName('Payer').AsInteger;
    if PayerKod=0 then PayerName:='';

    if FieldByName('Client').AsInteger<>0 then begin
      EField:=TEtvLookField(FieldByName('CountOrgName'));
      if EField.StringByLookName('RKC')='' then aKodBn:=EField.StringByLookName('KodBn') else aKodBn:=EField.StringByLookName('RKC');
      ClientName:=TEtvLookField(FieldByName('OrgName')).StringByLookName('FullName')+', '+TEtvLookField(FieldByName('OrgName')).StringByLookName('Address');
      if not RepInvoice2009 then
        { Если плательщика нет, значит наим. клиента формируем по полному варианту иначе по укороченному }
        if (PayerName='') then begin
          //ClientName:=ClientName+', '+TEtvLookField(FieldByName('OrgName')).StringByLookName('Address');
          ClientName:=ClientName+', р/с '+EField.StringByLookName('BCount')+' код '+aKodBn+' '+EField.StringByLookName('BankName')+', '+EField.StringByLookName('Address');
        end else with ModuleOrgs do begin
          //PayerName:=PayerName+', '+TEtvLookField(FieldByName('PayerName')).StringByLookName('Address');
          if OrgBankLookup.Locate('Org;TCount',VarArrayOf([PayerKod,1]),[])
          or OrgBankLookup.Locate('Org',PayerKod,[]) then
            PayerName:=PayerName+', р/с '+OrgBankLookupBCount.AsString+' код '+
            OrgBankLookupKodBn.AsString+' '+OrgBankLookupBankName.AsString+', '+OrgBankLookupAddress.AsString;
        end;
      //ClientName:=ClientName+', '+TEtvLookField(FieldByName('OrgName')).StringByLookName('Address');
      InvoiceAddSetTrustStr.Value:='доверенности';
    end else begin
      ClientName:='По договору №'+FieldByName('TrustNum').AsString+' от '+
        FieldByName('TrustDate').AsString+' гр-н '+FieldByName('Trust').AsString;
      InvoiceAddSetTrustStr.Value:='договору';
    end;
    ClientKod:=FieldByName('Client').AsInteger;
    ClientIsShop:=GetFromSQLText(InvoiceProdD.DataBaseName,
      'select GetClientIsShop('+IntToStr(ClientKod)+')',false)=1;

    if PayerName='' then begin
      PayerName:=ClientName;
      PayerKod:=ClientKod;
      ClientName:='';
      ClientKod:=null;
      PointUnloading:=FieldByName('PointUnloading').AsString;
      // Инициализация УНН, ОКПО и № лицензии получателя для печати в накладной
      InvoiceAddSetPayerINN.Value:=TEtvLookField(FieldByName('OrgName')).StringByLookName('INN');
      InvoiceAddSetPayerOKPO.Value:=TEtvLookField(FieldByName('OrgName')).StringByLookName('OKPO');
      InvoiceAddSetPayerLic.Value:=TEtvLookField(FieldByName('OrgName')).StringByLookName('Licence');
    end else begin
      InvoiceAddSetPayerINN.Value:=TEtvLookField(FieldByName('PayerName')).StringByLookName('INN');
      InvoiceAddSetPayerOKPO.Value:=TEtvLookField(FieldByName('PayerName')).StringByLookName('OKPO');
      InvoiceAddSetPayerLic.Value:=TEtvLookField(FieldByName('PayerName')).StringByLookName('Licence');
      PointUnloading:=ClientName;
    end;

    { Инициализация заказчика-плательщика автотранспорта }
    if FieldByName('TransportClient').AsInteger>0 then begin
      TransportClientName:=TEtvLookField(FieldByName('TransportClientName')).StringByLookName('FullName')+', '+
        TEtvLookField(FieldByName('TransportClientName')).StringByLookName('Address');
    end else
      if FieldByName('TransportClientStr').AsString<>'' then
        TransportClientName:=FieldByName('TransportClientStr').AsString
      else
        if not RepInvoice2009 then TransportClientName:=PayerName
        else TransportClientName:='';
    InvoiceAddSetTransportClient.Value:=TransportClientName;

    { Дата выписки накладной }
    InvoiceAddSetsDate.Value:=DateToStrEtv(FieldByName('SDate').AsDateTime);
    case FieldByName('TTransport').AsInteger of
         0: begin
             InvoiceAddSetAutoName.Value:='Паспорт';
             InvoiceAddSetWayPaper.Value:='';
            end;
      1..2: begin
             InvoiceAddSetAutoName.Value:='Автомобиль';
             InvoiceAddSetWayPaper.Value:='к путевому листу №';
           end;
      3..4: begin
             InvoiceAddSetAutoName.Value:='Ж/д квитанция № ';
             InvoiceAddSetWayPaper.Value:='вагон №';
           end;
    end;
    if ClientIsShop then
      InvoiceAddSetLabContr.Value:='Договора с покупателями'
    else
      if (FieldByName('Contract').AsString<>'') then begin
        if (DeclarTPriceD.Value in [1,2,3,34]) then InvoiceAddSetLabContr.Value:='Договор № '
        else InvoiceAddSetLabContr.Value:='Контракт № ';
        InvoiceAddSetLabContr.Value:=InvoiceAddSetLabContr.Value+FieldByName('Contract').AsString+
        ' от '+TEtvLookField(FieldByName('ContractName')).StringByLookName('sDate');
        if Pos('ПЕРЕРАСЧЕТ ОТГРУЗКИ',AnsiUpperCase(FieldByName('PointUnloading').AsString))>0 then
          InvoiceAddSetLabContr.Value:=InvoiceAddSetLabContr.Value+', '+
            TEtvLookField(FieldByName('ContractName')).StringByLookName('Remark1');
      end else InvoiceAddSetLabContr.Value:='';
    // SenderName:=AnsiUpperCase(SenderName); // Печатаем наше предприятие БОЛЬШИМИ БУКВАМИ
    case FieldByName('TTransport').AsInteger of
      0: begin { Будаунiк Гродно }
           InvoiceAddSetTransPlantName.Value:='';
           InvoiceAddSetTTransport.Value:='';
           InvoiceAddSetPayer.Value:=PayerName;
           InvoiceAddSetPayerShort.Value:='';
           InvoiceAddSetSenderName.Value:=SenderName;
         end;
      1: begin { Самовывоз }
           if FieldByName('TransPlantName').IsNull then
             if ((FieldByName('TransPlantStr').IsNull) or (FieldByName('TransPlantStr').Value='')) then
               if not RepInvoice2009 then
                 InvoiceAddSetTransPlantName.Value:='Собственный транспорт'
               else InvoiceAddSetTransPlantName.Value:='Грузополучатель'
             else InvoiceAddSetTransPlantName.AsString:=FieldByName('TransPlantStr').AsString
           else
             InvoiceAddSetTransPlantName.Value:=
               TEtvLookField(FieldByName('TransPlantName')).StringByLookName('Name');
           InvoiceAddSetTTransport.Value:='Автотранспорт';
           InvoiceAddSetPayer.Value:=PayerName;
           // Кем выдана доверенность (свидетельство, приказ, договор)
           if FieldByName('TrustWhom').AsString<>'' then InvoiceAddSetPayerShort.Value:=FieldByName('TrustWhom').AsString
           else
             if PayerKod=0 then InvoiceAddSetPayerShort.Value:=''
             else InvoiceAddSetPayerShort.Value:=Copy(PayerName,1,Pos(',',PayerName)-1);
           InvoiceAddSetSenderName.Value:=SenderName;
         end;
      2: begin { Центровывоз }
           InvoiceAddSetTransPlantName.Value:=
             TEtvLookField(FieldByName('TransPlantName')).StringByLookName('Name');
           InvoiceAddSetTTransport.Value:='Автотранспорт';
           if PayerName='' then begin
             InvoiceAddSetPayer.Value:=SenderName;
           // Кем выдана доверенность (свидетельство, приказ, договор)
           if FieldByName('TrustWhom').AsString<>'' then InvoiceAddSetPayerShort.Value:=FieldByName('TrustWhom').AsString
           else InvoiceAddSetPayerShort.Value:=Copy(SenderName,1,Pos(',',SenderName)-1);
             InvoiceAddSetSenderName.Value:='ОН ЖЕ';
           end else begin
             InvoiceAddSetPayer.Value:=PayerName;
             // Кем выдана доверенность (свидетельство, приказ, договор)
             if FieldByName('TrustWhom').AsString<>'' then InvoiceAddSetPayerShort.Value:=FieldByName('TrustWhom').AsString
             else InvoiceAddSetPayerShort.Value:=Copy(PayerName,1,Pos(',',PayerName)-1);
             InvoiceAddSetSenderName.Value:=SenderName;
           end;
         end;
      3..4:
         begin { Ж/Д в пределах РБ }
           InvoiceAddSetTransPlantName.Value:='';
           if PayerKod<>205000 then InvoiceAddSetTTransport.Value:='Вид перевозки Ж/д транспорт';
           InvoiceAddSetPayer.Value:=PayerName;
           InvoiceAddSetPayerShort.Value:='';
           InvoiceAddSetSenderName.Value:=SenderName;
         end;
    end;
    InvoiceAddSetPayerKod.AsVariant:=PayerKod;
    InvoiceAddSetClientkod.AsVariant:=ClientKod;
    InvoiceAddSetPointUnloading.Value:=PointUnloading;
    InvoiceAddSetDepotName.AsString:=TEtvLookField(FieldByName('DepotName')).StringByLookName('Name')+
      ', '+TEtvLookField(FieldByName('SenderName')).StringByLookName('Address');

    // Доп. информация для условия поставки
    if InvoiceProdDDeclar.FieldByName('BaseTPrice').Value=8 then
      InvoiceAddSetBaseTPriceNameAdd.Value:='. Для строительства на селе. Рентабельность 5%.'
    else
      // Для частных лиц и магазина дополнительная надпись на накладной 10.08.01
      // if (PayerKod=0) or (PayerKod=205000) or (FieldByName('GoalPurchase').AsInteger in [1,2,3]) then InvoiceAddSetBaseTPriceNameAdd.Value:='. Для жилищного строительства.'
      // 11.01.08 выяснилось, что задача поставлена не правильно. А правильным будет цепляться к типу цены.
      // Если тип цены - для жилищного строительства, то тогда и фразу соответствующую печатаем.
      if (InvoiceProdDDeclar.FieldByName('BaseTPrice').Value=10) or (PayerKod=0) or ClientIsShop then
        InvoiceAddSetBaseTPriceNameAdd.Value:='. Для жилищного строительства.'
    else InvoiceAddSetBaseTPriceNameAdd.Value:='';

    if Pos('бартер',AnsiLowerCase(DeclarTPriceNameD.StringByLookName('Name')))>0 then
      InvoiceAddSetIsBarter.Value:='Бартер'
    else InvoiceAddSetIsBarter.Value:='';
    InvoiceAddSetClientName.Value:=ClientName;
    InvoiceAddSetCurrencyNameDop.Value:=MyMetric[1,3]+' ('+
    DeclarTPriceNameD.StringByLookName('CurrencyName')+')';

    { Корректировка массы по накладной }
    MassaNameAdd:='';
    if not InputQuery('Изменение расчетного веса',
      'Введите суммарный вес по накладной',MassaNameAdd) then Exit;
    if MassaNameAdd<>'' then begin
      MassaNameAdd:=NumberToWords(Abs(StrToFloat(MassaNameAdd)), mtBigWeight, nil);
      InvoiceAddSetMassaNameAdd.Value:=MassaNameAdd+MassaTara;
    end else InvoiceAddSetMassaNameAdd.Value:=FieldByName('MassaName').AsString;
    if TEtvLookField(FieldByName('OrgName')).ValueByLookName('Country')<>30 then
      InvoiceAddSetCountryProd.Value:='СТРАНА ПРОИСХОЖДЕНИЯ ТОВАРА - РЕСПУБЛИКА БЕЛАРУСЬ'
    else InvoiceAddSetCountryProd.Clear;
    with ModuleBase do begin
      if (FieldByName('TareAmount').AsInteger>0) then begin
        { Обработка нескольких видов СП в поле TareName }
        aPos:=System.Pos(',',aDataSet.FieldByName('TareName').AsString);
        if aPos=0 then aPos:=Length(FieldByName('TareName').AsString)
        else aPos:=aPos-1;
        if (TareLookup.Locate('Name',Copy(FieldByName('TareName').AsString,1,aPos),[loPartialKey]))
          and (TareLookupSReturn.Value in [0,1,3,4]) then
          InvoiceAddSetTareMessage.Value:=
            AnsiUpperCase(FieldByName('TareName').AsString)+' В КОЛИЧЕСТВЕ '+
              FieldByName('TareAmount').AsString+' ШТ. - ТАРА '+
                AnsiUpperCase(Copy(TareLookupSReturn.Values[TareLookupSReturn.Value],5,30))
        else InvoiceAddSetTareMessage.Clear;
        // Кол-во грузовых мест прописью
        InvoiceAddSetTareAmountName.Value:=NumberToWords(FieldByName('TareAmount').AsInteger, mtFullNothing, nil);
      end else begin
        InvoiceAddSetTareAmountName.Value:='';
        InvoiceAddSetTareMessage.Value:='';
      end;  
    end;
  end;
  InvoiceAddSet.Post;
end;


Procedure TModuleInvoice.InvoiceDeclarSDateValidate(Sender: TField);
begin
  if Sender.DataSet.State=dsFilter then Exit;
  with TFormStart(ModuleBase.UsersC.Form) do
    if (UserName<>'LEV') and (UserName<>'BAUSHA') and (UserName<>'SHURA') and
    (UserName<>'OLGA') and (UserName<>'ANNA') and (UserName<>'ADMIN') and
    (Copy(InvoiceDeclarSDate.AsString,7,2)<>Copy(EditCurMonth.Text,7,2)) and
    not((Copy(InvoiceDeclarSDate.AsString,4,2)='12') or (Copy(EditCurMonth.Text,4,2)='01')) then begin
      ShowMessage('Недопустимая дата');
      {Sender.Value:=EditCurMonth.Date;}
      {InvoiceDeclarSDate.Value:=EditCurMonth.Date;}
      {TFormInvoice(InvoiceC.Form).EditSDate.Date:=EditCurMonth.Date;}
      Abort;
    end;
    { Контроль на дублирование № накладной+Дата выписки документа }
    if CheckDuplicationNumInvoiceSDate(InvoiceDeclarKod.Value,InvoiceDeclarSDate.Value) then begin
      ResultDlg:=MessageDlg('Поле: '+InvoiceDeclarKod.DisplayLabel+' '+InvoiceDeclarKod.Value+#13+
                 InvoiceDeclarSDate.DisplayLabel+' '+InvoiceDeclarSDate.AsString+#13+
                'Дублирование значений',mtWarning,[mbOk],0);
      Abort
    end;
end;

Procedure TModuleInvoice.InvoiceDeclarKodValidate(Sender: TField);
var I,Code:integer;
    PosError:byte;
begin
  if (Sender=InvoiceDeclarKod) and (InvoiceDeclar.State in [dsInsert,dsEdit]) then begin
    { Контроль за вводом символов в поле "№ накладной" }
    Val(Copy(InvoiceDeclarKod.Value,2,7), I, Code);
    if InvoiceDeclar.State=dsInsert then begin
      if InvoiceDeclarKod.Value='+'{'?'} then Code:=0;
      if InvoiceDeclarKod.Value='' then Exit;
    end;
    if ((Code <> 0) and (InvoiceDeclarKod.Value[7]<>'/') and (InvoiceDeclarKod.Value[8]<>'*'))
    or not(InvoiceDeclarKod.Value[1] in['0'..'9','+','?'{,'/','~'}]) then begin
      Beep;
      if (Code<>0) then PosError:=Code+1 else PosError:=1;
      MessageDlg('Поле: № НАКЛАДНОЙ'+#13+
                 'Ошибка ввода в позиции: '+IntToStr(PosError),mtWarning,[mbOk],0);
      Abort;
    end;
    { Контроль на дублирование № накладной+Дата выписки документа }
    if CheckDuplicationNumInvoiceSDate(InvoiceDeclarKod.Value,InvoiceDeclarSDate.Value) then begin
      ResultDlg:=MessageDlg('Поле: '+InvoiceDeclarKod.DisplayLabel+' '+InvoiceDeclarKod.Value+#13+
                 InvoiceDeclarSDate.DisplayLabel+' '+InvoiceDeclarSDate.AsString+#13+
                'Дублирование значений',mtWarning,[mbOk],0);
      Abort;
    end;
  end;
end;

Procedure TModuleInvoice.InvoiceDeclarClientValidate(Sender: TField);
begin
  if not(Sender.DataSet.State in [dsInsert,dsEdit]) or
    (InvoiceDeclarKodCountOrg.AsInteger=0) then Exit;
  ModuleOrgs.OrgBankLookup.Locate('AutoInc',InvoiceDeclarKodCountOrg.Value,[]);
  if ModuleOrgs.OrgBankLookupOrg.Value<>Sender.Value then InvoiceDeclarKodCountOrg.Clear;
end;

Procedure TModuleInvoice.InvoiceDeclarAfterPost(DataSet: TDataSet);
var aSource:TDataSource;
    Flag:byte;
begin
  { для корректного пересчета LookUp'ного поля Client и последующего }
  { пересчета цен в InvoiceProd для частников (*торговую надбавку)   }
(*
  aSource:=InvoiceProdDDeclar.MasterSource;
  InvoiceProdDDeclar.MasterSource:=Invoice;
*)

  try
    if InvoiceChanged then begin
(*
      InvoiceProcess.Close;
      InvoiceProcess.Open;
*)
      InvoiceProdDDeclar.Refresh;
      if (NumInvoiceChanged or SDateChanged) and (InvoiceDeclarTTransport.Value in [3,4]) then
        InvoiceRailDeclar.Refresh;
      if InvoicePayerChanged and not CloneRegime then with InvoiceProdDDeclar do
      try
        DisableControls;
        aSource:=InvoiceProdDDeclar.MasterSource;
        InvoiceProdDDeclar.MasterSource:=Invoice;
        First;
        while not Eof do begin
          { Меняем только если Price<>0 }
          if DeclarPriceD.AsInteger<>0 then begin
            Edit;
            Post;
          end;
          Next;
        end;
      finally
        First;
        InvoiceProdDDeclar.MasterSource:=aSource;
        EnableControls;
      end;
    end;
  finally
(*   InvoiceProdDDeclar.MasterSource:=aSource;*)
  end;
  { Проверка на изменение каких-либо полей, влияющих на значение "Сумма" }
  { Чего-то поменялось }
  if not CloneRegime then
    try
      flag:=0;
      if InvoiceDeclarSumma.Value<>SummaInvoice then flag:=flag+1;
      {if StrToFloat('0'+InvoiceDeclarMassa.AsString)<>Weight/1000.0 then flag:=flag+2;}
      { Почему-то в TFloatField хранится не 20.96, а нечто большее, типа 20.960000000000859299999...}
      if Abs(InvoiceDeclarMassa.Value-Weight/1000.0)>0.000000001 then flag:=flag+2;
      if InvoiceDeclarTareAmount.Value<>TareAmount then flag:=flag+4;
      if InvoiceDeclarTareName.Value<>TareName then flag:=flag+8;
      if InvoiceDeclarCurrency.Value<>Currency then flag:=flag+16;
      if InvoiceDeclarContract.Value<>Contract then flag:=flag+32;
      if flag>0 then begin
        InvoiceDeclar.Edit;
        if (flag and 1)>0  then InvoiceDeclarSumma.Value:=SummaInvoice;
        if (flag and 2)>0  then InvoiceDeclarMassa.Value:=Weight/1000.0;
        if (flag and 4)>0  then InvoiceDeclarTareAmount.Value:=TareAmount;
        if (flag and 8)>0  then InvoiceDeclarTareName.Value:=TareName;
        if (flag and 16)>0 then InvoiceDeclarCurrency.Value:=Currency;
        if ((flag and 32)>0) and (InvoiceDeclarContract.AsString='') then InvoiceDeclarContract.Value:=Contract;
      end;
    finally
      if InvoiceDeclar.State=dsEdit then InvoiceDeclar.CheckBrowseMode;
    end;
end;

Procedure TModuleInvoice.InvoiceDeclarBeforePost(DataSet: TDataSet);
var Client: integer;
    Payer: Variant;
begin
  InvoiceChanged:=false;
  InvoicePayerChanged:=false;
  NumInvoiceChanged:=false;
  SDateChanged:=false;

  if InvoiceDeclarTransportPay.IsNull then InvoiceDeclarTransportPay.Value:=0;
  { Проверка на согласованное заполнение полей транспортировки }
  { Все три поля должны быть заполнены одновременно, или все - NULL }
  if not InvoiceDeclarTransportDate.IsNull or (InvoiceDeclarTransportPay.Value<>0)
  or not InvoiceDeclarTransportCurrency.IsNull then begin
    if InvoiceDeclarTransportDate.IsNull or InvoiceDeclarTransportCurrency.IsNull or
    (InvoiceDeclarTransportPay.Value=0) then begin
      ShowMessage('Не заполнены поля транспортного тарифа');
      Abort;
    end;
  end;

  case InvoiceDeclar.State of
    dsInsert:
      begin
        Client:=0;
        Payer:=0;
      end;
    dsEdit:
      begin
        Client:=InvoiceDeclar.OldEditValues[InvoiceDeclarClient.Index];
        Payer:=InvoiceDeclar.OldEditValues[InvoiceDeclarPayer.Index];
        (*
        { Инициализация переменной в случае новой записи }
        if VarIsEmpty(Payer) then Payer:=0;
        *)
      end;
  end;
  { Контроль за вводом кода плательщика 405215 при значении кода клиента=415215. }
  { Это два наших магазина в Бресте. Весь финансовый учет ведется по основному коду - 405215 }
  { Если код не установлен, то устанавливаем значение поля "Плательщик" в 405215, и сообщаем юзеру, кто из нас "чайник" }
  if (InvoiceDeclarClient.Value=415215) and (InvoiceDeclarPayer.Value<>405215) then begin
    InvoiceDeclarPayer.Value:=405215;
    ShowMessage('КОНТРОЛЬ ЗА ВВОДОМ ДАННЫХ! КОД ПЛАТЕЛЬЩИКА УСТАНОВЛЕН В 405215');
  end;

  if (InvoiceDeclar.State=dsInsert) or
  ((InvoiceDeclarClient.Value<>Client) or (InvoiceDeclarPayer.AsVariant<>Payer) or
  (InvoiceDeclarKod.Value<>InvoiceDeclar.OldEditValues[InvoiceDeclarKod.Index]) or
  (InvoiceDeclarSDate.Value<>StrToDate(InvoiceDeclar.OldEditValues[InvoiceDeclarSDate.Index]))) then begin
    InvoiceChanged:=true;
    { Это СУПЕРВАЖНАЯ ОБРАБОТКА!!! Поменялся клиент или плательщик, поэтому  }
    { необходимо пройтись по нижней части таблицы и запостить каждую строку  }
    { для необходимых изменений в таблице InvoiceProd !!!!                   }
    if (InvoiceDeclarClient.Value<>Client) or (InvoiceDeclarPayer.AsVariant<>Payer) then
      InvoicePayerChanged:=true;

    { Т.к. Клиент поменялся, то заполняем поле "Пункт разгрузки" значением по умолчанию }
    { т.е. его адресом }
    if (InvoiceDeclarClient.Value<>Client) and (InvoiceDeclarPointUnloading.AsString='') then begin
      InvoiceDeclarPointUnloading.Value:=InvoiceDeclarOrgName.StringByLookName('Address');
      Exit;
    end;
  end;
  if (InvoiceDeclar.State=dsEdit) then begin
    if (InvoiceDeclarKod.Value<>InvoiceDeclar.OldEditValues[InvoiceDeclarKod.Index]) then
      NumInvoiceChanged:=true;
    if (VarToStr(InvoiceDeclarSDate.AsVariant)<>VarToStr(InvoiceDeclar.OldEditValues[InvoiceDeclarSDate.Index])) then
      SDateChanged:=true;
    { Проверка на удаление всех строк из InvoiceProd в текущей накладной }
    { За исключением ситуации, когда меняем дату накладной               }
    if not SDateChanged and (InvoiceProdDDeclar.RecordCount=0) and (InvoiceDeclarSumma.Value>0) then begin
      InvoiceDeclarSumma.Value:=0;
      InvoiceDeclarMassa.Value:=0;
      InvoiceDeclarTareAmount.Value:=0;
      InvoiceDeclarTareName.Value:='';
      InvoiceDeclarCurrency.Clear;
      InvoiceDeclarContract.Clear;
    end;
  end;
  { Если поле "Пункт разгрузки" пустое, то заполняем его адресом клиента }
  if InvoiceDeclarPointUnloading.AsString='' then
    InvoiceDeclarPointUnloading.Value:=InvoiceDeclarOrgName.StringByLookName('Address');
  { Если грузополучатель - резидент РБ и поле Контракт - не заполнено, то }
  { напоминаем диспетчеру }
  if (InvoiceDeclarOrgName.ValueByLookName('Rezident')=1) and (InvoiceDeclarContract.IsNull) then begin
    TFormInvoice(InvoiceC.Form).EditKod.SetFocus;
    ShowMessage('Внимание! Не заполнено поле КОНТРАКТ...');
  end;
  { Если перерасчет, то добавляем в конец номера символ '*' }
  if (Pos('ПЕРЕРАСЧЕТ ОТГРУЗКИ',AnsiUpperCase(InvoiceDeclarPointUnloading.AsString))>0) and
    (Pos('*',InvoiceDeclarKod.Value)=0) then InvoiceDeclarKod.Value:=InvoiceDeclarKod.AsString+'*';
  { Запоминаем старое значение номера накладной для автоматического расчета нового номера }
  aNumInvoice:=InvoiceDeclarKod.AsString;
end;

Function TModuleInvoice.DeclarDateNameFilter(Sender: TObject): String;
Var TLT: TLinkTable;

Procedure SelectTarePrice;
begin
  with ModuleProd.ProdPriceProcess do
    { Обработка разных цена на залоговую тару для удобства работы диспетчеров }
    if TLT.FieldByName('Prod').AsInteger-90000 in [31..34] then begin
      if ((TLT.MasterSource.DataSet.FieldByName('Client').Value<>900000)
      and (Telf(TLT.MasterSource.DataSet.FieldByName(aClientNameField)).StringByLookName('INN')='500038966')) or (TLT.MasterSource.DataSet.FieldByName('Client').Value=0) then
        Filter:='RateVAT=1' //'((RateVAT=1) or ((sDate>=''07.06.2011'') and (RateVAT>=1)))' -- Неудачная попытка перейти к ценам за залоговую тару с одного дня.
      else
        Filter:='RateVAT>1';
      Filtered:=true;
    end else begin
      Filtered:=false;
      Filter:='';
    end;
end;

begin
(*
  if (DeclarProdD.AsString='') or (DeclarTareD.AsString='') or (DeclarTPriceD.AsString='')
  then begin
    ShowMessage('Недостаточно значений для формирования запроса');
    Abort;
  end;
  Result:='(Prod='+DeclarProdD.AsString+') and (Tare='+
    IntToStr(ModuleProd.GetAnalTare(DeclarTareD.Value))
    +') and (TPrice='+DeclarTPriceD.AsString+')';
*)
  TLT:=TLinkTable(TXELookField(Sender).DataSet);
  if TLT.State in [dsBrowse] then begin
    with ModuleProd.ProdPriceProcess do
      {if DataSource<>TLT.LinkSource then} begin
        Close;
        DataSource:=TLT.LinkSource;
        Params[0].Bound:=false;
        Params[1].Bound:=false;
        Params[2].Bound:=false;
        Params[3].Bound:=false;
        SelectTarePrice;
        Open;
      end;
  end;

  if TLT.State in [dsInsert,dsEdit] then begin
    with ModuleProd.ProdPriceProcess do begin
      Close;
      DataSource:=nil;
      Params.ParamByName('Prod').Value:=TLT.FieldByName('Prod').Value;
      Params.ParamByName('Tare').Value:=TLT.FieldByName('Tare').Value;
      Params.ParamByName('TPrice').Value:=TLT.FieldByName('TPrice').Value;
      Params.ParamByName('BaseTPrice').Value:=TLT.FieldByName('BaseTPrice').Value;
      if TLT.Name='FactureProdDeclar' then
        Params.ParamByName('SDate').Value:=TLT.FieldByName('SDate').Value+20
      else
        Params.ParamByName('SDate').Value:=TLT.FieldByName('SDate').Value;
      SelectTarePrice;
      Open;
    end;
  end;
end;

Procedure TModuleInvoice.DeclarDateNameSetEditValue(Sender: TField; Text: String);
begin
  if not (Sender.DataSet.State in [dsEdit,dsInsert]) then Sender.DataSet.Edit;
  DeclarDatePriceD.AsString:=Text;
end;

Procedure TModuleInvoice.InvoiceRailDeclarNewRecord(DataSet: TDataSet);
begin
  InvoiceRailNumInvoice.Value:=InvoiceDeclarKod.Value;
end;

Procedure TModuleInvoice.InvoiceRailDeclarBeforeInsert(DataSet: TDataSet);
begin
  if not InvoiceRailDeclar.IsEmpty then begin
    ShowMessage('У документа м.б. только одна станция назначения');
    Abort;
  end;
end;

Procedure TModuleInvoice.InvoiceDeclarAfterScroll(DataSet: TDataSet);
var flag:byte;
    {MyMetric: TLnUserMetric;
    i: byte;}
begin
  {exit;}
  {InvoiceCalculated(InvoiceDeclarKod.Value,Summa,Weight,TareAmount,TareName);}
  if (Assigned(Screen.ActiveControl) and (Screen.ActiveControl.Name='Grid'))
    or (InvoiceDeclar.BOF and InvoiceDeclar.EOF) or
     (Assigned(DataSet) and ((DataSet.State=dsInsert) or (DataSet.Name<>'InvoiceDeclar'))) then Exit;
  if not InvoiceProdDDeclar.Active then Exit;
  { Накладная из закрытых периодов уже не должна редактироваться }
  if DeclarDateModifyD.Value<ModuleBase.ConfigDeclarCurPeriod.Value then Exit;
  flag:=0;
  try
    if InvoiceDeclarSumma.Value<>SummaInvoice then flag:=flag+1;
    {if StrToFloat('0'+InvoiceDeclarMassa.AsString)<>Weight/1000.0 then flag:=flag+2;}
    if Abs(InvoiceDeclarMassa.Value-Weight/1000.0)>0.000000001 then flag:=flag+2;
    if InvoiceDeclarTareAmount.Value<>TareAmount then flag:=flag+4;
    if InvoiceDeclarTareName.Value<>TareName then flag:=flag+8;
    if InvoiceDeclarCurrency.Value<>Currency then flag:=flag+16;
    if InvoiceDeclarContract.Value<>Contract then flag:=flag+32;
    {if ((flag div 1)=0) and (Summa>0) and (InvoiceDeclarSummaName.Value='') then flag:=flag+16;}
    if flag>0 then begin
      InvoiceDeclar.Edit;
      if (flag and 1)>0  then InvoiceDeclarSumma.Value:=SummaInvoice;
      if (flag and 2)>0  then InvoiceDeclarMassa.Value:=Weight/1000.0;
      if (flag and 4)>0  then InvoiceDeclarTareAmount.Value:=TareAmount;
      if (flag and 8)>0  then InvoiceDeclarTareName.Value:=TareName;
      if (flag and 16)>0 then InvoiceDeclarCurrency.Value:=Currency;
      if ((flag and 32)>0) and (InvoiceDeclarContract.AsString='') then InvoiceDeclarContract.Value:=Contract;
{
      if (flag and 16)>0 then begin
        for i:=1 to 3 do MyMetric[0,i]:='';
        MyMetric[1,1]:=' '+DeclarTPriceNameD.StringByLookName('Nominative');
        MyMetric[1,2]:=' '+DeclarTPriceNameD.StringByLookName('Genitive');
        MyMetric[1,3]:=' '+DeclarTPriceNameD.StringByLookName('NameDop');
        with TFormInvoice(InvoiceC.Form) do begin
          EditSummaName.Caption:=NumberToWords(Summa, mtSumUser, @MyMetric);
          InvoiceDeclarSummaName.Value:=EditSummaName.Caption;
          EditSummaName.Repaint;
        end;
      end;
}
    end;
  finally
    if InvoiceDeclar.State=dsEdit then InvoiceDeclar.CheckBrowseMode;
  end;
end;

(*
Procedure TModuleInvoice.GridTotal(Sender: TXEDbGrid);
begin
  with ModuleBase do begin
    CalcTotals('Sta.InvoiceV',InvoiceVDeclar.Filter,'''Summa'',''Amount'',''Massa''');
    with TBEForm(InvoiceVC.Form).Grid do begin
      SetItemTotal('Summa',QueriesProcess.FieldByName('i1').Value);
      SetItemTotal('Amount',QueriesProcess.FieldByName('i2').Value);
      SetItemTotal('Massa',QueriesProcess.FieldByName('i3').Value);
      Total:=true;
    end;
  end;
end;                                        
*)

Procedure TModuleInvoice.RepAbroadBeforePrint(Sender: TObject);
const i:byte=0;
      Len=56; { Ширина метки для маршрута следования }
var j: smallint;
    S: string;
    NumPack: SmallInt;
begin
  {if RepAbroad.Device=dvScreen then}
  if RepAbroad.DeviceType='Screen' then
    with RepAbroad do begin
      PreviewForm.WindowState := wsMaximized;
      TppViewer(PreviewForm.Viewer).ZoomSetting :=zsPageWidth;
      { zs100Percent }
      { zsWholePage  }
    end;

  { Договор № ... }
  RepAbroadLabelDogNo.Caption:='Договор № '+InvoiceDeclarTrustNum.Value+
                                ' от '+InvoiceDeclarTrustDate.AsString;
  { Станция, ж.д. отправителя }
  with ModuleGeography,PLInvoice.DataSource.DataSet do begin
    StationLookUp.Locate(
    'Kod',TEtvLookField(FieldByName('SenderName')).ValueByLookName('Station'),[]);
    RepAbroadLabelSenderRail.Caption:=StationLookupRail.AsString;
    RepAbroadLabelStation.Caption:=StationLookUpName.Value+', '+
      StationLookUpRailName.ValueByLookName('FullName')+', '+
        StationLookUpKod.AsString;
  end;
  {(FieldByLookName('StationName') as TEtvLookField).StringByLookName('RailName');}

  { Информация о грузоотправителе }
  with ModuleOrgs, ModuleGeography, PLInvoice.DataSource.DataSet do begin
    {if not OrgBankDDeclar.Active then OrgBankDDeclar.Open;}
    CountryLookUp.Locate('Kod',
      TEtvLookField(FieldByName('SenderName')).ValueByLookName('Country'),[]);
    RepAbroadLabelSenderInfo.Caption:=
      TEtvLookField(FieldByName('SenderName')).ValueByLookName('FullName')+' р/с '
      +TEtvLookField(FieldByName('CountSenderName')).ValueByLookName('BCount')+' в '+
      TEtvLookField(FieldByName('CountSenderName')).ValueByLookName('BankName')
      {+OrgBankDDeclarBCount.Value+' в '+OrgBankDDeclarBankName.Value}+', '
      +TEtvLookField(FieldByName('SenderName')).ValueByLookName('Address')+', '+CountryLookUpName.Value;
  { Информация о грузополучателе }
    with TEtvLookField(FieldByName('OrgName')) do begin
      CountryLookUp.Locate('Kod',ValueByLookName('Country'),[]);
      RepAbroadLabelClientInfo.Caption:=
        ValueByLookName('FullName')+', '+ValueByLookName('Address')+', '
         +CountryLookUpName.Value;
    { Станция, ж.д. получателя }
    S:='';
    if StationLookUp.Locate(
      'Kod',StringByLookName('Station'),[]) then begin
      RepAbroadLabelClientRail.Caption:=StationLookupRail.AsString;
      S:=StationLookUpName.Value+', '+StationLookupRailName.ValueByLookName('FullName');
      if (ValueByLookName('RailBranch')<>null) then
        if RailBranchLookUp.Locate('Kod',ValueByLookName('RailBranch'),[])
          then S:=S+', ветка - '+RailBranchLookUpName.Value;
      end;
    end;
    RepAbroadLabelClientStation.Caption:=S;
  end;

  { Инициализация информации о пограничных станциях перехода }
  with ModuleGeography,ModuleGeography.BoundaryStationDeclarD,RepAbroadMemoBoundaryStation do begin
    Lines.Clear;
    First;
    j:=0; i:=0;
    while not Eof do begin
      Inc(i);
      case i mod 2 of
        0: Lines[j]:=Lines[j]+' / ';
        1: begin
             Lines.Add('');
             if i=3 then Inc(j);{ Обеспечиваем переход на вторую строку }
           end;
      end;
      with BoundaryStationDeclarDStationName do
        Lines[j]:=Lines[j]+ValueByLookName('RailName')+' '
            +StringByLookName('Rail')+' '
            +Value+' '+ValueByLookName('Kod');
      Next;
    end;
  end;
  { Наименование продукции + коды для отправки по ж.д.}
  with RepAbroadMemoProd,TFormInvoice(InvoiceC.Form) do begin
    Lines.Clear;
    for j:=0 to MemoProd.Lines.Count-1 do
      Lines.Add(MemoProd.Lines[j]);
  end;
  { Отметка о технических условиях погрузки извести }
  with RepAbroadMemoTU do
    if DeclarProdD.Value>30000 then begin
      Visible:=true;
      Lines[2]:='мастер '+TEtvLookField(PLInvoice.DataSource.DataSet.FieldByName('StockManName')).Value;
    end else begin
      Visible:=false;
    end;

  { Число мест, Вес тары, итого мест прописью }
  NumPack:=DeclarPackageD.Value;
  if NumPack>0 then begin
    RepAbroadLabelPackage.Caption:=
      DeclarAmountD.AsString+'/'+DeclarPackageD.AsString;
    RepAbroadLabelWeightTare.Caption:=
      FloatToStr(DeclarTareNameD.ValueByLookName('Weight')*NumPack);
    RepAbroadLabelWeightTare.Visible:=true;
    RepAbroadLabel3.Visible:=true;
    EtvDBText9.Visible:=true;
    RepAbroadLabelPackageName.Caption:=NumberToWords(NumPack,mtPiece,nil);
  end else begin
    RepAbroadLabelPackage.Caption:='';
    RepAbroadLabelPackageName.Caption:=DeclarTareNameD.ValueByLookName('TareName');
    RepAbroadLabelWeightTare.Visible:=false;
    RepAbroadLabel3.Visible:=false;
    EtvDBText9.Visible:=false;
  end;
  { Вес продукции }
  RepAbroadLabelWeightProd.Caption:=
    FloatToStr(DeclarProdNameD.ValueByLookName('Massa')*DeclarAmountD.Value);
  RepAbroadLabelWeightName.Caption:=NumberToWords(DeclarWeightD.Value,mtWeight,nil);

  { Документы, приложенные отправителем }
  with RepAbroadMemoDocs do begin
    if InvoiceDeclarOrgName.ValueByLookName('Country')=154{ Россия } then begin
      Lines[0]:='Счет-фактура             - 1 экземпляр';
      Lines[1]:='Сертификат происхождения - 1 экземпляр';
      Lines[2]:='Паспорт                  - 1 экземпляр';
      if DeclarProdD.Value<30000{ не Известь } then
        Lines[3]:='Сертификат №             - 1 экземпляр'
      else Lines[3]:='';
    end else begin
      Lines[0]:='Счет-фактура             - 2 экземпляра';
      Lines[1]:='Таможенная декларация    - 1 экземпляр';
      Lines[2]:='Транзитная декларация    - 3 экземпляра';
      Lines[3]:='Паспорт                  - 1 экземпляр';
    end;
  end;                                         

  { Способ определения веса }
  with RepAbroadMemoDefWeight do
    if DeclarProdD.Value<30000 then begin
      Lines[0]:='Расчетным';
      Lines[1]:='путем';
    end else begin
      Lines[0]:='На вагонных ве- ';
      Lines[1]:='сах отправителя';
    end;
end;

Procedure TModuleInvoice.RepInsideBeforePrint(Sender: TObject);
var S:string;
    i: byte;
begin
  {if RepInside.Device=dvScreen then}
  if RepInside.DeviceType='Screen' then
    with RepInside do begin
      PreviewForm.WindowState:=wsMaximized;
      TppViewer(PreviewForm.Viewer).ZoomSetting :=zsPageWidth;
      { zs100Percent }
      { zsWholePage  }
    end;
  with ModuleOrgs,ModuleGeography, PLInvoice.DataSource.DataSet do begin
    {  удавить скоро !!! }
    {if not OrgBankDDeclar.Active then OrgBankDDeclar.Open;}

    { Станция, ж.д. отправителя }
    StationLookUp.Locate(
      'Kod',TEtvLookField(FieldByName('SenderName')).ValueByLookName('Station'),[]);
    RepInsideSenderStation.Caption:=StationLookUpName.Value+', '+
        StationLookUpRailName.ValueByLookName('FullName');
{
    StationLookUp.Locate(
      'Kod',InvoiceDeclarOrgName.ValueByLookName('Station'),[]);
    RepInsideOrgStation.Caption:=StationLookUpName.Value+', '+
        StationLookUpRailName.ValueByLookName('FullName');
}
    StationLookUp.Locate('Kod',InvoiceRailStation.Value,[]);
    RepInsideOrgStation.Caption:=InvoiceRailStationName.ValueByLookName('Name');
    { Добавляем название железной дороги }
    RepInsideOrgStation.Caption:=RepInsideOrgStation.Caption+', '
      +StationLookUpRailName.ValueByLookName('FullName');
    { Добавляем, если есть ж.д. ветку }
    if (InvoiceRailBranch.Value<>null) and (InvoiceRailBranch.Value>0) then
      RepInsideOrgStation.Caption:=RepInsideOrgStation.Caption+', '+InvoiceRailBranchName.Value;

    { Формирование наименования продукции }
    S:='';
    with InvoiceProdDDeclar do begin
      DisableControls;
      First;
      if not Eof then begin
        while not Eof do begin
          S:=DeclarProdNameD.ValueByLookName('FullName');
          i:=Pos(' ',S);
          S:=Copy(S,1,i+Pos(' ',Copy(S,i+1,99))-1);
(*
          S:=S+#10{#13}+
            DeclarProdNameD.ValueByLookName('UnitMName');
*)
(* Решили пока цену не печатать, будет мастер писать ручками
             +'- '+
              { Количество продукции известно только по кирпичу силикатному }
              {DeclarAmountD.AsString+'x'+}DeclarPriceD.AsString+#10{#13};
*)
          { Если продукция - известь, то положено писать снизу }
          { Аварийная карточка № 808                           }
          if ModuleProd.GetMainUp(DeclarProdD.Value)=4 then begin
            S:='80/00Н 1910'+#10+S+','+#10+'8, аварийная карточка №808';
          end;
          Next;
        end;
        First;
      end else
        S:='Панели для жилья'+#10+
           'в собственном вагоне'+#10+#10+
           'Вес конуса';
      EnableControls;
      RepInsideProdName.Caption:=S;
    end;
  end;
end;

// Какое-то событие, которое щас отключено. М.б. его надо удалить?
// Инициализация поля PointUnloading (Пункт разгрузки) происходит в событии BeforePost
// Lev 20.11.2010
Procedure TModuleInvoice.InvoiceDeclarOrgNameChange(Sender: TField);
begin
  if not(Sender.DataSet.State in [dsInsert,dsEdit]) or
    (InvoiceDeclarPointUnloading.AsString<>'') then Exit;
  if InvoiceDeclarPointUnloading.AsString='' then
    InvoiceDeclarPointUnloading.Value:=InvoiceDeclarOrgName.StringByLookName('Address');
end;

Procedure TModuleInvoice.InvoiceDeclarDriverChange(Sender: TField);
begin
  if (InvoiceDeclar.State in [dsInsert,dsEdit]) and (InvoiceDeclarTrust.Value='') then
    InvoiceDeclarTrust.Value:=InvoiceDeclarDriver.Value;
end;

Procedure TModuleInvoice.InvoiceCActivateForm(Sender: TObject);
begin
  aClientNameField:='OrgName'; // Временное решение. Правильное решение - переименовать Lookup поле OrgName в ClientName
  with ModuleProd.ProdPriceProcess do
    if DataSource<>InvoiceProdD then begin
      Close;
      DataSource:=InvoiceProdD;
      ParamByName('Prod').AssignField(DeclarProdD);
      ParamByName('Tare').AssignField(DeclarTareD);
      ParamByName('TPrice').AssignField(DeclarTPriceD);
      Open;
    end;
end;

Procedure TModuleInvoice.InvoiceCCreateForm(Sender: TObject);
begin
  with TFormInvoice(InvoiceC.Form) do begin
    Grid.TitleRows:=2;
    Grid.TitleAlignment:=taCenter;
    EtvDBGrid1.OnTitleClick:=GridTitleClick;
    EtvDBGrid1.TitleRows:=2;
    EtvDBGrid1.TitleAlignment:=taCenter;
  end;

  ModuleProd.PriceDateLookup.Active:=true;
  // Запрет редактировать группе FSGL таблицу InvoiceProd из Клиента
  // Пока закомментарил, ибо есть случаи когда им нужно подредактировать строки внизу накладной
  // Если что, они - бухгалтерия, они и отвечают...
  (*
  if GetFromSQLText(InvoiceProdD.DataBaseName,'select IsMemberOf('''+UserName+''',''FSGL'')',false)>0 then
    InvoiceProdDDeclar.ReadOnly:=true;
  *)
  {AMScaleForm(TFormInvoice(InvoiceC.Form));}
end;

Procedure TModuleInvoice.InvoiceDeclarKodChange(Sender: TField);
begin
  if (Sender.Name='InvoiceDeclarKod') and (InvoiceDeclar.State=dsEdit) then
  with TFormInvoice(InvoiceC.Form) do begin
    if InvoiceDeclarTTransport.Value in [3,4] then begin
      {TabSheet.Invalidate;}
    end;
    InvoiceProdDDeclar.Refresh;
  end;
end;

Procedure TModuleInvoice.InvoiceProdDDeclarBeforePost(DataSet: TDataSet);
  { 0 - продукцию еще не ввели, а уже вводят транспортные услуги                          }
  { 1 - условия поставки продукции предполагают взимание платы за транспортные услуги     }
  { 2 - условия поставки продукции предполагают включение стоимости транспортных расходов }
  {     в стоимость готовой продукции                                                     }
var TransportChargesType: byte;
begin
  { Контроль за вводом информации по транспортным услугам }
  if (DeclarProdD.Value=46001) or (DeclarProdD.Value=46002) then begin
    with TFormInvoice(InvoiceC.Form).EtvDBGrid1 do begin
      TransportChargesType:=GetFromSQLText(InvoiceProdD.DataBaseName,
        'select GetTransportChargesType('''+DeclarNumInvoiceD.AsString+''','''
        +DeclarSDateD.AsString+''')',false);
      if TransportChargesType=0  then begin
        if not Focused then SetFocus;
        {MessageDlg('Нет никакой продукции. Чего будем везти ?');}

        ResultDlg:=MessageDlg('Внимание!!! Нет никакой продукции. '#13+
           'Обычно первой строкой в накладной идет продукция КСМ!!!'#13+
            'Продолжить работу?', mtWarning,[mbYes, mbNo],0);
        if ResultDlg=idNo then Abort;
      end else
        if TransportChargesType<>DeclarTPriceD.AsInteger then begin
          if not Focused then SetFocus;
          ShowMessage('Несоответствие условий поставки продукции и транспортных услуг');
          if InvoiceDeclarSenderName.ValueByLookName('INN')='500038966' then begin // Наши магазины
            ResultDlg:=MessageDlg('Внимание!!!'#13+'НЕСООТВЕТСТВИЕ УСЛОВИЙ ПОСТАВКИ ПРОДУКЦИИ И ТРАНСПОРТНЫХ УСЛУГ!!!'#13+
           ' ВЫ ПОДТВЕРЖДАЕТЕ СДЕЛАННЫЙ ВЫБОР?', mtWarning,[mbYes, mbNo],0);
            if ResultDlg=idNo then Abort;
          end else Abort;
        end;
    end;
    { Если Транспортное предприятие - "Гродненский КСМ", то код автоуслуг - 46003(!!!) }
    if InvoiceDeclarTransPlant.Value=4 then begin
      ShowMessage('Код автотранспортных услуг для транспортного предприятия'+#13+
      'ОАО "Гродненский КСМ" - 46003');
      Abort;
    end;
  end;
  { Контроль за введенными значениями в поле "Условие поставки" }
  if aPayerLookField.ValueByLookName('Rezident')=1 then
  with TFormInvoice(InvoiceC.Form).EtvDBGrid1 do
    try
      {
      (*В конце июля 2001 года КСМ решил пользоваться только одной ценой  1 - Франко-склад предприятия
        в силу того что чужие услуги неадекватно влияют на формирование отпускной цены                *)
      if InvoiceDeclarTTransport.Value=3 then begin
        if (aPayerLookField.StringByLookName('sGroup')='1') then
          if DeclarTPriceD.Value<>2 then DeclarTPriceD.Value:=2 else
        else
          if DeclarTPriceD.Value<>34 then DeclarTPriceD.Value:=34
      end;
      }
      ExecSQLText(InvoiceProdD.DataBaseName,
        'Call STA.CheckInvoiceProd('+
        IntToStr(StrToIntDef(aPayerLookField.StringByLookName('TActivity'),0))+
        ','+InvoiceDeclarTTransport.AsString+','+DeclarTPriceD.AsString+')',false);

       { Предупреждение о том, что по резидентам РБ обычно контракты не ведутся }
       if ((InvoiceProdDDeclar.State=dsInsert) or (InvoiceProdDDeclar.OldEditValues[DeclarContractD.Index]=Null)) and
         (not DeclarContractD.IsNull) then begin
         ResultDlg:=MessageDlg('ВНИМАНИЕ!!!'#13+
           'ОБЫЧНО ПО РЕЗИДЕНТАМ РБ ПОЛЕ "КОНТРАКТ" НЕ ЗАПОЛНЯЕТСЯ!!!'#13+
           'ВЫ УВЕРЕНЫ В СВОЕМ ВЫБОРЕ?', mtWarning,[mbYes, mbNo],0);
         if ResultDlg=idNo then begin
           SetFocus;
           Abort;
         end;
       end;
    except
      if not Focused then SetFocus;
      {ShowMessage('НЕВЕРНОЕ ЗНАЧЕНИЕ В ПОЛЕ: "УСЛОВИЕ ПОСТАВКИ"!');}
      Raise;
      Abort;
    end;
  try
    {InvoiceProdDDeclar.OnCalcFields:=nil;}
    { Инициализация остальных полей из БД }
    DeclarPriceB.Value:=DeclarPriceD.Value;
    DeclarSummaB.Value:=DeclarSummaD.Value;
    DeclarRateVATB.Value:=RateVATD.Value/100+1;
    DeclarClientB.Value:=aPayer;
    { Временная инициализация }
    {DeclarBaseTPriceD.Value:=0;}
    if DeclarClientB.Value=0 then
      DeclarBidB.Value:=DeclarPriceBidD.Value
    else DeclarBidB.Value:=0;
    DeclarExtraB.Value:=DeclarPriceExtraD.Value;
    DeclarTPriceNameD.ValueByLookNameToField('Currency',DeclarCurrencyB);
  finally
    {InvoiceProdDDeclar.OnCalcFields:=InvoiceProdDDeclarCalcFields;}
  end;
  { Обязательно дата цены должна быть такой же как и в справочнике продукции }
  {if InvoiceProdDDeclar.State in [dsInsert,dsEdit] then}
  DeclarDatePriceD.Value:=ThisDatePrice;
end;

var DateBeg: TDateTime;
    DateEnd: TDateTime;
Procedure TModuleInvoice.InvoiceVG1Click(Sender: TObject);
var DlgOneDate: TDialDate;
begin
  if DateBeg=0 then DateBeg:=Date;
  if DateEnd=0 then DateEnd:=Date;
  DlgOneDate:=TDialDate.Create(Application);
  DlgOneDate.EditDateBeg.Date:=DateBeg;
  DlgOneDate.EditDateEnd.Date:=DateEnd;
  with DlgOneDate do begin
    {VisibleSecondDate(false);}
    Caption:='Укажите период расчета книги продаж';
  end;
  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) and
  (DlgOneDate.EditDateEnd.Date>0) and (DlgOneDate.EditDateEnd.Date>=DlgOneDate.EditDateBeg.Date) then
    if ((DlgOneDate.EditDateEnd.Date<>DateEnd) or (DlgOneDate.EditDateBeg.Date<>DateBeg)) then
      { проверили на старые значения }
      with DlgOneDate do try
        { Заголовок формы }
        InvoiceVGC.Caption:='КНИГА ПРОДАЖ с '+EditDateBeg.Text+' по '+EditDateEnd.Text;
        DateBeg:=EditDateBeg.Date;
        DateEnd:=EditDateEnd.Date;
        { Закрыли таблицу со старыми значениями }
        InvoiceVGDeclar.Close;
        { Запустили генерацию необходтимого VIEW }
        ExecSQLText(InvoiceVGDeclar.DataBaseName,
          'Call STA.GenerateInvoiceVGroup('''+EditDateBeg.Text+''','''+EditDateEnd.Text+''')',false);
        { Открыли таблицу с новыми значениями }
        InvoiceVGDeclar.Close;
      finally
        DlgOneDate.Release;
      end
    else
  else Abort;
end;

Procedure TModuleInvoice.ppGroupFooterBand2BeforePrint(Sender: TObject);
begin
  { Инициализация AmountName }
  InvoiceAddSet.Edit;
  InvoiceAddSetAmountName.Value:=NumberToWords(SumAmount,mtNothing,nil)+' '+UnitMStr;
  InvoiceAddSet.Post;
  {RepInvoice.Stop;}
  { Обнуление для следующего раза }
(*
  if InvoiceProdDDeclar.Eof then begin
    PLInvoiceProd.OnTraversal:=nil;
    ppGroupFooterBand2.BeforePrint:=nil;
  end;
*)
  SumAmount:=0;
  InvoiceProdRowCount:=0;
  { Информация про тару в конце накладной }
  EtvPpDBTareMessage.Visible:=(InvoiceDeclarTareAmount.AsInteger>0);
end;

Procedure TModuleInvoice.PLInvoiceProdTraversal(Sender: TObject);
var aPos:byte;
begin
  { Изменилась позиция записи в DataSet'е InvoiceProd }
  { Необходимо проинициализировать дополнительные переменные }
  InvoiceAddSet.Edit;
  { Разборки с наименованием продукции }
  InvoiceAddSetProdName.AsString:=DeclarProdNameD.StringByLookName('Name');
  if (DeclarProdD.Value>46000) and (DeclarProdD.Value<46010)
  {and (DeclarTPriceD.Value=2)} or InvoiceProdDDeclar.Eof then begin
    InvoiceAddSetAmount.Clear;
    InvoiceAddSetPrice.Clear;
    InvoiceAddSetMassa.Clear;
    Inc(InvoiceProdRowCount);
    { Наименование единицы измерения }
  end else begin
    { Продолжение разборок с наименованием продукции }
    if (DeclarBaseTPriceD.AsInteger=11) then begin
      aPos:=Pos('кат)',DeclarProdNameD.StringByLookName('Name'));
      if aPos>0 then InvoiceAddSetProdName.AsString:=InvoiceAddSetProdName.AsString+'-ДХ';
    end;
    if (DeclarDatePriceD.AsString='21.12.07') then begin
      aPos:=Pos('(IIкат)',DeclarProdNameD.StringByLookName('Name'));
      if aPos>0 then InvoiceAddSetProdName.AsString:=Copy(InvoiceAddSetProdName.AsString,1,aPos-1)+'(IIIкат)';
    end;
    InvoiceAddSetAmount.Value:=DeclarAmountD.Value;
    InvoiceAddSetPrice.Value:=DeclarPriceD.Value;
    { Корректировка массы по накладной }
    Inc(InvoiceProdRowCount);
    if MassaNameAdd<>'' then begin
      MassaForOneRow:='';
      MassaForOneRow:=InputBox('Изменение расчетного веса',
        'Введите вес по строке № в КГ'+IntToStr(InvoiceProdRowCount),'');
      if MassaForOneRow='' then MassaForOneRow:='0';
      InvoiceAddSetMassa.AsFloat:=StrToFloat(MassaForOneRow)/1000.0;
    end else InvoiceAddSetMassa.Value:=DeclarWeightD.Value;
    if (DeclarProdD.Value<47001) or (DeclarProdD.Value>47050) then begin
      UnitMStr:=DeclarProdNameD.StringByLookName('UnitMNameFull');
      SumAmount:=SumAmount+InvoiceAddSetAmount.Value;
    end;
  end;
  InvoiceAddSet.Post;
end;

Procedure TModuleInvoice.PLInvoiceProdFirst(Sender: TObject);
begin
(*
  Inc(II);
  { НИ ХРЕНА НЕ ПОНЯТНО! ПОЧЕМУ-ТО ЗАХОДИТ СЮДА ТРИ(!!!) РАЗА ВМЕСТО ОДНОГО }
  { DIGITAL METAPHORS - CHAINIKI!                                           }
  if II mod 2=0 then begin
    PLInvoiceProd.OnTraversal:=PLInvoiceProdTraversal;
    ppGroupFooterBand2.BeforePrint:=ppGroupFooterBand2BeforePrint;
  end else begin
    PLInvoiceProd.OnTraversal:=nil;
    ppGroupFooterBand2.BeforePrint:=nil;
  end;
*)
end;

procedure TModuleInvoice.InvoiceProdDDeclarAfterScroll(DataSet: TDataSet);
begin
  Exit;
  if IsPrintOn and (DeclarProdD.Value=46002) then InvoiceProdDeclar.Next;
end;

procedure TModuleInvoice.InvoiceProdDDeclarBeforeInsert(DataSet: TDataSet);
begin
  AutoRailRow:=false;
  // 31.07.01 решили всю продукцию отпускать только по цене франко-склад предприятия
  // поэтому был закомментарен оператор  {(DeclarTPriceD.Value=34) and}
  // а с 15.08.01 все опять вернулось как было до 31.07.01
  if (DeclarTPriceD.Value=34) and (DeclarProdD.Value<>46002)
  and ((UserName='SL') or (UserName='BALL') or (UserName='COW') or (UserName='DED')
    or(UserName='ROM') or (UserName='DAV')) then
      if MessageDlg('В ПОМОЩЬ ДИСПЕТЧЕРУ...'+#13+
        'ЕСЛИ ВЫ ВСЕ ЗАПОЛНИЛИ ПО ПРОДУКЦИИ, ТО МОЖЕТ БЫТЬ,'+#13+
        'ЖЕЛАЕТЕ ДОБАВИТЬ СТРОКУ С Ж/Д ТАРИФОМ?',mtConfirmation,
        [mbYes,mbNo],0)=idYes then AutoRailRow:=true;
end;

Procedure TModuleInvoice.N2Click(Sender: TObject);
  var InvCount:Variant;
  msg:String;
begin
  //if not Assigned(DialDate) then
  DialDate:=TDialDate.Create(Application);
  with DialDate do begin
    Caption:='Введите интервал для снятия замков:';
    EditDateBeg.Text:=DateToStr(Now-5);
    EditDateEnd.Text:=DateToStr(Now);
    if ShowModal=idOK
      then
        try
          InvCount:=GetFromSQLText(Invoice.DatabaseName,'Select UnlockInvoices('''+EditDateBeg.Text+''','''+EditDateEnd.Text+''')',false);
          if InvCount>0 then Msg:='Замки сняты c '+IntToStr(InvCount)+' накладных.' else Msg:='Нет накладных для снятия замков!';
          MessageDlg(msg,mtInformation,[mbOk],0)
        Finally
        end;
    Free;
  end;
end;

Function TModuleInvoice.DeclarContractNameDFilter(Sender: TObject): String;
var aClient: string[10];
    aCurrency: smallint;
begin
  aClient:='Client';
  if TEtvLookField(Sender).DataSet=InvoiceDeclar then with TEtvLookField(Sender).DataSet do
    if not FieldByName('Payer').IsNull then aClient:='Payer';

  aCurrency:=974;
  with TEtvLookField(Sender).DataSet do begin
    { В момент заполнения шапки накладной поле Currency еше не инициализировано }
    if FindField('Currency')<>nil then
       if FieldByName('Currency').AsString<>'' then
         aCurrency:=FieldByName('Currency').AsInteger;
    Result:='(Client='''+FieldByName(aClient).AsString+
      ''') and (Currency='+IntToStr(aCurrency)+')';
  end;
end;

Procedure TModuleInvoice.FactureVATDataChange(Sender: TObject; Field: TField);
begin
  {ShowMessage(Sender.ClassName);}
  if TLinkSource(Sender).DataSet.State<>dsBrowse then Exit;
  if TLinkSource(Sender).DataSet.State<>dsInsert then begin
    ExecSQLText(FactureVATDeclar.DataBaseName,
         'call STA.GetFactureVATProd('+FactureVATDeclarClient.AsString+','''+FactureVATDeclarBegPeriod.AsString
         +''','''+FactureVATDeclarEndPeriod.AsString+''')',false);
    // ClientReportC.Caption:='Акт сверки по клиенту: '+LookUpClient.Text+' | '+OrgLookupName.AsString;
    with FactureVATProdDeclar do begin
      if not Active then Active:=true;
      DisableControls;
      Refresh;
      Last;
      aFactureSummaVAT:=FactureVATProdDeclarSummaVAT.Value;
      aFactureSumma:=FactureVATProdDeclarSumma.Value;
      {FactureVATDeclar.Edit;} {FactureVATDeclar.Post;}
      {FactureVATDeclarCalcFields(FactureVATDeclar);}
      First;
      EnableControls;
    end;
  end;
end;

Procedure TModuleInvoice.FactureVATDeclarNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Sender').Value:=900000;
  aFactureSummaVAT:=0;
  aFactureSumma:=0;
end;

Procedure TModuleInvoice.FactureVATDeclarCalcFields(DataSet: TDataSet);
begin
  if DataSet.State<>dsInsert then begin
    ExecSQLText(FactureVATDeclar.DataBaseName,
         'call STA.GetFactureVATProd('+FactureVATDeclarClient.AsString+','''+FactureVATDeclarBegPeriod.AsString
         +''','''+FactureVATDeclarEndPeriod.AsString+''')',false);
    with FactureVATProdDeclar do begin
      if not Active then Active:=true;
      DisableControls;
      FactureVATProdDeclar.MasterSource:=nil;
      Refresh;
      Last;
      FactureVATDeclarSummaVATName.Value:=NumberToWordsCurrency(FactureVATProdDeclarSummaVAT.Value,974);
      FactureVATDeclarSummaName.Value:=NumberToWordsCurrency(FactureVATProdDeclarSumma.Value,974);
      First;
      FactureVATProdDeclar.MasterSource:=FactureVAT;
      EnableControls;
    end;
  end;
end;

procedure TModuleInvoice.InvoiceVCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form).Grid do begin
    TitleRows:=2;
    TitleAlignment:=taCenter;
    {Font.Name:='Arial Narrow'; мелковато
    TitleFont.Name:='Arial Narrow';}
    OnDblClick:=ModuleClientsAdd.GridDblClick;
  end;
end;

procedure TModuleInvoice.FactureProdDeclarAfterPost(DataSet: TDataSet);
begin
  with FactureProcess do begin
    Close;
    ParamByName('NumInvoice').Value:=FactureDeclarNumInvoice.Value;
    ParamByName('DateInvoice').Value:=FactureDeclarsDate.Value;
    Open;
  end;
  with FactureDeclar do begin
    DisableControls;
    Edit;
    FactureDeclarSumma.Value:=FactureProcessSumma.Value;
    FactureDeclarSummaVAT.Value:=FactureProcessSummaVAT.Value;
    Post;
    EnableControls;
  end;
end;

procedure TModuleInvoice.FactureDeclarCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('SummaVATName').AsString:=NumberToWordsCurrency(FieldByName('SummaVAT').AsFloat,974);
    {FactureDeclarSummaVATName.Value:=NumberToWordsCurrency(FactureDeclarSummaVAT.Value,974);}
    FieldByName('SummaName').AsString:=NumberToWordsCurrency(FieldByName('Summa').AsFloat,974);
    {FactureDeclarSummaName.Value:=NumberToWordsCurrency(FactureDeclarSumma.Value,974);}
    if FieldByName('Client').AsInteger>0 then
      FieldByName('ClientSaldo').Value:=GetFromSQLText(FactureDeclar.DataBaseName,
       'select GetClientBalance('+FieldByName('Client').AsString+')',false);
(*
  FactureDeclarClientSaldo.Value:=GetFromSQLText(FactureDeclar.DataBaseName,
    'select GetClientBalance('+FactureDeclarClient.AsString+')',false);
*)
  end;
end;

procedure TModuleInvoice.EtvPpDBText50GetText(Sender: TObject; var Text: String);
begin
  if (EtvPpDBText64.Text='Железнодорожный тариф') or (EtvPpDBText64.Text='Сальдо по клиенту') then begin
    Text:='';
  end;
  { Обработка для ед.изм. "Усл.тыс.шт". При первом входе в таблицу типа "Сведения о грузе", примечания выключаем }
  if TppBDEPipeLine(TEtvPpDBText(Sender).DataPipeLine).DataSource.DataSet.BOF then
    { скрываем важное примечание про кол-во штук кирпича в 1 усл.тыс.шт }
    ppLabelNoteBrickInFacture.Visible:=false;
  { Если попался кирпич, то примечание включаем }  
  if TEtvLookField(TppBDEPipeLine(TEtvPpDBText(Sender).DataPipeLine).DataSource.DataSet.FieldByName('ProdName')).ValueByLookName('UnitM')=1 then
    { Показываем важное примечание про кол-во штук кирпича в 1 усл.тыс.шт }
    ppLabelNoteBrickInFacture.Visible:=true;
end;

procedure TModuleInvoice.FactureDeclarAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TModuleInvoice.EtvPpDBText51GetText(Sender: TObject;
  var Text: String);
begin
  if Text='' then Text:=FactureDeclarClientStr.AsString;
end;

procedure TModuleInvoice.FactureDeclarNewRecord(DataSet: TDataSet);
begin
  FactureDeclarNumInvoice.AsVariant:=GetFromSQLText(FactureDeclar.DataBaseName,
    'select Max(cast(NumInvoice as integer)) from STA.Facture where Year(sDate)=Year(Now(*))',false)+1;
end;

procedure TModuleInvoice.EtvPpDBText67GetText(Sender: TObject;
  var Text: String);
begin
  if {(EtvPpDBText64.Text='Железнодорожный тариф') or} (EtvPpDBText64.Text='Сальдо по клиенту') then begin
    Text:='';
  end;
end;

procedure TModuleInvoice.InvoiceDeclarContractChange(Sender: TField);
begin
  if (InvoiceDeclar.State in [dsInsert,dsEdit]) then
    InvoiceDeclarGoalPurchase.Value:=InvoiceDeclarContractName.ValueByLookName('GoalPurchase');
end;

function TModuleInvoice.ContractDeclarGoalPurchaseNameFilter(Sender: TObject): String;
begin
  Result:='((Kod>=0) and (Kod<=3)) or (Kod=8)';
end;

procedure TModuleInvoice.ppSummaryBand1BeforePrint(Sender: TObject);
var i: integer;
begin
  if RepInvoice.PageNo=1 then RepInvoice.SummaryBand.NewPage:=true;
end;

procedure TModuleInvoice.RepInvoiceStartPage(Sender: TObject);
var DSet: TDataSet; { текущий датасет по накладным. Этот датасет практически всегда InvoiceDeclar, но на всякий случай сделаем общий случай }
begin
  if RepInvoice.PageNo=1 then begin
    { Печать копии ТТН или типографского бланка }
    with RepInvoice do begin
      ppLabelGruzootpravitel.Visible:=CopyInvoiceFlag or RepInvoice2009;
      ppLabelGruzopoluchatel.Visible:=CopyInvoiceFlag or RepInvoice2009;
      ppLabelZakazchik.Visible:=CopyInvoiceFlag or RepInvoice2009;
      ppLabelKodUnn.Visible:=CopyInvoiceFlag or RepInvoice2009;
      // В старом шаблоне было больше меток
      ppLabelKodOKULP.Visible:=CopyInvoiceFlag and not RepInvoice2009;
      ppLabelLicense.Visible:=CopyInvoiceFlag and not RepInvoice2009;
      ppLabelCopy.Visible:=CopyInvoiceFlag;
      ppLabelTTN.Visible:=CopyInvoiceFlag;
      EtvPpDBTextNum.Visible:=CopyInvoiceFlag;
      DSet:=TppBDEPipeLine(PpDBTextZakazchikINN1.DataPipeLine).DataSource.DataSet;
      if (DSet.FieldByName('TransportClient').IsNull) and (DSet.FieldByName('TransportClientStr').IsNull) then begin
        PpDBTextZakazchikINN1.Visible:=not RepInvoice2009;
        // В старом шаблоне было больше меток
        PpDBTextDBTextZakazchikOKPO1.Visible:=not RepInvoice2009;
        PpTextDBTextZakazchikLicence.Visible:=not RepInvoice2009;
      end;
      ppLabelTotalAmount.Visible:=not RepInvoice2009;
      ppDBTextAmountName.Visible:=not RepInvoice2009;
    end;
    { Это как бы установка отступа на след. странице }
    RepInvoice.PrinterSetup.MarginTop:=5;
  end else { if RepInvoice.PageNo>1 then}
    { Это установка отступа на 1-й странице, т.е при просмотре туда-сюда }
    RepInvoice.PrinterSetup.MarginTop:=18;
end;

procedure TModuleInvoice.EtvPpDBText126GetText(Sender: TObject; var Text: String);
begin
  { Выравниваем по горизонтали дополнение к условию поставки }
  { Франко-склад предприятия. Для строительства на селе. Рентабельность 5%. }
  { Чтобы после первого предложения вплотную шло второе }
  Text:=Text+EtvPpDBText131.Text;
end;

procedure TModuleInvoice.DeclarProdDChange(Sender: TField);
begin
  if (Sender.FieldName='Prod') then begin
    if Sender.Value>=5000 then DeclarBaseTPriceD.Value:=0;
    // Анализ информации для обработки "Класса прочности"
    if ((Sender.Value mod 50000>=2000) and (Sender.Value mod 50000<=5000)) or ((Sender.Value>=10000) and (Sender.Value<=11000)) then
      with TXELookField(Sender.DataSet.FieldByName('ProdName')) do
        case ValueByLookName('Shop') of
          1: // Выбрана продукция цеха №1
          Case ValueByLookName('Density') of // Присваиваем значения по умолчанию
            400: DeclarClassCargoD.AsString:='1.5';
            450: DeclarClassCargoD.AsString:='1.5';
            500: DeclarClassCargoD.AsString:='1.5';
            600: DeclarClassCargoD.AsString:='2.5';
            else DeclarClassCargoD.Clear;
          end;
          2: // Выбрана продукция цеха №2
          Case ValueByLookName('Density') of // Присваиваем значения по умолчанию
            400: DeclarClassCargoD.AsString:='1.5';
            450: DeclarClassCargoD.AsString:='2.0';
            500: DeclarClassCargoD.AsString:='2.0';
            600: DeclarClassCargoD.AsString:='2.5';
            else DeclarClassCargoD.Clear;
          end;
          else DeclarClassCargoD.Clear;
        end;
  end;
end;

// Возникла ситуация на предприятии, когда завели еще один расчетный счет.
// При необходимости печати в счет-фактуре другого расчетного счета
// можно воспользоваться событием ниже для корректирвки шапки счета-фактуры
(*
procedure TModuleInvoice.ppLabel158Print(Sender: TObject);
begin
  // if УСЛОВИЕ НА ВЫБОР ТОГО ИЛИ ИНОГО РАСЧЕТНОГО СЧЕТА then
  // Внимание! Если свойство AutoSize:=true, то данное событие вызывается дважды
  if RepFacture.DeviceType='Screen' then begin // Для исключения лишней работы при выводе на принтер
    case MessageDlg('Основной р/счет - 3012000003920 - Да,'+#13+'Дополнительный р/с - 3012000004121 - Нет',mtConfirmation,[mbYes,mbNo],0) of
      idYes: TppLabel(Sender).Caption:='р/с 3012000003920';
      idNo: TppLabel(Sender).Caption:='р/с 3012000004121'
      else Abort;
    end;
    TppLabel(Sender).Caption:=TppLabel(Sender).Caption+' в ф-ле №400 ГОУ АСБ "Беларусбанк" г.Гродно,код 752, ул. Новооктябрьская, 5, УНН 500038966, ОКПО 00294639, ОКОНХ 16152';
  end;
end;
*)

procedure TModuleInvoice.EtvPpDBText64GetText(Sender: TObject;  var Text: String);
begin
  { Обработка для блоков длительного хранения }
  if TppBDEPipeLine(TEtvPpDBText(Sender).DataPipeLine).DataSource.DataSet.FieldByName('BaseTPrice').AsInteger=11 then begin
    Text:=Text+'-ДХ';
    { Уменьшаем шрифт, иначе наименование не влазит }
    TEtvPpDBText(Sender).Font.Size:=8;
  end;
end;

procedure TModuleInvoice.EtvPpDBText100GetText(Sender: TObject;  var Text: String);
var aExtra: Single;
    aExtraStr: string[40];
begin
  { Обработка для ед.изм. "Усл.тыс.шт" }
  if TEtvLookField(TppBDEPipeLine(TEtvPpDBText(Sender).DataPipeLine).DataSource.DataSet.FieldByName('ProdName')).ValueByLookName('UnitM')=1 then begin
    { Уменьшаем шрифт (наим. ед. изм.), иначе наименование не влазит }
    TEtvPpDBText(Sender).Font.Size:=7;
    { Показываем важное примечание про кол-во штук кирпича в 1 усл.тыс.шт }
    ppLabelNote.Caption:='1 усл.тыс.шт.= 739 шт. кирпича';
    ppLabelNote.Visible:=true;
    ppLabelNoteRail.Caption:='1 усл.тыс.шт.= 739 шт. кирпича';
    ppLabelNoteRail.Visible:=true;
    EtvPpDBText36.Visible:=false;
  end else begin
    aExtra:=TEtvLookField(TppBDEPipeLine(TEtvPpDBText(Sender).DataPipeLine).DataSource.DataSet.FieldByName('PriceExtraCalc')).Value;
    if aExtra<>0 then begin
      if aExtra>0 then aExtraStr:='Наценка '+FloatToStr(aExtra)+'%'
      else aExtraStr:='Скидка '+FloatToStr(-aExtra)+'%';
      { Шрифтик для красивого написания }
      TEtvPpDBText(Sender).Font.Size:=8;
      { Показываем важное примечание про кол-во штук кирпича в 1 усл.тыс.шт }
      ppLabelNote.Caption:=aExtraStr;
      ppLabelNote.Visible:=true;
      ppLabelNoteRail.Caption:=aExtraStr;
      ppLabelNoteRail.Visible:=true;
      EtvPpDBText36.Visible:=false;
    end else begin { для других строк в накладной возвращаем начальные значения }
      { Шрифтик для наим. ед. измерения }
      TEtvPpDBText(Sender).Font.Size:=8;
      { скрываем важное примечание про кол-во штук кирпича в 1 усл.тыс.шт }
      ppLabelNote.Visible:=false;
      ppLabelNoteRail.Visible:=false;
      EtvPpDBText36.Visible:=true;
    end;
  end;
end;

procedure TModuleInvoice.DeclarProdNameDGetText(Sender: TField; var Text: String; DisplayText: Boolean);
begin
  Text:=TEtvLookField(Sender).AsString;
  { Базовый тип цены - 11 - длительное хранение }
  if (Sender.DataSet.FieldByName('BaseTPrice').AsInteger=11) and (TEtvLookField(Sender).VFieldIndex=1) then begin
    Text:=Text+'-ДХ'
  end;
end;

// Возникла ситуация на предприятии, когда завели еще один расчетный счет.
// При необходимости печати в счет-фактуре другого расчетного счета
// можно воспользоваться событием ниже для корректирвки шапки счета-фактуры
procedure TModuleInvoice.RepFactureBeforePrint(Sender: TObject);
begin
  // if УСЛОВИЕ НА ВЫБОР ТОГО ИЛИ ИНОГО РАСЧЕТНОГО СЧЕТА then
  // Внимание! Если свойство AutoSize:=true, то компонент рисуется неправильно почему-то
  if RepFacture.DeviceType='Screen' then begin // Для исключения лишней работы при выводе на принтер
    case MessageDlg('Основной р/счет - 3012000003920 - Да,'+#13+'Дополнительный р/с - 3012000004121 - Нет',mtConfirmation,[mbYes,mbNo],0) of
      idYes: ppLabel158.Caption:='р/с 3012000003920';
      idNo:  ppLabel158.Caption:='р/с 3012000004121'
      else Abort;
    end;
    ppLabel158.Caption:=ppLabel158.Caption+' в ф-ле №400 ГОУ АСБ "Беларусбанк" г.Гродно,код 752, ул. Новооктябрьская, 5, УНН 500038966, ОКПО 00294639, ОКОНХ 16152';
  end;
end;

procedure TModuleInvoice.InvoiceDeclarClientChange(Sender: TField);
begin
  if (Sender.FieldName='Client') and (InvoiceDeclar.State in [dsInsert,dsEdit]) then begin
     if Sender.Value>0 then InvoiceDeclarTrustType.Value:=1;
     if Sender.Value=0 then InvoiceDeclarTrustType.Value:=2;
  end;
end;

procedure TModuleInvoice.FactureCActivateForm(Sender: TObject);
begin
  aClientNameField:='ClientName';
end;

end.
