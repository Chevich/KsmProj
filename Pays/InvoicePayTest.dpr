Program InvoicePayTest;
Uses Windows,
  SysUtils;
Const MaxPayDoc=200;
      MaxInvoice=100;
      MaxInvoicePay=700;
      //MaxBalance=50;
Type
     RPayDoc=record
       AutoInc: integer;      { Уникальный индентификатор документа  }
       DateComing: TDateTime; { Дата проведения нашим банком         }
       Summa: double;         { Сумма предоплаты                     }
       SummaActive: double;   { Сумма, оставшаяся от первоначальной  }
                              { 0 - если все деньги ушли на закрытие }
     end;                     { накладных                            }
     RInvoice=record
       NumInvoice: integer;   { Номер накладной                      }
       SDate: TDateTime;      { Дата выписки накладной               }
       Summa: double;         { Сумма по накладной                   }
       SummaClose: double;    { Сумма, на которую накладная закрыта  }
                              { В идеале SummaClose=Summa            }
     end;
     { Таблица, связующая PayDoc и Invoice }
     RInvoicePay=record
       NumInvoice: integer;
       SDate: TDateTime;
       NumDoc: integer;
       DateComing: TDateTime;
       Summa: Double;
     end;

     RBalance=record
       Period:      TDateTime;
       NumDoc:      Integer;
       DateComing:  TDateTime;
       SummaActive: Double;
       NumInvoice:  Integer;
       SDate:       TDateTime;
       SummaClose:  Double;
       Balance:     Double;
     end;

var PayDoc:array[0..MaxPayDoc+1] of RPayDoc;
    Invoice:array[0..MaxInvoice+1] of RInvoice;
    InvoicePay:array[0..MaxInvoicePay+1] of RInvoicePay;
    //Balance: array[0..MaxBalance] of RBalance;
    i,j,k,l:integer;
    ResultText:TextFile;
    aBalance: double;
    aSummaActive, aSummaClose: double;

Procedure InitPayDoc;
var i: integer;
begin
  Randomize;
  for i:=0 to MaxPayDoc do
    with PayDoc[i] do begin
      AutoInc:=i;
      DateComing:=Date;
      {Summa:=Random(100000000);}
      Summa:=100000+i*Random(1000);
      SummaActive:=Summa;
    end;
end;

Procedure InitInvoice;
var i:integer;
begin
  Randomize;
  for i:=0 to MaxInvoice do
    with Invoice[i] do begin
      NumInvoice:=i;
      SDate:=Date;
      Summa:=100000+i*Random(1000);
      SummaClose:=0;
    end;
end;

{ Выводит одну строку результатов закрытия накладных платежками }
Procedure OutPutOneStrResult(InvoiceIndex,InvoicePayIndex,PayDocIndex:integer);
const NumberRow:integer=0;
begin
  Inc(NumberRow);
  writeln(ResultText,'|',NumBerRow:4,' |',aBalance:9:0,' |',
                     Invoice[InvoiceIndex].NumInvoice:9,' | ',
                     DateTimeToStr(Invoice[InvoiceIndex].SDate),' | ',
                     Invoice[InvoiceIndex].Summa:9:0,' | ',
                     {Invoice[InvoiceIndex].SummaClose}aSummaClose:9:0,' | ',
                     InvoicePayIndex:3,' | ',
                     InvoicePay[InvoicePayIndex].Summa:9:0,' | ',
                     PayDoc[PayDocIndex].AutoInc:8,' | ',
                     DateTimeToStr(PayDoc[PayDocIndex].DateComing),' | ',
                     PayDoc[PayDocIndex].Summa:9:0,' | ',
                     {PayDoc[PayDocIndex].SummaActive}aSummaActive:9:0,' |');
end;

Procedure InvoicePayCalculated;
var CurInvoice,
    CurPayDoc,
    CurInvoicePay: integer;
    //aPayDocSumma: Double;
    //aInvoiceSumma: Double;
    aSummaConnection: Double;
    aExistPayDoc,aExistInvoice: integer;
    aSummaInvoice: Double;
    PayDoc_InvoiceLoop: boolean;
