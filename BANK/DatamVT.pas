unit DatamVT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DatamodV, Db, EtvDB, DBTables, EtvTable, EtvForms, EtvLook;

type
  TDMVT = class(TDMV)
    TbValText: TEtvTable;
    TbValTextDATE: TStringField;
    TbValTextKURS: TStringField;
    TbValTextOWNER: TStringField;
    TbValTextRELATION: TStringField;
    TbValTextKODVA: TStringField;
    TbValTextPRIZNAK: TStringField;
    DSValText: TDataSource;
    BMValut: TBatchMove;
    DatabaseText: TDatabase;
    BMValutC: TBatchMove;
    TbValTextC: TEtvTable;
    TbValTextCDate: TStringField;
    TbValTextCKurs: TStringField;
    TbValTextCOwner: TStringField;
    TbValTextCRelation: TStringField;
    TbValTextCKodVa: TStringField;
    TbValTextCPriznak: TStringField;
    DSValTextC: TDataSource;
    BelText: TDatabase;
    QValT: TEtvQuery;
    BMVal: TBatchMove;
    QValTSDATE: TStringField;
    QValTCURRENCY: TStringField;
    QValTCOURSE: TStringField;
    QValTKodOwner: TIntegerField;
    QValTRelation: TIntegerField;
    QTempCur: TEtvQuery;
    QTempCurSDATE: TStringField;
    QTempCurCURRENCY: TStringField;
    QTempCurSCALE: TStringField;
    QTempCurCOURSE3: TStringField;
    QTempCurCOURSE: TStringField;
    QValC: TEtvQuery;
    procedure ShowMessage(Msg:String);
    procedure DM3Create(Sender: TObject);
    procedure DatabaseTextLogin(Database: TDatabase;
      LoginParams: TStrings);
  private
    { Private declarations }
  public
    { Public declarations }
    {procedure TXT2DB;}
    Procedure PeregonValutFromBelBank;
    Procedure PeregonTempFromBelBank;
  end;

var
  DMVT: TDMVT;

implementation
uses bde, Datamod1;
{$R *.DFM}

procedure TDMVT.ShowMessage(Msg:String);
begin
  writeln(Msg)
end;

Procedure TDMVT.PeregonTempFromBelBank;
var VaDirSource,DirSource:string;
    SearchRec:TSearchRec;
    Found:integer;
    MaxDate,FileDate:TDateTime;
    i:integer;
