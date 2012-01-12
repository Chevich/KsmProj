{*******************************************************}
{                                                       }
{            X-library v.03.51                          }
{                                                       }
{  16.07.98             				}
{                                                       }
{  TPrintLink - print settings                          }
{  TXStringsReport - text lines report                  }
{  TXDBReport - inherited from TppReport                }
{               with text writings and                  }
{               additional print setup                  }
{                                                       }
{  Last corrections 16.02.99                            }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit XReports;

Interface

Uses Classes, Graphics, Printers, ppTypes, ppDevice, ppForms, ppReport, ppDBBDE,
     XMisc, LnkMisc, ppDB, ppPrintr;

Type
  TXDBReport = class;
  TXPrintDevice = (pdNone, pdGraph, pdText);
  TXPrintTypeText = (txNone,txNormal,txElite,txSmall,txSmallElite);
  TXTypeNLQ = (nxNone, nxDraft, nxRoman, nxSansSerif);

{ TTextPrintLink }

  TTextPrintLink = class(TPersistent)
  private
    FSkipTextLines: Boolean;
    FTypeText: TXPrintTypeText;
    FTypeNLQ: TXTypeNLQ;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property TypeText: TXPrintTypeText read FTypeText write FTypeText default txNormal;
    property TypeNLQ: TXTypeNLQ read FTypeNLQ write FTypeNLQ default nxDraft;
    property SkipTextLines: Boolean read FSkipTextLines write FSkipTextLines;
  end;

{ TTitlePrintLink }

  TTitlePrintLink = class(TPersistent)
  private
    FAlign: TXAlignment;
    FAllPages: Boolean;
    FTitle: String;
  public
    procedure Assign(Source: TPersistent); override;
  protected
    property Title: String read FTitle write FTitle;
    property Align: TXAlignment read FAlign write FAlign default xaMiddle;
    property AllPages: Boolean read FAllPages write FAllPages default False;
  end;

{ TUpPrintLink }

  TUpPrintLink = class(TTitlePrintLink)
  public
    constructor Create;
  published
    property Title;
    property Align default xaMiddle;
    property AllPages default False;
  end;

{ TDownPrintLink }

  TDownPrintLink = class(TTitlePrintLink)
  public
    constructor Create;
  published
    property Title;
    property Align default xaMiddle;
    property AllPages default False;
  end;

{ TDetailPrintLink }

  TDetailPrintLink = class(TPersistent)
  private
    FPageNumAlign: TXAlignment;
    FPageNumTop: Boolean;
    FPageNumAll: Boolean;
    FDateAlign: TXAlignment;
    FDateTop: Boolean;
    FPageNumTitle: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property PageNumAlign: TXAlignment read FPageNumAlign write FPageNumAlign
             default xaRight;
    property PageNumTop: Boolean read FPageNumTop write FPageNumTop default False;
    property PageNumAll: Boolean read FPageNumAll write FPageNumAll default False;
    property PageNumTitle: String read FPageNumTitle write FPageNumTitle;
    property DateAlign: TXAlignment read FDateAlign write FDateAlign default xaLeft;
    property DateTop: Boolean read FDateTop write FDateTop default False;
  end;

