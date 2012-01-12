unit DiPrint;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Spin, ComCtrls,
  EtvPrint, Dialogs;

type
  TDialPrint=class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    PageControl1: TPageControl;
    TabSheetCommon: TTabSheet;
    RadioGroupMode: TRadioGroup;
    GroupBoxRange: TGroupBox;
    LabelExamplePages: TLabel;
    RadioButtonAll: TRadioButton;
    RadioButtonPages: TRadioButton;
    EditPages: TEdit;
    LabelCopies: TLabel;
    SpinEditCopies: TSpinEdit;
    TabSheetPage: TTabSheet;
    LabelTitle: TLabel;
    GroupBoxMargins: TGroupBox;
    LabelTop: TLabel;
    LabelLeft: TLabel;
    LabelRight: TLabel;
    LabelBottom: TLabel;
    SpinEditTop: TSpinEdit;
    SpinEditLeft: TSpinEdit;
    SpinEditRight: TSpinEdit;
    SpinEditBottom: TSpinEdit;
    TabSheetNumbering: TTabSheet;
    ComboBoxV: TComboBox;
    ComboBoxH: TComboBox;
    CheckBoxNumFirstPage: TCheckBox;
    SpinEditNumPage: TSpinEdit;
    LabelFirstPage: TLabel;
    LabelFormat: TLabel;
    EditNumFormat: TEdit;
    CheckBoxNumbering: TCheckBox;
    TabSheetText: TTabSheet;
    RadioGroupText: TRadioGroup;
    BitBtnHeaderFont: TBitBtn;
    GroupBoxGraphics: TGroupBox;
    BitBtnTextFont: TBitBtn;
    LabelTitleFont: TLabel;
    LabelTextFont: TLabel;
    LabelNumFont: TLabel;
    BitBtnNumFont: TBitBtn;
    LabelInterval: TLabel;
    SpinButton1: TSpinButton;
    EditInterval: TEdit;
    MemoTitle: TMemo;
    LabelPrinter: TLabel;
    GroupBoxSize: TGroupBox;
    ComboBoxPapers: TComboBox;
    LabelWidth: TLabel;
    SpinEditPageWidth: TSpinEdit;
    LabelHeight: TLabel;
    SpinEditPageHeight: TSpinEdit;
    RadioGroupOrient: TRadioGroup;
    BitBtnPrinter: TBitBtn;
    SaveDialog: TSaveDialog;
    EditFilename: TEdit;
    SpeedButton1: TSpeedButton;
    GroupBoxPosition: TGroupBox;
    CheckBoxWOPages: TCheckBox;
    procedure BitBtnPrinterClick(Sender: TObject);
    procedure BitBtnHeaderFontClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure EditIntervalExit(Sender: TObject);
    procedure BitBtnTextFontClick(Sender: TObject);
    procedure BitBtnNumFontClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComboBoxPapersChange(Sender: TObject);
    procedure RadioGroupOrientClick(Sender: TObject);
    procedure SpinEditPageWidthChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure EditPagesChange(Sender: TObject);
    procedure EditFilenameChange(Sender: TObject);
  protected
    NamePrn,DrivPrn,PortPrn:array [0..254] of char;
    HandlePrinter:THandle;
    fProcess:boolean;
    fNumberFont,fTitleFont,fTextFont:TFont;
    fPaperHeight,fPaperWidth:TStrings;
    fPrintSet:TEtvPrintSet;
    function FontInfo(aFont:TFont):string;
    procedure CalcPrinterProperty;
    procedure CheckInterval(Change:real);
    procedure ExecuteFontDialog(aFont:TFont);
    procedure CalcPaperIndex;
  public
    function Execute(aPrintSet:TEtvPrintSet):boolean;
  end;

function DialPrint: TDialPrint;

function DeviceCapabilities(pDevice, pPort: PChar; fwCapability: Word;
  pOutput: PChar; DevMode: PDeviceMode): Integer; stdcall;

IMPLEMENTATION
uses WinSpool,Printers,
     EtvConst;
{$R *.DFM}

