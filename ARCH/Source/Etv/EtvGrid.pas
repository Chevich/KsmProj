unit EtvGrid;

interface

Uses Windows, Classes, Controls, Messages, Graphics, Grids, Menus,
     StdCtrls, DB, DBGrids, DBCtrls,
     EtvPopup,EtvLook,EtvList,EtvMem;

{$I Etv.Inc}

type
  TOnGetHeaderText = procedure(Sender: TObject; ACol: Integer; var Text: string) of object;
  TOnDrawTitleRect = procedure(Sender: TObject; ACol: Integer; Column: TColumn; ARect: TRect) of object;
  TOnGetHeaderRect = procedure(Sender: TObject; ACol: Integer; var IndexStart, Count: Integer) of object;

  TItemTotal=class
  public
    FieldName:string;
    Value:string;
    Constructor Create(AField,AValue:string);
  end;
  TListTotal=class(TListObj)
    procedure SetItemValue(AField,AValue:string);
    function GetItemValue(AField:string):string;
  end;

  TSetColorEvent = procedure (Sender: TObject; Field:TField;
    var aColor:TColor) of object;
  TSetLayoutEvent=procedure (Sender: TObject; Field:TField) of object;
  TUpdateLookupComboEvent=procedure(Sender: TColumn; Field:TField) of object;
  TIsEtvField=(efLookup,efList,efOther);

  TEtvGridDataLink = class(TGridDataLink)
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    {procedure EditingChanged; override;}
    procedure UpdateData; override;
    procedure HideEtvEditors;
  end;

  TEtvInplaceLookupCombo = class(TEtvCustomDBLookupCombo)
  protected
    FLookup: TWinControl;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    property Lookup:TWinControl read FLookup;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEtvDBInplaceCombo=class(TEtvCustomDBCombo) (* For EtvList*)
  private
    FLookup: TWinControl;
  protected
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
    property Lookup:TWinControl read FLookup;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TEtvLookupEditGrid = class(TEtvLookupEdit)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoExit; override;
  end;

  TEtvDbGrid=class(TDBGrid)
  protected
    FIntoField:boolean;
    FIsEtvField: TIsEtvField;
    FKeyCode: Word;
    FKeyCodeChar:boolean;
    FShiftState: TShiftState;
    FEditCode: TEtvLookupEditGrid;
    FLookupCombo: TEtvInplaceLookupCombo;
    FCombo: TEtvDBInplaceCombo;
    FOtherControl: TWinControl;
    fSetFont:TSetFontEvent;
    fSetColor:TSetColorEvent;
    fSetLayout:TSetLayoutEvent;
    fOldLeftCol:longint;
    fTotal:boolean;
    fTotalFont:TFont;
    fListTotal:TListTotal;
    fChangeTotal:smallint;
    fOnKeyDown:TKeyEvent;
    FOnUpdateLookupCombo: TUpdateLookupComboEvent;
    fEditFieldIndex:smallint;
    fEtvAutoHide:boolean;
    fTitleRows:smallint;
    fTitleRowCount:smallint;
    fTitleAlignment:TAlignment;
    FFixedCols: Integer; // Lev 21.05.2010 По материалам статьи "Необычный TDBGrid" http://www.delphikingdom.com/asp/viewitem.asp?catalogid=806#pic02
    FSubHeader: Boolean; // Lev 21.05.2010 подзаголовки (по материалам той же статьи)
    FOnGetHeaderText: TOnGetHeaderText;
    FOnDrawTitleRect: TOnDrawTitleRect;
    FOnGetHeaderRect: TOnGetHeaderRect;
    {protected}
    procedure SetEtvField;
    procedure DBGridDrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
      (* Val begin *)
    procedure ReadColumns(Reader: TReader);
    procedure WriteColumns(Writer: TWriter);
    procedure DefineProperties(Filer: TFiler);override;
      (* Val end *)
    procedure Paint; override;
    procedure PaintTotal; virtual;
    procedure SetTotal(ATotal:boolean);
    procedure SetTotalFont(Value:TFont);
    procedure SetTitleAlignment(ATitleAlignment:TAlignment);
    procedure SetTitleRows(ATitleRows:smallint);
    procedure TopLeftChanged; override;
    function GetClientRect: TRect; override;
    procedure Loaded; override;

    procedure VisibleChanging; override;
    function CreateInplaceLookupCombo:TEtvInplaceLookupCombo; virtual;
    function CreateEditor: TInplaceEdit; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure ColEnter; override;
    procedure SetColumnAttributes; override;
    procedure UpdateEditCode(c:char);
    procedure UpdateLookupCombo;
    procedure UpdateCombo;
    procedure UpdateExternalEditors(c:char);
    procedure DoEditData; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X,Y: Integer); override;

    procedure EtvOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    function NextSubStr(Str:string; AWidth:integer; var Pos:Integer):string;
       (* specially for Val *)
    function SetColumnTotal(NCol:longint; var Str:string):boolean; virtual;

    { Lev 21.05.10 Фиксированные колонки в начале Grid'а }
    function GetFixedCols:integer;
    procedure SetFixedCols(const Value: Integer);
    { Lev 21.05.10 Процедуры для обработки сложных заголовков }
    function GetHeaderText(ACol: Integer): string;
    function GetHeaderRect(ACol: Integer): TRect;
    procedure SetSubHeader(const Value: Boolean);
    procedure CalcTitleHeight; // Добавление в высоту заголока еще одной строки при сложных заголовках
    { Lev 21.05.10}
    property EtvAutoHide:boolean read fEtvAutoHide write fEtvAutoHide;
  public
    { Обработка для случая наличия события NewRecord и позиционирования в определенный столбец Lev 12.02.2010. Замена VK_TAB на VK_DOWN }
    GridAcceptKey: Boolean;
    function ListTotal:TListTotal;
    procedure BeginTotal;
    procedure SetItemTotal(AField,AValue:string);
    procedure EndTotal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Print;
    procedure PrintRec;
    procedure SetListFieldVisible;
    {procedure LayoutChanged; override; 24.05.10}
    property IsEtvField:TIsEtvField read fIsEtvField;
    property LookupCombo: TEtvInplaceLookupCombo read FLookupCombo;
    // Lev 21.05.10
    property FixedCols: Integer read GetFixedCols write SetFixedCols;
    property SubHeader: boolean read FSubHeader write SetSubHeader;
    property OnGetHeaderText: TOnGetHeaderText read FOnGetHeaderText write FOnGetHeaderText;
    property OnGetHeaderRect: TOnGetHeaderRect read FOnGetHeaderRect write FOnGetHeaderRect;
    property OnDrawTitleRect: TOnDrawTitleRect read FOnDrawTitleRect write FOnDrawTitleRect;
    // Lev 21.05.10
    // Lev 05.02.11
    property LeftCol; // The index of the left most displayed column (runtime only).
    property TopRow;  // The index of the top most row displayed (runtime only)
    // Lev 05.02.11
  published
    property OnKeyDown:TKeyEvent read fOnKeyDown write fOnKeyDown;
    property OnSetColor:TSetColorEvent read fSetColor Write fSetColor;
    property OnSetFont:TSetFontEvent read fSetFont Write fSetFont;
    property OnSetLayout:TSetLayoutEvent read fSetLayout Write fSetLayout;
    property OnUpdateLookupCombo: TUpdateLookupComboEvent read FOnUpdateLookupCombo write FOnUpdateLookupCombo;
    property Total:boolean read fTotal Write SetTotal;
    property TotalFont:TFont read fTotalFont Write SetTotalFont;
    property TitleAlignment:TAlignment read fTitleAlignment write SetTitleAlignment;
    property TitleRows:smallint read fTitleRows Write SetTitleRows;
  end;

type
TPopupMenuEtvDBGrid=class(TPopupMenuEtvDBControls)
protected
  fGridLineCount:smallint;
  function GetGrid:TDBGrid;
  procedure CheckScroll;
  procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
public
  procedure SetListFieldVisible(Sender: TObject);
  procedure Print(Sender: TObject);
  procedure PrintRec(Sender: TObject);
  procedure SetLengthFields(Sender: TObject);
  procedure ChangeControls(Sender: TObject);
  constructor Create(AOwner: TComponent); override;
end;
function PopupMenuEtvDBGrid:TPopupMenu;

(* Calc Length of Fields by scan all data on client*)
procedure SetLengthFieldsByDataScan(aDataSet:TComponent; aMaxRowScan:integer);

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer; const Text: string; Alignment: TAlignment
  {$IFDEF Delphi4}; ARightToLeft: Boolean {$ENDIF});

function RectHeight(R: TRect): Integer;
function RectWidth(R: TRect): Integer;
procedure Paint3dRect(DC: HDC; ARect: TRect); // Рамочка вокруг заданного прямоугольника
procedure DrawLine(aCanvas:TCanvas; aCurColor,aNeededColor: TColor; x1,y1,x2,y2:longint; aWidth:integer); // Процедура Igo, вынес из локальной для другого применения+пар-р Canvas Lev 25.05.10

IMPLEMENTATION

Uses TypInfo,SysUtils,Forms,
     EtvDBFun,EtvConst,EtvDB,EtvBor,EtvPrint,EtvPas,EtvContr,EtvOther,
     DiDual,DiPrint;

Type TWinControlSelf = class(TWinControl)
     end;

function RectHeight(R: TRect): Integer;
begin
  Result := R.Bottom - R.Top;
end;
//--------------------------------------------------------------------------------------------------

function RectWidth(R: TRect): Integer;
begin
  Result := R.Right - R.Left;
end;

