unit DatamodC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, EtvTable, EtvDB, EtvForms, EtvLook;

const LCount=13; (* количество знаков в банковском счете *)
      MaxPosDebet=57; (* Max правал позиция, где должен кончаться дебет *)
      MaxPosNB=36; (* Max правал позиция, где должен кончаться вид платежа в бюджет *)
      LicCount='‹ЁжҐў®©'; (* Лицевой *)
      LicCountVa='‹€–…‚Ћ‰'; (* ЛИЦЕВОЙ *)
      BegRest='‚е®¤пйЁ©'; (* Входящий*)
      EndRest='€бе®¤пйЁ©'; (* Исходящий *)
type
  TDMC = class(TDataModule)
    TbPay: TEtvTable;                
    TbPayDate: TDateField;
    TbPayRodOper: TSmallintField;
    TbPayMFO: TStringField;
    TbPayNDok: TStringField;
    TbPayKodNP: TIntegerField;
    TbPaySumma: TFloatField;
    TbPayRodOperN: TEtvLookField;
    TbPayKodNPN: TEtvLookField;
    EtvDMInfo1: TEtvDMInfo;
    TbCounts: TEtvTable;
    TbCountsDate: TDateField;
    TbCountsSumma: TFloatField;
    TbPayBCountEnterprise: TStringField;
    TbPayAutoinc: TAutoIncField;
    TbPaySummaD: TCurrencyField;
    TbPaySummaK: TCurrencyField;
    TbCountsBCountEnterprise: TStringField;
    DSCounts: TDataSource;
    TbCountsTurnoverD: TFloatField;
    TbCountsTurnoverK: TFloatField;
    TbCountsQuantityDok: TSmallintField;
    TbCountsSummaBY: TFloatField;
    TbPaySummaBY: TFloatField;
    TbPayOrgN: TStringField;
    QCounts: TEtvQuery;
    QCountsBCountEnterprise: TStringField;
    QCountssDate: TDateField;
    QCountsSumma: TFloatField;
    QCountsSummaBY: TFloatField;
    QCountsTurnoverD: TFloatField;
    QCountsTurnoverK: TFloatField;
    QCountsQuantityDok: TSmallintField;
    QCountsSummaK: TCurrencyField;
    QCountsSummaD: TCurrencyField;
    QPayTotal: TEtvQuery;
    QPayTotalSummaDK: TFloatField;
    QPayOnDate: TEtvQuery;
    QPayOnDateBCountEnterprise: TStringField;
    QPayOnDatesDate: TDateField;
    QPayOnDateRodOper: TSmallintField;
    QPayOnDateMFO: TStringField;
    QPayOnDateBCount: TStringField;
    QPayOnDateNDok: TStringField;
    QPayOnDateKodNP: TIntegerField;
    QPayOnDateSumma: TFloatField;
    QPayOnDateSummaD: TFloatField;
    QPayOnDateSummaK: TFloatField;
    TbPayCurrency: TSmallintField;
    TbPayCourse: TFloatField;
    TbPayDestination: TStringField;
    TbPayMfoEnterprise: TStringField;
    TbCountsMfoEnterprise: TStringField;
    QCountsMfoEnterprise: TStringField;
    QPayTotalCountDoc: TIntegerField;
    TbPayBCount: TStringField;
    TbPayCross: TCurrencyField;
    TbPayCrossDate: TStringField;
    TbPayBankN: TEtvLookField;
    TbPayCourseUSD: TFloatField;
    TbPayCrossCourse: TFloatField;
    procedure TbPayCalcFields(DataSet: TDataSet);
    procedure TbPayEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
    procedure QCountsCalcFields(DataSet: TDataSet);
    procedure QPayOnDateCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    Procedure PeregonCounts(aDirName:string);
    Procedure PeregonCountsVa(aFileName:string);
    Procedure PrintPayOnDate(sDate:string);
  end;

var
  DMC: TDMC;

implementation
uses EtvDBFun,EtvPas,datamod1,Pay, TrLabel, EtvPrint,EtvView, DatamodV;
{$R *.DFM}

type
  ECountsInvalid = class (EInOutError)
end;

procedure ReadInt(var Str:string; s:string; var i:smallint);
begin
  Str:='';
  while s[i]=' ' do inc(i);
  while (s[i] in ['0'..'9']) do begin
    Str:=Str+s[i];
    inc(i);
  end;
  if str='' then str:='0';
end;

procedure ReadFloat(var Str:string; s:string; var i:smallint);
begin
  Str:='';
  while s[i]=' ' do inc(i);
  while (i<=Length(s)) and (s[i] in ['0'..'9','.']) do begin
    Str:=Str+s[i];
    inc(i);
  end;
  if str='' then str:='0';
