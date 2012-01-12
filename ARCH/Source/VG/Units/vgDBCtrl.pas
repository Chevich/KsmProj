{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Data controls                                 }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgDBCtrl;

interface
uses Classes, Messages, Controls, vgTools, StdCtrls, DB, {$IFDEF _D3_} DBCtrls {$ELSE} DBTables {$ENDIF},
  Menus, DBGrids;

type
{ TvgDBMenu }
  TMenuAction = (maInsert, maEdit, maDelete, maFirst, maLast, maRefresh);
  TMenuActions = set of TMenuAction;

  TMenuActionEvent = procedure (Sender: TObject; Action: TMenuAction) of object;

  TvgDBMenu = class(TCustomHook)
  private
    FDataLink: TDataLink;
    FPopupMenu: TPopupMenu;
    FMenuActions: TMenuActions;
    FMenuItems: array [TMenuAction] of TMenuItem;
    FOnMenuActions: TMenuActionEvent;
    FOnPopup: TNotifyEvent;
    FOnUpdateMenuItems: TNotifyEvent;
    function GetCaption(Index: Integer): string;
    procedure SetCaption(Index: Integer; Value: string);
    function IsCaptionStored(Index: Integer): Boolean;
    function GetEnabled(Action: TMenuAction): Boolean;
    procedure SetEnabled(Action: TMenuAction; Value: Boolean);
    function GetShortCut(Index: Integer): TShortCut;
    procedure SetShortCut(Index: Integer; Value: TShortCut);
    function IsShortCutStored(Index: Integer): Boolean;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure SetMenuActions(Value: TMenuActions);
    function GetMenuItem(Index: TMenuAction): TMenuItem;
    procedure MenuItemClick(Sender: TObject);
    procedure MenuPopup(Sender: TObject);
    function GetControl: TControl;
    procedure SetControl(Value: TControl);
  protected
    procedure DataSetChanged; virtual;
    procedure DoClick(Action: TMenuAction); virtual;
    procedure DoPopup; virtual;
    procedure DoUpdateMenuItems; virtual;
    procedure HookObject; override;
    procedure UnHookObject; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click(Action: TMenuAction);
    procedure UpdateMenuItems;
    property MenuItems[Index: TMenuAction]: TMenuItem read GetMenuItem;
    property PopupMenu: TPopupMenu read FPopupMenu;
    property Enabled[Action: TMenuAction]: Boolean read GetEnabled write SetEnabled;
  published
    property CaptionInsert: string index 0 read GetCaption write SetCaption stored IsCaptionStored;
    property CaptionEdit: string index 1 read GetCaption write SetCaption stored IsCaptionStored;
    property CaptionDelete: string index 2 read GetCaption write SetCaption stored IsCaptionStored;
    property CaptionFirst: string index 3 read GetCaption write SetCaption stored IsCaptionStored;
    property CaptionLast: string index 4 read GetCaption write SetCaption stored IsCaptionStored;
    property CaptionRefresh: string index 5 read GetCaption write SetCaption stored IsCaptionStored;
    property Control: TControl read GetControl write SetControl;
    property MenuActions: TMenuActions read FMenuActions write SetMenuActions
      default [maInsert, maEdit, maDelete, maFirst, maLast, maRefresh];
    property ShortCutInsert: TShortCut index 0 read GetShortCut write SetShortCut stored IsShortCutStored;
    property ShortCutEdit: TShortCut index 1 read GetShortCut write SetShortCut stored IsShortCutStored;
    property ShortCutDelete: TShortCut index 2 read GetShortCut write SetShortCut stored IsShortCutStored;
    property ShortCutFirst: TShortCut index 3 read GetShortCut write SetShortCut stored IsShortCutStored;
    property ShortCutLast: TShortCut index 4 read GetShortCut write SetShortCut stored IsShortCutStored;
    property ShortCutRefresh: TShortCut index 5 read GetShortCut write SetShortCut stored IsShortCutStored;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnMenuItemClick: TMenuActionEvent read FOnMenuActions write FOnMenuActions;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
    property OnUpdateMenuItems: TNotifyEvent read FOnUpdateMenuItems write FOnUpdateMenuItems;
  end;

