
{ A modified version of TDBNavigator. Added 4 new buttons:
    2 buttons to jump either forward or backwards a specified number of records.
    1 button to set a bookmark to the current record.
    1 button to goto bookmark prevously set.

    Properties:

     JUMP: integer       set this property to the number of
                           records you would like to jump.

 I couldn't figure out how to add this functionality through
   inheritence because of all the types that are  defined for the
   dbnavigator and the resource files and so on.

 I was able to add this functionallity through copying all the code
    associated with the dbnavigator into another unit and make changes to that
    unit, creating my own recource file(nav.res) and registering the component as
    TExtDBNavigator.
}
Unit Nav;

Interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Controls, Forms,
     Graphics, Menus, StdCtrls, ExtCtrls, DB, DBTables, Mask, Buttons, XMisc;

Const InitRepeatPause = 400;  { pause before repeat timer (ms) }
      RepeatPause     = 100;  { pause before hint window displays (ms)}
      SpaceSize       =   5;  { size of space between special buttons }

type
  TNavButton = class;
  TNavDataLink = class;

  TNavGlyph = (ngEnabled, ngDisabled);

  {Added nbMark, nbGoto: How can I override these variables}
  TNavigateBtn = (nbFirst, nbRW, nbPrior, nbNext, nbFF, nbLast, nbInsert,
                  nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbMark, nbGoto);
  TButtonSet = set of TNavigateBtn;
  TNavButtonStyle = set of (nsAllowTimer, nsFocusRect);

  ENavClick = procedure (Sender: TObject; Button: TNavigateBtn) of object;

  { TExtDBNavigator }

  TExtDBNavigator = class (TCustomPanel)
  private
    FConfirmDelete: Boolean;
    {FIsStoredDataSource: Boolean;}
    {FStoredDataSource: TDataSource;}
    FStoredControlSource: TDataSource;
    FDataLink: TNavDataLink;
    FVisibleButtons: TButtonSet;
    FHints: TStrings;
    ButtonWidth: Integer;
    MinBtnSize: TPoint;
    FOnNavClick: ENavClick;
    FBeforeAction: ENavClick;
    FocusedButton: TNavigateBtn;
    {added Bookmark: this could be acomplished with inheritence}
    FBM: TBookmark;
    FJump: longint;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure InitButtons;
    procedure InitHints;
    procedure ClickBtn(Sender: TObject);
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetVisible(Value: TButtonSet);
    procedure AdjustSize (var W: Integer; var H: Integer);
    procedure SetHints(Value: TStrings);
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMChangeControlSource(var Msg: TMessage); message WM_ChangeControlSource;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    Buttons: array[TNavigateBtn] of TNavButton;
    procedure DataChanged;
    procedure EditingChanged;
    procedure ActiveChanged;

    procedure ReadState(Reader: TReader); override;
    (*** TEST
    procedure Loaded; override;
    TEST ***)
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure BtnClick(Index: TNavigateBtn);
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property VisibleButtons: TButtonSet read FVisibleButtons write SetVisible
      default [nbFirst, nbRW, nbPrior, nbNext, nbFF, nbLast, nbInsert, nbDelete,
        nbEdit, nbPost, nbCancel, nbRefresh];
    property Jump: longint read FJump write FJump default 20;
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Ctl3D;
    property Hints: TStrings read FHints write SetHints;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property BeforeAction: ENavClick read FBeforeAction write FBeforeAction;
    property OnClick: ENavClick read FOnNavClick write FOnNavClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnResize;
  end;
{ TExtDBNavigator }

{ TNavButton }

  TNavButton = class(TSpeedButton)
  private
    FIndex: TNavigateBtn;
    FNavStyle: TNavButtonStyle;
    FRepeatTimer: TTimer;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    destructor Destroy; override;
    property NavStyle: TNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TNavigateBtn read FIndex write FIndex;
  end;
{ TNavButton }

{ TNavDataLink }

  TNavDataLink = class(TDataLink)
  private
    FNavigator: TExtDBNavigator;
  protected
    procedure EditingChanged; override;
    procedure DataSetChanged; override;
    procedure ActiveChanged; override;
  public
    constructor Create(ANav: TExtDBNavigator);
    destructor Destroy; override;
  end;
{procedure register;}
Implementation

