{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         TItemListEditor                               }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }

unit vgItemEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DsgnIntf, vgTools, Menus, DsgnWnds, {$IFNDEF _D3_}LibMain, {$ENDIF}LibIntf;

type
{$IFDEF _D4_}
  TFormDesigner = IFormDesigner;
{$ENDIF}

  TItemListFormDesigner = class;

  TItemEditorForm = class(TDesignWindow)
    lbItems: TListBox;
    puPopup: TPopupMenu;
    miCut: TMenuItem;
    miCopy: TMenuItem;
    miPaste: TMenuItem;
    miDelete: TMenuItem;
    miSelectAll: TMenuItem;
    miLine2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure miCutClick(Sender: TObject);
    procedure miCopyClick(Sender: TObject);
    procedure miDeleteClick(Sender: TObject);
    procedure miPasteClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure lbItemsClick(Sender: TObject);
    procedure lbItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lbItemsKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FItemList: TItemList;
    FFormDesigner: TFormDesigner;
    FItemListDesigner: TItemListFormDesigner;
    FUpdateCount: Integer;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure ComponentRead(Component: TComponent);
    procedure SetItemList(Value: TItemList);
  protected
    function UniqueName(Component: TComponent): String; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF _D4_}
    procedure ComponentDeleted(AComponent: IPersistent); override;
    {$ELSE}
    procedure ComponentDeleted(AComponent: TComponent); override;
    {$ENDIF}
    procedure FormModified; override;
    procedure FormClosed(Form: {$IFDEF _D3_}TCustomForm{$ELSE}TForm{$ENDIF}); override;
    procedure UpdateItems;
    procedure UpdateSelection;
    property FormDesigner: TFormDesigner read FFormDesigner write FFormDesigner;
    property ItemList: TItemList read FItemList write SetItemList;
  end;

  TItemEditorFormClass = class of TItemEditorForm;

  TItemListFormDesigner = class(TItemListDesigner)
  private
    FForm: TItemEditorForm;
  public
    procedure Event(Item: TItem; Event: Integer); override;
  end;

  TItemListEditor = class(TComponentEditor)
  private
    FForm: TItemEditorForm;
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetFormClass: TItemEditorFormClass; virtual;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation
uses ClipBrd, vgUtils;

{$R *.DFM}

type
  TItemHack = class(TItem);

var
  FForms: TList = nil;

function FindItemListEditorForm(Component: TComponent): TItemEditorForm;
var
  I: Integer;
begin
  for I := 0 to ListCount(FForms) - 1 do
  begin
    Result := FForms[I];
    if Result.ItemList = Component then Exit;
  end;
  Result := nil;
end;

procedure TItemListEditor.ExecuteVerb(Index: Integer);
begin
  FForm := FindItemListEditorForm(Component);

  if not Assigned(FForm) then
    FForm := GetFormClass.Create(Application);

  FForm.FFormDesigner := Self.Designer;
  FForm.ItemList := Component as TItemList;
  FForm.Show;
end;

function TItemListEditor.GetFormClass: TItemEditorFormClass;
begin
  Result := TItemEditorForm;
end;

function TItemListEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Items...';
  end;
end;

function TItemListEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure TItemListFormDesigner.Event(Item: TItem; Event: Integer);
begin
  if (Event = ieItemListChanged) then FForm.FormDesigner.Modified;
  FForm.UpdateItems;
end;

constructor TItemEditorForm.Create(AOwner: TComponent);
begin
  inherited;
  ListAdd(FForms, Self);
end;

destructor TItemEditorForm.Destroy;
begin
  SetItemList(nil);
  ListRemove(FForms, Self);
  inherited;
end;

procedure TItemEditorForm.FormActivate(Sender: TObject);
begin
  UpdateItems;
end;

procedure TItemEditorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetItemList(nil);
  Action := caFree;
end;

procedure TItemEditorForm.SetItemList(Value: TItemList);
begin
  if (FItemList <> Value) then
  begin
    if Assigned(FItemListDesigner) then
    begin
      FItemListDesigner.Free;
      FItemListDesigner := nil;
      FFormDesigner := nil;
    end;

    if Assigned(Value) then
    begin
      FItemListDesigner := TItemListFormDesigner.Create(Value);
      FItemListDesigner.FForm := Self;
      FormModified;
    end;
    FItemList := Value;
    UpdateItems;
  end;
end;

{$IFDEF _D4_}
procedure TItemEditorForm.ComponentDeleted(AComponent: IPersistent);
begin
  if ExtractPersistent(AComponent) = FItemList then
{$ELSE}
procedure TItemEditorForm.ComponentDeleted(AComponent: TComponent);
begin
  if AComponent = FItemList then
{$ENDIF}
  begin
    SetItemList(nil);
    Close;
  end else
    UpdateItems;
end;