//Рамочка вокруг заданного прямоугольника. Решение из интернета http://www.delphikingdom.com/asp/viewitem.asp?catalogid=806#pic02
procedure Paint3dRect(DC: HDC; ARect: TRect);
begin
  InflateRect(ARect, 1, 1);
  DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
  DrawEdge(DC, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
end;

procedure DrawLine(aCanvas:TCanvas; aCurColor,aNeededColor: TColor; x1,y1,x2,y2:longint; aWidth:integer);
var
  OldPen: TPen;
begin
  OldPen := TPen.Create;
  try
    with aCanvas do begin
      OldPen.Assign(Pen);
      Pen.Style := psSolid;
      Pen.Mode := pmCopy;
      Pen.Width := aWidth;
      if ColorToRGB(aCurColor) <> ColorToRGB(aNeededColor{clBtnFace}) then
        Pen.Color := aNeededColor{clBtnFace}
      else Pen.Color := clBtnShadow;
      try
        MoveTo(x1,y1);
        LineTo(x2,y2);
      finally
        Pen := OldPen;
      end;
    end;
  finally
    OldPen.Free;
  end;
end;

constructor TItemTotal.create(AField,AValue:string);
begin
  Inherited create;
  FieldName:=AField;
  Value:=AValue;
end;

procedure TListTotal.SetItemValue(AField,AValue:string);
var i:smallint;
begin
  for i:=0 to Count-1 do
    if TItemTotal(Items[i]).FieldName=AField then begin
      TItemTotal(Items[i]).Value:=AValue;
      Exit;
    end;
  Add(TItemTotal.Create(AField,AValue));
end;

function TListTotal.GetItemValue(AField:string):string;
var i:smallint;
begin
  Result:='';
  for i:=0 to Count-1 do
    if TItemTotal(Items[i]).FieldName=AField then begin
      Result:=TItemTotal(Items[i]).Value;
      Exit;
    end;
end;

{TEtvGridDataLink}
procedure TEtvGridDataLink.HideEtvEditors;
begin
  with TEtvDBGrid(TGridDataLinkBorland(Self).fGrid) do begin
    if not EtvAutoHide then Exit;
    if Assigned(FEditCode) and FEditCode.focused then begin
      FEditCode.Visible:=false;
      SetFocus;
    end;
    if Assigned(FLookupCombo) and FLookupCombo.focused then begin
      FLookupCombo.Visible:=false;
      SetFocus;
    end;
    if Assigned(FCombo) and FCombo.Visible and FCombo.focused then begin
      FCombo.Visible:=false;
      setFocus;
    end;
    if Assigned(FOtherControl) and
       FOtherControl.visible and FOtherControl.focused then begin
      FOtherControl.Visible:=false;
      SetFocus;
    end;
  end;
end;

procedure TEtvGridDataLink.ActiveChanged;
begin
  HideEtvEditors;
  inherited;
end;

procedure TEtvGridDataLink.DataSetChanged;
begin
  HideEtvEditors;
  inherited;
end;

procedure TEtvGridDataLink.DataSetScrolled(Distance: Integer);
begin
  HideEtvEditors;
  inherited;
end;

{TEtvInplaceLookupCombo}
constructor TEtvInplaceLookupCombo.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  TDBLookupControlBorland(Self).FDataLink.Free;
  TDBLookupControlBorland(Self).FDataLink:=TEtvCustomDataSourceLink.Create;
  TDataSourceLinkBorland(TDBLookupControlBorland(Self).FDataLink).FDBLookupControl := Self;
  Visible:=False;
  Ctl3d:=false;
end;

procedure TEtvInplaceLookupCombo.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do begin
    ExStyle := ExStyle and not WS_EX_OVERLAPPEDWINDOW;
    Style := Style and not WS_CAPTION;
  end;
end;

procedure TEtvInplaceLookupCombo.CNKeyDown(var Message: TWMKeyDown);
begin
 if Message.CharCode=VK_TAB then begin
    fLookup.Setfocus;
    Message.CharCode:=0;
    {PostMessage(fLookup.Handle,WM_KeyDown,VK_Tab,0);}
  end;
  inherited;
end;

procedure TEtvInplaceLookupCombo.DoExit;
begin
  Inherited;
  Visible:=False;
  if Assigned(TWinControlSelf(FLookup).OnExit) then
    TWinControlSelf(FLookup).OnExit(Self);
end;

procedure TEtvInplaceLookupCombo.KeyPress(var Key: Char);
var WKey: Word;
    OldListVisible:boolean;
begin
  WKey:=Integer(Key);
  OldListVisible:=ListVisible;
  Inherited;
  if ((WKey=vk_Escape) and
     ((Not OldListVisible) or
      (foEditOnEnter in GetOptions))) or
     ((WKey=vk_Return) and (Not ListVisible)) then begin
    Visible:=False;
    FLookup.SetFocus;
    if WKey=vk_Return then TWinControlSelf(FLookup).KeyDown(WKey,[]);
  end;
end;

{TEtvDBInplaceCombo}
constructor TEtvDBInplaceCombo.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Visible:=False;
  ParentCtl3D := False;
  Ctl3D:=false;
end;

procedure TEtvDBInplaceCombo.CNKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode=VK_TAB then begin
    fLookup.Setfocus;
    Message.CharCode:=0;
    PostMessage(fLookup.Handle,WM_KeyDown,VK_Tab,0);
  end;
  inherited;
end;

procedure TEtvDBInplaceCombo.DoExit;
begin
  Inherited;
  Visible:=False;
  if Assigned(TWinControlSelf(FLookup).OnExit) then TWinControlSelf(FLookup).OnExit(Self);
  if Assigned(TWinControlSelf(FLookup).OnClick) then TWinControlSelf(FLookup).OnClick(Self);
end;

procedure TEtvDBInplaceCombo.KeyPress(var Key: Char);
var WKey: Word;
begin
  WKey:=Integer(Key);
  Inherited;
  if WKey in [vk_Return, vk_Escape] then begin
    Visible:=False;
    FLookup.SetFocus;
    if WKey=vk_Return then begin
      TWinControlSelf(FLookup).KeyDown(WKey,[]);
      Key:=#0;
    end;
  end;
end;

{TEtvLookupEditGrid}
constructor TEtvLookupEditGrid.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  ParentCtl3D := False;
  Ctl3D := False;
  BorderStyle:=bsNone;
end;

procedure TEtvLookupEditGrid.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE;
end;

procedure TEtvLookupEditGrid.DoExit;
var EtvField:TEtvLookField;
begin
  Inherited;
  fExist:=false;
  if (Not ReadOnly) and fReturnData then begin
    with TEtvDBGrid(FLookup) do
      EtvField:=TEtvLookField(Columns[SelectedIndex].Field);
    with EtvField do begin
      if Assigned(EtvField.SetEditValue) then EtvField.SetEditValue(EtvField,Self.Text)
      else if Self.Text <>'' then begin
        if (foValueNotInLookup in EtvField.Options) and
           (LowerCase(LookupField[TEtvDBGrid(FLookup).fEditFieldIndex].FieldName)=
            LowerCase(EtvField.LookupKeyFields)) then begin
          if not (DataSet.State in [dsEdit,dsInsert]) then DataSet.Edit;
          DataSet.FieldByName(KeyFields).AsString:=Self.Text;
        end else
          if LookupDataSet.Locate(LookupField[TEtvDBGrid(FLookup).fEditFieldIndex].FieldName, Self.Text,
             [loCaseInsensitive,loPartialKey]) then begin
            if not (DataSet.State in [dsEdit,dsInsert]) then DataSet.Edit;
            DataSet.FieldByName(KeyFields).value:=LookupDataSet.FieldByName(LookupKeyFields).value;
          end else EtvApp.ShowMessage(SInvalidValue);
      end else begin
        if not (DataSet.State in [dsEdit,dsInsert]) then DataSet.Edit;
        DataSet.FieldByName(KeyFields).Clear;
      end;
    end;
  end;
  fReturnData:=true;
  Visible:=False;
  if Assigned(TWinControlSelf(FLookup).OnExit) then TWinControlSelf(FLookup).OnExit(Self);
  if Assigned(TWinControlSelf(FLookup).OnClick) then TWinControlSelf(FLookup).OnClick(Self);
end;

procedure TEtvGridDataLink.UpdateData;
begin
  with TEtvDBGrid(TGridDataLinkBorland(self).fgrid) do
    if assigned(fEditCode) and fEditCode.fExist then HideEtvEditors;
  inherited;
end;

 {Borland Begin}

type
  TEditStyle = (esSimple, esEllipsis, esPickList, esDataList);
  TPopupListbox = class;

  TDBGridInplaceEditBorland = class(TInplaceEdit)
  private
    FButtonWidth: Integer;
    FDataList: TDBLookupListBox;
    FPickList: TPopupListbox;
    FActiveList: TWinControl;
    FLookupSource: TDatasource;
    FEditStyle: TEditStyle;
    FListVisible: Boolean;
    FTracking: Boolean;
    FPressed: Boolean;
    procedure ListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetEditStyle(Value: TEditStyle);
    procedure StopTracking;
    procedure TrackButton(X,Y: Integer);
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CancelMode;
    procedure WMCancelMode(var Message: TMessage); message WM_CancelMode;
    procedure WMKillFocus(var Message: TMessage); message WM_KillFocus;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message wm_LButtonDblClk;
    procedure WMPaint(var Message: TWMPaint); message wm_Paint;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SetCursor;
    {$IFDEF Delphi4}
    function OverButton(const P: TPoint): Boolean;
    function ButtonRect: TRect;
    {$ENDIF}
  protected
    procedure BoundsChanged; override;
    procedure CloseUp(Accept: Boolean);
    procedure DoDropDownKeys(var Key: Word; Shift: TShiftState);
    procedure DropDown;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    procedure UpdateContents; override;
    procedure WndProc(var Message: TMessage); override;
    property  EditStyle: TEditStyle read FEditStyle write SetEditStyle;
    property  ActiveList: TWinControl read FActiveList write FActiveList;
    property  DataList: TDBLookupListBox read FDataList;
    property  PickList: TPopupListbox read FPickList;
  public
    constructor Create(Owner: TComponent); override;
  end;

{ TPopupListbox }

  TPopupListbox = class(TCustomListbox)
  private
    FSearchText: String;
    FSearchTickCount: Longint;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

procedure KillMessage(Wnd: HWnd; Msg: Integer);
// Delete the requested message from the queue, but throw back
// any WM_QUIT msgs that PeekMessage may also return
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, pm_Remove) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.wparam);
end;

procedure TPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_BORDER;
    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    {$IFDEF Delphi4}
    AddBiDiModeExStyle(ExStyle);
    {$ENDIF}
    WindowClass.Style := CS_SAVEBITS;
  end;
end;

procedure TPopupListbox.CreateWnd;
begin
  inherited CreateWnd;
  Windows.SetParent(Handle, 0);
  CallWindowProc(DefWndProc, Handle, wm_SetFocus, 0, 0);
end;

procedure TPopupListbox.Keypress(var Key: Char);
var
  TickCount: Integer;
begin
  case Key of
    #8, #27: FSearchText := '';
    #32..#255:
      begin
        TickCount := GetTickCount;
        if TickCount - FSearchTickCount > 2000 then FSearchText := '';
        FSearchTickCount := TickCount;
        if Length(FSearchText) < 32 then FSearchText := FSearchText + Key;
        SendMessage(Handle, LB_SelectString, WORD(-1), Longint(PChar(FSearchText)));
        Key := #0;
      end;
  end;
  inherited Keypress(Key);
end;

procedure TPopupListbox.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  TDBGridInplaceEditBorland(Owner).CloseUp((X >= 0) and (Y >= 0) and
      (X < Width) and (Y < Height));
end;

{$IFDEF Delphi4}
constructor TDBGridInplaceEditBorland.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TDBGridInplaceEditBorland.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 2, Width - 2, Height);
  if FEditStyle <> esSimple then
    if not TCustomDBGrid(Owner).UseRightToLeftAlignment then
      Dec(R.Right, FButtonWidth)
    else
      Inc(R.Left, FButtonWidth - 2);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

