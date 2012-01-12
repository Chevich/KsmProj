unit EtvPrint;

interface

uses Windows, Classes, DB, SysUtils, WinSpool, graphics;

type
TPrintMode=(pmText,pmGraphics,pmFile);
TTextFont=(tfDefault,tfNormal,tfElite,tfCondensed,tfCondensedElite);

TEtvPrintSet=class
protected
  fDataset:TDataset;
public
  Mode:TPrintMode;
  Copies:word;
  PrintRange:word; (* 0 All, 1 select *)
  PrintRangeStr,
  Title,
  FileName:string;

  PageHeight,
  PageWidth:smallint;
  Portrait:boolean;
  MarginTop,
  MarginLeft,
  MarginRight,
  MarginBottom:smallint;
  WithoutPages:boolean;

  Numbering,
  NumberOnFirstPage:boolean;
  NumberTop:boolean;
  NumberH:TAlignment;
  NumberFirstPage:integer;
  NumberFormat:string;
  NumberFont:TFont;

  TextModeFont:TTextFont; (* Default; Normal; Elite; Condensed; Condensed elite *)
  TitleFont:TFont;
  TextFont:TFont;
  Interval:real;
  constructor Create;
  Destructor Destroy; override;
  procedure SetTitle(aValue:string; aDataset:TDataset);
end;

TEtvPrinter=class
protected
  FPrintMode:TPrintMode;
  DrInfo:PPrinterInfo2;
  DocI:PDocInfo1A;
  HandlePrinter:THandle;
  NamePrinter,DriverPrinter:array[0..254] of char;
  fPrinting:boolean;
  Fprn:TextFile;
  fMaxBuffer:integer;
  fDeviceMode:THandle;
  fStr2PChar:pointer;
  fMaxStrLength:smallint;
  fPrintSet:TEtvPrintSet;
  fMaxPage,fCurPage,x,y,MaxX,MaxY,FullY,MinX,MinY:integer;
  fCurPagePrinting,fPageNeedPrint:boolean;
  fCurPageText:string;
  fListPages:TStrings;

  procedure SetMaxStrLength(ALength:smallint);
  procedure InitPage;
  procedure CloseCanal;
  procedure SetPrintMode(aPrintMode:TPrintMode);
  procedure CalcPagePrint;
  procedure CheckPagePrint;
  procedure SimplePrintStr(s:string);
  procedure PrintBottom;  {Used for text and file mode}
public
  constructor Create;
  destructor Destroy; override;
  function BeginDoc(aPrintSet:TEtvPrintSet):boolean; dynamic;
  procedure EndDoc; dynamic;
  procedure Abort; dynamic;
  procedure NewPage; dynamic;
  procedure PrintStr(aStr:string);
  procedure PrintStrings(Strings:TStrings);
  function PrintStillNeed:boolean;
  property MaxStrLength:smallint read fMaxStrLength write SetMaxStrLength;
  property PrintMode:TPrintMode read fPrintMode write SetPrintMode;
end;

function EtvPrinter:TEtvPrinter;

function PrintLine(length:smallint):string;

var FileForPrint:string='Printer.';

(* Data print *)
function DataSetPrintTitle(ADataSet:TDataSet; PrFields:string):string;
function DataSetPrintRecord(ADataSet:TDataSet; PrFields:string):string;
  (* print of record n=0 - vertical, else upon width n
     separate - separate between title and value, if ='' - title on top *)
procedure DataSetPrintOneRecord(ADataSet:TDataSet; PrFields:string;Strings:tstrings;
                 n:smallint; Separate:string);
procedure DataSetPrintData(ADataSet:TDataSet; PrFields:string;Strings:tstrings;
             aNumber:byte; aTitle:boolean; SumFields:string);
procedure DataSetPrintMemos(ADataSet:TDataSet; Memos:string; Lines:TStrings);

function EtvPrintSet:TEtvPrintSet;

IMPLEMENTATION

Uses Printers,
     EtvConst,EtvPas,EtvDBFun;

type EPrinterError=class (EInOutError)
end;

var fEtvPrintSet:TEtvPrintSet;