var fDialPrint: TDialPrint;
function DialPrint: TDialPrint;
begin
  if not assigned(fDialPrint) then
    fDialPrint:=TDialPrint.Create(nil);
  Result:=fDialPrint;
end;

function DeviceCapabilities;  external winspl name 'DeviceCapabilitiesA';

function TDialPrint.FontInfo(aFont:TFont):string;
begin
  Result:='';
  if Assigned(aFont) then With aFont do begin
    Result:=Name+', '+IntToStr(Size);
    if fsBold in style then Result:=Result+', Bold';
    if fsItalic in style then Result:=Result+', Italic';
    if fsUnderLine in style then Result:=Result+', Underline';
    if fsStrikeOut in style then Result:=Result+', StrikeOut';
  end;
end;

function TDialPrint.Execute(aPrintSet:TEtvPrintSet):boolean;
begin
  fPrintSet:=aPrintSet;
  with fPrintSet do begin
    RadioGroupMode.ItemIndex:=byte(Mode);(* 0 text; 1 graphics; 2 file*)
    SpinEditCopies.Value:=Copies;
    RadioButtonAll.Checked:=PrintRange=0; (* 0 All, 1 select *)
    RadioButtonPages.Checked:=PrintRange=1;
    EditPages.Text:=PrintRangeStr;
    MemoTitle.Text:=Title;
    EditFilename.Text:=FileName;

    if Portrait then RadioGroupOrient.ItemIndex:=0
    else RadioGroupOrient.ItemIndex:=1;
    SpinEditPageHeight.Value:=PageHeight;
    SpinEditPageWidth.Value:=PageWidth;

    SpinEditTop.Value:=MarginTop;
    SpinEditLeft.Value:=MarginLeft;
    SpinEditRight.Value:=MarginRight;
    SpinEditBottom.Value:=MarginBottom;
    CheckBoxWOPages.Checked:=WithoutPages;

    CheckBoxNumbering.Checked:=Numbering;
    CheckBoxNumFirstPage.Checked:=NumberOnFirstPage;
    if NumberTop then ComboBoxV.ItemIndex:=0
    else ComboBoxV.ItemIndex:=1;
    case NumberH of
      taLeftJustify: ComboBoxH.ItemIndex:=0;
      taCenter: ComboBoxH.ItemIndex:=1;
      taRightJustify: ComboBoxH.ItemIndex:=2;
    end;
    SpinEditNumPage.Value:=NumberFirstPage;
    EditNumFormat.Text:=NumberFormat;
    LabelNumFont.Caption:=FontInfo(NumberFont);

    RadioGroupText.ItemIndex:=Integer(TextModeFont);
      (* Default; Normal; Elite; Condensed; Condensed elite *)
    LabelTitleFont.Caption:=FontInfo(TitleFont);
    LabelTextFont.Caption:=FontInfo(TextFont);
    EditInterval.Text:=FloatToStr(Interval);
    fNumberFont:=TFont.Create;
    fTitleFont:=TFont.Create;
    fTextFont:=TFont.Create;
    fNumberFont.Assign(NumberFont);
    fTitleFont.Assign(TitleFont);
    fTextFont.Assign(TextFont);
    try
      Result:=ShowModal=idOk;
      if Result then begin
        Mode:=TPrintMode(RadioGroupMode.ItemIndex);
        Copies:=SpinEditCopies.Value;
        if RadioButtonAll.Checked then
          PrintRange:=0
        else PrintRange:=1;
        PrintRangeStr:=EditPages.Text;
        Title:=MemoTitle.Text;
        FileName:=EditFilename.Text;

        PageHeight:=SpinEditPageHeight.Value;
        PageWidth:=SpinEditPageWidth.Value;
        Portrait:=RadioGroupOrient.ItemIndex=0;
        MarginTop:=SpinEditTop.Value;
        MarginLeft:=SpinEditLeft.Value;
        MarginRight:=SpinEditRight.Value;
        MarginBottom:=SpinEditBottom.Value;
        WithoutPages:=CheckBoxWOPages.Checked;

        Numbering:=CheckBoxNumbering.Checked;
        NumberOnFirstPage:=CheckBoxNumFirstPage.Checked;
        NumberTop:=ComboBoxV.ItemIndex=0;
        case ComboBoxH.ItemIndex of
          0: NumberH:=taLeftJustify;
          1: NumberH:=taCenter;
          2: NumberH:=taRightJustify;
        end;
        NumberFirstPage:=SpinEditNumPage.Value;
        NumberFormat:=EditNumFormat.Text;
        NumberFont.Assign(fNumberFont);
        TextModeFont:=TTextFont(RadioGroupText.ItemIndex);
        TitleFont.Assign(fTitleFont);
        TextFont.Assign(fTextFont);
        try
          CheckInterval(0);
          Interval:=StrToFloat(EditInterval.Text);
        except
          Interval:=1;
        end;
      end;
    finally
      fNumberFont.Free;
      fTitleFont.Free;
      fTextFont.Free;
    end;
  end;
