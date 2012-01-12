Unit XPrlDlg;

Interface

Uses Forms, StdCtrls, Buttons, ExtCtrls, Mask, Controls, ComCtrls, Classes,
     Dialogs, XReports, Menus;

type
  TPrintLinkDialog = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    PC: TPageControl;
    CommonSheet: TTabSheet;
    HeadersSheet: TTabSheet;
    Label1: TLabel;
    UpTitleEdit: TMaskEdit;
    Label8: TLabel;
    DownTitleEdit: TMaskEdit;
    UpGroup: TRadioGroup;
    DownGroup: TRadioGroup;
    PrintGroup: TRadioGroup;
    GrFontPanel: TPanel;
    Label2: TLabel;
    UpFontBtn: TSpeedButton;
    DetailFontBtn: TSpeedButton;
    DownFontBtn: TSpeedButton;
    TextFontPanel: TPanel;
    TextGroup: TRadioGroup;
    NLQGroup: TRadioGroup;
    UpAllGroup: TRadioGroup;
    DownAllGroup: TRadioGroup;
    OtherSheet: TTabSheet;
    PageAlignGroup: TRadioGroup;
    DateAlignGroup: TRadioGroup;
    PageTopGroup: TRadioGroup;
    PageAllGroup: TRadioGroup;
    PageNumEdit: TMaskEdit;
    DateTopGroup: TRadioGroup;
    PageNumLab: TLabel;
    BoundsSheet: TTabSheet;
    Panel3: TPanel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    DeviceGroup: TRadioGroup;
    ZoomEdit: TMaskEdit;
    Label4: TLabel;
    FontBtn: TSpeedButton;
    FontDial: TFontDialog;
    SkipLinesCheck: TCheckBox;
    Label6: TLabel;
    TableSheet: TTabSheet;
    CheckHeaderBorder: TCheckBox;
    CheckVertLines: TCheckBox;
    CheckHorzLines: TCheckBox;
    SpeedButton5: TSpeedButton;
    CheckHeader: TCheckBox;
    ResultGroup: TRadioGroup;
    CheckDetailBorder: TCheckBox;
    CalcPanel: TPanel;
    ResultsBtn: TBitBtn;
    Label5: TLabel;
    Bevel2: TBevel;
    TableLab: TLabel;
    VisBtn: TBitBtn;
    InqCheck: TCheckBox;
    AggregateBtn: TBitBtn;
    PagePopup: TPopupMenu;
    CommonItem: TMenuItem;
    BoundsItem: TMenuItem;
    HeadersItem: TMenuItem;
    OtherItem: TMenuItem;
    TableItem: TMenuItem;
    PageOrientGroup: TRadioGroup;
    Label3: TLabel;
    LinesCountEdit: TMaskEdit;
    HeightEdit: TMaskEdit;
    WidthEdit: TMaskEdit;
    TopEdit: TMaskEdit;
    BottomEdit: TMaskEdit;
    LeftEdit: TMaskEdit;
    RightEdit: TMaskEdit;
    Label7: TLabel;
    Label9: TLabel;
    CharsCountEdit: TMaskEdit;
    procedure PrintGroupClick(Sender: TObject);
    procedure UpGroupClick(Sender: TObject);
    procedure DownGroupClick(Sender: TObject);
    procedure PageAlignGroupClick(Sender: TObject);
    procedure DateAlignGroupClick(Sender: TObject);
    procedure FontBtnClick(Sender: TObject);
    procedure VisBtnClick(Sender: TObject);
    procedure ResultsBtnClick(Sender: TObject);
    procedure AggregateBtnClick(Sender: TObject);
    procedure CommonItemClick(Sender: TObject);
    procedure BoundsItemClick(Sender: TObject);
    procedure HeadersItemClick(Sender: TObject);
    procedure OtherItemClick(Sender: TObject);
    procedure TableItemClick(Sender: TObject);
    procedure PageOrientGroupClick(Sender: TObject);
  private
    FPrintLink: TPrintLink;
    FSaveOrientation: Integer;
    procedure SetCheckSheet(aSheet: TTabSheet; aChecked: Boolean);
  public
    procedure InitSetup;
    function ShowDialog: Boolean;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
  end;
{ TPrintLinkDialog }

var PrintLinkDialog: TPrintLinkDialog;

Implementation

{$R *.DFM}

