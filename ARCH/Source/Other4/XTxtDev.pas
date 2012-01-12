Unit XTxtDev;

Interface

Uses Classes, ppDrwCmd, ppDevice, ppForms, XTxtPrn;

type

{ TXTextPrintDevice }

  TXTextPrintDevice = class(TppDevice)
  private
    FFirstPage: Boolean;
    FSkipLines: Byte;
    FOffsetX: Integer;
    FOffsetY: Integer;
    FCharWidth: Integer;
    FCharHeight: Integer;
    FCancelDialog: TppCustomCancelDialog;
    FCollatedCopies: Integer;
    FPrinter: TXTextPrinter;
    FTopOffset: Integer;
    FGroupCommands: TList;
    procedure DisplayMessage(aPage: TppPage);
    procedure StartPage(aPage: TppPage);
    procedure EndPage(apage: TppPage);
    procedure SetDrawCommand(ADrawCommand: TppDrawCommand);
    procedure DrawTextCommands;
  protected
    function  CheckEndJob: Boolean; virtual;
    procedure DrawText(aDrawText: TppDrawText); virtual;
    procedure DrawShape(aDrawShape: TppDrawShape); virtual;
    procedure DrawLine(aDrawLine: TppDrawLine); virtual;
    procedure DrawImage(aDrawImage: TppDrawImage); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CalcDrawPosition(aDrawCommand: TppDrawCommand);
    function  Draw(aDrawCommand: TppDrawCommand): Boolean; override;
    procedure StartJob; override;
    procedure EndJob; override;
    procedure CancelJob; override;
    procedure ReceivePage(aPage: TppPage); override;
    property Printer: TXTextPrinter read FPrinter;
    property CancelDialog: TppCustomCancelDialog read FCancelDialog write FCancelDialog;
  end;
{ TXTextPrintDevice }

Implementation

Uses Windows, SysUtils, Forms, ppTypes, ppUtils, XMisc, XReports;

{ TXTextPrintDevice }

Constructor TXTextPrintDevice.Create(aOwner: TComponent);
begin
  Inherited Create(AOwner);
  FCancelDialog:=nil;
  FCollatedCopies:=1;
  FFirstPage:=True;
  FPrinter:=TXTextPrinter.Create;
  FGroupCommands:=TList.Create;
{  GetMem(FBufferStr,255);}
end;

Destructor TXTextPrintDevice.Destroy;
begin
  FGroupCommands.Free;
  FPrinter.Free;
{  FreeMem(FBufferStr,255);}
  Inherited;
end;

Procedure TXTextPrintDevice.StartJob;
var Rep: TXDBReport;
    aWidth, AHeight: Integer;
begin
  if (Busy) then Exit;
  Inherited StartJob;
  Rep:= TXDBReport(owner);
  with Rep do begin
    if PrintLink.TextLink.SkipTextLines then FSkipLines:= 2 else FSkipLines:= 1;
    GetFontCharSizes(PrintLink.Font, FCharWidth, FCharHeight);
    {Inc(FCharHeight,8);}
    FCharHeight:=26;
    aWidth:=1+ppToScreenPixels(PrinterSetup.PaperWidth, Units, pprtHorizontal, Nil) div FCharWidth;
    aHeight:=FSkipLines*(1+ppToScreenPixels(PrinterSetup.Paperheight, Units, pprtVertical, Nil) div FCharHeight);
    {
    aWidth:=TRunc(aWidth/Screen.PixelsPerInch/2.54);
    aHeight:=TRunc(aHeight/Screen.PixelsPerInch/2.54);
    }
    if PrintLink.TextLink.SkipTextLines then begin
       FPrinter.InitLine:= #27'A'#6;
       FPrinter.DoneLine:= #27'A'#12;
    end;
    case PrintLink.TextLink.TypeNLQ of
      nxDraft: FPrinter.InitLine:= FPrinter.InitLine+#27'x'#0;
      nxRoman:
        begin
          FPrinter.InitLine:= FPrinter.InitLine+#27'x'#1#27'k'#0;
          FPrinter.DoneLine:= #27'x'#0+FPrinter.DoneLine;
        end;
      nxSansSerif:
        begin
          FPrinter.InitLine:= FPrinter.InitLine+#27'x'#1#27'k'#1;
          FPrinter.DoneLine:= #27'x'#0+FPrinter.DoneLine;
        end;
    end;
    case PrintLink.TextLink.TypeText of
      txNormal: FPrinter.InitLine:=FPrinter.InitLine+#27+'!'+#0;
      txElite:
        begin
          FPrinter.InitLine:= FPrinter.InitLine+#27+'!'+#1;
          FPrinter.DoneLine:= #27+'!'+#0+FPrinter.DoneLine;
        end;
      txSmall:
        begin
          FPrinter.InitLine:= FPrinter.InitLine+#27+'!'+#4;
          FPrinter.DoneLine:= #27+'!'+#0+FPrinter.DoneLine;
        end;
      txSmallElite:
        begin
          FPrinter.InitLine:= FPrinter.InitLine+#27'!'#5;
          FPrinter.DoneLine:= #27'!'#0+FPrinter.DoneLine;
        end;
    end;
  end;
  FPrinter.Canvas.SetBounds(aWidth+2, aHeight);
  FPrinter.BeginDoc;
