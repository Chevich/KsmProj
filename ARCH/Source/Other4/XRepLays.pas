Unit XRepLays;

Interface

Uses Classes, Graphics, DB, ppTypes, ppClass, ppCtrls, XReports;

type

{ TXLineLayout }

  TXLineLayoutType = (llNone, llRail, llDoubleRail, llTop, llBottom, llFrame, llFrameComponents);

  TXLineLayout = class(TComponent)
  private
    FLineType: TXLineLayoutType;
    FIndentOffset: Integer;
  public
    property LineType: TXLineLayoutType read FLineType write FLineType;
    property IndentOffset: Integer read FIndentOffset write FIndentOffset;
  end;

{ TXBandStyle }

  TXBandStyle = class(TComponent)
  private
    FColor: TColor;
    FFont: TFont;
    FLine: Boolean;
    FLinePenColor: TColor;
    FLinePenWidth: Integer;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    property Color: TColor read FColor write FColor;
    property Font: TFont read FFont write FFont;
    property Line: Boolean read FLine write FLine;
    property LinePenColor: TColor read FLinePenColor write FLinePenColor;
    property LinePenWidth: Integer read FLinePenWidth write FLinePenWidth;
  end;


{ TXReportLayout }

  TXReportLayout = class(TComponent)
  private
    FPrintLink: TPrintLink;
    FBandStyleList: TList;
    FBandClassList: TList;
    FBandList: TList;
    FBandLayoutList: TList;
    FColumnHeaderBand: TppBand;
    FDetailBand: TppBand;
    FFooterBand: TppBand;
    FSummaryBand: TppBand;
    FReport: TXDBReport;
    FCompList: TList;
    FLabelList: TList;
    FColumnHeaderTopOffset: Integer;
    FCurrentLength: Integer;
    procedure ClearStyle;
    procedure AddBandStyle(aBand: TppBand);
    procedure ClearLayout;
    procedure AddBandLayout(aBand: TppBand; aBandLayout: TXLineLayout);
    function  StyleForBand(aBand: TppBand): TXBandStyle;
    procedure AdjustRepFieldWidths(TotalWidth: Integer; aBand: TppBand);
    procedure SetComponentLine(aBand: TppBand; aX: Integer; aY:Integer; IsLine: Boolean);
    procedure GetFieldMaps(var TotalWidth: Integer; var MaxFieldWidth: Integer;
                          var MaxLabelWidth: Integer; var FieldsOver: Boolean);
    procedure PositionControlsHorizontal(AAdjustFieldWidth: Boolean;
                           MaxFieldWidth: Integer; TotalIndent: Integer; FieldsOver: Boolean);
    procedure SetCalcComp(aField: TField; aIndex: Integer; aCalcType: TppDBCalcType);
  protected
    procedure SetStyleAttributes(aBandStyle: TXBandStyle; aBand: TppBand); virtual;
    procedure SetLayoutAttributes(aBandLayout: TXLineLayout; aBand: TppBand); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitStyle;
    procedure InitLayout;
    procedure CreateDataControls;
    procedure SetComponentSize(aComponent: TppComponent);
    function CreateLabel(ABand: TppBand; const ACaption: String): TppLabel;
    function CreateLabel1(ABand: TppBand; const ACaption: String; AFieldDisplayWidth, aWidth, aHeight: Integer): TppLabel;
    procedure PositionControls(aAdjustFieldWidth: Boolean);
    procedure CreateFinish;
    function  LayoutForBand(aBand: TppBand): TXLineLayout;
    procedure FrameComponents(aBand: TppBand);
    procedure ApplyLayout(aReport: TXDBReport);
    procedure ApplyStyle(aReport: TXDBReport);

    property ColumnHeaderTopOffset: Integer read FColumnHeaderTopOffset write FColumnHeaderTopOffset;
    property ColumnHeaderBand: TppBand read FColumnHeaderBand write FColumnHeaderBand;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
  end;
{ TXReportLayout }

Implementation

Uses SysUtils, ppClasUt, ppUtils, ppBands, ppDBBDE, ppMemo, EtvLook, EtvList, EtvppCtl,
     XMisc, LnkMisc, ppVar, Math;

Var  DeltaTop:SmallInt;
{ TXBandStyle }

Constructor TXBandStyle.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FColor:=clWhite;
  FFont:=TFont.Create;
  FLine:=False;
  FLinePenColor:=clBlack;
  FLinePenWidth:=2;
end;

Destructor TXBandStyle.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

{ TXReportLayout }

Constructor TXReportLayout.Create(aOwner: TComponent);
var
  lBand: TppBand;
begin
  Inherited Create(aOwner);
  FCompList:=TList.Create;
  FLabelList:=TList.Create;
  FBandClassList:=TList.Create;
  FBandStyleList:=TList.Create;
  FBandList:=TList.Create;
  FBandLayoutList:=TList.Create;
  FColumnHeaderBand:=nil;
  FColumnHeaderTopOffset:=5;
  if not(aOwner is TXDBReport) then Exit;
  FReport:=TXDBReport(aOwner);
  lBand:=TppBand(ppComponentCreate(FReport, TppTitleBand));
  (*lBand.spHeight:=27{50};*)
  lBand.Report:=FReport;
  FSummaryBand:=TppBand(ppComponentCreate(FReport, TppSummaryBand));
  FSummaryBand.spHeight:={26}50;
  FSummaryBand.Report:=FReport;
end;

Destructor TXReportLayout.Destroy;
begin
  ClearStyle;
  FBandStyleList.Free;
  FBandClassList.Free;
  ClearLayout;
  FBandLayoutList.Free;
  FBandList.Free;
  FLabelList.Free;
  FCompList.Free;
  Inherited Destroy;
end;

Procedure TXReportLayout.ClearStyle;
var
  liBandStyle: Integer;
  liBandStyles: Integer;
begin
  liBandStyles := FBandStyleList.Count;
  for liBandStyle := 0 to liBandStyles - 1 do TXBandStyle(FBandStyleList[liBandStyle]).Free;
  FBandStyleList.Clear;
end;

Procedure TXReportLayout.InitStyle;
var
  liBand: Integer;
  liBands: Integer;
  lBand: TppBand;
begin
  ClearStyle;
  liBands := FReport.BandCount;
  for liBand := 0 to liBands - 1 do begin
    lBand := FReport.Bands[liBand];
    AddBandStyle(lBand);
  end;
end;

Procedure TXReportLayout.AddBandStyle(aBand: TppBand);
var lStyle: TXBandStyle;
begin
  if (FBandClassList.IndexOf(aBand.ClassType) = -1) then begin
    lStyle := TXBandStyle.Create(FReport);
    FBandClassList.Add(aBand.ClassType);
    FBandStyleList.Add(lStyle);
    SetStyleAttributes(lStyle, aBand);
  end;
end;

