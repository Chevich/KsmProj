unit datamod2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBTables, EtvDB, EtvTable, EtvForms;
       
type
  TDM2 = class(TDataModule)
    TbKart: TEtvTable;
    DSKart: TDataSource;
    QKartCurrent: TQuery;
    TbKartAutoInc: TAutoIncField;
    BMKart: TBatchMove;
    QSum: TQuery;
    DSQSum: TDataSource;
    QTotal: TQuery;
    TbKartA: TEtvTable;
    DSKartA: TDataSource;
    TbKartADateOpl: TDateField;
    TbKartASumma: TFloatField;
    TbKartASummaGreen: TFloatField;
    EtvDMInfo1: TEtvDMInfo;
    TbKartOrgN: TStringField;
    QSumSumTotal: TFloatField;
    QKartA: TEtvQuery;
    QKartADateOpl: TDateField;
    QKartASumma: TFloatField;
    QKartASummaGreen: TFloatField;
    QTotalAllSumma: TFloatField;
    TbKartNKart: TStringField;
    TbKartBCountEnterprise: TStringField;
    TbKartsDate: TDateField;
    TbKartSumma: TFloatField;
    TbKartNDoc: TStringField;
    TbKartMFO: TStringField;
    TbKartBCount: TStringField;
    procedure TbKartEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure TbKartCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    {procedure Dbf2DB;}
    procedure PeregonFromBelText(AFileSource:string);
    { Public declarations }
  end;

var DM2: TDM2;

implementation
uses datamod1, FormKart,etvPas, DatamVT;
{$R *.DFM}

procedure TDM2.PeregonFromBelText(AFileSource:string);
var Kurs:double;
    MaxFile,sDate,DirSource:string;
    SearchRec:TSearchRec;
    Found:integer;
    MaxDate,FileDate:TDateTime;