end;

Procedure TXTextPrintDevice.EndJob;
begin
  if not(Busy) then Exit;
  if not CheckEndJob then Exit;
  {end print job }
  FPrinter.EndDoc;
  Inherited EndJob;
end;

Function TXTextPrintDevice.CheckEndJob;
begin
  {check whether all copies have been printed}
  Result:=(FCollatedCopies = 1);
  if Result then Exit;
  {print another copy}
  FCollatedCopies:=FCollatedCopies-1;
  MakePageRequest;
end;

Procedure TXTextPrintDevice.CancelJob;
begin
  FPrinter.EndDoc;
  Inherited CancelJob;
end;

Procedure TXTextPrintDevice.ReceivePage(aPage: TppPage);
begin
  {are we receiving a page we requested?}
  Inherited ReceivePage(aPage);
  {have we started the print job?}
  if not(Busy) then Exit;
  if IsRequestedPage then begin
    DisplayMessage(aPage);
    if not(IsMessagePage) then begin
      StartPage(aPage);
      DrawPage(aPage);
      EndPage(aPage);
    end;
  end;
end;

Procedure TXTextPrintDevice.StartPage(aPage: TppPage);
var i, ALeft: Integer;
begin
  {setup printer and start a new page}
  FPrinter.PrinterSetup := aPage.PrinterSetup;
  FPrinter.StartPage;
{  APage.PageDef.spPrintableWidth;
  APage.PageDef.spPrintableHeight;}
  {set object position offsets to accomodate page gutters}
  FOffSetX := -FPrinter.PageGutters.Left;
  FOffSetY := -FPrinter.PageGutters.Top;
  {initialize collated copies counter}
  if FFirstPage then begin
    if {aPage.PrinterSetup.Collation}TRUE then
      FCollatedCopies := aPage.PrinterSetup.Copies;
    FFirstPage := False;
  end;
  FTopOffset:= 0;
end;

Procedure TXTextPrintDevice.EndPage(aPage: TppPage);
begin
  DrawTextCommands;
  FPrinter.EndPage;
end;