end;

procedure TDialPrint.BitBtnPrinterClick(Sender: TObject);
var PrinterSetupDialog:TPrinterSetupDialog;
begin
  PrinterSetupDialog:=TPrinterSetupDialog.Create(nil);
  try
    if PrinterSetupDialog.Execute then CalcPrinterProperty;
  finally
    PrinterSetupDialog.Free;
    LabelPrinter.Caption:=Printer.Printers[Printer.PrinterIndex];
  end;
end;

procedure TDialPrint.ExecuteFontDialog(aFont:TFont);
var FontDialog:TFontDialog;
begin
  FontDialog:=TFontDialog.Create(nil);
  try
    FontDialog.Font.Assign(aFont);
    if FontDialog.Execute then
      aFont.Assign(FontDialog.Font);
  finally
    FontDialog.Free;
  end;
end;

procedure TDialPrint.CheckInterval(Change:real);
var lInterval:real;
begin
  try
    lInterval:=StrToFloat(EditInterval.Text);
    lInterval:=lInterval+Change;
    if lInterval<0.5 then lInterval:=0.5;
    if lInterval>100 then lInterval:=100;
    EditInterval.Text:=FloatToStr(lInterval);
  except
    EditInterval.Text:='1';
  end;
end;

procedure TDialPrint.SpinButton1DownClick(Sender: TObject);
begin
  CheckInterval(-0.5);
end;

procedure TDialPrint.SpinButton1UpClick(Sender: TObject);
begin
  CheckInterval(0.5);
end;

procedure TDialPrint.EditIntervalExit(Sender: TObject);
begin
  CheckInterval(0);
end;

procedure TDialPrint.BitBtnHeaderFontClick(Sender: TObject);
begin
  ExecuteFontDialog(fTitleFont);
  LabelTitleFont.Caption:=FontInfo(fTitleFont);
end;

procedure TDialPrint.BitBtnTextFontClick(Sender: TObject);
begin
  ExecuteFontDialog(fTextFont);
  LabelTextFont.Caption:=FontInfo(fTextFont);
end;

procedure TDialPrint.BitBtnNumFontClick(Sender: TObject);
begin
  ExecuteFontDialog(fNumberFont);
  LabelNumFont.Caption:=FontInfo(fNumberFont);
end;

procedure TDialPrint.FormActivate(Sender: TObject);
begin
  CalcPrinterProperty;
end;

procedure TDialPrint.CalcPaperIndex;
var i,ind:integer;
begin
  ind:=ComboBoxPapers.Items.Count-1;
  if (SpinEditPageHeight.Text<>'') and (SpinEditPageWidth.Text<>'') then
    for i:=0 to fPaperHeight.Count-1 do
      if RadioGroupOrient.ItemIndex=0 then begin {portrait}
        if (Abs(SpinEditPageHeight.Value*10-StrToInt(fPaperHeight[i]))<10) and
           (Abs(SpinEditPageWidth.Value*10-StrToInt(fPaperWidth[i]))<10) then begin
          ind:=i;
          Break;
        end;
      end else
        if (Abs(SpinEditPageHeight.Value*10-StrToInt(fPaperWidth[i]))<10) and
           (Abs(SpinEditPageWidth.Value*10-StrToInt(fPaperHeight[i]))<10) then begin
          ind:=i;
          Break;
        end;
  ComboBoxPapers.ItemIndex:=ind;
