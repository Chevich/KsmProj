{$I XLib.inc }
unit DSLnkSet;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DsgnWnds, DsgnIntf, Menus, StdCtrls, ExtCtrls,
  LibIntf, DB, LnkSet, Buttons, DSDesign, ComCtrls;

type      

  TLinkSourceEditorForm = class(TDesignWindow)
    LinkMenu: TPopupMenu;
    ToolsPanel: TPanel;
    SelGroup: TRadioGroup;
    NewDeclBtn: TSpeedButton;
    NewLookupBtn: TSpeedButton;
    NewProcessBtn: TSpeedButton;
    RemoveBtn: TSpeedButton;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    Splitter1: TSplitter;
    FieldPanel: TPanel;
    LinkPanel: TPanel;
    AddDeclar1: TMenuItem;
    AddLookup1: TMenuItem;
    AddProcess1: TMenuItem;
    Delete1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    LinkList: TListBox;
    procedure LinkMenuPopup(Sender: TObject);
    procedure LinkListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CopyDataSetClick(Sender: TObject);
    procedure ListViewEnter(Sender: TObject);
    procedure ListViewClick(Sender: TObject);
    procedure SelGroupClick(Sender: TObject);
    procedure NewDeclBtnClick(Sender: TObject);
    procedure NewLookupBtnClick(Sender: TObject);
    procedure NewProcessBtnClick(Sender: TObject);
    procedure RemoveBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LinkListKeyPress(Sender: TObject; var Key: Char);
  private
    fOwnSelection: Boolean;
    fPasteFlag: Boolean;
    FLinkSourceComp: TLinkSource;
    FDataSetEditor: TDataSetEditor;
    FSelectFieldList: TComponentList;
    fSelectList: TComponentList;
    FDSaveTop, FDSaveLeft: Integer;
    procedure NewLinkSet(AItem: TLinkSetItem);
    function GetLinkSetItem: TLinkSetItem;
    function GetLinkSets: TLinkSets;
    procedure SelectComp(Comp: TPersistent);
    procedure SelectFields;
    procedure FieldListEnter(Sender: TObject);
    procedure FieldListClick(Sender: TObject);
    procedure FieldListKeyPress(Sender: TObject; var Key: Char);
    procedure FieldListAdd(Sender: TObject);
    procedure FieldListNew(Sender: TObject);
    procedure FieldListCut(Sender: TObject);
    procedure FieldListPaste(Sender: TObject);
    procedure FieldListDelete(Sender: TObject);
    procedure FieldListSelectAll(Sender: TObject);
    procedure ChangeDataSetEditor(ADataSet: TDataSet);
    function GetDataSet: TDataSet;

    function GetFieldName: string;
    function GetField: TField;
    procedure SetLinkSourceComp(Comp: TLinkSource);
    procedure Initialize;
  protected
    property SelectList: TComponentList read fSelectList;
    procedure SelectOne(Comp: TComponent);
    procedure ClearSelection;
    procedure SelectAdd(Comp: TPersistent{TComponent});
    procedure FinishSelection; virtual;
    procedure ReleaseSelection;
    procedure SelectDataSet(DataSet: TDataSet);
    procedure SelectField(Field: TField);
    function UniqueName(Comp: TComponent): string; override;
    procedure DeleteSelection; virtual;
    procedure CopyToClipboard; virtual;
    procedure PasteFromClipboard; virtual;
    procedure DoSelectAll; virtual;
    procedure CutToClipboard; virtual;
    procedure CopyFromList(CopyList: TComponentList; ListBox: TListBox);
    procedure PasteError(Comp: TPersistent{TComponent});
  public
    destructor Destroy; override;
    procedure Activated; override;
    procedure ComponentDeleted(Comp: IPersistent); override;
    procedure FormClosed(Form: TCustomForm); override;
    procedure FormModified; override;
    procedure SelectionChanged(List: TComponentList); override;
    function GetEditState: TEditState; override;
    procedure EditAction(Action: TEditAction); override;
    procedure UpdateSelection;
    property LinkSourceComp: TLinkSource read FLinkSourceComp write SetLinkSourceComp;
    property OwnSelection: Boolean read fOwnSelection write fOwnSelection;
    property LinkSets: TLinkSets read GetLinkSets;
  end;
  { TLinkSourceEditorForm }