{ TPrintLink }

  TPrintDataLinkOption = (poHeaderBorder, poDetailBorder, poHorzLines, poVertLines);
  TPrintDataLinkOptions = Set of TPrintDataLinkOption;

  TPrintLink = class(TPersistent)
  private
    FDataCalc: TCalcLink;
    FTextLink: TTextPrintLink;
    FDetailLink: TDetailPrintLink;
    FUpLink: TUpPrintLink;
    FDownLink: TDownPrintLink;
    FDataOptions: TPrintDataLinkOptions;
    {FTypeDevice: TppDeviceType;}
    FDeviceType: String; { For RBuilder 4.x }
    FTypePrint: TXPrintDevice;
    FLinesCount: Integer;
    FZoomView: Integer;
    FPrinterSetup: TppPrinterSetup;
{    FRepeatFields: String;}
    FFont: TFont;
    function IsFontStored: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetTypePrint(Value: TXPrintDevice);
  public
    constructor Create(aPrintType: TXPrintDevice);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetVisibleFields;
    function GetFieldsXReport(aOwner: TComponent; IsDestroyed: Boolean): TXDBReport;
    function GetVisibleFieldsXReport(aOwner: TComponent; IsDestroyed: Boolean): TXDBReport;
    procedure CreateXDBReport(aReport: TXDBReport; aText: String;
                aOrientation: TPrinterOrientation; aAdjustFieldWidth: Boolean);
    function ShowPrintDialog: Boolean;
    property DataCalc: TCalcLink read FDataCalc write FDataCalc;
  published
    property PrinterSetup: TppPrinterSetup read FPrinterSetup write FPrinterSetup;
    {property TypeDevice: TppDeviceType read FTypeDevice write FTypeDevice default dvScreen;}
    property DeviceType: String read FDeviceType write FDeviceType;
    property TypePrint: TXPrintDevice read FTypePrint write SetTypePrint default pdText;
    property ZoomView: Integer read FZoomView write FZoomView default 0;
    property UpLink: TUpPrintLink read FUpLink write FUpLink;
    property DownLink: TDownPrintLink read FDownLink write FDownLink;
    property DetailLink: TDetailPrintLink read FDetailLink write FDetailLink;
    property TextLink: TTextPrintLink read FTextLink write FTextLink;
    property LinesCount: Integer read FLinesCount write FLinesCount default 60;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property DataOptions: TPrintDataLinkOptions read FDataOptions write FDataOptions
                          default [poHeaderBorder, poDetailBorder, poVertLines];
  end;
{ TPrintLink }

{ TXStringsReport }

  TXStringsReport = class(TPersistent)
  private
    FPrintLink: TPrintLink;
    FLines: TStrings;
    FReport: TXDBReport;
    FListIndex: Integer;
    FItemCount: Integer;
    FLinesCount: Integer;
    FIsOnePage: Boolean;
    function GetSelfFieldValue(const aFieldName: String): Variant;
    function CheckBOF: Boolean;
    function CheckEOF: Boolean;
    function GetBookmark: Integer;
    function GetDataSetName: String;
    function GetFieldAsString(aFieldName: String): String;
    function GetFieldValue(aFieldName: String): Variant;
    procedure GotoBookmark(aBookmark: Integer);
    procedure GotoFirstRecord(Sender: TObject);
    procedure GotoLastRecord(Sender: TObject);
    procedure OpenDataSet(Sender: TObject);
    procedure CloseDataSet(Sender: TObject);
    procedure TraverseBy(aIncrement: Integer);
  public
    constructor Create;
    function CreateReport(aCaption: String; aOwner: TComponent; aDeviceType: String{TppDeviceType};
            aPrintType:TXPrintDevice; IsDestroyed: Boolean; isHeader, isFooter:Boolean): TXDBReport;
    property Lines:TStrings read FLines write FLines;
    property LinesCount: Integer read FLinesCount write FLinesCount default 60;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
  end;
{ TXStringsReport }

{ TXDBReport }

  TXDBReport = class(TppReport)
  private
    FPrintLink: TPrintLink;
{    FPrintType: TXPrintDevice;}
    FTextPrinterDevice: TppDevice;
    procedure PrintDialogCloseEvent(Sender: TObject);
    procedure CancelDialogActivateEvent(Sender: TObject);
    procedure CancelDialogCancelEvent(Sender: TObject);
    procedure CancelDialogCloseEvent(Sender: TObject);
    procedure CancelDialogDestroyEvent(Sender: TObject);
    function  CreatePrintDialog: TppCustomPrintDialog;
    function  CreateCancelDialog: TppCustomCancelDialog;
  protected
    procedure DoOnPreviewFormCreate; override;
    function GetPreviewCaption: String; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PrintAsText;
    procedure Print; override;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
  end;
{ TXDBReport }

Implementation

Uses SysUtils, Controls, Forms, Dialogs, DB, ppComm, ppClass, XTxtDev, StdCtrls, 
     XPDlg, XPrevDlg, XPrlDlg, XRepLays, ppUtils, ppClasUt, ppDBJIT, ppCtrls, ppVar,
     XTxtPrn;

Procedure SetUniquePipeLineName(aPipeLine: TppBDEPipeLine);
var i: Integer;
    Fmt, S: string;
