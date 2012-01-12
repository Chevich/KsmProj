unit DModCT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DatamodC, DBTables, EtvTable, Db, EtvDB, EtvLook;

type
  TDMCT = class(TDMC)
    BMPay: TBatchMove;
    BelText: TDatabase;
    QPayT: TEtvQuery;
    TbRstbackup1: TEtvTable;
    TbRstbackup1SDATE: TStringField;
    TbRstbackup1BCOUNT: TStringField;
    TbRstbackup1SUMMA: TStringField;
    TbRstbackup1CURRENCY: TStringField;
    TbRst: TEtvQuery;
    TbRstSDATE: TStringField;
    TbRstBCOUNT: TStringField;
    TbRstSUMMA: TStringField;
    TbRstCURRENCY: TStringField;
  private
    { Private declarations }
  public
    Procedure PeregonCountsFromBelBank;
  end;

var
  DMCT: TDMCT;

implementation

uses Datamod1, DatamVT;

{$R *.DFM}

Procedure TDMCT.PeregonCountsFromBelBank;
var DirSource,lBCountEnterprise:string;
    SearchRec:TSearchRec;
    Found:integer;
    MaxDate,FileDate:TDateTime;
    Exist:boolean;
    Q:TQuery;
    j:integer;
    Field:TField;

function CalcRate(aCurrency,aDate:string):double;
var lDateKurs:string;
begin
  Result:=1;
  if aCurrency<>'906' then
    dmvt.RateOnDate(StrToInt(aCurrency),aDate,Result,lDateKurs);
end;