end;

procedure TDialPrint.FormCreate(Sender: TObject);
begin
  Caption:=sDiPrintCaption;
  CancelBtn.Caption:=SCancelCaption;
  TabSheetCommon.Caption:=sDiPrintCommonTabs;
  LabelTitle.Caption:=sDiPrintTitle;
  LabelCopies.Caption:=sDiPrintCopies;
  RadioGroupMode.Caption:=sDiPrintMode;
  RadioGroupMode.Items.Add(sDiPrintTextMode);
  RadioGroupMode.Items.Add(sDiPrintGraphicsMode);
  RadioGroupMode.Items.Add(sDiPrintFileMode);
  GroupBoxRange.Caption:=sDiPrintPrintRange;
  LabelExamplePages.Caption:=sDiPrintExample;
  RadioButtonAll.Caption:=sDiPrintAll;
  RadioButtonPages.Caption:=sDiPrintPages;
  BitBtnPrinter.Caption:=sDiPrintPrinter;
  BitBtnPrinter.Hint:=sPrinterSetup;
  EditFilename.Hint:=sDiPrintFilenameHint;
  TabSheetPage.Caption:=sDiPrintPageTabs;
  GroupBoxMargins.Caption:=sDiPrintMargins;
  LabelTop.Caption:=sDiPrintTop;
  LabelLeft.Caption:=sDiPrintLeft;
  LabelRight.Caption:=sDiPrintRight;
  LabelBottom.Caption:=sDiPrintBottom;
  GroupBoxSize.Caption:=sDiPrintPaperSize;
  LabelWidth.Caption:=sDiPrintPaperWidth;
  LabelHeight.Caption:=sDiPrintPaperHeight;
  RadioGroupOrient.Caption:=sDiPrintOrientation;
  RadioGroupOrient.Items.Add(sDiPrintPortrait);
  RadioGroupOrient.Items.Add(sDiPrintLandscape);
  CheckBoxWOPages.Caption:=sDiPrintWOPages;
  TabSheetNumbering.Caption:=sDiPrintNumberingTabS;
  CheckBoxNumbering.Caption:=sDiPrintNumberingTabS;
  GroupBoxPosition.Caption:=sDiPrintNumberingPosition;
  LabelFirstPage.Caption:=sDiPrintNumberFirst;
  LabelFormat.Caption:=sDiPrintNumberFormat;
  CheckBoxNumFirstPage.Caption:=sDiPrintNumberFirstPage;
  EditNumFormat.Text:=sDiPrintNumberTemplate;
  BitBtnNumFont.Caption:=sDiPrintNumberFont;
  TabSheetText.Caption:=sDiPrintTextTabS;
  LabelInterval.Caption:=sDiPrintInterval;
  RadioGroupText.Caption:=sDiPrintGroupTextMode;
  GroupBoxGraphics.Caption:=sDiPrintGroupGraphicsMode;
  RadioGroupText.Items.Add(sDiPrintFontDefault);
  RadioGroupText.Items.Add(sDiPrintFontNormal);
  RadioGroupText.Items.Add(sDiPrintFontElite);
  RadioGroupText.Items.Add(sDiPrintFontCond);
  RadioGroupText.Items.Add(sDiPrintFontCondElite);
  BitBtnHeaderFont.Caption:=sDiPrintFontTitle;
  BitBtnTextFont.Caption:=sDiPrintFontText;

  fProcess:=false;
  fPaperHeight:=TStringList.Create;
  fPaperWidth:=TStringList.Create;
end;

procedure TDialPrint.FormDestroy(Sender: TObject);
begin
  fPaperHeight.Free;
  fPaperWidth.Free;
end;