end;

procedure ReadFloatM(var Str:string; s:string; var i:smallint);
begin
  Str:='';
  while s[i]=' ' do inc(i);
  while (i<=Length(s)) and (s[i] in ['-','0'..'9','.']) do begin
    Str:=Str+s[i];
    inc(i);
  end;
  if str='' then str:='0';
end;

procedure ToInt(s:string; var i:smallint);
begin
  while not(s[i] in ['0'..'9']) do inc(i);
end;
procedure ToIntM(s:string; var i:smallint);
begin
  while not(s[i] in ['-','0'..'9']) do inc(i);
end;

Procedure TDMC.PeregonCountsVa(aFileName:string);
var Str,NDok,CountDok,DirSource,
    s,CurCount,filename:string;
    LastDate,CurDate,NewDate:TDateTime;
    NewSumma,NewSummaBy,SummaDok,SummaDokBy,AllDebet,AllKredit,LastSumma,LastSummaBy:double;
    kolDok,i:smallint;
    Found:integer;
    SearchRec:TSearchRec;
    f:TextFile;
    NumberOfLine:smallint;
    fileTime:integer;
  procedure ToRaise(str:string);
  begin
    raise ECountsInvalid.Create(str+' Файл '+FileName+' строка №'+intToStr(NumberOfLine));
  end;

  procedure NextLine;
  begin
    if Not EOF(f) then ReadLn(f,s)
    else ToRaise('Обрыв');
    Inc(NumberOfLine);
    i:=1;
  end;

  procedure ReadCount(var Str:string);
  var Exist:boolean;
  begin
    Str:='';
    Exist:=false;
    while s[i]=' ' do inc(i);
    while (s[i] in ['0'..'9','/']) do begin
      if s[i]='/' then Exist:=true;
      if Not Exist then Str:=Str+s[i];
      inc(i);
    end;
  end;

  procedure ReadDate(Var ADate:TDateTime);
  var u:string[8];
      j:smallint;
  begin
    u:=Copy(s,i,8);
    {u:=copy(u,4,3)+copy(u,1,3)+copy(u,7,2);}
    for j:=1 to length(u) do if u[j]='/' then u[j]:='.';
    ADate:=StrToDate(u);

    {ADate:=StrToDate(Copy(s,i,8));}
    i:=i+8;
  end;


  procedure AfterSeparate;
  begin
    while not(s[i] in ['|']) do inc(i);
    inc(i);
  end;