var
  LinkSourceEditorForm: TLinkSourceEditorForm;

implementation

{$R *.DFM}

procedure SelectNone(ListBox: TListBox);
var
  I: Integer;
begin
  with ListBox do
    for I:=0 to Items.Count-1 do
      Selected[I]:=False
end;

procedure SelectAll(ListBox: TListBox);
var
  I: Integer;
begin
  with ListBox do
    for I:=0 to Items.Count-1 do
      Selected[I]:=True
end;

destructor TLinkSourceEditorForm.Destroy;
begin
  ChangeDatasetEditor(nil);
  inherited Destroy;
end;

procedure TLinkSourceEditorForm.Initialize;
var
  i: Integer;
  DataSet: TDataSet;
begin
  LinkList.Clear;
{!  FieldList.Clear;}
  if LinkSourceComp=nil then
  begin
{}
  end else begin
    ClearSelection;
    Caption:='Editing '+LinkSourceComp.Name;
    with LinkSourceComp do begin
      if LinkSets.Count>0 then
        for i:=0 to LinkSets.Count-1 do
          LinkList.Items.AddObject(LinkSets[i].DisplayName, LinkSets[i]);
      if LinkSets.Count>0 then LinkList.ItemIndex:=0;
      ListViewClick(nil);
    end;
  end;
end;

procedure TLinkSourceEditorForm.FormCreate(Sender: TObject);
begin
  FDatasetEditor:=nil;
  FSelectFieldList:=nil;
  Initialize;
end;

procedure TLinkSourceEditorForm.SelectOne(Comp: TComponent);
begin
  ClearSelection;
  if Comp<>nil then SelectAdd(Comp);
  FinishSelection;
end;

procedure TLinkSourceEditorForm.ClearSelection;
begin
  fSelectList:=TComponentList.Create;
end;

procedure TLinkSourceEditorForm.SelectAdd(Comp: TPersistent);
begin
  SelectList.Add(Comp)
end;

procedure TLinkSourceEditorForm.FinishSelection;
begin
  SetSelection(SelectList);
  OwnSelection:=True;
end;

procedure TLinkSourceEditorForm.ReleaseSelection;
begin
  SelectList.Free;
  fSelectList:=nil;
  OwnSelection:=False;
end;

procedure TLinkSourceEditorForm.UpdateSelection;
begin
{!  if FieldList.SelCount > 0 then
    FieldListClick(FieldList)
  else }if LinkList.SelCount > 0 then
    LinkListClick(LinkList)
  else
    SelectOne(LinkSourceComp);
end;

procedure TLinkSourceEditorForm.SetLinkSourceComp(Comp: TLinkSource);
begin
  if FLinkSourceComp<>Comp then begin
    FLinkSourceComp:=Comp;
{
    if Comp <> nil then
       if Comp.Owner is TForm then
       with Comp.Owner as TForm do
       begin
         Self.Caption:=Name + '.' + Comp.Name;
         if Designer <> nil then
           Self.Designer:=Designer as TFormDesigner;
       end;
       }
    Initialize;
  end;
end;

procedure TLinkSourceEditorForm.ComponentDeleted(Comp: IPersistent);
begin
  if ExtractPersistent(Comp)=LinkSourceComp then
  begin
    LinkSourceComp:=nil;
    Release;
  end else
  if not (ExtractPersistent(Comp) is TField) then begin
    if (ExtractPersistent(Comp) is TDataSet) and
    Assigned(FDataSetEditor) and (ExtractPersistent(Comp)=FDataSetEditor.DataSet) then begin
      FDataSetEditor:=nil;
    end;
    inherited;
  end;
end;

procedure TLinkSourceEditorForm.FormClosed(Form: TCustomForm);
begin
  if (LinkSourceComp <> nil) and (Form=LinkSourceComp.Owner) then begin
    Close;
  end;
