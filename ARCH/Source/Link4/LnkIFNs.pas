{*******************************************************}
{                                                       }
{            X-library v.03.05                          }
{                                                       }
{   07.10.97                   				}
{                                                       }
{   TIFNItem - index names item                         }
{   TIFNLink - collection of TIFNItem's                 }
{   TLinkFilters - link adds to TEtvFilter              }
{   TFindLink - link of search in datasets              }
{   TCaclLink - link of calculation in datasets         }
{   TAggregateLink - common link of datasets            }
{                                                       }
{   Last corrections 23.10.98                           }
{                                                       }
{*******************************************************}
Unit LnkIFNs;

Interface

Uses Classes, DB, XMisc;

type

  TIFNLink = class;

{ TIFNItem }

  TIFNMode = (imFieldLabels, imFieldNames, imName, imDisplayName);

  TIFNItem = class(TSrcLinkItem)
  private
    FOptions: TIndexOptions;
    FName: String;
    FDisplayName: string;
    FFieldLabels: string;
    FFields: String;
    FOrders: String;
    FContexts: String;
    FOrderCalcs: TStringList;
    FContextCalcs: TStringList;
    function GetIFNLink: TIFNLink;
    procedure SetOrders(aValue: String);
    procedure SetContexts(aValue: String);
    procedure UpdateOrders(aDataSet: TDataSet);
    procedure UpdateOrderNames;
    procedure UpdateContexts(aDataSet: TDataSet);
    procedure UpdateContextNames;
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignIFNItem(AItem: TIFNItem); virtual;
    procedure AssignIndexDef(ADef: TIndexDef);
    function ChooseOrderFields(aDataSet: TDataSet; aCaption: String): Boolean;
    function ChooseContextFields(aDataSet: TDataSet; aCaption: String): Boolean;
    function GetString(aItems: TStrings; aLink: TSrcLinks): Integer; override;
    procedure ChangeFieldLabels(aDataset: TDataset);
    property IFNLink: TIFNLink read GetIFNLink;
    property OrderCalcs: TStringList read FOrderCalcs;
    property ContextCalcs: TStringList read FContextCalcs;
    property FieldLabels: string read FFieldLabels write FFieldLabels;
  published
    property DisplayName;
{    property Caption: string read FCaption write FCaption;}
    property Name: string read FName write FName;
    property Fields: String read FFields write FFields;
    property Options: TIndexOptions read FOptions write FOptions;
    property Orders: String read FOrders write SetOrders;
    property Contexts: String read FContexts write SetContexts;
  end;
  { TIFNItem }


{ TIFNLink}
  TIFNLink = class(TSrcLinks)
  private
    FOnlyUnique: Boolean;
    FDefLink: Boolean;
    FOwner: TPersistent;
    FMode: TIFNMode;
    FDataset: TDataset;
    function GetItem(Index: Integer): TIFNItem;
    procedure SetItem(Index: Integer; Value: TIFNItem);
    procedure SetMode(Value: TIFNMode);
    procedure SetDefLink(Value: Boolean);
  protected
    procedure SetCurrentIndex(aIndex: Integer); override;
  public
    procedure Assign(Source: TPersistent); override;
    function GetOwner: TPersistent; override;
    constructor Create(AOwner: TPersistent);
    function Add: TIFNItem;
    function IndexOfName(Const AName: String): Integer;
    function IndexOfFields(Const AFieldNames: String): Integer;
    procedure GetString(aItems: TStrings; aSrcLinkItem: TSrcLinkItem);override;
    procedure ChangeFieldLabels(aDataset: TDataset);
    procedure IncOwner;
    procedure RestoreOwner(AOwner: TPersistent);
    property Items[Index: Integer]: TIFNItem read GetItem write SetItem; default;
    property Dataset: TDataset read FDataset write FDataset;
  published
    property DefLink: Boolean read FDefLink write SetDefLink default True;
    property Mode: TIFNMode read FMode write SetMode default imFieldLabels;
    property OnlyUnique: Boolean read FOnlyUnique write FOnlyUnique default False;
  end;
{ TIFNLink}

Implementation

Uses SysUtils;

{ TIFNItem }

constructor TIFNItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOrderCalcs:= TStringList.Create;
  FContextCalcs:= TStringList.Create;
end;

destructor TIFNItem.Destroy;
begin
  FContextCalcs.Free;
  FOrderCalcs.Free;
  Inherited Destroy;
end;

function TIFNItem.GetDisplayName: string;
begin
  Result:= FDisplayName;
end;

procedure TIFNItem.SetDisplayName(const Value: String);
begin
  FDisplayName:= Value;
end;

function TIFNItem.GetString(aItems: TStrings; aLink: TSrcLinks): Integer;
var i: Integer;
    aDataset: TDataset;
begin
  Result:= -1;
  for i:= 0 to aItems.Count-1 do begin
    if (aItems.Objects[i] is TIFNItem)and
    (AnsiCompareText(TIFNItem(aItems.Objects[i]).Fields, Fields)=0) then begin
      Result:= i;
      Break;
    end;
  end;
  if (Result=-1)and(aLink is TIFNLink)and(TIFNLink(aLink).FOwner is TAggregateLink) then begin
    aDataset:= TAggregateLink(TIFNLink(aLink).FOwner).GetLinkDataset;
    ChangeFieldLabels(aDataset);
    aLink.GetString(aItems, Self);
    Result:= aItems.Count-1;
  end;
end;

procedure TIFNItem.ChangeFieldLabels(aDataset: TDataset);
var i: Integer;
    S: String;
    aField: TField;
begin
  if Assigned(aDataset) then begin
    S:= '';
    i := 1;
    while i <= Length(Fields) do begin
      if S<>'' then S:= S+'; ';
      aField:= aDataSet.FindField(ExtractFieldName(Fields, i));
      if Assigned(aField) then S:= S+aField.DisplayLabel;
    end;
    FieldLabels:= S;
  end;
end;

function TIFNItem.GetIFNLink: TIFNLink;
begin
  Result:= TIFNLink(Collection);
end;

procedure TIFNItem.AssignIFNItem(AItem: TIFNItem);
begin
  DisplayName:= AItem.DisplayName;
  Name:= AItem.Name;
  Fields:= AItem.Fields;
  Options:= aItem.Options;
  Orders:= aItem.Orders;
  Contexts:= aItem.Contexts;
end;

procedure TIFNItem.Assign(Source: TPersistent);
begin
  if Source is TIFNItem then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      AssignIFNItem(TIFNItem(Source));
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else inherited Assign(Source);
end;

procedure TIFNItem.AssignIndexDef(ADef: TIndexDef);
begin
  if Assigned(Collection) then Collection.BeginUpdate;
  try
    Name:= ADef.Name;
    Fields:= ADef.Fields;
    Options:= aDef.Options;
  finally
    if Assigned(Collection) then Collection.EndUpdate;
  end;
end;

procedure TIFNItem.SetOrders(aValue: String);
begin
  if aValue<>FOrders then begin
    FOrders:= aValue;
  end;
end;

procedure TIFNItem.SetContexts(aValue: String);
begin
  if aValue<>FContexts then begin
    FContexts:= aValue;
  end;
end;

procedure TIFNItem.UpdateOrders(aDataSet: TDataSet);
var i: Integer;
    S, S1: String;
    aList: TStringList;
    aFieldList: TList;
begin
  aFieldList:= TList.Create;
  try
    aList:= FOrderCalcs;
    S:= FOrders;
  {  UpdateFields;}
    if (FFields<>'') and Assigned(aDataSet) then begin
      aDataSet.GetFieldList(aFieldList, FFields);
    end;

    aList.Clear;
    while Length(S)>0 do begin
      if aList.Count>aFieldList.Count then Break;
      i:= Pos(';',S);
      if i>0 then begin
        if i=1 then S1:='' else S1:= copy(S,1,i-1);
        Delete(S,1,i);
      end else begin
        S1:= S;
        S:='';
      end;
      aList.Add(S1);
    end;
    if aList.Count<aFieldList.Count then
      for i:= aList.Count to aFieldList.Count-1 do aList.Add('');
  finally
    aFieldList.Free;
  end;
end;

procedure TIFNItem.UpdateOrderNames;
var i: Integer;
begin
  FOrders:= '';
  for i:=0 to OrderCalcs.Count-1 do begin
    FOrders:= FOrders+OrderCalcs[i]+';';
  end;
  if FOrders<>'' then Delete(FOrders, Length(FOrders),1);
end;

function TIFNItem.ChooseOrderFields(aDataSet: TDataSet; aCaption: String): Boolean;
var aDst, aSrc: String;
begin
  Result:= False;
  UpdateOrders(aDataset);
  aDst:= Fields;
  if ChooseOrderIndexFields(aDataSet, aDst, aSrc, OrderCalcs, aCaption) then begin
    if Fields<>aDst then Result:= True;
  end;
  if Result then begin
    UpdateOrderNames;
    Fields:= aDst;
  end;
end;

procedure TIFNItem.UpdateContexts(aDataSet: TDataSet);
var i: Integer;
    S, S1: String;
    aList: TStringList;
    aFieldList: TList;
begin
  aFieldList:= TList.Create;
  try
    aList:= FContextCalcs;
    S:= FContexts;
  {  UpdateFields;}
    if (FFields<>'')and Assigned(aDataSet) then begin
      aDataSet.GetFieldList(aFieldList, FFields);
    end;

    aList.Clear;
    while Length(S)>0 do begin
      if aList.Count>aFieldList.Count then break;
      i:= Pos(';',S);
      if i>0 then begin
        if i=1 then S1:='' else S1:= copy(S,1,i-1);
        Delete(S,1,i);
      end else begin
        S1:= S;
        S:='';
      end;
      aList.Add(S1);
    end;
    if aList.Count<aFieldList.Count then
      for i:= aList.Count to aFieldList.Count-1 do aList.Add('');
  finally
    aFieldList.Free;
  end;
end;

Procedure TIFNItem.UpdateContextNames;
var i: Integer;
begin
  FContexts:= '';
  for i:=0 to OrderCalcs.Count-1 do FContexts:= FContexts+ContextCalcs[i]+';';
  if FContexts<>'' then Delete(FContexts, Length(FContexts),1);
end;

Function TIFNItem.ChooseContextFields(aDataSet: TDataSet; aCaption: String): Boolean;
var aDst, aSrc: String;
begin
  Result:= False;
  UpdateContexts(aDataset);
  aDst:= Fields;
  if ChooseContextIndexFields(aDataSet, aDst, aSrc, ContextCalcs, aCaption) then
    Result:= True;
  if Result then begin
    UpdateContextNames;
    Fields:= aDst;
  end;
end;

{ TIFNLink }

Constructor TIFNLink.Create(AOwner: TPersistent);
begin
  inherited Create(TIFNItem);
  FOwner := AOwner;
  FDefLink:= True;
  FMode:= imFieldLabels;
  FOnlyUnique:= False;
end;

Function TIFNLink.Add: TIFNItem;
begin
  Result := TIFNItem(inherited Add);
end;

procedure TIFNLink.Assign(Source: TPersistent);
begin
  if Source is TIFNLink then begin
    BeginUpdate;
    try
      FDefLink:= TIFNLink(Source).FDefLink;
      FMode:= TIFNLink(Source).FMode;
      FOnlyUnique:= TIFNLink(Source).FOnlyUnique;
    finally
      EndUpdate;
    end;
  end;
  inherited Assign(Source);
end;

procedure TIFNLink.SetDefLink(Value: Boolean);
begin
  FDefLink:= Value;
end;

procedure TIFNLink.SetMode(Value: TIFNMode);
begin
  if (Value <> FMode) then begin
    FMode := Value;
    {!!! if not (csLoading in LinkSource.ComponentState) then}
    Changed;
  end;
end;

function TIFNLink.GetItem(Index: Integer): TIFNItem;
begin
  Result := TIFNItem(inherited GetItem(Index));
end;

function TIFNLink.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure GetIndexNames(ADataSet: TDataSet; ANames: TStrings; AItems: TIFNLink;
                        AIFNMode: TIFNMode; IsOnlyUnique: Boolean);
var i: Integer;
    AFld: string;
    Pos: Integer;
begin
  ANames.Clear;
  for i:= 0 to AItems.Count-1 do begin
    if (Not IsOnlyUnique)or(IsOnlyUnique and (ixUnique in aItems[i].Options)) then
      case AIFNMode of
        imFieldLabels:
          if ANames.IndexOf(AItems[i].FieldLabels)<0 then
            ANames.AddObject(AItems[i].FieldLabels, AItems[I]);
        imFieldNames:
          if ANames.IndexOf(AItems[i].Fields)<0 then
            ANames.AddObject(AItems[i].Fields, AItems[I]);
        imName:
          if ANames.IndexOf(AItems[i].Name)<0 then
            ANames.AddObject(AItems[i].Name, AItems[I]);
        imDisplayName:
          if ANames.IndexOf(AItems[i].DisplayName)<0 then
            ANames.AddObject(AItems[i].DisplayName, AItems[I]);
      end;
  end;    
end;
{
procedure TIFNLink.GetStrings(ADataSet: TDataSet; ANames: TStrings);
begin
  GetIndexNames(aDataset, aNames, Self, FMode, FOnlyUnique);
end;}


procedure TIFNLink.GetString(aItems: TStrings; aSrcLinkItem: TSrcLinkItem);
begin
  if aSrcLinkItem is TIFNItem then
    case FMode of
      imFieldLabels: aItems.AddObject(TIFNItem(aSrcLinkItem).FieldLabels, aSrcLinkItem);
      imFieldNames: aItems.AddObject(TIFNItem(aSrcLinkItem).Fields, aSrcLinkItem);
      imName: aItems.AddObject(TIFNItem(aSrcLinkItem).Name, aSrcLinkItem);
      imDisplayName: aItems.AddObject(TIFNItem(aSrcLinkItem).DisplayName, aSrcLinkItem);
    end;
end;

procedure TIFNLink.ChangeFieldLabels(aDataset: TDataset);
var i: Integer;
begin
  for i:=0 to Count-1 do Items[i].ChangeFieldLabels(aDataset);
end;

procedure TIFNLink.SetCurrentIndex(aIndex: Integer);
begin
  if (FOwner is TAggregateLink)and(aIndex<>-1)and(CurrentIndex<>aIndex) then
    TAggregateLink(FOwner).ChangeCommonIFN(Items[aIndex]);
  Inherited;
end;

type
  TSelfPersistent = class(TPersistent)
  end;

procedure TIFNLink.IncOwner;
begin
  if Assigned(FOwner) then FOwner:=TSelfPersistent(FOwner).GetOwner;
end;

procedure TIFNLink.RestoreOwner(AOwner: TPersistent);
begin
  FOwner:= AOwner;
end;

procedure TIFNLink.SetItem(Index: Integer; Value: TIFNItem);
begin
  inherited SetItem(Index, Value);
end;

function TIFNLink.IndexOfName(Const AName: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (AnsiCompareText(Items[i].Name, AName)=0) then begin
      Result:=i;
      Break;
    end;
end;

function TIFNLink.IndexOfFields(Const AFieldNames: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (AnsiCompareText(Items[i].Fields, AFieldNames)=0) then begin
      Result:=i;
      Break;
    end;
end;

end.
