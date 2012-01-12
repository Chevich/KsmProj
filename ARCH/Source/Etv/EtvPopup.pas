unit EtvPopup;

interface
uses Classes, Menus, DB;
{$I Etv.inc}

type

TPopupMenuEtvDBControls=class(TPopupMenu)
protected
  fDataSet:TDataSet;
  procedure MouseProcOnPopup(Sender: TObject);
  procedure KeyProcOnPopup(Sender: TObject);
  procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); virtual;
  function GetDataSet(aFromFocused:boolean):TDataSet;
  procedure InsertItem(aIndex:smallint; aCaption:string;
                       aClick:TNotifyEvent; aShortCut:word);
  procedure Insert(Sender: TObject);
  procedure Delete(Sender: TObject);
  procedure Edit(Sender: TObject);
  procedure Post(Sender: TObject);
  procedure Cancel(Sender: TObject);
  procedure Refresh(Sender: TObject);
  procedure Clone(Sender: TObject);
  procedure ClearField(Sender: TObject);
public
  constructor Create(AOwner: TComponent); override;
end;

TPopupMenuEtvDBFieldControls=class(TPopupMenuEtvDBControls)
protected
  fFieldControlsLineCount:smallint;
  procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
  procedure First(Sender: TObject);
  procedure Prior(Sender: TObject);
  procedure Next(Sender: TObject);
  procedure Last(Sender: TObject);
public
  constructor Create(AOwner: TComponent); override;
end;
function PopupMenuEtvDBFieldControls:TPopupMenu;