end;

procedure TLinkSourceEditorForm.FormModified;
var
  I: Integer;
begin
  inherited FormModified;
{!
  with FieldList.Items do
    for I:=0 to Count-1 do
      with Objects[I] as TField do
        if FieldName <> Strings[I] then
          Strings[I]:=FieldName;
}
  with LinkList.Items do
    for I:=0 to Count-1 do
      with Objects[I] as TLinkSetItem do
        if DisplayName <> Strings[I] then
          Strings[I]:=DisplayName;
end;

{New methods}

function ListBoxSelected(List: TListBox): Integer;
var
  I: Integer;
begin
  Result:=-1;
  with List do
    if SelCount=1 then
      for I:=0 to Items.Count-1 do
        if Selected[I] then begin
          Result:=I;
          Exit;
        end;
end;

function TLinkSourceEditorForm.GetLinkSets: TLinkSets;
begin
  Result:=LinkSourceComp.LinkSets;
end;

procedure TLinkSourceEditorForm.SelectComp(Comp: TPersistent);
begin
  FSelectList:=TComponentList.Create;
  if Comp<>nil then FSelectList.Add(Comp);
  SetSelection(FSelectList);
end;

procedure TLinkSourceEditorForm.SelectFields;
var i: Integer;
begin
  with FDataSetEditor.FieldListBox do
    if SelCount >=1 then begin
      FSelectList:=TComponentList.Create;
      for i:=0 to Items.Count-1 do
        if Selected[I] then begin
          FSelectList.Add(FDataSetEditor.DataSet.Fields[i]);
        end;
      SetSelection(FSelectList);
    end;
end;

procedure TLinkSourceEditorForm.FieldListClick(Sender: TObject);
var i: Integer;
    ADataSet: TDataSet;
begin
  FDataSetEditor.AListBoxClick(FDataSetEditor.FieldListBox);
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListEnter(Sender: TObject);
var i: Integer;
    ADataSet: TDataSet;
begin
  i:=ListBoxSelected(FDataSetEditor.FieldListBox);
  if i<>-1 then begin
     SelectFields;
{     ADataSet:=GetDataSet;
     if Assigned(ADataSet) then begin
        SelectComp(ADataSet.Fields[i]);
        end;}
     end else begin
{     FDataSetEditor.SelectTable(FDataSetEditor.DataSet);}
     ADataSet:=GetDataSet;
     if Assigned(ADataSet) then begin
        SelectComp(ADataSet);
        end;
     end;
end;

procedure TLinkSourceEditorForm.FieldListKeyPress(Sender: TObject; var Key: Char);
var
    ADataSet: TDataSet;
