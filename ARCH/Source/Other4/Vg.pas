Unit Vg;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     CommCtrl, ComCtrls, DB, DBTables, DBCtrls;

type
  TSetRangeEvent = procedure (Sender: TObject; DataSet: TDataSet; ParentID: String) of object;
  TCancelRangeEvent = procedure (Sender: TObject; DataSet: TDataSet) of object;
  TCreateNodeEvent = procedure (Sender: TObject; Node: TTreeNode; DataSet:TDataSet) of object;
  TNodeEvent = procedure (Sender: TObject; Node: TTreeNode) of object;
  TCompareNodeEvent = procedure (Sender: TObject; Node: TTreeNode;
    NodeID: String; var Equal: Boolean) of object;
  TvgDBTreeDataLink = class;

  TvgDBTreeNode = class (TTreeNode)
  protected
    {FBookmark: TBookmark;}
  public
    ID:variant;
    destructor Destroy; override;
    function GotoBookmark: Boolean;
    procedure ExpandSafe(Recurse: Boolean);
    {property Bookmark: TBookmark read FBookmark write FBookmark;}
  end;

  TvgCustomDBTreeView = class(TCustomTreeView)
  private
    { Private declarations }
    FChanged: Boolean;
    FDataLink: TvgDBTreeDataLink;
    FDataFields: array[0..3] of String;
    FNodes: TList;
    FStreamedDataFields: array[0..3] of String;
    FRootID, FStreamedRootID: String;
    FOnSetRange: TSetRangeEvent;
    FOnCancelRange: TCancelRangeEvent;
    FOnCreateNode: TCreateNodeEvent;
    FOnCompareNode: TCompareNodeEvent;
    FOnDestroyNode: TNodeEvent;
    FOnUpdateNode: TNodeEvent;
    FSyncDataSet:boolean;
    fDataSetState:TDataSetState;
    fOldFieldId:variant;
    fOldFieldParentID:variant;
    fOldFieldText:variant;
    fDeleteFieldID:Variant;
    FDataSetChanged:SmallInt;
    FReadOnly:boolean;
    FGotoNode:boolean;
    FDataSetBeforeDelete: TDataSetNotifyEvent;
    FDataSetAfterDelete: TDataSetNotifyEvent;

    function GetDataSource: TDataSource;
    function GetField(Index: Integer): TField;
    procedure SetDataField(Index: Integer; Value: String);
    procedure SetDataSource(Value: TDataSource);
    procedure SetRootID(Value: String);
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
  protected
    { Protected declarations }
    // BeginChange/EndChange - additional interface to TTreeNodes.BeginUpdate/EndUpdate.
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure BeginChange;
    procedure EndChange;
    procedure Collapse(Node: TTreeNode); override;
    function CreateNode: TTreeNode; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateBranches(Node: TTreeNode; ParentID: String);
    procedure CreateSingleBranches(Node: TTreeNode; ParentID: String);
    procedure CreateRoot;
    procedure DestroyBranches(Node: TTreeNode);
    procedure DestroyNode(Node: TTreeNode);
    procedure DestroyRoot;
    procedure DoSetRange(DataSet: TDataSet; ParentID: String); dynamic;
    procedure DoCancelRange(DataSet: TDataSet); dynamic;
    procedure DoCreateNode(Node: TTreeNode; DataSet: TDataSet); dynamic;
    procedure DoDestroyNode(Node: TTreeNode); dynamic;
    procedure DoUpdateNode(Node: TTreeNode); dynamic;
    function CanExpand(Node: TTreeNode): Boolean; override;
    procedure DoChange(Node: TTreeNode);
    procedure SetSyncDataSet(aSyncDataSet:boolean);
    function CanChange(Node: TTreeNode): Boolean; override;
    procedure Change(Node: TTreeNode); override;
    { properties }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DataFieldID: String index 0 read FDataFields[0] write SetDataField;
    property DataFieldParentID: String index 1 read FDataFields[1] write SetDataField;
    property DataFieldText: String index 2 read FDataFields[2] write SetDataField;
    property DataFieldAmountDown: String index 3 read FDataFields[3] write SetDataField;
    property FieldID: TField index 0 read GetField;
    property FieldParentID: TField index 1 read GetField;
    property FieldText: TField index 2 read GetField;
    property FieldAmountDown: TField index 3 read GetField;
    property RootID: String read FRootId write SetRootID;
    property SyncDataSet:boolean read fSyncDataSet write SetSyncDataSet;
    property ReadOnly:boolean read fReadOnly write fReadOnly;
    property OnSetRange: TSetRangeEvent read FOnSetRange write FOnSetRange;
    property OnCancelRange: TCancelRangeEvent read FOnCancelRange write FOnCancelRange;
    property OnCreateNode: TCreateNodeEvent read FOnCreateNode write FOnCreateNode;
    property OnCompareNode: TCompareNodeEvent read FOnCompareNode write FOnCompareNode;
    property OnDestroyNode: TNodeEvent read FOnDestroyNode write FOnDestroyNode;
    property OnUpdateNode: TNodeEvent read FOnUpdateNode write FOnUpdateNode;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CompareNode(Node: TTreeNode; NodeID: String): Boolean; virtual;
    {function LookupNode(StartNode: TTreeNode; NodeID: String; CreateOnTheFly:Boolean): TTreeNode;}
    function UpdateCursorPos: Boolean;
    procedure UpdateNode(Node: TTreeNode);
    function GotoNode(AValue:variant):boolean;
    function FindNode(AValue:variant):boolean;
    function GetVisibleNode(ID:variant):TvgDBTreeNode;
    procedure EnableDataSetChanged;
    procedure DisableDataSetChanged;
    function EtvCreateNode(Node:TTreeNode;Sort:boolean):TTreeNode;
    function GetLastVisible:TTreeNode;
    procedure NavigatorClick(Sender: TObject; Button: TNavigateBtn);
    procedure DataSetBeforeDelete(DataSet:TDataSet);
    procedure DataSetAfterDelete(DataSet:TDataSet);
    procedure SetDataSetEvent(DataSource:TDataSource; ExChange:boolean);
    procedure FullExpandSafe;
    Function NodeFind(ID:variant):TTreeNode;
  end;
{ TvgCustomDBTreeView }

  TvgDBTreeView = class(TvgCustomDBTreeView)
  public
  { new properties }
    property FieldID;
    property FieldParentID;
    property FieldText;
  { inherited propertied }
    property Items;
  published
  { new properties }
    property DataSource;
    property DataFieldID;
    property DataFieldParentID;
    property DataFieldText;
    property DataFieldAmountDown;
    property RootID;
    property SyncDataSet;
    property OnSetRange;
    property OnCancelRange;
    property OnCreateNode;
    property OnDestroyNode;
    property OnUpdateNode;
  { inherited propertied }
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    property DragMode;
    property HideSelection;
    property Indent;
    {property Items;}
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property SortType;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Images;
    property StateImages;
  end;
{ TvgDBTreeView }

  TvgDBTreeDataLink = class (TDataLink)
  private
    FTreeView: TvgCustomDBTreeView;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure EditingChanged; override;
    procedure UpdateData; override;
  end;