Procedure TXReportLayout.SetStyleAttributes(aBandStyle: TXBandStyle; aBand: TppBand);
begin
  if PrintLink.TypePrint in [pdGraph, pdText] then begin
    if PrintLink.TypePrint = pdText then with ABandStyle do begin
      Font.Name:='Courier New Cyr';
      Font.Size:=15;
    end;
    with aBandStyle do begin
      {set default values}
      if PrintLink.TypePrint = pdGraph then begin
        Font.Name:='TIMES NEW ROMAN';
        Font.Size:=9;
      end;
      Font.Color:=clNavy;
      Line:=False;
      if aBand is TppDetailBand then LinePenWidth:=1;
      LinePenColor:=clNavy;
      {set values based on band}
      if (aBand is TppTitleBand) then begin
        if PrintLink.TypePrint=pdGraph then Font.Size:=12;
        Font.Style:=[fsBold, fsItalic];
      end else
        if (aBand is TppHeaderBand) then begin
          if PrintLink.TypePrint=pdGraph then Font.Size:=9;
          Font.Style := [fsBold, fsItalic];
          Line := True;
        end else
          if (aBand is TppFooterBand) then begin
            if PrintLink.TypePrint=pdGraph then Font.Size:=9;
            Line:=True;
            LinePenColor:=clGray;
            LinePenWidth:=2;
          end
        else if (aBand is TppDetailBand) then begin
          if PrintLink.TypePrint = pdGraph then begin
            Font.Name := 'ARIAL';
            Font.Size := 8;
          end;
          Font.Color := clBlack;
        end;
    end; {with, aBandStyle}
  end;
end;

Procedure TXReportLayout.ClearLayout;
var liBandLayout: Integer;
    liBandLayouts: Integer;
begin
  liBandLayouts:=FBandLayoutList.Count;
  for liBandLayout:=0 to liBandLayouts-1 do
    TXLineLayout(FBandLayoutList[liBandLayout]).Free;
  FBandLayoutList.Clear;
end;

Procedure TXReportLayout.AddBandLayout(aBand: TppBand; aBandLayout: TXLineLayout);
begin
  FBandList.Add(aBand);
  FBandLayoutList.Add(aBandLayout);
end;

Function TXReportLayout.StyleForBand(aBand: TppBand): TXBandStyle;
var liIndex: Integer;
begin
  liIndex:=FBandClassList.IndexOf(aBand.ClassType);
  if (liIndex>-1) then Result:=TXBandStyle(FBandStyleList[liIndex])
  else Result:=nil;
end;

Procedure TXReportLayout.InitLayout;
var liBand: Integer;
    liBands: Integer;
    lBand: TppBand;
    lBandLayout: TXLineLayout;
begin
  ClearLayout;
  if (FReport = nil) then Exit;
  liBands:=FReport.BandCount;
  for liBand:=0 to liBands-1 do begin
    lBand:=FReport.Bands[liBand];
    lBandLayout:=TXLineLayout.Create(FReport);
    lBandLayout.LineType:=llNone;
    SetLayoutAttributes(lBandLayout,lBand);
    AddBandLayout(lBand, lBandLayout);
  end;
end;

Procedure TXReportLayout.SetLayoutAttributes(aBandLayout: TXLineLayout; aBand: TppBand);
var liLastGroup: Integer;
begin
  if (aBand is TppTitleBand) then begin
    {do nothing}
{   aBandLayout.LineType := llBottom;}
  end else
    if (aBand is TppHeaderBand) then begin
      aBand.PrintHeight:= phDynamic;
{     aBandLayout.LineType := llBottom;}
      ColumnHeaderBand := aBand;
    end
  else if (aBand is TppDetailBand) then begin
    {do nothing}
    aBand.PrintHeight:=phDynamic;
{   TppSelfBand(aBand).PrintTimes:= ptCount;}
{   aBand.spHeight:= aBand.spHeight+4;}
{   aBandLayout.LineType := llBottom;}
  end else
    if (aBand is TppFooterBand) then begin
{          aBandLayout.LineType := llBottom;}
    end;
end;

Function ppDataTypeToComponentClass(aDataType: TppDataType): TComponentClass;
begin
  case aDataType of
    dtMemo: Result := TppDBMemo;
    dtGraphic, dtBLOB: Result := TppDBImage;
  else Result:=TppDBText;
  end;
end;

Procedure TXReportLayout.CreateDataControls;
var lComponentClass: TComponentClass;
    lBand: TppBand;
    lDetailBand: TppBand;
    lComponent: TppComponent;
{*  lFieldMap: TXFieldMapItem;}
    lDataType: TppDataType;
    liField: Integer;
    lLabel: TppLabel;
    AField:TField;
    aRepeatFieldList: TList;
{***}
    aDataset: TDataset;
begin
  lDetailBand:=FReport.GetBand(btDetail, 0);
  aRepeatFieldList:= PrintLink.DataCalc.GetCalcFields(coVisible, 'NoRep', '');
  if Assigned(FReport.DataPipeline) and
  Assigned(TppBDEPipeLine(FReport.DataPipeline).DataSource) and
  Assigned(TppBDEPipeLine(FReport.DataPipeline).DataSource.Dataset) then
  try
    TppDetailBand(lDetailBand).DataPipeLine:=FReport.DataPipeLine;
    aDataset:=TppBDEPipeLine(FReport.DataPipeline).DataSource.Dataset;
    for liField:=0 to aDataset.FieldCount-1 do begin
      aField:= aDataset.Fields[liField];
      if aField.Visible then begin
        if (aField is TEtvLookField)or(aField is TEtvListField) then begin
          lComponentClass:=TEtvPPDBText;
        end else begin
          lDataType := FReport.DataPipeline.GetFieldDataType(aField.FieldName);
          lComponentClass := ppDataTypeToComponentClass(lDataType);
        end;
        {create component}
        lComponent:=TppComponent(ppComponentCreate(FReport, lComponentClass));
        lComponent.DataField:=aField.FieldName;
        lComponent.DataPipeline:=FReport.DataPipeline;
        if aField is TEtvLookField then begin
          TEtvPPDBText(lComponent).LookField:=TEtvLookField(aField).LookupResultField;
        (*TEtvPPDBText(lComponent).OnPrint:=TEtvPPDBText(lComponent).LevEtvPpDBTextPrint;*)
        end;
        if lComponent is TppDBText then begin
          if aField is TNumericField then
            TppDBText(lComponent).DisplayFormat:= TNumericField(aField).DisplayFormat;
          TppDBText(lComponent).SuppressRepeatedValues:= aRepeatFieldList.IndexOf(aField)<>-1;
        end;
        lBand:=lDetailBand;
 {!?    if (lFieldMap.GroupOrder <> -1) and (lComponent is TppDBText) then
        TppDBText(lComponent).SuppressRepeatedValues := True;}
        lComponent.Band:=lBand;
        SetComponentSize(lComponent);
        {create label for component}
        lLabel:=CreateLabel1(ColumnHeaderBand, aField.DisplayLabel, aField.DisplayWidth, lComponent.spWidth, lComponent.spHeight);

        {save reference to component}
     {  lFieldMap.ppComponent := lComponent;
        lFieldMap.ppLabel := lLabel;}
        FCompList.Add(lComponent);
        FLabelList.Add(lLabel);
   {
        if (lLabel <> nil) then
          if (lComponent.spWidth > lLabel.spWidth) then
             lFieldMap.ColumnWidth := lComponent.spWidth
           else
             lFieldMap.ColumnWidth := lLabel.spWidth;
   }
      end else begin
        FCompList.Add(nil);
        FLabelList.Add(nil);
      end;
    end;
  Finally
    aRepeatFieldList.Free;
  end;