begin
  Fmt:='SystemBDEPipe';
  Fmt:=Fmt+'%d';
  for i:=1 to High(Integer) do begin
    S := Format(Fmt, [I]);
{!  if TryName(S, aPipeLine.Owner) then }begin
      aPipeLine.Name:=S;
      Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique name for %s.', [aPipeLine.ClassName]);
end;

Function CreateBDEPipeline(aOwner: TComponent; aDataSet: TDataSet): TppBDEPipeLine;
var aPipeLine: TppBDEPipeLine;
begin
  aPipeLine:=TppBDEPipeLine.Create(aOwner);
  if aPipeLine.Name='' then SetUniquePipeLineName(aPipeLine);
  aPipeLine.DataSource:=TDataSource.Create(aOwner);
  aPipeLine.DataSource.DataSet:=aDataSet;
  Result:=aPipeLine;
end;

{ TTextPrintLink }

Constructor TTextPrintLink.Create;
begin
  Inherited Create;
  FTypeText:= txNormal;
  FTypeNLQ:= nxDraft;
end;

Procedure TTextPrintLink.Assign(Source: TPersistent);
begin
  if Source is TTextPrintLink then
    with TTextPrintLink(Source) do begin
      Self.TypeText:=TypeText;
      Self.TypeNLQ:=TypeNLQ;
      Self.SkipTextLines:=SkipTextLines;
    end
  else Inherited;
end;

{ TTitlePrintLink }

Procedure TTitlePrintLink.Assign(Source: TPersistent);
begin
  if Source is TTitlePrintLink then
    with TTitlePrintLink(Source) do begin
      Self.Title:=Title;
      Self.Align:=Align;
      Self.AllPages:=AllPages;
    end
  else Inherited;
end;

{ TUpPrintLink }

Constructor TUpPrintLink.Create;
begin
  Inherited Create;
  FAlign:= xaMiddle;
  FAllPages:= False;
end;

Constructor TDownPrintLink.Create;
begin
  Inherited Create;
  FAlign:= xaNone;
  FAllPages:= False;
end;

{ TDetailPrintLink }

Constructor TDetailPrintLink.Create;
begin
  Inherited Create;
  FPageNumAlign:=xaNone;{xaRight;}
  FPageNumTop:=False;
  FPageNumAll:=False;
  FDateAlign:=xaNone;{xaLeft;}
  FDateTop:=False;
end;

Procedure TDetailPrintLink.Assign(Source: TPersistent);
begin
  if Source is TDetailPrintLink then
    with TDetailPrintLink(Source) do begin
      Self.PageNumAlign:=PageNumAlign;
      Self.PageNumTop:=PageNumTop;
      Self.PageNumAll:=PageNumAll;
      Self.DateAlign:=DateAlign;
      Self.DateTop:=DateTop;
    end
  else Inherited;
end;

{ TPrintLink }

Constructor TPrintLink.Create(aPrintType: TXPrintDevice);
begin
  Inherited Create;
  FTextLink:=TTextPrintLink.Create;
  FUpLink:=TUpPrintLink.Create;
  FDownLink:=TDownPrintLink.Create;
  FDetailLink:=TDetailPrintLink.Create;
  FPrinterSetup:=TppPrinterSetup.Create(nil);
  FDataOptions:=[poHeaderBorder, poDetailBorder, poVertLines];
  {FTypeDevice:=dvScreen;}
  FDeviceType:='Screen';
  FZoomView:=0;
  FLinesCount:=60;
  FFont:=TFont.Create;
  FFont.Name:='Courier New Cyr';
  if aPrintType=pdText then FFont.Size:={16;}15
  else FFont.Size:=7;
  TypePrint:=aPrintType;
end;

Destructor TPrintLink.Destroy;
begin
  FUpLink.Free;
  FDownLink.Free;
  FDetailLink.Free;
  FTextLink.Free;
  FPrinterSetup.Free;
  FFont.Free;
  Inherited Destroy;
end;