begin
  DirSource:=Dm1.tbConfDirSourcePay.value;
  Found := FindFirst(DirSource+'\schema.ini', faArchive, SearchRec);
  Sysutils.FindClose(SearchRec);
  if Found=0 then begin
    q:=nil;
    try
      FileDate:=0;
      MaxDate:=0;
      Found := FindFirst(DirSource+'\*.out', faArchive, SearchRec);
      if Found=0 then begin
        TbPay.Readonly:=false;
        Q:=TQuery.Create(nil);
        Q.DataBaseName:=TbPay.DatabaseName;
      end;
      while Found = 0 do begin
        FileDate:=StrToDate(SearchRec.Name[1]+SearchRec.Name[2]+'.'+
                            SearchRec.Name[3]+SearchRec.Name[4]+'.'+
                            copy(SearchRec.Name,5,4));
        if MaxDate<FileDate then MaxDate:=FileDateToDateTime(SearchRec.Time);
        //MaxDate:=FileDate;
        DeleteFile(DirSource+'\out.txt');
        if FileExists(DirSource+'\out.txt') then begin
          ShowMessage('Файл '+DirSource+'\out.txt невозможно удалить');
          Abort;
        end;
        if not RenameFile(DirSource+'\'+SearchRec.Name, DirSource+'\out.txt') then
          ShowMessage(SearchRec.Name+' - не переименовывается - '+DirSource+'\out.txt');
        if Not(FileExists(DirSource+'\out.Txt')) then Abort;
        (* Удаление старых данных *)
        Q.Sql.Clear;
        Q.SQL.Add('delete '+TbPay.TableName+
          ' where (sDate='''+DateToStr(FileDate)+''') and (MfoEnterprise=''752'')');
        Q.ExecSQL;
        (* Перекачка *)

        {BMPay.Execute;}
        dm1.EtvDBGKSM.StartTransaction;
        try
          TbPay.Open;
          QPayT.Open;
          QPayT.First;
          while Not QPayT.EOF do begin
            TbPay.Insert;
            for j:=0 to QPayT.FieldCount-1 do begin
              Field:=TbPay.FindField(QPayT.Fields[j].FieldName);
              if Assigned(Field) then
                if QPayT.Fields[j].Value=null then
                  Field.Clear
                else Field.Value:=QPayT.Fields[j].Value;
            end;
            if TbPayCurrency.Value<>906 then
              TbPayBCountEnterprise.AsString:=TbPayBCountEnterprise.AsString+
                '/'+TbPayCurrency.AsString;
            TbPay.Post;
            QPayT.Next;
          end;
          QPayT.Close;
          TbPay.Close;
          dm1.EtvDBGKSM.Commit;
        except
          dm1.EtvDBGKSM.RollBack;
          Raise;
        end;
        Found := FindNext(SearchRec);
      end;
      Sysutils.FindClose(SearchRec);
      if dm1.TbConfDatePay.value<MaxDate then begin
        dm1.TbConf.Edit;
        dm1.TbConfDatePay.value:=MaxDate;
        dm1.TbConf.Post;
      end;
    except
      //ShowMessage('Ошибка при перекачке выписок из Беларусбанка')
      on E:Exception do ShowMessage(E.Message);
    end;
    if Assigned(Q) then Q.Free;
    if TbPay.Active then TbPay.Close;
    TbPay.Readonly:=true;
    (* Остатки на счетах *)
    try
      FileDate:=0;
      Found := FindFirst(DirSource+'\*.rst', faArchive, SearchRec);
      if Found=0 then begin
        Dm1.TbSprBCount.Close;
        DM1.TbSprBCount.ReadOnly:=false;
        Dm1.TbSprBCount.Open;
        TbCounts.ReadOnly:=false;
        TbCounts.CachedUpdates:=false;
        TbCounts.Open;
      end;

      while Found = 0 do begin
        FileDate:=StrToDate(SearchRec.Name[1]+SearchRec.Name[2]+'.'+
                            SearchRec.Name[3]+SearchRec.Name[4]+'.'+
                            copy(SearchRec.Name,5,4));
        DeleteFile(DirSource+'\rst.txt');
        if FileExists(DirSource+'\rst.txt') then Abort;
        if not RenameFile(DirSource+'\'+SearchRec.Name, DirSource+'\rst.txt') then
          ShowMessage(SearchRec.Name+' - не переименовывается - '+DirSource+'\rst.txt');
        if Not(FileExists(DirSource+'\rst.Txt')) then Abort;

        TbRst.Open;
        while Not TbRst.EOF do begin
          lBCountEnterprise:=TbRstBCOUNT.Value;
          if TbRstCurrency.Value<>'906' then
            lBCountEnterprise:=lBCountEnterprise+'/'+TbRstCurrency.AsString;
          if Dm1.TbSprBCount.Locate('BCOUNT',lBCountEnterprise,[]) then begin
            if dm1.TbSprBCountsDate.value<=FileDate then begin
              dm1.TbSprBCount.Edit;
              dm1.TbSprBCountsDate.value:=FileDate;
              dm1.TbSprBCountSumma.value:=TbRstSumma.AsFloat;
              dm1.TbSprBCountSummaBY.value:=TbRstSumma.AsFloat*
              CalcRate(TbRstCurrency.Value,dm1.TbSprBCountsDate.AsString);
              dm1.TbSprBCount.Post;
            end;
          end else showMessage('Счет не найден '+lBCountEnterprise);
          Exist:=TbCounts.Locate('MfoEnterprise;BCountEnterprise',
            varArrayof(['752',lBCountEnterprise]),[]);
          TbCounts.SetKey;
          TbCountsDate.value:=FileDate;
          TbCountsBCountEnterprise.value:=lBCountEnterprise;
          if Not TbCounts.GotoKey then begin
            TbCounts.Insert;
            TbCountsBCountEnterprise.value:=lBCountEnterprise;
            TbCountsDate.value:=FileDate;
          end else TbCounts.Edit;
          TbCountsMfoEnterprise.value:='752';
          TbCountsSumma.value:=TbRstSumma.AsFloat;
          TbCountsSummaBy.value:=TbRstSumma.AsFloat*
            CalcRate(TbRstCurrency.Value,TbCountsDate.AsString);
          TbCountsQuantityDok.Clear;
          with QPayTotal.SQL do begin
            while Count>1 do Delete(Count-1);
            Add('where (Summa>0) and (MfoEnterprise=''752'') and (BCountEnterprise='''+
                lBCountEnterprise+''') and (sDate='''+DateToStr(FileDate)+''')');
            QPayTotal.Open;
            TbCountsTurnoverK.value:=QPayTotalSummaDK.AsCurrency;
            TbCountsQuantityDok.value:=TbCountsQuantityDok.value+QPayTotalCountDoc.Value;
            QPayTotal.Close;
            while Count>1 do Delete(Count-1);
            Add('where (Summa<0) and (MfoEnterprise=''752'') and (BCountEnterprise='''+
                lBCountEnterprise+''') and (sDate='''+DateToStr(FileDate)+''')');
            QPayTotal.Open;
            TbCountsTurnoverD.value:=-QPayTotalSummaDK.AsCurrency;
            TbCountsQuantityDok.value:=TbCountsQuantityDok.value+QPayTotalCountDoc.Value;
            QPayTotal.Close;
          end;
          if (TbCountsQuantityDok.asInteger=0) and Exist then TbCounts.Cancel
          else TbCounts.Post;
          TbRst.Next;
        end;
        TbRst.Close;
        Found := FindNext(SearchRec);
      end;
      Sysutils.FindClose(SearchRec);
    except
      //ShowMessage('Ошибка при перекачке остатков на счетах');
      on E:Exception do ShowMessage(E.Message);
    end;
    if TbCounts.Active then TbCounts.close;
    if dm1.TbSprBCount.Active then DM1.TbSprBCount.close;
  end else ShowMessage('Message only for Lev! File "Schema.ini" is absent in '+DirSource);
end;

end.