begin
  DirSource:=Dm1.tbConfDirSourcePayVa.value;

  Dm1.TbSprBCount.Close;
  DM1.TbSprBCount.ReadOnly:=false;
  Dm1.TbSprBCount.Open;
  TbPay.IndexName:='Pay_MainSumma';
  TbPay.ReadOnly:=false;
  TbPay.CachedUpdates:=false;
  TbPay.Open;
  TbCounts.ReadOnly:=false;
  TbCounts.CachedUpdates:=false;
  TbCounts.Open;
  (* Выбор файла из каталога *)
  try
    if aFileName='' then begin
      FileTime:=0;
      FileName:='';
      Found := FindFirst(DirSource+'\val_vyp.*', faArchive, SearchRec);
      while Found = 0 do begin
        if SearchRec.time>FileTime then begin
          FileName:=DirSource+'\'+SearchRec.Name;
          FileTime:=SearchRec.time;
        end;
        Found := FindNext(SearchRec);
      end;
      Sysutils.FindClose(SearchRec);
    end else FileName:=DirSource+'\'+aFileName;
    (* Обработка файла*)
    if fileName<>'' then begin
      (* перекодировка файла *)
      if CreateEtvProcess(ExtractFilePath(ParamStr(0))+
        '\pfm /u'+FileName+' /w'+DM1.TbConfLastDir.value,
        'Перекодировка валютных выписок',true,false)=0 then begin
        FormLabel.Update;
        AssignFile(F,DM1.TbConfLastDir.value+'\val_216.lic');
        {$I-}
        Reset(F);
        {$I+}
        if IOResult=0 then begin
          NumberOfLine:=0;
          while Not Eof(f) do begin
            NextLine;
            if Pos(LicCountVa,s)=0 then Continue;  (*Лицевой*)
            (* Обработка строки 'Лицевой по ...' *)
            (* Счет *)
            ToInt(s,i);
            ReadCount(CurCount);
            if not Dm1.TbSprBCount.Locate('BCount',CurCount,[]) then
              ToRaise('Счет №'+CurCount+' у предприятия отсутствует');
            (* Дата *)
            ToInt(s,i);
            ReadDate(CurDate);
            (*Удаление старой версии этого дня по этому счету *)
            TbPay.Filter:='(sDate='''+DateToStr(CurDate)+''') and (BCountEnterprise='+CurCount+')';
            TbPay.Filtered:=true;
            TbPay.First;
            while Not TbPay.EOF do
              TbPay.Delete;
            TbPay.Filtered:=False;

            (* операции *)
            KolDok:=0;
            AllDebet:=0;
            AllKredit:=0;
            NextLine;
            while (Pos('------',s)=0) do NextLine;
            NextLine;
            while (Pos('------',s)=0) do NextLine;
            NextLine;
            (* Дата вход. остатка *)
            ToInt(s,i);
            ReadDate(LastDate);
            LastDate:=LastDate-1;
            (* Сумма остатка *)
            ToIntM(s,i);
            ReadFloatM(Str,s,i);
            LastSumma:=StrToFloat(Str);
            (* Сумма остатка в рублях*)
            ToIntM(s,i);
            ReadFloatM(Str,s,i);
            LastSummaBy:=StrToFloat(Str);

            (*if need then save record to Counts*)
            TbCounts.SetKey;
            TbCountsDate.value:=LastDate;
            TbCountsBCountEnterprise.value:=CurCount;
            if Not TbCounts.GotoKey then begin
              ShowMessage('Счет №'+CurCount+' сумма '+FloatToStr(LastSumma)+' за '+DateToStr(LastDate)+' отсутствовала');
              TbCounts.Insert;
              TbCountsMfoEnterprise.value:='335';
              TbCountsBCountEnterprise.value:=CurCount;
              TbCountsDate.value:=LastDate;
              TbCountsSumma.value:=LastSumma;
              TbCountsSummaBy.value:=LastSummaBy;
              TbCountsTurnoverD.Clear;
              TbCountsTurnoverK.Clear;
              TbCountsQuantityDok.Clear;
              TbCounts.Post;
            end else if Abs(TbCountsSumma.value-LastSumma)>=1 then begin
              ShowMessage('Счет №'+CurCount+' '+
                DateToStr(LastDate)+' было '+FloatToStr(TbCountsSumma.value)+
                ' станет '+FloatToStr(LastSumma)+' Разность '+
                FloatTostr(Abs(TbCountsSumma.value-LastSumma)));
              TbCounts.Edit;
              TbCountsSumma.value:=LastSumma;
              TbCountsSummaBY.value:=LastSummaBY;
              TbCountsTurnoverD.Clear;
              TbCountsTurnoverK.Clear;
              TbCountsQuantityDok.Clear;
              TbCounts.Post;
            end;
            NextLine;
            while Pos('------',s)=0 do NextLine;
            NextLine;
            (* Обрабатываем документы *)
            while Pos('------',s)=0 do begin
              Inc(KolDok);
              AfterSeparate;
              ReadInt(Str,s,i); (* номер операции *)
              AfterSeparate;
              ReadInt(NDok,s,i);
              AfterSeparate;
              (* Дату не считываем *)
              AfterSeparate;
              ReadCount(CountDok);
              AfterSeparate;
              ReadFloat(Str,s,i);
              if StrToFloat(Str)>0.01 then begin
                SummaDok:=-StrToFloat(Str);
                AfterSeparate;
                AfterSeparate;
              end else begin
                AfterSeparate;
                ReadFloat(Str,s,i);
                SummaDok:=StrToFloat(Str);
                AfterSeparate;
              end;
              if SummaDok<0 then AllDebet:=AllDebet-SummaDok
              else AllKredit:=AllKredit+SummaDok;
              ReadFloatM(Str,s,i);
              SummaDokBy:=StrToFloat(Str);
                (* Запись документа в базу *)
              TbPay.Insert;
              TbPayMfoEnterprise.value:='335';
              TbPayBCountEnterprise.value:=CurCount;
              TbPayDate.Value:=CurDate;
              TbPayBCount.Value:=CountDok;
              TbPayNDok.Value:=NDok;
              TbPaySumma.Value:=SummaDok;
              TbPaySummaBy.Value:=SummaDokBy;
              TbPay.Post;
              NextLine;
            end;
            NextLine;  (* Сальдо на конец дня *)
            ToInt(s,i);
            ReadDate(NewDate);
            if CurDate<>NewDate then
              ToRaise('Дата счета '+DateToStr(CurDate)+'<>Дата на конец дня'+DateToStr(NewDate));
            ToInt(s,i);
            ReadFloat(Str,s,i);
            if Abs(AllDebet-StrToFloat(Str))>=1 then
              ToRaise('Дебет '+FloatToStr(AllDebet)+'<>'+Str);
            ToInt(s,i);
            ReadFloat(Str,s,i);
            if Abs(AllKredit-StrToFloat(Str))>=1 then
              ToRaise('Кредит '+FloatToStr(AllKredit)+'<>'+Str);
            ToIntM(s,i);
            ReadFloatM(Str,s,i);
            NewSumma:=StrToFloat(Str);
            if Abs(LastSumma-AllDebet+AllKredit-NewSumma)>=1 then
              ToRaise('Итоговые суммы '+FloatToStr(NewSumma)+'<>'+FloatToStr(LastSumma-AllDebet+AllKredit));
            ToIntM(s,i);
            ReadFloatM(Str,s,i);
            NewSummaBy:=StrToFloat(Str);

            (*if need then save record to Counts*)
            TbCounts.SetKey;
            TbCountsDate.value:=NewDate;
            TbCountsBCountEnterprise.value:=CurCount;
            if Not TbCounts.GotoKey then begin
              TbCounts.insert;
              TbCountsMfoEnterprise.value:='335';
              TbCountsBCountEnterprise.value:=CurCount;
              TbCountsDate.value:=NewDate;
              TbCountsSumma.value:=NewSumma;
              TbCountsSummaBy.value:=NewSummaBy;
              if KolDok<>0 then begin
                TbCountsTurnoverD.value:=AllDebet;
                TbCountsTurnoverK.value:=AllKredit;
                TbCountsQuantityDok.value:=kolDok;
              end else begin
                TbCountsTurnoverD.Clear;
                TbCountsTurnoverK.Clear;
                TbCountsQuantityDok.Clear;
              end;
              TbCounts.Post;
            end else if (TbCountsSumma.value<>NewSumma) or
                        (TbCountsSummaBy.value<>NewSummaBy) or
                        (TbCountsTurnoverD.value<>AllDebet) or
                        (TbCountsTurnoverK.value<>AllKredit) or
                        (TbCountsQuantityDok.value<>kolDok) then begin
              TbCounts.Edit;
              TbCountsSumma.value:=NewSumma;
              TbCountsSummaBy.value:=NewSummaBy;
              if KolDok<>0 then begin
                TbCountsTurnoverD.value:=AllDebet;
                TbCountsTurnoverK.value:=AllKredit;
                TbCountsQuantityDok.value:=kolDok;
              end else begin
                TbCountsTurnoverD.Clear;
                TbCountsTurnoverK.Clear;
                TbCountsQuantityDok.Clear;
              end;
              TbCounts.Post;
            end;
            if Dm1.TbSprBCount.Locate('BCount',CurCount,[]) then begin
              if dm1.TbSprBCountsDate.value<=NewDate then begin
                dm1.TbSprBCount.Edit;
                dm1.TbSprBCountsDate.value:=NewDate;
                dm1.TbSprBCountSumma.value:=NewSumma;
                dm1.TbSprBCountSummaBY.value:=NewSummaBY;
                dm1.TbSprBCount.Post;
              end;
            end else ToRaise('Счет №'+CurCount+' ранее найденный повторно не найден!!!');
            NextLine;
          end;
          CloseFile(f);
        end else ShowMessage('После раскодировки не найден текстовый файл,'+
                         #10+'содержащий валютные выписки - '+
                         DM1.TbConfLastDir.value+'\val_216.lic');
      end;
    end;
  finally
    TbCounts.close;
    TbPay.close;
    DM1.TbSprBCount.close;
  end;
end;

Procedure TDMC.PeregonCounts(aDirName:string);
var Str,NDok,CountDok,MFO,DirSource,
    KolDokText,s,CurCount,filename:string;
    UDate,LastDate,ControlDate,FileDate,CurDate,NewDate:TDateTime;
    NewSumma,SummaDok,AllDebet,AllKredit,LastSumma:double;
    j,NB,KolCount,KolCountText,TD,kolDok,i:smallint;
    Found:integer;
    SearchRec:TSearchRec;
    f:TextFile;
    FileHour,FileMinute:byte;
    mainCycle,NumberOfLine:smallint;
    Year, Month, Day: Word;

  procedure ToRaise(str:string);
  begin
    raise ECountsInvalid.Create(str+' Файл '+FileName+' строка №'+intToStr(NumberOfLine));
  end;

  procedure NextLine;
  begin
    if Not EOF(f) then ReadLn(f,s)
    else ToRaise('Обрыв');
    Inc(NumberOfLine);
    i:=1;
    if Pos(LicCount,s)>0 then Inc(KolCountText);
  end;

  procedure ReadCount(var Str:string);
  begin
    Str:='';
    while (s[i] in ['0'..'9','-']) do begin
      if s[i] in ['0'..'9'] then Str:=Str+s[i];
      inc(i);
    end;
    if length(Str)<>LCount then
    ToRaise('Неправильный N счета '+Str);
  end;

  procedure ReadDate(Var ADate:TDateTime);
  var u:string[8];
      j:smallint;
  begin
    u:=Copy(s,i,8);
    u:=copy(u,4,3)+copy(u,1,3)+copy(u,7,2);
    for j:=1 to length(u) do if u[j]='.' then u[j]:='/';
    ADate:=StrToDate(u);

    {ADate:=StrToDate(Copy(s,i,8));}
    i:=i+8;
  end;

begin
  if aDirName='' then begin
    DecodeDate(Now, Year, Month, Day);
    s:=NForm(IntToStr(Day),2)+NForm(IntToStr(Month),2)+NForm(IntToStr(Year mod 100),2);
  end else s:=aDirName;
  DirSource:=Dm1.tbConfDirSourcePay.value+'\';
  for i:=1 to length(s) do if s[i] in ['0'..'9'] then
    DirSource:=DirSource+s[i];

  {ShowMessage(DirSource);}

  (* Выбор файла из каталога *)
  ControlDate:=0;
  Dm1.TbSprBCount.Close;
  DM1.TbSprBCount.ReadOnly:=false;
  Dm1.TbSprBCount.Open;

  TbPay.IndexName:='Pay_MainSumma';
  TbPay.ReadOnly:=false;
  TbPay.CachedUpdates:=false;
  TbPay.Open;

  TbCounts.ReadOnly:=false;
  TbCounts.CachedUpdates:=false;
  TbCounts.Open;
  try
    repeat
      FileHour:=0;
      FileMinute:=0;
      FileName:='';
      FileDate:=0;
      Found := FindFirst(DirSource+'\*.*', faArchive, SearchRec);
      while Found = 0 do begin
        AssignFile(F,DirSource+'\'+SearchRec.Name);
        Reset(F);
        NextLine;
        ReadDate(UDate);
        if (Pos('/5/',s)>0) and
           ((UDate<=FileDate) or (FileDate=0)) and
           (UDate>ControlDate) and
           ((strToInt(copy(s,10,2))>FileHour) or
            ((strToInt(copy(s,10,2))=FileHour) and
             (strToInt(copy(s,13,2))>FileMinute))) then begin
          FileName:=DirSource+'\'+SearchRec.Name;
          FileHour:=strToInt(copy(s,10,2));
          FileMinute:=strToInt(copy(s,13,2));
          FileDate:=UDate;
        end;
        CloseFile(F);
        Found := FindNext(SearchRec);
      end;
      sysutils.FindClose(SearchRec);
      ControlDate:=fileDate;

      (* Обработка файла*)
      if fileName<>'' then begin
        {ShowMessage(FileName+' '+DateToStr(ControlDate));}
        AssignFile(F,FileName);
        for MainCycle:=1 to 2 do begin
          KolCount:=0;
          KolCountText:=0;
          NumberOfLine:=0;
          Reset(F);
          while Not Eof(f) do begin
            NextLine;
            if Pos(LicCount,s)=0 then Continue;  (*Лицевой*)
            (* Обработка строки 'Лицевой по ...' *)
            (* Счет *)
            Inc(KolCount);
            ToInt(s,i);
            ReadCount(CurCount);
            if not Dm1.TbSprBCount.Locate('BCount',CurCount,[]) then
              ToRaise('Счет №'+CurCount+' у предприятия отсутствует');
            (* Дата *)
            ToInt(s,i);
            ReadDate(CurDate);

            (*Удаление старой версии этого дня по этому счету *)
            if MainCycle=2 then begin
              TbPay.Filter:='(sDate='''+DateToStr(CurDate)+''') and (BCountEnterprise='+CurCount+')';
              TbPay.Filtered:=true;
              TbPay.First;
              while Not TbPay.EOF do
                TbPay.Delete;
              TbPay.Filtered:=False;
            end;

            (* Проверяем были ли операции *)
            KolDok:=0;
            AllDebet:=0;
            AllKredit:=0;
            NextLine;
            while (Pos(BegRest,s)=0) and (Pos(EndRest,s)=0) do
              NextLine;
            (* Входящий остаток*)
            if Pos(BegRest,s)<>0 then begin

              (* Дата вход. остатка *)
              ToInt(s,i);
              ReadDate(LastDate);
              (* Сумма остатка *)
              ToInt(s,i);
              ReadFloat(Str,s,i);
              LastSumma:=StrToFloat(Str);
              if i<=MaxPosDebet then LastSumma:=-LastSumma;

              (*if need then save record to Counts*)
              if MainCycle=2 then begin
                TbCounts.SetKey;
                TbCountsDate.value:=LastDate;
                TbCountsBCountEnterprise.value:=CurCount;
                if Not TbCounts.GotoKey then begin
                  ShowMessage('Счет №'+CurCount+' сумма '+FloatToStr(LastSumma)+' за '+DateToStr(LastDate)+' отсутствовала');
                  TbCounts.insert;
                  TbCountsMfoEnterprise.value:=CurCount;
                  TbCountsBCountEnterprise.value:=CurCount;
                  TbCountsDate.value:=LastDate;
                  TbCountsSumma.value:=LastSumma;
                  TbCountsTurnoverD.Clear;
                  TbCountsTurnoverK.Clear;
                  TbCountsQuantityDok.Clear;
                  TbCounts.Post;
                end else if Abs(TbCountsSumma.value-LastSumma)>=1 then begin
                  ShowMessage('Счет №'+CurCount+' '+
                    DateToStr(LastDate)+' было '+FloatToStr(TbCountsSumma.value)+
                    ' станет '+FloatToStr(LastSumma)+' Разность '+
                    FloatTostr(Abs(TbCountsSumma.value-LastSumma)));
                  TbCounts.Edit;
                  TbCountsSumma.value:=LastSumma;
                  TbCountsTurnoverD.Clear;
                  TbCountsTurnoverK.Clear;
                  TbCountsQuantityDok.Clear;
                  TbCounts.Post;
                end;
              end;

              NextLine;
              while Pos('-',s)=0 do NextLine;
              (* Обрабатываем документы *)
              while Pos('-',s)<>0 do begin
                Inc(KolDok);
                ToInt(s,i);
                ReadInt(Str,s,i);
                if Length(Str)>2 then
                  ToRaise('Тип документа '+Str);
                Td:=StrToInt(Str);
                ToInt(s,i);
                ReadInt(MFO,s,i);
                if Length(MFO)<>3 then ToRaise('МФО '+MFO);
                ToInt(s,i);
                ReadCount(CountDok);
                ToInt(s,i);
                ReadInt(NDok,s,i);
                ToInt(s,i);
                NB:=0;
                if i>MaxPosNB then ReadFloat(Str,s,i)
                else begin
                  ReadInt(Str,s,i);
                  NB:=StrToInt(Str);
                  ToInt(s,i);
                  ReadFloat(Str,s,i);
                end;
                SummaDok:=StrToFloat(Str);
                if i<=MaxPosDebet then begin
                  AllDebet:=AllDebet+SummaDok;
                  SummaDok:=-SummaDok;
                end else AllKredit:=AllKredit+SummaDok;

                (* Запись документа в базу *)
                if MainCycle=2 then begin
                  TbPay.Insert;
                  TbPayMfoEnterprise.value:='335';
                  TbPayBCountEnterprise.value:=CurCount;
                  TbPayDate.Value:=CurDate;
                  TbPayRodOper.Value:=td;
                  TbPayMFO.Value:=MFO;
                  TbPayBCount.Value:=CountDok;
                  TbPayNDok.Value:=NDok;
                  TbPayKodNP.Value:=NB;
                  TbPaySumma.Value:=SummaDok;
                  TbPay.Post;
                end;
                NextLine;
              end;
              (* *)
              while Pos(':',s)=0 do NextLine;
              ToInt(s,i);
              ReadInt(KolDokText,s,i);
              if KolDok<>StrToInt(KolDokText) then
                ToRaise('Кол-во документов '+IntToStr(KolDok)+'<>'+KolDokText);
              ToInt(s,i);
              ReadFloat(Str,s,i);
              if Abs(AllDebet-StrToFloat(Str))>=1 then
                ToRaise('Дебет '+FloatToStr(AllDebet)+'<>'+Str);
              NextLine;
              ToInt(s,i);
              ReadFloat(Str,s,i);
              if Abs(AllKredit-StrToFloat(Str))>=1 then
                ToRaise('Кредит '+FloatToStr(AllKredit)+'<>'+Str);
              NextLine;
            end;(*of нашли входящий остаток, т.е. документы*)
            while Pos(EndRest,s)=0 do NextLine; (* Исходящий *)
            (* Дата исх. остатка *)
            ToInt(s,i);
            ReadDate(NewDate);
            if (KolDok>0) and (CurDate<>NewDate) then
              ToRaise('Дата счета '+DateToStr(CurDate)+'<>исх. дата '+DateToStr(NewDate));
            (* Сумма остатка *)
            ToInt(s,i);
            ReadFloat(Str,s,i);
            NewSumma:=StrToFloat(Str);
            if i<=MaxPosDebet then NewSumma:=-NewSumma;
            if (kolDok<>0) and (Abs(LastSumma-AllDebet+AllKredit-NewSumma)>=1) then
              ToRaise('Итоговые суммы '+FloatToStr(NewSumma)+'<>'+FloatToStr(LastSumma-AllDebet+AllKredit));

            (*if need then save record to Counts*)
            if MainCycle=2 then begin
              TbCounts.SetKey;
              TbCountsDate.value:=NewDate;
              TbCountsBCountEnterprise.value:=CurCount;
              if Not TbCounts.GotoKey then begin
                TbCounts.insert;
                TbCountsMfoEnterprise.value:='335';
                TbCountsBCountEnterprise.value:=CurCount;
                TbCountsDate.value:=NewDate;
                TbCountsSumma.value:=NewSumma;
                if KolDok<>0 then begin
                  TbCountsTurnoverD.value:=AllDebet;
                  TbCountsTurnoverK.value:=AllKredit;
                  TbCountsQuantityDok.value:=kolDok;
                end else begin
                  TbCountsTurnoverD.Clear;
                  TbCountsTurnoverK.Clear;
                  TbCountsQuantityDok.Clear;
                end;
                TbCounts.Post;
              end else if (TbCountsSumma.value<>NewSumma) or
                          (TbCountsTurnoverD.value<>AllDebet) or
                          (TbCountsTurnoverK.value<>AllKredit) or
                          (TbCountsQuantityDok.value<>kolDok) then begin
                TbCounts.Edit;
                TbCountsSumma.value:=NewSumma;
                if KolDok<>0 then begin
                  TbCountsTurnoverD.value:=AllDebet;
                  TbCountsTurnoverK.value:=AllKredit;
                  TbCountsQuantityDok.value:=kolDok;
                end else begin
                  TbCountsTurnoverD.Clear;
                  TbCountsTurnoverK.Clear;
                  TbCountsQuantityDok.Clear;
                end;
                TbCounts.Post;
              end;
              if Dm1.TbSprBCount.Locate('BCount',CurCount,[]) then begin
                if dm1.TbSprBCountsDate.value<=NewDate then begin
                  dm1.TbSprBCount.Edit;
                  dm1.TbSprBCountsDate.value:=NewDate;
                  dm1.TbSprBCountSumma.value:=NewSumma;
                  dm1.TbSprBCount.Post;
                end;
              end else ToRaise('Счет №'+CurCount+' ранее найденный повторно не найден!!!');
            end;
            NextLine;
          end;
          if KolCount<>KolCountText then
            ToRaise('Количество лицевых '+IntToStr(KolCount)+'<>'+IntToStr(KolCountText));
          if MainCycle=2 then begin
            dm1.TbConf.Edit;
            dm1.TbConfDatePay.value:=CurDate;
            dm1.TbConf.Post;
          end;
        end;
        CloseFile(f);
      end;
    until FileName='';
  finally
    TbCounts.close;
    TbPay.close;
    DM1.TbSprBCount.close;
  end;
end;

procedure TDMC.TbPayCalcFields(DataSet: TDataSet);
var lDate:string;
    lSumma,lCourse1,lCourse2:double;
begin
  if TbPaySumma.Value<0 then begin
    TbPaySummaD.Value:=Abs(TbPaySumma.Value);
    TbPaySummaK.Value:=0;
  end else begin
    TbPaySummaD.Value:=0;
    TbPaySummaK.Value:=TbPaySumma.Value;
  end;
  if (TbPayMFO.value<>'') and (TbPayBCount.value<>'') then begin
    va[0]:=TbPayMFO.value;
    va[1]:=TbPayBCount.value;
    if dm1.QOrg.locate('kodotd;BCount',Va,[]) then
      TbPayOrgN.value:=dm1.QOrgOrg.asString+'  '+dm1.QOrgName.value;
  end;

  if (TbPayCross.visible) or (TbPayCrossDate.visible)  then begin
    DMV.CalcCurrency(TbPaySumma.Value,TbPayCurrency.value,840,
      TbPayDate.AsString,lSumma,lDate,lCourse1,lCourse2);
    TbPayCross.Value:=lSumma;
    TbPayCrossDate.Value:=lDate;
  end;
  TbPayCourseUSD.Value:=
  GetFromSQLText('DBGKSM','Select RateOnDateF(840,'''+TbPayDate.asString+''')',true);
  if TbPayCourse.Value<>0 then
  TbPayCrossCourse.Value:=TbPayCourseUSD.Value/TbPayCourse.Value;
end;

procedure TDMC.TbPayEditData(Sender: TObject; TypeShow:TTypeShow; FieldReturn:TFieldReturn);
begin
  ToForm(TFormPay,TbPay,TypeShow,FieldReturn);
end;

procedure TDMC.QCountsCalcFields(DataSet: TDataSet);
begin
  if QCountsSumma.Value<0 then begin
    QCountsSummaD.Value:=Abs(QCountsSumma.Value);
    QCountsSummaK.Value:=0;
  end else begin
    QCountsSummaD.Value:=0;
    QCountsSummaK.Value:=QCountsSumma.Value;
  end;
end;


procedure TDMC.QPayOnDateCalcFields(DataSet: TDataSet);
begin
  if QPayOnDateSumma.Value<0 then begin
    QPayOnDateSummaD.Value:=Abs(QPayOnDateSumma.Value);
    QPayOnDateSummaK.Value:=0;
  end else begin
    QPayOnDateSummaD.Value:=0;
    QPayOnDateSummaK.Value:=QPayOnDateSumma.Value;
  end;
end;

procedure TDMC.PrintPayOnDate(sDate:string);
var S,SumOnBCount:string;
begin
  FormView:=TFormView.Create(Application);
  FormView.RichEdit.Lines.Add('     ВЫПИСКА ЗА '+sDate);
  FormView.RichEdit.Lines.Add('');
  TbCounts.IndexFieldNames:='BCountEnterprise;sDate';
  TbCounts.Open;
  QPayOnDate.Params.ParamByName('DatePay').AsString:=sDate;
  dm1.QSprBCount.First;
  While Not dm1.QSprBCount.EOF do begin
    QPayOnDate.Params.ParamByName('aBCountEnterprise').value:=dm1.QSprBCountBCount.Value;
    QPayOnDate.Open;
    if Not (QPayOnDate.BOF and QPayOnDate.EOF) then begin
      FormView.RichEdit.Lines.Add('Лицевой посчету № '+
        dm1.QSprBCountBCount.AsString+' '+dm1.QSprBCountName.Asstring);
      FormView.RichEdit.Lines.Add('');
      FormView.RichEdit.Lines.Add('  №  |'+DataSetPrintTitle(QPayOnDate,VisibleFields));

      TbCounts.SetKey;
      TbCountsBCountEnterprise.value:=dm1.QSprBCountBCount.Value;
      TbCountsDate.AsString:=sDate;
      SumOnBCount:='Отсутствуют итоги! Необходима проверка базы!';
      if TbCounts.GotoKey then begin
        if TbCountsSumma.value>=0 then
          SumOnBCount:=sForm(FormatFloat(TbCountsSumma.DisplayFormat,TbCountsSumma.value),46,taRightJustify)
        else SumOnBCount:=sForm(FormatFloat(TbCountsSumma.DisplayFormat,TbCountsSumma.value),25,taRightJustify);
        if Not TbCounts.BOF then TbCounts.Prior;
        if (TbCountsDate.value<>StrToDate(sDate)) and
           (TbCountsBCountEnterprise.value=dm1.QSprBCountBCount.Value) then begin
          s:=sform('Входящий остаток за '+TbCountsDate.AsString+' ',40,taRightJustify);
          if TbCountsSumma.value>=0 then
            s:=s+SForm(FormatFloat(TbCountsSumma.DisplayFormat,TbCountsSumma.value),46,taRightJustify)
          else s:=s+sForm(FormatFloat(TbCountsSumma.DisplayFormat,TbCountsSumma.value),25,taRightJustify);
          FormView.RichEdit.Lines.Add(s);
        end;
      end;

      DataSetPrintData(QPayOnDate,VisibleFields,FormView.RichEdit.Lines,
                       5, false,'SummaD;SummaK');

      FormView.RichEdit.Lines.Add(sForm('Исходящий остаток за '+sDate+' ',40,taRightJustify)+SumOnBCount);
      FormView.RichEdit.Lines.Add('');
    end;
    QPayOnDate.Close;
    dm1.QSprBCount.Next;
  end;
  TbCounts.Close;
  FormView.Show;
end;

end.
