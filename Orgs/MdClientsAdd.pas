unit MdClientsAdd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, EtvTable, LnTables, LnkSet, XMisc, XTFC, XDBTFC, EtvList,
  XEFields, EtvLook, Menus, DBGrids, Grids;

type
  TModuleClientsAdd = class(TDataModule)
    ClientReport2008V: TLinkSource;
    ClientReport2008VDeclar: TLinkTable;
    ClientReport2008VDeclarID: TIntegerField;
    ClientReport2008VDeclarContract: TStringField;
    ClientReport2008VDeclarClient: TIntegerField;
    ClientReport2008VDeclarClientName: TStringField;
    ClientReport2008VDeclarPeriod: TDateField;
    ClientReport2008VDeclarInvoiceID: TIntegerField;
    ClientReport2008VDeclarInvoiceProdID: TIntegerField;
    ClientReport2008VDeclarNumInvoice: TStringField;
    ClientReport2008VDeclarDateInvoice: TDateField;
    ClientReport2008VDeclarCurrency: TSmallintField;
    ClientReport2008VDeclarSumma: TFloatField;
    ClientReport2008VDeclarSummaClose: TFloatField;
    ClientReport2008VDeclarSummaConnection: TFloatField;
    ClientReport2008VDeclarBalance: TFloatField;
    ClientReport2008VDeclarSummaDoc: TFloatField;
    ClientReport2008VDeclarSummaDocActive: TFloatField;
    ClientReport2008VDeclarDateComing: TDateField;
    ClientReport2008VDeclarPayDocID: TIntegerField;
    ClientReport2008VDeclarTransactID: TIntegerField;
    ClientReport2008VDeclarIsEndPeriod: TSmallintField;
    ClientReport2008VDeclarProd: TIntegerField;
    ClientReport2008VDeclarAccountProd: TStringField;
    ClientReport2008VDeclarAccountD: TStringField;
    ClientReport2008VDeclarAccountK: TStringField;
    ClientReport2008VC: TDBFormControl;
    ClientReport2008VByC: TDBFormControl;
    ClientReport2008VBy: TLinkSource;
    ClientReport2008VByDeclar: TLinkTable;
    ClientReport2008VByDeclarID: TIntegerField;
    ClientReport2008VByDeclarContract: TStringField;
    ClientReport2008VByDeclarClient: TIntegerField;
    ClientReport2008VByDeclarClientName: TStringField;
    ClientReport2008VByDeclarPeriod: TDateField;
    ClientReport2008VByDeclarInvoiceID: TIntegerField;
    ClientReport2008VByDeclarInvoiceProdID: TIntegerField;
    ClientReport2008VByDeclarNumInvoice: TStringField;
    ClientReport2008VByDeclarDateInvoice: TDateField;
    ClientReport2008VByDeclarCurrency: TSmallintField;
    ClientReport2008VByDeclarSumma: TFloatField;
    ClientReport2008VByDeclarSummaBy: TFloatField;
    ClientReport2008VByDeclarSummaClose: TFloatField;
    ClientReport2008VByDeclarSummaConnection: TFloatField;
    ClientReport2008VByDeclarBalance: TFloatField;
    ClientReport2008VByDeclarSummaDoc: TFloatField;
    ClientReport2008VByDeclarSummaDocActive: TFloatField;
    ClientReport2008VByDeclarDateComing: TDateField;
    ClientReport2008VByDeclarNumDoc: TIntegerField;
    ClientReport2008VByDeclarPayDocID: TIntegerField;
    ClientReport2008VByDeclarTransactID: TIntegerField;
    ClientReport2008VByDeclarIsEndPeriod: TSmallintField;
    ClientReport2008VByDeclarProd: TIntegerField;
    ClientReport2008VByDeclarAccountProd: TStringField;
    ClientReport2008VByDeclarAccountD: TStringField;
    ClientReport2008VByDeclarAccountK: TStringField;
    InvoicePay: TLinkSource;
    InvoicePayDeclar: TLinkTable;
    InvoicePayDeclarClientName: TXELookField;
    InvoicePayDeclarCurrencyName: TXELookField;
    InvoicePayDeclarBalance: TFloatField;
    InvoicePayDeclarPeriod: TDateField;
    InvoicePayDeclarPayDocID: TIntegerField;
    InvoicePayDeclarInvoiceID: TIntegerField;
    InvoicePayDeclarSummaCopnnection: TFloatField;
    InvoicePayDeclarDateComing: TDateField;
    InvoicePayDeclarDateInvoice: TDateField;
    InvoicePayDeclarSummaActive: TFloatField;
    InvoicePayDeclarSummaClose: TFloatField;
    InvoicePayDeclarIsEndPeriod: TSmallintField;
    InvoicePayDeclarInvoiceProdID: TIntegerField;
    InvoicePayDeclarTransactID: TIntegerField;
    InvoicePayDeclarClient: TIntegerField;
    InvoicePayDeclarCurrency: TSmallintField;
    InvoicePayC: TDBFormControl;
    Popup: TControlMenu;
    N1: TMenuItem;
    InvoicePayCalculatedItem: TMenuItem;
    ClientReport2008V1: TLinkMenuItem;
    ClientReport2008VBy1: TLinkMenuItem;
    ClientReportTotal2008V: TLinkSource;
    ClientReportTotal2008VDeclar: TLinkTable;
    ClientReportTotal2008VDeclarClient: TIntegerField;
    ClientReportTotal2008VDeclarClientName: TStringField;
    ClientReportTotal2008VDeclarCurrency: TSmallintField;
    ClientReportTotal2008VDeclarPeriod: TDateField;
    ClientReportTotal2008VDeclarBalance: TFloatField;
    ClientReportTotal2008VC: TDBFormControl;
    ClientReportTotal2008V1: TLinkMenuItem;
    ClientReport2008VDeclarAmount: TFloatField;
    ClientReport2008VDeclarProdName: TStringField;
    ClientReport2008VByDeclarCurrencyName: TStringField;
    ClientReport2008VByDeclarSummaDocBy: TFloatField;
    ClientReport2008VByDeclarProdName: TStringField;
    ClientReport2008VByDeclarAmount: TFloatField;
    ClientReport2008VDeclarUnitMName: TStringField;
    ClientReportTotal2008VDeclarTimeCalcBalance: TDateTimeField;
    ClientReport2008VDeclarTableLeft: TSmallintField;
    ClientReport2008VDeclarTableRight: TSmallintField;
    ClientReport2008VByDeclarTableLeft: TSmallintField;
    ClientReport2008VByDeclarTableRight: TSmallintField;
    ClientReport2008VByDeclarSummaConnectionBy: TFloatField;
    ClientReportTotal2008VDeclarIsEndPeriod: TSmallintField;
    ClientReport2008: TLinkSource;
    ClientReport2008Declar: TLinkTable;
    ClientReport2008DeclarsNumber: TSmallintField;
    ClientReport2008DeclarDateInvoice: TDateField;
    ClientReport2008DeclarNumInvoice: TStringField;
    ClientReport2008DeclarSumma: TFloatField;
    ClientReport2008DeclarSummaClose: TFloatField;
    ClientReport2008DeclarSummaUnClose: TFloatField;
    ClientReport2008DeclarDateDoc: TDateField;
    ClientReport2008DeclarNumDoc: TIntegerField;
    ClientReport2008DeclarSummaPay: TFloatField;
    ClientReport2008DeclarSummaPayOut: TFloatField;
    ClientReport2008DeclarSummaRest: TFloatField;
    ClientReport2008C: TDBFormControl;
    ClientReport20081: TLinkMenuItem;
    ClientReport2008DeclarProdName: TStringField;
    ClientReport2008DeclarDateTransact: TDateField;
    Report16_6: TLinkSource;
    Report16_6Declar: TLinkTable;
    Report16_6DeclarTableLeft: TSmallintField;
    Report16_6DeclarTableRight: TSmallintField;
    Report16_6DeclarInvoiceProdID: TIntegerField;
    Report16_6DeclarNumInvoice: TStringField;
    Report16_6DeclarDateInvoice: TDateField;
    Report16_6DeclarClient: TIntegerField;
    Report16_6DeclarCurrency: TSmallintField;
    Report16_6DeclarSummaPrevUnClose: TFloatField;
    Report16_6DeclarSummaClosePrev: TFloatField;
    Report16_6DeclarSummaClosePrevAll: TFloatField;
    Report16_6DeclarSummaBeg: TFloatField;
    Report16_6DeclarSummaCloseBeg: TFloatField;
    Report16_6DeclarInDebtedBeg: TFloatField;
    Report16_6DeclarSumma: TFloatField;
    Report16_6DeclarSummaClose: TFloatField;
    Report16_6DeclarSummaCloseAll: TFloatField;
    Report16_6DeclarInDebted: TFloatField;
    Report16_6DeclarInDebtedAll: TFloatField;
    Report16_6DeclarProd: TIntegerField;
    Report16_6DeclarAccountProd: TStringField;
    Report16_6C: TDBFormControl;
    N2: TMenuItem;
    Report16_2008_1: TLinkMenuItem;
    Report16_6DeclarClientName: TStringField;
    Report16_2008: TLinkSource;
    Report16_2008Declar: TLinkTable;
    Report16_2008DeclarDateInvoice: TDateField;
    Report16_2008DeclarNumInvoice: TStringField;
    Report16_2008DeclarInvoiceProdID: TIntegerField;
    Report16_2008DeclarClient: TIntegerField;
    Report16_2008DeclarClientName: TStringField;
    Report16_2008DeclarCurrency: TSmallintField;
    Report16_2008DeclarSumma: TFloatField;
    Report16_2008DeclarSummaClosePeriod: TFloatField;
    Report16_2008DeclarSaldoBeg: TFloatField;
    Report16_2008DeclarSummaCloseAll: TFloatField;
    Report16_2008DeclarSummaUnClose: TFloatField;
    Report16_2008DeclarProd: TIntegerField;
    Report16_2008DeclarAccountProd: TStringField;
    Report16_2008C: TDBFormControl;
    Report16_2008DeclarSummaBy: TFloatField;
    Report16_2008DeclarRelationBy: TFloatField;
    Report16_2008DeclarSummaClosePeriodBy: TFloatField;
    Report16_2008DeclarSaldoBegBy: TFloatField;
    Report16_2008DeclarSummaCloseAllBy: TFloatField;
    Report16_2008DeclarSummaUnCloseBy: TFloatField;
    Report16_2008DeclarProdName: TStringField;
    Report16_2008DeclarSummaWVATBy: TFloatField;
    Report16_2008DeclarSummaVATBy: TFloatField;
    Summary16_2008: TLinkSource;
    Summary16_2008Declar: TLinkTable;
    Summary16_2008DeclarNum: TSmallintField;
    Summary16_2008DeclarProdName: TStringField;
    Summary16_2008DeclarSaldoBeg: TFloatField;
    Summary16_2008DeclarSaldoBegClose: TFloatField;
    Summary16_2008DeclarSumma: TFloatField;
    Summary16_2008DeclarSummaClose: TFloatField;
    Summary16_2008DeclarSummaCloseAll: TFloatField;
    Summary16_2008DeclarSaldoEnd: TFloatField;
    Summary16_2008C: TDBFormControl;
    Summary16_20081: TLinkMenuItem;
    ClientReportTotal2008VDeclarLastDateInvoice: TDateField;
    ClientReportTotal2008VDeclarLastDatePay: TDateField;
    Report16_2008DeclaraSet: TSmallintField;
    Report16_2008DeclarINN: TStringField;
    ClientReport2008DeclarPayDocID: TIntegerField;
    Chess62_2008: TLinkSource;
    Chess62_2008Declar: TLinkTable;
    Chess62_2008DeclarAccount: TStringField;
    Chess62_2008DeclarS90_00: TFloatField;
    Chess62_2008DeclarS46_05: TFloatField;
    Chess62_2008DeclarS90_06: TFloatField;
    Chess62_2008DeclarS91_07: TFloatField;
    Chess62_2008DeclarS91_08: TFloatField;
    Chess62_2008DeclarS91_09: TFloatField;
    Chess62_2008DeclarS45_01: TFloatField;
    Chess62_2008DeclarS45_02: TFloatField;
    Chess62_2008DeclarTotal: TFloatField;
    Chess62_2008C: TDBFormControl;
    Chess62_2008_1: TLinkMenuItem;
    Circle62: TLinkSource;
    Circle62Declar: TLinkTable;
    Circle62DeclarSaldoBeg: TFloatField;
    Circle62DeclarSumDebet: TFloatField;
    Circle62DeclarSumKredit: TFloatField;
    Circle62DeclarPay: TFloatField;
    Circle62DeclarSaldoEnd: TFloatField;
    Circle62DeclarPeriod: TDateField;
    Circle62DeclarCourseDifference: TFloatField;
    Circle62C: TDBFormControl;
    Circle62_1: TLinkMenuItem;
    Summary16_2008DeclarSaldoEndCheck: TFloatField;
    ClientReport2008VDeclarPercentPay: TFloatField;
    ClientReport2008VDeclarSummaVATPay: TFloatField;
    ClientReport2008VDeclarSummaDocBy: TFloatField;
    ClientReport2008VDeclarPrice: TFloatField;
    ClientReport2008VDeclarAmountPay: TFloatField;
    ClientReport2008VDeclarSummaBy: TFloatField;
    ClientReport2008VDeclarSummaWVATBy: TFloatField;
    ClientReport2008VDeclarSummaVATBy: TFloatField;
    Chess62_2008DeclarAccountName: TStringField;
    Chess62_2008DeclarS45_03: TFloatField;
    ClientReport2008VDeclarBalanceContract: TFloatField;
    ClientReport2008VDeclarIsEndPeriodContract: TSmallintField;
    ClientReportContractTotal2008V: TLinkSource;
    ClientReportContractTotal2008VDeclar: TLinkTable;
    ClientReportContractTotal2008VDeclarID: TIntegerField;
    ClientReportContractTotal2008VDeclarClient: TIntegerField;
    ClientReportContractTotal2008VDeclarClientName: TStringField;
    ClientReportContractTotal2008VDeclarContract: TStringField;
    ClientReportContractTotal2008VDeclarCurrency: TSmallintField;
    ClientReportContractTotal2008VDeclarSummaInvoice: TFloatField;
    ClientReportContractTotal2008VDeclarSummaPay: TFloatField;
    ClientReportContractTotal2008VDeclarLastPeriod: TDateField;
    ClientReportContractTotal2008VDeclarBalanceContract: TFloatField;
    ClientReportContractTotal2008VC: TDBFormControl;
    ClientReportContractTotal2008V1: TLinkMenuItem;
    ClientReportTotal2008VDeclarFirstDateInvoiceUnClose: TDateField;
    ClientReportTotal2008VDeclarFirstDatePayDocActive: TDateField;
    TransactReport2008V: TLinkSource;
    TransactReport2008VDeclar: TLinkTable;
    TransactReport2008VDeclarPeriod: TDateField;
    TransactReport2008VDeclarSaldoBeg: TFloatField;
    TransactReport2008VDeclarDebet: TFloatField;
    TransactReport2008VDeclarKredit: TFloatField;
    TransactReport2008VDeclarCourseDifferenceD: TFloatField;
    TransactReport2008VDeclarCourseDifferenceK: TFloatField;
    TransactReport2008VDeclarPayBy: TFloatField;
    TransactReport2008VDeclarSaldoEnd: TFloatField;
    TransactReport2008VDeclarCourseDifferenceDose: TFloatField;
    TransactReport2008VC: TDBFormControl;
    TransactReport2008V1: TLinkMenuItem;
    AccountsReceivable2008V: TLinkSource;
    AccountsReceivable2008VDeclar: TLinkTable;
    AccountsReceivable2008VDeclaraReportPeriod: TDateField;
    AccountsReceivable2008VDeclaraPrevReportPeriod: TDateField;
    AccountsReceivable2008VDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivable2008VDeclarSumAll: TFloatField;
    AccountsReceivable2008VDeclarSumLateAll: TFloatField;
    AccountsReceivable2008VDeclarSumLate3m: TFloatField;
    AccountsReceivable2008VDeclarSumLate6m: TFloatField;
    AccountsReceivable2008VDeclarSumLate1y: TFloatField;
    AccountsReceivable2008VDeclarSumLate3y: TFloatField;
    AccountsReceivable2008VC: TDBFormControl;
    AccountsReceivable2008V1: TLinkMenuItem;
    Summary16_2008DeclarCourseDifference: TFloatField;
    AccountsPayable2008V: TLinkSource;
    AccountsPayable2008VDeclar: TLinkTable;
    AccountsPayable2008VDeclaraReportPeriod: TDateField;
    AccountsPayable2008VDeclaraPrevReportPeriod: TDateField;
    AccountsPayable2008VDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayable2008VDeclarSumAll: TFloatField;
    AccountsPayable2008VDeclarSumLateAll: TFloatField;
    AccountsPayable2008VDeclarSumLate3m: TFloatField;
    AccountsPayable2008VDeclarSumLate6m: TFloatField;
    AccountsPayable2008VDeclarSumLate1y: TFloatField;
    AccountsPayable2008VDeclarSumLate3y: TFloatField;
    AccountsPayable2008VC: TDBFormControl;
    AccountsPayable2008V1: TLinkMenuItem;
    Chess62_2008DeclarS91_10: TFloatField;
    AccountsPayable2008VClient: TLinkSource;
    AccountsPayable2008VClientDeclar: TLinkTable;
    AccountsPayable2008VClientDeclaraReportPeriod: TDateField;
    AccountsPayable2008VClientDeclaraPrevReportPeriod: TDateField;
    AccountsPayable2008VClientDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayable2008VClientDeclarSumAll: TFloatField;
    AccountsPayable2008VClientDeclarSumLateAll: TFloatField;
    AccountsPayable2008VClientDeclarSumLate3m: TFloatField;
    AccountsPayable2008VClientDeclarSumLate6m: TFloatField;
    AccountsPayable2008VClientDeclarSumLate1y: TFloatField;
    AccountsPayable2008VClientDeclarSumLate3y: TFloatField;
    AccountsPayable2008VClientDeclarClient: TIntegerField;
    AccountsPayable2008VClientC: TDBFormControl;
    AccountsPayable2008VClient1: TLinkMenuItem;
    AccountsReceivable2008VClient: TLinkSource;
    AccountsReceivable2008VClientDeclar: TLinkTable;
    AccountsReceivable2008VClientDeclaraReportPeriod: TDateField;
    AccountsReceivable2008VClientDeclaraPrevReportPeriod: TDateField;
    AccountsReceivable2008VClientDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivable2008VClientDeclarSumAll: TFloatField;
    AccountsReceivable2008VClientDeclarSumLateAll: TFloatField;
    AccountsReceivable2008VClientDeclarSumLate3m: TFloatField;
    AccountsReceivable2008VClientDeclarSumLate6m: TFloatField;
    AccountsReceivable2008VClientDeclarSumLate1y: TFloatField;
    AccountsReceivable2008VClientDeclarSumLate3y: TFloatField;
    AccountsReceivable2008VClientDeclarClient: TIntegerField;
    AccountsReceivable2008VClientDeclarClientName: TStringField;
    AccountsReceivable2008VClientC: TDBFormControl;
    AccountsReceivable2008VClient1: TLinkMenuItem;
    AccountsPayable2008VClientDeclarClientName: TStringField;
    AccountsPayable2008VClientDeclarRezident: TSmallintField;
    AccountsPayable2008VClientDeclarCountry: TSmallintField;
    AccountsReceivable2008VClientDeclarCountry: TSmallintField;
    Report16_2008DeclarRezident: TSmallintField;
    Report16_2008DeclarCourseDifference: TFloatField;
    Report16_2008DeclarPeriod: TDateField;
    Report16_2008DeclarCountry: TSmallintField;
    ClientBuildingGrodno: TLinkSource;
    ClientBuildingGrodnoDeclar: TLinkTable;
    ClientBuildingGrodnoDeclarID: TIntegerField;
    ClientBuildingGrodnoDeclarClient: TIntegerField;
    ClientBuildingGrodnoDeclarsGroup: TIntegerField;
    ClientBuildingGrodnoDeclarGroupName: TStringField;
    ClientBuildingGrodnoC: TDBFormControl;
    ClientBuildingGrodno1: TLinkMenuItem;
    N3: TMenuItem;
    ClientBuildingGrodnoReal: TLinkSource;
    ClientBuildingGrodnoRealDeclar: TLinkTable;
    ClientBuildingGrodnoRealDeclarID: TIntegerField;
    ClientBuildingGrodnoRealDeclarClient: TIntegerField;
    ClientBuildingGrodnoRealDeclarBegPeriod: TDateField;
    ClientBuildingGrodnoRealDeclarEndPeriod: TDateField;
    ClientBuildingGrodnoRealDeclarClientName: TStringField;
    ClientBuildingGrodnoRealDeclarSaldoBeg: TFloatField;
    ClientBuildingGrodnoRealDeclarSumBrick: TFloatField;
    ClientBuildingGrodnoRealDeclarSumBlock: TFloatField;
    ClientBuildingGrodnoRealDeclarSumProd: TFloatField;
    ClientBuildingGrodnoRealDeclarSumPay: TFloatField;
    ClientBuildingGrodnoRealDeclarSumPay51: TFloatField;
    ClientBuildingGrodnoRealDeclarSaldoEnd: TFloatField;
    ClientBuildingGrodnoRealDeclarOwnerName: TStringField;
    ClientBuildingGrodnoRealC: TDBFormControl;
    ClientBuildingGrodnoReal1: TLinkMenuItem;
    CommodityOutput: TLinkSource;
    CommodityOutputDeclar: TLinkTable;
    CommodityOutputDeclarID: TIntegerField;
    CommodityOutputDeclarProd: TIntegerField;
    CommodityOutputDeclarProdName: TStringField;
    CommodityOutputDeclarTare: TSmallintField;
    CommodityOutputDeclarTareName: TStringField;
    CommodityOutputDeclarUnitM: TSmallintField;
    CommodityOutputDeclarUnitMName: TStringField;
    CommodityOutputDeclarAmountGrossInternal: TFloatField;
    CommodityOutputDeclarAmountExportNear: TFloatField;
    CommodityOutputDeclarAmountExportFar: TFloatField;
    CommodityOutputDeclarAmountTrade: TFloatField;
    CommodityOutputDeclarAmountTotal: TFloatField;
    CommodityOutputDeclarSumGrossInternal: TFloatField;
    CommodityOutputDeclarSumExportNear: TFloatField;
    CommodityOutputDeclarSumExportFar: TFloatField;
    CommodityOutputDeclarSumTrade: TFloatField;
    CommodityOutputDeclarSumTotal: TFloatField;
    CommodityOutputC: TDBFormControl;
    CommodityOutput1: TLinkMenuItem;
    CommodityOutputDeclarSumCPGrossInternal: TFloatField;
    CommodityOutputDeclarSumCPExportNear: TFloatField;
    CommodityOutputDeclarSumCPExportFar: TFloatField;
    CommodityOutputDeclarSumCPTrade: TFloatField;
    CommodityOutputDeclarSumCPTotal: TFloatField;
    ClientBuildingGrodnoRealDeclarDatePay: TDateField;
    ClientBuildingGrodnoRealDeclarPlan: TIntegerField;
    ClientBuildingGrodnoDeclarIsPrint: TXEListField;
    ClientBuildingGrodnoDeclarClientName: TXELookField;
    ClientReportTotal2008VDeclarBalanceBy: TFloatField;
    ClientReportTotal2008VDeclarContract: TStringField;
    ClientReportTotal2008VDeclarDateContract: TDateField;
    Chess62_2008DeclarS91_13: TFloatField;
    TareMove: TLinkSource;
    TareMoveDeclar: TLinkTable;
    TareMoveDeclarsDate: TDateField;
    TareMoveDeclarOperation: TSmallintField;
    TareMoveDeclarNumDoc: TStringField;
    TareMoveDeclarClient: TIntegerField;
    TareMoveDeclarTare: TSmallintField;
    TareMoveDeclarPackage: TSmallintField;
    TareMoveDeclarID: TAutoIncField;
    TareMoveDeclarNumDoc1: TStringField;
    TareMoveDeclarOperationName: TXELookField;
    TareMoveDeclarClientName: TXELookField;
    TareMoveDeclarTareName: TXELookField;
    TareMoveC: TDBFormControl;
    N4: TMenuItem;
    TareMove1: TLinkMenuItem;
    TareMoveReport: TLinkSource;
    TareMoveReportDeclar: TLinkTable;
    TareMoveReportDeclarID: TIntegerField;
    TareMoveReportDeclarsDate: TDateField;
    TareMoveReportDeclarOperation: TSmallintField;
    TareMoveReportDeclarClient: TIntegerField;
    TareMoveReportDeclarNumDoc: TStringField;
    TareMoveReportDeclarNumDoc1: TStringField;
    TareMoveReportDeclarTare: TSmallintField;
    TareMoveReportDeclarPackageOut: TSmallintField;
    TareMoveReportDeclarPackageIn: TSmallintField;
    TareMoveReportDeclarRest: TSmallintField;
    TareMoveReportDeclarOperationName: TXELookField;
    TareMoveReportC: TDBFormControl;
    TareMoveReport1: TLinkMenuItem;
    TareMoveReportTotal: TLinkSource;
    TareMoveReportTotalDeclar: TLinkTable;
    TareMoveReportTotalDeclarID: TIntegerField;
    TareMoveReportTotalDeclarDateBeg: TDateField;
    TareMoveReportTotalDeclarDateEnd: TDateField;
    TareMoveReportTotalDeclarClient: TIntegerField;
    TareMoveReportTotalDeclarTare: TSmallintField;
    TareMoveReportTotalDeclarSaldoBeg: TSmallintField;
    TareMoveReportTotalDeclarPackageOut: TSmallintField;
    TareMoveReportTotalDeclarPackageIn: TSmallintField;
    TareMoveReportTotalDeclarPackageOff: TSmallintField;
    TareMoveReportTotalDeclarSaldoEnd: TSmallintField;
    TareMoveReportTotalDeclarClientName: TXELookField;
    TareMoveReportTotalC: TDBFormControl;
    TareMoveReportTotal1: TLinkMenuItem;
    TareMovePenalty: TLinkSource;
    TareMovePenaltyDeclar: TLinkTable;
    TareMovePenaltyDeclarID: TIntegerField;
    TareMovePenaltyDeclarNumDocOut: TStringField;
    TareMovePenaltyDeclarNumDoc1Out: TStringField;
    TareMovePenaltyDeclarPackageOut: TSmallintField;
    TareMovePenaltyDeclarDateNorm: TDateField;
    TareMovePenaltyDeclarDateIn: TDateField;
    TareMovePenaltyDeclarNumDocIn: TStringField;
    TareMovePenaltyDeclarNumDoc1In: TStringField;
    TareMovePenaltyDeclarPackageIn: TSmallintField;
    TareMovePenaltyDeclarRestOut: TSmallintField;
    TareMovePenaltyDeclarPackage15: TSmallintField;
    TareMovePenaltyDeclarSumma15: TFloatField;
    TareMovePenaltyDeclarPackage16: TSmallintField;
    TareMovePenaltyDeclarSumma16: TFloatField;
    TareMovePenaltyDeclarPackageCompens: TSmallintField;
    TareMovePenaltyDeclarSummaCompens: TFloatField;
    TareMovePenaltyDeclarTare: TSmallintField;
    TareMovePenaltyDeclarClient: TIntegerField;
    TareMovePenaltyDeclarIdOut: TIntegerField;
    TareMovePenaltyDeclarIdIn: TIntegerField;
    TareMovePenaltyDeclarPackageConnection: TSmallintField;
    TareMovePenaltyDeclarRestIn: TSmallintField;
    TareMovePenaltyDeclarBalance: TSmallintField;
    TareMovePenaltyDeclarContract: TStringField;
    TareMovePenaltyDeclarPeriodReturn: TSmallintField;
    TareMovePenaltyC: TDBFormControl;
    TareMovePenalty1: TLinkMenuItem;
    AccountsReceivable2008VClientDeclarAddress: TStringField;
    AccountsReceivable2008VClientDeclarPhones: TStringField;
    CommodityOutputDeclarID1: TIntegerField;
    CommodityOutputDeclarAmountGrossInternalOld: TFloatField;
    CommodityOutputDeclarAmountGrossInternalDiff: TFloatField;
    CommodityOutputDeclarAmountExportNearOld: TFloatField;
    CommodityOutputDeclarAmountExportNearDiff: TFloatField;
    CommodityOutputDeclarAmountExportFarOld: TFloatField;
    CommodityOutputDeclarAmountExportFarDiff: TFloatField;
    CommodityOutputDeclarAmountTradeOld: TFloatField;
    CommodityOutputDeclarAmountTradeDiff: TFloatField;
    CommodityOutputDeclarAmountTotalOld: TFloatField;
    CommodityOutputDeclarAmountTotalDiff: TFloatField;
    CommodityOutputDeclarSumCPGrossInternalOld: TFloatField;
    CommodityOutputDeclarSumCPGrossInternalDiff: TFloatField;
    CommodityOutputDeclarSumCPExportNearOld: TFloatField;
    CommodityOutputDeclarSumCPExportNearDiff: TFloatField;
    CommodityOutputDeclarSumCPExportFarOld: TFloatField;
    CommodityOutputDeclarSumCPExportFarDiff: TFloatField;
    CommodityOutputDeclarSumCPTradeOld: TFloatField;
    CommodityOutputDeclarSumCPTradeDiff: TFloatField;
    CommodityOutputDeclarSumCPTotalOld: TFloatField;
    CommodityOutputDeclarSumCPTotalDiff: TFloatField;
    TareMovePenaltyDeclarDateOut: TDateField;
    CommodityOutputDeclarSumGrossInternalOld: TFloatField;
    CommodityOutputDeclarSumGrossInternalDiff: TFloatField;
    CommodityOutputDeclarSumExportNearOld: TFloatField;
    CommodityOutputDeclarSumExportNearDiff: TFloatField;
    CommodityOutputDeclarSumExportFarOld: TFloatField;
    CommodityOutputDeclarSumExportFarDiff: TFloatField;
    CommodityOutputDeclarSumTradeOld: TFloatField;
    CommodityOutputDeclarSumTradeDiff: TFloatField;
    CommodityOutputDeclarSumTotalOld: TFloatField;
    CommodityOutputDeclarSumTotalDiff: TFloatField;
    Chess62_2008DeclarCourseDifference: TFloatField;
    AccountsPayable2008VContract: TLinkSource;
    AccountsPayable2008VContractDeclar: TLinkTable;
    AccountsPayable2008VContractDeclaraReportPeriod: TDateField;
    AccountsPayable2008VContractDeclaraPrevReportPeriod: TDateField;
    AccountsPayable2008VContractDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayable2008VContractDeclarClient: TIntegerField;
    AccountsPayable2008VContractDeclarClientName: TStringField;
    AccountsPayable2008VContractDeclarSumAll: TFloatField;
    AccountsPayable2008VContractDeclarSumLateAll: TFloatField;
    AccountsPayable2008VContractDeclarSumLate3m: TFloatField;
    AccountsPayable2008VContractDeclarSumLate6m: TFloatField;
    AccountsPayable2008VContractDeclarSumLate1y: TFloatField;
    AccountsPayable2008VContractDeclarSumLate3y: TFloatField;
    AccountsPayable2008VContractDeclarCountry: TSmallintField;
    AccountsPayable2008VContractDeclarContract: TStringField;
    AccountsPayable2008VContractDeclarRezident: TSmallintField;
    AccountsPayable2008VContractC: TDBFormControl;
    AccountsPayable2008VContract1: TLinkMenuItem;
    AccountsReceivable2008VContract: TLinkSource;
    AccountsReceivable2008VContractDeclar: TLinkTable;
    AccountsReceivable2008VContractDeclaraReportPeriod: TDateField;
    AccountsReceivable2008VContractDeclaraPrevReportPeriod: TDateField;
    AccountsReceivable2008VContractDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivable2008VContractDeclarClient: TIntegerField;
    AccountsReceivable2008VContractDeclarClientName: TStringField;
    AccountsReceivable2008VContractDeclarAddress: TStringField;
    AccountsReceivable2008VContractDeclarPhones: TStringField;
    AccountsReceivable2008VContractDeclarSumAll: TFloatField;
    AccountsReceivable2008VContractDeclarSumLateAll: TFloatField;
    AccountsReceivable2008VContractDeclarSumLate3m: TFloatField;
    AccountsReceivable2008VContractDeclarSumLate6m: TFloatField;
    AccountsReceivable2008VContractDeclarSumLate1y: TFloatField;
    AccountsReceivable2008VContractDeclarSumLate3y: TFloatField;
    AccountsReceivable2008VContractDeclarCountry: TSmallintField;
    AccountsReceivable2008VContractDeclarContract: TStringField;
    AccountsReceivable2008VContractC: TDBFormControl;
    AccountsReceivable2008VContract1: TLinkMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ClientReport2008VDeclarTransport: TStringField;
    ClientReport2008VDeclarStation: TStringField;
    ClientReport2008VDeclarStationName: TStringField;
    Report16_2008DeclarContract: TStringField;
    Chess62_2008DeclarCorrection: TFloatField;
    Chess62_2008DeclarPeriod: TDateField;
    ClientReport2008VByDeclarBalanceContract: TFloatField;
    ClientReport2008VByDeclarDestination: TStringField;
    ClientReport2008VByDeclarSectionD: TSmallintField;
    ClientReport2008VByDeclarSectionK: TSmallintField;
    ClientReport2008VByDeclarSummaConnectionBy_1: TFloatField;
    ClientReport2008VByDeclarCourseDifference: TFloatField;
    ClientReport2008VByDeclarSummaDocRest: TFloatField;
    TransactReport2008V2: TLinkSource;
    TransactReport2008V2Declar: TLinkTable;
    TransactReport2008V2DeclarPeriod: TDateField;
    TransactReport2008V2DeclarID: TIntegerField;
    TransactReport2008V2DeclarsDate: TDateField;
    TransactReport2008V2DeclarClient: TIntegerField;
    TransactReport2008V2DeclarContract: TStringField;
    TransactReport2008V2DeclarRezident: TSmallintField;
    TransactReport2008V2DeclarCountry: TSmallintField;
    TransactReport2008V2DeclarSaldoBeg: TFloatField;
    TransactReport2008V2DeclarDebet: TFloatField;
    TransactReport2008V2DeclarKredit: TFloatField;
    TransactReport2008V2DeclarCourseDifferenceD: TFloatField;
    TransactReport2008V2DeclarCourseDifferenceK: TFloatField;
    TransactReport2008V2DeclarPayBy: TFloatField;
    TransactReport2008V2DeclarCourseDifferenceDose: TFloatField;
    TransactReport2008V2DeclarSaldoEnd: TFloatField;
    TransactReport2008V2DeclarAccountD: TStringField;
    TransactReport2008V2DeclarAccountK: TStringField;
    TransactReport2008V2C: TDBFormControl;
    TransactReport2008V21: TLinkMenuItem;
    TransactReport2008V2DeclarAccountDName: TXELookField;
    TransactReport2008V2DeclarDestination: TStringField;
    Chess62_2008DeclarS91_12: TFloatField;
    Chess62_2008DeclarS10_04: TFloatField;
    Report16_2008DeclarNote: TStringField;
    TareRest: TLinkSource;
    TareRestDeclar: TLinkTable;
    TareRestDeclarPeriod: TDateField;
    TareRestDeclarClient: TIntegerField;
    TareRestDeclarTare: TSmallintField;
    TareRestDeclarRest: TSmallintField;
    TareRestDeclarClientName: TXELookField;
    TareRestDeclarTareName: TXELookField;
    TareRestC: TDBFormControl;
    TareRest1: TLinkMenuItem;
    ClientReport2008VDeclarNumDoc: TStringField;
    Report16_2008DeclarAmount: TFloatField;
    Report16_2008DeclarPrice: TFloatField;
    Report16_2008DeclarPriceBy: TFloatField;
    ClientReport2008DeclarProd: TIntegerField;
    TareMoveReportDeclarPackageOff: TSmallintField;
    TareMoveDeclarDateOut: TDateField;
    TareMoneyReturn: TLinkSource;
    TareMoneyReturnDeclar: TLinkTable;
    TareMoneyReturnDeclarsDate: TDateField;
    TareMoneyReturnDeclarTare: TSmallintField;
    TareMoneyReturnDeclarContract: TStringField;
    TareMoneyReturnDeclarDateContract: TDateField;
    TareMoneyReturnDeclarPrice: TFloatField;
    TareMoneyReturnDeclarSumma: TFloatField;
    TareMoneyReturnDeclarID: TAutoIncField;
    TareMoneyReturnDeclarTareName: TXELookField;
    TareMoneyReturnC: TDBFormControl;
    TareMoneyReturn1: TLinkMenuItem;
    TareMoneyReturnDeclarPackage: TSmallintField;
    TareMoveReportTotalDeclarPackageBuy: TSmallintField;
    TransactReport2008V2DeclarCurrency: TSmallintField;
    TransactReport2008V2DeclarCourseBeg: TFloatField;
    TransactReport2008V2DeclarCourseEnd: TFloatField;
    TransactReport2008V2DeclarClientName: TStringField;
    TransactReport2008V2DeclarSummaBeg: TFloatField;
    TransactReport2008V2DeclarSummaEnd: TFloatField;
    ClientBuildingGrodnoRealDeclarsGroup: TSmallintField;
    ClientBuildingGrodnoRealDeclarsGroupName: TStringField;
    ClientReport: TLinkSource;
    ClientReportDeclar: TLinkTable;
    ClientReportDeclarID: TSmallintField;
    ClientReportDeclarContract: TStringField;
    ClientReportDeclarCurrency: TSmallintField;
    ClientReportDeclarAccount: TStringField;
    ClientReportDeclarIDOut: TIntegerField;
    ClientReportDeclarIDTOut: TIntegerField;
    ClientReportDeclarDateOut: TDateField;
    ClientReportDeclarNumDocOut: TStringField;
    ClientReportDeclarProdOut: TIntegerField;
    ClientReportDeclarProdOutName: TStringField;
    ClientReportDeclarSummaOut: TFloatField;
    ClientReportDeclarSummaOutBy: TFloatField;
    ClientReportDeclarSummaCloseOut: TFloatField;
    ClientReportDeclarSummaCloseOutBy: TFloatField;
    ClientReportDeclarSummaUnCloseOut: TFloatField;
    ClientReportDeclarSummaUnCloseOutBy: TFloatField;
    ClientReportDeclarIDIn: TIntegerField;
    ClientReportDeclarIDTIn: TIntegerField;
    ClientReportDeclarDateIn: TDateField;
    ClientReportDeclarNumDocIn: TStringField;
    ClientReportDeclarProdIn: TIntegerField;
    ClientReportDeclarProdInName: TStringField;
    ClientReportDeclarSummaIn: TFloatField;
    ClientReportDeclarSummaInBy: TFloatField;
    ClientReportDeclarSummaCloseIn: TFloatField;
    ClientReportDeclarSummaCloseInBy: TFloatField;
    ClientReportDeclarSummaUnCloseIn: TFloatField;
    ClientReportDeclarSummaUnCloseInBy: TFloatField;
    ClientReportC: TDBFormControl;
    ClentReport1: TLinkMenuItem;
    Report16: TLinkSource;
    Report16Declar: TLinkTable;
    Report16DeclarDateOut: TDateField;
    Report16DeclarNumDocOut: TStringField;
    Report16DeclarIDOut: TIntegerField;
    Report16DeclarIDTOut: TIntegerField;
    Report16DeclaraSet: TSmallintField;
    Report16DeclarPeriod: TDateField;
    Report16DeclarClient: TIntegerField;
    Report16DeclarClientName: TStringField;
    Report16DeclarINN: TStringField;
    Report16DeclarRezident: TSmallintField;
    Report16DeclarCountry: TSmallintField;
    Report16DeclarContract: TStringField;
    Report16DeclarCurrency: TSmallintField;
    Report16DeclarProdOut: TIntegerField;
    Report16DeclarProdOutName: TStringField;
    Report16DeclarAmount: TFloatField;
    Report16DeclarPrice: TFloatField;
    Report16DeclarPriceBy: TFloatField;
    Report16DeclarAccountDOut: TStringField;
    Report16DeclarAccountKOut: TStringField;
    Report16DeclarSummaOut: TFloatField;
    Report16DeclarSummaOutWVATBy: TFloatField;
    Report16DeclarSummaOutVATBy: TFloatField;
    Report16DeclarSummaOutBy: TFloatField;
    Report16DeclarSummaCloseOutPeriod: TFloatField;
    Report16DeclarSummaCloseOutPeriodBy: TFloatField;
    Report16DeclarSaldoOutBeg: TFloatField;
    Report16DeclarSaldoOutBegBy: TFloatField;
    Report16DeclarSummaCloseOut: TFloatField;
    Report16DeclarSummaCloseOutBy: TFloatField;
    Report16DeclarSummaUnCloseOut: TFloatField;
    Report16DeclarSummaUnCloseOutBy: TFloatField;
    Report16DeclarCourseDifference: TFloatField;
    Report16DeclarNote: TStringField;
    Report16C: TDBFormControl;
    N7: TMenuItem;
    Report16_1: TLinkMenuItem;
    Summary16: TLinkSource;
    Summary16Declar: TLinkTable;
    Summary16DeclarNum: TSmallintField;
    Summary16DeclarProdName: TStringField;
    Summary16DeclarSaldoBeg: TFloatField;
    Summary16DeclarSaldoBegClose: TFloatField;
    Summary16DeclarSumma: TFloatField;
    Summary16DeclarSummaClose: TFloatField;
    Summary16DeclarSummaCloseAll: TFloatField;
    Summary16DeclarCourseDifference: TFloatField;
    Summary16DeclarSaldoEnd: TFloatField;
    Summary16DeclarSaldoEndCheck: TFloatField;
    Summary16C: TDBFormControl;
    Summary16_1: TLinkMenuItem;
    AccountsReceivableV: TLinkSource;
    AccountsReceivableVDeclar: TLinkTable;
    AccountsReceivableVDeclaraReportPeriod: TDateField;
    AccountsReceivableVDeclaraPrevReportPeriod: TDateField;
    AccountsReceivableVDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivableVDeclarSumAll: TFloatField;
    AccountsReceivableVDeclarSumLateAll: TFloatField;
    AccountsReceivableVDeclarSumLate3m: TFloatField;
    AccountsReceivableVDeclarSumLate6m: TFloatField;
    AccountsReceivableVDeclarSumLate1y: TFloatField;
    AccountsReceivableVDeclarSumLate3y: TFloatField;
    AccountsReceivableVC: TDBFormControl;
    N8: TMenuItem;
    AccountsRecievableV1: TLinkMenuItem;
    AccountsReceivableVClient: TLinkSource;
    AccountsReceivableVClientDeclar: TLinkTable;
    AccountsReceivableVClientDeclaraReportPeriod: TDateField;
    AccountsReceivableVClientDeclaraPrevReportPeriod: TDateField;
    AccountsReceivableVClientDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivableVClientDeclarClient: TIntegerField;
    AccountsReceivableVClientDeclarClientName: TStringField;
    AccountsReceivableVClientDeclarAddress: TStringField;
    AccountsReceivableVClientDeclarPhones: TStringField;
    AccountsReceivableVClientDeclarSumAll: TFloatField;
    AccountsReceivableVClientDeclarSumLateAll: TFloatField;
    AccountsReceivableVClientDeclarSumLate3m: TFloatField;
    AccountsReceivableVClientDeclarSumLate6m: TFloatField;
    AccountsReceivableVClientDeclarSumLate1y: TFloatField;
    AccountsReceivableVClientDeclarSumLate3y: TFloatField;
    AccountsReceivableVClientDeclarCountry: TSmallintField;
    AccountsReceivableVClientC: TDBFormControl;
    AccountsReceivableVClient1: TLinkMenuItem;
    AccountsReceivableVContract: TLinkSource;
    AccountsReceivableVContractDeclar: TLinkTable;
    AccountsReceivableVContractDeclaraReportPeriod: TDateField;
    AccountsReceivableVContractDeclaraPrevReportPeriod: TDateField;
    AccountsReceivableVContractDeclaraPrevPrevReportPeriod: TDateField;
    AccountsReceivableVContractDeclarClient: TIntegerField;
    AccountsReceivableVContractDeclarClientName: TStringField;
    AccountsReceivableVContractDeclarContract: TStringField;
    AccountsReceivableVContractDeclarAddress: TStringField;
    AccountsReceivableVContractDeclarPhones: TStringField;
    AccountsReceivableVContractDeclarSumAll: TFloatField;
    AccountsReceivableVContractDeclarSumLateAll: TFloatField;
    AccountsReceivableVContractDeclarSumLate3m: TFloatField;
    AccountsReceivableVContractDeclarSumLate6m: TFloatField;
    AccountsReceivableVContractDeclarSumLate1y: TFloatField;
    AccountsReceivableVContractDeclarSumLate3y: TFloatField;
    AccountsReceivableVContractDeclarCountry: TSmallintField;
    AccountsReceivableVContractC: TDBFormControl;
    AccountsReceivableVContract1: TLinkMenuItem;
    Chess62: TLinkSource;
    Chess62Declar: TLinkTable;
    Chess62DeclarAccount: TStringField;                           
    Chess62DeclarAccountName: TStringField;
    Chess62DeclarS90_00: TFloatField;
    Chess62DeclarS46_05: TFloatField;
    Chess62DeclarS90_06: TFloatField;
    Chess62DeclarS91_07: TFloatField;
    Chess62DeclarS91_08: TFloatField;
    Chess62DeclarS91_09: TFloatField;
    Chess62DeclarS91_10: TFloatField;
    Chess62DeclarS91_12: TFloatField;
    Chess62DeclarS91_13: TFloatField;
    Chess62DeclarS10_04: TFloatField;
    Chess62DeclarS45_01: TFloatField;
    Chess62DeclarS45_02: TFloatField;
    Chess62DeclarS45_03: TFloatField;
    Chess62DeclarCorrection: TFloatField;
    Chess62DeclarCourseDifference: TFloatField;
    Chess62DeclarTotal: TFloatField;
    Chess62DeclarPeriod: TDateField;
    Chess62C: TDBFormControl;
    Chess62_1: TLinkMenuItem;
    TransactReportV: TLinkSource;
    TransactReportVDeclar: TLinkTable;
    TransactReportVDeclarPeriod: TDateField;
    TransactReportVDeclarSaldoBeg: TFloatField;
    TransactReportVDeclarDebet: TFloatField;
    TransactReportVDeclarKredit: TFloatField;
    TransactReportVDeclarCourseDifferenceD: TFloatField;
    TransactReportVDeclarCourseDifferenceK: TFloatField;
    TransactReportVDeclarPayBy: TFloatField;
    TransactReportVDeclarCourseDifferenceDose: TFloatField;
    TransactReportVDeclarSaldoEnd: TFloatField;
    TransactReportVC: TDBFormControl;
    TransactReportV1: TLinkMenuItem;
    N9: TMenuItem;
    AccountsPayableV: TLinkSource;
    AccountsPayableVDeclar: TLinkTable;
    AccountsPayableVDeclaraReportPeriod: TDateField;
    AccountsPayableVDeclaraPrevReportPeriod: TDateField;
    AccountsPayableVDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayableVDeclarSumAll: TFloatField;
    AccountsPayableVDeclarSumLateAll: TFloatField;
    AccountsPayableVDeclarSumLate3m: TFloatField;
    AccountsPayableVDeclarSumLate6m: TFloatField;
    AccountsPayableVDeclarSumLate1y: TFloatField;
    AccountsPayableVDeclarSumLate3y: TFloatField;
    AccountsPayableVC: TDBFormControl;
    AccountsPayableV1: TLinkMenuItem;
    AccountsPayableVClient: TLinkSource;
    AccountsPayableVClientDeclar: TLinkTable;
    AccountsPayableVClientDeclaraReportPeriod: TDateField;
    AccountsPayableVClientDeclaraPrevReportPeriod: TDateField;
    AccountsPayableVClientDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayableVClientDeclarClient: TIntegerField;
    AccountsPayableVClientDeclarClientName: TStringField;
    AccountsPayableVClientDeclarSumAll: TFloatField;
    AccountsPayableVClientDeclarSumLateAll: TFloatField;
    AccountsPayableVClientDeclarSumLate3m: TFloatField;
    AccountsPayableVClientDeclarSumLate6m: TFloatField;
    AccountsPayableVClientDeclarSumLate1y: TFloatField;
    AccountsPayableVClientDeclarSumLate3y: TFloatField;
    AccountsPayableVClientDeclarRezident: TSmallintField;
    AccountsPayableVClientDeclarCountry: TSmallintField;
    AccountsPayableVClientC: TDBFormControl;
    AccountsPayableVClient1: TLinkMenuItem;
    AccountsPayableVContract: TLinkSource;
    AccountsPayableVContractDeclar: TLinkTable;
    AccountsPayableVContractDeclaraReportPeriod: TDateField;
    AccountsPayableVContractDeclaraPrevReportPeriod: TDateField;
    AccountsPayableVContractDeclaraPrevPrevReportPeriod: TDateField;
    AccountsPayableVContractDeclarClient: TIntegerField;
    AccountsPayableVContractDeclarClientName: TStringField;
    AccountsPayableVContractDeclarContract: TStringField;
    AccountsPayableVContractDeclarSumAll: TFloatField;
    AccountsPayableVContractDeclarSumLateAll: TFloatField;
    AccountsPayableVContractDeclarSumLate3m: TFloatField;
    AccountsPayableVContractDeclarSumLate6m: TFloatField;
    AccountsPayableVContractDeclarSumLate1y: TFloatField;
    AccountsPayableVContractDeclarSumLate3y: TFloatField;
    AccountsPayableVContractDeclarRezident: TSmallintField;
    AccountsPayableVContractDeclarCountry: TSmallintField;
    AccountsPayableVContractC: TDBFormControl;
    AccountsPayableVContract1: TLinkMenuItem;
    TransactReportV2: TLinkSource;
    TransactReportV2Declar: TLinkTable;
    TransactReportV2DeclarPeriod: TDateField;
    TransactReportV2DeclarID: TIntegerField;
    TransactReportV2DeclarsDate: TDateField;
    TransactReportV2DeclarClient: TIntegerField;
    TransactReportV2DeclarClientName: TStringField;
    TransactReportV2DeclarContract: TStringField;
    TransactReportV2DeclarRezident: TSmallintField;
    TransactReportV2DeclarCountry: TSmallintField;
    TransactReportV2DeclarCurrency: TSmallintField;
    TransactReportV2DeclarCourseBeg: TFloatField;
    TransactReportV2DeclarCourseEnd: TFloatField;
    TransactReportV2DeclarSummaBeg: TFloatField;
    TransactReportV2DeclarSaldoBeg: TFloatField;
    TransactReportV2DeclarDebet: TFloatField;
    TransactReportV2DeclarKredit: TFloatField;
    TransactReportV2DeclarCourseDifferenceD: TFloatField;
    TransactReportV2DeclarCourseDifferenceK: TFloatField;
    TransactReportV2DeclarPayBy: TFloatField;
    TransactReportV2DeclarCourseDifferenceDose: TFloatField;
    TransactReportV2DeclarSummaEnd: TFloatField;
    TransactReportV2DeclarSaldoEnd: TFloatField;
    TransactReportV2DeclarAccountD: TStringField;
    TransactReportV2DeclarAccountDName: TXELookField;
    TransactReportV2DeclarAccountK: TStringField;
    TransactReportV2DeclarDestination: TStringField;
    TransactReportV2C: TDBFormControl;
    TransactReportV2_1: TLinkMenuItem;
    N10: TMenuItem;
    ClientReportTotal: TLinkSource;
    ClientReportTotalDeclar: TLinkTable;
    ClientReportTotalDeclarID: TSmallintField;
    ClientReportTotalDeclarPeriod: TDateField;
    ClientReportTotalDeclarClient: TIntegerField;
    ClientReportTotalDeclarClientName: TStringField;
    ClientReportTotalDeclarCurrency: TSmallintField;
    ClientReportTotalDeclarCurrencyName: TStringField;
    ClientReportTotalDeclarAccount: TStringField;
    ClientReportTotalDeclarAccountName: TStringField;
    ClientReportTotalDeclarContract: TStringField;
    ClientReportTotalDeclarIsEndPeriodContract: TSmallintField;
    ClientReportTotalDeclarBalanceContract: TFloatField;
    ClientReportTotalDeclarBalanceContractBy: TFloatField;
    ClientReportTotalDeclarIsEndPeriodAccount: TSmallintField;
    ClientReportTotalDeclarBalanceAccount: TFloatField;
    ClientReportTotalDeclarBalanceAccountBy: TFloatField;
    ClientReportTotalDeclarIsEndPeriod: TSmallintField;
    ClientReportTotalDeclarBalance: TFloatField;
    ClientReportTotalDeclarBalanceBy: TFloatField;
    ClientReportTotalDeclarTimeCalcBalance: TDateTimeField;
    ClientReportTotalDeclarLastDateOut: TDateField;
    ClientReportTotalDeclarLastDateIn: TDateField;
    ClientReportTotalDeclarFirstDateOutUnClose: TDateField;
    ClientReportTotalDeclarFirstDateInUnClose: TDateField;
    ClientReportTotalC: TDBFormControl;
    ClientReportTotal1: TLinkMenuItem;
    CheckSaldo: TLinkSource;
    CheckSaldoDeclar: TLinkTable;
    CheckSaldoDeclarPeriod: TDateField;
    CheckSaldoDeclarClient: TIntegerField;
    CheckSaldoDeclarCurrency: TSmallintField;
    CheckSaldoDeclarSaldoBeg: TFloatField;
    CheckSaldoDeclarSumProd: TFloatField;
    CheckSaldoDeclarSumPay: TFloatField;
    CheckSaldoDeclarSaldoEnd: TFloatField;
    CheckSaldoDeclarAccount: TStringField;
    CheckSaldoDeclarCheckFlag: TXEListField;
    CheckSaldoC: TDBFormControl;
    CheckSaldo1: TLinkMenuItem;
    ClientReportDeclarTableIDOut: TIntegerField;
    ClientReportDeclarTableIDIn: TIntegerField;
    ClientReportDeclarDebet: TFloatField;
    ClientReportDeclarKredit: TFloatField;
    ClientReportDeclarDebetBy: TFloatField;
    ClientReportDeclarKreditBy: TFloatField;
    ClientReportDeclarCourseOutUSD: TFloatField;
    ClientReportDeclarSummaOutUSD: TFloatField;
    ClientReportDeclarSummaCloseOutUSD: TFloatField;
    ClientReportDeclarSummaUnCloseOutUSD: TFloatField;
    ClientReportDeclarCourseInUSD: TFloatField;
    ClientReportDeclarSummaInUSD: TFloatField;
    ClientReportDeclarSummaCloseInUSD: TFloatField;
    ClientReportDeclarSummaUnCloseInUSD: TFloatField;
    ClientReportTotalDeclarPlace: TIntegerField;
    ClientReportTotalDeclarPlaceName: TStringField;
    ClientReportTotalDeclarRegion: TIntegerField;
    ClientReportTotalDeclarRegionName: TStringField;
    ClientReportTotalDeclarINN: TStringField;
    ProdRequestForShop: TLinkSource;
    ProdRequestForShopDeclar: TLinkTable;
    ProdRequestForShopDeclarClient: TIntegerField;
    ProdRequestForShopDeclarDateRequest: TDateField;
    ProdRequestForShopDeclarProd: TIntegerField;
    ProdRequestForShopDeclarAmountRailCar: TFloatField;
    ProdRequestForShopDeclarDateShipment: TDateField;
    ProdRequestForShopDeclarNote: TStringField;
    ProdRequestForShopDeclarID: TAutoIncField;
    ProdRequestForShopDeclarClientName: TXELookField;
    ProdRequestForShopDeclarProdName: TXELookField;
    ProdRequestForShopC: TDBFormControl;
    ProdRequestForShop1: TLinkMenuItem;
    ProdRequestForShopDeclarProcess: TXEListField;
    ClientReportTotalDeclarHiOrg: TSmallintField;
    ClientReportTotalDeclarHiOrgName: TStringField;
    ExportToExcelHistory: TLinkSource;
    ExportToExcelHistoryDeclar: TLinkTable;
    ExportToExcelHistoryDeclarNumber: TIntegerField;
    ExportToExcelHistoryDeclarUserName: TStringField;
    ExportToExcelHistoryDeclarNodeAddr: TStringField;
    ExportToExcelHistoryDeclarHostName: TStringField;
    ExportToExcelHistoryDeclarSQLText: TStringField;
    ExportToExcelHistoryDeclarRecordCount: TIntegerField;
    ExportToExcelHistoryDeclarTimeRequest: TDateTimeField;
    ExportToExcelHistoryDeclarTableName: TStringField;
    ExportToExcelHistoryDeclarID: TAutoIncField;
    ExportToExcelHistoryC: TDBFormControl;
    ExportToExcelHistory1: TLinkMenuItem;
    AccountsReceivableVClientDeclarHiOrg: TSmallintField;
    AccountsReceivableVClientDeclarHiOrgName: TStringField;
    AccountsPayableVClientDeclarHiOrg: TSmallintField;
    AccountsPayableVClientDeclarHiOrgName: TStringField;
    TareMoveReportTotalDeclarPackage20: TSmallintField;
    TareMoveReportTotalDeclarPackage35: TSmallintField;
    TareMoveReportTotalDeclarINN: TStringField;
    AccountsReceivableVClientDeclarPlace: TIntegerField;
    AccountsReceivableVClientDeclarPlaceName: TStringField;
    AccountsReceivableVClientDeclarRegion: TIntegerField;
    AccountsReceivableVClientDeclarRegionName: TStringField;
    AccountsPayableVClientDeclarAddress: TStringField;
    AccountsPayableVClientDeclarPhones: TStringField;
    AccountsPayableVClientDeclarPlace: TIntegerField;
    AccountsPayableVClientDeclarPlaceName: TStringField;
    AccountsPayableVClientDeclarRegion: TIntegerField;
    AccountsPayableVClientDeclarRegionName: TStringField;
    ClientReportTotalDeclarLastSummaIn: TFloatField;
    AccountsReceivableVClientNow: TLinkSource;
    AccountsReceivableVClientNowDeclar: TLinkTable;
    AccountsReceivableVClientNowDeclaraReportPeriod: TDateField;
    AccountsReceivableVClientNowDeclaraToday: TDateField;
    AccountsReceivableVClientNowDeclaraTodayMinus60: TDateField;
    AccountsReceivableVClientNowDeclaraTodayMinus90: TDateField;
    AccountsReceivableVClientNowDeclarClient: TIntegerField;
    AccountsReceivableVClientNowDeclarClientName: TStringField;
    AccountsReceivableVClientNowDeclarHiOrg: TSmallintField;
    AccountsReceivableVClientNowDeclarHiOrgName: TStringField;
    AccountsReceivableVClientNowDeclarCountry: TSmallintField;
    AccountsReceivableVClientNowDeclarAddress: TStringField;
    AccountsReceivableVClientNowDeclarPhones: TStringField;
    AccountsReceivableVClientNowDeclarPlace: TIntegerField;
    AccountsReceivableVClientNowDeclarPlaceName: TStringField;
    AccountsReceivableVClientNowDeclarRegion: TIntegerField;
    AccountsReceivableVClientNowDeclarRegionName: TStringField;
    AccountsReceivableVClientNowDeclarSumAll: TFloatField;
    AccountsReceivableVClientNowDeclarSumLateAll: TFloatField;
    AccountsReceivableVClientNowDeclarSumLate3m: TFloatField;
    AccountsReceivableVClientNowDeclarSumLate6m: TFloatField;
    AccountsReceivableVClientNowDeclarSumLate1y: TFloatField;
    AccountsReceivableVClientNowDeclarSumLate3y: TFloatField;
    AccountsReceivableVClientNowC: TDBFormControl;
    AccountsReceivableVClientNow1: TLinkMenuItem;
    AccountsReceivableVClientNowDeclarINN: TStringField;
    AccountsReceivableVClientDeclarINN: TStringField;
    procedure ModuleClientsAddCreate(Sender: TObject);
    procedure ClientReportVCCreateForm(Sender: TObject);
    procedure InteractionAssetsCalculatedItemClick(Sender: TObject);
    procedure OrgSumma1Click(Sender: TObject);
    procedure TimeCalcBalanceClick(Sender:TObject);
    procedure ClientReportClick(Sender: TObject);
    procedure ByClick(Sender:TObject);
    procedure PlusClick(Sender:TObject);
    procedure CheckSaldoClick(Sender:TObject);
    procedure ChangeViewClick(Sender:TObject);
    procedure CalcReportClick(Sender: TObject);
    procedure CalcSummary16_2008Click(Sender: TObject);
    procedure CalcChess62_2008Click(Sender: TObject);
    procedure CalcCircle62Click(Sender: TObject);
    procedure SetGridClientReport2008Font(Sender: TObject; Field: TField; Font: TFont);
    procedure SetGridClientReport2008Color(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetGridClientReportFont(Sender: TObject; Field: TField; Font: TFont);
    procedure SetGridClientReportColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetGridClientReportTotalFont(Sender: TObject; Field: TField; Font: TFont);
    procedure SetGridClientReportTotalColor(Sender: TObject; Field: TField; var Color: TColor);

    procedure CreateReportForm(Sender: TObject);
    procedure SomeCreateForm(Sender: TObject);
    procedure Summary16_2008CCreateForm(Sender: TObject);
    procedure CurrentReportPeriodExit(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure Chess62CCreateForm(Sender: TObject);
    procedure Circle62CCreateForm(Sender: TObject);

    procedure SetGridClientBuildingRealFont(Sender: TObject; Field: TField; Font: TFont);
    procedure SetGridClientBuildingRealColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure TareMoveReportCCreateForm(Sender: TObject);
    procedure TareMoveDeclarNewRecord(DataSet: TDataSet);
    procedure TareMoveDeclarBeforePost(DataSet: TDataSet);
    procedure CommodityOutputVisibleFields(aVisible: boolean);
    procedure TareMoveReportTotalDeclarClientNameGetText(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure TareMoneyReturnCCreateForm(Sender: TObject);
    procedure TareMoneyReturnDeclarNewRecord(DataSet: TDataSet);
    procedure TareMoneyReturnDeclarBeforePost(DataSet: TDataSet);
    procedure ActivateForm(Sender: TObject);
    procedure CheckReport16Form(Sender: TObject);
    procedure Summary16CCreateForm(Sender: TObject);
    procedure CheckTransactReportVForm(Sender: TObject);
    function ProdRequestForShopDeclarClientNameFilter(
      Sender: TObject): String;
    procedure ProdRequestForShopDeclarNewRecord(DataSet: TDataSet);
    procedure ExportToExcelHistoryDeclarBeforeOpen(DataSet: TDataSet);
  public
    { Public declarations }
  end;

  Const _Transact=811;
        _InvoiceProd=910;
        _MInvoiceT=866;
        _MFaktura=1064;
//  Type TInteractionAssetsTableID=(_Transact,_InvoiceProd,_MInvoiceT,_MFaktura);

var ModuleClientsAdd: TModuleClientsAdd;

Implementation

Uses MdBase, MdOrgs, DlgClient, BEForms, EtvDBFun, EtvContr, EtvTemp, EtvPas, EtvRus, MdCommon, MdProd, MdMaterials,
     Buttons, StdCtrls, DlgAct, XECtrls, MdInvc, MdPays, ToolEdit, Math, EtvGrid, EtvBor,
     MdContr, MdWorkers;

{$R *.DFM}

var aLabelTimeCalcBalance: TLabel;
    BtnCalcBalance, BtnTimeCalcBalance, BtnActParam, BtnBy, BtnPlus, BtnCalcSummary16_2008,
    BtnCalcChess62_2008, BtnCalcCircle62, BtnTareMoveReport, BtnTareMoveReportTotal,
    BtnTareMovePenalty, BtnCheckSaldo, BtnChangeView: TBitBtn;
    CurrentReportPeriod: TXEDBDateEdit;
    ReportPeriodChess62,ReportPeriodCircle62: TDateEdit;
    InDateBeg: string[10];
    InDateEnd: string[10];
    InTare: SmallInt=3;
    InDaysOnWay:string[2]='05';
    IsClientReportTotalSend: boolean; // Вызов был из формы ClientReportTotalC
    VisibleBy: boolean; // Видимы ли поля By в акте сверки
    aOperation, aTare: smallint; // Переменные для сохранения временных значений при вводе данных
    aDate: TDateTime;
    aNumDoc, aNumDoc1: string[10];
    aClient: integer;
    aPrice:  Real;
    InClient,InClientAll,InCurrency,InCurrencyAll,InAccount,InAccountAll,InContract: variant;

// Константы для отчетов, чтобы удобно было отрабатывать подготовительные нюансы
Const rpActRevise2008=1;
      rpTareMoveReport=2;
      rpTareMoveReportTotal=3;
      rpTareMovePenalty=4;
      rpActRevise=5;
      rpSumBalance=6;

Procedure TModuleClientsAdd.TimeCalcBalanceClick(Sender:TObject);
var aClient: integer;
    FC: TDBFormControl;
begin
  FC:=TDBFormControl(TBEForm(TBitBtn(Sender).Owner).FormControl);
  if (FC.Name='ClientReportTotalC') or (FC.Name='CheckSaldoC') then
    aLabelTimeCalcBalance.Caption:=ModuleBase.ConfigDeclarEndProcessCB.AsString
  else begin
    if FC.Name='ClientReportC' then aClient:=InClient
    else aClient:=TBEForm(TComponent(Sender).Owner).Grid.DataSource.DataSet.FieldByName('Client').AsInteger;
    aLabelTimeCalcBalance.Caption:=IntToStr(aClient)+' : '+VarToStr(ModuleOrgs.GetClientTimeCalcBalance(aClient));
  end;
end;

Procedure TModuleClientsAdd.ByClick(Sender:TObject); // Включаем/выключаем поля BY
var i: byte;
begin
  with TBitBtn(Sender) do
    if Caption='BY+' then begin
      Caption:='BY-';
      VisibleBy:=true;
    end else begin
      Caption:='BY+';
      VisibleBy:=false;
    end;
  with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.DataSet do
    for i:=0 to FieldCount-1 do
      if (Pos('BY',Fields[i].DisplayLabel)>0) then
        if (VisibleBy and (Fields[i-1].Visible)) or (not VisibleBy) then Fields[i].Visible:=VisibleBy;
  RefreshDataOnForm(nil,true);
  TBEForm(TBitBtn(Sender).Owner).Grid.FormatColumns(true);
end;

Procedure TModuleClientsAdd.PlusClick(Sender:TObject); // Включаем/выключаем фильтр на итоги
var i: byte;
begin
  with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.DataSet do begin
    // Пока простой случай, без учета возможных установленных фильтров
    // Если пользователи будут практиковать установку других фильтров, то
    // придется накладывать/снмать фильтр на итоги с учетом работы других фильтров
    // Lev 07.09.2008
    DisableControls;
    if not Filtered then begin
      Filter:='IDOut=0';
      Filtered:=true;
    end
    else begin
      Filtered:=false;
      Filter:='';
    end;
    EnableControls;
  end;
  {
  RefreshDataOnForm(nil,true);
  TBEForm(TBitBtn(Sender).Owner).Grid.FormatColumns(true);
  }
  with TBitBtn(Sender) do if Caption='-' then Caption:='+' else Caption:='-'
end;

Procedure TModuleClientsAdd.CheckSaldoClick(Sender:TObject); // Вызов формы для контроля расчета по клиентам
begin
  CheckSaldoC.Execute;
end;

Procedure TModuleClientsAdd.ChangeViewClick(Sender:TObject);
var MathView: boolean;
begin
  with TBitBtn(Sender) do
    if Caption='Математический вид' then begin
      Caption:='Бухгалтерский вид';
      MathView:=true;
    end else begin
      Caption:='Математический вид';
      MathView:=false;
    end;
  with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.DataSet do begin
    FieldByName('SummaUnCloseOut').Visible:=MathView;
    FieldByName('SummaUnCloseOutBy').Visible:=VisibleBy and MathView;
    FieldByName('SummaUnCloseIn').Visible:=MathView;
    FieldByName('SummaUnCloseInBy').Visible:=VisibleBy and MathView;
    FieldByName('Debet').Visible:=not MathView;
    FieldByName('DebetBy').Visible:=VisibleBy and not MathView;
    FieldByName('Kredit').Visible:=not MathView;
    FieldByName('KreditBy').Visible:=VisibleBy and not MathView;
  end;
  RefreshDataOnForm(nil,true);
  TBEForm(TBitBtn(Sender).Owner).Grid.FormatColumns(true);
end;

Procedure TModuleClientsAdd.OrgSumma1Click(Sender: TObject);
begin
  if CreateEtvProcess('command.com /c copy \\server_gksm\netdata\xchange\odbctext\org.txt c:\temp\org.',
    'Копирование ORG.TXT на локальную машину',true,true)<>0 then begin
    ShowMessage('Неудачное копирование файла ORG.TXT'+#13+
                'Обратитесь к разработчикам.');
    Abort;
  end;
end;

Procedure TModuleClientsAdd.ModuleClientsAddCreate(Sender: TObject);
var aDate: TDateTime;
    Year, Month, Day: Word;
begin
  DecodeDate(Date,Year,Month,Day);
  InDateBeg:=DateToStr(EncodeDate(Year,Month,1));
  If Month=12 then begin
    Month:=0;
    Year:=Year+1;
  end;
  InDateEnd:=DateToStr(EncodeDate(Year,Month+1,1)-1);
  if Application.Terminated then Exit;
  if (UserName='VERBICKIJ') or (UserName='LEV') or (UserName='FSGL') or (UserName='FSGT') then begin
    ClientReportContractTotal2008V1.Visible:=true;
  end;
  InClient:=300004;
  InClientAll:=null;
  InCurrency:=974;
  InCurrencyAll:=null;
  InAccount:=Null;
  InAccountAll:='62.00';
  InContract:=Null;
end;

Procedure TModuleClientsAdd.ClientReportVCCreateForm(Sender: TObject);
var FC: TDBFormControl;
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  {with ModuleBase do}
  if not(UserName='LEV'){IsProgrammers} then with ClientReport2008VDeclar do begin
    {
    Close;
    ReadOnly:=true;
    Open;
    }
  end;
  FC:=TDBFormControl(Sender);
  with TBEForm(FC.Form) do begin
    if (FC.Name='ClientReportTotal2008VC') or (FC.Name='ClientReportTotalC') then
      Grid.TitleRows:=4 else Grid.TitleRows:=2;
    if FC.Name<>'ClientReport2008C' then begin
      BtnCalcBalance:=TBitBtn.Create(FC.Form);
      with BtnCalcBalance do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        Name:='BtnCalcBalance';
        Caption:='Расчет баланса';
        ShowHint:=true;
        Hint:='Расчет всех хозяйственных операций по клиенту/клиентам за текущий период';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=InteractionAssetsCalculatedItemClick;
      end;
    end;
    BtnTimeCalcBalance:=TBitBtn.Create(FC.Form);
    with BtnTimeCalcBalance do begin
      Top:=0;
      Left:=230;
      Width:=100;
      Height:=22;
      Name:='BtnTimeCalcBalance';
      Font.Style:=[fsBold];
      Caption:='Время расчета';
      ShowHint:=true;
      Hint:='Время расчета по текущему клиенту';
      Parent:=PageControl1TabPanel;
      OnClick:=TimeCalcBalanceClick;
    end;
    aLabelTimeCalcBalance:=TLabel.Create(FC.Form);
    with aLabelTimeCalcBalance do begin
      Top:=4;
      Left:=333;
      Width:=150;
      Name:='aLabelTimeCalcBalance';
      Font.Style:=[fsBold];
      Font.Size:=9;
      Height:=20;
      if (FC.Name='ClientReportTotalC') or (FC.Name='CheckSaldoC') then
        Caption:=ModuleBase.ConfigDeclarEndProcessCB.AsString
      else Caption:='000000 : 00.00.00 || 00:00:00';
      Parent:=PageControl1TabPanel;
    end;
    if (FC.Name='ClientReport2008C') or (FC.Name='ClientReportC')
    or (FC.Name='ClientReportTotalC') then with FC do begin
      BtnActParam:=TBitBtn.Create(Form);
      with BtnActParam do begin
        Top:=0;
        Height:=22;
        Name:='BtnActParam';
        Font.Style:=[fsBold];
        Font.Name:='Arial Narrow';
        if (FC.Name='ClientReportTotalC') then begin
          Left:=442;
          Width:=168;
          Caption:='Суммовой баланс по клиентам';
          Hint:='Суммовой баланс по клиентам'
        end else begin
          Left:=510;
          Width:=90;
          Caption:='Акт сверки';
          Hint:='Акт сверки по клиенту';
        end;
        ShowHint:=true;
        Parent:=PageControl1TabPanel;
        OnClick:=ClientReportClick;
      end;
      if (FC.Name='ClientReportC') or (FC.Name='ClientReportTotalC') then begin
         // Шрифт для Grida - Arial Narrow
        { Поэкспериментируем позже
        Grid.Font.Name:='ArialNarrow';
        Grid.TotalFont.Name:='ArialNarrow';
        Grid.TitleFont.Name:='ArialNarrow';
        }
        {Grid.TotalFont.Size:=7;}
        // Кнопку для вкл/выкл полей BY
        BtnBy:=TBitBtn.Create(Form);
        with BtnBy do begin
          Top:=0;
          {if FC.Name='ClientReportC' then Left:=620
          else} Left:=720;
          Width:=40;
          Height:=22;
          Name:='BtnBy';
          Font.Style:=[fsBold];
          Caption:='BY+';
          ShowHint:=true;
          VisibleBy:=false;
          Hint:='Вкл/выкл полей BY';
          Parent:=PageControl1TabPanel;
          OnClick:=ByClick;
        end;
        if FC.Name='ClientReportC' then begin
          // Кнопку для вкл/выкл всей инфо или только итогов
          BtnPlus:=TBitBtn.Create(Form);
          with BtnPlus do begin
            Top:=0;
            Left:=780;
            Width:=20;
            Height:=22;
            Name:='BtnPlus';
            Font.Style:=[fsBold];
            Font.Size:=15;
            Caption:='-';
            ShowHint:=true;
            Hint:='Вкл/выкл. фильтра на итоги';
            Parent:=PageControl1TabPanel;
            OnClick:=PlusClick;
          end;
        end;
        // Кнопка вызова контроля расчета по клиентам
        BtnCheckSaldo:=TBitBtn.Create(Form);
        with BtnCheckSaldo do begin
          Top:=0;
          Left:=613;
          Width:=105;
          Height:=22;
          Name:='BtnCheckSaldo';
          Font.Style:=[fsBold];
          Font.Name:='Arial Narrow';
          Caption:='Контроль расчетов';
          ShowHint:=true;
          Hint:='Контроль расчета по клиентам';
          Parent:=PageControl1TabPanel;
          OnClick:=CheckSaldoClick;
        end;
        if FC.Name='ClientReportC' then begin
          // Кнопка переключения между математическим видом и бухгалтерским
          BtnChangeView:=TBitBtn.Create(Form);
          with BtnChangeView do begin
            Top:=0;
            Left:=813;
            Width:=105;
            Height:=22;
            Name:='BtnChangeView';
            Font.Style:=[fsBold];
            Font.Name:='Arial Narrow';
            Caption:='Бухгалтерский вид';
            ShowHint:=true;
            Hint:='Математический вид - Бухгалтерский вид';
            Parent:=PageControl1TabPanel;
            OnClick:=ChangeViewClick;
          end;
        end;  
      end;
      if FC.Name='ClientReport2008C' then begin
        Grid.OnSetFont:=SetGridClientReport2008Font;
        Grid.OnSetColor:=SetGridClientReport2008Color;
      end
      else
        if FC.Name='ClientReportC' then begin
          Grid.Color:=$00F3FCF4;//$00E1F7E2;
          Grid.OnSetFont:=SetGridClientReportFont;
          Grid.OnSetColor:=SetGridClientReportColor;
        end
        else if FC.Name='ClientReportTotalC' then begin
          Grid.Color:=$00F3FCF4;//$00E1F7E2;
          Grid.OnSetFont:=SetGridClientReportTotalFont;
          Grid.OnSetColor:=SetGridClientReportTotalColor;
        end;
      Grid.OnDblClick:=GridDblClick;
      //Grid.ShowHint:=true;
      //Grid.Hint:='Двойной клик - переход к первичному документу';
    end;
    if FC.Name='ClientReportVC' then TBEForm(FC.Form).Grid.OnDblClick:=GridDblClick;
    if FC.Name='CheckSaldoC' then CreateReportForm(Sender)
  end;
end;

Procedure TModuleClientsAdd.InteractionAssetsCalculatedItemClick(Sender: TObject);
var lClient : variant;
    lCountry: smallint;
    Mes:String;
    lResult: variant;
    lLastCalcStr:string;
    lNameProc:string;
    lRepeatCount: byte;
    lFlagCalculated: boolean;
    lCalcNextPeriod: byte;
    lCurrencyKod: string[3];
    lCurrentFormControl: TDBFormControl;
    lCurrentDataSet: TDataSet;
    lStr10: string[10];
begin
  {
  ShowMessage('Процедура находится в стадии разработки');
  Exit;
  }
{
  if (UserName<>'LEV') and (UserName<>'FSGL') and (UserName<>'VERBICKIJ')
  and (UserName<>'LEO') and (UserName<>'SALECHIEF') and (UserName<>'SALE1')
  and (UserName<>'JURIST') and (UserName<>'NICK') then begin
    ShowMessage('Процедура не доступна пользователю '+UserName);
    Exit;
  end;
}
  lCalcNextPeriod:=ModuleBase.ConfigDeclarCalcNextPeriod.Value;
  case MessageDlg('Расчет оплаты за продукцию за '+Copy(ModuleBase.ConfigDeclarCurPeriod.AsString,4,5)+
     #13+'Будете работать с одной организацией ?',mtConfirmation,[mbYes,mbAll,mbCancel],0) of
(* ЕСЛИ ПЕРЕДЕЛАТЬ ЧЕРЕЗ MessageBox то кнопки будут подписаны по русски
  case MessageBox('Расчет оплаты за продукцию за '+Copy(ModuleBase.ConfigDeclarCurPeriod.AsString,4,5)+
     #13+'Будете работать с одной организацией ?','',) of
*)

    idYes:
      with ModuleOrgs do begin { работаем с одним клиентом }
        if not OrgLookUp.Active then OrgLookUp.Open;
        DlgClientF:=TDlgClientF.Create(nil);
        with DlgClientF do
        try
          ClientLookUp.KeyValue:=InClient; // Инициализируем значение по клиенту, чтобы юзер не устал нажимать кнопки
          Label1.Caption:='Выберите клиента для расчета';
          ShowModal;
          if (ModalResult in [idOk,idYes]) then begin
            {ClientExist:=true;}
            lClient:=ClientLookUp.KeyValue;
            lCountry:=OrgLookUpCountry.Value;
            if (lClient=null) {or not((lCountry=974) or (lCountry=643) or (lCountry=840))} then begin
              if lClient=null then Mes:='Не задан клиент для расчета';
              {else Mes:='Код страны не входит в обрабатываемое подмножество (974,643,840)';}
              ShowMessage(Mes);
              Exit;
            end;
            lLastCalcStr:=aLabelTimeCalcBalance.Caption;
          end else Exit;
        finally
          DlgClientF.Free;
        end;
        lRepeatCount:=0;
        lFlagCalculated:=false;
        if lCalcNextPeriod=0 then lNameProc:='InteractionAssetsCalculated'
        else lNameProc:='InteractionAssetsCalculated2';
        repeat
          Inc(lRepeatCount);
          case lRepeatCount of
            1: lCurrencyKod:='974';
            2: lCurrencyKod:='643';
            3: lCurrencyKod:='840';
            4: lCurrencyKod:='978';
          end;
          if (lRepeatCount=1) or (lCountry<>30) then with ModuleCommon do begin
            if not CurrencyLookup.Active then CurrencyLookup.Open;
            CurrencyLookup.Locate('Kod',StrToInt(lCurrencyKod),[]);
            lResult:=
              GetFromSQLText(ClientReportDeclar.DataBaseName,
                'Select '+lNameProc+'('+IntToStr(lClient)+','''+CurPeriod+''','+lCurrencyKod+',1)',false);
            if lResult=1 then
              Mes:='Новых документов со времени последнего расчета '+lLastCalcStr+#13+
              'по клиенту '+OrgLookUpKod.AsString+' : '+OrgLookUpName.AsString+#13+
              'по валюте '+lCurrencyKod+': '+CurrencyLookupName.AsString+#13+
              'за период '+CurPeriod+#13+' в информационную систему не поступало'
            else begin
              lFlagCalculated:=true;
              Mes:='Произведен расчет по клиенту '+OrgLookUpKod.AsString+' : '+OrgLookUpName.AsString+#13+
              'по валюте '+lCurrencyKod+': '+CurrencyLookupName.AsString+#13+
              'за период '+CurPeriod;
            end;
            ShowMessage(Mes);
          end;
        until lRepeatCount=4;
        if (Sender.ClassName='TBitBtn') and lFlagCalculated then begin
          lCurrentFormControl:=TDBFormControl(TBEForm(TBitBtn(Sender).Owner).FormControl);
          lCurrentDataSet:=lCurrentFormControl.CurrentSource.DataSet;
          if lCurrentDataSet<>ClientReportDeclar then
            lClient:=lCurrentDataSet.FindField('Client').Value
          else lClient:=null;
          with lCurrentDataSet do begin
            DisableControls;
            if lCurrentFormControl.Name='ClientReport2008VC' then with ClientReport2008VC do begin
              { Баланс по всем клиентам сразу }
              if CurrentInquiryItem.Index=2 then begin
                { Запоминаем клиента, на котором стоит курсор }
                lClient:=ClientReport2008VDeclarClient.Value;
              end;
              case CurrentInquiryItem.Index of
                0,1:
                  begin
                    Refresh;
                    Last;
                  end;
                2:
                  begin
                    {Close;
                    Open;}
                    Refresh;
                    Locate('Client',lClient,[]);
                  end;
              end;
            end;
            if lCurrentFormControl.Name='ClientReportTotal2008VC' then with ClientReportTotal2008VC do begin
              Refresh;
              Locate('Client',lClient,[]);
            end;
(* Старый расчет закомментарил
            { Повторяем пересчет по клиенту  }
            if lCurrentFormControl.Name='ClientReportC' then begin
              ExecSQLText(ClientReportDeclar.DataBaseName,
              'call STA.GetClientReport('''+InDateBeg+''','''+InDateEnd+
              ''','+IntToStr(InClient)+','+VarToStr_(InCurrency)+')',false);
              if ClientReportDeclar.Active then begin
                //ClientReportDeclar.Refresh;
                RefreshDataOnForm(nil,true);
                TBEForm(TBitBtn(Sender).Owner).Grid.FormatColumns(true);
              end;
            end;
*)
            EnableControls;
            BtnTimeCalcBalance.Click;
          end;
        end;
{
        lResult:=
        GetFromSQLText(ClientReportVDeclar.DataBaseName,
          'Select InvoicePayCalculated('+IntToStr(lClient)+','''+CurPeriod+''',974,1)',false);
        if lResult=1 then Mes:='Новых документов со времени последнего расчета '+lLastCalcStr+#13+
          'по клиенту '+OrgLookUpKod.AsString+' : '+OrgLookUpName.AsString+#13+
          'по валюте 974 : Белорусский рубль'+#13+'в информационную систему не поступало'
        else Mes:='Произведен расчет по клиенту '+OrgLookUpKod.AsString+' : '+OrgLookUpName.AsString+#13+
          'по валюте 974 : Белорусский рубль';
        ShowMessage(Mes);
        if lCountry<>30 then begin
        GetFromSQLText(ClientReportVDeclar.DataBaseName,
            'Select InvoicePayCalculated('+IntToStr(lClient)+','''+CurPeriod+''',643,1)',false);
          GetFromSQLText(ClientReportVDeclar.DataBaseName,
            'Select InvoicePayCalculated('+IntToStr(lClient)+','''+CurPeriod+''',840,1)',false);
        end;
}
      end;
    idNo+1: {mrAll=mrNo+1: работаем со всеми клиентами }
{      if (UserName='LEV') or (UserName='ANDY') or (UserName='ECON') or (UserName='VERBICKIJ') or (UserName='FSGL')
        or (UserName='FIN') or (UserName='COMDIV') or (UserName='FSGT') or (UserName='OLGA') or (UserName='SALECHIEF')
        or (UserName='MIH') or (UserName='DIL') or (UserName='TAMARA') or (UserName='LEO') then begin}
        try
          if lCalcNextPeriod=0 then begin
            lNameProc:='STA.InteractionAssetsCalculatedAll';
            lStr10:=''',1)'
          end else begin
            lNameProc:='STA.InteractionassetsCalculatedAll2';
            lStr10:=''',1,2)'
          end;
          OpenDutyQuery(ClientReport2008VDeclar.DataBaseName,'Call '+lNameProc+'('''+CurPeriod+''+lStr10,true);
          if DQuery.Active then begin { Обработка полученных результатов, если они, конечно, получены }
            Beep;
            ShowMessage('РЕЗУЛЬТАТЫ РАБОТЫ ПРОЦЕДУРЫ РАСЧЕТА БАЛАНСА ПО КЛИЕНТАМ'+#13+#13+
              'Период расчета '+#9#9#9+':'+CurPeriod+#13+
              'Начало расчета '+#9#9#9+':'+DQuery.Fields[1].AsString+#13+
              'Конец расчета  '+#9#9#9+':'+DQuery.Fields[2].AsString+#13+
              'Время расчета  '+#9#9#9+':'+DQuery.Fields[3].AsString+#13+
              'Всего обработано клиентов '+#9#9+':'+DQuery.Fields[4].AsString+#13+
              'Всего расчитано клиентов  '+#9#9+':'+DQuery.Fields[5].AsString+#13+
              'Не поступало новых документов по '+#9+':'+DQuery.Fields[6].AsString+' клиентам')
          end;
        finally
          if DQuery.Active then DQuery.Close;
        end;
      {end else ShowMessage('Процедура с этим параметром еще тестируется')}
    else Abort;
  end;
end;

Procedure TModuleClientsAdd.ClientReportClick(Sender: TObject);
var aReport: byte;
    aCaption: string;
begin
  {
  if not ModuleBase.IsProgrammers and (UserName<>'FSGL')
  and (UserName<>'FSGT') and (UserName<>'SALECHIEF') then begin
    MessageDlg('Данная процедура Вам не доступна',mtInformation,[mbOk],0);
    Exit;
  end;
  }
  // В первую очередь открываем список клиентов
  if ModuleOrgs.OrgLookUp.Active=false then ModuleOrgs.OrgLookUp.Open;
  if (TBitBtn(Sender).Caption='Акт сверки') or (TBitBtn(Sender).Caption='Суммовой баланс по клиентам') then begin
    aReport:=rpActRevise2008;
    if ModuleCommon.CurrencyLookUp.Active=false then ModuleCommon.CurrencyLookUp.Open;
    // Инициализация дополнительных списков для нового акта сверки или суммового баланса
    if (TBEForm(TBitBtn(Sender).Owner).FormControl.Name='ClientReportC') or (TBEForm(TBitBtn(Sender).Owner).FormControl.Name='ClientReportTotalC') then begin
      aReport:=rpActRevise;
      if ModuleCommon.AccountLookup.Active=false then ModuleCommon.AccountLookup.Open;       // Бухгалтерские счета
      if ModuleContract.ContractLookup.Active=false then ModuleContract.ContractLookup.Open; // Контракты
    end;
    if (TBEForm(TBitBtn(Sender).Owner).FormControl.Name='ClientReportTotalC') then aReport:=rpSumBalance;
  end;
  if TBitBtn(Sender).Caption='Движение тары' then begin
    aReport:=rpTareMoveReport;
    if ModuleBase.TareLookUp.Active=false then ModuleBase.TareLookUp.Open;
  end;
  if TBitBtn(Sender).Caption='Оборот тары' then begin
    aReport:=rpTareMoveReportTotal;
    if ModuleBase.TareLookUp.Active=false then ModuleBase.TareLookUp.Open;
  end;
  if TBitBtn(Sender).Caption='Расчет штрафов' then begin
    aReport:=rpTareMovePenalty;
    if ModuleBase.TareLookUp.Active=false then ModuleBase.TareLookUp.Open;
  end;

  DialAct:=TDialAct.Create(Application);
  with DialAct do try
    // Инициализация LookUp'ов
    LabelDateBeg.Visible:=true;
    EditDateBeg.Visible:=true;
    EditDateBeg.Text:=InDateBeg;
    EditDateEnd.Text:=InDateEnd;
    if aReport in [rpActRevise2008,rpActRevise,rpSumBalance] then begin
      LookupClient.Visible:=true;
      LabelClient.Visible:=true;
      LookupCurrency.Visible:=true;
      LabelCurrency.Visible:=true;
      if aReport=rpSumBalance then begin
        LookupClient.KeyValue:=InClientAll;
        LookupCurrency.KeyValue:=InCurrencyAll;
        LookupAccount.KeyValue:=InAccountAll;
      end else begin
        LookupClient.KeyValue:=InClient;
        LookupCurrency.KeyValue:=InCurrency;
        LookupAccount.KeyValue:=InAccount;
      end;
      if aReport in [rpActRevise,rpSumBalance] then begin
        LookupAccount.Top:=LookupAccount.Top-24;
        LookupAccount.Visible:=true;
        LabelAccount.Top:=LabelAccount.Top-24;
        LabelAccount.Visible:=true;
        LookupContract.Top:=LookupContract.Top-24;
        LookupContract.Visible:=true;
        LabelContract.Top:=LabelContract.Top-24;
        LabelContract.Visible:=true;
        if (aReport=rpActRevise) and (UserName='LEV') then begin
          EditAddParam.Top:=LookupContract.Top;
          EditAddParam.Visible:=true;
        end;
        Bevel1.Height:=Bevel1.Height-24;
        BitBtn1.Top:=BitBtn1.Top-24;
        BitBtn2.Top:=BitBtn2.Top-24;
        Height:=Height-24;
        LookupContract.KeyValue:=InContract;
      end;
    end;

    if aReport in [rpTareMoveReport, rpTareMoveReportTotal, rpTareMovePenalty] then begin
      // Тара нужна по всем отчетам
      LookupTare.Visible:=true;
      LabelTare.Visible:=true;
      LookupTare.KeyValue:=InTare;
      // Клиент нужен только по двум отчетам
      if aReport in [rpTareMoveReport, rpTareMovePenalty] then begin
        LookupClient.Visible:=true;
        LabelClient.Visible:=true;
        LookupClient.KeyValue:=InClient;
      end;
      // Кол-во дней в пути нужно только для расчета штрафов
      if aReport=rpTareMovePenalty then begin
        LabelDaysOnWay.Visible:=true;
        EditDaysOnWay.Visible:=true;
        EditDaysOnWay.Text:=InDaysOnWay;
        LabelDateBeg.Visible:=false;
        EditDateBeg.Visible:=false;
        EditDateEnd.Date:=Date;
      end;
    end;

    TBEForm(TBitBtn(Sender).Owner).Caption:=TBitBtn(Sender).Caption;
    if IsClientReportTotalSend or (DialAct.ShowModal in [idOk,idYes]) then begin
      // Запоминаем, что запомнил пользователь
      InDateBeg:=EditDateBeg.Text;
      InDateEnd:=EditDateEnd.Text;
      if aReport=rpActRevise2008 then begin
        InClient:=LookupClient.KeyValue;
        InCurrency:=LookupCurrency.KeyValue;
        ExecSQLText(ClientReport2008Declar.DataBaseName,
         'call STA.GetClientReport2008('''+EditDateBeg.Text+''','''+EditDateEnd.Text+
           ''','+VarToStr_(InClient)+','+VarToStr_(InCurrency)+')',false);
      end;
      if aReport in [rpActRevise,rpSumBalance] then begin
        InContract:=LookupContract.KeyValue;
      end;
      if aReport=rpActRevise then begin
        InClient:=LookupClient.KeyValue;
        InCurrency:=LookupCurrency.KeyValue;
        InAccount:=LookupAccount.KeyValue;
        // Настройка видимости некоторых полей в зависимости от выбранных параметров
        ClientReportDeclarContract.Visible:=(InCurrency<>974);
        ClientReportDeclarCurrency.Visible:=(InCurrency=null);
        ClientReportDeclarAccount.Visible:=(InAccount=null);
        {ClientReportDeclarContract.Visible:=(InContract=null);}
        ClientReportDeclarProdOut.Visible:=(InAccount<>'62.00');
        ClientReportDeclarProdIn.Visible:=(InAccount<>'62.00');
        ClientReportDeclarProdInName.Visible:=(InAccount<>'62.00');
        ClientReportDeclarSummaCloseOut.Visible:=(InAccount<>'62.00');
        ClientReportDeclarSummaCloseIn.Visible:=(InAccount<>'62.00');
        ClientReportDeclarSummaUnCloseIn.Visible:=(InAccount<>'62.00');

        ExecSQLText(ClientReportDeclar.DataBaseName,'call STA.GetClientReport('''+EditDateBeg.Text+''','''+EditDateEnd.Text+
           ''','+VarToStr_(InClient)+','
           +VarToStr_(InCurrency)+','
           +VarToStr_(InAccount)+','
           +VarToStr_(InContract)+','+EditAddParam.Text+
           ')',false);
      end;
      if aReport=rpSumBalance then begin
        InClientAll:=LookupClient.KeyValue;
        InCurrencyAll:=LookupCurrency.KeyValue;
        InAccountAll:=LookupAccount.KeyValue;
        // Настройка видимости некоторых полей в зависимости от выбранных параметров
        // Поля типа IsEndPeriod вроде бы и не нужны пользователю, тем более, что сделан контроль за
        // расчетом (CheckSaldo), где пользователь может увидеть нерасчитанных клиентов и там же расчитать их
        // Поэтому немного погодя закомментаренные строки ниже можно будет удалить Lev 28.10.2008
        ClientReportTotalDeclarContract.Visible:=(InCurrencyAll<>Null) and (InCurrencyAll<>974) and (InAccountAll='62.00');
        {ClientReportTotalDeclarIsEndPeriodContract.Visible:=(InCurrencyAll<>Null) and (InCurrencyAll<>974) and (InAccountAll='62.00');}
        ClientReportTotalDeclarBalanceContract.Visible:=(InCurrencyAll<>Null) and (InCurrencyAll<>974) and (InAccountAll='62.00');

        ClientReportTotalDeclarCurrency.Visible:=(InCurrencyAll=null);
        ClientReportTotalDeclarCurrencyName.Visible:=(InCurrencyAll=null);

        // Поля, связ. с бухгалтерским счетом
        ClientReportTotalDeclarAccount.Visible:=(InAccountAll=null);
        ClientReportTotalDeclarAccountName.Visible:=(InAccountAll=null);

        {ClientReportTotalDeclarIsEndPeriod.Visible:=(InAccountAll=null);}
        ClientReportTotalDeclarBalance.Visible:=(InAccountAll=null);

        {ClientReportTotalDeclarIsEndPeriodAccount.Visible:=(InAccountAll<>null);}
        ClientReportTotalDeclarBalanceAccount.Visible:=(InAccountAll<>null);

        ExecSQLText(ClientReportTotalDeclar.DataBaseName,'call STA.GetClientReportTotal('''+EditDateBeg.Text+''','''+EditDateEnd.Text+
           ''','+VarToStr_(InClientAll)+','
           +VarToStr_(InCurrencyAll)+','
           +VarToStr_(InAccountAll)+','
           +VarToStr_(InContract)+
           ')',false);
      end;
      if aReport=rpTareMoveReport then begin
        InClient:=LookupClient.KeyValue;
        InTare:=LookupTare.KeyValue;
        ExecSQLText(ClientReport2008Declar.DataBaseName,
          'call STA.GetTareMoveReport('''+EditDateBeg.Text+''','''+EditDateEnd.Text+
             ''','+IntToStr(LookUpClient.KeyValue)+','+IntToStr(LookUpTare.KeyValue)+')',false);
      end;
      if aReport=rpTareMoveReportTotal then begin
        InTare:=LookupTare.KeyValue;
        ExecSQLText(ClientReport2008Declar.DataBaseName,
          'call STA.GetTareMoveReportTotal('''+EditDateBeg.Text+''','''+EditDateEnd.Text+
             ''','+IntToStr(LookUpTare.KeyValue)+')',false);
      end;
      if aReport=rpTareMovePenalty then begin
        InClient:=LookupClient.KeyValue;
        InTare:=LookupTare.KeyValue;
        InDaysOnWay:=EditDaysOnWay.Text;
        ExecSQLText(ClientReport2008Declar.DataBaseName,
          'call STA.GetTareMovePenalty('''+EditDateEnd.Text+''','+IntToStr(LookUpTare.KeyValue)+','+
             EditDaysOnWay.Text+','+IntToStr(LookUpClient.KeyValue)+')',false);
      end;

      // Формирование заголовка отчетов

      // Добавляем в заголовок значения из диалога. И вкл/выкл. поля в отчете
      aCaption:='';

      if (aReport in [rpActRevise,rpActRevise2008,rpTareMovePenalty,rpTareMoveReport]) then begin
        if InClient<>null then aCaption:=aCaption+' по клиенту: '+LookUpClient.Text+' | '+ModuleOrgs.OrgLookupName.AsString;
      end;
      if (aReport in [rpActRevise,rpActRevise2008]) then begin
        if InCurrency<>null then aCaption:=aCaption+' , по валюте: '+VarToStr(InCurrency);
      end;
      if (aReport=rpActRevise) then begin // В новом акте сверки появился СЧЕТ(Account) и КОНТРАКТ(Contract)
        if InAccount<>null  then aCaption:=aCaption+' , по счету: '+VarToStr(InAccount);
        if InContract<>null then aCaption:=aCaption+' , по контракту: '+VarToStr(InContract);
      end;

      if (aReport=rpSumBalance) then begin
        if InClientAll<>null then aCaption:=aCaption+' по клиенту: '+LookUpClient.Text+' | '+ModuleOrgs.OrgLookupName.AsString;
        if InCurrencyAll<>null then aCaption:=aCaption+' , по валюте: '+VarToStr(InCurrencyAll);
        if InAccountAll<>null  then aCaption:=aCaption+' , по счету: '+VarToStr(InAccountAll);
        if InContract<>null then aCaption:=aCaption+' , по контракту: '+VarToStr(InContract);
      end;

      if aReport in[rpActRevise2008,rpTareMoveReport,rpTareMovePenalty,rpActRevise,rpSumBalance] then
        TBEForm(TBitBtn(Sender).Owner).Caption:=TBitBtn(Sender).Caption+aCaption;

      if aReport in [rpTareMoveReport, rpTareMoveReportTotal] then
        TBEForm(TBitBtn(Sender).Owner).Caption:=
          TBEForm(TBitBtn(Sender).Owner).Caption+
          ' | '+LookupTare.ListSource.DataSet.FieldByName('Name').AsString+
          ' | '+EditDateBeg.Text+'-'+EditDateEnd.Text;

      if aReport in [rpTareMovePenalty] then
        TBEForm(TBitBtn(Sender).Owner).Caption:=
          TBEForm(TBitBtn(Sender).Owner).Caption+
          ' | на '+EditDateEnd.Text+' | дней в пути: '+InDaysOnWay+
          ' | '+LookupTare.ListSource.DataSet.FieldByName('Name').AsString;

      RefreshDataOnForm(nil,true);
      TBEForm(TBitBtn(Sender).Owner).Grid.FormatColumns(true);
    end;
  finally
    DialAct.Free;
    IsClientReportTotalSend:=false;
  end;
end;

procedure TModuleClientsAdd.SetGridClientReport2008Font(Sender: TObject; Field: TField; Font: TFont);
begin
  if (Copy(ClientReport2008DeclarProdName.AsString,1,2)='НА') then begin
    Font.Style:=[fsBold];
    Font.Color:=$00A00000;
  end;
end;

procedure TModuleClientsAdd.SetGridClientReport2008Color(Sender: TObject; Field: TField; var Color: TColor);
begin
  if (Copy(ClientReport2008DeclarProdName.AsString,1,2)='НА') and
  (Field.FieldName='SummaUnClose') then
    Color:=$00CCEAAC;//$00CCEACC;//$00C6FDD8;//$00C6CDFD;//$00A0CD8F;//$00C6DDA4
end;

procedure TModuleClientsAdd.SetGridClientReportFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if (Copy(ClientReportDeclarProdOutName.AsString,1,4)='ИТОГ') then begin
    Font.Style:=[fsBold];
    if (Pos('SummaUnCloseOut',Field.FieldName)=0) and (Pos('Debet',Field.FieldName)=0) and (Pos('Kredit',Field.FieldName)=0) then
      Font.Color:=$00A00000
    else Font.Color:=$00400080 //clPurple
  end;
end;

procedure TModuleClientsAdd.SetGridClientReportColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  if (Copy(ClientReportDeclarProdOutName.AsString,1,4)='ИТОГ') then
    if (Pos('SummaUnCloseOut',Field.FieldName)>0) or (Pos('Debet',Field.FieldName)>0) or (Pos('Kredit',Field.FieldName)>0)  then
      Color:=$00E2F5F5 //$00E1F4F5  //$00EEF3E0
    else Color:=$00EAF6E3; //$00EEFADC;//$00DEF8DC;
end;

procedure TModuleClientsAdd.SetGridClientReportTotalFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if (Pos('Balance',Field.FieldName)=1) then begin
    Font.Style:=[fsBold];
    Font.Color:=$00400080 //clPurple
  end;
end;

procedure TModuleClientsAdd.SetGridClientReportTotalColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  if (Pos('Balance',Field.FieldName)=1) then
    Color:=$00E2F5F5 //$00E1F4F5  //$00EEF3E0
  else Color:=$00EAF6E3; //$00EEFADC;//$00DEF8DC;
end;

procedure TModuleClientsAdd.SomeCreateForm(Sender: TObject);
var aDataSet: TDataSet;
begin
  aDataSet:=TDBFormControl(Sender).DefSource.DataSet;
  with TBEForm(TDBFormControl(Sender).Form) do begin
     Grid.TitleRows:=3;
     Grid.Color:=$00F3FCF4;
     if TDBFormControl(Sender).Name='ExportToExcelHistoryC' then begin
       Grid.Font.Name:='ArialNarrow';
       Grid.Font.Size:=9;
       Grid.TitleFont.Name:='ArialNarrow';
       Grid.TitleFont.Size:=8;
       Grid.TotalFont.Name:='ArialNarrow';
     end;
  end;
  if aDataSet.Name='ProdRequestForShopDeclar' then ProdRequestForShopDeclar.Last;
end;

procedure TModuleClientsAdd.Summary16_2008CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    CurrentReportPeriod:=TXEDBDateEdit.Create(Form);
    with CurrentReportPeriod do begin
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='CurrentReportPeriod';
      DataField:='ReportPeriod';
      DataSource:=ModuleBase.Config;
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      TabStop:=true;
      TabOrder:=0;
      OnExit:=CurrentReportPeriodExit;
    end;
    BtnCalcSummary16_2008:=TBitBtn.Create(Form);
    with BtnCalcSummary16_2008 do begin
      Top:=0;
      Left:=210;
      Width:=100;
      Height:=22;
      Name:='BtnCalcPeriod';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      Parent:=PageControl1TabPanel;
      OnClick:=CalcSummary16_2008Click;
      TabStop:=true;
      TabOrder:=1;
    end;
  end;
end;

Procedure TModuleClientsAdd.CurrentReportPeriodExit(Sender: TObject);
begin
  ModuleBase.ConfigDeclar.Post;
end;

procedure TModuleClientsAdd.CalcSummary16_2008Click(Sender: TObject);
begin
  ExecSQLText(Summary16_2008Declar.DataBaseName,'call STA.GetSummary16_2008()',false);
  Summary16_2008Declar.Refresh;
  Summary16_2008C.Caption:='Сводная ведомость по отгрузке и оплате продукции и материалов за '+
    FormatDateTime('mmmm yyyy года',ModuleBase.ConfigDeclarReportPeriod.AsDateTime);
  with TBEForm(Summary16_2008C.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TModuleClientsAdd.GridDblClick(Sender: TObject);
(*
Список полей, по клику на которые
['SNumber','DateInvoice','NumInvoice','ProdName','Summa','SummaClose','SummaUnClose'];
['InvoiceID','InvoiceProdID','NumInvoice','DateInvoice','Currency','Summa','SummaClose','Prod','ProdName'];
*)
var FName: string;
    DS: TDataSource;
    aTableID: integer;
begin
  inherited;
  DS:=TXEDbGrid(Sender).DataSource; // Источник данных
  if DS.Name='ClientReport2008' then
    with TBEForm(TDBFormControl(ClientReport2008C).Form).Grid do begin
      FName:=SelectedField.FieldName;
      { Активизируем соответствующую накладную }
      if (FName='SNumber') or (FName='DateInvoice') or (FName='NumInvoice') or (FName='ProdName') or
      (FName='Summa') or (FName='SummaClose') or (FName='SummaUnClose') then with ModuleInvoice do begin
        if not Assigned(InvoiceC.Form) or not InvoiceC.Form.Active then begin
          InvoiceC.Execute;
          {ClientReportC.Form.SetFocus;}
        end;
        if not InvoiceDeclar.Locate('Kod;SDate',
          VarArrayOf([ClientReport2008DeclarNumInvoice.Value,ClientReport2008DeclarDateInvoice.Value]),[]) then
           InvoiceDeclar.Locate('Kod',ClientReport2008DeclarNumInvoice.Value,[]);
        InvoiceC.Execute
      end else with ModulePays do begin
        if not Assigned(PayDocC.Form) or not PayDocC.Form.Active then begin
          PayDocC.Execute;
          {ClientReportC.Form.SetFocus;}
        end;
        if PayDocS.Locate('AutoInc',ClientReport2008DeclarPayDocID.Value,[]) then PayDocC.Execute;
      end;
    end;

  if (DS.Name='ClientReport') and (Copy(ClientReportDeclarProdOutName.AsString,1,5)<>'ИТОГО') then
    with TBEForm(TDBFormControl(ClientReportC).Form).Grid, ClientReportDeclar do begin
      FName:=SelectedField.FieldName;
      if Pos('Out',FName)>0 then begin
        aTableID:=ClientReportDeclarTableIDOut.AsInteger;
        FName:='Out';
      end;
      if Pos('In',FName)>0 then begin
        aTableID:=ClientReportDeclarTableIDIn.AsInteger;
        FName:='In';
      end;
      if not FieldByName('ID'+FName).IsNull then
        case aTableID of
          _Transact:
            with ModulePays do begin
              if not Assigned(PayDocC.Form) or not PayDocC.Form.Active then begin
                PayDocC.Execute;
              end;
              if PayDocS.Locate('AutoInc',FieldByName('ID'+FName).Value,[]) then PayDocC.Execute;
            end;
          _InvoiceProd:
            with ModuleInvoice do begin
              if not Assigned(InvoiceC.Form) or not InvoiceC.Form.Active then InvoiceC.Execute;
              if InvoiceDeclar.Locate('ID',ClientReportDeclarIDOut.Value,[]) then InvoiceC.Execute
            end;
          _MInvoiceT:
            with MdMat do begin
              if not MInvoiceHDeclar.Active then MInvoiceHDeclar.Open;
              if MInvoiceHDeclar.Locate('ID;InvoiceNum',VarArrayOf([ClientReportDeclarIDIn.Value,ClientReportDeclarNumDocIn.AsVariant]),[]) then MInvoiceC.Execute
            end;
          _MFaktura:
            with MdMat do begin
              if not MFakturaDeclar.Active then MFakturaDeclar.Open;
              if MFakturaDeclar.Locate('ID;NumDoc',VarArrayOf([FieldByName('ID'+FName).Value,FieldByName('NumDoc'+FName).Value]),[]) then MFakturaC.Execute;
            end;
        end;
(*
      if (ClientReportDeclarAccount.Value='62.00') then begin
        { Активизируем соответствующую накладную }
        if Pos('Out',FName)>0 then with ModuleInvoice do begin
          if not Assigned(InvoiceC.Form) or not InvoiceC.Form.Active then begin
            InvoiceC.Execute;
            {ClientReportC.Form.SetFocus;}
          end;
          if InvoiceDeclar.Locate('ID',ClientReportDeclarIDOut.Value,[]) then InvoiceC.Execute
        end;
        if Pos('In',FName)>0 then with ModulePays do begin
          if not Assigned(PayDocC.Form) or not PayDocC.Form.Active then begin
            PayDocC.Execute;
          end;
          if PayDocS.Locate('AutoInc',ClientReportDeclarIDIn.Value,[]) then PayDocC.Execute;
        end;
      end;
      if (ClientReportDeclarAccount.Value='60.00') or (ClientReportDeclarAccount.Value='76.03') then begin
        { Активизируем соответствующую накладную/счет-фактуру }
        if Pos('Out',FName)>0 then with ModulePays do begin
          if not Assigned(PayDocC.Form) or not PayDocC.Form.Active then begin
            PayDocC.Execute;
          end;
          if PayDocS.Locate('AutoInc',ClientReportDeclarIDOut.Value,[]) then PayDocC.Execute
        end;
        if Pos('In',FName)>0 then with MdMat do begin
          if not MInvoiceHDeclar.Active then MInvoiceHDeclar.Open;
          if MInvoiceHDeclar.Locate('ID;InvoiceNum',VarArrayOf([ClientReportDeclarIDIn.Value,ClientReportDeclarNumDocIn.Value]),[]) then MInvoiceC.Execute
          else begin
            {MInvoiceC.DeactivateForm;}
            ClientReportC.Form.SetFocus;
            if not MFakturaDeclar.Active then MFakturaDeclar.Open;
            if MFakturaDeclar.Locate('ID;NumDoc',VarArrayOf([ClientReportDeclarIDIn.Value,ClientReportDeclarNumDocIn.Value]),[]) then MFakturaC.Execute;
          end;
        end;
      end;
*)
    end;

  if DS.Name='ClientReport2008V' then
    with TBEForm(TDBFormControl(ClientReport2008VC).Form).Grid do begin
      FName:=SelectedField.FieldName;
      { Активизируем соответствующую накладную }
      if (FName='InvoiceID') or (FName='InvoiceProdID') or (FName='NumInvoice') or (FName='DateInvoice') or
      (FName='Currency') or (FName='Summa') or (FName='SummaClose') or (FName='Prod') or (FName='ProdName')
      then with ModuleInvoice do begin
        if not Assigned(InvoiceC.Form) then begin
          InvoiceC.Execute;
          {ClientReportC.Form.SetFocus;}
        end;
        if InvoiceDeclar.Locate('ID',DS.DataSet.FieldByName('InvoiceID').Value,[]) then
          InvoiceC.Execute;
      end else
        if (FName='SummaDoc') or (FName='SummaDocActive') or (FName='DateComing')
        or (FName='NumDoc') or (FName='PayDocID') or (FName='TransactID') then with ModulePays do begin
          if not Assigned(PayDocC.Form) then begin
            PayDocC.Execute;
            {ClientReportC.Form.SetFocus;}
          end;
          if PayDocS.Locate('AutoInc',DS.DataSet.FieldByName('PayDocID').Value,[]) then
            PayDocC.Execute;
      end;
    end;
  if DS.Name='TareMovePenalty' then
    with TBEForm(TDBFormControl(TareMovePenaltyC).Form).Grid do begin
      FName:=SelectedField.FieldName;
      { Активизируем соответствующую накладную }
      if (FName='NumDocOut') or (FName='DateOut') or (FName='NumDocOut') or (FName='NumDoc1Out')
      then with ModuleInvoice do begin
        if not Assigned(InvoiceC.Form) then begin
          InvoiceC.Execute;
          {ClientReportC.Form.SetFocus;}
        end;
        if InvoiceDeclar.Locate(
          'Kod;sDate',VarArrayOf([TareMovePenaltyDeclarNumDocOut.Value,TareMovePenaltyDeclarDateOut.Value]),[]) or
           InvoiceDeclar.Locate(
          'Kod;sDate',VarArrayOf([TareMovePenaltyDeclarNumDoc1Out.Value,TareMovePenaltyDeclarDateOut.Value]),[]) then
          InvoiceC.Execute;
      end;
      { Активизируем соответствующий контракт }
      if (FName='Contract') then with ModuleContract do begin
        if not Assigned(ContractC.Form) then begin
          ContractC.Execute;
        end;
        if ContractDeclar.Locate('Kod',TareMovePenaltyDeclarContract.Value,[]) then
          ContractC.Execute;
      end;
    end;
  if DS.Name='TareMoveReport' then
    with TBEForm(TDBFormControl(TareMoveReportC).Form).Grid do begin
      if (TareMoveReportDeclarOperation.Value=2) and (TareMoveReportDeclarsDate.Value>=StrToDate('01.01.05')) then
      with ModuleInvoice do begin
        if not Assigned(InvoiceC.Form) then begin
          InvoiceC.Execute;
          {ClientReportC.Form.SetFocus;}
        end;
        if InvoiceDeclar.Locate(
          'Kod;sDate',VarArrayOf([TareMoveReportDeclarNumDoc.Value,TareMoveReportDeclarsDate.Value]),[]) or
           InvoiceDeclar.Locate(
          'Kod;sDate',VarArrayOf([TareMoveReportDeclarNumDoc1.Value,TareMoveReportDeclarsDate.Value]),[]) then
          InvoiceC.Execute;
      end;
      if (TareMoveReportDeclarOperation.Value=17) or
      ((TareMoveReportDeclarOperation.Value=2) and (TareMoveReportDeclarsDate.Value<StrToDate('01.01.05')))
       then begin
        if not Assigned(TareMoveC.Form) then TareMoveC.Execute;
        if TareMoveDeclar.Locate('Client;Tare;sDate;NumDoc1',VarArrayOf([
        TareMoveReportDeclarClient.Value,TareMoveReportDeclarTare.Value,
          TareMoveReportDeclarsDate.Value, TareMoveReportDeclarNumDoc1.Value]),[]) or
        TareMoveDeclar.Locate('Client;Tare;sDate',VarArrayOf([
        TareMoveReportDeclarClient.Value,TareMoveReportDeclarTare.Value,
          TareMoveReportDeclarsDate.Value]),[]) then TareMoveC.Execute;
      end;
    end;
  if (DS.Name='TransactExt') or (DS.Name='Transact') or (DS.Name='Transact62') or (DS.Name='Transact62Ext') then
    with ModulePays do begin
      if not Assigned(PayDocC.Form) or not PayDocC.Form.Active then PayDocC.Execute;
      if PayDocS.Locate('AutoInc',DS.DataSet.FieldByName('Oper').Value,[]) then PayDocC.Execute;
    end;

  if (DS.Name='InvoiceV') or (DS.Name='InvoiceVBy') or (DS.Name='InvoiceVT') then
    with ModuleInvoice do begin
      if not Assigned(InvoiceC.Form) or not InvoiceC.Form.Active then InvoiceC.Execute;
      if InvoiceDeclar.Locate('ID',DS.DataSet.FieldByName('InvoiceID').Value,[]) then InvoiceC.Execute;
    end;

  if DS.Name='ClientReportTotal' then begin
    if not Assigned(ClientReportC.Form) or not ClientReportC.Form.Active then ClientReportC.Execute;
    InClient:=ClientReportTotalDeclarClient.Value;
    InAccount:=ClientReportTotalDeclarAccount.Value;
    InCurrency:=ClientReportTotalDeclarCurrency.Value;
    IsClientReportTotalSend:=true;
    TBitBtn(ClientReportC.Form.FindComponent('BtnActParam')).Click;
  end;
  if DS.Name='MProviderCalc2' then with MdMat do begin
    if not Assigned(ClientReportC.Form) or not ClientReportC.Form.Active then ClientReportC.Execute;
    InDateBeg:='01.01.09';
    InDateEnd:='31.10.09';
    InClient:=MProviderCalc2Declar.FieldByName('Client').Value;
    InAccount:=ReportMProviderCalc0000.Text;
    InCurrency:=null;
    IsClientReportTotalSend:=false;
    TBitBtn(ClientReportC.Form.FindComponent('BtnActParam')).Click;
  end;
  if DS.Name='TareMoveReportTotal' then begin
    if not Assigned(TareMoveReportC.Form) or not TareMoveReportC.Form.Active then TareMoveReportC.Execute;
    InClient:=TareMoveReportTotalDeclarClient.Value;
    { Остальные параметры запроса подходят из вызывающей формы: две даты и код тары }
    TBitBtn(TareMoveReportC.Form.FindComponent('BtnTareMoveReport')).Click;
  end;
end;

procedure TModuleClientsAdd.Chess62CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    ReportPeriodChess62:=TDateEdit.Create(Form);
    with ReportPeriodChess62 do begin
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriodChess62';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      TabStop:=true;
      TabOrder:=0;
      if Date=0 then Date:=ModuleBase.ConfigDeclarReportPeriod.AsDateTime;
    end;
    BtnCalcChess62_2008:=TBitBtn.Create(Form);
    with BtnCalcChess62_2008 do begin
      Top:=0;
      Left:=210;
      Width:=100;
      Height:=22;
      Name:='BtnCalcChess62_2008';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      Parent:=PageControl1TabPanel;
      OnClick:=CalcChess62_2008Click;
      TabStop:=true;
      TabOrder:=1;
    end;
  end;
end;

procedure TModuleClientsAdd.CalcChess62_2008Click(Sender: TObject);
begin
  ExecSQLText(Chess62_2008Declar.DataBaseName,'call STA.GetChess62_2008('''+
  TDateEdit(TBEForm(TComponent(Sender).Owner).FindComponent('ReportPeriodChess62')).Text
  +''')',false);
  Chess62_2008Declar.Refresh;
  Chess62_2008C.Caption:='Отчет по оплате продукции и материалов за '+
    FormatDateTime('mmmm yyyy года',ReportPeriodChess62.Date);
  with TBEForm(Chess62_2008C.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

{ Универсальная процедура по расчету отчетов за период }
{ на сервере типа CALL GetReport(InPeriod)             }
procedure TModuleClientsAdd.CalcReportClick(Sender: TObject);
var aFormControl: TDBFormControl;
    aForm:TBEForm;
    aComponent: TComponent;
    aDeclar: TLinkTable;
    aReportName: string[50];
    aAddParameter, aDate1, aDate2: string;
    i: integer;
begin
  aAddParameter:='';
  { 1 - Определение FormControl'я }
  aForm:=TBEForm(TComponent(Sender).Owner);
  aFormControl:=TDBFormControl(aForm.FormControl);
  aDeclar:=TLinkTable(TLinkSource(aFormControl.CurrentSource).Declar);
  aReportName:=Copy(aDeclar.TableName,Pos('.',aDeclar.TableName)+1,50);
  aDate1:=TDateEdit(aForm.FindComponent('ReportPeriod'+aReportName)).Text;
  if (aReportName='ClientBuildingGrodnoReal') or (aReportName='CommodityOutput') or
  (aReportName='WorkersSalaryForPension') or (aReportName='BalanceT') or (aReportName='WorkTimeReport') then begin
    aDate2:=TDateEdit(aForm.FindComponent('ReportPeriod'+aReportName+'2')).Text;
    if aDate2='  .  .  ' then aDate2:='';
  end else aDate2:='';

  if (aReportName='ClientBuildingGrodnoReal') or (aReportName='CommodityOutput') or
    (aReportName='WorkersSalaryForPension') or (aReportName='BalanceT') or (aReportName='WorkTimeReport') then
    if aDate2<>'' then
      aAddParameter:=''','''+aDate2+''''
    else aAddParameter:=''',null'
  else aAddParameter:='''';
  if (aReportName='Chess62_2008') or (aReportName='Chess62') or (aReportName='CommodityOutput') or (aReportName='ClientBuildingGrodnoReal') or (aReportName='WorkTimeReport') then begin
    if TCheckBox(aForm.FindComponent('CheckBox'+aReportName)).Checked then aAddParameter:=aAddParameter+',1'
    else aAddParameter:=aAddParameter+',0';
    // Обработка второго и третьего CheckBox'ов
    if aReportName<>'WorkTimeReport' then
      if (aReportName='CommodityOutput') then begin
        if MessageDlg('Уважаемый пользователь '+AnsiUpperCase(UserName)+'!!!'+#13+
        'Расчет товарной продукции ЗА ОДИН МЕСЯЦ занимает 1 МИНУТУ.'+#13+
        'С учетом прошлого года ЗА ОДИН МЕСЯЦ - 2 МИНУТЫ.'+#13+
        'Пока идет Ваш расчет, другие ПОЛЬЗОВАТЕЛИ информационной системы'+#13+
        'БУДУТ ВЫНУЖДЕНЫ СТОЯТЬ В ОЧЕРЕДИ ЗА ВАМИ.'+#13+
        'Просьба не запускать расчет без необходимости !!!'+#13+
        'ПРОИЗВЕСТИ РАСЧЕТ ТОВАРНОЙ ПРОДУКЦИИ?'
        ,mtConfirmation,[mbYes,mbCancel],0)<>idYes then Abort;
        if TCheckBox(aForm.FindComponent('CheckBox'+aReportName+'2')).Checked then aAddParameter:=aAddParameter+',1'
        else aAddParameter:=aAddParameter+',0';
        if TCheckBox(aForm.FindComponent('CheckBox'+aReportName+'3')).Checked then begin
          aAddParameter:=aAddParameter+',1';
          CommodityOutputVisibleFields(true);
        end else begin
          aAddParameter:=aAddParameter+',0';
          CommodityOutputVisibleFields(false);
        end;
        aReportName:='CommodityOutputAll';
      end else aAddParameter:=aAddParameter+',0';
  end else
    if (aReportName='WorkersSalaryForPension') then
      aAddParameter:=aAddParameter+',''';
    {else aAddParameter:=aAddParameter+'''';}
  if aReportName='PVReport' then aAddParameter:=''',13';

  if aReportName='WorkReport' then begin
    aAddParameter:=aAddParameter+TEdit(aForm.FindComponent('Edit'+aReportName)).Text+'';
    aFormControl.Caption:='Отчет по работе за '+aDate1;
    aForm.Caption:='Отчет по работе за '+aDate1;
  end;

  if aReportName='WorkersSalaryForPension' then begin
    aComponent:=aForm.FindComponent('Edit'+aReportName);
    aAddParameter:=aAddParameter+TEtvDBLookupCombo(aComponent).Text+'''';
    aFormControl.Caption:=TXEDBLookupCombo(aComponent).ListSource.DataSet.FieldByName('FullName').AsString;
    aForm.Caption:=aFormControl.Caption
  end;

  if aAddParameter='' then aAddParameter:='''';

  ExecSQLText(aDeclar.DataBaseName,'call STA.Get'+aReportName+'('''+aDate1+aAddParameter+')',false);

  { Закрываем другие вспомогательные DataSet'ы (Поиск, фильтры и т.д.)}
  i:=0;
  with ModuleBase.KSMDatabase do
    while i<=DatasetCount-1 do begin
      if (DataSets[i] is TTable) and (TTable(DataSets[i]).TableName=aDeclar.TableName)
        then with TTable(DataSets[i]) do begin
          Close;
          FieldDefs.Clear;
        end
      else Inc(i);
    end;
  ModuleBase.KSMDatabase.FlushSchemaCache(aDeclar.TableName);
  if Assigned(aForm) then begin
    aForm.Scroll.DestroyComponents;
    aForm.Tag:=1;
  end;
  with aDeclar do begin
    FieldDefs.Clear;
    aForm.Grid.Columns.RebuildColumns;
    aForm.Grid.Repaint;
    Open;
    for i:=0 to FieldCount-1 do
      if Fields[i] is TNumericField then with TNumericField(Fields[i]) do
        if (DisplayFormat='') and (Pos('Код',DisplayLabel)=0) then DisplayFormat:='### ### ###.##;-### ### ###.##;#';
    if Name='PVReportDeclar' then begin
      DataSetLabel(aDeclar,UserName);
      FieldByName('ID').Visible:=false;
      FieldByName('DstDept').Visible:=false;
      FieldByName('RecType').Visible:=false;
    end;
    if Name='WorkTimeReportDeclar' then begin
      TNumericField(FieldByName('Section')).DisplayFormat:='';
      TNumericField(FieldByName('Category')).DisplayFormat:='';
      if Copy(aAddParameter,Length(aAddParameter),1)='0' then begin
        FieldByName('Industrial').Visible:=false;
        FieldByName('IndustrialName').Visible:=false;
        FieldByName('Section').Visible:=true;
        FieldByName('SectionName').Visible:=true;
      end else begin
        FieldByName('Industrial').Visible:=false;
        FieldByName('IndustrialName').Visible:=false;
        FieldByName('Section').Visible:=false;
        FieldByName('SectionName').Visible:=false;
      end;
    end;
  end;
  // Заголовок отчета
  if aDate2='' then begin
    if aReportName='WorkReport' then
      aFormControl.Caption:='Отчет по работе за '+aDate1
    else if aReportName='WorkersSalaryForPension' then
      aFormControl.Caption:=aFormControl.Caption
      +#10+'Дата выхода на пенсию : '+FormatDateTime('mmmm yyyy года',StrToDate(aDate1))
    else
      aFormControl.Caption:=aDeclar.Caption+' за '+FormatDateTime('mmmm yyyy года',StrToDate(aDate1))
  end else
    if aReportName='WorkersSalaryForPension' then
      aFormControl.Caption:=aFormControl.Caption+#10+'c '+
        FormatDateTime('mmmm yyyy года',TDateEdit(aForm.FindComponent('ReportPeriod'+aReportName)).Date)+
          ' по '+FormatDateTime('mmmm yyyy года',TDateEdit(aForm.FindComponent('ReportPeriod'+aReportName+'2')).Date)
    else
      aFormControl.Caption:=aDeclar.Caption+' c '+DateToStrEtv(StrToDate(aDate1))+' по '+DateToStrEtv(StrToDate(aDate2));
  with aForm.Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

Procedure TModuleClientsAdd.CommodityOutputVisibleFields(aVisible: boolean);
begin
  with CommodityOutputDeclar do begin
    FieldByName('AmountGrossInternalOld').Visible:=aVisible;
    FieldByName('AmountGrossInternalDiff').Visible:=aVisible;
    FieldByName('AmountExportNearOld').Visible:=aVisible;
    FieldByName('AmountExportNearDiff').Visible:=aVisible;
    FieldByName('AmountExportFarOld').Visible:=aVisible;
    FieldByName('AmountExportFarDiff').Visible:=aVisible;
    FieldByName('AmountTradeOld').Visible:=aVisible;
    FieldByName('AmountTradeDiff').Visible:=aVisible;
    FieldByName('AmountTotalOld').Visible:=aVisible;
    FieldByName('AmountTotalDiff').Visible:=aVisible;
    FieldByName('SumGrossInternalOld').Visible:=aVisible;
    FieldByName('SumGrossInternalDiff').Visible:=aVisible;
    FieldByName('SumGrossInternalOld').Visible:=aVisible;
    FieldByName('SumGrossInternalDiff').Visible:=aVisible;
    FieldByName('SumExportNearOld').Visible:=aVisible;
    FieldByName('SumExportNearDiff').Visible:=aVisible;
    FieldByName('SumExportFarOld').Visible:=aVisible;
    FieldByName('SumExportFarDiff').Visible:=aVisible;
    FieldByName('SumTradeOld').Visible:=aVisible;
    FieldByName('SumTradeDiff').Visible:=aVisible;
    FieldByName('SumTotalOld').Visible:=aVisible;
    FieldByName('SumTotalDiff').Visible:=aVisible;
    FieldByName('SumCPGrossInternalOld').Visible:=aVisible;
    FieldByName('SumCPGrossInternalDiff').Visible:=aVisible;
    FieldByName('SumCPGrossInternalOld').Visible:=aVisible;
    FieldByName('SumCPGrossInternalDiff').Visible:=aVisible;
    FieldByName('SumCPExportNearOld').Visible:=aVisible;
    FieldByName('SumCPExportNearDiff').Visible:=aVisible;
    FieldByName('SumCPExportFarOld').Visible:=aVisible;
    FieldByName('SumCPExportFarDiff').Visible:=aVisible;
    FieldByName('SumCPTradeOld').Visible:=aVisible;
    FieldByName('SumCPTradeDiff').Visible:=aVisible;
    FieldByName('SumCPTotalOld').Visible:=aVisible;
    FieldByName('SumCPTotalDiff').Visible:=aVisible;
  end;
end;

procedure TModuleClientsAdd.CreateReportForm(Sender: TObject);
var aReportName: string[50];
    WorkersSource: TDataSource;
    EditWorkers:TEtvDBLookupCombo;
    aDateEdit, aDateEdit2: TDateEdit;
    aBitBtn: TBitBtn;
    aEdit: TEdit;
    aCheckBox: TCheckBox;
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    aReportName:=Copy(TDBFormControl(Sender).Name,1,Length(TDBFormControl(Sender).Name)-1);
    Grid.TitleRows:=4;
    Grid.TitleAlignment:=taCenter;
    if (aReportName='WorkTimeReport') or (aReportName='CommodityOutput') then begin
      Grid.Font.Name:='Arial Narrow';
      Grid.Font.Size:=9;
      Grid.TitleFont.Name:='Arial Narrow';
      Grid.TitleFont.Size:=7;
      Grid.TitleFont.Style:=[fsBold];
    end;
    Grid.OnSetFont:=SetGridClientBuildingRealFont;
    Grid.OnSetColor:=SetGridClientBuildingRealColor;
    aDateEdit:=TDateEdit.Create(Form);
    with aDateEdit do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      if aReportName<>'CheckSaldo' then
        Left:=125
      else Left:=445;
      Width:=80;
      Height:=22;
      Name:='ReportPeriod'+aReportName;
      Font.Style:=[fsBold];
      Font.Size:=9;
      TabStop:=True;
      TabOrder:=0;
      if (Date=0) then with ModuleBase do
        if aReportName='CheckSaldo' then
          case ConfigDeclar.FieldByName('CalcNextPeriod').AsInteger of
            0: Date:=ConfigDeclar.FieldByName('CurPeriod').AsDateTime;
            1: Date:=ConfigDeclar.FieldByName('NextPeriod').AsDateTime;
          end
        else Date:=ModuleBase.ConfigDeclarReportPeriod.AsDateTime;
    end;
    aBitBtn:=TBitBtn.Create(Form);
    with aBitBtn do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      if aReportName<>'CheckSaldo' then
        Left:=207
      else Left:=527;
      Width:=100;
      Height:=22;
      Name:='BtnCalc'+aReportName;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcReportClick;
      TabStop:=true;
      TabOrder:=1;
    end;
    if (aReportName='ClientBuildingGrodnoReal') or (aReportName='CommodityOutput')
    or (aReportName='WorkersSalaryForPension') or (aReportName='BalanceT')
    or (aReportName='WorkTimeReport') then begin
      Grid.Color:=$00E4FDC4; //$00D1FCB1;
      {Grid.Font.Style:=[fsBold];}
      aBitBtn.Left:=290;
      aBitBtn.TabOrder:=3;
      aDateEdit2:=TDateEdit.Create(Form);
      with aDateEdit2 do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=205;
        Width:=80;
        Height:=20;
        Name:='ReportPeriod'+aReportName+'2';
        Font.Style:=[fsBold];
        TabStop:=True;
        TabOrder:=1;
        if (Date=0) and (aReportName<>'WorkersSalaryForPension') then begin
          Date:=SysUtils.Date;
          aDateEdit.Date:=Date;
          aDateEdit.Text:='01'+Copy(aDateEdit.Text,3,10);
        end;
      end;
    end;
    { Для отчета по оплате продукции здесь развилка: }
    { 1) - шахматка по оплате, 2) - шахматка по источникам оплаты отгруженной продукции }
    if (aReportName='Chess62_2008') or (aReportName='Chess62') or (aReportName='CommodityOutput') or
      (aReportName='ClientBuildingGrodnoReal') or (aReportName='WorkTimeReport') then begin
      aCheckBox:=TCheckBox.Create(Form);
      with aCheckBox do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=aBitBtn.Left+aBitBtn.Width+5;
        Width:=180;
        Height:=22;
        Name:='CheckBox'+aReportName;
        Font.Style:=[fsBold];
        if (aReportName='Chess62_2008') or (aReportName='Chess62') then Caption:='Источники оплаты продукции';
        if aReportName='CommodityOutput' then Caption:='Цена с налогами';
        if aReportName='ClientBuildingGrodnoReal' then  Caption:='По всем клиентам';
        if aReportName='WorkTimeReport' then Caption:='Сводная форма';
        TabStop:=true;
        TabOrder:=4;
      end;
    end;
    if (aReportName='CommodityOutput') then begin
      aCheckBox:=TCheckBox.Create(Form);
      with aCheckBox do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=aBitBtn.Left+aBitBtn.Width+130;
        Width:=105;
        Height:=22;
        Name:='CheckBox'+aReportName+'2';
        Font.Style:=[fsBold];
        Caption:='Учет выпуска';
        TabStop:=true;
        TabOrder:=5;
      end;
      aCheckBox:=TCheckBox.Create(Form);
      with aCheckBox do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=aBitBtn.Left+aBitBtn.Width+130+105;
        Width:=135;
        Height:=22;
        Name:='CheckBox'+aReportName+'3';
        Font.Style:=[fsBold];
        Caption:='С прошлым годом';
        TabStop:=true;
        TabOrder:=6;
      end;
    end;
    if (aReportName='WorkReport') then begin
      Grid.Color:=$00E4FDC4;
      aEdit:=TEdit.Create(Form);
      with aEdit do begin
        Parent:=PageControl1TabPanel;
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=aBitBtn.Left+aBitBtn.Width+10;
        Width:=105;
        Height:=20;
        Name:='Edit'+aReportName;
        TabStop:=true;
        TabOrder:=3;
        Font.Style:=[fsBold];
        Text:='';
      end;
    end;
    if (aReportName='WorkersSalaryForPension') then begin
      Grid.Color:=$00E4FDC4;
      WorkersSource:=TDataSource.Create(TBEForm(TDBFormControl(Sender).Form));
      WorkersSource.DataSet:=ModuleWorkers.WorkersVVLookup;
      if not WorkersSource.DataSet.Active then WorkersSource.DataSet.Open;
      EditWorkers:=
        TEtvDBLookupCombo(EditForField(TBEForm(TDBFormControl(Sender).Form),
          ModuleWorkers.WorkersSalaryDeclarTabNumName,0,WorkersSource));
      with EditWorkers do begin
        Left:=290;
        Top:=0;
        DropDownWidth:=250;
        Name:='Edit'+aReportName;
        TabStop:=true;
        Parent:=PageControl1TabPanel;
        TabOrder:=2;
        { Перемещаем кнопку запуска процедуры }
        aBitBtn.Left:=Left+Width+10;
      end;
    end;
    PageControl1TabPanel.AutoSize:=False;
    PageControl1TabPanel.AutoSize:=True;
  end;
end;

procedure TModuleClientsAdd.Circle62CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    ReportPeriodCircle62:=TDateEdit.Create(Form);
    with ReportPeriodCircle62 do begin
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriodCircle62';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      TabStop:=true;
      TabOrder:=0;
      if Date=0 then Date:=ModuleBase.ConfigDeclarReportPeriod.AsDateTime;
    end;
    BtnCalcCircle62:=TBitBtn.Create(Form);
    with BtnCalcCircle62 do begin
      Top:=0;
      Left:=210;
      Width:=100;
      Height:=22;
      Name:='BtnCalcCircle62';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      Parent:=PageControl1TabPanel;
      OnClick:=CalcCircle62Click;
      TabStop:=true;
      TabOrder:=1;
    end;
  end;
end;

procedure TModuleClientsAdd.CalcCircle62Click(Sender: TObject);
begin
  ExecSQLText(Chess62_2008Declar.DataBaseName,'call STA.GetCircle62('''+ReportPeriodCircle62.Text+''')',false);
  Circle62Declar.Refresh;
  with TBEForm(Circle62C.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TModuleClientsAdd.SetGridClientBuildingRealFont(Sender: TObject; Field: TField; Font: TFont);
Const MaxChars=1000;
//Type TCharBuffer=array[0..MaxChars] of Char;
//     PCharBuffer=^TCharBuffer;
var Str: string;
    //aCharBuffer: PCharBuffer;
    aCharBuffer: array[0..MaxChars] of Char;
    MaxCharsVar: integer;
    i: integer;
begin
  MaxCharsVar:=Min(MaxChars,Field.DataSet.RecordSize);
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxCharsVar);
  //aCharBuffer:=Field.DataSet.ActiveBuffer^;
  for i:=0 to MaxCharsVar do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i]); // Меняем символ #0 на #1, бо функция Pos работать не будет
  if (Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0) then begin
    Font.Style:=[fsBold];
    Font.Color:=$00B00000;
    try
      StrToFloat(Field.AsString);
      {TNumericField(Field).DisplayFormat:='### ### ###.00';}
      Field.Alignment:=taRightJustify;
    except
    end;
  end
    else if Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0 then begin
           Font.Style:=[fsBold];
           Font.Color:=clRed;
         end
      else if Pos('+ ',aCharBuffer)>0 then begin
             Font.Style:=[fsBold];
             Font.Color:=clPurple;
         end
end;

procedure TModuleClientsAdd.SetGridClientBuildingRealColor(Sender: TObject;
  Field: TField; var Color: TColor);
Const MaxChars=150;
var aCharBuffer: array[0..MaxChars] of Char;
    i: integer;
begin
  {FillChar(aCharBuffer,MaxChars,#0);}
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxChars);
  for i:=0 to MaxChars do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i]);
  if Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0 then Color:=$00B4FEFE
    else if (Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0) or
            (Pos('БАЛАНС',AnsiUpperCase(aCharBuffer))>0) then Color:=$00D5FFFE
      else if Pos('+ ',aCharBuffer)>0 then Color:=$00DAFFFA //$00F4F5D8
        else Color:=TDBGrid(Sender).Color;
  {if Copy(ClientBuildingGrodnoRealDeclarClientName.AsString,1,5)='Всего' then Color:=$00D5FFFE;}
  // $00FFF8E6; //$00CCEACC;//$00C6FDD8;//$00C6CDFD;//$00A0CD8F;//$00C6DDA4
end;

procedure TModuleClientsAdd.TareMoveReportCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    Grid.TitleFont.Name:='Arial Narrow';
    Grid.TitleFont.Size:=8;
    if TDBFormControl(Sender).Name='TareMoveReportC' then begin
      BtnTareMoveReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
      with BtnTareMoveReport do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        Name:='BtnTareMoveReport';
        Caption:='Движение тары';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=ClientReportClick;
      end;
      TBEForm(TDBFormControl(Sender).Form).Grid.OnDblClick:=GridDblClick;
    end;
    if TDBFormControl(Sender).Name='TareMoveReportTotalC' then begin
      BtnTareMoveReportTotal:=TBitBtn.Create(TDBFormControl(Sender).Form);
      with BtnTareMoveReportTotal do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        Name:='BtnTareMoveReport';
        Caption:='Оборот тары';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=ClientReportClick;
      end;
      TBEForm(TDBFormControl(Sender).Form).Grid.OnDblClick:=GridDblClick;
    end;
    if TDBFormControl(Sender).Name='TareMovePenaltyC' then begin
      Grid.TitleRows:=4;
      BtnTareMovePenalty:=TBitBtn.Create(TDBFormControl(Sender).Form);
      with BtnTareMovePenalty do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        Name:='BtnTareMovePenalty';
        Caption:='Расчет штрафов';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=ClientReportClick;
      end;
      TBEForm(TDBFormControl(Sender).Form).Grid.OnDblClick:=GridDblClick;
    end;
  end;
end;

procedure TModuleClientsAdd.TareMoveDeclarNewRecord(DataSet: TDataSet);
begin
  TareMoveDeclarsDate.Value:=aDate;
  TareMoveDeclarClient.Value:=aClient;
  TareMoveDeclarNumDoc.Value:=aNumDoc;
  TareMoveDeclarNumDoc1.Value:=aNumDoc1;
  TareMoveDeclarOperation.Value:=aOperation;
  TareMoveDeclarTare.Value:=aTare;
end;

procedure TModuleClientsAdd.TareMoveDeclarBeforePost(DataSet: TDataSet);
begin
  aDate:=TareMoveDeclarsDate.Value;
  aClient:=TareMoveDeclarClient.Value;
  aNumDoc:=TareMoveDeclarNumDoc.Value;
  aNumDoc1:=TareMoveDeclarNumDoc1.Value;
  aOperation:=TareMoveDeclarOperation.Value;
  aTare:=TareMoveDeclarTare.Value;
end;

procedure TModuleClientsAdd.TareMoveReportTotalDeclarClientNameGetText(
  Sender: TField; var Text: String; DisplayText: Boolean);
begin
  if TareMoveReportTotalDeclarClient.Value+1-TareMoveReportTotalDeclarID.Value<>0 then
  Text:=Sender.AsString else Text:='ИТОГО';
end;

procedure TModuleClientsAdd.TareMoneyReturnCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3;
    aDate:=Date;
    aPrice:=0;
  end;
end;

procedure TModuleClientsAdd.TareMoneyReturnDeclarNewRecord(DataSet: TDataSet);
begin
  TareMoneyReturnDeclarsDate.Value:=aDate;
  TareMoneyReturnDeclarTare.Value:=aTare;
  TareMoneyReturnDeclarPrice.Value:=aPrice;
  TBEForm(TareMoneyReturnC.Form).Grid.SelectedIndex:=2;
end;

procedure TModuleClientsAdd.TareMoneyReturnDeclarBeforePost(
  DataSet: TDataSet);
begin
  aDate:=TareMoneyReturnDeclarsDate.Value;
  aTare:=TareMoneyReturnDeclarTare.Value;
  aPrice:=TareMoneyReturnDeclarPrice.Value;
  TareMoneyReturnDeclarSumma.Value:=TareMoneyReturnDeclarPackage.Value*TareMoneyReturnDeclarPrice.Value;
end;

procedure TModuleClientsAdd.ActivateForm(Sender: TObject);
begin
  RefreshDataOnForm(nil,true);
end;

procedure TModuleClientsAdd.CheckReport16Form(Sender: TObject);
begin
  if (not Report16Declar.Active) or (Report16Declar.RecordCount=0) then begin
    ShowMessage('Для получения отчета необходимо сделать расчет 16-й ведомости');
    Abort;
  end;
end;

procedure TModuleClientsAdd.Summary16CCreateForm(Sender: TObject);
begin
  CheckReport16Form(Sender);
  CreateReportForm(Sender);
end;

procedure TModuleClientsAdd.CheckTransactReportVForm(Sender: TObject);
begin
  if (not TransactReportVDeclar.Active) or (TransactReportVDeclar.RecordCount=0) then begin
    ShowMessage('Для получения отчета необходимо сделать расчет оборотов по 62-му счету');
    Abort;
  end;
end;

function TModuleClientsAdd.ProdRequestForShopDeclarClientNameFilter(Sender: TObject): String;
begin
  {Result:='(Kod=205000) or (Kod=400900) or (Kod=401600) or (Kod=405215) or (Kod=415215) or (Kod=405351) or (Kod=406600) or (Kod=406100) or (Kod=700000) or (Kod=403000)';}
   Result:='(INN=''500038966'') and (Kod<>900000) and (Kod<>600000)';
  {if InClient in( 205000,400900,401600,405215,415215,405351,406600,406100,700000,403000) then}
end;

procedure TModuleClientsAdd.ProdRequestForShopDeclarNewRecord(DataSet: TDataSet);
var i:byte;
begin
  { Инициализация значений новой строки. Полностью заполняем значениями старой строки }
  with TLinkTable(DataSet) do begin
    if not VarIsEmpty(OldEditValues) then
      { 0 поле ID - AutoInc, заполнится само, поле Note - не заполняем }
      for i:=1 to 6 { Остальные поля заполняет сбыт } do
        if not(Fields[i] is TEtvLookField) and (Fields[i].FieldName<>'Prod') then with Fields[i] do
          try
            if (FieldName='Process') then { Мерзкий тип - XEList, но иногда - полезный }
              case VarType(OldEditValues[i]) of
                3  : Value:=OldEditValues[i];     { В OldEditValues[i] сохранено как целое число}
                8  : AsString:=OldEditValues[i];  { В OldEditValues[i] сохранено как строка     }
              end
            else Value:=OldEditValues[i]
          except
          end;
  end;
  {Установка фокуса Grid'а на поле по-умолчанию: продукция }
  TBEForm(Screen.ActiveForm).Grid.SelectedField:=DataSet.FieldByName('ProdName');
end;

procedure TModuleClientsAdd.ExportToExcelHistoryDeclarBeforeOpen(DataSet: TDataSet);
begin
  if UserName='LEV' then TTable(DataSet).ReadOnly:=false;
end;

end.
