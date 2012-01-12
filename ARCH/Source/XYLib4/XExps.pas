{$I XLib.inc }
Unit XExps;

Interface

{procedure Register;}
Function GetXTypeCount: Integer; export;stdcall;
Function GetXType(I: Integer):String; export;stdcall;
Function GetXIndexOf(Const S: String):Integer; stdcall;
Function GetXSource(Const S: String):String; stdcall;
Function GetFirstXControl(Const S: String; Var AControl, AModule: String):Boolean; stdcall;

  { The Win3.1 API defines hmemcpy to copy memory that might span
    a segment boundary. Win32 does not define it, so add it, for portability. }
  Procedure HMemCpy(DstPtr, SrcPtr: Pointer; Amount: LongInt);
  Function  HugeOffset(HugePtr: Pointer; Amount: LongInt): Pointer;

Implementation

Uses Consts, Windows, Classes, SysUtils, Forms, Dialogs, DB, XForms, XDBForms,
     Proxies, TypInfo, DsgnIntf, ToolIntf, EditIntf, ExptIntf,
     IStreams, XMisc, IniFiles, VirtIntf, LnkSet, XDBTFC;

{ This is not defined in Delphi 2.0. }
Procedure HMemCpy(DstPtr, SrcPtr: Pointer; Amount: LongInt);
begin
  Move(SrcPtr^, DstPtr^, Amount);
end;

Function  HugeOffset(HugePtr: Pointer; Amount: LongInt): Pointer;
begin
  Result := PChar(HugePtr) + Amount;
end;

{ Move Size pointers within an array, from index Src to index Dst. }
Procedure HugeMove(Base: Pointer; Dst, Src, Size: LongInt);
var
  SrcPtr, DstPtr: PChar;
begin
  SrcPtr := PChar(Base) + Src * SizeOf(Pointer);
  DstPtr := PChar(Base) + Dst * SizeOf(Pointer);
  Move(SrcPtr^, DstPtr^, Size*SizeOf(Pointer));
end;

type

  TXLibDsgnExpert = class(TIExpert)
  public
    constructor Create;
    function GetName: string; override; stdcall;
    function GetStyle: TExpertStyle; override; stdcall;
    function GetIDString: string; override;stdcall;
  end;

  TXCustomFormExpert = class(TIExpert)
  public
    function GetStrSource: String; virtual; abstract;
    function GetStrDFM: String; virtual; abstract;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    procedure Execute; override;
  end;

  TXFormExpert = class(TXCustomFormExpert)
  public
    function GetStrSource: String; override;
    function GetStrDFM: String; override;
    function GetName: string; override;
    function GetIDString: string; override;
    function GetComment: string; override;
  end;

  TXDBFormExpert = class(TXCustomFormExpert)
  public
    function GetStrSource: String; override;
    function GetStrDFM: String; override;
    function GetName: string; override;
    function GetIDString: string; override;
    function GetComment: string; override;
  end;

  TXFormDesignModule = class(TCustomModule)
  public
{do ShowFormControl?}
  end;

  TXDBFormDesignModule = class(TCustomModule)
  public
    procedure ValidateComponent(Component: IComponent); override;
  end;

var Notifier: TIAddInNotifier;
    RegisterXList: TStringList;

resourcestring

{ TXForm }

  strXFormSource =
    'unit %0:s;'#13#10 +
    ''#13#10 +
    'interface'#13#10 +
    ''#13#10 +
    'uses'#13#10 +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, XForms,'#13#10 +
    '  XMisc;'#13#10 +
    ''#13#10 +
    'type'#13#10 +
    '  T%1:s = class(TXForm)'#13#10 +
    '  private'#13#10 +
    '    { Private declarations }'#13#10 +
    '  public'#13#10 +
    '    { Public declarations }'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  %1:s: T%1:s;'#13#10 +
    ''#13#10 +
    'implementation'#13#10 +
    ''#13#10 +
    '{$R *.DFM}'#13#10 +
    ''#13#10 +
    ''#13#10 +
    'initialization'#13#10+
    '  RegisterXForm(T%1:s)'#13#10+
    'finalization'#13#10+
    '  UnRegisterXForm(T%1:s)'#13#10+
    'end.'#13#10 +
    '';
  strXFormDFM =
    'object %0:s: T%0:s'#13#10 +
    '  Left = 200'#13#10 +
    '  Top = 112'#13#10 +
    '  Width = 544'#13#10 +
    '  Height = 375'#13#10 +
    '  Caption = ''%0:s'''#13#10 +
    'end';