{ TDBRadioButton }
  TDBRadioButton = class(TRadioButton)
  private
    FDataLink: TFieldDataLink;
    FFocused: Boolean;
    FValue: string;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetFocused(Value: Boolean);
    procedure SetReadOnly(AValue: Boolean);
    procedure SetValue(Value: string);
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure Click; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Value: string read FValue write SetValue;
  end;

{ TvgQuickSearch }
  TvgQuickSearch = class(TCustomHook)
  private
    FEnableCopy: Boolean;
    FSearchText: string;
    FOldKeyDown: TKeyEvent;
    FOldKeyPress: TKeyPressEvent;
    FOldMouseDown: TMouseEvent;
    function Locate(NewText: string): Boolean;
    procedure OldKeyDown(var Key: Word; Shift: TShiftState);
    procedure OldKeyPress(var Key: Char);
    procedure OldMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function GetGrid: TCustomDBGrid;
    procedure SetGrid(Value: TCustomDBGrid);
  protected
    function GetDataSet: TDataSet;
    function InBrowseMode: Boolean;
    procedure KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure KeyPress(Sender: TObject; var Key: Char); virtual;
    procedure MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function LocateDataSet(DataSet: TDataSet; const KeyFields: string;
      const KeyValues: Variant; Options: TLocateOptions): Boolean; virtual;
    procedure HookObject; override;
    procedure UnHookObject; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property EnableCopy: Boolean read FEnableCopy write FEnableCopy default True;
    property Grid: TCustomDBGrid read GetGrid write SetGrid;
  end;

implementation
uses Windows, SysUtils, TypInfo, vgDBRes, vgDBUtl;

{ TvgDBMenu }
var
  DefCaptions: array [TMenuAction] of string;

  DefShortCuts: array [TMenuAction] of TShortCut =
    (VK_INSERT, VK_RETURN, VK_DELETE, VK_HOME, VK_END, VK_F5);

type
  TDBMenuDataLink = class(TDataLink)
  private
    FDBMenu: TvgDBMenu;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
  end;

  TControlHack = class(TControl);

procedure TDBMenuDataLink.ActiveChanged;
begin
  if Assigned(FDBMenu) then FDBMenu.DataSetChanged;
end;

procedure TDBMenuDataLink.DataSetChanged;
begin
  if Assigned(FDBMenu) then FDBMenu.DataSetChanged;
end;

{ TvgDBMenu }

var
  CaptionsLoaded: Boolean = False;

constructor TvgDBMenu.Create(AOwner: TComponent);
var
  I: TMenuAction;
begin
  inherited;

  if not CaptionsLoaded then
  begin
    for I := Low(DefCaptions) to High(DefCaptions) do
      DefCaptions[I] := LoadStr(SDBMenuInsert - Integer(I));
    CaptionsLoaded := True;
  end;

  Active := True;
  FDataLink := TDBMenuDataLink.Create;
  TDBMenuDataLink(FDataLink).FDBMenu := Self;
  FPopupMenu := TPopupMenu.Create(nil);
  for I := Low(TMenuAction) to High(TMenuAction) do
  begin
    FMenuItems[I] := NewItem(DefCaptions[I], DefShortCuts[I],  False, False, MenuItemClick, 0, '');
    FMenuItems[I].Tag := Integer(I);
    FPopupMenu.Items.Add(FMenuItems[I]);
  end;
  FPopupMenu.Items.Insert(FMenuItems[maFirst].MenuIndex, NewLine);
  FPopupMenu.Items.Insert(FMenuItems[maRefresh].MenuIndex, NewLine);
  FPopupMenu.OnPopup := MenuPopup;
  FMenuActions := [maInsert, maEdit, maDelete, maFirst, maLast, maRefresh];
end;

destructor TvgDBMenu.Destroy;
begin
  FDataLink.Free;
  while FPopupMenu.Items.Count > 0 do FPopupMenu.Items[0].Free;
  FPopupMenu.Free;
  inherited;
end;

procedure TvgDBMenu.DoClick(Action: TMenuAction);
begin
  case Action of
    maFirst:
      DataSource.DataSet.First;
    maLast:
      DataSource.DataSet.Last;
  else if Assigned(FOnMenuActions) then
    FOnMenuActions(Self, Action);
  end;