Uses SysUtils, LnkMisc, XDBMisc, ppTypes, XMisc, ppUtils, Printers;
Const DeviceTypes:array[0..3] of String=(dtPrinter,dtScreen,dtFile,dtArchive);

Function TPrintLinkDialog.ShowDialog: Boolean;
var aDataOptions: TPrintDataLinkOptions;
begin
  with PrintLink do begin
    DeviceGroup.ItemIndex:= 0{Ord(TypeDevice)};
    PrintGroup.ItemIndex:=Ord(TypePrint);
    ZoomEdit.Text:= IntToStr(ZoomView);

    TextGroup.ItemIndex:= Ord(TextLink.TypeText);
    NLQGroup.ItemIndex:= Ord(TextLink.TypeNLQ);
    SkipLinesCheck.Checked:= TextLink.SkipTextLines;

    UpTitleEdit.Text:= UpLink.Title;
    UpAllGroup.ItemIndex:= Ord(UpLink.AllPages);
    UpGroup.ItemIndex:= Ord(UpLink.Align);

    DownTitleEdit.Text:= DownLink.Title;
    DownAllGroup.ItemIndex:= Ord(DownLink.AllPages);
    DownGroup.ItemIndex:= Ord(DownLink.Align);

    PageAlignGroup.ItemIndex:= Ord(DetailLink.PageNumAlign);
    PageTopGroup.ItemIndex:= Ord(DetailLink.PageNumTop);
    PageAllGroup.ItemIndex:= Ord(DetailLink.PageNumAll);
    PageNumEdit.Text:= DetailLink.PageNumTitle;
    DateAlignGroup.ItemIndex:= Ord(DetailLink.DateAlign);
    DateTopGroup.ItemIndex:= Ord(DetailLink.DateTop);

    CheckHeaderBorder.Checked:= poHeaderBorder in DataOptions;
    CheckDetailBorder.Checked:= poDetailBorder in DataOptions;
    CheckVertLines.Checked:= poVertLines in DataOptions;
    CheckHorzLines.Checked:= poHorzLines in DataOptions;
    LinesCountEdit.Text:= IntToStr(LinesCount);
    with PrinterSetup do begin
      HeightEdit.Text:=IntToStr(ppToMMThousandths(PaperHeight, utInches, pprtVertical,nil));
      WidthEdit.Text:=IntToStr(ppToMMThousandths(PaperWidth, utInches, pprtHorizontal,nil));
      TopEdit.Text:= IntToStr(ppToMMThousandths(MarginTop, utInches, pprtVertical,nil));
      BottomEdit.Text:= IntToStr(ppToMMThousandths(MarginBottom, utInches, pprtVertical,nil));
      LeftEdit.Text:= IntToStr(ppToMMThousandths(MarginLeft, utInches, pprtHorizontal,nil));
      RightEdit.Text:= IntToStr(ppToMMThousandths(MarginRight, utInches, pprtHorizontal,nil));
      PageOrientGroup.ItemIndex:= Ord(Orientation);
      FSaveOrientation:= PageOrientGroup.ItemIndex;
    end;
    CalcPanel.Visible:=Assigned(DataCalc) and Assigned(DataCalc.DataSet);
    if Assigned(DataCalc) then begin
      ResultGroup.ItemIndex:=Ord(DataCalc.TypeResult);
    end;
  end;
  InitSetup;
  Result:= (ShowModal = mrYes);
  if Result then with PrintLink do begin
    {DeviceType:='Printer';}
    DeviceType:=DeviceTypes[DeviceGroup.ItemIndex];
    {TypeDevice:=TppDeviceType(DeviceGroup.ItemIndex);}
    TypePrint:=TXPrintDevice(PrintGroup.ItemIndex);
    case TypePrint of
      pdGraph: begin
                 Font.Size:=8;
               end;
      pdText : begin
                 Font.Size:=15;
               end;
    end;
    ZoomView:=StrToInt(ZoomEdit.Text);
    TextLink.TypeText:=TXPrintTypeText(TextGroup.ItemIndex);
    TextLink.TypeNLQ:=TXTypeNLQ(NLQGroup.ItemIndex);
    TextLink.SkipTextLines:=SkipLinesCheck.Checked;
    UpLink.Title:=UpTitleEdit.Text;
    UpLink.AllPages:=Boolean(UpAllGroup.ItemIndex);
    UpLink.Align:=TXAlignment(UpGroup.ItemIndex);
    DownLink.Title:=DownTitleEdit.Text;
    DownLink.AllPages:=Boolean(DownAllGroup.ItemIndex);
    DownLink.Align:=TXAlignment(DownGroup.ItemIndex);
    DetailLink.PageNumAlign:=TXAlignment(PageAlignGroup.ItemIndex);
    DetailLink.PageNumTop:=Boolean(PageTopGroup.ItemIndex);
    DetailLink.PageNumAll:=Boolean(PageAllGroup.ItemIndex);
    DetailLink.PageNumTitle:=PageNumEdit.Text;
    DetailLink.DateAlign:=TXAlignment(DateAlignGroup.ItemIndex);
    DetailLink.DateTop:=Boolean(DateTopGroup.ItemIndex);
    aDataOptions:=[];
    if CheckHeaderBorder.Checked then Include(aDataOptions, poHeaderBorder);
    if CheckDetailBorder.Checked then Include(aDataOptions, poDetailBorder);
    if CheckVertLines.Checked then Include(aDataOptions, poVertLines);
    if CheckHorzLines.Checked then begin
      Include(aDataOptions, poHorzLines);
      { Включаем пропуск линий }
      TextLink.SkipTextLines:=true;
    end;
    DataOptions:=aDataOptions;
    LinesCount:=StrToInt(LinesCountEdit.Text);
    with PrinterSetup do begin
      PaperHeight:=ppFromMMThousandths(StrToInt(HeightEdit.Text), utInches, pprtVertical,nil);
      PaperWidth:=ppFromMMThousandths(StrToInt(WidthEdit.Text), utInches, pprtHorizontal,nil);
      MarginTop:=ppFromMMThousandths(StrToInt(TopEdit.Text), utInches, pprtVertical,nil);
      MarginBottom:=ppFromMMThousandths(StrToInt(BottomEdit.Text), utInches, pprtVertical,nil);
      MarginLeft:=ppFromMMThousandths(StrToInt(LeftEdit.Text), utInches, pprtHorizontal,nil);
      MarginRight:=ppFromMMThousandths(StrToInt(RightEdit.Text), utInches, pprtHorizontal,nil);
      Orientation:=TPrinterOrientation(PageOrientGroup.ItemIndex);
    end;
    if Assigned(DataCalc) then begin
      DataCalc.TypeResult:= TXTypeResult(ResultGroup.ItemIndex);
    end;
  end;