begin
  CurInvoicePay:=-1; { Индекс в InvoicePay }
  CurPayDoc:=-1;     { Индекс в PayDoc     }
  CurInvoice:=-1;    { Индекс в Invoice    }
  PayDoc_InvoiceLoop:=false;
  aBalance:=0;
  aSummaActive:=0;
  aSummaInvoice:=0;
  aSummaClose:=0;
  aExistPayDoc:=1;   // 1-если еще есть платежные документы, 0-нет
  aExistInvoice:=1;  // 1-если еще есть накладные (ж.д. квитанции), 0-нет
  repeat
    //aPayDocSumma:=0;
    //aInvoiceSumma:=0;
    aSummaConnection:=0;

    // Переход на следующую платежку
    if (aSummaActive=0) and (aExistPayDoc=1) then begin
      Inc(CurPayDoc);
      if CurPayDoc>MaxPayDoc then begin // Платежные документы закончились
        aExistPayDoc:=0;
        CurInvoicePay:=MaxInvoicePay+1; // Значит связей с InvoicePay'ем тоже не будет
      end else begin
        aSummaActive:=PayDoc[CurPayDoc].SummaActive;
        {aPayDocSumma:=aSummaActive;}
        {aBalance:=aBalance+aSummaActive;}
      end;
    end;

    // Переход на следующую накладную
    if (aSummaClose=aSummaInvoice) and (aExistInvoice=1) then begin
      Inc(CurInvoice);
      if CurInvoice>MaxInvoice then begin // Накладные закончились
        aExistInvoice:=0;
        CurInvoicePay:=MaxInvoicePay+1; // Значит связей с InvoicePay'ем тоже не будет
      end else begin
        aSummaInvoice:=Invoice[CurInvoice].Summa;
        aSummaClose:=Invoice[CurInvoice].SummaClose;
        {aInvoiceSumma:=aSummaInvoice;}
        aBalance:=aBalance-aSummaInvoice;
      end;
    end;

    // Документов нет хотя бы в одной из таблиц
    if (aExistPayDoc=0) or (aExistInvoice=0) then begin
      if(aExistPayDoc=0) and (aExistInvoice=1) then begin
        //aInvoiceSumma:=0;
        aSummaConnection:=0;
        aSummaClose:=0;
        aSummaInvoice:=0;
      end else
        if (aExistPayDoc=1) and (aExistInvoice=0) then begin
          //aPayDocSumma:=aSummaActive;
          aSummaConnection:=aSummaActive;
          aSummaActive:=0;
        end;
    end else begin // Есть записи(документы) в обеих таблицах
      if aSummaActive-(aSummaInvoice-aSummaClose)<=0 then begin
        //aPayDocSumma:=aSummaActive;
        aSummaConnection:=aSummaActive;
        aSummaClose:=aSummaClose+aSummaConnection;//aPayDocSumma;
        aSummaActive:=0;
      end else begin
        //aInvoiceSumma:=aSummaInvoice-aSummaClose;
        aSummaConnection:=aSummaInvoice-aSummaClose;
        aSummaActive:=aSummaActive-aSummaConnection; //aInvoiceSumma;
        aSummaClose:=aSummaInvoice
      end;
    end;

    // Корректируем текущую накладную (поле SummaClose)
    if ((aSummaClose=aSummaInvoice) and (aSummaClose>0) and (aExistInvoice+aExistPayDoc=2)) // Накладная закрыта полностью
      or ((aSummaClose>0) and (aExistPayDoc=0) and (aExistInvoice=1)) then begin  // Накладная закрыта частично
      //update ThisInvoice set SummaClose=aSummaClose where current of ThisInvoice
      Invoice[CurInvoice].SummaClose:=aSummaClose;
    end;
    // Корректируем текущую платежку (поле SummaActive)
    if ({(aSummaActive<=PayDoc[CurPayDoc].Summa) and} (aSummaActive=0) and (aExistPayDoc+aExistInvoice=2)) // Деньги потрачены полностью
      or ((aSummaActive>0) and (aExistInvoice=0) and (aExistPayDoc=1)) then begin // Деньги потрачены частично
      //update ThisPayDoc set SummaActive=aSummaActive where current of ThisPayDoc
      PayDoc[CurPayDoc].SummaActive:=aSummaActive;
    end;

    // В обеих таблицах есть документы ==> добавляем строку в InvoicePay
    if (aExistPayDoc=1) and (aExistInvoice=1) then begin
      //insert into STA.InvoicePay values(
      //  aAutoInc,aNumInvoice,LocSumma,InClient,aDateComing,aDateInvoice,InCurrency)
      Inc(CurInvoicePay);
      with InvoicePay[CurInvoicePay] do begin
        NumInvoice:=Invoice[CurInvoice].NumInvoice;
        SDate:=Invoice[CurInvoice].SDate;
        NumDoc:=PayDoc[CurPayDoc].AutoInc;
        DateComing:=PayDoc[CurPayDoc].DateComing;
        Summa:=aSummaConnection;//aPayDocSumma+aInvoiceSumma;
      end;
    end;
    // Модификация Balanc'а на LocSumma
    aBalance:=aBalance+aSummaConnection+aSummaActive;//aPayDocSumma+aInvoiceSumma;
    // В этой точке (т.е. в точке процедуры) находится реальный баланс по платежам
    // Если необходимо сохранять баланс по клиенту в таблице, то это необходимо
    // делать здесь ...

    // Вывод результата в файл
    OutPutOneStrResult(CurInvoice,CurInvoicePay,CurPayDoc);
    aBalance:=aBalance-aSummaActive;

    // М.б. документы закончились
    if (aExistPayDoc=0) and (aExistInvoice=0) then begin
      // leave PayDoc_InvoiceLoop
      PayDoc_InvoiceLoop:=true;
    end;
  until PayDoc_InvoiceLoop;
end;

Procedure OutPutResult;
begin
end;

begin
  { Открытие устройства вывода результатов }
  AssignFile(ResultText,'c:\b\ksm\pays\test.txt');
  Rewrite(ResultText);
  InitPayDoc;
  InitInvoice;
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  Writeln(ResultText,'|  №  |  Баланс  |    №     |   Дата   |   Сумма   |   Сумма   |  №  |  Сумма    |    №     |  Дата    |   Сумма   |  Активная |');
  Writeln(ResultText,'|опера|    по    |   нак-   |  выписки |    по     | закрытия  | тек.| текущего  | платежн. |получения |  платежа  |   сумма   |');
  Writeln(ResultText,'| ции |организаци|  ладной  | накладной| накладной | накладной | закр| закрытия  | документа|  суммы   |           |           |');
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  {for i:=0 to MaxInvoice do OutPutOneStrResult(i,i,i);}
  InvoicePayCalculated;
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  { Обсчет результатов }
  Close(ResultText);
end.