procedure TDialPrint.ComboBoxPapersChange(Sender: TObject);
begin
  if (Not fProcess) and (ComboBoxPapers.ItemIndex<ComboBoxPapers.Items.Count-1) then
    With ComboBoxPapers do begin
      fProcess:=true;
      try
        if RadioGroupOrient.ItemIndex=0 then begin {portrait}
          SpinEditPageWidth.Value:=Round(StrToInt(fPaperWidth[ComboBoxPapers.ItemIndex])/10);
          SpinEditPageHeight.Value:=Round(StrToInt(fPaperHeight[ComboBoxPapers.ItemIndex])/10);
        end
        else begin
          SpinEditPageHeight.Value:=Round(StrToInt(fPaperWidth[ComboBoxPapers.ItemIndex])/10);
          SpinEditPageWidth.Value:=Round(StrToInt(fPaperHeight[ComboBoxPapers.ItemIndex])/10);
        end;
      finally
        fProcess:=false;
      end;
   end;
end;

procedure TDialPrint.RadioGroupOrientClick(Sender: TObject);
var i:integer;
begin
  i:=SpinEditPageHeight.Value;
  fProcess:=true;
  try
    SpinEditPageHeight.Value:=SpinEditPageWidth.Value;
    SpinEditPageWidth.Value:=i;
  finally
    fProcess:=false;
  end;
end;

procedure TDialPrint.SpinEditPageWidthChange(Sender: TObject);
begin
  if not fProcess then begin
    fProcess:=true;
    try
      CalcPaperIndex;
    finally
      fProcess:=false;
    end;
  end;
end;

procedure TDialPrint.SpeedButton1Click(Sender: TObject);
begin
  if SaveDialog.Execute then
    EditFileName.Text:=SaveDialog.FileName;
end;

procedure TDialPrint.CalcPrinterProperty;
var lBuf,lItem,lCurrent:pointer;
    lCount,i:integer;
begin
  LabelPrinter.Caption:=Printer.Printers[Printer.PrinterIndex];
  ComboBoxPapers.Items.Clear;
  Printer.GetPrinter(NamePrn,DrivPrn,PortPrn,HandlePrinter);
  lBuf:=nil;
  lCount:=DeviceCapabilities(NamePrn,PortPrn,DC_PAPERNAMES,lBuf,nil);
  GetMem(lBuf,lCount*64);
  try
    DeviceCapabilities(NamePrn,PortPrn,DC_PAPERNAMES,lBuf,nil);
    GetMem(lItem,64+1);
    try
      for i:=0 to lCount-1 do begin
        lCurrent:=pchar(lBuf)+i*64;
        ComboBoxPapers.Items.Add(StrPas(StrLCopy(lItem, lCurrent, 64)));
      end;
    finally
      freeMem(lItem,64+1);
    end;
  finally
    freeMem(lBuf,lCount*64);
  end;

  lBuf:=nil;
  fPaperWidth.Clear;
  fPaperHeight.Clear;
  lCount:=DeviceCapabilities(NamePrn,PortPrn,DC_PAPERSIZE,lBuf,nil);
  GetMem(lBuf,lCount*Sizeof(TPoint));
  try
    DeviceCapabilities(NamePrn,PortPrn,DC_PAPERSIZE,lBuf,nil);
    GetMem(lItem,Sizeof(TPoint));
    try
      for i:=0 to lCount-1 do begin
        lCurrent:=pchar(lBuf)+i*Sizeof(TPoint);
        fPaperWidth.Add(IntToStr(TPoint(lCurrent^).X));
        fPaperHeight.Add(IntToStr(TPoint(lCurrent^).Y));
      end;
    finally
      freeMem(lItem,SizeOf(TPoint));
    end;
  finally
    freeMem(lBuf,lCount*SizeOf(TPoint));
  end;
  CalcPaperIndex;
end;

procedure TDialPrint.EditPagesChange(Sender: TObject);
begin
  if EditPages.Text='' then RadioButtonAll.Checked:=true
  else RadioButtonPages.Checked:=true;
end;

procedure TDialPrint.EditFilenameChange(Sender: TObject);
begin
  if EditFilename.Text='' then RadioGroupMode.ItemIndex:=1
  else RadioGroupMode.ItemIndex:=2;
end;

initialization

finalization
  if Assigned(fDialPrint) then fDialPrint.Free;
end.