const
  SDupFieldNames = 'ID and ParentID data fields must be different.';
  STTableNeeded  = 'Internal support for TTable descendent only.';
  SUnusableIndex = 'Unsupported internally index.'#13#10+
                   'Internal support only: IndexFieldNames=DataFieldParentID';

{procedure Register;}

Function CustomSortProc(Node1, Node2: TvgDBTreeNode; Data: integer): integer; stdcall;
Function SortProc1(Node1, Node2: TvgDBTreeNode; Data: integer): integer; stdcall;
var DefaultSortProc:TTVCompare;

Implementation
Uses DsgnIntf, EtvDBFun, PopupTr;

(*
procedure Register;
begin
  RegisterComponents('Other', [TvgDBTreeView]);
{
  RegisterPropertyEditor(TypeInfo(String), TvgDBTreeView, 'DataFieldID',
    TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String), TvgDBTreeView, 'DataFieldParentID',
    TDataFieldProperty);
  RegisterPropertyEditor(TypeInfo(String), TvgDBTreeView, 'DataFieldText',
    TDataFieldProperty);
}
end;
*)

Function CustomSortProc(Node1, Node2: TvgDBTreeNode; Data: integer): integer; stdcall;
begin
  Result := Node1.ID-Node2.ID;
end;

{ Сортировка по ширине,длине   }
Function SortProc1(Node1, Node2: TvgDBTreeNode; Data: integer): integer; stdcall;
var Rez1,Rez2:integer;
  function SortResult(S:String):integer;
  var x,y,z:byte;
      S2:string[10];
  begin
    x:=Pos('-',S);
    y:=Pos('-',Copy(S,x+1,30));
    if y>0 then y:=y+x;
    z:=Pos('-',Copy(S,y+1,30));
    if z>0 then z:=z+y;
    if (x=0) or (y=0) or (z=0) then begin
      Result:=0;
      Exit;
    end;
    S2:=Copy(S,x+1,y-x-1);
    if Length(S2)=1 then S2:='0'+S2;
    S2:=Copy(S,y+1,z-y-1)+S2;
    Result:=StrToIntDef(S2,0);
  end;

begin
  Rez1:=SortResult(Node1.Text);
  Rez2:=SortResult(Node2.Text);
  if (Rez1=0) or (Rez2=0) then begin
    Rez1:=Node1.ID;
    Rez2:=Node2.ID;
  end;
  Result:= Rez1-Rez2;
end;

{ TvgDBTreeDataLink }
Procedure TvgDBTreeDataLink.ActiveChanged;
begin
  FTreeView.UpdateNode(nil);
end;

Function DState(D:TDataSet):string;
begin
  case D.State of
    dsBrowse: Result:='Browse';
    dsInsert: Result:='Insert';
    dsEdit: Result:='Edit';
    dsCalcFields: Result:='CalcFields';
    else Result:='Unknown';
  end;
end;

Procedure TvgDBTreeDataLink.EditingChanged;
begin
  if Assigned(DataSet) and (DataSet.State=dsEdit) then begin
    FTreeView.fOldFieldID:=FTreeView.FieldID.value;
    FTreeView.fOldFieldParentID:=FTreeView.FieldParentID.value;
    FTreeView.fOldFieldText:=FTreeView.FieldText.value;
  end;