end;

procedure TvgDBMenu.Click(Action: TMenuAction);
begin
  MenuItems[Action].Click;
end;

procedure TvgDBMenu.DataSetChanged;
begin
  DoUpdateMenuItems;
end;

procedure TvgDBMenu.DoPopup;
begin
  if Assigned(FOnPopup) then FOnPopup(Self);
end;

procedure TvgDBMenu.DoUpdateMenuItems;
  function NotEmpty: Boolean;
  begin
    Result := not (DataSource.DataSet.BOF and DataSource.DataSet.EOF);
  end;
begin
  FMenuItems[maInsert].Enabled := FDataLink.Active;
  FMenuItems[maEdit].Enabled := FDataLink.Active and NotEmpty;
  FMenuItems[maDelete].Enabled := FMenuItems[maEdit].Enabled;
  FMenuItems[maFirst].Enabled  := FDataLink.Active and not DataSource.DataSet.BOF;
  FMenuItems[maLast].Enabled  := FDataLink.Active and not DataSource.DataSet.EOF;
  FMenuItems[maRefresh].Enabled := FDataLink.Active;
  if not (csDestroying in ComponentState) and Assigned(FOnUpdateMenuItems) then
    FOnUpdateMenuItems(Self);
end;

function TvgDBMenu.GetCaption(Index: Integer): string;
begin
  Result := FMenuItems[TMenuAction(Index)].Caption;
end;

procedure TvgDBMenu.SetCaption(Index: Integer; Value: string);
begin
  FMenuItems[TMenuAction(Index)].Caption := Value;
end;

function TvgDBMenu.IsCaptionStored(Index: Integer): Boolean;
begin
  Result := FMenuItems[TMenuAction(Index)].Caption <> DefCaptions[TMenuAction(Index)];
end;

function TvgDBMenu.GetEnabled(Action: TMenuAction): Boolean;
begin
  Result := FMenuItems[Action].Enabled;
end;

procedure TvgDBMenu.SetEnabled(Action: TMenuAction; Value: Boolean);
begin
  FMenuItems[Action].Enabled := Value;
end;

function TvgDBMenu.GetShortCut(Index: Integer): TShortCut;
begin
  Result := FMenuItems[TMenuAction(Index)].ShortCut;
end;

procedure TvgDBMenu.SetShortCut(Index: Integer; Value: TShortCut);
begin
  FMenuItems[TMenuAction(Index)].ShortCut := Value;
end;

function TvgDBMenu.IsShortCutStored(Index: Integer): Boolean;
begin
  Result := FMenuItems[TMenuAction(Index)].ShortCut <> DefShortCuts[TMenuAction(Index)];
end;

function TvgDBMenu.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TvgDBMenu.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Assigned(Value) then FreeNotification(Value);
end;

procedure TvgDBMenu.SetMenuActions(Value: TMenuActions);
  function IsSeparator(Index: Integer): Boolean;
  var
    I: Integer;
    Item: TMenuItem;
  begin
    Result := True;
    for I := Index to FPopupMenu.Items.Count - 1 do
    begin
      Item := FPopupMenu.Items[I];
      if (Item.Caption <> '-') and Item.Visible then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
  procedure UpdateVisible;
  var
    I, Count: Integer;
    Item: TMenuItem;
  begin
    Count := 0;
    for I := 0 to FPopupMenu.Items.Count - 1 do
    begin
      Item := FPopupMenu.Items[I];
      if (Item.Caption <> '-') then
      begin
        if Item.Visible then Inc(Count);
      end else begin
        Item.Visible := (Count > 0) and not IsSeparator(I + 1);
        Count := 0;
      end;
    end;
  end;
var
  I: TMenuAction;
begin
  if FMenuActions <> Value then
  begin
    for I := Low(TMenuAction) to High(TMenuAction) do
      FMenuItems[I].Visible := I in Value;
    FMenuActions := Value;
    UpdateVisible;
  end;
end;

function TvgDBMenu.GetMenuItem(Index: TMenuAction): TMenuItem;
begin
  Result := FMenuItems[Index];
end;

