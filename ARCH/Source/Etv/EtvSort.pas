unit EtvSort;

interface
{$I Etv.inc}

uses Messages, Classes, Stdctrls, Controls, db,
     EtvDB;
type

TSortingDataLink=Class(TDataLink)
  fCombo:TCustomComboBox;
  procedure ActiveChanged; override;
  procedure DataSetChanged;override;
  procedure DataSetScrolled(Distance: Integer);override;
end;

TEtvDBSortingCombo=class(TCustomComboBox)
protected
  fSelfList:boolean;
  fSetProcess:smallint;
  fDataLink:TDataLink;
  fItems:TStrings;
  fIndexDefs:TIndexDefs;
  fFieldNameKind:TFieldNameKind;
  procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  procedure Change; override;
  procedure Notification(AComponent: TComponent;
                         Operation: TOperation); override;
  procedure SetParent(AParent: TWinControl); override;
  function GetDataSource: TDataSource;
  procedure SetDataSource(Value: TDataSource);
  procedure SetItems(Value: TStrings);
  procedure SetSelfList(Value: boolean);
  procedure CheckSortingList;
  procedure SetCurrentSorting;
  function StandartList:boolean;
  function ActiveItems:TStrings;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
published
  property DataSource:TDataSource read GetDataSource write SetDataSource;
  property FieldNameKind:TFieldNameKind read fFieldNameKind write fFieldNameKind default fnNoQuotes;
  property SelfList:boolean read fSelfList write SetSelfList;
  property Items:TStrings read fItems write SetItems;

  property Color;
  property Ctl3D;
  property DragMode;
  property DragCursor;
  property DropDownCount;
  property Enabled;
  property Font;
  property ImeMode;
  property ImeName;
  property ItemHeight;

  property ParentColor;
  property ParentCtl3D;
  property ParentFont;
  property ParentShowHint;
  property PopupMenu;
  property ShowHint;
  property TabOrder;
  property TabStop;
  property Visible;
  property OnChange;
  property OnClick;
  property OnDblClick;
  property OnDragDrop;
  property OnDragOver;
  property OnDrawItem;
  property OnDropDown;
  property OnEndDrag;
  property OnEnter;
  property OnExit;
  property OnKeyDown;
  property OnKeyPress;
  property OnKeyUp;
  property OnMeasureItem;
  property OnStartDrag;
end;

IMPLEMENTATION
uses TypInfo, SysUtils,
     {$IFDEF BDE_IS_USED}
     DbTables,
     {$ENDIF}
     Etvpas,EtvDBFun;

{TEtvDBSortingCombo}
procedure TSortingDataLink.ActiveChanged;
begin
  if Assigned(fCombo) then
    TEtvDBSortingCombo(fCombo).CheckSortingList;
end;

procedure TSortingDataLink.DataSetChanged;
begin
  if Assigned(fCombo) then with TEtvDBSortingCombo(fCombo) do
    {$IFDEF BDE_IS_USED}
    if StandartList and (DataSource.DataSet is TTable) then
      SetCurrentSorting
    else
    {$ENDIF}
    CheckSortingList;
end;

procedure TSortingDataLink.DataSetScrolled(Distance: Integer);
begin
end;

procedure TEtvDBSortingCombo.Change;
var NewSorting:string;
begin
  if (fSetProcess=0) and Enabled and fDataLink.Active then
    if ItemIndex>=0 then begin
      if StandartList then begin
        if fIndexDefs[ItemIndex].Fields<>'' then
          NewSorting:=fIndexDefs[ItemIndex].Fields
        else NewSorting:=fIndexDefs[ItemIndex].Name;
      end else NewSorting:=ActiveItems[ItemIndex];
      SortingToDataSet(DataSource.DataSet,NewSorting,true,FieldNameKind=fnQuotes);
    end;
  inherited Change;
end;

procedure TEtvDBSortingCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TEtvDBSortingCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    CheckSortingList;
end;


procedure TEtvDBSortingCombo.SetParent(AParent: TWinControl);
begin
  inherited;
  if Assigned(Parent) then CheckSortingList;
end;

function TEtvDBSortingCombo.GetDataSource: TDataSource;
begin
  if FDataLink <> nil then Result := FDataLink.DataSource
  else Result := nil;
end;

procedure TEtvDBSortingCombo.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource<>Value then begin
    FDataLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TEtvDBSortingCombo.SetItems(Value: TStrings);
begin
  fItems.Assign(Value);
  CheckSortingList;
end;

