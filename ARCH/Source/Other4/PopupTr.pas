unit PopupTr;

interface
uses classes,Menus,
     EtvPopup;

type TPopupMenuDBTree=class(TPopupMenuEtvDBControls)
  protected
    fDBTreeLineCount:smallint;
    procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
    procedure ExpandBranch(Sender: TObject);
    procedure CollapseBranch(Sender: TObject);
    procedure ExpandFull(Sender: TObject);
    procedure CollapseFull(Sender: TObject);
    procedure RebuildTree(Sender: TObject);
    procedure SyncTree(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
end;
function PopupMenuDBTree:TPopupMenu;

IMPLEMENTATION
uses comctrls,db,
     vg;

constructor TPopupMenuDBTree.Create(AOwner: TComponent);
var i:integer;
begin
  inherited;
  Items.Insert(0,TMenuItem.Create(nil));
  Items[0].Caption:='Открытие текущей ветки до конца';
  Items[0].OnClick:=ExpandBranch;
  Items.Insert(1,TMenuItem.Create(nil));
  Items[1].Caption:='Закрытие текущей ветки';
  Items[1].OnClick:=CollapseBranch;
  Items.Insert(2,TMenuItem.Create(nil));
  Items[2].Caption:='-';
  Items.Insert(3,TMenuItem.Create(nil));
  Items[3].Caption:='Открытие дерева до конца';
  Items[3].OnClick:=ExpandFull;
  Items.Insert(4,TMenuItem.Create(nil));
  Items[4].Caption:='Закрытие дерева';
  Items[4].OnClick:=CollapseFull;
  Items.Insert(5,TMenuItem.Create(nil));
  Items[5].Caption:='-';
  Items.Insert(6,TMenuItem.Create(nil));
  Items[6].Caption:='Перестроить дерево';
  Items[6].OnClick:=RebuildTree;
  Items.Insert(7,TMenuItem.Create(nil));
  Items[7].Caption:='Синхронизация с DataSet''ом (вкл/выкл.)';
  Items[7].OnClick:=SyncTree;
  fDBTreeLineCount:=8;
  for i:=fDBTreeLineCount to Items.Count-1 do Items[i].Visible:=false;
end;

procedure TPopupMenuDBTree.ProcOnPopup(Sender: TObject; LineAdd:smallint);
var i:integer;
begin
  inherited ProcOnPopup(Sender,LineAdd+fDBTreeLineCount);
  for i:=fDBTreeLineCount to Items.Count-1 do Items[i].Enabled:=false;
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    if true then begin
      if Assigned(TvgDBTreeView(PopupComponent).Selected) then begin
        Items[LineAdd].Enabled:=true;
        Items[LineAdd+1].Enabled:=true;
      end;
      Items[LineAdd+3].Enabled:=true;
      Items[LineAdd+4].Enabled:=true;
      Items[LineAdd+6].Enabled:=true;
      Items[LineAdd+7].Enabled:=true;
      Items[LineAdd+7].Checked:=TvgDBTreeView(PopupComponent).SyncDataSet;
    end;
end;

procedure TPopupMenuDBTree.ExpandBranch(Sender: TObject);
var Node: TTreeNode;
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    with TvgDBTreeView(PopupComponent) do
      if Assigned(DataSource) and Assigned(Selected) then begin
        Node:=Selected;
        TvgDBTreeNode(Selected).ExpandSafe(true);
        Selected:=Node;
      end;
end;

procedure TPopupMenuDBTree.CollapseBranch(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    with TvgDBTreeView(PopupComponent) do
      if Assigned(DataSource) and Assigned(Selected) then
        TvgDBTreeNode(Selected).Collapse(true);
end;

procedure TPopupMenuDBTree.ExpandFull(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    with TvgDBTreeView(PopupComponent) do
      if Assigned(DataSource) then begin
        if Not Assigned(Selected) then Selected:=Items[0];
        FullExpandSafe;
        TopItem:=Selected;
      end;
end;

procedure TPopupMenuDBTree.CollapseFull(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    with TvgDBTreeView(PopupComponent) do
      if Assigned(DataSource) then begin
        FullCollapse;
        Selected:=Items[0];
        TopItem:=Selected;
      end;
end;

procedure TPopupMenuDBTree.RebuildTree(Sender: TObject);
var Kod: integer;
    DS:TDataSource;
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) then
    with TvgDBTreeView(PopupComponent) do
      if Assigned(DataSource) then begin
        { Перестроить дерево }
        if not Assigned(Selected) then Selected:=Items.GetFirstNode;
        Kod:=TvgDBTreeNode(Selected).ID;
        DS:=DataSource;
        DataSource:=nil;
        DataSource:=DS;
        GoToNode(Kod);
      end;
end;

procedure TPopupMenuDBTree.SyncTree(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TvgDBTreeView) and
     Assigned(TvgDBTreeView(PopupComponent).DataSource) then
    TvgDBTreeView(PopupComponent).SyncDataSet:=not TvgDBTreeView(PopupComponent).SyncDataSet;
end;

var FPopupMenuDBTree:TPopupMenuDBTree;
function PopupMenuDBTree:TPopupMenu;
begin
  if Not Assigned(fPopupMenuDBTree) then
    fPopupMenuDBTree:=TPopupMenuDBTree.Create(nil);
  Result:=fPopupMenuDBTree;
end;

initialization

finalization
  if Assigned(FPopupMenuDBTree) then fPopupMenuDBTree.Free;
end.