begin  (*Перекачка картотеки *)

  DirSource:=Dm1.tbConfDirSourcePay.value;
  Found := FindFirst(DirSource+'\schema.ini', faArchive, SearchRec);
  Sysutils.FindClose(SearchRec);
  if Found=0 then begin
    try
      if AFileSource='' then begin //при неуказании ищем сами
        MaxDate:=0;
        MaxFile:='';
        Found := FindFirst(DirSource+'\*.vba', faArchive, SearchRec);
        while Found = 0 do begin //ищем последнюю выписку
          FileDate:=StrToDate(SearchRec.Name[1]+SearchRec.Name[2]+'.'+
                              SearchRec.Name[3]+SearchRec.Name[4]+'.'+
                              copy(SearchRec.Name,5,4));
          if MaxDate<FileDate then begin
            //MaxDate:=FileDate;
            MaxDate:=FileDateToDateTime(SearchRec.Time);
            MaxFile:=SearchRec.Name;
          end;
          Found := FindNext(SearchRec);
        end;                    //нашли последнюю
        Sysutils.FindClose(SearchRec);
      end else begin
        MaxFile:=AFileSource;
        MaxDate:=StrToDate(AFileSource[1]+AFileSource[2]+'.'+
                              AFileSource[3]+AFileSource[4]+'.'+
                              copy(AFileSource,5,4));
      end;
      if MaxDate>0 then begin //когда определились, то работаем
        DeleteFile(DirSource+'\vba.txt');
        if FileExists(DirSource+'\vba.txt') then begin
          ShowMessage('Невозможно удалить старый Файл '+DirSource+'\vba.txt');
          Abort;
        end; //удавили старый файл и делаем копию выписки
        CopyFile(PChar(DirSource+'\'+MaxFile),PChar(DirSource+'\vba.txt'),false);
        if Not FileExists(DirSource+'\vba.txt') then begin
          ShowMessage('Новый файл '+DirSource+'\vba.txt не создан');
          Abort;
        end;
        // хороше подумав лучше наверное обрабатывать все файлишки, которые попадются
        (* Удаление старых данных *)
        TbKart.CachedUpdates:=false;
        TbKart.Readonly:=false;
        try
          TbKart.EmptyTable;
        Except
          TbKart.Open;
          TbKart.First;
          while not TbKart.EOF do TbKart.Delete;
          TbKart.Close;
        end;
        (* Перекачка *)
        BMKart.Execute;
      end;
    except
      ShowMessage('Ошибка при перекачке картотеки')
    end;
    TbKart.Readonly:=true;

    if TbKartA.active then TbKartA.Close;
    TbKartA.ReadOnly:=false;
    TbKartA.Open;
    QTotal.Open;
    TbKartA.SetKey;
    TbKartADateOpl.Value:=MaxDate;
    if TbKartA.GotoKey then TbKartA.Edit
    else TbKartA.Insert;
    TbKartADateOpl.Value:=MaxDate;
    TbKartASumma.value:=QTotalAllSumma.value;
    dmvt.RateOnDate(1,TbKartADateOpl.AsString,Kurs,sDate); //рассчитали курс на дату
    if Kurs>0 then TbKartASummaGreen.value:=TbKartASumma.value/Kurs
    else TbKartASummaGreen.value:=0;
    TbKartA.Post;
    TbKartA.Close; //записали итог на дату

    if not(dm1.TbConf.Active) then dm1.TbConf.Open;
    if dm1.TbConfDateKart.value<MaxDate then begin
      dm1.TbConf.Edit;
      dm1.TbConfDateKart.value:=MaxDate;
      dm1.TbConf.Post;
    end;
    QTotal.Close;  //и дату на морде исправили
  end else ShowMessage('Message only for Lev! File "Schema.ini" is absent in '+DirSource);
end;


(*
procedure TDM2.Dbf2DB;
var Kurs:double;
    sDate:string;
{var f:file of char;
    dbDes: DBDesc;
    s:string;}
begin  {Перекачка картотеки}

{  Check(DbiGetDatabaseDesc(PChar(TbKart.DataBaseName), @dbDes));
  s:=dbDes.szPhyName;
  ShowMessage(s);
  assignfile(f,s+'\Kart.Cur');
  { I-}
  {Reset(f);
  if IOResult=0 then begin
    s:='';
    while not EOF(f) do begin
      read
    s:=s+c
    end;
  end;
  { I+}

  TbKart.CachedUpdates:=false;
  try
    TbKart.EmptyTable;
  Except
    TbKart.Open;
    TbKart.First;
    while not TbKart.EOF do TbKart.Delete;
    TbKart.Close;
  end;
  BMKart.Execute;

  if tbKartA.active then TbKartA.Close;
  {QTotal.prepare;}
  TbKartA.ReadOnly:=false;
  TbKartA.Open;
  QTotal.Open;
  TbKartA.SetKey;
  TbKartADateOpl.Value:=QTotalMaxDate.value;
  if TbKartA.GotoKey then TbKartA.Edit
  else TbKartA.Insert;
  TbKartADateOpl.Value:=QTotalMaxDate.value;
  TbKartASumma.value:=QTotalAllSumma.value;
  dmvt.RateOnDate(1,QTotalMaxDate.AsString,Kurs,sDate);
  if Kurs>0 then TbKartASummaGreen.value:=TbKartASumma.value/Kurs
  else TbKartASummaGreen.value:=0;
  TbKartA.Post;
  if not(dm1.TbConf.Active) then dm1.TbConf.Open;
  dm1.TbConf.Edit;
  dm1.TbConfDateKart.value:=QTotalMaxDate.value;
  dm1.TbConf.Post;
  QTotal.Close;
  TbKartA.Close;
end; *)

procedure TDM2.TbKartEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormKartoteka,TbKart,TypeShow,FieldReturn);
end;

procedure TDM2.TbKartCalcFields(DataSet: TDataSet);
begin
  if (DataSet.FieldByName('MFO').value<>'') and (DataSet.FieldByName('BCount').value<>'') then begin
    va[0]:=DataSet.FieldByName('MFO').value;
    va[1]:=DataSet.FieldByName('BCount').value;
    if dm1.QOrg.locate('kodOtd;bCount',Va,[]) then
      DataSet.FieldByName('OrgN').value:=dm1.QOrgOrg.asString+' '+dm1.QOrgName.value;
  end;
end;

end.