function EtvPrintSet:TEtvPrintSet;
begin
  if not Assigned(fEtvPrintSet) then
    fEtvPrintSet:=TEtvPrintSet.Create;
  Result:=fEtvPrintSet;
end;

constructor TEtvPrintSet.Create;
begin
  inherited;
  Mode:=pmGraphics;
  Copies:=1;
  PrintRange:=0;

  PageHeight:=297;
  PageWidth:=210;
  Portrait:=true;
  MarginTop:=20;
  MarginLeft:=20;
  MarginRight:=15;
  MarginBottom:=20;
  WithoutPages:=false;

  Numbering:=True;
  NumberOnFirstPage:=False;
  NumberTop:=true;
  NumberH:=taCenter;
  NumberFirstPage:=1;
  NumberFormat:='- # -';

  TextModeFont:=tfNormal;
  Interval:=1;
  NumberFont:=TFont.Create;
  NumberFont.Name:='Arial';
  NumberFont.Size:=10;

  TitleFont:=TFont.Create;
  TitleFont.Name:='Arial';
  TitleFont.Size:=14;
  TitleFont.Style:=[fsBold,fsItalic];

  TextFont:=TFont.Create;
  TextFont.Name:='Courier New';
  TextFont.Size:=12;
end;

Destructor TEtvPrintSet.Destroy;
begin
  NumberFont.Free;
  TitleFont.Free;
  TextFont.Free;
  inherited;
end;

procedure TEtvPrintSet.SetTitle(aValue:string; aDataset:TDataset);
begin
  if (aDataSet=nil) or
     ((aDataSet<>fDataSet) and (aValue<>''))then Title:=aValue;
  fDataSet:=aDataSet;
end;

var fEtvPrinter:TEtvPrinter=nil;
constructor TEtvPrinter.Create;
begin
  inherited Create;
  DrInfo:=nil;
  DocI:=nil;
  {FTypeDoc:='EtvPrint';}
  fPrintMode:=pmText;
  fPrinting:=false;
  fMaxStrLength:=255;
  GetMem(fStr2PChar,fMaxStrLength);
  {CreateForTypePrinter;}
  fListPages:=TStringList.Create;
end;

destructor TEtvPrinter.Destroy;
begin
  if fPrinting then
    EndDoc;
  FreeMem(fStr2PChar,fMaxStrLength);
  fListPages.Free;
  inherited Destroy;
end;

procedure TEtvPrinter.CloseCanal;
begin
  if fPrintMode=pmText (* text mode *) then begin
    ClosePrinter(HandlePrinter);
    if Assigned(DrInfo) then begin
      FreeMem(DrInfo,fMaxBuffer);
      DrInfo:=nil;
    end;
    if Assigned (DocI) then begin
      FreeMem(DocI,SizeOf(TDocInfo1A));
      DocI:=nil;
    end;
  end;
end;