{ TXDBForm }

  strXDBFormSource =
    'unit %0:s;'#13#10 +
    ''#13#10 +
    'interface'#13#10 +
    ''#13#10 +
    'uses'#13#10 +
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, XDBForms,'#13#10 +
    '  XMisc;'#13#10 +
    ''#13#10 +
    'type'#13#10 +
    '  T%1:s = class(TXDBForm)'#13#10 +
    '  private'#13#10 +
    '    { Private declarations }'#13#10 +
    '  public'#13#10 +
    '    { Public declarations }'#13#10 +
    '  end;'#13#10 +
    ''#13#10 +
    'var'#13#10 +
    '  %1:s: T%1:s;'#13#10 +
    ''#13#10 +
    'implementation'#13#10 +
    ''#13#10 +
    '{$R *.DFM}'#13#10 +
    ''#13#10 +
    ''#13#10 +
    'initialization'#13#10+
    '  RegisterXForm(T%1:s)'#13#10+
    'finalization'#13#10+
    '  UnRegisterXForm(T%1:s)'#13#10+
    'end.'#13#10 +
    '';
  strXDBFormDFM =
    'inherited %0:s: T%0:s'#13#10 +
    '  Left = 200'#13#10 +
    '  Top = 112'#13#10 +
    '  Width = 544'#13#10 +
    '  Height = 375'#13#10 +
    '  Caption = ''%0:s'''#13#10 +
    'end';

{ Tell Delphi about exceptions. }
Procedure HandleException;
begin
  ToolServices.RaiseException(ReleaseException);
end;

{ RegisterXList procedures}

type
  TXItem = class
    Source: String;
    Dfm: String;
    DfmType: String;
    Controls: TStringList;
    ContrSources: TStringList;
  end;

Procedure ClearXList;
var i: Integer;
    XItem: TXItem;
begin
  for i:=0 to RegisterXList.Count-1 do begin
    XItem:=TXItem(RegisterXList.Objects[i]);
    XItem.Controls.Free;
    XItem.ContrSources.Free;
    XItem.Free;
    RegisterXList.Objects[i]:=nil;
  end;
  RegisterXList.Clear;
end;

Function GetXTypeCount: Integer; export; stdcall;
begin
  Result:=RegisterXList.Count;
end;

Function GetXType(I: Integer):String; export; stdcall;
begin
  Result:=RegisterXList[i];
end;

Function GetXIndexOf(Const S: String):Integer; stdcall;
begin
  Result:=RegisterXList.IndexOf(S);
end;

Function GetXSource(Const S: String):String; stdcall;
var i: Integer;
begin
  i:=RegisterXList.IndexOf(S);
  if i<>-1 then Result:=TXItem(RegisterXList.Objects[i]).Source else Result:='';
end;

Function GetFirstXControl(Const S: String; Var AControl, AModule: String):Boolean; stdcall;
var i: Integer;
    XItem: TXItem;
begin
  AControl:='';
  AModule:='';
  Result:=False;
  for i:=0 to RegisterXList.Count-1 do begin
    XItem:=TXItem(RegisterXList.Objects[i]);
    if (XItem.Controls.Count>0)and(XItem.DfmType=S) then begin
      AControl:=XItem.Controls[0];
      AModule:=XItem.ContrSources[0];
      Result:=True;
      Break;
    end;
  end;
end;

type

  TS_PackProc = procedure(Index: LongInt) of object;
  TS_CustomList = class
  private
    fList: Pointer;     { Pointer to the base of the list }
    fCount: LongInt;    { Number of items in the list }
    fCapacity: LongInt; { Number of available slots in the list }
  protected
    function GetPointer(Index: LongInt): Pointer; virtual;
    procedure ReAllocList(NewCapacity: LongInt); virtual;
    procedure CheckIndex(Index: LongInt); virtual;
    function ExpandSize: LongInt; virtual;
    function GetItem(Index: LongInt): Pointer; virtual;
    procedure SetItem(Index: LongInt; Item: Pointer); virtual;
    procedure SetCapacity(NewCapacity: LongInt); virtual;
    procedure SetCount(NewCount: LongInt); virtual;
    procedure DoPack(PackProc: TS_PackProc);
    property Items[Index: LongInt]: Pointer read GetItem write SetItem;
  public
    destructor Destroy; override;
    function Add(Item: Pointer): LongInt; virtual;
    property Capacity: LongInt read fCapacity write SetCapacity;
    procedure Clear; virtual;
    property Count: LongInt read fCount write SetCount;
    { This is different from TList, where Delete is a procedure.
      It seems more useful to return the deleted pointer, which
      can save the caller a step sometimes. }
    function Delete(Index: LongInt): Pointer; virtual;
    procedure Exchange(I1, I2: LongInt); virtual;
    function Expand: TS_CustomList;
    function First: Pointer;
    function IndexOf(Item: Pointer): LongInt; virtual;
    procedure Insert(Index: LongInt; Item: Pointer); virtual;
    function Last: Pointer;
    procedure Move(CurIndex, NewIndex: LongInt); virtual;
    procedure Pack; virtual;
    function Remove(Item: Pointer): LongInt; virtual;
  end;

  { List of module notifiers. }
  TNotifierList = class(TS_CustomList)
  private
    function GetNotifier(I: LongInt): TIModuleNotifier;
  public
    property Notifiers[I: LongInt]: TIModuleNotifier read GetNotifier; default;
    function Add(Item: TIModuleNotifier): LongInt;
    procedure Clear; override;
    function Delete(Index: LongInt): Pointer; override;
  end;

