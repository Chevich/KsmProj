{*******************************************************}
{                                                       }
{   09.04.98                  				}
{                                                       }
{   Dispatcher of the Notification events               }
{           - TXNotifyEvent - master of events          }
{           - TXNotifySelect - master of select object  }
{           - TXNotifyString - master of string         }
{   TSrcLinkItem - special TCollectionItem              }
{                                                       }
{   functions of the clone components and               }
{            of the register X-Forms                    }
{                                                       }
{   Last corrections 22.10.98                           }
{                                                       }
{*******************************************************}

Unit XMisc;

Interface

Uses Messages, Classes, Controls, Graphics;

Const WM_LinkSource=WM_User+1001;
      WM_ChangePageSource = WM_User+1002;
      WM_ChangeControlSource = WM_User+1003;

{Procedure SendLinkMessage(Comp: TControl; Value: TDataSource);}

var IsAppActive: Boolean = True;
    CurrentXControl: TWinControl = nil;

Const

  xeNone        = 0;
{ LnTables }
  xeSetLink     = 1;
  xeUpdateLinks = 2;
{ DBTools }
  xeSetSource   = 3;

  xeGetXEdit    = 4;
  xeIsDeclar    = 5;{LinkDataSet}
  xeGetDataSet  = 6;
  xeSetDataSet  = 7;
  xeSetParams   = 8;
  xeGetFirstXControl = 9;
  xeEnd = 10;
  xeIsLookField = 11;
  xeIsThisLink  = 12;
  xeChangeParams = 14;
  xeSumExecute = 15;

type

  TXAlignment = (xaNone, xaLeft, xaMiddle, xaRight);

{ TXNotifyEvent }

  TXNotifyEvent = class(TComponent)
  private
    FEvent: Word;
    FChild: TPersistent;
  public
    procedure GoSpell(AComponent: TComponent; AEvent: Word; Operation: TOperation);
    procedure GoSpellChild(AComponent: TComponent; AEvent: Word; AChild: TPersistent; Operation: TOperation);
    procedure GoEqual(BChild: TPersistent; Operation: TOperation);
    property SpellEvent: Word read FEvent write FEvent;
    property SpellChild: TPersistent read FChild write FChild;
  end;

{ TXNotifySelect }

  TXNotifySelect = class(TXNotifyEvent)
  private
    FSelect: TPersistent;
  public
    procedure GoSpellSelect(AComponent: TComponent; AEvent: Word; AChild,
              ASelect: TPersistent; Operation: TOperation);
    property SpellSelect: TPersistent read FSelect write FSelect;
  end;

{ TXNotifyString }

  TXNotifyString = class(TXNotifyEvent)
  private
    FStr: String;
  public
    procedure GoSpellStr(AComponent: TComponent; AEvent: Word; Const AStr: String; Operation: TOperation);
    property SpellStr: String read FStr write FStr;
  end;

{ TSrcLinkItem }

  TSrcLinks = class;

  TSrcLinkItem = class(TCollectionItem)
  public
    function GetString(aItems: TStrings; aLink: TSrcLinks): Integer; virtual;
  end;

{ TSrcLinks }

  TSrcLinks = class(TCollection)
  private
    FCurrentIndex: Integer;
  protected
    procedure SetCurrentIndex(aIndex: Integer); virtual;
  public
    constructor Create(ItemClass: TCollectionItemClass);
    procedure GetString(aItems: TStrings; aSrcLinkItem: TSrcLinkItem);virtual;
    procedure GetStrings(aItems: TStrings);
    property CurrentIndex: Integer read FCurrentIndex write SetCurrentIndex;
  end;

{ TXCustomLink }
{
  TXCustomLink = class(TPersistent)
  private
    FOwner: TPersistent;
    FItems: TStrings;
    procedure SetItems(AItems: TStrings);
  protected
    procedure DeAssignItems; virtual;
    procedure AssignItems; virtual;
  public
    constructor Create(AOwner: TPersistent);virtual;
    destructor Destroy; override;
    property Owner: TPersistent read FOwner;
  published
    property Items: TStrings read FItems write SetItems;
  end;
}