Function TEtvPrinter.BeginDoc(aPrintSet:TEtvPrintSet):boolean;
var Drivprn,Portprn:array [0..254] of char;
    cX,cY:integer;
    InitStr:string;
  procedure SetPrintProp;
  var XDivide,YDivide,XOfs,YOfs:integer;
  begin
    XDivide:=254;
    YDivide:=254;
    InitStr:='';
    if fPrintMode=pmText then begin
      {in symbol}
      if Assigned(fPrintSet) then begin
        case fPrintSet.TextModeFont of
          tfDefault: Cx:=100;
          tfNormal: begin Cx:=100; InitStr:=#27+'P'+#18; end;
          tfElite: begin Cx:=120; InitStr:=#27+'M'+#18; end;
          tfCondensed: begin Cx:=170; InitStr:=#27+'P'+#15 end;
          tfCondensedElite: begin Cx:=200{72}; InitStr:=#27+'M'+#15 end;
          else cX:=100;
        end;
        cY:=trunc(fPrintSet.Interval*36);
      end else begin
        cx:=100;
        InitStr:=#27+'P'+#18;
        cY:=36;
      end;
      InitStr:=InitStr+#27+'3'+chr(cY);
      XOfs:=GetDeviceCaps(Printer.Handle,PHYSICALOFFSETX)*Cx div
        GetDeviceCaps(Printer.Handle,LOGPixelsX) div 10;
      YOfs:=GetDeviceCaps(Printer.Handle,PHYSICALOFFSETY)*216 div
        GetDeviceCaps(Printer.Handle,LOGPixelsY) div cY;
      yDivide:=254*cy;
      cy:=2160;
    end else if fPrintMode=pmGraphics then begin
      {in pixels}
      cX:=GetDeviceCaps(Printer.Handle,LOGPixelsX)*10;
      cY:=GetDeviceCaps(Printer.Handle,LOGPixelsY)*10;
      XOfs:=GetDeviceCaps(Printer.Handle,PHYSICALOFFSETX);
      YOfs:=GetDeviceCaps(Printer.Handle,PHYSICALOFFSETY);
    end else begin
      cx:=100;
      cY:=36;
      XOfs:=0;
      YOfs:=0;
    end;
    if Assigned(fPrintSet) then begin
      if fPrintSet.Portrait then
        Printer.Orientation:=poPortrait
      else Printer.Orientation:=poLandscape;
      Printer.Copies:=fPrintSet.Copies;
      MinX:=fPrintSet.MarginLeft*cX div XDivide-xOfs;
      MinY:=fPrintSet.MarginTop*cY div YDivide-yOfs;
      MaxX:=(fPrintSet.PageWidth-fPrintSet.MarginRight)*cX div XDivide-xOfs;
      MaxY:=(fPrintSet.PageHeight-fPrintSet.MarginBottom)*cY div YDivide-yOfs;
      FullY:=(fPrintSet.PageHeight)*cY div YDivide-yOfs;
      fCurPage:=fPrintSet.NumberFirstPage;
    end else begin
      Printer.Copies:=1;
      MinX:=10*cX div XDivide-XOfs;
      MinY:=(10)*cY div YDivide-YOfs;
      if fPrintMode=pmGraphics then begin
        MaxX:=Printer.PageWidth-(10*cX div XDivide)-xOfs;
        MaxY:=Printer.PageHeight-(10*cY div YDivide)-yOfs;
        FullY:=Printer.PageHeight-Yofs;
      end else begin
        MaxX:=(GetDeviceCaps(Printer.Handle,HORZSIZE)-10)*cX div XDivide-xOfs;
        FullY:=GetDeviceCaps(Printer.Handle,VERTSIZE)*cY div YDivide-yOfs;
        MaxY:=FullY-(10*cY div YDivide);
      end;
      fCurPage:=1;
    end;
    x:=MinX;
    y:=MinY;
    CalcPagePrint;
    CheckPagePrint;
    fCurPagePrinting:=fPageNeedPrint;
  end;

begin
  Result:=false;
  if Assigned(aPrintSet) then begin
    fPrintSet:=aPrintSet;
    PrintMode:=fPrintSet.Mode;
  end
  else fPrintSet:=nil;
  if fPrinting then raise EPrinterError.Create('Double BeginDoc');
  fPrinting:=true;
  try
    case fPrintMode of
      pmText: begin
        SetPrintProp;
        if PrintStillNeed then begin
          Printer.GetPrinter(NamePrinter,DrivPrn,PortPrn,fDeviceMode);
          if not OpenPrinter(NamePrinter,HandlePrinter,nil) then
            raise EPrinterError.Create(SPrinterError);
          GetPrinter(HandlePrinter,2,nil,0,@fMaxBuffer);
          GetMem(DrInfo,fMaxBuffer);
          if not GetPrinter(HandlePrinter,2,DrInfo,fMaxBuffer,@fMaxBuffer) then begin
            CloseCanal;
            raise EPrinterError.Create(SPrinterError);
          end;

          GetMem(DocI,SizeOf(TDocInfo1A));
          DocI^.pDocName:='EtvPrint';
          DocI^.pOutPutFile:=nil;
          DocI^.pDatatype:=nil;
          if StartDocPrinter(HandlePrinter,1,DocI)=0 then begin
            CloseCanal;
            raise EPrinterError.Create(SPrinterOpenDocError);
          end;
          SimplePrintStr(InitStr);
          InitPage;
          if Assigned(fPrintSet) then PrintStr(fPrintSet.Title);
        end else raise EPrinterError.Create(SPrinterNothingToPrintError);
      end;
      pmGraphics: begin
        SetPrintProp;
        if PrintStillNeed then begin
          Printer.BeginDoc;
          InitPage;
        end else raise EPrinterError.Create(SPrinterNothingToPrintError);
        if Assigned(fPrintSet) then begin
          Printer.Canvas.Font.Assign(fPrintSet.TitleFont);
          PrintStr(fPrintSet.Title);
          Printer.Canvas.Font.Assign(fPrintSet.TextFont);
        end else begin
          Printer.Canvas.Font.Name:='Courier New';
          Printer.Canvas.Font.Size:=12;
          Printer.Orientation:=poPortrait;
          Printer.Title:='EtvPrint';
        end;
      end;
      pmFile: begin
        if Assigned(fPrintSet) and (fPrintSet.FileName<>'') then
          AssignFile(fprn,fPrintSet.FileName)
        else AssignFile(fprn,FileForPrint);
        {$I-}
        Rewrite(Fprn);
        {$I+}
        if IOResult<>0 then
          raise EPrinterError.Create(SPrinterOpenFileError);
        SetPrintProp;
        if PrintStillNeed then InitPage;
        if Assigned(fPrintSet) then PrintStr(fPrintSet.Title);
      end;
    end; {case}
  except
    fPrinting:=false;
    Exit;
  end;
  Result:=true;
