{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Non-visual components                         }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgTools;

interface
uses Messages, Windows, SysUtils, Classes, vgSystem;

type
{ TItem }
  TItemList = class;

  TItem = class(TComponent)
  private
    FItemList: TItemList;
    function GetIndex: Integer;
    procedure SetIndex(Value: Integer);
    procedure SetItemList(Value: TItemList);
  protected
    procedure ItemEvent(Event: Integer); virtual;
    function GetItemName: String; virtual;
    procedure Notify(Event: Integer; Data: Pointer); virtual;
    procedure SetParentComponent(AParent: TComponent); override;
    property Index: Integer read GetIndex write SetIndex stored False;
    property ItemList: TItemList read FItemList write SetItemList;
  public
    destructor Destroy; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
  end;

{ TItemList }
  TItemListDesigner = class;

  TItemList = class(TItem)
  private
    FDesigner: TItemListDesigner;
    FItems: TList;
    FUpdateCount: Integer;
    function GetCount: Integer;
    function GetInUpdate: Boolean;
    function GetItem(Index: Integer): Pointer;
  protected
    procedure Clear; virtual;
    function FindItem(const AName: String): TItem;
    procedure ItemListEvent(Item: TItem; Event: Integer); virtual;
    procedure GetChildren(Proc: TGetChildProc{$IFDEF _D3_}; Root: TComponent{$ENDIF}); override;
    procedure SetChildOrder(Component: TComponent; Order: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifyChildren(Event: Integer; Data: Pointer);
    procedure InsertItem(Item: TItem); virtual;
    procedure RemoveItem(Item: TItem); virtual;
    procedure SetName(const Value: TComponentName); override;
    procedure Sort(Compare: TListSortCompare); virtual;
    property UpdateCount: Integer read FUpdateCount;
    property InUpdate: Boolean read GetInUpdate;
  public
    destructor Destroy; override;
    procedure DestroyingChildren;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    function HasChildren: Boolean;
    function IndexOf(Item: TItem): Integer;
    property Count: Integer read GetCount;
    property Designer: TItemListDesigner read FDesigner;
    property Items[Index: Integer]: Pointer read GetItem; default;
  end;

{ TItemListDesigner }
  TItemListDesigner = class(TObject)
  private
    FItemList: TItemList;
  public
    constructor Create(AItemList: TItemList);
    destructor Destroy; override;
    procedure Event(Item: TItem; Event: Integer); virtual;
    property ItemList: TItemList read FItemList;
  end;

{ TOwnerList }
  PComponent = ^TComponent;
  TOwnerManager = class;

  TOwnerList = class(TItem)
  private
    FComponent: TComponent;
    FVariable: PComponent;
    FOwners: TList;
    procedure SetComponent(AComponent: TComponent; AVariable: PComponent);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    procedure InsertOwner(AOwner: TComponent);
    procedure RemoveOwner(AOwner: TComponent);
    property Component: TComponent read FComponent;
    property Variable: PComponent read FVariable;
  end;

{ TOwnerManager }
  TOwnerManager = class(TItemList)
  private
    function GetItem(Index: Integer): TOwnerList;
  public
    function FindOwnerList(Variable: PComponent): TOwnerList;
    function IndexOfVariable(Variable: PComponent): Integer;
    procedure InsertOwner(Variable: PComponent; ComponentClass: TComponentClass; AOwner: TComponent);
    procedure RemoveOwner(Variable: PComponent; AOwner: TComponent);
    property Items[Index: Integer]: TOwnerList read GetItem;
  end;


{ TCustomHook }
  TCustomHook = class;
  TCustomHookClass = class of TCustomHook;

  TCustomHook = class(TComponent)
  private
    FHookedObject, FStreamedHookedObject: TComponent;
    FActive, FStreamedActive: Boolean;
    procedure SetActive(Value: Boolean);
    procedure InternalHook;
    procedure InternalUnHook;
  protected
    procedure HookObject; virtual;
    procedure UnHookObject; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function FindHook(Value: TComponent; HookClass: TCustomHookClass): TCustomHook;
    procedure SetHookedObject(Value: TComponent); virtual;
    class function GetHookList: TList;
    function IsObjectHooked(Value: TComponent): Boolean;
    property HookedObject: TComponent read FHookedObject write SetHookedObject;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Hook;
    procedure UnHook;
    property Active: Boolean read FActive write SetActive;
  end;

{ TvgThread }
  TvgThread = class(TComponent)
  private
    FThread: TThreadEx;
    FSyncMethod: TNotifyEvent;
    FSyncParams: Pointer;
    FStreamedSuspended: Boolean;
    FOnExecute: TNotifyEvent;
    procedure InternalSynchronize;
    function GetHandle: THandle;
    function GetOnTerminate: TNotifyEvent;
    procedure SetOnTerminate(Value: TNotifyEvent);
    function GetPriority: TThreadPriority;
    procedure SetPriority(Value: TThreadPriority);
    function GetReturnValue: Integer;
    procedure SetReturnValue(Value: Integer);
    function GetSuspended: Boolean;
    procedure SetSuspended(Value: Boolean);
  protected
    procedure DoExecute(Sender: TObject); virtual;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    procedure Synchronize(Method: TThreadMethod);
    procedure SynchronizeEx(Method: TNotifyEvent; Params: Pointer);
    procedure Suspend;
    procedure Resume;
    procedure Terminate(Hard: Boolean);
    function WaitFor: Integer;
    property ReturnValue: Integer read GetReturnValue write SetReturnValue;
    property Handle: THandle read GetHandle;
  published
    property OnTerminate: TNotifyEvent read GetOnTerminate write SetOnTerminate;
    property Priority: TThreadPriority read GetPriority write SetPriority;
    property Suspended: Boolean read GetSuspended write SetSuspended default True;
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
  end;

{ TBroadcaster }
  TBroadcastEvent = procedure (Sender: TObject; var Msg: TMessage;
    Item, Data: TObject; var Handled: Boolean) of object;

  TBroadcaster = class(TComponent)
  private
    FItems: TList;
    FDatas: TList;
    FOnBroadcast: TBroadcastEvent;
    function GetCount: Integer;
    function GetData(Index: Integer): TObject;
    function GetItem(Index: Integer): TObject;
  protected
    { Protected declarations }
    function BroadcastMessage(var Msg: TMessage; Item, Data: TObject): Boolean; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Broadcast(Msg: Cardinal; WParam, LParam: Longint): Longint; virtual;
    function IndexOf(AObject: TObject): Integer;
    procedure InsertObject(AObject, AData: TObject);
    procedure RemoveObject(AObject: TObject);
    property Count: Integer read GetCount;
    property Data[Index: Integer]: TObject read GetData;
    property Item[Index: Integer]: TObject read GetItem;
  published
    { Published declarations }
    property OnBroadcast: TBroadcastEvent read FOnBroadcast write FOnBroadcast;
  end;

{ TClassItem }
  TClassItem = class
  private
    FClassType: TClass;
    FData: Pointer;
    FInfo: String;
  public
    constructor Create(AClassType: TClass; AData: Pointer; AInfo: String);
    property GetClassType: TClass read FClassType;
    property Data: Pointer read FData;
    property Info: String read FInfo;
  end;

{ TClassList }
  TClassName = type ShortString;

  TClassList = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TClassItem;
  protected
    function InternalRegister(AClass: TClass; const AData: Pointer; const AInfo: String; Inheritance: Boolean): TClassItem; virtual;
    procedure InternalUnRegister(AClass: TClass; Index: Integer); virtual;
  public
    destructor Destroy; override;
    function ClassItemByName(const AClassName: TClassName): TClassItem;
    function FindClassItem(const AClassName: TClassName): TClassItem;
    function IndexOf(const AClassName: TClassName): Integer;
    function IndexOfClass(AClass: TClass; Inheritance: Boolean): Integer;
    procedure RegisterClass(AClass: TClass; const AData: Pointer; const AInfo: String; Inheritance: Boolean);
    procedure UnregisterClass(AClass: TClass);
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TClassItem read GetItem; default;
  end;

function NameDelimiter(C: Char): Boolean;
function IsLiteral(C: Char): Boolean;

const
  { Item events }
  ieItemChanged              =  0;
  ieItemListChanged          = -1;
  ieItemListLast             = ieItemListChanged;

implementation
uses Consts, vgVCLRes, vgUtils, Forms;

type
  TvgParamEvents = (peChanged);

{ Parse SQL utility routines }

function NameDelimiter(C: Char): Boolean;
begin
  Result := C in [' ', ',', ';', ')', #13, #10];
end;

function IsLiteral(C: Char): Boolean;
begin
  Result := C in ['''', '"'];
end;

var
  HookList: TList = nil;

{ TItem }

destructor TItem.Destroy;
begin
  SetItemList(nil);
  inherited;
end;

function TItem.GetIndex: Integer;
begin
  if Assigned(FItemList) then
    Result := FItemList.IndexOf(Self) else
    Result := -1;
end;

procedure TItem.ItemEvent(Event: Integer);
begin
  if Assigned(FItemList) then FItemList.ItemListEvent(Self, Event);
end;

function TItem.GetItemName: String;
begin
  Result := '';
end;

function TItem.GetParentComponent: TComponent;
begin
  Result := ItemList;
end;

function TItem.HasParent: Boolean;
begin
  Result := Assigned(FItemList);
end;

procedure TItem.Notify(Event: Integer; Data: Pointer);
begin
end;

procedure TItem.SetIndex(Value: Integer);
var
  CurIndex, Count: Integer;
begin
  CurIndex := GetIndex;
  if CurIndex >= 0 then
  begin
    Count := FItemList.FItems.Count;
    if Value < 0 then Value := 0;
    if Value >= Count then Value := Count - 1;
    if Value <> CurIndex then
    begin
      FItemList.FItems.Delete(CurIndex);
      FItemList.FItems.Insert(Value, Self);
      ItemEvent(ieItemListChanged);
    end;
  end;
end;

procedure TItem.SetItemList(Value: TItemList);
begin
  if (FItemList <> Value) then
  begin
    if Assigned(FItemList) then FItemList.RemoveItem(Self);
    if Assigned(Value) then Value.InsertItem(Self);
  end;
end;

procedure TItem.SetParentComponent(AParent: TComponent);
begin
  if (AParent is TItemList) then ItemList := AParent as TItemList;
end;

{ TItemList }
destructor TItemList.Destroy;
begin
  Clear;
  inherited;
end;

procedure TItemList.DestroyingChildren;
var
  I: Integer;
  Item: TItem;
begin
  Destroying;
  for I := 0 to Count - 1 do
  begin
    Item := Items[I];
    if Item is TItemList then
      TItemList(Item).DestroyingChildren;
  end;
end;

function TItemList.GetCount: Integer;
begin
  Result := ListCount(FItems);
end;

function TItemList.GetInUpdate: Boolean;
begin
  Result := FUpdateCount > 0;
end;

function TItemList.GetItem(Index: Integer): Pointer;
begin
  Result := ListItem(FItems, Index);
end;

procedure TItemList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TItemList.EndUpdate;
begin
  Dec(FUpdateCount);
end;

function TItemList.FindItem(const AName: String): TItem;
var
  I: Integer;
begin
  if Assigned(FItems) then
    for I := 0 to FItems.Count - 1 do
    begin
      Result := FItems[I];
      if AnsiCompareText(Result.GetItemName, AName) = 0 then Exit;
    end;
  Result := nil;
end;

procedure TItemList.Clear;
begin
  while (ListCount(FItems) > 0) do TObject(FItems.Last).Free;
end;

procedure TItemList.ItemListEvent(Item: TItem; Event: Integer);
begin
  if Assigned(FDesigner) then FDesigner.Event(Item, Event);
end;

procedure TItemList.GetChildren(Proc: TGetChildProc{$IFDEF _D3_}; Root: TComponent{$ENDIF});
var
  I: Integer;
  Item: TItem;
begin
  for I := 0 to ListCount(FItems) - 1 do
  begin
    Item := FItems[I];
    Proc(Item);
  end;
end;

procedure TItemList.SetChildOrder(Component: TComponent; Order: Integer);
begin
  if ListIndexOf(FItems, Component) >= 0 then (Component as TItem).Index := Order;
end;

procedure TItemList.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    I := ListIndexOf(FItems, AComponent);
    if I >= 0 then RemoveItem(AComponent as TItem);
  end;
end;

procedure TItemList.NotifyChildren(Event: Integer; Data: Pointer);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    TItem(Items[I]).Notify(Event, Data);
end;

function TItemList.HasChildren: Boolean;
begin
  Result := Assigned(FItems);
end;

function TItemList.IndexOf(Item: TItem): Integer;
begin
  Result := ListIndexOf(FItems, Item);
end;

procedure TItemList.InsertItem(Item: TItem);
begin
  if ListIndexOf(FItems, Item) < 0 then
  begin
    FreeNotification(Item);
    ListAdd(FItems, Item);
    Item.FItemList := Self;
    ItemListEvent(Item, ieItemListChanged);
  end;
end;

procedure TItemList.RemoveItem(Item: TItem);
begin
  if ListIndexOf(FItems, Item) >= 0 then
  begin
    ListRemove(FItems, Item);
    Item.FItemList := nil;
    ItemListEvent(Item, ieItemListChanged);
  end;
end;

procedure TItemList.SetName(const Value: TComponentName);
var
  I: Integer;
  OldName, ItemName, NamePrefix: TComponentName;
  Item: TItem;
begin
  OldName := Name;
  inherited SetName(Value);
  if (csDesigning in ComponentState) and (Name <> OldName) then
    { In design mode the name of the items should track the item list name }
    for I := 0 to ListCount(FItems) - 1 do
    begin
      Item := FItems[I];
      if Item.Owner = Owner then
      begin
        ItemName := Item.Name;
        NamePrefix := ItemName;
        if Length(NamePrefix) > Length(OldName) then
        begin
          SetLength(NamePrefix, Length(OldName));
          if CompareText(OldName, NamePrefix) = 0 then
          begin
            System.Delete(ItemName, 1, Length(OldName));
            System.Insert(Value, ItemName, 1);
            try
              Item.Name := ItemName;
            except
              on EComponentError do {Ignore rename errors };
            end;
          end;
        end;
      end;
    end;
end;

procedure TItemList.Sort(Compare: TListSortCompare);
begin
  ListSort(FItems, Compare);
end;

{ TItemListDesigner }
constructor TItemListDesigner.Create(AItemList: TItemList);
begin
  FItemList := AItemList;
  FItemList.FDesigner := Self;
end;

destructor TItemListDesigner.Destroy;
begin
  FItemList.FDesigner := nil;
  inherited;
end;

procedure TItemListDesigner.Event(Item: TItem; Event: Integer);
begin
end;

{ TOwnerList }
destructor TOwnerList.Destroy;
begin
  SetComponent(nil, nil);
  inherited;
end;

procedure TOwnerList.InsertOwner(AOwner: TComponent);
begin
  if Assigned(FComponent) and Assigned(AOwner) then
  begin
    FreeNotification(AOwner);
    ListAdd(FOwners, AOwner);
  end;
end;

procedure TOwnerList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and Assigned(FComponent) then
    if (AComponent = FComponent) then Destroy else RemoveOwner(AComponent);
end;

procedure TOwnerList.RemoveOwner(AOwner: TComponent);
var
  I: Integer;
begin
  I := ListIndexOf(FOwners, AOwner);
  if (I >= 0) then
  begin
    ListDelete(FOwners, I);
    if not Assigned(FOwners) then
    begin
      if Assigned(FVariable) then FVariable^ := nil;
      FComponent.Free;
    end;
  end;
end;

procedure TOwnerList.SetComponent(AComponent: TComponent; AVariable: PComponent);
begin
  if (FComponent <> AComponent) then
  begin
    ListClear(FOwners);
    FComponent := AComponent;
    FVariable := AVariable;
    if Assigned(FComponent) then FreeNotification(FComponent) else FVariable := nil;
  end;
end;

{ TOwnerManager }
function TOwnerManager.GetItem(Index: Integer): TOwnerList;
begin
  Result := inherited Items[Index];
end;

function TOwnerManager.FindOwnerList(Variable: PComponent): TOwnerList;
var
  I: Integer;
begin
  I := IndexOfVariable(Variable);
  if I >= 0 then Result := Items[I] else Result := nil;
end;

function TOwnerManager.IndexOfVariable(Variable: PComponent): Integer;
var
  Item: TOwnerList;
begin
  for Result := 0 to Count - 1 do
  begin
    Item := Items[Result];
    if Item.Variable = Variable then Exit;
  end;
  Result := -1;
end;

procedure TOwnerManager.InsertOwner(Variable: PComponent; ComponentClass: TComponentClass; AOwner: TComponent);
var
  Item: TOwnerList;
begin
  Item := FindOwnerList(Variable);
  if not Assigned(Item) then
  begin
    Item := TOwnerList.Create(Self);
    try
      Item.ItemList := Self;
      Variable^ := ComponentClass.Create(Application);
      try
        Item.SetComponent(Variable^, Variable);
      except
        Variable^.Free;
        Variable^ := nil;
        raise;
      end;
    except
      Item.Free;
      raise;
    end;
  end;
  Item.InsertOwner(AOwner);
end;

procedure TOwnerManager.RemoveOwner(Variable: PComponent; AOwner: TComponent);
var
  Item: TOwnerList;
begin
  Item := FindOwnerList(Variable);
  if Assigned(Item) then Item.RemoveOwner(AOwner);
end;

{ TCustomHook }

constructor TCustomHook.Create(AOwner: TComponent);
begin
  inherited;
  ListAdd(vgTools.HookList, Self);
end;

destructor TCustomHook.Destroy;
begin
  SetHookedObject(nil);
  ListRemove(vgTools.HookList, Self);
  inherited;
end;

procedure TCustomHook.Hook;
begin
  SetActive(True);
end;

procedure TCustomHook.UnHook;
begin
  SetActive(False);
end;

function TCustomHook.FindHook(Value: TComponent; HookClass: TCustomHookClass): TCustomHook;
var
  I: Integer;
begin
  for I := 0 to ListCount(HookList) - 1 do
  begin
    Result := HookList[I];
    if (Result is HookClass) and (Result.HookedObject = Value) then Exit;
  end;
  Result := nil;
end;

class function TCustomHook.GetHookList: TList;
begin
  Result := vgTools.HookList;
end;

function TCustomHook.IsObjectHooked(Value: TComponent): Boolean;
var
  Hook: TCustomHook;
  FClass: TCustomHookClass;
begin
  Result := Assigned(Value);
  if Result then
  begin
    FClass := TCustomHookClass(Self.ClassType);
    Hook := FindHook(Value, FClass);
    Result := Assigned(Hook) and (Hook <> Self);
  end;
end;

procedure TCustomHook.SetHookedObject(Value: TComponent);
var
  SaveActive: Boolean;
begin
  if (csLoading in ComponentState) then
    FStreamedHookedObject := Value
  else if FHookedObject <> Value then
  begin
    SaveActive := FActive;
    InternalUnHook;
    if Assigned(Value) then FreeNotification(Value);
    FHookedObject := Value;
    if SaveActive then InternalHook;
  end;
end;

procedure TCustomHook.SetActive(Value: Boolean);
begin
  if (csLoading in ComponentState) then
    FStreamedActive := Value
  else if FActive <> Value then
    if Value then InternalHook else InternalUnHook;
end;

procedure TCustomHook.Loaded;
begin
  inherited;
  try
    SetHookedObject(FStreamedHookedObject);
    SetActive(FStreamedActive);
  except
    if csDesigning in ComponentState then
      Application.HandleException(Self)
    else
      raise;
  end;
end;

procedure TCustomHook.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (AComponent = FHookedObject) and (Operation = opRemove) then SetHookedObject(nil);
  inherited;
end;

procedure TCustomHook.InternalHook;
begin
  if not FActive and (FHookedObject <> nil) then HookObject;
  FActive := True;
end;

procedure TCustomHook.InternalUnHook;
begin
  if FActive and (FHookedObject <> nil) then UnHookObject;
  FActive := False;
end;

procedure TCustomHook.HookObject;
begin
end;

procedure TCustomHook.UnHookObject;
begin
end;

{ TvgThread }
type
  TThreadHack = class(TThreadEx);

constructor TvgThread.Create(AOwner: TComponent);
begin
  inherited;
  FStreamedSuspended := True;
  FThread := TThreadEx.Create(True);
  FThread.OnExecute := DoExecute;
end;

destructor TvgThread.Destroy;
begin
  Terminate(True);
  FThread.Free;
  inherited;
end;

procedure TvgThread.DoExecute(Sender: TObject);
begin
  if Assigned(FOnExecute) then FOnExecute(Self);
end;

function TvgThread.GetHandle: THandle;
begin
  Result := FThread.Handle;
end;

function TvgThread.GetOnTerminate: TNotifyEvent;
begin
  Result := FThread.OnTerminate;
end;

function TvgThread.GetPriority: TThreadPriority;
begin
  Result := FThread.Priority;
end;

function TvgThread.GetReturnValue: Integer;
begin
  Result := TThreadHack(FThread).ReturnValue;
end;

function TvgThread.GetSuspended: Boolean;
begin
  if not (csDesigning in ComponentState) then
    Result := FThread.Suspended else
    Result := FStreamedSuspended;
end;

procedure TvgThread.Execute;
begin
  Terminate(True);
  FThread.Resume;
end;

procedure TvgThread.Loaded;
begin
  inherited;
  SetSuspended(FStreamedSuspended);
end;

procedure TvgThread.SetOnTerminate(Value: TNotifyEvent);
begin
  FThread.OnTerminate := Value;
end;

procedure TvgThread.SetPriority(Value: TThreadPriority);
begin
  FThread.Priority := Value;
end;

procedure TvgThread.SetReturnValue(Value: Integer);
begin
  TThreadHack(FThread).ReturnValue := Value;
end;

procedure TvgThread.SetSuspended(Value: Boolean);
begin
  if not (csDesigning in ComponentState) then
  begin
    if (csLoading in ComponentState) then
      FStreamedSuspended := Value else
      FThread.Suspended := Value;
  end else
    FStreamedSuspended := Value;
end;

procedure TvgThread.Suspend;
begin
  FThread.Suspend;
end;

procedure TvgThread.Synchronize(Method: TThreadMethod);
begin
  TThreadHack(FThread).Synchronize(Method);
end;

procedure TvgThread.InternalSynchronize;
begin
  FSyncMethod(FSyncParams);
end;

procedure TvgThread.SynchronizeEx(Method: TNotifyEvent; Params: Pointer);
begin
  if Assigned(Method) then
  begin
    FSyncMethod := Method; FSyncParams := Params;
    try
      TThreadHack(FThread).Synchronize(InternalSynchronize);
    finally
      FSyncMethod := nil; FSyncParams := nil;
    end;
  end;
end;

procedure TvgThread.Resume;
begin
  FThread.Resume;
end;

procedure TvgThread.Terminate(Hard: Boolean);
var
  FTmp: TThreadEx;
begin
  if Hard then
  begin
    TerminateThread(FThread.Handle, 0);
    FTmp := TThreadEx.Create(True);
    try
      FTmp.Priority := Self.Priority;
      FTmp.OnExecute := DoExecute;
      FTmp.OnTerminate := Self.OnTerminate;
    except
      FTmp.Free;
      raise;
    end;
    FThread.Free;
    FThread := FTmp;
  end else
    FThread.Terminate;
end;

function TvgThread.WaitFor: Integer;
begin
  Terminate(True);
  Result := FThread.WaitFor;
end;

{ TBroadcaster }

constructor TBroadcaster.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TList.Create;
  FDatas := TList.Create;
end;

destructor TBroadcaster.Destroy;
begin
  FItems.Free;
  FDatas.Free;
  inherited;
end;

function TBroadcaster.Broadcast(Msg: Cardinal; WParam, LParam: Longint): Longint;
var
  I: Integer;
  Message: TMessage;
begin
  Message.Msg := Msg;
  Message.WParam := WParam;
  Message.LParam := LParam;
  Message.Result := 0;
  for I := 0 to Count - 1 do
    if BroadcastMessage(Message, Item[I], Data[I]) then Break;
  Result := Message.Result;
end;

function TBroadcaster.BroadcastMessage(var Msg: TMessage; Item, Data: TObject): Boolean;
begin
  Result := False;
  if Assigned(FOnBroadcast) then FOnBroadcast(Self, Msg, Item, Data, Result);
end;

function TBroadcaster.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TBroadcaster.GetData(Index: Integer): TObject;
begin
  Result := FDatas[Index];
end;

function TBroadcaster.GetItem(Index: Integer): TObject;
begin
  Result := FItems[Index];
end;

function TBroadcaster.IndexOf(AObject: TObject): Integer;
begin
  Result := FItems.IndexOf(AObject);
end;

procedure TBroadcaster.InsertObject(AObject, AData: TObject);
var
  I: Integer;
begin
  I := FItems.IndexOf(AObject);
  if I < 0 then
  begin
    FItems.Add(AObject);
    FDatas.Add(AData);
    if (AObject is TComponent) then
      FreeNotification(TComponent(AObject));
  end;
end;

procedure TBroadcaster.RemoveObject(AObject: TObject);
var
  I: Integer;
begin
  I := FItems.IndexOf(AObject);
  if I >= 0 then
  begin
    FItems.Delete(I);
    FDatas.Delete(I);
  end;
end;

procedure TBroadcaster.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then RemoveObject(AComponent);
end;

{ TClassItem }
constructor TClassItem.Create(AClassType: TClass; AData: Pointer; AInfo: String);
begin
  FClassType := AClassType;
  FData := AData;
  FInfo := AInfo;
end;

{ TClassList }
destructor TClassList.Destroy;
begin
  ListDestroyAll(FItems);
  inherited;
end;

function TClassList.ClassItemByName(const AClassName: TClassName): TClassItem;
begin
  Result := FindClassItem(AClassName);
  if not Assigned(Result) then
    raise EClassNotFound.Create({$IFNDEF _D3_}FmtLoadStr(SClassNotFound, [AClassName]){$ELSE}Format(SClassNotFound, [AClassName]){$ENDIF});
end;

function TClassList.FindClassItem(const AClassName: TClassName): TClassItem;
var
  I: Integer;
begin
  I := IndexOf(AClassName);
  if I >= 0 then
    Result := Items[I] else Result := nil;
end;

function TClassList.GetCount: Integer;
begin
  Result := ListCount(FItems);
end;

function TClassList.GetItem(Index: Integer): TClassItem;
begin
  Result := ListItem(FItems, Index);
end;

function TClassList.IndexOf(const AClassName: TClassName): Integer;
var
  AClass: TClass;
begin
  for Result := 0 to Count - 1 do
  begin
    AClass := Items[Result].GetClassType;
    if AnsiCompareText(AClass.ClassName, AClassName) = 0 then Exit;
  end;
  Result := -1;
end;

function TClassList.IndexOfClass(AClass: TClass; Inheritance: Boolean): Integer;
begin
  if Inheritance then
  begin
    for Result := Count - 1 downto 0 do
      if IsClass(AClass, Items[Result].GetClassType) then Exit;
  end else begin
    for Result := 0 to Count - 1 do
      if Items[Result].GetClassType = AClass then Exit;
  end;
  Result := -1;
end;

function TClassList.InternalRegister(AClass: TClass; const AData: Pointer; const AInfo: String; Inheritance: Boolean): TClassItem;
var
  I, J: Integer;
  Item: TClassItem;
begin
  Result := TClassItem.Create(AClass, AData, AInfo);
  try
    if Inheritance then
    begin
      J := 0;
      for I := Count - 1 downto 0 do
      begin
        Item := Items[I];
        if IsClass(AClass, Item.GetClassType) then
        begin
          J := I + 1;
          Break;
        end;
      end;
    end else
      J := Count;
    ListInsert(FItems, J, Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TClassList.InternalUnRegister(AClass: TClass; Index: Integer);
begin
  ListDelete(FItems, Index);
end;

procedure TClassList.RegisterClass(AClass: TClass; const AData: Pointer; const AInfo: String; Inheritance: Boolean);
begin
  if IndexOfClass(AClass, False) < 0 then
    InternalRegister(AClass, AData, AInfo, Inheritance);
end;

procedure TClassList.UnregisterClass(AClass: TClass);
var
  I: Integer;
begin
  I := IndexOfClass(AClass, False);
  if I >= 0 then InternalUnRegister(AClass, I);
end;

end.