{ TXLibControl }

  TXLibControl = class(TComponent)
  public
    procedure ActivateLinks(IsLoaded: Boolean);virtual;
  end;

var RegisterXFormList: TStringList;
    RegisterXToolList: TStringList;
    RegisterXSplashList: TStringList;

Procedure RegisterXForm(AXFormClass: TComponentClass);
Procedure RegisterXForms(AClasses: array of TComponentClass);
Procedure RegisterAliasXForm(Const Name: String; AXFormClass: TComponentClass);
Procedure UnRegisterXForm(AXFormClass: TComponentClass);
Procedure UnRegisterXForms(AClasses: array of TComponentClass);
Procedure UnRegisterNotAliasXForm(AXFormClass: TComponentClass);
Procedure RegisterXTool(AXToolClass: TComponentClass);
Procedure RegisterAliasXTool(Const Name: String; AXToolClass: TComponentClass);
Procedure UnRegisterXTool(AXToolClass: TComponentClass);
Procedure RegisterXSplash(AXSplashClass: TComponentClass);
Procedure RegisterAliasXSplash(Const Name: String; AXSplashClass: TComponentClass);
Procedure UnRegisterXSplash(AXSplashClass: TComponentClass);
Function IsXFormClass(AClass: TClass; Const ANameClass: String): Boolean;
Procedure GetFontCharSizes(aFont: TFont; var aWidth, aHeight: Integer);
Function LoadXComponentFromStream(aStream: TStream; aComponent: TPersistent; aRoot: TComponent;
             aReferenceNameEvent: TReferenceNameEvent; aSetNameEvent: TSetNameEvent; aFindMethodEvent: TFindMethodEvent; aErrorEvent: TReaderError): Boolean;
Function StoreXComponentToStream(aStream: TStream; aComponent: TPersistent; aRoot: TComponent): Boolean;
Function CloneXComponent(var aCloneComponent: TComponent; aComponent: TComponent; aRoot: TComponent): Boolean;
Function CloneXComponentToClass(var aCloneComponent: TComponent; aComponent: TComponent;
              aClass: TComponentClass; aRoot: TComponent): Boolean;
Function CloneXComponentAncestor(var aCloneComponent: TComponent; aComponent: TComponent;
              AncestorClass: TClass; aRoot: TComponent): Boolean;
Function CloneXComponentAncestorToClass(var aCloneComponent: TComponent; aComponent: TComponent;
              AncestorClass, aClass: TComponentClass; aRoot: TComponent): Boolean;

Procedure AddCollection(Dest, Source: TCollection);

(*** FOR TEST!!!
var
    FFFF:Text; { Файл отчета об ошибках при отлове Accsess Violation }
    CaptureErrorMode: boolean=false;
FOR TEST!!! ***)

Implementation

Uses XCracks;

type PClass = ^TClass;

{
Procedure SendLinkMessage(Comp: TControl; Value: TDataSource);
var i: Integer;
    F: TCustomForm;
begin
  if Comp is TWinControl then CurrentXControl:=TWinControl(Comp);
  F:=GetParentForm(Comp);
  for i:=0 to F.ComponentCount-1 do
      if F.Components[i] is TWinControl then
         PostMessage(TWinControl(F.Components[i]).Handle, wm_LinkSource, LongInt(Value), LongInt(Comp));
end;
}

{ TXNotifyEvent }

Procedure TXNotifyEvent.GoSpell(AComponent: TComponent; AEvent: Word; Operation: TOperation);
begin
  if Assigned(AComponent) and (not (csDestroying in aComponent.ComponentState)) then begin
    FEvent:=AEvent;
    TComponentSelf(AComponent).Notification(Self, Operation);
  end;
end;

Procedure TXNotifyEvent.GoSpellChild(AComponent: TComponent; AEvent: Word; AChild: TPersistent;
                                     Operation: TOperation);
begin
  if Assigned(aComponent) and (not (csDestroying in aComponent.ComponentState)) then begin
    FEvent:=AEvent;
    FChild:=AChild;
    TComponentSelf(AComponent).Notification(Self, Operation);
  end;
end;

