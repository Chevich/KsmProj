{                                                                   }
{ First Autor:      Sergei Sotnik EMail:sergei@alice.dp.ua          }
{ Home page                       http://www.alice.dp.ua/~sergei    }
{ Improvement:      Lev Zusman    EMail: lev@ksm.grodno.by          }
{ Special Features: Pavel Baulin  EMail: bausha@yahoo.com           }
{ The Best Improvment Lev Zusman  EMail: lev@ksm.grodno.by          }
{ 09.2009                                                           }
Unit ExpExcel;
Interface
Uses DbTables,DbGrids,EtvTable,EtvGrid;

Procedure ExportToExcel(aQuery:TDBDataSet; aListName: string; aReportCaption: string; aNumList: integer; aFileName:string; aMacroName: string; aGrid:TEtvDBGrid=nil);

Implementation
Uses Windows, SysUtils, Classes, Registry, Dialogs, DB, Printers,
     { For Export to Excel }
     Excel_TLB, ComObj;
//   Excel_TLB - Import through "Project/Import type library"
//   library EXCEL8.OLB

var ExApp: _Application;
    WS:    WorkSheet;
    aTextPrinterWin98: boolean; // Установлен ли в системе Win98 Драйвер принтера "TEXT"
    UserPrinters:TStringList; // Список принтеров с реестра [HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts]
                              // Структура нужна для оптимизации скорости печати при экспорте в Excel, т.к.
                              // В Excel имя принтера имеет вид: 'Microsoft Office Document Image Writer (Ne02:)';
                              // В этой структуре и будем формировать имена принтеров такого формата.

Procedure ExportToExcel(aQuery:TDBDataSet; aListName: string; aReportCaption: string; aNumList: integer; aFileName:string; aMacroName: string; aGrid:TEtvDBGrid=nil);
{ Если aNumList<>0, то меняем границы печати для печати главной книги четных и нечетных листов }
{ Если aNumlist=0, то не делаем ничего}
Const MaxRecordExportStr='65536';  { MAX количество строк на лист Excel }
      MaxFieldsExportStr='256'; { MAX количество столбцов на лист Excel }
      PlaceL=13; {Какая по счету буква в алфавите }
var i, j, k, l1, l2: integer;
    v: Variant;
    R: Real;
    Reg: TRegistry;
    Str,aDisplayFormat: string;
    aRecordCount, aFieldCount: integer;
    aValCode: integer;
    NameCell,AddNameCell,aReportCaption2,aDefaultPrinter: string;
    aPos, IndexTotal: byte;
    ExAppExists: boolean;
    V1:OleVariant;

begin
  if not aQuery.Active then aQuery.Open;
  aRecordCount:=aQuery.RecordCount;
  if aRecordCount>StrToInt(MaxRecordExportStr) then begin
    ShowMessage('Превышен предел количества строк '+MaxRecordExportStr+#13+
                'Сообщите о проблеме автору');
    Exit;
  end;
  i:=Pos(#10,aReportCaption);
  if i>0 then begin
    aReportCaption2:=Copy(aReportCaption,i+1,Length(aReportCaption)-i+1);
    aReportCaption:=Copy(aReportCaption,1,i-1);
  end else aReportCaption2:='';

  ExAppExists:=false;

  if (ExApp<>nil) then
    if not VarIsEmpty(ExApp) then
      try
        if aFileName='' then
          ExApp.Worksheets.Add(null,ExApp.Worksheets.Item[ExApp.Worksheets.Count],1,xlWorkSheet,0)
        else
          ExApp.Worksheets.Add(null,ExApp.Worksheets.Item[ExApp.Worksheets.Count],1,xlWorkSheet,0);
        {ExApp.Sheets.Add(null,0(*ExApp.Sheets.Count-1*),1,null,0);}
        ExAppExists:=true;
      except
        {ExApp._Release;}{ Эта строчка лишняя 16.04.2003 }
      end
    else ExApp._Release;
  if not ExAppExists then begin
    ExApp :=CoApplication_.Create;
    if aFileName='' then
      ExApp.Workbooks.Add(xlWBATWorksheet, 0)
    else
      ExApp.Workbooks.Add(aFileName, 0);
    {'K:\Реализация\TempOrder2.xls'}
    { Добавление макросов для главной книги }
    (*
    if aNumList<>0 then begin
      ExApp.RecordMacro('Sub OddListsVisible() For i = 1 To ThisWorkbook.Sheets.Count Step 2 ThisWorkbook.Worksheets(i).Visible = Not ThisWorkbook.Worksheets(i).Visible Next i End Sub',null,0)
    end;
    *)
  end;
  // Lev 16.07.2011
  // Разборки с принтерами для удобного и быстрого экспорта в EXCEL.
  {
  TRegKeyInfo = record
    NumSubKeys: Integer;
    MaxSubKeyLen: Integer;
    NumValues: Integer;
    MaxValueLen: Integer;
    MaxDataLen: Integer;
    FileTime: TFileTime;
  end;
  }
  if not Assigned(UserPrinters) then begin
    UserPrinters:=TStringList.Create;
    Reg:=TRegistry.Create;
    if Win32Platform=VER_PLATFORM_WIN32_NT then
      with Reg do try
        RootKey:=HKEY_CURRENT_USER;
        Reg.OpenKeyReadOnly('Software\Microsoft\Windows NT\CurrentVersion\PrinterPorts');
        //R.GetKeyInfo(aRegKeyInfo);
        Reg.GetValueNames(UserPrinters); // Считали имена параметров открытого ключа
        // Считываем значения параметров открытого ключа и подправляем как нам надо уже полученные имена параметров (они же - ПРИНТЕРЫ)
        for i:=0 to UserPrinters.Count-1 do begin
          Str:=Reg.ReadString(UserPrinters[i]);
          // примерное значение ключа "winspool,Ne02:,15,45", нам нужно вытащить "Ne02:"
          UserPrinters[i]:=UserPrinters[i]+' ('+Copy(Str,10,Pos(':,',Str)-9)+')';
        end;
      finally
        Reg.Free;
      end
    else
      with Reg do try
        RootKey:=HKEY_LOCAL_MACHINE;
        aTextPrinterWin98:=Reg.OpenKeyReadOnly('System\CurrentControlSet\Control\Print\Printers\Text');
      finally
        Reg.Free;
      end;
  end;

  ExApp.ScreenUpdating[0]:=false;
  aDefaultPrinter:=ExApp.ActivePrinter[0];
  if Win32Platform=VER_PLATFORM_WIN32_NT then
    for i:=0 to UserPrinters.Count-1 do
      if Pos('Microsoft Office Document Image Writer',UserPrinters[i])>0 then begin
        ExApp.ActivePrinter[0]:=UserPrinters[i];
        Break;
      end
  else
    if aTextPrinterWin98 then
      ExApp.ActivePrinter[0]:='TEXT (FILE:)';
  //ExApp.ActivePrinter[0]:='Microsoft Office Document Image Writer (Ne02:)';
  //ExApp.ActivePrinter[0]:='Text (FILE:)';
  { Установка параметров страницы }
  with (ExApp.ActiveSheet as WorkSheet).PageSetup do begin
    Orientation:=xlLandscape;
    BottomMargin:=20;
    if (aNumList mod 2=1) or (aNumlist=0) then begin
      LeftMargin:=85;
      RightMargin:=20;
    end else begin
      LeftMargin:=20;
      RightMargin:=85;
    end;
    if aNumList<>0 then Zoom:=false;
    TopMargin:=20;
  end;
  ExApp.Visible[0] := true;
  v:= VarArrayCreate([0, aQuery.RecordCount+1, 0, aQuery.FieldCount-1], varVariant);
  WS := ExApp.ActiveSheet as WorkSheet;
  if aListName<>'' then WS.Name:=aListName;

  k:=-1;
  for i:=0 to aQuery.FieldCount-1 do with aQuery.Fields[i] do if Visible then begin
    Inc(k);
    v[0,k]:=DisplayLabel;
    { 65 - A, 66 - B, 67 - C, ... }
    if k>25 then
      NameCell:=Chr((k div 26)-1+65)+Chr((k mod 26)+65)
    else
      NameCell:=Chr((k mod 26)+65);

    {* Устанавливаем минимальную ширину столбцов
       для того чтобы большие заголовки переносились по словам *}
    {WS.Columns.Range[NameCell+'1',NameCell+'1'].ColumnWidth:=10;}

    { Устанавливаем соответствующий формат данных у ячеек }
    with WS.Range[NameCell+'1',NameCell+MaxRecordExportStr] do begin
      case DataType of
        ftString,
        ftMemo,
        ftFmtMemo  : NumberFormat:='@';
        ftSmallint,
        ftInteger,
        ftWord,
        ftAutoInc  : NumberFormat:='0';
        ftFloat    :
             begin
               if TNumericField(aQuery.Fields[i]).DisplayFormat=''
                 then NumberFormat :='0'+DecimalSeparator+'##;-0'+DecimalSeparator+'##;#'
                 else begin
                   aDisplayFormat:=TNumericField(aQuery.Fields[i]).DisplayFormat;
                   if (DecimalSeparator=',') and (Pos('.',aDisplayFormat)>0)  then begin
                     j:= 1;
                     while j<Length(aDisplayFormat) do begin
                       if aDisplayFormat[j]='.' then aDisplayFormat[j]:=',';
                       Inc(j);
                     end;
                   end;
                   NumberFormat:=aDisplayFormat;
                 end;
               {обработка ситуации маски '#.,00'}
               l1:=Pos('.', NumberFormat);
               l2:=Pos(',', NumberFormat);
               if (l1>0) and (l2>0) then
                 begin
                   if l2>l1 then l1:=l2;
                   if l1<Length(NumberFormat) then
                     NumberFormat:='# ##0'+DecimalSeparator+System.Copy(NumberFormat, l1+1, Length(NumberFormat)-l1)
                   else
                     NumberFormat:='# ##0';
                 end;
             end;
      end;
      if (aFileName='') and (aGrid<>nil) then begin
        Font.Size:=aGrid.Font.Size;
        Font.Name:=aGrid.Font.Name;
      end else Font.Size:=9;
      {RowHeight:=12;}
    end;
  end;
  aFieldCount:=k;

  aQuery.First;
  j:=1; // № строки в табличных данных
  try
    aQuery.DisableControls;
    while not aQuery.Eof do begin
      k:=-1; // № столбца в табличных данных. Отображаем в отчете только видимые столбцы
      for i:=0 to aQuery.FieldCount-1 do begin
        with aQuery.Fields[i] do begin
          if aQuery.Fields[i].Visible then begin
            Inc(k);
            if (aQuery.Fields[i].FieldName[1] in ['s','S'])
            and (aQuery.Fields[i].FieldName[2] in ['0'..'9']) and (DataType=ftString) then begin
              { Проверка строкового поля на число }
              Val(aQuery.Fields[i].AsString, R, aValCode);
              if aValCode=0 then v[j,k]:=aQuery.Fields[i].AsFloat
              else v[j,k]:=aQuery.Fields[i].AsString;
            end else v[j,k]:=aQuery.Fields[i].Value;
            {для Главной книги ловим индекс итоговой строки для последующего выделения }
            if (aNumList<>0) and (aQuery.Fields[i].AsString='11.11.11') then IndexTotal:=j+1;
          end;
          {поиск итоговых строк и выделение их}
          Str:=AnsiUpperCase(aQuery.Fields[i].AsString);
          if (Pos('ИТОГО',Str)>0) or (Pos('ВСЕГО',Str)>0) or (Pos('+ ',Str)>0) then
            with WS.Range['a'+IntToStr(j+1),'iv'+IntToStr(j+1)] do  begin
              Font.Bold := True;
            end;
        end;
      end;
      aQuery.Next;
      Inc(j);
    end;
    { Добавляем строку с итогами. Lev 27.09.2009 г. }
    k:=-1;
    if Assigned(aGrid) and aGrid.Total then
      for i:=0 to aQuery.FieldCount-1 do
        with aQuery.Fields[i] do begin
          if aQuery.Fields[i].Visible then begin
            Inc(k);
            Str:=aGrid.ListTotal.GetItemValue(FieldName);
            if Str<>'' then v[j,k]:=Str;
          end;
          {Итоги выделяем жирным шрифтом}
          with WS.Range['a'+IntToStr(j+1),'iv'+IntToStr(j+1)] do Font.Bold:=True;
        end;
  finally
    aQuery.EnableControls;
  end;

(*
  WS.Cells.Range['a1',chr(ord('a')+varArrayHighBound(v, 2))+
    IntToStr(varArrayHighBound(v, 1)+1)].Borders[xlEdgeBottom].Color:=clBlack;
*)

(* Форматируем заголовок*)
  with WS.Range['a1','iv1'] do begin
    if (aFileName='') and (aGrid<>nil) then begin
      Font.Size:=aGrid.Titlefont.Size;
      Font.Name:=aGrid.TitleFont.Name;
    end else Font.Size:=8;
    Font.Bold := True;
    WrapText := True;
    HorizontalAlignment := xlCenter;
    VerticalAlignment := xlCenter;
    NumberFormat:='@'
  end;

  if (aNumList<>0) and (IndexTotal>0) then
    with WS.Range['a'+IntToStr(IndexTotal),'iv'+IntToStr(IndexTotal)] do begin
      if (aFileName='') and (aGrid<>nil) then begin
        Font.Size:=aGrid.Titlefont.Size;
        Font.Name:=aGrid.TitleFont.Name;
      end;
      {Font.Size := 8.5;}
      Font.Bold := True;
      {WrapText := True;}
      {HorizontalAlignment := xlCenter;}
      {VerticalAlignment := xlCenter;}
      {NumberFormat:='00.00';}
    end;

  WS.Cells.Range['a1',NameCell+IntToStr(varArrayHighBound(v, 1)+1)].value:=v;

(* Рисуем грид *)
  try
    WS.Cells.Range['a1',NameCell+IntToStr(varArrayHighBound(v, 1)+1)].Borders.Weight:=xlThin; // Установка толщины линий самой тонкой
    WS.Cells.Range['a1',NameCell+IntToStr(varArrayHighBound(v, 1)+1)].Borders.LineStyle:=xlContinuous; // Заголовок отчета и заголовки столбцов сплошной линией
    WS.Cells.Range['a2',NameCell+IntToStr(varArrayHighBound(v, 1)-1)].Borders[xlInsideHorizontal].Weight:=xlHairline; // Внутрення часть таблицы волосяной линией
    WS.Cells.Range['a2',NameCell+IntToStr(varArrayHighBound(v, 1)-1)].Borders[xlInsideVertical].Weight:=xlHairline;
  except
    ExApp.ScreenUpdating[0]:=true;
  end;

(*  WS.Range['a1',chr(ord('a')+varArrayHighBound(v, 2))+IntToStr(1)].Insert(xlShiftDown);*)
(* Вставляем строку для названия отчёта *)
  if (aNumList=0) or (aQuery.FieldCount<=PlaceL) then begin
    AddNameCell:=NameCell;
    WS.Range['a1',NameCell+'1'].Insert(xlShiftDown);
    if aReportCaption2<>'' then
      WS.Range['a2',NameCell+'2'].Insert(xlShiftDown)
  end else begin
    AddNameCell:='M';
    WS.Range['a1','M1'].Insert(xlShiftDown);
    WS.Range['N1',NameCell+'1'].Insert(xlShiftDown);
  end;

{* Форматируем строку с названием отчёта *}
  with WS.Range['a1',AddNameCell+'1'] do
    begin
      Font.Size := 9;
      Font.Bold := True;
      Font.Italic := True;
      WrapText := True;
      HorizontalAlignment := xlCenter;
      VerticalAlignment := xlCenter;
      Merge(7);
      Value := aReportCaption;
    end;
  if aReportCaption2<>'' then
    with WS.Range['a2',AddNameCell+'2'] do
      begin
        Font.Size := 9;
        Font.Bold := True;
        Font.Italic := True;
        WrapText := True;
        HorizontalAlignment := xlCenter;
        VerticalAlignment := xlCenter;
        Merge(7);
        Value := aReportCaption2;
      end;

  { Дальнейшее форматирование для Главной Книги }
  if aNumList<>0 then with WS do begin
    if aFieldCount+1>PlaceL then begin
      Range['N2','Y17'].Cut(Range['B18','M33']);
      Range['A2','A17'].Copy(Range['A18','A33']);
    end;
    if aFieldCount+1>=2*PlaceL then begin
      Range['Z2','AK17'].Cut(Range['B34','M48']);
      Range['A2','A17'].Copy(Range['A34','A48']);
    end;
    if aFieldCount+1>=3*PlaceL then begin
      Range['AL2','AW17'].Cut(Range['B50','M64']);
      Range['A2','A17'].Copy(Range['A50','A64']);
    end;
    if aFieldCount+1>=4*PlaceL then begin
      Range['AX2','BI17'].Cut(Range['B66','M80']);
      Range['A2','A17'].Copy(Range['A66','A80']);
    end;

    {WS.Range['A15','A15'].Select;}
    {V1:=WS.Range['A15','K28'].PasteSpecial(xlPasteAll,xlPasteSpecialOperationNone,false,false);}
  end;

(* Автоматический подбор ширины столбцов *)
{
WS.Cells.Range['a1',AddNameCell+IntToStr(varArrayHighBound(v, 1)+100)].AutoFormat(xlRangeAutoFormatSimple,
       false,
       false,
       false,
       false,
       false,
       true);
}
{ New Hi-Technology!!! Lev 27.09.2009. Супер-оптимальная ширина! }
with WS.Cells.Range['a1',AddNameCell+IntToStr(varArrayHighBound(v, 1)+100)] do begin
  ColumnWidth:=3;
  Columns.AutoFit;
end;

{ Дальнейшее форматирование для Главной Книги. Высота строк }
if aNumList<>0 then with WS do begin
  if aFieldCount+1>PlaceL then begin
    Range['B19','M32'].RowHeight:=11.9;
    Range['A19','A32'].RowHeight:=11.9;
  end;
  if aFieldCount+1>=2*PlaceL then begin
    Range['B35','M48'].RowHeight:=11.9;
    Range['A35','A48'].RowHeight:=11.9;
  end;
  if aFieldCount+1>=3*PlaceL then begin
    Range['B51','M64'].RowHeight:=11.9;
    Range['A51','A64'].RowHeight:=11.9;
  end;
  if aFieldCount+1>=4*PlaceL then begin
    Range['B67','M80'].RowHeight:=11.9;
    Range['A67','A80'].RowHeight:=11.9;
  end;
end;
  try
    ExApp._Run2(aMacroName,
      null,null,null,null,null,null,null,null,null,null,
      null,null,null,null,null,null,null,null,null,null,
      null,null,null,null,null,null,null,null,null,null,0);
  except
    ExApp.ScreenUpdating[0]:=true;
  end;
  ExApp.ScreenUpdating[0]:=true;
  ExApp.ActivePrinter[0]:=aDefaultPrinter;
(*
  WS.Cells.Range['a1',chr(ord('a')+varArrayHighBound(v, 2))+
    IntToStr(varArrayHighBound(v, 1)+1)].BorderAround(
      xlDouble,xlMedium,xlColorIndexAutomatic,xlColor3)
*)
end;
end.