procedure TvgDBMenu.MenuPopup(Sender: TObject);
begin
  DoPopup;
end;

procedure TvgDBMenu.MenuItemClick(Sender: TObject);
begin
  DoClick(TMenuAction((Sender as TMenuItem).Tag));
end;

procedure TvgDBMenu.Loaded;
begin
  Active := True;
  inherited;
  DoUpdateMenuItems;
end;

procedure TvgDBMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = GetDataSource) then SetDataSource(nil);
end;

function TvgDBMenu.GetControl: TControl;
begin
  Result := TControl(HookedObject);
end;

procedure TvgDBMenu.SetControl(Value: TControl);
begin
  HookedObject := Value;
end;

procedure TvgDBMenu.HookObject;
begin
  if (csDesigning in ComponentState) then Exit;
  TControlHack(GetControl).PopupMenu := FPopupMenu;
end;

procedure TvgDBMenu.UnHookObject;
begin
  if (csDesigning in ComponentState) then Exit;
  TControlHack(GetControl).PopupMenu := nil;
end;

procedure TvgDBMenu.UpdateMenuItems;
begin
  DoUpdateMenuItems;
end;

{ TDBRadioButton }
constructor TDBRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
end;

destructor TDBRadioButton.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TDBRadioButton.Click;
begin
  inherited;
  if FDataLink.Editing then FDataLink.Field.Text := FValue;
end;

procedure TDBRadioButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = GetDataSource) then DataSource := nil;
end;

procedure TDBRadioButton.DataChange(Sender: TObject);
begin
  Checked := (FDataLink.Field <> nil) and (FDataLink.Field.Text = FValue);
end;

procedure TDBRadioButton.EditingChange(Sender: TObject);
begin
end;

function TDBRadioButton.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBRadioButton.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TDBRadioButton.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TDBRadioButton.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TDBRadioButton.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBRadioButton.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Assigned(Value) then FreeNotification(Value);
end;

procedure TDBRadioButton.SetFocused(Value: Boolean);
begin
  FFocused := Value;
end;

procedure TDBRadioButton.SetReadOnly(AValue: Boolean);

  procedure TurnSiblingsReadOnly;
  var
    I: Integer;
    Sibling: TControl;
  begin
    if Parent <> nil then
      with Parent do
        for I := 0 to ControlCount - 1 do
        begin
          Sibling := Controls[I];
          if (Sibling <> Self) and (Sibling is TDBRadioButton) then
            with (Sibling as TDBRadioButton) do ReadOnly := AValue;
        end;
  end;

begin
  if (ReadOnly <> AValue) then
  begin
    FDataLink.ReadOnly := AValue;
    TurnSiblingsReadOnly;
  end;
end;

procedure TDBRadioButton.SetValue(Value: string);
begin
  if (FValue <> Value) then
  begin
    FValue := Value;
    DataChange(nil);
  end;
end;

procedure TDBRadioButton.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TDBRadioButton.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TDBRadioButton.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  SetFocused(False);
  DoExit;
end;

procedure TDBRadioButton.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = BN_CLICKED) then
  begin
    FDataLink.Edit;
    if not FDataLink.Editing then Exit;
  end;
  inherited;
end;

{ TvgQuickSearch }
type
  TDBGridHack = class(TCustomDBGrid);

constructor TvgQuickSearch.Create(AOwner: TComponent);
begin
  inherited;
  Active := True;
  FEnableCopy := True;
end;

destructor TvgQuickSearch.Destroy;
begin
  inherited;
end;

function TvgQuickSearch.GetDataSet: TDataSet;
begin
  if InBrowseMode then
    Result := TDBGridHack(GetGrid).DataSource.DataSet else
    Result := nil;
end;

function TvgQuickSearch.InBrowseMode: Boolean;
begin
  Result := (GetGrid <> nil) and Assigned(TDBGridHack(GetGrid).DataSource) and
    (TDBGridHack(GetGrid).DataSource.State = dsBrowse);
end;

procedure TvgQuickSearch.KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  OldKeyDown(Key, Shift);
  if (Key in [0, VK_PRIOR..VK_DOWN]) then FSearchText := '';

  if FEnableCopy and (Key in [VK_INSERT, 67 {'C'}]) and (ssCtrl in Shift) and InBrowseMode then
  begin
    GridToClipboard(Grid);
    Key := 0;
  end;