{ Check a list index and raise an exception if it is not valid. }
Procedure TS_CustomList.CheckIndex(Index: LongInt);
begin
  if (Index<0) or (Index>=Count) then raise EListError.Create(SListIndexError)
end;

{ Destroy a TS_CustomList by unlocking and freeing the list's memory }
Destructor TS_CustomList.Destroy;
begin
  Clear;
  Inherited Destroy;
end;

{ Reallocate the list, copying the old list values into
  the new list.  Reset all the fields for the new list.
}
Procedure TS_CustomList.ReAllocList(NewCapacity: LongInt);
var
  NewList: Pointer;
  Ptr: Pointer;
begin
  { If the list is shrinking, then update Count for the smaller size. }
  if NewCapacity<Count then fCount:=NewCapacity;

  { Try to reallocate the existing list, if there is one. }
  if fList=nil then NewList:=nil
  else NewList:=GlobalReallocPtr(fList, NewCapacity*SizeOf(Pointer), GMem_Moveable);

  if NewList=nil then
  begin
    { Either this is the first time, or the reallocation failed. }
    NewList:=GlobalAllocPtr(GMem_Fixed, NewCapacity*SizeOf(Pointer));
    if NewList=nil then OutOfMemoryError;

    { Copy the old list into the new one. }
    if fList<>nil then begin
      HMemCpy(NewList, fList, Count*SizeOf(Pointer));
      GlobalFreePtr(fList);
    end;
  end;

  fList := NewList;

  { If Windows allocated even more memory, then see how much
    we really have.  The user might not have requested that
    much, but why waste memory?
  }
{$ifdef WIN32}
  fCapacity:=GlobalSize(GlobalHandle(fList)) div SizeOf(Pointer);
{$else}
  { Get the selector of the list pointer, to retrieve the memory handle.
    Extract the handle part of the value returned by GlobalHandle to
    get the size in bytes. Then divide to get the size as a capacity. }
  fCapacity:=GlobalSize(Word(GlobalHandle(Seg(fList^)))) div SizeOf(Pointer);
{$endif}

  { Zero out the unused slots. }
  if Capacity>Count then begin
    Ptr := HugeOffset(fList, Count * SizeOf(Pointer));
    FillChar(Ptr^, (Capacity-Count)*SizeOf(Pointer), 0);
  end;
end;

{ Return the new capacity of the list when we expand it.
  Here we emulate TList, which expands the list by 4, 8, or
  16 elements, depending on the number of items already in
  the list.
}
Function TS_CustomList.ExpandSize: LongInt;
begin
  if Capacity>8 then ExpandSize := Capacity + 16
  else if Capacity > 4 then ExpandSize := Capacity + 8
  else ExpandSize := Capacity + 4
end;

{ Return an item of the list, raising an exception for an invalid index }
Function TS_CustomList.GetItem(Index: LongInt): Pointer;
var
  Ptr: ^Pointer;
begin
  CheckIndex(Index);
  Ptr := HugeOffset(fList, Index*SizeOf(Pointer));
  GetItem := Ptr^;
end;

{ Get an item without checking for range errors.  Return a pointer
  to the slot in the list, so the pointer value can be changed.
  This function is available for use by derived classes, but is
  not used by TS_CustomList itself.  Instead, TS_CustomList calls
  HugeOffset() directly, which improves performance slightly.
}
Function TS_CustomList.GetPointer(Index: LongInt): Pointer;
begin
  GetPointer := HugeOffset(fList, Index * SizeOf(Pointer));
end;

{ Set a list item. }
Procedure TS_CustomList.SetItem(Index: LongInt; Item: Pointer);
var
  Ptr: ^Pointer;
begin
  CheckIndex(Index);
  Ptr := HugeOffset(fList, Index * SizeOf(Pointer));
  Ptr^ := Item;
end;

{ Set the new capacity of the list.  If the list shrinks,
  then adjust Count.
}
Procedure TS_CustomList.SetCapacity(NewCapacity: LongInt);
begin
  if NewCapacity < 0 then raise EListError.Create(sListIndexError);
  if Capacity <> NewCapacity then ReAllocList(NewCapacity);
end;

{ Set the count. If the new count is larger, then set the new
  items to nil. Increase the capacity as needed. }
Procedure TS_CustomList.SetCount(NewCount: LongInt);
var Ptr: ^Pointer;
    NZeroBytes: LongInt;
begin
  if NewCount<0 then raise EListError.Create(sListIndexError);
  if NewCount>Capacity then Capacity := NewCount;
  if Count<NewCount then begin
    { zero all the new items, which may cross segment boundaries }
    Ptr := HugeOffset(fList, Count * SizeOf(Pointer));
    NZeroBytes := (NewCount - Count) * SizeOf(Pointer);
    ZeroMemory(Ptr, NZeroBytes);
  end;
  fCount := NewCount;
end;

{ Add Item to the end of the list }
Function TS_CustomList.Add(Item: Pointer): LongInt;
begin
  Insert(Count, Item);
  Add:=Count-1;
end;

{ Clear all the items in the list. }
Procedure TS_CustomList.Clear;
begin
  if fList<>nil then begin
    GlobalFreePtr(fList);
    fList:=nil;
  end;
  fCount := 0;
  fCapacity := 0;
end;

Function TS_CustomList.Delete(Index: LongInt): Pointer;
begin
  Result := Items[Index];
  Dec(fCount);
  HugeMove(fList, Index, Index+1, Count-Index);
end;

{ Exchange the items at indexes I1 and I2. }
Procedure TS_CustomList.Exchange(I1, I2: LongInt);
var
  Tmp: Pointer;
  P, Q: ^Pointer;
begin
  CheckIndex(I1);
  CheckIndex(I2);
  P := HugeOffset(fList, I1 * SizeOf(Pointer));
  Q := HugeOffset(fList, I2 * SizeOf(Pointer));
  Tmp := P^;
  P^ := Q^;
  Q^ := Tmp;
end;

{ Return the first item in the list }
Function TS_CustomList.First: Pointer;
begin
  First := Items[0];
end;

Function TS_CustomList.IndexOf(Item: Pointer): LongInt;
var
  Ptr: ^Pointer;
begin
  Ptr := fList;
  for Result := 0 to Count-1 do begin
    if Ptr^ = Item then Exit;
    Ptr := HugeOffset(Ptr, SizeOf(Pointer));
  end;
  Result := -1;
end;

{ Insert Item at position, Index.  Slide all other items
  over to make room.  The user can insert to any valid index,
  or to one past the end of the list, thereby appending an
  item to the list.  In the latter case, adjust the capacity
  if needed. }
Procedure TS_CustomList.Insert(Index: LongInt; Item: Pointer);
var
  Ptr: ^Pointer;
begin
  if (Index<0) or (Index>Count) then raise EListError.Create(SListIndexError);
  if Count>=Capacity then Expand;
  { Make room for the inserted item. }
  Ptr:=HugeOffset(fList, Index*SizeOf(Pointer));
  HugeMove(Ptr, 1, 0, Count-Index);
  Ptr^:=Item;
  Inc(fCount);
end;

{ Return the last item in the list.  Raise an exception
  if the list is empty. }
Function TS_CustomList.Last: Pointer;
begin
  Last:=Items[Count - 1];
end;

{ Move an item from CurIndex to NewIndex. Only move the
  items that lie between CurIndex and NewIndex, leaving
  the rest of the list alone.
}
Procedure TS_CustomList.Move(CurIndex, NewIndex: LongInt);
var Tmp: Pointer;
    Ptr: ^Pointer;
begin
  CheckIndex(NewIndex);
  if NewIndex<>CurIndex then begin
    Tmp:=Items[CurIndex];
    if NewIndex<CurIndex then begin
      Ptr := HugeOffset(fList, NewIndex * SizeOf(Pointer));
      HugeMove(Ptr, 1, 0, CurIndex-NewIndex)
    end else
      if CurIndex < NewIndex then begin
        Ptr := HugeOffset(fList, CurIndex * SizeOf(Pointer));
        HugeMove(Ptr, 0, 1, NewIndex-CurIndex);
        Ptr := HugeOffset(fList, NewIndex * SizeOf(Pointer));
      end;
    Ptr^ := Tmp;
  end;
end;

{ Pack the list by removing nil slots.  After packing
  Count might be smaller.  After each loop iteration,
  the following is invariant:
    Items[k] <> nil for all k <= i
  Thus, when at the end of the loop, the list is packed.

  The loop marches through the list, using the I index.
  Whenever Items[I] = nil, collect a maximal string of nil slots,
  and then shift down the remaining items, adjusting Count to match.
}
Procedure TS_CustomList.DoPack(PackProc: TS_PackProc);
var
  I, J, K: LongInt;
  P, Q: ^Pointer;
begin
  { Instead of a for loop, use a while loop, and use the
    current value of Count for each iteration, since Count
    changes during the loop. }
  I := 0;
  P := fList;
  while I<Count do begin
    if P^<>nil then begin
      Inc(I);
      P := HugeOffset(fList, I*SizeOf(Pointer));
    end else begin
      if Assigned(PackProc) then PackProc(I);
      { Collect a run of nil slots. }
      for j:=i+1 to Count-1 do begin
        P:=HugeOffset(fList, J*SizeOf(Pointer));
        if P^<>nil then Break else
        if Assigned(PackProc) then PackProc(J);
      end;
      { Shift slots if there is a non-nil value.
        If all the remaining slots are nil, then the loop is done. }
      if P^=nil then begin
        fCount := I;
        Break;
      end;
      { Now shift the slots; setting the newly vacated slots to nil,
        as a safety measure. Stop at the next nil slot. }
      K:=I;
      while J<Count do begin
        P := HugeOffset(fList, K * SizeOf(Pointer));
        Q := HugeOffset(fList, J * SizeOf(Pointer));
        P^ := Q^;
        { Check after assigning to P^, so the check for nil at
          the top of the loop is true.  A small inefficiency for
          greater programming ease and maintainability. }
        if Q^=nil then Break;
        Q^:=nil;
        Inc(K);
        Inc(J);
      end;
      { Adjust Count by the number of nil slots removed. }
      Dec(fCount, J-K);
      { Set the loop counter to the next nil slot. }
      I:=K;
    end;
  end;
end;

Procedure TS_CustomList.Pack;
begin
  DoPack(nil)
end;

Function TS_CustomList.Remove(Item: Pointer): LongInt;
begin
  Result := IndexOf(Item);
  if Result>=0 then Delete(Result);
end;

Function TS_CustomList.Expand: TS_CustomList;
begin
  Capacity:=ExpandSize;
  Result:=Self;
end;

{ Convenient list of module notifiers. }
Function TNotifierList.GetNotifier(I: LongInt): TIModuleNotifier;
begin
  Result:=TIModuleNotifier(GetItem(I));
end;

Function TNotifierList.Delete(Index: LongInt): Pointer;
begin
  with TIModuleNotifier(inherited Delete(Index)) do Free;
  Result:=nil;
end;

Procedure TNotifierList.Clear;
var i:LongInt;
begin
  for i:=0 to Count-1 do begin
    Notifiers[i].Free;
    Items[i]:=nil;
  end;
  Inherited Clear;
end;

Function TNotifierList.Add(Item: TIModuleNotifier): LongInt;
begin
  Result:=Inherited Add(Pointer(Item));
end;


type
{ TProjectNotifier }
{ Notifier for opening files and projects. }

  TProjectNotifier=class(TIAddInNotifier)
  private
    FExpert: TXLibDsgnExpert;
    FNotifiers: TNotifierList;
    procedure MakeModuleNotifier(const FileName: string);
  public
    constructor Create(Expert: TXLibDsgnExpert);
    destructor Destroy; override;
    procedure FileNotification(NotifyCode: TFileNotification;
      const FileName: string; var Cancel: Boolean); override; stdcall;
    property Notifiers: TNotifierList read fNotifiers;
    property Expert: TXLibDsgnExpert read fExpert;
  end;

  TModuleNotifier = class(TIModuleNotifier)
  private
    fUnitFilename: string;
    fFormFilename: string;
    fIntf: TIModuleInterface;
    fProjectNotifier: TProjectNotifier;
    procedure GetFileNames;
  public
    constructor Create(ModIntf: TIModuleInterface; ProjectNotifier: TProjectNotifier);
    destructor Destroy; override;
    procedure Notify(NotifyCode: TNotifyCode); override; stdcall;
    procedure ComponentRenamed(Handle: Pointer; const OldName, NewName: string); override; stdcall;
    property ModIntf: TIModuleInterface read fIntf;
    property UnitFilename: string read fUnitFilename;
    property FormFilename: string read fFormFilename;
    property ProjectNotifier: TProjectNotifier read fProjectNotifier;
  end;

{ TModuleNotifier }

Constructor TModuleNotifier.Create(ModIntf: TIModuleInterface; ProjectNotifier: TProjectNotifier);
begin
  fIntf := ModIntf;
  fProjectNotifier := ProjectNotifier;
  Inherited Create;
  ModIntf.AddNotifier(Self);
  GetFileNames;
end;

{ Save the form and unit file names. }
Procedure TModuleNotifier.GetFileNames;
var FormIntf: TIFormInterface;
    EditIntf: TIEditorInterface;
begin
  FormIntf:=ModIntf.GetFormInterface;
  if FormIntf=nil then fFormFilename:=''
  else begin
    fFormFilename:=FormIntf.FileName;
    FormIntf.Free;
  end;

  EditIntf:=ModIntf.GetEditorInterface;
  if EditIntf=nil then fUnitFilename:=''
  else begin
    fUnitFilename:=EditIntf.FileName;
    EditIntf.Free;
  end;
end;

{ Remove the module notifier. Since the notifier is being
  removed cleanly, delete the auto-saved files, too. }
destructor TModuleNotifier.Destroy;
begin
  if ModIntf<>nil then ModIntf.RemoveNotifier(Self);
  ModIntf.Free;
  Inherited Destroy;
end;

{ When the module is saved, then delete the auto-save file.
  When the module interface is being freed, remove the notifier. }
var LastFormName: String='';
    LastModIntf: TIModuleInterface;

Function FindXControlItem(AControlName: String): TXItem;
var i: Integer;
    XItem: TXItem;
begin
  Result:=nil;
  for i:=0 to RegisterXList.Count-1 do begin
    XItem:=TXItem(RegisterXList.Objects[i]);
    if UpperCase(XItem.Dfm)=UpperCase(AControlName) then begin
      Result:=XItem;
      Break;
    end;
  end;
end;

Procedure ConstructForm(FormIntf: TIFormInterface);
var Form: TComponent;
    CompIntf, CompIntf1: TIComponentInterface;
{  Link: TXLibLink;}
    Control: TXLibControl;
    XItem: TXItem;
    i: Integer;
    Module: TIModuleInterface;
    DataIntf: TIFormInterface;
    PropInfo: PPropInfo;
begin
  CompIntf:=FormIntf.GetFormComponent;
  try
    Form:=TComponent(CompIntf.GetComponentHandle);
    XItem:=FindXControlItem(FormIntf.FileName);
    if Assigned(XItem) then
      if (XItem.ContrSources.Count=1)and(XItem.ContrSources[0]<>'ERROR') then begin
        Module:=ToolServices.GetModuleInterface(XItem.ContrSources[0]);
        if Module<>nil then
          try
            DataIntf:=Module.GetFormInterface;
            if DataIntf<>nil then
              try
                CompIntf1:=DataIntf.FindComponent(XItem.Controls[0]);
                if Assigned(CompIntf1) then begin
                  Control:=TXLibControl(CompIntf1.GetComponentHandle);
                  Control.ActivateLinks(False);
                end;
              finally
                DataIntf.Free;
              end;
          finally
            Module.Free;
          end;
      end
    else begin
      PropInfo:=GetPropInfo(Form.ClassInfo, 'FormControl');
      if PropInfo<>nil then begin
        Control:=TXLibControl(GetOrdProp(Form,PropInfo));
        if Assigned(Control) {and Control.ClassNameIs('TDBFormControl')} then
          Control.ActivateLinks(False);
      end;

{     if IsXFormClass(Form.ClassType, 'TForm') then begin}
{!       CompIntf1:=FormIntf.FindComponent('FormLink');}
{       Link:=TXLibLink(TFormDesigner(TForm(Form).Designer).GetComponent('FormLink'));}
{!       if Assigned(CompIntf1) then begin
          Link:=TXLibLink(CompIntf1.GetComponentHandle);
          if Assigned(Link) and Assigned(Link.LinkControl) then begin
             if Link.LinkControl.ClassNameIs('TDBFormControl') then begin
                TXLibControl(Link.LinkControl).ActivateLinks(False);
                end;
             end;
          end;
     end;}
    end;
  finally
    CompIntf.Free;
  end;
end;

Procedure TModuleNotifier.Notify(NotifyCode: TNotifyCode);
var FormIntf: TIFormInterface;
begin
  case NotifyCode of
    ncAfterSave:
      { The real file was saved, so delete the auto-save file. }
{      DeleteAutoSavedFiles};
    ncFormSelected:
      begin
        FormIntf:=ModIntf.GetFormInterface;
        if FormIntf<>nil then begin
          if FormIntf.FileName<>LastFormName then begin
            LastFormName:=FormIntf.FileName;
            ConstructForm(FormIntf);
            LastModIntf:=ModIntf;
          end;
          FormIntf.Free;
        end;
      end;
    ncModuleDeleted: ProjectNotifier.Notifiers.Remove(Self);
    ncModuleRenamed:
      begin
{       DeleteAutoSavedFiles};
        GetFileNames;
      end;
  end;
end;

Procedure TModuleNotifier.ComponentRenamed(Handle: Pointer; const OldName, NewName: string);
begin
  { The auto-save expert doesn't care about renamed components. }
end;

Constructor TProjectNotifier.Create(Expert: TXLibDsgnExpert);
begin
  FExpert:=Expert;
  FNotifiers:=TNotifierList.Create;
  Inherited Create;
  ToolServices.AddNotifier(Self);
end;

Destructor TProjectNotifier.Destroy;
begin
  FNotifiers.Free;
  ToolServices.RemoveNotifier(Self);
  Inherited Destroy;
end;

Function XUnits(Param: Pointer; const Filename, Unitname, Formname: string): Boolean; stdcall;
begin
{  if param<>Nil then showmessage(Unitname+'>'+TObject(Param).ClassName)
     else showmessage(Unitname+'>'+'Nil');}
end;

Procedure TProjectNotifier.FileNotification(NotifyCode: TFileNotification;
                           const FileName: string; var Cancel: Boolean);
var i,j,j1,k,k1, m, m1: Integer;
    S: String;
    MIni: TIniFile;
    List: TStringList;
    XItem: TXItem;
begin
  case NotifyCode of
{
  fnRemovedFromProject: begin
    RemoveXForm(FileName);
    end;
  fnFileClosing: begin
    RemoveXForm(FileName);
    end;}
  fnProjectOpened, fnFileOpened, fnAddedToProject:
    begin
    { Create a module notifier }
{-----------}
{    if NotifyCode = fnProjectOpened then
       AddXForms else
    if NotifyCode = fnFileOpened then
       AddXForm(FileName);}

{    ShowMessage('Hello>'+FileName);}
      if NotifyCode=fnProjectOpened then begin
        S:=FileName;
        i:=Pos('.',S);
        if i>0 then System.Delete(S,i,255);
        MIni := TIniFile.Create(S+'.DXL');
        if Assigned(MIni) then with MIni do begin
          ClearXList;
          m:=ReadInteger('Modules','Count',-1);
          for j:=0 to m-1 do begin
            S:=ReadString('Modules', 'Alias'+IntToStr(j), 'ERROR');
            if S<>'ERROR' then begin
              XItem:=TXItem.Create;
              XItem.Controls:=TStringList.Create;
              XItem.ContrSources:=TStringList.Create;
              RegisterXList.AddObject(S, XItem);
              XItem.Source:=ReadString(S, 'Source', 'ERROR');
              XItem.Dfm:=ReadString(S, 'Dfm', 'ERROR');
              XItem.DfmType:=ReadString(S, 'DfmType', 'ERROR');
              m1:=ReadInteger(S,'Count',-1);
              for j1:=0 to m1-1 do begin
                XItem.Controls.Add(ReadString(S, 'Control'+IntToStr(j1), 'ERROR'));
                XItem.ContrSources.Add(ReadString(S, 'Module'+IntToStr(j1), 'ERROR'));
              end;
            end;
          end;
        end;
        MIni.Free;
      end;
{-----------}
      if FileName<>'' then MakeModuleNotifier(FileName);
    end;
  fnProjectDesktopSave:
    begin
      MIni := TIniFile.Create(FileName);
      if Assigned(MIni) then with MIni do begin
        List:=TStringList.Create;
        List.Sorted:=False;

        m:=ReadInteger('Modules','Count',-1);
        for j:=0 to m-1 do begin
          S:=ReadString('Modules', 'Module'+IntToStr(j), 'ERROR');
          if S<>'ERROR' then List.Add(S);
          DeleteKey('Modules','Module'+IntToStr(j));
        end;
        k1:=0;
        for i:=0 to ToolServices.GetUnitCount-1 do begin
          S:=ToolServices.GetUnitName(i);
          k:=List.IndexOf(S);
          if k<>-1 then begin
            if k>k1 then List.Exchange(k,k1);
            Inc(k1)
          end;
        end;
        for i:=0 to List.Count-1 do
          WriteString('Modules','Module'+IntToStr(i),List[i]);

        MIni.Free;
      end;
      List.Free;
    end;
  fnProjectClosing:
    begin
      ToolServices.EnumProjectUnits(XUnits, Pointer(Self));
{    RemoveXForms;}
    end;
  end;
end;

Procedure TProjectNotifier.MakeModuleNotifier(const FileName: string);
var ModIntf: TIModuleInterface;
begin
  ModIntf:=ToolServices.GetModuleInterface(FileName);
  if ModIntf<>nil then Notifiers.Add(TModuleNotifier.Create(ModIntf, Self));
end;

{ TXLibDsgnExpert }

Constructor TXLibDsgnExpert.Create;
begin
  try
    Inherited Create;
    { register the project notifier. }
    Notifier := TProjectNotifier.Create(Self);
  except
    HandleException;
  end;
end;

Function TXLibDsgnExpert.GetName: string;
begin
  try
    Result := 'XLibDsgn';
  except
    HandleException;
  end;
end;

Function TXLibDsgnExpert.GetStyle: TExpertStyle;
begin
  try
    Result := esAddIn;
  except
    HandleException;
  end;
end;

Function TXLibDsgnExpert.GetIDString: string;
begin
  try
    Result:='XLibrary.XLibDsgnExpert';
  except
    HandleException;
  end;
end;

{ TXCustomFormExpert }

Function TXCustomFormExpert.GetGlyph: hIcon;
begin
  Result:=0;
end;

Function  TXCustomFormExpert.GetStyle: TExpertStyle;
begin
  Result:=esForm;
end;

Function TXCustomFormExpert.GetState: TExpertState;
begin
  Result:=[esEnabled];
end;

Function TXCustomFormExpert.GetAuthor: String;
begin
  Result:='V.Poputhevitch';
end;

Function TXCustomFormExpert.GetPage: String;
begin
  Result:='New';
end;

Procedure TXCustomFormExpert.Execute;
var ISourceStream,  IFormStream: TIStreamAdapter;
    FormText, FormDFM: TStringStream;
    UnitIdent, FormIdent, FileName: String;
begin
  if ToolServices=nil then Exit;
  if ToolServices.GetNewModuleName(UnitIdent, FileName) then
  begin
    UnitIdent := AnsiLowerCase(UnitIdent);
    UnitIdent[1] := Upcase(UnitIdent[1]);
    FormIdent := GetName + Copy(UnitIdent, 5, MaxInt);
    FormText:= TStringStream.Create(Format(GetStrDFM, [FormIdent]));
    FormDFM:= TStringStream.Create('');
    ObjectTextToResource(FormText, FormDFM);
    FormDFM.Position := 0;
    IFormStream:= TIStreamAdapter.Create(FormDFM, {soOwned}soReference{False});
    try
      {IFormStream.AddRef;}
      ISourceStream := TIStreamAdapter.Create(TStringStream.Create(
        Format(GetStrSource, [UnitIdent,FormIdent])),soOwned{True});
      try
        {ISourceStream.AddRef;}
        ToolServices.CreateModule(FileName, ISourceStream, IFormStream,
          [cmAddToProject, cmShowSource, cmShowForm, cmUnNamed,
          cmMarkModified]);
      finally
        ISourceStream.Free;
      end;
    finally
      IFormStream.Free;
    end;
  end;
end;

{ TXFormExpert }

Function TXFormExpert.GetName: String;
begin
  Result:='XForm';
end;

Function  TXFormExpert.GetIDString: String;
begin
  Result:='XLibrary.XFormExpert';
end;

Function TXFormExpert.GetComment: String;
begin
  Result:='X-library base form';
end;

Function TXFormExpert.GetStrSource: String;
begin
  Result:=strXFormSource;
end;

Function TXFormExpert.GetStrDFM: String;
begin
  Result:=strXFormDFM;
end;

{ TXDBFormExpert }

Function TXDBFormExpert.GetName: String;
begin
  Result:='XDBForm';
end;

Function TXDBFormExpert.GetIDString: String;
begin
  Result:='XLibrary.XDBFormExpert';
end;

Function TXDBFormExpert.GetComment: String;
begin
  Result:='X-library DB-base form';
end;

Function TXDBFormExpert.GetStrSource: String;
begin
  Result:=strXDBFormSource;
end;

Function TXDBFormExpert.GetStrDFM: String;
begin
  Result:=strXDBFormDFM;
end;

{ TXFormModule }

Procedure TXDBFormDesignModule.ValidateComponent(Component: IComponent);
var ALink: TDataSource;
    PropInfo: PPropInfo;
begin
  Inherited;
  if TXForm(Root).FormControl is TDBFormControl then begin
    ALink:=TDBFormControl(TXForm(Root).FormControl).DefSource;
    if Assigned(ALink) then begin
      PropInfo := GetPropInfo(ExtractComponent(Component).ClassInfo, 'DataSource');
      if PropInfo<>nil then begin
        SetOrdProp(ExtractComponent(Component), PropInfo, LongInt(ALink));
      end;
    end;
  end;
end;

Initialization
  RegisterCustomModule(TXForm, TXFormDesignModule);
  RegisterCustomModule(TXDBForm, TXDBFormDesignModule);
  RegisterXList:= TStringList.Create;
  {$WARNINGS OFF}
  RegisterLibraryExpert(TXLibDsgnExpert.Create);
  RegisterLibraryExpert(TXFormExpert.Create);
  RegisterLibraryExpert(TXDBFormExpert.Create);
  {$WARNINGS ON}

Finalization
  ClearXList;
  RegisterXList.Free;
  Notifier.Free;
end.
