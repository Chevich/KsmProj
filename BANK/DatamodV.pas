unit DatamodV;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, EtvTable, EtvForms, EtvDB, EtvLook;

type
  TDMV = class(TDataModule)
    TbVal: TEtvTable;
    TbValDate: TDateField;
    TbValCurrency: TSmallintField;
    TbValCurrencyN: TEtvLookField;
    TbValCourse: TFloatField;
    TbValKodOwner: TSmallintField;
    TbValOwnerN: TEtvLookField;
    TbValRelation: TSmallintField;
    DSVal: TDataSource;
    TbValC: TEtvTable;
    TbValCDate: TDateField;
    TbValCCurrency: TSmallintField;
    TbValCCurrencyN: TEtvLookField;
    TbValCCourse: TFloatField;
    TbValCKodOwner: TSmallintField;
    TbValCOwnerN: TEtvLookField;
    TbValCRelation: TSmallintField;
    DSValC: TDataSource;
    EtvDMInfo1: TEtvDMInfo;
    QV2V: TQuery;
    QV2VThisSumma: TFloatField;
    QV2VThisDate: TDateField;
    QRateOnDate: TQuery;
    QRateOnDateThisKurs: TFloatField;
    QRateOnDateThisDate: TDateField;
    QValutPeriod: TEtvQuery;
    QValutPeriodsDate: TDateField;
    QValutPeriodCurrency: TSmallintField;
    QValutPeriodCourse: TFloatField;
    QValutPeriodRelation: TSmallintField;
    QValutPeriodCurrencyN: TEtvLookField;
    TbValVerb: TEtvTable;
    TbValVerbDate: TDateField;
    TbValVerbDem: TFloatField;
    TbValVerbItl: TFloatField;
    TbValVerbChf: TFloatField;
    TbValVerbRur: TFloatField;
    TbValVerbUsa: TFloatField;
    TbValVerbXeu: TFloatField;
    QV2VThisCourse1: TFloatField;
    QV2VThisCourse2: TFloatField;
    procedure TbValCFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure TbValFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure TbValCEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbValEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbValVerbEditData(Sender: TObject; TypeShow: TTypeShow;
      FieldReturn: TFieldReturn);
  private
    u:array[1..999] of boolean;
  public
    Procedure PrintValut;
    Procedure ResetU;
    procedure RateOnDate(Currency:smallint; sDate:String;
                var Result:double; var DateKurs:string);
    procedure CalcCurrency(summa:double; Valut1,Valut2:smallint; ValutDate:String;
                var Result:double; var DateKurs:string; var aCourse1,aCourse2: double);
    { Public declarations }
  end;

var
  DMV: TDMV;

implementation

uses fBase,EtvDBFun,etvPrint,EtvView,Datamod1,FormVal,DiDateVa;

{$R *.DFM}

procedure TDMV.TbValCFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=(DataSet.Tag=0) or u[TbValCCurrency.Value];
end;

procedure TDMV.TbValFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  Accept:=(DataSet.Tag=0) or u[TbValCurrency.Value];
end;

procedure TDMV.ResetU;
var i:integer;
begin
  for i:=1 to 999 do u[i]:=false;
  if assigned(dm1.QSprVa) then begin
    dm1.QSprVa.first;
    while not DM1.QSprVa.EOF do begin
      if dm1.QSprVaTag.value=1 then u[dm1.QSprVaKod.value]:=true;
      DM1.QSprVa.Next;
    end;
  end;
end;

procedure TDMV.RateOnDate(Currency:smallint; sDate:String;
                var Result:double; var DateKurs:string);
begin
  qRateOnDate.Params.ParamByName('Currency').value:=Currency;
  qRateOnDate.Params.ParamByName('sDate').value:=sDate;
  qRateOnDate.Open;
  Result:=qRateOnDateThisKurs.value;
  DateKurs:=qRateOnDateThisDate.AsString;
  qRateOnDate.Close;
end;

procedure TDMV.CalcCurrency(Summa:double; Valut1,Valut2:smallint; ValutDate:String;
  var Result:double; var DateKurs:string; var aCourse1, aCourse2: double);
begin
  qV2V.Params.ParamByName('Currency1').value:=Valut1;
  qV2V.Params.ParamByName('Currency2').value:=Valut2;
  qV2V.Params.ParamByName('Summa').value:=Summa;
  qV2V.Params.ParamByName('sDate').value:=ValutDate;
  qV2V.Open;
  Result:=qV2VThisSumma.Value;
  DateKurs:=qV2VThisDate.AsString;
  aCourse1:=qV2VThisCourse1.Value;
  aCourse2:=qV2VThisCourse2.Value;
  qV2V.Close;
end;

procedure TDMV.TbValCEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormValut,TbValC,TypeShow,FieldReturn);
end;

procedure TDMV.TbValEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormValut,TbVal,TypeShow,FieldReturn);
end;

procedure TDMV.PrintValut;
var s:string;
begin
  if Not Assigned(DialDateVa) then
    DialDateVa:=TDialDateVa.Create(Application);
  if DialDateVa.ShowModal=mrOk then with DialDateVa do begin
    if EditDateBeg.Date=0 then QValutPeriod.Params.ParamByName('DateBe').Clear
    else QValutPeriod.Params.ParamByName('DateBe').Asstring:=EditDateBeg.Text;
    if EditDateEnd.Date=0 then QValutPeriod.Params.ParamByName('DateEn').Clear
    else QValutPeriod.Params.ParamByName('DateEn').Asstring:=EditDateEnd.Text;
    if DBLCVa.keyValue=null then QValutPeriod.Params.ParamByName('Currency').Clear
    else QValutPeriod.Params.ParamByName('Currency').value:=DBLCVa.KeyValue;
    QValutPeriod.Open;
    FormView:=TFormView.Create(Application);
    s:=' ”–—€ ¬¿Àﬁ“ (÷¡)';
    if EditDateBeg.Date<>0 then s:=s+' ÓÚ '+EditDateBeg.text;
    if EditDateEnd.Date<>0 then s:=s+' ‰Ó '+EditDateEnd.text;
    if DBLCVa.keyValue<>null then begin
      if dm1.QSprVa.Locate('Kod',DBLCVa.keyValue,[]) then
        s:=s+'  '+dm1.QSprVaName.Asstring
      else s:=s+'   Ó‰ ‚‡Î˛Ú˚ '+DBLCVa.Text;
      QValutPeriodCurrencyN.visible:=false;
    end else QValutPeriodCurrencyN.visible:=true;
    FormView.RichEdit.Lines.Add(s);
    FormView.RichEdit.Lines.Add('');
    DataSetPrintData(QValutPeriod,VisibleFields,FormView.RichEdit.Lines,0,true,'');
    FormView.Show;
    QValutPeriod.Close;
  end;
end;

procedure TDMV.TbValVerbEditData(Sender: TObject; TypeShow: TTypeShow;
  FieldReturn: TFieldReturn);
begin
  ToFormReport(DMV.TbValVerb);
end;

end.