Procedure TPrintLink.Assign(Source: TPersistent);
begin
  if Source is TPrintLink then
    with TPrintLink(Source) do begin
      if Assigned(Self.DataCalc) then Self.DataCalc.Assign(TPrintLink(Source).DataCalc);
      Self.UpLink.Assign(UpLink);
      Self.DownLink.Assign(DownLink);
      Self.TextLink.Assign(TextLink);
      Self.DataOptions:=DataOptions;
      Self.LinesCount:=LinesCount;
      Self.TypePrint:=TypePrint;
      Self.Font:=Font;
      Self.ZoomView:=ZoomView;
    end else Inherited Assign(Source);
end;

Function TPrintLink.IsFontStored: Boolean;
begin
{?  FFont.Name := 'Courier New Cyr';
  FFont.Size := 12;}
  Result:=True;
end;

Procedure TPrintLink.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

Procedure TPrintLink.SetTypePrint(Value: TXPrintDevice);
begin
  FTypePrint:=Value;
  if Value=pdText then FTextLink.SkipTextLines:=True
  else FTextLink.SkipTextLines:=False;
end;

Function TPrintLink.GetFieldsXReport(aOwner: TComponent; IsDestroyed: Boolean): TXDBReport;
var AReport: TXDBReport;
   {  Temp1: TPipeControl;}
    aSelectFields: TList;
    aIsControlName: Boolean;
    aIsShowForm: Boolean;
    aPipeLine: TppBDEPipeLine;
    aCaption: String;
begin
  if DataCalc.Fields.Count>0 then begin
    aSelectFields:=DataCalc.Fields;
    aIsControlName:=True;
    aIsShowForm:=False;
    aPipeLine:=CreateBDEPipeline(aOwner, DataCalc.DataSet);

    if UpLink.Title='' then aCaption:=DataCalc.DataSet.Name
    else aCaption:= UpLink.Title;
    AReport:=nil;
{   if SystemWizard.Completed then }begin
{        AReport   := TXDBReport(SystemWizard.Report);}

      aReport:=TXDBReport.Create(aOwner);
      aReport.CachePages:=True;
      aReport.PassSetting:=psOnePass;
      aReport.DataPipeLine:=aPipeLine;
      aReport.PrintLink:= Self;
      aReport.CreateDefaultBands;
      CreateXDBReport(aReport, aCaption, poPortrait, True);
      {AReport.Device:=TypeDevice;}
      AReport.DeviceType:=DeviceType;
{!    AReport.PrintType:= TypePrint;}
      {aReport.DataPipeLine:=nil;}
      aReport.Publisher.CachePages:=true;
      AReport.Print;
    end;
    if IsDestroyed then begin
      AReport.Free;
      AReport:=nil;
      aPipeLine.DataSource.Free;
      aPipeline.Free;
    end;
    Result:= AReport;
  end;
end;

Procedure TPrintLink.SetVisibleFields;
var i: Integer;
    S: String;
begin
  if Assigned(DataCalc.DataSet) then begin
    S:='';
    for i:=0 to DataCalc.DataSet.FieldCount-1 do
      if DataCalc.DataSet.Fields[i].Visible then S:=S+DataCalc.DataSet.Fields[i].FieldName+';';
      if S<>'' then begin
        SetLength(S, Length(S)-1);
        DataCalc.FieldNames:= S;
      end else DataCalc.FieldNames:= '';
  end;
end;

Function TPrintLink.GetVisibleFieldsXReport(aOwner: TComponent; IsDestroyed: Boolean): TXDBReport;
begin
  SetVisibleFields;
  Result:=GetFieldsXReport(aOwner, IsDestroyed);
end;

Procedure TPrintLink.CreateXDBReport(AReport: TXDBReport; AText: String;
                AOrientation: TPrinterOrientation; AAdjustFieldWidth: Boolean);
var AReportLayout: TXReportLayout;
    ii:byte;
    aScreenPixels: integer;