Procedure TXNotifyEvent.GoEqual(BChild: TPersistent; Operation: TOperation);
begin
  if Operation=opInsert then begin
    SpellChild:=BChild;
    SpellEvent:=xeNone;
  end else
    if SpellChild = BChild then SpellEvent:=xeNone;
end;

{ TXNotifySelect }

Procedure TXNotifySelect.GoSpellSelect(AComponent: TComponent; AEvent: Word; AChild,
                                       ASelect: TPersistent; Operation: TOperation);
begin
  if Assigned(AComponent)and(not (csDestroying in aComponent.ComponentState)) then begin
    FEvent:=AEvent;
    FChild:=AChild;
    FSelect:= ASelect;
    TComponentSelf(AComponent).Notification(Self, Operation);
  end;
end;

{ TXNotifyString }

Procedure TXNotifyString.GoSpellStr(AComponent: TComponent; AEvent: Word;
                                    Const AStr: String; Operation: TOperation);
begin
  if Assigned(AComponent) and (not (csDestroying in aComponent.ComponentState)) then begin
    FEvent:=AEvent;
    FStr:= AStr;
    TComponentSelf(AComponent).Notification(Self, Operation);
  end;
end;

{ TXCustomLink }
{
constructor TXCustomLink.Create(AOwner: TPersistent);
begin
  Inherited Create;
  FOwner:=AOwner;
  FItems:=TStringList.Create;
end;

destructor TXCustomLink.Destroy;
begin
  FItems.Free;
  FItems:=Nil;
  Inherited;
end;

procedure TXCustomLink.SetItems(AItems: TStrings);
begin
  DeAssignItems;
  FItems.Assign(AItems);
  AssignItems;
end;

procedure TXCustomLink.DeAssignItems;
begin
end;

procedure TXCustomLink.AssignItems;
begin
end;
}
{ other procedures and functions }

Procedure GetFontCharSizes(aFont: TFont; var aWidth, aHeight: Integer);
var
  lBitmap: TBitmap;
begin
  lBitmap := TBitMap.Create;
  lBitmap.Canvas.Font := aFont;
  aWidth   := {11}lBitmap.Canvas.TextWidth('0');
  aHeight  := lBitmap.Canvas.TextHeight('W');
  lBitmap.Free;
end;

{ TSrcLinkItem }

Function TSrcLinkItem.GetString(aItems: TStrings; aLink: TSrcLinks): Integer;
begin
end;

{ TSrcLinks }

Constructor TSrcLinks.Create(ItemClass: TCollectionItemClass);
begin
  Inherited;
  FCurrentIndex:= -1;
end;

Procedure TSrcLinks.GetString(aItems: TStrings; aSrcLinkItem: TSrcLinkItem);
begin
end;

Procedure TSrcLinks.GetStrings(aItems: TStrings);
var i: Integer;
begin
  for i:=0 to Count-1 do GetString(aItems, TSrcLinkItem(Items[i]));
end;

Procedure TSrcLinks.SetCurrentIndex(aIndex: Integer);
begin
  FCurrentIndex:= aIndex;
end;

{ TXLibControl }

Procedure TXLibControl.ActivateLinks(IsLoaded: Boolean);
begin
end;

Procedure RegisterXForm(AXFormClass: TComponentClass);
var S: String;
begin
  S:=AXFormClass.ClassName;
  if UpCase(S[1])='T' then Delete(S,1,1);
  RegisterXFormList.AddObject(S, TObject(AXFormClass));
end;

Procedure RegisterAliasXForm(Const Name: String; AXFormClass: TComponentClass);
begin
  RegisterXFormList.AddObject(Name, TObject(AXFormClass));
end;

Procedure RegisterXForms(AClasses: array of TComponentClass);
var i: Integer;
begin
  for i:=Low(AClasses) to High(AClasses) do RegisterXForm(AClasses[i]);
end;

Procedure UnRegisterXForm(AXFormClass: TComponentClass);
begin
  RegisterXFormList.Delete(RegisterXFormList.IndexOfObject(TObject(AXFormClass)));
end;