Uses DBIErrs, DBITypes, Clipbrd, DBConsts, Dialogs;

{$R Nav}

{ TExtDBNavigator }
{
procedure Register;
begin
  RegisterComponents('Samples', [TExtDBNavigator]);
end;
 }
(*
const
  BtnStateName: array[TNavGlyph] of PChar = ('EN', 'DI');

  {Added Mark and Goto to this list}
  BtnTypeName: array[TNavigateBtn] of PChar = ('FIRST', 'RW', 'PRIOR', 'NEXT','FF',
    'LAST', 'INSERT', 'DELETE', 'EDIT', 'POST', 'CANCEL', 'REFRESH', 'MARK', 'GOTO');

  {Added 10 thru 13  to this list????}
  BtnHintId: array[TNavigateBtn] of Word = (SFirstRecord, SPriorRecord,
    SNextRecord, SLastRecord, SInsertRecord, SDeleteRecord, SEditRecord,
    SPostEdit, SCancelEdit, SRefreshRecord,10, 11, 12, 13);
 *)
var
  {Added Mark and Goto to this list}
  BtnTypeName: array[TNavigateBtn] of PChar = ('FIRST', 'RW', 'PRIOR', 'NEXT','FF',
    'LAST', 'INSERT', 'DELETE', 'EDIT', 'POST', 'CANCEL', 'REFRESH', 'MARK', 'GOTO');
  BtnHintId: array[TNavigateBtn] of string = (
  'Первая запись',
  'Назад на страницу',
  'Предыдущая запись',
  'Следующая запись',
  'Вперед на страницу',
  'Последняя запись',
  'Новая запись',
  'Удалить запись',
  'Редактировать запись',
  'Сохранить измененное',
  'Отказаться от измененного',
  'Обновить записи',
  'Установить отметку',
  'Перейти на отметку');

Constructor TExtDBNavigator.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption] + [csFramed, csOpaque];
  FDataLink := TNavDataLink.Create(Self);
  FVisibleButtons := [nbFirst, {nbRW,} nbPrior, nbNext, {nbFF,} nbLast, nbInsert,
    nbDelete, nbEdit, nbPost, nbCancel, nbRefresh, nbMark, nbGoto];
  FHints := TStringList.Create;
  { added hints }
  FJump := 20;
  FHints.add('Первая запись');
  FHints.add('Назад на страницу');
  FHints.add('Предыдущая запись');
  FHints.add('Следующая запись');
  FHints.add('Вперед на страницу');
  FHints.add('Последняя запись');
  FHints.add('Новая запись');
  FHints.add('Удалить запись');
  FHints.add('Редактировать запись');
  FHints.add('Сохранить измененное');
  FHints.add('Отказаться от измененного');
  FHints.add('Обновить записи');
  FHints.add('Установить отметку');
  FHints.add('Перейти на отметку');
  ShowHint:=True;
  InitButtons;
  BevelOuter:=bvNone;
  BevelInner:=bvNone;
  Width:=241;
  Height:=25;
  ButtonWidth:=0;
  FocusedButton:=nbFirst;
  FConfirmDelete:=True;
end;

Destructor TExtDBNavigator.Destroy;
begin
  FHints.Free;
  FDataLink.Free;
  FDataLink:=nil;
  Inherited Destroy;
end;

Procedure TExtDBNavigator.InitButtons;
var i: TNavigateBtn;
    Btn: TNavButton;
    X: Integer;
    ResName: array[0..40] of Char;
begin
  MinBtnSize:=Point(20, 18);
  X:=0;
  for i:=Low(Buttons) to High(Buttons) do begin
    Btn:=TNavButton.Create(Self);
    Btn.Index:=i;
    Btn.Visible:=i in FVisibleButtons;
    Btn.Enabled:=True;
    Btn.SetBounds(X, 0, MinBtnSize.X, MinBtnSize.Y);
    {Changed dbn to dbd, to match nav.res file}
    Btn.Glyph.Handle:=LoadBitmap(HInstance, StrFmt(ResName, 'dbd_%s',[BtnTypeName[i]]));
    Btn.NumGlyphs:=2;
    Btn.OnClick:=ClickBtn;
    Btn.OnMouseDown:=BtnMouseDown;
    Btn.Parent:=Self;
    Buttons[I]:=Btn;
    X:=X+MinBtnSize.X;
  end;
  InitHints;
  Buttons[nbPrior].NavStyle:=Buttons[nbPrior].NavStyle + [nsAllowTimer];
  Buttons[nbNext].NavStyle:=Buttons[nbNext].NavStyle + [nsAllowTimer];