procedure TEtvDBSortingCombo.SetSelfList(Value: boolean);
begin
  if Value<>fSelfList then begin
    fSelfList:=Value;
    CheckSortingList;
  end;
end;

procedure TEtvDBSortingCombo.CheckSortingList;
var j:integer;
    lItems:TStrings;
begin
  if Assigned(Parent) then try
    inherited Items.BeginUpdate;
    Inc(fSetProcess);
    inherited Items.Clear;
    if fDataLink.Active and Enabled then begin
      if StandartList then begin
        fIndexDefs.Update;
        for j:=0 to fIndexDefs.Count-1 do begin
          if fIndexDefs[j].Fields='' then TCustomComboBox(Self).Items.Add(fIndexDefs[j].Name)
          else
            TCustomComboBox(Self).Items.
              Add(FieldsDisplayName(Self.DataSource.DataSet,fIndexDefs[j].Fields));
        end;
      end else begin
        lItems:=ActiveItems;
        for j:=0 to lItems.Count-1 do
          inherited Items.Add(FieldsDisplayName(DataSource.DataSet,lItems[j]));
      end;
      SetCurrentSorting;
    end;
  finally
    Dec(fSetProcess);
    inherited Items.EndUpdate;
  end;
end;

procedure TEtvDBSortingCombo.SetCurrentSorting;
var i,j:integer;
    CurFields:string;
    lItems:TStrings;
    lIndexName:string;
begin
  i:=-1;
  if StandartList then begin
    lIndexName:=ObjectStrProp(DataSource.DataSet,'IndexName');
    if lIndexName<>'' then i:=fIndexDefs.IndexOf(lIndexName);
    if i<0 then begin
      CurFields:=SortingFromDataSet(DataSource.DataSet);
      for j:=0 to fIndexDefs.Count-1 do
        if AnsiCompareText(fIndexDefs[j].Fields,CurFields)=0 then begin
          i:=j;
          Break;
        end;
    end;
  end else begin
    CurFields:=SortingFromDataSet(DataSource.DataSet);
    lItems:=ActiveItems;
    for j:=0 to lItems.Count-1 do
      if AnsiCompareText(lItems[j],CurFields)=0 then begin
        i:=j;
        break;
      end;
  end;
    {if (i<0) and (CurFields<>'') then begin
        i:=TCustomComboBox(Self).Items.Count;
        TCustomComboBox(Self).Items.Add(CurFields);
      end;}
  if ItemIndex<>i then try
    Inc(fSetProcess);
    ItemIndex:=i;
  finally
    dec(fSetProcess);
  end;
end;

function TEtvDBSortingCombo.StandartList:boolean;
  procedure Check;
    var PropInfo:PPropInfo;
  begin
    PropInfo := GetPropInfo(DataSource.DataSet.ClassInfo, 'IndexDefs');
    if PropInfo <> nil then
      fIndexDefs:=TIndexDefs(GetOrdProp(DataSource.DataSet, PropInfo));
  end;
begin
  Result:=false;
  if Assigned(DataSource.DataSet) and
    (ActiveItems.Count<=0) then begin
    fIndexDefs:=nil;
    {$IFDEF BDE_IS_USED}
    if (DataSource.DataSet is TTable) then
      fIndexDefs:=TTable(DataSource.DataSet).IndexDefs
    else
    {$ENDIF}
    Check;
    if Assigned(fIndexDefs) then Result:=true;
  end;

  {Result:=true;
  if (not (DataSource.DataSet is TTable)) or
     ((ActiveItems.Count>0) and (fSelfList or (fItems.Count=0))) then
    Result:=false;}
end;

function TEtvDBSortingCombo.ActiveItems:TStrings;
var PropInfo:PPropInfo;
    lItems:TStrings;
begin
  Result:=fItems;
  if (not fSelfList) or (Result.Count=0) then begin
    PropInfo := GetPropInfo(DataSource.DataSet.ClassInfo, 'SortingList');
    if PropInfo <> nil then begin
      lItems:=TStrings(GetOrdProp(DataSource.DataSet, PropInfo));
      if lItems.Count>0 then Result:=lItems;
    end;
  end;
end;

constructor TEtvDBSortingCombo.Create(AOwner: TComponent);
begin
  inherited;
  fDataLink :=TSortingDataLink.Create;
  TSortingDataLink(FDataLink).fCombo:=self;
  fSelfList:=false;
  fSetProcess:=0;
  Style:=csDropDownList;
  Width:=180;
  fItems:=TStringList.Create;
end;

Destructor TEtvDBSortingCombo.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  fItems.Free;
  inherited;
end;

end.
 