begin
  if TypePrint<>pdGraph then aScreenPixels:=LinesCount*26
  { Высота для формата А4 подогнана }
  else aScreenPixels:=1140;
  AReport.PrinterSetup.PaperHeight:= ppFromScreenPixels(aScreenPixels,aReport.Units,
                                     pprtVertical, nil);
{ ppToScreenPixels(AReport.PrinterSetup.PaperHeight,aReport.Units, pprtVertical, Nil) div 26;}
  AReport.Template.Description:=AText;
  AReport.PrinterSetup.Orientation:=AOrientation;
  AReportLayout:=TXReportLayout.Create(AReport);
  with AReportLayout do begin
    PrintLink:=Self;
    InitStyle;
    InitLayout;
  end;
  AReportLayout.CreateDataControls;
  AReportLayout.PositionControls(aAdjustFieldWidth);
  AReportLayout.CreateFinish;

  AReportLayout.ApplyLayout(AReport);
  AReportLayout.ApplyStyle(AReport);
  AReportLayout.Free;
end;

Function TPrintLink.ShowPrintDialog: Boolean;
var
  aPrintDialog: TPrintLinkDialog;
begin
  aPrintDialog:=TPrintLinkDialog.Create(Application);
  aPrintDialog.PrintLink:= Self;
  Result:= aPrintDialog.ShowDialog;
  aPrintDialog.Free;
end;

{ TXStringsReport }

Constructor TXStringsReport.Create;
begin
  Inherited;
  FLinesCount:= 60;
end;

Function TXStringsReport.CreateReport(aCaption: String; aOwner: TComponent; aDeviceType: String{TppDeviceType};
            aPrintType:TXPrintDevice; IsDestroyed: Boolean; isHeader, isFooter:Boolean): TXDBReport;
var aPipe: TppJITPipeLine;
    lDetailBand, lHeaderBand, lFooterBand: TppBand;
    lComponent: TppComponent;
    aField: TppField;
    aCharWidth, aCharheight, aMaxLen, i: Integer;
    aFont: TFont;
    lCalc: TppCalc;