type
  TPopupMenuEtvDBMemo=class(TPopupMenuEtvDBControls)
  protected
    fMemoLineCount:smallint;
    procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
    procedure CopyToClipboard(Sender: TObject);
    procedure PasteFromClipboard(Sender: TObject);
    procedure SelectAll(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
end;
function PopupMenuEtvDBMemo:TPopupMenu;

type
  TPopupMenuEtvDBImage=class(TPopupMenuEtvDBFieldControls)
  protected
    fCanLoadSave:boolean;
    fDBImageLineCount:smallint;
    procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
    procedure LoadFromFile(Sender: TObject);
    procedure SaveToFile(Sender: TObject);
    procedure Stretch(Sender: TObject);
    procedure CopyToClipboard(Sender: TObject);
    procedure PasteFromClipboard(Sender: TObject);
    procedure Clear(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property CanLoadSave:boolean read fCanLoadSave write fCanLoadSave;
end;
function PopupMenuEtvDBImage:TPopupMenu;

IMPLEMENTATION

uses Windows, SysUtils, Clipbrd, dbctrls, DbGrids, Dialogs, Graphics, TypInfo,
     Forms, Controls, DbConsts, Stdctrls, EtvLook,
     EtvConst,EtvPas,EtvDB,EtvDBFun;

{TPopupMenuEtvDBControls}
constructor TPopupMenuEtvDBControls.Create(AOwner: TComponent);
begin
  inherited;
  Items.OnClick:=KeyProcOnPopup;
  OnPopup:=MouseProcOnPopup;
  InsertItem(0,SNavInsert,Insert,ShortCutIns);
  InsertItem(1,SNavDelete,Delete,ShortCutDel);
  InsertItem(2,SNavEdit,Edit,0);
  InsertItem(3,SNavPost,Post,ShortCutPost);
  InsertItem(4,SNavCancel,Cancel,ShortCutCancel);
  InsertItem(5,SNavRefresh,Refresh,ShortCutRefresh);
  InsertItem(6,SCloneRecord,Clone,ShortCutClone);
  InsertItem(7,SPopupClearField,ClearField,0);
  {$IFNDEF InsDelPopupMenuControls}
  Items[0].Visible:=false;
  Items[1].Visible:=false;
  {$ENDIF}
end;

procedure TPopupMenuEtvDBControls.MouseProcOnPopup(Sender: TObject);
var i:integer;
begin
  for i:=0 to Items.Count-1 do Items[i].Enabled:=false;
  fDataSet:=GetDataSet(false);
  ProcOnPopup(Sender,0);
end;

procedure TPopupMenuEtvDBControls.KeyProcOnPopup(Sender: TObject);
var i:integer;
begin
  for i:=0 to Items.Count-1 do Items[i].Enabled:=false;
  fDataSet:=GetDataSet(true);
  ProcOnPopup(Sender,0);
end;

procedure TPopupMenuEtvDBControls.ProcOnPopup(Sender: TObject; LineAdd:Smallint);
var PropInfo: PPropInfo;
    i:integer;
    lActions:TEtvDataSetActions;
begin
  if Assigned(fDataSet) then begin
    if fDataSet.CanModify then begin
      PropInfo:=GetPropInfo(fDataSet.ClassInfo, 'Actions');
      if PropInfo <> nil then begin
        i:=GetOrdProp(fDataSet,PropInfo);
        Move(i,lActions,Sizeof(TEtvDataSetActions));
        {$IFDEF InsDelPopupMenuControls}
        Items[LineAdd].Enabled:=daInsert in lActions;
        Items[LineAdd+1].Enabled:=(daDelete in lActions) and
          not(fDataSet.BOF and fDataSet.Eof);
        {$ENDIF}
        Items[LineAdd+6].Enabled:=daClone in lActions; {Clone}
      end else begin
        {$IFDEF InsDelPopupMenuControls}
        Items[LineAdd].Enabled:=true;
        Items[LineAdd+1].Enabled:=not(fDataSet.BOF and fDataSet.Eof);
        {$ENDIF}
        Items[LineAdd+6].Enabled:=true; {Clone}
      end;
      Items[LineAdd+2].Enabled:=(fDataSet.State=dsBrowse) and
        not(fDataSet.BOF and fDataSet.Eof); {Edit}
      if fDataSet.State in [dsInsert,dsEdit] then begin {Post,Cancel}
        Items[LineAdd+3].Enabled:=true;
        Items[LineAdd+4].Enabled:=true;
      end;
    end;
    Items[LineAdd+5].Enabled:=true; {refresh}
    Items[LineAdd+7].Enabled:=true;
  end;
end;

type TWinControlSelf=class(TWinControl) end;

function TPopupMenuEtvDBControls.GetDataSet(aFromFocused:boolean):TDataSet;
var PropInfo: PPropInfo;
    DS:TDataSource;
begin
  Result:=nil;
  if aFromFocused then
    if Assigned(Screen) and Assigned(Screen.ActiveControl) and
       (TWinControlSelf(Screen.ActiveControl).PopupMenu=Self) then
      PopupComponent:=Screen.ActiveControl
    else Exit;
  if Assigned(PopupComponent) then begin
    PropInfo:=GetPropInfo(PopupComponent.ClassInfo, 'DataSource');
    if PropInfo <> nil then begin
      DS:=TDataSource(GetOrdProp(PopupComponent,PropInfo));
      if Assigned(DS) and Assigned(DS.DataSet) and DS.DataSet.Active then
        Result:=DS.DataSet;
    end;
  end;
end;

procedure TPopupMenuEtvDBControls.InsertItem(aIndex:smallint; aCaption:string;
            aClick:TNotifyEvent; aShortCut:word);
begin
  Items.Insert(aIndex,TMenuItem.Create(nil));
  Items[aIndex].Caption:=aCaption;
  Items[aIndex].OnClick:=aClick;
  if aShortCut>0 then Items[aIndex].ShortCut:=aShortCut;
end;

procedure TPopupMenuEtvDBControls.Insert(Sender: TObject);
var PropInfo: PPropInfo;
    lInsertNeed:boolean;
    lAction:TOnDataSetActionEvent;
begin
  if Assigned(fDataSet) and fDataSet.CanModify then begin
    lInsertNeed:=true;
    PropInfo:=GetPropInfo(fDataSet.ClassInfo, 'OnAction');
    if PropInfo <> nil then begin
      lAction:=TOnDataSetActionEvent(GetMethodProp(fDataSet,PropInfo));
      if Assigned(lAction) then lAction(Self,fDataSet,daInsert,lInsertNeed);
    end;
    if lInsertNeed then fDataSet.Insert;
  end;
end;

procedure TPopupMenuEtvDBControls.Delete(Sender: TObject);
var PropInfo: PPropInfo;
    lDeleteNeed:boolean;
    lAction:TOnDataSetActionEvent;
    s:string;
begin
  if Assigned(fDataSet) and fDataSet.CanModify then begin
    lDeleteNeed:=true;
    PropInfo:=GetPropInfo(fDataSet.ClassInfo, 'OnAction');
    if PropInfo <> nil then begin
      lAction:=TOnDataSetActionEvent(GetMethodProp(fDataSet,PropInfo));
      if Assigned(lAction) then lAction(Self,fDataSet,daDelete,lDeleteNeed);
    end;
    if lDeleteNeed then begin
      EtvApp.DisableRefreshForm;
      try
        s:=ObjectStrProp(fDataSet,'Caption');
        if s<>'' then s:=s+#10+SDeleteRecordQuestion
        else s:=SDeleteRecordQuestion;
        if MessageDlg(S, mtConfirmation, mbOKCancel, 0) <> idCancel then
        fDataSet.Delete;
      finally
        EtvApp.EnableRefreshForm;
      end;
    end;
  end;
end;

procedure TPopupMenuEtvDBControls.Edit(Sender: TObject);
begin
  if Assigned(fDataSet) and fDataSet.CanModify and (fDataSet.State=dsBrowse) then
    fDataSet.Edit;
end;

procedure TPopupMenuEtvDBControls.Post(Sender: TObject);
begin
  if Assigned(fDataSet) and (fDataSet.State in [dsInsert,dsEdit]) then
    fDataSet.Post;
end;

procedure TPopupMenuEtvDBControls.Cancel(Sender: TObject);
begin
  if Assigned(fDataSet) and (fDataSet.State in [dsInsert,dsEdit]) then
    fDataSet.Cancel;
end;

procedure TPopupMenuEtvDBControls.Refresh(Sender: TObject);
begin
  if Assigned(fDataSet) then DataSetRefresh(fDataSet);
end;

procedure TPopupMenuEtvDBControls.Clone(Sender: TObject);
begin
  if Assigned(fDataSet) then CloneRecord(fDataSet);
end;

procedure TPopupMenuEtvDBControls.ClearField(Sender: TObject);
var aField: TField;
begin
  if Assigned(fDataSet) then begin
    if fDataSet.State=dsBrowse then fDataSet.Edit;
    if Screen.ActiveControl is TDBGrid then
      TDBGrid(Screen.ActiveControl).SelectedField.Clear
    else begin
       aField:=TField(FIsDBControl(Screen.ActiveControl,'DataField'));
       if aField<>nil then aField.Clear;
       if aField is TEtvLookField then with TEtvLookField(aField) do begin
         fDataSet.FieldByName(KeyFields).Clear;
       end;
    end;
  end;
end;

{TPopupMenuEtvDBFieldControls}
constructor TPopupMenuEtvDBFieldControls.Create(AOwner: TComponent);
begin
  inherited;
  InsertItem(0,SNavFirst,First,ShortCutHome);
  InsertItem(1,SNavPrior,Prior,ShortCutPrior);
  InsertItem(2,SNavNext,Next,ShortCutNext);
  InsertItem(3,SNavLast,Last,ShortCutEnd);
  InsertItem(4,'-',nil,0);
  {$IFNDEF NavVisiblePopupMenuControls}
  Items[0].Visible:=false;
  Items[1].Visible:=false;
  Items[2].Visible:=false;
  Items[3].Visible:=false;
  Items[4].Visible:=false;
  {$ENDIF}
  fFieldControlsLineCount:=5;
end;

procedure TPopupMenuEtvDBFieldControls.ProcOnPopup(Sender: TObject; LineAdd:smallint);
begin
  inherited ProcOnPopup(Sender,LineAdd+fFieldControlsLineCount);
  if Assigned(fDataSet) then begin
    if Not fDataSet.BOF then begin
      Items[LineAdd].Enabled:=true;
      Items[LineAdd+1].Enabled:=true;
    end;
    if Not fDataSet.EOF then begin
      Items[LineAdd+2].Enabled:=true;
      Items[LineAdd+3].Enabled:=true;
    end;
  end;
end;

procedure TPopupMenuEtvDBFieldControls.First(Sender: TObject);
begin
  if Assigned(fDataSet) then fDataSet.First;
end;

procedure TPopupMenuEtvDBFieldControls.Prior(Sender: TObject);
begin
  if Assigned(fDataSet) then fDataSet.Prior;
end;

procedure TPopupMenuEtvDBFieldControls.Next(Sender: TObject);
begin
  if Assigned(fDataSet) then fDataSet.Next;
end;

procedure TPopupMenuEtvDBFieldControls.Last(Sender: TObject);
begin
  if Assigned(fDataSet) then fDataSet.Last;
end;

var fPopupMenuEtvDBFieldControls:TPopupMenuEtvDBFieldControls;
function PopupMenuEtvDBFieldControls:TPopupMenu;
begin
  if Not Assigned(fPopupMenuEtvDBFieldControls) then
    fPopupMenuEtvDBFieldControls:=TPopupMenuEtvDBFieldControls.Create(nil);
  Result:=fPopupMenuEtvDBFieldControls;
end;

{TPopupMenuEtvDBMemo}
constructor TPopupMenuEtvDBMemo.Create(AOwner: TComponent);
begin
  inherited;
  InsertItem(0,SPopupCopy,CopyToClipBoard,0);
  InsertItem(1,SPopupPaste,PasteFromClipboard,0);
  InsertItem(2,SPopupSelectAll,SelectAll,0);
  InsertItem(3,'-',nil,0);
  fMemoLineCount:=4;
end;

procedure TPopupMenuEtvDBMemo.ProcOnPopup(Sender: TObject; LineAdd:smallint);
var Field:TField;
begin
  inherited ProcOnPopup(Sender,LineAdd+fMemoLineCount);
  if Assigned(fDataSet) and (PopupComponent is TCustomEdit) then begin
    Items[LineAdd].Enabled:=TCustomEdit(PopupComponent).SelLength>0;
    Field:=fDataSet.FindField(ObjectStrProp(PopupComponent,'DataField'));
    Items[LineAdd+1].Enabled:=Assigned(Field) and Field.CanModify and
      (Clipboard.AsText<>'');
    Items[LineAdd+2].Enabled:=Assigned(Screen) and (Screen.ActiveControl=PopupComponent);
  end;
end;

procedure TPopupMenuEtvDBMemo.CopyToClipboard(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TCustomEdit) then
    TCustomEdit(PopupComponent).CopyToClipboard;
end;

procedure TPopupMenuEtvDBMemo.PasteFromClipboard(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TCustomEdit) then
    TCustomEdit(PopupComponent).PasteFromClipboard;
end;

procedure TPopupMenuEtvDBMemo.SelectAll(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TCustomEdit) and
     Assigned(Screen) and (Screen.ActiveControl=PopupComponent) then
    TCustomEdit(PopupComponent).SelectAll;
end;

var fPopupMenuEtvDBMemo:TPopupMenu;
function PopupMenuEtvDBMemo:TPopupMenu;
begin
  if Not Assigned(fPopupMenuEtvDBMemo) then begin
    fPopupMenuEtvDBMemo:=TPopupMenuEtvDBMemo.Create(nil);
  end;
  Result:=fPopupMenuEtvDBMemo;
end;

{TPopupMenuEtvDBImage}
constructor TPopupMenuEtvDBImage.Create(AOwner: TComponent);
begin
  inherited;
  CanLoadSave:=True;
  Items.Insert(0,TMenuItem.Create(nil));
  Items[0].Caption:=SLoadFromFile;
  Items[0].OnClick:=LoadFromFile;
  Items.Insert(1,TMenuItem.Create(nil));
  Items[1].Caption:=SSaveToFile;
  Items[1].OnClick:=SaveToFile;
  Items.Insert(2,TMenuItem.Create(nil));
  Items[2].Caption:=SPopupStretch;
  Items[2].OnClick:=Stretch;
  Items.Insert(3,TMenuItem.Create(nil));
  Items[3].Caption:=SPopupCopy;
  Items[3].OnClick:=CopyToClipboard;
  Items.Insert(4,TMenuItem.Create(nil));
  Items[4].Caption:=SPopupPaste;
  Items[4].OnClick:=PasteFromClipboard;
  Items.Insert(5,TMenuItem.Create(nil));
  Items[5].Caption:=SPopupClear;
  Items[5].OnClick:=Clear;
  InsertItem(6,'-',nil,0);
  fDBImageLineCount:=7;
end;

procedure TPopupMenuEtvDBImage.ProcOnPopup(Sender: TObject; LineAdd:smallint);
begin
  inherited ProcOnPopup(Sender,LineAdd+fDBImageLineCount);
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) then
    with TDBImage(PopupComponent) do
      if Assigned(Field) and (Field is TBlobField) then begin
        if Field.CanModify then begin
          Items[LineAdd].Enabled:=CanLoadSave;
          Items[LineAdd+4].Enabled:=Clipboard.HasFormat(CF_BITMAP);
          Items[LineAdd+5].Enabled:=Not Field.isNull;
        end;
        Items[LineAdd+1].Enabled:=(Not Field.isNull) and CanLoadSave;
        Items[LineAdd+2].Enabled:=true; {Stretch}
        Items[LineAdd+2].Checked:=Stretch;
        Items[LineAdd+3].Enabled:=Not Field.isNull;
      end;
end;

procedure TPopupMenuEtvDBImage.LoadFromFile(Sender: TObject);
var OpenDialogPic:TOpenDialog;
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) and
     Assigned(TDBImage(PopupComponent).Field) and
     (TDBImage(PopupComponent).Field is TBlobField) and
     TDBImage(PopupComponent).Field.CanModify then begin
     OpenDialogPic:=TOpenDialog.Create(nil);
     try
       OpenDialogPic.DefaultExt := GraphicExtension(TBitmap);
       OpenDialogPic.Filter := GraphicFilter(TBitmap);
       if OpenDialogPic.Execute then with TDBImage(PopupComponent).Field.DataSet do begin
         if not (State in [dsEdit,dsInsert]) then Edit;
         TBlobField(TDBImage(PopupComponent).Field).LoadFromFile(OpenDialogPic.FileName);
       end;
     finally
       OpenDialogPic.Free;
     end;
  end;