procedure TItemEditorForm.FormClosed(Form: {$IFDEF _D3_}TCustomForm{$ELSE}TForm{$ENDIF});
begin
  if Form = FormDesigner.Form then
  begin
    SetItemList(nil);
    Close;
  end;
end;

procedure TItemEditorForm.FormModified;
begin
  if Assigned(ItemList) then
    Caption := Format('%s.%s', [ItemList.Owner.Name, ItemList.Name]);
end;

function TItemEditorForm.UniqueName(Component: TComponent): String;
begin
  Result := vgUtils.UniqueName(Component, Component.Name, ItemList.Owner);
end;

procedure TItemEditorForm.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TItemEditorForm.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) then UpdateItems;
end;

procedure TItemEditorForm.UpdateItems;
var
  I, J, K: Integer;
  List: TList;
begin
  if not Assigned(ItemList) or (FUpdateCount > 0) then Exit;
  J := lbItems.ItemIndex;
  List := nil;
  lbItems.Items.BeginUpdate;
  with lbItems do
  try
    List := TList.Create;
    for I := 0 to Items.Count - 1 do
      if Selected[I] then List.Add(Items.Objects[I]);
    Items.Clear;
    if Assigned(ItemList) then
    begin
      for I := 0 to ItemList.Count - 1 do
        Items.AddObject(TComponent(ItemList.Items[I]).Name, ItemList.Items[I]);
      for I := 0 to List.Count - 1 do
      begin
        K := Items.IndexOfObject(List[I]);
        if K >= 0 then Selected[K] := True;
      end;
      if J >= Items.Count then J := Items.Count - 1;
      ItemIndex := J;
    end;
    UpdateSelection;
  finally
    List.Free;
    Items.EndUpdate;
  end;
end;

procedure TItemEditorForm.UpdateSelection;
var
  List: TComponentList;
  I: Integer;
begin
  if FUpdateCount > 0 then Exit;
  List := TComponentList.Create;
  try
    if Assigned(ItemList) and Active then
      for I := 0 to lbItems.Items.Count - 1 do
        if lbItems.Selected[I] then List.Add(TComponent(lbItems.Items.Objects[I]));

    I := List.Count;
    if (I > 0) and Assigned(ItemList) then FormDesigner.SetSelections(List);

    miCut.Enabled := I > 0;
    miCopy.Enabled := I > 0;
    miDelete.Enabled := I > 0;
  finally
    List.Free;
  end;
end;

procedure TItemEditorForm.miCutClick(Sender: TObject);
begin
  miCopy.Click;
  miDelete.Click;
end;

procedure TItemEditorForm.miCopyClick(Sender: TObject);
var
  I: Integer;
  List: TComponentList;
begin
  List := TComponentList.Create;
  try
    for I := 0 to lbItems.Items.Count - 1 do
      if lbItems.Selected[I] then List.Add(TComponent(lbItems.Items.Objects[I]));

    I := List.Count;
    if I > 0 then CopyComponents(ItemList.Owner, List);
  finally
    List.Free;
  end;
end;

procedure TItemEditorForm.ComponentRead(Component: TComponent);
begin
  FormDesigner.Modified;
end;

procedure TItemEditorForm.miPasteClick(Sender: TObject);
var
  S: TStream;
  R: TReader;
begin
  BeginUpdate;
  try
    S := GetClipboardStream;
    try
      R := TReader.Create(S, 1024);
      try
        R.ReadComponents(ItemList.Owner, ItemList, ComponentRead);
      finally
        R.Free;
      end;
    finally
      S.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TItemEditorForm.miDeleteClick(Sender: TObject);
var
  I, J: Integer;
begin
  J := lbItems.ItemIndex;
  BeginUpdate;
  try
    for I := 0 to lbItems.Items.Count - 1 do
      if lbItems.Selected[I] then lbItems.Items.Objects[I].Free;
  finally
    EndUpdate;
  end;
  lbItems.ItemIndex := J;
end;

procedure TItemEditorForm.miSelectAllClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to lbItems.Items.Count - 1 do
    lbItems.Selected[I] := True;
  UpdateSelection;
end;

procedure TItemEditorForm.lbItemsClick(Sender: TObject);
begin
  UpdateSelection;
end;

procedure TItemEditorForm.lbItemsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source = lbItems) and (lbItems.SelCount > 0);
end;

procedure TItemEditorForm.lbItemsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  I, J: Integer;
  List: TList;
begin
  BeginUpdate;
  try
    J := lbItems.ItemAtPos(Point(X, Y), True);
    if J >= 0 then
    begin
      List := TList.Create;
      try
        for I := 0 to lbItems.Items.Count - 1 do
          if lbItems.Selected[I] then
            List.Add(lbItems.Items.Objects[I]);

        for I := List.Count - 1 downto 0 do
        begin
          TItemHack(List[I]).Index := J;
          FormDesigner.Modified;
        end;
      finally
        List.Free;
      end;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TItemEditorForm.lbItemsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then ActivateInspector(#0);
end;

end.