end;

Procedure TPrintLinkDialog.InitSetup;
begin
  case PrintGroup.ItemIndex of
    0: begin
         GrFontPanel.Visible:= False;
         TextFontPanel.Visible:= False;
       end;
    1: begin
         GrFontPanel.Visible:= True;
         TextFontPanel.Visible:= False;
       end;
    2: begin
         GrFontPanel.Visible:= False;
         TextFontPanel.Visible:= True;
       end;
  end;
  UpGroupClick(nil);
  DownGroupClick(nil);
  PageAlignGroupClick(nil);
  DateAlignGroupClick(nil);
{Lev}
  {ResultGroup.ItemIndex:=2;} { Lev } 
  SkipLinesCheck.Checked:=False;
{Lev}
end;

Procedure TPrintLinkDialog.PrintGroupClick(Sender: TObject);
begin
  InitSetup;
end;

Procedure TPrintLinkDialog.UpGroupClick(Sender: TObject);
begin
  UpTitleEdit.Visible:= UpGroup.ItemIndex<>0;
  UpAllGroup.Visible:= UpTitleEdit.Visible;
end;

Procedure TPrintLinkDialog.DownGroupClick(Sender: TObject);
begin
  DownTitleEdit.Visible:= DownGroup.ItemIndex<>0;
  DownAllGroup.Visible:= DownTitleEdit.Visible;
end;

Procedure TPrintLinkDialog.PageAlignGroupClick(Sender: TObject);
begin
  PageTopGroup.Visible:= PageAlignGroup.ItemIndex<>0;
  PageAllGroup.Visible:= PageTopGroup.Visible;
  PageNumLab.Visible:= PageTopGroup.Visible;
  PageNumEdit.Visible:= PageTopGroup.Visible;
end;

Procedure TPrintLinkDialog.DateAlignGroupClick(Sender: TObject);
begin
  DateTopGroup.Visible:= DateAlignGroup.ItemIndex<>0;
end;