Procedure TXTextPrintDevice.DisplayMessage(aPage: TppPage);
var lsMessage: String;
begin
  if IsMessagePage and not Publisher.ReportCompleted then begin
    if (aPage.PassSetting = psOnePass) then Exit;
      {message: Calculating page <page> for report <documentname> }
      lsMessage:=LoadStr(aPage.LanguageIndex + ppMsgCalculating);
      lsMessage:=ppSetMessageParameters(lsMessage);
      lsMessage:=Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), aPage.DocumentName]);
  end
  else if (PageSetting = psAll) and (aPage.PassSetting = psTwoPass) then begin
    {message: Printing Page 1 of 15 for <reportname> on <printername>}
    lsMessage:=LoadStr(aPage.LanguageIndex + ppMsgPrintingPages);
    lsMessage:=ppSetMessageParameters(lsMessage);
    lsMessage:=Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), IntToStr(aPage.AbsolutePageCount),
      aPage.DocumentName, Printer.PrinterDescription]);
  end else begin
    {message: Printing Page 1 for <reportname> on <printername>}
    lsMessage:=LoadStr(aPage.LanguageIndex+ppMsgPrintingNoPC);
    lsMessage:=ppSetMessageParameters(lsMessage);
    lsMessage:=Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), aPage.DocumentName,
      Printer.PrinterDescription]);
  end;
  if (FCancelDialog<>nil) and (FCancelDialog.PrintProgress<>lsMessage) then begin
    FCancelDialog.PrintProgress:=lsMessage;
    Application.ProcessMessages;
  end;
end;

Procedure TXTextPrintDevice.CalcDrawPosition(aDrawCommand: TppDrawCommand);
begin
  {scale the bounding rectangle}
  aDrawCommand.DrawLeft:=FOffsetX+Trunc(ppFromMMThousandths(aDrawCommand.Left,
                            utPrinterPixels, pprtHorizontal, FPrinter));
  aDrawCommand.DrawTop:=FOffsetY+Trunc(ppFromMMThousandths(aDrawCommand.Top,
                            utPrinterPixels, pprtVertical, FPrinter));
  aDrawCommand.DrawRight:=FOffsetX+Trunc(ppFromMMThousandths((aDrawCommand.Left+aDrawCommand.Width),
                            utPrinterPixels, pprtHorizontal, FPrinter));
  aDrawCommand.DrawBottom:=FOffsetY+Trunc(ppFromMMThousandths((aDrawCommand.Top+aDrawCommand.Height),
                            utPrinterPixels, pprtVertical, FPrinter));
end;

Function TXTextPrintDevice.Draw(aDrawCommand: TppDrawCommand): Boolean;
begin
  Result:=True;
  CalcDrawPosition(aDrawCommand);
  if (aDrawCommand is TppDrawText) then DrawText(TppDrawText(aDrawCommand))
  else if (aDrawCommand is TppDrawShape) then DrawShape(TppDrawShape(aDrawCommand))
       else if (aDrawCommand is TppDrawLine) then DrawLine(TppDrawLine(aDrawCommand))
            else if (aDrawCommand is TppDrawImage) then DrawImage(TppDrawImage(aDrawCommand))
                 else Result := False;
end;

Procedure TXTextPrintDevice.DrawTextCommands;
var i, j: Integer;
    BDrawText: TppDrawText;
    ALeft, ARight, ATop: Integer;
begin
  for i:=0 to FGroupCommands.Count-1 do begin
    BDrawText:=TppDrawText(FGroupCommands[i]);
    ALeft:=BDrawText.DrawLeft div FCharWidth-Byte(BDrawText.Alignment=taRightJustify)+1;
    ARight:=(BDrawText.DrawRight div FCharWidth){-1};
    //ATop:= FSkipLines*((BDrawText.DrawTop{-6}) div (FCharHeight)){-1};
    ATop:= FSkipLines*Round((BDrawText.DrawTop+18)/(FCharHeight));
    if BDrawText.WrappedText.Count>0 then
      for j:=0 to BDrawText.WrappedText.Count-1 do
        FPrinter.Canvas.TextOutAlign(ALeft, ARight, ATop+j*FSkipLines,
          BDrawText.WrappedText[j], BDrawText.Alignment)
    else FPrinter.Canvas.TextOutAlign(ALeft, ARight, ATop, BDrawText.Text,
           BDrawText.Alignment);
  end;
  FGroupCommands.Clear;
end;

