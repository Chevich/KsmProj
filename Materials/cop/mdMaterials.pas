unit mdMaterials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  XMisc, XTFC, XDBTFC, DBTables, EtvTable, LnTables, LnkSet, EtvLook, XECtrls,
  XEFields, Db, Menus, EtvDBase, UsersSet, XApps, ComCtrls, VG, ppBands,
  ppCtrls, EtvPpCtl, ppPrnabl, ppClass, ppDB, ppProd, ppReport, ppComm,
  ppRelatv, ppCache, ppDBPipe, ppDBBDE, ppModule, daDatMod, SelectBox,
  ppVar, Commctrl, DBGrids, Grids, ppStrtch, ppMemo, EtvDB, extctrls,BEForms,
  ImgList;

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
    MObjZatrDeclarKOD: TAutoIncField;
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
    MFakturaDeclarSummaClose: TFloatField;
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
    MFakturaMoveAccountsDeclarKredit: TStringField;
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
    MProviderCalcDeclarBalanceEnd: TIntegerField;
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
    procedure CalcMDrgInventClick(Sender: TObject);
    procedure CalcMOsnastkaCurClick(Sender: TObject);
    procedure CalcMOsnastkaCurClickDoc(Sender: TObject);
    procedure CalcMOsnastkaCurClickDel(Sender: TObject);
    procedure CalcMAmounts2Click(Sender: TObject);
    procedure CalcMAmounts_BUHClick(Sender: TObject);
    procedure CalcMAmounts_BUH2Click(Sender: TObject);
    procedure CalcMAmounts_BUH3Click(Sender: TObject);
    procedure CalcMCardsClick(Sender: TObject);
    procedure CalcMCards2Click(Sender: TObject);
    procedure CalcMOborotMatClick(Sender: TObject);
    procedure CalcMProviderCalcClick(Sender: TObject);
    procedure CalcMSvodMoveClick(Sender: TObject);
    procedure CalcMSvodProviderClick(Sender: TObject);
    procedure CalcMSvodProviderClick2(Sender: TObject);
    procedure CalcMProviderAnalitClick(Sender: TObject);
    procedure CalcMProviderAnalitClick2(Sender: TObject);
    procedure CalcMMoveMatClick(Sender: TObject);
    procedure CalcMostNmoveClick(Sender: TObject);
    procedure CalcMControlResClick(Sender: TObject);
    procedure CalcMFindClick(Sender: TObject);
    procedure CalcMFindClick2(Sender: TObject);
    procedure CalcMRashWorkClick(Sender: TObject);
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
  private
    { Private declarations }
    NodeID:Variant;
    NewRecord:Boolean;
    MKodUp:Variant;
    BOX:TFormSelect;
    GlobalCourse: Currency;
    Course:Currency;
    LastMatName:string;
    LastUnitM: integer;
    LastSection: integer;
    LastAccount: string;
    DeleteNode: TTreeNode;
    Changing: boolean;
    procedure DrawCellAmount(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMotion(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellSpisanie(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMSvodMove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMMove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMostNmove(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DrawCellMControlRes(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure RefreshTree(DataSet: TDataSet; LocateNew: Boolean = True);
    procedure FindNewNumDoc;
    function FirstDayOfMonth(ADate: TDateTime): TDateTime;
    function RoundA(ANumber: extended): extended;
    procedure LocalCalcTotals(DataSet: TDataSet);
    procedure RecalcAllRoznica(Sender: TObject);
    procedure RecalcAll(Sender: TObject);
    function GetOperNum(Sender: TObject): integer;
    procedure MGridTitleClick(Column:TColumn);
    function FindMaretialsFirstPriceForRash(Material: extended; Depot: integer; var PriceUC: Double; var Account: string): extended;
    Function MaterialNameFilter(Sender: TObject): string;
    procedure OnDblClickCheck_SS(Sender: TObject);
    procedure CheckDrgOper;
    procedure OnMOsnastkaChange(Sender: TObject);
    procedure AssignAccounts;
    procedure RecalcFakturaSum;
    procedure DrawDataInvoice;
  public
    { Public declarations }
    WorkDate :TDateTime;
    CloseDate :TDateTime;
    function GetFirstDayOfMonth(date: TDateTime): TDateTime;
    function GetLastDayOfMonth(date: TDateTime): TDateTime;
//    GlobalSourceDepot : integer;
    procedure ShowFields(ColumnList:TColumnList; AddFields: boolean);
    procedure DrawInputFields(ColumnList:TColumnList);
    procedure SortInputFields(index: integer);
    procedure ChangeMaterialLookup(isRashod: boolean = False);
    procedure DoCalcOst(IsDelete: boolean; DataSet: TDataSet);
    function CheckRashod: boolean;
    procedure ShowDrgWindow;
    procedure OpenDokHistory(ADeclar:TLinkTable; AMaterial, APriceUc: extended; ADepot: integer;
  DepotFieldName: string = 'DEPOT';
  PriceFieldName: string = 'PRICEUC';
  MaterialFieldName: string = 'MATERIAL');
    procedure ShowServiceInfo;
    procedure ShowMCard(AMaterial: extended; ADepot: integer; APriceUC: extended;
                        Adt_from, Adt_to: TDateTime; AAccount: string);
    procedure AssignColumns(DataSet: TDataSet;aForm:TBEForm; isVisible: boolean = True);
  end;

var mdMat: TmdMat;
    FieldListNames: array [0..25] of string=
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
     'SummaCustomBy'  // 25
     );
    TempQuery: TQuery;

implementation
uses Buttons, ToolEdit, Materials, MdBase, MdCommon,MdGeography,MdOrgs, MInvoice, EtvDBFun, EtvBor, DBCommon, MFaktura,
     XDBMisc, Misc, StdCtrls, MdInvc, MdContr, RxSpin, MInvoiceCheckSS, MInvoiceDragInfo, EtvFilt, EtvMem, MServiceUnit;
{$R *.DFM}
Const TotalList:string='_Amount_Summa_SummaBy_SummaVAT_SummaVatBy_SummaBID_SummaBIDBy_Total_TotalBy_SummaCustomBy_';
var BtnCalcMAmounts: TBitBtn;
    ChbxMRashWork: TCheckBox;
    ChbxMReadyMat: TCheckBox;
    BtnCalcMDrgInvent: TBitBtn;
    BtnCalcMAmounts2: TBitBtn;
    BtnCalcPKPBook: TBitBtn;
    BtnCalcMAmounts3: TBitBtn;
    ReportPeriodMAmounts: TDateEdit;
    ReportPeriodMDrgInvent: TDateEdit;
    ReportDepotMDrgInvent: TComboBox;
    BtnCalcMCards: TBitBtn;
    BtnCalcMCardsInt: TBitBtn;
    BtnCalcMCards2: TBitBtn;
    ReportSpinEdit: TrxSpinEdit;
    ReportDepotMControl: TComboBox;
    ReportPeriod: TDateEdit;
    ReportPeriod_from: TDateEdit;
    ReportEdit: TEdit;
    ReportLabel: TLabel;
    ReportPeriod_to: TDateEdit;
    ReportDepotMAmounts: TXEDBLookupCombo;
    ReportClientMProviderCalc: TXEDBLookupCombo;
    ReportDepotMAmounts2: TComboBox;
    ReportMOsnastka: TComboBox;
    ReportDepotMCards: TXEDBLookupCombo;
    ReportAccountMRashWork: TComboBox;
    ReportAccountMRashWork2: TComboBox;
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
    if FieldByName('Kredit').AsVariant=null then FieldByName('Kredit').AsString:='60.00';
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
     3,10:
      begin
        FieldByName('RateVAT').AsFloat:=0.18;
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
    case GetOperNum(Dataset.Fields[0]) of
    7:
      begin
        with DataSet do begin
          a:=(1 + FieldByName('BID').AsFloat)*FieldByName('PriceBy').AsFloat*FieldByName('Amount').AsFloat;
          FieldByName('SummaVATBy').AsFloat:=RoundA(FieldByName('RateVAT').AsFloat*a);
          FieldByName('TotalBy').asFloat:=RoundA((1+FieldByName('RateVAT').AsFloat)*a);
          FieldByName('Total').asFloat:=FieldByName('TotalBy').asFloat;
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
  LocalCalcTotals(Sender.DataSet);
end;

Procedure TmdMat.MInvoiceTDeclarAmountChange(Sender: TField);
begin
  if GetOperNum(Sender) = 16 then
    RecalcAllRoznica(Sender)
  else
    begin
      with Sender.DataSet do begin //Наверное придется делать case
       if FieldByName('Operation').AsInteger=3 then // простой приход
         begin
           FieldByName('Price').AsFloat:=(1+FieldByName('BID').AsFloat)*(FieldByName('Price_no_BID').AsFloat);
           FieldByName('Price_no_round').AsFloat:=FieldByName('Price').AsFloat*Course;
           // Цена округляется только в приходе!!!
           FieldByName('PriceBy').AsFloat:=RoundA(FieldByName('Price_no_round').AsFloat);
         end;
       if FieldByName('Operation').AsInteger in [4,7,8] then // простой расход
         begin
           FieldByName('Price').AsFloat:=FieldByName('PriceBy').AsFloat;
           FieldByName('Price_no_round').AsFloat:=FieldByName('PriceBy').AsFloat;
         end;
       FieldByName('Summa').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat;
       if FieldByName('Operation').AsInteger=11 then // валютный приход
         FieldByName('SummaBy').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('Price').AsFloat*Course
       else
         FieldByName('SummaBy').AsFloat:=FieldByName('Amount').AsFloat*FieldByName('PriceBy').AsFloat;
       if FieldByName('Operation').AsInteger<>10
         then FieldByName('DocAmount').AsFloat:=FieldByName('Amount').AsFloat;
       LocalCalcTotals(Sender.DataSet);
       if FieldByName('Operation').AsInteger=4 then // расход
           begin
             MInvoiceT_SSDeclarSTVChange(Sender);
           end;
      end;
    end;
end;

Procedure TmdMat.MInvoiceTDeclarBIDChange(Sender: TField);
begin
  if not calcBID then
    try
      calcBid:=True;
      case GetOperNum(Sender) of
      7:
        with MInvoiceTDeclar do
          begin
            if (FieldByName('Price_no_BID').AsFloat <> RoundA((1 + FieldByName('BID').AsFloat)*FieldByName('PriceBy').AsFloat)) then
              FieldByName('Price_no_BID').AsFloat := RoundA((1 + FieldByName('BID').AsFloat)*FieldByName('PriceBy').AsFloat);
            if (FieldByName('SummaBy').AsFloat <> FieldByName('Amount').AsFloat*FieldByName('Price_no_BID').AsFloat) then
              FieldByName('SummaBy').AsFloat := FieldByName('Amount').AsFloat*FieldByName('Price_no_BID').AsFloat;
          end;
      16: RecalcAllRoznica(Sender)
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
          end;
     end; // case
 finally
   calcBid:=False;
 end;
end;

Procedure TmdMat.MaterialsEditDeclarNewRecord(DataSet: TDataSet);
var Kod:Variant;
begin
  NewRecord:=true;
  if LastUnitM<>0 then DataSet.FieldByName('UnitM').AsInteger:=LastUnitM;
  if LastSection<>0 then DataSet.FieldByName('Section').AsInteger:=LastSection;
  DataSet.FieldByName('Account').AsString:=LastAccount;
  DataSet.FieldByName('Name').AsString:=LastMatName;
  Kod:=GetFromSQLText('AO_GKSM_InProgram','Select Max(Kod)+1 from sta.Materials where kodup='+
    DataSet.FieldByName('KodUp').AsString,false);
  if Kod=null then Kod:=DataSet.FieldByName('KodUp').asString+'0000';
  DataSet.FieldByName('KOD').Value:=Kod
end;

Procedure TmdMat.MasterChange(DataSet:TDataSet);
begin
  XNotifyEvent.GoSpellChild(TMInvoiceForm(MInvoiceC.Form).XEDBGrid1, xeSumExecute, MInvoiceT.DeclarLink, opInsert);
  //
end;

Procedure TmdMat.MdMatCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  NodeID:=-1;
  TEtvMasterDataLink(MinvoiceTDeclar.MasterLink).onMasterScroll:=MasterChange;
  LastUnitM:=4;
  LastMatName:='';
  LastAccount:='';
  MaterialsEditDeclarSectionName.OnFilter:=ModuleBase.SectionNameFilter;
  GlobalCourse:=1;
  CurDateIns:=Now;
//  GlobalSourceDepot:=-1;
  Changing:=False;
  WorkDate:=GetFromSQLText(MAmountsDeclar.DataBaseName,
    'select ReportPeriod from STA.ADMCONFIG',false);
  CloseDate:=GetFromSQLText(MAmountsDeclar.DataBaseName,
    'select CurPeriodmat from STA.ADMCONFIG',false);
//  WorkDate:=EncodeDate(2004,05,1);
end;

Procedure TmdMat.MInvoiceHDeclarOperationChange(Sender: TField);
begin
  // Случай входа в режим инсерт
  if (MInvoiceHDeclar.State in [dsInsert]) and (MInvoiceHDeclarOperation.AsVariant=null) then Exit;
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
  FindNewNumDoc;
end;

Procedure TmdMat.MInvoiceTDeclarSummaChange(Sender: TField);
begin
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
      if not (FieldByName('Operation').AsInteger in [4,6,7,8,15]) then
        begin
          FieldByName('PriceUC').AsFloat:=FieldByName('PriceBy').AsFloat;
        end;
    end;
end;

Procedure TmdMat.MInvoiceTDeclarPriceChange(Sender: TField);
begin
  // балансовые счета
  if not calcPrice then
    try
      CalcPrice:=True;
      AssignAccounts;
      if not CheckRashod then
        begin
         MInvoiceTDeclarPriceUC.AsFloat:=MInvoiceTDeclarPriceBy.AsFloat;
         if GetOperNum(Sender) in [9,13] then
          MInvoiceTDeclarPrice_no_round.AsFloat:=MInvoiceTDeclarPriceBy.AsFloat;
        end;
      if Assigned(Sender) then
        begin
          case GetOperNum(Sender) of
          7:
            with MInvoiceTDeclar do
              begin
                if (FieldByName('Price_no_BID').AsFloat <> FieldByName('PriceBy').AsFloat) then
                    FieldByName('Price_no_BID').AsFloat := FieldByName('PriceBy').AsFloat;
                if (FieldByName('Price_no_round').AsFloat <> FieldByName('PriceBy').AsFloat) then
                    FieldByName('Price_no_round').AsFloat := FieldByName('PriceBy').AsFloat;
                if (PriceLookup.RecordCount>0) and (FieldByName('PriceUC').AsFloat <> PriceLookup.FieldByName('PriceUC').AsFloat) then
                   FieldByName('PriceUC').AsFloat := PriceLookup.FieldByName('PriceUC').AsFloat;
                LocalCalcTotals(MInvoiceTDeclar);
           {     if (FieldByName('Price_no_BID').AsFloat <> FieldByName('PriceBy').AsFloat) then
                  begin
                    FieldByName('Price_no_BID').AsFloat := FieldByName('PriceBy').AsFloat;
                    //FieldByName('Price').AsFloat := FieldByName('PriceBy').AsFloat;
                    GetPrices(TField(Sender).DataSet);
                    if PriceLookup.Locate('Price',FieldByName('PriceBy').AsFloat,[]) then
                      begin
                       FieldByName('PriceUC').AsFloat := PriceLookup.FieldByName('PriceUC').AsFloat;
                       FieldByName('Price').AsFloat := FieldByName('PriceBy').AsFloat
                      end;
                  end;}
              end;
          16: RecalcAllRoznica(Sender);
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
begin
  // Проставляем бухгалтерские счета
  with MInvoiceTDeclar do
    begin
      AutoCalcFields:=true;
      FieldByName('Debit').Clear;
      case MInvoiceHDeclarOperation.AsInteger of
 3,9,10,11,13,14,16: begin
              (FieldByName('MaterialName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Debit'));
              FieldByName('Kredit').AsString:=MInvoiceHDeclarKredit.AsString;
              //В валютных накладных надо вводить контракт в каждую строку!
              (FieldByName('MaterialName') as TXELookField).ValueByLookNameToField('Contract',FieldByName('Contract'));
             end;
          4: begin
                MInvoiceTDeclarPriceBy.AsFloat:=FindMaretialsFirstPriceForRash(MInvoiceTDeclarMaterial.AsFloat,
                  MInvoiceHDeclarSourceDepot.AsInteger, ValueUC ,Account);
                MInvoiceTDeclarKredit.AsString:=Account;
                MInvoiceTDeclarDebit.AsString:=Account;
                if not (MInvoiceHDeclarSourceDepot.AsInteger in SkladSet) and
                 (FieldByName('Kredit').AsString='10.10') then FieldByName('Kredit').AsString:='10.11';
                if not (MInvoiceHDeclarDestDepot.AsInteger in SkladSet) and
                 (FieldByName('Debit').AsString='10.10') then FieldByName('Debit').AsString:='10.11';
                MInvoiceTDeclarPriceUC.AsFloat:=ValueUC;
             end;
    6,7,8,15:
             begin
                FieldByName('Debit').AsString:=MInvoiceHDeclarKredit.AsString;
                MInvoiceTDeclarPriceBy.AsFloat:=FindMaretialsFirstPriceForRash(MInvoiceTDeclarMaterial.AsFloat,
                  MInvoiceHDeclarSourceDepot.AsInteger, ValueUC ,Account);
                MInvoiceTDeclarKredit.AsString:=Account;
                MInvoiceTDeclarPriceUC.AsFloat:=ValueUC;
             end;

      end;
      CheckDrgOper;
      AutoCalcFields:=false;
    end;
end;

Procedure TmdMat.ShowFields(ColumnList:TColumnList; AddFields: boolean);
  var
    i:Byte;
    FList:String;
    aResCalcNames:String;
    index: byte;
begin
  FList:=';';
  if AddFields then
    ColumnList:=ColumnList+[21]+[22]+[23];
  aResCalcNames:='';
  for i:=0 to 255 do
    if i in ColumnList then
      begin
        FList:=FList+FieldListNames[i]+';';
      end;
  with MinvoiceTDeclar do begin
    for i:=0 to Fields.Count-1 do begin
      Fields[i].Visible:=Pos(LowerCase(';'+Fields[i].FieldName+';'),LowerCase(FList))>0;
      if (Fields[i].Visible) then begin
        if (Pos('_'+Fields[i].FieldName+'_',TotalList)>0) then aResCalcNames:=aResCalcNames+'Sum';
        aResCalcNames:=aResCalcNames+';';
      end;
    end;
    if aResCalcNames<>'' then System.Delete(aResCalcNames, Length(aResCalcNames),1);
  end;

  {Корректировка строки ResCalc для инициализации полей для расчета}
  with MInvoiceT.DeclarLink.Calc do begin
    FieldNames:=GetVisibleFieldNames(MInvoiceTDeclar, true, false);
    ResCalcNames:=aResCalcNames;
  end;
  SortInputFields(0);
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
    3,11, 16: // 3 - Приход, 11 - Приход за валюту
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
  MInvoiceHDeclar.Refresh;
  MInvoiceTDeclar.Refresh;
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
      TabOrder:=0;
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
      DataSource1.DataSet:=ModuleBase.DepotLookup;
      ListSource:=DataSource1;
      KeyValue:=91;
      if not ModuleBase.DepotLookup.Active then ModuleBase.DepotLookup.Active:=True;
      Name:='DepotCalcMCards';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    {with ModuleBase.DepotDeclar do
      begin
        ReportDepotMCards.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMCards.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=91 then
              ReportDepotMCards.ItemIndex:=ReportDepotMCards.Items.Count-1;
            Next;
          end;
      end;}
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
      TabOrder:=2;
    end;
    BtnCalcMCards2:=TBitBtn.Create(PageControl1TabPanel);
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
      TabOrder:=3;
    end;
    Grid.OnDrawColumnCell:=DrawCellAmount;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMCardsClick(Sender: TObject);
begin
  ExecSQLText(MCardsDeclar.DataBaseName,
     'call STA.GetMCardsOnPeriod('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''','+IntToStr(Integer(ReportDepotMCards.KeyValue))+')',false);
  TBEForm(MCardsC.Form).Caption:='Движение материалов (обороты) по '+ModuleBase.DepotLookupName.AsString+
     ' ('+ModuleBase.DepotLookupKod.AsString+') за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
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
  if (MInvoiceHDeclar.State in [dsInsert]) and (MInvoiceHDeclarOperation.AsInteger in [3, 11, 16]) then
    begin
      if not Assigned(TempQuery) then
        begin
          TempQuery:=TQuery.Create(Self);
          TempQuery.DatabaseName:=MaterialsEdit.DatabaseName;
        end;
      TempQuery.SQL.Text:='select isNull(Max(cast(numDoc as INTEGER)),0) + 1 from STA.MInvoice '+
       ' where DateDoc >= '''+FormatDateTime('dd.mm.yy', FirstDayOfMonth(MInvoiceHDeclarDateDoc.AsDateTime))+''' and Operation in (3,11,16) and isNumeric(numDoc)=1 ';
      try
        TempQuery.Open;
        MInvoiceHDeclarNumDoc.AsString := TempQuery.Fields[0].AsString;
      except
        MInvoiceHDeclarNumDoc.AsString := '';
      end;
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

function TmdMat.RoundA(ANumber: extended): extended;
begin
  if Assigned(MInvoiceHDeclar) and
     (MInvoiceHDeclarOperation.AsInteger in [3, 7, 11, 16]) then
    Result:=Round(ANumber+0.01)
  else
    Result:=ANumber;
end;

procedure TmdMat.DrawInputFields(ColumnList: TColumnList);
  var i: integer;
begin
  for i:=0 to High(FieldListNames) do
    if i in ColumnList then
       MInvoiceTDeclar.FieldbyName(FieldListNames[i]).Tag:=1
    else
       MInvoiceTDeclar.FieldbyName(FieldListNames[i]).Tag:=0;
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

        if (FieldByName('Amount').AsFloat>0) and
           (FieldByName('PriceBy').AsFloat<>RoundA(FieldByName('Summa').AsFloat/FieldByName('Amount').AsFloat)) then
          begin
            FieldByName('PriceBy').AsFloat:=RoundA(FieldByName('Summa').AsFloat/FieldByName('Amount').AsFloat);
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

function TmdMat.GetOperNum(Sender: TObject): integer;
begin
  if (Sender is TField) then
    Result := MInvoiceHDeclarOperation.AsInteger
//    TField(Sender).DataSet.FieldByName('Operation').AsInteger
  else
    Result := 0;
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
  MInvoiceTDeclarMaterialName.OnFilter:=MaterialNameFilter;
  // вспомогательная временная таблица
//  ExecSQLText(MInvoiceTDeclar.DataBaseName,'call STA.GetMaterialsRash2()',false);
  MaterialsEditLookupCalc.Open;
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
      MInvoiceTDeclarMaterialName.LookupResultField:='Kod;Name;UnitMName;PriceUC;Amount;Account';
      MInvoiceTDeclarMaterialName.LookupGridFields:='Kod;Name;UnitMName';
      MInvoiceTDeclarMaterialName.LookupAddFields:='KodUp;Price;Depot;Gold;Platinum;Silver;Palladium;Rutenium;Rodium;Iridium';
      {MInvoiceTDeclarMaterialName.DisplayWidth:= MaterialsEditLookupCalcKod.DisplayWidth+
            MaterialsEditLookupCalcKod.DisplayWidth +
            MaterialsEditLookupCalcName.DisplayWidth +
            MaterialsEditLookupCalcUnitMName.DisplayWidth +
            //MaterialsEditLookupCalcPriceUC.DisplayWidth +
            //MaterialsEditLookupCalcAmount.DisplayWidth
            -5;}
    end;
  //ShowMessage(IntToStr(MInvoiceTDeclarMaterialName.DisplayWidth));
  if not MInvoiceTDeclar.Active then MInvoiceTDeclar.Active:=True;
end;

function TmdMat.FindMaretialsFirstPriceForRash(Material: extended;
  Depot: integer; var PriceUC: Double; var Account: string): extended;
  var ss: string;
      vv: Array of Variant;
begin
  try
    if (MInvoiceForm.cbAllMat.Visible) and (MInvoiceForm.cbAllMat.Checked) then
      ss:='select 0, 0,  0 as Amount, Account  from STA.Materials A  where A.Kod='+FloatToStr(Material)
    else
      ss:='select Price, PriceUC,  MAmount('''+ MInvoiceHDeclarDateDoc.AsString +''', Depot, Material,Price, PriceUC) as Amount, Account '+
        'from STA.MTotalsA A '+
        'where A.Material='+FloatToStr(Material)+' '+
        '        and Depot='+IntToStr(Depot)+' '+
        'group by Price, PriceUC, Depot, Material, Account '+
        'order by Amount desc ';

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
begin
  ExecSQLText(MControlResDeclar.DataBaseName,
     'call STA.GetMControlRes('''+ReportPeriod.Text+''','+
       IntToStr(Integer(ReportDepotMControl.Items.Objects[ReportDepotMControl.ItemIndex]))+
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
         1 ---- продажа - поля по другому отсортированы}
  var i, k: integer;
      ColumnList : TColumnListArray;
begin
  case index of
  0:
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
      ColumnList[4]:=3;
      ColumnList[5]:=11;
    end;
  else ShowMessage('Глюки mdMat');
  end;
  k:=0;
  for i:=0 to High(ColumnList) do
      begin
        MInvoiceTDeclar.FieldByName(FieldListNames[ColumnList[i]]).Index := k;
        inc(k);
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
begin
  begin
    if MInvoiceTDeclar.Active and
       //(MInvoiceTDeclar.RecordCount>0) and
       (MInvoiceT_SSDeclar.State<>dsBrowse) and
       MInvoiceT_SSDeclar.Active and
       (not MInvoiceTDeclarPrice.IsNull) and
       (not MInvoiceTDeclarAmount.IsNull) then
    begin
      // активизируем запись списания на себестоимость
      if MInvoiceT_SSDeclar.RecordCount>0 then MInvoiceT_SSDeclar.Edit;
      if MInvoiceT_SSDeclarSTV.IsNull then MInvoiceT_SSDeclarSTV.AsFloat:=0.5;
      // расчитываем себестоимость...
      if MInvoiceTDeclarAmount.AsFloat=0 then
        begin
          OldPrice:=MInvoiceTDeclarPriceBy.AsFloat; // Возможно неверно...
        end
      else
        begin
          OldPrice:={Round}((MInvoiceT_SSDeclarSumma.AsFloat+MInvoiceTDeclarSummaBY.AsFloat)/MInvoiceTDeclarAmount.AsFloat);
        end;
      NewPrice:={Round}(OldPrice * (1 - MInvoiceT_SSDeclarSTV.AsFloat));
      NewPrice:=Round(NewPrice*10000)/10000;
      //NewPrice := FirstPrice - OldPrice;
      OldSumma := OldPrice * MInvoiceTDeclarAmount.AsFloat;
      try
        // меняем начальную строку
        MInvoiceTDeclar.Edit;
        MInvoiceTDeclarPriceBy.AsFloat := NewPrice;
        // сохраняем сумму отклонений
        NewSumma := NewPrice * MInvoiceTDeclarAmount.AsFloat;
        MInvoiceT_SSDeclarSumma.AsFloat:=OldSumma - NewSumma;
        if MInvoiceT_SSDeclarAccount.IsNull then
          with MInvoiceHDeclar do
          begin
            MInvoiceT_SSDeclarAccount.AsString :=
               MInvoiceHDeclarDestDepotName.ValueByLookName('Account');
          end;
        if MInvoiceT_SSDeclarKod_StatRash.IsNull then MInvoiceT_SSDeclarKod_StatRash.AsInteger:=0;
        if MInvoiceT_SSDeclarKod_ObjZatr.IsNull then MInvoiceT_SSDeclarKod_ObjZatr.AsInteger:=999;
        if MInvoiceForm.AutoFlag then
          begin
            MInvoiceT_SSDeclar.Post;
            MInvoiceTDeclar.Post;
          end;
      except
      end;
    end;
  end;
end;

Function TmdMat.MaterialNameFilter(Sender: TObject): string;
begin
  if MInvoiceHDeclarOperation.AsInteger in [3, 9, 11, 13, 16] then
    Result:=''
  else
    begin
      if MInvoiceForm.cbAllMat.Visible and MInvoiceForm.cbAllMat.Checked then
        Result:=''
      else
        Result:='( Amount>0 ) and ( Depot='+IntToStr(MInvoiceHDeclarSourceDepot.AsInteger)+' )';
      //Result:=Result + '( Depot='+IntToStr(MInvoiceHDeclarSourceDepot.AsInteger)+' )';
      // попытка убрать отключения нижнего датасета
      if not (MInvoiceTDeclarMaterialName.LookupDataSet=MaterialsEditLookupCalc) then
          MInvoiceTDeclarMaterialName.LookupDataSet:=MaterialsEditLookupCalc;
      if not MaterialsEditLookupCalc.Active then MaterialsEditLookupCalc.Active:=True;
      // end попытка убрать отключения нижнего датасета
    end;
end;

procedure TmdMat.MInvoiceTDeclarAfterPost(DataSet: TDataSet);
begin
  { Зашли в режим редактирования, но ничего не поменяли }
//  DoCalcOst(False, DataSet);
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

procedure TmdMat.DoCalcOst(IsDelete: boolean; DataSet: TDataSet);
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
      { Insert к сожалению не подходит, т.к. при работе с TQuery кэш на клиенте не обновляется... }
      { А Close+Open отрабатывает медленно }
      {Last;}
      {if MaterialsEditLookupCalcKod.Value<2147483000 then }
      { Надо бы переформировать и переоткрыть MaterialsEditLookupCalc, но пока не критично, т.к. запас в 500 резервных строк }
      {Edit;}
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
    if not ((MInvoiceHDeclarOperation.Value=3) and (MInvoiceHDeclarDestDepot.Value=MInvoiceHDeclarSourceDepot.Value)) then
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
end;

function TmdMat.CheckRashod: boolean;
begin
 if MInvoiceHDeclarOperation.AsInteger in [4,6,7,8,15] then
   Result:=True
 else
   Result:=False;
end;

procedure TmdMat.MInvoiceHDeclarCalcFields(DataSet: TDataSet);
begin
  if MInvoiceHDeclarOperation.AsInteger = 3 then
    MInvoiceHDeclarSourceCommonName.AsString:=MInvoiceHDeclarClientName.AsString
  else
    MInvoiceHDeclarSourceCommonName.AsString:=MInvoiceHDeclarSourceDepotName.AsString;
  if MInvoiceHDeclarOperation.AsInteger = 7 then
    MInvoiceHDeclarDestCommonName.AsString:=MInvoiceHDeclarRecipientName.AsString
  else
    MInvoiceHDeclarDestCommonName.AsString:=MInvoiceHDeclarDestDepotName.AsString;
  MInvoiceForm.SetLockGlyph(MInvoiceHDeclarIsLock.AsInteger=1);
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
  TDBGrid(Sender).Canvas.Brush.Color := CurColorArr[CurColorIndex];
  TDBGrid(Sender).Canvas.Font.Color  := clBlack;
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
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
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
     'call STA.GetMDrgOper('''+ReportPeriod_from.Text+''')',false);
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
      PriceUC:= MAmounts_BUH.Declar.FieldByName('Price').AsFloat;
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
 //       FieldByName('POSITION').DisplayWidth:=15;
      end;
    SetFocus;
  end;
//  Cond:=TFilterItem(TXInquiryItem(MAmounts_BUHC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
//  MAmountsC.PlayInquiry(MAmounts_BUHC.Inquiries[0],Cond);
  try
    MAmounts_BUHDeclar.Refresh;
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
  APriceUC: extended; Adt_from, Adt_to: TDateTime; AAccount: string);
var i: integer;
  s1, s2, s3, s4,  s5, s6, s7, s8, ss1, ss2, s9: string;
begin
  MCardC.Execute;
  s2:=FloatToStr(AMaterial);
  s4:=FloatToStr(APriceUC);
  s1:=IntToStr(ADepot);
  ss1:= FormatDateTime('dd.mm.yyyy',Adt_from);
  ss2:= FormatDateTime('dd.mm.yyyy',Adt_to);
  ExecSQLText(MCard.DataBaseName,
         'call STA.GetMCard('+s2+', '+s4+', '+s1+', '''+ss1+''', '''+ss2+''','''+aAccount+''');',false);

  TempQuery.SQL.Text:='begin declare oAm numeric(15,4); declare oSum numeric(18,2); ' +
     ' call STA.GetMAmountAndSum(''' + ss2 + ''', ' + s1 + ', ' + s2 + ', ' + s4 + ', oAm, oSum,'''+aAccount+'''); ' +
     ' select oAm, oSum from dummy; end; ' ;
  try
    TempQuery.Open;
    s5:=TempQuery.Fields[0].AsString;
    s6:=TempQuery.Fields[1].AsString;
  except
  end;

  if not Assigned(TempQuery) then
     begin
       TempQuery:=TQuery.Create(Self);
       TempQuery.DatabaseName:=MaterialsEdit.DatabaseName;
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
      4: TLabel(CardPanel.Controls[i]).Caption:=s4;
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
  with TBEForm(MCardC.Form) do
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
         MAmounts_BUHDeclarPrice.AsFloat,
         StrToDate('01.01.1950'), Date+30, MAmounts_BUHDeclarAccount.AsString);
    end;
end;

procedure TmdMat.CalcMCards2Click(Sender: TObject);
begin
 if MCardsDeclar.Active and
    (MCardsDeclar.RecordCount>0) then
    begin
      ShowMCard(MCardsDeclarMaterial.AsFloat,
        Integer(ReportDepotMCards.KeyValue),
         MCardsDeclarPriceUC.AsFloat,
         StrToDate('01.01.1950'), Date+30,MCardsDeclarKredit.AsString);
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
  Result:=' (Kod=3) or (Kod=4) or (Kod=6) or (Kod=7) or (Kod=8) or (Kod=9) or (Kod=11) or (Kod=13) or (Kod=16) '
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
      KeyValue:=91;
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
 3,9,10,11,13,14,16: begin
              (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Account',FieldByName('Debit'));
              if FieldByName('Debit').AsString='' then FieldByName('Debit').AsString:=Debit;
              // обработка ситуации с 10/10-10/11
              if not (MInvoiceHDeclarDestDepot.AsInteger in SkladSet) and
                 (FieldByName('Debit').AsString='10.10') then FieldByName('Debit').AsString:='10.11';
              if (Copy(FieldByName('Debit').AsString,1,2)='10') and (Trim(FieldByName('Kredit').AsString)='') then
                  FieldByName('Kredit').AsString:=MInvoiceHDeclarKredit.AsString;
              //В валютных накладных надо вводить контракт в каждую строку!
              (FieldByName('PriceName') as TXELookField).ValueByLookNameToField('Contract',FieldByName('Contract'));
             end;
          4: begin
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
    ReportDepotMDrgInvent:=TComboBox.Create(PageControl1TabPanel);
    with ReportDepotMDrgInvent do begin
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=220;
      Width:=300;
      Height:=22;
      Parent:=PageControl1TabPanel;
      Name:='DepotCalcMDrgInvent';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      TabStop:=true;
      TabOrder:=1;
    end;
    with ModuleBase.DepotDeclar do
      begin
        ReportDepotMDrgInvent.Items.Clear;
        if Not Active then Active:=True;
        First;
        while not ModuleBase.DepotDeclar.Eof do
          begin
            ReportDepotMDrgInvent.Items.AddObject(FieldByName('NAME').AsString,TObject(FieldByName('KOD').AsInteger));
            if FieldByName('KOD').AsInteger=1 then
              ReportDepotMDrgInvent.ItemIndex:=ReportDepotMDrgInvent.Items.Count-1;
            Next;
          end;
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
     ''','+IntToStr(Integer(ReportDepotMDrgInvent.Items.Objects[ReportDepotMDrgInvent.ItemIndex]))+')',false);
  TBEForm(MDrgInventC.Form).Caption:=ReportDepotMDrgInvent.Items[ReportDepotMDrgInvent.ItemIndex]+
    ' на '+ReportPeriodMDrgInvent.Text;
  try
    MDrgInventDeclar.Refresh;
  except
  end;
end;

procedure TmdMat.MFakturaCCreateForm(Sender: TObject);
var
  Cond: TListObj;
  i: integer;
begin
  Changing:=False;
  MFakturaC.Execute;
  with TBEForm(MFakturaC.Form).Grid do begin
    FormatColumns(true);
    Cond:=TFilterItem(TXInquiryItem(MFakturaC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
    for i:=0 to Cond.Count-1 do
      with TConditionItem(Cond[i]) do
        if i=0 then Value:=DateToStr(WorkDate)
        else Value:=DateToStr(IncMonth(WorkDate,1));
    MFakturaC.PlayInquiry(MFakturaC.Inquiries[0],Cond);
    Refresh;
    //SetFocus;
  end;
end;

procedure TmdMat.MFakturaDeclarAfterScroll(DataSet: TDataSet);
begin
  MFakturaTDeclar.Filtered:=False;
  if MFakturaDeclar.RecordCount>0 then
    MFakturaTDeclar.Filter:='ID='+MFakturaDeclarID.AsString
  else
    MFakturaTDeclar.Filter:='ID=-1';
  MFakturaTDeclar.Filtered:=True;
  MFakturaDeclarCurrencyChange(MFakturaDeclarID);
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
  MFakturaDeclarKredit.AsString:='60.00';
  MFakturaDeclarCurrency.AsInteger:=974;
  MFakturaDeclarSummaClose.AsInteger:=0;
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
end;

procedure TmdMat.MFakturaTDeclarAfterPost(DataSet: TDataSet);
begin
  RecalcFakturaSum;
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
{var
  Cond: TListObj;}
begin
{  Changing:=False;
  with TBEForm(MMoveAccountsC.Form).Grid, MMoveAccountsC do begin
    Execute;
    FormatColumns(true);
    Cond:=TFilterItem(TXInquiryItem(Inquiries[0]).Filters.Data.Filters[0]).Conditions;
    PlayInquiry(Inquiries[0],Cond);
    Refresh;
    //SetFocus;
  end;}
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
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=300;
      Width:=100;
      Height:=22;
      Name:='BtnProviderAnalit';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderAnalitClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=500;
      Width:=30;
      Height:=22;
      Name:='BtnProviderAnalit2';
      Font.Style:=[fsBold];
      Caption:='док';
      OnClick:=CalcMProviderAnalitClick2;
      TabStop:=true;
      TabOrder:=3;
    end;
    //Grid.OnDrawColumnCell:=DrawCellMSvodMove;
    PageControl1TabPanel.Autosize:=True;
  end;

end;

procedure TmdMat.CalcMProviderAnalitClick(Sender: TObject);
begin
  ExecSQLText(MSvodMoveDeclar.DataBaseName,
     'call STA.GetMProviderAnalit('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
  TBEForm(MProviderAnalitC.Form).Caption:='ВЕДОМОСТЬ АНАЛИТИЧЕСКОГО УЧЕТА ПО КОРР СЧЕТАМ с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
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
      Kor: string[5];
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
          else if AnsiUpperCase(FieldName)='KREDIT' then Value:=Kor
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
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=610;
      Width:=100;
      Height:=22;
      Name:='BtnMProviderCalc';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMProviderCalcClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    PageControl1TabPanel.Autosize:=True;
  end;
end;

procedure TmdMat.CalcMProviderCalcClick(Sender: TObject);
begin
  if ReportClientMProviderCalc.KeyValue>0 then
     ExecSQLText(MProviderCalcDeclar.DataBaseName,
        'call STA.GetMProviderCalc('''+ReportPeriod_from.Text+''',''60.00'','''+IntToStr(Integer(ReportClientMProviderCalc.KeyValue))+''')',false)
  else
     ExecSQLText(MProviderCalcDeclar.DataBaseName,
        'call STA.GetMProviderCalc('''+ReportPeriod_from.Text+''')',false);
  TBEForm(MProviderCalcC.Form).Caption:='Ведомость расчетов с поставщиками за период с '+ReportPeriod_from.Text;
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
      Name:='BtnCalcMCards232';
      Font.Style:=[fsBold];
      Caption:='Расчет формы';
      OnClick:=CalcMSvodProviderClick;
      TabStop:=true;
      TabOrder:=2;
    end;
    with TBitBtn.Create(Form) do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=410;
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
     'call STA.GetMSvodProvider('''+ReportPeriod_from.Text+''','''+ReportPeriod_to.Text+''')',false);
  TBEForm(MSvodProviderC.Form).Caption:='Сводная ведомость движения по синтетическим счетам за период с '+ReportPeriod_from.Text+ ' по '+ReportPeriod_to.Text;
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
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
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
begin
  ExecSQLText(MPKPBookCalcDeclar.DataBaseName,
     'call STA.GetMPKPBookCalc('''+ReportPeriod_from.Text+''')',false);
  TBEForm(MPKPBookCalcC.Form).Caption:='Покупка за период с '+ReportPeriod_from.Text+
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
      Cond: TListObj;
begin
 if MSvodProviderDeclar.Active and
    (MSvodProviderDeclar.RecordCount>0) then
    begin
      Dat:= MSvodProviderDate;
      Kor:= MSvodProvider.Declar.FieldByName('Account').Value;
      MSvodProviderDocsC.Execute;
      Cond:=TFilterItem(TXInquiryItem(MSvodProviderDocsC.Inquiries[0]).Filters.Data.Filters[0]).Conditions;
      for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='PERIOD' then Value:=Dat
          else if AnsiUpperCase(FieldName)='KORR' then Value:=Kor
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
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
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
begin
  ExecSQLText(MProviderProsrochDeclar.DataBaseName,
     'call STA.GetMProviderProsroch('''+ReportPeriod_from.Text+''')',false);
  TBEForm(MProviderProsrochC.Form).Caption:='Просроченная задолженность на (период неверен) '+ReportPeriod_from.Text;
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
    BtnCalcMCards:=TBitBtn.Create(Form);
    with BtnCalcMCards do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=210;
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
begin
  ExecSQLText(MProviderProsrochClientDeclar.DataBaseName,
     'call STA.GetMProviderProsrochClient('''+ReportPeriod_from.Text+''')',false);
  TBEForm(MProviderProsrochClientC.Form).Caption:='Ведомость контроля задолженности с поставщиками на начало '+ReportPeriod_from.Text;
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

Initialization
  XNotifyEvent:=TXNotifyEvent.Create(nil);
  SetLength(CurColorArr,2);
  CurColorArr[0]:=TColor($f0f0f0);
  CurColorArr[1]:=TColor($fafafa);
  GMoveMat := False;
  calcPrice:=False;
  calcBID:=False;
  if not Assigned(TempQuery) then
    begin
      TempQuery:=TQuery.Create(Application);
      TempQuery.DatabaseName:='AO_GKSM_InProgram';
    end;

Finalization
//  FMInvoiceCheckSS.Free;
//  FMInvoiceCheckSS:=nil;
  //if GMoveMat then
  //  ExecSQLText(TempQuery.DatabaseName,'call STA.GetMMoveMat(''01.01.08'',''01.01.08'',20,''10.01'')',false);
  XNotifyEvent.Free;
  XNotifyEvent:=nil;
  (*  if Assigned(TempQuery) then
    begin
      TempQuery.Free;
      TempQuery:=nil;
    end;*)
end.




