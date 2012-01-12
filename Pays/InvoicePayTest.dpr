Program InvoicePayTest;
Uses Windows,
  SysUtils;
Const MaxPayDoc=200;
      MaxInvoice=100;
      MaxInvoicePay=700;
      //MaxBalance=50;
Type
     RPayDoc=record
       AutoInc: integer;      { ���������� �������������� ���������  }
       DateComing: TDateTime; { ���� ���������� ����� ������         }
       Summa: double;         { ����� ����������                     }
       SummaActive: double;   { �����, ���������� �� ��������������  }
                              { 0 - ���� ��� ������ ���� �� �������� }
     end;                     { ���������                            }
     RInvoice=record
       NumInvoice: integer;   { ����� ���������                      }
       SDate: TDateTime;      { ���� ������� ���������               }
       Summa: double;         { ����� �� ���������                   }
       SummaClose: double;    { �����, �� ������� ��������� �������  }
                              { � ������ SummaClose=Summa            }
     end;
     { �������, ��������� PayDoc � Invoice }
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

{ ������� ���� ������ ����������� �������� ��������� ���������� }
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
  CurInvoicePay:=-1; { ������ � InvoicePay }
  CurPayDoc:=-1;     { ������ � PayDoc     }
  CurInvoice:=-1;    { ������ � Invoice    }
  PayDoc_InvoiceLoop:=false;
  aBalance:=0;
  aSummaActive:=0;
  aSummaInvoice:=0;
  aSummaClose:=0;
  aExistPayDoc:=1;   // 1-���� ��� ���� ��������� ���������, 0-���
  aExistInvoice:=1;  // 1-���� ��� ���� ��������� (�.�. ���������), 0-���
  repeat
    //aPayDocSumma:=0;
    //aInvoiceSumma:=0;
    aSummaConnection:=0;

    // ������� �� ��������� ��������
    if (aSummaActive=0) and (aExistPayDoc=1) then begin
      Inc(CurPayDoc);
      if CurPayDoc>MaxPayDoc then begin // ��������� ��������� �����������
        aExistPayDoc:=0;
        CurInvoicePay:=MaxInvoicePay+1; // ������ ������ � InvoicePay'�� ���� �� �����
      end else begin
        aSummaActive:=PayDoc[CurPayDoc].SummaActive;
        {aPayDocSumma:=aSummaActive;}
        {aBalance:=aBalance+aSummaActive;}
      end;
    end;

    // ������� �� ��������� ���������
    if (aSummaClose=aSummaInvoice) and (aExistInvoice=1) then begin
      Inc(CurInvoice);
      if CurInvoice>MaxInvoice then begin // ��������� �����������
        aExistInvoice:=0;
        CurInvoicePay:=MaxInvoicePay+1; // ������ ������ � InvoicePay'�� ���� �� �����
      end else begin
        aSummaInvoice:=Invoice[CurInvoice].Summa;
        aSummaClose:=Invoice[CurInvoice].SummaClose;
        {aInvoiceSumma:=aSummaInvoice;}
        aBalance:=aBalance-aSummaInvoice;
      end;
    end;

    // ���������� ��� ���� �� � ����� �� ������
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
    end else begin // ���� ������(���������) � ����� ��������
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

    // ������������ ������� ��������� (���� SummaClose)
    if ((aSummaClose=aSummaInvoice) and (aSummaClose>0) and (aExistInvoice+aExistPayDoc=2)) // ��������� ������� ���������
      or ((aSummaClose>0) and (aExistPayDoc=0) and (aExistInvoice=1)) then begin  // ��������� ������� ��������
      //update ThisInvoice set SummaClose=aSummaClose where current of ThisInvoice
      Invoice[CurInvoice].SummaClose:=aSummaClose;
    end;
    // ������������ ������� �������� (���� SummaActive)
    if ({(aSummaActive<=PayDoc[CurPayDoc].Summa) and} (aSummaActive=0) and (aExistPayDoc+aExistInvoice=2)) // ������ ��������� ���������
      or ((aSummaActive>0) and (aExistInvoice=0) and (aExistPayDoc=1)) then begin // ������ ��������� ��������
      //update ThisPayDoc set SummaActive=aSummaActive where current of ThisPayDoc
      PayDoc[CurPayDoc].SummaActive:=aSummaActive;
    end;

    // � ����� �������� ���� ��������� ==> ��������� ������ � InvoicePay
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
    // ����������� Balanc'� �� LocSumma
    aBalance:=aBalance+aSummaConnection+aSummaActive;//aPayDocSumma+aInvoiceSumma;
    // � ���� ����� (�.�. � ����� ���������) ��������� �������� ������ �� ��������
    // ���� ���������� ��������� ������ �� ������� � �������, �� ��� ����������
    // ������ ����� ...

    // ����� ���������� � ����
    OutPutOneStrResult(CurInvoice,CurInvoicePay,CurPayDoc);
    aBalance:=aBalance-aSummaActive;

    // �.�. ��������� �����������
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
  { �������� ���������� ������ ����������� }
  AssignFile(ResultText,'c:\b\ksm\pays\test.txt');
  Rewrite(ResultText);
  InitPayDoc;
  InitInvoice;
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  Writeln(ResultText,'|  �  |  ������  |    �     |   ����   |   �����   |   �����   |  �  |  �����    |    �     |  ����    |   �����   |  �������� |');
  Writeln(ResultText,'|�����|    ��    |   ���-   |  ������� |    ��     | ��������  | ���.| ��������  | �������. |��������� |  �������  |   �����   |');
  Writeln(ResultText,'| ��� |����������|  ������  | ���������| ��������� | ��������� | ����| ��������  | ���������|  �����   |           |           |');
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  {for i:=0 to MaxInvoice do OutPutOneStrResult(i,i,i);}
  InvoicePayCalculated;
  Writeln(ResultText,'--------------------------------------------------------------------------------------------------------------------------------');
  { ������ ����������� }
  Close(ResultText);
end.