begin
  Result:=nil;
  if Assigned(FPrintLink) and Assigned(Lines) then begin
    FListIndex:=-1;
    FItemCount:=Lines.Count;
    FReport:=TXDBReport.Create(aOwner);
    FReport.PrintLink:=PrintLink;
    if not IsHeader then FReport.DefaultBands:=FReport.DefaultBands-[btHeader];
    if not IsFooter then FReport.DefaultBands:=FReport.DefaultBands-[btFooter];
    FReport.CreateDefaultBands;

    aPipe:= TppJITPipeLine.Create(nil{aOwner});
    aPipe.OnCheckBOF:=CheckBOF;
    aPipe.OnCheckEOF:=CheckEOF;
    aPipe.OnGetBookmark:=GetBookmark;
    aPipe.OnGetDataSetName:=GetDataSetName;
    aPipe.OnGetFieldAsString:=GetFieldAsString;
    aPipe.OnGetFieldValue:=GetFieldValue;
    aPipe.OnGotoBookmark:=GotoBookmark;
    aPipe.OnGotoFirstRecord:=GotoFirstRecord;
    aPipe.OnGotoLastRecord:=GotoLastRecord;
    aPipe.OnOpenDataSet:=OpenDataSet;
    aPipe.OnCloseDataSet:=CloseDataSet;
    aPipe.OnTraverseBy:=TraverseBy;

    lHeaderBand:=FReport.GetBand(btHeader, 0);
    lFooterBand:=FReport.GetBand(btFooter, 0);

    lDetailBand:=FReport.GetBand(btDetail, 0);
    lDetailBand.PrintHeight:=phDynamic;
    lComponent:=TppComponent(ppComponentCreate(FReport, TppDBText));

    aField:=TppField.Create(aPipe);
    aField.FieldName:='Strings';
    aMaxLen:=0;
    for i:=0 to Lines.Count-1 do
      if Length(Lines[i])>aMaxLen then aMaxLen:=Length(Lines[i]);
    aField.FieldLength:=aMaxLen;
    aField.DisplayWidth:=aMaxLen;
    aField.DataPipeLine:=aPipe;

    lComponent.DataPipeline:=aPipe;
    lComponent.Band:=lDetailBand;
    lComponent.DataField:='Strings';
    lComponent.Font.Name:='Courier New Cyr';
    if aPrintType=pdText then lComponent.Font.Size:=15
    else lComponent.Font.Size:=7;
    GetFontCharSizes(lComponent.Font, aCharWidth, aCharHeight);
    if aPrintType=pdText then lComponent.spTop:=6
    else lComponent.spTop:=2;
    lComponent.spWidth:=aMaxLen*aCharWidth;
    lComponent.spHeight:=aCharHeight - 2;
    FReport.PrinterSetup.PaperHeight:=
      ppFromScreenPixels((LinesCount+1)*(lComponent.spTop+lComponent.spHeight)+
        ppToScreenPixels(FReport.PrinterSetup.MarginTop,FReport.Units, pprtVertical,nil)+
        ppToScreenPixels(FReport.PrinterSetup.MarginBottom,FReport.Units, pprtVertical,nil),
        FReport.Units, pprtVertical,nil);
    if (aMaxLen*aCharWidth > lDetailBand.spWidth ) then
      FReport.PrinterSetup.PaperWidth:=
        ppFromScreenPixels(aMaxLen*aCharWidth+
        ppToScreenPixels(FReport.PrinterSetup.MarginLeft,FReport.Units, pprtHorizontal,nil)+
        ppToScreenPixels(FReport.PrinterSetup.MarginRight,FReport.Units, pprtHorizontal, Nil),
        FReport.Units, pprtHorizontal,nil);

    { Header context }
    if IsHeader then begin
      lHeaderBand.spHeight:=lComponent.spHeight+5;
      lComponent:=TppLabel(ppComponentCreate(FReport,TppLabel));
      lComponent.Caption:=aCaption;
      lComponent.spHeight:=aCharHeight -{+} 2;
   {  lComponent.Transparent := True;}
      lComponent.Font:=PrintLink.Font;
      lComponent.Font.Style:=[fsBold];
      lComponent.Band:=lHeaderBand;
    end;

    { Footer context }
    if IsFooter then begin
      lFooterBand.spHeight:=lComponent.spHeight+5;
      lCalc:=TppCalc(ppComponentCreate(FReport, TppCalc));
      lCalc.Font:=PrintLink.Font;
      lCalc.CalcType:=ctPrintDateTime;
      lCalc.Band:=lFooterBand;
      lCalc.spWidth:=aCharWidth*Length(lCalc.Text);
      lCalc.spTop:=5;
      lCalc.spLeft:=5;

      lCalc:=TppCalc(ppComponentCreate(FReport, TppCalc));
      lCalc.Font:=PrintLink.Font;
      lCalc.CalcType:=ctPageNo{ctPageSetDesc};
      lCalc.Alignment:=taRightJustify;
      lCalc.Band:=lFooterBand;
      lCalc.spWidth:=aCharWidth*(Length(lCalc.Text)+3);
      lCalc.spTop:=5;
      lCalc.spLeft:=lCalc.Band.spWidth - lCalc.spWidth - 5-2;{-2}
    end;

    if (FReport <> nil)  then begin
      FReport.DataPipeLine:=aPipe;
      {FReport.Device:=ADeviceType;}
      FReport.DeviceType:=ADeviceType;
      FReport.Print;
    end;
    if IsDestroyed then begin
      FReport.Free;
      FReport:=nil;
      aPipe.Free;
    end;
    Result:=FReport;
  end;
end;

Function TXStringsReport.GetSelfFieldValue(const aFieldName: String): Variant;
var lsFieldName: String;
    lList: TStringList;
begin
  lsFieldName:=Uppercase(aFieldName);
  if (Lines<>nil) then Result := Lines[FListIndex] else Result := '';
end;

Function TXStringsReport.CheckBOF: Boolean;
begin
  Result:=(FListIndex=-1);
end;

Function TXStringsReport.CheckEOF: Boolean;
begin
  Result:=(FListIndex = FItemCount);
end;

Function TXStringsReport.GetBookmark: Integer;
begin
  Result:=FListIndex;
end;

Function TXStringsReport.GetDataSetName: String;
begin
  Result:='Customer';
end;

Function TXStringsReport.GetFieldAsString(aFieldName: String): String;
begin
  Result:=String(GetSelfFieldValue(aFieldName));
end;

Function TXStringsReport.GetFieldValue(aFieldName: String): Variant;
begin
  Result:=GetSelfFieldValue(aFieldName);
end;

Procedure TXStringsReport.GotoBookmark(aBookmark: Integer);
begin
  FListIndex:=aBookmark;
