unit mdMaterials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  XMisc, XTFC, XDBTFC, DBTables, EtvTable, LnTables, LnkSet, EtvLook, XECtrls,
  XEFields, Db, Menus, EtvDBase, UsersSet, XApps, ComCtrls, VG, ppBands,
  ppCtrls, EtvPpCtl, ppPrnabl, ppClass, ppDB, ppProd, ppReport, ppComm,
  ppRelatv, ppCache, ppDBPipe, ppDBBDE, ppModule, daDatMod, SelectBox,
  ppVar, Commctrl, DBGrids, Grids, ppStrtch, ppMemo, EtvDB, extctrls, BEForms, ImgList,
  EtvList;

const
  SkladSet = [91,92];

type
    TColumnList = set of byte;
    TColumnListArray = array of byte;
    TmdMat = class(TDataModule)
    Popup: TControlMenu;
    MaterialsEdit: TLinkSource;
    MaterialsEditDeclar: TLinkTable;
    MaterialsC: TDBFormControl;
    N2: TMenuItem;
    Materials1: TLinkMenuItem;
    MaterialsEditDeclarName: TStringField;
    MaterialsView: TLinkSource;
    MaterialsViewDeclar: TLinkTable;
    MaterialsEditDeclarAccount: TStringField;
    MaterialsEditDeclarUnitM: TSmallintField;
    MaterialsEditDeclarAmountDown: TSmallintField;
    MaterialsEditDeclarKod: TIntegerField;
    MaterialsEditDeclarAccountName: TXELookField;
    MaterialsEditDeclarUnitMName: TXELookField;
    MInvoiceH: TLinkSource;
    MInvoiceHDeclarNumDoc: TStringField;
    MInvoiceHDeclarClient: TIntegerField;
    MInvoiceHDeclarKredit: TStringField;
    MInvoiceHDeclarOperation: TSmallintField;
    MInvoiceHDeclarCurrency: TSmallintField;
    MInvoiceT: TLinkSource;
    MInvoiceTDeclar: TLinkTable;
    MInvoiceTDeclarInvoiceID: TIntegerField;
    MInvoiceTDeclarMaterial: TIntegerField;
    MInvoiceTDeclarOperation: TSmallintField;
    MInvoiceTDeclarRateVAT: TFloatField;
    MInvoiceTDeclarSummaVAT: TFloatField;
    MInvoiceTDeclarBID: TFloatField;
    MInvoiceTDeclarSummaBY: TFloatField;
    MInvoiceTDeclarPriceBy: TFloatField;
    MInvoiceC: TDBFormControl;
    MInvoiceHDeclar: TLinkTable;
    MInvoiceHDeclarID: TAutoIncField;
    MInvoiceHDeclarKrName: TXELookField;
    Operation: TLinkSource;
    OperationDeclarName: TStringField;
    OperationDeclarKod: TSmallintField;
    MInvoiceHDeclarOperationName: TXELookField;
    MInvoiceHDeclarCurrencyName: TXELookField;
    MaterialsEditLookupkod: TIntegerField;
    MInvoiceTDeclarMaterialName: TXELookField;
    MInvoiceTDeclarID: TAutoIncField;
    MInvoiceTDeclarSumma: TFloatField;
    MInvoiceTDeclarSummaBID: TFloatField;
    MInvoiceTDeclarTotal: TFloatField;
    MInvoice1: TLinkMenuItem;
    MInvoiceHDeclarSourceDepotName: TXELookField;
    MInvoiceV: TLinkSource;
    MInvoiceVDeclar: TLinkTable;
    MInvoiceVC: TDBFormControl;
    MInvoiceV1: TLinkMenuItem;
    MInvoiceTDeclarAmount: TFloatField;
    MAmountsV: TLinkSource;
    MAmountsVC: TDBFormControl;
    MAmountsV1: TLinkMenuItem;
    MAmountsVDeclar: TLinkTable;
    MAmountsVDeclarDepot: TSmallintField;
    MAmountsVDeclarDepotName: TStringField;
    MAmountsVDeclarmaterial: TIntegerField;
    MAmountsVDeclarMaterialName: TStringField;
    MAmountsVDeclarprice: TFloatField;
    MAmountsVDeclaramount: TFloatField;
    MInvoiceHDeclarDestDepot: TSmallintField;
    MInvoiceHDeclarSourceDepot: TSmallintField;
    MInvoiceHDeclarClientName: TXELookField;
    MInvoiceHDeclarRecipient: TIntegerField;
    MInvoiceHDeclarRecipientName: TXELookField;
    MLimit: TLinkSource;
    MLimitDeclar: TLinkTable;
    MLimitDeclarNumDoc: TStringField;
    MLimitDeclarDateDoc: TDateField;
    MLimitDeclarDepot: TSmallintField;
    MLimitDeclarSumma: TFloatField;
    MLimitC: TDBFormControl;
    MLimit1: TLinkMenuItem;
    MLimitDeclarID: TAutoIncField;
    MLimitDeclarDepotName: TXELookField;
    MInvoiceTDeclarContract: TStringField;
    MInvoiceHDeclarDestDepotName: TXELookField;
    MaterialsEditDeclarKodUp: TIntegerField;
    MaterialsEditDeclarGold: TFloatField;
    MaterialsEditDeclarPlatinum: TFloatField;
    MaterialsEditDeclarSilver: TFloatField;
    MCardC1: TLinkMenuItem;
    PLMCard: TppBDEPipeline;
    N1: TMenuItem;
    PLMInOrderT: TppDBPipeline;
    MReport: TppReport;
    ppTitleBand2: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppHeaderBand2: TppHeaderBand;
    ppShape3: TppShape;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppShape4: TppShape;
    ppLabel9: TppLabel;
    ppShape5: TppShape;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppShape9: TppShape;
    ppShape8: TppShape;
    ppShape7: TppShape;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText9: TppDBText;
    ppDBCalc1: TppDBCalc;
    ppDBText1: TppDBText;
    ppFooterBand2: TppFooterBand;
    MInvoiceTDeclarDocAmount: TFloatField;
    MInvoiceVDeclarNumDoc: TStringField;
    MInvoiceVDeclarID: TIntegerField;
    MInvoiceVDeclarHID: TIntegerField;
    MInvoiceVDeclarClient: TIntegerField;
    MInvoiceVDeclarClientName: TStringField;
    MInvoiceVDeclarDestDepot: TSmallintField;
    MInvoiceVDeclarDestDepotName: TStringField;
    MInvoiceVDeclarKredit: TStringField;
    MInvoiceVDeclarSourceDepot: TSmallintField;
    MInvoiceVDeclarCurrency: TSmallintField;
    MInvoiceVDeclarInvoiceID: TIntegerField;
    MInvoiceVDeclarMaterial: TIntegerField;
    MInvoiceVDeclarMaterialName: TStringField;
    MInvoiceVDeclarUnitMName: TStringField;
    MInvoiceVDeclarOperation: TSmallintField;
    MInvoiceVDeclarOperationName: TStringField;
    MInvoiceVDeclarRateVAT: TFloatField;
    MInvoiceVDeclarSummaVAT: TFloatField;
    MInvoiceVDeclarBID: TFloatField;
    MInvoiceVDeclarAmount: TFloatField;
    MInvoiceVDeclarPrice: TFloatField;
    MInvoiceVDeclarSummaBY: TFloatField;
    MInvoiceVDeclarPriceBY: TFloatField;
    MInvoiceVDeclarSummaBID: TFloatField;
    MInvoiceVDeclarSumma: TFloatField;
    MInvoiceVDeclarRecipient: TIntegerField;
    ppSummaryBand1: TppSummaryBand;
    ppDBCalc2: TppDBCalc;
    ppLabel12: TppLabel;
    Price: TLinkSource;
    PriceLookup: TLinkQuery;
    PriceLookupMaterial: TIntegerField;
    PriceLookupPrice: TFloatField;
    PriceLookupAmount: TFloatField;
    MInvoiceTDeclarPriceName: TXELookField;
    MInvoiceTDeclarPrice: TFloatField;
    MInvoiceTDeclarSummaVatBy: TFloatField;
    MInvoiceTDeclarSummaBIDBy: TFloatField;
    MInvoiceTDeclarPriceNameBy: TXELookField;
    MInvoiceTDeclarTotalBy: TFloatField;
    MInvoiceTDeclarDebit: TStringField;
    MInvoiceTDeclarDebitName: TXELookField;
    MInvoiceTDeclarKredit: TStringField;
    MInvoiceTDeclarKreditName: TXELookField;
    MCardsV: TLinkSource;
    MCardsVDeclar: TLinkTable;
    MCardsVC: TDBFormControl;
    MCardsVC1: TLinkMenuItem;
    OperationC: TDBFormControl;
    MInvoiceHDeclarPerson: TStringField;
    MInvoiceHDeclarDepreciation: TSmallintField;
    MInvoiceHDeclarInvoiceNum: TStringField;
    MaterialsEditDeclarSection: TIntegerField;
    MaterialsEditDeclarSectionName: TXELookField;
    MAmountsVDeclarUnitM: TSmallintField;
    MAmountsVDeclarUnitMName: TStringField;
    MAmountsVDeclarSection: TIntegerField;
    MAmountsVDeclarSectionName: TStringField;
    MaterialsEditDeclarPalladium: TFloatField;
    MInvoiceHDeclarInfo: TStringField;
    MInvoiceHDeclarsUser: TStringField;
    MInvoiceHDeclarsTime: TDateTimeField;
    MInvoiceHDeclarDateDoc: TDateTimeField;
    MInvoiceTDeclarDateDoc: TDateTimeField;
    MInvoiceVDeclarDateDoc: TDateTimeField;
    MCardsVDeclarPosition: TDateTimeField;
    MCardsVDeclarInvoiceTabID: TIntegerField;
    MCardsVDeclarDepot: TSmallintField;
    MCardsVDeclarDepotName: TStringField;
    MCardsVDeclarMaterial: TIntegerField;
    MCardsVDeclarMaterialName: TStringField;
    MCardsVDeclarPrice: TFloatField;
    MCardsVDeclarBeginAmount: TFloatField;
    MCardsVDeclarAmountIn: TFloatField;
    MCardsVDeclarAmountOut: TFloatField;
    MCardsVDeclarRestAmount: TFloatField;
    MAmountsVDeclarSumma: TFloatField;
    MInvoiceVDeclarSection: TIntegerField;
    MInvoiceVDeclarSectionName: TStringField;
    MInvoiceT_Restore: TLinkSource;
    MInvoiceT_RestoreDeclar: TLinkTable;
    MInvoiceT_RestoreDeclarNumDoc: TStringField;
    MInvoiceT_RestoreDeclarMaterial: TIntegerField;
    MInvoiceT_RestoreDeclarOperation: TSmallintField;
    MInvoiceT_RestoreDeclarRateVAT: TFloatField;
    MInvoiceT_RestoreDeclarSummaVAT: TFloatField;
    MInvoiceT_RestoreDeclarBID: TFloatField;
    MInvoiceT_RestoreDeclarAmount: TFloatField;
    MInvoiceT_RestoreDeclarPrice: TFloatField;
    MInvoiceT_RestoreDeclarSummaBY: TFloatField;
    MInvoiceT_RestoreDeclarPriceBy: TFloatField;
    MInvoiceT_RestoreDeclarSummaBID: TFloatField;
    MInvoiceT_RestoreDeclarSumma: TFloatField;
    MInvoiceT_RestoreDeclarContract: TStringField;
    MInvoiceT_RestoreDeclarDocAmount: TFloatField;
    MInvoiceT_RestoreDeclarSummaVatBy: TFloatField;
    MInvoiceT_RestoreDeclarSummaBIDBy: TFloatField;
    MInvoiceT_RestoreDeclarTotal: TFloatField;
    MInvoiceT_RestoreDeclarTotalBy: TFloatField;
    MInvoiceT_RestoreDeclarDebit: TStringField;
    MInvoiceT_RestoreDeclarKredit: TStringField;
    MInvoiceT_RestoreDeclarDateDoc: TDateTimeField;
    MInvoiceT_RestoreDeclarClient: TIntegerField;
    MInvoiceT_RestoreDeclarDestDepot: TSmallintField;
    MInvoiceT_RestoreDeclarSourceDepot: TSmallintField;
    MInvoiceT_RestoreDeclarRecipient: TIntegerField;
    MInvoiceT_RestoreDeclarID: TAutoIncField;
    MInvoiceT_RestoreDeclarMaterialName: TXELookField;
    MInvoiceT_RestoreDeclarDebitName: TXELookField;
    MInvoiceT_RestoreDeclarKreditName: TXELookField;
    MInvoiceT_RestoreDeclarOperationName: TXELookField;
    MInvoiceT_RestoreC: TDBFormControl;
    MInvoiceT_Restore1: TLinkMenuItem;
    MInvoiceT_RestoreDeclarClientName: TXELookField;
    MInvoiceT_RestoreDeclarDestDepotName: TXELookField;
    MInvoiceT_RestoreDeclarSourceDepotName: TXELookField;
    MInvoiceT_RestoreDeclarRecipientName: TXELookField;
    MInvoiceVDeclarInvoiceNum: TStringField;
    MInvoiceHLookup: TLinkQuery;
    MInvoiceHLookupNumDoc: TStringField;
    MInvoiceHLookupID: TIntegerField;
    MInvoiceVDeclarNumDocName: TXELookField;
    MAmountsVAll: TLinkSource;
    MAmountsVAllC: TDBFormControl;
    MAmountsVAllDeclar: TLinkTable;
    MAmountsVAllDeclarPosition: TDateTimeField;
    MAmountsVAllDeclarDepot: TSmallintField;
    MAmountsVAllDeclarDepotName: TStringField;
    MAmountsVAllDeclarMaterial: TIntegerField;
    MAmountsVAllDeclarMaterialName: TStringField;
    MAmountsVAllDeclarUnitM: TSmallintField;
    MAmountsVAllDeclarUnitMName: TStringField;
    MAmountsVAllDeclarPrice: TFloatField;
    MAmountsVAllDeclarAmount: TFloatField;
    MAmountsVAllDeclarSumma: TFloatField;
    MAmountsVAllDeclarSection: TIntegerField;
    MAmountsVAllDeclarSectionName: TStringField;
    MAmountsVAll1: TLinkMenuItem;
    MAmounts: TLinkSource;
    MAmountsDeclar: TLinkTable;
    MAmountsDeclarMaterial: TIntegerField;
    MAmountsDeclarPrice: TFloatField;
    MAmountsDeclarPeriod: TDateField;
    MAmountsDeclarMaterialName: TStringField;
    MAmountsDeclarUnitM: TSmallintField;
    MAmountsDeclarUnitMName: TStringField;
    MAmountsDeclarAmount: TFloatField;
    MAmountsDeclarConsumptionCurrent: TFloatField;
    MAmountsDeclarConsumptionLastYear: TFloatField;
    MAmountsDeclarPriceVAT: TFloatField;
    MAmountsDeclarPosition: TDateTimeField;
    MAmountsDeclarIncomeCurrent: TFloatField;
    MAmountsDeclarIncomeLastYear: TFloatField;
    MAmountsC: TDBFormControl;
    MAmounts1: TLinkMenuItem;
    MAmountsDeclarSumma: TFloatField;
    MCardsVDeclarBeginSumma: TFloatField;
    MCardsVDeclarSummaIn: TFloatField;
    MCardsVDeclarSummaOut: TFloatField;
    MCardsVDeclarRestSumma: TFloatField;
    MCardsC: TDBFormControl;
    MCards: TLinkSource;
    MCardsDeclar: TLinkTable;
    MCardsDeclarMaterial: TIntegerField;
    MCardsDeclarPrice: TFloatField;
    MCardsDeclarMaterialName: TStringField;
    MCardsDeclarUnitM: TSmallintField;
    MCardsDeclarNameM: TStringField;
    MCardsDeclarAmount_BEG: TFloatField;
    MCardsDeclarSumma_BEG: TFloatField;
    MCardsDeclarAmount_IN: TFloatField;
    MCardsDeclarSumma_IN: TFloatField;
    MCardsDeclarAmount_OUT: TFloatField;
    MCardsDeclarSumma_OUT: TFloatField;
    MCardsDeclarAmount_END: TFloatField;
    MCardsDeclarSumma_END: TFloatField;
    MCardsDeclarKredit: TStringField;
    MCardsC1: TLinkMenuItem;
    ppLabel4: TppLabel;
    ppDBMemo1: TppDBMemo;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppDBText2: TppDBText;
    MInvoiceTLookupQuery: TLinkQuery;
    MInvoiceTLookupQueryKod: TSmallintField;
    MInvoiceTLookupQueryName: TStringField;
    MMotion: TLinkSource;
    MMotionDeclar: TLinkTable;
    MMotionC: TDBFormControl;
    MMotionDeclarDepot: TSmallintField;
    MMotionDeclarPrice: TFloatField;
    MMotionDeclarAmount_before: TFloatField;
    MMotionDeclarAmount: TFloatField;
    MMotionDeclarAmount_after: TFloatField;
    MMotionDeclarNumDoc: TStringField;
    MMotionDeclarSourceID: TIntegerField;
    MMotionDeclarSourceName: TStringField;
    MMotionDeclarDestID: TIntegerField;
    MMotionDeclarDestName: TStringField;
    MMotionDeclarOperation: TSmallintField;
    MMotionDeclarNameOper: TStringField;
    MMotionDeclarsUser: TStringField;
    MMotionDeclarsTime: TDateTimeField;
    MMotionC1: TLinkMenuItem;
    MMotionDeclarInvoiceID: TIntegerField;
    MMotionDeclarInvoiceIDName: TXELookField;
    MInvoiceTDeclarSummaOTKL: TFloatField;
    MInvoiceTDeclarSummaOTKLBy: TFloatField;
    N3: TMenuItem;
    N4: TMenuItem;
    MInvoiceShortV: TLinkSource;
    MInvoiceShortVDeclar: TLinkTable;
    MInvoiceShortVDeclarSourceID: TIntegerField;
    MInvoiceShortVDeclarSourceName: TStringField;
    MInvoiceShortVDeclarDestID: TIntegerField;
    MInvoiceShortVDeclarDestName: TStringField;
    MInvoiceShortVDeclarOperation: TSmallintField;
    MInvoiceShortVDeclarNameOper: TStringField;
    MInvoiceShortVDeclarID: TIntegerField;
    MInvoiceShortVDeclarIDName: TXELookField;
    MInvoiceShortVC: TDBFormControl;
    N5: TMenuItem;
    MInvoiceShortVC1: TLinkMenuItem;
    MInvoiceShortVDeclarNumDoc: TStringField;
    MInvoiceShortVDeclarDateDoc: TDateTimeField;
    MInvoiceTDeclarPrice_no_BID: TFloatField;
    MInvoiceHDeclarContract: TStringField;
    MInvoiceHDeclarAllower: TIntegerField;
    MInvoiceHDeclarContractName: TXELookField;
    MInvoiceHDeclarAllowerNAme: TXELookField;
    MStatRash: TLinkSource;
    MStatRashDeclar: TLinkTable;
    MStatRashDeclarKOD: TAutoIncField;
    MStatRashDeclarNAME: TStringField;
    MStatRashC: TDBFormControl;
    MObjZatr: TLinkSource;
    MObjZatrDeclar: TLinkTable;
    MObjZatrDeclarNAME: TStringField;
    MObjZatrC: TDBFormControl;
    N6: TMenuItem;
    MObjZatrC1: TLinkMenuItem;
    MStatRashC1: TLinkMenuItem;
    MInvoiceHDeclarKod_StatRash: TIntegerField;
    MInvoiceHDeclarKod_ObjZatr: TIntegerField;
    MInvoiceHDeclarStatRashName: TXELookField;
    MInvoiceHDeclarObjZatrName: TXELookField;
    MMotionDeclarMaterialsName: TXELookField;
    MCardsDeclarTYPE_STR: TSmallintField;
    MStatRashLookup: TLinkQuery;
    MStatRashLookupkod: TIntegerField;
    MStatRashLookupname: TStringField;
    MObjZatrLookup: TLinkQuery;
    MObjZatrLookupkod: TIntegerField;
    MObjZatrLookupname: TStringField;
    MaterialsViewDeclarKod: TIntegerField;
    MaterialsViewDeclarKodUp: TIntegerField;
    MaterialsViewDeclarAmountDown: TSmallintField;
    MaterialsViewDeclarName: TStringField;
    MRashWork: TLinkSource;
    MRashWorkDeclar: TLinkTable;
    MRashWorkDeclarAccount: TStringField;
    MRashWorkDeclarKorrAmount: TStringField;
    MRashWorkDeclarDepot: TIntegerField;
    MRashWorkDeclarDepotName: TStringField;
    MRashWorkDeclarKodObjZatr: TIntegerField;
    MRashWorkDeclarNameObjZatr: TStringField;
    MRashWorkDeclarKodStatRash: TIntegerField;
    MRashWorkDeclarNameStatRash: TStringField;
    MRashWorkDeclarSumma: TFloatField;
    MRashWorkC: TDBFormControl;
    N7: TMenuItem;
    MRashWorkC1: TLinkMenuItem;
    MInvoiceTDeclarSummaOTKL2: TFloatField;
    MInvoiceTDeclarSummaOTKL2By: TFloatField;
    MaterialsCC: TDBFormControl;
    MaterialsEdit2: TLinkSource;
    MaterialsEdit2Declar: TLinkTable;
    MaterialsEdit2DeclarName: TStringField;
    MaterialsEdit2DeclarKod: TIntegerField;
    MaterialsEdit2DeclarInvNumber: TIntegerField;
    MInvoiceHLookupInvoiceNum: TStringField;
    MaterialsEditLookupCalcKod: TIntegerField;
    MaterialsEditLookupCalcName: TStringField;
    MaterialsEditLookupCalcInvNumber: TIntegerField;
    MaterialsEditLookupCalcUnitMName: TStringField;
    MaterialsEditLookupName: TStringField;
    MaterialsEditLookupInvNumber: TIntegerField;
    MaterialsEditLookupAccount: TStringField;
    MaterialsEditLookupCalcAccount: TStringField;
    MaterialsEditLookupCalcPrice: TFloatField;
    MMotionDeclarSection: TIntegerField;
    MMotionDeclarname: TStringField;
    MInvoiceTDeclarPrice_no_Round: TFloatField;
    MostNmove: TLinkSource;
    MostNmoveDeclar: TLinkTable;
    MostNmoveC: TDBFormControl;
    MostNmoveDeclarDEPOT: TSmallintField;
    MostNmoveDeclarNAME: TStringField;
    MostNmoveDeclarSummaBEG: TFloatField;
    MostNmoveDeclarSummaPrihPost: TFloatField;
    MostNmoveDeclarSummaPrihPro: TFloatField;
    MostNmoveDeclarSummaPrihVnut: TFloatField;
    MostNmoveDeclarSummaRashOsn: TFloatField;
    MostNmoveDeclarSummaRashVsp: TFloatField;
    MostNmoveDeclarSummaRashVnesh: TFloatField;
    MostNmoveDeclarSummaRashAnother: TFloatField;
    MostNmoveDeclarSummaRAshVnut: TFloatField;
    MostNmoveDeclarSummaEND: TFloatField;
    MostNmoveC1: TLinkMenuItem;
    MostNmoveDeclarSummaPrihALL: TFloatField;
    MostNmoveDeclarSummaRashAll: TFloatField;
    MControlRes: TLinkSource;
    MControlResDeclar: TLinkTable;
    MControlResC: TDBFormControl;
    MControlResDeclarAccount: TStringField;
    MControlResDeclarKod: TIntegerField;
    MControlResDeclarName: TStringField;
    MControlResDeclarUnitM: TStringField;
    MControlResDeclarPrice: TFloatField;
    MControlResDeclarSummaBy: TFloatField;
    MControlResDeclarControl: TIntegerField;
    MControlResDeclarKolvo: TFloatField;
    MControlResC1: TLinkMenuItem;
    MControlResDeclarLastPrih: TDateField;
    MControlResDeclarLastRash: TDateField;
    MControlResDeclarSTR_TP: TSmallintField;
    MInvoiceHDeclarsUserIns: TIntegerField;
    MInvoiceHDeclarsDateIns: TDateTimeField;
    MInvoiceHDeclarsUserUpd: TIntegerField;
    MInvoiceHDeclarsDateUpd: TDateTimeField;
    MInvoiceTDeclarsUserIns: TIntegerField;
    MInvoiceTDeclarsDateIns: TDateTimeField;
    MInvoiceTDeclarsUserUpd: TIntegerField;
    MInvoiceTDeclarsDateUpd: TDateTimeField;
    MFindC: TDBFormControl;
    MFind: TLinkSource;
    MFindDeclar: TLinkTable;
    MFindDeclarMaterial: TIntegerField;
    MFindDeclarPrice: TFloatField;
    MFindDeclarPeriod: TDateField;
    MFindDeclarMaterialName: TStringField;
    MFindDeclarUnitM: TSmallintField;
    MFindDeclarUnitMName: TStringField;
    MFindDeclarAmount: TFloatField;
    MFindDeclarPosition: TDateTimeField;
    MFindDeclarSumma: TFloatField;
    MFindDeclarDepot: TSmallintField;
    MFindDeclarDepotName: TStringField;
    MFindC1: TLinkMenuItem;
    MSvodMove: TLinkSource;
    MSvodMoveC: TDBFormControl;
    MSvodMoveDeclar: TLinkTable;
    MSvodMoveDeclarOsnAcc: TStringField;
    MSvodMoveDeclarKorrAcc: TStringField;
    MSvodMoveDeclarSumma_BEG_DEB: TFloatField;
    MSvodMoveDeclarSumma_BEG_KRE: TFloatField;
    MSvodMoveDeclarSumma_OBRT_DEB: TFloatField;
    MSvodMoveDeclarSumma_OBRT_KRE: TFloatField;
    MSvodMoveDeclarSumma_END_DEB: TFloatField;
    MSvodMoveDeclarSumma_END_KRE: TFloatField;
    MSvodMoveDeclarTYPE: TSmallintField;
    MSvodMoveC1: TLinkMenuItem;
    MMoveMat_Prih: TLinkSource;
    MMoveMat_PrihC: TDBFormControl;
    MMoveMat_PrihDeclar: TLinkTable;
    MMoveMat_RashC: TDBFormControl;
    MMoveMAt_PrihC1: TLinkMenuItem;
    MMoveMat_RashC1: TLinkMenuItem;
    MMoveMat_Rash: TLinkSource;
    MMoveMat_RashDeclar: TLinkTable;
    MInvoiceHDeclarsAuto: TStringField;
    MInvoiceHDeclarsAuto_lst: TStringField;
    MInvoiceHDeclarsAuto_ownr: TStringField;
    MInvoiceHDeclarsAuto_drvr: TStringField;
    MInvoiceHDeclarUsl_Post: TStringField;
    MInvoiceHDeclarOsn_Vyd: TStringField;
    MInvoiceHDeclarCel_Prb: TStringField;
    MInvoiceHDeclarPlace_Razgr: TStringField;
    MInvoiceT_SS: TLinkSource;
    MInvoiceT_SSDeclar: TLinkTable;
    MInvoiceT_SSDeclarID: TIntegerField;
    MInvoiceT_SSDeclarKod_StatRash: TIntegerField;
    MInvoiceT_SSDeclarKod_ObjZatr: TIntegerField;
    MInvoiceT_SSDeclarSTV: TFloatField;
    MInvoiceT_SSDeclarSumma: TFloatField;
    MInvoiceT_SSDeclarKod_StatRashName: TXELookField;
    MInvoiceT_SSDeclarKod_ObjZatrName: TXELookField;
    MInvoiceT_SSDeclarAccount: TStringField;
    MInvoiceT_SSDeclarAccountName: TXELookField;
    MAmountsDeclarSection: TIntegerField;
    MAmountsDeclarSectionName: TXELookField;
    MaterialsEditLookupCalcAmount: TFloatField;
    MaterialsEditLookupCalcDepot: TSmallintField;
    MaterialsEditLookup: TLinkTable;
    MaterialsEditLookupCalc: TLinkTable;
    MaterialsEditLookupKodUp: TIntegerField;
    MaterialsEditLookupCalcKodUp: TIntegerField;
    MInvoiceHDeclarSourceCommonName: TStringField;
    MInvoiceHDeclarDestCommonName: TStringField;
    MaterialsEditLookupUnitMName: TStringField;
    MInvoiceTDeclarPriceUC: TFloatField;
    PriceLookupPriceUC: TFloatField;
    MInvoice_SSCheckC: TDBFormControl;
    MInvoice_SSCheck: TLinkSource;
    MInvoice_SSCheckDeclar: TLinkTable;
    MInvoice_SSCheckDeclarID: TIntegerField;
    MInvoice_SSCheckDeclarDestDepot: TSmallintField;
    MInvoice_SSCheckDeclarSourceDepot: TSmallintField;
    MInvoice_SSCheckDeclarDestName: TStringField;
    MInvoice_SSCheckDeclarSourceName: TStringField;
    MInvoice_SSCheckDeclarInvoice: TXELookField;
    N8: TMenuItem;
    MInvoice_SSCheckC1: TLinkMenuItem;
    MaterialsEditLookupCalcPriceUC: TFloatField;
    MOborotMat: TLinkSource;
    MOborotMatDeclar: TLinkTable;
    MOborotMatDeclarID: TIntegerField;
    MOborotMatDeclarClient: TIntegerField;
    MOborotMatDeclarDestDepot: TSmallintField;
    MOborotMatDeclarSourceDepot: TSmallintField;
    MOborotMatDeclarRecipient: TIntegerField;
    MOborotMatDeclarOperation: TSmallintField;
    MOborotMatDeclarAmount: TFloatField;
    MOborotMatDeclarPriceBy: TFloatField;
    MOborotMatDeclarKod: TIntegerField;
    MOborotMatDeclarName: TStringField;
    MOborotMatDeclarUnitM: TSmallintField;
    MOborotMatC: TDBFormControl;
    MOborotMatDeclarIDName: TXELookField;
    MOborotMatDeclarUnitMName: TXELookField;
    MOborotMatDeclarOperationName: TXELookField;
    MOborotMatDeclarClientName: TXELookField;
    MOborotMatDeclarRecipientName: TXELookField;
    MOborotMatDeclarDestDepotName: TXELookField;
    MOborotMatDeclarSourceDepotName: TXELookField;
    MOborotMatC1: TLinkMenuItem;
    MRashWorkDeclarPrz: TIntegerField;
    MAmountsGroup: TLinkSource;
    MAmountsGroupDeclar: TLinkTable;
    MAmountsGroupDeclarkod: TIntegerField;
    MAmountsGroupDeclarname: TStringField;
    MAmountsGroupDeclarSumma: TFloatField;
    MAmountsGroupC: TDBFormControl;
    MAmountsGroupC1: TLinkMenuItem;
    MAmountsGroupDeclarUnitMName: TStringField;
    MAmountsGroupDeclarAmount: TFloatField;
    MInvoiceIDsByAccount: TLinkSource;
    MInvoiceIDsByAccountC: TDBFormControl;
    MInvoiceIDsByAccountDeclar: TLinkTable;
    MInvoiceIDsByAccountDeclarID: TIntegerField;
    MInvoiceIDsByAccountDeclarIDName: TXELookField;
    N9: TLinkMenuItem;
    MRashWorkDeclarID: TFloatField;
    MMotionDeclarDepotName: TXELookField;
    MMotionDeclarPosition: TDateField;
    MMotionDeclarPriceUC: TFloatField;
    MMotionDeclarShortN: TStringField;
    MMotionDeclarInvoiceNum: TStringField;
    MAmountsDeclarDepot: TSmallintField;
    MAmountsDeclarDepotName: TStringField;
    MAmountsDeclarPriceUC: TFloatField;
    MaterialsEditLookupPrice: TFloatField;
    MaterialsEditLookupPriceUc: TFloatField;
    MaterialsEditLookupAmount: TFloatField;
    MaterialsEditLookupDepot: TSmallintField;
    MaterialsEditLookupGold: TFloatField;
    MaterialsEditLookupPlatinum: TFloatField;
    MaterialsEditLookupSilver: TFloatField;
    MaterialsEditLookupPalladium: TFloatField;
    MaterialsEditLookupRutenium: TFloatField;
    MaterialsEditLookupRodium: TFloatField;
    MaterialsEditLookupIridium: TFloatField;
    MaterialsEditLookupCalcGold: TFloatField;
    MaterialsEditLookupCalcPlatinum: TFloatField;
    MaterialsEditLookupCalcSilver: TFloatField;
    MaterialsEditLookupCalcPalladium: TFloatField;
    MaterialsEditLookupCalcRutenium: TFloatField;
    MaterialsEditLookupCalcRodium: TFloatField;
    MaterialsEditLookupCalcIridium: TFloatField;
    MaterialsEditDeclarRutenium: TFloatField;
    MaterialsEditDeclarRodium: TFloatField;
    MaterialsEditDeclarIridium: TFloatField;
    MDrgOperC: TDBFormControl;
    MDrgOper: TLinkSource;
    MDrgOperDeclar: TLinkTable;
    MDrgOperDeclarKod: TSmallintField;
    MDrgOperDeclarName: TStringField;
    MDrgOperDeclarOperation: TSmallintField;
    MInvoiceTDeclarKodDrgOper: TSmallintField;
    MInvoiceTDeclarDrgOperName: TXELookField;
    MDrgOperMoveC: TDBFormControl;
    MDrgOperMove: TLinkSource;
    MDrgOperMoveDeclar: TLinkTable;
    MDrgOperMoveDeclarKodDrgOper: TSmallintField;
    MDrgOperMoveDeclarMaterial: TIntegerField;
    MDrgOperMoveDeclarUnitM: TSmallintField;
    MDrgOperMoveDeclarPriceBy: TFloatField;
    MDrgOperMoveDeclarKolvo: TFloatField;
    MDrgOperMoveDeclarDrgName: TStringField;
    MDrgOperMoveDeclarDrgKolvo: TFloatField;
    MDrgOperMoveDeclarKodDrg: TSmallintField;
    MDrgOperMoveDeclarStrType: TSmallintField;
    MDrgOperMoveDeclarMaterialName: TStringField;
    MDrgOperMoveDeclarInvoiceID: TIntegerField;
    MDrgOperMoveC1: TLinkMenuItem;
    MDrgOperMoveDeclarUnitMName: TXELookField;
    MDrgOperMoveDeclarMaterialsKod: TXELookField;
    MaterialsLookupKod: TIntegerField;
    MaterialsLookupName: TStringField;
    MDrgOperMoveDeclarDocument: TXELookField;
    MInvoiceHLookupDateDoc: TDateField;
    MFindDeclarPriceUC: TFloatField;
    MSpisanie: TLinkSource;
    MSpisanieC: TDBFormControl;
    MSpisanieDeclar: TLinkTable;
    MSpisanieDeclarDateDoc: TDateField;
    MSpisanieDeclarOsn: TStringField;
    MSpisanieDeclarKor: TStringField;
    MSpisanieDeclarDepot: TSmallintField;
    MSpisanieDeclarKod_StatRash: TIntegerField;
    MSpisanieDeclarKod_ObjZatr: TIntegerField;
    MSpisanieDeclarInvoiceID: TIntegerField;
    MSpisanieDeclarMaterial: TIntegerField;
    MSpisanieDeclarPriceUC: TFloatField;
    MSpisanieDeclarPriceBy: TFloatField;
    MSpisanieDeclarSummaSpisania: TFloatField;
    MSpisanieDeclarPRZ_FULL: TSmallintField;
    MSpisanieDeclarDepotName: TXELookField;
    MSpisanieDeclarObjZatrName: TXELookField;
    MSpisanieDeclarInvoiceName: TXELookField;
    MSpisanieDeclarMaterialName: TXELookField;
    MSpisanieDeclarAmount: TFloatField;
    MSpisanieC1: TLinkMenuItem;
    MSpisanieDeclarOsnName: TXELookField;
    MSpisanieDeclarKorName: TXELookField;
    MRashWorkDeclarOsn: TStringField;
    MRashWorkDeclarKor: TStringField;
    MCardsDeclarPriceUC: TFloatField;
    MCardsDeclarSebest: TFloatField;
    MInvoiceHDeclarIsLock: TSmallintField;
    MAmountsDeclarAccount: TStringField;
    MFindDeclarAccount: TStringField;
    MAmountsDeclarMatName: TXELookField;
    MaterialsLookupKodUp: TIntegerField;
    MAmounts_BUH: TLinkSource;
    MAmounts_BUHDeclar: TLinkTable;
    MAmounts_BUHDeclarMaterial: TIntegerField;
    MAmounts_BUHDeclarAccount: TStringField;
    MAmounts_BUHDeclarAmount: TFloatField;
    MAmounts_BUHDeclarPrice: TFloatField;
    MAmounts_BUHDeclarSumma: TFloatField;
    MAmounts_BUHDeclarUnitM: TSmallintField;
    MAmounts_BUHDeclarTYPE_STR: TSmallintField;
    MAmounts_BUHDeclarMaterialName: TStringField;
    MAmounts_BUHDeclarUnitMName: TXELookField;
    MAmounts_BUHC: TDBFormControl;
    MAmounts_BUHC1: TLinkMenuItem;
    MAmounts_BUHDeclarID: TIntegerField;
    MCardC: TDBFormControl;
    MCard: TLinkSource;
    MCardDeclar: TLinkTable;
    MCardDeclarInvoiceID: TIntegerField;
    MCardDeclarAmount_P: TFloatField;
    MCardDeclarAmount_R: TFloatField;
    MCardDeclarOst: TFloatField;
    MCardDeclarInvoiceTabID: TIntegerField;
    MCardDeclarDate: TDateField;
    MCardDeclarNum: TIntegerField;
    MCardDeclarInvoiceName: TXELookField;
    MCardDeclarClientName: TStringField;
    MOsnastkaC: TDBFormControl;
    MOsnastka: TLinkSource;
    MOsnastkaDeclar: TLinkTable;
    MOsnastkaDeclarKod: TIntegerField;
    MOsnastkaDeclarDate: TDateField;
    MOsnastkaDeclarAmount: TFloatField;
    MOsnastkaDeclarPriceUC: TFloatField;
    MOsnastkaDeclarPeriod: TIntegerField;
    MOsnastkaDeclarAccount: TStringField;
    MOsnastkaDeclarPercent: TFloatField;
    MOsnastkaDeclarDepot: TSmallintField;
    MOsnastkaDeclarKodName: TXELookField;
    N10: TMenuItem;
    N11: TLinkMenuItem;
    MaterialsLookupAccount: TStringField;
    MOsnastkaCur: TLinkSource;
    MOsnastkaCurC: TDBFormControl;
    MOsnastkaCurDeclar: TLinkTable;
    MOsnastkaCurDeclarKod: TIntegerField;
    MOsnastkaCurDeclarName: TStringField;
    MOsnastkaCurDeclarDate: TDateField;
    MOsnastkaCurDeclarAmount: TFloatField;
    MOsnastkaCurDeclarSumma: TFloatField;
    MOsnastkaCurDeclarPeriod: TIntegerField;
    MOsnastkaCurDeclarPercent: TFloatField;
    MOsnastkaCurDeclarDateSpis: TDateField;
    MOsnastkaCurDeclarAmountSpis: TFloatField;
    N12: TLinkMenuItem;
    MOsnastkaDeclarPriceUCName: TXELookField;
    MOsnastkaDeclarAccountName: TXELookField;
    MOsnastkaCurDeclarPriceUC: TFloatField;
    MOsnastkaDeclarsName: TStringField;
    MInvoiceT_SSDeclarPricePrev: TFloatField;
    PriceLookupAccount: TStringField;
    MDrgInvent: TLinkSource;
    MDrgInventC: TDBFormControl;
    MDrgInventDeclar: TLinkTable;
    MDrgInventDeclarAccount: TStringField;
    MDrgInventDeclarKod: TIntegerField;
    MDrgInventDeclarName: TStringField;
    MDrgInventDeclarAmount: TFloatField;
    MDrgInventDeclarShortN: TStringField;
    MDrgInventDeclarGold: TFloatField;
    MDrgInventDeclarPlatinum: TFloatField;
    MDrgInventDeclarSilver: TFloatField;
    MDrgInventDeclarRutenium: TFloatField;
    MDrgInventDeclarRodium: TFloatField;
    MDrgInventDeclarIridium: TFloatField;
    MDrgInventDeclarType_STR: TSmallintField;
    MDrgInventDeclarDepot: TIntegerField;
    MDrgInventC1: TLinkMenuItem;
    MDrgInventDeclarID: TIntegerField;
    MaterialsLookup: TLinkTable;
    N13: TMenuItem;
    MFaktura: TLinkSource;
    MFakturaC: TDBFormControl;
    MFakturaDeclar: TLinkTable;
    MFakturaDeclarID: TIntegerField;
    MFakturaDeclarNumDoc: TStringField;
    MFakturaDeclarDataDoc: TDateTimeField;
    MFakturaDeclarClient: TIntegerField;
    MFakturaDeclarDebit: TStringField;
    MFakturaDeclarKredit: TStringField;
    MFakturaDeclarDepot: TSmallintField;
    MFakturaDeclarObjZatr: TIntegerField;
    MFakturaDeclarStatRash: TIntegerField;
    MFakturaDeclarTotal: TFloatField;
    MFakturaDeclarSummaNDS: TFloatField;
    MFakturaDeclarSumma: TFloatField;
    MFakturaDeclarKomment: TStringField;
    MFakturaDeclarClientName: TXELookField;
    MFakturaDeclarDebitName: TXELookField;
    MFakturaDeclarKreditName: TXELookField;
    MFakturaDeclarDepotName: TXELookField;
    N14: TLinkMenuItem;
    N15: TMenuItem;
    MFakturaDeclarObjZatrName: TXELookField;
    MFakturaDeclarStatRashName: TXELookField;
    MFakturaT: TLinkSource;
    MFakturaTDeclar: TLinkTable;
    MFakturaTDeclarTabID: TIntegerField;
    MFakturaTDeclarID: TIntegerField;
    MFakturaTDeclarAccount: TStringField;
    MFakturaTDeclarSumma: TFloatField;
    MFakturaTDeclarAccountName: TXELookField;
    BalanceMatBegin: TLinkSource;
    BalanceMatBeginDeclar: TLinkTable;
    BalanceMatBeginDeclarClient: TIntegerField;
    BalanceMatBeginDeclarSumma: TFloatField;
    BalanceMatBeginDeclarClientName: TXELookField;
    BalanceMatBeginC: TDBFormControl;
    BalanceMatBegin1: TLinkMenuItem;
    MMotionDeclarAccount: TStringField;
    MFakturaDeclarCurrency: TSmallintField;
    MFakturaDeclarCurrencyName: TXELookField;
    MaterialsEditDeclarAddName: TStringField;
    DataSource1: TDataSource;
    dsPrih: TDataSource;
    MInvoiceTDeclarMonSpis: TFloatField;
    MMoveAccounts: TLinkSource;
    MMoveAccountsC: TDBFormControl;
    MMoveAccountsDeclar: TLinkTable;
    MMoveAccountsDeclarDebit: TStringField;
    MMoveAccountsDeclarKredit: TStringField;
    MMoveAccountsDeclarMaterial: TIntegerField;
    MMoveAccountsDeclarAmount: TFloatField;
    MMoveAccountsDeclarPriceBy: TFloatField;
    MMoveAccountsDeclarPriceUC: TFloatField;
    MMoveAccountsDeclarInvoiceID: TIntegerField;
    MMoveAccountsDeclarDateDoc: TDateField;
    MMoveAccountsDeclarOperation: TSmallintField;
    MMoveAccountsDeclarDebitName: TXELookField;
    MMoveAccountsDeclarKreditName: TXELookField;
    MMoveAccountsDeclarMaterialName: TXELookField;
    MMoveAccountsDeclarDocName: TXELookField;
    MMoveAccountsDeclarOperationName: TXELookField;
    MMoveAccountsC1: TLinkMenuItem;
    MMoveAccountsDeclarSumma: TFloatField;
    MOsnastkaDeclarPrihDocID: TIntegerField;
    MProviderOst: TLinkSource;
    MProviderOstC: TDBFormControl;
    MProviderOstDeclar: TLinkTable;
    MProviderOstDeclarClient: TIntegerField;
    MProviderOstDeclarClientName: TStringField;
    MProviderOstDeclarDebit: TFloatField;
    MProviderOstDeclarKredit: TFloatField;
    MProviderOstDeclarPeriod: TDateField;
    N16: TLinkMenuItem;
    MProviderAnalit: TLinkSource;
    MProviderAnalitDeclar: TLinkTable;
    MProviderAnalitDeclarID: TIntegerField;
    MProviderAnalitDeclarDateDoc: TDateField;
    MProviderAnalitDeclarAccount: TStringField;
    MProviderAnalitDeclarDepot: TIntegerField;
    MProviderAnalitDeclarObjZatr: TIntegerField;
    MProviderAnalitDeclarSumma: TFloatField;
    MProviderAnalitDeclarDepotName: TStringField;
    MProviderAnalitDeclarZatrname: TStringField;
    MProviderAnalitC: TDBFormControl;
    N17: TLinkMenuItem;
    MFakturaMoveAccountsC: TDBFormControl;
    MFakturaMoveAccounts: TLinkSource;
    MFakturaMoveAccountsDeclar: TLinkTable;
    MFakturaMoveAccountsDeclarDateDoc: TDateField;
    MFakturaMoveAccountsDeclarDepot: TSmallintField;
    MFakturaMoveAccountsDeclarObjZatr: TIntegerField;
    MFakturaMoveAccountsDeclarSumma: TFloatField;
    MFakturaMoveAccountsDeclarID: TIntegerField;
    MFakturaMoveAccountsDeclarDepotName: TXELookField;
    MFakturaMoveAccountsDeclarObjZatrName: TXELookField;
    MFakturaMoveAccountsDeclarDocName: TXELookField;
    MProviderAnalitDeclarKorr: TStringField;
    MSpisanieDeclarMaterialName2: TStringField;
    MSpisanieDeclarDepotName2: TStringField;
    MSpisanieDeclarZatrName: TStringField;
    MProviderCalc: TLinkSource;
    MProviderCalcDeclar: TLinkTable;
    MProviderCalcDeclarID: TIntegerField;
    MProviderCalcDeclarClient: TIntegerField;
    MProviderCalcDeclarCurrency: TIntegerField;
    MProviderCalcDeclarIDTableIn: TIntegerField;
    MProviderCalcDeclarNumDocIn: TStringField;
    MProviderCalcDeclarDateIn: TDateField;
    MProviderCalcDeclarSummaIn: TFloatField;
    MProviderCalcDeclarD10: TFloatField;
    MProviderCalcDeclarD18: TFloatField;
    MProviderCalcDeclarAccountIN: TStringField;
    MProviderCalcDeclarSummaOutAll: TFloatField;
    MProviderCalcDeclarBalanceBeg: TFloatField;
    MProviderCalcDeclarIDTableOut: TIntegerField;
    MProviderCalcDeclarNumDocOut: TStringField;
    MProviderCalcDeclarDateOut: TDateField;
    MProviderCalcDeclarAccountOut: TStringField;
    MProviderCalcDeclarSummaOut: TFloatField;
    MProviderCalcC: TDBFormControl;
    MProviderCalcC11: TLinkMenuItem;
    MProviderCalcDeclarClientName: TXELookField;
    MProviderCalcDeclarCurrencyName: TXELookField;
    MSvodProviderC: TDBFormControl;
    MSvodProvider: TLinkSource;
    MSvodProviderDeclar: TLinkTable;
    MSvodProviderDeclarID: TIntegerField;
    MSvodProviderDeclarAccount: TStringField;
    MSvodProviderDeclarOST_BEG_DEB: TFloatField;
    MSvodProviderDeclarOST_BEG_KRE: TFloatField;
    MSvodProviderDeclarMOVE_DEB: TFloatField;
    MSvodProviderDeclarMOVE_KRE: TFloatField;
    MSvodProviderDeclarOST_END_DEB: TFloatField;
    MSvodProviderDeclarOST_END_KRE: TFloatField;
    MSvodProviderDeclarType_Str: TIntegerField;
    sdfsf1: TLinkMenuItem;
    MAmounts_BUHDeclarDepot: TIntegerField;
    MAmounts_BUHDeclarDepotName: TXELookField;
    SprDepotAdv: TLinkSource;
    SprDepotAdvLookup: TLinkQuery;
    SprDepotAdvLookupKod: TSmallintField;
    SprDepotAdvLookupName: TStringField;
    MProviderOborotVat: TLinkSource;
    MProviderOborotVatC: TDBFormControl;
    MProviderOborotVatDeclar: TLinkTable;
    MProviderOborotVatDeclarID: TIntegerField;
    MProviderOborotVatDeclarClient: TIntegerField;
    MProviderOborotVatDeclarBEG_KRE: TFloatField;
    MProviderOborotVatDeclarBEG_KRE_VAT: TFloatField;
    MProviderOborotVatDeclarBEG_DEB: TFloatField;
    MProviderOborotVatDeclarMOVE_KRE: TFloatField;
    MProviderOborotVatDeclarMOVE_KRE_VAT: TFloatField;
    MProviderOborotVatDeclarMOVE_DEB: TFloatField;
    MProviderOborotVatDeclarPKP_KRE: TFloatField;
    MProviderOborotVatDeclarPKP_KRE_NDS: TFloatField;
    MProviderOborotVatDeclarEND_KRE: TFloatField;
    MProviderOborotVatDeclarEND_KRE_NDS: TFloatField;
    MProviderOborotVatDeclarEND_DEB: TFloatField;
    MProviderOborotVatDeclarClientName: TXELookField;
    MProviderOborotVatC1: TLinkMenuItem;
    MReadyMaterialStatusC: TDBFormControl;
    MReadyMaterialStatus: TLinkSource;
    MReadyMaterialStatusDeclar: TLinkTable;
    MReadyMaterialStatusDeclarID: TIntegerField;
    MReadyMaterialStatusC1: TLinkMenuItem;
    MReadyMaterialStatusDeclarString: TStringField;
    MPKPBookCalc: TLinkSource;
    MPKPBookCalcDeclar: TLinkTable;
    MPKPBookCalcDeclarID: TIntegerField;
    MPKPBookCalcDeclarClient: TIntegerField;
    MPKPBookCalcDeclarClientName: TStringField;
    MPKPBookCalcDeclarUNN: TStringField;
    MPKPBookCalcDeclarDateIn: TDateField;
    MPKPBookCalcDeclarNumDocin: TStringField;
    MPKPBookCalcDeclarDateOut: TDateField;
    MPKPBookCalcDeclarNumDocOut: TStringField;
    MPKPBookCalcDeclarTotal: TFloatField;
    MPKPBookCalcDeclarSumma_no_18: TFloatField;
    MPKPBookCalcDeclarSumma_18: TFloatField;
    MPKPBookCalcDeclarSumma_no_10: TFloatField;
    MPKPBookCalcDeclarSumma_10: TFloatField;
    MPKPBookCalcDeclarSumma_no_24: TFloatField;
    MPKPBookCalcDeclarSumma_24: TFloatField;
    MPKPBookCalcC: TDBFormControl;
    MPKPBookCalcC1: TLinkMenuItem;
    MSvodProviderDocsC: TDBFormControl;
    MSvodProviderDocs: TLinkSource;
    MSvodProviderDocsDeclar: TLinkTable;
    MSvodProviderDocsDeclarPeriod: TDateField;
    MSvodProviderDocsDeclarKorr: TStringField;
    MSvodProviderDocsDeclarOsn: TStringField;
    MSvodProviderDocsDeclarClient: TIntegerField;
    MSvodProviderDocsDeclarTableID: TSmallintField;
    MSvodProviderDocsDeclarID: TIntegerField;
    MSvodProviderDocsDeclarIDT: TIntegerField;
    MSvodProviderDocsDeclarNumDoc: TStringField;
    MSvodProviderDocsDeclarDateDoc: TDateField;
    MSvodProviderDocsDeclarClientName: TXELookField;
    MSvodProviderDocsDeclarSummaOut: TFloatField;
    MSvodProviderDocsDeclarSummaConn: TFloatField;
    MSvodProviderDocsDeclarSummaIn: TFloatField;
    MAmounts_BUHDeclarKodUp: TIntegerField;
    Costs: TLinkSource;
    CostsDeclar: TLinkTable;
    CostsDeclarKod: TIntegerField;
    CostsC: TDBFormControl;
    CostsDeclarObject: TIntegerField;
    CostsLookup: TLinkTable;
    CostsLookupKod: TIntegerField;
    CostsLookupName: TStringField;
    CostsLookupObject: TIntegerField;
    Costs1: TLinkMenuItem;
    CostsLookupAccount: TStringField;
    CostsLookupShop: TSmallintField;
    CostsDeclarAccount: TStringField;
    CostsDeclarShop: TSmallintField;
    CostsDeclarName: TStringField;
    CostsDeclarAccountName: TXELookField;
    CostsDeclarShopName: TXELookField;
    CostsDeclarObjectName: TXELookField;
    MSpisanieDeclarUnitM: TSmallintField;
    MSpisanieDeclarUnitMName: TXELookField;
    MProviderProsrochC: TDBFormControl;
    MProviderProsroch: TLinkSource;
    MProviderProsrochDeclar: TLinkTable;
    MProviderProsrochDeclarID: TIntegerField;
    MProviderProsrochDeclarColName: TStringField;
    MProviderProsrochDeclarTotal: TFloatField;
    MProviderProsrochDeclarOutDated2: TFloatField;
    MProviderProsrochDeclarOutDated3: TFloatField;
    N18: TMenuItem;
    MProviderProsrochC1: TLinkMenuItem;
    MProviderProsrochClientC: TDBFormControl;
    MProviderProsrochClient: TLinkSource;
    MProviderProsrochClientDeclar: TLinkTable;
    MProviderProsrochClientDeclarID: TIntegerField;
    MProviderProsrochClientDeclarClient: TIntegerField;
    MProviderProsrochClientDeclarClientName: TStringField;
    MProviderProsrochClientDeclarDebet: TFloatField;
    MProviderProsrochClientDeclarKredit: TFloatField;
    MProviderProsrochClientC1: TLinkMenuItem;
    N19: TMenuItem;
    MMotionDeclarMaterial: TIntegerField;
    MMotionDeclarMaterialName: TStringField;
    MFakturaDeclarSummaBy: TFloatField;
    MFakturaDeclarSummaNDSBy: TFloatField;
    MFakturaDeclarTotalBy: TFloatField;
    MFakturaTDeclarSummaBy: TFloatField;
    MMotionDeclarID: TIntegerField;
    MInvoiceTDeclarSummaCustomBy: TFloatField;
    MFakturaDeclarSummaCustomBy: TFloatField;
    MProviderCalcDeclarCourseDifference: TFloatField;
    MInvoiceVDeclarDebit: TStringField;
    MInvoiceVDeclarSummaClose: TFloatField;
    MInvoiceVDeclarTotal: TFloatField;
    MInvoiceVDeclarTotalBy: TFloatField;
    MInvoiceVDeclarSummaCustomBy: TFloatField;
    MFakturaTDeclarDepot: TSmallintField;
    MFakturaTDeclarObjZatr: TIntegerField;
    MFakturaTDeclarDepotName: TXELookField;
    MFakturaTDeclarObjZatrName: TXELookField;
    MFakturaDeclarSectionD: TSmallintField;
    MFakturaDeclarSectionK: TSmallintField;
    MFakturaDeclarSectionDName: TXELookField;
    MFakturaDeclarSectionKName: TXELookField;
    MMoveAccountsDeclarClient: TIntegerField;
    MMoveAccountsDeclarClientName: TStringField;
    MRashWorkItg: TLinkSource;
    MRashWorkItgDeclar: TLinkTable;
    MRashWorkItgC: TDBFormControl;
    MRashWorkItgDeclarDepot: TIntegerField;
    MRashWorkItgDeclarSumma: TFloatField;
    MRashWorkItgDeclarDepotName: TXELookField;
    MRashWorkItgC1: TLinkMenuItem;
    MMoveAccountsDeclarTotal: TFloatField;
    MMoveAccountsDeclarTotalBy: TFloatField;
    MMoveAccountsDeclarSummaCustomBy: TFloatField;
    MDrgOperMoveDeclarDrgOperName: TXELookField;
    MDrgOperMoveDeclarKodDepot: TIntegerField;
    MDrgOperMoveDeclarDepotName: TXELookField;
    MMoveAccountsDeclarInvoiceNum: TStringField;
    MProviderOstDeclarAccount: TStringField;
    MDrgInventDeclarPalladium: TFloatField;
    MInvoiceHDeclarsUserLock: TIntegerField;
    MProviderCalc2: TLinkSource;
    MProviderCalc2C: TDBFormControl;
    MProviderCalc2Declar: TLinkTable;
    MProviderCalc2C1: TLinkMenuItem;
    MMoveAccountsDeclarIsLock: TXEListField;
    MMoveAccountsDeclarSummaVAT: TFloatField;
    MMoveAccountsDeclarSummaVATBy: TFloatField;
    MaterialsEditDeclarDateDrg: TDateField;
    MaterialsEditDeclarCountry: TSmallintField;
    MaterialsEditDeclarCountryName: TXELookField;
    MObjZatrDeclarShop: TSmallintField;
    MObjZatrDeclarParentKOD: TIntegerField;
    MObjZatrDeclarShopName: TXELookField;
    MObjZatrDeclarParentKodName: TXELookField;
    MObjZatrDeclarisBasic: TXEListField;
    MObjZatrDeclarAccount: TStringField;
    MObjZatrDeclarAccountName: TXELookField;
    MSpisanieDeclarCountry: TSmallintField;
    MFakturaMoveAccountsDeclarOSN: TStringField;
    MFakturaMoveAccountsDeclarVSP: TStringField;
    MObjZatrDeclarKOD: TIntegerField;
    MInvoiceTDeclarSaleAdd: TFloatField;
    MInvoiceTDeclarSaleVat: TFloatField;
    MControlResDeclarDepot: TIntegerField;
    MControlResDeclarDepotName: TXELookField;
    MInvoiceHDeclarSection: TIntegerField;
    MInvoiceHDeclarDateExp: TDateField;
    MInvoiceHDeclarSectionName: TXELookField;
    MObjZatrLookupoldPrz: TSmallintField;
    MObjZatrDeclaroldPrz: TSmallintField;
    MObjZatrLookupDepot: TIntegerField;
    MMoveAccountsDeclarCountry: TSmallintField;
    MMoveAccountsDeclarCountryName: TXELookField;
    MAmounts_SpisC: TDBFormControl;
    MAmounts_Spis: TLinkSource;
    MAmounts_SpisDeclar: TLinkTable;
    MAmounts_SpisDeclarID: TIntegerField;
    MAmounts_SpisDeclarKOD: TIntegerField;
    MAmounts_SpisDeclarDT_PRIH: TDateField;
    MAmounts_SpisDeclarAMOUNT: TFloatField;
    MAmounts_SpisDeclarPRICE: TFloatField;
    MAmounts_SpisDeclarSUMMA_PRIH: TFloatField;
    MAmounts_SpisDeclarSUMMA_OST: TFloatField;
    MAmounts_SpisDeclarSUMMA_SPIS: TFloatField;
    MAmounts_SpisDeclarMON: TIntegerField;
    MAmounts_SpisDeclarMaterial: TXELookField;
    dfgdf1: TLinkMenuItem;
    MProviderCalcDeclarBalanceEnd: TFloatField;
    MDrgObVedC: TDBFormControl;
    MDrgObVed: TLinkSource;
    MDrgObVedDeclar: TLinkTable;
    MDrgObVedDeclarID: TIntegerField;
    MDrgObVedDeclarKod: TIntegerField;
    MDrgObVedDeclarNameDrg: TStringField;
    MDrgObVedDeclarAmountBeg: TFloatField;
    MDrgObVedDeclarAmountIn: TFloatField;
    MDrgObVedDeclarAmountOut: TFloatField;
    MDrgObVedDeclarAmountEnd: TFloatField;
    MDrgObVedDeclarAccount: TStringField;
    N20: TLinkMenuItem;
    MAmounts_BUHDeclarID_PRIH: TIntegerField;
    MAmounts_BUHDeclarPrihDoc: TXELookField;
    MProviderProsrochSvodC: TDBFormControl;
    MProviderProsrochSvod: TLinkSource;
    MProviderProsrochSvodDeclar: TLinkTable;
    MProviderProsrochSvodDeclarClient: TIntegerField;
    MProviderProsrochSvodDeclarName: TStringField;
    MProviderProsrochSvodDeclarSumma: TFloatField;
    MProviderProsrochSvodDeclarSummaPro: TFloatField;
    MProviderProsrochSvodDeclarSummaPro3: TFloatField;
    MProviderProsrochSvodDeclarSummaPro6: TFloatField;
    MProviderProsrochSvodDeclarSummaPro12: TFloatField;
    MProviderProsrochSvodDeclarSummaPro36: TFloatField;
    MProviderProsrochSvodC1: TLinkMenuItem;
    MShopRstPrih: TLinkSource;
    MShopRstPrihC: TDBFormControl;
    MShopRstPrihDeclar: TLinkTable;
    miShop: TMenuItem;
    MShopRstPrihC1: TLinkMenuItem;
    MShopRstPrihDeclarID: TIntegerField;
    MShopRstPrihDeclarDateDoc: TDateField;
    MShopRstPrihDeclarNumDoc: TStringField;
    MShopRstPrihDeclarSummaOtp: TFloatField;
    MShopRstPrihDeclarSummaRozn: TFloatField;
    MShopRstPrihDeclarSummaFakt: TFloatField;
    MShopRstPrihDeclarSummaOTKL: TFloatField;
    MCards_ShopC: TDBFormControl;
    MCards_Shop: TLinkSource;
    MCards_ShopDeclar: TLinkTable;
    MCards_ShopDeclarMaterial: TIntegerField;
    MCards_ShopDeclarPrice: TFloatField;
    MCards_ShopDeclarMaterialName: TStringField;
    MCards_ShopDeclarUnitM: TSmallintField;
    MCards_ShopDeclarNameM: TStringField;
    MCards_ShopDeclarAmount_BEG: TFloatField;
    MCards_ShopDeclarSumma_BEG: TFloatField;
    MCards_ShopDeclarAmount_IN: TFloatField;
    MCards_ShopDeclarSumma_IN: TFloatField;
    MCards_ShopDeclarAmount_OUT: TFloatField;
    MCards_ShopDeclarSumma_OUT: TFloatField;
    MCards_ShopDeclarAmount_END: TFloatField;
    MCards_ShopDeclarSumma_END: TFloatField;
    MCards_ShopDeclarKredit: TStringField;
    MCards_ShopDeclarTYPE_STR: TSmallintField;
    MCards_ShopDeclarPriceUC: TFloatField;
    MCards_ShopDeclarAmount_SPIS: TFloatField;
    MCards_ShopDeclarSumma_SPIS: TFloatField;
    MCards_ShopC1: TLinkMenuItem;
    MShopRstPrihDeclarInvoiceID: TIntegerField;
    MShopRstPrihDeclarDocName: TXELookField;
    MShopRstPrihDeclarTYPE_STR: TIntegerField;
    MShopRstPrihDeclarInfo: TStringField;
    MCards_Shop_BIGC: TDBFormControl;
    MCards_Shop_BIG: TLinkSource;
    MCards_Shop_BIGDeclar: TLinkTable;
    MCards_Shop_BIGDeclarMaterial: TIntegerField;
    MCards_Shop_BIGDeclarPrice: TFloatField;
    MCards_Shop_BIGDeclarMaterialName: TStringField;
    MCards_Shop_BIGDeclarUnitM: TSmallintField;
    MCards_Shop_BIGDeclarNameM: TStringField;
    MCards_Shop_BIGDeclarAmount_BEG: TFloatField;
    MCards_Shop_BIGDeclarSumma_BEG: TFloatField;
    MCards_Shop_BIGDeclarAmount_IN: TFloatField;
    MCards_Shop_BIGDeclarSumma_IN: TFloatField;
    MCards_Shop_BIGDeclarAmount_OUT: TFloatField;
    MCards_Shop_BIGDeclarSumma_OUT: TFloatField;
    MCards_Shop_BIGDeclarAmount_END: TFloatField;
    MCards_Shop_BIGDeclarSumma_END: TFloatField;
    MCards_Shop_BIGDeclarKredit: TStringField;
    MCards_Shop_BIGDeclarTYPE_STR: TSmallintField;
    MCards_Shop_BIGDeclarPriceUC: TFloatField;
    MCards_Shop_BIGDeclarAmount_SPIS: TFloatField;
    MCards_Shop_BIGDeclarSumma_SPIS: TFloatField;
    MCards_Shop_BIGDeclarAmount_BEG2: TFloatField;
    MCards_Shop_BIGDeclarSumma_BEG2: TFloatField;
    MCards_Shop_BIGDeclarAmount_IN2: TFloatField;
    MCards_Shop_BIGDeclarSumma_IN2: TFloatField;
    MCards_Shop_BIGDeclarAmount_OUT2: TFloatField;
    MCards_Shop_BIGDeclarSumma_OUT2: TFloatField;
    MCards_Shop_BIGDeclarAmount_END2: TFloatField;
    MCards_Shop_BIGDeclarSumma_END2: TFloatField;
    MCards_Shop_BIGDeclarAmount_SPIS2: TFloatField;
    MCards_Shop_BIGDeclarSumma_SPIS2: TFloatField;
    MCards_Shop_BIGDeclarPrice2: TFloatField;
    MCards_Shop_BIGC1: TLinkMenuItem;
    MSaleAdd: TLinkSource;
    MSaleAddC: TDBFormControl;
    MSaleAddC1: TLinkMenuItem;
    MSaleAddDeclar: TLinkTable;
    MSaleAddDeclarKod: TIntegerField;
    MSaleAddDeclarPriceUC: TFloatField;
    MSaleAddDeclarRATE: TFloatField;
    MSaleAddDeclarVAT: TFloatField;
    MSaleAddDeclarMaterialName: TXELookField;
    MSaleAddInvoice: TLinkSource;
    MSaleAddInvoiceC: TDBFormControl;
    MSaleAddInvoiceDeclar: TLinkTable;
    MSaleAddInvoiceDeclarKod: TIntegerField;
    MSaleAddInvoiceDeclarPriceUC: TFloatField;
    MSaleAddInvoiceDeclarRATE: TFloatField;
    MSaleAddInvoiceDeclarVAT: TFloatField;
    MSaleAddInvoiceDeclarInvoiceID: TIntegerField;
    MSaleAddInvoiceDeclarMaterialName: TXELookField;
    ppBDEPipeMInvoiceT: TppBDEPipeline;
    ppRepMInvoice: TppReport;
    ppBDEPipeMInvoiceH: TppBDEPipeline;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText3: TppDBText;
    ppLabel13: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText8: TppDBText;
    ppLine3: TppLine;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppVariable1: TppVariable;
    ppVariable2: TppVariable;
    ppDBText12: TppDBText;
    ppVariable3: TppVariable;
    ppLabel16: TppLabel;
    ppDBText13: TppDBText;
    ppLine4: TppLine;
    ppDBText14: TppDBText;
    MInvoiceHDeclarKOD_ZD: TSmallintField;
    MSaleAddInvoiceDeclarDepot: TIntegerField;
    MSaleAddDeclarDepot: TIntegerField;
    MSaleAddDeclarPriceNew: TFloatField;
    MSaleAddInvoiceDeclarPriceNew: TFloatField;
    MSaleAddDepot: TLinkSource;
    MSaleAddDepotC: TDBFormControl;
    MSaleAddDepotDeclar: TLinkTable;
    MSaleAddDepotDeclarDepot: TIntegerField;
    MSaleAddDepotDeclarRATE: TFloatField;
    MSaleAddDepotDeclarVAT: TFloatField;
    MSaleAddDepotDeclarDepotName: TXELookField;
    N21: TMenuItem;
    MSaleAddDepotC1: TLinkMenuItem;
    ppTN: TppReport;
    MInvoiceVPrint: TLinkSource;
    MInvoiceTVPrint: TLinkSource;
    MInvoiceVPrintDeclar: TLinkTable;
    MInvoiceVPrintDeclarID: TIntegerField;
    MInvoiceVPrintDeclarNumDoc: TStringField;
    MInvoiceVPrintDeclarDateDoc: TDateTimeField;
    MInvoiceVPrintDeclarNameOperation: TStringField;
    MInvoiceVPrintDeclarInvoiceNum: TStringField;
    MInvoiceVPrintDeclarSourceName: TStringField;
    MInvoiceVPrintDeclarDestName: TStringField;
    MInvoiceVPrintDeclarInfo: TStringField;
    MInvoiceTVPrintDeclar: TLinkTable;
    MInvoiceTVPrintDeclarName: TStringField;
    MInvoiceTVPrintDeclarID: TIntegerField;
    MInvoiceTVPrintDeclarInvoiceID: TIntegerField;
    MInvoiceTVPrintDeclarMaterial: TIntegerField;
    MInvoiceTVPrintDeclarOperation: TSmallintField;
    MInvoiceTVPrintDeclarRateVAT: TFloatField;
    MInvoiceTVPrintDeclarSummaVAT: TFloatField;
    MInvoiceTVPrintDeclarBID: TFloatField;
    MInvoiceTVPrintDeclarAmount: TFloatField;
    MInvoiceTVPrintDeclarPrice: TFloatField;
    MInvoiceTVPrintDeclarSummaBY: TFloatField;
    MInvoiceTVPrintDeclarPriceBy: TFloatField;
    MInvoiceTVPrintDeclarSummaBID: TFloatField;
    MInvoiceTVPrintDeclarSumma: TFloatField;
    MInvoiceTVPrintDeclarDocAmount: TFloatField;
    MInvoiceTVPrintDeclarSummaVatBy: TFloatField;
    MInvoiceTVPrintDeclarSummaBIDBy: TFloatField;
    MInvoiceTVPrintDeclarTotal: TFloatField;
    MInvoiceTVPrintDeclarTotalBy: TFloatField;
    MInvoiceTVPrintDeclarDebit: TStringField;
    MInvoiceTVPrintDeclarKredit: TStringField;
    MInvoiceTVPrintDeclarDateDoc: TDateTimeField;
    MInvoiceTVPrintDeclarSummaOTKL: TFloatField;
    MInvoiceTVPrintDeclarSummaOTKLBy: TFloatField;
    MInvoiceTVPrintDeclarContract: TStringField;
    MInvoiceTVPrintDeclarPrice_no_BID: TFloatField;
    MInvoiceTVPrintDeclarPrice_no_Round: TFloatField;
    MInvoiceTVPrintDeclarSummaOTKL2: TFloatField;
    MInvoiceTVPrintDeclarSummaOTKL2By: TFloatField;
    MInvoiceTVPrintDeclarsUserIns: TIntegerField;
    MInvoiceTVPrintDeclarsDateIns: TDateTimeField;
    MInvoiceTVPrintDeclarsUserUpd: TIntegerField;
    MInvoiceTVPrintDeclarsDateUpd: TDateTimeField;
    MInvoiceTVPrintDeclarPriceUC: TFloatField;
    MInvoiceTVPrintDeclarKodDrgOper: TSmallintField;
    MInvoiceTVPrintDeclarSummaClose: TFloatField;
    MInvoiceTVPrintDeclarMonSpis: TFloatField;
    MInvoiceTVPrintDeclarSummaCustomBy: TFloatField;
    MInvoiceTVPrintDeclarSaleAdd: TFloatField;
    MInvoiceTVPrintDeclarSaleVat: TFloatField;
    ppMInvoiceVPrint: TppBDEPipeline;
    ppMInvoiceTVPrint: TppBDEPipeline;
    MInvoiceTVPrintDeclarShortN: TStringField;
    MInvoiceVPrintDeclarSummaVAT: TFloatField;
    MInvoiceVPrintDeclarTotals: TFloatField;
    MInvoiceVPrintDeclarAmount: TFloatField;
    MInvoiceVPrintDeclarSummaVATPro: TStringField;
    MInvoiceVPrintDeclarTotalsPro: TStringField;
    MInvoiceVPrintDeclarAmountPro: TStringField;
    MInvoiceTVPrintDeclarVAT: TFloatField;
    UniformVC: TDBFormControl;
    UniformV: TLinkSource;
    UniformVDeclar: TLinkTable;
    UniformVDeclarWorker: TIntegerField;
    UniformVDeclarMaterial: TIntegerField;
    UniformVDeclarDateBeg: TDateField;
    UniformVDeclarDateEnd: TDateField;
    UniformVDeclarMaterialsName: TXELookField;
    UniformVDeclarWorkerName: TXELookField;
    UniformCC: TMenuItem;
    UniformVC1: TLinkMenuItem;
    UniformVDeclarsUser: TIntegerField;
    MaterialsUniform: TLinkQuery;
    MaterialsUniformKod: TIntegerField;
    MaterialsUniformname: TStringField;
    UniformProfC: TDBFormControl;
    UniformProf: TLinkSource;
    UniformProfDeclar: TLinkTable;
    UniformProfDeclarProf: TIntegerField;
    UniformProfDeclarMaterial: TIntegerField;
    UniformProfDeclarMonth: TIntegerField;
    UniformProfDeclarMaterialName: TXELookField;
    UniformProfDeclarProfName: TXELookField;
    UniformProfC1: TLinkMenuItem;
    UniformProfDeclarSection: TIntegerField;
    UniformProfDeclarSectionName: TXELookField;
    UniformProfAnalog: TLinkSource;
    UniformProfAnalogC: TDBFormControl;
    UniformProfAnalogDeclar: TLinkTable;
    UniformProfAnalogDeclarID: TIntegerField;
    UniformProfAnalogDeclarUniformProfID: TIntegerField;
    UniformProfAnalogDeclarMaterial: TIntegerField;
    UniformProfAnalogDeclarMonth: TIntegerField;
    UniformProfAnalogDeclarGroup: TIntegerField;
    UniformProfAnalogDeclarMaterialName: TXELookField;
    MaterialsUniformGroup: TLinkQuery;
    MaterialsUniformGroupKod: TIntegerField;
    MaterialsUniformGroupname: TStringField;
    UniformProfDeclarDuty: TXEListField;
    MMotionDeclarSectionCustomer: TIntegerField;
    MMotionDeclarDateExp: TDateField;
    MMotionDeclarSectionCustomerName: TXELookField;
    UniformProfAnalogJob: TLinkSource;
    UniformProfAnalogJobC: TDBFormControl;
    UniformProfAnalogJobDeclar: TLinkTable;
    UniformProfAnalogJobDeclarID: TIntegerField;
    UniformProfAnalogJobDeclarSection: TIntegerField;
    UniformProfAnalogJobDeclarProf: TIntegerField;
    UniformProfAnalogJobDeclarSectionAnalog: TIntegerField;
    UniformProfAnalogJobDeclarProfAnalog: TIntegerField;
    UniformProfAnalogJobDeclarSectionName: TXELookField;
    UniformProfAnalogJobDeclarSectionAnalogName: TXELookField;
    UniformProfAnalogJobDeclarProfName: TXELookField;
    UniformProfAnalogJobDeclarProfAnalogName: TXELookField;
    Uniform: TLinkSource;
    UniformC: TDBFormControl;
    UniformDeclar: TLinkTable;
    UniformDeclarID: TIntegerField;
    UniformDeclarWorker: TIntegerField;
    UniformDeclarMaterial: TIntegerField;
    UniformDeclarDateBeg: TDateField;
    UniformDeclarDateEnd: TDateField;
    UniformDeclarsUser: TIntegerField;
    UniformVDeclarDuty: TXEListField;
    UniformDeclarMaterialName: TXELookField;
    N22: TMenuItem;
    Uniform1: TLinkMenuItem;
    DataSource2: TDataSource;
    UniformDeclarDuty: TXEListField;
    MAmounts_BUHDeclarPriceUC: TFloatField;
    MSaleAddCheck: TLinkSource;
    MSaleAddCheckC: TDBFormControl;
    MSaleAddCheckDeclar: TLinkTable;
    MSaleAddCheckDeclarDepot: TSmallintField;
    MSaleAddCheckDeclarAccount: TStringField;
    MSaleAddCheckDeclarInvoiceID: TIntegerField;
    MSaleAddCheckDeclarMaterial: TIntegerField;
    MSaleAddCheckDeclarPriceUC: TFloatField;
    MSaleAddCheckDeclarPrice_no_BID: TFloatField;
    MSaleAddCheckDeclarInvoiceBID: TFloatField;
    MSaleAddCheckDeclarInvoiceVAT: TFloatField;
    MSaleAddCheckDeclarMustBID: TFloatField;
    MSaleAddCheckDeclarMustVAT: TFloatField;
    MSaleAddCheckDeclarInvoiceName: TXELookField;
    MSaleAddCheckDeclarMaterialName: TXELookField;
    MSaleAddCheckDeclarDateDoc: TDateTimeField;
    N23: TLinkMenuItem;
    UniformProfWorker: TLinkSource;
    MShopRstPrihDeclarClient: TIntegerField;
    MShopRstPrihDeclarClientName: TStringField;
    UniformProfWorkerDeclar: TLinkTable;
    UniformProfWorkerDeclarID: TIntegerField;
    UniformProfWorkerDeclarUniformProfID: TIntegerField;
    UniformProfWorkerDeclarNum: TStringField;
    UniformProfWorkerDeclarMaterial: TIntegerField;
    UniformProfWorkerDeclarMonth: TIntegerField;
    UniformProfWorkerDeclarAnalog: TSmallintField;
    UniformProfWorkerDeclarGroupID: TSmallintField;
    UniformProfWorkerDeclarMaterialName: TXELookField;
    UniformProfWorkerDeclarDuty: TXEListField;
    UniformReport: TLinkSource;
    UniformReportC: TDBFormControl;
    UniformReportDeclar: TLinkTable;
    UniformReportDeclarID: TIntegerField;
    UniformReportDeclarMessage: TStringField;
    UniformReportDeclarRate: TSmallintField;
    N24: TMenuItem;
    UniformReportC1: TLinkMenuItem;
    UniformDeclarBroken: TXEListField;
    MaterialsEditLookupCalcUniform: TLinkTable;
    MaterialsEditLookupCalcUniformKod: TIntegerField;
    MaterialsEditLookupCalcUniformPrice: TFloatField;
    MaterialsEditLookupCalcUniformDepot: TSmallintField;
    MaterialsEditLookupCalcUniformName: TStringField;
    MaterialsEditLookupCalcUniformInvNumber: TIntegerField;
    MaterialsEditLookupCalcUniformAccount: TStringField;
    MaterialsEditLookupCalcUniformAmount: TFloatField;
    MaterialsEditLookupCalcUniformUnitMName: TStringField;
    MaterialsEditLookupCalcUniformKodUp: TIntegerField;
    MaterialsEditLookupCalcUniformPriceUC: TFloatField;
    MaterialsEditLookupCalcUniformGold: TFloatField;
    MaterialsEditLookupCalcUniformPlatinum: TFloatField;
    MaterialsEditLookupCalcUniformSilver: TFloatField;
    MaterialsEditLookupCalcUniformPalladium: TFloatField;
    MaterialsEditLookupCalcUniformRutenium: TFloatField;
    MaterialsEditLookupCalcUniformRodium: TFloatField;
    MaterialsEditLookupCalcUniformIridium: TFloatField;
    UniformVDeclarID: TAutoIncField;
    UniformProfDeclarID: TAutoIncField;
    UniformReportCheckSectionC: TDBFormControl;
    UniformReportCheckSection: TLinkSource;
    UniformReportCheckSectionDeclar: TLinkTable;
    UniformReportCheckSectionDeclarID: TIntegerField;
    UniformReportCheckSectionDeclarMessage: TStringField;
    UniformReportCheckSectionDeclarRate: TSmallintField;
    Ghjdth1: TLinkMenuItem;
    SprSectionSource: TDataSource;
    MInvoiceTVPrintDeclarPrice_no_BID2: TFloatField;
    MInvoiceTVPrintDeclarSummaBY2: TFloatField;
    MInvoiceTVPrintDeclarSummaVATBY2: TFloatField;
    MInvoiceTVPrintDeclarTotalBy2: TFloatField;
    MInvoiceTVPrintDeclarSummaVatPRO2: TStringField;
    MInvoiceTVPrintDeclarTotalsPro2: TStringField;
    ppTitleBand1: TppTitleBand;
    ppShape15: TppShape;
    ppShape14: TppShape;
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
    ppDBText15: TppDBText;
    ppLabel366: TppLabel;
    EtvPpDBText157: TEtvPpDBText;
    EtvPpDBText161: TEtvPpDBText;
    ppLabelTTN1: TppLabel;
    ppLabelCopy1: TppLabel;
    EtvPpDBText138: TEtvPpDBText;
    EtvPpDBText139: TEtvPpDBText;
    EtvPpDBText142: TEtvPpDBText;
    EtvPpDBText143: TEtvPpDBText;
    EtvPpDBText144: TEtvPpDBText;
    EtvPpDBText145: TEtvPpDBText;
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
    ppLine246: TppLine;
    ppLine247: TppLine;
    ppLine248: TppLine;
    ppLine249: TppLine;
    ppLine250: TppLine;
    ppLine251: TppLine;
    ppLine252: TppLine;
    ppLine253: TppLine;
    ppLine261: TppLine;
    ppLine262: TppLine;
    ppLine263: TppLine;
    ppGroup5: TppGroup;
    ppGroupHeaderBand5: TppGroupHeaderBand;
    ppGroupFooterBand5: TppGroupFooterBand;
    ppLine323: TppLine;
    ppLine324: TppLine;
    ppLine325: TppLine;
    ppLine326: TppLine;
    ppLine327: TppLine;
    ppLine328: TppLine;
    ppDBCalc15: TppDBCalc;
    ppLine330: TppLine;
    ppLine331: TppLine;
    ppDBCalc16: TppDBCalc;
    ppLine332: TppLine;
    ppDBCalc17: TppDBCalc;
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
    ppLine274: TppLine;
    ppLine275: TppLine;
    ppLabel203: TppLabel;
    EtvPpDBText75: TEtvPpDBText;
    EtvPpDBText83: TEtvPpDBText;
    ppLine5: TppLine;
    DepotWorker: TLinkSource;
    DepotWorkerDeclar: TLinkTable;
    DepotWorkerDeclarKod: TIntegerField;
    DepotWorkerDeclarName: TStringField;
    DepotWorkerDeclarAccount: TStringField;
    UniformForChange: TLinkSource;
    UniformForChangeC: TDBFormControl;
    UniformForChangeDeclar: TLinkTable;
    UniformForChangeDeclarID: TIntegerField;
    UniformForChangeDeclarWorker: TIntegerField;
    UniformForChangeDeclarMaterial: TIntegerField;
    UniformForChangeDeclarDateChange: TDateField;
    UniformForChangeDeclarWorkerName: TXELookField;
    UniformForChangeDeclarMaterialName: TXELookField;
    UniformForChangeC1: TLinkMenuItem;
    UniformDeclarInvoiceID: TIntegerField;
    UniformDeclarInvoiceTIDSpis: TIntegerField;
    UniformDeclarInvoiceName: TXELookField;
    MProviderDecodeC: TDBFormControl;
    MProviderDecode: TLinkSource;
    MProviderDecodeDeclar: TLinkTable;
    MProviderDecodeC1: TLinkMenuItem;
    UniformProfDeclarProfit: TXEListField;
    procedure MaterialsEditDeclarAfterPost(DataSet: TDataSet);
    procedure MaterialsEditDeclarBeforeDelete(DataSet: TDataSet);
    procedure MaterialsEditDeclarAfterDelete(DataSet: TDataSet);
    procedure MInvoiceHDeclarNewRecord(DataSet: TDataSet);
    procedure MInvoiceTDeclarNewRecord(DataSet: TDataSet);
    procedure MInvoiceTDeclarRateVATChange(Sender: TField);
    procedure MInvoiceTDeclarAmountChange(Sender: TField);
    procedure MInvoiceTDeclarBIDChange(Sender: TField);
    procedure MaterialsEditDeclarNewRecord(DataSet: TDataSet);
    procedure MdMatCreate(Sender: TObject);
    procedure MInvoiceHDeclarOperationChange(Sender: TField);
    procedure MInvoiceTDeclarSummaChange(Sender: TField);
    procedure MaterialsViewDeclarNewRecord(DataSet: TDataSet);
    procedure MaterialsViewDeclarAfterScroll(DataSet: TDataSet);
    procedure N1Click(Sender: TObject);
    procedure MaterialsEditDeclarCalcFields(DataSet: TDataSet);
    procedure GetPrices(DataSet: TDataSet);
    procedure GetPricesOsnastka(DataSet: TDataSet);
    function MInvoiceTDeclarPriceNameFilter(Sender: TObject): String;
    procedure MInvoiceTDeclarBeforePost(DataSet: TDataSet);
    procedure MInvoiceTDeclarPriceChange(Sender: TField);
    procedure MInvoiceTDeclarMaterialChange(Sender: TField);
    procedure MInvoiceTDeclarBeforeDelete(DataSet: TDataSet);
    procedure MInvoiceT_RestoreDeclarNewRecord(DataSet: TDataSet);
    procedure MInvoiceHDeclarCurrencyChange(Sender: TField);
    procedure MInvoiceHDeclarBeforeDelete(DataSet: TDataSet);
    procedure MaterialsEditDeclarBeforePost(DataSet: TDataSet);
    procedure MInvoiceHDataChange(Sender: TObject; Field: TField);
    procedure MAmountsVCCreateForm(Sender: TObject);
    procedure MInvoiceHDeclarAfterCancel(DataSet: TDataSet);
    procedure MInvoiceHDeclarBeforePost(DataSet: TDataSet);
    procedure MInvoiceHDeclarAfterPost(DataSet: TDataSet);
    procedure MInvoiceHDeclarBeforeEdit(DataSet: TDataSet);
    procedure MAmountsCCreateForm(Sender: TObject);
    procedure CalcMAmountsClick(Sender: TObject);
    procedure CalcMAmountsClick_Spis(Sender: TObject);
    procedure CalcMDrgInventClick(Sender: TObject);
    procedure CalcMOsnastkaCurClick(Sender: TObject);
    procedure CalcMOsnastkaCurClickDoc(Sender: TObject);
    procedure CalcMOsnastkaCurClickDel(Sender: TObject);
    procedure CalcMAmounts2Click(Sender: TObject);
    procedure CalcUniformSectionClick(Sender: TObject);
    procedure CalcMAmounts_BUHClick(Sender: TObject);
    procedure BtnUniformForChangeClick(Sender: TObject);
    procedure CalcMAmounts_BUH2Click(Sender: TObject);
    procedure CalcMAmounts_BUH3Click(Sender: TObject);
    procedure CalcMCardsClick(Sender: TObject);
    procedure CalcUniformProfClick(Sender: TObject);
    procedure CalcUniformProfJClick(Sender: TObject);
    procedure CalcMCardsSClick(Sender: TObject);
    procedure CalcMCards2Click(Sender: TObject);
    procedure CalcMCards2SClick(Sender: TObject);
    procedure CalcMCardsSBClick(Sender: TObject);
    procedure CalcMCards2SBClick(Sender: TObject);
    procedure CalcMOborotMatClick(Sender: TObject);
    procedure CalcMProviderCalcClick(Sender: TObject);
    procedure CalcMDrgObVedClick(Sender: TObject);
    procedure CalcMProviderCalc2Click(Sender: TObject);
    procedure CalcMProviderCalc3Click(Sender: TObject);
    procedure CalcMSvodMoveClick(Sender: TObject);
    procedure CalcMSvodProviderClick(Sender: TObject);
    procedure CalcMSvodProviderClick2(Sender: TObject);
    procedure CalcMProviderAnalitClick(Sender: TObject);
    procedure CalcMShopRstPrihClick(Sender: TObject);
    procedure CalcUniformReportClick(Sender: TObject);
    procedure CalcMSaleAddClick(Sender: TObject);
    procedure CalcMProviderAnalitClick2(Sender: TObject);
    procedure CalcMMoveMatClick(Sender: TObject);
    procedure MODecodeBtnClick(Sender: TObject);
    procedure CalcMostNmoveClick(Sender: TObject);
    procedure CalcMControlResClick(Sender: TObject);
    procedure CalcMFindClick(Sender: TObject);
    procedure CalcMFindClick2(Sender: TObject);
    procedure CalcMRashWorkClick(Sender: TObject);
    procedure CalcMRashWorkClickItg(Sender: TObject);
    procedure CalcMRashWorkClick2(Sender: TObject);
    procedure CalcMRashWorkClick3(Sender: TObject);
    procedure CalcMAmountsGroup(Sender: TObject);
    procedure CalcMDrgOperMove(Sender: TObject);
    procedure CalcMInvoiceIDsByAccountClick(Sender: TObject);
    procedure CalcMInvoice_SSCheckClick(Sender: TObject);
    procedure MaterialsViewDeclarAfterPost(DataSet: TDataSet);
    procedure MaterialsViewDeclarAfterDelete(DataSet: TDataSet);
    procedure MaterialsViewDeclarBeforeDelete(DataSet: TDataSet);
    procedure MaterialsViewDeclarAfterCancel(DataSet: TDataSet);
    procedure MOunt(Sender: TObject);
    procedure MInvoiceTDeclarAfterInsert(DataSet: TDataSet);
    procedure MInvoiceHDeclarDateDocChange(Sender: TField);
    procedure MInvoiceTDeclarTotalChange(Sender: TField);
    procedure MRashWorkCCreateForm(Sender: TObject);
    procedure MasterChange(DataSet:TDataSet);
    procedure MInvoiceCCreateForm(Sender: TObject);
    procedure OnSourceDepotChange(Sender: TObject);
    procedure MInvoiceHDeclarBeforeOpen(DataSet: TDataSet);
    procedure MostNmoveCCreateForm(Sender: TObject);
    procedure MControlResCCreateForm(Sender: TObject);
    procedure MFindCCreateForm(Sender: TObject);
    procedure MSvodMoveCCreateForm(Sender: TObject);
    procedure MMoveMat_PrihCCreateForm(Sender: TObject);
    procedure MInvoiceHDeclarAfterScroll(DataSet: TDataSet);
    procedure MInvoiceHDeclarDestDepotChange(Sender: TField);
    procedure MInvoiceTDeclarDebitChange(Sender: TField);
    procedure MInvoiceT_SSDeclarSTVChange(Sender: TField);
    procedure MInvoiceTDeclarAfterPost(DataSet: TDataSet);
    procedure MInvoiceHDeclarCalcFields(DataSet: TDataSet);
    procedure MInvoiceT_SSDeclarBeforeEdit(DataSet: TDataSet);
    procedure MInvoiceT_SSDeclarAfterCancel(DataSet: TDataSet);
    procedure MInvoiceT_SSDeclarBeforeDelete(DataSet: TDataSet);
    procedure MInvoiceT_SSDeclarAfterEdit(DataSet: TDataSet);
    procedure MInvoiceTDeclarBeforeEdit(DataSet: TDataSet);
    procedure MInvoice_SSCheckCCreateForm(Sender: TObject);
    procedure MOborotMatCCreateForm(Sender: TObject);
    procedure MAmountsGroupCCreateForm(Sender: TObject);
    procedure MInvoiceIDsByAccountCCreateForm(Sender: TObject);
    procedure MMotionCCreateForm(Sender: TObject);
    procedure MMotionCActivateForm(Sender: TObject);
    procedure MInvoiceCCloseForm(Sender: TObject;
      var Action: TCloseAction);
    procedure MInvoiceCActivateForm(Sender: TObject);
    procedure MDrgOperMoveCCreateForm(Sender: TObject);
    procedure MaterialsCCreateForm(Sender: TObject);
    procedure MSpisanieCCreateForm(Sender: TObject);
    procedure MAmounts_BUHCCreateForm(Sender: TObject);
    procedure MInvoiceTDeclarAfterOpen(DataSet: TDataSet);
    procedure MInvoiceHDeclarAfterOpen(DataSet: TDataSet);
    procedure MCardC1Click(Sender: TObject);
    procedure CalcMCardIntClick(Sender: TObject);
    procedure MCardCCreateForm(Sender: TObject);
    procedure MCardCDestroyForm(Sender: TObject);
    procedure MOsnastkaCCreateForm(Sender: TObject);
    procedure MOsnastkaDeclarNewRecord(DataSet: TDataSet);
    procedure MOsnastkaDeclarKodChange(Sender: TField);
    function MOsnastkaDeclarKodNameFilter(Sender: TObject): String;
    function MInvoiceHDeclarOperationNameFilter(Sender: TObject): String;
    function MOsnastkaDeclarPriceUCNameFilter(Sender: TObject): String;
    procedure MOsnastkaCurCCreateForm(Sender: TObject);
    procedure MDrgInventCCreateForm(Sender: TObject);
    procedure MFakturaCCreateForm(Sender: TObject);
    procedure MFakturaDeclarAfterScroll(DataSet: TDataSet);
    procedure MFakturaDeclarBeforePost(DataSet: TDataSet);
    procedure MFakturaDeclarTotalChange(Sender: TField);
    procedure MFakturaDeclarNewRecord(DataSet: TDataSet);
    procedure MFakturaDeclarAfterOpen(DataSet: TDataSet);
    procedure MFakturaTDeclarNewRecord(DataSet: TDataSet);
    procedure MFakturaTDeclarAfterPost(DataSet: TDataSet);
    procedure MFakturaDeclarSummaChange(Sender: TField);
    procedure MInvoiceTDataChange(Sender: TObject; Field: TField);
    procedure MInvoiceTDeclarAfterScroll(DataSet: TDataSet);
    procedure MMoveMat_PrihDeclarBeforeOpen(DataSet: TDataSet);
    procedure MMoveMat_PrihCDestroyForm(Sender: TObject);
    procedure MProviderOstCCreateForm(Sender: TObject);
    procedure MMoveAccountsCCreateForm(Sender: TObject);
    procedure MProviderAnalitCCreateForm(Sender: TObject);
    procedure MProviderCalcCCreateForm(Sender: TObject);
    procedure CalcMProviderOborotVATClick(Sender: TObject);
    procedure CalcMProviderProsrochClick(Sender: TObject);
    procedure CalcMProviderProsrochClientClick(Sender: TObject);
    procedure CalcMProviderProsrochSvodClick(Sender: TObject);
    procedure CalcMReadyMaterialStatus(Sender: TObject);
    procedure CalcMPKPBookCalc(Sender: TObject);
    procedure MSvodProviderCCreateForm(Sender: TObject);
    procedure MProviderOborotVatCCreateForm(Sender: TObject);
    procedure MReadyMaterialStatusCCreateForm(Sender: TObject);
    procedure MPKPBookCalcCCreateForm(Sender: TObject);
    procedure MProviderProsrochCCreateForm(Sender: TObject);
    procedure MProviderProsrochClientCCreateForm(Sender: TObject);
    procedure MFakturaDeclarCurrencyChange(Sender: TField);
    procedure MFakturaCActivateForm(Sender: TObject);
    procedure MFakturaTDeclarSummaChange(Sender: TField);
    procedure GridDblClick(Sender: TObject);
    procedure MInvoiceVCCreateForm(Sender: TObject);
    procedure MInvoiceHDeclarInfoChange(Sender: TField);
    procedure MRashWorkItgCCreateForm(Sender: TObject);
    procedure MProviderCalc2DeclarBeforeOpen(DataSet: TDataSet);
    procedure MProviderCalc2CCreateForm(Sender: TObject);
    procedure MProviderCalc2CDestroyForm(Sender: TObject);
    procedure MFakturaDeclarAfterPost(DataSet: TDataSet);
    procedure MObjZatrDeclarBeforeInsert(DataSet: TDataSet);
    function MInvoiceHDeclarSectionNameFilter(Sender: TObject): String;
    function MInvoiceHDeclarObjZatrNameFilter(Sender: TObject): String;
    procedure MAmounts_SpisCCreateForm(Sender: TObject);
    procedure MInvoiceT_SSDeclarNewRecord(DataSet: TDataSet);
    procedure MDrgObVedCCreateForm(Sender: TObject);
    procedure MProviderProsrochSvodCCreateForm(Sender: TObject);
    procedure MInvoiceTDeclarContractChange(Sender: TField);
    procedure MShopRstPrihCCreateForm(Sender: TObject);
    procedure MCards_ShopCCreateForm(Sender: TObject);
    procedure OnUniformWorkerChoice(Sender: TObject);
    procedure OnUniformWorkerKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MCards_Shop_BIGCCreateForm(Sender: TObject);
    procedure MInvoiceTDeclarPriceUCChange(Sender: TField);
    procedure MSaleAddCCreateForm(Sender: TObject);
    procedure ppVariable1Calc(Sender: TObject; var Value: Variant);
    procedure ppVariable2Calc(Sender: TObject; var Value: Variant);
    procedure ppVariable3Calc(Sender: TObject; var Value: Variant);
    function MInvoiceHDeclarSourceDepotNameFilter(Sender: TObject): String;
    function MInvoiceTDeclarMaterialNameFilter(Sender: TObject): String;
    procedure MSaleAddDeclarCalcFields(DataSet: TDataSet);
    procedure MInvoiceVPrintDeclarCalcFields(DataSet: TDataSet);
    procedure MInvoiceTVPrintDeclarCalcFields(DataSet: TDataSet);
    procedure UniformVDeclarBeforeOpen(DataSet: TDataSet);
    procedure UniformVDeclarAfterPost(DataSet: TDataSet);
    procedure UniformVDeclarDateBegSetText(Sender: TField;
      const Text: String);
    procedure UniformProfDeclarAfterPost(DataSet: TDataSet);
    procedure UniformProfCCreateForm(Sender: TObject);
    procedure UniformProfAnalogDeclarNewRecord(DataSet: TDataSet);
    procedure UniformVCCreateForm(Sender: TObject);
    procedure UniformCCreateForm(Sender: TObject);
    procedure UniformCActivateForm(Sender: TObject);
    procedure UniformDeclarNewRecord(DataSet: TDataSet);
    procedure UniformReportCCreateForm(Sender: TObject);
    procedure UniformDeclarBeforeOpen(DataSet: TDataSet);
    procedure UniformProfAnalogJobCCreateForm(Sender: TObject);
    procedure UniformReportCheckSectionCCreateForm(Sender: TObject);
    procedure UniformForChangeCCreateForm(Sender: TObject);
    procedure MProviderDecodeDeclarBeforeOpen(DataSet: TDataSet);
    procedure MProviderDecodeCDestroyForm(Sender: TObject);
    procedure MProviderDecodeCCreateForm(Sender: TObject);
  private
    { Private declarations }
    NodeID:Variant;
    NewRecord:Boolean;
    MKodUp:Variant;
    FDefaultShop: integer;
    FDefaultAccount: string;
    BOX:TFormSelect;
    GlobalCourse: Currency;
    Course:Currency;
    LastMatName:string;
    LastUnitM: integer;
    LastCountry: integer;
    LastSection: integer;
    LastAccount: string;
    DeleteNode: TTreeNode;
    Changing: boolean;
    ComboUniform: TXEDBInplaceLookUpCombo;
    procedure UniformUpdateLookupCombo(Sender: TColumn; Field: TField);
    procedure UniformComboOnCloseUp(Sender: TObject);
    procedure DrawCellAmount(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMCard(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMotion(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellSpisanie(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMSvodMove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMMove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMostNmove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMControlRes(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure RefreshTree(DataSet: TDataSet; LocateNew: Boolean = True);
    procedure FindNewNumDoc;
    function FirstDayOfMonth(ADate: TDateTime): TDateTime;
    function RoundA(ANumber: extended; isNotRound: boolean = false): extended;
    function Round10(ANumber: extended; Round10: boolean = false): extended;
    function Round50(ANumber: extended): extended;
    procedure LocalCalcTotals(DataSet: TDataSet);
    procedure RecalcAllRoznica(Sender: TObject);
    procedure RecalcAll(Sender: TObject);
    function GetOperNum(Sender: TObject; MayBeSevenIfShop: boolean = false): integer;
    procedure MGridTitleClick(Column:TColumn);
    function FindMaterialsFirstPriceForRash(Material: extended; Depot: integer; var PriceUC: Double; var Account: string): extended;
    Function MaterialNameFilter(Sender: TObject): string;
    procedure OnDblClickCheck_SS(Sender: TObject);
    procedure CheckDrgOper;
    procedure OnMOsnastkaChange(Sender: TObject);
    procedure AssignAccounts;
    procedure RecalcFakturaSum;
    procedure DrawDataInvoice;
    function GetAccountByUser:string;
    procedure DrawUniformCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
    procedure DrawMShopRstPrihCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
    procedure DrawUniformNewCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
    procedure GetSaleRateAndVATShop(Kod: integer; PriceUC: Extended; Account: string; Depot: integer; var Rate: Extended; var VAT: Extended);
  public
    { Public declarations }
    WorkDate :TDateTime;
    CloseDate :TDateTime;
    function GetDefaultAccount: string;
    function GetDefaultDepot: integer;
    function LockBuhValue: integer;
    function WhosLock: integer;
    function IsShop: integer;
    function GetFirstDayOfMonth(date: TDateTime): TDateTime;
    function GetLastDayOfMonth(date: TDateTime): TDateTime;
//    GlobalSourceDepot : integer;
    procedure ShowFields(ColumnList:TColumnList; AddFields: boolean; SortOrderIndex: integer=0);
    procedure DrawInputFields(ColumnList:TColumnList);
    procedure SortInputFields(index: integer);
    procedure ChangeMaterialLookup(isRashod: boolean = False);
//    procedure DoCalcOst(IsDelete: boolean; DataSet: TDataSet);
    function CheckRashod: boolean;
    procedure ShowDrgWindow;
    procedure OpenDokHistory(ADeclar:TLinkTable; AMaterial, APriceUc: extended; ADepot: integer;
              DepotFieldName: string = 'DEPOT';
              PriceFieldName: string = 'PRICEUC';
              MaterialFieldName: string = 'MATERIAL');
    procedure ShowServiceInfo;
    procedure ShowMCard(AMaterial: extended; ADepot: integer; APriceUC: extended;
                        Adt_from, Adt_to: TDateTime; AAccount: string; APrice: extended);
    procedure AssignColumns(DataSet: TDataSet;aForm:TBEForm; isVisible: boolean = True);
    procedure MFakturaDataChange(Sender: TObject; Field: TField);{ TDataChangeEvent;}
    function LookupAccountFilter(Sender: TObject): String;
    procedure PrintMInvoiceDoc;
  end;

var mdMat: TmdMat;
    ReportMProviderCalc0000: TXEDBLookupCombo;
    DepotList: TStringList;
    FieldListNames: array [0..28] of string=
    ('MaterialName',  // 0
     'Amount',        // 1
     'DocAmount',     // 2
     'Price_no_BID',  // 3
     'BID',           // 4
     'SummaBID',      // 5
     'SummaBIDBy',    // 6
     'PriceName',     // 7
     'PriceNameBy',   // 8
     'Summa',         // 9
     'SummaBy',       // 10
     'SummaOTKL',     // 11
     'SummaOTKLBy',   // 12
     'RateVAT',       // 13
     'SummaVAT',      // 14
     'SummaVatBy',    // 15
     'SummaOTKL2',    // 16
     'SummaOTKL2By',  // 17
     'Total',         // 18
     'TotalBy',       // 19
     'Contract',      // 20
     'DebitName',     // 21
     'KreditName',    // 22
     'DrgOperName',   // 23
     'MonSpis',       // 24
     'SummaCustomBy', // 25
     'SaleAdd',       // 26
     'SaleVat',       // 27
     'PriceUC'       // 28
     );
    TempQuery: TQuery;

implementation
uses Buttons, ToolEdit, Materials, MdBase, MdCommon,MdGeography,MdOrgs, MInvoice, EtvDBFun, EtvBor, DBCommon, MFaktura, EtvRus,
     XDBMisc, Misc, StdCtrls, MdInvc, MdContr, RxSpin, MInvoiceCheckSS, MInvoiceDragInfo, EtvFilt, EtvMem, MServiceUnit, mdWorkers,
  MdClientsAdd;
{$R *.DFM}
Const TotalList:string='_Amount_Summa_SummaBy_SummaVAT_SummaVatBy_SummaBID_SummaBIDBy_Total_TotalBy_SummaCustomBy_';
    NDS_def = 0.2;
var BtnCalcMAmounts: TBitBtn;
    BtnUniformForChange: TBitBtn;
    BtnUniformSection: TBitBtn;
    BtnCalcMAmounts_Spis: TBitBtn;
    ChbxMRashWork: TCheckBox;
    ChbxMReadyMat: TCheckBox;
    ChkBoxMCardsShop: TCheckBox;
//    ChbxMCards: TCheckBox;
    BtnCalcMCards000: TBitBtn;
    BtnCalcMCardsS: TBitBtn;
    BtnCalcMCardsS2: TBitBtn;
    BtnCalcMCardsSB: TBitBtn;
    BtnCalcMCardsSB2: TBitBtn;
    ReportPeriod_to000: TDateEdit;
    ReportPeriod_from000: TDateEdit;
    ReportPeriod_from999: TDateEdit;
    ReportPeriod_to1: TDateEdit;
    ReportPeriod_from1: TDateEdit;
    BtnCalcMCards1: TBitBtn;
    BtnCalcMDrgInvent: TBitBtn;
    BtnCalcMAmounts2: TBitBtn;
    BtnCalcPKPBook: TBitBtn;
    BtnCalcMAmounts3: TBitBtn;
    Date1MSaleAddCheck: TDateEdit;
    Date2MSaleAddCheck: TDateEdit;
    ReportPeriodMAmounts: TDateEdit;
    ReportUniformForChangeDate: TDateEdit;
    ReportPeriodMAmounts_Spis: TDateEdit;
    ReportPeriodMDrgInvent: TDateEdit;
    ReportDepotMDrgInvent: TXEDBLookupCombo;
    eMCards:TEdit;
    BtnCalcMCards: TBitBtn;
    MODecodeBtn: TBitBtn;
    BtnUniformProf: TBitBtn;
    BtnUniformProfJ: TBitBtn;
    BtnShopRstPrih: TBitBtn;
    BtnUniformReport: TBitBtn;
    BtnMSaleAdd: TBitBtn;
    BtnCalcMCards999: TBitBtn;
    BtnCalcMCardsInt: TBitBtn;
    BtnCalcMCards2: TBitBtn;
    MProviderChkBox: TCheckBox;
    ReportSpinEdit: TrxSpinEdit;
    ReportDepotMControl: TComboBox;
    ReportPeriod: TDateEdit;
    ReportPeriod_from: TDateEdit;

    MODecodePeriod_to: TDateEdit;
    MODecodePeriod_from: TDateEdit;


    ReportMCardsS_from: TDateEdit;
    ReportMCardsS_to: TDateEdit;
    ReportMCardsSB_from: TDateEdit;
    ReportMCardsSB_to: TDateEdit;


    ReportShopPeriod_from: TDateEdit;
    ReportShopPeriod_to: TDateEdit;
    ReportMSaleAddPeriod: TDateEdit;

    ReportPeriodMDrgOperMove_from: TDateEdit;
    ReportPeriodMDrgOperMove_to: TDateEdit;
    ReportEdit: TEdit;
    ReportLabel: TLabel;
    ReportPeriod_to: TDateEdit;
    ReportDepotMAmounts: TXEDBLookupCombo;
    UniformForChangeCombo: TXEDBLookupCombo;
    ReportUniformSection: TXEDBLookupCombo;
    ReportUniform: TXEDBLookupCombo;
    LabelSection: TLabel;
    LabelMainSection: TLabel;
    LabelProf: TLabel;
    WorkerLab: TLabel;
    UniformProfGrid: TXEDBGrid;
    ReportDepotMRstPrih: TXEDBLookupCombo;
    ReportDepotMSaleAdd: TXEDBLookupCombo;
    ReportDepotMAmounts_Spis: TXEDBLookupCombo;
    ReportClientMProviderCalc: TXEDBLookupCombo;
    ReportDepotMAmounts2: TComboBox;
    ReportMOsnastka: TComboBox;
    ReportDepotMCards: TXEDBLookupCombo;
    ReportDepotMCardsS: TXEDBLookupCombo;
    ReportDepotMCardsSB: TXEDBLookupCombo;
    ReportAccountMRashWork: TComboBox;
    ReportAccountMRashWork2: TComboBox;
    ReportMSvodProvider: TXEDBLookupCombo;
    ReportMProviderProsrochClient: TXEDBLookupCombo;
    ReportMProviderProsrochClient999: TXEDBLookupCombo;
    ReportMProviderProsroch: TXEDBLookupCombo;
    ReportMPrividerAnalit: TXEDBLookupCombo;
    ReportMProviderCalc: TXEDBLookupCombo;
    ReportMPKPBookCalc: TXEDBLookupCombo;
    MODecodeAccount: TComboBox;
    ReportAccountMovePR: TComboBox;
    XNotifyEvent: TXNotifyEvent;
    CurPriceMotion: extended;
    CurAccountMotion: string;
    CurColorIndex: integer;
    CurColorArr: array of TColor;
    CardPanel: TPanel;
    CalcPrice: boolean;
    CalcBID: boolean;
    CurDateIns: variant;
    GMoveMat: boolean;
    GCalc: boolean;
    MSvodProviderDate: TDateTime;

Procedure TmdMat.MaterialsEditDeclarAfterPost(DataSet: TDataSet);
var aNode: Integer;
    Position:TTreeNode;
begin
  if Assigned(MaterialsC.Form) then
    with TFormMat(MaterialsC.Form).MaterialsTree do
      begin
        { Если ветка закрыта, то нефиг выделываться }
        if not Assigned(Selected) then Exit;
        if not Selected.Expanded then Exit;
        Items.BeginUpdate;
        Position:=Selected;
        aNode:=MaterialsEditDeclarKod.AsVariant;
        if not NewRecord then
        begin
          MaterialsEditDeclarAfterDelete(DataSet);
        end;
        MaterialsEditDeclar.DisableControls;
        MaterialsEditDeclar.MasterSource:=nil;
        RefreshTree(DataSet, False);
        Items.EndUpdate;
        MaterialsEditDeclar.MasterSource:=MaterialsView;
        MaterialsEditDeclar.Locate('Kod',aNode,[]);
        MaterialsEditDeclar.EnableControls;
        NewRecord:=false;
      end;
end;

Procedure TmdMat.MaterialsEditDeclarBeforeDelete(DataSet: TDataSet);
begin
  NodeID:=MaterialsEditDeclarKod.AsVariant;
end;

Procedure TmdMat.MaterialsEditDeclarAfterDelete(DataSet: TDataSet);
   var Node:TTreeNode;
begin
  with TFormMat(MaterialsC.Form).MaterialsTree do
  begin
    Node:=NodeFind(NodeID);
    if Assigned(Node) then Items.Delete(Node);
  end;
end;

Procedure TmdMat.MInvoiceHDeclarNewRecord(DataSet: TDataSet);
begin
  Changing:=True;
  with DataSet do begin
    if FieldByName('DateDoc').AsVariant=null then FieldByName('DateDoc').AsDateTime:=CurDateIns;
    if FieldByName('Currency').AsVariant=null then FieldByName('Currency').AsInteger:=974;
    if FieldByName('Kredit').AsVariant=null then
       FieldByName('Kredit').AsString:=GetDefaultAccount;
    if FieldByName('IsLock').AsVariant=null then FieldByName('IsLock').AsInteger:=0;
    case isShop of
    39: FieldByName('KOD_ZD').AsInteger:=2;
    43: FieldByName('KOD_ZD').AsInteger:=3;
    else
        FieldByName('KOD_ZD').AsInteger:=1;
    end;
  end;
  Changing:=False;
end;

Procedure TmdMat.MInvoiceTDeclarNewRecord(DataSet: TDataSet);
begin
  with DataSet do begin
(***** Lev 13.12.2004 *****)
    AutoCalcFields:=false;
(***** Lev 13.12.2004 *****)
    FieldByName('BID').AsInteger:=0;
    FieldByName('InvoiceID').AsInteger:=MInvoiceHDeclarID.AsInteger;
    FieldByName('SummaBy').AsInteger:=0;
    FieldByName('Price_no_BID').AsInteger:=0;
    FieldByName('Price_no_round').AsInteger:=0;
    FieldByName('PriceBy').AsInteger:=0;
    FieldByName('Price').AsInteger:=0;
    FieldByName('Summa').AsInteger:=0;
    FieldByName('SummaBID').AsInteger:=0;
    FieldByName('SummaBIDBy').AsInteger:=0;
    FieldByName('SummaVAT').AsInteger:=0;
    FieldByName('SummaVATBy').AsInteger:=0;
    FieldByName('DateDoc').AsDateTime:=MInvoiceHDeclarDateDoc.AsDateTime;
    FieldByName('Operation').AsInteger:=MInvoiceHDeclarOperation.AsInteger;
    FieldByName('RateVAT').AsFloat:=0;
//    AutoCalcFields:=True;
    case MInvoiceHDeclar.FieldByName('Operation').AsInteger of
     3,10,18:
      begin
        if (IsShop=39) then
          FieldByName('RateVAT').AsFloat:=0.1
        else
          FieldByName('RateVAT').AsFloat:=NDS_def;
        FieldByName('Kredit').AsString:='';
      end;
     6,7,8,15:
      begin
        if MInvoiceHDeclar.REcordCount>0 then
          begin
            FieldByName('Kredit').AsString:=MInvoiceHDeclarKredit.AsString;
            FieldByName('Debit').AsString:=MInvoiceHDeclarKredit.AsString;
          end
        else
          begin
            FieldByName('Kredit').AsString:='';
            FieldByName('Debit').AsString:='';
          end
      end;
    end; // case
//    AutoCalcFields:=False;
  end;
end;

Procedure TmdMat.LocalCalcTotals(DataSet:TDataSet);
  var a: extended;
begin
  try
    case GetOperNum(Dataset.Fields[0],true) of
    7:
      begin
        if isShop>0 then
          with DataSet do begin
            //a:=(1 + FieldByName('BID').AsFloat)*FieldByName('PriceBy').AsFloat*FieldByName('Amount').AsFloat;
            //FieldByName('SummaVATBy').AsFloat:=RoundA(FieldByName('RateVAT').AsFloat*a);
            FieldByName('TotalBy').asFloat:=RoundA(FieldByName('Price_no_BID').AsFloat*FieldByName('Amount').AsFloat);
            FieldByName('Total').asFloat:=FieldByName('TotalBy').asFloat;
            FieldByName('SummaBy').asFloat:=FieldByName('TotalBy').AsFloat-FieldByName('SummaVATBy').AsFloat;
            FieldByName('Summa').asFloat:=FieldByName('SummaBy').AsFloat;
          end
        else
          with DataSet do begin
            a:=(1 + FieldByName('BID').AsFloat)*FieldByName('PriceBy').AsFloat*FieldByName('Amount').AsFloat;
            FieldByName('SummaVATBy').AsFloat:=RoundA(FieldByName('RateVAT').AsFloat*a);
            FieldByName('TotalBy').asFloat:=RoundA((1+FieldByName('RateVAT').AsFloat)*a);
            FieldByName('Total').asFloat:=FieldByName('TotalBy').asFloat;
          end;
      end;
    11: begin
      with DataSet do begin
        FieldByName('SummaVATBy').AsFloat:=
          FieldByName('RateVAT').AsFloat*(FieldByName('SummaBy').AsFloat+FieldByName('SummaOTKLBy').AsFloat);
        FieldByName('SummaVAT').AsFloat:=
          FieldByName('RateVAT').AsFloat*(FieldByName('Summa').AsFloat+FieldByName('SummaOTKL').AsFloat);


        // 12.09.2011
        FieldByName('TotalBy').asFloat:=
          FieldByName('SummaVATBy').AsFloat+
          //(FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat*Course)+         ///////////    !!!!!! 11.11.11
          (FieldByName('Amount').AsFloat*FieldByName('PriceBy').AsFloat)+
          FieldByName('SummaOTKLBy').AsFloat+
          FieldByName('SummaOTKL2By').AsFloat;

        FieldByName('Total').asFloat:=
            FieldByName('SummaVAT').AsFloat+
            FieldByName('Summa').AsFloat+
            FieldByName('SummaOTKL').AsFloat+
            FieldByName('SummaOTKL2').AsFloat;
      end;
    end;
    16: RecalcAllRoznica(Dataset.Fields[0])
    else
      with DataSet do begin
        FieldByName('SummaVATBy').AsFloat:=
          RoundA(FieldByName('RateVAT').AsFloat*(FieldByName('SummaBy').AsFloat+FieldByName('SummaOTKLBy').AsFloat));
        FieldByName('SummaVAT').AsFloat:=
          FieldByName('RateVAT').AsFloat*(FieldByName('Summa').AsFloat+FieldByName('SummaOTKL').AsFloat);

        FieldByName('TotalBy').asFloat:=RoundA(
          FieldByName('SummaVATBy').AsFloat+
          FieldByName('SummaBy').AsFloat+
          FieldByName('SummaOTKLBy').AsFloat+
          FieldByName('SummaOTKL2By').AsFloat);

        if GetOperNum(Dataset.Fields[0])=3 then
          FieldByName('Total').asFloat:=FieldByName('TotalBy').asFloat
        else
          FieldByName('Total').asFloat:=
            FieldByName('SummaVAT').AsFloat+
            FieldByName('Summa').AsFloat+
            FieldByName('SummaOTKL').AsFloat+
            FieldByName('SummaOTKL2').AsFloat;
      end;
    end;
  except
    ShowMessage('Error in LocalCalcTotals');
  end;
end;

Procedure TmdMat.MInvoiceTDeclarRateVATChange(Sender: TField);
begin
  MInvoiceTDeclarBIDChange(Sender);
  LocalCalcTotals(Sender.DataSet);
end;

Procedure TmdMat.MInvoiceTDeclarAmountChange(Sender: TField);
 var num: double;
begin
  if GetOperNum(Sender) = 16 then
    RecalcAllRoznica(Sender)
  else
    begin
      with Sender.DataSet do try //Наверное придется делать case
       if MInvoiceTDeclarOperation.AsInteger=3 then // простой приход
         begin
           MInvoiceTDeclarPrice_no_round.AsFloat:=(1+MInvoiceTDeclarBID.AsFloat)*(MInvoiceTDeclarPrice_no_BID.AsFloat);
           MInvoiceTDeclarPriceBy.AsFloat:=MInvoiceTDeclarPrice_no_round.AsFloat;
           MInvoiceTDeclarPrice.AsFloat:=MInvoiceTDeclarPrice_no_round.AsFloat;
           // Цена округляется только в приходе!!!
           MInvoiceTDeclarPriceBy.AsFloat:=RoundA(MInvoiceTDeclarPrice_no_round.AsFloat);
         end;
       if FieldByName('Operation').AsInteger in [4,7,8] then // простой расход
         begin
           FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
           if (GetOperNum(Sender, true)<>7) then
              FieldByName('Price_no_round').AsFloat:=FieldByName('PriceBy').AsFloat;
         end;
       if FieldByName('Operation').AsInteger=18 then // приход по магазину
         begin
           num := (1+MInvoiceTDeclarSaleAdd.AsFloat)*(1+MInvoiceTDeclarSaleVAT.AsFloat)*(MInvoiceTDeclarPriceUC.AsFloat);
           MInvoiceTDeclarPrice_no_Round.AsFloat := num;
           MInvoiceTDeclarPrice_no_BID.AsFloat := num;
           MInvoiceTDeclarPrice.AsFloat := Round10(num, true);
           MInvoiceTDeclarPriceBy.AsFloat := MInvoiceTDeclarPrice.AsFloat;
           MInvoiceTDeclarSumma.AsFloat := MInvoiceTDeclarAmount.AsFloat*MInvoiceTDeclarPriceUC.AsFloat;
           MInvoiceTDeclarSummaBy.AsFloat := MInvoiceTDeclarSumma.AsFloat;
         end
       else
         FieldByName('Summa').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat;
       if FieldByName('Operation').AsInteger=11 then // валютный приход
         FieldByName('SummaBy').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat*Course
       else if (GetOperNum(Sender, true)=7) then
         begin
           num := (1+MInvoiceTDeclarSaleAdd.AsFloat)*(MInvoiceTDeclarPriceUC.AsFloat);
           MInvoiceTDeclarSumma.AsFloat := MInvoiceTDeclarAmount.AsFloat*num;
           MInvoiceTDeclarSummaBy.AsFloat := RoundA(MInvoiceTDeclarSumma.AsFloat);
           num := (1+MInvoiceTDeclarSaleVAT.AsFloat)*num;
           MInvoiceTDeclarPrice_no_Round.AsFloat := RoundA(num);
           MInvoiceTDeclarPrice_no_BID.AsFloat := RoundA(num);
         end
       else if (FieldByName('Operation').AsInteger<>18) then
          FieldByName('SummaBy').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price_no_round').AsFloat;
      finally
         if FieldByName('Operation').AsInteger<>10
           then FieldByName('DocAmount').AsFloat:=FieldByName('Amount').AsFloat;
         LocalCalcTotals(Sender.DataSet);
         if GetOperNum(Sender, true)=4 then // расход
             begin
               MInvoiceT_SSDeclarSTVChange(Sender);
             end;
      end;
    end;
end;

Procedure TmdMat.MInvoiceTDeclarBIDChange(Sender: TField);
 var aPrice: extended;
begin
  if not calcBID then
    try
      calcBid:=True;
      case GetOperNum(Sender, true) of
      7:
        with MInvoiceTDeclar do
          begin
            aPrice:={RoundA}((1 + MInvoiceTDeclarBID.AsFloat)*MInvoiceTDeclarPriceBy.AsFloat);
            if (MInvoiceTDeclarPrice_no_BID.AsFloat <> RoundA((1 + MInvoiceTDeclarRateVAT.AsFloat)*aPrice)) then
              begin
                MInvoiceTDeclarPrice_no_BID.AsFloat := RoundA((1 + MInvoiceTDeclarRateVAT.AsFloat)*aPrice);
                MInvoiceTDeclarSummaBy.AsFloat := RoundA(MInvoiceTDeclarAmount.AsFloat*aPrice);
              end;
            LocalCalcTotals(Sender.DataSet);
          end;
      16: RecalcAllRoznica(Sender);
      18:
      else
        with Sender.DataSet do
          begin
            // в случае восстановления из списания на себестоимость..
            if MInvoiceForm.cbAllMat.Visible and MInvoiceForm.cbAllMat.Checked and
              (FieldByName('PriceUC').AsFloat<>FieldByName('Price_no_BID').AsFloat) then
              FieldByName('PriceUC').AsFloat:=FieldByName('Price_no_BID').AsFloat;
            // все неравенства нужны для ускорения работы обработчиков
            if (FieldByName('SummaBIDBy').AsFloat<>FieldByName('BID').AsFloat*FieldByName('Price_no_BID').AsFloat*Course) then
              FieldByName('SummaBIDBy').AsFloat:=FieldByName('BID').AsFloat*FieldByName('Price_no_BID').AsFloat*Course;
            if (FieldByName('SummaBID').AsFloat<>FieldByName('BID').AsFloat*FieldByName('Price_no_BID').AsFloat) then
              FieldByName('SummaBID').AsFloat:=FieldByName('BID').AsFloat*FieldByName('Price_no_BID').AsFloat;
            if (FieldByName('Price_no_Round').AsFloat<>FieldByName('SummaBIDBy').AsFloat+(FieldByName('Price_no_BID').AsFloat*Course)) then
              FieldByName('Price_no_Round').AsFloat:=FieldByName('SummaBIDBy').AsFloat+(FieldByName('Price_no_BID').AsFloat*Course);
            if (FieldByName('PriceBy').AsFloat<>RoundA(FieldByName('Price_no_Round').AsFloat)) then
              FieldByName('PriceBy').AsFloat:=RoundA(FieldByName('Price_no_Round').AsFloat);
            if (FieldByName('Price').AsFloat<>FieldByName('SummaBID').AsFloat+FieldByName('Price_no_BID').AsFloat) then
              FieldByName('Price').AsFloat:=FieldByName('SummaBID').AsFloat+FieldByName('Price_no_BID').AsFloat;
            LocalCalcTotals(Sender.DataSet)
          end;
     end; // case
 finally
   calcBid:=False;
 end;
end;

Procedure TmdMat.MaterialsEditDeclarNewRecord(DataSet: TDataSet);
var Kod:Variant;
function DoZeroTill7(str: string): string;
begin
  Result:=str;
  while Length(Result)<7 do
    begin
      Result:=Result+'0';
    end;
  Result[7]:='1';
end;
begin
  NewRecord:=true;
  if LastUnitM<>0 then DataSet.FieldByName('UnitM').AsInteger:=LastUnitM;
  if (LastCountry<>0) and (IsShop=39) then DataSet.FieldByName('Country').AsInteger:=LastCountry;
  if LastSection<>0 then DataSet.FieldByName('Section').AsInteger:=LastSection;
  DataSet.FieldByName('Account').AsString:=LastAccount;
  DataSet.FieldByName('Name').AsString:=LastMatName;
  Kod:=GetFromSQLText('AO_GKSM_InProgram','Select Max(Kod)+1 from sta.Materials where kodup='+
    DataSet.FieldByName('KodUp').AsString,false);
  if Kod=null then Kod:=DoZeroTill7(DataSet.FieldByName('KodUp').asString);
  DataSet.FieldByName('KOD').Value:=Kod;
  if isShop=39 then
    begin
      DataSet.FieldbyName('Section').AsInteger:=390000;
      DataSet.FieldbyName('Account').AsString:='41.00';
      DataSet.FieldbyName('Country').AsInteger:=30;
      if LastUnitM=0 then DataSet.FieldbyName('UnitM').AsInteger:=4;
    end;
  if isShop=43 then
    begin
      DataSet.FieldbyName('Section').AsInteger:=430000;
      DataSet.FieldbyName('Account').AsString:='41.00';
      DataSet.FieldbyName('Country').AsInteger:=30;
      if LastUnitM=0 then DataSet.FieldbyName('UnitM').AsInteger:=4;
    end;
end;

Procedure TmdMat.MasterChange(DataSet:TDataSet);
begin
  //if TMInvoiceForm(MInvoiceC.Form).XEDBGrid1.Datasource.Dataset.RecordCount>0 then
     XNotifyEvent.GoSpellChild(TMInvoiceForm(MInvoiceC.Form).XEDBGrid1, xeSumExecute, MInvoiceT.DeclarLink, opInsert);
  //
end;

Procedure TmdMat.MdMatCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  NodeID:=-1;
  TEtvMasterDataLink(MinvoiceTDeclar.MasterLink).onMasterScroll:=MasterChange;
  LastUnitM:=4;
  LastCountry:=30;
  LastMatName:='';
  LastAccount:='';
  MaterialsEditDeclarSectionName.OnFilter:=ModuleBase.SectionNameFilter;
  GlobalCourse:=1;
  CurDateIns:=Now;
  FDefaultShop:=-1;
  FDefaultAccount:='60.00';
//  GlobalSourceDepot:=-1;
  Changing:=False;
  WorkDate:=GetFromSQLText(MAmountsDeclar.DataBaseName,
    'select ReportPeriod from STA.ADMCONFIG',false);
  CloseDate:=GetFromSQLText(MAmountsDeclar.DataBaseName,
    'select CurPeriod from STA.ADMCONFIG',false);
//  WorkDate:=EncodeDate(2004,05,1);
  if (UserName='LEV') or (UserName='ADMIN') or (UserName='ANDY') then MInvoiceV1.Visible:=true;
  if IsShop>0 then
    begin
      MaterialsEditLookupCalc.TableName:='STA.MTotalsAShop';
      MaterialsEditLookupCalc.TableName:='STA.MTotalsAShop';
      MaterialsEditLookupCalcPrice.DisplayLabel:='Цена розн.';
    end;
  MFaktura.OnDataChange:=MFakturaDataChange;

  if not Assigned(DepotList) then
    begin
      TempQuery.SQL.Text:='select STA.GetMShopMemberNumDepot(),STA.GetMShopMemberAcc()';
      try
        TempQuery.Open;
        while not TempQuery.Eof do
          begin
            FDefaultShop:=TempQuery.Fields[0].AsInteger;
            FDefaultAccount:=TempQuery.Fields[1].AsString;
            TempQuery.Next;
          end;
        TempQuery.Close;
      except
      end;

      // список рабочих подразделений
      DepotList:=TStringList.Create;
      TempQuery.SQL.Text:='select kod from STA.SprDepot where Shop='+IntToStr(IsShop);
      try
        TempQuery.Open;
        while not TempQuery.Eof do
          begin
            DepotList.Add(TempQuery.Fields[0].AsString);
            TempQuery.Next;
          end;
        TempQuery.Close;
      except
      end;

    end;

   if (IsShop=39) or (IsShop=43) then
     begin
       MaterialsEditDeclarGold.Visible:=False;
       MaterialsEditDeclarSilver.Visible:=False;
       MaterialsEditDeclarPlatinum.Visible:=False;
       MaterialsEditDeclarPalladium.Visible:=False;
       MaterialsEditDeclarRutenium.Visible:=False;
       MaterialsEditDeclarIridium.Visible:=False;
       MaterialsEditDeclarRodium.Visible:=False;
       MaterialsEditDeclarDateDrg.Visible:=False;
     end;

   miShop.Visible:=IsShop>0;
end;

Procedure TmdMat.MFakturaDataChange(Sender: TObject; Field: TField);
begin
  MFakturaDeclarCurrencyChange(Field);
end;

Procedure TmdMat.MInvoiceHDeclarOperationChange(Sender: TField);
begin
  // Случай входа в режим инсерт
  if (MInvoiceHDeclar.State in [dsInsert]) and (MInvoiceHDeclarOperation.AsVariant=null) then
    Exit;
  if (MInvoiceHDeclar.State in [dsInsert]) and
     (MInvoiceHDeclarOperation.AsInteger=7) and
     (MInvoiceHDeclarCel_Prb.AsVariant=null) then
       MInvoiceHDeclarCel_Prb.AsString:='Для собств. нужд';
  //
  if MInvoiceHDeclar.State in [dsEdit] then
    begin
      if MessageDLg('Изменить тип документа?',mtConfirmation,mbOkCancel,0)=mrCancel then
        Abort
      else
        begin
          ShowMessage('ВНИМАНИЕ!'+chr(13)+
                      '------------------'+chr(13)+
                      'Вы изменили тип документа!'+chr(13)+
                      'Введите заново поставщика и получателя.'+chr(13)+
                      'Строки наполнения будут временно отключены.'+chr(13)+
                      'Сохраните шапку документа и наполнение появится!');
          MInvoiceHDeclarClient.Clear;
          MInvoiceHDeclarRecipient.Clear;
          MInvoiceHDeclarSourceDepot.Clear;
          MInvoiceHDeclarDestDepot.Clear;
          MInvoiceHDeclarKod_StatRash.Clear;
          MInvoiceHDeclarKod_ObjZatr.Clear;
          // меняем операцию во всех строках детализации
          With MInvoiceTDeclar do
            begin
              DisableControls;
              First;
              while not MInvoiceTDeclar.Eof do
                begin
                  Edit;
                  MInvoiceTDeclarOperation.AsInteger:=MInvoiceHDeclarOperation.AsInteger;
                  Post;
                  Next;
                end;
              EnableControls;
            end;
       end;
    end;
  TMInvoiceForm(MInvoiceC.Form).ChangeFormFace(True);
  //FindNewNumDoc;
end;

Procedure TmdMat.MInvoiceTDeclarSummaChange(Sender: TField);
begin
  if isShop>0 then Exit;
  LocalCalcTotals(Sender.Dataset);
end;

Procedure TmdMat.MaterialsViewDeclarNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('KodUp').AsVariant:=MKodUp;
end;

Procedure TmdMat.MaterialsViewDeclarAfterScroll(DataSet: TDataSet);
begin
  MKodUP:=DataSet.FieldByName('KodUp').AsVariant;
end;

Procedure TmdMat.N1Click(Sender: TObject);
 var aDeviceType: String;
      aNumCopies:integer;
begin
(*   if not Assigned(Box) then
     Box:=TFormSelect.Create(Application);
   with Box do
     begin
       if not ModuleBase.DepotLookup.Active then
         ModuleBase.DepotLookup.Open;
       if not MaterialsEditLookup.Active then begin
         {TBorlandDataSet(MaterialsEditLookup).FBufferCount:=7;}
         MaterialsEditLookup.Open;
       end;
       ShowModal;
       if ModalResult=idOK then
         begin
           MCardVQuery.Close;
           MCardVQuery.ParamByName('Depot').Value:=Depot;
           MCardVQuery.ParamByName('Material').Value:=Material;
           if not MCardVQuery.Prepared then
             MCardVQuery.Prepare;
           MCardVQuery.Open;
         end
       else Abort
     end;
   aDeviceType:='Screen';
   aNumCopies:=1;
   PLMCard.RangeEndCount:=aNumCopies;
   with MReport do begin
     Template.FileName:=DirShb+'\MCard.rtm';
     Template.LoadFromFile;
     DeviceType:=aDeviceType;
     Print;
   end;*)
end;

Procedure TmdMat.MaterialsEditDeclarCalcFields(DataSet: TDataSet);
var Depot:String;
begin
   Depot:='';
   (*If (DataSet.State=dsCalcFields) and MaterialsEditDeclarAmount.Visible then begin
    //if Assigned(TFormMat(MaterialsC.Form)) then Depot:=vartostr(TFormMat(MaterialsC.Form).DepotLookUp.KeyValue);
    if Depot='' then Depot:='0';
    MaterialsEditDeclarAmount.AsVariant:=GetFromSQLText('AO_GKSM_InProgram','Select MAmount(null,'+
      Depot+','+MaterialsEditDeclarKod.AsString+',0)',false);
  end;*)
end;

Procedure TmdMat.GetPrices(DataSet:TDataSet);
begin
  if PriceLookup.Active then PriceLookup.Close;
  PriceLookup.ParamByName('Mat').AsInteger:=MInvoiceTDeclar.FieldByName('Material').AsInteger;
  if CheckRashod then begin
    PriceLookup.ParamByName('Depot').AsInteger:=MInvoiceHDeclar.FieldByName('SourceDepot').AsInteger;
    PriceLookup.ParamByName('Position').AsDateTime:=MInvoiceHDeclar.FieldByName('DateDoc').AsDateTime + 1;
  end else begin
    PriceLookup.ParamByName('Depot').AsInteger:=0;
    PriceLookup.ParamByName('Position').AsDateTime:=Now;
  end;
  PriceLookup.Open;
end;

Function TmdMat.MInvoiceTDeclarPriceNameFilter(Sender: TObject): String;
begin
  GetPrices(TField(Sender).DataSet);
end;

Procedure TmdMat.MInvoiceTDeclarBeforePost(DataSet: TDataSet);
begin
  with DataSet do
    begin
      if FieldByName('Operation').AsInteger<>11 then
        begin
          FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
          FieldByName('Summa').AsFloat:=FieldByName('SummaBy').AsFloat;
          FieldByName('SummaVAT').AsFloat:=FieldByName('SummaVATBy').AsFloat;
          FieldByName('SummaBID').AsFloat:=FieldByName('SummaBIDBy').AsFloat;
        end;
      if not (FieldByName('Operation').AsInteger in [4,6,7,8,15,18]) then
        begin
            FieldByName('PriceUC').AsFloat:=FieldByName('PriceBy').AsFloat;
        end;
    end;
end;

Procedure TmdMat.MInvoiceTDeclarPriceChange(Sender: TField);
  var Rate, VAT: extended;
begin
  // балансовые счета
  if not calcPrice then
    try
      CalcPrice:=True;
      AssignAccounts;
      if not CheckRashod then
        begin
         if GetOperNum(Sender)<>18 then
           MInvoiceTDeclarPriceUC.AsFloat:=MInvoiceTDeclarPriceBy.AsFloat;
         if GetOperNum(Sender) in [9,13] then
           MInvoiceTDeclarPrice_no_round.AsFloat:=MInvoiceTDeclarPriceBy.AsFloat;
        end;
      if Assigned(Sender) then
        begin
          case GetOperNum(Sender, true) of
          7:
            with MInvoiceTDeclar do
              begin
                if (PriceLookup.RecordCount>0) and (FieldByName('PriceUC').AsFloat <> PriceLookup.FieldByName('PriceUC').AsFloat) then
                   FieldByName('PriceUC').AsFloat := PriceLookup.FieldByName('PriceUC').AsFloat;
                LocalCalcTotals(MInvoiceTDeclar);
              end;
          16: RecalcAllRoznica(Sender);
          18:;
          else
            with MInvoiceTDeclar do
              begin
                // все неравенства нужны для ускорения работы обработчиков
                if (FieldByName('Operation').AsInteger<>11) then
                  begin
                    if (FieldByName('Price').AsFloat<>FieldByName('PriceBy').AsFloat) then
                     FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
                  end;
                if not (FieldByName('Operation').AsInteger in [4,6,8,11]) and
                   (FieldByName('Price_no_round').AsFloat<>0) and
                   (FieldByName('PriceBy').AsFloat<>RoundA(FieldByName('Price_no_round').AsFloat)) then
                   FieldByName('PriceBy').AsFloat:=RoundA(FieldByName('Price_no_round').AsFloat);
                if (FieldByName('Operation').AsInteger in [11]) and
                   (FieldByName('PriceBy').AsFloat<>0) and
                   (FieldByName('PriceBy').AsFloat<>RoundA(FieldByName('Price_no_round').AsFloat)) then
                   FieldByName('Price_no_round').AsFloat:=RoundA(FieldByName('PriceBy').AsFloat);
                if (FieldByName('Operation').AsInteger in [4,6,8])  then
                   begin
                     if FieldByName('Price').AsFloat<>FieldByName('PriceBy').AsFloat then
                       FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
                     if FieldByName('Price_no_round').AsFloat<>FieldByName('PriceBy').AsFloat then
                       FieldByName('Price_no_round').AsFloat:=FieldByName('PriceBy').AsFloat;
                   end;
                if FieldByName('Summa').AsFloat<>FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat then
                   FieldByName('Summa').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat;
                if (FieldByName('SummaBy').AsFloat<>FieldByName('Amount').AsFloat*FieldByName('Price_no_Round').AsFloat) then
                   FieldByName('SummaBy').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price_no_Round').AsFloat;
                if (FieldByName('Price_no_BID').AsFloat=0) and
                   (FieldByName('Price_no_BID').AsFloat<>FieldByName('Price').AsFloat/(1+FieldByName('BID').AsFloat)) then
                  FieldByName('Price_no_BID').AsFloat:=FieldByName('Price').AsFloat/(1+FieldByName('BID').AsFloat);
                LocalCalcTotals(MInvoiceTDeclar);
              end;
            with MInvoiceTDeclarPriceNameBy do
              Value:=LookupDataSet.Lookup(LookupKeyFields,DataSet.FieldValues[KeyFields],LookupResultField);
            with MInvoiceTDeclarPriceName do
              Value:=LookupDataSet.Lookup(LookupKeyFields,DataSet.FieldValues[KeyFields],LookupResultField);
          end; // case
          if (IsShop>0) and (GetOperNum(Sender) in [4,7]) and (Sender = MInvoiceTDeclarPriceBy) and
             not MInvoiceTDeclarMaterial.IsNull and not MInvoiceTDeclarPriceUC.IsNull  then
            begin
               GetSaleRateAndVATShop(MInvoiceTDeclarMaterial.Value, MInvoiceTDeclarPriceUC.Value, MInvoiceTDeclarKredit.Value,MInvoiceHDeclarSourceDepot.Value,
                  Rate, VAT);
               MInvoiceTDeclarRateVAT.AsFloat:=VAT;
               MInvoiceTDeclarBID.AsFloat:=Rate;
            end;
        end;
      if (GetOperNum(Sender)=11){ and (MInvoiceTDeclar.FieldByName('SummaCustomBy').AsInteger=0)} then
       with MInvoiceTDeclar do
        if FieldByName('SummaCustomBy').AsFloat<>FieldByName('TotalBy').AsFloat-RoundA(FieldByName('Total').AsFloat*Course) then
          FieldByName('SummaCustomBy').AsFloat:=FieldByName('TotalBy').AsFloat-RoundA(FieldByName('Total').AsFloat*Course)
    finally
      CalcPrice:=False;
    end; // calcPrice=False
end;

Procedure TmdMat.MInvoiceHDeclarCurrencyChange(Sender: TField);
begin
  if not Changing then
    with MInvoiceHDeclar do
      if FieldByName('Operation').asInteger=11 then begin
        Course:=GetFromSQLText('AO_GKSM_InProgram',Format('Select RateOnDateF(%d,''%s'')',
        [MInvoiceHDeclarCurrency.AsInteger,MInvoiceHDeclarDateDoc.AsString]),false);
      end
      else
        Course:=1;
      TMInvoiceForm(MInvoiceC.Form).LabelCourse1.Caption:=FloatToStr(Course);
      TMInvoiceForm(MInvoiceC.Form).LabelCourse.Caption:='курс на '+
        FormatDateTime('dd.mm.yy',MInvoiceHDeclarDateDoc.AsDateTime);
      // пересчитываем все строки из-за изменения курса
      if (GlobalCourse<>Course) and (MInvoiceTDeclar.Active) and not (MInvoiceHDeclar.State=dsBrowse) then
        with MInvoiceTDeclar do
          begin
            DisableControls;
            First;
            while not MInvoiceTDeclar.Eof do
              begin
                Edit;
                try
                  MInvoiceTDeclarPriceChange(Sender);
                finally
                  Post;
                end;
                Next;
              end;
            First;
            EnableControls;
          end;
      GlobalCourse:=Course;
end;

Procedure TmdMat.MInvoiceTDeclarMaterialChange(Sender: TField);
  var ValueUC: Double;
      Account: string;
      Rate, VAT: extended;
begin
  // Проставляем бухгалтерские счета
  with MInvoiceTDeclar do
    begin
      AutoCalcFields:=true;
      FieldByName('Debit').Clear;
      case {MInvoiceHDeclarOperation.AsInteger} GetOperNum(Sender, true) of
 3,9,10,11,13,14,16,18: begin
              (FieldByName('MaterialName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Debit'));
              FieldByName('Kredit').AsString:=MInvoiceHDeclarKredit.AsString;
              if IsShop>0 then MInvoiceTDeclarDebit.AsString:='41.00';
              //В валютных накладных надо вводить контракт в каждую строку!
              (FieldByName('MaterialName') as TXELookField).ValueByLookNameToField('Contract',FieldByName('Contract'));
             end;
          4: begin
                MInvoiceTDeclarPriceBy.AsFloat:=FindMaterialsFirstPriceForRash(MInvoiceTDeclarMaterial.AsFloat,
                  MInvoiceHDeclarSourceDepot.AsInteger, ValueUC ,Account);
                MInvoiceTDeclarKredit.AsString:=Account;
                MInvoiceTDeclarDebit.AsString:=Account;
                if not (MInvoiceHDeclarSourceDepot.AsInteger in SkladSet) and
                 (FieldByName('Kredit').AsString='10.10') then FieldByName('Kredit').AsString:='10.11';
                if not (MInvoiceHDeclarDestDepot.AsInteger in SkladSet) and
                 (FieldByName('Debit').AsString='10.10') then FieldByName('Debit').AsString:='10.11';
                MInvoiceTDeclarPriceUC.AsFloat:=ValueUC;
                if (IsShop>0) then
                  begin
                     GetSaleRateAndVATShop(MInvoiceTDeclarMaterial.Value, MInvoiceTDeclarPriceUC.Value, MInvoiceTDeclarKredit.Value,MInvoiceHDeclarSourceDepot.Value,
                        Rate, VAT);
                     MInvoiceTDeclarRateVAT.AsFloat:=VAT;
                     MInvoiceTDeclarBID.AsFloat:=Rate;
                  end;
             end;
    6,7,8,15:
             begin
                FieldByName('Debit').AsString:=MInvoiceHDeclarKredit.AsString;
                MInvoiceTDeclarPriceBy.AsFloat:=FindMaterialsFirstPriceForRash(MInvoiceTDeclarMaterial.AsFloat,
                  MInvoiceHDeclarSourceDepot.AsInteger, ValueUC ,Account);
                if IsShop>0 then
                  MInvoiceTDeclarKredit.AsString:='41.00'
                else
                  MInvoiceTDeclarKredit.AsString:=Account;
                MInvoiceTDeclarPriceUC.AsFloat:=ValueUC;
                if (MInvoiceHDeclarOperation.AsInteger in [4,7]) and (IsShop>0) then // - продажа или расход магазина
                  begin
                     GetSaleRateAndVATShop(MInvoiceTDeclarMaterial.Value, MInvoiceTDeclarPriceUC.Value, MInvoiceTDeclarKredit.Value,MInvoiceHDeclarSourceDepot.Value,
                        Rate, VAT);
                     MInvoiceTDeclarRateVAT.AsFloat:=VAT;
                     MInvoiceTDeclarBID.AsFloat:=Rate;
                  end;
             end;

      end;
      CheckDrgOper;
      AutoCalcFields:=false;
    end;
end;

Procedure TmdMat.ShowFields(ColumnList:TColumnList; AddFields: boolean; SortOrderIndex: integer=0);
  var
    i:Byte;
    FList:String;
    aResCalcNames:String;
    index: byte;
begin
  FList:=';';
  if AddFields then
    begin
      ColumnList:=ColumnList+[21]+[22];
      if isShop=0 then
         ColumnList:=ColumnList+[23];
    end;
  aResCalcNames:='';
  for i:=0 to 255 do
    if i in ColumnList then
      begin
        FList:=FList+FieldListNames[i]+';';
      end;
  with MinvoiceTDeclar do begin
    for i:=0 to Fields.Count-1 do begin
      Fields[i].Visible:=Pos(LowerCase(';'+Fields[i].FieldName+';'),LowerCase(FList))>0;
      if Fields[i].Visible then
        begin
          if (Pos('_'+Fields[i].FieldName+'_',TotalList)>0) then aResCalcNames:=aResCalcNames+'Sum';
          aResCalcNames:=aResCalcNames+';';
          Fields[i].ReadOnly:=True;
        end;
    end;
    if aResCalcNames<>'' then System.Delete(aResCalcNames, Length(aResCalcNames),1);
  end;

  {Корректировка строки ResCalc для инициализации полей для расчета}
  with MInvoiceT.DeclarLink.Calc do begin
    FieldNames:=GetVisibleFieldNames(MInvoiceTDeclar, true, false);
    ResCalcNames:=aResCalcNames;
  end;
  SortInputFields(SortOrderIndex);
end;

Procedure TmdMat.MInvoiceHDeclarBeforeDelete(DataSet: TDataSet);
begin
  if MessageDlg('Внимание! Вы удаляете накладную!'+#13+#10+'                  Вы уверены?', mtWarning, mbOKCancel, 0)=mrCancel
    then Abort;
end;

Procedure TmdMat.MInvoiceTDeclarBeforeDelete(DataSet: TDataSet);
begin
  Inherited;
(*
  if MessageDlg('Удалить строку документа?', mtWarning, [mbOK, mbCancel], 0)=mrCancel
    then Abort
*)
    ///DoCalcOst(True, DataSet);
end;

Procedure TmdMat.MaterialsEditDeclarBeforePost(DataSet: TDataSet);
begin
  LastMatName:=DataSet.FieldByName('Name').AsString;
  LastUnitM:=DataSet.FieldByName('UnitM').AsInteger;
  LastCountry:=DataSet.FieldByName('Country').AsInteger;
  LastSection:=DataSet.FieldByName('Section').AsInteger;
  LastAccount:=DataSet.FieldByName('Account').AsString;
end;

Procedure TmdMat.MInvoiceHDataChange(Sender: TObject; Field: TField);
begin
//  if not Assigned(Field) then Exit;
  if Assigned(Field) and (Field<>MInvoiceHDeclarOperation) then Exit;
  { Идет обработка комбинации клавиш <Ctrl+Shift+Z> }
  if (Sender is TLinkSource) and (TLinkSource(Sender).DataSet.Tag=99) then Exit;
  if not Assigned(MInvoiceC.Form) then MInvoiceC.Execute;
  if Assigned(Field) or
    (TMInvoiceForm(MInvoiceC.Form).GlobalMode<>MInvoiceHDeclarOperation.AsInteger) then
    begin
     TMInvoiceForm(MInvoiceC.Form).ChangeFormFace;
{Lev 25.04.04}
{Lev 25.04.04}
    end;
  MInvoiceHDeclarCurrencyChange(nil);
end;

Procedure TmdMat.MAmountsVCCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=3
  end;
end;

Procedure TmdMat.MInvoiceHDeclarAfterCancel(DataSet: TDataSet);
begin
  TMInvoiceForm(MInvoiceC.Form).ChangeFormFace;
end;

Procedure TmdMat.MInvoiceHDeclarBeforePost(DataSet: TDataSet);
begin
  // Обнуляем ненужные и выставляем проверку на наличие значений полей в зависимости от текущей операции
  case MInvoiceHDeclarOperation.Value of
    3,11,16,18: // 3 - Приход, 11 - Приход за валюту
    begin
      MInvoiceHDeclarClient.Required:=true;
      MInvoiceHDeclarRecipient.Clear;
      MInvoiceHDeclarSourceDepot.Clear;
      MInvoiceHDeclarDestDepot.Required:=true;
    end;
    4: // Расход
    begin
      MInvoiceHDeclarClient.Clear;
      MInvoiceHDeclarRecipient.Clear;
      MInvoiceHDeclarSourceDepot.Required:=true;
      MInvoiceHDeclarDestDepot.Required:=true;
    end;
    5,6,8: // 5 - Акт ОТК, 6 - списание, 8 - списание на себестоимость
    begin
      MInvoiceHDeclarClient.Clear;
      MInvoiceHDeclarRecipient.Clear;
      MInvoiceHDeclarSourceDepot.Required:=true;
      MInvoiceHDeclarDestDepot.Clear;
    end;
    7: // 7 - Продажа
    begin
      MInvoiceHDeclarClient.Clear;
      MInvoiceHDeclarRecipient.Required:=true;
      MInvoiceHDeclarSourceDepot.Required:=true;
      MInvoiceHDeclarDestDepot.Clear;
    end;
    9,10,13: // 9 - Взятие на баланс, 10 - Акт приемки, 13 - занесение остатков
    begin
      MInvoiceHDeclarClient.Clear;
      MInvoiceHDeclarRecipient.Clear;
      MInvoiceHDeclarSourceDepot.Clear;
      MInvoiceHDeclarDestDepot.Required:=true;
    end;
  end;
  CurDateIns := Dataset.FieldByName('DateDoc').AsDateTime;
end;

Procedure TmdMat.MInvoiceHDeclarAfterPost(DataSet: TDataSet);
begin
  MInvoiceForm.ShowFields(MInvoiceHDeclarOperation.AsInteger, MInvoiceHDeclarDestDepot.AsInteger);
  //MInvoiceHDeclar.Refresh;
  //MInvoiceTDeclar.Refresh;
end;

Procedure TmdMat.MInvoiceHDeclarBeforeEdit(DataSet: TDataSet);
begin
  MInvoiceHDeclarClient.Required:=false;
  MInvoiceHDeclarRecipient.Required:=false;
  MInvoiceHDeclarSourceDepot.Required:=false;
  MInvoiceHDeclarDestDepot.Required:=false;
end;

procedure TmdMat.MInvoiceT_RestoreDeclarNewRecord(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('BID').AsInteger:=0;
    FieldByName('SummaBy').AsInteger:=0;
    FieldByName('PriceBy').AsInteger:=0;
    FieldByName('Price').AsInteger:=0;
    FieldByName('Summa').AsInteger:=0;
    FieldByName('SummaBID').AsInteger:=0;
    FieldByName('SummaVAT').AsInteger:=0;
  end;
end;

Procedure TmdMat.MAmountsCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMAmounts:=TDateEdit.Create(PageControl1TabPanel);
    with ReportPeriodMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriodMAmounts';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := SysUtils.Date+1;
    end;
    ReportDepotMAmounts:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMAmounts';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=ModuleBase.DepotLookup;
      ListSource:=DataSource1;
      KeyValue:=91;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    {with ModuleBase.DepotDeclar do
      begin
        ReportDepotMAmounts.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMAmounts.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportDepotMAmounts.ItemIndex:=ReportDepotMAmounts.Items.Count-1;
            Next;
          end;
      end;}
    BtnCalcMAmounts:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMAmountsClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMAmounts2:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=645;
      Width:=30;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMAmounts2Click;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.AutoSize:=True;
    Grid.OnDrawColumnCell:=DrawCellAmount;
  end;
end;

Procedure TMdMat.CalcMAmountsClick(Sender: TObject);
var
  Cond: TListObj;
begin
  ExecSQLText(MAmountsDeclar.DataBaseName,
     'call STA.GetMAmountsOnPeriod('''+ReportPeriodMAmounts.Text+
     ''','+IntToStr(Integer(ReportDepotMAmounts.KeyValue))+',1)',false);
  TBEForm(MAmountsC.Form).Caption:='Остатки материалов по '+ModuleBase.DepotLookupName.AsString+
     ' ('+ModuleBase.DepotLookupKod.AsString+') на '+ReportPeriodMAmounts.Text;
{  try
    MAmountsDeclar.Refresh;
  except
  end;}
  with TBEForm(MAmountsC.Form).Grid do begin
    FormatColumns(true);
    with TBEForm(MAmountsC.Form).Grid.DataSource.DataSet do
      begin
        FieldByName('SUMMA').DisplayWidth:=FieldByName('PRICE').DisplayWidth;
        FieldByName('POSITION').DisplayWidth:=15;
      end;
    SetFocus;
  end;
  Cond:=TFilterItem(TXInquiryItem(MAmountsC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
  MAmountsC.PlayInquiry(MAmountsC.Inquiries[0],Cond);
  try
    MAmountsDeclar.Refresh;
  except
  end;
end;

procedure TmdMat.MaterialsViewDeclarAfterPost(DataSet: TDataSet);
begin
  RefreshTree(DataSet);
end;

procedure TmdMat.MaterialsViewDeclarAfterDelete(DataSet: TDataSet);
 var Node: TTreeNode;
begin
  if Assigned(DeleteNode) then
    with TFormMat(MaterialsC.Form).MaterialsTree do
      begin
        Selected:=DeleteNode.GetPrevVisible;
        Items.Delete(DeleteNode);
        SyncDataSet:=True;
      end;
end;

procedure TmdMat.MaterialsViewDeclarBeforeDelete(DataSet: TDataSet);
begin
  with TFormMat(MaterialsC.Form).MaterialsTree do
    begin
      DeleteNode:=NodeFind(DataSet.FieldByName('KOD').Value);
      SyncDataSet:=False;
    end;
end;

procedure TmdMat.MaterialsViewDeclarAfterCancel(DataSet: TDataSet);
begin
  with TFormMat(MaterialsC.Form).MaterialsTree do
    if not SyncDataSet then SyncDataSet:=True;
end;

procedure TmdMat.MOunt(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    ReportPeriod_from:=TDateEdit.Create(Form);
    PageControl1TabPanel.Autosize:=False;
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=115;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=200;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    ReportDepotMCards:=TXEDBLookupCombo.Create(Form); // TComboBox
    with ReportDepotMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=285;
      Width:=300;
      Height:=22;
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=91;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Name:='DepotCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=590;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMCardsClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    BtnCalcMCards2:=TBitBtn.Create(Form);
    with BtnCalcMCards2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=695;
      Width:=30;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMCards2';
      Font.Style:=[fsBold];
      Caption:='Карт';
      OnClick:=CalcMCards2Click;
      TabStop:=true;
      TabOrder:=4;
    end;
    {ChbxMCards:= TCheckBox.Create(Form);
    with ChbxMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=730;
      Width:=100;
      Height:=22;
      Name:='ChbxMReadyMat';
      Font.Style:=[fsBold];
      Caption:='в шт.';
      TabStop:=true;
      TabOrder:=5;
    end;}
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMCardsClick(Sender: TObject);
begin
  ExecSQLText(MCardsDeclar.DataBaseName,
     'call STA.GetMCardsOnPeriod('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','+IntToStr(Integer(ReportDepotMCards.KeyValue))+
        ',0)',false);
  TBEForm(MCardsC.Form).Caption:='Движение материалов (обороты) по '+SprDepotAdvLookupName.AsString+
     ' ('+SprDepotAdvLookupKod.AsString+') за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  try
    MCardsDeclar.DisableControls;
    MCardsDeclar.Close;
    MCardsDeclar.Open;
    MCardsDeclar.EnableControls;
  except
  end;
  with TBEForm(MCardsC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.DrawCellAmount(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Pos('Amount',Column.Field.FullName)>0 then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clHighlight;
        TDBGrid(Sender).Canvas.Font.Color:=clHighlightText;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clWindow;
        TDBGrid(Sender).Canvas.Font.Color:=clWindowText;
      end;

  if (Column.Field.DataSet = MAmountsDeclar) and
     (Column.Field.DataSet.FieldByName('Amount').Value<0) then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clYellow;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clRed;
      end;
  if Column.Field.DataSet = MCardsDeclar then
    if Column.Field.DataSet.FieldByName('TYPE_STR').AsInteger>0 then
      begin
        TDBGrid(Sender).Canvas.Font.Style:=[fsBold];
        if (gdSelected in State) and (gdFocused in State) then
          begin
            TDBGrid(Sender).Canvas.Font.Color:=clYellow;
          end
        else
          begin
            if Column.Field.DataSet.FieldByName('TYPE_STR').AsInteger=2 then
              TDBGrid(Sender).Canvas.Font.Color:=clMaroon
            else
              TDBGrid(Sender).Canvas.Font.Color:=clBlue;
          end;
      end;
  if (Column.Field.DataSet = MCardsDeclar) and
     (Column.Field.DataSet.FieldByName('TYPE_STR').AsInteger>0) and
     (Column.Field.FullName = 'Price') then
    TDBGrid(Sender).DefaultDrawDataCell(Rect,nil, State)
  else
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MInvoiceTDeclarAfterInsert(DataSet: TDataSet);
begin
{  case MInvoiceHDeclarOperation.AsInteger of
    3, 11, 14, 16: MInvoiceTDeclarKredit.AsString:=MInvoiceHDeclarKredit.AsString;
    7, 8, 15: MInvoiceTDeclarDebit.AsString:=MInvoiceHDeclarKredit.AsString;
  end;}
end;

procedure TmdMat.RefreshTree(DataSet: TDataSet; LocateNew: Boolean);
 var Node: TTreeNode;
begin
  with TFormMat(MaterialsC.Form).MaterialsTree do
    begin
      Node:=NodeFind(DataSet.FieldByName('KODUP').Value);
      if Assigned(Node) then
        begin
          TvgDBTreeNode(Node).Collapse(true);
          TvgDBTreeNode(Node).ExpandSafe(true);
        end;
      if LocateNew then
        begin
          Node:=NodeFind(DataSet.FieldByName('KOD').Value);
          if Assigned(Node) then Node.Selected:=True;
        end;
    end;
end;

procedure TmdMat.FindNewNumDoc;
begin
  if ((MInvoiceHDeclar.State in [dsInsert]) and (MInvoiceHDeclarOperation.AsInteger in [3, 9, 11, 16, 18]))
    or ((MInvoiceHDeclar.State in [dsEdit]) and (MInvoiceHDeclarOperation.AsInteger in [3, 9, 11, 16, 18]) and (MInvoiceHDeclarNumDoc.AsString='')) then
    begin
      if not Assigned(TempQuery) then
        begin
          TempQuery:=TQuery.Create(Self);
          TempQuery.DatabaseName:=MaterialsEdit.DatabaseName;
        end;
      TempQuery.SQL.Text:='select STA.GetMInvoiceNextNumDoc('''+FormatDateTime('dd.mm.yy', FirstDayOfMonth(MInvoiceHDeclarDateDoc.AsDateTime))+''','+MInvoiceHDeclarDestDepot.asString+')';
      try
        TempQuery.Open;
        MInvoiceHDeclarNumDoc.AsString := TempQuery.Fields[0].AsString;
      except
        MInvoiceHDeclarNumDoc.AsString := '';
      end;
      // DateExp
      if MInvoiceHDeclarDateExp.IsNull then
         MInvoiceHDeclarDateExp.AsDateTime:=IncMonth(MInvoiceHDeclarDateDoc.AsDateTime,1);
    end;
end;

procedure TmdMat.MInvoiceHDeclarDateDocChange(Sender: TField);
begin
  FindNewNumDoc;
  MInvoiceHDeclarCurrencyChange(Sender);
  DrawDataInvoice;
end;

function TmdMat.FirstDayOfMonth(ADate: TDateTime): TDateTime;
  var d,m,y: word;
begin
  try
    DecodeDate(ADate, y, m, d);
    Result:=EncodeDate(y, m, 1)
  except
    Result:=Date;
  end;
end;

function TmdMat.RoundA(ANumber: extended; isNotRound: boolean = false): extended;
begin
  if Assigned(MInvoiceHDeclar) and
     (GetOperNum(MInvoiceHDeclarID,true) in [3, 7, 11, 16,18]) and
     (not isNotRound) then
    Result:=Round(ANumber+0.01)
  else
    Result:=ANumber;
end;

procedure TmdMat.DrawInputFields(ColumnList: TColumnList);
  var i: integer;
begin
  for i:=0 to High(FieldListNames) do
    begin
      if i in ColumnList then
         begin
           MInvoiceTDeclar.FieldbyName(FieldListNames[i]).Tag:=1;
         end
      else
         begin
           MInvoiceTDeclar.FieldbyName(FieldListNames[i]).Tag:=0;
         end;
      MInvoiceTDeclar.FieldbyName(FieldListNames[i]).ReadOnly:=False;
    end;
end;

procedure TmdMat.MInvoiceTDeclarTotalChange(Sender: TField);
begin
  RecalcAllRoznica(Sender);
end;

procedure TmdMat.RecalcAllRoznica(Sender: TObject);
begin
  if GetOperNum(Sender) = 16 then
    with TField(Sender).DataSet do
      begin
        if FieldByName('Total').AsFloat<>FieldByName('TotalBy').AsFloat then
           FieldByName('Total').AsFloat:=FieldByName('TotalBy').AsFloat;

        if FieldByName('SummaOTKL2').AsFloat<>FieldByName('SummaOTKL2By').AsFloat then
           FieldByName('SummaOTKL2').AsFloat:=FieldByName('SummaOTKL2By').AsFloat;

        if FieldByName('SummaVATBy').AsFloat<>
             RoundA((FieldByName('TotalBy').AsFloat-FieldByName('SummaOtkl2By').AsFloat)*FieldByName('RateVAT').AsFloat) then
          begin
            FieldByName('SummaVATBy').AsFloat:=
              RoundA((FieldByName('TotalBy').AsFloat-FieldByName('SummaOtkl2By').AsFloat)*FieldByName('RateVAT').AsFloat);
            FieldByName('SummaVAT').AsFloat:=FieldByName('SummaVATBy').AsFloat;
          end;

        if FieldByName('SummaOTKL').AsFloat<>FieldByName('SummaOTKLBy').AsFloat then
           FieldByName('SummaOTKL').AsFloat:=FieldByName('SummaOTKLBy').AsFloat;
        {if FieldByName('SummaOTKL').AsFloat<>0 then
          begin
            FieldByName('SummaOTKL').AsFloat:=0;
            FieldByName('SummaOTKLBy').AsFloat:=0;
          end;}

        if FieldByName('Summa').AsFloat<>
             FieldByName('TotalBy').AsFloat-FieldByName('SummaVATBy').AsFloat-FieldByName('SummaOTKLBy').AsFloat then
          begin
            FieldByName('Summa').AsFloat:=FieldByName('TotalBy').AsFloat -
                     FieldByName('SummaVATBy').AsFloat - FieldByName('SummaOTKLBy').AsFloat;
            FieldByName('SummaBy').AsFloat:=FieldByName('Summa').AsFloat;
          end;

        if (FieldByName('Amount').AsFloat<>0) and
           (FieldByName('PriceBy').AsFloat<>Abs(RoundA(FieldByName('Summa').AsFloat/FieldByName('Amount').AsFloat))) then
          begin
            FieldByName('PriceBy').AsFloat:=Abs(RoundA(FieldByName('Summa').AsFloat/FieldByName('Amount').AsFloat));
            FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
          end;

        if  FieldByName('Price_no_BID').AsFloat<>RoundA(FieldByName('PriceBy').AsFloat/(1+FieldByName('BID').AsFloat)) then
          FieldByName('Price_no_BID').AsFloat:=RoundA(FieldByName('PriceBy').AsFloat/(1+FieldByName('BID').AsFloat));

        if FieldByName('SummaBID').AsFloat<>FieldByName('PriceBy').AsFloat-FieldByName('Price_no_BID').AsFloat then
          begin
            FieldByName('SummaBID').AsFloat:=FieldByName('PriceBy').AsFloat-FieldByName('Price_no_BID').AsFloat;
            FieldByName('SummaBID').AsFloat:=FieldByName('Summa').AsFloat;
          end;
      end;
end;

function TmdMat.GetOperNum(Sender: TObject; MayBeSevenIfShop: boolean = false): integer;
begin
  if (Sender is TField) then
    Result := MInvoiceHDeclarOperation.AsInteger
  else
    Result := 0;
  if MayBeSevenIfShop and (Result=4) and (isShop>0) then Result:=7;
end;

procedure TmdMat.RecalcAll(Sender: TObject);
begin
end;

procedure TmdMat.MRashWorkCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := InCMonth(WorkDate,1)-1;
    end;
    ReportAccountMRashWork:=TComboBox.Create(Form);
    with ReportAccountMRashWork do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=305;
      Width:=70;
      Height:=22;
      Name:='ReportAccountMRashWork';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    with ModuleCommon.AccountLookup do
      begin
        ReportAccountMRashWork.Items.Clear;
        if Not Active then Active:=True;
        First;
        ReportAccountMRashWork.Items.Add('<все>');
        while not ModuleCommon.AccountLookup.Eof do
          begin
            if Copy(FieldByName('BuhAccount').AsString,1,2)='10' then
              ReportAccountMRashWork.Items.Add(FieldByName('BuhAccount').AsString);
            Next;
          end;
        ReportAccountMRashWork.ItemIndex:=0;
      end;
    ReportAccountMRashWork2:=TComboBox.Create(Form);
    with ReportAccountMRashWork2 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=385;
      Width:=70;
      Height:=22;
      Name:='ReportAccountMRashWork2';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    with ModuleCommon.AccountLookup do
      begin
        ReportAccountMRashWork2.Items.Clear;
        if Not Active then Active:=True;
        First;
        ReportAccountMRashWork2.Items.Add('<все>');
        while not ModuleCommon.AccountLookup.Eof do
          begin
            //if Copy(FieldByName('BuhAccount').AsString,1,2)='10' then
            ReportAccountMRashWork2.Items.Add(FieldByName('BuhAccount').AsString);
            Next;
          end;
        ReportAccountMRashWork2.ItemIndex:=0;
      end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=470;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMRAshWorkClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=580;
      Width:=30;
      Height:=22;
      Name:='BtnCalcMRashWorkC2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMRAshWorkClick2;
      TabStop:=true;
      TabOrder:=3;
    end;
    ChbxMRashWork:= TCheckBox.Create(Form);
    with ChbxMRashWork do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=615;
      Width:=100;
      Height:=22;
      Name:='ChbxCalcMRashWorkC2';
      Font.Style:=[fsBold];
      Caption:='10.01+10.02';
      OnClick:=CalcMRAshWorkClick3;
      TabStop:=true;
      TabOrder:=4;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMRashWorkClick(Sender: TObject);
var ss: string;
    ss2: string;
begin
  {ExecSQLText(MRashWorkDeclar.DataBaseName,
     'call STA.GetMRashWorkAll('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','''+ReportAccountMRashWork.Items[ReportAccountMRashWork.ItemIndex]+''')',false);}
  if ReportAccountMRashWork.ItemIndex=0 then
    ss:=''
  else
    ss:=ReportAccountMRashWork.Items[ReportAccountMRashWork.ItemIndex];

  if ReportAccountMRashWork2.ItemIndex=0 then
    ss2:=''
  else
    ss2:=ReportAccountMRashWork2.Items[ReportAccountMRashWork2.ItemIndex];


  ExecSQLText(MRashWorkDeclar.DataBaseName,
     'call STA.GetMRashWorkAll('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','''+ss+''','+IntToStr(Integer(ChbxMRashWork.Checked))+','''+ss2+''')',false);
  TBEForm(MRashWorkC.Form).Caption:='Расход материалов на производство по счету '+ReportAccountMRashWork.Items[ReportAccountMRashWork.ItemIndex]+
    ' за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  with MRashWorkDeclar do
    try

      tag:=Trunc(StrToDate(ReportPeriod_from.Text));
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MRashWorkC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.MInvoiceCCreateForm(Sender: TObject);
begin
  TMInvoiceForm(MInvoiceC.Form).XEDbGrid1.OnTitleClick:=MGridTitleClick;
  //MInvoiceTDeclarMaterialName.OnFilter:=MaterialNameFilter;
  // вспомогательная временная таблица
//  ExecSQLText(MInvoiceTDeclar.DataBaseName,'call STA.GetMaterialsRash2()',false);
  MaterialsEditLookupCalc.Open;
  if Screen.ActiveForm.Name='FormStart' then
    TMInvoiceForm(MInvoiceC.Form).CheckBox1.Checked:=False;
  {AMScaleForm(TMInvoiceForm(MInvoiceC.Form));}
end;

procedure TmdMat.MGridTitleClick(Column: TColumn);
begin
  {
  if Column.Field.FieldName<>'MaterialName' then Exit;
  with TXELookField(Column.Field) do
    if LookUpLevelUp<>'' then begin
      LookUpLevelUp:='';
      LookUpLevelDown:='';
      LookUpFilterField:='AmountDown';
      LookUpFilterKey:='0';
      Column.Title.Caption:='Наименование материала';
    end else begin
      LookUpLevelUp:='KodUp';
      LookUpLevelDown:='AmountDown';
      LookUpFilterField:='';
      LookUpFilterKey:='';
      Column.Title.Caption:='Дерево материалов';
    end;}
end;

procedure TmdMat.OnSourceDepotChange(Sender: TObject);
begin
//  if (MInvoiceHDeclarSourceDepot.AsInteger <> GlobalSourceDepot) then
//      GlobalSourceDepot:=MInvoiceHDeclarSourceDepot.AsInteger;
  if (MInvoiceHDeclarOperation.AsInteger in [4,6,7,8,15]) then
    with MaterialsEditLookupCalc do
      begin
        MaterialsEditLookupCalc.Active:=False;
        MaterialsEditLookupCalc.Active:=True;
      end;
end;

procedure TmdMat.ChangeMaterialLookup(isRashod: boolean);
  var MustOpen: boolean;
begin
  MustOpen:=False; // надо ли открывать таблицу MaterialsV...
  if isRashod and not (MInvoiceTDeclarMaterialName.LookupDataSet=MaterialsEditLookupCalc) then
    begin
      MInvoiceTDeclar.Active:=False;
      MInvoiceTDeclarMaterialName.LookupDataSet:=MaterialsEditLookupCalc;
      if not MaterialsEditLookupCalc.Active then OnSourceDepotChange(nil);
      MustOpen:=True;
    end;
  if (not MustOpen) and (not isRashod) and (MInvoiceTDeclarMaterialName.LookupDataSet=MaterialsEditLookupCalc) then
    begin
      MInvoiceTDeclar.Active:=False;
      MInvoiceTDeclarMaterialName.LookupDataSet:=MaterialsEditLookup;
      MInvoiceTDeclarMaterialName.LookupResultField:='Kod;Name;UnitMName;Account';
      MInvoiceTDeclarMaterialName.LookupGridFields:='Kod;Name;UnitMName';
      MInvoiceTDeclarMaterialName.LookupAddFields:='KodUp;Gold;Platinum;Silver;Palladium;Rutenium;Rodium;Iridium';
      {MInvoiceTDeclarMaterialName.DisplayWidth:=
            MaterialsEditDeclarKod.DisplayWidth+
            MaterialsEditDeclarName.DisplayWidth+
            MaterialsEditDeclarUnitMName.DisplayWidth+
            2;}
    end;
  if MustOpen then
    begin
      if IsShop>0 then
        begin
          MInvoiceTDeclarMaterialName.LookupResultField:='Kod;Name;UnitMName;Price;PriceUC;Amount';
          MInvoiceTDeclarMaterialName.LookupAddFields:='KodUp;Account;Depot;Gold;Platinum;Silver;Palladium;Rutenium;Rodium;Iridium';
        end
      else
        begin
          MInvoiceTDeclarMaterialName.LookupResultField:='Kod;Name;UnitMName;PriceUC;Amount;Account';
          MInvoiceTDeclarMaterialName.LookupAddFields:='KodUp;Price;Depot;Gold;Platinum;Silver;Palladium;Rutenium;Rodium;Iridium';
        end;
      MInvoiceTDeclarMaterialName.LookupGridFields:='Kod;Name;UnitMName';
    end;
  //ShowMessage(IntToStr(MInvoiceTDeclarMaterialName.DisplayWidth));
  if not MInvoiceTDeclar.Active then MInvoiceTDeclar.Active:=True;
end;

function TmdMat.FindMaterialsFirstPriceForRash(Material: extended;
  Depot: integer; var PriceUC: Double; var Account: string): extended;
  var ss: string;
      vv: Array of Variant;
begin
  try
    if (MInvoiceForm.cbAllMat.Visible) and (MInvoiceForm.cbAllMat.Checked) then
      ss:='select 0, 0,  0 as Amount, Account  from STA.Materials A  where A.Kod='+FloatToStr(Material)
    else
      ss:='select Price, PriceUC,  MAmount('''+ MInvoiceHDeclarDateDoc.AsString +''', Depot, Material,Price, PriceUC,Account) as aMAmount, Account '+
        'from STA.MTotalsA A '+
        'where A.Material='+FloatToStr(Material)+' '+
        '        and Depot='+IntToStr(Depot)+' '+
        '        and aMAmount>0 '+
        'group by Price, PriceUC, Depot, Material, Account '+
        'order by IsNull(aMAmount,500000) desc ';

    vv := GetArrFromSQLText('AO_GKSM_InProgram',ss,false);
    if VarIsEmpty(vv) or VarIsNull(vv) then
      begin
        Result:=0;
        PriceUC:=0;
        Account:='';
      end
    else
      begin
        Result:=vv[0];
        PriceUc:=vv[1];
        Account:=vv[3];
      end;
  except
    Result:=0;
    PriceUC:=0;
    Account:='';
  end;
end;

procedure TmdMat.MInvoiceHDeclarBeforeOpen(DataSet: TDataSet);
begin
  //DataSet.Filter:='DateDoc>='''+FormatDateTime('dd.mm.yy', WorkDate)+'''';
  //DataSet.Filtered:=False;
  //DataSet.Filtered:=True;
end;

procedure TmdMat.MostNmoveCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    ReportPeriod_from:=TDateEdit.Create(Form);
    PageControl1TabPanel.Autosize:=False;
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=310;
      Width:=100;
      Height:=22;
      Name:='BtnMostNmove';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMostNmoveClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    Grid.OnDrawColumnCell:=DrawCellMostNmove;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMostNmoveClick(Sender: TObject);
begin
  if MessageDlg('ВНИМАНИЕ!!!'#13' Расчет занимает продолжительное время.'#13+
      'В это время запросы остальных пользователей'#13'попадут в режим ожидания!'#13+
      'Вы желаете ПРОДОЛЖИТЬ?', mtInformation, [mbYes, mbNo], 0)=mrYes then
    begin
      ExecSQLText(MostNmoveDeclar.DataBaseName,
         'call STA.GetM_OST_N_MOVE_OnPeriod('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
      TBEForm(MostNmoveC.Form).Caption:='Ведомость отстатков и движения материалов за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
      try
        MostNmoveDeclar.DisableControls;
        MostNmoveDeclar.Close;
        MostNmoveDeclar.Open;
        MostNmoveDeclar.EnableControls;
      except
      end;
      with TBEForm(MostNmoveC.Form).Grid do begin
       FormatColumns(True);
       SetFocus;
      end;
    end;
end;

procedure TmdMat.DrawCellMostNmove(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Pos('PRIH',AnsiUpperCase(Column.Field.FullName))>0 then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clHighlight;
        TDBGrid(Sender).Canvas.Font.Color:=clHighlightText;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clGreen;
        TDBGrid(Sender).Canvas.Font.Color:=clWhite;
      end;
  if Pos('RASH',AnsiUpperCase(Column.Field.FullName))>0 then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clHighlight;
        TDBGrid(Sender).Canvas.Font.Color:=clHighlightText;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Brush.Color:=clRed;
        TDBGrid(Sender).Canvas.Font.Color:=clYellow;
      end;
  if Pos('ALL',AnsiUpperCase(Column.Field.FullName)) > 0 then
    TDBGrid(Sender).Canvas.Font.Style := [fsBold];
  if MostNmoveDeclarDEPOT.AsInteger = 999 then
    TDBGrid(Sender).Canvas.Font.Style := [fsBold];
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MControlResCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;    
    ReportPeriod:=TDateEdit.Create(Form);
    with ReportPeriod do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=115;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportDepotMControl:=TComboBox.Create(Form);
    with ReportDepotMControl do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=195;
      Width:=300;
      Height:=22;
      Name:='DepotCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    with ModuleBase.DepotDeclar do
      begin
        ReportDepotMControl.Items.Clear;
        if Not Active then Active:=True;
        First;
        ReportDepotMControl.Items.AddObject('< все подразделения >',TObject(0));
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMControl.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=91 then
              ReportDepotMControl.ItemIndex:=ReportDepotMControl.Items.Count-1;
            Next;
          end;
      end;
    ReportSpinEdit:=TrxSpinEdit.Create(Form);
    with ReportSpinEdit do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=495;
      Width:=50;
      Height:=22;
      Name:='SpinEdit';
      MaxValue:=99;
      MinValue:=1;
      Value:=1;
      Font.Style:=[];
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=545;
      Width:=100;
      Height:=22;
      Name:='BtnMostNmove';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMControlResClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    Grid.OnDrawColumnCell:=DrawCellMControlRes;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMControlResClick(Sender: TObject);
 var Dep: integer;
begin
  Dep:=Integer(ReportDepotMControl.Items.Objects[ReportDepotMControl.ItemIndex]);
  ExecSQLText(MControlResDeclar.DataBaseName,
     'call STA.GetMControlRes('''+ReportPeriod.Text+''','+
       IntToStr(Dep)+
       ','+FloatToStr(ReportSpinEdit.Value)+')',false);
  TBEForm(MControlResC.Form).Caption:='Контроль использования материальных ресурсов по '+ReportDepotMControl.Items[ReportDepotMControl.ItemIndex]+
    ' за период с '+ReportPeriod.Text;
  with MControlResDeclar do
    try
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MControlResC.Form).Grid do begin
   Columns[Columns.Count-1].Visible:=Dep=-1;
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.DrawCellMControlRes(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Pos('ИТОГО',AnsiUpperCase(MControlResDeclarName.AsString))>0) or
     (Pos('ВСЕГО',AnsiUpperCase(MControlResDeclarName.AsString))>0) then
    TDBGrid(Sender).Canvas.Font.Style := [fsBold];
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MFindCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;    
    ReportLabel:=TLabel.Create(Form);
    with ReportLabel do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=5;
      Left:=115;
      Width:=200;
      Height:=20;
      Font.Style:=[fsBold];
      Caption:='Наим. или код материала';
    end;
    ReportEdit:=TEdit.Create(Form);
    with ReportEdit do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=275;
      Width:=180;
      Height:=20;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
    end;
    with TLabel.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=5;
      Left:=460;
      Width:=80;
      Height:=20;
      Font.Style:=[fsBold];
      Caption:='На дату';
    end;
    ReportPeriod:=TDateEdit.Create(Form);
    with ReportPeriod do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=510;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := SysUtils.Date + 1;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=595;
      Width:=100;
      Height:=22;
      Name:='BtnMostNmove';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMFindClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMCards2:=TBitBtn.Create(Form);
    with BtnCalcMCards2 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=700;
      Width:=30;
      Height:=22;
      Name:='BtnMostNmove2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMFindClick2;
      TabStop:=true;
      TabOrder:=3;
    end;
    Grid.OnDrawColumnCell:=DrawCellMControlRes;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMFindClick(Sender: TObject);
  var Kod: integer;
begin
  try
    Kod:=StrToInt(ReportEdit.Text);
  except
    Kod:=-1;
  end;
  ExecSQLText(MFindDeclar.DataBaseName,
     'call STA.GetMAmountsByMaterial('''+ReportPeriod.Text+
     ''','+IntToStr(Kod)+','''+ReportEdit.Text+''')',false);
  TBEForm(MFindC.Form).Caption:='Остатки материала ~ <<'+ReportEdit.Text+'>> на '+ReportPeriod.Text;
  try
    MFindDeclar.Refresh;
  except
  end;
  with TBEForm(MFindC.Form).Grid do begin
    FormatColumns(true);
    with TBEForm(MFindC.Form).Grid.DataSource.DataSet do
      begin
        FieldByName('SUMMA').DisplayWidth:=FieldByName('PRICE').DisplayWidth;
        FieldByName('POSITION').DisplayWidth:=15;
      end;
    SetFocus;
  end;
end;

procedure TmdMat.MSvodMoveCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMSvodMoveClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    Grid.OnDrawColumnCell:=DrawCellMSvodMove;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMSvodMoveClick(Sender: TObject);
begin
  ExecSQLText(MSvodMoveDeclar.DataBaseName,
     'call STA.GetMSvodMove('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
  TBEForm(MSvodMoveC.Form).Caption:='Сводная ведомость движения по синтетическим счетам за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  try
    MSvodMoveDeclar.DisableControls;
    MSvodMoveDeclar.Close;
    MSvodMoveDeclar.Open;
    MSvodMoveDeclar.EnableControls;
  except
  end;
  with TBEForm(MSvodMoveC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.DrawCellMSvodMove(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field.DataSet.FieldByName('type').Value = 2 then
        TDBGrid(Sender).Canvas.Font.Style:=[fsBold];
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MMoveMat_PrihCCreateForm(Sender: TObject);
  var MFormCtrl: TDBFormControl;
      isPrih: boolean;
begin
  // Один обработчик на приход и расход
  MFormCtrl := TDBFormControl(Sender);
  isPrih := MFormCtrl.Tag = 1;
  if isPrih then
    begin
      //MMoveMat_PrihDeclar.TableName:='Andy.MMoveMat_Prih';
      MFormCtrl.Caption:='Сводная ведомость движения материалов (Приходная часть)';
    end
  else
    begin
      //MMoveMat_PrihDeclar.TableName:='Andy.MMoveMat_Rash';
      MFormCtrl.Caption:='Сводная ведомость движения материалов (Расходная часть)';
    end;
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    ReportAccountMovePR:=TComboBox.Create(Form);
    with ReportAccountMovePR do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=305;
      Width:=70;
      Height:=22;
      Name:='ReportAccountMovePR';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    with ModuleCommon.AccountLookup do
      begin
        ReportAccountMovePR.Items.Clear;
        if Not Active then Active:=True;
        First;
        ReportAccountMovePR.Items.Add('<все>');
        while not ModuleCommon.AccountLookup.Eof do
          begin
            if Copy(FieldByName('BuhAccount').AsString,1,2)='10' then
              ReportAccountMovePR.Items.Add(FieldByName('BuhAccount').AsString);
            Next;
          end;
        ReportAccountMovePR.ItemIndex:=0;
      end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top := 0;
      Left := 390;
      Width := 100;
      Height := 22;
      Name := 'BtnCalcMCards';
      Font.Style := [fsBold];
      Caption := 'Расчет формы';
      OnClick := CalcMMoveMatClick;
      TabStop := true;
      TabOrder := 2;
      Tag := MFormCtrl.Tag;
    end;
    Grid.OnDrawColumnCell:=DrawCellMMove;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMMoveMatClick(Sender: TObject);
  var i: integer;

// формируем имя поля
procedure GetName(AField: TField);
  var ss: string;
      i: integer;
begin
   if AnsiUpperCase(AField.FullName) = 'KOD_DEPOT' then AField.DisplayLabel := 'код';
   if AnsiUpperCase(AField.FullName) = 'NAME_DEPOT' then AField.DisplayLabel := 'Подразделение';
   if AnsiUpperCase(AField.FullName) = 'SUMMA_OST_BEG' then AField.DisplayLabel := 'Остаток на начало';
   if AnsiUpperCase(AField.FullName) = 'SUMMA_OST_END' then AField.DisplayLabel := 'Остаток на конец';
   if AnsiUpperCase(AField.FullName) = 'SUM_INTNL' then AField.DisplayLabel := 'Внутренние перемещения';
   if AnsiUpperCase(AField.FullName) = 'SUMMA_PRIH' then AField.DisplayLabel := 'Всего по приходу';
   if AnsiUpperCase(AField.FullName) = 'SUMMA_RASH' then AField.DisplayLabel := 'Всего по расходу';
   if (AnsiUpperCase(AField.FullName) <> 'SUM_INTNL') and
    (Pos('SUM_',AnsiUpperCase(AField.FullName)) > 0) then
      begin
        ss := Copy(AField.FullName, 5, Length(AField.FullName) - 4);
        for i:=1 to Length(ss) do
          if ss[i]='_' then ss[i] := '.';
        AField.DisplayLabel := ss;
      end;
end;

{procedure RemoveClearFields(Dataset: TDataset);
  var i:integer;
begin
//  dataset.DisableControls;
  Dataset.Last;
  for i:=0 to Dataset.FieldCount-1 do
    if (COPY(dataset.Fields[i].FullName,1,3)='SUM') and (dataset.Fields[i].AsInteger=0) then
        dataset.Fields[i].Visible:=False
      else
        dataset.Fields[i].Visible:=True;
  Dataset.First;
//  dataset.EnableControls;
end;}

begin
  if TButton(Sender).Tag = 1 then
    begin
      ExecSQLText(MMoveMat_PrihDeclar.DataBaseName,
        'call STA.GetMMoveMat('''+ReportPeriod_from.Text+''','''+
        ReportPeriod_to.Text+''',1,'''+ReportAccountMovePR.Items[ReportAccountMovePR.ItemIndex]+''')',false);
      AssignColumns(MMoveMat_PrihDeclar,TBEForm(MMoveMat_PrihC.Form));
      TBEForm(MMoveMat_PrihC.Form).Caption:=
        'Сводная ведомость движения материалов <'+ReportAccountMovePR.Items[ReportAccountMovePR.ItemIndex]+'> за период с '+
        ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text+' (ПРИХОД)' ;
    end
  else
    begin
      ExecSQLText(MMoveMat_RashDeclar.DataBaseName,
        'call STA.GetMMoveMat('''+ReportPeriod_from.Text+''','''+
        ReportPeriod_to.Text+''',2,'''+ReportAccountMovePR.Items[ReportAccountMovePR.ItemIndex]+''')',false);
      AssignColumns(MMoveMat_RashDeclar,TBEForm(MMoveMat_RashC.Form));
      TBEForm(MMoveMat_RashC.Form).Caption:=
       'Сводная ведомость движения материалов <'+ReportAccountMovePR.Items[ReportAccountMovePR.ItemIndex]+'> за период с '+
       ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text+' (РАСХОД)' ;
    end;
  if TButton(Sender).Tag = 1 then
    with TBEForm(MMoveMat_PrihC.Form).Grid do begin
     FormatColumns(True);
     with MMoveMat_PrihDeclar do
       for i:=0 to Fields.Count - 1 do
         GetName(Fields[i]);
     SetFocus;
    end
  else
    with TBEForm(MMoveMat_RashC.Form).Grid do begin
     FormatColumns(True);
     with MMoveMat_RashDeclar do
       for i:=0 to Fields.Count - 1 do
         GetName(Fields[i]);
     SetFocus;
    end;
end;

procedure TmdMat.DrawCellMMove(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Column.Field.DataSet.FieldByName('KOD_DEPOT').Value = 99 then
        TDBGrid(Sender).Canvas.Font.Color:=clBlue;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.SortInputFields(index: integer);
{index = 0 ---- обычная сортировка полей
         1 ---- продажа - поля по другому отсортированы
         2 ---- приход по магазину
}
  var i, k: integer;
      ColumnList : TColumnListArray;
begin
  case index of
  0,3:
    begin
      SetLength(ColumnList, Length(FieldListNames));
      for i := 0 to High(FieldListNames) do
        ColumnList[i] := i;
    end;
  1:
    begin
      SetLength(ColumnList, 6);
      ColumnList[0]:=0;
      ColumnList[1]:=1;
      ColumnList[2]:=8;
      ColumnList[3]:=4;
      ColumnList[4]:=13;
      ColumnList[5]:=3;
    end;
  2:
    begin
      SetLength(ColumnList, 7);
      ColumnList[0]:=0;
      ColumnList[1]:=1;
      ColumnList[2]:=28;
      ColumnList[3]:=10;
      ColumnList[4]:=26;
      ColumnList[5]:=27;
      ColumnList[6]:=8;
    end;
  else ShowMessage('Глюки mdMat');
  end;
  k:=0;
  for i:=0 to High(ColumnList) do
      begin
        MInvoiceTDeclar.FieldByName(FieldListNames[ColumnList[i]]).Index := k;
        inc(k);
      end;
  if index=3 then
    begin
      MInvoiceTDeclarContract.Index:=1;
      MInvoiceTDeclarContract.DisplayLabel:='Цена в шт.';
    end;
end;

procedure TmdMat.MInvoiceHDeclarAfterScroll(DataSet: TDataSet);
begin
  if (Assigned(Screen.ActiveControl) and (Screen.ActiveControl.Name='Grid'))
    or (MInvoiceHDeclar.BOF and MInvoiceHDeclar.EOF) or
     (Assigned(DataSet) and ((DataSet.State=dsInsert) or (DataSet.Name<>'MInvoiceHDeclar'))) then Exit;
  if not MInvoiceTDeclar.Active then Exit;
  if Assigned(MInvoiceForm) then with MInvoiceForm,MInvoiceHDeclar do
    begin
    if (GlobalMode<>FieldByName('Operation').AsInteger) and
      (not VarIsEmpty(TempEditValues) and (Pos('Operation',TempEditNames)>0) and
      (GlobalMode<>TempEditValues[GetIndexOfField('Operation',TempEditNames)])) then ChangeFormFace(True);
       MInvoiceForm.ShowFields(FieldByName('Operation').AsInteger, FieldByName('DestDepot').AsInteger);
    end;
  DrawDataInvoice;
end;

procedure TmdMat.MInvoiceHDeclarDestDepotChange(Sender: TField);
begin
 //
 FindNewNumDoc;
end;

procedure TmdMat.MInvoiceTDeclarDebitChange(Sender: TField);
begin
// если счет
  if Sender.FieldName='Debit' then
    with MInvoiceTDeclarDebitName do
      Value:=LookupDataSet.Lookup(LookupKeyFields,DataSet.FieldValues[KeyFields],LookupResultField);
  if Sender.FieldName='Kredit' then
    with MInvoiceTDeclarKreditName do
      Value:=LookupDataSet.Lookup(LookupKeyFields,DataSet.FieldValues[KeyFields],LookupResultField);
end;

procedure TmdMat.MInvoiceT_SSDeclarSTVChange(Sender: TField);
  var FirstSumma, NewPrice, OldSumma, NewSumma, OldPrice: extended;
  var Obj: integer;
var Account: string;
begin
  begin
    if MInvoiceTDeclar.Active and
       (MInvoiceT_SSDeclar.State<>dsBrowse) and
       MInvoiceT_SSDeclar.Active and
       not GCalc and
       (not MInvoiceTDeclarPrice.IsNull) and
       (not MInvoiceTDeclarAmount.IsNull) then
    begin
      GCalc:=True;
      Account:=MInvoiceHDeclarDestDepotName.ValueByLookName('Account');
      if Account='00.00' then Account:=MInvoiceHDeclarKredit.AsString;
//      if (Account<>'00.00') or (MInvoiceT_SSDeclar.State in [dsEdit,dsInsert]) then
        begin
          // активизируем запись списания на себестоимость
          if MInvoiceT_SSDeclar.RecordCount>0 then MInvoiceT_SSDeclar.Edit;
          if MInvoiceT_SSDeclarSTV.IsNull then MInvoiceT_SSDeclarSTV.AsFloat:=0.5;
          // расчитываем себестоимость...
          if (MInvoiceTDeclarAmount.AsFloat=0) or ((MInvoiceT_SSDeclarSTV.AsFloat=0) and (Sender=MInvoiceT_SSDeclarSumma)) then
            begin
              OldPrice:=MInvoiceTDeclarPriceBy.AsFloat; // Возможно неверно...
            end
          else
            begin
              OldPrice:={Round}((MInvoiceT_SSDeclarSumma.AsFloat+MInvoiceTDeclarSummaBY.AsFloat)/MInvoiceTDeclarAmount.AsFloat);
            end;
          if (MInvoiceT_SSDeclarSTV.AsFloat<>0) or (Sender = MInvoiceT_SSDeclarSTV) then
            begin
              NewPrice:={Round}(OldPrice * (1 - MInvoiceT_SSDeclarSTV.AsFloat));
              NewPrice:=Round(NewPrice*10000)/10000;
            end
          else if Sender=MInvoiceT_SSDeclarSumma then
            begin
              NewPrice:=OldPrice - MInvoiceT_SSDeclarSumma.AsFloat/MInvoiceTDeclarAmount.AsFloat;
              NewPrice:=Round(NewPrice*10000)/10000;
            end;
          //NewPrice := FirstPrice - OldPrice;
          OldSumma := OldPrice * MInvoiceTDeclarAmount.AsFloat;
          try
            // меняем начальную строку
            MInvoiceTDeclar.Edit;
            MInvoiceTDeclarPriceBy.AsFloat := Round(NewPrice*10)/10;
            // сохраняем сумму отклонений
            NewSumma := NewPrice * MInvoiceTDeclarAmount.AsFloat;
            MInvoiceT_SSDeclarSumma.AsFloat:= Round((OldSumma - NewSumma)*10)/10;
            if MInvoiceT_SSDeclarAccount.IsNull then
              with MInvoiceHDeclar do
              begin
                MInvoiceT_SSDeclarAccount.AsString :=Account;
              end;
            if MInvoiceT_SSDeclarKod_StatRash.IsNull then MInvoiceT_SSDeclarKod_StatRash.AsInteger:=0;
            if MInvoiceHDeclarDestDepot.AsInteger<0 then Obj:=1
            else
              begin
                Obj:=StrToInt(Copy(Account,1,2))*10000;
                Obj:=Obj+(MInvoiceHDeclarDestDepot.AsInteger mod 100*100);
                if (MInvoiceHDeclarDestDepot.AsInteger in [43,55,78]) and (Account<>'92.00') then
                  Obj:=Obj+91
                else
                  Obj:=Obj+99;
              end;
            if MInvoiceT_SSDeclarKod_ObjZatr.IsNull then MInvoiceT_SSDeclarKod_ObjZatr.AsInteger:=Obj;
            if MInvoiceForm.AutoFlag then
              begin
                MInvoiceT_SSDeclar.Post;
                MInvoiceTDeclar.Post;
              end;
          except
          end;
        end;
    end;
    GCalc:=False;
  end;
end;

Function TmdMat.MaterialNameFilter(Sender: TObject): string;
begin
//
end;

procedure TmdMat.MInvoiceTDeclarAfterPost(DataSet: TDataSet);
begin
  { Зашли в режим редактирования, но ничего не поменяли }
  // добавим автоматическое списание 50% с перемещения со склада спецодежды
  if (MInvoiceHDeclarOperation.AsInteger=4) and
     (MInvoiceHDeclarSourceDepot.AsInteger in [91,92]) and
     not (MInvoiceHDeclarDestDepot.AsInteger in [91,92]) and
     ((MInvoiceTDeclarKredit.AsString='10.09') or (MInvoiceTDeclarKredit.AsString='10.10')) and
     ((not MInvoiceT_SSDeclar.Active) or (MInvoiceT_SSDeclar.RecordCount=0)) then
  begin
    // добавляем списание
    MInvoiceForm.btnEditSSClick(Self);
    MInvoiceForm.btnSaveSSClick(Self);
  end;
  MasterChange(DataSet);
  MaterialsEditLookupCalc.Refresh;
  MInvoiceTDeclarAfterScroll(DataSet);
end;

{procedure TmdMat.DoCalcOst(IsDelete: boolean; DataSet: TDataSet);
  var OldVal: extended;
      aDepot, aDepot2: integer;
      koff: integer;

procedure DoCalc(iDepot: integer; ikoff: integer);
begin
  with MaterialsEditLookupCalc do begin
    if Locate('Kod;Depot;Price',
      VarArrayOf([MInvoiceTDeclarMaterial.Value,iDepot,MInvoiceTDeclarPriceBy.Value]),[]) then
      Edit
    else begin
      Insert;
      MaterialsEditLookupCalcKod.Value:=MInvoiceTDeclarMaterial.Value;
      MaterialsEditLookupCalcKodUp.Value:=MInvoiceTDeclarMaterialName.ValueByLookName('KodUp');
      MaterialsEditLookupCalcName.Value:=MInvoiceTDeclarMaterialName.ValueByLookName('Name');
      MaterialsEditLookupCalcInvNumber.AsString:=MInvoiceTDeclarMaterialName.StringByLookName('InvNumber');
      MaterialsEditLookupCalcAccount.Value:=MInvoiceTDeclarMaterialName.ValueByLookName('Account');
      MaterialsEditLookupCalcPrice.AsFloat:=MInvoiceTDeclarPriceBy.AsFloat;
      MaterialsEditLookupCalcUnitMName.Value:=MInvoiceTDeclarMaterialName.ValueByLookName('UnitMName');
      MaterialsEditLookupCalcDepot.Value:=iDepot;
    end;
    if not ((MInvoiceHDeclarOperation.Value in [3,18]) and (MInvoiceHDeclarDestDepot.Value=MInvoiceHDeclarSourceDepot.Value)) then
      begin
        if (not isDelete ) and (not VarIsEmpty(MInvoiceTDeclar.OldEditValues))
        and (MInvoiceTDeclarMaterial.Value=MInvoiceTDeclar.OldEditValues[MInvoiceTDeclar.FieldByName('Material').Index]) then
          OldVal:=MInvoiceTDeclar.OldEditValues[MInvoiceTDeclar.FieldByName('Amount').Index]
        else
          OldVal:=0;
        MaterialsEditLookupCalcAmount.Value:=MaterialsEditLookupCalcAmount.Value +
          ikoff * (OldVal - MInvoiceTDeclarAmount.Value);
       end;
  end;
end;
begin
  begin
    if not CheckRashod and not MaterialsEditLookupCalc.Active then Exit;

    with MaterialsEditLookupCalc do begin
      DisableControls;
      aDepot2:=0;
      if CheckRashod then
        begin
          aDepot:=MinvoiceHDeclarSourceDepot.Value;
          if (MInvoiceHDeclarOperation.Value = 4) then
            aDepot2:=MinvoiceHDeclarDestDepot.Value;
          koff:=1;
        end
      else
        begin
          aDepot:=MinvoiceHDeclarDestDepot.Value;
          koff:=-1;
        end;
      if isDelete then begin
        koff := -1 * koff;
      end;
      DoCalc(aDepot, koff);
      if aDepot2<>0 then
        DoCalc(aDepot2, -1*koff);
      Post;
      EnableControls;
    end;
    MasterChange(DataSet);
  end;
 (*** Lev 13.12.2004 ***)
end; }

function TmdMat.CheckRashod: boolean;
begin
 if MInvoiceHDeclarOperation.AsInteger in [4,6,7,8,15] then
   Result:=True
 else
   Result:=False;
end;

procedure TmdMat.MInvoiceHDeclarCalcFields(DataSet: TDataSet);
begin
  if (MInvoiceHDeclarOperation.AsInteger = 3) or (MInvoiceHDeclarOperation.AsInteger = 18) then
    MInvoiceHDeclarSourceCommonName.AsString:=MInvoiceHDeclarClientName.AsString
  else
    MInvoiceHDeclarSourceCommonName.AsString:=MInvoiceHDeclarSourceDepotName.AsString;
  if MInvoiceHDeclarOperation.AsInteger = 7 then
    MInvoiceHDeclarDestCommonName.AsString:=MInvoiceHDeclarRecipientName.AsString
  else
    MInvoiceHDeclarDestCommonName.AsString:=MInvoiceHDeclarDestDepotName.AsString;
  MInvoiceForm.SetLockGlyph(MInvoiceHDeclarIsLock.AsInteger);
end;

procedure TmdMat.MInvoiceT_SSDeclarBeforeEdit(DataSet: TDataSet);
begin
//
  if Assigned(MInvoiceForm) then
    MInvoiceForm.SetEnabledPanel999(True, MInvoiceForm.Panel999);
end;

procedure TmdMat.MInvoiceT_SSDeclarAfterCancel(DataSet: TDataSet);
begin
//
  if Assigned(MInvoiceForm) then
    begin
      MInvoiceForm.SetEnabledPanel999(False, MInvoiceForm.Panel999);
      MInvoiceForm.CheckEditSS(False);
    end;
end;

procedure TmdMat.MInvoiceT_SSDeclarBeforeDelete(DataSet: TDataSet);
  var OldPrice: extended;
begin
  begin
    if MInvoiceTDeclar.Active and
       (MInvoiceTDeclar.RecordCount>0) and
       MInvoiceT_SSDeclar.Active and
       (not MInvoiceTDeclarPrice.IsNull) and
       (not MInvoiceTDeclarAmount.IsNull) then
    begin
      // расчитываем первоначальную цену
      OldPrice:=MInvoiceT_SSDeclarPricePrev.AsFloat;
      try
        // меняем начальную строку
        MInvoiceTDeclar.Edit;
        MInvoiceTDeclarPriceBy.AsFloat := OldPrice;
        MInvoiceTDeclar.Post;
      except
      end;
    end;
  end;
end;

procedure TmdMat.MInvoiceT_SSDeclarAfterEdit(DataSet: TDataSet);
begin
  if Assigned(MInvoiceForm) then
    begin
      MInvoiceForm.CheckEditSS(True);
    end;
end;

procedure TmdMat.MInvoiceTDeclarBeforeEdit(DataSet: TDataSet);
begin
  if (MInvoiceHDeclarOperation.AsInteger = 4) and MInvoiceT_SSDeclar.Active then
    if (MInvoiceT_SSDeclar.RecordCount>0) and (MInvoiceT_SSDeclar.State=dsBrowse) then
      raise EInvalidOp.Create('Перед редактированием удалите запись на списание!');
end;

procedure TmdMat.MInvoice_SSCheckCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMInvoice_SSCheckClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    Grid.OnDblClick:=OnDblClickCheck_SS;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMInvoice_SSCheckClick(Sender: TObject);
begin
  ExecSQLText(MInvoice_SSCheckDeclar.DataBaseName,
     'call STA.GetMCheck_SS('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
  TBEForm(MInvoice_SSCheckC.Form).Caption:='Контроль себестоимости при перемещениях '+
    ' за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  with MInvoice_SSCheckDeclar do
    try
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MInvoice_SSCheckC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.OnDblClickCheck_SS(Sender: TObject);
begin
  // вызов диалога проставления бал.счета и прочих причиндалов...
  //ShowMessage('1');
  if not Assigned(FMInvoiceCheckSS) then
    FMInvoiceCheckSS:=TFMInvoiceCheckSS.Create(Self);
  FMInvoiceCheckSS.Execute(MInvoice_SSCheckDeclarID.AsInteger);
end;

procedure TmdMat.MOborotMatCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportLabel:=TLabel.Create(Form);
    with ReportLabel do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=5;
      Left:=115;
      Width:=200;
      Height:=20;
      Font.Style:=[fsBold];
      Caption:='Наим.материала';
    end;
    ReportEdit:=TEdit.Create(Form);
    with ReportEdit do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=180;
      Height:=20;
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
    end;
    with TLabel.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=5;
      Left:=400;
      Width:=70;
      Height:=20;
      Font.Style:=[fsBold];
      Caption:='за период';
    end;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=465;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=545;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=2;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=630;
      Width:=70;
      Height:=22;
      Name:='BtnCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет';
      OnClick:=CalcMOborotMatClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMOborotMatClick(Sender: TObject);
begin
  ExecSQLText(MOborotMatDeclar.DataBaseName,
     'call STA.GetMOborotMat('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+
     ''','''+ReportEdit.Text+''')',false);
//  TBEForm(MOborotMatC.Form).Caption:='Движение материалов (обороты) по '+ReportDepotMCards.Items[ReportDepotMCards.ItemIndex]+
//    ' за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  try
    MOborotMatDeclar.DisableControls;
    MOborotMatDeclar.Close;
    MOborotMatDeclar.Open;
    MOborotMatDeclar.EnableControls;
  except
  end;
  with TBEForm(MOborotMatC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MAmountsGroupCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;    
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    with TBitBtn.Create(Form) do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMAmountsGroup;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMAmountsGroup(Sender: TObject);
begin
  ExecSQLText(MAmountsGroupDeclar.DataBaseName,
     'call STA.GetMAmountsGroup('''+ReportPeriod_from.Text+''')',false);
  with MAmountsGroupDeclar do
    try
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MAmountsGroupC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.MInvoiceIDsByAccountCCreateForm(Sender: TObject);
 var PnlTop: TPanel;
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;    
    PnlTop:=TPanel.Create(TBEForm(TDBFormControl(Sender).Form));
    PnlTop.Parent:=TBEForm(TDBFormControl(Sender).Form);
    PnlTop.Align:=alTop;
    PnlTop.Height:=60;
    with TLabel.Create(PnlTop) do
      begin
        Parent:=PnlTop;
        Font.Color:=clNavy;
        Top:=2;
        Left:=10;
        Width:=60;
        Height:=20;
        Caption:='Период с';
      end;
    ReportPeriod_from:=TDateEdit.Create(PnlTop);
    with ReportPeriod_from do begin
      Top:=2;
      Left:=75;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      Parent:=PnlTop;
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    with TLabel.Create(PnlTop) do
      begin
        Parent:=PnlTop;
        Font.Color:=clNavy;
        Top:=2;
        Left:=160;
        Width:=20;
        Height:=20;
        Caption:='по';
      end;
    ReportPeriod_to:=TDateEdit.Create(PnlTop);
    with ReportPeriod_to do begin
      Top:=2;
      Left:=185;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      Parent:=PnlTop;
      TabStop:=true;
      TabOrder:=2;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    with TLabel.Create(PnlTop) do
      begin
        Parent:=PnlTop;
        Font.Color:=clNavy;
        Top:=30;
        Left:=10;
        Width:=80;
        Height:=20;
        Caption:='Бал.счет 1';
      end;
    ReportDepotMControl:= TComboBox.Create(PnlTop);
    with ReportDepotMControl do
      begin
        Parent:=PnlTop;
        Top:=25;
        Left:=95;
        Width:=60;
        Height:=20;
        TabStop:=true;
        TabOrder:=3;
      end;
    with TLabel.Create(PnlTop) do
      begin
        Parent:=PnlTop;
        Top:=30;
        Font.Color:=clNavy;
        Left:=160;
        Width:=80;
        Height:=20;
        Caption:='Бал.счет 2';
      end;
    ReportDepotMAmounts2:= TComboBox.Create(PnlTop);
    with ReportDepotMAmounts do
      begin
        Parent:=PnlTop;
        Top:=25;
        Left:=245;
        Width:=60;
        Height:=20;
        TabStop:=true;
        TabOrder:=4;
      end;
    with ModuleCommon.AccountLookup do
      begin
        ReportDepotMAmounts2.Items.Clear;
        ReportDepotMControl.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleCommon.AccountLookup.Eof do
          begin
            ReportDepotMAmounts2.Items.Add(FieldByName('BuhAccount').AsString);
            ReportDepotMControl.Items.Add(FieldByName('BuhAccount').AsString);
            if FieldByName('BuhAccount').AsString='10.01' then
              begin
                ReportDepotMAmounts2.ItemIndex:=ReportDepotMAmounts2.Items.Count-1;
                ReportDepotMControl.ItemIndex:=ReportDepotMControl.Items.Count-1;
              end;
            Next;
          end;
      end;
    with TBitBtn.Create(PnlTop) do begin
      Top:=2;
      Font.Color:=clNavy;
      Left:=310;
      Width:=100;
      Height:=50;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      Parent:=PnlTop;
      OnClick:=CalcMInvoiceIDsByAccountClick;
      TabStop:=true;
      TabOrder:=5;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMInvoiceIDsByAccountClick(Sender: TObject);
begin
  ExecSQLText(MInvoiceIDsByAccountDeclar.DataBaseName,
     'call STA.GetMInvoiceIDsByAccount(''' + ReportPeriod_from.Text +
                                   ''',''' + ReportPeriod_to.Text +
                                   ''',''' + ReportDepotMControl.Text +
                                   ''',''' + ReportDepotMAmounts2.Text +''')',false);
  with MInvoiceIDsByAccountDeclar do
    try
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MInvoiceIDsByAccountC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.MMotionCCreateForm(Sender: TObject);
begin
  TBEForm(TDBFormControl(Sender).Form).Grid.OnDrawColumnCell:=DrawCellMotion;
end;

procedure TmdMat.DrawCellMotion(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (CurPriceMotion <> MMotionDeclarPrice.AsFloat) or (CurAccountMotion <> MMotionDeclarAccount.AsString) then
    begin
      CurPriceMotion := MMotionDeclarPrice.AsFloat;
      CurAccountMotion := MMotionDeclarAccount.AsString;
      CurColorIndex:=(CurColorIndex + 1) mod 2;
    end;
//  TDBGrid(Sender).Canvas.Brush.Color := CurColorArr[CurColorIndex];

  if (Column.Field.DataSet = MMotionDeclar) and
     (Column.Field.DataSet.FieldByName('Amount').Value>0)
      then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clLime;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clGreen;
      end;

  if (Column.Field.DataSet = MMotionDeclar) and
     (Column.Field.DataSet.FieldByName('Amount').Value<0)  then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clYellow;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clMaroon;
      end;




  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MMotionCActivateForm(Sender: TObject);
begin
  CurColorIndex:=0;
end;

procedure TmdMat.ShowDrgWindow;
  var i: byte;

 procedure Insert(sField, sText: string);
 begin
  with MInvoiceTDeclarMaterialName,FMInvoiceDragInfo do
    if not VarIsNull(ValueByLookName(sField)) then
      begin
        Grid.RowCount := i + 1;
        Grid.Cells[0,i] := sText;
        Grid.Cells[1,i] := ValueByLookName(sField);
        inc(i);
      end;
 end;
begin
  // драгметаллы
  with MInvoiceTDeclarMaterialName do
   if (not MInvoice.MInvoiceForm.Visible) or
      (not MInvoice.MInvoiceForm.XEDbGrid1.Focused) or
      ((ValueByLookName('Gold') = null) and
      (ValueByLookName('Platinum') = null) and
      (ValueByLookName('Silver') = null) and
      (ValueByLookName('Palladium') = null) and
      (ValueByLookName('Rutenium') = null) and
      (ValueByLookName('Rodium') = null) and
      (ValueByLookName('Iridium') = null))
    then
      begin
        if Assigned(FMInvoiceDragInfo) then
          FMInvoiceDragInfo.Hide;
      end
    else
      begin
        if not Assigned(FMInvoiceDragInfo) then
          begin
            FMInvoiceDragInfo:=TFMInvoiceDragInfo.Create(Self);
            with FMInvoiceDragInfo do
              begin
                Left := MInvoice.MInvoiceForm.Left + MInvoice.MInvoiceForm.Width - Width - 5;
                Top := 50;
                i := 0;
              end;
          end;
        Insert('Gold','Золото');
        Insert('Silver','Серебро');
        Insert('Platinum','Платина');
        Insert('Palladium','Палладий');
        Insert('Rutenium','Рутений');
        Insert('Rodium','Родий');
        Insert('Iridium','Иридий');
        FMInvoiceDragInfo.Show;
        MInvoice.MInvoiceForm.SetFocus;
      end;
end;

procedure TmdMat.MInvoiceCCloseForm(Sender: TObject;
  var Action: TCloseAction);
begin
//  MInvoice.MInvoiceForm.Hide;
//  ShowDrgWindow;
end;

procedure TmdMat.MInvoiceCActivateForm(Sender: TObject);
begin
// ShowDrgWindow;
end;

procedure TmdMat.CheckDrgOper;
 var Kod: variant;
begin
  if MInvoiceTDeclar.FieldByName('KodDrgOper').IsNull then
    with MInvoiceTDeclarMaterialName do
      if(ValueByLookName('Gold') <> null) or
        (ValueByLookName('Platinum') <> null) or
        (ValueByLookName('Silver') <> null) or
        (ValueByLookName('Palladium') <> null) or
        (ValueByLookName('Rutenium') <> null) or
        (ValueByLookName('Rodium') <> null) or
        (ValueByLookName('Iridium') <> null)
      then
      begin
        Kod:=GetFromSQLText('AO_GKSM_InProgram','select IsNull(kod,0) from STA.MDrgOper where Operation='+
          MInvoiceHDeclar.FieldByName('Operation').AsString,false);
        if not VarIsNull(Kod) then
           MInvoiceTDeclar.FieldbyName('KodDrgOper').Value:=Kod;
      end;
end;

procedure TmdMat.MDrgOperMoveCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMDrgOperMove_from:=TDateEdit.Create(Form);
    with ReportPeriodMDrgOperMove_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriodMDrgOperMove_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriodMDrgOperMove_to:=TDateEdit.Create(Form);
    with ReportPeriodMDrgOperMove_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriodMDrgOperMove_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=295;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMDrgOperMove;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMDrgOperMove(Sender: TObject);
begin
  ExecSQLText(MDrgOperMoveDeclar.DataBaseName,
     'call STA.GetMDrgOper('''+ReportPeriodMDrgOperMove_from.Text+''','''+ReportPeriodMDrgOperMove_to.Text+''')',false);
  TBEForm(MDrgOperMoveC.Form).Caption:='Движение драгметаллов за период с '+ReportPeriodMDrgOperMove_from.Text+ ' по '+ReportPeriodMDrgOperMove_to.Text;
  with MDrgOperMoveDeclar do
    try
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MDrgOperMoveC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.MaterialsCCreateForm(Sender: TObject);
begin
  {AMScaleForm(TFormMat(MaterialsC.Form));}
end;

procedure TmdMat.CalcMAmounts2Click(Sender: TObject);
  var Material, PriceUc: extended;
      Depot, i: integer;
      Cond: TListObj;
begin
 if MAmounts.Declar.Active and
    (MAmounts.Declar.RecordCount>0) then
    begin
      Material:= MAmounts.Declar.FieldByName('Material').AsFloat;
      PriceUC:= MAmounts.Declar.FieldByName('PriceUc').Value;
      Depot:= Integer(ReportDepotMAmounts.KeyValue);
      if not MMotionDeclar.Active then
        MMotionDeclar.Active:=True;
      MMotionC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MMotionC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='MATERIAL' then Value:=Material
          else if AnsiUpperCase(FieldName)='PRICEUC' then Value:=PriceUC
          else if AnsiUpperCase(FieldName)='DEPOT' then Value:=Depot;
      MMotionC.PlayInquiry(MMotionC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.CalcMFindClick2(Sender: TObject);
  var Material, PriceUc: extended;
      Depot, i: integer;
      Cond: TListObj;
begin
 if MFind.Declar.Active and
    (MFind.Declar.RecordCount>0) then
    begin
      Material:= MFind.Declar.FieldByName('Material').AsFloat;
      PriceUC:= MFind.Declar.FieldByName('PriceUC').AsFloat;
      Depot:= MFind.Declar.FieldByName('Depot').AsInteger;
      if not MMotionDeclar.Active then
        MMotionDeclar.Active:=True;
      MMotionC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MMotionC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='MATERIAL' then Value:=Material
          else if AnsiUpperCase(FieldName)='PRICEUC' then Value:=PriceUC
          else if AnsiUpperCase(FieldName)='DEPOT' then Value:=Depot;
      MMotionC.PlayInquiry(MMotionC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.CalcMRashWorkClick2(Sender: TObject);
  var i: integer;
      Dat: TDateTime;
      Osn, Kor: string[5];
      Depot, Kod_OZ: integer;
      Obj: integer;
      Cond: TListObj;
begin
 if MRashWork.Declar.Active and
    (MRashWork.Declar.RecordCount>0) then
    begin
      Dat:= MRashWork.Declar.Tag;
      Osn:= MRashWork.Declar.FieldByName('Osn').Value;
      Kor:= MRashWork.Declar.FieldByName('Kor').Value;
      Depot:=MRashWork.Declar.FieldByName('Depot').AsInteger;
      Kod_OZ:=MRashWork.Declar.FieldByName('KodObjZatr').AsInteger;
      if not MSpisanieDeclar.Active then
        MSpisanieDeclar.Active:=True;
      MSpisanieC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MSpisanieC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='DATEDOC' then Value:=Dat
          else if AnsiUpperCase(FieldName)='OSN' then Value:=Osn
          else if AnsiUpperCase(FieldName)='KOR' then Value:=Kor
          else if AnsiUpperCase(FieldName)='DEPOT' then Value:=Depot
          else if AnsiUpperCase(FieldName)='KOD_OBJZATR' then Value:=Kod_OZ;
      MSpisanieC.PlayInquiry(MSpisanieC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.MSpisanieCCreateForm(Sender: TObject);
begin
  TBEForm(TDBFormControl(Sender).Form).Grid.OnDrawColumnCell:=DrawCellSpisanie;
end;

procedure TmdMat.DrawCellSpisanie(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var CurColor: TColor;
begin
  if MSpisanieDeclarPRZ_FULL.AsInteger=1 then
    CurColor:=TColor($f0f0f0)
  else
    CurColor:=TColor($fafafa);
  TDBGrid(Sender).Canvas.Brush.Color := CurColor;
  TDBGrid(Sender).Canvas.Font.Color  := clBlack;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.MAmounts_BUHCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMAmounts:=TDateEdit.Create(PageControl1TabPanel);
    with ReportPeriodMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriodMAmounts';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1);
    end;
    ReportDepotMAmounts:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMAmounts';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup; //ModuleBase.DepotLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=GetDefaultDepot;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    {with ModuleBase.DepotDeclar do
      begin
        ReportDepotMAmounts.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMAmounts.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportDepotMAmounts.ItemIndex:=ReportDepotMAmounts.Items.Count-1;
            Next;
          end;
      end;}
    BtnCalcMAmounts:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMAmounts_BUHClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMAmounts2:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=645;
      Width:=30;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMAmounts_BUH2Click;
      TabStop:=true;
      TabOrder:=3;
    end;
    BtnCalcMAmounts3:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts3 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=680;
      Width:=33;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts3';
      Font.Style:=[fsBold];
      Caption:='карт';
      OnClick:=CalcMAmounts_BUH3Click;
      TabStop:=true;
      TabOrder:=4;
    end;
    PageControl1TabPanel.AutoSize:=True;
    Grid.OnDrawColumnCell:=DrawCellAmount;
  end;

end;

procedure TmdMat.OpenDokHistory(ADeclar:TLinkTable; AMaterial, APriceUc: extended; ADepot: integer;
  DepotFieldName: string = 'DEPOT';
  PriceFieldName: string = 'PRICEUC';
  MaterialFieldName: string = 'MATERIAL');
  var i: integer;
      Cond: TListObj;
begin
 if ADeclar.Active and
    (ADeclar.RecordCount>0) then
    begin
      if not MMotionDeclar.Active then
        MMotionDeclar.Active:=True;
      MMotionC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MMotionC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)=AnsiUpperCase(MaterialFieldName) then Value:=AMaterial
          else if AnsiUpperCase(FieldName)=AnsiUpperCase(PriceFieldName) then Value:=APriceUC
          else if AnsiUpperCase(FieldName)=AnsiUpperCase(DepotFieldName) then Value:=ADepot;
      MMotionC.PlayInquiry(MMotionC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.CalcMAmounts_BUH2Click(Sender: TObject);
  var Material, PriceUc: extended;
      Depot, i: integer;
      Cond: TListObj;
begin
 if MAmounts_BUH.Declar.Active and
    (MAmounts_BUH.Declar.RecordCount>0) then
    begin
      Material:= MAmounts_BUH.Declar.FieldByName('Material').AsFloat;
      PriceUC:= MAmounts_BUH.Declar.FieldByName('PriceUC').AsFloat;
      Depot:= Integer(ReportDepotMAmounts.KeyValue);
      if not MMotionDeclar.Active then
        MMotionDeclar.Active:=True;
      MMotionC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MMotionC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='MATERIAL' then Value:=Material
          else if AnsiUpperCase(FieldName)='PRICEUC' then Value:=PriceUC
          else if AnsiUpperCase(FieldName)='DEPOT' then Value:=Depot;
      MMotionC.PlayInquiry(MMotionC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.CalcMAmounts_BUHClick(Sender: TObject);
//var
//  Cond: TListObj;
begin
  ExecSQLText(MAmounts_BUHDeclar.DataBaseName,
     'call STA.GetMAmountsBuh('''+ReportPeriodMAmounts.Text+
     ''','+IntToStr(Integer(ReportDepotMAmounts.KeyValue))+')',false);
  TBEForm(MAmounts_BUHC.Form).Caption:='Остатки материалов по '+SprDepotAdvLookupName.AsString+
     ' ('+SprDepotAdvLookupKod.AsString+') на '+ReportPeriodMAmounts.Text;
  with TBEForm(MAmounts_BUHC.Form).Grid do begin
    MAmounts_BUHDeclar.Fields[9].Visible:=Integer(ReportDepotMAmounts.KeyValue)=0;
    FormatColumns(true);
    with TBEForm(MAmounts_BUHC.Form).Grid.DataSource.DataSet do
      begin
        FieldByName('SUMMA').DisplayWidth:=FieldByName('PRICE').DisplayWidth;
        FieldByName('PRIHDOC').DisplayWidth:=10;
 //       FieldByName('POSITION').DisplayWidth:=15;
      end;
    SetFocus;
  end;
//  Cond:=TFilterItem(TXInquiryItem(MAmounts_BUHC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
//  MAmountsC.PlayInquiry(MAmounts_BUHC.Inquiries[0],Cond);
  try
    MAmounts_BUHDeclar.Active:=False;
    MAmounts_BUHDeclar.Active:=True;
  except
  end;
end;

procedure TmdMat.MInvoiceTDeclarAfterOpen(DataSet: TDataSet);
begin
  if MInvoiceTDeclarMaterialName.DisplayWidth < 21 then
     MInvoiceTDeclarMaterialName.DisplayWidth :=
        MaterialsEditDeclarKod.DisplayWidth+
        MaterialsEditDeclarName.DisplayWidth +
        MaterialsEditDeclarUnitMName.DisplayWidth + 2;
end;

procedure TmdMat.MInvoiceHDeclarAfterOpen(DataSet: TDataSet);
begin
  MasterChange(DataSet);
end;

procedure TmdMat.ShowMCard(AMaterial: extended; ADepot: integer;
  APriceUC: extended; Adt_from, Adt_to: TDateTime; AAccount: string; APrice: extended);
var i: integer;
  s1, s2, s3, s4,  s5, s6, s7, s8, ss1, ss2, s9, s10: string;
begin
  MCardC.Execute;
  s2:=FloatToStr(AMaterial);
  s4:=FloatToStr(APriceUC);
  s10:=FloatToStr(APrice);

  s1:=IntToStr(ADepot);
  ss1:= FormatDateTime('dd.mm.yyyy',Adt_from);
  ss2:= FormatDateTime('dd.mm.yyyy',Adt_to);
  ExecSQLText(MCard.DataBaseName,
         'call STA.GetMCard('+s2+', '+s4+', '+s1+', '''+ss1+''', '''+ss2+''','''+aAccount+''');',false);

  if not Assigned(TempQuery) then
     begin
       TempQuery:=TQuery.Create(Self);
       TempQuery.DatabaseName:=MaterialsEdit.DatabaseName;
     end;
  TempQuery.SQL.Text:='begin declare oAm numeric(15,4); declare oSum numeric(18,2); ' +
     ' call STA.GetMAmountAndSum(''' + ss2 + ''', ' + s1 + ', ' + s2 + ', ' + s4 + ', oAm, oSum,'''+aAccount+'''); ' +
     ' select oAm, oSum from dummy; end; ' ;
  try
    TempQuery.Open;
    s5:=TempQuery.Fields[0].AsString;
    s6:=TempQuery.Fields[1].AsString;
  except
  end;

  TempQuery.SQL.Text:='select Name from STA.SprDepot where kod= '+s1 ;
  try
    TempQuery.Open;
    s1:=s1+' - '+TempQuery.Fields[0].AsString;
  except
  end;

  TempQuery.SQL.Text:='select M.Name, M.Account, U.ShortN from STA.Materials M, STA.SprUnitM U where M.kod= '+s2+' and U.Kod=M.UnitM ' ;
  try
    TempQuery.Open;
    s3:=TempQuery.Fields[0].AsString;
    s7:=AAccount;
    s8:=TempQuery.Fields[2].AsString;
  except
  end;

  //s4:=Trim(Format('%18n',[APriceUC]));

  for i:=0 to CardPanel.ControlCount -1 do
    case CardPanel.Controls[i].Tag of
      1: TLabel(CardPanel.Controls[i]).Caption:=s1;
      2: TLabel(CardPanel.Controls[i]).Caption:=s2;
      3: TLabel(CardPanel.Controls[i]).Caption:=s3;
      4: TLabel(CardPanel.Controls[i]).Caption:='приход: '+s4+'  цена остатков: '+s10;
      5: TLabel(CardPanel.Controls[i]).Caption:=s5;
      6: TLabel(CardPanel.Controls[i]).Caption:=s6;
      7: TLabel(CardPanel.Controls[i]).Caption:=s7;
      8: TLabel(CardPanel.Controls[i]).Caption:=s8;
    end;
  MCardDeclar.Refresh;
end;

procedure TmdMat.MCardC1Click(Sender: TObject);
begin
// ShowMCard(210004, 18, 1559, StrToDate('01.01.1900'), Date+30,'10.00');
end;

procedure TmdMat.MCardCCreateForm(Sender: TObject);
begin
  TBEForm(MCardC.Form).Caption:='Карточка материала';
  if Not Assigned(MServiceForm) then MServiceForm := TMServiceForm.Create(nil);
  if not Assigned(CardPanel) then
      CardPanel := MServiceForm.Panel1.Create(nil);
  //MServiceForm.Panel1.Create(Self);
  //CardPanel.Assign(MServiceForm.Panel1);
  CardPanel.Parent := TBEForm(MCardC.Form).GridSheet;
  CardPanel.Top := 1;
  CardPanel.Height := 140;
  CardPanel.Align := alTop;
  with TBEForm(MCardC.Form) do begin
   Grid.OnDrawColumnCell:=DrawCellMCard;
    with TBitBtn.Create(PageControl1TabPanel) do begin
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=200;
        Width:=100;
        Height:=22;
        Parent:=PageControl1TabPanel;
        Name:='BtnCalcMCardInt';
        Font.Style:=[fsBold];
        Caption:='Перерасчет формы';
        OnClick:=CalcMCardIntClick;
        TabStop:=true;
        TabOrder:=2;
    end;
  end;

end;

procedure TmdMat.MCardCDestroyForm(Sender: TObject);
begin
  if Assigned(CardPanel) then CardPanel.Free;
  if Assigned(MServiceForm) then MServiceForm.Free;
end;

procedure TmdMat.CalcMAmounts_BUH3Click(Sender: TObject);
begin
 if MAmounts_BUHDeclar.Active and
    (MAmounts_BUHDeclar.RecordCount>0) then
    begin
     ShowMCard(MAmounts_BUHDeclarMaterial.AsFloat,
        Integer(ReportDepotMAmounts.KeyValue),
         MAmounts_BUHDeclarPriceUC.AsFloat,
         StrToDate('01.01.1950'), Date+30, MAmounts_BUHDeclarAccount.AsString,MAmounts_BUHDeclarPriceUC.AsFloat);
    end;
end;

procedure TmdMat.CalcMCards2Click(Sender: TObject);
begin
 if MCardsDeclar.Active and
   (MCardsDeclar.RecordCount>0) then
    with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.Dataset do
      begin
        ShowMCard(FieldByName('Material').AsFloat,
          Integer(ReportDepotMCards.KeyValue),
           FieldByName('PriceUC').AsFloat,
           StrToDate('01.01.1950'), Date+30,FieldByName('KREDIT').AsString,FieldByName('PriceUC').AsFloat);
      end;
end;

procedure TmdMat.MOsnastkaCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportMOsnastka:=TComboBox.Create(PageControl1TabPanel);
    if UserName='ADMIN' then
      begin
        MOsnastkaDeclarPriceUC.Visible:=True;
        MOsnastkaDeclarPriceUCName.Visible:=False;
      end
    else
      begin
        MOsnastkaDeclarPriceUC.Visible:=False;
        MOsnastkaDeclarPriceUCName.Visible:=True;
      end;
    with ReportMOsnastka do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='ReportMOsnastkaC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=0;
    end;
    with ModuleBase.DepotDeclar do
      begin
        ReportMOsnastka.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportMOsnastka.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportMOsnastka.ItemIndex:=ReportMOsnastka.Items.Count-1;
            Next;
          end;
      end;
    ReportMOsnastka.OnChange:=OnMOsnastkaChange;
    OnMOsnastkaChange(Sender);
    PageControl1TabPanel.AutoSize:=True;
    Grid.OnDrawColumnCell:=DrawCellAmount;
  end;
end;

procedure TmdMat.OnMOsnastkaChange(Sender: TObject);
  var Depot: integer;
begin
  Depot:=Integer(ReportMOsnastka.Items.Objects[ReportMOsnastka.ItemIndex]);
  with MOsnastkaDeclar do
    begin
      Filtered:=False;
      Filter:='Depot='+IntToStr(Depot);
      Filtered:=True;
    end;
end;

procedure TmdMat.MOsnastkaDeclarNewRecord(DataSet: TDataSet);
begin
  MOsnastkaDeclarPercent.Value:=0;
  MOsnastkaDeclarDepot.Value:=Integer(ReportMOsnastka.Items.Objects[ReportMOsnastka.ItemIndex]);
end;

procedure TmdMat.MOsnastkaDeclarKodChange(Sender: TField);
begin
  with MOsnastkaDeclar do
    if Sender.DataSet.State=dsInsert then
      begin
        (FieldByName('KodName') as TXELookField).ValueByLookNameToField('Name',FieldByName('sName'));
        (FieldByName('KodName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Account'));
        (FieldByName('KodName') as TXELookField).ValueByLookNameToField('Amount',FieldByName('Amount'));
        if FieldByName('sName').IsNull then FieldByName('sName').AsString:=''

      end;
end;

function TmdMat.MOsnastkaDeclarKodNameFilter(Sender: TObject): String;
begin
  if UserName<>'ADMIN' then
   Result:='( Depot=91 ) and ( Amount>0 )';// and ( Account>=''10.20'') and ( Account<=''10.30'')';
end;

function TmdMat.MInvoiceHDeclarOperationNameFilter(
  Sender: TObject): String;
begin
//  Result:=' Kod in (3, 4, 6, 7, 8, 11, 13, 16) '
  Result:=' (Kod=3) or (Kod=4) or (Kod=6) or (Kod=7) or (Kod=8) or (Kod=9) or (Kod=11) or (Kod=13) or (Kod=16) or (Kod=18) '
end;

procedure TmdMat.ShowServiceInfo;
  var ss: string;
begin
  ss := 'Проверка параметров: ';
  ss := ss + #13 + 'LookUp = '+IntToStr(Integer(MInvoiceTDeclarMaterialName.LookupDataSet.Active));
  ss := ss + #13 + 'LookUpName = '+MInvoiceTDeclarMaterialName.LookupDataSet.Name;
  ss := ss + #13 + 'MaterialsEditLookup = '+IntToStr(Integer(MaterialsEditLookup.Active));
  ss := ss + #13 + 'MaterialsEditLookupCalc = '+IntToStr(Integer(MaterialsEditLookupCalc.Active));
  ss := ss + #13 + 'Filter MaterialsEditLookup = <'+MaterialsEditLookup.Filter+'>';
  ss := ss + #13 + 'Filter MaterialsEditLookupCalc = <'+MaterialsEditLookupCalc.Filter+'>';

  ShowMessage(ss);
end;

procedure TmdMat.GetPricesOsnastka(DataSet: TDataSet);
begin
  if PriceLookup.Active then PriceLookup.Close;
  PriceLookup.ParamByName('Mat').AsInteger:=MOsnastkaDeclarKod.AsInteger;
  PriceLookup.ParamByName('Depot').AsInteger:=91;
  PriceLookup.ParamByName('Position').AsDateTime:=Now;
  PriceLookup.Open;
end;

function TmdMat.MOsnastkaDeclarPriceUCNameFilter(Sender: TObject): String;
begin
  GetPricesOsnastka(MOsnastkaDeclar);
end;

procedure TmdMat.MOsnastkaCurCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMAmounts:=TDateEdit.Create(PageControl1TabPanel);
    with ReportPeriodMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=105;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriodMAmounts';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := GetLastDayOfMonth(SysUtils.Date);
    end;
    ReportDepotMAmounts:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=190;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=ModuleBase.DepotLookup;
      ListSource:=DataSource1;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      KeyValue:=GetDefaultDepot;
      Name:='DepotCalcMAmounts';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    {with ModuleBase.DepotDeclar do
      begin
        ReportDepotMAmounts.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMAmounts.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportDepotMAmounts.ItemIndex:=ReportDepotMAmounts.Items.Count-1;
            Next;
          end;
      end;}
    BtnCalcMAmounts:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=495;
      Width:=60;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMOsnastkaCur';
      Font.Style:=[fsBold];
      Caption:='Расчет';
      OnClick:=CalcMOsnastkaCurClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMAmounts2:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=560;
      Width:=60;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMOsnastkaCur2';
      Font.Style:=[fsBold];
      Caption:='Внести';
      OnClick:=CalcMOsnastkaCurClickDoc;
      TabStop:=true;
      TabOrder:=3;
    end;
    BtnCalcMAmounts3:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts3 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=625;
      Width:=60;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMOsnastkaCur3';
      Font.Style:=[fsBold];
      Caption:='Удалить';
      OnClick:=CalcMOsnastkaCurClickDel;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.AutoSize:=True;
    Grid.OnDrawColumnCell:=DrawCellAmount;
  end;
end;

procedure TmdMat.CalcMOsnastkaCurClick(Sender: TObject);
begin
  ExecSQLText(MOsnastkaCurDeclar.DataBaseName,
     'call STA.GetMOsnastka('+IntToStr(Integer(ReportDepotMAmounts.KeyValue))+','''+ReportPeriodMAmounts.Text+''')',false);
  with TBEForm(MOsnastkaCurC.Form).Grid do begin
    TBEForm(MOsnastkaCurC.Form).Caption:='Состояние спецодежды/оснастки по '+ModuleBase.DepotLookupName.AsString+
     ' ('+ModuleBase.DepotLookupKod.AsString+') на '+ReportPeriodMAmounts.Text;
    SetFocus;
  end;
  try
    MOsnastkaCurDeclar.Refresh;
  except
  end;
end;

procedure TmdMat.CalcMOsnastkaCurClickDoc(Sender: TObject);
begin
  // вставляем расчитанные суммы в документы
  if MessageDlg('Внести расчитанные изменения на подразделения?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
    begin
      ExecSQLText(MOsnastkaCurDeclar.DataBaseName,
         'call STA.GetMOsnastkaInsert('+IntToStr(Integer(ReportDepotMAmounts.KeyValue))+','''+ReportPeriodMAmounts.Text+''')',false);

      with TBEForm(MOsnastkaCurC.Form).Grid do begin
        SetFocus;
      end;
    end;
end;

function TmdMat.GetFirstDayOfMonth(date: TDateTime): TDateTime;
 var Year, Month, Day: Word;
begin
 DecodeDate(date,Year, Month, Day);
 Result:=EncodeDate(Year, Month, 1);
end;

function TmdMat.GetLastDayOfMonth(date: TDateTime): TDateTime;
begin
  Result:=GetFirstDayOfMonth(Date);
  Result:=IncMonth(Result,1)-1;
end;

procedure TmdMat.CalcMOsnastkaCurClickDel(Sender: TObject);
begin
  // удаляем расчитанные суммы из документы
  if MessageDlg('Удалить расчет месяца из документов подразделения?',mtConfirmation,[mbYes, mbNo],0)=mrYes then
    begin
      ExecSQLText(MOsnastkaCurDeclar.DataBaseName,
         'call STA.GetMOsnastkaInsert('+IntToStr(Integer(ReportDepotMAmounts.KeyValue))+','''+ReportPeriodMAmounts.Text+''',1)',false);

      with TBEForm(MOsnastkaCurC.Form).Grid do begin
        SetFocus;
      end;
    end;
end;

procedure TmdMat.CalcMCardIntClick(Sender: TObject);
begin
//
end;

procedure TmdMat.AssignAccounts;
  var Kredit, Debit: string;
begin
  with MInvoiceTDeclar do
    begin
      AutoCalcFields:=true;
      Kredit:=FieldByName('Kredit').AsString;
      Debit:=FieldByName('Debit').AsString;
//      FieldByName('Debit').Clear;
      case MInvoiceHDeclarOperation.AsInteger of
 3,9,10,11,13,14,16,18: begin
              (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Debit'));
              if FieldByName('Debit').AsString='' then FieldByName('Debit').AsString:=Debit;
              // обработка ситуации с 10/10-10/11
              if not (MInvoiceHDeclarDestDepot.AsInteger in SkladSet) and
                 (FieldByName('Debit').AsString='10.10') then FieldByName('Debit').AsString:='10.11';
              if (Copy(FieldByName('Debit').AsString,1,2)='10') and (Trim(FieldByName('Kredit').AsString)='') then
                  FieldByName('Kredit').AsString:=MInvoiceHDeclarKredit.AsString;
              //В валютных накладных надо вводить контракт в каждую строку!
              //(FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Contract',FieldByName('Contract'));
             end;
          4: begin
              if MInvoiceTDeclarDebit.IsNull then
                   (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Debit'));
              (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Kredit'));
              if FieldByName('Debit').AsString='' then FieldByName('Debit').AsString:=Debit;
              if FieldByName('Kredit').AsString='' then FieldByName('Kredit').AsString:=Kredit;

              // обработка ситуации с 10/10-10/11
              if not (MInvoiceHDeclarSourceDepot.AsInteger in SkladSet) and
                 (FieldByName('Kredit').AsString='10.10') then FieldByName('Kredit').AsString:='10.11';
              if not (MInvoiceHDeclarDestDepot.AsInteger in SkladSet) and
                 (FieldByName('Debit').AsString='10.10') then FieldByName('Debit').AsString:='10.11';
             end;
    6,7,8,15:
             begin
              (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Kredit'));
              if FieldByName('Kredit').AsString='' then FieldByName('Kredit').AsString:=Kredit;

              // обработка ситуации с 10/10-10/11
              if not (MInvoiceHDeclarSourceDepot.AsInteger in SkladSet) and
                 (FieldByName('Kredit').AsString='10.10') then FieldByName('Kredit').AsString:='10.11';
             end;

      end;
    end;
end;

procedure TmdMat.MDrgInventCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMDrgInvent:=TDateEdit.Create(PageControl1TabPanel);
    with ReportPeriodMDrgInvent do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriodMDrgInvent';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := SysUtils.Date+1;
    end;

    ReportDepotMDrgInvent:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMDrgInvent do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMAmounts';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup; //ModuleBase.DepotLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=91;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;

    BtnCalcMDrgInvent:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMDrgInvent do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMDrgInvent';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMDrgInventClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.AutoSize:=True;
    //Grid.OnDrawColumnCell:=DrawCellAmount;
  end;
end;

procedure TmdMat.CalcMDrgInventClick(Sender: TObject);
var
  Cond: TListObj;
begin
  ExecSQLText(MDrgInventDeclar.DataBaseName,
     'call STA.GetMDrgInvent('''+ReportPeriodMDrgInvent.Text+
     ''','+IntToStr(Integer(ReportDepotMDrgInvent.KeyValue))+')',false);
  TBEForm(MDrgInventC.Form).Caption:=SprDepotAdvLookupName.AsString+
     ' ('+SprDepotAdvLookupKod.AsString+') на '+ReportPeriodMDrgInvent.Text;
  try
    MDrgInventDeclar.Refresh;
  except
  end;
end;

procedure TmdMat.MFakturaCCreateForm(Sender: TObject);
var
  Cond: TListObj;
  i: integer;
  FromFormStart: boolean; { Если вызов был из главной формы, то вызываем запрос, иначе - не вызываем. Lev 12.09.08 }
begin
  Changing:=False;
  FromFormStart:=(Screen.ActiveForm.Name='FormStart');
  MFakturaC.Execute;
  if FromFormStart then
    with TBEForm(MFakturaC.Form).Grid do begin
      FormatColumns(true);
      Cond:=TFilterItem(TXInquiryItem(MFakturaC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if i=0 then
            Value:=DateToStr(WorkDate)
          else
            if i=1 then Value:=DateToStr(IncMonth(WorkDate,1))
          else if AnsiUpperCase(FieldName)='DEBIT' then Value:=GetAccountByUser
          else if AnsiUpperCase(FieldName)='KREDIT' then Value:=GetAccountByUser;

      MFakturaC.PlayInquiry(MFakturaC.Inquiries[0],Cond);
      Refresh;
      //SetFocus;
    end;
end;

procedure TmdMat.MFakturaDeclarAfterScroll(DataSet: TDataSet);
begin
  (*MFakturaTDeclar.Filtered:=False;
  if MFakturaDeclar.RecordCount>0 then
    MFakturaTDeclar.Filter:='ID='+MFakturaDeclarID.AsString
  else
    MFakturaTDeclar.Filter:='ID=-1';
  MFakturaTDeclar.Filtered:=True;*)
  //MFakturaDeclar.Refresh;
  {MFakturaDeclarCurrencyChange(MFakturaDeclarID);}
end;

procedure TmdMat.MFakturaDeclarBeforePost(DataSet: TDataSet);
  var ID: integer;
begin
  if MFakturaDeclar.State in [dsInsert] then
     begin
       ID:=GetFromSQLText('AO_GKSM_InProgram','Select IsNull(Max(ID),0)+1 from sta.MFaktura',false);
       MFakturaDeclarID.AsInteger:=ID;
     end;
end;

procedure TmdMat.MFakturaDeclarTotalChange(Sender: TField);
begin
  RecalcFakturaSum;
end;

procedure TmdMat.RecalcFakturaSum;
  var Sum: extended;
      SumBy: extended;
      isRight: boolean;
begin
  isRight := True;
  if not Changing then  // лекарство от зацикливания :(
    begin
      Changing:=True;
      if Assigned(TBEForm(MFakturaC.Form)) then
        isRight := not TMFakturaForm(MFakturaC.Form).cbUp.Checked;
      if not isRight then
        begin
          sum := MFakturaDeclarSummaNDS.AsFloat;
          sumBy := MFakturaDeclarSummaNDSBy.AsFloat;
          // вычитаются суммы по гриду...
          if (MFakturaTDeclar.Active) and (MFakturaTDeclar.RecordCount>0) then
            begin
              MFakturaTDeclar.First;
              while not MFakturaTDeclar.Eof do
                begin
                  sum:=sum+MFakturaTDeclarSumma.AsFloat;
                  sumBy:=sumBy+MFakturaTDeclarSummaBy.AsFloat;
                  MFakturaTDeclar.Next;
                end;
              MFakturaTDeclar.First;
            end;
          MFakturaDeclar.Edit;
          sum := sum + MFakturaDeclarSumma.AsFloat;
          sumBy := sumBy + MFakturaDeclarSummaBy.AsFloat;
          MFakturaDeclarTotal.AsFloat:=sum;
          MFakturaDeclarTotalBy.AsFloat:=sumBy;
        end
      else
        begin
          sum:=MFakturaDeclarTotal.AsFloat - MFakturaDeclarSummaNDS.AsFloat;
          sumBY:=MFakturaDeclarTotalBy.AsFloat - MFakturaDeclarSummaNDSBy.AsFloat;
          // вычитаются суммы по гриду...
          if (MFakturaTDeclar.Active) and (MFakturaTDeclar.RecordCount>0) then
            begin
              MFakturaTDeclar.First;
              while not MFakturaTDeclar.Eof do
                begin
                  sum:=sum-MFakturaTDeclarSumma.AsFloat;
                  sumBy:=sumBY-MFakturaTDeclarSummaBy.AsFloat;
                  MFakturaTDeclar.Next;
                end;
              MFakturaTDeclar.First;
            end;
          MFakturaDeclar.Edit;
          MFakturaDeclarSumma.AsFloat:=sum;
          MFakturaDeclarSummaBy.AsFloat:=sumBy;
        end;
      if MFakturaDeclarCurrency.Value=974 then
         begin
           MFakturaDeclarSummaNDSBy.AsFloat:=MFakturaDeclarSummaNDS.AsFloat;
           MFakturaDeclarSummaBy.AsFloat:=MFakturaDeclarSumma.AsFloat;
           MFakturaDeclarTotalBy.AsFloat:=MFakturaDeclarTotal.AsFloat;
         end;
      Changing:=False;
    end;
end;

procedure TmdMat.MFakturaDeclarNewRecord(DataSet: TDataSet);
begin
  MFakturaDeclarID.AsInteger:=-1;
  MFakturaDeclarKredit.AsString:=GetAccountByUser;
  MFakturaDeclarSectionD.AsInteger:=0;
  MFakturaDeclarSectionK.AsInteger:=0;
  if MFakturaDeclarKredit.AsString='76.04' then
    begin
      MFakturaDeclarDebit.AsString:='44.00';
      MFakturaDeclarSectionD.AsInteger:=4;
    end;

  MFakturaDeclarCurrency.AsInteger:=974;
  {MFakturaDeclarSummaClose.AsInteger:=0;} // Потенциальный источник ошибок!!! Это действие делает тригер на сервере. Lev - 08.01.2009
  MFakturaDeclarSummaCustomBy.AsFloat:=0;
end;

procedure TmdMat.MFakturaDeclarAfterOpen(DataSet: TDataSet);
begin
  MFakturaTDeclar.Active:=True;
end;

procedure TmdMat.MFakturaTDeclarNewRecord(DataSet: TDataSet);
  var ID: integer;
begin
  ID:=GetFromSQLText('AO_GKSM_InProgram','Select IsNull(Max(TabID),0)+1 from sta.MFakturaT',false);
  MFakturaTDeclarTabID.AsInteger:=ID;
  MFakturaTDeclarID.AsInteger:=MFakturaDeclarID.AsInteger;
  if not MFakturaDeclarObjZatr.IsNull then MFakturaTDeclarObjZatr.Value:=MFakturaDeclarObjZatr.Value;
  if not MFakturaDeclarDepot.IsNull then MFakturaTDeclarDepot.Value:=MFakturaDeclarDepot.Value;
end;

procedure TmdMat.MFakturaTDeclarAfterPost(DataSet: TDataSet);
begin
  RecalcFakturaSum;
  MFakturaDeclar.Post;
end;

procedure TmdMat.MFakturaDeclarSummaChange(Sender: TField);
begin
  RecalcFakturaSum;
end;

procedure TmdMat.CalcMRashWorkClick3(Sender: TObject);
  var i: integer;
begin
{BtnCalcMRashWorkC2}
//
  for i:=0 to MRashWorkC.Form.ComponentCount-1 do
    if MRashWorkC.Form.Components[i].Name='BtnCalcMRashWorkC2' then
      begin
        TButton(MRashWorkC.Form.Components[i]).Enabled:=not ChbxMRashWork.Checked;
      end;
end;

procedure TmdMat.MInvoiceTDataChange(Sender: TObject; Field: TField);
begin
  if not Assigned(Field) then
    begin
      {With MInvoice.MInvoiceForm do
        begin
          Panel999.Visible:= MInvoiceHDeclarOperation.AsInteger=4;
          if Panel999.Visible then
            begin
              if not MInvoiceT_SSDeclar.Active then MInvoiceT_SSDeclar.Active:=True;
              if (MInvoiceTDeclar.RecordCount>0) and (MInvoiceT_SSDeclar.State=dsBrowse) then
                begin
                  MInvoiceT_SSDeclar.Filtered := False;
                  if MInvoiceTDeclarID.IsNull then
                    MInvoiceT_SSDeclar.Filter := 'ID = 0'
                  else
                    MInvoiceT_SSDeclar.Filter := 'ID = ' + MInvoiceTDeclarID.AsString;
                  MInvoiceT_SSDeclar.Filtered := True;
                end;
            end
          else
            begin
              MInvoiceT_SSDeclar.Filtered := False;
              MInvoiceT_SSDeclar.Filter := 'ID = 0';
              MInvoiceT_SSDeclar.Filtered := True;
            end;
        end;
      ShowDrgWindow;}
    end;
end;

procedure TmdMat.MInvoiceTDeclarAfterScroll(DataSet: TDataSet);
begin
  With MInvoice.MInvoiceForm do
    begin
      Panel999.Visible:= MInvoiceHDeclarOperation.AsInteger=4;
      if Panel999.Visible then
        begin
          if not MInvoiceT_SSDeclar.Active then MInvoiceT_SSDeclar.Active:=True;
          if (MInvoiceTDeclar.RecordCount>0) and (MInvoiceT_SSDeclar.State=dsBrowse) then
            begin
              MInvoiceT_SSDeclar.Filtered := False;
              if MInvoiceTDeclarID.IsNull then
                MInvoiceT_SSDeclar.Filter := 'ID = 0'
              else
                MInvoiceT_SSDeclar.Filter := 'ID = ' + MInvoiceTDeclarID.AsString;
              MInvoiceT_SSDeclar.Filtered := True;
            end;
        end
      else
        begin
          MInvoiceT_SSDeclar.Filtered := False;
          MInvoiceT_SSDeclar.Filter := 'ID = 0';
          MInvoiceT_SSDeclar.Filtered := True;
        end;
    end;
  ShowDrgWindow;
end;

procedure TmdMat.MMoveMat_PrihDeclarBeforeOpen(DataSet: TDataSet);
begin
  try
    //ExecSQLText(MMoveMat_PrihDeclar.DataBaseName,'call STA.GetMMoveMat(''01.01.08'',''01.01.08'',20,''10.01'')',false);
    ExecSQLText(MMoveMat_PrihDeclar.DataBaseName,'call STA.GetMMoveMat(''01.01.08'',''01.01.08'',10,''10.01'')',false);
  finally
    GMoveMat:=True;
  end;
end;

procedure TmdMat.AssignColumns(DataSet: TDataSet;aForm:TBEForm; isVisible: boolean = True);
  var i: integer;
begin
  with Dataset do
    begin
      Close;
      ModuleBase.KSMDatabase.FlushSchemaCache(TLinkTable(Dataset).TableName);
      if Assigned(aForm) then begin
        aForm.Scroll.DestroyComponents;
        aForm.Tag:=1;
      end;
      FieldDefs.Clear;
      aForm.Grid.Columns.RebuildColumns;
      aForm.Grid.Repaint;
      Open;
      //FieldDefs.Update;
      for i:=0 to FieldCount-1 do
        begin
          if Fields[i] is TNumericField then with TNumericField(Fields[i]) do
            if DisplayFormat='' then DisplayFormat:='### ### ### ###;-### ### ### ###;#';
        end;
    end;
end;

procedure TmdMat.MMoveMat_PrihCDestroyForm(Sender: TObject);
begin
  ExecSQLText(MMoveMat_PrihDeclar.DataBaseName,'call STA.GetMMoveMat(''01.01.08'',''01.01.08'',20,''10.01'')',false);
end;

procedure TmdMat.MProviderOstCCreateForm(Sender: TObject);
var
  Cond: TListObj;
begin
  if MdMat.Tag=0 then
    begin
      Changing:=False;
      with TBEForm(MProviderOstC.Form).Grid, MProviderOstC do begin
        Execute;
        FormatColumns(true);
        Cond:=TFilterItem(TXInquiryItem(Inquiries[0]).Filters.Data.Filters[0]).Conditions;
        PlayInquiry(Inquiries[0],Cond);
        Refresh;
        //SetFocus;
      end;
    end;
end;

procedure TmdMat.MMoveAccountsCCreateForm(Sender: TObject);
{var Cond: TListObj;}
begin
  { Changing:=False;
  with TBEForm(MMoveAccountsC.Form).Grid, MMoveAccountsC do begin
    Execute;
    FormatColumns(true);
    Cond:=TFilterItem(TXInquiryItem(Inquiries[0]).Filters.Data.Filters[0]).Conditions;
    PlayInquiry(Inquiries[0],Cond);
    Refresh;
    //SetFocus;
  end;}
  MInvoiceVCCreateForm(Sender); // Две строки в Гриде
end;

procedure TmdMat.MProviderAnalitCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;

    ReportMPrividerAnalit:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMPrividerAnalit do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=480;
      Width:=100;
      Height:=22;
      Name:='BtnProviderAnalit';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderAnalitClick;
      TabStop:=true;
      TabOrder:=2;
    end;

    MProviderChkBox:= TCheckBox.Create(Form);
    with MProviderChkBox do
     begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=580;
      Width:=90;
      Height:=22;
      Name:='MProviderChkBox';
      Font.Style:=[fsBold];
      Caption:='Дебет';
      TabStop:=true;
      TabOrder:=3;
     end;

    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=680;
      Width:=30;
      Height:=22;
      Name:='BtnProviderAnalit2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMProviderAnalitClick2;
      TabStop:=true;
      TabOrder:=4;
    end;
    //Grid.OnDrawColumnCell:=DrawCellMSvodMove;
    PageControl1TabPanel.Autosize:=True;
  end;

end;

procedure TmdMat.CalcMProviderAnalitClick(Sender: TObject);
 var acc: string;
begin
  acc:=ReportMPrividerAnalit.Text;
  ExecSQLText(MSvodMoveDeclar.DataBaseName,
     'call STA.GetMProviderAnalit('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','''+acc+''')',false);
  TBEForm(MProviderAnalitC.Form).Caption:='ВЕДОМОСТЬ АНАЛИТИЧЕСКОГО УЧЕТА '+acc+' ПО КОРР СЧЕТАМ с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  try
    //Integer(StrToDateTime(ReportPeriod_from.Text))
//    MProviderAnalitDeclar.Tag:=ReportPeriod_from.Date;
    MProviderAnalitDeclar.DisableControls;
    MProviderAnalitDeclar.Close;
    MProviderAnalitDeclar.Open;
    MProviderAnalitDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderAnalitC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.CalcMProviderAnalitClick2(Sender: TObject);
  var i: integer;
      Dat1, Dat2: TDateTime;
      Kor, Osn: string[5];
      Depot, Kod_OZ: Variant;
      Obj: integer;
      Cond: TListObj;
begin
 if MProviderAnalitDeclar.Active and
    (MProviderAnalitDeclar.RecordCount>0) then
    begin
      Dat1:= MProviderAnalit.Declar.FieldByName('DateDoc').Value;
//      Dat2:= MProviderAnalitDeclar.Tag;
      Kor:= MProviderAnalit.Declar.FieldByName('Korr').Value;
      Osn:= ReportMPrividerAnalit.Text;
      if MProviderAnalit.Declar.FieldByName('Depot').IsNull then Depot:=null
      else Depot:=MProviderAnalit.Declar.FieldByName('Depot').Value;
      if MProviderAnalit.Declar.FieldByName('ObjZatr').IsNull then Kod_OZ:=null
      else Kod_OZ:=MProviderAnalit.Declar.FieldByName('ObjZatr').Value;
      if not MFakturaMoveAccountsDeclar.Active then
        MFakturaMoveAccountsDeclar.Active:=True;
      MFakturaMoveAccountsC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MFakturaMoveAccountsC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='DATEDOC' then Value:=Dat1
          else if AnsiUpperCase(FieldName)='VSP' then Value:=Kor
          else if AnsiUpperCase(FieldName)='OSN' then Value:=Osn
          else if AnsiUpperCase(FieldName)='DEPOT' then Value:=Depot
          else if AnsiUpperCase(FieldName)='OBJZATR' then Value:=Kod_OZ;
      MFakturaMoveAccountsC.PlayInquiry(MFakturaMoveAccountsC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.MProviderCalcCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from123';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to123';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    ReportClientMProviderCalc:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportClientMProviderCalc do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='ClientMProviderCalc';
      KeyField:='Kod';
      ListField:='Kod;FullName';
      DataSource1.DataSet:=ModuleOrgs.OrgLookup;
      if not ModuleOrgs.OrgLookup.Active then ModuleOrgs.OrgLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=null;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;

    ReportMProviderCalc:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMProviderCalc do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=610;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=2;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=820;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderCalcClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderCalcClick(Sender: TObject);
 var account: string;
     Cond: TListObj;
begin
  account:=ReportMProviderCalc.Text;
  if ReportClientMProviderCalc.KeyValue>0 then
     ExecSQLText(MProviderCalcDeclar.DataBaseName,
        'call STA.GetMProviderCalc('''+ReportPeriod_from.Text+''','''+account+''','''+IntToStr(Integer(ReportClientMProviderCalc.KeyValue))+''')',false)
  else
     ExecSQLText(MProviderCalcDeclar.DataBaseName,
        'call STA.GetMProviderCalc('''+ReportPeriod_from.Text+''','''+account+''')',false);
  if account='60.00' then
     TBEForm(MProviderCalcC.Form).Caption:='Ведомость расчетов с поставщиками (60/00) за период с '+ReportPeriod_from.Text
  else if account='76.03' then
     TBEForm(MProviderCalcC.Form).Caption:='Ведомость расчетов с подрядчиками (76/03) за период с '+ReportPeriod_from.Text
  else
     TBEForm(MProviderCalcC.Form).Caption:='Ведомость расчетов по счету '+account+' за период с '+ReportPeriod_from.Text  ;
  try
    MProviderCalcDeclar.DisableControls;
    MProviderCalcDeclar.Close;
    MProviderCalcDeclar.Open;
    MProviderCalcDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderCalcC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
  if account='60.00' then
    begin
   //   Cond:=TFilterItem(TXInquiryItem(MProviderCalcC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      MProviderCalcC.PlayInquiry(MProviderCalcC.Inquiries[0]);
    end
  else
    begin
 //     Cond:=TFilterItem(TXInquiryItem(MProviderCalcC.Inquiries[1]).Filters.Data.Filters[0]).Conditions;
      MProviderCalcC.PlayInquiry(MProviderCalcC.Inquiries[1]);
    end;

end;

function TmdMat.LookupAccountFilter(Sender: TObject): String;
begin
  inherited;
  Result:='InteractionAssetsFlag>0';
end;

procedure TmdMat.MSvodProviderCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from2';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to2';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;

    ReportMSvodProvider:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMSvodProvider do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=2;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=480;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMCards232';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMSvodProviderClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=590;
      Width:=50;
      Height:=22;
      Name:='BtnCalcMCards233';
      Font.Style:=[fsBold];
      Caption:='док.';
      OnClick:=CalcMSvodProviderClick2;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMSvodProviderClick(Sender: TObject);
begin
  ExecSQLText(MSvodProviderDeclar.DataBaseName,
     'call STA.GetMSvodProvider('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','''+ReportMSvodProvider.Text+''')',false);
  TBEForm(MSvodProviderC.Form).Caption:=
  ReportMSvodProvider.Text+
  ' за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  {LookupAccount.Text}
  try
    MSvodProviderDate:=ReportPeriod_from.Date;
    MSvodProviderDeclar.DisableControls;
    MSvodProviderDeclar.Close;
    MSvodProviderDeclar.Open;
    MSvodProviderDeclar.EnableControls;
  except
  end;
  with TBEForm(MSvodProviderC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MProviderOborotVatCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from1233';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to1232';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc123';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderOborotVATClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderOborotVATClick(Sender: TObject);
begin
  ExecSQLText(MProviderOborotVATDeclar.DataBaseName,
     'call STA.GetMProviderOborotVAT('''+ReportPeriod_from.Text+''')',false);
  TBEForm(MProviderOborotVATC.Form).Caption:='Оборотно-сальдовая ведомость по учету НДС за период '+ReportPeriod_from.Text;
  try
    MProviderOborotVATDeclar.DisableControls;
    MProviderOborotVATDeclar.Close;
    MProviderOborotVATDeclar.Open;
    MProviderOborotVATDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderOborotVATC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MReadyMaterialStatusCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from123312';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ChbxMReadyMat:= TCheckBox.Create(Form);
    with ChbxMReadyMat do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=22;
      Height:=22;
      Name:='ChbxMReadyMat';
      Font.Style:=[fsBold];
      Caption:='';
      TabStop:=true;
      TabOrder:=4;
    end;
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=240;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc12323';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMReadyMaterialStatus;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMReadyMaterialStatus(Sender: TObject);
begin
  ExecSQLText(MReadyMaterialStatusDeclar.DataBaseName,
     'call STA.GetMReadyMaterialStatus('''+ReportPeriod_from.Text+''','+IntToStr(Integer(ChbxMReadyMat.Checked))+')',false);
  TBEForm(MReadyMaterialStatusC.Form).Caption:='Проверка готовности материалов к закрытию за период '+ReportPeriod_from.Text;
  try
    MReadyMaterialStatusDeclar.DisableControls;
    MReadyMaterialStatusDeclar.Close;
    MReadyMaterialStatusDeclar.Open;
    MReadyMaterialStatusDeclar.EnableControls;
  except
  end;
  with TBEForm(MReadyMaterialStatusC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MPKPBookCalcCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from12344';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;

    ReportMPKPBookCalc:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMPKPBookCalc do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=290;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc12344';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMPKPBookCalc;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMPKPBookCalc(Sender: TObject);
 var account: string;
begin
  account:=ReportMPKPBookCalc.Text;
  ExecSQLText(MPKPBookCalcDeclar.DataBaseName,
     'call STA.GetMPKPBookCalc('''+ReportPeriod_from.Text+''','''+account+''')',false);
  TBEForm(MPKPBookCalcC.Form).Caption:='Покупка по '''+account+''' за период с '+ReportPeriod_from.Text+
     ' по '+ DateToStr(GetLastDayOfMonth(ReportPeriod_from.Date));
  try
    MPKPBookCalcDeclar.DisableControls;
    MPKPBookCalcDeclar.Close;
    MPKPBookCalcDeclar.Open;
    MPKPBookCalcDeclar.EnableControls;
  except
  end;
  with TBEForm(MPKPBookCalcC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.CalcMSvodProviderClick2(Sender: TObject);
  var i: integer;
      Dat: TDateTime;
      Kor: string[5];
      Osn: string[5];
      Cond: TListObj;
begin
 if MSvodProviderDeclar.Active and
    (MSvodProviderDeclar.RecordCount>0) then
    begin
      Dat:= MSvodProviderDate;
      Kor:= MSvodProvider.Declar.FieldByName('Account').Value;
      Osn:=ReportMSvodProvider.Text;
      MSvodProviderDocsC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MSvodProviderDocsC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='PERIOD' then Value:=Dat
          else if AnsiUpperCase(FieldName)='KORR' then Value:=Kor
          else if AnsiUpperCase(FieldName)='OSN' then Value:=Osn
          else if AnsiUpperCase(FieldName)='DATEDOC' then Value:=Dat;
      MSvodProviderDocsC.PlayInquiry(MSvodProviderDocsC.Inquiries[0],Cond);
    end;
end;

procedure TmdMat.MProviderProsrochCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from778';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1);
    end;

    ReportMProviderProsroch:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMProviderProsroch do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=380;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc778';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderProsrochClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderProsrochClick(Sender: TObject);
 var account: string;
begin
  account:=ReportMProviderProsroch.Text;
  ExecSQLText(MProviderProsrochDeclar.DataBaseName,
     'call STA.GetMProviderProsroch('''+ReportPeriod_from.Text+''','''+account+''')',false);
  TBEForm(MProviderProsrochC.Form).Caption:='Просроченная задолженность по счету '''+account+''' на '+ReportPeriod_from.Text;
  try
    MProviderProsrochDeclar.DisableControls;
    MProviderProsrochDeclar.Close;
    MProviderProsrochDeclar.Open;
    MProviderProsrochDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderProsrochC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MProviderProsrochClientCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from779';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1);
    end;

    ReportMProviderProsrochClient:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMProviderProsrochClient do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    eMCards:=TEdit.Create(Form);
    with eMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=390;
      Width:=30;
      Height:=22;
      Name:='werewrwerw';
      Font.Style:=[fsBold];
      TabStop:=true;
      Text:='3';
      TabOrder:=1;
    end;

    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=430;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc779';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderProsrochClientClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderProsrochClientClick(Sender: TObject);
 var account: string;
begin
  account:=ReportMProviderProsrochClient.Text;
  ExecSQLText(MProviderProsrochClientDeclar.DataBaseName,
     'call STA.GetMProviderProsrochClient('''+ReportPeriod_from.Text+''','+eMCards.Text+','''+account+''')',false);
  TBEForm(MProviderProsrochClientC.Form).Caption:='Ведомость контроля задолженности по счету '''+account+''' на начало '+ReportPeriod_from.Text;
  try
    MProviderProsrochClientDeclar.DisableControls;
    MProviderProsrochClientDeclar.Close;
    MProviderProsrochClientDeclar.Open;
    MProviderProsrochClientDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderProsrochClientC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MFakturaDeclarCurrencyChange(Sender: TField);
begin
 TMFakturaForm(MFakturaC.Form).ChangeVisibleCurrency(MFakturaDeclarCurrency.Value);
end;

procedure TmdMat.MFakturaCActivateForm(Sender: TObject);
begin
  TBEForm(MFakturaC.Form).Refresh;
end;

procedure TmdMat.MFakturaTDeclarSummaChange(Sender: TField);
begin
  if MFakturaDeclarCurrency.Value=974 then
    MFakturaTDeclarSummaBy.Value:=MFakturaTDeclarSumma.Value;
end;

procedure TmdMat.DrawDataInvoice;
 var Form: TMInvoiceForm;
begin
  Form:=TMInvoiceForm(MInvoiceC.Form);
  if Assigned(Form) and (MInvoiceHDeclarDateDoc.Value>=GetFirstDayOfMonth(CloseDate+32)) then
    MInvoiceForm.EditDateDoc.Font.Color:=clBlue
  else
    MInvoiceForm.EditDateDoc.Font.Color:=clRed;
end;

procedure TmdMat.GridDblClick;
  var FName: string;
  DS: TDataSource;
begin
  inherited;
  DS:=TXEDbGrid(Sender).DataSource; // Источник данных
  if (DS.Name='MInvoiceV') or (DS.Name='MMoveAccounts') {or (DS.Name='InvoiceVT')} then begin
    if not Assigned(MInvoiceC.Form) or not MInvoiceC.Form.Active then MInvoiceC.Execute;
    if MInvoiceHDeclar.Locate('ID',DS.DataSet.FieldByName('InvoiceID').Value,[]) then MInvoiceC.Execute;
  end;
end;

procedure TmdMat.MInvoiceVCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=2;
    Grid.TitleAlignment:=taCenter;
    Grid.OnDblClick:=GridDblClick;
  end;
end;

procedure TmdMat.MInvoiceHDeclarInfoChange(Sender: TField);
begin
  if (MInvoiceHDeclarOperation.AsInteger=7) then
    begin
      if MInvoiceHDeclarsAuto_ownr.AsVariant=null then MInvoiceHDeclarsAuto_ownr.AsString:=MInvoiceHDeclarInfo.AsString;
      if MInvoiceHDeclarsAuto_drvr.AsVariant=null then MInvoiceHDeclarsAuto_drvr.AsString:=MInvoiceHDeclarInfo.AsString;
    end;
//       MInvoiceHDeclarCel_Prb.AsString:='Для собств. нужд';
end;

function TmdMat.GetAccountByUser: string;
begin
  Result:='';
  Result:=mdBase.ModuleBase.UsersDeclarAccount.AsString;
  if result='' then Result:='60.00';
end;

procedure TmdMat.MRashWorkItgCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from:=TDateEdit.Create(Form);
    with ReportPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from2';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to:=TDateEdit.Create(Form);
    with ReportPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to2';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := InCMonth(WorkDate,1)-1;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMRashWorkC';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMRAshWorkClickItg;
      TabStop:=true;
      TabOrder:=2;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMRashWorkClickItg(Sender: TObject);
begin
  ExecSQLText(MRashWorkItgDeclar.DataBaseName,
     'call STA.GetMRashWorkItg('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
  TBEForm(MRashWorkItgC.Form).Caption:='Итоговые суммы расхода материалов на производство за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
  with MRashWorkItgDeclar do
    try
      tag:=Trunc(StrToDate(ReportPeriod_from.Text));
      DisableControls;
      Close;
      Open;
      EnableControls;
    except
    end;
  with TBEForm(MRashWorkItgC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

function TmdMat.LockBuhValue: integer;
begin
  with ModuleBase do
    if (Pos('BUH',UsersDeclarMemberOfGroups.AsString)>0) or (AnsiUpperCase(UsersDeclarName.AsString)='ADMIN' ) then
      Result:=2
    else
      Result:=1;
end;

function TmdMat.WhosLock: integer;
begin
  if mdMat.MInvoiceHDeclarsUserLock.AsInteger>0 then
    Result:=mdMat.MInvoiceHDeclarsUserLock.AsInteger
end;

procedure TmdMat.MProviderCalc2DeclarBeforeOpen(DataSet: TDataSet);
begin
  try
    ExecSQLText(MProviderCalc2Declar.DataBaseName,'call STA.GetMProviderCalc2(''01.01.08'',''60.01'',10)',false);
  finally
  end;
end;

procedure TmdMat.MProviderCalc2CCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from000:=TDateEdit.Create(Form);
    Grid.OnDblClick:=ModuleClientsAdd.GridDblClick;
    with ReportPeriod_from000 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from000';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to000:=TDateEdit.Create(Form);
    with ReportPeriod_to000 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to000';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;

    ReportMProviderCalc0000:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMProviderCalc0000 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=170;
      Height:=22;
      Name:='LookupAccount';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=2;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards000:=TBitBtn.Create(Form);
    with BtnCalcMCards000 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=510;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderCalc2Click;
      TabStop:=true;
      TabOrder:=3;
    end;

    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderCalc2Click(Sender: TObject);
 var account: string;
     i: integer;

 // формируем имя поля
procedure GetName(AField: TField);
  var ss: string;
      i: integer;
begin
   if AnsiUpperCase(AField.FullName) = 'ID' then AField.Visible := False;
   if AnsiUpperCase(AField.FullName) = 'CLIENT' then AField.DisplayLabel := 'Код';
   if AnsiUpperCase(AField.FullName) = 'CLIENTNAME' then AField.DisplayLabel := 'Поставщик';
   if AnsiUpperCase(AField.FullName) = 'MATERIAL' then AField.DisplayLabel := 'Код мат.';
   if AnsiUpperCase(AField.FullName) = 'MATERIALNAME' then AField.DisplayLabel := 'материал';
   if AnsiUpperCase(AField.FullName) = 'SUMK' then AField.DisplayLabel := 'Итого кредит';
   if AnsiUpperCase(AField.FullName) = 'SUMD' then AField.DisplayLabel := 'Итого дебет';
   if AnsiUpperCase(AField.FullName) = 'NUMDOCK' then AField.DisplayLabel := '№ док';
   if AnsiUpperCase(AField.FullName) = 'DATEDOCK' then AField.DisplayLabel := 'Дата док.';
   if AnsiUpperCase(AField.FullName) = 'NUMDOCD' then AField.DisplayLabel := '№ док';
   if AnsiUpperCase(AField.FullName) = 'DATEDOCD' then AField.DisplayLabel := 'Дата док';
   if AnsiUpperCase(AField.FullName) = 'OSTBEGD' then AField.DisplayLabel := 'Дебет на начало';
   if AnsiUpperCase(AField.FullName) = 'OSTBEGK' then AField.DisplayLabel := 'Кредит на начало';
   if AnsiUpperCase(AField.FullName) = 'OSTBEGVATK' then AField.DisplayLabel := 'НДС кредит нач.';
   if AnsiUpperCase(AField.FullName) = 'OSTENDD' then AField.DisplayLabel := 'Дебет на конец';
   if AnsiUpperCase(AField.FullName) = 'OSTENDK' then AField.DisplayLabel := 'Кредит на конец';
   if AnsiUpperCase(AField.FullName) = 'OSTENDVATK' then AField.DisplayLabel := 'НДС кредит кон.';
   if (copy(AField.FullName,1,1) = 'K') and (Length(AField.FullName)=5)
      then AField.DisplayLabel := 'в Д'+copy(AField.FullName,2,2)+'/'+copy(AField.FullName,4,2);
   if (copy(AField.FullName,1,1) = 'D') and (Length(AField.FullName)=5)
      then AField.DisplayLabel := 'с К'+copy(AField.FullName,2,2)+'/'+copy(AField.FullName,4,2);

{   if (AnsiUpperCase(AField.FullName) <> 'SUM_INTNL') and
    (Pos('SUM_',AnsiUpperCase(AField.FullName)) > 0) then
      begin
        ss := Copy(AField.FullName, 5, Length(AField.FullName) - 4);
        for i:=1 to Length(ss) do
          if ss[i]='_' then ss[i] := '.';
        AField.DisplayLabel := ss;
      end;}
end;

procedure SortFields(Grid: TXEDbGrid;acc: string);
 var i: integer;

procedure SetIndex(ColName: string; var ind: integer);
 var j: integer;
begin
 for j:=0 to Grid.Columns.Count-1 do
   if AnsiUpperCase(Grid.Columns[j].Field.FullName)=Colname then
     begin
       Grid.Columns[j].Index:=ind;
       inc(ind);
       Break;
     end;
end;

begin
  if Acc='76.04' then
    begin
      i:=0;
      SetIndex('CLIENT',i);
      SetIndex('CLIENTNAME',i);
      SetIndex('MATERIAL',i);
      SetIndex('MATERIALNAME',i);
      SetIndex('SUMK',i);
      SetIndex('SUMD',i);
      SetIndex('NUMDOCK',i);
      SetIndex('DATEDOCK',i);
      SetIndex('NUMDOCD',i);
      SetIndex('DATEDOCD',i);
      SetIndex('OSTBEGD',i);
      SetIndex('OSTBEGK',i);
      SetIndex('OSTBEGVATK',i);
      SetIndex('OSTENDD',i);
      SetIndex('OSTENDK',i);
      SetIndex('OSTENDVATK',i);
 {  if (copy(AField.FullName,1,1) = 'K') and (Length(AField.FullName)=5)
      then AField.DisplayLabel := 'в Д'+copy(AField.FullName,2,2)+'/'+copy(AField.FullName,4,2);
   if (copy(AField.FullName,1,1) = 'D') and (Length(AField.FullName)=5)
      then AField.DisplayLabel := 'с К'+copy(AField.FullName,2,2)+'/'+copy(AField.FullName,4,2);}
    end;
end;


begin
  account:=ReportMProviderCalc0000.Text;
  ExecSQLText(MProviderCalc2Declar.DataBaseName,
    'call STA.GetMProviderCalc2('''+ReportPeriod_from000.Text+''','''+account+''',1)',false);
  AssignColumns(MProviderCalc2Declar,TBEForm(MProviderCalc2C.Form));
  TBEForm(MProviderCalc2C.Form).Caption:='Журнал-ордер по счету ('+account+') за '+FormatDateTime('mmmm yyyy',ReportPeriod_from000.Date);
  try
    MProviderCalc2Declar.DisableControls;
    MProviderCalc2Declar.Close;
    MProviderCalc2Declar.IndexFieldNames:='ID';
    MProviderCalc2Declar.Open;
    MProviderCalc2Declar.EnableControls;
  except
  end;
  with TBEForm(MProviderCalc2C.Form).Grid do begin
    FormatColumns(True);
    with MProviderCalc2Declar do
      for i:=0 to Fields.Count - 1 do
        begin
          GetName(Fields[i]);
          if Fields[i].DataType = ftFloat then TFloatField(Fields[i]).DisplayFormat:='0.,';
        end;
    //SortFields(TBEForm(MProviderCalc2C.Form).Grid,account);
    SetFocus;
  end;
end;

procedure TmdMat.MProviderCalc2CDestroyForm(Sender: TObject);
begin
  ExecSQLText(MProviderCalc2Declar.DataBaseName,'call STA.GetMProviderCalc2(''01.01.08'',''10.01'',20)',false);
end;

procedure TmdMat.MFakturaDeclarAfterPost(DataSet: TDataSet);
begin
  MFakturaDeclarAfterScroll(DataSet);
  MFakturaDeclar.Refresh;
end;

procedure TmdMat.MObjZatrDeclarBeforeInsert(DataSet: TDataSet);
begin
  if MObjZatrDeclaroldPrz.IsNull then MObjZatrDeclaroldPrz.AsInteger:=1;
end;

function TmdMat.MInvoiceHDeclarSectionNameFilter(Sender: TObject): String;
begin
  Result:='( (Section=251600) or (Section=250500) or (Section=251500) or (Section=160000) or (Section=252000)or (Section=390000)or (Section=430000))';
end;

function TmdMat.MInvoiceHDeclarObjZatrNameFilter(Sender: TObject): String;
 var sDepot: string;
begin
  if MInvoiceHDeclarOperation.AsInteger=8 then
    begin
      if Length(MInvoiceHDeclarSourceDepot.AsString) = 3 then
         sDepot:=Copy(MInvoiceHDeclarSourceDepot.AsString,2,2)
      else
         sDepot:=MInvoiceHDeclarSourceDepot.AsString;
      Result:='Depot='+sDepot+' and (oldPrz=0)';
    end;
end;

procedure TmdMat.CalcMProviderCalc3Click(Sender: TObject);
begin
//  GridDblClick(Sender);
end;

procedure TmdMat.MAmounts_SpisCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriodMAmounts_Spis:=TDateEdit.Create(PageControl1TabPanel);
    with ReportPeriodMAmounts_Spis do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportPeriodMAmounts';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := SysUtils.Date+1;
    end;
    ReportDepotMAmounts_Spis:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMAmounts_Spis do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMAmounts';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=ModuleBase.DepotLookup;
      ListSource:=DataSource1;
      KeyValue:=91;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    {with ModuleBase.DepotDeclar do
      begin
        ReportDepotMAmounts.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMAmounts.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportDepotMAmounts.ItemIndex:=ReportDepotMAmounts.Items.Count-1;
            Next;
          end;
      end;}
    BtnCalcMAmounts_Spis:=TBitBtn.Create(PageControl1TabPanel);
    with BtnCalcMAmounts_Spis do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMAmounts';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMAmountsClick_Spis;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.AutoSize:=True;
    Grid.OnDrawColumnCell:=DrawCellAmount;
  end;
end;

procedure TmdMat.CalcMAmountsClick_Spis(Sender: TObject);
begin
  ExecSQLText(MAmounts_SpisDeclar.DataBaseName,
     'call STA.GetMAmount_Spis('''+ReportPeriodMAmounts_Spis.Text+
     ''','+IntToStr(Integer(ReportDepotMAmounts_Spis.KeyValue))+')',false);
  TBEForm(MAmounts_SpisC.Form).Caption:='Остатки материалов по '+ModuleBase.DepotLookupName.AsString+
     ' ('+ModuleBase.DepotLookupKod.AsString+') на '+ReportPeriodMAmounts_Spis.Text;
  try
    MAmounts_SpisDeclar.Refresh;
  except
  end;
  with TBEForm(MAmounts_SpisC.Form).Grid do begin
    FormatColumns(true);
    SetFocus;
  end;
end;

procedure TmdMat.MInvoiceT_SSDeclarNewRecord(DataSet: TDataSet);
begin
   MInvoiceT_SSDeclarKod_StatRash.AsInteger:=0;
end;

procedure TmdMat.MDrgObVedCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from1:=TDateEdit.Create(Form);
    with ReportPeriod_from1 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from1234';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportPeriod_to1:=TDateEdit.Create(Form);
    with ReportPeriod_to1 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_to1234';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    BtnCalcMCards1:=TBitBtn.Create(Form);
    with BtnCalcMCards1 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnMDrgObVed';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMDrgObVedClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMDrgObVedClick(Sender: TObject);
begin
//
  ExecSQLText(MDrgObVedDeclar.DataBaseName,
     'call STA.GetMDrgObVed('''+ReportPeriod_from1.Text+''','''+ReportPeriod_to1.Text+''')',false);
  TBEForm(MDrgObVedC.Form).Caption:=
  'Обороты драгметаллов за период с '+ReportPeriod_from1.Text+ ' по '+ReportPeriod_to1.Text;
  {LookupAccount.Text}
  try
    MDrgObVedDeclar.DisableControls;
    MDrgObVedDeclar.Close;
    MDrgObVedDeclar.Open;
    MDrgObVedDeclar.EnableControls;
  except
  end;
  with TBEForm(MDrgObVedC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MProviderProsrochSvodCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportPeriod_from999:=TDateEdit.Create(Form);
    with ReportPeriod_from999 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportPeriod_from999';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1);
    end;

    ReportMProviderProsrochClient999:=TXEDBLookupCombo.Create(Form);
    if not ModuleCommon.AccountLookup.Active then ModuleCommon.AccountLookup.Open;
    with ReportMProviderProsrochClient999 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=170;
      Height:=22;
      Name:='LookupAccount999';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      KeyField:='BuhAccount';
      ListField:='BuhAccount;Name';
      ListSource:=ModuleCommon.AccountLSource;
      DropDownWidth:=300;
      KeyValue:=GetAccountByUser;
      OnFilter:=LookupAccountFilter;
    end;

    BtnCalcMCards999:=TBitBtn.Create(Form);
    with BtnCalcMCards999 do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=430;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc999';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderProsrochSvodClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderProsrochSvodClick(Sender: TObject);
 var account: string;
begin
  account:=ReportMProviderProsrochClient999.Text;
  ExecSQLText(MProviderProsrochSvodDeclar.DataBaseName,
     'call STA.GetMProviderProsrochSvod('''+ReportPeriod_from999.Text+''','''+account+''')',false);
  TBEForm(MProviderProsrochSvodC.Form).Caption:='Ведомость задолженности по клиентам по счету '''+account+''' на конец '+ReportPeriod_from999.Text;
  try
    MProviderProsrochSvodDeclar.DisableControls;
    MProviderProsrochSvodDeclar.Close;
    MProviderProsrochSvodDeclar.Open;
    MProviderProsrochSvodDeclar.EnableControls;
  except
  end;
  with TBEForm(MProviderProsrochSvodC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

function TmdMat.Round10(ANumber: extended; Round10: boolean = false): extended;
begin
  if not Round10 then
    Result:=RoundA(ANumber/10)*10
  else
    Result:=Round(ANumber/10)*10;
end;

procedure TmdMat.MInvoiceTDeclarContractChange(Sender: TField);
 var Amount: double;
     kod: integer;
begin
  if (IsShop>0) then
    try
      Amount := 0;
      try
        Kod := MInvoiceTDeclarMaterial.AsInteger;
        KOd:= Kod mod 100000;
        Amount := StrToFloat(MInvoiceTDeclarContract.AsString);
      except
        Amount:=0;
      end;
      if not Assigned(TempQuery) then
         begin
           TempQuery:=TQuery.Create(Self);
           TempQuery.DatabaseName:=MaterialsEdit.DatabaseName;
         end;
      TempQuery.SQL.Text:='select STA.GetAmountProd('+FloatToStr(Amount)+','+IntToStr(Kod)+')';
      try
        TempQuery.Active:=False;
        TempQuery.Active:=True;
        Amount:=TempQuery.Fields[0].AsFloat;
      except
      end;
    finally
      MInvoiceTDeclarAmount.AsFloat := Amount;
    end;
end;

procedure TmdMat.MShopRstPrihCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    Grid.OnDrawColumnCell:=DrawMShopRstPrihCell;
    PageControl1TabPanel.Autosize:=False;
    ReportShopPeriod_from:=TDateEdit.Create(Form);
    with ReportShopPeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportShopPeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportShopPeriod_to:=TDateEdit.Create(Form);
    with ReportShopPeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='ReportShopPeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;

    ReportDepotMRstPrih:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMRstPrih do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMAmounts';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup; //ModuleBase.DepotLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=GetDefaultDepot;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=2;
    end;


    BtnShopRstPrih:=TBitBtn.Create(Form);
    with BtnShopRstPrih do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=620;
      Width:=100;
      Height:=22;
      Name:='BtnShopRstPrih';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMShopRstPrihClick;
      TabStop:=true;
      TabOrder:=3;
    end;

    PageControl1TabPanel.Autosize:=True;
  end;

end;

procedure TmdMat.CalcMShopRstPrihClick(Sender: TObject);
begin
  ExecSQLText(MShopRstPrihDeclar.DataBaseName,
     'call STA.GetMShopRstPrih('''+ReportShopPeriod_from.Text+''','''+ReportShopPeriod_to.Text+''','+
     IntToStr(Integer(ReportDepotMRstPrih.KeyValue))+',''41.00'')',false);
  TBEForm(MShopRstPrihC.Form).Caption:='РЕЕСТР ПРИХОДА ЗА ПЕРИОД с '+ReportShopPeriod_from.Text+ ' по '+ReportShopPeriod_to.Text;
  try
    MShopRstPrihDeclar.DisableControls;
    MShopRstPrihDeclar.Close;
    MShopRstPrihDeclar.Open;
    MShopRstPrihDeclar.EnableControls;
  except
  end;
  with TBEForm(MShopRstPrihC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MCards_ShopCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    ReportMCardsS_from:=TDateEdit.Create(Form);
    PageControl1TabPanel.Autosize:=False;
    with ReportMCardsS_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=115;
      Width:=80;
      Height:=20;
      Name:='ReportMCardsS_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportMCardsS_to:=TDateEdit.Create(Form);
    with ReportMCardsS_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=200;
      Width:=80;
      Height:=20;
      Name:='ReportMCardsS_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    ReportDepotMCardsS:=TXEDBLookupCombo.Create(Form); // TComboBox
    with ReportDepotMCardsS do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=285;
      Width:=300;
      Height:=22;
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=GetDefaultDepot;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Name:='DepotCalcMCardsS';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMCardsS:=TBitBtn.Create(Form);
    with BtnCalcMCardsS do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=590;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMCardsS';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMCardsSClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    BtnCalcMCardsS2:=TBitBtn.Create(Form);
    with BtnCalcMCardsS2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=695;
      Width:=30;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMCards2S';
      Font.Style:=[fsBold];
      Caption:='Карт';
      OnClick:=CalcMCards2SClick;
      TabStop:=true;
      TabOrder:=4;
    end;
    ChkBoxMCardsShop:=TCheckBox.Create(Form);
    with ChkBoxMCardsShop do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=730;
      Width:=50;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='ChkBoxMCardsShop';
      Font.Style:=[fsBold];
      Caption:='свободно-отпускные цены';
      TabStop:=true;
      Checked:=IsShop=39;
      TabOrder:=5;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMCardsSClick(Sender: TObject);
begin
  ExecSQLText(MCards_ShopDeclar.DataBaseName,
     'call STA.GetMCardsOnPeriod_Shop('''+ReportMCardsS_from.Text+''','''+ReportMCardsS_to.Text+''','+IntToStr(Integer(ReportDepotMCardsS.KeyValue))+
        ','+IntToStr(Integer(ChkBoxMCardsShop.Checked))+')',false);
  TBEForm(MCards_ShopC.Form).Caption:='Движение товара (обороты) по '+SprDepotAdvLookupName.AsString+
     ' ('+SprDepotAdvLookupKod.AsString+') за период с '+ReportMCardsS_from.Text+ ' по '+ReportMCardsS_to.Text;
  try
    MCards_ShopDeclar.DisableControls;
    MCards_ShopDeclar.Active:=False;
    MCards_ShopDeclar.Active:=True;
    MCards_ShopDeclar.Active:=False;
    MCards_ShopDeclar.Active:=True;
    MCards_ShopDeclar.EnableControls;
  except
  end;
  with TBEForm(MCards_ShopC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;

end;

procedure TmdMat.CalcMCards2SClick(Sender: TObject);
begin
 if MCards_ShopDeclar.Active and
   (MCards_ShopDeclar.RecordCount>0) then
    with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.Dataset do
      begin
        ShowMCard(FieldByName('Material').AsFloat,
          Integer(ReportDepotMCardsS.KeyValue),
           FieldByName('PriceUC').AsFloat,
           StrToDate('01.01.1950'), Date+30,FieldByName('KREDIT').AsString,FieldByName('PriceUC').AsFloat);
      end;
end;

procedure TmdMat.MCards_Shop_BIGCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    ReportMCardsSB_from:=TDateEdit.Create(Form);
    PageControl1TabPanel.Autosize:=False;
    with ReportMCardsSB_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=115;
      Width:=80;
      Height:=20;
      Name:='ReportMCardsS_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    ReportMCardsSB_to:=TDateEdit.Create(Form);
    with ReportMCardsSB_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=200;
      Width:=80;
      Height:=20;
      Name:='ReportMCardsS_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    ReportDepotMCardsSB:=TXEDBLookupCombo.Create(Form); // TComboBox
    with ReportDepotMCardsSB do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=285;
      Width:=300;
      Height:=22;
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=GetDefaultDepot;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Name:='DepotCalcMCardsS';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=2;
    end;
    BtnCalcMCardsSB:=TBitBtn.Create(Form);
    with BtnCalcMCardsSB do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=590;
      Width:=100;
      Height:=22;
      Name:='BtnCalcMCardsS';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMCardsSBClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    BtnCalcMCardsSB2:=TBitBtn.Create(Form);
    with BtnCalcMCardsSB2 do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=695;
      Width:=30;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnCalcMCards2S';
      Font.Style:=[fsBold];
      Caption:='Карт';
      OnClick:=CalcMCards2SBClick;
      TabStop:=true;
      TabOrder:=4;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMCards2SBClick(Sender: TObject);
begin
 if MCards_Shop_BIGDeclar.Active and
   (MCards_Shop_BIGDeclar.RecordCount>0) then
    with TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.Dataset do
      begin
        ShowMCard(FieldByName('Material').AsFloat,
          Integer(ReportDepotMCardsSB.KeyValue),
           FieldByName('PriceUC').AsFloat,
           StrToDate('01.01.1950'), Date+30,FieldByName('KREDIT').AsString,FieldByName('PriceUC').AsFloat);
      end;
end;

procedure TmdMat.CalcMCardsSBClick(Sender: TObject);
begin
  ExecSQLText(MCards_Shop_BIGDeclar.DataBaseName,
     'call STA.GetMCardsOnPeriod_Shop_BIG('''+ReportMCardsSB_from.Text+''','''+ReportMCardsSB_to.Text+''','+IntToStr(Integer(ReportDepotMCardsSB.KeyValue))+
        ',0)',false);
  TBEForm(MCards_Shop_BIGC.Form).Caption:='Движение товара (обороты) по '+SprDepotAdvLookupName.AsString+
     ' ('+SprDepotAdvLookupKod.AsString+') за период с '+ReportMCardsSB_from.Text+ ' по '+ReportMCardsSB_to.Text;
  try
    MCards_Shop_BIGDeclar.DisableControls;
    MCards_Shop_BIGDeclar.Close;
    MCards_Shop_BIGDeclar.Open;
    MCards_Shop_BIGDeclar.EnableControls;
  except
  end;
  with TBEForm(MCards_Shop_BIGC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.MInvoiceTDeclarPriceUCChange(Sender: TField);
begin
  if MInvoiceTDeclarOperation.AsInteger=18 then
    MInvoiceTDeclarAmountChange(Sender);
end;

procedure TmdMat.MSaleAddCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportMSaleAddPeriod:=TDateEdit.Create(Form);
    with ReportMSaleAddPeriod do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='ReportMSaleAddPeriod';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := Now+1;
    end;

    ReportDepotMSaleAdd:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportDepotMSaleAdd do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='ReportDepotMSaleAdd';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=SprDepotAdvLookup; //ModuleBase.DepotLookup;
      if not SprDepotAdvLookup.Active then SprDepotAdvLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=GetDefaultDepot;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;


    BtnMSaleAdd:=TBitBtn.Create(Form);
    with BtnMSaleAdd do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=520;
      Width:=100;
      Height:=22;
      Name:='BtnMSaleAdd';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMSaleAddClick;
      TabStop:=true;
      TabOrder:=2;
    end;

    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMSaleAddClick(Sender: TObject);
begin
  ExecSQLText(MSaleAddDeclar.DataBaseName,
     'call STA.GetMAmountsBuh('''+ReportMSaleAddPeriod.Text+''','+
     IntToStr(Integer(ReportDepotMSaleAdd.KeyValue))+')',false);
  TBEForm(MSaleAddC.Form).Caption:='РЕЕСТР ТОРГОВЫХ НАДБАВОК НА '+ReportMSaleAddPeriod.Text+ ' по подразделению '+ReportDepotMSaleAdd.KeyField;
  try
    MSaleAddDeclar.DisableControls;
    MSaleAddDeclar.Close;
    MSaleAddDeclar.Open;
    MSaleAddDeclar.EnableControls;
  except
  end;
  with TBEForm(MSaleAddC.Form).Grid do begin
   FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.GetSaleRateAndVATShop(Kod: integer; PriceUC: Extended; Account: string; Depot: integer; var Rate: Extended; var VAT: Extended);
  var ss: string;
      vv: Array of Variant;
begin
  try
    ss:='select RATE, VAT from STA.MSaleAdd where kod='+IntToStr(Kod)+' and PriceUC='+FloatToStr(PriceUC)+' and Account='''+Account+''' and Depot='+IntToStr(Depot);
    vv := GetArrFromSQLText('AO_GKSM_InProgram',ss,false);
    if VarIsEmpty(vv) or VarIsNull(vv) then
      begin
        Rate:=0;
        VAT:=0;
      end
    else
      begin
        Rate:=vv[0];
        VAT:=vv[1];
      end;
  except
    Rate:=0;
    VAT:=0;
  end;
end;

procedure TmdMat.PrintMInvoiceDoc;
  var ID: integer;
      oldFilter: string;
begin
  oldFilter:=MInvoiceHDeclar.Filter;
  try
    ID:=MInvoiceHDeclarID.AsInteger;
    {MInvoiceHDeclar.Filter:='ID='+IntToStr(ID);
    MInvoiceHDeclar.Filtered:=false;
    MInvoiceHDeclar.Filtered:=true;}
    //ppRepMInvoice.Print;
    if (IsShop>0) and (GetOperNum(MInvoiceHDeclarNumDoc, true)=7) then
      begin
        MInvoiceVPrintDeclar.Close;
        MInvoiceVPrintDeclar.Filtered:=False;
        MInvoiceVPrintDeclar.Filter:='ID = '+MInvoiceHDeclarID.AsString;
        MInvoiceVPrintDeclar.Filtered:=True;
        MInvoiceVPrintDeclar.Active:=true;
        if MessageDlg('Печатаем на бланке ТН?', mtInformation, [mbYes, mbNo],0)=mrYes then
           ppTN.Template.FileName:='X:\APPS\REAL\SHB\MatInvoiceTN.rtm'
        else
           ppTN.Template.FileName:='X:\APPS\REAL\SHB\MatInvoiceTNadd.rtm';
        ppTN.Template.LoadFromFile;
        ppTN.Print;
      end
    else
      ppRepMInvoice.Print;
  finally
    {MInvoiceHDeclar.Filter:=oldFilter;
    MInvoiceHDeclar.Filtered:=false;
    MInvoiceHDeclar.Filtered:=true;}
  end;
end;

procedure TmdMat.ppVariable1Calc(Sender: TObject; var Value: Variant);
begin
  if (MInvoiceHDeclarOperation.AsInteger in [4,6,7,8]) then
    Value:=MInvoiceHDeclarSourceDepotName.AsString
  else if MInvoiceHDeclarOperation.AsInteger in [3,11,16] then
    Value:=MInvoiceHDeclarClientName.AsString
  else
    Value:=MInvoiceHDeclarRecipientName.AsString;
end;

procedure TmdMat.ppVariable2Calc(Sender: TObject; var Value: Variant);
begin
  if (MInvoiceHDeclarOperation.AsInteger in [3,4,11,16]) then
    Value:=MInvoiceHDeclarDestDepotName.AsString
  else if MInvoiceHDeclarOperation.AsInteger in [7] then
    Value:=MInvoiceHDeclarRecipientName.AsString
  else
    Value:=MInvoiceHDeclarClientName.AsString;
end;

procedure TmdMat.ppVariable3Calc(Sender: TObject; var Value: Variant);
begin
  if MInvoiceHDeclarOperation.AsInteger in [3] then
    Value:='по накл. №'+MInvoiceHDeclarInvoiceNum.AsString
  else
    Value:='';
end;

function TmdMat.GetDefaultAccount: string;
begin
   Result:=FDefaultAccount;
end;

function TmdMat.GetDefaultDepot: integer;
begin
   case mdMat.IsShop of
   43: Result:=52; // торговый комплекс
   39: Result:=61; // комплекс общественного питания
   else
     Result:=91;
   end;
end;

function TmdMat.MInvoiceHDeclarSourceDepotNameFilter(
  Sender: TObject): String;
  var i: integer;
begin
  Result:='';
  if IsShop>0 then
    begin
      for i:=0 to DepotList.Count-1 do
        begin
          if i>0 then Result:=Result+' or ';
          Result:=Result+'(kod='+DepotList[i]+')';
        end;
      Result:='('+Result+') and ';
    end;
  Result:=Result+'not (name=''-(нет)*'')';
end;

function TmdMat.IsShop: integer;
begin
  if FDefaultShop = 91 then
    Result := 0 // материальные склады
  else
    // торговый комплекс
    // комплекс общественного питания
    Result := FDefaultShop;
end;

function TmdMat.MInvoiceTDeclarMaterialNameFilter(Sender: TObject): String;
begin
  Result:='(kod>=1000000)';
  if not (MInvoiceHDeclarOperation.AsInteger in [3, 9, 11, 13, 16, 18]) then
    begin
      if not MInvoiceForm.cbAllMat.Visible or not MInvoiceForm.cbAllMat.Checked then
        Result := Result + ' and ( Amount>0 ) and ( Depot='+IntToStr(MInvoiceHDeclarSourceDepot.AsInteger)+' )';
      // следующее выражение под вопросом - непонятно что с полем Section
      if IsShop>0 then
        Result := Result+' and (Account=''41.00'')'
      else
        Result := Result+' and (Account<>''41.00'')';
      //Result:=Result + '( Depot='+IntToStr(MInvoiceHDeclarSourceDepot.AsInteger)+' )';
      // попытка убрать отключения нижнего датасета
      if not (MInvoiceTDeclarMaterialName.LookupDataSet=MaterialsEditLookupCalc) then
          MInvoiceTDeclarMaterialName.LookupDataSet:=MaterialsEditLookupCalc;
      if not MaterialsEditLookupCalc.Active then MaterialsEditLookupCalc.Active:=True;
      // end попытка убрать отключения нижнего датасета
    end;
  //MaterialNameFilter(Sender);
  if IsShop=43 then // торговый комплекс
  // торговый комплекс имеет право только на ветку 800
    Result:=Result+' and (kod >= 8000000) and (kod < 9000000)';
  if IsShop=39 then // комплекс общественного питания
  // комплекс питания (столовая) - ветка 600
    Result:=Result+' and (kod >= 6000000) and (kod < 7000000)';
//--  ShowMessage(Result);  
end;

procedure TmdMat.MSaleAddDeclarCalcFields(DataSet: TDataSet);
var aNum: extended;
begin
  // расчет примерной отпускной цены при известных ставках торговой надбавки и НДС
  try
    aNum:=(Dataset.FieldByName('PriceUC').AsFloat*(1+Dataset.FieldByName('RATE').AsFloat))*(1+Dataset.FieldByName('VAT').AsFloat);
  except
    aNum:=0;
  end;
  Dataset.FieldByName('PriceNew').AsFloat:=RoundA(aNum);
end;

procedure TmdMat.MInvoiceVPrintDeclarCalcFields(DataSet: TDataSet);
begin
  // суммы прописью
  MInvoiceVPrintDeclarSummaVATPro.AsString:=mdInvc.NumberToWordsCurrency(MInvoiceVPrintDeclarSummaVAT.AsFloat, MInvoiceHDeclarCurrency.AsInteger);
  MInvoiceVPrintDeclarTotalsPro.AsString:=mdInvc.NumberToWordsCurrency(MInvoiceVPrintDeclarTotals.AsFloat, MInvoiceHDeclarCurrency.AsInteger);
  MInvoiceVPrintDeclarAmountPro.AsString:=EtvRus.NumberToWords(MInvoiceVPrintDeclarAmount.AsFloat,mtNothing,nil);
end;

procedure TmdMat.MInvoiceTVPrintDeclarCalcFields(DataSet: TDataSet);
begin
  MInvoiceTVPrintDeclarVAT.AsFloat:=MInvoiceTVPrintDeclarRateVAT.AsFloat*100;
  // ---------------------------------
  MInvoiceTVPrintDeclarPrice_no_BID2.AsFloat:=Round50(MInvoiceTVPrintDeclarPrice_no_BID.AsFloat);
  MInvoiceTVPrintDeclarSummaBy2.AsFloat:=Round10(MInvoiceTVPrintDeclarPrice_no_BID2.AsFloat*MInvoiceTVPrintDeclarAmount.AsFloat);
  MInvoiceTVPrintDeclarSummaVatBy2.AsFloat:=Round10(MInvoiceTVPrintDeclarSummaBy2.AsFloat*MInvoiceTVPrintDeclarRateVAT.AsFloat);
  MInvoiceTVPrintDeclarTotalBy2.AsFloat:=Round10(MInvoiceTVPrintDeclarSummaBy2.AsFloat+MInvoiceTVPrintDeclarSummaVatBy2.AsFloat);
end;

procedure TmdMat.UniformVDeclarBeforeOpen(DataSet: TDataSet);
begin
  if (mdBase.ModuleBase.UsersDeclarEmpNo.AsInteger <> 6271) and
     (mdBase.ModuleBase.UsersDeclarEmpNo.AsInteger <> 391)then
    begin
      DataSet.Filtered := False;
      DataSet.Filter := 'sUser = '+mdBase.ModuleBase.UsersDeclarEmpNo.AsString;
      DataSet.Filtered := True;
    end;
end;

procedure TmdMat.UniformVDeclarAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
  DataSet.Last;
end;

procedure TmdMat.UniformVDeclarDateBegSetText(Sender: TField;
  const Text: String);
begin
  Sender.AsString:=StringReplace(Text,',','.',[rfReplaceAll]);
end;

procedure TmdMat.UniformProfDeclarAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TmdMat.UniformProfCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    BtnUniformProf:=TBitBtn.Create(Form);
    with BtnUniformProf do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=115;
      Width:=200;
      Height:=22;
      Name:='BtnUniformProf';
      Font.Style:=[fsBold];
      Caption:='Альтернативный СИЗ';
      OnClick:=CalcUniformProfClick;
      TabStop:=true;
      TabOrder:=1;
    end;
    BtnUniformProfJ:=TBitBtn.Create(Form);
    with BtnUniformProfJ do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=320;
      Width:=200;
      Height:=22;
      Name:='BtnUniformProfJ';
      Font.Style:=[fsBold];
      Caption:='Альтернативы профессий';
      OnClick:=CalcUniformProfJClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcUniformProfClick(Sender: TObject);
  var UniformProfID: integer;
      i: integer;
      Cond: TListObj;
begin
 if UniformProfDeclar.Active and
    (UniformProfDeclar.RecordCount>0) then
    begin
      UniformProfID:= UniformProfDeclar.FieldByName('ID').AsInteger;
      with UniformProfAnalogDeclar do
        begin
          if not Active then Active := True;
          Filtered := False;
          Filter := 'UniformProfID='+IntToStr(UniformProfID);
          Filtered := True;
        end;
      UniformProfAnalogC.Tag := UniformProfID;
      UniformProfAnalogC.Execute;
    end;
end;

procedure TmdMat.UniformProfAnalogDeclarNewRecord(DataSet: TDataSet);
begin
  //
  UniformProfAnalogDeclarUniformProfID.AsInteger := UniformProfAnalogC.Tag;
  UniformProfAnalogDeclarGroup.AsInteger := 1;
end;

procedure TmdMat.UniformVCCreateForm(Sender: TObject);
begin
  //
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin

  end;

end;

procedure TmdMat.CalcUniformProfJClick(Sender: TObject);
begin
  with UniformProfAnalogJobDeclar do
    begin
      if not Active then Active := True;
    end;
  UniformProfAnalogJobC.Execute;
end;

procedure TmdMat.UniformCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do
    begin
      ReportUniform:=TXEDBLookupCombo.Create(PageControl1TabPanel);
      Grid.OnDrawColumnCell:=DrawUniformCell;
      Grid.TitleRows:=4;
      ComboUniform:=nil;
      with ReportUniform do begin
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=10;
        Width:=300;
        Height:=22;
        Parent:=PageControl1TabPanel;
        Name:='ReportUniform';
        KeyField:='ID';
        ListField:='TabNum;FullName';
        DataSource2.DataSet:=ModuleWorkers.WorkersVVLookup;
        if not ModuleWorkers.WorkersVVLookup.Active then ModuleWorkers.WorkersVVLookup.Active:=True;
        ListSource:=DataSource2;
        Font.Style:=[fsBold];
        Caption:='Расчет формы';
        TabStop:=true;
        TabOrder:=0;
        OnCloseUp:=OnUniformWorkerChoice;
        OnKeyDown:=OnUniformWorkerKeyDown;
      end;
      LabelMainSection:=TLabel.Create(PageControl1TabPanel);
      with LabelMainSection do
        begin
          Anchors:=[akTop,akLeft];
          Top:=30;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Font.Color:=TColor($805080);
          Name:='LabelMainSection';
          Font.Style:=[fsBold];
          Caption:='';
        end;
      LabelSection:=TLabel.Create(PageControl1TabPanel);
      with LabelSection do
        begin
          Anchors:=[akTop,akLeft];
          Top:=50;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Font.Color:=clPurple;
          Name:='LabelSection';
          Font.Style:=[fsBold];
          Caption:='';
        end;
      LabelProf:=TLabel.Create(PageControl1TabPanel);
      with LabelProf do
        begin
          Anchors:=[akTop,akLeft];
          Top:=70;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Name:='LabelProf';
          Font.Color:=clNavy;
          Font.Style:=[fsBold];
          Caption:='';
        end;
      WorkerLab:=TLabel.Create(PageControl1TabPanel);
      with WorkerLab do
        begin
          Parent:=PageControl1TabPanel;
          Anchors:=[akTop,akLeft];
          Top:=0;
          Left:=310;
          Width:=50;
          Height:=22;
          Alignment:=taLeftJustify;
          Name:='WorkerLab';
          Font.Color:=clNavy;
          Font.Style:=[fsBold];
          Caption:='';
        end;
      UniformProfGrid:=TXEDBGrid.Create(PageControl1TabPanel);
      with UniformProfGrid do
        begin
          Anchors:=[akTop,akLeft];
          Top:=100;
          Left:=10;
          Width:=550;
          Height:=150;
          Parent:=PageControl1TabPanel;
          Name:='UniformProfGrid';
          ReadOnly:=True;
          Options:=Options+[dgRowSelect]-[dgAlwaysShowSelection];
          DataSource:=UniformProfWorkerDeclar.LinkSource;
          if not UniformProfWorkerDeclar.Active then UniformProfWorkerDeclar.Active:=True;
          OnDrawColumnCell:=DrawUniformNewCell;
          TabStop:=False;
        end;
      PageControl1TabPanel.TabOrder:=0;
      PageControl1TabPanel.AutoSize:=False;
      PageControl1TabPanel.AutoSize:=True;
    end;
end;

procedure TmdMat.OnUniformWorkerChoice(Sender: TObject);
 var sFilter: string;
     Section, SectionMain, Prof: integer;
     Worker: integer;
begin
  //
    sFilter:='Worker=-1';
    Worker:=-1;
    if ReportUniform.KeyValue>0 then
      try
        Worker:=Integer(ReportUniform.KeyValue);
        sFilter:='Worker='+IntToStr(Worker);


        // подтягиваем профессию и подразделение
        TempQuery.SQL.Text:=' select W.Section,S.name as SectionName,W.Position as Prof,P.name as ProfName  '+
                            ' from STA.WCareer W, STA.SprSection S, STA.SprProf P '+
                            ' where W.ID='+IntToStr(Worker)+
                            ' and W.DateOff is null '+
                            //' and W.Temp=0 '+
                            ' and S.Section=W.Section '+
                            ' and P.Kod=W.Position';
        try
          TempQuery.Open;
          Section := TempQuery.Fields[0].AsInteger;
          LabelSection.Caption := IntToStr(Section)+' '+TempQuery.Fields[1].AsString;
          Prof := TempQuery.Fields[2].AsInteger;
          LabelProf.Caption := IntToStr(Prof)+' '+TempQuery.Fields[3].AsString;
          WorkerLab.Caption:=IntToStr(Worker);
          TempQuery.Close;
        except
        end;

        // основное подразделение
        SectionMain:=(Section div 10000)*10000;
        TempQuery.SQL.Text:=' select S.name as SectionName '+
                            ' from STA.SprSection S '+
                            ' where S.Section='+IntToStr(SectionMain);
        try
          TempQuery.Open;
          LabelMainSection.Caption := AnsiUpperCase(TempQuery.Fields[0].AsString);
          TempQuery.Close;
        except
        end;

        // подтягиваем нормы выдачи
        TempQuery.SQL.Text:=' begin'+
                            ' call STA.GetUniformProfWorker('+IntToStr(Worker)+'); '+
                            ' end;';
        try
          TempQuery.ExecSQL;
        except
        end;

        UniformProfWorkerDeclar.Active:=False;
        UniformProfWorkerDeclar.Active:=True;
      except end;
    UniformDeclar.Tag:=Worker;
    UniformDeclar.Filtered := False;
    UniformDeclar.Filter := sFilter;
    UniformDeclar.Filtered := True;
end;

procedure TmdMat.OnUniformWorkerKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then OnUniformWorkerChoice(Sender);
end;

procedure TmdMat.UniformCActivateForm(Sender: TObject);
begin
  ReportUniform.SetFocus;
end;

procedure TmdMat.UniformDeclarNewRecord(DataSet: TDataSet);
begin
  UniformDeclarWorker.AsInteger:=UniformDeclar.Tag;
end;

procedure TmdMat.DrawUniformCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (UniformDeclarDateEnd.AsDateTime <= Date) and
      (not UniformDeclarDateEnd.IsNull)
    then
      if (gdSelected in State) and (gdFocused in State) then
        TDBGrid(Sender).Canvas.Font.Color := clYellow
      else
        TDBGrid(Sender).Canvas.Font.Color := clRed
    else
      if (gdSelected in State) and (gdFocused in State) then
        TDBGrid(Sender).Canvas.Font.Color := clHighlightText
      else
        TDBGrid(Sender).Canvas.Font.Color := clWindowText;
//  TDBGrid(Sender).Font.Size:=12;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TmdMat.DrawMShopRstPrihCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Pos('ВСЕГО ',MShopRstPrihDeclarClientName.AsString) >0
    then
      begin
        TDBGrid(Sender).Canvas.Font.Style:=[fsBold];
        if (gdSelected in State) and (gdFocused in State) then
          TDBGrid(Sender).Canvas.Font.Color := clYellow
        else
          TDBGrid(Sender).Canvas.Font.Color := clNavy;
      end
   else if Pos('ИТОГО ',MShopRstPrihDeclarClientName.AsString) >0
    then
      begin
        TDBGrid(Sender).Canvas.Font.Style:=[fsBold];
        if (gdSelected in State) and (gdFocused in State) then
          TDBGrid(Sender).Canvas.Font.Color := clYellow
        else
          TDBGrid(Sender).Canvas.Font.Color := clMaroon;
      end
    else
      if (gdSelected in State) and (gdFocused in State) then
        TDBGrid(Sender).Canvas.Font.Color := clHighlightText
      else
        TDBGrid(Sender).Canvas.Font.Color := clWindowText;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.DrawUniformNewCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (UniformProfWorkerDeclarNum.AsString = '*') then
      if (gdSelected in State){ and (gdFocused in State)} then
        TDBGrid(Sender).Canvas.Font.Color := clYellow
      else
        TDBGrid(Sender).Canvas.Font.Color := clBlue;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.UniformReportCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
//    Grid.OnDrawColumnCell:=DrawMShopRstPrihCell;
    PageControl1TabPanel.Autosize:=False;
    BtnUniformReport:=TBitBtn.Create(Form);
    with BtnUniformReport do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=100;
      Height:=22;
      Name:='BtnUniformReport';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcUniformReportClick;
      TabStop:=true;
      TabOrder:=3;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcUniformReportClick(Sender: TObject);
begin
  ExecSQLText(UniformReportDeclar.DataBaseName,
     'call STA.GetUniformReport()',false);
  //TBEForm(MShopRstPrihC.Form).Caption:='РЕЕСТР ПРИХОДА ЗА ПЕРИОД с '+ReportShopPeriod_from.Text+ ' по '+ReportShopPeriod_to.Text;
  try
    UniformReportDeclar.DisableControls;
    UniformReportDeclar.Close;
    UniformReportDeclar.Open;
    UniformReportDeclar.EnableControls;
  except
  end;
  with TBEForm(UniformReportC.Form).Grid do begin
   //FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.UniformDeclarBeforeOpen(DataSet: TDataSet);
begin
  MaterialsEditLookupCalcUniform.Active:=False;
  MaterialsEditLookupCalcUniform.Active:=True;
end;

procedure TmdMat.UniformUpdateLookupCombo(Sender: TColumn; Field: TField);
begin
end;

procedure TmdMat.UniformComboOnCloseUp(Sender: TObject);
begin
end;

procedure TmdMat.UniformProfAnalogJobCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do
    begin
      Grid.OnDrawColumnCell:=DrawUniformCell;
      Grid.TitleRows:=4;
      ComboUniform:=nil;
      with ReportUniform do begin
        Anchors:=[akTop,akLeft];
        Top:=0;
        Left:=10;
        Width:=300;
        Height:=22;
        Parent:=PageControl1TabPanel;
        Name:='ReportUniform';
        KeyField:='ID';
        ListField:='TabNum;FullName';
        DataSource2.DataSet:=ModuleWorkers.WorkersVVLookup;
        if not ModuleWorkers.WorkersVVLookup.Active then ModuleWorkers.WorkersVVLookup.Active:=True;
        ListSource:=DataSource2;
        Font.Style:=[fsBold];
        Caption:='Расчет формы';
        TabStop:=true;
        TabOrder:=0;
        OnCloseUp:=OnUniformWorkerChoice;
        OnKeyDown:=OnUniformWorkerKeyDown;
      end;
      LabelMainSection:=TLabel.Create(PageControl1TabPanel);
      with LabelMainSection do
        begin
          Anchors:=[akTop,akLeft];
          Top:=30;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Font.Color:=TColor($805080);
          Name:='LabelMainSection';
          Font.Style:=[fsBold];
          Caption:='';
        end;
      LabelSection:=TLabel.Create(PageControl1TabPanel);
      with LabelSection do
        begin
          Anchors:=[akTop,akLeft];
          Top:=50;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Font.Color:=clPurple;
          Name:='LabelSection';
          Font.Style:=[fsBold];
          Caption:='';
        end;
      LabelProf:=TLabel.Create(PageControl1TabPanel);
      with LabelProf do
        begin
          Anchors:=[akTop,akLeft];
          Top:=70;
          Left:=10;
          Width:=300;
          Height:=22;
          Parent:=PageControl1TabPanel;
          Alignment:=taLeftJustify;
          Name:='LabelProf';
          Font.Color:=clNavy;
          Font.Style:=[fsBold];
          Caption:='';
        end;
      UniformProfGrid:=TXEDBGrid.Create(PageControl1TabPanel);
      with UniformProfGrid do
        begin
          Anchors:=[akTop,akLeft];
          Top:=100;
          Left:=10;
          Width:=550;
          Height:=150;
          Parent:=PageControl1TabPanel;
          Name:='UniformProfGrid';
          ReadOnly:=True;
          Options:=Options+[dgRowSelect]-[dgAlwaysShowSelection];
          DataSource:=UniformProfWorkerDeclar.LinkSource;
          if not UniformProfWorkerDeclar.Active then UniformProfWorkerDeclar.Active:=True;
          OnDrawColumnCell:=DrawUniformNewCell;
          TabStop:=False;
        end;
      PageControl1TabPanel.TabOrder:=0;
      PageControl1TabPanel.AutoSize:=False;
      PageControl1TabPanel.AutoSize:=True;
    end;
end;

procedure TmdMat.UniformReportCheckSectionCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportUniformSection:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with ReportUniformSection do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='ReportUniformSection';
      KeyField:='Section';
      ListField:='Section;Name';
      SprSectionSource.DataSet:=ModuleBase.SectionLookup;
      if not ModuleBase.SectionLookup.Active then ModuleBase.SectionLookup.Active:=True;
      ListSource:=SprSectionSource;
      KeyValue:=0;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=0;
    end;
    BtnUniformSection:=TBitBtn.Create(PageControl1TabPanel);
    with BtnUniformSection do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnUniformSection';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcUniformSectionClick;
      TabStop:=true;
      TabOrder:=1;
    end;
    PageControl1TabPanel.AutoSize:=True;
  end;
end;

procedure TmdMat.CalcUniformSectionClick(Sender: TObject);
begin
  ExecSQLText(UniformReportCheckSectionDeclar.DataBaseName,
     'call STA.GetUniformReportCheckSection('+IntToStr(Integer(ReportUniformSection.KeyValue))+')',false);
  //TBEForm(MShopRstPrihC.Form).Caption:='РЕЕСТР ПРИХОДА ЗА ПЕРИОД с '+ReportShopPeriod_from.Text+ ' по '+ReportShopPeriod_to.Text;
  try
    UniformReportCheckSectionDeclar.DisableControls;
    UniformReportCheckSectionDeclar.Close;
    UniformReportCheckSectionDeclar.Open;
    UniformReportCheckSectionDeclar.EnableControls;
  except
  end;
  with TBEForm(UniformReportCheckSectionC.Form).Grid do begin
   //FormatColumns(True);
   SetFocus;
  end;
end;

procedure TmdMat.DrawCellMCard(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  if (Column.Field.DataSet = MCardDeclar) and
     (Column.Field.DataSet.FieldByName('Amount_R').Value=0) and
     (Column.Field.DataSet.FieldByName('Amount_P').Value>0)
      then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clLime;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clGreen;
      end;

  if (Column.Field.DataSet = MCardDeclar) and
     (Column.Field.DataSet.FieldByName('Amount_R').Value>0) and
     (Column.Field.DataSet.FieldByName('Amount_P').Value=0)  then
    if (gdSelected in State) and (gdFocused in State) then
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clYellow;
      end
    else
      begin
        TDBGrid(Sender).Canvas.Font.Color:=clMaroon;
      end;

//    TDBGrid(Sender).DefaultDrawDataCell(Rect,nil, State)
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TmdMat.UniformForChangeCCreateForm(Sender: TObject);
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    ReportUniformForChangeDate:=TDateEdit.Create(PageControl1TabPanel);
    with ReportUniformForChangeDate do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Parent:=PageControl1TabPanel;
      Name:='ReportUniformForChangeDate';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1);
    end;
    UniformForChangeCombo:=TXEDBLookupCombo.Create(PageControl1TabPanel);
    with UniformForChangeCombo do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='UniformForChangeCombo';
      KeyField:='Kod';
      ListField:='Kod;Name';
      DataSource1.DataSet:=ModuleBase.ShopLookup;
      if not ModuleBase.ShopLookup.Active then ModuleBase.ShopLookup.Active:=True;
      ListSource:=DataSource1;
      KeyValue:=1;
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    BtnUniformForChange:=TBitBtn.Create(PageControl1TabPanel);
    with BtnUniformForChange do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=540;
      Width:=100;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='BtnUniformForChange';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=BtnUniformForChangeClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.AutoSize:=True;
  end;
end;

procedure TmdMat.BtnUniformForChangeClick(Sender: TObject);
 var DateFrom,DateTo: TDateTime;
begin
  DateFrom:=GetFirstDayOfMonth(ReportUniformForChangeDate.Date);
  DateTo:=GetLastDayOfMonth(DateFrom);
  ExecSQLText(UniformForChangeDeclar.DataBaseName,
     'call STA.GetUniformForChange('''+DateToStr(DateFrom)+
     ''','+IntToStr(Integer(UniformForChangeCombo.KeyValue))+')',false);
  TBEForm(UniformForChangeC.Form).Caption:='Сроки замены спецодежды сотрудников '+ModuleBase.ShopLookupName.AsString+
     ' c '+DateToStr(DateFrom)+' по '+DateToStr(DateTo);
  with TBEForm(UniformForChangeC.Form).Grid do begin
//    FormatColumns(true);
    SetFocus;
  end;
  try
    UniformForChangeDeclar.Active:=False;
    UniformForChangeDeclar.Active:=True;
  except
  end;
end;

function TmdMat.Round50(ANumber: extended): extended;
var A, B: Extended;
begin
  A:=(Round(ANumber) div 100)*100;
  B:=Round(ANumber) mod 100;
  if B<25 then B:=0
  else if B>75 then B:=100
  else B:=50;
  Result:=A+B;
end;

procedure TmdMat.MProviderDecodeDeclarBeforeOpen(DataSet: TDataSet);
begin
  try
    ExecSQLText(MProviderDecodeDeclar.DataBaseName,'call GetMProviderDecode(''01.12.2011'',''31.12.2011'',''23.00'',10);',false);
  finally
    GMoveMat:=True;
  end;
end;

procedure TmdMat.MProviderDecodeCDestroyForm(Sender: TObject);
begin
  ExecSQLText(MMoveMat_PrihDeclar.DataBaseName,'call GetMProviderDecode(''01.12.2011'',''31.12.2011'',''23.00'',20);',false);
end;

procedure TmdMat.MProviderDecodeCCreateForm(Sender: TObject);
begin
      //MMoveMat_PrihDeclar.TableName:='Andy.MMoveMat_Prih';
  TDBFormControl(Sender).Caption:='Расшифровки??';
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    PageControl1TabPanel.Autosize:=False;
    MODecodePeriod_from:=TDateEdit.Create(Form);
    with MODecodePeriod_from do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=125;
      Width:=80;
      Height:=20;
      Name:='MODecodePeriod_from';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=0;
      YearDigits:=dyTwo;
      Date := WorkDate;
    end;
    MODecodePeriod_to:=TDateEdit.Create(Form);
    with MODecodePeriod_to do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
      Width:=80;
      Height:=20;
      Name:='MODecodePeriod_to';
      Font.Style:=[fsBold];
      TabStop:=true;
      TabOrder:=1;
      YearDigits:=dyTwo;
      Date := IncMonth(WorkDate,1)-1;
    end;
    MODecodeAccount:=TComboBox.Create(Form);
    with MODecodeAccount do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=305;
      Width:=70;
      Height:=22;
      Style:= csDropDownList;
      Name:='MODecodeAccount';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=2;
    end;
    with ModuleCommon.AccountLookup do
      begin
        MODecodeAccount.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleCommon.AccountLookup.Eof do
          begin
            MODecodeAccount.Items.Add(FieldByName('BuhAccount').AsString);
            Next;
          end;
        MODecodeAccount.ItemIndex:=0;
      end;

    MODecodeBtn:=TBitBtn.Create(Form);
    with MODecodeBtn do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top := 0;
      Left := 390;
      Width := 100;
      Height := 22;
      Name := 'MODecodeBtn';
      Font.Style := [fsBold];
      Caption := 'Расчет формы';
      OnClick := MODecodeBtnClick;
      TabStop := true;
      TabOrder := 3;
    end;
    Grid.OnDrawColumnCell:=DrawCellMMove;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.MODecodeBtnClick(Sender: TObject);
  var i: integer;

// формируем имя поля
procedure GetName(AField: TField);
  var ss, ssbuh: string;
      num: integer;
begin
   if AnsiUpperCase(AField.FullName) = 'KOD_DEPOT' then AField.DisplayLabel := 'код';
   if AnsiUpperCase(AField.FullName) = 'NAME_DEPOT' then AField.DisplayLabel := 'Подразделение';
   if AnsiUpperCase(AField.FullName) = 'ITOG' then AField.DisplayLabel := 'ИТОГО';
   if (AnsiUpperCase(AField.FullName)[1] = 'F') then
      begin
        // бухсчет
        ssbuh := Copy(AField.FullName, 2, 5);
        ssbuh[3] := '/';

        ss := Copy(AField.FullName,9,Length(AField.FullName)-9);

        try
          ss:=GetFromSQLText('AO_GKSM_InProgram','select name from MObjZatr where kod='+ss,false);
        except
          ss:='*****'
        end;

        AField.DisplayLabel := ssbuh + ' ' + ss;
      end;
end;

begin
  ExecSQLText(MProviderDecodeDeclar.DataBaseName,
    'call GetMProviderDecode('''+MODecodePeriod_from.Text+''','''+
    MODecodePeriod_to.Text+''','''+MODecodeAccount.Items[MODecodeAccount.ItemIndex]+''',0)',false);
  AssignColumns(MProviderDecodeDeclar,TBEForm(MProviderDecodeC.Form));

  TBEForm(MProviderDecodeC.Form).Caption:=
    'Расшифровки?? по <'+MODecodeAccount.Items[MODecodeAccount.ItemIndex]+'> за период с '+

  MODecodePeriod_from.Text+ ' по '+MODecodePeriod_to.Text;
  with TBEForm(MProviderDecodeC.Form).Grid do begin
   FormatColumns(True);
   with MProviderDecodeDeclar do
     for i:=0 to Fields.Count - 1 do
       GetName(Fields[i]);
   SetFocus;
  end; 
end;

Initialization
  XNotifyEvent:=TXNotifyEvent.Create(nil);
  SetLength(CurColorArr,2);
  CurColorArr[0]:=TColor($f0f0f0);
  CurColorArr[1]:=TColor($fafafa);
  GMoveMat := False;
  GCalc := False;
  calcPrice:=False;
  calcBID:=False;
  if not Assigned(TempQuery) then
    begin
      TempQuery:=TQuery.Create(Application);
      TempQuery.DatabaseName:='AO_GKSM_InProgram';
    end;


Finalization
  XNotifyEvent.Free;
  XNotifyEvent:=nil;

end.