end;

procedure TPopupMenuEtvDBImage.SaveToFile(Sender: TObject);
var SaveDialogPic:TSaveDialog;
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) and
     Assigned(TDBImage(PopupComponent).Field) and
     (TDBImage(PopupComponent).Field is TBlobField) and
     (Not TDBImage(PopupComponent).Field.isNull) then begin
     SaveDialogPic:=TSaveDialog.Create(nil);
     try
       SaveDialogPic.DefaultExt := GraphicExtension(TBitmap);
       SaveDialogPic.Filter := GraphicFilter(TBitmap);
       if SaveDialogPic.Execute then begin
         TBlobField(TDBImage(PopupComponent).Field).SaveToFile(SaveDialogPic.FileName);
       end;
     finally
       SaveDialogPic.Free;
     end;
  end;
end;

procedure TPopupMenuEtvDBImage.Stretch(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) then
    TDBImage(PopupComponent).Stretch:=not TDBImage(PopupComponent).Stretch;
end;

procedure TPopupMenuEtvDBImage.CopyToClipboard(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) then
    TDBImage(PopupComponent).CopyToClipboard;
end;

procedure TPopupMenuEtvDBImage.PasteFromClipboard(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) then
    TDBImage(PopupComponent).PasteFromClipboard;
end;

procedure TPopupMenuEtvDBImage.Clear(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBImage) and
     Assigned(TDBImage(PopupComponent).Field) and
     TDBImage(PopupComponent).Field.CanModify then
    with TDBImage(PopupComponent).Field do begin
      if not (DataSet.State in [dsEdit,dsInsert]) then DataSet.Edit;
      Clear;
    end;
end;

var FPopupMenuEtvDBImage:TPopupMenuEtvDBImage;
function PopupMenuEtvDBImage:TPopupMenu;
begin
  if Not Assigned(fPopupMenuEtvDBImage) then
    fPopupMenuEtvDBImage:=TPopupMenuEtvDBImage.Create(nil);
  Result:=fPopupMenuEtvDBImage;
end;

initialization

finalization
  if Assigned(FPopupMenuEtvDBFieldControls) then fPopupMenuEtvDBFieldControls.Free;
  if Assigned(fPopupMenuEtvDBMemo) then fPopupMenuEtvDBMemo.Free;
  if Assigned(fPopupMenuEtvDBImage) then fPopupMenuEtvDBImage.Free;
end.