end;

Procedure TExtDBNavigator.InitHints;
var i: Integer;
    j: TNavigateBtn;
begin
  for j:=Low(Buttons) to High(Buttons) do Buttons[j].Hint:=BtnHintId[j];
  j:=Low(Buttons);
  for i:=0 to (FHints.Count-1) do begin
    if FHints.Strings[i]<>'' then Buttons[j].Hint:=FHints.Strings[i];
    if j=High(Buttons) then Exit;
    Inc(j);
  end;
end;

Procedure TExtDBNavigator.SetHints(Value: TStrings);
begin
  FHints.Assign(Value);
  InitHints;
end;

Procedure TExtDBNavigator.Notification(AComponent: TComponent; Operation: TOperation);
begin
(*** TEST  Writeln(FFFF,'TExtDBNavigator.Notification #1 : ',AComponent.Name); ***)
  Inherited Notification(AComponent, Operation);
(*** TEST!!!   Writeln(FFFF,'TExtDBNavigator.Notification #2 : ',AComponent.Name); ***)
  if Assigned(FDataLink) and (Operation=opRemove) and (FDataLink<>nil) and
  (AComponent=DataSource) then DataSource:=nil;
(*** TEST!!!   Writeln(FFFF,'TExtDBNavigator.Notification #3 : ',AComponent.Name); ***)
end;

Procedure TExtDBNavigator.SetVisible(Value: TButtonSet);
var i: TNavigateBtn;
    w,h: Integer;
begin
  W:=Width;
  H:=Height;
  FVisibleButtons:=Value;
  for i:=Low(Buttons) to High(Buttons) do Buttons[i].Visible:=i in FVisibleButtons;
  AdjustSize(W,H);
  if (W<>Width) or (H<>Height) then Inherited SetBounds(Left, Top, W, H);
  Invalidate;
end;

Procedure TExtDBNavigator.AdjustSize (var W: Integer; var H: Integer);
var Count: Integer;
    MinW: Integer;
    I: TNavigateBtn;
    {LastBtn: TNavigateBtn;}
    Space, Temp, Remain: Integer;
    X: Integer;
begin
  { if (csLoading in ComponentState) then Exit;}
  if Buttons[nbFirst]=nil then Exit;
  Count := 0;
  {LastBtn := High(Buttons);}
  for i:=Low(Buttons) to High(Buttons) do begin
    if Buttons[I].Visible then begin
      Inc(Count);
      {LastBtn:=i;}
    end;
  end;
  if Count=0 then Inc(Count);

  MinW:=Count*(MinBtnSize.X - 1) + 1;
  if W < MinW then W := MinW;
  if H < MinBtnSize.Y then H := MinBtnSize.Y;
  ButtonWidth := ((W - 1) div Count) + 1;
  Temp := Count * (ButtonWidth - 1) + 1;
  if Align = alNone then W := Temp;
  X:=0;
  Remain:=W-Temp;
  Temp:=Count div 2;
  for i:=Low(Buttons) to High(Buttons) do begin
    if Buttons[I].Visible then begin
      Space := 0;
      if Remain <> 0 then begin
        Dec (Temp, Remain);
        if Temp < 0 then begin
          Inc (Temp, Count);
          Space := 1;
        end;
      end;
      Buttons[I].SetBounds (X, 0, ButtonWidth + Space, Height);
      Inc(X, ButtonWidth - 1 + Space);
      {LastBtn:=i;}
    end else Buttons[i].SetBounds (Width + 1, 0, ButtonWidth, Height);
  end;
end;

Procedure TExtDBNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  AdjustSize (W, H);
  Inherited SetBounds (ALeft, ATop, W, H);
end;

Procedure TExtDBNavigator.WMSize(var Message: TWMSize);
var W, H: Integer;
begin
  Inherited;
  { check for minimum size }
  W := Width;
  H := Height;
  AdjustSize (W, H);
  if (W <> Width) or (H <> Height) then Inherited SetBounds(Left, Top, W, H);
  Message.Result := 0;
end;