end;

Procedure TXReportLayout.SetComponentSize(aComponent: TppComponent);
var lBandStyle: TXBandStyle;
    aWidth, aHeight, liDisplayWidth: Integer;
    lAlignment: TAlignment;
    aBand: TppBand;
    lLine: TppLine;
begin
  if aComponent.HasFont then begin
    lBandStyle := StyleForBand(aComponent.Band);
    GetFontCharSizes(lBandStyle.Font, aWidth, aHeight);
    if (aComponent.DataPipeline<>nil) and (aComponent.DataField<>'') then begin
      liDisplayWidth:=aComponent.DataPipeline.GetFieldDisplayWidth(aComponent.DataField);
      lAlignment:=aComponent.DataPipeline.GetFieldAlignment(aComponent.DataField);
    end else begin
      liDisplayWidth:=Length(aComponent.Text);
      lAlignment:=taLeftJustify;
    end;
    aComponent.spWidth:=liDisplayWidth*aWidth+1;
    aComponent.spHeight:=aHeight+2;
    aComponent.Alignment:=lAlignment;
  end;
  if (aComponent is TppCustomImage) then
    begin
      TppCustomImage(aComponent).Stretch := True;
      aComponent.spWidth  := 50;
      aComponent.spHeight := 50;
    end
  else if (aComponent is TppCustomMemo) then
    begin
      aComponent.spWidth   := 150;
      aComponent.spHeight := 50;
    end;
end;

Function TXReportLayout.CreateLabel1(ABand: TppBand; const ACaption: String; aFieldDisplayWidth, aWidth, aHeight: Integer): TppLabel;
var lStyle: TXBandStyle;
    lWrappedText: TStrings;
    lTextBuf: PChar;
    lRect: TppRect;
    Priz: Boolean;
    lPos: LongInt;
begin
  lStyle:=StyleForBand(aBand);
  Result:=TppLabel(ppComponentCreate(FReport,TppLabel));
  Result.AutoSize:=False;
  Result.Caption:=aCaption;
  Result.Transparent:=True;
  Result.Font:=lStyle.Font;
{  Result.Font.Style := Result.Font.Style + [fsBold];}
  Result.Alignment:=taCenter;
  Result.Band:=aBand;
  {size the label}
  Result.spHeight:=aHeight;
  Result.spWidth:=aWidth;
  Result.WordWrap:=True;
  Result.Autosize:=True;

  lWrappedText:=TStringList.Create;
  lTextBuf:=Result.GetTextBuf;

  {Result.spHeight:=Result.spHeight+aHeight;}
  lRect.Left:=0;
  lRect.Top:=0;
  lRect.Right:=Result.mmWidth;
  lRect.Bottom:=Result.mmHeight;
  lPos:=0;
  Priz:=True{False};
  ppWordWrap(lTextBuf, lRect, lStyle.Font, 0, True, lWrappedText, nil,
                 aBand.Report.Units, False, nil, lPos, Priz);

  Result.spHeight:=lWrappedText.Count*
   (aHeight+(Byte(PrintLink.TypePrint<>PdGraph)*4));
(*
  MaxWidth:=0;
  for i:=0 to lWrappedText.Count-1 do begin
    MaxWidth:=Max(MaxWidth,Length(lWrappedText[i]));
  end;
  if MaxWidth-1>aFieldDisplayWidth then
    Result.spWidth:=(aWidth div aFieldDisplayWidth)*(MaxWidth-1);
*)
  { Для отладки }
  {Result.spHeight:=(Result.spHeight div 32) * 28;}
  lWrappedText.Free;
  StrDispose(lTextBuf);
end;

Procedure TXReportLayout.AdjustRepFieldWidths(TotalWidth: Integer; aBand: TppBand);
var liFields: Integer;
    liField: Integer;
    liMinWidth: Integer;
    liOver: Integer;
    leRatio: Extended;
    liFieldWidth: Integer;
    liLabelWidth: Integer;
    liWidth: Integer;
    aField: TField;
    aDataset: TDataset;
begin
  aDataset:=TppBDEPipeLine(FReport.DataPipeline).DataSource.Dataset;
  liMinWidth:=5;
  liOver:=(TotalWidth-aBand.spWidth);
  if (liOver<=0) then Exit;
  {provide for some margin on the right}
  liOver:=liOver + 15;
  liFields:=aDataset.FieldCount;
  for liField:=0 to liFields - 1 do begin
    aField:=aDataset.Fields[liField];
    if aField.Visible then begin
      liFieldWidth:=TppComponent(FCompList[liField]).spWidth;
      liLabelWidth:=TppLabel(FLabelList[liField]).spWidth;
      if liFieldWidth>liLabelWidth then liWidth:=liFieldWidth
      else liWidth:=liLabelWidth;
   {! liWidth := liFieldWidth;}
      leRatio:=liWidth/TotalWidth;
   {!!!Ratio      liWidth := liWidth - Round((liOver * leRatio) + 0.5);}
   {* if (liWidth >= liMinWidth) then
      lFieldMap.ColumnWidth := liWidth
         else
           lFieldMap.ColumnWidth := liMinWidth;}
   {?      ALayout.SetComponentSize(lFieldMap.ppLabel);}
    end;
  end;
end;

Procedure TXReportLayout.GetFieldMaps(var TotalWidth: Integer; var MaxFieldWidth: Integer;
                                      var MaxLabelWidth: Integer; var FieldsOver: Boolean);
var liField: Integer;
    liFieldWidth: Integer;
    liLabelWidth: Integer;
    lDetailBand: TppBand;
    liSpacer: Integer;
    aField: TField;
    aDataset: TDataset;