end;

Procedure TXStringsReport.GotoFirstRecord(Sender: TObject);
begin
  FListIndex:=0;
end;

Procedure TXStringsReport.GotoLastRecord(Sender: TObject);
begin
  FListIndex:=FItemCount - 1;
end;

Procedure TXStringsReport.OpenDataSet(Sender: TObject);
begin
  FListIndex := 0;
end;

procedure TXStringsReport.CloseDataSet(Sender: TObject);
begin
  FListIndex:=-1;
end;

Procedure TXStringsReport.TraverseBy(aIncrement: Integer);
begin
  FListIndex:=FListIndex + aIncrement;
end;

{ TXDBReport }

type
  TppProducerSelf = class(TppCommunicator)
  public
    FAllowPrintToArchive: Boolean;
    FAllowPrintToFile: Boolean;
    FArchiveFileName: String;
    FCancelDialog: TppCustomCancelDialog;
  end;

Constructor TXDBReport.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

Destructor TXDBReport.Destroy;
begin
  Inherited Destroy;
end;

Procedure TXDBReport.PrintDialogCloseEvent(Sender: TObject);
begin
  DoOnPrintDialogClose;
end;

Procedure TXDBReport.CancelDialogCancelEvent(Sender: TObject);
begin
  Cancel;
  DoOnCancel;
end;

Procedure TXDBReport.CancelDialogCloseEvent(Sender: TObject);
begin
  DoOnCancelDialogClose;
end;

Procedure TXDBReport.CancelDialogDestroyEvent(Sender: TObject);
begin
  if Assigned(CancelDialog) then begin
    if Assigned(FTextPrinterDevice) then
      TXTextPrintDevice(FTextPrinterDevice).CancelDialog:=nil;
    TppProducerSelf(Self).FCancelDialog:=nil;
  end;
end;

Procedure TXDBReport.CancelDialogActivateEvent(Sender: TObject);
begin
  PrintToDevices;
  CancelDialog.ppCloseModal;
end;

Function TXDBReport.CreatePrintDialog: TppCustomPrintDialog;
var lFormClass: TFormClass;
    lPrintDialog: TppCustomPrintDialog;
begin
  Result:=nil;
  if not (pppcDesigning in DesignState) and not(ShowPrintDialog) then Exit;
  lFormClass:=ppGetFormClass(TppCustomPrintDialog);
  lPrintDialog:=TppCustomPrintDialog(lFormClass.Create(Application));
  lPrintDialog.Report           := Self;
  lPrintDialog.LanguageIndex    := LanguageIndex;
  lPrintDialog.AllowPrintToFile := AllowPrintToFile;
  lPrintDialog.PageRequested    := CurrentPage;
  lPrintDialog.Printer          := TXTextPrintDevice(FTextPrinterDevice).Printer;
  lPrintDialog.TextFileName     := TextFileName;
  lPrintDialog.ppOnClose        := PrintDialogCloseEvent;
  if not(Icon.Empty) then lPrintDialog.Icon := Icon;
  DoOnPrintDialogCreate;
  Result:=lPrintDialog;
end;

Function TXDBReport.CreateCancelDialog: TppCustomCancelDialog;
var lFormClass: TFormClass;
    lCancelDialog: TppCustomCancelDialog;
begin
  Result:=nil;
  if not(ShowCancelDialog) then Exit;
  lFormClass:=ppGetFormClass(TppCustomCancelDialog);
  lCancelDialog:=TppCustomCancelDialog(lFormClass.Create(Application));
  lCancelDialog.Report           := Self;
  lCancelDialog.LanguageIndex    := LanguageIndex;
  lCancelDialog.ppOnCancel       := CancelDialogCancelEvent;
  lCancelDialog.ppOnClose        := CancelDialogCloseEvent;
  lCancelDialog.ppOnDestroy      := CancelDialogDestroyEvent;
  lCancelDialog.AllowPrintCancel := True;
  if not(Icon.Empty) then lCancelDialog.Icon := Icon;
  Result := lCancelDialog;
end;