Procedure UnRegisterNotAliasXForm(AXFormClass: TComponentClass);
var i: Integer;
begin
  i:=RegisterXFormList.IndexOfObject(TObject(AXFormClass));
  if RegisterXFormList.Strings[i]=AXFormClass.ClassName then RegisterXFormList.Delete(i);
end;

Procedure UnRegisterXForms(AClasses: array of TComponentClass);
var i: Integer;
begin
  for i:=Low(AClasses) to High(AClasses) do UnRegisterXForm(AClasses[i]);
end;

Procedure RegisterXTool(AXToolClass: TComponentClass);
var S: String;
begin
  S:=AXToolClass.ClassName;
  if UpCase(S[1])='T' then Delete(S,1,1);
  RegisterXToolList.AddObject(S, TObject(AXToolClass));
end;

Procedure RegisterAliasXTool(const Name: String; AXToolClass: TComponentClass);
begin
  RegisterXToolList.AddObject(Name, TObject(AXToolClass));
end;

Procedure UnRegisterXTool(AXToolClass: TComponentClass);
begin
  RegisterXToolList.Delete(RegisterXToolList.IndexOfObject(TObject(AXToolClass)));
end;

Procedure RegisterXSplash(AXSplashClass: TComponentClass);
begin
  RegisterXSplashList.AddObject(AXSplashClass.ClassName, TObject(AXSplashClass));
end;

Procedure RegisterAliasXSplash(Const Name: String; AXSplashClass: TComponentClass);
begin
  RegisterXSplashList.AddObject(Name, TObject(AXSplashClass));
end;

Procedure UnRegisterXSplash(AXSplashClass: TComponentClass);
begin
  RegisterXSplashList.Delete(RegisterXSplashList.IndexOfObject(TObject(AXSplashClass)));
end;

Function IsXFormClass(AClass: TClass; const ANameClass: String): Boolean;
begin
  Result:=False;
  while Assigned(AClass) do begin
    if AClass.ClassNameIs(ANameClass) then begin
      Result:=True;
      Exit;
    end;
    AClass:=AClass.ClassParent;
  end;
end;

Function LoadXComponentFromStream(aStream: TStream; aComponent: TPersistent; aRoot: TComponent;
             aReferenceNameEvent: TReferenceNameEvent; aSetNameEvent: TSetNameEvent; aFindMethodEvent: TFindMethodEvent; aErrorEvent: TReaderError): Boolean;
var aReader: TReader;
begin
  Result:= True;
  aReader:= TReader.Create(aStream, 1024);
  try
    if Assigned(aReferenceNameEvent) then
       AReader.OnReferenceName:= aReferenceNameEvent;
{    if Assigned(aSetNameEvent) then AReader.OnSetName    := aSetNameEvent;
    if Assigned(aFindMethodEvent) then AReader.OnFindMethod := aFindMethodEvent;
    if Assigned(aErrorEvent) then AReader.OnError:= aErrorEvent;}
    {reposition at beginning of stream}
    aStream.Seek(0, soFromBeginning);
    aReader.Root:= aRoot;
    aReader.BeginReferences;
    try
      aReader.ReadSignature;
      if aComponent is TComponent then {aComponent:=}aReader.ReadComponent(TComponent(aComponent))
        else
          if aComponent is TCollection then begin
            aReader.ReadValue;
            aReader.ReadCollection(TCollection(aComponent));
          end else Result:= False;
      if aStream.Position<aStream.Size then aReader.ReadListEnd;
      aReader.FixupReferences;
    finally
      aReader.EndReferences;
    end;
  finally
    aReader.Free;
  end;
end;

Function StoreXComponentToStream(aStream: TStream; aComponent: TPersistent; aRoot: TComponent): Boolean;
var aWriter: TWriter;
begin
  Result:= True;
  aWriter:= TWriter.Create(aStream, 1024);
  try
    aWriter.Root := ARoot;
    aWriter.WriteSignature;
    if aComponent is TComponent then aWriter.WriteComponent(TComponent(aComponent))
      else
        if aComponent is TCollection then aWriter.WriteCollection(TCollection(aComponent))
        else Result:= False;
    aWriter.WriteListEnd;
  finally
    aWriter.Free;
  end;