begin
  aDataset:=TppBDEPipeLine(FReport.DataPipeline).DataSource.Dataset;
  liSpacer:=5;
  for liField:=0 to aDataset.FieldCount-1 do begin
    aField:=aDataset.Fields[liField];
    if aField.Visible then begin
      {determine max width}
      liFieldWidth:=TppComponent(FCompList[liField]).spWidth;
      liLabelWidth:=TppLabel(FLabelList[liField]).spWidth;
      if (liFieldWidth>MaxFieldWidth) then MaxFieldWidth:=liFieldWidth;
      if liLabelWidth>MaxLabelWidth then MaxLabelWidth:=liLabelWidth;
      if liFieldWidth>liLabelWidth then Inc(TotalWidth, liFieldWidth+liSpacer)
      else Inc(TotalWidth, liLabelWidth + liSpacer);
    end;
  end;  {for, each fieldmap}
  {remove spacer for last column}
  if TotalWidth>0 then TotalWidth:=TotalWidth - liSpacer;
  {determine if controls fit in band}
  lDetailBand:=FReport.GetBand(btDetail, 0);
  FieldsOver:=((TotalWidth + (5 * (aDataset.FieldCount-1)))>lDetailBand.spWidth);
end;

Procedure TXReportLayout.PositionControls(aAdjustFieldWidth: Boolean);
var liIndent: Integer;
    liTotalIndent: Integer;
    liMaxFieldWidth: Integer;
    liMaxLabelWidth: Integer;
    liTotalWidth: Integer;
    lbFieldsOver: Boolean;