end;

Procedure TvgDBTreeDataLink.DataSetChanged;
var Node:TTreeNode;
begin
  if (DataSet.state=dsBrowse) and (FTreeView.FDataSetChanged=0) then with FTreeView do begin
    case fDataSetState of
      dsEdit: begin
        if (fOldFieldID<>FieldID.value) or
           (fOldFieldParentID<>FieldParentID.value) or
           (fOldFieldText<>FieldText.value) then begin
          if FSyncDataSet then begin
            FSyncDataSet:=false;
            Items.Delete(Selected);
            FSyncDataSet:=true;
            GotoNode(FieldID.value);
          end else begin
            Node:=GetVisibleNode(fOldFieldID);
            if Node<>nil then begin
              Items.Delete(Node);
              GotoNode(FieldID.Value);
              TvgDBTreeNode(Selected).GotoBookMark;
            end;
          end;
        end;
      end;
      dsInsert: begin
        if fSyncDataSet then GotoNode(FieldID.Value)
        else begin
          Node:=GetVisibleNode(FieldParentID.Value);
          if ((Node<>nil) and Node.Expanded) or
             (FieldParentID.Value=null) then GotoNode(FieldID.Value)
        end;
      end;
      else if FSyncDataSet then GotoNode(FieldID.value);
    end; (* of case *)
  end;
  FTreeView.fDataSetState:=dsBrowse;
end;

Procedure TvgDBTreeDataLink.UpdateData;
begin
  { showMessage('UpdateData'+DState(DataSet));}
  FTreeView.fDataSetState:=DataSet.State;
end;

{ TvgDBTreeNode }
Destructor TvgDBTreeNode.Destroy;
begin
(*
  if Assigned(FBookMark) then FreeMem(FBookmark);
  FBookmark:=nil;
*)  
  Inherited;
end;

Function TvgDBTreeNode.GotoBookmark: Boolean;
var
  Tree: TvgCustomDBTreeView;
begin
  try
    Tree := TvgCustomDBTreeView(Owner.Owner);
    Tree.EnableDataSetChanged;
(*    Tree.FDataLink.DataSet.GotoBookmark(Bookmark);*)
    {if Tree.FDataLink.DataSet.FieldByName(Tree.DataFieldID).Value<>ID then}
       Tree.FDataLink.DataSet.Locate(Tree.DataFieldID,ID,[]);
    Tree.DisableDataSetChanged;
    Result := True;
  except
    Result := False;
  end;
end;

Procedure TvgDBTreeNode.ExpandSafe(Recurse: Boolean);
begin
  ModifyLookDataSetActive(TvgCustomDBTreeView(TreeView).fDataLink.DataSet,false);
  Expand(Recurse);
  ModifyLookDataSetActive(TvgCustomDBTreeView(TreeView).fDataLink.DataSet,true);
end;

{ TvgCustomDBTreeView }
Constructor TvgCustomDBTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly:=true;
  FDataLink := TvgDBTreeDataLink.Create;
  FDataLink.FTreeView := Self;
  FNodes := TList.Create;
  FSyncDataSet:=false;
  FDataSetChanged:=0;
  fDataSetState:=dsBrowse;
  FOldFieldID:=null;
  FDeleteFieldID:=null;
  FGotoNode:=false;
  DefaultSortProc:=@CustomSortProc;
end;

Destructor TvgCustomDBTreeView.Destroy;
begin
  SetDataSource(nil);
  FDataLink.Free;
  FNodes.Free;
  Inherited;
end;

Procedure TvgCustomDBTreeView.DataSetBeforeDelete(DataSet: TDataSet);
begin
  if Assigned(FDataSetBeforeDelete) then FDataSetBeforeDelete(DataSet);
  { Запись с этим полем возможно удалится из БД }
  FDeleteFieldID:=FieldID.Value;
end;

