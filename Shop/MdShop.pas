unit MdShop;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  XMisc, XTFC, XDBTFC, Db, DBTables, EtvTable, LnTables, LnkSet, Menus,
  EtvLook, XEFields, ppBands, ppRelatv, ppCache, ppClass, ppComm, ppProd,
  ppReport, EtvList;

type
  TModuleShop = class(TDataModule)
    Shop: TLinkSource;
    ShopDeclar: TLinkTable;
    ShopDeclarKod: TStringField;
    ShopDeclarsDate: TDateField;
    ShopDeclarFIO: TStringField;
    ShopDeclarAddr: TStringField;
    ShopDeclarSumma: TFloatField;
    ShopDeclarAdditInfo: TStringField;
    Popup: TControlMenu;
    ShopC: TDBFormControl;
    ShopProd: TLinkSource;
    ShopProdDeclar: TLinkTable;
    ShopProdDeclarAutoinc: TIntegerField;
    ShopProdDeclarContract: TStringField;
    ShopProdDeclarProd: TIntegerField;
    ShopProdDeclarAmount: TIntegerField;
    ShopProdDeclarPrice: TIntegerField;
    ShopProdD: TLinkSource;
    ShopLookup: TLinkQuery;
    ShopLookupKod: TStringField;
    ShopProdDDeclar: TLinkTable;
    ShopProdDDeclarAutoinc: TIntegerField;
    ShopProdDDeclarContract: TStringField;
    ShopProdDDeclarProd: TIntegerField;
    ShopProdDDeclarAmount: TIntegerField;
    ShopProdDDeclarPrice: TIntegerField;
    ShopProdDDeclarProdName: TXELookField;
    ReportShop: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ShopDeclarPayType: TXEListField;
    ShopProdDeclarProdName: TEtvLookField;
    ShopProdDeclarSumma: TFloatField;
    ShopProdDDeclarSumma: TFloatField;
    procedure ShopProdDDeclarCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleShop: TModuleShop;

implementation

{$R *.DFM}

procedure TModuleShop.ShopProdDDeclarCalcFields(DataSet: TDataSet);
begin
  ShopProdDDeclarSumma.Value := ShopProdDDeclarAmount.Value*ShopProdDDeclarPrice.Value;
End;

end.