end;

procedure TEtvPrinter.EndDoc;
begin
  if not fPrinting then
    raise EPrinterError.Create('EndDoc without BeginDoc');
  try
    case fPrintMode of
      pmText:begin
        try
          if fPageNeedPrint then PrintBottom;
          PrintStr(#27+'@');
          if Not EndDocPrinter(HandlePrinter) then
            raise EPrinterError.Create(SPrinterCloseDocError);
        finally
          CloseCanal;
        end;
      end;
      pmGraphics: Printer.EndDoc;
      pmFile: begin
        if fPageNeedPrint then PrintBottom;
        CloseFile(FPrn);
      end;
    end;
  finally
    fPrinting:=false;
  end;
end;

procedure TEtvPrinter.Abort;
begin
  if not fPrinting then
    raise EPrinterError.Create('EndDoc without BeginDoc');
  try
    case fPrintMode of
      pmText:begin
        try
          PrintStr(#27+'@');
          if Not EndDocPrinter(HandlePrinter) then
            raise EPrinterError.Create(SPrinterCloseDocError);
        finally
          CloseCanal;
        end;
      end;
      pmGraphics: Printer.Abort;
      pmFile: CloseFile(FPrn);
    end;
  finally
    fPrinting:=false;
  end;
end;

procedure TEtvPrinter.NewPage;
begin
  case fPrintMode of
    pmText,pmFile:begin
      if fPageNeedPrint then PrintBottom;
      Y:=MinY;
      Inc(fCurPage);
      CheckPagePrint;
      if fPageNeedPrint then begin
        fCurPagePrinting:=true;
        InitPage;
      end;
    end;
    pmGraphics: begin
      Y:=MinY;
      Inc(fCurPage);
      CheckPagePrint;
      if fPageNeedPrint then begin
        if fCurPagePrinting then Printer.NewPage;
        fCurPagePrinting:=true;
        InitPage;
      end;
    end;
  end;
end;

procedure TEtvPrinter.SimplePrintStr(s:string);
var strT:string; plen:dword;
  procedure Char2OEM;
  begin
    if length(S)>fMaxStrLength then
      CharToOEMBuff(PChar(s),fStr2PChar,fMaxStrLength)
    else CharToOEM(PChar(s),fStr2PChar);
    strT:=StrPas(fStr2PChar);
  end;
begin
  case fPrintMode of
    pmText: begin Char2OEM;
      if Not writePrinter(HandlePrinter,Pchar(strT),length(strT),plen) then
        raise EPrinterError.Create(SPrinterProcessDocError);
    end;
    pmFile: begin
      {$I-}
      write(Fprn,S);
      {$I+}
      if IOResult<>0 then
        EPrinterError.Create(SPrinterProcessFileError);
    end;
  end;
end;

procedure TEtvPrinter.PrintStr(aStr:string);
var i,yInc:integer;
    R:TRect;
    lTextMetric:TTextMetric;
  procedure PrintOneStr(aStr:string);
  begin
    case fPrintMode of
      pmText:begin
        if Y>=MaxY then NewPage;
        if fPageNeedPrint then
          SimplePrintStr(copy(sform('',MinX-1,taLeftJustify)+aStr,1,MaxX)+#13#10);
        Inc(y);
      end;
      pmFile:begin
        if Y>=MaxY then NewPage;
        if fPageNeedPrint then
          SimplePrintStr(aStr+#13#10);
        Inc(y);
      end;
      pmGraphics: begin
        if Y+Abs(Printer.Canvas.Font.Height)>MaxY then NewPage;
        if fPageNeedPrint then begin
          R.Left:=X;
          R.Top:=Y;
          R.Right:=MaxX;
          R.Bottom:=MaxY{Y-Printer.Canvas.Font.Height};
          Printer.Canvas.TextRect(R,x,y,aStr);
        end;
        GetTextMetrics(Printer.Canvas.Handle,lTextMetric);
        yInc:=lTextMetric.tmHeight+lTextMetric.tmExternalLeading;
        if Assigned(fPrintSet) then
          yInc:=trunc(yInc*fPrintSet.Interval);
        y:=y+yInc;
      end;
      {pmFile: SimplePrintStr(aStr+#13#10);}
    end; {case}
  end;
begin
  if not fPrinting then raise EPrinterError.Create('Print without BeginDoc');

  i:=Pos(#12,aStr);
  if i>0 then begin
    PrintStr(Copy(aStr,1,i-1));
    NewPage;
    if i+1<=Length(aStr) then
      PrintStr(Copy(aStr,i+1,MaxInt));
  end else begin
    i:=Pos(#13+#10,aStr);
    if i<=0 then i:=Pos(#10+#13,aStr);
    if i>0 then begin
      PrintStr(Copy(aStr,1,i-1));
      if i+2<=Length(aStr) then
        PrintStr(Copy(aStr,i+2,MaxInt))
      else PrintStr('');
    end else PrintOneStr(aStr);
  end;
end;

procedure TEtvPrinter.CalcPagePrint;
var s:string;
    iMax,i,l:integer;
begin
  if Assigned(fPrintSet) and (fPrintSet.PrintRange=1) then begin
    fMaxPage:=0;
    fListPages.Clear;
    i:=1;
    s:='';
    l:=Length(fPrintSet.PrintRangeStr);
    while i<=l do begin
      s:='';
      while (i<=L) and (fPrintSet.PrintRangeStr[i] in ['0'..'9','-']) do begin
        s:=s+fPrintSet.PrintRangeStr[i];
        inc(i);
      end;
      if s<>'' then begin
        if pos('-',s)>0 then
          iMax:=StrToIntDef(copy(s,pos('-',s)+1,MaxInt),0)
        else iMax:=StrToIntDef(s,0);
        if iMax>0 then fListPages.Add(s);
        if fMaxPage<iMax then fMaxPage:=iMax;
      end;
      while (i<=L) and (not (fPrintSet.PrintRangeStr[i] in ['0'..'9','-'])) do
        inc(i);
    end;
  end else fMaxPage:=MaxInt;
end;

procedure TEtvPrinter.CheckPagePrint;
var iMin,iMax,i:integer;
    s:string;
begin
  if Assigned(fPrintSet) and (fPrintSet.PrintRange=1) then begin
    fPageNeedPrint:=false;
    if PrintStillNeed then for i:=0 to fListPages.Count-1 do begin
      s:=fListPages[i];
      if pos('-',s)>0 then begin
        iMin:=StrToIntDef(copy(s,1,pos('-',s)-1),MaxInt);
        iMax:=StrToIntDef(copy(s,pos('-',s)+1,MaxInt),0);
        if (fCurPage>=iMin) and (fCurPage<=iMax) then begin
          fPageNeedPrint:=true;
          break;
        end;
      end else if StrToIntDef(s,0)=fCurPage then begin
        fPageNeedPrint:=true;
        Break;
      end;
    end;
  end else fPageNeedPrint:=true;
end;

procedure TEtvPrinter.PrintStrings(Strings:TStrings);
var i:integer;
begin
  if not fPrinting then raise EPrinterError.Create('Print without BeginDoc');
  for i:=0 to Strings.count-1 do
    PrintStr(Strings[i]);
end;

function TEtvPrinter.PrintStillNeed:boolean;
begin
  Result:=fMaxPage>=fCurPage;
end;

procedure TEtvPrinter.SetPrintMode(aPrintMode:TPrintMode);
begin
  if fPrinting then EndDoc;
  fPrintMode:=aPrintMode;
end;

procedure TEtvPrinter.SetMaxStrLength(aLength:smallint);
begin
  FreeMem(fStr2PChar,fMaxStrLength);
  fMaxStrLength:=aLength;
  GetMem(fStr2PChar,fMaxStrLength);
end;

procedure TEtvPrinter.InitPage;
var i:integer;
    R:TRect;
begin
  fCurPageText:='';
  if fPageNeedPrint and fCurPagePrinting then begin
    if Assigned(fPrintSet) then With fPrintSet do
      if Numbering and
         (NumberOnFirstPage or (fCurPage>NumberFirstPage)) then begin
        i:=Pos('#',NumberFormat);
        if i>0 then fCurPageText:=Copy(NumberFormat,1,i-1)+IntToStr(fCurPage)+
          Copy(NumberFormat,i+1,maxInt)
        else fCurPageText:='- '+IntToStr(fCurPage)+' -';

        case fPrintMode of
          pmText,pmFile: begin
            i:=length(fCurPageText);
            case NumberH of
              taLeftJustify:  i:=MinX;
              taCenter:       i:=(MaxX-MinX+i) div 2+MinX;
              taRightJustify: i:=MaxX-i;
            end;
            fCurPageText:=sForm(' ',i,taCenter)+fCurPageText;
          end;
          pmGraphics: begin
            Printer.Canvas.Font.Assign(fPrintSet.NumberFont);
            i:=Printer.Canvas.TextWidth(fCurPageText);
            case NumberH of
              taLeftJustify: {Left} R.Left:=MinX;
              taCenter: {Center} R.Left:=(MaxX-MinX+i) div 2+MinX;
              taRightJustify: {Right} R.Left:=MaxX-i;
            end;
            if NumberTop then begin
              R.Top:=MinY-Abs(Printer.Canvas.Font.Height)*2;
              if R.Top<0 then R.Top:=0;
            end else begin
              R.Top:=FullY-2*Abs(Printer.Canvas.Font.Height);
              if R.Top<MaxY then R.Top:=MaxY;
            end;
            R.Right:=MaxX;
            R.Bottom:=FullY;
            Printer.Canvas.TextRect(R,R.Left,R.Top,fCurPageText);
            Printer.Canvas.Font.Assign(fPrintSet.TextFont);
          end;
        end;
      end;
    if (fPrintMode in [pmText,pmFile]) and
       (Not (Assigned(fPrintSet) and fPrintSet.WithoutPages)) then
      for i:=0 to MinY-2 do begin
        if Assigned(fPrintSet) and fPrintSet.NumberTop and
           ((i=1) or (MinY=2)) then SimplePrintStr(fCurPageText);
        SimplePrintStr(#13#10);
      end;
  end;
end;

procedure TEtvPrinter.PrintBottom;
var i:integer;
begin
  if Not (Assigned(fPrintSet) and fPrintSet.WithoutPages) then begin
    if Assigned(fPrintSet) and (not fPrintSet.NumberTop) and
       (fCurPageText<>'') then begin
      for i:=y to FullY-4 do
        SimplePrintStr(#13#10);
      SimplePrintStr(fCurPageText);
    end;
    SimplePrintStr(#12);
  end;
end;

function EtvPrinter:TEtvPrinter;
begin
  if fEtvPrinter=nil then
    fEtvPrinter:=TEtvPrinter.Create;
  Result := fEtvPrinter;
end;

function PrintLine(Length:smallint):string;
var i:smallint;
begin
  Result:='';
  for i:=1 to length do
    Result:=Result+'-';
end;

{DataPrint}
function DataSetPrintedField(ADataSet:TDataSet; PrFields:string; field:tField):boolean;
var Pos: Integer;
begin
  with ADataSet do begin
    Result:=false;
    if PrFields=AllFields then begin Result:=true; Exit; end;
    if PrFields=UserFields then begin
      if(field.tag<>8) then Result:=true;
      Exit;
    end;
    if PrFields=VisibleFields then begin
      if (Field.tag<>8) and (Field.visible) then Result:=true;
      Exit;
    end;
    Pos:= 1;
    while Pos <= Length(PrFields) do
      if Field=FieldByName(ExtractFieldName(PrFields, Pos)) then begin
        Result:=true;
        exit;
      end;
  end;
end;

function DataSetPrintTitle(ADataSet:TDataSet; PrFields:string):string;
var i,j:smallint;
begin
  (* Header *)
  Result:='';
  with ADataSet do
    for i:=0 to FieldCount-1 do
      if DataSetPrintedField(ADataSet,PrFields,fields[i]) then begin
        if Result<>'' then Result:=Result+'|';
        j:=length(fields[i].DisplayLabel);
        if fields[i].displaywidth>j then j:=fields[i].displaywidth;
        Result:=Result+sform(fields[i].displayLabel,j,taCenter);
      end;
end;

type TFieldSelf=class(TField)
end;

function DataSetPrintRecord(ADataSet:TDataSet; PrFields:string):string;
var i,j:smallint;
    s:string;
begin
  Result:='';
  With ADataSet do
    for i:=0 to FieldCount-1 do
      if DataSetPrintedField(ADataSet,PrFields,fields[i]) then begin
        if Result<>'' then Result:=Result+'|';
        j:=length(fields[i].DisplayLabel);
        if fields[i].displaywidth>j then j:=fields[i].displaywidth;
        TFieldSelf(Fields[i]).GetText(s,true);
        Result:=Result+sform(s{Fields[i].AsString},j,Fields[i].Alignment);
      end;
end;

procedure DataSetPrintOneRecord(ADataSet:TDataSet; PrFields:string;Strings:tstrings;
                 n:smallint; Separate:string);
var i,j,k,lenLabel:smallint;
    s,s0,s1:string;
begin
  s:='';
  s1:='';
  LenLabel:=0;
  With ADataSet do begin
    if n=0 then begin
      for i:=0 to FieldCount-1 do
        if DataSetPrintedField(ADataSet,PrFields,fields[i]) and
           (LenLabel<length(fields[i].DisplayLabel)) then
          LenLabel:=length(fields[i].DisplayLabel);
    end;
    for i:=0 to FieldCount-1 do
      if DataSetPrintedField(ADataSet,PrFields,fields[i]) then begin
        j:=length(fields[i].DisplayLabel);
        if fields[i].displaywidth>j then j:=fields[i].displaywidth;
        if Separate='' then k:=j
        else k:=length(fields[i].DisplayLabel)+1+length(separate)+1+j;
        if (Length(s0)+k>n) and (s0<>'') then begin
          Strings.Add(s0);
          if Separate='' then Strings.Add(s1);
          s0:='';
          s1:='';
        end;
        TFieldSelf(Fields[i]).GetText(s,true);
        if Separate<>'' then begin
          if n<>0 then s0:=s0+Fields[i].displayLabel
          else s0:=sform(Fields[i].DisplayLabel,LenLabel,taLeftJustify);
          s0:=s0+' '+Separate+' '+sform(s,j,taLeftJustify);
        end else begin
          s0:=s0+sform(Fields[i].displayLabel,j,tacenter);
          s1:=s1+sform(s,j,taLeftJustify);
        end;
      end;
    Strings.Add(s0);
    if Separate='' then Strings.Add(s1);
  end;
end;

procedure DataSetPrintData(ADataSet:TDataSet; PrFields:string; Strings:tstrings;
            aNumber:byte; aTitle:boolean; SumFields:string);
var bm:TBookMark;
    s:string;
    i,j,k:smallint;
    num:integer;
    List:TList;
    Sums,CurSums:variant;
    Exist:boolean;
begin
  if Assigned(ADataSet)and ADataSet.Active then begin
    num:=0;
    List:=Tlist.Create;
    with ADataSet do try
      DisableControls;
      bm:=GetBookMark;
      First;
      if SumFields<>'' then begin
        GetFieldList(List,SumFields);
        Sums:=varArrayCreate([0,List.Count-1],varVariant);
        for i:=0 to list.Count-1 do
          Sums[i]:=0;
      end;
      if aTitle then begin
        s:=DataSetPrintTitle(ADataSet,PrFields);
        if aNumber>0 then s:=sform('|',aNumber+1,taRightJustify)+s;
        Strings.Add(s);
        (* Separate*)
        Strings.Add(PrintLine(Length(s)));
      end;
      (* Data *)
      While Not EOF do begin
        s:=DataSetPrintRecord(ADataSet,PrFields);
        if aNumber>0 then begin
          Inc(Num);
          s:=sform(intToStr(Num)+'|',aNumber+1,taRightJustify)+s;
        end;
        Strings.Add(s);
        if SumFields<>'' then begin
          CurSums:=FieldValues[SumFields];
          for i:=0 to list.Count-1 do
            if CurSums[i]<>null then Sums[i]:=Sums[i]+CurSums[i];
        end;
        Next;
      end;
      if SumFields<>'' then begin (* Totals *)
        Strings.Add(PrintLine(length(s)));
        if aNumber>0 then s:=sform('',aNumber+1,taCenter);
        for i:=0 to FieldCount-1 do begin
          if i>0 then s:=s+' ';
          j:=length(fields[i].DisplayLabel);
          if fields[i].displaywidth>j then j:=fields[i].displaywidth;
          Exist:=false;
          for k:=0 to List.Count-1 do
            if Fields[i]=TField(List[k]) then begin
              Exist:=true;
              if Fields[i] is tIntegerField then
                s:=s+sform(IntToStr(Sums[k]),j,Fields[i].Alignment)
              else
              if Fields[i] is tFloatField then
                s:=s+sform(FormatFloat(TFloatField(Fields[i]).DisplayFormat,Sums[k]),j,Fields[i].Alignment)
              else Exist:=false;
            end;
          if not Exist then s:=s+sform('',j,Fields[i].Alignment)
        end;
        Strings.Add(s);
      end;
      gotobookmark(bm);
      freebookmark(bm);
      EnableControls;
    finally
      List.free;
    end;
  end;
end;

procedure DataSetPrintMemos(ADataSet:TDataSet; Memos:string; Lines:tstrings);
var s:string;
    Exist:smallint;
    k,i,j,i0,L,predWidth:integer;
    List:TList;
    Str:TStringlist;
begin
  List:=TList.create;
  ADataSet.GetFieldList(List,Memos);
  Str:=TStringList.Create;
  L:=Lines.count;
  PredWidth:=0;

  for k:=0 to list.count-1 do begin
    Str.Clear;
    i:=0;
    s:=TField(List[k]).AsString;
    while i<Length(s) do begin
      Exist:=0;
      i0:=i+TField(List[k]).DisplayWidth;
      if i0>length(s) then begin
        i0:=length(s);
        Exist:=1;
      end;
      if pos(#13#10,copy(s,i+1,i0-i))>0 then begin
        i0:=i+pos(#13#10,copy(s,i+1,i0-i))-1;
        Exist:=2;
      end;
      if exist=0 then if pos(' ',copy(s,i+2,i0-i))>0 then
        while s[i0]<>' ' do dec(i0);
      str.Add(sform(copy(s,i+1,i0-i),TField(List[k]).DisplayWidth,taLeftJustify));
      if Exist<>2 then i:=i0 else i:=i0+2;
    end;

    while Str.count>Lines.count-L do Lines.Add(sform('',PredWidth,taCenter));

    if k=0 then s:='' else s:='   ';
    for j:=L to Lines.count-1 do
      if str.count>j-L then Lines[j]:=Lines[j]+s+Str[j-L]
      else Lines[j]:=Lines[j]+sform('',TField(List[k]).DisplayWidth,taCenter)+s;
    PredWidth:=PredWidth+TField(List[k]).DisplayWidth+length(s);
  end;
  Str.free;
  List.free;
end;

initialization

finalization
  if Assigned(fEtvPrintSet) then fEtvPrintSet.Free;
  if Assigned(fEtvPrinter) then fEtvPrinter.Free;
end.
