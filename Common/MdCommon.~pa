unit MdCommon;

interface

uses
  Forms, Db, ExtCtrls, EtvDB, DBTables, LnTables, XTFC, Graphics,
  Menus, Classes, XMisc, EtvTable, XEFields, XDBTFC, StdCtrls,
  LnkSet, EtvList, EtvLook;

type
  TModuleCommon = class(TDataModule)
    Popup: TControlMenu;
    CurrencyC: TDBFormControl;
    Currency: TLinkSource;
    CurrencyDeclar: TLinkTable;
    CurrencyLookup: TLinkTable;
    AccountLookup: TLinkTable;
    CurrencyDeclarKod: TSmallintField;
    CurrencyDeclarKod3: TStringField;
    CurrencyDeclarName: TStringField;
    CurrencyDeclarRelation: TSmallintField;
    CurrencyDeclarNameDop: TStringField;
    CurrencyDeclarCountry: TIntegerField;
    CurrencyDeclarTag: TSmallintField;
    CurrencyDeclarCountryName: TXELookField;
    CurrencyLookupKod: TSmallintField;
    CurrencyLookupKod3: TStringField;
    CurrencyLookupName: TStringField;
    TCountC: TDBFormControl;
    TCount: TLinkSource;
    TCountDeclar: TLinkTable;
    Bank: TLinkSource;
    BankDeclar: TLinkTable;
    TCountDeclarKod: TSmallintField;
    TCountDeclarName: TStringField;
    BankDeclarName: TStringField;
    BankDeclarPIndex: TIntegerField;
    BankDeclarCountry: TSmallintField;
    BankDeclarPhones: TStringField;
    BankDeclarPlace: TIntegerField;
    BankDeclarKodOtd: TSmallintField;
    BankDeclarCountryName: TXELookField;
    BankDeclarPlaceName: TXELookField;
    TCountLookupSmallintField: TSmallintField;
    TCountLookupStringField: TStringField;
    BankDeclarRemark: TMemoField;
    BankLookupName: TStringField;
    TCountLookup: TLinkQuery;
    Bank1: TLinkMenuItem;
    BankC: TDBFormControl;
    BankProcess: TLinkTable;
    BankProcessName: TStringField;
    BankProcessPlace: TIntegerField;
    BankProcessPlaceName: TXELookField;
    BankLookupKodOtd: TSmallintField;
    Account: TLinkSource;
    AccountDeclar: TLinkTable;
    AccountDeclarName: TStringField;
    AccountDeclarPrAmount: TXEListField;
    AccountC: TDBFormControl;
    AccountDeclarMat: TSmallintField;
    AccountDeclarKod: TStringField;
    AccountDeclarSubKod: TStringField;
    CommonItems: TMenuItem;
    BankProcessKodOtd: TSmallintField;
    BankLookupPlace: TIntegerField;
    BankLookupPlaceName: TXELookField;
    Account1: TLinkMenuItem;
    CurrencyLookupNameDop: TStringField;
    CurrencyDeclarGenitive1: TStringField;
    CurrencyDeclarNominative: TStringField;
    CurrencyLookupGenitive1: TStringField;
    CurrencyLookupNominative: TStringField;
    Tax: TLinkSource;
    TaxDeclar: TLinkTable;
    TaxC: TDBFormControl;
    TaxDeclarKod: TSmallintField;
    TaxDeclarName: TStringField;
    TaxDeclarMFO: TStringField;
    TaxDeclarBCount: TStringField;
    TaxDeclarTOp: TSmallintField;
    TaxDeclarOrg: TXELookField;
    TaxDeclarOrgName: TXELookField;
    Pay: TLinkSource;
    PayDeclar: TLinkTable;
    PayC: TDBFormControl;
    PayDeclarAutoinc: TIntegerField;
    PayDeclarRodOper: TSmallintField;
    PayDeclarMFO: TStringField;
    PayDeclarNDok: TStringField;
    PayDeclarKodNP: TIntegerField;
    PayDeclarSumma: TFloatField;
    PayDeclarSummaBy: TFloatField;
    PayDeclarCurrency: TSmallintField;
    PayDeclarCourse: TFloatField;
    PayDeclarDestination: TStringField;
    PayDeclarMfoEnterprise: TStringField;
    PayDeclarsDate: TDateField;
    BankDeclarCorrCount: TStringField;
    CurrencyDeclarGenitive2: TStringField;
    CurrencyDeclarNominative2: TStringField;
    CurrencyDeclarNameDop2: TStringField;
    Transact: TLinkSource;
    TransactDeclar: TLinkTable;
    TransactDeclarsDate: TDateField;
    TransactDeclarSumma: TFloatField;
    TransactDeclarOper: TIntegerField;
    TransactDeclarAccountD: TStringField;
    TransactDeclarAccountK: TStringField;
    TransactDeclarSubContoD: TIntegerField;
    TransactDeclarSubContoK: TIntegerField;
    TransactDeclarCurrency: TSmallintField;
    TransactDeclarAmount: TFloatField;
    TransactDeclarSummaActive: TFloatField;
    TransactDeclarID: TAutoIncField;
    TransactDeclarAccountDName: TXELookField;
    TransactDeclarAccountKName: TXELookField;
    TSubConto: TLinkSource;
    TSubContoDeclar: TLinkTable;
    TSubContoDeclarName: TStringField;
    TSubContoDeclarTableName: TStringField;
    TSubContoC: TDBFormControl;
    TSubConto1: TLinkMenuItem;
    TSubContoLookup: TLinkQuery;
    TSubContoLookupName: TStringField;
    TransactDeclarTSubContoD: TSmallintField;
    TransactC: TDBFormControl;
    Transact1: TLinkMenuItem;
    TransactD: TLinkSource;
    TransactDDeclar: TLinkTable;
    TransactDsDate: TDateField;
    TransactDSumma: TFloatField;
    TransactDOper: TIntegerField;
    TransactDAccountD: TStringField;
    TransactDAccountK: TStringField;
    TransactDTSubContoD: TSmallintField;
    TransactDSubContoD: TIntegerField;
    TransactDSubContoK: TIntegerField;
    TransactDCurrency: TSmallintField;
    TransactDAmount: TFloatField;
    TransactDAccountDName: TXELookField;
    TransactDAccountKName: TXELookField;
    TransactDID: TAutoIncField;
    TransactDSubContoDName: TXELookField;
    TransactDSubContoKName: TXELookField;
    TransactDTableDoc: TSmallintField;
    TransactDeclarTableDoc: TSmallintField;
    TransactDeclarInfo: TStringField;
    TransactDInfo: TStringField;
    Transact62: TLinkSource;
    Transact62Declar: TLinkTable;
    Transact62DeclarID: TAutoIncField;
    Transact62DeclarsDate: TDateField;
    Transact62DeclarSumma: TFloatField;
    Transact62DeclarOper: TIntegerField;
    Transact62DeclarAccountD: TStringField;
    Transact62DeclarAccountDName: TXELookField;
    Transact62DeclarAccountK: TStringField;
    Transact62DeclarAccountKName: TXELookField;
    Transact62DeclarTSubContoD: TSmallintField;
    Transact62DeclarSubContoD: TIntegerField;
    Transact62DeclarSubContoK: TIntegerField;
    Transact62DeclarCurrency: TSmallintField;
    Transact62DeclarAmount: TFloatField;
    Transact62DeclarSummaActive: TFloatField;
    Transact62DeclarTableDoc: TSmallintField;
    Transact62DeclarInfo: TStringField;
    Transact62C: TDBFormControl;
    Transact621: TLinkMenuItem;
    Transact62DeclarsUser: TStringField;
    Transact62DeclarsTime: TDateTimeField;
    TransactDDeclarsUser: TStringField;
    TransactDDeclarsTime: TDateTimeField;
    TransactDeclarsUser: TStringField;
    TransactDeclarsTime: TDateTimeField;
    PayDeclarBCountEnterprise: TStringField;
    PayDeclarBCount: TStringField;
    PayDeclarOrgName: TStringField;
    Transact62DeclarOperName: TXELookField;
    TransactDeclarSummaBy: TFloatField;
    TransactDDeclarSummaBy: TFloatField;
    Transact62DeclarSummaBy: TFloatField;
    Transact62DeclarContract: TStringField;
    TransactDeclarContract: TStringField;
    TransactDDeclarContract: TStringField;
    AccountFlowV: TLinkSource;
    AccountFlowVDeclar: TLinkTable;
    AccountFlowTDeclar: TLinkTable;
    AccountFlowVC: TDBFormControl;
    AccountFlowV1: TLinkMenuItem;
    BuhTable: TMenuItem;
    Transact62DeclarNumDoc: TIntegerField;
    Transact62DeclarTDoc: TSmallintField;
    TransactDeclarSubContoDName: TXELookField;
    TransactDeclarSubContoKName: TXELookField;
    Transact62Ext: TLinkSource;
    Transact62ExtDeclar: TLinkTable;
    Transact62ExtDeclarID: TIntegerField;
    Transact62ExtDeclarsDate: TDateField;
    Transact62ExtDeclarSumma: TFloatField;
    Transact62ExtDeclarOper: TIntegerField;
    Transact62ExtDeclarAccountD: TStringField;
    Transact62ExtDeclarAccountK: TStringField;
    Transact62ExtDeclarTSubContoD: TSmallintField;
    Transact62ExtDeclarSubContoD: TIntegerField;
    Transact62ExtDeclarSubContoK: TIntegerField;
    Transact62ExtDeclarCurrency: TSmallintField;
    Transact62ExtDeclarSummaBy: TFloatField;
    Transact62ExtDeclarAmount: TFloatField;
    Transact62ExtDeclarSummaActive: TFloatField;
    Transact62ExtDeclarTableDoc: TSmallintField;
    Transact62ExtDeclarsUser: TStringField;
    Transact62ExtDeclarsTime: TDateTimeField;
    Transact62ExtDeclarContract: TStringField;
    Transact62ExtDeclarNumDoc: TIntegerField;
    Transact62ExtDeclarTDoc: TSmallintField;
    Transact62ExtDeclarSubContoDName: TStringField;
    Transact62ExtDeclarSubContoKName: TStringField;
    Transact62ExtDeclarClientD: TIntegerField;
    Transact62ExtDeclarClientDName: TStringField;
    Transact62ExtDeclarInfo: TStringField;
    Transact62ExtDeclarAccountDName: TXELookField;
    Transact62ExtDeclarAccountKName: TXELookField;
    Transact62ExtC: TDBFormControl;
    Transact62Ext1: TLinkMenuItem;
    Transact62ExtDeclarDestination: TStringField;
    AccountDeclarBuhAccount: TStringField;
    Transact62ExtDeclarClientK: TIntegerField;
    Transact62ExtDeclarClientKName: TStringField;
    Transact62ExtDeclarOperName: TXELookField;
    AccountDeclarTSubConto1: TSmallintField;
    AccountDeclarTSubConto2: TSmallintField;
    AccountDeclarTSubConto1Name: TXELookField;
    AccountDeclarTSubConto2Name: TXELookField;
    TransactCorrect: TLinkSource;
    TransactCorrectDeclar: TLinkTable;
    TransactCorrectDeclarAccountD: TStringField;
    TransactCorrectDeclarAccountK: TStringField;
    TransactCorrectDeclarInfo: TStringField;
    TransactCorrectDeclarTask: TXEListField;
    TransactCorrectC: TDBFormControl;
    N1: TMenuItem;
    TransactCorrect1: TLinkMenuItem;
    TransactCorrectDeclarID: TAutoIncField;
    TransactCorrectDeclarAccountDName: TXELookField;
    TransactCorrectDeclarAccountKName: TXELookField;
    TSubContoLookupKod: TSmallintField;
    TSubContoDeclarKod: TSmallintField;
    TransactDeclarTSubContoK: TSmallintField;
    TransactDeclarTSubContoD2: TSmallintField;
    TransactDeclarTSubContoK2: TSmallintField;
    TransactDeclarSubContoD2: TIntegerField;
    TransactDeclarSubContoK2: TIntegerField;
    Ledger: TLinkSource;
    LedgerC: TDBFormControl;
    LedgerDeclar: TLinkTable;
    LedgerDeclarPeriod: TDateField;
    LedgerDeclarAccountD: TStringField;
    LedgerDeclarAccountK: TStringField;
    LedgerDeclarSumma: TFloatField;
    LedgerDeclarAccountDName: TXELookField;
    LedgerDeclarAccountKName: TXELookField;
    Ledger1: TLinkMenuItem;
    LedgerDeclarID: TAutoIncField;
    LedgerV: TLinkSource;
    LedgerVC: TDBFormControl;
    LedgerVDeclar: TLinkTable;
    LedgerV1: TLinkMenuItem;
    Excel1: TMenuItem;
    AccountFlowT: TLinkSource;
    AccountFlowTC: TDBFormControl;
    AccountFlowT1: TLinkMenuItem;
    Section1: TLinkSource;
    Section1Declar: TLinkTable;
    Section1DeclarKod: TSmallintField;
    Section1DeclarName: TStringField;
    Section1C: TDBFormControl;
    Section11: TLinkMenuItem;
    Section1Lookup: TLinkQuery;
    Section1LookupKod: TSmallintField;
    Section1LookupName: TStringField;
    LedgerDeclarSectionD: TSmallintField;
    LedgerDeclarSectionName: TXELookField;
    LedgerDeclarSectionK: TSmallintField;
    LedgerDeclarSectionKName: TXELookField;
    TransactDSectionD: TSmallintField;
    TransactDSectionK: TSmallintField;
    TransactDSectionDName: TXELookField;
    TransactDSectionKName: TXELookField;
    AccountDeclarSType: TSmallintField;
    Transact62ExtDeclarSubContoDRezident: TSmallintField;
    Transact62ExtDeclarSubContoKRezident: TSmallintField;
    N2: TMenuItem;
    ImportTransact: TMenuItem;
    RotateBalanceT: TLinkSource;
    RotateBalanceTDeclar: TLinkTable;
    RotateBalanceTDeclarAccount: TStringField;
    RotateBalanceTDeclarSummaDB: TFloatField;
    RotateBalanceTDeclarSummaKB: TFloatField;
    RotateBalanceTDeclarSummaDO: TFloatField;
    RotateBalanceTDeclarSummaKO: TFloatField;
    RotateBalanceTDeclarSummaDE: TFloatField;
    RotateBalanceTDeclarSummaKE: TFloatField;
    RotateBalanceTDeclarSection: TSmallintField;
    RotateBalanceTC: TDBFormControl;
    RotateBalanceT1: TLinkMenuItem;
    Transact62DeclarSectionD: TSmallintField;
    Transact62DeclarSectionK: TSmallintField;
    Transact62DeclarSectionDName: TXELookField;
    Transact62DeclarSectionKName: TXELookField;
    Bank99: TLinkSource;
    Bank99Declar: TLinkTable;
    Bank99DeclarKod: TIntegerField;
    Bank99DeclarName: TStringField;
    Bank99DeclarPlace: TStringField;
    Bank99DeclarAddress: TStringField;
    Bank99DeclarPhone: TStringField;
    Bank99DeclarFax: TStringField;
    Bank99DeclarEMail: TStringField;
    Bank99DeclarINN: TStringField;
    Bank99DeclarDirector: TStringField;
    Bank99DeclarKodOtd: TSmallintField;
    BankImport: TMenuItem;
    BankDeclarFax: TStringField;
    BankDeclarAddress: TStringField;
    BankDeclarEMail: TStringField;
    BankDeclarDirector: TStringField;
    BankDeclarPhone: TStringField;
    BankDeclarFullName: TStringField;
    Ledger2003: TLinkSource;
    Ledger2003Declar: TLinkTable;
    Ledger2003DeclarID: TAutoIncField;
    Ledger2003DeclarPeriod: TDateField;
    Ledger2003DeclarAccountD: TStringField;
    Ledger2003DeclarAccountDName: TXELookField;
    Ledger2003DeclarSectionD: TSmallintField;
    Ledger2003DeclarSectionDName: TXELookField;
    Ledger2003DeclarAccountK: TStringField;
    Ledger2003DeclarAccountKName: TXELookField;
    Ledger2003DeclarSectionK: TSmallintField;
    Ledger2003DeclarSectionKName: TXELookField;
    Ledger2003DeclarSumma: TFloatField;
    Ledger2003C: TDBFormControl;
    Ledger20031: TLinkMenuItem;
    CurrencyJournalT: TLinkSource;
    CurrencyJournalTDeclar: TLinkTable;
    CurrencyJournalTC: TDBFormControl;
    CurrencyJournalT1: TLinkMenuItem;
    AccountLookupBuhAccount: TStringField;
    AccountLookupName: TStringField;
    TransactDeclarOperName: TXELookField;
    CurrencyReport: TLinkSource;
    CurrencyReportDeclar: TLinkTable;
    CurrencyReportDeclarID: TIntegerField;
    CurrencyReportDeclarJanuary: TFloatField;
    CurrencyReportDeclarFebruary: TFloatField;
    CurrencyReportDeclarMarch: TFloatField;
    CurrencyReportDeclarQuarter1: TFloatField;
    CurrencyReportDeclarApril: TFloatField;
    CurrencyReportDeclarMay: TFloatField;
    CurrencyReportDeclarJune: TFloatField;
    CurrencyReportDeclarQuarter2: TFloatField;
    CurrencyReportDeclarHalfYear1: TFloatField;
    CurrencyReportDeclarJuly: TFloatField;
    CurrencyReportDeclarAugust: TFloatField;
    CurrencyReportDeclarSeptember: TFloatField;
    CurrencyReportDeclarQuarter3: TFloatField;
    CurrencyReportDeclarOctober: TFloatField;
    CurrencyReportDeclarNovember: TFloatField;
    CurrencyReportDeclarDecember: TFloatField;
    CurrencyReportDeclarQuarter4: TFloatField;
    CurrencyReportDeclarHalfYear2: TFloatField;
    CurrencyReportDeclarWholeYear: TFloatField;
    CurrencyReportC: TDBFormControl;
    CurrencyReport1: TLinkMenuItem;
    CurrencyReportDeclarName: TStringField;
    TaxInnovation: TLinkSource;
    TaxInnovationDeclar: TLinkTable;
    TaxInnovationDeclarD43: TFloatField;
    TaxInnovationDeclarD44: TFloatField;
    TaxInnovationDeclarD90K23: TFloatField;
    TaxInnovationDeclarD90K20: TFloatField;
    TaxInnovationDeclarD2002: TFloatField;
    TaxInnovationDeclarD20K02: TFloatField;
    TaxInnovationDeclarD90K0203: TFloatField;
    TaxInnovationDeclarD906K206: TFloatField;
    TaxInnovationDeclarTotal: TFloatField;
    TaxInnovationDeclarInnovFundLastMonth: TFloatField;
    TaxInnovationDeclarTaxable: TFloatField;
    TaxInnovationDeclarRate45: TFloatField;
    TaxInnovationDeclarNationPart: TFloatField;
    TaxInnovationDeclarTax: TFloatField;
    TaxInnovationC: TDBFormControl;
    TaxInnovation1: TLinkMenuItem;
    TaxInnovationDeclarsDate: TDateField;
    Journal3T: TLinkSource;
    Journal3TDeclar: TLinkTable;
    Journal3TDeclarID: TFloatField;
    Journal3TDeclarPeriod: TStringField;
    Journal3TDeclarD60: TStringField;
    Journal3TDeclarTotalD: TStringField;
    Journal3TDeclarK51: TStringField;
    Journal3TDeclarTotalK: TStringField;
    Journal3TC: TDBFormControl;
    N3: TMenuItem;
    Journal3T1: TLinkMenuItem;
    Journal3TDeclarSaldoB: TStringField;
    Journal3TDeclarSaldoE: TStringField;
    TaxInnovationDeclarD90_6K29: TFloatField;
    TaxInnovationDeclarD90K76_03: TFloatField;
    TaxInnovationDeclarD91_04K10_01: TFloatField;
    TransactExt: TLinkSource;
    TransactExtDeclar: TLinkTable;
    TransactExtDeclarID: TIntegerField;
    TransactExtDeclarsDate: TDateField;
    TransactExtDeclarCurrency: TSmallintField;
    TransactExtDeclarSumma: TFloatField;
    TransactExtDeclarSummaBy: TFloatField;
    TransactExtDeclarOper: TIntegerField;
    TransactExtDeclarOperName: TXELookField;
    TransactExtDeclarAccountD: TStringField;
    TransactExtDeclarAccountDName: TXELookField;
    TransactExtDeclarAccountK: TStringField;
    TransactExtDeclarAccountKName: TXELookField;
    TransactExtDeclarTSubContoD: TSmallintField;
    TransactExtDeclarSubContoD: TIntegerField;
    TransactExtDeclarSubContoK: TIntegerField;
    TransactExtDeclarAmount: TFloatField;
    TransactExtDeclarSummaActive: TFloatField;
    TransactExtDeclarTableDoc: TSmallintField;
    TransactExtDeclarsUser: TStringField;
    TransactExtDeclarsTime: TDateTimeField;
    TransactExtDeclarContract: TStringField;
    TransactExtDeclarNumDoc: TIntegerField;
    TransactExtDeclarTDoc: TSmallintField;
    TransactExtDeclarSubContoDName: TStringField;
    TransactExtDeclarSubContoDRezident: TSmallintField;
    TransactExtDeclarSubContoKName: TStringField;
    TransactExtDeclarSubContoKRezident: TSmallintField;
    TransactExtDeclarClientD: TIntegerField;
    TransactExtDeclarClientDName: TStringField;
    TransactExtDeclarClientK: TIntegerField;
    TransactExtDeclarClientKName: TStringField;
    TransactExtDeclarDestination: TStringField;
    TransactExtDeclarInfo: TStringField;
    TransactExtC: TDBFormControl;
    TransactExt1: TLinkMenuItem;
    BankDeclarKod: TStringField;
    BankLookupKod: TStringField;
    AccountDeclarDebetToBalanceRow: TStringField;
    AccountDeclarKreditToBalanceRow: TStringField;
    Balance: TLinkSource;
    BalanceDeclar: TLinkTable;
    BalanceDeclarSection: TStringField;
    BalanceDeclarName: TStringField;
    BalanceDeclarKodRow: TStringField;
    BalanceDeclarTotalRow: TStringField;
    BalanceDeclarID: TIntegerField;
    BalanceDeclarAP: TXEListField;
    TaxInnovationNew: TLinkSource;
    TaxInnovationNewDeclar: TLinkTable;
    TaxInnovationNewDeclarsDate: TDateField;
    TaxInnovationNewDeclarD43: TFloatField;
    TaxInnovationNewDeclarD44: TFloatField;
    TaxInnovationNewDeclarInnovFundLastMonth1: TFloatField;
    TaxInnovationNewDeclarTaxable1: TFloatField;
    TaxInnovationNewDeclarRate1: TFloatField;
    TaxInnovationNewDeclarTax1: TFloatField;
    TaxInnovationNewDeclarD90K23: TFloatField;
    TaxInnovationNewDeclarD90K20: TFloatField;
    TaxInnovationNewDeclarD20_02: TFloatField;
    TaxInnovationNewDeclarD90K02: TFloatField;
    TaxInnovationNewDeclarD90K02_03: TFloatField;
    TaxInnovationNewDeclarD90K76_03: TFloatField;
    TaxInnovationNewDeclarD90_6K20_6: TFloatField;
    TaxInnovationNewDeclarD90_6K29: TFloatField;
    TaxInnovationNewDeclarD90K29: TFloatField;
    TaxInnovationNewDeclarTotal2: TFloatField;
    TaxInnovationNewDeclarInnovFundLastMonth2: TFloatField;
    TaxInnovationNewDeclarTaxable2: TFloatField;
    TaxInnovationNewDeclarRate2: TFloatField;
    TaxInnovationNewDeclarNationPart: TFloatField;
    TaxInnovationNewDeclarTax2: TFloatField;
    TaxInnovationNewDeclarTax: TFloatField;
    TaxInnovationNewC: TDBFormControl;
    TaxInnovationNew1: TLinkMenuItem;
    Journal31T: TLinkSource;
    Journal31TDeclar: TLinkTable;
    Journal31TDeclarID: TFloatField;
    Journal31TDeclarPeriod: TStringField;
    Journal31TDeclarSaldoB: TStringField;
    Journal31TDeclarD50: TStringField;
    Journal31TDeclarTotalD: TStringField;
    Journal31TDeclarK51: TStringField;
    Journal31TDeclarTotalK: TStringField;
    Journal31TDeclarSaldoE: TStringField;
    Journal31TC: TDBFormControl;
    Journal31T1: TLinkMenuItem;
    TransactAlt: TLinkSource;
    TransactAltDeclar: TLinkTable;
    TransactAltDeclarsDate: TDateField;
    TransactAltDeclarSumma: TFloatField;
    TransactAltDeclarAccountD: TStringField;
    TransactAltDeclarAccountK: TStringField;
    TransactAltDeclarSrcDept: TSmallintField;
    TransactAltDeclarDstDept: TSmallintField;
    TransactAltC: TDBFormControl;
    TransactAltDeclarAccountDName: TXELookField;
    TransactAltDeclarAccountKName: TXELookField;
    TransactAltDeclarSrcDepotName: TXELookField;
    TransactAltDeclarDstDepotName: TXELookField;
    TransactAlt1: TLinkMenuItem;
    TransactAltDeclarID: TAutoIncField;
    AverageWage: TLinkSource;
    AverageWageDeclar: TLinkTable;
    AverageWageDeclarPeriod: TDateField;
    AverageWageDeclarSumma: TFloatField;
    AverageWageC: TDBFormControl;
    AverageWage1: TLinkMenuItem;
    PVReport: TLinkSource;
    PVReportDeclar: TLinkTable;
    PVReportC: TDBFormControl;
    PVReport1: TLinkMenuItem;
    BalanceC: TDBFormControl;
    Balance1: TLinkMenuItem;
    BalanceT: TLinkSource;
    BalanceTDeclar: TLinkTable;
    BalanceTDeclarID: TIntegerField;
    BalanceTDeclarAP: TSmallintField;
    BalanceTDeclarSection: TStringField;
    BalanceTDeclarName: TStringField;
    BalanceTDeclarKodRow: TStringField;
    BalanceTDeclarTotalRow: TStringField;
    BalanceTDeclarOnBegPeriod: TFloatField;
    BalanceTDeclarOnEndPeriod: TFloatField;
    BalanceTC: TDBFormControl;
    BalanceT1: TLinkMenuItem;
    BalanceTDeclarOnBegPeriodMln: TFloatField;
    BalanceTDeclarOnEndPeriodMln: TFloatField;
    TransactExtDeclarMfoD: TStringField;
    TransactExtDeclarBCountD: TStringField;
    TransactExtDeclarMfoK: TStringField;
    TransactExtDeclarBCountK: TStringField;
    TransactExtDeclarSectionD: TSmallintField;
    TransactExtDeclarSectionK: TSmallintField;
    LedgerZ: TLinkSource;
    LedgerZDeclar: TLinkTable;
    LedgerZDeclarAccount: TStringField;
    LedgerZDeclarPeriod: TDateField;
    LedgerZDeclarSumma: TIntegerField;
    LedgerZDeclarSection: TSmallintField;
    SprLedgerZ: TLinkSource;
    SprLedgerZDeclar: TLinkTable;
    SprLedgerZDeclarKod: TStringField;
    SprLedgerZDeclarName: TStringField;
    SprLedgerZC: TDBFormControl;
    SprLedgerZ1: TLinkMenuItem;
    SprLedgerZLookup: TLinkQuery;
    SprLedgerZLookupkod: TStringField;
    SprLedgerZLookupname: TStringField;
    LedgerZDeclarAccountName: TXELookField;
    LedgerZDeclarSectionName: TXELookField;
    LedgerZC: TDBFormControl;
    LedgerZ1: TLinkMenuItem;
    LedgerZRep: TLinkSource;
    LedgerZRepC: TDBFormControl;
    LedgerZRepDeclar: TLinkTable;
    LedgerZRepDeclarS1: TFloatField;
    LedgerZRepDeclarsDate: TStringField;
    LedgerZRepDeclarDTO: TStringField;
    LedgerZRepDeclarKTO: TStringField;
    LedgerZRepDeclarDTS: TStringField;
    LedgerZRepDeclarKTS: TStringField;
    LedgerZRep1: TLinkMenuItem;
    BankProcessKod: TStringField;
    Journal66T: TLinkSource;
    Journal66TDeclar: TLinkTable;
    Journal66TC: TDBFormControl;
    Journal66T1: TLinkMenuItem;
    Journal67T: TLinkSource;
    Journal67TDeclar: TLinkTable;
    Journal67TC: TDBFormControl;
    Journal67T1: TLinkMenuItem;
    TransactAltDeclarDstObj: TIntegerField;
    TransactAltDeclarDstObjName: TXELookField;
    Journal3TDeclarD51: TStringField;
    BankDeclarRKC: TStringField;
    BankLookupRKC: TStringField;
    BankProcessRKC: TStringField;
    BankDeclarCBS: TSmallintField;
    BankLookupCBS: TSmallintField;
    BankProcessCBS: TSmallintField;
    BankDeclarID: TAutoIncField;
    BankLookupID: TIntegerField;
    BankProcessID: TIntegerField;
    Journal661T: TLinkSource;
    Journal661TC: TDBFormControl;
    Journal661TDeclar: TLinkTable;
    Journal661T1: TLinkMenuItem;
    TransactExtDeclarDateComing: TDateField;
    AccountLookupInteractionAssetsFlag: TSmallintField;
    TransactDCorrection: TXEListField;
    SprBCount: TLinkSource;
    SprBCountDeclar: TLinkTable;
    SprBCountDeclarMFO: TStringField;
    SprBCountDeclarBCount: TStringField;
    SprBCountDeclarKodVa: TSmallintField;
    SprBCountDeclarName: TStringField;
    SprBCountDeclarsOrder: TSmallintField;
    SprBCountDeclarsJOrder: TSmallintField;
    SprBCountDeclarsJAcc: TStringField;
    SprBCountC: TDBFormControl;
    SprBCount1: TLinkMenuItem;
    Journal3TDeclarK52: TStringField;
    Journal3TDeclarD6001: TStringField;
    AccountDeclarCurPeriodAccount: TDateField;
    Journal3TDeclarD9702: TStringField;
    AccountLSource: TProcSubSource;
    Section1LSource: TProcSubSource;
    CurrencyLSource: TProcSubSource;
    AutomationNews: TLinkSource;
    AutomationNewsDeclar: TLinkTable;
    AutomationNewsDeclarID: TIntegerField;
    AutomationNewsDeclarsDate: TDateField;
    AutomationNewsC: TDBFormControl;
    AutomationNews1: TLinkMenuItem;
    AutomationNewsDeclarNews: TStringField;
    RotateBalanceTDeclarAccountName: TStringField;
    RotateBalanceTDeclarSectionName: TStringField;
    RotateBalanceTDeclarDebetToBalanceRow: TStringField;
    RotateBalanceTDeclarKreditToBalanceRow: TStringField;
    TransactDDeclarBCountD: TStringField;
    TransactDDeclarBCountK: TStringField;
    procedure TransactDDeclarNewRecord(DataSet: TDataSet);
    procedure PayDeclarCalcFields(DataSet: TDataSet);
    procedure PayCCreateForm(Sender: TObject);
    procedure AccountFlowV1Click(Sender: TObject);
    procedure AccountFlowT1Click(Sender: TObject);
    procedure InitPayAddClick(Sender: TObject);
    procedure LedgerDeclarBeforeInsert(DataSet: TDataSet);
    procedure LedgerDeclarNewRecord(DataSet: TDataSet);
    procedure LedgerVCCreateForm(Sender: TObject);
    procedure LedgerReportClick(Sender: TObject);
    procedure LedgerReportClickCall(Sender: TObject);
    procedure LedgerReportClickCall2(Sender: TObject);
    procedure LedgerVWorkCall(InAccount:string; InSection:string; InPeriod:string);
    procedure LedgerVWork(aAccountD:string; aSectionD:string; aPeriod: string; ReCalc: byte; var NotError: boolean);
    procedure LedgerZRepWork(aAccountD:string; aSectionD:string; aPeriod: string; ReCalc: byte; var NotError: boolean);    
    procedure ExportLedgerToExcel(Sender: TObject);
    procedure LedgerCCreateForm(Sender: TObject);
    procedure GridColEnter(Sender: TObject);
    procedure LedgerDataChange(Sender: TObject; Field: TField);
    procedure AccountFlowTCCreateForm(Sender: TObject);
    procedure SetGridClientReportFont(Sender: TObject; Field: TField; Font: TFont);
    procedure SetGridClientReportColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure ImportTransactClick(Sender: TObject);
    procedure RotateBalanceTCCreateForm(Sender: TObject);
    procedure RotateBalanceReportClick(Sender: TObject);
    procedure BankImportClick(Sender: TObject);
    procedure AccountFlowTCDestroyForm(Sender: TObject);
    procedure AccountFlowVCDestroyForm(Sender: TObject);
    procedure CurrencyJournalTCCreateForm(Sender: TObject);
    procedure CurrencyReportCCreateForm(Sender: TObject);
    procedure CurrencyReportClick(Sender: TObject);
    procedure LedgerZRepCCreateForm(Sender: TObject);
    procedure LedgerZRepClick(Sender: TObject);
    procedure PVReportDeclarBeforeOpen(DataSet: TDataSet);
    procedure TransactCCreateForm(Sender: TObject);
    procedure SprBCountDeclarsJAccValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LedgerGridPanel: TPanel;
  LedgerLabel, Ledger2003Label, CurLedgerLabel: TLabel;
  ModuleCommon: TModuleCommon;
  aRound: SmallInt=1000;  { Порядок округления  до 01.04.99 - до 100  рублей }
                          { с 01.04.99  - до 1000 рублей инициализируется в InvoiceCalcFields }
                          { и других процедурах, где имеем дело с ценами на продукцию         }