begin
  i:=0;
  DirSource:=Dm1.tbConfDirSourcePay.value;
  VaDirSource:=Dm1.tbConfDirSourceVa.value;
  Found := FindFirst(DirSource+'\schema.ini', faArchive, SearchRec);
  Sysutils.FindClose(SearchRec);
  if Found=0 then begin
    try
      MaxDate:=0;
      Found := FindFirst(VaDirSource+'\s8*.', faArchive, SearchRec);
{***** TEST }
{      ShowMessage(VaDirSource+' '+IntToStr(Found));}
{***** TEST }
      if Found=0 then begin
        TbVal.ReadOnly:=false;
        TbVal.Open;
      end;
      while Found = 0 do begin
        DeleteFile(DirSource+'\Cur.txt');
        if FileExists(DirSource+'\Cur.txt') then sysutils.Abort;
        if not RenameFile(VaDirSource+'\'+SearchRec.Name, DirSource+'\Cur.txt') then
          ShowMessage(SearchRec.Name+' - не переименовывается - '+DirSource+'\Cur.txt');
        if Not(FileExists(DirSource+'\Cur.Txt')) then sysutils.Abort;
        (* Удаление старых данных *)
        (* Нету *)
        (* Перекачка *)
        QTempCur.Open; //qtempcur это cur.txt
        QTempCur.First;
        while not QTempCur.EOF do begin
           // проверка на Кратность что б не нул
          if (not QTempCurScale.isNull) and (QTempCurScale.AsInteger<>0) then begin
          // а есть ли та валюта в спрвочнике ?
            if dm1.QSprVa.Locate('Kod',QTempCurCurrency.AsInteger,[]) then begin
              FileDate:=StrToDate(QTempCurSDate.AsString[7]+QTempCurSDate.AsString[8]+'.'+
                        QTempCurSDate.AsString[5]+QTempCurSDate.AsString[6]+'.'+
                        copy(QTempCurSDate.AsString,1,4));
                        // это вычисляем последнюю дату курса
              if FileDate>MaxDate then MaxDate:=FileDateToDateTime(SearchRec.Time);
              //MaxDate:=FileDate;
              // ? запись на дату/вылюта/вид курса
              if not TbVal.locate('sDate;Currency;KodOwner',
                 VarArrayOf([FileDate,QTempCurCurrency.AsInteger,1]),[]) then begin
                TbVal.Insert;
                TbValDate.Value:=FileDate;
                TbValCurrency.Value:=QTempCurCurrency.AsInteger;
                TbValCourse.Value:=QTempCurCourse.AsFloat/1000;
                TbValKodOwner.Value:=1;
                TbValRelation.Value:=QTempCurScale.AsInteger;
                TbVal.Post;
              end;
              // см пред.
              if not TbVal.locate('sDate;Currency;KodOwner',
                 VarArrayOf([FileDate,QTempCurCurrency.AsInteger,3]),[]) then begin
                TbVal.Insert;
                TbValDate.Value:=FileDate;
                TbValCurrency.Value:=QTempCurCurrency.AsInteger;
                TbValCourse.Value:=QTempCurCourse3.AsFloat/1000;
                TbValKodOwner.Value:=3;
                TbValRelation.Value:=QTempCurScale.AsInteger;
                TbVal.Post;
              end; //курсы официальный и НБ совпадают
              // ето понятно !!! хотя ее можно и вставить
            end else ShowMessage('Код валюты '+QTempCurCurrency.AsString+' не найден');
          end;
          inc(i);  //счетчик
          QTempCur.Next;
        end;
        QTempCur.Close;
        Found := FindNext(SearchRec);
      end;
      Sysutils.FindClose(SearchRec); //закончили поиск

      if not(dm1.TbConf.Active) then dm1.TbConf.Open;
      //меняем дату последней выписки
      if dm1.TbConfDateValut.value<MaxDate then begin
        dm1.TbConf.Edit;
        dm1.TbConfDateValut.value:=MaxDate;
        dm1.TbConf.Post;
      end;

    except
      ShowMessage(intTostr(i)+' Ошибка при перекачке временных курсов валют из Беларусбанка')
    end;
    if TbVal.Active then TbVal.Close;
    TbVal.Readonly:=true;
  end else ShowMessage('Message only for Lev! File "Schema.ini" is absent in '+DirSource);
end;

Procedure TDMVT.PeregonValutFromBelBank;
var DirSource:string;
    SearchRec:TSearchRec;
    Found:integer;
    MaxDate,FileDate:TDateTime;
    Q:TQuery;
begin
// временные
  PeregonTempFromBelBank;
  DirSource:=Dm1.tbConfDirSourcePay.value;
  Found := FindFirst(DirSource+'\schema.ini', faArchive, SearchRec);
  Sysutils.FindClose(SearchRec);
  if Found=0 then begin
    q:=nil;
    try
      MaxDate:=0;
      Found := FindFirst(DirSource+'\*.rat', faArchive, SearchRec);
      if Found=0 then begin
        TbVal.ReadOnly:=false;
        Q:=TQuery.Create(nil);
        Q.DataBaseName:=TbVal.DatabaseName;
      end;
      while Found = 0 do begin
        FileDate:=StrToDate(SearchRec.Name[1]+SearchRec.Name[2]+'.'+
                            SearchRec.Name[3]+SearchRec.Name[4]+'.'+
                            copy(SearchRec.Name,5,4));
        if MaxDate<FileDate then MaxDate:=FileDateToDateTime(SearchRec.Time);
        //MaxDate:=FileDate;
        DeleteFile(DirSource+'\Rat.txt');
        if FileExists(DirSource+'\Rat.txt') then sysutils.Abort;
        if not RenameFile(DirSource+'\'+SearchRec.Name, DirSource+'\Rat.txt') then
          ShowMessage(SearchRec.Name+' - не переименовывается - '+DirSource+'\Rat.txt');
        if Not(FileExists(DirSource+'\Rat.Txt')) then sysutils.Abort;
        (* Удаление старых данных *)
        Q.Sql.Clear;
        Q.SQL.Add('delete '+TbVal.TableName+
          ' where (sDate='''+DateToStr(FileDate)+''') and (KodOwner=1)');
        Q.ExecSQL;
        (* Перекачка *)
        BMVal.Execute;
        Found := FindNext(SearchRec);
      end;
      Sysutils.FindClose(SearchRec);
(*      try //чистим копию курсов
        TbValC.EmptyTable;
      except
        TbValC.open;
        TbValC.first;
        while not TbValC.EOF do TbValC.Delete;
        TbValC.Close;
      end;
      // и загоняем через эту пачку курсы за последнюю дату
      BMValutC.Execute;*)
      if not(dm1.TbConf.Active) then dm1.TbConf.Open;
      //обновляем дату последних курсов
      if dm1.TbConfDateValut.value<MaxDate then begin
        dm1.TbConf.Edit;
        dm1.TbConfDateValut.value:=MaxDate;
        dm1.TbConf.Post;
      end;
    except
      // ну а тут ошибка какаето
      ShowMessage('Ошибка при перекачке курсов валют из Беларусбанка')
    end;
    if Assigned(Q) then Q.Free;
    if TbVal.Active then TbVal.Close;
    TbVal.Readonly:=true;
  end else ShowMessage('Message only for Lev! File "Schema.ini" is absent in '+DirSource);
  // и домой
end;

(*procedure TDMVT.TXT2DB;
var f:file;
    {dbDes: DBDesc;}
    s:string;
    isOk:boolean;
    MaxDate:double;
function DateChange(s:string):string;
var i:smallint;
    {c:char;}
begin
  Result:=s;
  {if Length(s)=8 then begin
    c:=Result[1];
    Result[1]:=Result[4];
    Result[4]:=c;
    c:=Result[2];
    Result[2]:=Result[5];
    Result[5]:=c;
  end;}
  for i:=1 to length(s) do
    if Not(Result[i] in ['0'..'9']) then Result[i]:='.';
end;

begin  {Перекачка курсов валют }
  MaxDate:=0;
  isOk:=false;
  try
    TbValText.Open;
    TbValOwnerN.fieldKind:=fkCalculated;
    TbValVaN.fieldKind:=fkCalculated;
    TbVal.Open;
    while Not TbValText.EOF do begin
      TbVal.Setkey;
      TbValDate.AsString:=DateChange(TbValTextDate.Value);
      TbValKodOwner.Asstring:=TbValTextPriznak.Value;
      TbValKodVa.AsString:=TbValTextKodVa.Value;
      if TbVal.GotoKey then TbVal.Edit
      else begin
        TbVal.Insert;
        TbValDate.AsString:=DateChange(TbValTextDate.Value);
        TbValKodOwner.AsString:=TbValTextPriznak.Value;
        TbValKodVa.AsString:=TbValTextKodVa.Value;
      end;
      TbValRelation.AsString:=TbValTextRelation.Value;
      TbValKurs.AsString:=TbValTextKurs.value;
      TbVal.Post;
      if MaxDate<TbValDate.value then MaxDate:=TbValDate.value;
      {ShowMessage(TbValDate.AsString);}
      TbValText.Next;
    end;
    isOk:=true;
  finally
    if not(dm1.TbConf.Active) then dm1.TbConf.Open;
    if dm1.TbConfDateValut.value<MaxDate then begin
      dm1.TbConf.Edit;
      dm1.TbConfDateValut.value:=MaxDate;
      dm1.TbConf.Post;
    end;
    TbVal.Close;
    TbValText.Close;
    if Not isOk then
      ShowMessage('Исключительная ситуация при обработке курсов валют (история)');
  end;

 { Check(DbiGetDatabaseDesc(PChar(DataBaseText.AliasName), @dbDes));
  s:=dbDes.szPhyName;}
  {ShowMessage(s);}
  s:=dm1.TbConfDirText.Value;
  assignfile(f,s+'\'+TbValText.TableName);
  rewrite(f);
  CloseFile(f);

  try
    TbValC.EmptyTable;
  except
    TbValC.open;
    TbValC.first;
    while not TbValC.EOF do TbValC.Delete;
    TbValC.Close;
  end;
  BMValutC.Execute;
end;*)

procedure TDMVT.DM3Create(Sender: TObject);
begin
  inherited;
  DatabaseText.connected:=true;
end;

procedure TDMVT.DatabaseTextLogin(Database: TDatabase;
  LoginParams: TStrings);
begin
  inherited;
  LoginParams.values['User Name']:='';
  LoginParams.values['Password']:='';
end;

end.
