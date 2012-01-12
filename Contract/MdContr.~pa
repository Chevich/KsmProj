unit MdContr;

interface

uses
  Forms, XTFC, Menus, Db, DBTables, LnTables, EtvDB,
  Classes, XMisc, EtvTable, XEFields, LnkSet, XDBTFC, EtvList, EtvLook;

type
  TModuleContract = class(TDataModule)
    ContractC: TDBFormControl;
    Contract: TLinkSource;
    ContractDeclar: TLinkTable;
    ContractLookup: TLinkTable;
    ContractDeclarKod: TStringField;
    ContractDeclarOrgName: TXELookField;
    ContractDeclarSDate: TDateField;
    ContractDeclarTimeTare: TSmallintField;
    ContractDeclarFileName: TStringField;
    ContractDeclarTContract: TSmallintField;
    ContractDeclarTContractName: TXELookField;
    ContractDeclarAllower: TIntegerField;
    ContractDeclarAllowerName: TXELookField;
    ContractDeclarSectionName: TXELookField;
    ContractDeclarRemark: TStringField;
    ContractDeclarFormPrice: TSmallintField;
    ContractDeclarFormPriceName: TXELookField;
    ContractDeclarTPrice: TSmallintField;
    ContractDeclarTPriceName: TXELookField;
    ContractDeclarSumma: TFloatField;
    ContractDeclarObject: TStringField;
    ContractDeclarKodCountOrg: TSmallintField;
    ContractDeclarBank: TXELookField;
    ContractDeclarPointUnloading: TStringField;
    ContractDeclarActive: TXEListField;
    ContractDeclarPenalty: TFloatField;
    ContractDeclarShop: TSmallintField;
    ContractDeclarDateActive: TDateField;
    ContractLookupKod: TStringField;
    ContractLookupClient: TIntegerField;
    ContractProdC: TDBFormControl;
    ContractProd: TLinkSource;
    ContractProdDeclar: TLinkTable;
    ContractProdDeclarAutoInc: TAutoIncField;
    ContractProdDeclarContract: TStringField;
    ContractProdDeclarAmount: TFloatField;
    ContractProdDeclarTPrice: TSmallintField;
    ContractProdDeclarTPriceName: TXELookField;
    ContractProdDeclarTare: TSmallintField;
    ContractProdDeclarTareName: TXELookField;
    ContractProdLookup: TLinkQuery;
    ContractProdD: TLinkSource;
    ContractPrpodDDeclar: TLinkTable;
    ContractProdDAutoInc: TAutoIncField;
    ContractPrpodDDeclarContract: TStringField;
    ContractProdDAmount: TFloatField;
    ContractProdDTPrice: TSmallintField;
    ContractPrpodDDeclarTPriceName: TXELookField;
    ContractProdDTare: TSmallintField;
    ContractProdDTareName: TXELookField;
    ContractProdUs: TLinkSource;
    ContractProdUsDeclar: TLinkTable;
    ContractProdUsAutoInc: TAutoIncField;
    ContractProdUsContract: TStringField;
    ContractProdUsProdUs: TStringField;
    ContractProdUsAmount: TFloatField;
    ContractProdUsCurrency: TSmallintField;
    ContractProdUsCurrencyName: TXELookField;
    ContractProdUsTPrice: TSmallintField;
    ContractProdUsTPriceName: TXELookField;
    ContractProdUsPrice: TFloatField;
    ContractProdUsDeclarumma: TFloatField;
    ContractProdUsD: TLinkSource;
    ContractProdUsDetail: TLinkTable;
    ContractProdUsAutoIncD: TAutoIncField;
    ContractProdUsContractD: TStringField;
    ContractProdUsProdUsD: TStringField;
    ContractProdUsAmountD: TFloatField;
    ContractProdUsCurrencyD: TSmallintField;
    ContractProdUsCurrencyNameD: TXELookField;
    ContractProdUsTPriceD: TSmallintField;
    ContractProdUsTPriceNameD: TXELookField;
    ContractProdUsPriceD: TFloatField;
    ContractProdUsSummaD: TFloatField;
    TContractC: TDBFormControl;
    TContract: TLinkSource;
    TContractDeclar: TLinkTable;
    TContractDeclarKod: TSmallintField;
    TContractDeclarName: TStringField;
    TContractLookup: TLinkQuery;
    TContractLookupkod: TSmallintField;
    TContractLookupname: TStringField;
    Popup: TControlMenu;
    Contract1: TLinkMenuItem;
    ContractProd1: TLinkMenuItem;
    TContract1: TLinkMenuItem;
    ContractDeclarNumReg: TStringField;
    ContractDeclarDateReg: TDateField;
    ContractDeclarCurrency: TSmallintField;
    ContractDeclarCurrencyName: TXELookField;
    ContractDeclarClient: TIntegerField;
    ContractDeclarSection: TIntegerField;
    N1: TMenuItem;
    GoalPurchase: TLinkSource;
    GoalPurchaseC: TDBFormControl;
    GoalPurchaseDeclar: TLinkTable;
    GoalPurchaseDeclarKod: TSmallintField;
    GoalPurchaseDeclarName: TStringField;
    GoalPurchase1: TLinkMenuItem;
    GoalPurchaseLookup: TLinkQuery;
    GoalPurchaseLookupKod: TSmallintField;
    GoalPurchaseLookupName: TStringField;
    ContractDeclarGoalPurchase: TSmallintField;
    ContractDeclarGoalPurchaseName: TXELookField;
    ContractLookupCurrency: TSmallintField;
    ContractLookupGoalPurchase: TSmallintField;
    ContractLookupGoalPurchaseName: TXELookField;
    N2: TMenuItem;
    ContractLookupsDate: TDateField;
    ContractDeclarRemark1: TStringField;
    ContractLookupRemark1: TStringField;
    ContractLookupDateActive: TDateField;
    ContractLSource: TProcSubSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleContract: TModuleContract;

implementation

uses MdOrgs, MdBase, MdProd, MdWorkers;

{$R *.DFM}

end.