Procedure TXTextPrintDevice.DrawText(ADrawText: TppDrawText);
var i: Integer;
begin
  if FTopOffset<>ADrawText.DrawTop then begin
    DrawTextCommands;
    FTopOffset:= ADrawText.DrawTop;
  end;
  i:=0;
  while i<FGroupCommands.Count do begin
    if ADrawText.DrawLeft<TppDrawText(FGroupCommands[i]).DrawLeft then break;
    Inc(i);
  end;
  FGroupCommands.Insert(i, ADrawText);
end;

Procedure TXTextPrintDevice.DrawShape(aDrawShape: TppDrawShape);
var i: Integer;
begin
  i:=0;
end;

Procedure TXTextPrintDevice.SetDrawCommand(ADrawCommand: TppDrawCommand);
var i: Integer;
begin
  if FTopOffset<>ADrawCommand.DrawTop then begin
{!     DrawGroupCommands;}
    FTopOffset:= ADrawCommand.DrawTop;
  end;
  i:=0;
  while i < FGroupCommands.Count do begin
    if ADrawCommand.DrawLeft<TppDrawCommand(FGroupCommands[i]).DrawLeft then Break;
    Inc(i);
  end;
  FGroupCommands.Insert(i, ADrawCommand);
end;

Procedure TXTextPrintDevice.DrawLine(aDrawLine: TppDrawLine);
var ALeft, ARight, ATop, ABottom: Integer;
    AStr: String;
begin
  case aDrawLine.LinePosition of
    lpTop:
      begin
        ALeft:= ADrawLine.DrawLeft div FCharWidth;
        ARight:=ADrawLine.DrawRight div FCharWidth;
        ATop:= FSkipLines*(ADrawLine.DrawTop div FCharHeight);
        SetLength(AStr,ARight-ALeft+1);
        FillChar(AStr[1],ARight-ALeft+1,'-');
        FPrinter.Canvas.TextOutAlign(ALeft, ARight, ATop, AStr, taLeftJustify);
      end;
    lpBottom:
      begin
        ALeft:= ADrawLine.DrawLeft div FCharWidth;
        ARight:= ADrawLine.DrawRight div FCharWidth;
        ABottom:= FSkipLines*(ADrawLine.DrawBottom div FCharHeight);
        SetLength(AStr,ARight-ALeft+1);
        FillChar(AStr[1],ARight-ALeft+1,'-');
        FPrinter.Canvas.TextOutAlign(ALeft, ARight, ABottom, AStr, taLeftJustify);
      end;
    lpLeft:
      begin
        ATop:= FSkipLines*(ADrawLine.DrawTop div FCharHeight);
        ABottom:= FSkipLines*(ADrawLine.DrawBottom div FCharHeight);
        ALeft:= ADrawLine.DrawLeft div FCharWidth;
        SetLength(AStr,ABottom-ATop+1);
        FillChar(AStr[1],ABottom-ATop+1,'|');
        {AStr[1]:='*';AStr[Length(AStr)]:='*';}
        FPrinter.Canvas.TextDownAlign(ALeft, ATop, ABottom, AStr, taLeftJustify);
        {FPrinter.Canvas.TextOutAlign(ALeft, ATop, ABottom, AStr, taLeftJustify);}
      end;
    lpRight:
      begin
        ATop:= FSkipLines*(ADrawLine.DrawTop div FCharHeight);
        ABottom:= FSkipLines*(ADrawLine.DrawBottom div FCharHeight);
        ALeft:= ADrawLine.DrawRight div FCharWidth;
        SetLength(AStr,ABottom-ATop+1);
        FillChar(AStr[1],ABottom-ATop+1,'|');
        {AStr[1]:='*';AStr[Length(AStr)]:='*';}
        FPrinter.Canvas.TextDownAlign(ALeft, ATop, ABottom, AStr, taLeftJustify);
        {FPrinter.Canvas.TextOutAlign(ALeft, ATop, ABottom, AStr, taLeftJustify);}
      end;
    end;
end;

Procedure TXTextPrintDevice.DrawImage(aDrawImage: TppDrawImage);
var i: integer;
begin
  i:=0;
end;

Initialization
  RegisterClasses([TXTextPrintDevice]);
end.