end;

Function IsCreateXCloneClass(var aCloneComponent: TComponent; aClass: TComponentClass; aRoot: TComponent): Boolean;
begin
  Result:= True;
  if not Assigned(aCloneComponent) then begin
    aCloneComponent:= aClass.Create(aRoot);
  end else if not(aCloneComponent is aClass) then Result:= False;
end;

Function IsCreateXCloneComponent(var aCloneComponent: TComponent; aComponent: TComponent; aRoot: TComponent): Boolean;
var aClass: TComponentClass;
begin
  Result:= True;
  if not Assigned(aCloneComponent) then begin
    aClass:= TComponentClass(aComponent.ClassType);
    aCloneComponent:= aClass.Create(aRoot);
  end else if not(aCloneComponent is aComponent.ClassType) then
  Result:= False;
end;

Function CloneXComponent(var aCloneComponent: TComponent; aComponent: TComponent; aRoot: TComponent): Boolean;
var aStream: TMemoryStream;
begin
  if (aComponent is TComponent) and
  (IsCreateXCloneComponent(aCloneComponent, aComponent, aRoot)) then begin
    Result:= True;
    aStream := TMemoryStream.Create;
    try
      StoreXComponentToStream(aStream, aComponent, aRoot);
      LoadXComponentFromStream(aStream, aCloneComponent, aRoot, nil, nil, nil, nil)
    finally
      aStream.Free;
    end;
  end else Result:=False;
end;

Function CloneXComponentToClass(var aCloneComponent: TComponent; aComponent: TComponent;
                                aClass: TComponentClass; aRoot: TComponent): Boolean;
begin
  if (aComponent is TComponent) and (IsCreateXCloneClass(aCloneComponent, aClass, aRoot)) then begin
    Result:= CloneXComponent(aCloneComponent, aComponent, aRoot);
  end else Result:= False;
end;

Function CloneXComponentAncestor(var aCloneComponent: TComponent; aComponent: TComponent;
                                 AncestorClass: TClass; aRoot: TComponent): Boolean;
var OldClass: TClass;
begin
  if (aComponent is AncestorClass) and
  (IsCreateXCloneComponent(aCloneComponent, aComponent, aRoot)) then begin
    OldClass:= PClass(aComponent)^;
    PClass(aComponent)^:= AncestorClass;
    try
      Result:= CloneXComponent(aCloneComponent, aComponent, aRoot);
    finally
      PClass(aComponent)^:= OldClass;
    end;
  end else Result:= False;
end;

Function CloneXComponentAncestorToClass(var aCloneComponent: TComponent; aComponent: TComponent;
                       AncestorClass, aClass: TComponentClass; aRoot: TComponent): Boolean;
begin
  if (aComponent is AncestorClass) and
  (IsCreateXCloneClass(aCloneComponent, aClass, aRoot)) then begin
    Result:= CloneXComponentAncestor(aCloneComponent, aComponent, AncestorClass, aRoot);
  end else Result:= False;
end;

Procedure AddCollection(Dest, Source: TCollection);
var i:Integer;
begin
  with Dest do begin
    BeginUpdate;
    try
      for i:=0 to TCollection(Source).Count-1 do
        Add.Assign(TCollection(Source).Items[i]);
    finally
      EndUpdate;
    end;
  end;
end;

Procedure CreateXLists;
begin
end;

Procedure FreeXLists;
begin
end;

Initialization
  RegisterXFormList:= TStringList.Create;
  RegisterXToolList:= TStringList.Create;
  RegisterXSplashList:= TStringList.Create;

  (*** FOR TEST!!!
  CaptureErrorMode:=true;
  if CaptureErrorMode then begin
    AssignFile(FFFF,'c:\temp\Error.rpt');
    Rewrite(FFFF);
  end;
  FOR TEST!!! ***)

Finalization
  RegisterXFormList.Free;
  RegisterXToolList.Free;
  RegisterXSplashList.Free;
  (*** FOR TEST!!! if CaptureErrorMode then CloseFile(FFFF); FOR TEST!!! ***)
end.