Implementation
Uses Windows, MdBase, MdGeography, MdInvc, MdOrgs, Dialogs, SysUtils, ToolEdit, Buttons, ETVMem, ETVFilt,
     BEForms, MdPays, GksmCons, EtvDBFun, DiDate, XCtrls, Etvcontr,
     ExpExcel, Controls, DBGrids, BDE, MdClientsAdd, MdMaterials;
{$R *.DFM}

Var Period: TDateTime;
    AccountD, AccountK: string[5];
    SectionD, SectionK: byte;
    BtnCalcLedger, BtnCalcLedgerZ, BtnCalcRotateBalance, BtnCallPageMainBook2, BtnCallPageMainBook, BtnCalcCurrencyReport :TBitBtn;
    LedgerAccountD: string[5];
    LedgerAcc: string[5];
    LedgerDate: string[10];
    AFDateBeg,AFDateEnd:string[10];
    AFAccount:string[5]='51.00';
    AFDebitKreditChar:char='D';
    AFSignComboBox: byte=1;
    AFDebitComboBoxItem: byte=0;
    AFSection:byte=0;
    NotError: boolean;
    aPeriodStr: string;
    aYear, aMonth, aDay: word;
    InitPayAddButton: TBitBtn;
    InitPayAddDate: TDateEdit;