Procedure TvgCustomDBTreeView.DataSetAfterDelete(DataSet: TDataSet);
Var Node:TTreeNode;
begin
  if Assigned(FDataSetAfterDelete) then FDataSetAfterDelete(DataSet);
  { Запись с полем FDeleteFieldID удалилась из БД ==> мы удаляем Nod'у из дерева}
  { если она видна }
  {if not FSyncDataSet then} Node:=GetVisibleNode(FDeleteFieldID);
  if Assigned(Node) then begin
    if FSyncDataSet then Selected:=Node.GetPrevVisible;
    Items.Delete(Node);
  end;
end;

Procedure TvgCustomDBTreeView.KeyDown(var Key: Word; Shift: TShiftState);
var Node:TTreeNode;
begin
  case Key of
    VK_SUBTRACT: if ((not Selected.Expanded) or (Selected.Count=0)) and
     (Selected.Parent<>nil) then  Selected:=Selected.Parent;
    VK_DELETE: if (ssCtrl in Shift) and (not FReadOnly) then begin
      if MessageDlg('Вы желаете удалить запись?',mtConfirmation,
        [mbYes, mbNo], 0) = mrNo then Abort;
      EnableDataSetChanged;
      try
        if not FSyncDataSet then begin
          if Assigned(Selected) then
            if DataSource.DataSet.Locate(FieldID.FieldName,TvgDBTreeNode(Selected).ID,[])
              then TTable(DataSource.DataSet).Delete;
        end else TTable(DataSource.DataSet).Delete;
      finally
        DisableDataSetChanged;
      end;
    end;
  end;
  Inherited;
end;

Procedure TvgCustomDBTreeView.BeginChange;
begin
  if not FChanged then begin
    FChanged := True;
    Items.BeginUpdate;
  end;
end;

Procedure TvgCustomDBTreeView.EndChange;
begin
  if FChanged then begin
    FChanged := False;
    Items.EndUpdate;
  end;
end;

Function TvgCustomDBTreeView.CompareNode(Node: TTreeNode; NodeID: String):Boolean;
begin
  if Assigned(FOnCompareNode) then
    FOnCompareNode(Self, Node, NodeID, Result)
  else Result := TvgDBTreeNode(Node).GotoBookmark and (FieldID.AsString = NodeID);
end;

Function TvgCustomDBTreeView.CreateNode: TTreeNode;
begin
  Result := TvgDBTreeNode.Create(Items);
end;

Procedure TvgCustomDBTreeView.Loaded;
begin
  Inherited;
  try
    RootID := FStreamedRootID;
    FDataFields[0] := FStreamedDataFields[0];
    FDataFields[1] := FStreamedDataFields[1];
    FDataFields[2] := FStreamedDataFields[2];
    FDataFields[3] := FStreamedDataFields[3];
    CreateRoot;
    if not(csDesigning in ComponentState) and not(Assigned(PopupMenu)) then
      PopupMenu:=PopupMenuDBTree;
  except
    if csDesigning in ComponentState then Application.HandleException(Self)
    else raise;
  end;

  if (not(csDesigning in ComponentState)) and Assigned(fDataLink.DataSet) then
    SetDataSetEvent(DataSource,false);
end;

Procedure TvgCustomDBTreeView.SetDataSetEvent(DataSource:TDataSource; ExChange:boolean);
begin
  { Возвращение старых процедур, где жили }
  if ExChange and Assigned(fDataLink.DataSet) then begin
    fDataLink.DataSet.BeforeDelete:=FDataSetBeforeDelete;
    fDataLink.DataSet.AfterDelete:=FDataSetAfterDelete;
  end;
  fDataSetBeforeDelete:=nil;
  fDataSetAfterDelete:=nil;
  { Добавляем свою событийность к FDataLink.DataSet'у }
  if Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
    if Assigned(DataSource.DataSet.BeforeDelete) then
      FDataSetBeforeDelete:=DataSource.DataSet.BeforeDelete;
    DataSource.DataSet.BeforeDelete:=DataSetBeforeDelete;
    if Assigned(DataSource.DataSet.AfterDelete) then
      FDataSetAfterDelete:=DataSource.DataSet.AfterDelete;
    DataSource.DataSet.AfterDelete:=DataSetAfterDelete;
  end;
end;

Procedure TvgCustomDBTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited;
  if (Operation = opRemove) and (AComponent = GetDataSource) then SetDataSource(nil);
end;

Function TvgCustomDBTreeView.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

Function TvgCustomDBTreeView.GetField(Index: Integer): TField;
begin
  Result := nil;
  if FDataLink.Active and (FDataFields[Index]<>'') then
    Result:=DataSource.DataSet.FieldByName(FDataFields[Index]);
end;

Procedure TvgCustomDBTreeView.SetDataField(Index: Integer; Value: String);
begin
  Value := AnsiUpperCase(Value);
  if (csLoading in ComponentState) then FStreamedDataFields[Index]:=Value
  else if (FDataFields[Index] <> Value) then begin
    DestroyRoot;
    FDataFields[Index] := Value;
    CreateRoot;
  end;
end;

Procedure TvgCustomDBTreeView.SetDataSource(Value: TDataSource);
begin
  if (not(csDesigning in ComponentState)) and (not(csLoading in ComponentState)) then
  if Value<>FDataLink.DataSource then SetDataSetEvent(Value,true);
  if (Value=nil) and Assigned(Selected) then Selected:=nil;
  FDataLink.DataSource := Value;
  if Assigned(Value) then FreeNotification(Value);
end;

Procedure TvgCustomDBTreeView.SetRootID(Value: String);
begin
  if (csLoading in ComponentState) then FStreamedRootID:=Value
  else if (FRootID<>Value) then begin
    DestroyRoot;
    FRootID := Value;
    CreateRoot;
  end;
end;

Procedure TvgCustomDBTreeView.Collapse(Node: TTreeNode);
var i: Integer;
begin
  try
    FDataLink.DataSet.DisableControls;
    {for i := Node.Count - 1 downto 0 do
      DestroyBranches(Node.Item[i]);}
    {for i:=Node.Count-1 downto 1 do DestroyNode(Node.Item[i]);}
    for i:=1 to Node.Count-1 do DestroyNode(Node.Item[1]);
    DestroyBranches(Node.Item[0]);
    Node.ImageIndex:=0;
  finally
    EndChange;
    FDataLink.DataSet.EnableControls;
  end;
  Inherited;
end;

Function TvgCustomDBTreeView.CanExpand(Node: TTreeNode):boolean;
var I: integer;
begin
  Result:=Inherited CanExpand(Node);
  if Result and ((Node=nil) or (not Node.Expanded)) then begin
    {Screen.Cursor := crHourglass;}
    Items.BeginUpdate;
    try
      FDataLink.DataSet.DisableControls;
      {if not FGotoNode then ModifyLookDataSetActive(fDataLink.DataSet,false);}
      DestroyBranches(Node);
      if TvgDBTreeNode(Node).GotoBookmark then CreateBranches(Node, FieldID.AsString);
      UpdateNode(Node.Item[0]);
      Node.ImageIndex:=1;
(*
      with TTable(fDataLink.DataSet) do begin
        IndexFieldNames:=DataFieldID+';'+DataFieldParentID;
        for i:= 0 to Node.Count-1 do begin
          Next;
          UpdateNode(Node.Item[i]);
        end;
        IndexFieldNames:=DataFieldParentID+';'+DataFieldID;
      end;
*)
    finally
      if fSyncDataSet and (Node<>nil) then TvgDBTreeNode(Node).GotoBookMark;
      {if not FGotoNode then ModifyLookDataSetActive(fDataLink.DataSet,true);}
      fDataLink.dataSet.EnableControls;
      Items.EndUpdate;
      case SortType of
        stText,
        stBoth : if Assigned(Node) then Node.AlphaSort
                        else Self.AlphaSort;
        stData : if Assigned(Node) then Node.CustomSort(DefaultSortProc,0)
                        else Self.CustomSort(DefaultSortProc,0);
      end;
  {    Screen.Cursor := crDefault;}
    end;
  end;
end;

Procedure TvgCustomDBTreeView.DoChange(Node: TTreeNode);
begin
  if fSyncDataSet and (Node<>nil) then TvgDBTreeNode(Node).GotoBookMark;
end;

Procedure TvgCustomDBTreeView.SetSyncDataSet(aSyncDataSet:boolean);
begin
  if fSyncDataSet<>aSyncDataSet then begin
    fSyncDataSet:=aSyncDataSet;
    if (csLoading in ComponentState) or (csDestroying in ComponentState) then Exit;
(* Состояния компонента
csAncestor
csDesigning
csDestroying
csFixups
csLoading
csReading
csUpdating
csWriting
*)
    if fSyncDataSet then begin
      (* Проверяем индекс *)
      if Focused then
        try
          fDataLink.DataSet.Locate(FieldID.FieldName,TvgDBTreeNode(Selected).Id,[]);
        except end
      else GoToNode(FieldID.value);
    end;
  end;
end;

Function TvgCustomDBTreeView.CanChange(Node: TTreeNode): Boolean;
begin
  Result:=Inherited CanChange(Node);
  if Result then begin
    try
      if Assigned(FDataLink.DataSet) and (FDataLink.DataSet.Active) then FDataLink.DataSet.CheckBrowseMode;
    except
      SysUtils.ShowException(ExceptObject, ExceptAddr);
    end;
    if FDataLink.DataSet.State in [dsInsert,dsEdit,dsInActive] then Result:=false;
  end;
end;

Procedure TvgCustomDBTreeView.Change(Node: TTreeNode);
begin
  DoChange(Node);
  inherited;
end;

Procedure TvgCustomDBTreeView.CreateBranches(Node: TTreeNode; ParentID: String);
var
  I: Integer;
begin
  with FDataLink.DataSet do
  begin
    try
      EnableDataSetChanged;
      DoSetRange(FDataLink.DataSet, ParentID);
      try
        First;
        BeginChange;
        while not EOF do begin
          EtvCreateNode(Node,false);
          Next;
        end;
        (*
        if FChanged and (SortType in [stText, stBoth]) then
          if Assigned(Node) then Node.AlphaSort
          else Self.AlphaSort;
        *)
        (*
        if FChanged then
          case SortType of
            stText,
            stBoth : if Assigned(Node) then Node.AlphaSort
                            else Self.AlphaSort;
            stData : if Assigned(Node) then Node.CustomSort(DefaultSortProc,0)
                            else Self.CustomSort(DefaultSortProc,0);
          end;
        *)
      finally
        DoCancelRange(FDataLink.DataSet);
      end;
      if not Assigned(Node) then
        for i:=Items.Count-1 downto 0 do UpdateNode(Items[i])
    finally
      DisableDataSetChanged;
      Screen.Cursor := crDefault;
    end;
  end;
end;

Procedure TvgCustomDBTreeView.CreateSingleBranches(Node: TTreeNode; ParentID: String);
begin
  with FDataLink.DataSet do
    try
      if TTable(FDataLink.DataSet).FindKey([ParentID]) then
        Items.AddChild(Node, FieldText.AsString);
    finally
    end;
end;

Procedure TvgCustomDBTreeView.CreateRoot;
var Mark:TBookMark;
begin
  if (csLoading in ComponentState) or not (FDataLink.Active) or (FDataFields[0] = '')
  or (FDataFields[1] = '') or (FDataFields[2] = '') then Exit;
  with DataSource.DataSet do begin
    if GetField(0)=GetField(1) then raise EInvalidOp.Create(SDupFieldNames);
    GetField(2);
    EnableDataSetChanged;
    DisableControls;
    Mark:=GetBookMark;
    CreateBranches(nil, FRootID);
    case SortType of
      stText,stBoth : Self.AlphaSort;
      stData        : Self.CustomSort(DefaultSortProc,0);
    end;
    GoToBookMark(Mark);
    FreeBookMark(Mark);
    EnableControls;
    DisableDataSetChanged;
  end;
end;

Procedure TvgCustomDBTreeView.DestroyBranches(Node: TTreeNode);
var i:Integer;
begin
  with Node do
    for i:=Count-1 downto 0 do begin
      BeginChange;
      DestroyNode(Item[I]);
   end;
end;

Procedure TvgCustomDBTreeView.DestroyNode(Node: TTreeNode);
begin
  BeginChange;
  DoDestroyNode(Node);
  DestroyBranches(Node);
  {showmessage(inttostr(Tvgdbtreenode(Node).id));}
  Node.Delete;
end;

Procedure TvgCustomDBTreeView.DestroyRoot;
var Node: TTreeNode;
begin
  while Items.Count>0 do begin
    Node := Items[0];
    DestroyNode(Node);
  end;
end;

Procedure TvgCustomDBTreeView.DoSetRange(DataSet: TDataSet; ParentID: String);
begin
  if Assigned(FOnSetRange) then FOnSetRange(Self, DataSet, ParentID)
  else begin
    if not (DataSet is TTable) then raise EInvalidOp.Create(STTableNeeded);
    with DataSet as TTable do begin
      if AnsiCompareText(IndexFieldNames, DataFieldParentID) <> 0 then
        try
          SortingToDataSet(DataSet, DataFieldParentID, false,false);
        except
          raise EInvalidOp.Create(SUnusableIndex);
        end;
      {KeyFieldCount:=0;}
      SetRangeStart;
      FieldParentID.AsString := ParentID;
      SetRangeEnd;
      FieldParentID.AsString := ParentID;
      ApplyRange;
    end;
  end;
end;

Procedure TvgCustomDBTreeView.DoCancelRange(DataSet: TDataSet);
begin
  if Assigned(FOnCancelRange) then FOnCancelRange(Self, DataSet)
  else begin
    if not (DataSet is TTable) then
      raise EInvalidOp.Create(STTableNeeded);
    with DataSet as TTable do
      CancelRange;
  end;
end;

Procedure TvgCustomDBTreeView.DoCreateNode(Node: TTreeNode; DataSet: TDataSet);
begin
  if Assigned(FOnCreateNode) then FOnCreateNode(Self, Node, DataSet);
end;

Procedure TvgCustomDBTreeView.DoDestroyNode(Node: TTreeNode);
begin
  if Assigned(FOnDestroyNode) then FOnDestroyNode(Self, Node);
end;

Procedure TvgCustomDBTreeView.DoUpdateNode(Node: TTreeNode);
begin
  if Assigned(FOnUpdateNode) then FOnUpdateNode(Self, Node);
end;

{function TvgCustomDBTreeView.LookupNode(StartNode: TTreeNode; NodeID: String;
CreateOnTheFly: Boolean): TTreeNode;
var
  I: Integer;
  Node: TTreeNode;
  SaveExpanded: Boolean;
begin
  Result := nil;
  Items.BeginUpdate;
  try
    if Assigned(StartNode) then
    begin
      if CompareNode(StartNode, NodeID) then
      begin
        Result := StartNode;
        Exit;
      end else begin
        SaveExpanded := StartNode.Expanded;
        if CreateOnTheFly then StartNode.Expanded := True;
        for I := 0 to StartNode.Count - 1 do
        begin
          Result := LookupNode(StartNode.Item[I], NodeID, CreateOnTheFly);
          if Assigned(Result) then Exit;
        end;
        if CreateOnTheFly and not Assigned(Result) then
          StartNode.Expanded := SaveExpanded;
      end;
    end else begin
      for I := Items.Count - 1 downto 0 do
      begin
        Node := Items[I];
        if (Node.Parent = nil) then
          Result := LookupNode(Node, NodeID, CreateOnTheFly);
        if Assigned(Result) then Exit;
      end;
    end;
  finally
    Items.EndUpdate;
  end;
end;
}

Function TvgCustomDBTreeView.UpdateCursorPos: Boolean;
begin
  Result := False;
  if Assigned(Selected) then Result := TvgDBTreeNode(Selected).GotoBookmark;
end;

Procedure TvgCustomDBTreeView.UpdateNode(Node: TTreeNode);
begin
  try
    if Assigned(Node) then begin
      DestroyBranches(Node);
      if TvgDBTreeNode(Node).GotoBookmark then begin
        with FDataLink.DataSet do begin
          if Assigned(FieldAmountDown) then begin
            if FieldAmountDown.Value>0 then Items.AddChild(Node,'');
          end else begin
            CreateSingleBranches(Node,FieldID.AsString)
          end;
        end;
      end;
    end else begin
      DestroyRoot;
      CreateRoot;
    end;
    DoUpdateNode(Node);
  finally
    EndChange;
  end;
end;

Function TvgCustomDBTreeView.EtvCreateNode(Node:TTreeNode;Sort:boolean):TTreeNode;
begin
  Result:= Items.AddChild(Node, FieldText.AsString+': '+FieldID.AsString);
  {TvgDBTreeNode(Result).Bookmark :=FDataLink.DataSet.GetBookMark;}
  TvgDBTreeNode(Result).ID:=FieldId.Value;
  if FDataLink.DataSet.FieldByName(DataFieldAmountDown).AsInteger>0 then
    begin
       TvgDBTreeNode(Result).ImageIndex:=0;
       TvgDBTreeNode(Result).SelectedIndex:=1;
       //Items.AddChildObject(TvgDBTreeNode(Result), '' , nil);
       //Items.AddChild(TvgDBTreeNode(Result),'');
       UpdateNode(TvgDBTreeNode(Result));
    end
  else
    begin
       TvgDBTreeNode(Result).ImageIndex:=2;
       TvgDBTreeNode(Result).SelectedIndex:=3;
    end;
  if Sort then
    case SortType of
      stText,
      stBoth : if Assigned(Result) then Result.AlphaSort else Self.AlphaSort;
      stData : if Assigned(Result) then Result.CustomSort(DefaultSortProc,0)
               else Self.CustomSort(DefaultSortProc,0);
    end;
  DoCreateNode(Result, FDataLink.DataSet);
  DoUpdateNode(Result);
end;

Function TvgCustomDBTreeView.GotoNode(AValue:variant):boolean;
const MaxLevel=20;
var Finds: Variant;
    Level,i: ShortInt;
    j:smallint;
    Node: TTreeNode;
    OldFSyncDataSet:boolean;
    CurMaxLevel:smallint;
    sInfo:string;
    IsInsertNode,
    Exist:boolean;
begin
  Result:=false;
  sInfo:='';
  if Assigned(Selected) and (TVGDBTreeNode(Selected).ID=aValue) then begin
    Result:=true;
    Exit;
  end;
  if not (Assigned(fDataLink.DataSet) and fDataLink.DataSet.Active) then Exit;
  try
    fDataLink.DataSet.DisableControls;
    FGotoNode:=true;
    ModifyLookDataSetActive(fDataLink.DataSet,false);
    OldFSyncDataSet:=fSyncDataSet;
    fSyncDataSet:=false;
    IsInsertNode:=false;

    if not fDataLink.DataSet.Locate(DataFieldID,aValue,[]) then begin
      SInfo:='Запись не найдена';
      Abort;
    end;
    Level:=0;
    CurMaxLevel:=MaxLevel;
    Finds:=VarArrayCreate([0,CurMaxLevel],varVariant);
    Finds[0]:=FieldID.Value;

    while FieldParentID.AsString<>RootID do begin
      if not FDataLink.DataSet.Locate(DataFieldID,FieldParentID.Value,[]) then begin
        SInfo:='Неверная ссылка в дереве.'+
                  #13+'Не найдено значение '+FieldParentID.AsString;
        Abort;
      end;
      for i:=0 to Level do
        if Finds[i]=FieldID.Value then begin
          SInfo:='Найдена петля! Поиск невозможен';
          Abort;
        end;
      if Level=CurMaxLevel then begin
        Inc(CurMaxLevel,MaxLevel);
        VarArrayRedim(Finds,CurMaxLevel);
      end;
      Inc(Level);
      Finds[Level]:=FieldID.Value;
    end;

    Items.BeginUpdate;

    Node:=Selected;
    Exist:=false;
    while (Node<>nil) and (not Exist) do begin
      for i:=Level downto 0 do
        if TvgDBTreeNode(Node).ID=Finds[i] then begin
          Exist:=true;
          Level:=i-1;
          break;
        end;
      if not Exist then Node:=Node.Parent;
    end;
    if Node=nil then begin
      Node:=Items[0];
      exist:=false;
      while Assigned(Node) do begin
       if TvgDBTreeNode(Node).ID=Finds[Level] then begin
          Exist:=true;
          Break;
        end;
        Node:=Node.GetNextSibling;
      end;
      if not Exist then begin
        fDataLink.DataSet.Locate(DataFieldID,Finds[Level],[]);
        Node:=EtvCreateNode(nil,true);
        if Node<>nil then IsInsertNode:=true;
        if Level=0 then CreateSingleBranches(Node,Finds[Level]);
      end;
      Dec(Level);
    end;

    if (Level>=0) and (not Node.Expanded) then Node.Expand(false);

    for i:=Level downto 0 do begin
      Exist:=false;
      for j:=0 to Node.Count-1 do
        if TvgDBTreeNode(Node.item[j]).ID=Finds[i] then begin
          Exist:=true;
          Node:=Node.item[j];
          break;
        end;
      if Not Exist then begin
        fDataLink.DataSet.Locate(DataFieldID,Finds[i],[]);
        Node:=EtvCreateNode(Node,true);
        if Node<>nil then IsInsertNode:=true;
        if not Node.Parent.Expanded then Node.Parent.Expand(false);
        if i=0 then CreateSingleBranches(Node,Finds[i]);
      end;
      if (i>0) and (not Node.Expanded) then Node.Expand(false);
    end;
    Result:=true;
  finally
    Items.EndUpdate;
    if IsInsertNode then
      case SortType of
        stText,
        stBoth : if Assigned(Node) then
                   if Assigned(Node.Parent) then Node.Parent.AlphaSort else Self.AlphaSort;
        stData : if Assigned(Node) then
                   if Assigned(Node.Parent) then Node.Parent.CustomSort(DefaultSortProc,0)
                   else Self.CustomSort(DefaultSortProc,0);
      end;
    if Result then Selected:=Node;
    fSyncDataSet:=OldFSyncDataSet;
    if fSyncDataSet then TvgDBTreeNode(Selected).GotoBookMark;
    FGotoNode:=false;
    EnableDataSetChanged;
    ModifyLookDataSetActive(fDataLink.DataSet,true);
    {TDataSetSelf(FDataLink.DataSet).CalculateFields(FDataLink.DataSet.ActiveBuffer);}
    FDataLink.DataSet.Refresh;
    FDataLink.DataSet.EnableControls;
    DisableDataSetChanged;
    {ModifyLookDataSetActive(fDataLink.DataSet,true);}
    if sInfo<>'' then ShowMessage(SInfo);
  end;
end;

Function TvgCustomDBTreeView.FindNode(AValue:variant):boolean;
begin
  Result:=GotoNode(AValue);
  if Result then SetFocus;
end;

Function TvgCustomDBTreeView.GetVisibleNode(ID:variant):TvgDBTreeNode;
begin
  if Assigned(Selected) and (TvgDBTreeNode(Selected).ID=ID) then begin
    Result:=TvgDBTreeNode(Selected);
    Exit;
  end;
  Result:=TvgDBTreeNode(Items.GetFirstNode);
  while (Result<>nil) and (Result.ID<>ID) do
    Result:=TvgDBTreeNode(Result.GetNextVisible);
end;

Procedure TvgCustomDBTreeView.WMLButtonDown(var Msg: TWMLButtonDown);
var
  Node: TTreeNode;
begin
  // Left click in outspace makes Selected := nil.
  Node := GetNodeAt(Msg.XPos, Msg.YPos);
  Selected := Node;
  Inherited;
end;

Procedure TvgCustomDBTreeView.WMRButtonDown(var Msg: TWMRButtonDown);
var Node: TTreeNode;
begin
  Node := GetNodeAt(Msg.XPos, Msg.YPos);
  if Assigned(Node) then Selected := Node;
  Inherited;
end;

Procedure TvgCustomDBTreeView.DisableDataSetChanged;
begin
  if FDataSetChanged>0 then Dec(FDataSetChanged);
end;

Procedure TvgCustomDBTreeView.EnableDataSetChanged;
begin
  Inc(FDataSetChanged);
end;

Function TvgCustomDBTreeView.GetLastVisible:TTreeNode;
var Node: TTreeNode;
begin
  Node:=Items[Items.Count-1];
  while not Node.IsVisible do Node:=Node.GetPrev;
  Result:=Node;
end;

Procedure TvgCustomDBTreeView.NavigatorClick(Sender: TObject; Button: TNavigateBtn);
var Exist:boolean;
    W:word;
begin
  if fSyncDataSet then begin
    Exist:=true;
    case Button of
      nbFirst : {PostMessage(Handle,WM_KeyDown,VK_Home,0);} Selected:=Items.GetFirstNode;
      {nbRW    : PostMessage(Handle,WM_KeyDown,VK_PRIOR,0); Из расширенного дерева }
      nbPrior : PostMessage(Handle,WM_KeyDown,VK_Up,0);{Node:=Selected.GetPrevVisible;}
      nbNext  : PostMessage(Handle,WM_KeyDown,VK_Down,0); {Node:=Selected.GetNextVisible;}
      {nbFF    : PostMessage(Handle,WM_KeyDown,VK_NEXT,0); Из расширенного дерева }
      nbLast  : {PostMessage(Handle,WM_KeyDown,VK_End,0);} Selected:=GetLastVisible;
      nbDelete: begin
                  W:=VK_DELETE;
                  KeyDown(W,[ssCtrl]);
                end;
      else Exist:=false; (* кнопка не обработана для дерева *)
    end;
    if Exist then Abort;
  end;
end;

Procedure TvgCustomDBTreeView.FullExpandSafe;
begin
  ModifyLookDataSetActive(fDataLink.DataSet,false);
  FullExpand;
  ModifyLookDataSetActive(fDataLink.DataSet,true);
end;

Function TvgCustomDBTreeView.NodeFind(ID:variant):TTreeNode;
begin
  Result := Items.GetFirstNode;
  while Assigned(Result) and (TVGDBTreeNode(Result).ID<>ID) do
    begin
      Result:=Result.GetNextVisible;
    end;
end;

end.