begin
  if Integer(Key)=VK_Escape then begin
    ADataSet:=GetDataSet;
    if Assigned(ADataSet) then begin
      SelectComp(ADataSet);
    end;
  end else
  if Integer(Key)=VK_Return then begin
    DelphiIDE.ModalEdit(#0, Self);
    Key:=#0;
    Exit;
  end;
  {FDataSetEditor.FieldListBoxKeyPress(FDataSetEditor.FieldListBox, Key);}
  FDataSetEditor.AListBoxKeyPress(FDataSetEditor.FieldListBox, Key);
end;

procedure TLinkSourceEditorForm.FieldListAdd(Sender: TObject);
begin
  FDataSetEditor.AddItemClick(nil);
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListNew(Sender: TObject);
begin
  FDataSetEditor.NewItemClick(nil);
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListCut(Sender: TObject);
begin
  FDataSetEditor.CutItemClick(nil);
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListPaste(Sender: TObject);
begin
  FDataSetEditor.PasteItemClick(nil);
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListDelete(Sender: TObject);
var i: Integer;
begin
  try
  FDataSetEditor.DeleteItemClick(nil);
  except
  end;
  SelectFields;
end;

procedure TLinkSourceEditorForm.FieldListSelectAll(Sender: TObject);
begin
  FDataSetEditor.SelectAllItemClick(nil);
  SelectFields;
end;

procedure TLinkSourceEditorForm.ChangeDataSetEditor(ADataSet: TDataSet);
var i: Integer;
    Priz: Boolean;
begin
  if Assigned(FDataSetEditor) then begin
    if FDataSetEditor.DataSet=ADataSet then Exit;
    with FDataSetEditor do begin
      Visible:=False;
      Parent:=nil;
      FieldListBox.OnEnter:=nil;
      FieldListBox.OnClick:=AListBoxClick;
      FieldListBox.OnKeyPress:=AListBoxKeyPress;
      AddItem.OnCLick:=AddItemClick;
      NewItem.OnCLick:=NewItemClick;
      CutItem.OnCLick:=CutItemClick;
      PasteItem.OnCLick:=PasteItemClick;
      DeleteItem.OnCLick:=DeleteItemClick;
      SelectAllItem.OnCLick:=SelectAllItemClick;
      BorderStyle:=bsSizeToolWin;
      Align:=alNone;
      Top:=FDSaveTop;
      Left:=FDSaveLeft;
    end;
  end;

  Priz:=False;
  FDataSetEditor:=nil;
  if Assigned(ADataSet) then begin
    for i:=0 to Owner.ComponentCount-1 do
      if Owner.Components[i] is TDataSetEditor and
      (TDataSetEditor(Owner.Components[i]).DataSet=ADataSet) then begin
        FDataSetEditor:=TDatasetEditor(Owner.Components[i]);
        FDataSetEditor.Visible:=False;
        {F.Show;}
        Priz:=True;
        Break;
      end;
    if not Priz then begin
      FDataSetEditor:=TDataSetEditor.Create(Owner);
      try
        FDataSetEditor.Designer:=Designer;
        FDataSetEditor.DataSet:=ADataSet;
      except
        FDataSetEditor.Free;
        FDataSetEditor:=nil;
      raise;
      end;
    end;
  end;
{----------}
  if Assigned(FDataSetEditor) then with FDataSetEditor do begin
    FieldListBox.OnEnter:=FieldListEnter;
    FieldListBox.OnClick:=FieldListClick;
    FieldListBox.OnKeyPress:=FieldListKeyPress;
    AddItem.OnCLick:=FieldListAdd;
    NewItem.OnCLick:=FieldListNew;
    CutItem.OnCLick:=FieldListCut;
    PasteItem.OnCLick:=FieldListPaste;
    DeleteItem.OnCLick:=FieldListDelete;
    SelectAllItem.OnCLick:=FieldListSelectAll;
    BorderStyle:=bsNone;
    Align:=alClient;
    FDSaveTop:=Top;
    FDSaveLeft:=Left;
    Top:=1;
    Left:=1;
    FieldPanel.Width:=Width+2;
    FieldPanel.Height:=Height+2;
    Parent:=FieldPanel;
    Visible:=True;
  end;
end;

procedure TLinkSourceEditorForm.SelectionChanged(List: TComponentList);
var aDataSet: TDataSet;
begin
  if not Assigned(List) then FDataSetEditor:=nil
  else begin
    if (List[0] is TLinkSetItem)and (TLinkSetItem(List[0]).Collection=LinkSets) then begin
      if Assigned(FDataSetEditor) and FDataSetEditor.FieldListBox.Focused then begin
        FieldListEnter(nil)
      end else begin
{!      ADataSet:=TLinkSetItem(List[0]).DataSet;
        ChangeDataSetEditor(ADataSet);}
      end;
    end;
  end;
end;

function TLinkSourceEditorForm.GetEditState: TEditState;
begin
  Result:=[];
  if LinkSourceComp <> nil then begin
    if ClipboardComponents then Include(Result, esCanPaste);
    if LinkList.SelCount > 0 then Result:=Result + [esCanCut, esCanCopy, esCanDelete];
  end;
end;

procedure TLinkSourceEditorForm.DeleteSelection;
begin
{!  if FieldList.SelCount > 0 then
    DeleteField(DeleteFieldItem)
  else
    DeleteDataSet(DeleteDataSetItem);}
end;

procedure TLinkSourceEditorForm.CopyToClipboard;
var
  List: TComponentList;
begin
  List:=TComponentList.Create;
  try
(*!
    CopyFromList(List, FieldList);
    { If no entries are selected, then copy the selected DataSets. }
    if List.Count=0 then
      CopyFromList(List, LinkList);
    CopyComponents(LinkSourceComp.Owner, List);
*)
  finally
    List.Free;
  end;
end;

procedure TLinkSourceEditorForm.CopyFromList(CopyList: TComponentList; ListBox: TListBox);
var
  I: Integer;
begin
  with ListBox do
    for I:=0 to Items.Count-1 do
      if Selected[I] then
        CopyList.Add(Items.Objects[I] as TComponent);
end;

procedure TLinkSourceEditorForm.PasteError(Comp: TPersistent);
var
  Msg: string;
begin
  if not fPasteFlag then begin
    fPasteFlag:=True;
    MessageBeep(Mb_IconExclamation);
    Msg:=Format('You cannot paste a %s component here', [Comp.ClassName]);
    MessageDlg(Msg, mtWarning, [mbOK], 0);
  end;
end;

procedure TLinkSourceEditorForm.PasteFromClipboard;
var
  List: TComponentList;
  I: Integer;
  Index: Integer;
begin
  fPasteFlag:=False;
  List:=TComponentList.Create;
  try
    PasteComponents(LinkSourceComp.Owner, LinkSourceComp, List);
    ClearSelection;
    for I:=0 to List.Count-1 do begin
{
      if List[I] is TDataSet then
        with TDataSet(List[I]) do
        begin
          Parent:=LinkSourceComp;
          LinkList.Items.AddObject(DataSetName, List[I]);
          SelectAdd(List[I]);
        end
      else if (List[I] is TField) and (GetDataSet <> nil) then
        with TField(List[I]) do
        begin
          Parent:=GetDataSet;
          FieldList.Items.AddObject(FieldName, List[I]);
          SelectAdd(List[I]);
        end
      else
      begin
        PasteError(List[I]);
        TComponent(List[I]).Owner.RemoveComponent(TComponent(List[I]));
      end;}
    end;
    { If there are any components successfully pasted, then select them. }
    if SelectList.Count > 0 then begin
      FinishSelection;
      UpdateSelection;
    end else ReleaseSelection;
  finally
    List.Free;
  end;
end;

{ Select all DataSets. }
procedure TLinkSourceEditorForm.DoSelectAll;
begin
  SelectAll(LinkList);
  LinkListClick(LinkList);
end;

{ Cut the current selection to the clipboard. }
procedure TLinkSourceEditorForm.CutToClipboard;
begin
  CopyToClipboard;
  DeleteSelection;
end;

procedure TLinkSourceEditorForm.EditAction(Action: TEditAction);
begin
  case Action of
    eaSelectAll: DoSelectAll;
    eaDelete:    DeleteSelection;
    eaCut:       CutToClipboard;
    eaCopy:      CopyToClipboard;
    eaPaste:     PasteFromClipboard;
  else ;{ ignore }
  end;
end;

procedure TLinkSourceEditorForm.CopyDataSetClick(Sender: TObject);
var
  List: TComponentList;
begin
  List:=TComponentList.Create;
  try
    CopyFromList(List, LinkList);
    CopyComponents(LinkSourceComp.Owner, List);
  finally
    List.Free;
  end;
end;

procedure TLinkSourceEditorForm.Activated;
begin
  if not OwnSelection then UpdateSelection;
  inherited Activated;
end;

function TryName(const Test: string; Comp: TComponent): Boolean;
var
  I: Integer;
begin
  Result:=False;
  for I:=0 to Comp.ComponentCount-1 do
    if CompareText(Comp.Components[I].Name, Test)=0 then
      Exit;
  Result:=True;
end;

function TLinkSourceEditorForm.UniqueName(Comp: TComponent): string;
var
  I: Integer;
  Fmt: string;
begin
  if Comp.ClassName[1] in ['t','T'] then
    Fmt:=Copy(Comp.ClassName, 2, 255) + '%d'
  else Fmt:=Comp.ClassName + '%d';

  if Comp.Owner=nil then begin
    Result:=Format(Fmt, [1]);
    Exit;
  end else begin
    for I:=1 to High(Integer) do begin
      Result:=Format(Fmt, [I]);
      if TryName(Result, Comp.Owner) then Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique name for %s.', [Comp.ClassName]);
end;

function TLinkSourceEditorForm.GetFieldName: string;
var
  Field: TField;
begin
  Field:=GetField;
  if Field=nil then Result:=''
  else Result:=Field.FieldName;
end;

function TLinkSourceEditorForm.GetField: TField;
begin
  Result:=nil;{! GetSelectedObject(FieldList) as TField;}
end;

{ Select DataSet in the DataSet list. If DataSet is nil, then
  select nothing. Update the Field list. }
procedure TLinkSourceEditorForm.SelectDataSet(DataSet: TDataSet);
var
  I: Integer;
begin
{!  FieldList.Clear;}
  if DataSet=nil then SelectNone(LinkList)
  else with LinkList do
    for I:=0 to Items.Count-1 do begin
{!!!
      Selected[I]:=CompareText(Items[I], DataSet.DataSetName)=0;
      if Selected[I] then LoadFieldList(DataSet);
          }
      end;
end;

{ Select the Field in the Field list. If Field is nil, then select nothing. }
procedure TLinkSourceEditorForm.SelectField(Field: TField);
var
  I: Integer;
begin
{!  if Field=nil then
    SelectNone(FieldList)
  else
    with FieldList do
      for I:=0 to Items.Count-1 do
        Selected[I]:=CompareText(Items[I], Field.FieldName)=0;}
end;

procedure TLinkSourceEditorForm.LinkMenuPopup(Sender: TObject);
begin
{  NewDataSetItem.Enabled:=LinkSourceComp <> nil;
  DeleteDataSetItem.Enabled:=LinkList.SelCount > 0;
  RenameDataSetItem.Enabled:=LinkList.SelCount=1;
  CutDataSetItem.Enabled:=LinkList.SelCount > 0;
  CopyDataSetItem.Enabled:=LinkList.SelCount > 0;
  PasteDataSetItem.Enabled:=ClipboardComponents;}
end;

procedure TLinkSourceEditorForm.LinkListClick(Sender: TObject);
var
  I: Integer;
begin
{!  FieldList.Clear;}
  if LinkList.SelCount=0 then SelectOne(LinkSourceComp)
  else if LinkList.SelCount=1 then begin
    SelectOne(GetDataSet);
{!    LoadFieldList(GetDataSet);}
  end else begin
    ClearSelection;
    with LinkList, LinkSourceComp do
      for I:=0 to Items.Count-1 do
{        if Selected[I] then
          SelectAdd(DataSets[Items[I]])};
        FinishSelection;
  end;
end;

procedure TLinkSourceEditorForm.ListViewEnter(Sender: TObject);
begin
  ListViewClick(Sender);
end;

procedure TLinkSourceEditorForm.ListViewClick(Sender: TObject);
var ADataSet: TDataSet;
    AItem: TLinkSetItem;
begin
  if LinkList.ItemIndex<>-1 then begin
    if GetLinkSetItem<>nil then
      ChangeDataSetEditor(GetLinkSetItem.DataSet)
    else
      ChangeDataSetEditor(nil);
    case SelGroup.ItemIndex of
      0: begin
           SelectComp(GetLinkSetItem);
         end;
      1: begin
           ADataSet:=GetDataSet;
           if Assigned(ADataSet) then
             SelectComp(ADataSet)
           else begin
             FDatasetEditor:=nil;
             SelectComp(nil);
           end;
         end;
      2: begin
           AItem:=GetLinkSetItem;
           if Assigned(AItem.Source) then SelectComp(AItem.Source)
           else begin
             FDatasetEditor:=nil;
             SelectComp(nil);
           end;
         end;
    end;
  end else begin
    SelectComp(LinkSourceComp);
  end;
end;

function TLinkSourceEditorForm.GetLinkSetItem: TLinkSetItem;
var i: Integer;
begin
  i:=LinkList.ItemIndex;
  if (i=-1) or (LinkSets.Count=0) then Result:=nil
  else Result:=TLinkSetItem(LinkSets.Items[i]);
end;

function TLinkSourceEditorForm.GetDataSet: TDataSet;
var i: Integer;
begin
  i:=LinkList.ItemIndex;
  if i=-1 then Result:=nil
  else Result:=TLinkSetItem(LinkSets.Items[i]).DataSet;
end;

procedure TLinkSourceEditorForm.SelGroupClick(Sender: TObject);
begin
  LinkList.SetFocus;
  ListViewClick(nil);
end;

procedure TLinkSourceEditorForm.NewLinkSet(AItem: TLinkSetItem);
begin
  LinkList.Items.AddObject(aItem.DisplayName, aItem);
  LinkList.ItemIndex:=LinkList.Items.Count-1;
  Designer.Modified;
end;

procedure TLinkSourceEditorForm.NewDeclBtnClick(Sender: TObject);
begin
  NewLinkSet(LinkSets.AddDeclar(nil));
end;

procedure TLinkSourceEditorForm.NewLookupBtnClick(Sender: TObject);
begin
  NewLinkSet(LinkSets.AddLookup);
end;

procedure TLinkSourceEditorForm.NewProcessBtnClick(Sender: TObject);
begin
  NewLinkSet(LinkSets.AddProcess);
end;

procedure TLinkSourceEditorForm.RemoveBtnClick(Sender: TObject);
var i: Integer;
begin
  if (LinkList.ItemIndex<>-1) then begin
    i:=LinkList.ItemIndex;
    if LinkSets[LinkList.ItemIndex].IsLinkDataSet then begin
      if MessageDlg('Dataset is existed. Delete now?',
        mtInformation, [mbYes, mbNo], 0)=mrYes then begin
        LinkList.Items.Objects[LinkList.ItemIndex].Free;
        LinkList.Items.Delete(LinkList.ItemIndex);
        FDataSetEditor:=nil;
      end;
    end else begin
      LinkList.Items.Objects[LinkList.ItemIndex].Free;
      LinkList.Items.Delete(LinkList.ItemIndex);
    end;
    if i>=LinkList.Items.Count then i:=LinkList.Items.Count-1;
    LinkList.ItemIndex:=i;
    ListViewClick(nil);
  end;
end;

procedure TLinkSourceEditorForm.UpBtnClick(Sender: TObject);
begin
  if (LinkList.ItemIndex>0) then begin
    LinkSets[LinkList.ItemIndex].Index:=LinkList.ItemIndex-1;
    LinkList.Items.Exchange(LinkList.ItemIndex-1,LinkList.ItemIndex);
    LinkList.ItemIndex:=LinkList.ItemIndex-1;
    LinkSets.SetSourceIndexes;
    ListViewClick(nil);
    Designer.Modified;
  end;
end;

procedure TLinkSourceEditorForm.DownBtnClick(Sender: TObject);
begin
  if (LinkList.ItemIndex<LinkList.Items.Count-1) then begin
    LinkSets[LinkList.ItemIndex].Index:=LinkList.ItemIndex+1;
    LinkList.Items.Exchange(LinkList.ItemIndex,LinkList.ItemIndex+1);
    LinkList.ItemIndex:=LinkList.ItemIndex+1;
    LinkSets.SetSourceIndexes;
    ListViewClick(nil);
    Designer.Modified;
  end;
end;

procedure TLinkSourceEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TLinkSourceEditorForm.LinkListKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Integer(Key)=VK_Escape then begin
    ChangeDatasetEditor(nil);
    SelectComp(LinkSourceComp);
  end else
    if Integer(Key)=VK_Return then begin
      DelphiIDE.ModalEdit(#0, Self);
      Key:=#0;
      Exit;
    end;
end;

end.