Procedure TExtDBNavigator.ClickBtn(Sender: TObject);
begin
  BtnClick (TNavButton (Sender).Index);
end;

Procedure TExtDBNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
                Shift: TShiftState; X, Y: Integer);
var OldFocus: TNavigateBtn;
begin
  OldFocus := FocusedButton;
  FocusedButton := TNavButton (Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then begin
    SetFocus;
    if (GetFocus <> Handle) then Exit;
  end else
    if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then begin
      Buttons[OldFocus].Invalidate;
      Buttons[FocusedButton].Invalidate;
    end;
end;

Procedure TExtDBNavigator.BtnClick(Index: TNavigateBtn);
begin
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then begin
    if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
      FBeforeAction(Self, Index);
    with DataSource.DataSet do begin
      case Index of
        nbPrior: Prior;
        nbRW: MoveBy(-FJump);
        nbFF: MoveBy(Fjump);
        nbNext: Next;
        nbFirst: First;
        nbLast: Last;
        nbInsert: Insert;
        nbEdit: Edit;
        nbCancel: Cancel;
        nbPost: Post;
        nbRefresh: Refresh;
        nbDelete:
          begin
            if not FConfirmDelete or
            (MessageDlg (SDeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel) then
              Delete;
          end;
        nbMark:
          begin
            FBM:=GetBookMark;
            Buttons[nbGoto].Enabled:=True;
          end;
       nbGoto:
         begin
           GotoBookMark(FBM);
           FreeBookMark(FBM);
         end;
      end;
    end;
  end;
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then
    FOnNavClick(Self, Index);
end;

Procedure TExtDBNavigator.WMSetFocus(var Message: TWMSetFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

Procedure TExtDBNavigator.WMKillFocus(var Message: TWMKillFocus);
begin
  Buttons[FocusedButton].Invalidate;
end;

Procedure TExtDBNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  NewFocus: TNavigateBtn;
  OldFocus: TNavigateBtn;
begin
  OldFocus := FocusedButton;
  case Key of
    VK_RIGHT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus < High(Buttons) then NewFocus := Succ(NewFocus);
        until (NewFocus=High(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus<>FocusedButton then begin
          FocusedButton:=NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_LEFT:
      begin
        NewFocus := FocusedButton;
        repeat
          if NewFocus>Low(Buttons) then NewFocus:=Pred(NewFocus);
        until (NewFocus=Low(Buttons)) or (Buttons[NewFocus].Visible);
        if NewFocus<>FocusedButton then begin
          FocusedButton := NewFocus;
          Buttons[OldFocus].Invalidate;
          Buttons[FocusedButton].Invalidate;
        end;
      end;
    VK_SPACE: if Buttons[FocusedButton].Enabled then Buttons[FocusedButton].Click;
  end;
end;

Procedure TExtDBNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result:=DLGC_WANTARROWS;
end;

Procedure TExtDBNavigator.DataChanged;
var UpEnable, DnEnable: Boolean;
begin
  UpEnable:=Enabled and FDataLink.Active and not FDataLink.DataSet.BOF;
  DnEnable:=Enabled and FDataLink.Active and not FDataLink.DataSet.EOF;
  Buttons[nbFirst].Enabled:=UpEnable;
  Buttons[nbPrior].Enabled:=UpEnable;
  Buttons[nbNext].Enabled:=DnEnable;
  Buttons[nbLast].Enabled:=DnEnable;
  Buttons[nbDelete].Enabled:=Enabled and FDataLink.Active and
  FDataLink.DataSet.CanModify and
  not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
  {Control New Buttons}
  Buttons[nbFF].Enabled:=Buttons[nbNext].Enabled;
  Buttons[nbRW].Enabled:=Buttons[nbPrior].Enabled;
  if Assigned(DataSource) then begin
    Buttons[nbMark].Enabled:=(DataSource.State=dsBrowse);
    Buttons[nbGoto].Enabled:=(DataSource.State=dsBrowse);
  end;
  if not assigned(FBM) then Buttons[nbGoto].Enabled:=False;
end;

Procedure TExtDBNavigator.EditingChanged;
var CanModify: Boolean;
begin
  CanModify:=Enabled and FDataLink.Active and FDataLink.DataSet.CanModify;
  Buttons[nbInsert].Enabled:=CanModify;
  Buttons[nbEdit].Enabled:=CanModify and not FDataLink.Editing;
  Buttons[nbPost].Enabled:=CanModify and FDataLink.Editing;
  Buttons[nbCancel].Enabled:=CanModify and FDataLink.Editing;
  Buttons[nbRefresh].Enabled:=not (FDataLink.DataSet is TQuery);
  {Control New Buttons}
  if Assigned(DataSource) then begin
    Buttons[nbMark].Enabled:=(DataSource.State=dsBrowse);
    Buttons[nbGoto].Enabled:=(DataSource.State=dsBrowse);
  end;
  if not Assigned(FBM) then Buttons[nbGoto].Enabled:=False;
end;

Procedure TExtDBNavigator.ActiveChanged;
var I: TNavigateBtn;
begin
  if not (Enabled and FDataLink.Active) then
    for i:=Low(Buttons) to High(Buttons) do Buttons[i].Enabled:=False
  else begin
    DataChanged;
    EditingChanged;
  end;
end;

Procedure TExtDBNavigator.WMChangeControlSource(var Msg: TMessage);
var wSource, lSource: TDataSource;
begin
  lSource:= TDataSource(Msg.lParam);
  wSource:= TDataSource(Msg.wParam);
  if Assigned(lSource) then begin
    if wSource=DataSource then begin
      FStoredControlSource:= DataSource;
      DataSource:= lSource;
    end;
  end else begin
    if wSource=FStoredControlSource then begin
      DataSource:= FStoredControlSource;
      FStoredControlSource:=nil;
    end;
  end;
end;

Procedure TExtDBNavigator.CMEnabledChanged(var Message: TMessage);
begin
  Inherited;
  if not (csLoading in ComponentState) then ActiveChanged;
end;

Procedure TExtDBNavigator.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:=Value;
  if not (csLoading in ComponentState) then ActiveChanged;
end;

Function TExtDBNavigator.GetDataSource: TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

Procedure TExtDBNavigator.ReadState(Reader: TReader);
var W, H: Integer;
begin
  Inherited ReadState(Reader);
  W:=Width;
  H:=Height;
  AdjustSize (W, H);
  if (W<>Width) or (H<>Height) then Inherited SetBounds (Left, Top, W, H);
  InitHints;
  ActiveChanged;
end;

(*** TEST
procedure TExtDBNavigator.Loaded;
var
  W, H: Integer;
begin
  Writeln(FFFF,'TExtDBNavigator.Loaded #1');
  inherited Loaded;
  W := Width;
  H := Height;
  AdjustSize (W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  InitHints;
  ActiveChanged;
  Writeln(FFFF,'TExtDBNavigator.Loaded #2');
end;
TEST ***)

{TNavButton}

Destructor TNavButton.Destroy;
begin
  if FRepeatTimer<>nil then FRepeatTimer.Free;
  Inherited Destroy;
end;

Procedure TNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  Inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then begin
    if FRepeatTimer=nil then FRepeatTimer := TTimer.Create(Self);
    FRepeatTimer.OnTimer:=TimerExpired;
    FRepeatTimer.Interval:=InitRepeatPause;
    FRepeatTimer.Enabled:=True;
  end;
end;

Procedure TNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer<>nil then FRepeatTimer.Enabled  := False;
end;

Procedure TNavButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsDown) and MouseCapture then begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

Procedure TNavButton.Paint;
var R: TRect;
begin
  Inherited Paint;
  if (GetFocus=Parent.Handle) and (FIndex=TExtDBNavigator(Parent).FocusedButton) then begin
    R:=Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then OffsetRect(R, 1, 1);
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

{ TNavDataLink }

Constructor TNavDataLink.Create(ANav: TExtDBNavigator);
begin
  Inherited Create;
  FNavigator := ANav;
end;

Destructor TNavDataLink.Destroy;
begin
  FNavigator:=nil;
  Inherited Destroy;
end;

Procedure TNavDataLink.EditingChanged;
begin
  if FNavigator<>nil then FNavigator.EditingChanged;
end;

Procedure TNavDataLink.DataSetChanged;
begin
  if FNavigator<>nil then FNavigator.DataChanged;
end;

Procedure TNavDataLink.ActiveChanged;
begin
  if FNavigator<>nil then FNavigator.ActiveChanged;
end;

end.