Procedure TPrintLinkDialog.FontBtnClick(Sender: TObject);
begin
  if Assigned(PrintLink) then begin
    FontDial.Font:= PrintLink.Font;
    if FontDial.Execute then begin
      PrintLink.Font:= FontDial.Font;
      end;
    end;
end;

Procedure TPrintLinkDialog.VisBtnClick(Sender: TObject);
var SSrc, SDst: String;
begin
  if Assigned(PrintLink) and Assigned(PrintLink.DataCalc.DataSet) then begin
    SDst:= PrintLink.DataCalc.FieldNames;
    PrintLink.DataCalc.UpdateCalcs(coVisible, '');

    if ChooseVisibleCalcFields(PrintLink.DataCalc.DataSet, SDst, SSrc,
    PrintLink.DataCalc.VisCalcs, 'Установка отчета') then begin
      PrintLink.DataCalc.FieldNames:= SDst;
      PrintLink.DataCalc.UpdateCalcNames(coVisible);
    end;
  end;
end;

Procedure TPrintLinkDialog.ResultsBtnClick(Sender: TObject);
var SSrc, SDst: String;
begin
  if Assigned(PrintLink) and Assigned(PrintLink.DataCalc.DataSet) then begin
    SDst:= PrintLink.DataCalc.FieldNames;
    PrintLink.DataCalc.UpdateCalcs(coResult, '');
    if ChooseResultCalcFields(PrintLink.DataCalc.DataSet, SDst, SSrc,
    PrintLink.DataCalc.ResCalcs, 'Установка отчета') then begin
{     PrintLink.FieldNames:= SDst;}
      PrintLink.DataCalc.UpdateCalcNames(coResult);
    end;
  end;
end;

Procedure TPrintLinkDialog.AggregateBtnClick(Sender: TObject);
var SSrc, SDst: String;
begin
  if Assigned(PrintLink) and Assigned(PrintLink.DataCalc.DataSet) then begin
    SDst:= PrintLink.DataCalc.FieldNames;
    PrintLink.DataCalc.UpdateCalcs(coAggregate, '');
    if ChooseAggregateCalcFields(PrintLink.DataCalc.DataSet, SDst, SSrc,
    PrintLink.DataCalc.AgrCalcs, 'Установка отчета') then begin
{     PrintLink.FieldNames:= SDst;}
      PrintLink.DataCalc.UpdateCalcNames(coAggregate);
    end;
  end;
end;

Procedure TPrintLinkDialog.SetCheckSheet(aSheet: TTabSheet; aChecked: Boolean);
var bSheet: TTabSheet;
begin
  if aChecked then aSheet.TabVisible:=True
  else if PC.ActivePage=aSheet then begin
    bSheet:=PC.FindNextPage(aSheet, True, True);
    aSheet.TabVisible:=False;
    PC.ActivePage:=bSheet;
    if aSheet=bSheet then aSheet.Visible:=False;
  end else aSheet.TabVisible:=False;
end;

Procedure TPrintLinkDialog.CommonItemClick(Sender: TObject);
begin
  CommonItem.Checked:=not CommonItem.Checked;
  SetCheckSheet(CommonSheet, CommonItem.Checked);
end;

Procedure TPrintLinkDialog.BoundsItemClick(Sender: TObject);
begin
  BoundsItem.Checked:=not BoundsItem.Checked;
  SetCheckSheet(BoundsSheet, BoundsItem.Checked);
end;

Procedure TPrintLinkDialog.HeadersItemClick(Sender: TObject);
begin
  HeadersItem.Checked:=not HeadersItem.Checked;
  SetCheckSheet(HeadersSheet, HeadersItem.Checked);
end;

Procedure TPrintLinkDialog.OtherItemClick(Sender: TObject);
begin
  OtherItem.Checked:=not OtherItem.Checked;
  SetCheckSheet(OtherSheet, OtherItem.Checked);
end;

Procedure TPrintLinkDialog.TableItemClick(Sender: TObject);
begin
  TableItem.Checked:=not TableItem.Checked;
  SetCheckSheet(TableSheet, TableItem.Checked);
end;

Procedure TPrintLinkDialog.PageOrientGroupClick(Sender: TObject);
var S: String;
begin
  if PageOrientGroup.ItemIndex<>FSaveOrientation then begin
    S:= HeightEdit.Text;
    HeightEdit.Text:= WidthEdit.Text;
    WidthEdit.Text:= S;
    FSaveOrientation:= PageOrientGroup.ItemIndex;
  end;
end;

end.