procedure TDBGridInplaceEditBorland.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ItemIndex <> -1 then
        ListValue := FPickList.Items[FPicklist.ItemIndex];
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TEtvDBGrid(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify then
          begin
            DataSet.Edit;
            MasterField.Value := ListValue;
          end;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TEtvDBGrid(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TDBGridInplaceEditBorland.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEditBorland.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
  Column: TColumn;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with TEtvDBGrid(Grid) do
      Column := Columns[SelectedIndex];
    if FActiveList = FDataList then
    with Column.Field do
    begin
      FDataList.Color := Color;
      FDataList.Font := Font;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
{      J := Column.DefaultWidth;
      if J > FDataList.ClientWidth then
        FDataList.ClientWidth := J;
}    end
    else
    begin
      FPickList.Color := Color;
      FPickList.Font := Font;
      FPickList.Items := Column.Picklist;
      if FPickList.Items.Count >= Integer(Column.DropDownRows) then
        FPickList.Height := Integer(Column.DropDownRows) * FPickList.ItemHeight + 4
      else
        FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + 4;
      if Column.Field.IsNull then
        FPickList.ItemIndex := -1
      else
        FPickList.ItemIndex := FPickList.Items.IndexOf(Column.Field.Text);
      J := FPickList.ClientWidth;
      for I := 0 to FPickList.Items.Count - 1 do
      begin
        Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
        if Y > J then J := Y;
      end;
      FPickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
    SetWindowPos(FActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

procedure TDBGridInplaceEditBorland.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    TEtvDBGrid(Grid).EditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TDBGridInplaceEditBorland.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEditBorland.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) and
    OverButton(Point(X,Y)) then
  begin
    if FListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(FActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TEtvDBGrid(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W, X, Y: Integer;
begin
  if FEditStyle <> esSimple then
  begin
    R := ButtonRect;
    Flags := 0;
    if FEditStyle in [esDataList, esPickList] then
    begin
      if FActiveList = nil then
        Flags := DFCS_INACTIVE
      else if FPressed then
        Flags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
    end
    else   { esEllipsis }
    begin
      if FPressed then Flags := BF_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      X := R.Left + ((R.Right - R.Left) shr 1) - 1 + Ord(FPressed);
      Y := R.Top + ((R.Bottom - R.Top) shr 1) - 1 + Ord(FPressed);
      W := FButtonWidth shr 3;
      if W = 0 then W := 1;
      PatBlt(DC, X, Y, W, W, BLACKNESS);
      PatBlt(DC, X - (W * 2), Y, W, W, BLACKNESS);
      PatBlt(DC, X + (W * 2), Y, W, W, BLACKNESS);
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TDBGridInplaceEditBorland.SetEditStyle(Value: TEditStyle);
begin
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListbox.Create(Self);
          FPickList.Visible := False;
          FPickList.Parent := Self;
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.IntegralHeight := True;
          FPickList.ItemHeight := 11;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TPopupDataList.Create(Self);
          FDataList.Visible := False;
          FDataList.Parent := Self;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  with TEtvDBGrid(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  Repaint;
end;

procedure TDBGridInplaceEditBorland.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TDBGridInplaceEditBorland.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  R := ButtonRect;
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TDBGridInplaceEditBorland.UpdateContents;
var
  Column: TColumn;
  NewStyle: TEditStyle;
  MasterField: TField;
begin
  with TEtvDBGrid(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         MasterField := Dataset.FieldByName(KeyFields);
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if Assigned(MasterField) and MasterField.CanModify and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TEtvDBGrid(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
{Etv Val Begin Change of style for not create LookupCombo}
                if Column.Field is TEtvLookField then
                   NewStyle:=esSimple
                else
{Etv Val End}
                   NewStyle := esDataList
       end
       else
       if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
         not Column.Readonly then
         NewStyle := esPickList
       else if DataType in [ftDataset, ftReference] then
         NewStyle := esEllipsis;
     end;
  end;
  EditStyle := NewStyle;
  inherited UpdateContents;
  Font.Assign(Column.Font);
end;

procedure TDBGridInplaceEditBorland.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then
    CloseUp(False);
end;

procedure TDBGridInplaceEditBorland.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TDBGridInplaceEditBorland.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if HWND(Message.WParam) <> TCustomDBGrid(Grid).Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
end;

function TDBGridInplaceEditBorland.ButtonRect: TRect;
begin
  if not TCustomDBGrid(Owner).UseRightToLeftAlignment then
    Result := Rect(Width - FButtonWidth, 0, Width, Height)
  else
    Result := Rect(0, 0, FButtonWidth, Height);
end;

function TDBGridInplaceEditBorland.OverButton(const P: TPoint): Boolean;
begin
  Result := PtInRect(ButtonRect, P);
end;

procedure TDBGridInplaceEditBorland.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (FEditStyle <> esSimple) and OverButton(Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TDBGridInplaceEditBorland.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TDBGridInplaceEditBorland.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (FEditStyle <> esSimple) and OverButton(P) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TDBGridInplaceEditBorland.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle in [esPickList, esDataList] then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if (CharCode <> 0) and FListVisible then
        begin
          with TMessage(Message) do
            SendMessage(FActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;

{$ELSE}

constructor TDBGridInplaceEditBorland.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FLookupSource := TDataSource.Create(Self);
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FEditStyle := esSimple;
end;

procedure TDBGridInplaceEditBorland.BoundsChanged;
var
  R: TRect;
begin
  SetRect(R, 2, 2, Width - 2, Height);
  if FEditStyle <> esSimple then Dec(R.Right, FButtonWidth);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
  if SysLocale.FarEast then
    SetImeCompositionWindow(Font, R.Left, R.Top);
end;

procedure TDBGridInplaceEditBorland.CloseUp(Accept: Boolean);
var
  MasterField: TField;
  ListValue: Variant;
begin
  if FListVisible then
  begin
    if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
    if FActiveList = FDataList then
      ListValue := FDataList.KeyValue
    else
      if FPickList.ItemIndex <> -1 then
        ListValue := FPickList.Items[FPicklist.ItemIndex];
    SetWindowPos(FActiveList.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    FListVisible := False;
    if Assigned(FDataList) then
      FDataList.ListSource := nil;
    FLookupSource.Dataset := nil;
    Invalidate;
    if Accept then
      if FActiveList = FDataList then
        with TEtvDBGrid(Grid), Columns[SelectedIndex].Field do
        begin
          MasterField := DataSet.FieldByName(KeyFields);
          if MasterField.CanModify then
          begin
            DataSet.Edit;
            MasterField.Value := ListValue;
          end;
        end
      else
        if (not VarIsNull(ListValue)) and EditCanModify then
          with TEtvDBGrid(Grid), Columns[SelectedIndex].Field do
            Text := ListValue;
  end;
end;

procedure TDBGridInplaceEditBorland.DoDropDownKeys(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        if FListVisible then CloseUp(True) else DropDown;
        Key := 0;
      end;
    VK_RETURN, VK_ESCAPE:
      if FListVisible and not (ssAlt in Shift) then
      begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
      end;
  end;
end;

procedure TDBGridInplaceEditBorland.DropDown;
var
  P: TPoint;
  I,J,Y: Integer;
  Column: TColumn;
begin
  if not FListVisible and Assigned(FActiveList) then
  begin
    FActiveList.Width := Width;
    with TEtvDBGrid(Grid) do
      Column := Columns[SelectedIndex];
    if FActiveList = FDataList then
    with Column.Field do
    begin
      FDataList.Color := Color;
      FDataList.Font := Font;
      FDataList.RowCount := Column.DropDownRows;
      FLookupSource.DataSet := LookupDataSet;
      FDataList.KeyField := LookupKeyFields;
      FDataList.ListField := LookupResultField;
      FDataList.ListSource := FLookupSource;
      FDataList.KeyValue := DataSet.FieldByName(KeyFields).Value;
    end
    else
    begin
      FPickList.Color := Color;
      FPickList.Font := Font;
      FPickList.Items := Column.Picklist;
      if FPickList.Items.Count >= Column.DropDownRows then
        FPickList.Height := Column.DropDownRows * FPickList.ItemHeight + 4
      else
        FPickList.Height := FPickList.Items.Count * FPickList.ItemHeight + 4;
      if Column.Field.IsNull then
        FPickList.ItemIndex := -1
      else
        FPickList.ItemIndex := FPickList.Items.IndexOf(Column.Field.Value);
      J := FPickList.ClientWidth;
      for I := 0 to FPickList.Items.Count - 1 do
      begin
        Y := FPickList.Canvas.TextWidth(FPickList.Items[I]);
        if Y > J then J := Y;
      end;
      FPickList.ClientWidth := J;
    end;
    P := Parent.ClientToScreen(Point(Left, Top));
    Y := P.Y + Height;
    if Y + FActiveList.Height > Screen.Height then Y := P.Y - FActiveList.Height;
    SetWindowPos(FActiveList.Handle, HWND_TOP, P.X, Y, 0, 0,
      SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
    FListVisible := True;
    Invalidate;
    Windows.SetFocus(Handle);
  end;
end;

procedure TDBGridInplaceEditBorland.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (EditStyle = esEllipsis) and (Key = VK_RETURN) and (Shift = [ssCtrl]) then
  begin
    TEtvDBGrid(Grid).EditButtonClick;
    KillMessage(Handle, WM_CHAR);
  end
  else
    inherited KeyDown(Key, Shift);
end;

procedure TDBGridInplaceEditBorland.ListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    CloseUp(PtInRect(FActiveList.ClientRect, Point(X, Y)));
end;

procedure TDBGridInplaceEditBorland.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (Button = mbLeft) and (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), Point(X,Y)) then
  begin
    if FListVisible then
      CloseUp(False)
    else
    begin
      MouseCapture := True;
      FTracking := True;
      TrackButton(X, Y);
      if Assigned(FActiveList) then
        DropDown;
    end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  ListPos: TPoint;
  MousePos: TSmallPoint;
begin
  if FTracking then
  begin
    TrackButton(X, Y);
    if FListVisible then
    begin
      ListPos := FActiveList.ScreenToClient(ClientToScreen(Point(X, Y)));
      if PtInRect(FActiveList.ClientRect, ListPos) then
      begin
        StopTracking;
        MousePos := PointToSmallPoint(ListPos);
        SendMessage(FActiveList.Handle, WM_LBUTTONDOWN, 0, Integer(MousePos));
        Exit;
      end;
    end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  WasPressed: Boolean;
begin
  WasPressed := FPressed;
  StopTracking;
  if (Button = mbLeft) and (FEditStyle = esEllipsis) and WasPressed then
    TEtvDBGrid(Grid).EditButtonClick;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TDBGridInplaceEditBorland.PaintWindow(DC: HDC);
var
  R: TRect;
  Flags: Integer;
  W: Integer;
begin
  if FEditStyle <> esSimple then
  begin
    SetRect(R, Width - FButtonWidth, 0, Width, Height);
    Flags := 0;
    if FEditStyle in [esDataList, esPickList] then
    begin
      if FActiveList = nil then
        Flags := DFCS_INACTIVE
      else if FPressed then
        Flags := DFCS_FLAT or DFCS_PUSHED;
      DrawFrameControl(DC, R, DFC_SCROLL, Flags or DFCS_SCROLLCOMBOBOX);
    end
    else   { esEllipsis }
    begin
      if FPressed then
        Flags := BF_FLAT;
      DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
      Flags := ((R.Right - R.Left) shr 1) - 1 + Ord(FPressed);
      W := Height shr 3;
      if W = 0 then W := 1;
      PatBlt(DC, R.Left + Flags, R.Top + Flags, W, W, BLACKNESS);
      PatBlt(DC, R.Left + Flags - (W * 2), R.Top + Flags, W, W, BLACKNESS);
      PatBlt(DC, R.Left + Flags + (W * 2), R.Top + Flags, W, W, BLACKNESS);
    end;
    ExcludeClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  end;
  inherited PaintWindow(DC);
end;

procedure TDBGridInplaceEditBorland.SetEditStyle(Value: TEditStyle);
begin
  if Value = FEditStyle then Exit;
  FEditStyle := Value;
  case Value of
    esPickList:
      begin
        if FPickList = nil then
        begin
          FPickList := TPopupListbox.Create(Self);
          FPickList.Visible := False;
          FPickList.Parent := Self;
          FPickList.OnMouseUp := ListMouseUp;
          FPickList.IntegralHeight := True;
          FPickList.ItemHeight := 11;
        end;
        FActiveList := FPickList;
      end;
    esDataList:
      begin
        if FDataList = nil then
        begin
          FDataList := TPopupDataList.Create(Self);
          FDataList.Visible := False;
          FDataList.Parent := Self;
          FDataList.OnMouseUp := ListMouseUp;
        end;
        FActiveList := FDataList;
      end;
  else  { cbsNone, cbsEllipsis, or read only field }
    FActiveList := nil;
  end;
  with TEtvDBGrid(Grid) do
    Self.ReadOnly := Columns[SelectedIndex].ReadOnly;
  Repaint;
end;

procedure TDBGridInplaceEditBorland.StopTracking;
begin
  if FTracking then
  begin
    TrackButton(-1, -1);
    FTracking := False;
    MouseCapture := False;
  end;
end;

procedure TDBGridInplaceEditBorland.TrackButton(X,Y: Integer);
var
  NewState: Boolean;
  R: TRect;
begin
  SetRect(R, ClientWidth - FButtonWidth, 0, ClientWidth, ClientHeight);
  NewState := PtInRect(R, Point(X, Y));
  if FPressed <> NewState then
  begin
    FPressed := NewState;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TDBGridInplaceEditBorland.UpdateContents;
var
  Column: TColumn;
  NewStyle: TEditStyle;
  MasterField: TField;
begin
  with TEtvDBGrid(Grid) do
    Column := Columns[SelectedIndex];
  NewStyle := esSimple;
  case Column.ButtonStyle of
   cbsEllipsis: NewStyle := esEllipsis;
   cbsAuto:
     if Assigned(Column.Field) then
     with Column.Field do
     begin
       { Show the dropdown button only if the field is editable }
       if FieldKind = fkLookup then
       begin
         MasterField := Dataset.FieldByName(KeyFields);
         { Column.DefaultReadonly will always be True for a lookup field.
           Test if Column.ReadOnly has been assigned a value of True }
         if Assigned(MasterField) and MasterField.CanModify and
           not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly) then
           with TEtvDBGrid(Grid) do
             if not ReadOnly and DataLink.Active and not Datalink.ReadOnly then
{Etv Val Begin Change of style for not create LookupCombo}
                if Column.Field is TEtvLookField then
                   NewStyle:=esSimple
                else
{Etv Val End}
                   NewStyle := esDataList
       end
       else
       if Assigned(Column.Picklist) and (Column.PickList.Count > 0) and
         not Column.Readonly then
         NewStyle := esPickList;
     end;
  end;
  EditStyle := NewStyle;
  inherited UpdateContents;
end;

procedure TDBGridInplaceEditBorland.CMCancelMode(var Message: TCMCancelMode);
begin
  if (Message.Sender <> Self) and (Message.Sender <> FActiveList) then
    CloseUp(False);
end;

procedure TDBGridInplaceEditBorland.WMCancelMode(var Message: TMessage);
begin
  StopTracking;
  inherited;
end;

procedure TDBGridInplaceEditBorland.WMKillFocus(var Message: TMessage);
begin
  if not SysLocale.FarEast then inherited
  else
  begin
    ImeName := Screen.DefaultIme;
    ImeMode := imDontCare;
    inherited;
    if Message.WParam <> TCustomDBGrid(Grid).Handle then
      ActivateKeyboardLayout(Screen.DefaultKbLayout, KLF_ACTIVATE);
  end;
  CloseUp(False);
end;

procedure TDBGridInplaceEditBorland.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  with Message do
  if (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), Point(XPos, YPos)) then
    Exit;
  inherited;
end;

procedure TDBGridInplaceEditBorland.WMPaint(var Message: TWMPaint);
begin
  PaintHandler(Message);
end;

procedure TDBGridInplaceEditBorland.WMSetCursor(var Message: TWMSetCursor);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if (FEditStyle <> esSimple) and
    PtInRect(Rect(Width - FButtonWidth, 0, Width, Height), ScreenToClient(P)) then
    Windows.SetCursor(LoadCursor(0, idc_Arrow))
  else
    inherited;
end;

procedure TDBGridInplaceEditBorland.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    wm_KeyDown, wm_SysKeyDown, wm_Char:
      if EditStyle in [esPickList, esDataList] then
      with TWMKey(Message) do
      begin
        DoDropDownKeys(CharCode, KeyDataToShiftState(KeyData));
        if (CharCode <> 0) and FListVisible then
        begin
          with TMessage(Message) do
            SendMessage(FActiveList.Handle, Msg, WParam, LParam);
          Exit;
        end;
      end
  end;
  inherited;
end;
{$ENDIF}

var
  DrawBitmap: TBitmap;
  UserCount: Integer;

procedure UsesBitmap;
begin
  if UserCount = 0 then
    DrawBitmap := TBitmap.Create;
  Inc(UserCount);
end;

procedure ReleaseBitmap;
begin
  Dec(UserCount);
  if UserCount = 0 then DrawBitmap.Free;
end;

function Max(X, Y: Integer): Integer;
begin
  Result := Y;
  if X > Y then Result := X;
end;

{$IFDEF Delphi4}
procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment; ARightToLeft: Boolean);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT or {DT_WORDBREAK or} DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT or {DT_WORDBREAK or} DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER or {DT_WORDBREAK or} DT_EXPANDTABS or DT_NOPREFIX );
  RTL: array [Boolean] of Integer = (0, DT_RTLREADING);
var
  B, R: TRect;
  Hold, Left: Integer;
  I: TColorRef;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    { In BiDi, because we changed the window origin, the text that does not
      change alignment, actually gets its alignment changed. }
    if (ACanvas.CanvasOrientation = coRightToLeft) and (not ARightToLeft) then
      ChangeBiDiModeAlignment(Alignment);
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ACanvas.TextRect(ARect, Left, ARect.Top + DY, Text);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        if (ACanvas.CanvasOrientation = coRightToLeft) then
          ChangeBiDiModeAlignment(Alignment);
        DrawText(Handle, PChar(Text), Length(Text), R,
          AlignFlags[Alignment] or RTL[ARightToLeft]);
      end;
      if (ACanvas.CanvasOrientation = coRightToLeft) then  
      begin
        Hold := ARect.Left;
        ARect.Left := ARect.Right;
        ARect.Right := Hold;
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;

{$ELSE}

procedure WriteText(ACanvas: TCanvas; ARect: TRect; DX, DY: Integer;
  const Text: string; Alignment: TAlignment);
const
  AlignFlags : array [TAlignment] of Integer =
    ( DT_LEFT {or DT_WORDBREAK }or DT_EXPANDTABS or DT_NOPREFIX,
      DT_RIGHT {or DT_WORDBREAK }or DT_EXPANDTABS or DT_NOPREFIX,
      DT_CENTER {or DT_WORDBREAK }or DT_EXPANDTABS or DT_NOPREFIX );
var
  B, R: TRect;
  I, Left: Integer;
begin
  I := ColorToRGB(ACanvas.Brush.Color);
  if GetNearestColor(ACanvas.Handle, I) = I then
  begin                       { Use ExtTextOut for solid colors }
    case Alignment of
      taLeftJustify:
        Left := ARect.Left + DX;
      taRightJustify:
        Left := ARect.Right - ACanvas.TextWidth(Text) - 3;
    else { taCenter }
      Left := ARect.Left + (ARect.Right - ARect.Left) shr 1
        - (ACanvas.TextWidth(Text) shr 1);
    end;
    ExtTextOut(ACanvas.Handle, Left, ARect.Top + DY, ETO_OPAQUE or
      ETO_CLIPPED, @ARect, PChar(Text), Length(Text), nil);
  end
  else begin                  { Use FillRect and Drawtext for dithered colors }
    DrawBitmap.Canvas.Lock;
    try
      with DrawBitmap, ARect do { Use offscreen bitmap to eliminate flicker and }
      begin                     { brush origin tics in painting / scrolling.    }
        Width := Max(Width, Right - Left);
        Height := Max(Height, Bottom - Top);
        R := Rect(DX, DY, Right - Left - 1, Bottom - Top - 1);
        B := Rect(0, 0, Right - Left, Bottom - Top);
      end;
      with DrawBitmap.Canvas do
      begin
        Font := ACanvas.Font;
        Font.Color := ACanvas.Font.Color;
        Brush := ACanvas.Brush;
        Brush.Style := bsSolid;
        FillRect(B);
        SetBkMode(Handle, TRANSPARENT);
        DrawText(Handle, PChar(Text), Length(Text), R, AlignFlags[Alignment]);
      end;
      ACanvas.CopyRect(ARect, DrawBitmap.Canvas, B);
    finally
      DrawBitmap.Canvas.Unlock;
    end;
  end;
end;
{$ENDIF}
{Borland}

{TEtvDBGridInplaceEdit}
type
  TEtvDBGridInplaceEdit = class(TDBGridInplaceEditBorland)
  protected
    procedure UpdateContents; override;
  end;

procedure TEtvDBGridInplaceEdit.UpdateContents;
begin
  With TEtvDBGrid(Grid) do begin
    inherited UpdateContents;
    if assigned(Columns[SelectedIndex].Field) then begin
      if assigned(OnSetFont) then begin
        {Self.Font := Columns[SelectedIndex].Font;}
        OnSetFont(Self,SelectedField,Self.Font);
      end;
      if assigned(OnSetLayout) then OnSetLayout(Self,SelectedField);
    end;
    if (EditStyle=esEllipsis) and (ssCtrl in FShiftState) and (FKeyCode=vk_Return)then begin
      FKeyCode:=0;
      EditButtonClick;
    end;
    if FIsEtvField<>efOther then begin
      HideEditor;
      if DataSource.State=dsInsert then DataLink.Modified;
    end;
    Case FIsEtvField of
      efLookup: begin
        {DataSource.Edit;}
        if (foEditWindow in TEtvLookField(SelectedField).Options) and
           (((FKeyCode=vk_F2) and (Not FKeyCodeChar)) or
            (FKeyCode=vk_Space) or
            ((FKeyCode=vk_Return) and (FShiftState=[]) and
             (foEditOnEnter in TEtvLookField(SelectedField).Options))) then
          UpdateEditCode(#0)
        else
          if (Char(Lo(FKeyCode)) in [#33..#255]) and FKeyCodeChar then begin
            if (foAutoDropDown in TEtvLookField(SelectedField).Options) or
               (not (foEditWindow in TEtvLookField(SelectedField).Options)) then begin
              if foAutoCodeName in TEtvLookField(SelectedField).Options then
                if Char(Lo(FKeyCode)) in ['0'..'9'] then TEtvLookField(SelectedField).ListFieldIndex:=0
                else if (Char(Lo(FKeyCode)) in Letters) then TEtvLookField(SelectedField).ListFieldIndex:=1;
              UpdateLookupCombo;
              FLookupCombo.DropDown;
              PostMessage(FLookupCombo.Handle, WM_CHAR, FKeyCode, 0);
            end else begin
              UpdateEditCode(Char(Lo(FKeyCode)));
              if not FEditCode.ReadOnly then
                FEditCode.Text:=Char(Lo(FKeyCode));
              FEditCode.SelStart:=1;
            end;
          end
          else UpdateLookupCombo;
      end;
      efList: UpdateCombo;
      efOther: begin
        (* attach external editors *)
        if (Char(Lo(FKeyCode)) in [#33..#255]) and FKeyCodeChar then
          UpdateExternalEditors(Char(Lo(FKeyCode)))
        else UpdateExternalEditors(#0);
      end;
    end;
    FKeyCode:=0;
  end;
end;

{TEtvDBGrid}

constructor TEtvDBGrid.Create(AOwner: TComponent);
begin
  if Inherited Create(AOwner)<>nil then begin
    DataLink.Free;
    TCustomDBGridBorland(Self).FDataLink:=
      TEtvGridDataLink.Create(Self);
    UsesBitmap;
    FShiftState:=[];
    FOldLeftCol:=0;
    FTotal:=false;
    fTotalFont:=TFont.Create;
    fTotalFont.Assign(Font);
    fListTotal:=nil;
    fChangeTotal:=0;
    fTitleAlignment:=taLeftJustify;
    fTitleRows:=0;
    fEtvAutoHide:=true;
    GridAcceptKey:=true;
    Inherited OnKeyDown:=EtvOnKeyDown;
  end;
end;

destructor TEtvDBGrid.Destroy;
begin
  if Assigned(fListTotal) then fListTotal.free;
  fTotalFont.Free;
  inherited Destroy;
  ReleaseBitmap;
end;

procedure TEtvDBGrid.SetFixedCols(const Value: Integer);
var FixedCount,i : Integer;
begin
  // Следует учесть индикатор грида
  if Value <= 0 then FixedCount:=IndicatorOffset
  else FixedCount := Value + IndicatorOffset;

  if DataLink.Active and not (csDesigning in ComponentState) and (ColCount > IndicatorOffset + 1) then begin
    if FixedCount >= ColCount then FixedCount:=ColCount - 1;
    Inherited FixedCols := FixedCount;
    // На фиксированных колонках нельзя останавливаться по табуляции
    for i := 1 to FixedCols do TabStops[I] := False;
  end;
  FFixedCols := FixedCount - IndicatorOffset;
end;
// Lev 21.05.10

function TEtvDBGrid.GetFixedCols: Integer;
begin
  if DataLink.Active then Result := Inherited FixedCols - IndicatorOffset else Result := FFixedCols;
end;
// Lev 21.05.10

function TEtvDBGrid.GetHeaderText(ACol: Integer): string;
begin
  Result := '';
  if Assigned(FOnGetHeaderText) then FOnGetHeaderText(Self,ACol, Result);
end;
// Lev 21.05.10

function TEtvDBGrid.GetHeaderRect(ACol: Integer): TRect;
var
  MasterCol: TColumn;
  Index, Shift, Count, i: Integer;

begin
  Result:=Rect(0,0,0,0);
  if [dgColLines]*Options=[dgColLines] then Shift:=1 else Shift:=0;

  Index := ACol;
  Count := 1;
  if Assigned(FOnGetHeaderRect) then FOnGetHeaderRect(Self, ACol, Index, Count);
  // Заголовка нету - выходим.
  if Count=1 then Exit;

  if Index + Count - 1 > Columns.Count - 1 then begin
    Index := ACol;
    Count := 1;
  end;

  Result := CalcTitleRect(Columns[Index], 0, MasterCol);

  for i := Index + 1 to Index + Count - 1 do
    Result.Right := Result.Right + RectWidth(CalcTitleRect(Columns[i], 0, MasterCol)) + Shift;

end;
// Lev 21.05.10

Procedure TEtvDBGrid.CalcTitleHeight;
begin
  RowHeights[0]:=RowHeights[0]+DefaultRowHeight+5;
end;

procedure TEtvDBGrid.SetSubHeader(const Value: Boolean);
begin
  FSubHeader := Value;
  if FSubHeader then
    fTitleRows := fTitleRows+1
  else
    fTitleRows := fTitleRows-1;
  if FSubHeader then CalcTitleHeight;
end;
// Lev 21.05.10

(* В статье была упомянута эта процедура, но пока закомментарил, потому как и без нее все работает.
procedure TEtvDBGrid.LayoutChanged;
begin
  inherited;
  CalcHeightTitle;
  SetFixedCols(FFixedCols);
end; // Lev 24.05.10
*)

procedure TEtvDBGrid.SetEtvField;
begin
  FIsEtvField:=efOther;
  if (dgEditing in Options) and Columns[SelectedIndex].Field.lookup and
     (Columns[SelectedIndex].Field is TEtvLookField) then
    FIsEtvField:=efLookup;
  if (dgEditing in Options) and (Columns[SelectedIndex].Field is TEtvListField) then
     FIsEtvField:=efList;
end;

procedure TEtvDBGrid.Print;
var bm:TBookMark;
    s,str:string;
    i:integer;
    PropInfo: PPropInfo;
    TWidth:integer;
    Cycle,EndCycle:integer;
begin
  if Assigned(DataSource) and (Assigned(DataSource.DataSet)) and
     DataSource.DataSet.Active and
     (not(DataSource.DataSet.BOF and DataSource.DataSet.EOF)) then begin
    if Assigned(CreateOtherDBGridPrint) then try
      CreateOtherDBGridPrint(Self);
    except
      EtvApp.ShowMessage(SGridPrintError);
    end
    else begin
      (* Header *)
      PropInfo := GetPropInfo(Self.DataSource.DataSet.ClassInfo, 'Caption');
      if PropInfo <> nil then
        EtvPrintSet.SetTitle(GetStrProp(Self.DataSource.DataSet,PropInfo),
                             DataSource.DataSet)
      else EtvPrintSet.SetTitle('',DataSource.DataSet);
      if DialPrint.Execute(EtvPrintSet) then with DataSource.DataSet do begin
        Canvas.Font:=Font;
        TWidth:=Canvas.TextWidth('0');
        if EtvPrintSet.Mode=pmText then EndCycle:=EtvPrintSet.Copies
        else EndCycle:=1;
        bm:=GetBookMark;
        DisableControls;
        try
          for Cycle:=1 to EndCycle do begin
            First;
            if EtvPrinter.BeginDoc(EtvPrintSet) then try
              s:='';
              for i:=0 to Columns.Count-1 do begin
                if i>0 then s:=s+'|';
                s:=s+sform(Columns[i].Title.caption,Columns[i].width div TWidth+1,taCenter);
              end;
              EtvPrinter.PrintStr(s);
              (* Delimiter *)
              EtvPrinter.PrintStr(PrintLine(Length(s)));
              (* Data *)
              While (Not EOF) and EtvPrinter.PrintStillNeed do begin
                s:='';
                for i:=0 to Columns.Count-1 do begin
                  if i>0 then s:=s+'|';
                  s:=s+sform(Columns[i].Field.DisplayText,Columns[i].width div TWidth+1,Columns[i].Alignment);
                end;
                EtvPrinter.PrintStr(s);
                Next;
              end;
              (* Totals *)
              if fTotal and EtvPrinter.PrintStillNeed then begin
                s:='';
                for i:=0 to Columns.Count-1 do begin
                  if i>0 then s:=s+' ';
                    if Assigned(fListTotal) then
                      str:=ListTotal.GetItemValue(Columns[i].FieldName)
                    else if not SetColumnTotal(i,Str) then Str:='';
                    s:=s+sform(str,Columns[i].width div TWidth+1,Columns[i].Alignment);
                end;
                EtvPrinter.PrintStr(s);
              end;
              EtvPrinter.EndDoc;
            except
              EtvPrinter.Abort;
              EtvApp.ShowMessage(SGridPrintError);
              Break;
            end;
          end;
        finally
          gotobookmark(bm);
          freebookmark(bm);
          EnableControls;
        end;
      end;
    end;
  end;
end;

procedure TEtvDBGrid.PrintRec;
var s:string;
    str:tStringList;
    PropInfo: PPropInfo;
begin
  if Assigned(DataSource) and (Assigned(DataSource.DataSet)) and
     DataSource.DataSet.Active and
     (not(DataSource.DataSet.BOF and DataSource.DataSet.EOF)) then begin
    if Assigned(CreateOtherDBGridPrintRecord) then try
      CreateOtherDBGridPrintRecord(Self);
    except
      EtvApp.ShowMessage(SGridPrintRecordError);
    end
    else with DataSource.DataSet do try
      {PrinterDoc.TypePrinter:=1;}
      EtvPrinter.BeginDoc(nil);
      (* Header *)
      s:='';
      PropInfo := GetPropInfo(Self.DataSource.DataSet.ClassInfo, 'Caption');
      if PropInfo <> nil then
        s:=GetStrProp(Self.DataSource.DataSet,PropInfo);
      if s<>'' then EtvPrinter.PrintStr('     '+s);
      Str:=TStringList.Create;
      DataSetPrintOneRecord(Self.DataSource.DataSet,VisibleFields,
        Str,0,'>');
      EtvPrinter.PrintStrings(str);
      Str.free;
      EtvPrinter.EndDoc;
    except
      EtvApp.ShowMessage(SGridPrintRecordError);
    end;
  end;
end;

procedure TEtvDBGrid.SetListFieldVisible;
var Dial:TEtvDualListDlg;
    i,j:integer;
begin
  if Assigned(DataSource) and Assigned (DataSource.DataSet) then begin
    Dial:=TEtvDualListDlg.Create(self);
    with Dial do try
      Caption:=SDialVisibleFields;
      SrcLabel.Caption:=SVisibleFields;
      DstLabel.Caption:=SInvisibleFields;
      SrcList.Items.Clear;
      DstList.Items.Clear;
      with DataSource.Dataset do begin
        for i:=0 to FieldCount-1 do
         if (Fields[i].tag mod 10<>8) and (Not(Fields[i] is TBlobField)) then
          if Fields[i].visible then
            SrcList.Items.add(Fields[i].DisplayLabel)
          else DstList.Items.add(Fields[i].DisplayLabel);
        if ShowModal=idOk then begin
          DisableControls;
          try
            for j:=0 to SrcList.Items.Count-1 do
              for i:=0 to Fieldcount-1 do
               if (Fields[i].Tag mod 10<>8) and (Not(Fields[i] is TBlobField)) then
                if Fields[i].DisplayLabel=SrcList.Items[j] then begin
                  Fields[i].Visible:=True;
                  Fields[i].index:=j;
                end;
            for j:=0 to DstList.Items.Count-1 do
              for i:=0 to Fieldcount-1 do
               if (Fields[i].Tag mod 10<>8) and (Not(Fields[i] is TBlobField)) then
                if Fields[i].DisplayLabel=DstList.Items[j] then begin
                  Fields[i].Visible:=False;
                  Fields[i].index:=j+SrcList.Items.Count-1;
                end;
          finally
            EnableControls;
          end;
        end;
      end;
    finally
      Dial.Free;
    end;
  end;
end;

(* Val begin more correct read of Columns by inheritance of form *)
procedure TEtvDBGrid.ReadColumns(Reader: TReader);
begin
  Columns.Clear;
  Reader.ReadValue;
  Reader.ReadCollection(Columns);
end;

procedure TEtvDBGrid.WriteColumns(Writer: TWriter);
begin
  Writer.WriteCollection(Columns);
end;

procedure TEtvDBGrid.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('Columns', ReadColumns, WriteColumns,
    ((Columns.State = csCustomized) and (Filer.Ancestor = nil)) or
    ((Filer.Ancestor <> nil) and (Columns.State = csCustomized) and
     ((Columns.State <> TEtvDBGrid(Filer.Ancestor).Columns.State) or
      (not CollectionsEqual(Columns, TEtvDBGrid(Filer.Ancestor).Columns)) )));
end;
(* Val end *)

procedure TEtvDBGrid.Paint;
begin
  inherited;
  PaintTotal;
end;

procedure TEtvDBGrid.CMFontChanged(var Message: TMessage);
begin
  SetTotalFont(Font);
  inherited;
end;

procedure TEtvDBGrid.PaintTotal;
var r:TRect;
    i,j:smallint;
    str:string;
  procedure writeOneTotal(NCol:smallint; Str:string);
  var r1:TRect;
  begin
    r1:=CellRect(NCol+IndicatorOffset,0);
    if r1.Bottom<>0 then begin
      r.Left:=r1.Left+2;
      r.Right:=r1.Right;
      WriteText(Canvas,R,0,2,Str,Columns[NCol].Alignment
        {$IFDEF Delphi4},false{$ENDIF});
    end;
  end;
begin
  if not fTotal then Exit;
  r:=inherited GetClientRect;
  r.Top:=r.Bottom-DefaultRowHeight-GridLineWidth;
  Canvas.Font:=fTotalFont;
  Canvas.Brush.Color:=Color;
  WriteText(Canvas, R, 0, 0,'', taCenter{$IFDEF Delphi4},false{$ENDIF});
  if Assigned(fListTotal) then begin
    for i:=0 to ListTotal.Count-1 do
      for j:=0 to Columns.count-1 do
        if AnsiUpperCase(Columns[j].FieldName)=AnsiUpperCase(TItemTotal(ListTotal.items[i]).FieldName) then begin
          WriteOneTotal(j,TItemTotal(ListTotal.items[i]).Value);
          Break;
        end;
  end else
    for i:=0 to Columns.count-1 do
      if SetColumnTotal(i,Str) then WriteOneTotal(i,Str);
end;

function TEtvDBGrid.SetColumnTotal(NCol:longint; var Str:string):boolean;
begin
  Result:=false;
end;

function TEtvDBGrid.ListTotal:TListTotal;
begin
  if Not Assigned(fListTotal) then fListTotal:=TListTotal.create;
  Result:=fListTotal;
end;

procedure TEtvDBGrid.BeginTotal;
begin
  inc(fChangeTotal);
end;

procedure TEtvDBGrid.SetItemTotal(AField,AValue:string);
begin
  ListTotal.SetItemValue(AField,AValue);
  if fChangeTotal=0 then PaintTotal;
end;

procedure TEtvDBGrid.EndTotal;
begin
  if fChangeTotal>0 then Dec(fChangeTotal);
  if fChangeTotal=0 then PaintTotal;
end;

procedure TEtvDBGrid.SetTotal(ATotal:boolean);
begin
  if fTotal<>ATotal then begin
    BeginLayout;
    fTotal:=ATotal;
    EndLayout;
  end;
end;

procedure TEtvDBGrid.SetTotalFont(Value: TFont);
begin
  fTotalFont.Assign(Value);
  if Total then PaintTotal;
end;

procedure TEtvDBGrid.SetTitleAlignment(ATitleAlignment:TAlignment);
begin
  if fTitleAlignment<>ATitleAlignment then begin
    BeginLayout;
    fTitleAlignment:=ATitleAlignment;
    EndLayout;
  end;
end;

procedure TEtvDBGrid.SetTitleRows(ATitleRows:smallint);
begin
  if fTitleRows<>ATitleRows then begin
    BeginLayout;
    fTitleRows:=ATitleRows;
    EndLayout;
  end;
end;

procedure TEtvDBGrid.TopLeftChanged;
begin
  inherited;
  if fOldLeftCol<>LeftCol then begin
    fOldLeftCol:=LeftCol;
    PaintTotal;
  end;
end;

function TEtvDBGrid.GetClientRect: TRect;
begin
  Result:= inherited GetClientRect;
  if fTotal then
    Result.bottom:=Result.bottom-DefaultRowHeight-GridLineWidth;
end;

procedure TEtvDBGrid.Loaded;
begin
  HandleNeeded;
  Inherited Loaded;
  if (not(csDesigning in ComponentState)) and (PopupMenu=nil) then PopupMenu:=PopupMenuEtvDBGrid;
end;

procedure TEtvDBGrid.ColEnter;
begin
  SetEtvField;
  Inherited
end;

function TEtvDBGrid.NextSubStr(Str:string; AWidth:integer; var Pos:Integer):string;
var i,l,SymbolWidth:integer;
begin
  SymbolWidth:=Canvas.TextWidth('0');
  if SymbolWidth>AWidth then begin
    Pos:=length(Str)+1;
    Result:='';
    Exit;
  end;
  Result:=Copy(Str,Pos,AWidth div SymbolWidth);
  L:=Length(Result);
  while (Pos+L-1<Length(Str)) and (Canvas.TextWidth(Result)<AWidth-SymbolWidth) do begin
    Inc(l);
    Result:=Copy(Str,Pos,L);
  end;
  while (L>1) and (Canvas.TextWidth(Result)>AWidth) do begin
    Dec(l);
    Result:=Copy(Result,1,L);
  end;
  if (Length(Str)>=Pos+L) and (Str[Pos+L]<>' ') and
     (Str[Pos+L-1]<>' ') and (System.Pos(' ',Result)>0) then begin
    for i:=length(Result) downto 1 do
      if Result[i]=' ' then begin
        Result:=Copy(Result,1,i);
        break;
      end;
  end;
  Pos:=Pos+length(Result);
  while(Pos<=Length(Str)) and (Str[Pos]=' ') do Inc(Pos);
  Result:=Trim(Result);
end;

function ReadOnlyField(Field: TField): Boolean;
var
  MasterField: TField;
begin
  Result := Field.ReadOnly;
  if not Result and (Field.FieldKind = fkLookup) then
  begin
    Result := True;
    if Field.DataSet = nil then Exit;
    MasterField := Field.Dataset.FindField(Field.KeyFields);
    if MasterField = nil then Exit;
    Result := MasterField.ReadOnly;
  end;
end;

procedure TEtvDBGrid.SetColumnAttributes;
var aWidth,i,Pos,n:integer;
    Exist:boolean;
begin
  SetFixedCols(FFixedCols);
  Exist:=(dgTitles in Options) and (fTitleRows>0);
  if Exist then begin
    Exclude(TCustomDBGridBorland(Self).fOptions,dgTitles);
    fTitleRowCount:=1;
    for i:=0 to Columns.Count-1 do with Columns[i] do
      if Assigned(Field) then begin
        pos:=1;
        n:=0;
        aWidth:=Width-4;
        {Canvas.Font:=Title.Font;}
        while (NextSubStr(Title.Caption,aWidth,Pos)<>'') and
              (n<fTitleRows) Do Inc(n);
        if n>fTitleRowCount then begin
          fTitleRowCount:=n;
          if fTitleRowCount=fTitleRows then break;
        end;
      end;
    if fTitleRowCount>1 then RowHeights[0]:=(RowHeights[0]-3)*fTitleRowCount+4;
    if FSubHeader then CalcTitleHeight;
  end;
  {Inherited;}
  // Change by Alex Kogan for TabStop in Calculated+cbsEllipsis
  {if Columns.Count>1 then}
    for I := Columns.Count-1 downto 0 do  with Columns[I] do begin
      TabStops[I + IndicatorOffset] := not ReadOnly and DataLink.Active and
        Assigned(Field) and not ReadOnlyField(Field) and
        (not (Field.FieldKind = fkCalculated) or (ButtonStyle = cbsEllipsis));
      (*
      if Assigned(Field) then
        aWidth:=Canvas.TextWidth('0')*(Field.DisplayWidth+1)
      else aWidth:=Width;
      *)
      ColWidths[I + IndicatorOffset] := {aWidth}Width;
    end;
  if (dgIndicator in Options) then ColWidths[0] := IndicatorWidth;
  // End Change

  if Exist then begin
    Include(TCustomDBGridBorland(Self).fOptions,dgTitles);
    PostMessage(Handle, WM_SIZE, 0, 0);
  end;
  if Columns.Count>0 then with Columns[0] do begin
    if DataLink.Active and Assigned(Field) then
      if (SelectedIndex>=0) and (FieldCount>SelectedIndex) then
      SetEtvField;
  end;
end;

procedure TEtvDBGrid.WMChar(var Message: TWMChar);
begin
  FKeyCode:=Message.CharCode;
  FKeyCodeChar:=true;
  if (FIsEtvField=efList) and (FKeyCode in [ord('0')..ord('9')]) and (FShiftState=[]) then begin
    if FKeyCode-ord('0')<=TEtvListField(SelectedField).MaxValue then begin
      DataSource.Edit;
      TEtvListField(SelectedField).AsInteger:=FKeyCode-ord('0');
    end else SysUtils.beep;
    Message.CharCode:=0;
    ShowEditor; // По требованию бухгалтера, чтобы был однообразный ввод значений и после ввода цифры было нажатие <Enter>
                // А без этого события приходится нажимать стрелку вправо, что сбивает с темпа работы. Lev 27.04.2010
  end
  else inherited;
end;

procedure TEtvDBGrid.WMKeyDown(var Message: TWMKeyDown);
begin
  FShiftState := KeyDataToShiftState(Message.KeyData);
  FKeyCode:=Message.CharCode;
  FKeyCodeChar:=false;
  case FKeyCode of
    VK_RETURN: begin
      if ssCtrl in FShiftState then ShowEditor;
      if Not (ssAlt in FShiftState) then Message.CharCode:=0;
    end;
  end;
  inherited;
end;

procedure TEtvDBGrid.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  if not (csDestroying in ComponentState) then
    TEtvGridDataLink(TCustomDBGridBorland(Self).FDataLink).HideEtvEditors;
  inherited;
end;

procedure TEtvDBGrid.UpdateEditCode(c:Char);
var  W, J, TextWidth: Integer;
  R: TRect;
  Field: TField;
  EtvField:TEtvLookField;
  KField:TField;
  BWidth:byte; (* width of border *)
  Exist:boolean;
begin
  if Not Assigned(FEditCode) then
    Try
      FEditCode:= TEtvLookupEditGrid.Create(Self);
      FEditCode.fLookup:=Self;
      FEditCode.Font.Assign(font);
      Parent.InsertControl(FEditCode);
      TWinControlSelf(FEditCode).SetZOrder(True);
    Except
      EtvApp.ShowMessage('Error create EditCode!');
  end;

  EtvField:=TEtvLookField(Columns[SelectedIndex].Field);
  FEditCode.ReadOnly:=
    (not EtvField.DataSet.FieldByName(EtvField.KeyFields).CanModify) or ReadOnly;
  if FEditCode.ReadOnly then c:=#0;
  FEditCode.Text:='';


  fEditFieldIndex:=-1;
  if Not (foKeyFieldEdit in EtvField.Options) then
    fEditFieldIndex:=EtvField.ListFieldIndex;
  if foAutoCodeName in EtvField.Options then
    if C in ['0'..'9'] then fEditFieldIndex:=0
    else if (C in Letters) and (EtvField.LookupResultCount>=2) then fEditFieldIndex:=1;

  Exist:=false;
  for J := 0 to EtvField.LookupResultCount - 1 do
    if (LowerCase(EtvField.LookupField[j].FieldName)=
        LowerCase(EtvField.LookupKeyFields)) then begin
      if fEditFieldIndex<0 then fEditFieldIndex:=j;
      if fEditFieldIndex=j then begin
        FEditCode.EditMask:=EtvField.LookupField[fEditFieldIndex].EditMask;
        if (c=#0) then FEditCode.Text:=EtvField.DataSet.FieldByName(EtvField.KeyFields).AsString;
        Exist:=true;
      end;
      Break;
    end;
  if Not Exist then begin
    if fEditFieldIndex<0 then fEditFieldIndex:=EtvField.ListFieldIndex;
    FEditCode.EditMask:=EtvField.LookupField[fEditFieldIndex].EditMask;
    if (C=#0) and EtvField.LookupDataSet.Locate(EtvField.LookupKeyFields,
       EtvField.DataSet.FieldByName(EtvField.KeyFields).value,[]) then begin
      KField:=EtvField.LookupField[fEditFieldIndex];
      if KField.Value<>null then FEditCode.text:=KField.AsString;
    end;
  end;

  with CellRect(Col,Row) do begin
    Canvas.Font.Assign(Font);
    TextWidth := Canvas.TextWidth('0');
    BWidth:=0;
    if BorderStyle=bsSingle then
      if Ctl3D then BWidth:=2 else BWidth:=1;
    R.Top := Self.Top+Top+BWidth;
    R.Bottom :=Self.Top+Bottom+BWidth;
    R.Left := Self.Left+Left+BWidth;

    for J := 0 to fEditFieldIndex-1 do begin
      Field := EtvField.LookupField[J];
      W := Field.DisplayWidth * TextWidth + 5;
      Inc(R.Left,W);
    end;
    Field := EtvField.LookupField[fEditFieldIndex];
    W := Field.DisplayWidth * TextWidth + 5;
    R.Right:=R.Left+W-1;
    if R.Right>Self.Left+Right+BWidth then begin (* dont place *)
      R.Left := Self.Left+Left+BWidth;
      R.Right:=Self.Left+Right+BWidth
    end;
    if fEditFieldIndex=EtvField.LookupResultCount-1 then
      R.Right:=Self.Left+Right+BWidth
  end;

  SetWindowPos(FEditCode.Handle, HWND_TOP, R.Left, R.Top, R.Right-R.Left, R.Bottom-R.Top,
    SWP_SHOWWINDOW or SWP_NOREDRAW);
  with FEditCode do begin
    UpdateShow;
    R := Rect(2, 2, Width - 2, Height);
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
    SendMessage(Handle, EM_SCROLLCARET, 0, 0);
    Invalidate;
    SelectAll;
  end;
end;

Function TEtvDBGrid.CreateInplaceLookupCombo:TEtvInplaceLookupCombo;
begin
  Result:=TEtvInplaceLookupCombo.Create(Self);
end;

procedure TEtvDBGrid.UpdateLookupCombo;
var BWidth:byte; (* width of border *)
begin
  if Not Assigned(FLookupCombo) then
    Try
    FLookupCombo:= CreateInplaceLookupCombo;
    FLookupCombo.fLookup:=Self;
    FLookupCombo.SetParent(parent);
    FLookupCombo.Font.Assign(font);
    FLookupCombo.DataSource:=DataSource;
    TWinControlSelf(FLookupCombo).SetZOrder(True);
    if Assigned(fSetFont) then
      FLookupCombo.OnSetFont:=fSetFont;
    Except
      EtvApp.ShowMessage('Error create LookupCombo!');
  end;
  FLookupCombo.DataField:='';

  TDBLookupComboBoxBorland(FLookupCombo).FDataList.KeyValue:=Null;
  FLookupCombo.ListFieldIndex:=TEtvLookField(Columns[SelectedIndex].Field).ListFieldIndex;
  FLookupCombo.DataField:=Columns[SelectedIndex].Field.FieldName;
  FLookupCombo.ReadOnly:=ReadOnly;
  if Assigned(FOnUpdateLookupCombo) then FOnUpdateLookupCombo(Columns[SelectedIndex],Columns[SelectedIndex].Field);
  if (foAutoDropDownWidth in TEtvLookField(Columns[SelectedIndex].Field).Options) or
     (TEtvLookField(Columns[SelectedIndex].Field).GridFields.Count>0) then
    FLookupCombo.DropdownWidth:=(FLookupCombo.CalcWidth+3)*Canvas.TextWidth('0')
  else FLookupCombo.DropdownWidth:=0;

  try
    FLookupCombo.ListLink.DataSet.Next; // Lev - 12.12.2007 20:50. Без этой строки глючило при вводе значений, не существующих в базе
    FLookupCombo.ListLink.DataSet.Locate(TDBLookupControlBorland(FLookupCombo).FKeyFieldName,FLookupCombo.KeyValue, [loPartialKey])
  except
    EtvApp.ShowMessage(SInvalidValue);
    FLookupCombo.SetFocus;
  end;

  BWidth:=0;
  if BorderStyle=bsSingle then
    if Ctl3D then BWidth:=2 else BWidth:=1;
  with CellRect(Col,Row) do
    SetWindowPos(FLookupCombo.Handle, HWND_TOP, Self.Left+Left+BWidth-1,
      Self.Top+Top+BWidth,Right-Left+1,Bottom-Top,SWP_SHOWWINDOW or SWP_NOREDRAW);

  FLookupCombo.Invalidate;
  FLookupCombo.Visible:=True;
  FLookupCombo.SetFocus;
  if (FKeyCode=vk_Return)and(ssCtrl in FShiftState) then
    FLookupCombo.DropDown;
end;

procedure TEtvDBGrid.DoEditData;
var FieldReturn:TFieldReturn;
    lDataSet:TDataSet;
    lItemDataSet:TItemDataSet;
    OldTag:TList;
    i:smallint;
    PropInfo: PPropInfo;
    lOnEditData:TOnEditDataEvent;
    DS:TDataSource;
begin
  with Columns[SelectedIndex].Field do
    if (Columns[SelectedIndex].Field is TEtvLookField) and
       (FieldKind=fkLookup) and Assigned(LookupDataSet) then begin
      lOnEditData:=TEtvLookField(Columns[SelectedIndex].Field).OnEditData;
      if not Assigned(lOnEditData) then begin
        PropInfo := GetPropInfo(LookupDataSet.ClassInfo, 'OnEditData');
        if PropInfo <> nil then
          lOnEditData:=TOnEditDataEvent(GetMethodProp(LookupDataSet,PropInfo));
      end;
      if Assigned(lOnEditData) then begin
        OldTag:=nil;
        if DataSet.State in [dsInsert,dsEdit] then begin
          OldTag:=TList.Create;
          lDataSet:=DataSet;
          repeat
            lItemDataSet:=TItemDataSet.Create;
            lItemDataSet.DataSet:=lDataSet;
            lItemDataSet.tag:=lDataSet.Tag;
            OldTag.Add(lItemDataSet);
            lDataSet.Tag:=80;

            DS:=nil;
            PropInfo := GetPropInfo(lDataSet.ClassInfo, 'MasterSource');
            if PropInfo <> nil then
              DS:=TDataSource(GetOrdProp(lDataSet,PropInfo))
            else begin
              PropInfo := GetPropInfo(lDataSet.ClassInfo, 'DataSource');
              if PropInfo <> nil then
                DS:=TDataSource(GetOrdProp(lDataSet,PropInfo));
            end;
            if Assigned(DS) and Assigned(DS.DataSet) then
              lDataSet:=DS.DataSet
            else break;
          until false;
        end;

        FieldReturn:=TFieldReturn.Create(nil);
        FieldReturn.Field:=LookupKeyFields;
        FieldReturn.Value:=DataSet.FieldByName(KeyFields).value;
        OkOnEditData:=false;
        try
          lOnEditData(Self,viShowModal,FieldReturn);
        except
        end;

        if Assigned(OldTag) then begin
          for i:=0 to OldTag.Count-1 do begin
            TItemDataSet(OldTag.Items[i]).DataSet.Tag:=
              TItemDataSet(OldTag.Items[i]).Tag;
            TItemDataSet(OldTag.Items[i]).Free;
          end;
          OldTag.free;
        end;
        if OkOnEditData and CanModify and (not Self.ReadOnly) then begin
          if not (Dataset.state in [dsInsert,dsEdit]) then Dataset.Edit;
          DataSet.FieldByName(KeyFields).value:=FieldReturn.Value;
        end;
        FieldReturn.free;
      end;
    end;
end;

procedure TEtvDBGrid.UpdateCombo;
var BWidth:byte; (* width of border *)
begin
  if Not Assigned(FCombo) then
    Try
      FCombo:= TEtvDBInplaceCombo.Create(self);
      FCombo.fLookup:=Self;
      Parent.InsertControl(FCombo);
      FCombo.Font.Assign(Font);
      FCombo.DataSource:=DataSource;
      TWinControlSelf(FCombo).SetZOrder(True);
    Except
      EtvApp.ShowMessage('Error create Combo!');
  end;
  FCombo.DataField:=Columns[SelectedIndex].Field.FieldName;
  FCombo.ReadOnly:=ReadOnly;

  BWidth:=0;
  if BorderStyle=bsSingle then
    if Ctl3D then BWidth:=2 else BWidth:=1;
  with CellRect(Col,Row) do
    SetWindowPos(FCombo.Handle, HWND_TOP, Self.Left+Left-3+BWidth, Self.Top+Top-3+BWidth,
      Right-Left+6,Bottom-Top+6,SWP_SHOWWINDOW or SWP_NOREDRAW);
    {SetWindowPos(FCombo.Handle, HWND_TOP, Self.Left+Left+BWidth-1,
      Self.Top+Top+BWidth,Right-Left+1,Bottom-Top,SWP_SHOWWINDOW or SWP_NOREDRAW);}

  FCombo.Invalidate;
  FCombo.Visible:=True;
  FCombo.SetFocus;
  if (FKeyCode=vk_Return)and(ssCtrl in FShiftState) then
    PostMessage(FCombo.Handle, CB_SHOWDROPDOWN, LongInt(True), 0);
end;

type TCustomEditSelf=class(TCustomEdit) end;

procedure TEtvDBGrid.UpdateExternalEditors(c:char);
var BWidth:byte; (* width of border *)
    R:TRect;
begin
  if Assigned(CreateOtherDBGridControls) then
    FOtherControl:=CreateOtherDBGridControls(Self,Columns[SelectedIndex].Field,c);
  if Assigned(FOtherControl) then begin
    HideEditor;
    if DataSource.State=dsInsert then DataLink.Modified;
    TWinControlSelf(FOtherControl).SetParent(Parent);
    TWinControlSelf(FOtherControl).SetZOrder(True);
    BWidth:=0;
    if BorderStyle=bsSingle then
      if Ctl3D then BWidth:=2 else BWidth:=1;
    with CellRect(Col,Row) do
      SetWindowPos(FOtherControl.Handle, HWND_TOP, Self.Left+Left+BWidth-1,
        Self.Top+Top+BWidth,Right-Left+1,Bottom-Top,SWP_SHOWWINDOW or SWP_NOREDRAW);

    FOtherControl.Invalidate;
    FOtherControl.Visible:=True;
    FOtherControl.SetFocus;
    if (FOtherControl is TCustomEdit) and
       (TCustomEditSelf(FOtherControl).BorderStyle=bsNone) then with FOtherControl do begin
      R := Rect(2, 2, Width - 2, Height);
      SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
      SendMessage(Handle, EM_SCROLLCARET, 0, 0);
      Invalidate;
    end;
    if c<>#0 then PostMessage(FOtherControl.Handle, WM_CHAR, Integer(c), 0);
  end;
end;

procedure TEtvDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState;X, Y: Integer);
var Cell : TGridCoord;
begin
  if (Button = mbLeft) and (ssAlt in Shift) then begin
    DoEditData;
    Exit;
  end;
  // Lev 21.05.2010
  Cell:=MouseCoord(X,Y);
  //При скроллировании данных фиксированные колонки должны оставаться на месте
  if (Cell.X >= 0) and (Cell.X < FixedCols + IndicatorOffset) and Datalink.Active then begin
    if (dgIndicator in Options) then Inherited MouseDown(Button, Shift, 1, Y)
      else if (Cell.Y >= 1) and (Cell.Y - Row <> 0) then Datalink.Dataset.MoveBy(Cell.Y - Row);
  end else inherited MouseDown(Button, Shift, X, Y);

  {inherited;}
end;

procedure TEtvDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[ssAlt]) and
     (Columns[SelectedIndex].Field is TEtvLookField) then begin
    Key:=0;
    DoEditData;
  end;
  if (Key=90) and (Shift=[ssCtrl]) then begin
    Key:=0;
    if Columns[SelectedIndex].Field is TEtvLookField then begin
      with TEtvLookField(Columns[SelectedIndex].Field) do
        if ListFieldIndex<LookupResultCount-1 then ListFieldIndex:=ListFieldIndex+1
        else ListFieldIndex:=0;
      Invalidate;
    end;
  end;

  // наша задача - не пустить в область фиксированных колонок,
  // то есть SelectedIndex  не может быть меньше, чем FFixedCols
  // Lev 21.05.2010 - нашел в инете хорошую статью про заголовки и столбцы Grid'а
  if ssCtrl in Shift then begin
    if (Key = VK_LEFT) and (FixedCols > 0) then begin
      SelectedIndex := FixedCols;
      Exit;
    end;
  end else case Key Of
        VK_LEFT: if (FixedCols > 0) and not (dgRowSelect in Options)
                 then if SelectedIndex <= FFixedCols then Exit;
        VK_HOME: if (FixedCols > 0) and (ColCount <> IndicatorOffset + 1) and not (dgRowSelect in Options) then begin
                   SelectedIndex := FixedCols;
                   Exit;
                 end;
      end;

  inherited;
end;

procedure TEtvDBGrid.EtvOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(fOnKeyDown) then fOnKeyDown(Self,Key,Shift);
  if Key=VK_Return then begin
    try
      TEtvGridDataLink(TCustomDBGridBorland(Self).FDataLink).UpdateData;
      { Обработчик для случая наличия события NewRecord и позиционирования в определенный столбец Lev 12.02.2010 }
      if not GridAcceptKey and (SelectedIndex=Columns.Count-1) then
        PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_DOWN,0) { Вместо ENTER'а(TAB'а) посылаем VK_DOWN }
      else KeyReturn(Sender,Key,Shift) { Вместо ENTER'а посылаем TAB }
    except end
  end;
end;

procedure TEtvDBGrid.VisibleChanging;
begin
  if Visible then begin
    if assigned(FLookupCombo) and FLookupCombo.Visible then FLookupCombo.Visible:=False;
    if assigned(FCombo) and FCombo.Visible then FCombo.Visible:=False;
    if assigned(FEditCode) and FEditCode.Visible then FEditCode.Visible:=False;
  end;
end;

function TEtvDBGrid.CreateEditor: TInplaceEdit;
begin
  Result := TEtvDBGridInplaceEdit.Create(Self);
end;

procedure TEtvDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  Field: TEtvLookField;
  PartRect: TRect;
  FieldsCount,TextWidth, W: Integer;
  i,j:integer;
  FieldsList:TList;
  DataCol: integer;

Procedure DrawSubHeader(ACol : Integer; Canvas : TCanvas); // Lev 21.05.10
var HRect : TRect;

begin
  // Получаем прямоугольник, объединяющий несколько колонок, для которых рисуем сложный заголовок
  HRect:=GetHeaderRect(ACol);
  // Заголовок не нужен!!!
  with HRect do if (Top=0) and (Left=0) and (Right=0) and (Bottom=0) then Exit;
  {PartRect.Top := RectHeight(ARect) div fTitleRows;}
  // По высоте берем только часть прямоугольника, т.к. вторая часть — обычный заголовок
  // Здеся fTitleRowCount - РЕАЛЬНОЕ (РАСЧИТЫВАЕМОЕ IGO, А НЕ ОБЪЯВЛЕННОЕ (fTitleRows)) кол-во строк в заголовке.
  // 0.5 - добавка для сложного заголовка. 0.5, а не 1 потому что шрифт крупный, и Bottom прямоугольника одлжен быть ниже.
  HRect.Bottom:=Round(RectHeight(HRect)/(fTitleRowCount+0.5));
  PartRect.Top := HRect.Bottom; // А это - верхняя граница прям-ка для остального заголовка.
  Canvas.FillRect(HRect);
  // Вписываем текст, который получаем методом GetHeaderText
  InflateRect(HRect,-1,-1);
  (*WriteText(Canvas, HRect, GetHeaderText(ACol) , taCenter);*)

  WriteText(Canvas, HRect, 0, 0,{'ТЕСТ'}GetHeaderText(ACol), taCenter
            {$IFDEF Delphi4},false{$ENDIF});

  // Рисуем 3D-окантовку
  Paint3dRect(Canvas.Handle,HRect);
  // Рисуем нижнюю линию ячейки заголовка черным цветом
  DrawLine(Canvas,Color,clBlack,HRect.Right, HRect.Bottom, HRect.Left-3, HRect.Bottom,1);
end;

begin
  FIntoField:=false;
  if Assigned(DataLink) and (ACol >= IndicatorOffset) and (not(gdFixed in AState)) and
     Assigned(Columns[ACol-IndicatorOffset].Field) and (Columns[ACol-IndicatorOffset].Field is TEtvLookField) then begin
    Canvas.Font:=Font;
    TextWidth :=Canvas.TextWidth('0');
    Field:=TEtvLookField(Columns[ACol-IndicatorOffset].Field);
    PartRect:=ARect;
    {if Field.LookupResultCount=0 then Field.ChangeLookupFields;}
    if Field.GridFields.Count>0 then begin
      FieldsList:=Field.GridFields;
      FieldsCount:=FieldsList.Count;
    end
    else begin
      FieldsList:=Field.LookupFields;
      FieldsCount:=Field.LookupResultCount;
    end;
    FIntoField:=true;

    for i:=0 to FieldsCount-1 do begin
      if Field.GridFields.Count>0 then begin
        Field.VFieldIndex:=0;
        for j:=0 to Field.LookupFields.Count-1 do
          if FieldsList[i]=Field.LookupField[j] then begin
            Field.VFieldIndex:=j;
            break;
          end;
      end else Field.VFieldIndex:=i;
      W :=TextWidth*TField(FieldsList[i]).DisplayWidth;
      PartRect.Right:=PartRect.Left+W+4;
      if PartRect.Right>ARect.Right then PartRect.Right:=ARect.Right;
      if (i=FieldsCount-1) and (PartRect.Right<ARect.Right) then PartRect.Right:=ARect.Right;
      DBGridDrawCell(ACol,ARow,PartRect, AState);
      DrawLine(Canvas,Color,clBtnFace,PartRect.Right, PartRect.Top, PartRect.Right, PartRect.Bottom,1);
      if (FieldsList[i]=Field.LookupField[Field.ListFieldIndex]) and
         HighlightCell(ACol, ARow, '', AState) then
        DrawLine(Canvas,Color,clBtnFace,PartRect.Left+1, PartRect.Bottom-3, PartRect.Left+13, PartRect.Bottom-3,1);
      Inc(PartRect.Left,W+5);
      if PartRect.Left>=ARect.Right then break;
    end;
    if DefaultDrawing and (gdSelected in AState)
       and ((dgAlwaysShowSelection in Options) or Focused)
       and not (csDesigning in ComponentState)
       and not (dgRowSelect in Options)
       and (UpdateLock = 0)
       and (ValidParentForm(Self).ActiveControl = Self) then
      Windows.DrawFocusRect(Canvas.Handle, ARect);
    Field.VFieldIndex:=-1;
  end else begin
// Lev 21.05.10 Test Прорисовка сложных заголовков
    PartRect := ARect;
    if (dgTitles in Options) and (gdFixed in AState) and (ARow = 0) and (ACol <> 0) then begin

      // Стандартное действие DBGrid
      (*
      if csLoading in ComponentState then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(ARect);
        Exit;
      end;
      FRect := ARect;
      *)
      DataCol:=ACol-1;

      Canvas.Brush.Color := Columns[DataCol].Title.Color;
      {Canvas.Font := Columns[DataCol].Title.Font;}
      if FSubHeader then begin
        // Рисуем объединяющий заголовок Header к мелким заголовкам Title
        Canvas.Font.Name:='Tahoma';
        Canvas.Font.Style:=[fsBold];
        Canvas.Font.Size:=11;
        DrawSubHeader(DataCol, Canvas);
        // Рисуем заголовки Title
        (*PartRect.Top := RectHeight(ARect) div FTitleRows;*)
        (*
        DrawTitleCell(FRect, Columns[DataCol]);
        *)
      end else Canvas.Font := Columns[DataCol].Title.Font;
      (*
      else  {DrawTitleCell(FRect, Columns[DataCol]);}
      (*
      if Assigned(FOnDrawTitleRect) then
        FOnDrawTitleRect(self, DataCol, Columns[DataCol], FRect);
      *)
    end;
// Lev 21.05.10 Test
    DBGridDrawCell(ACol,ARow,PartRect,AState);
  end;
end;

procedure TEtvDBGrid.DBGridDrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
  function RowIsMultiSelected: Boolean;
  var
    Index: Integer;
  begin
    Result := (dgMultiSelect in Options) and Datalink.Active and
      {TCustomDBGridBorland(Self).FBookmarks}
      SelectedRows.Find(Datalink.Datasource.Dataset.Bookmark, Index);
  end;
var
  OldActive: Integer;
  Indicator: Integer;
  Highlight: Boolean;
  Value: string;
  DrawColumn: TColumn;
  FrameOffs: Byte;
  MultiSelected: Boolean;
  OldTop,OldBottom,i,L,Pos:integer;
  s:string;
  lTitleAlignment: TAlignment;
  lColor:TColor;
begin
  if csLoading in ComponentState then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ARect);
    Exit;
  end;

  Dec(ARow, TCustomDBGridBorland(Self).FTitleOffset);
  Dec(ACol, IndicatorOffset);

  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =[dgRowLines, dgColLines]) then begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end else FrameOffs := 2;

  if (gdFixed in AState) and (ACol < 0) then
  begin
    Canvas.Brush.Color := FixedColor;
    Canvas.FillRect(ARect);
    if Assigned(DataLink) and DataLink.Active  then
    begin
      MultiSelected := False;
      if ARow >= 0 then
      begin
        OldActive := DataLink.ActiveRecord;
        try
          Datalink.ActiveRecord := ARow;
          MultiSelected := RowIsMultiselected;
        finally
          Datalink.ActiveRecord := OldActive;
        end;
      end;
      if (ARow = DataLink.ActiveRecord) or MultiSelected then
      begin
        Indicator := 0;
        if DataLink.DataSet <> nil then
          case DataLink.DataSet.State of
            dsEdit: Indicator := 1;
            dsInsert: Indicator := 2;
            dsBrowse:
              if MultiSelected then
                if (ARow <> Datalink.ActiveRecord) then
                  Indicator := 3
                else
                  Indicator := 4;  // multiselected and current row
          end;
        TCustomDBGridBorland(Self).FIndicators.BkColor := FixedColor;
        TCustomDBGridBorland(Self).FIndicators.Draw(Canvas, ARect.Right -
          TCustomDBGridBorland(Self).FIndicators.Width - FrameOffs,
          (ARect.Top + ARect.Bottom - TCustomDBGridBorland(Self).FIndicators.Height) shr 1, Indicator);
        if ARow = Datalink.ActiveRecord then
          TCustomDBGridBorland(Self).FSelRow := ARow + TCustomDBGridBorland(Self).FTitleOffset;
      end;
    end;
  end
  else with Canvas do begin
    DrawColumn := Columns[ACol];
    if gdFixed in AState then
    begin
      if Assigned(DrawColumn.Field) and (DrawColumn.Field.Tag<>10) then   // 20.01.11 Lev. Для фиксированных столбцов хочу шрифт как в Grid'е
        Font := DrawColumn.Title.Font
      else Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Title.Color;
    end
    else
    begin
      Font := DrawColumn.Font;
      Brush.Color := DrawColumn.Color;
    end;
    {Etv Begin}
    {if ARow < 0 then with DrawColumn.Title do begin
      WriteText(Canvas, ARect, FrameOffs, FrameOffs, Caption, Alignment)}
    if ARow < 0 then with DrawColumn.Title do begin
      if cvTitleAlignment in DrawColumn.AssignedValues then
        lTitleAlignment:=DrawColumn.Title.Alignment
      else lTitleAlignment:=fTitleAlignment;
      if (fTitleRows>0) and (fTitleRowCount>1) then begin
        OldTop:=ARect.Top;
        OldBottom:=ARect.Bottom;
        Pos:=1;
        if FrameOffs=1 then L:=2 else L:=0;
        for i:=1 to fTitleRowCount do begin
          if i=fTitleRowCount then ARect.Bottom:=OldBottom
          else ARect.Bottom:=ARect.Top+(RowHeights[0]-3) div fTitleRowCount;
          s:=NextSubStr(Caption,ARect.Right-ARect.Left-4+L,Pos);
          if (i=fTitleRowCount) and (Pos<=Length(Caption)) then
            s:=s+'...';
          WriteText(Canvas, ARect, FrameOffs, FrameOffs,s,lTitleAlignment
            {$IFDEF Delphi4},false{$ENDIF});
          ARect.Top:=ARect.Bottom;
        end;
        ARect.Top:=OldTop;
      end else
        WriteText(Canvas, ARect, FrameOffs, FrameOffs, Caption, lTitleAlignment
          {$IFDEF Delphi4},false{$ENDIF})
    end
    {EtvEnd}
    else if (DataLink = nil) or not DataLink.Active then
      FillRect(ARect)
    else
    begin
      Value := '';
      OldActive := DataLink.ActiveRecord;
      try
        DataLink.ActiveRecord := ARow;
        {Etv begin}
        {if Assigned(DrawColumn.Field) then
          Value := DrawColumn.Field.DisplayText;}
        if Assigned(DrawColumn.Field) then begin
          Value := DrawColumn.Field.DisplayText;
          if Assigned(OnSetFont) then OnSetFont(Self,DrawColumn.Field,Font);
        end;
       {Etv End}
        Highlight := HighlightCell(ACol, ARow, Value, AState);
        if Highlight then
        begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        {Etv Begin}
        else
          if Assigned(DrawColumn.Field) and Assigned(OnSetColor) then begin
            lColor:=DrawColumn.Color;
            OnSetColor(Self,DrawColumn.Field,lColor);
            Brush.Color:=lColor;
          end;
        {Etv End}
        if DefaultDrawing then
          {Etv Begin}
          if FIntoField then
            WriteText(Canvas, ARect, 2, 2, Value,
              TField(TEtvLookField(DrawColumn.Field).
              LookupField[TEtvLookField(DrawColumn.Field).VFieldIndex]).Alignment
              {$IFDEF Delphi4},false{$ENDIF})
          else
          {Etv End}
            WriteText(Canvas, ARect, 2, 2, Value, DrawColumn.Alignment
            {$IFDEF Delphi4},false{$ENDIF});
        if Columns.State = csDefault then
          DrawDataCell(ARect, DrawColumn.Field, AState);
        DrawColumnCell(ARect, ACol, DrawColumn, AState);
      finally
        DataLink.ActiveRecord := OldActive;
      end;
      if DefaultDrawing and (gdSelected in AState)
        and ((dgAlwaysShowSelection in Options) or Focused)
        and not (csDesigning in ComponentState)
        and not (dgRowSelect in Options)
        and (UpdateLock = 0)
        and (ValidParentForm(Self).ActiveControl = Self)
{EtvBegin}
        and (Not FIntoField) then
{EtvEnd}
        Windows.DrawFocusRect(Handle, ARect);
    end;
  end;
  if (gdFixed in AState) and ([dgRowLines, dgColLines] * Options =[dgRowLines, dgColLines]) then begin
{
    InflateRect(ARect, 1, 1);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_TOPLEFT);
}
    Paint3dRect(Canvas.Handle,ARect); // Lev 25.05.10
  end;
end;

{TPopupMenuEtvDBGrid}
constructor TPopupMenuEtvDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  InsertItem(0,SDialVisibleFields,SetListFieldVisible,0);
  InsertItem(1,SPopupPrint,Print,0);
  InsertItem(2,SGridPrintRecord,PrintRec,0);
  InsertItem(3,SGridOrRecord,ChangeControls,0);
  InsertItem(4,SGridSetLengthFieldsByDataScan,SetLengthFields,0);
  InsertItem(5,'-',nil,0);
  fGridLineCount:=6;
end;

function TPopupMenuEtvDBGrid.GetGrid:TDBGrid;
begin
  Result:=nil;
  if Assigned(PopupComponent) then
    if (PopupComponent is TDBGrid) then Result:=TDBGrid(PopupComponent)
    else if (PopupComponent is TEtvScrollBoxForGrid) and
      Assigned(TEtvScrollBoxForGrid(PopupComponent).Grid) then
        Result:=TDBGrid(TEtvScrollBoxForGrid(PopupComponent).Grid);
end;

procedure TPopupMenuEtvDBGrid.CheckScroll;
begin
  if PopupComponent is TEtvScrollBoxForGrid then
    TEtvScrollBoxForGrid(PopupComponent).RefreshRecord;
end;

procedure TPopupMenuEtvDBGrid.ProcOnPopup(Sender: TObject; LineAdd:smallint);
begin
  inherited ProcOnPopup(Sender,LineAdd+fGridLineCount);
  if GetGrid<>nil then with GetGrid do begin
    if Assigned(DataSource) and Assigned(DataSource.DataSet) and
       DataSource.DataSet.Active then begin
      if GetGrid is TEtvDBGrid then begin
        Items[LineAdd].Enabled:=true;
        if not(DataSource.DataSet.BOF and DataSource.DataSet.EOF) then begin
          Items[LineAdd+1].Enabled:=true;
          Items[LineAdd+2].Enabled:=true;
        end;
      end else if not(DataSource.DataSet.BOF and DataSource.DataSet.EOF) then begin
        Items[LineAdd+1].Enabled:=Assigned(CreateOtherDBGridPrint);
        Items[LineAdd+2].Enabled:=Assigned(CreateOtherDBGridPrintRecord);
      end;
      Items[LineAdd+3].Enabled:=true;
      Items[LineAdd+4].Enabled:=true;
    end;
  end;
end;

procedure TPopupMenuEtvDBGrid.SetListFieldVisible(Sender: TObject);
begin
  if GetGrid is TEtvDBGrid then begin
    TEtvDBGrid(GetGrid).SetListFieldVisible;
    CheckScroll;
  end;
end;

procedure TPopupMenuEtvDBGrid.Print(Sender: TObject);
var lGrid:TDBGrid;
begin
  lGrid:=GetGrid;
  if lGrid is TEtvDBGrid then TEtvDBGrid(lGrid).Print
  else if (lGrid is TDBGrid) and Assigned(CreateOtherDBGridPrint) then
   with lGrid do
    if Assigned(DataSource) and (Assigned(DataSource.DataSet)) and
       DataSource.DataSet.Active and
       (not(DataSource.DataSet.BOF and DataSource.DataSet.EOF)) then try
      CreateOtherDBGridPrint(lGrid);
    except
      EtvApp.ShowMessage(SGridPrintError);
    end;
end;

procedure TPopupMenuEtvDBGrid.PrintRec(Sender: TObject);
var lGrid:TDBGrid;
begin
  lGrid:=GetGrid;
  if lGrid is TEtvDBGrid then TEtvDBGrid(lGrid).PrintRec
  else if (lGrid is TDBGrid) and Assigned(CreateOtherDBGridPrintRecord) then
   with lGrid do
    if Assigned(DataSource) and (Assigned(DataSource.DataSet)) and
       DataSource.DataSet.Active and
       (not(DataSource.DataSet.BOF and DataSource.DataSet.EOF)) then try
      CreateOtherDBGridPrintRecord(lGrid);
    except
      EtvApp.ShowMessage(SGridPrintRecordError);
    end;
end;

procedure TPopupMenuEtvDBGrid.SetLengthFields(Sender: TObject);
begin
  SetLengthFieldsByDataScan(GetGrid,300);
  CheckScroll;
end;

procedure TPopupMenuEtvDBGrid.ChangeControls(Sender: TObject);
var Scroll:TEtvScrollBoxForGrid;
begin
  if Assigned(PopupComponent) then
    if PopupComponent is TCustomDBGrid then begin
      Scroll:=TEtvScrollBoxForGrid.Create(PopupComponent.Owner);
      Scroll.Grid:=TCustomDBGrid(PopupComponent);
      Scroll.PopupMenu:=Self;
      Scroll.ChangeControls;
    end
    else if PopupComponent is TEtvScrollBoxForGrid then
      try
        TEtvScrollBoxForGrid(PopupComponent).ChangeControls;
      finally
        TEtvScrollBoxForGrid(PopupComponent).Free;
      end;
end;

var fPopupMenuEtvDBGrid:TPopupMenuEtvDBGrid;
function PopupMenuEtvDBGrid:TPopupMenu;
begin
  if Not Assigned(fPopupMenuEtvDBGrid) then
    fPopupMenuEtvDBGrid:=TPopupMenuEtvDBGrid.Create(nil);
  Result:=fPopupMenuEtvDBGrid;
end;

procedure SetLengthFieldsByDataScan(aDataSet:TComponent; aMaxRowScan:integer);
var B:TBookmark;
    List:array[0..1024] of byte;
    i,j,l:integer;
    lDataSet:TDataSet;
    TM: TTextMetric;
    lRowScan:integer;
    OldActive:boolean;
begin
  lDataSet:=nil;
  if aDataSet is TDataSet then lDataSet:=TDataSet(aDataSet)
  else
  if (aDataSet is TDBGrid) and
     Assigned(TDBGrid(aDataSet).DataSource)then
    lDataSet:=TDBGrid(aDataSet).DataSource.DataSet;

  if Assigned(lDataSet) then Try
    OldActive:=lDataSet.Active;
    if Not OldActive then lDataSet.Open
    else lDataSet.CheckBrowseMode;
    if Not (lDataSet.BOF and lDataSet.EOF) then begin
      lDataSet.DisableControls;
      B:=nil;
     if OldActive then B:=lDataSet.GetBookmark;

      FillChar(List,lDataSet.FieldCount,#0);
      lDataSet.First;
      lRowScan:=0;
      while (not lDataSet.EOF) and (lRowScan<aMaxRowScan) do begin
        for i:=0 to lDataSet.FieldCount-1 do
          if (not(lDataSet.fields[i] is TBlobField)) and
             (not(lDataSet.fields[i] is TEtvLookField)) then begin
            l:=length(lDataSet.fields[i].DisplayText);
            if list[i]<l then
              if l>255 then List[i]:=255
              else List[i]:=l;
          end;
        lDataSet.Next;
        Inc(lRowScan);
      end;
      for i:=0 to lDataSet.FieldCount-1 do
        if List[i]>0 then begin
          if (aDataSet is TDBGrid) and
             (dgColumnResize in TDBGrid(aDataSet).Options) then with TDBGrid(aDataSet) do
            for j:=0 to Columns.Count-1 do
              if Columns[j].Field=lDataSet.fields[i] then begin
                Canvas.Font:=Columns[j].Font;
                GetTextMetrics(Canvas.Handle, TM);
                Columns[j].Width:=
                  (List[i]+1+list[i] div 20)*(Canvas.TextWidth('0')-TM.tmOverhang)+TM.tmOverhang+4;
                break;
              end;
          lDataSet.fields[i].DisplayWidth:=List[i]+1+list[i] div 20;
        end;
      if B<>nil then begin
        GotoBookMarkWOExcept(lDataSet,B);
        lDataSet.FreeBookmark(B);
      end;
    end;
    if not OldActive then lDataSet.Close;
  finally
    lDataSet.EnableControls;
  end;
end;

initialization

finalization
  if Assigned(FPopupMenuEtvDBGrid) then fPopupMenuEtvDBGrid.Free;
end.