procedure TModuleCommon.TransactDDeclarNewRecord(DataSet: TDataSet);
var OrgDValue, OrgKValue :variant;
begin
  if MessageDlg('Завести проводку автоматически?',mtConfirmation,[mbNo,mbYes],0)<>idYes then Exit;
  case FIN_BUH_FSG_Group of
  FSGL,ADMIN:
    with TransactDDeclar.MasterSource.DataSet do begin
      {TransactDDeclarSubContoK.Value:=900000;}
      OrgDValue:=TransactDDeclar.MasterSource.DataSet.FieldByName('OrgD').Value;
      OrgKValue:=TransactDDeclar.MasterSource.DataSet.FieldByName('OrgK').Value;
      if OrgDValue=null then begin
        ShowMessage('Плательщик не определен');
        SysUtils.Abort;
      end;
      TransactDSubContoD.AsVariant:=OrgDValue;
      TransactDSubContoK.AsVariant:=OrgKValue;
      TransactDAccountK.Value:='62.00';
      { Общие поля для исходящих и входящих платежных документов }
      TransactDCurrency.Value:=FieldByName('Currency').Value;
      TransactDSumma.Value:=FieldByName('Summa').Value;
      TransactDDeclarSummaBy.Value:=FieldByName('Summa').Value*FieldByName('Course').Value;
      TransactDTSubContoD.Value:=1;
      TransactDsDate.Value:=FieldByName('DateDoc').Value;
    end;
  BUH:
    with TransactDDeclar.MasterSource.DataSet do begin
      if FieldByName('Currency').Value<>974 then begin
        if FieldByName('OrgD').Value=900000 then
          TransactDAccountK.Value:='52.00'
        else
          TransactDAccountK.Value:='76.05';
        if FieldByName('OrgK').Value=900000 then
          TransactDAccountD.Value:='52.00'
        else
          TransactDAccountD.Value:='76.05';
      end else
      if (FieldByName('OrgD').Value<>900000) then begin
        { Внутренний платежный документ }
        TransactDAccountD.Value:='60.00';
        TransactDAccountK.Value:='62.00';
        TransactDSubContoK.Value:=900000;
        OrgDValue:=FieldByName('OrgD').Value;
        if OrgDValue=null then begin
          ShowMessage('Плательщик не определен');
          SysUtils.Abort;
        end;
        TransactDSubContoD.Value:=OrgDValue;
      end else begin
        { Исходящий платежный документ }
        TransactDAccountD.Value:='76.03';
        TransactDAccountK.Value:='51.00';
        TransactDSubContoD.Value:=900000;
        TransactDSubContoK.AsVariant:=FieldByName('OrgK').AsVariant;
      end;
      { Общие поля для исходящих и входящих платежных документов }
      TransactDCurrency.Value:=FieldByName('Currency').Value;
      TransactDSumma.Value:=FieldByName('Summa').Value;
      TransactDDeclarSummaBy.Value:=FieldByName('Summa').Value*FieldByName('Course').Value;
      TransactDTSubContoD.Value:=1;
      if FieldByName('DateComing').Value<>Null then
        TransactDsDate.Value:=FieldByName('DateComing').Value
      else TransactDsDate.Value:=FieldByName('DateDoc').Value;
    end;
  FIN:
    with TransactDDeclar.MasterSource.DataSet do begin
      OrgDValue:=TransactDDeclar.MasterSource.DataSet.FieldByName('OrgD').Value;
      (*
      if OrgDValue=null then begin
        ShowMessage('Плательщик не определен');
        SysUtils.Abort;
      end;
      *)
      TransactDSubContoD.AsVariant:=OrgDValue;
      OrgKValue:=TransactDDeclar.MasterSource.DataSet.FieldByName('OrgK').Value;
      (*
      if OrgKValue=null then begin
        ShowMessage('Получатель не определен');
        SysUtils.Abort;
      end;
      *)
      TransactDSubContoK.AsVariant:=OrgKValue;
      if OrgDValue <> 900000 then begin
        TransactDAccountD.Value:='76.00';
        TransactDAccountK.Value:='62.00';
        TransactDSumma.Value:=TransactDDeclar.MasterSource.DataSet.FieldByName('Summa').Value
      end else begin
        TransactDAccountD.Value:='51.00';
        TransactDAccountK.Value:='60.00';
      end;
      { Общие поля для исходящих и входящих платежных документов }
      TransactDCurrency.Value:=FieldByName('Currency').Value;
      TransactDSumma.Value:=FieldByName('Summa').Value;
      TransactDDeclarSummaBy.Value:=FieldByName('Summa').Value*FieldByName('Course').Value;
      TransactDTSubContoD.Value:=1;
      TransactDsDate.Value:=TransactDDeclar.MasterSource.DataSet.FieldByName('DateDoc').Value;
    end;
  end;
  {Lev 17.12.99 DefaultExpression=333 }
  {TransactDDeclarTableDoc.Value:=333;}
  {Общие значения для всех юзеров}
  TransactDSectionD.Value:=0;
  TransactDSectionK.Value:=0;
  TransactDCorrection.Value:=0;