begin
  {  lHeaderBand := ColumnHeaderBand;}
  FDetailBand:=FReport.GetBand(btDetail, 0);
  FFooterBand:=FReport.GetBand(btFooter, 0);
  {collect field and group maps}
  liTotalWidth:=0;
  liMaxFieldWidth:=0;
  liMaxLabelWidth:=0;
  lbFieldsOver:=False;
  {  AAdjustFieldWidth:= False;{?}
  GetFieldMaps(liTotalWidth, liMaxFieldWidth, liMaxLabelWidth, lbFieldsOver);
  {recalc control widths to fit in band}
{ if lbFieldsOver and aAdjustFieldWidth then
    AdjustRepFieldWidths(liTotalWidth, FDetailBand);}
  {position group band components}
  liIndent:=20;
  liTotalIndent:=0;
  PositionControlsHorizontal(aAdjustFieldWidth,liMaxFieldWidth,liTotalIndent,lbFieldsOver);
end;

Procedure TXReportLayout.SetComponentLine(aBand: TppBand; aX: Integer; aY: Integer; IsLine: Boolean);
var lLine: TppLine;
begin
  { Set vertical lines }
  if IsLine then begin
    {aBand:= aComponent.Band;}
    if Assigned(aBand) then begin
      lLine:=TppLine(ppComponentCreate(FReport, TppLine));
      lLine.spWidth:=2;
      lLine.Style:=lsSingle;
      lLine.Position:=lpLeft;
      lLine.spTop:=0;
{     lLine.spLeft := aComponent.spWidth+aComponent.spLeft;}
      lLine.spLeft:=aX;
   {  lLine.spWidth := liWidth+2;}
{     lLine.spHeight := aComponent.spHeight;}
      lLine.spHeight:={aBand.spHeight}aY;
{     aBand.spHeight:= aY;}
      lLine.Band:=aBand;
      lLine.SendToBack;
    end;
  end;
end;

Procedure TXReportLayout.SetCalcComp(aField: TField; aIndex: Integer; aCalcType: TppDBCalcType);
var lComponent: TppComponent;
    lCalc: TppDBCalc;
begin
  lComponent:=TppComponent(FCompList[aIndex]);
  lCalc:=TppDBCalc(ppComponentCreate(FReport,TppDBCalc));
  lCalc.DataField:=aField.FieldName;
  lCalc.DataPipeline:=FReport.DataPipeline;
  lCalc.DBCalcType:=aCalcType;
  lCalc.Alignment:=lComponent.Alignment;
  lCalc.spHeight:=lComponent.spHeight;
  lCalc.spWidth:=lComponent.spWidth;
  (*lCalc.spTop:={lComponent.spTop+}23;*)
  lCalc.spLeft:=lComponent.spLeft-3;
  lCalc.spTop:=lComponent.spTop;
  if aField is TNumericField then
    lCalc.DisplayFormat:= TNumericField(aField).DisplayFormat;
  if PrintLink.DataCalc.TypeResult=rsLocal then begin
    lCalc.Band:= FFooterBand;
    if PrintLink.TypePrint<>PdGraph then lCalc.spTop:=lCalc.spTop+9;
  end else begin
    lCalc.Band:=FSummaryBand;
    if PrintLink.TypePrint<>PdGraph then lCalc.spTop:=lCalc.spTop+{19}25;
  end;
    {  SetComponentLine(FooterBand, lComponent.spLeft-liSpacer1,
       lComponent.spHeight+lComponent.spTop+2, liField>0);}
end;

Function IsFieldInList(aFieldName: String; aList: TList): Boolean;
var i: Integer;
begin
  Result:= False;
  for i:= 0 to aList.Count-1 do
    if AnsiCompareText(TField(AList[i]).FieldName, aFieldName)=0 then begin
      Result:= True;
      Break;
    end;
end;

Procedure CreateNewReportLine(aReport: TXDBReport; aBand: TppBand; aStyle: TppLineStyleType;
                aPos: TppLinePositionType; aTop, aLeft, aHeight, aWidth: Integer; aAddName: String);
                                                            { добавка к имени для идентификации }
Const Num:integer=0;
var lLine: TppLine;
begin
  lLine:=TppLine(ppComponentCreate(aReport, TppLine));
  with lLine do begin
    if aAddName<>'' then begin
      Inc(Num);
      Name:=Name+IntToStr(Num)+aAddName;
    end;
    Style:=aStyle;
    Position:=aPos;
    spTop:=aTop;
    spLeft:=aLeft;
    spHeight:=aHeight;
    spWidth:=aWidth;
    Band:=aBand;
    SendToBack;
  end;
end;

Procedure TXReportLayout.PositionControlsHorizontal(AAdjustFieldWidth: Boolean;
                      MaxFieldWidth: Integer; TotalIndent: Integer; FieldsOver: Boolean);
var
  liTop: Integer;
  liHeaderTop: Integer;
  liMaxBottom: Integer;
  liStartPosition: Integer;
  liCurrentPosition: Integer;
  lComponent: TppComponent;
  lLabel: TppLabel;
  liSpacer: Integer;
  liSpacer1: Integer;
  liField: Integer;
  liWidth: Integer;
  liChange: Integer;
  aBand: TppBand;
  lCharWidth, lCharHeight, lHeight, lMaxLabelHeight: Integer;

  CountCalcList, SumCalcList, MinCalcList, MaxCalcList, AverCalcList: TList;
  aField: TField;
  aDataset: TDataset;

begin
  liTop:=4;
  liHeaderTop:=ColumnHeaderTopOffset;
  liMaxBottom:=0;
  GetFontCharSizes(FReport.PrintLink.Font, lCharWidth, lCharHeight);
  liSpacer:=lCharWidth*3{44{!5};
  liSpacer1:=lCharWidth*2{liSpacer div 2};
  lMaxLabelHeight:=0;
  if TotalIndent=0 then liStartPosition:=lCharWidth*2{22{!5}
  else liStartPosition:=TotalIndent;
  liCurrentPosition:=liStartPosition;
  aDataset:=TppBDEPipeLine(FReport.DataPipeline).DataSource.Dataset;
  {position detail band components (going from left to right)}
  for liField:=0 to aDataset.FieldCount - 1 do begin
    {Dec(liCurrentPosition,2);}
    aField:=aDataset.Fields[liField];
    if aField.Visible then begin
      lComponent:=TppComponent(FCompList[liField]);
      liWidth:=lComponent.spWidth;
      if (liCurrentPosition + liWidth +liSpacer1 > FDetailBand.spWidth ) then begin
        FReport.PrinterSetup.PaperWidth:=ppFromScreenPixels(liCurrentPosition+liWidth+LiSpacer1+
        ppToScreenPixels(FReport.PrinterSetup.MarginLeft,FReport.Units, pprtHorizontal,nil)+
        ppToScreenPixels(FReport.PrinterSetup.MarginRight,FReport.Units, pprtHorizontal,nil),
        FReport.Units, pprtHorizontal,nil)
      end;
      lComponent.spLeft:=liCurrentPosition-4;
      lComponent.spTop:=liTop;
      {create label}
      lLabel:=TppLabel(FLabelList[liField]);
      lLabel.spLeft:=liCurrentPosition-4;
   {  lLabel.spTop  := liTop;}
      lLabel.spTop:=liHeaderTop;
   {  lLabel.spHeight:=lLabel.spHeight+lLabel.spHeight;}
      if lMaxLabelHeight<lLabel.spHeight then lMaxLabelHeight:=lLabel.spHeight;

      if poVertLines in PrintLink.DataOptions then
        SetComponentLine(FDetailBand, lComponent.spLeft-liSpacer1+6,
          lComponent.spHeight+lComponent.spTop-2, liField>0);
      (* lLabel.Alignment:=taCenter;{lComponent.Alignment;} *)
      if AAdjustFieldWidth and FieldsOver then begin
        if not(aField is TEtvLookField) then liWidth:=aField.DisplayWidth{+1}
        else liWidth:=aField.DisplayWidth{+1}-3;
        lComponent.spWidth:=Max(lLabel.spWidth,liWidth*lCharWidth);
        lLabel.spWidth:=lComponent.spWidth; {(aField.DisplayWidth+1)*lCharWidth;}
      end;
      {determine width of this column}
      if (lComponent.spWidth > lLabel.spWidth) then liWidth:=lComponent.spWidth
      else liWidth:=lLabel.spWidth;
      liCurrentPosition:=liCurrentPosition+liWidth+liSpacer{33{liSpacer{+ liSpacer1};
      {update band height, if necessary}
      if ((lComponent.spTop+lComponent.spHeight)>liMaxBottom) then
        liMaxBottom:=lComponent.spTop+lComponent.spHeight;
      {adjust right-aligned controls}
      if (lLabel.spWidth>lComponent.spWidth) and (lComponent.Alignment=taRightJustify) then
        lComponent.spLeft:=lComponent.spLeft+(lLabel.spWidth-lComponent.spWidth);
        {update band height, if necessary}
      if (lComponent.spTop+lComponent.spHeight)>liMaxBottom then
        liMaxBottom:=lComponent.spTop+lComponent.spHeight;
      if (liMaxBottom>FDetailBand.spHeight) then FDetailBand.spHeight:=liMaxBottom + 5;
    end;
  end; {for, each field map}
  DeltaTop:=0; { Для графического режима всегда 0 }

  FCurrentLength:=liCurrentPosition;
  if poDetailBorder in PrintLink.DataOptions then begin
    {detail right line }
    CreateNewReportLine(FReport, FDetailBand, lsSingle, lpRight, 0,
      liCurrentPosition-liSpacer1{14}, lComponent.spHeight+lComponent.spTop-2,2,'Border');
    {detail left line }
    CreateNewReportLine(FReport, FDetailBand, lsSingle, lpLeft,
      0, liStartPosition-liSpacer1{14}, lComponent.spHeight+lComponent.spTop-2,2,'Border');
  end;

  if poHorzLines in PrintLink.DataOptions then begin
    {detail bottom line }
    CreateNewReportLine(FReport, FDetailBand, lsSingle, lpBottom,
      0, liStartPosition-liSpacer1{12},
        lComponent.spHeight+lComponent.spTop-2{+2}, liCurrentPosition-liSpacer1{12},'');
  end;

  if (poHeaderBorder in PrintLink.DataOptions) or (poVertLines in PrintLink.DataOptions) or
  (poHorzLines in PrintLink.DataOptions) then begin
    for liField := 0 to aDataset.FieldCount-1 do begin
      aField:=aDataset.Fields[liField];
      if aField.Visible then begin
        lLabel:=TppLabel(FLabelList[liField]);
        SetComponentLine(ColumnHeaderBand, lLabel.spLeft-liSpacer1+6,
          lMaxLabelHeight+lLabel.spTop{-2}{+2}, liField>0);
      end;
    end;
    if PrintLink.DataCalc.TypeResult in [rsLocal, rsGlobal] then begin
      if PrintLink.DataCalc.TypeResult=rsLocal then begin
        aBand:=FFooterBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:=24;
      end else begin
        aBand:=FSummaryBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:=25{35};
      end;

      for liField := 0 to aDataset.FieldCount-1 do begin
        aField:=aDataset.Fields[liField];
        if aField.Visible then begin
          lComponent:=TppComponent(FCompList[liField]);
          SetComponentLine(aBand, lComponent.spLeft-liSpacer1+6,
            lComponent.spHeight+lComponent.spTop+DeltaTop, liField>0);
        end;
      end
    end else {SetComponentLine(FFooterBand, lComponent.spLeft-liSpacer1,
           lComponent.spHeight+lComponent.spTop+2, liField>0)}
{ Lev 10.99 }
        CreateNewReportLine(FReport, FFooterBand, lsSingle, lpTop,
           0, liStartPosition-liSpacer1{12},
          lComponent.spHeight+lComponent.spTop-2, liCurrentPosition-liSpacer1{12},'');
{  Lev 10.99 }
  end;

  {result context}
  if PrintLink.DataCalc.TypeResult in [rsLocal, rsGlobal] then begin
    CountCalcList:=PrintLink.DataCalc.GetCalcFields(coResult, 'Count', '');
    SumCalcList:=PrintLink.DataCalc.GetCalcFields(coResult, 'Sum', '');
    MinCalcList:=PrintLink.DataCalc.GetCalcFields(coResult, 'Min', '');
    MaxCalcList:=PrintLink.DataCalc.GetCalcFields(coResult, 'Max', '');
    AverCalcList:=PrintLink.DataCalc.GetCalcFields(coResult, 'Aver', '');
    for liField := 0 to aDataset.FieldCount-1 do begin
      aField:=aDataset.Fields[liField];
      if aField.Visible then begin
        if IsFieldInList(aField.FieldName, CountCalcList) then
          SetCalcComp(aField, liField, dcCount)
        else
          if IsFieldInList(aField.FieldName, SumCalcList) then
            SetCalcComp(aField, liField, dcSum)
          else
            if IsFieldInList(aField.FieldName, MinCalcList) then
              SetCalcComp(aField, liField, dcMinimum)
            else
              if IsFieldInList(aField.FieldName, MaxCalcList) then
                SetCalcComp(aField, liField, dcMaximum)
              else
                if IsFieldInList(aField.FieldName, AverCalcList) then
                   SetCalcComp(aField, liField, dcAverage);
      end;
    end;
    CountCalcList.Free;
    SumCalcList.Free;
    MinCalcList.Free;
    MaxCalcList.Free;
    AverCalcList.Free;
  end;

  { ПРАВЫЕ И ЛЕВЫЕ БОРДЮРНЫЕ ЛИНИИ }
  if poHeaderBorder in PrintLink.DataOptions then begin
    {label right line }
    CreateNewReportLine(FReport, ColumnHeaderBand, lsSingle, lpRight,
      0, liCurrentPosition-liSpacer1{14}, lMaxLabelHeight+lLabel.spTop{-2}{+2}, 2,'');
    {label left line }
    CreateNewReportLine(FReport, ColumnHeaderBand, lsSingle, lpLeft,
      0, liStartPosition-liSpacer1{14}, lMaxLabelHeight+lLabel.spTop{-2}{+2}, 2,'');
    if PrintLink.DataCalc.TypeResult in [rsLocal, rsGlobal] then begin
      if PrintLink.DataCalc.TypeResult=rsLocal then begin
        aBand:=FFooterBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:=24;
      end else begin
        aBand:=FSummaryBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:=25{35}{17};
      end;
      {result right line }
      CreateNewReportLine(FReport, aBand, lsSingle, lpRight,
        0, liCurrentPosition-liSpacer1{14}, lComponent.spHeight+lComponent.spTop{-2}{+2}+DeltaTop,2,'');
      {result left line }
      CreateNewReportLine(FReport, aBand, lsSingle, lpLeft,
        0, liStartPosition-liSpacer1{14}, lComponent.spHeight+lComponent.spTop{-2}{+2}+DeltaTop,2,'');
    end;
  end;

  if (poHeaderBorder in PrintLink.DataOptions) or (poHorzLines in PrintLink.DataOptions) then begin
    {label top line }
    lHeight:=lMaxLabelHeight+lLabel.spTop{-2}{+2};
{Lev}
(*
    if not FPrintLink.TextLink.SkipTextLines and (lHeight mod 26>0)
    and (PrintLink.TypePrint<>PdGraph) then lHeight:=(lHeight div 26)*26;
*)
{Lev}
    CreateNewReportLine(FReport, ColumnHeaderBand, lsSingle, lpTop,
      0, liStartPosition-liSpacer1{12}, lHeight, liCurrentPosition-liSpacer1{12},'');

    if PrintLink.DataCalc.TypeResult in [rsLocal,rsGlobal] then begin
      {result top line }
{Lev} lHeight:=lComponent.spHeight{+19}+lComponent.spTop{-2}{+2};
      if {not FPrintLink.TextLink.SkipTextLines}True and (lHeight mod 26>0)
      and (PrintLink.TypePrint<>PdGraph) then lHeight:=lHeight-(lHeight mod 26)+26;
{Lev}
      if PrintLink.DataCalc.TypeResult=rsLocal then begin
        aBand:=FFooterBand;
        DeltaTop:=0;
      end else begin
        aBand:=FSummaryBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:={11}{17}23;
      end;
      CreateNewReportLine(FReport, aBand, lsSingle, lpTop,
        0+DeltaTop, liStartPosition-liSpacer1{12}, lHeight, liCurrentPosition-liSpacer1{12},'');
    end;
(*
    if PrintLink.DataCalc.TypeResult=rsGlobal then begin
      {result top line }
{Lev} lHeight:=lComponent.spHeight+19{+lComponent.spTop+2};
      if not FPrintLink.TextLink.SkipTextLines and (lHeight mod 26>0) then
        lHeight:=lHeight-(lHeight mod 26)+26;
{Lev}
      CreateNewReportLine(FReport, FSummaryBand, lsSingle, lpTop,
        0+26, liStartPosition-liSpacer1{12}, lHeight, liCurrentPosition-liSpacer1{12});
    end;
*)
  end;

  if (poHeaderBorder in PrintLink.DataOptions) or (poVertLines in PrintLink.DataOptions) or
  (poHorzLines in PrintLink.DataOptions) or (poDetailBorder in PrintLink.DataOptions) then begin
    {label bottom line }
    lHeight:=lMaxLabelHeight+lLabel.spTop{-2};
{Lev}
(*
    if not FPrintLink.TextLink.SkipTextLines and (lHeight mod 26>0)
    and (PrintLink.TypePrint<>PdGraph) then lHeight:=(lHeight div 26)*26;
*)
{Lev}
    { Нижняя линия шапки заголовков столбцов... ох и достала она меня в текстовом режиме... 09.10.2004 Lev }
    CreateNewReportLine(FReport, ColumnHeaderBand, lsSingle, lpBottom,
      0, liStartPosition-liSpacer1{12}, Round(lHeight/26+0.5)*26, liCurrentPosition-liSpacer1{12},'');
    if PrintLink.DataCalc.TypeResult in [rsLocal, rsGlobal] then begin
      {result bottom line }
      lHeight:=lComponent.spHeight{lComponent.spTop+2};
      {if PrintLink.TypePrint<>PdGraph then} Inc(lHeight,6);
{Lev}
      if not FPrintLink.TextLink.SkipTextLines{True} and (lHeight mod 26>0)
      and (PrintLink.TypePrint<>PdGraph) then lHeight:=lHeight-(lHeight mod 26)+26;
{Lev}
      if PrintLink.DataCalc.TypeResult=rsLocal then begin
        aBand:=FFooterBand;
        DeltaTop:=0;
      end else begin
        aBand:=FSummaryBand;
        if PrintLink.TypePrint<>PdGraph then DeltaTop:={11}{17}23;
      end;
      CreateNewReportLine(FReport, aBand, lsSingle, lpBottom,
        0+DeltaTop, liStartPosition-liSpacer1{12}, lHeight, liCurrentPosition-liSpacer1{12},'');
    end;
  end;
end;

Function TXReportLayout.CreateLabel(ABand: TppBand; const ACaption: String): TppLabel;
var lStyle: TXBandStyle;
    lWidth, lHeight: Integer;
begin
  lStyle:=StyleForBand(aBand);
  {create the label}
  Result:=TppLabel(ppComponentCreate(FReport,TppLabel));
  Result.AutoSize:=False;
  Result.Caption:=aCaption;
  Result.Transparent:=True;
  Result.Font:=lStyle.Font;
  Result.Font.Style:=Result.Font.Style + [fsBold];
  Result.Band:=aBand;
  {size the label}
  GetFontCharSizes(Result.Font, lWidth, lHeight);
  Result.spHeight:=lHeight;
  Result.spWidth:=lWidth*Length(aCaption){lBitmap.Canvas.TextWidth(aCaption)};
{Lev}
  Result.WordWrap:=true;
{  Result.Caption := aCaption;}
end;

Procedure TXReportLayout.CreateFinish;
var lLabel: TppLabel;
    lCalc: TppCalc;
    lBand: TppBand;
    lStyle: TXBandStyle;
    lWidth, lHeight: Integer;
    lLeft: Integer;
begin
  if PrintLink.UpLink.Align<>xaNone then begin
    lBand:=FReport.GetBand(btTitle, 0);
    lLabel:=CreateLabel(lBand, FReport.Template.Description);
    if PrintLink.TypePrint<>PdGraph then lLabel.spTop:=5;
    lLabel.spLeft:=5;
    lLabel.spHeight:=28;
    if lLabel.spWidth<FCurrentLength then lLabel.spWidth:= FCurrentLength;
    case PrintLink.UpLink.Align of
      xaLeft: lLabel.Alignment:= taLeftJustify;
      xaMiddle: lLabel.Alignment:= taCenter;
      xaRight: lLabel.Alignment:= taRightJustify;
    end;
  end;

  lBand:=FReport.GetBand(btFooter, 0);
  lStyle:=StyleForBand(lBand);
  GetFontCharSizes(lStyle.Font, lWidth, lHeight);

  lLeft:= 5;
  if PrintLink.DownLink.Align<>xaNone then begin
    lLabel:=CreateLabel(lBand, PrintLink.DownLink.Title);
    lLabel.spTop:=5;
    lLabel.spLeft:=lLeft;
    Inc(lLeft,lLabel.spWidth+5);
  end;
  if PrintLink.DetailLink.DateAlign<>xaNone then begin
    lCalc:=TppCalc(ppComponentCreate(FReport, TppCalc));
    lCalc.Font:=lStyle.Font;
    lCalc.CalcType:=ctPrintDateTime;
    lCalc.Band:=lBand;
   {lCalc.Caption:=lCalc.Text;}
    lCalc.spWidth:=lWidth*Length(lCalc.Text);
    case PrintLink.DataCalc.TypeResult of
      rsNone, rsGlobal: lCalc.spTop:= 5;
      rsLocal:          lCalc.spTop:= 5+(lHeight+8);
    end;
    lCalc.spLeft := lLeft;
  end;

  if PrintLink.DetailLink.PageNumAlign<>xaNone then begin
    lCalc:=TppCalc(ppComponentCreate(FReport, TppCalc));
    lCalc.Font:=lStyle.Font;
    lCalc.CalcType:=ctPageNo{ctPageSetDesc};
    lCalc.Alignment:=taRightJustify;
    lCalc.Band:=lBand;
    {lCalc.Caption:=lCalc.Text;}
    lCalc.spWidth:=lWidth*(Length(lCalc.Text)+3);
    case PrintLink.DataCalc.TypeResult of
      rsNone, rsGlobal: lCalc.spTop:= 5;
      rsLocal:          lCalc.spTop:= 5+(lHeight+8);
    end;
    lCalc.spLeft:=lCalc.Band.spWidth-lCalc.spWidth-5-2;{-2}
  end;
end;

Function TXReportLayout.LayoutForBand(aBand: TppBand): TXLineLayout;
var liIndex: Integer;
begin
  liIndex:=FBandList.IndexOf(aBand);
  if (liIndex>-1) then Result:=TXLineLayout(FBandLayoutList[liIndex])
  else Result:=nil;
end;

Procedure TXReportLayout.FrameComponents(aBand: TppBand);
var liComponents: Integer;
    liComponent: Integer;
    lComponent: TppComponent;
    liRight: Integer;
    liNextLeft: Integer;
    liPreviousRight: Integer;
    lLeftToRight: TStringList;
    lShape: TppShape;
    lsTopLeft: String;
    liTop: Integer;
begin
  liNextLeft:=0;
  liPreviousRight:=0;
  liComponents:=aBand.ObjectCount;
  lLeftToRight:=TStringList.Create;
  {get component positions}
  for liComponent:=0 to liComponents - 1 do begin
    lComponent:=aBand.Objects[liComponent];
    lsTopLeft:=Format('%8d',[lComponent.spTop]) + Format('%8d',[lComponent.spLeft]);
    lLeftToRight.AddObject(lsTopLeft, lComponent);
  end;
  lLeftToRight.Sort;
  liTop:=-1;
  {put shapes around each component}
  for liComponent:=0 to liComponents - 1 do begin
    lComponent:=TppComponent(lLeftToRight.Objects[liComponent]);
    if liComponent<>liComponents - 1 then
      liNextLeft:=TppComponent(lLeftToRight.Objects[liComponent + 1]).spLeft;
    if (liNextLeft<lComponent.spLeft) then
      liNextLeft:=lComponent.spLeft+lComponent.spWidth+2
    else if (liNextLeft=lComponent.spLeft) then
           liNextLeft:=lComponent.spLeft+lComponent.spWidth+4;
    if (lComponent.spTop<>liTop) then begin
      liPreviousRight:=2;
      liTop:=lComponent.spTop;
    end;
    lShape:=TppShape(ppComponentCreate(FReport, TppShape));
    lShape.spTop:=lComponent.spTop-2;
    lShape.spHeight:=lComponent.spHeight+4;
    lShape.spLeft:=liPreviousRight;
    liRight:=lComponent.spLeft+lComponent.spWidth+
      ((liNextLeft-(lComponent.spLeft+lComponent.spWidth)) div 2);
    lShape.spWidth:=(liRight-lShape.spLeft)+1;
    lShape.Band:=aBand;
    lShape.SendToBack;
    liPreviousRight:=liRight;
  end; {for, each component}
  lLeftToRight.Free;
end; {procedure, FrameComponents}

Procedure TXReportLayout.ApplyLayout(aReport: TXDBReport);
var liBands: Integer;
    liBand: Integer;
    lBand: TppBand;
    lBandLayout: TXLineLayout;
    liComponent: Integer;
    liComponents: Integer;
    lComponent: TppComponent;
    lLine: TppLine;
    lShape: TppShape;
    liMinTop: Integer;
    liMaxBottom: Integer;
    liMinLeft: Integer;
    liWidth: Integer;
begin
  liBands:=aReport.BandCount;
  for liBand:= 0 to liBands - 1 do begin
    lBand:=aReport.Bands[liBand];
    lBandLayout:=LayoutForBand(lBand);
    liComponents:=lBand.ObjectCount;
    liMinTop:=lBand.spHeight;
    liMaxBottom:=0;
    liMinLeft:=lBand.spWidth;
    {calc component positions}
    for liComponent:=0 to liComponents-1 do begin
      lComponent:=lBand.Objects[liComponent];
      {calculate maxbottom, mintop and minleft for this row}
      if (lComponent.spTop+lComponent.spHeight)>liMaxBottom then
        liMaxBottom:=lComponent.spTop+lComponent.spHeight;
      if (lComponent.spTop<liMinTop) then liMinTop:=lComponent.spTop;
      if (lComponent.spLeft < liMinLeft) then liMinLeft:=lComponent.spLeft;
    end; {for, each component}
    if (liMaxBottom>0) then begin
{Lev}
      if FPrintLink.TypePrint<>pdGraph then begin
        if liMaxBottom<26 then liMaxBottom:=26;
        lBand.spHeight:=liMaxBottom{5};
        if (lBand is TppTitleBand) {or (lBand is TppHeaderBand)} then begin
          lBand.spHeight:=Round(lBand.spHeight/26+0.5)*26;
          {liMaxBottom:=lBand.spHeight;}
        end;
        if (lBand is TppHeaderBand) then TppHeaderBand(lBand).PrintPosition:=0.9;

(*
        if ((FPrintLink.TextLInk.SkipTextLines and
        (lBand is TppHeaderBand))){ or (lBand is TppTitleBand))}
        and (lBand.spHeight mod 26>0) then lBand.spHeight:=(lBand.spHeight div 26)*26;
*)
        if (lBand is TppDetailBand) and (lBand.spHeight mod 26>0) then
          lBand.spHeight:=(lBand.spHeight div 26)*26;
        if {not FPrintLink.TextLink.SkipTextLines}True and not(lBand is TppDetailBand)
        and not(lBand is TppHeaderBand) and (lBand.spHeight mod 26>0) then
          lBand.spHeight:=lBand.spHeight-(lBand.spHeight mod 26)+26;
      end else begin
        if lBand is TppTitleBand then lBand.spHeight:=liMaxBottom+2
        else lBand.spHeight:=liMaxBottom;
      end;
{Lev}
    end else lBand.spHeight:=0;
    if lBandLayout.LineType=llFrameComponents then FrameComponents(lBand);
    if (lBand=FColumnHeaderBand) then liMinTop:=FColumnHeaderTopOffset;
    liWidth:=lBand.spWidth-liMinLeft-5;
    {create formatting}
    case lBandLayout.LineType of
      llRail:
        begin
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsSingle;
          lLine.spWidth:=liWidth;
          lLine.spTop:=liMinTop;
          lLine.spLeft:=liMinLeft;
          lLine.Band:=lBand;
          lLine.SendToBack;
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsSingle;
          lLine.spWidth:=liWidth;
          lLine.spTop:=liMaxBottom;
          lLine.spLeft:=liMinLeft;
          lLine.Band:=lBand;
          lLine.SendToBack;
        end;
      llDoubleRail:
        begin
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsDouble;
          lLine.spWidth:=liWidth;
          lLine.spTop:=liMinTop;
          lLine.spLeft:=liMinLeft;
          lLine.Band:=lBand;
          lLine.SendToBack;
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsDouble;
          lLine.spWidth:=liWidth;
          lLine.spTop:=liMaxBottom;
          lLine.spLeft:=liMinLeft;
          lLine.Band:=lBand;
          lLine.SendToBack;
        end;
      llTop:
        begin
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsSingle;
          lLine.spWidth:=liWidth+2;{+2}
          lLine.spTop:=liMinTop-2;{-2}
          lLine.spLeft:=liMinLeft-2;{-2}
          lLine.Band:=lBand;
          lLine.SendToBack;
        end;
      llBottom:
        begin
          lLine:=TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style:=lsSingle;
          lLine.spWidth:=liWidth+2;{+2}
{         lLine.spTop := liMaxBottom+2;{+2}
          lLine.spLeft:=liMinLeft-2;{-2}
          lLine.Band:=lBand;
          lLine.ParentHeight:=True;
          lLine.ParentWidth:=True;
          lLine.Position:=lpBottom;
          lLine.SendToBack;
{         lLine := TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style := lsSingle;
          lLine.Band := lBand;
          lLine.ParentHeight:= True;
          lLine.ParentWidth:= True;
          lLine.Position:= lpLeft;
          lLine := TppLine(ppComponentCreate(aReport, TppLine));
          lLine.Style := lsSingle;
          lLine.Band := lBand;
          lLine.ParentHeight:= True;
          lLine.ParentWidth:= True;
          lLine.Position:= lpRight;
}       end;
      llFrame:
        begin
          lShape:=TppShape(ppComponentCreate(aReport, TppShape));
          lShape.spWidth:=liWidth+2;{+2}
          lShape.spTop:=liMinTop-2;{-2}
          lShape.spLeft:=liMinLeft-2;{-2}
          lShape.spHeight:=liMaxBottom-liMinTop+4;{+4}
          lShape.Band:=lBand;
          lShape.SendToBack;
        end;
      end; {case, LineType}
    end; {for, each band}
end;

Procedure TXReportLayout.ApplyStyle(aReport: TXDBReport);
var liBands: Integer;
    liBand: Integer;
    lBand: TppBand;
    lStyle: TXBandStyle;
    liComponent: Integer;
    liComponents: Integer;
    lComponent: TppComponent;
    lShape: TppShape;
begin
  liBands:=aReport.BandCount;
  for liBand:=0 to liBands-1 do begin
    lBand:=aReport.Bands[liBand];
    lStyle:=StyleForBand(lBand);
    liComponents:=lBand.ObjectCount;
    for liComponent:=0 to liComponents-1 do begin
      lComponent:=lBand.Objects[liComponent];
      if lComponent.HasFont and not(lComponent is TppLabel) then
        lComponent.Font:=lStyle.Font;
      if (lComponent is TppLine) then begin
        TppLine(lComponent).Pen.Color:=lStyle.LinePenColor;
        TppLine(lComponent).Pen.Width:=lStyle.LinePenWidth;
        { Боковые бордюрчики потолще }
        if (lBand is TppDetailBand) and (Pos('Border',lComponent.Name)>0) then
          TppLine(lComponent).Pen.Width:=2;
      end;
      if (lStyle.Color <> clWhite) then begin
        if (lComponent is TppCustomText) then TppCustomText(lComponent).Transparent := True
        else if (lComponent is TppCustomMemo) then
          TppCustomMemo(lComponent).Transparent := True;
      end;
    end;
    if (lStyle.Color<>clWhite) then begin
      lShape:=TppShape.Create(aReport.Owner);
      lShape.Pen.Color:=lStyle.Color;
      lShape.Brush.Color:=lStyle.Color;
      lShape.spWidth:=lBand.spWidth;
      lShape.spHeight:=lBand.spHeight;
      lShape.Band:=lBand;
      lShape.SendToBack;
    end;
  end;
end;

end.