procedure TXDBReport.PrintAsText;
var ASavePrinterSetup: TppPrinterSetup;
    APrintDialog: TppCustomPrintDialog;

  procedure FreeObjects;
  begin
    APrintDialog.Free;
    ASavePrinterSetup.Free;
    FTextPrinterDevice.Free;
    FTextPrinterDevice:=nil;
  end;

begin
  if (CancelDialog<>nil) then Exit;
  if ppPrinters.Count = 0 then begin
    {display message, 'There are no printers currently connected to your computer'}
    MessageDlg(LoadStr(LanguageIndex+8), mtWarning, [mbOK], 0);
{   Exit;}
  end;
  {save current printer setup}
  ASavePrinterSetup:=TppPrinterSetup.Create(nil);
  ASavePrinterSetup.Assign(PrinterSetup);
  {create a printer device}
  FTextPrinterDevice:=TXTextPrintDevice.Create(Self);
  FTextPrinterDevice.Stackable:=True;
  FTextPrinterDevice.LanguageIndex:=LanguageIndex;
  if Assigned(TXTextPrintDevice(FTextPrinterDevice).Printer) then
    TXTextPrinter(
    TXTextPrintDevice(FTextPrinterDevice).Printer).PrinterSetup:=PrinterSetup;
    {TXTextPrintDevice(FTextPrinterDevice).Printer.PrinterSetup.Assign(PrinterSetup);}
  APrintDialog:=CreatePrintDialog;
  if (APrintDialog<>nil) and (APrintDialog.ShowModal<>mrOK) then begin
    FreeObjects;
    Exit;
  end;
  if (APrintDialog<>nil) then begin
    {assign page range settings to printer device}
    FTextPrinterDevice.PageSetting:=APrintDialog.PageSetting;
    FTextPrinterDevice.PageRequested:=APrintDialog.PageRequested;
    FTextPrinterDevice.PageList:=APrintDialog.PageList;
  end;
  {assign printer device to publisher}
  FTextPrinterDevice.Publisher:=Publisher;
  DeviceCreated(FTextPrinterDevice);
  {get printer device's printersetup - note: do not use assign here}
  PrinterSetup:=TXTextPrinter(TXTextPrintDevice(FTextPrinterDevice).Printer).PrinterSetup;
{ Lev 27.03.00 }
{ Что-то плохо устанавливается }
  PrinterSetup.Active:=False;
  PrinterSetup.Copies:=StrToInt(TEdit(APrintDialog.FindComponent('edtCopies')).Text);
  PrinterSetup.Active:=True;
{ Lev 27.03.00 }
  {create the cancel dialog}
  TppProducerSelf(Self).FCancelDialog:=CreateCancelDialog;
  {assign cancel dialog to device}
  if (CancelDialog <> nil) then
    FTextPrinterDevice.CancelDialog:=CancelDialog;
  DoOnCancelDialogCreate;
  {print report}
  try
    {display cancel dialog}
    if (CancelDialog <> nil) then
      if ModalCancelDialog then begin
        CancelDialog.ppOnActivate:=CancelDialogActivateEvent;
        CancelDialog.ShowModal;
        CancelDialog.Free;
      end else begin
        CancelDialog.Show;
        PrintToDevices;
        if (CancelDialog <> nil) then CancelDialog.Close;
      end
    else PrintToDevices;
  finally
    {restore printer setup}
    PrinterSetup.Assign(ASavePrinterSetup);
    {free all objects created by this procedure}
    FreeObjects;
  end;
end;

Procedure TXDBReport.Print;
begin
  if Assigned(PrintLink) and (PrintLink.TypePrint=pdText)and
  ({(Device=dvPrinter)}(DeviceType='Printer') or
   (PrintLink.DeviceType='Printer')) then PrintAsText
  else Inherited;
end;

Function TXDBReport.GetPreviewCaption;
begin
  Result:= 'Просмотр';
end;

Procedure TXDBReport.DoOnPreviewFormCreate;
var S: String;
begin
  {
  Inherited;
  S:=GetPreviewCaption;
  if S<>'' then PreviewForm.Caption:=S;
  }
end;

Initialization
  ppRegisterForm(TppCustomPreviewer, TXPrintPreview);
  ppRegisterForm(TppCustomPrintDialog, TXPrintDialog);

end.
