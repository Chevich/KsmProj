unit Datamod1;
{При трансляции Transfer вписать dba+password в params of tdatabase }
{При трансляции Bank удалить dba+password в params of tdatabase }
{Можно сделать программно.  (Программно можно сделать все)}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, EtvDB, EtvTable, EtvForms, EtvList, EtvLook;

type
  TDM1 = class(TDataModule)
    TbSprPlace: TEtvTable;
    TbSprBa: TEtvTable;
    TbSprVa: TEtvTable;
    TbSprPP: TEtvTable;
    TbSprKu: TEtvTable;
    TbSprTD: TEtvTable;
    TbSprTOp: TEtvTable;
    TbSprBCount: TEtvTable;
    DSSprPP: TDataSource;
    EtvDMInfo1: TEtvDMInfo;
    DSSprCount2Pay: TDataSource;
    TbSprCount2Pay: TEtvTable;
    TbSprCount2PayName: TStringField;
    TbSprCount2PayDate: TDateField;
    TbSprCount2PaySumma: TFloatField;
    TbSprCount2PaySummaD: TCurrencyField;
    TbSprCount2PaySummaK: TCurrencyField;
    DSSprCount: TDataSource;
    TbConf: TEtvTable;
    TbConfPrioritetKart: TSmallintField;
    TbConfOrgKart: TIntegerField;
    DSConf: TDataSource;
    DSSprVa: TDataSource;
    TbSprCount2PaySummaBY: TFloatField;
    TbConfDirSourceVa: TStringField;
    TbConfDirSourcePayVa: TStringField;
    TbConfDirSourcePay: TStringField;
    TbConfLastDir: TStringField;
    EtvDBGKSM: TDatabase;
    QOrg: TEtvQuery;
    QOrgbcount: TStringField;
    QOrgorg: TIntegerField;
    QOrgname: TStringField;
    TbSprBaName: TStringField;
    TbSprBaPIndex: TIntegerField;
    TbSprBaCountry: TSmallintField;
    TbSprBaPhones: TStringField;
    TbSprBaPlace: TIntegerField;
    TbSprBaKodOtd: TSmallintField;
    TbSprBaRemark: TMemoField;
    TbSprCo: TEtvTable;
    TbSprCoKod: TSmallintField;
    TbSprCoName: TStringField;
    TbSprCoPhoneKod: TStringField;
    TbSprCoKod2: TStringField;
    TbSprBaCountryN: TEtvLookField;
    TbSprVaKod: TSmallintField;
    TbSprVaKod3: TStringField;
    TbSprVaName: TStringField;
    TbSprVaRelation: TSmallintField;
    TbSprVaNameDop: TStringField;
    TbSprVaCountry: TIntegerField;
    TbSprVaCountryN: TEtvLookField;
    QSprCo: TEtvQuery;
    QSprCoKod: TSmallintField;
    QSprCoName: TStringField;
    QSprVa: TEtvQuery;
    QSprVaKod: TSmallintField;
    QSprVaKod3: TStringField;
    QSprVaName: TStringField;
    QSprVaRelation: TSmallintField;
    QSprVaNameDop: TStringField;
    QSprVaCountry: TIntegerField;
    QSprVaTag: TSmallintField;
    TbSprPPKod: TSmallintField;
    TbSprPPName: TStringField;
    QSprPP: TEtvQuery;
    QSprPPKod: TSmallintField;
    QSprPPName: TStringField;
    TbSprKuKod: TSmallintField;
    TbSprKuName: TStringField;
    QSprKu: TEtvQuery;
    QSprKuKod: TSmallintField;
    QSprKuName: TStringField;
    TbSprTDKod: TSmallintField;
    TbSprTDName: TStringField;
    TbSprTDStrict: TStringField;
    QSprTD: TEtvQuery;
    QSprTDKod: TSmallintField;
    QSprTDName: TStringField;
    QSprTDStrict: TStringField;
    QSprTOp: TEtvQuery;
    QSprTOpKod: TSmallintField;
    QSprTOpName: TStringField;
    TbSprTOpKod: TSmallintField;
    TbSprTOpPGNI: TEtvListField;
    TbSprTOpPTam: TEtvListField;
    TbSprTOpName: TStringField;
    TbSprVaTag: TEtvListField;
    TbSprBCountMFO: TStringField;
    TbSprBCountBCount: TStringField;
    TbSprBCountKodVa: TSmallintField;
    TbSprBCountName: TStringField;
    TbSprBCountsDate: TDateField;
    TbSprBCountSumma: TFloatField;
    TbSprBCountSummaBY: TFloatField;
    TbSprBCountsOrder: TSmallintField;
    TbSprBCountKodVaN: TEtvLookField;
    TbSprBaPlaceN: TEtvLookField;
    QSprPlace: TEtvQuery;
    QSprPlaceKod: TIntegerField;
    QSprPlaceName: TStringField;
    QSprPlaceKodUp: TIntegerField;
    QSprPlaceCountry: TSmallintField;
    TbSprPlaceKod: TIntegerField;
    TbSprPlaceName: TStringField;
    TbSprPlaceTPlace: TSmallintField;
    TbSprPlaceRegion: TIntegerField;
    TbSprPlaceCountry: TSmallintField;
    TbSprPlacePhoneKod: TStringField;
    TbSprPlaceSubRegion: TIntegerField;
    TbSprTPlace: TEtvTable;
    QSprTPlace: TEtvQuery;
    TbSprTPlaceKod: TSmallintField;
    TbSprTPlaceName: TStringField;
    QSprTPlaceKod: TSmallintField;
    QSprTPlaceName: TStringField;
    TbSprPlaceTPlaceN: TEtvLookField;
    TbSprPlaceCountryN: TEtvLookField;
    TbSprPlacePrPlace: TEtvListField;
    QSprPlaceRe: TEtvQuery;
    QSprPlaceReKod: TIntegerField;
    QSprPlaceReName: TStringField;
    QSprPlaceReCountry: TSmallintField;
    QSprPlaceSubRe: TEtvQuery;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    TbSprPlaceRegionN: TEtvLookField;
    TbSprPlaceSubRegionN: TEtvLookField;
    QSprPlaceSubReRegion: TIntegerField;
    QSprBCount: TEtvQuery;
    QSprBCountMFO: TStringField;
    QSprBCountBCount: TStringField;
    QSprBCountKodVa: TSmallintField;
    QSprBCountName: TStringField;
    QSprBCountsOrder: TSmallintField;
    TbConfDirText: TStringField;
    TbSprCount2PayMFO: TStringField;
    TbSprCount2PayBCount: TStringField;
    TbSprTax: TEtvTable;
    TbSprTaxKod: TSmallintField;
    TbSprTaxName: TStringField;
    TbSprTaxMFO: TStringField;
    TbSprTaxBCount: TStringField;
    TbSprTaxTOp: TSmallintField;
    TbSprTaxOrgN: TStringField;
    TbSprTaxTOpN: TEtvLookField;
    TbSprBaCorrCount: TStringField;
    QOrgKodOtd: TSmallintField;
    QSprBank: TEtvQuery;
    QSprBankName: TStringField;
    QSprBankKodOtd: TSmallintField;
    TbConfDateKart: TDateTimeField;
    TbConfDateValut: TDateTimeField;
    TbConfDatePay: TDateTimeField;
    tbBankProtocols: TEtvTable;
    tbBankProtocolssDate: TDateTimeField;
    tbBankProtocolsComment: TStringField;
    tbBankProtocolsID: TIntegerField;
    QSprBankKod: TStringField;
    TbSprBaKod: TStringField;
    TbSprBaRKC: TStringField;
    TbSprCount2PaysOrder: TSmallintField;
    procedure TbSprPlaceEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprVaEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprBaEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprPPEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprKuEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprTOpEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprTDEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprBCountEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbSprCount2PayCalcFields(DataSet: TDataSet);
    procedure DM1Create(Sender: TObject);
    procedure TbSprCoEditData(Sender: TObject; TypeShow: TTypeShow;
      FieldReturn: TFieldReturn);
    procedure TbSprTPlaceEditData(Sender: TObject; TypeShow: TTypeShow;
      FieldReturn: TFieldReturn);
    procedure TbSprTaxEditData(Sender: TObject; TypeShow: TTypeShow;
      FieldReturn: TFieldReturn);
    procedure TbSprTaxCalcFields(DataSet: TDataSet);
    procedure tbBankProtocolsEditData(Sender: TObject; TypeShow: TTypeShow;
      FieldReturn: TFieldReturn);
    procedure AppMessage1(var Msg: TMsg; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetOptions;
  end;

var
  DM1: TDM1;

var va:variant;

implementation
uses fBase;
{$R *.DFM}

procedure TDm1.SetOptions;
var Q:TEtvQuery;
begin
  Q:=TEtvQuery.Create(nil);
  try
    Q.DatabaseName:='DBGksm';
    Q.Sql.Add('SET TEMPORARY OPTION date_order = ''dmy''');
    Q.ExecSQL;
  finally
    Q.Free;
  end;
end;

procedure TDM1.TbSprPlaceEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprPlace,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprVaEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprVa,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprBaEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprBa,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprPPEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprPP,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprKuEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprKu,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprTOpEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprTOp,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprTDEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprTD,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprBCountEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormBase,TbSprBCount,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprCoEditData(Sender: TObject; TypeShow: TTypeShow;
  FieldReturn: TFieldReturn);
begin
  ToForm(TFormBase,TbSprCo,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprTPlaceEditData(Sender: TObject; TypeShow: TTypeShow;
  FieldReturn: TFieldReturn);
begin
  ToForm(TFormBase,TbSprTPlace,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprCount2PayCalcFields(DataSet: TDataSet);
begin
  if TbSprCount2PaySumma.Value<0 then begin
    TbSprCount2PaySummaD.Value:=Abs(TbSprCount2PaySumma.Value);
    TbSprCount2PaySummaK.Value:=0;
  end else begin
    TbSprCount2PaySummaD.Value:=0;
    TbSprCount2PaySummaK.Value:=TbSprCount2PaySumma.Value;
  end;
end;

procedure TDM1.DM1Create(Sender: TObject);
begin
  va:=varArrayCreate([0,1],varVariant);
  Application.OnMessage:=AppMessage1;
end;

procedure TDM1.TbSprTaxEditData(Sender: TObject; TypeShow: TTypeShow;
  FieldReturn: TFieldReturn);
begin
  ToForm(TFormBase,TbSprTax,TypeShow,FieldReturn);
end;

procedure TDM1.TbSprTaxCalcFields(DataSet: TDataSet);
begin
if (TbSprTaxMFO.value<>'') and (TbSprTaxBCount.value<>'') then begin
    va[0]:=TbSprTaxMFO.value;
    va[1]:=TbSprTaxBCount.value;
    if QOrg.locate('kodotd;BCount',Va,[]) then
      TbSprTaxOrgN.value:=QOrgOrg.asString+'  '+QOrgName.value;
  end;
end;

procedure TDM1.tbBankProtocolsEditData(Sender: TObject;
  TypeShow: TTypeShow; FieldReturn: TFieldReturn);
begin
  ToForm(TFormBase,tbBankProtocols,TypeShow,FieldReturn);
end;

Procedure TDM1.AppMessage1(var Msg: TMsg; var Handled: Boolean);
var i: LongInt;
begin
  {Mouse wheel behaves strangely with dgbgrids - this proc sorts this out}
  if Msg.message = WM_MOUSEWHEEL then begin
    Msg.message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := Msg.wParam;
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;
      Handled := False;
  end;
end;

end.