end;

procedure TvgQuickSearch.KeyPress(Sender: TObject; var Key: Char);
var
  NewText: string;
begin
  OldKeyPress(Key);
  NewText := FSearchText;
  case Key of
    #8:
      if Length(NewText) > 0 then Delete(NewText, Length(NewText), 1);
    #32..#255:
      begin
        NewText := NewText + Key;
      end;
  end;
  if (NewText <> '') and Locate(NewText) then Key := #0;
end;

procedure TvgQuickSearch.MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  OldMouseDown(Button, Shift, X, Y);
  FSearchText := '';
end;

function TvgQuickSearch.Locate(NewText: string): Boolean;
var
  DataSet: TDataSet;
  Col: Integer;
  Field: TField;
begin
  Result := False;
  if InBrowseMode then
  begin
    DataSet := TDBGridHack(GetGrid).DataSource.DataSet;
    Col := TDBGridHack(GetGrid).Col - Ord(dgIndicator in TDBGridHack(GetGrid).Options);
    if Col < TDBGridHack(GetGrid).Columns.Count then
    begin
      Field := TDBGridHack(GetGrid).Columns[Col].Field;
      if Assigned(Field) and not Field.Calculated and not Field.Lookup then
      begin
        DataSet.DisableControls;
        try
          try
            Result := LocateDataSet(DataSet, Field.FieldName, NewText, [loCaseInsensitive, loPartialKey]);
            if Result then FSearchText := NewText;;
          except end;
        finally
          DataSet.EnableControls;
        end;
      end;
    end;
  end;
end;

function TvgQuickSearch.LocateDataSet(DataSet: TDataSet; const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
  Result := DataSet.Locate(KeyFields, KeyValues, Options);
end;

procedure TvgQuickSearch.OldKeyDown(var Key: Word; Shift: TShiftState);
begin
  if Assigned(FOldKeyDown) then FOldKeyDown(GetGrid, Key, Shift);
end;

procedure TvgQuickSearch.OldKeyPress(var Key: Char);
begin
  if Assigned(FOldKeyPress) then FOldKeyPress(GetGrid, Key);
end;

procedure TvgQuickSearch.OldMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOldMouseDown) then FOldMouseDown(GetGrid, Button, Shift, X, Y);
end;

function TvgQuickSearch.GetGrid: TCustomDBGrid;
begin
  Result := TCustomDBGrid(HookedObject);
end;

procedure TvgQuickSearch.SetGrid(Value: TCustomDBGrid);
begin
  if HookedObject <> Value then
  begin
    if IsObjectHooked(Value) then Exit;
    HookedObject := Value;
  end;
end;

procedure TvgQuickSearch.Loaded;
begin
  Active := True;
  inherited;
end;

procedure TvgQuickSearch.HookObject;
var
  FKeyPress: TKeyPressEvent;
begin
  if (csDesigning in ComponentState) then Exit;
  with TDBGridHack(GetGrid) do
  begin
    FOldKeyDown := OnKeyDown;
    TMethod(FOldKeyPress) := GetMethodProp(GetGrid, GetPropInfo(Grid.ClassInfo, 'OnKeyPress'));
    FOldMouseDown := OnMouseDown;
    OnKeyDown := Self.KeyDown;
    FKeyPress := Self.KeyPress;
    { TrxDBGrid overrides default event and kills the old one }
    SetMethodProp(GetGrid, GetPropInfo(Grid.ClassInfo, 'OnKeyPress'), TMethod(FKeyPress));
    OnMouseDown := Self.MouseDown;
  end;
end;

procedure TvgQuickSearch.UnHookObject;
begin
  if (csDesigning in ComponentState) then Exit;
  with TDBGridHack(GetGrid) do
  begin
    OnKeyDown := FOldKeyDown;
    SetMethodProp(GetGrid, GetPropInfo(Grid.ClassInfo, 'OnKeyPress'), TMethod(FOldKeyPress));
    OnMouseDown := FOldMouseDown;
  end;
end;

end.