end;

procedure TModuleCommon.PayDeclarCalcFields(DataSet: TDataSet);
begin
  if (PayDeclarMFO.Value<>'') and (PayDeclarBCount.Value<>'') then with ModuleOrgs do begin
    {
    va[0]:=TbPayMFO.value;
    va[1]:=TbPayBCount.value;
    }
    if not OrgBankLookUp1.Active then OrgBankLookUp1.Open; 
    if OrgBankLookUp1.
    Locate('KodBn;BCount',PayDeclar.FieldValues['MFO;BCount'],[]) then
      PayDeclarOrgName.Value:=OrgBankLookup1Org.AsString+'  '+OrgBankLookup1OrgName.Value;
  end;
end;

procedure TModuleCommon.PayCCreateForm(Sender: TObject);
var FC: TDBFormControl;
begin
  {AccountFlowVDeclar.TableName:=UserName+'.'+'AccountFlowV';}
  if Sender.ClassName<>'TDBFormControl' then Exit;
  FC:=TDBFormControl(Sender);
  if UserName='FIN' then SysUtils.Abort;
  with TBEForm(FC.Form) do begin
    Grid.TitleRows:=2;
    InitPayAddButton:=TBitBtn.Create(FC.Form);
    with InitPayAddButton do begin
      Top:=0;
      Left:=125;
      Width:=105;
      Height:=22;
      Name:='InitPayAddButton';
      Caption:='Расчет cумм BY';
      Font.Name:='ArialNarrow';
      ShowHint:=true;
      Hint:='Расчет сумм в белорусских рублях за текущий период';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=InitPayAddClick;
    end;
    { Добавляем дату для выявления заканчивающихся контрактов }
    InitPayAddDate:=TDateEdit.Create(FC.Form);
    with InitPayAddDate do begin
      Top:=0;
      Left:=InitPayAddButton.Left+InitPayAddButton.Width+25;
      Width:=80;
      Height:=20;
      Name:='InitPayAddDate';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      TabStop:=true;
      TabOrder:=0;
      if Date=0 then Date:=SysUtils.Date;
    end;
  end;
end;

Procedure TModuleCommon.InitPayAddClick(Sender: TObject);
begin
  with TLinkTable(TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.DataSet) do begin
    { Закрыли таблицу со старыми значениями }
    DisableControls;
    Close;
    { Запустили расчет ошибок }
    ExecSQLText(DataBaseName,'Call STA.InitPayAdd('''+InitPayAddDate.Text+''')',false);
    { Открыли таблицу с новыми значениями }
    Open;
    EnableControls;
  end;
  ShowMessage('Расчет произведен');
end;

procedure TModuleCommon.AccountFlowV1Click(Sender: TObject);
var AccountLabel, SectionLabel, DebitLabel, SignLabel: TXLabel;
    DlgOneDate: TDialDate;
    EditAccount, EditSection:TEtvDBLookupCombo;
    EditDebitKredit: TEtvDBCombo;
    DebitComboBox, SignComboBox: TComboBox;
    DebitKreditChar: Char;
    i: byte;
    DataSetCursor: HDBICur;

begin

  DlgOneDate:=TDialDate.Create(Application);
  {DlgOneDate.EditDateBe.Date:=Date;}
  with DlgOneDate do begin
    {VisibleSecondDate(false);}
    Caption:='Движение денежных средств по счетам';
  end;

  {* Ввод бухгалтерского счета *}
  AccountLabel:=TXLabel.Create(DlgOneDate);
  with AccountLabel do begin
    Caption:='Бухгалтерский счет';
    Left:=24;
    Top:=88;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not AccountLookup.Active then AccountLookup.Open;
  EditAccount:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDeclarAccountDName,0,AccountLSource));
  with EditAccount do begin
    Left:=124;
    Top:=AccountLabel.Top;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=2;
  end;

  {* Ввод хозрасчетного подразделения *}
  SectionLabel:=TXLabel.Create(DlgOneDate);
  with SectionLabel do begin
    Caption:='Подразделение';
    Left:=180;
    Top:=64;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not Section1Lookup.Active then Section1Lookup.Open;
  EditSection:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDSectionDName,0,Section1LSource));
  with EditSection do begin
    Left:=204;
    Top:=AccountLabel.Top;
    DropDownWidth:=150;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=3;
  end;

{*****************}
  DebitLabel:=TXLabel.Create(DlgOneDate);
  with DebitLabel do begin
    Caption:='Дебет-Кредит';
    Left:=24;
    Top:=114;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=20;
    Parent:=DlgOneDate;
  end;

  DebitComboBox:=TComboBox.Create(DlgOneDate);
  with DebitComboBox do begin
    Parent:=DlgOneDate;
    Style:=csDropDownList;
    Left:=124;
    Top:=DebitLabel.Top;
    Width:=63;
    {Text:='Дебет';}
    TabStop:=true;
    Items.Add('Дебет');
    Items.Add('Кредит');
    ItemIndex:=0;
    TabOrder:=4;
  end;

  SignLabel:=TXLabel.Create(DlgOneDate);
  with SignLabel do begin
    Caption:='Суммы';
    Left:=24;
    Top:=DebitLabel.Top+22;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=20;
    Parent:=DlgOneDate;
  end;

  SignComboBox:=TComboBox.Create(DlgOneDate);
  with SignComboBox do begin
    Parent:=DlgOneDate;
    Style:=csDropDownList;
    Left:=124;
    Top:=SignLabel.Top;
    Width:=90;
    TabStop:=true;
    Items.Add('Отрицательные');
    Items.Add('Все');

    Items.Add('Положительные');
    ItemIndex:=1;
    TabOrder:=5;
  end;
  { Инициализация прошлых значений для удобства пользования }
  with DlgOneDate do begin
    EditDateBeg.Text:=AFDateBeg;
    EditDateEnd.Text:=AFDateEnd;
    EditAccount.KeyValue:=AFAccount;
    EditSection.KeyValue:=AFSection;
    SignComboBox.ItemIndex:=AFSignComboBox;
    DebitComboBox.ItemIndex:=AFDebitComboBoxItem;
  end;

  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) and
  (DlgOneDate.EditDateEnd.Date>0) and (DlgOneDate.EditDateEnd.Date>=DlgOneDate.EditDateBeg.Date) then
    with DlgOneDate do try
      { Закрыли таблицу со старыми значениями }
      with AccountFlowVDeclar do begin
(*
        i:=Fields.Count;
        while i>0 do begin
          RemoveField(Fields[i-1]);
          Dec(i);
        end;
        FieldDefs.Clear;
        Close;
        {
        DataSetCursor:=Handle;
        DbiCloseCursor(DataSetCursor);
        }
*)
        if (Filtered) or (Filter<>'') then begin
          Filtered:=false;
          Filter:='';
        end;
        Close;
      end;
       { Запустили генерацию необходимого VIEW }
      if DebitComboBox.Text='Дебет' then DebitKreditChar:='D'
      else DebitKreditChar:='K';
      ExecSQLText(AccountFlowVDeclar.DataBaseName,
        'Call STA.GenerateAccountFlowV('''+EditAccount.Text+''','''+EditSection.Text+''','''+DebitKreditChar
        +''','''+EditDateBeg.Text+''','''+EditDateEnd.Text+''','+IntToStr(SignComboBox.ItemIndex-1)+')',false);
      { Открыли таблицу с новыми значениями }
{
      AccountFlowVDeclar.Close;
      AccountFlowVDeclar.FieldDefs.Clear;
      AccountFlowVDeclar.Fields.Clear;
}
      { Закрываем другие вспомогательные DataSet'ы (Поиск, фильтры и т.д.)}
      i:=0;
      with ModuleBase.KSMDatabase do
        while i<=DatasetCount-1 do begin
          if (DataSets[i] is TTable) and (TTable(DataSets[i]).TableName='AccountFlowV')
            then with TTable(DataSets[i]) do begin
              Close;
              FieldDefs.Clear;
            end
          else Inc(i);
        end;
      ModuleBase.KSMDatabase.FlushSchemaCache('AccountFlowV');
      { Заголовок формы }
      with AccountFlowVC do begin
        Caption:='Обороты по '+DebitComboBox.Text+'у '+Copy(EditAccount.Text,1,2)+'/'+
        Copy(EditAccount.Text,4,2)+'-'+EditSection.Text+
          ' счёта '+Section1Lookup.FieldByName('Name').Value+' с '+EditDateBeg.Text+' по '+EditDateEnd.Text;
        if Assigned(Form) then Form.Repaint;
      end;

      if Assigned(AccountFlowVC.Form) then begin
        TBEForm(AccountFlowVC.Form).Scroll.DestroyComponents;
        AccountFlowVC.Form.Tag:=1;
      end;
      with AccountFlowVDeclar do begin
        FieldDefs.Clear;
        {AccountFlowV.Inner.FieldDefs.Clear;}
        Open;
        { Обзываем красиво DisplayLabel'ы}
        Fields[0].DisplayLabel:='Дата';
        Fields[FieldCount-1].DisplayLabel:='Итого';
        TNumericField(Fields[FieldCount-1]).DisplayFormat:='### ### ### ###';
        TNumericField(Fields[FieldCount-1]).Alignment:=taRightJustify;
        for i:=1 to FieldCount-2 do with TNumericField(Fields[i]) do begin
          DisplayLabel:='Счет '+Copy(FieldName,2,2)+'/'+Copy(FieldName,5,2)+'-'+Copy(FieldName,8,1);
          DisplayFormat:='### ### ### ###';
          Alignment:=taRightJustify;
        end;
      end;
    finally
      with DlgOneDate do begin
        AFDateBeg:=EditDateBeg.Text;
        AFDateEnd:=EditDateEnd.Text;
        AFAccount:=EditAccount.Text;
        AFSignComboBox:=SignComboBox.ItemIndex;
        AFDebitComboBoxItem:=DebitComboBox.ItemIndex;
        AFSection:=EditSection.KeyValue;
      end;
      DlgOneDate.Release;
    end
  else SysUtils.Abort;
end;

procedure TModuleCommon.LedgerDeclarBeforeInsert(DataSet: TDataSet);
begin
  { Запоминаем значения строки, на которой находился фокус перед операцией вставки }
  Period:=LedgerDeclarPeriod.Value;
  AccountD:=LedgerDeclarAccountD.Value;
  AccountK:=LedgerDeclarAccountK.Value;
  SectionD:=LedgerDeclarSectionD.Value;
  SectionK:=LedgerDeclarSectionK.Value;
end;

procedure TModuleCommon.LedgerDeclarNewRecord(DataSet: TDataSet);
begin
  { Присваиваем сохраненные значения }
  LedgerDeclarPeriod.Value:=Period;
  LedgerDeclarAccountD.Value:=AccountD;
  LedgerDeclarAccountK.Value:=AccountK;
  LedgerDeclarSectionD.Value:=SectionD;
  LedgerDeclarSectionK.Value:=SectionK;
end;

Procedure TModuleCommon.LedgerVCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    Grid.TitleAlignment:=taCenter;
    BtnCalcLedger:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCalcLedger do begin
      Top:=0;
      Left:=125;
      Width:=105;
      Height:=22;
      Name:='BtnCalcLedger';
      Caption:='Расчет листа';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=LedgerReportClick;
    end;
{
      TBEForm(Form).Grid.OnSetFont:=SetGridClientReportFont;
      TBEForm(Form).Grid.OnSetColor:=SetGridClientReportColor;
      TBEForm(Form).Grid.OnDblClick:=GridDblClick;
}
    LedgerDate:='01.01.'+Copy(DateToStr(Date),7,2);
    LedgerAccountD:='';
  end;
end;

Procedure TModuleCommon.LedgerVWork(aAccountD:string; aSectionD: string; aPeriod: string; ReCalc: byte; var NotError: boolean);
var i: integer;
    aErrorMessage: string;
    aOldYear:string; // для расчета старых лет
    Delta:byte;
begin
  NotError:=true;
  with LedgerVDeclar do begin
    if (Filtered) or (Filter<>'') then begin
      Filtered:=false;
      Filter:='';
    end;
    Close;
  end;
  { Случай, когда ввели только год в качестве периода}
  if Pos('.',aPeriod)=0 then aPeriod:='01.01.'+aPeriod;
   { Запустили генерацию необходимого VIEW }
  if (Copy(aPeriod,7,2)='03') or (Copy(aPeriod,7,4)='2003') then aOldYear:='2003' else aOldYear:='';
  try
    ExecSQLText(LedgerVDeclar.DataBaseName,'Call STA.GenerateLedgerV'+aOldYear+'('''+aAccountD+''','''+aPeriod+''','''+aSectionD+''','''+IntToStr(ReCalc)+''')',false);
  except
    on E:Exception do begin
      i:=Pos(':',E.Message);
      ShowMessage(Copy(E.Message,i+1,Length(E.Message)-i));
      {ShowMessage('По счету '+aAccountD+'-'+aSectionD+' учет не ведется!!!');}
      NotError:=false;
    end;
  end;
  { Открыли таблицу с новыми значениями }
  LedgerVDeclar.Close;
  { Закрываем другие вспомогательные DataSet'ы (Поиск, фильтры и т.д.)}
  i:=0;
  with ModuleBase.KSMDatabase do
    while i<=DatasetCount-1 do begin
      if (DataSets[i] is TTable) and (TTable(DataSets[i]).TableName='STA.LedgerV')
        then with TTable(DataSets[i]) do begin
          Close;
          FieldDefs.Clear;
        end
      else Inc(i);
    end;
  if not NotError then Exit;
  ModuleBase.KSMDatabase.FlushSchemaCache('STA.LedgerV');
  { Заголовок формы }
  with LedgerVC do begin
    Caption:='ОАО "ГКСМ". Счет '+Copy(aAccountD,1,2)+'/'+Copy(aAccountD,4,2)+'-'+aSectionD+' : '+
      GetFromSQLText(LedgerV.DataBaseName,'select "Name" from STA.SprAccount'+aOldYear+' where BuhAccount='''+aAccountD+'''',true);
    if Assigned(Form) then Form.Repaint;
  end;

  if Assigned(LedgerVC.Form) then begin
    TBEForm(LedgerVC.Form).Scroll.DestroyComponents;
    LedgerVC.Form.Tag:=1;
    {TBEForm(LedgerVC.Form).Grid.Columns.Destroy;}
  end;

  with LedgerVDeclar do begin
    FieldDefs.Clear;
    Open;
   { Обзываем красиво DisplayLabel'ы}
    Fields[0].DisplayLabel:='Период';
    if (Pos('68.',aAccountD)>0) or (Pos('90.',aAccountD)>0) or (Pos('91.',aAccountD)>0) or (Pos('92.',aAccountD)>0)
    or (aAccountD='99.99') then Delta:=7 else Delta:=5;
    for i:=1 to FieldCount-Delta do
      Fields[i].DisplayLabel:=Copy(Fields[i].FieldName,2,2)+'/'+Copy(Fields[i].FieldName,5,2)
      +'-'+Copy(Fields[i].FieldName,8,1);
    for i:=FieldCount-Delta to FieldCount-1 do Fields[i].DisplayWidth:=12;
    Fields[FieldCount-Delta].DisplayLabel:='Обороты по дебету';
    Fields[FieldCount-(Delta-1)].DisplayLabel:='Обороты по кредиту';
    Fields[FieldCount-(Delta-2)].DisplayLabel:='Дебетовое сальдо';
    Fields[FieldCount-(Delta-3)].DisplayLabel:='Кредитовое сальдо';
    Fields[FieldCount-(Delta-4)].DisplayLabel:='Корректировка ';
    if Delta=7 then begin
      Fields[FieldCount-(Delta-5)].DisplayLabel:='Обороты по дебету с нарастающим итогом';
      Fields[FieldCount-(Delta-6)].DisplayLabel:='Обороты по кредиту с нарастающим итогом';
    end;
    for i:=0 to FieldCount-1 do
     if Fields[i].DataType=ftFloat then TNumericField(Fields[i]).DisplayFormat:='### ### ### ##0.';
  end;
end;

Procedure TModuleCommon.LedgerReportClick(Sender: TObject);
var AccountLabel,SectionLabel: TXLabel;
    DlgOneDate: TDialDate;
    EditAccount,EditSection:TEtvDBLookupCombo;
    i: byte;
    DataSetCursor: HDBICur;

begin
  {DlgOneDate.EditDateBe.Date:=Date;}

  DlgOneDate:=TDialDate.Create(Application);
  with DlgOneDate do begin
    {VisibleSecondDate(false);}
    Caption:='Расчет листа главной книги';
    LabelDateEnd.Visible:=false;
    EditDateEnd.Visible:=false;
    Bevel1.Height:=80;
    Height:=150;
    BitBtn1.Top:=Bevel1.Top+Bevel1.Height+6;
    BitBtn2.Top:=BitBtn1.Top;
    EditDateBeg.Text:='01.01.'+Copy(DateToStr(Date),7,2);
  end;

  AccountLabel:=TXLabel.Create(DlgOneDate);
  with AccountLabel do begin
    Caption:='Бухгалтерский счет';
    Left:=24;
    Top:=48;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not AccountLookup.Active then AccountLookup.Open;
  EditAccount:=TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDeclarAccountDName,0,AccountLSource));
  with EditAccount do begin
    Left:=108;
    Top:=AccountLabel.Top;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=2;
  end;

  {* Ввод хозрасчетного подразделения *}
  SectionLabel:=TXLabel.Create(DlgOneDate);
  with SectionLabel do begin
    Caption:='Подразделение';
    Left:=180;
    Top:=24;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not Section1Lookup.Active then Section1Lookup.Open;
  EditSection:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDSectionDName,0,Section1LSource));
  with EditSection do begin
    Left:=204;
    Top:=AccountLabel.Top;
    DropDownWidth:=150;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=3;
  end;

  { Инициализация сохраненных значений }
  DlgOneDate.EditDateBeg.Text:=LedgerDate;
  EditAccount.KeyValue:=LedgerAccountD;
  EditSection.KeyValue:=AFSection;

  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) then
    with DlgOneDate do try
      { Сохранили значения для будущих диалогов }
      LedgerDate:=EditDateBeg.Text;
      LedgerAccountD:=EditAccount.Text;
      AFSection:=EditSection.KeyValue;
      LedgerVDeclar.DisableControls;
      LedgerVWork(EditAccount.Text, EditSection.Text, EditDateBeg.Text, 1, NotError);
    finally
      LedgerVDeclar.EnableControls;
      DlgOneDate.Release;
    end
  else SysUtils.Abort;
end;

Procedure TModuleCommon.LedgerReportClickCall(Sender: TObject);
begin
  with RotateBalanceTDeclar do
    if FieldByName('Account').AsString<>'' then
      LedgerVWorkCall(FieldByName('Account').AsString, FieldByName('Section').AsString, LedgerDate);
end;


Procedure TModuleCommon.LedgerVWorkCall(InAccount:string; InSection:string; InPeriod:string);
begin
  try
    LedgerVDeclar.DisableControls;
    {LedgerVWork(EditAccount.Text, EditSection.Text, EditDateBeg.Text, 1, NotError);}
    LedgerVWork(InAccount,InSection,InPeriod, 1, NotError);
  finally
    LedgerVDeclar.EnableControls;
    LedgerVC.Execute;
  end;
end;

Procedure TModuleCommon.ExportLedgerToExcel(Sender: TObject);
const MaxAccount=200;
      MaxColumns=37;  { Мах кол-во столбцов на лист главной книги }
var QQ: TEtvQuery;
    BuhAccounts: array[1..MaxAccount,1..2] of string[5];
    i,j,aCount: integer;
    aDeltaNumList: byte; { Приращение Счетчика листов из-за листов с большим кол-вом счетов }
    aOldYear: string[4];
begin
  if (UserName<>'LEV') and (UserName<>'BAUSHA') and (UserName<>'TAMARA') then begin
    ShowMessage('Данная процедура недоступна пользователю '+UserName);
    Exit;
  end;
  aPeriodStr:='01.01.2004';
  repeat
    if not InputQuery('Введите период для расчета главной книги',
      'Введите период для расчета главной книги',aPeriodStr) then Exit;
    DecodeDate(StrToDate(aPeriodStr), aYear, aMonth, aDay);
  until (aDay=1) and (aMonth<=12) and (aYear>=2003);
  if aYear=2003 then aOldYear:='2003' else aOldYear:='';
  try
    QQ:=TEtvQuery.Create(nil);
    QQ.DataBaseName:=Ledger.DataBaseName;
    QQ.SQL.Add('select distinct AccountD, SectionD from STA.Ledger'+aOldYear+' key join STA.SprAccount'+aOldYear+
      ' as FLedgerD_SprAccount where Year(Period)='+IntToStr(aYear)+' and (sType<2) order by AccountD,SectionD');
    QQ.Open;
    aCount:=0;
    while not QQ.Eof do begin
      Inc(aCount);
      BuhAccounts[aCount,1]:=QQ.FieldByName('AccountD').AsString;
      BuhAccounts[aCount,2]:=QQ.FieldByName('SectionD').AsString;
      QQ.Next
    end;
    QQ.Close;
    { Добваляем счет 99.99 }
    Inc(aCount);
    BuhAccounts[aCount,1]:='99.99';
    BuhAccounts[aCount,2]:='0';
  finally
    if Assigned(QQ) then QQ.Free;
  end;
  LedgerVDeclar.DisableControls;
{ ОГРАНИЧЕНИЕ КОЛ-ВА ЛИСТОВ ДЛЯ ОТЛАДКИ!!! }
//aCount:=15;
{ ОГРАНИЧЕНИЕ КОЛ-ВА ЛИСТОВ ДЛЯ ОТЛАДКИ!!! }
  aDeltaNumList:=0;
  for i:=1 to aCount do begin
    {if BuhAccounts[i,1]='92.00' then begin}
    {ShowMessage(BuhAccounts[i,1]+' '+BuhAccounts[i,2]);}
      LedgerVWork(BuhAccounts[i,1],BuhAccounts[i,2],aPeriodStr,0, NotError);
      if NotError then
        if LedgerVDeclar.FieldCount<=MaxColumns then
          ExportToExcel(LedgerVDeclar,BuhAccounts[i,1]+'-'+BuhAccounts[i,2], LedgerVC.Caption, i+aDeltaNumList,'','')
        else with LedgerVDeclar do begin { Разбиваем лист на два, т.к. кол-во столбцов очень большое }
          { Выводим лист с первыми MaxColumns (0..MaxColumns-1) столбцами }
          for j:=MaxColumns to LedgerVDeclar.FieldCount-1 do Fields[j].Visible:=false;
          ExportToExcel(LedgerVDeclar,BuhAccounts[i,1]+'-'+BuhAccounts[i,2]+'-1', LedgerVC.Caption, i+aDeltaNumList,'','');
          { Выводим еще один лист со столбцами из диапазона (MaxColumns..FieldCount-1) }
          Inc(aDeltaNumList);
          for j:=1 to LedgerVDeclar.FieldCount-1 do Fields[j].Visible:=not Fields[j].Visible;
          ExportToExcel(LedgerVDeclar,BuhAccounts[i,1]+'-'+BuhAccounts[i,2]+'-2', LedgerVC.Caption, i+aDeltaNumList,'','');
          { Если столбцов будет более чем 2*MaxColumns, то надо будет разбивать лист на 3, но пока вроде нет }
        end
    {end;}
  end;
  LedgerVDeclar.EnableControls;
end;

procedure TModuleCommon.LedgerCCreateForm(Sender: TObject);
begin
  LedgerGridPanel:=TPanel.Create(nil);
  CurLedgerLabel:=TLabel.Create(nil);
  with LedgerGridPanel do begin
    Align:=alBottom;
    Alignment:=taCenter;
    Height:=20;
  end;
  with CurLedgerLabel do begin
    Left:=20;
    Top:=1;
  end;

  with TBEForm(TDBFormControl(Sender).Form) do begin
    PageControl1.InsertControl(LedgerGridPanel);
    LedgerGridPanel.InsertControl(CurLedgerLabel);
    Grid.OnColEnter:=GridColEnter;
  end;
  if TDBFormControl(Sender).Name='LedgerC' then LedgerLabel:=CurLedgerLabel
  else Ledger2003Label:=CurLedgerLabel
end;

procedure TModuleCommon.GridColEnter(Sender: TObject);
begin
  if ((TDBGrid(Sender).SelectedField.FieldName='AccountDName') or
     (TDBGrid(Sender).SelectedField.FieldName='AccountKName') or
     (TDBGrid(Sender).SelectedField.FieldName='SectionDName') or
     (TDBGrid(Sender).SelectedField.FieldName='SectionKName')) then
    CurLedgerLabel.Caption:=TEtvLookField(TDBGrid(Sender).SelectedField).ValueByLookName('Name')
  else CurLedgerLabel.Caption:='';
  Inherited;
end;

procedure TModuleCommon.LedgerDataChange(Sender: TObject; Field: TField);
begin
  if (TLinkSource(Sender).DataSet.State=dsBrowse) and (Screen.ActiveForm is TBEForm) then begin
     if TLinkSource(Sender).DataSet=LedgerDeclar then CurLedgerLabel:=LedgerLabel else CurLedgerLabel:=Ledger2003Label;
     GridColEnter(TBEForm(Screen.ActiveForm).Grid)
  end;
end;

procedure TModuleCommon.AccountFlowT1Click(Sender: TObject);
var AccountLabel, SectionLabel, DebitLabel: TXLabel;
    DlgOneDate: TDialDate;
    EditAccount, EditSection: TEtvDBLookupCombo;
    EditDebitKredit: TEtvDBCombo;
    DebitComboBox: TComboBox;
    i: byte;
    DataSetCursor: HDBICur;

begin
  DlgOneDate:=TDialDate.Create(Application);
  {DlgOneDate.DateEditBe.Date:=Date;}
  with DlgOneDate do begin
    VisibleSecondDate(false,120);
    Caption:='Журнал';
  end;

  AccountLabel:=TXLabel.Create(DlgOneDate);
  with AccountLabel do begin
    Caption:='Бухгалтерский счет';
    Left:=24;
    Top:=68;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not AccountLookup.Active then AccountLookup.Open;
  EditAccount:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDeclarAccountDName,0,AccountLSource));
  with EditAccount do begin
    Left:=124;
    Top:=AccountLabel.Top;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=2;
  end;

  {* Ввод хозрасчетного подразделения *}
  SectionLabel:=TXLabel.Create(DlgOneDate);
  with SectionLabel do begin
    Caption:='Подразделение';
    Left:=170;
    Top:=44;
    Width:=82;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not Section1Lookup.Active then Section1Lookup.Open;
  EditSection:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,TransactDSectionDName,0,Section1LSource));
  with EditSection do begin
    Left:=204;
    Top:=AccountLabel.Top;
    DropDownWidth:=150;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=3;
    KeyValue:=0;
  end;

{*****************}
  DebitLabel:=TXLabel.Create(DlgOneDate);
  with DebitLabel do begin
    Caption:='Дебет-Кредит';
    Left:=24;
    Top:=94;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=20;
    Parent:=DlgOneDate;
  end;

  DebitComboBox:=TComboBox.Create(DlgOneDate);
  with DebitComboBox do begin
    Parent:=DlgOneDate;
    Style:=csDropDownList;
    Left:=124;
    Top:=DebitLabel.Top;
    Width:=63;
    {Text:='Дебет';}
    TabStop:=true;
    Items.Add('Все');
    Items.Add('Дебет');
    Items.Add('Кредит');
    ItemIndex:=1;
    TabOrder:=4;
  end;

  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) then
    with DlgOneDate do try
      { Закрыли таблицу со старыми значениями }
      with AccountFlowTDeclar do begin
(*
        i:=Fields.Count;
        while i>0 do begin
          RemoveField(Fields[i-1]);
          Dec(i);
        end;
        FieldDefs.Clear;
        Close;
        {
        DataSetCursor:=Handle;
        DbiCloseCursor(DataSetCursor);
        }
*)
        if (Filtered) or (Filter<>'') then begin
          Filtered:=false;
          Filter:='';
        end;
        Close;
      end;
     { Запустили генерацию необходимого Temporary Table }
      ExecSQLText(AccountFlowTDeclar.DataBaseName,
        'Call STA.GenerateAccountFlowT('''+EditAccount.Text+''','''+EditSection.Text+''','''+EditDateBeg.Text+''','''+
        IntToStr(DebitComboBox.ItemIndex)+''')',false);
      { Открыли таблицу с новыми значениями }
      AccountFlowTDeclar.Close;
      { Закрываем другие вспомогательные DataSet'ы (Поиск, фильтры и т.д.)}
      i:=0;
      with ModuleBase.KSMDatabase do
        while i<=DatasetCount-1 do begin
          if (DataSets[i] is TTable) and (TTable(DataSets[i]).TableName='AccountFlowT')
            then with TTable(DataSets[i]) do begin
              Close;
              FieldDefs.Clear;
            end
          else Inc(i);
        end;
      ModuleBase.KSMDatabase.FlushSchemaCache(UserName+'.AccountFlowT');
(*
      { Заголовок формы }
      with AccountFlowTC do begin
        Caption:='Журнал по '+EditAccount.Text+' счёту за '+EditDateBeg.Text+' период ';
        if Assigned(Form) then Form.Repaint;
      end;
*)
      if Assigned(AccountFlowTC.Form) then begin
        TBEForm(AccountFlowTC.Form).Scroll.DestroyComponents;
        TBEForm(AccountFlowTC.Form).Grid.Columns.RebuildColumns;
        AccountFlowTC.Form.Tag:=1;
      end;

      with AccountFlowTDeclar do begin
        {DisableControls;}
        FieldDefs.Clear;
        {AccountFlowV.Inner.FieldDefs.Clear;}
        Open;
       { Обзываем красиво DisplayLabel'ы}
(*
        Fields[0].DisplayLabel:='Дата';
        Fields[FieldCount-1].DisplayLabel:='Итого';
*)
        Fields[0].Visible:=false;
        for i:=1 to FieldCount-1 do with TNumericField(Fields[i]) do begin
          Alignment:=taRightJustify;
          DisplayWidth:=12;
        end;
        if Assigned(AccountFlowTC.Form) then begin
          TBEForm(AccountFlowTC.Form).Grid.Columns.RebuildColumns;
          AccountFlowTC.Form.Tag:=1;
        end;
        EnableControls;
      end;
    finally
      DlgOneDate.Release;
    end
  else SysUtils.Abort;
end;

procedure TModuleCommon.AccountFlowTCCreateForm(Sender: TObject);
begin
  TBEForm(TDBFormControl(Sender).Form).Grid.OnSetFont:=SetGridClientReportFont;
  TBEForm(TDBFormControl(Sender).Form).Grid.OnSetColor:=SetGridClientReportColor;
end;

procedure TModuleCommon.SetGridClientReportFont(Sender: TObject;
  Field: TField; Font: TFont);
var S2:string[10];
begin
  S2:=AccountFlowTDeclar.FieldByName('S2').AsString;
  if (S2='Дата') or (S2='Итого') or (S2='') then begin
    Font.Style:=[fsBold];
    Font.Color:=$00A00000;
  end;
end;

procedure TModuleCommon.SetGridClientReportColor(Sender: TObject; Field: TField; var Color: TColor);
begin
(*
  if (Copy(ClientReportDeclarProdName.AsString,1,2)='НА') and
  (Field.FieldName='SummaUnClose') then
    Color:=$00CCEAAC;//$00CCEACC;//$00C6FDD8;//$00C6CDFD;//$00A0CD8F;//$00C6DDA4
*)
end;

procedure TModuleCommon.ImportTransactClick(Sender: TObject);
begin
  if MessageDlg('Импортировать проводки по 51 счету в главную книгу?',
    mtConfirmation,[mbNo,mbYes],0)=idYes then begin
    aPeriodStr:=DateToStr(Date);
    aPeriodStr:='01.'+Copy(aPeriodStr,4,5);
    repeat
      if not InputQuery('Импорт проводок в главную книгу',
        'Период для импорта проводок по 51 счету',aPeriodStr) then Exit;
      DecodeDate(StrToDate(aPeriodStr), aYear, aMonth, aDay);
    until (aDay=1) and (aMonth<=12) and (aYear>=2005);
    ExecSQLText(ModuleBase.KSMDatabase.DataBaseName,
      'Call STA.Kredit51ToLedger('''+aPeriodStr+''')',false);
    ShowMessage('Импорт проводок по 51 счету в главную книгу произведен');
  end;
  if MessageDlg('Импортировать проводки по 52 счету в главную книгу?',
    mtConfirmation,[mbNo,mbYes],0)=idYes then begin
    aPeriodStr:=DateToStr(Date);
    aPeriodStr:='01.'+Copy(aPeriodStr,4,5);
    repeat
      if not InputQuery('Импорт проводок в главную книгу',
        'Период для импорта проводок по 52 счету',aPeriodStr) then Exit;
      DecodeDate(StrToDate(aPeriodStr), aYear, aMonth, aDay);
    until (aDay=1) and (aMonth<=12) and (aYear>=2005);
    ExecSQLText(ModuleBase.KSMDatabase.DataBaseName,'Call STA.Kredit52ToLedger('''+aPeriodStr+''')',false);
    ShowMessage('Импорт проводок по 52 счету в главную книгу произведен');
  end;
end;

procedure TModuleCommon.RotateBalanceTCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=2;
    Grid.TitleAlignment:=taCenter;
    BtnCalcRotateBalance:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCalcRotateBalance do begin
      Top:=0;
      Left:=125;
      Width:=95;
      Height:=22;
      Name:='BtnCalcRotateBalance';
      Caption:='Расчет баланса';
      Font.Name:='Arial Narrow';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=RotateBalanceReportClick;
    end;
    BtnCallPageMainBook:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCallPageMainBook do begin
      Top:=0;
      Left:=125+95+15;
      Width:=110;
      Height:=22;
      Name:='BtnCallPageMainBook';
      Caption:='Лист главной книги';
      Font.Name:='Arial Narrow';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=LedgerReportClickCall;
    end;
    BtnCallPageMainBook2:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCallPageMainBook2 do begin
      Top:=0;
      Left:=125+95+110+20;
      Width:=110;
      Height:=22;
      Name:='BtnCallPageMainBook2';
      Caption:='60 СЧЕТ';
      Font.Name:='Arial Narrow';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=LedgerReportClickCall2;
    end;
    Grid.OnDblClick:=LedgerReportClickCall;
  end;
end;

Procedure TModuleCommon.RotateBalanceReportClick(Sender: TObject);
var aPeriodStr: string;
    aYear, aMonth, aDay: word;
    aOldYear: string[4];
begin
  if (UserName<>'LEV') and (UserName<>'BAUSHA') and (UserName<>'ANDY') and (UserName<>'TAMARA')
  and (UserName<>'FIN') and (UserName<>'ADMIN') and (UserName<>'ECON') and (UserName<>'GLAVBUH') then begin
    ShowMessage('Данная процедура недоступна пользователю '+UserName);
    Exit;
  end;
  aPeriodStr:='01.01.2006';

  repeat
    if not InputQuery('Введите период для расчета главной книги',
      'Введите период для расчета главной книги',aPeriodStr) then Exit;
    DecodeDate(StrToDate(aPeriodStr), aYear, aMonth, aDay);
  until (aDay=1) and (aMonth<=12) and (aYear>=2003);
  if aYear=2003 then aOldYear:='2003' else aOldYear:='';
  LedgerDate:=aPeriodStr; // Инициализация периода для вызова листов главной книги
  ExecSQLText(ModuleBase.KSMDatabase.DataBaseName,'Call STA.GetRotateBalanceT'+aOldYear+'('''+aPeriodStr+''',1)',false);
  RotateBalanceTC.Caption:='Оборотный баланс за '+aPeriodStr;
  RotateBalanceTDeclar.Refresh;
end;

procedure TModuleCommon.BankImportClick(Sender: TObject);
var F: text;
    i: integer;
    Str: string;
    Position: byte;
begin
  if (UserName<>'LEV') and (UserName<>'BAUSHA') and (UserName<>'ANDY') then begin
    ShowMessage('Данная процедура недоступна пользователю '+UserName);
    Exit;
  end else begin
    ShowMessage(UserName+'!!! Данная процедура импортирует справочник банков из текстового файла в таблицу STA.SprBank99'+#13+
    'для последующих изменений в справочнике STA.SprBank')
  end;
  AssignFile(F,InputBox('Текстовый файл','Введите путь и имя файла','c:\bank.txt'));
  Reset(F);
  i:=0;
  Bank99Declar.Open;
  while not Eof(F) do begin
    Readln(F,Str);
    if Pos('г.',Str)=1 then begin // первая строка по очередному банку
      Bank99Declar.Insert;
      Inc(i);
      // Исключение нас. пункт Большая Берестовица --> Большая_Берестовица
      Position:=Pos(' ',Str);
      Bank99DeclarPlace.AsString:=Copy(Str,1,Position-1);
      Bank99DeclarName.AsString:=Copy(Str,Position+1,150);
      Readln(F,Str); // Номер МФО
      Bank99DeclarKod.AsString:=Copy(Str,Pos(':',Str)+2,9);
      Readln(F,Str); // Адрес
      Bank99DeclarAddress.AsString:=Copy(Str,Pos(':',Str)+6,150);
      Readln(F,Str); // Телефон
      Bank99DeclarPhone.AsString:=Copy(Str,Pos(':',Str)+3,150);
      Readln(F,Str); // Факс
      Bank99DeclarFax.AsString:=Copy(Str,Pos(':',Str)+6,150);
      Readln(F,Str); // или E-Mail или УНН
      if Pos('E-mail:',Str)>0 then begin
        Bank99DeclarEMail.AsString:=Copy(Str,Pos(':',Str)+2,150);
        Readln(F,Str); // теперь уж точно УНН
      end;
      Bank99DeclarINN.AsString:=Copy(Str,Pos(':',Str)+4,150);
      Readln(F,Str); // Руководитель
      Bank99DeclarDirector.AsString:=Copy(Str,Pos(':',Str)+2,150);
      Bank99Declar.Post;
      Readln(F); // Пропуск строки
    end;
  end;
  CloseFile(F);
  ShowMessage('Вставлено '+IntToStr(I)+' записей...')
  {Импорт справочника банков}
end;

procedure TModuleCommon.AccountFlowTCDestroyForm(Sender: TObject);
begin
  {Удаляем временную таблицу на сервере}
  ExecSQLText(AccountFlowVDeclar.DataBaseName,'drop Table '+UserName+'.AccountFlowT',false);
end;

procedure TModuleCommon.AccountFlowVCDestroyForm(Sender: TObject);
begin
  {Удаляем View UserName.AccountFlowV на сервере}
  ExecSQLText(AccountFlowVDeclar.DataBaseName,'drop View '+UserName+'.AccountFlowV',false);
end;

procedure TModuleCommon.CurrencyJournalTCCreateForm(Sender: TObject);
begin
  ModuleClientsAdd.CreateReportForm(Sender);
end;

procedure TModuleCommon.CurrencyReportCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=2;
    Grid.TitleAlignment:=taCenter;
    BtnCalcCurrencyReport:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCalcCurrencyReport do begin
      Top:=0;
      Left:=125;
      Width:=105;
      Height:=22;
      Name:='BtnCalcCurrencyReport';
      Caption:='Отчет по валюте';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=CurrencyReportClick;
    end;
  end;
end;

Procedure TModuleCommon.CurrencyReportClick(Sender: TObject);
var aPeriodStr: string;
    aYear, aMonth, aDay: word;
begin
  aPeriodStr:='01.01.2005';
  repeat
    if not InputQuery('Отчет по валюте',
      'Введите дату для расчета отчета по валюте (берется только год)',aPeriodStr) then Exit;
    DecodeDate(StrToDate(aPeriodStr), aYear, aMonth, aDay);
  until (aDay=1) and (aMonth<=12) and (aYear>=2003);
  ExecSQLText(ModuleBase.KSMDatabase.DataBaseName,'Call STA.GetCurrencyReport('''+aPeriodStr+''')',false);
  CurrencyReportC.Caption:='Отчет по валюте за '+IntToStr(aYear)+' год' ;
  CurrencyReportDeclar.Close;
  CurrencyReportDeclar.Open;
end;

procedure TModuleCommon.LedgerZRepCCreateForm(Sender: TObject);
begin
  if Sender.ClassName<>'TDBFormControl' then Exit;
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=4;
    Grid.TitleAlignment:=taCenter;
    BtnCalcLedgerZ:=TBitBtn.Create(TDBFormControl(Sender).Form);
    with BtnCalcLedgerZ do begin
      Top:=0;
      Left:=125;
      Width:=105;
      Height:=22;
      Name:='BtnCalcLedgerZ';
      Caption:='Расчет листа';
      Font.Style:=[fsBold];
      Parent:=PageControl1TabPanel;
      OnClick:=LedgerZRepClick;
    end;

{      TBEForm(Form).Grid.OnSetFont:=SetGridClientReportFont;
      TBEForm(Form).Grid.OnSetColor:=SetGridClientReportColor;
      TBEForm(Form).Grid.OnDblClick:=GridDblClick;}

    LedgerDate:='01.01.'+Copy(DateToStr(Date),7,2);
    LedgerAccountD:='';
  end;
end;


Procedure TModuleCommon.LedgerZRepClick(Sender: TObject);
var AccountLabel,SectionLabel: TXLabel;
    DlgOneDate: TDialDate;
    LookSource: TDataSource;
    EditAccount,EditSection:TEtvDBLookupCombo;
    i: byte;
    DataSetCursor: HDBICur;

begin
  DlgOneDate:=TDialDate.Create(Application);
  {DlgOneDate.EditDateBe.Date:=Date;}
  with DlgOneDate do begin
    {VisibleSecondDate(false);}
    Caption:='Расчет листа главной книги (забаланс)';
    LabelDateEnd.Visible:=false;
    EditDateEnd.Visible:=false;
    Bevel1.Height:=80;
    Height:=150;
    BitBtn1.Top:=Bevel1.Top+Bevel1.Height+6;
    BitBtn2.Top:=BitBtn1.Top;
    EditDateBeg.Text:='01.01.'+Copy(DateToStr(Date),7,2);
  end;

  AccountLabel:=TXLabel.Create(DlgOneDate);
  with AccountLabel do begin
    Caption:='Бухгалтерский счет';
    Left:=24;
    Top:=48;
    Width:=81;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  LookSource:=TDataSource.Create(DlgOneDate);
  LookSource.DataSet:=SprLedgerZLookup;
  if not LookSource.DataSet.Active then LookSource.DataSet.Open;
  EditAccount:=TEtvDBLookupCombo(EditForField(DlgOneDate,LedgerZDeclarAccountName{TransactDeclarAccountDName},0,LookSource));
  with EditAccount do begin
    Left:=108;
    Top:=AccountLabel.Top;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=2;
  end;

  {* Ввод хозрасчетного подразделения *}
  SectionLabel:=TXLabel.Create(DlgOneDate);
  with SectionLabel do begin
    Caption:='Подразделение';
    Left:=180;
    Top:=24;
    Width:=80;
    AutoSize:=false;
    WordWrap:=true;
    Height:=30;
    Parent:=DlgOneDate;
  end;

  if not Section1Lookup.Active then Section1Lookup.Open;
  EditSection:=
    TEtvDBLookupCombo(EditForField(DlgOneDate,LedgerZDeclarAccountName,0,Section1LSource));
  with EditSection do begin
    Left:=204;
    Top:=AccountLabel.Top;
    DropDownWidth:=150;
    {Width:=100;
    DisplayFormat:='';}
    TabStop:=true;
    Parent:=DlgOneDate;
    TabOrder:=3;
  end;

  { Инициализация сохраненных значений }
  DlgOneDate.EditDateBeg.Text:=LedgerDate;
  EditAccount.KeyValue:=LedgerAcc;
  EditSection.KeyValue:=AFSection;

  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) then
    with DlgOneDate do try
      { Сохранили значения для будущих диалогов }
      LedgerDate:=EditDateBeg.Text;
      LedgerAcc:=EditAccount.Text;
      AFSection:=EditSection.KeyValue;
      LedgerZRepDeclar.DisableControls;
      LedgerZRepWork(EditAccount.Text, EditSection.Text, EditDateBeg.Text, 1, NotError);
    finally
      LedgerZRepDeclar.EnableControls;
      DlgOneDate.Release;
    end
  else SysUtils.Abort;
end;

Procedure TModuleCommon.LedgerZRepWork(aAccountD:string; aSectionD: string; aPeriod: string; ReCalc: byte; var NotError: boolean);
var i: integer;
    aErrorMessage: string;
    aOldYear:string; // для расчета старых лет
    Delta:byte;
begin
  NotError:=true;
  with LedgerZRepDeclar do begin
    if (Filtered) or (Filter<>'') then begin
      Filtered:=false;
      Filter:='';
    end;
    Close;
  end;
  { Случай, когда ввели только год в качестве периода}
  if Pos('.',aPeriod)=0 then aPeriod:='01.01.'+aPeriod;
   { Запустили генерацию необходимого VIEW }
{  if (Copy(aPeriod,7,2)='03') or (Copy(aPeriod,7,4)='2003') then aOldYear:='2003' else aOldYear:='';}
  try
    ExecSQLText(LedgerZRepDeclar.DataBaseName,'Call STA.GetLedgerZRep('''+aAccountD+''','+aSectionD+','''+aPeriod+''')',false);
  except
    on E:Exception do begin
      i:=Pos(':',E.Message);
      ShowMessage(Copy(E.Message,i+1,Length(E.Message)-i));
      {ShowMessage('По счету '+aAccountD+'-'+aSectionD+' учет не ведется!!!');}
      NotError:=false;
    end;
  end;
  { Открыли таблицу с новыми значениями }
  LedgerZRepDeclar.Close;
  { Закрываем другие вспомогательные DataSet'ы (Поиск, фильтры и т.д.)}
  i:=0;
  with ModuleBase.KSMDatabase do
    while i<=DatasetCount-1 do begin
      if (DataSets[i] is TTable) and (TTable(DataSets[i]).TableName='STA.LedgerZRep')
        then with TTable(DataSets[i]) do begin
          Close;
          FieldDefs.Clear;
        end
      else Inc(i);
    end;
  if not NotError then Exit;
  ModuleBase.KSMDatabase.FlushSchemaCache('STA.LedgerZRep');
  { Заголовок формы }
  with LedgerZRepC do begin
    Caption:='ОАО "ГКСМ". Счет '+aAccountD+'-'+aSectionD+' : '+
      GetFromSQLText(LedgerZ.DataBaseName,'select "Name" from STA.SprLedgerZ where Kod='''+aAccountD+'''',true);
    if Assigned(Form) then Form.Repaint;
  end;
  LedgerZRepDeclar.Open;

(*
  if Assigned(LedgerZRepC.Form) then begin
    TBEForm(LedgerZRepC.Form).Scroll.DestroyComponents;
    LedgerZRepC.Form.Tag:=1;
    {TBEForm(LedgerVC.Form).Grid.Columns.Destroy;}
  end;
(*
  with LedgerZRepDeclar do begin
    FieldDefs.Clear;
    Open;
   { Обзываем красиво DisplayLabel'ы}
    Fields[0].DisplayLabel:='Период';
    if (Pos('68.',aAccountD)>0) or (Pos('90.',aAccountD)>0) or (Pos('91.',aAccountD)>0) or (Pos('92.',aAccountD)>0)
    or (aAccountD='99.99') then Delta:=7 else Delta:=5;
    for i:=1 to FieldCount-Delta do
      Fields[i].DisplayLabel:=Copy(Fields[i].FieldName,2,2)+'/'+Copy(Fields[i].FieldName,5,2)
      +'-'+Copy(Fields[i].FieldName,8,1);
    for i:=FieldCount-Delta to FieldCount-1 do Fields[i].DisplayWidth:=12;
    Fields[FieldCount-Delta].DisplayLabel:='Обороты по дебету';
    Fields[FieldCount-(Delta-1)].DisplayLabel:='Обороты по кредиту';
    Fields[FieldCount-(Delta-2)].DisplayLabel:='Дебетовое сальдо';
    Fields[FieldCount-(Delta-3)].DisplayLabel:='Кредитовое сальдо';
    Fields[FieldCount-(Delta-4)].DisplayLabel:='Корректировка ';
    if Delta=7 then begin
      Fields[FieldCount-(Delta-5)].DisplayLabel:='Обороты по дебету с нарастающим итогом';
      Fields[FieldCount-(Delta-6)].DisplayLabel:='Обороты по кредиту с нарастающим итогом';
    end;
    for i:=0 to FieldCount-1 do
     if Fields[i].DataType=ftFloat then TNumericField(Fields[i]).DisplayFormat:='### ### ### ##0.';
  end; *)
end;

procedure TModuleCommon.PVReportDeclarBeforeOpen(DataSet: TDataSet);
begin
  ExecSQLText(ModuleBase.KSMDatabase.DataBaseName,'Call STA.GetPVReportBegin()',false);
end;

procedure TModuleCommon.LedgerReportClickCall2(Sender: TObject);
var
  Cond: TListObj;
  i: integer;
  Dat: TDateTime;
begin
  if Assigned(mdMat) then
    begin
     mdMat.Tag:=1;
     mdMat.MProviderOstC.Execute;
     with TBEForm(mdMat.MProviderOstC.Form).Grid, mdMat.MProviderOstC do begin
       //Execute;
       FormatColumns(true);
       Cond:=TFilterItem(TXInquiryItem(Inquiries[1]).Filters.Data.Filters[0]).Conditions;
       dat:=StrToDateTime(LedgerDate);
       for i:=0 to Cond.Count-1 do
        with TConditionItem(Cond[i]) do
          if AnsiUpperCase(FieldName)='PERIOD' then Value:=dat;
       PlayInquiry(Inquiries[1],Cond);
       Refresh;
     end;
     mdMat.Tag:=0;
   end;
end;

procedure TModuleCommon.TransactCCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=2;
    Grid.OnDblClick:=ModuleClientsAdd.GridDblClick;
  end;
end;

procedure TModuleCommon.SprBCountDeclarsJAccValidate(Sender: TField);
var S: string;
    i:byte;
    fError: boolean;
begin
  if Sender=SprBCountDeclarsJAcc then begin
    fError:=false;
    if SprBCountDeclarsJAcc.IsNull then Exit; // При очистке поля с помощью Popup меню
    S:=SprBCountDeclarsJAcc.AsString;
    if (Length(S)<5) or ((Length(S)-(Length(S) div 5)+1) mod 5<>0) then fError:=true; // Контролируем всё.
    // Проверка на допустимые символы
    for i:=1 to Length(S) do
      case i mod 3 of
        1,2: if not(S[i] in ['0'..'9']) then fError:=true;
        0: case i mod 6 of
             3: if S[i]<>'.' then fError:=true;
             0: if S[i]<>',' then fError:=true;
           end;
      end;
      if fError then begin
        ShowMessage('Недопустимый формат поля!'+#13+'Допустимый формат: 00.00,00.00,00.00, и т.д.');
        SysUtils.Abort;
      end;
  end;
end;

end.
