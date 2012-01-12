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
{   TCalcLink - link of calculation in datasets         }
{   TAggregateLink - common link of datasets            }
{                                                       }
{   Last corrections 23.10.98                           }
{                                                       }
{*******************************************************}
Unit LnkMisc;

Interface

Uses Classes, Controls, Forms, DB, DBTables, Messages, ppTypes, EtvFilt, XMisc,
     LnTables, XDBMisc, EtvGrid;


Type

(*
  TFieldResult = class(TObject)
  private
    FFieldName: string[50]; { Имя поля, с которым связана функция }
    FFuncName: string[25];  { Имя функции, назначенной для этого поля }
  public
    property FieldName: String[50] read FFieldName write FFieldName;
    property FuncName:  String[25] read FFuncName write FFuncName;
  end;

  TFieldResult=array[1..MaxFieldResult] of RFieldResult;
*)

  TIFNLink = class;
  TAggregateLink = class;

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
    procedure UpdateOrders(aDataSet: TDataSet);
    procedure UpdateOrderNames;
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
{ TIFNLink }

{ TLinkFilters }

  TLinkFilters = class(TPersistent)
  private
    FData: TEtvFilter;
    procedure OldReadData(Stream: TStream);
    procedure OldReadData1(Stream: TStream);
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
    {procedure CreateQExtracts(Sender: TObject);}
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Data: TEtvFilter read FData write FData;

  end;
{ TLinkFilters }

{ TFindLink }

  TFindLink = class;

  TStartFindEvent = procedure (aLink: TFindLink;
                               aFindValues: TStrings;
                           var aMaxLabelWidth,
                               aMaxEditWidth: Integer;
                           var aIsFindStored: Boolean) of object;

  TFindLink = class(TPersistent)
  private
    FIsFindStored: Boolean;
    FIsSetRange: Boolean;
    FIsFirstFind: Boolean;
    FIsLikeFind: Boolean;
    FIFNCheck: Boolean;
    FIFNStored: String;
    FKeyCountStore: Integer;
    FLinkState: TLinkSetState;
    FLikeState: TXAlignment;
    FIFNItem: TIFNItem;
    FIFNUnique: TIFNItem;
    FIFNLink: TIFNLink;
    FMaxLabelWidth: Integer;
    FMaxEditWidth: Integer;
    FFinds: TStrings;
    FModelDataset: TDataset;
    FModelTableName: String;
    FModelFieldNames: String;
    FModelState: TLinkSetState;
    FFindDataset :TDBDataset;
    FFindState: TLinkSetState;
    FLikeQuery: TLnQuery;
    FLikeList: TList;
    FLikeFields: String;
    FFindValues: TStrings;
    FLikeValues: TStringList;
    FLikePatterns: TStringList;
    FLikes: Variant;
    FOnStartFind: TStartFindEvent;
    function GetIFN: String;
    procedure SetIFN(Value: String);
    procedure SetFinds(AItems: TStrings);
    procedure InitLikeQuery(aDataset: TDataset);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function Execute(aDataSet: TDataset; aTableName, aFieldNames: String;
             aIFNItem, aIFNUnique: TIFNItem; aIFNLink: TIFNLink): Boolean;
    procedure InitLikes(aDataset: TDataSet);
    function ChangeLikeQuery(aDataSet: TDataSet; Const aTableName, aFieldsName: String; Const aStr:String): Boolean;
    procedure SetFindState;
    procedure GotoCurrentFind(IsGoto: Boolean);
    function GetFindValues: Variant;
    procedure GetFindStrings(aFindValues: TStrings);
    procedure ChangeFindLikeValues(aValues: Variant);
    procedure ChangeFindLikeStrings(aStrings: TStrings);
    function SetFindRange(aValues: Variant): Boolean;
    procedure CancelFindRange;
    procedure CancelFind;
    function GotoNearestFind: Boolean;

    property ModelDataset: TDataset read FModelDataset write FModelDataset;
    property ModelState: TLinkSetState read FModelState;
    property ModelTableName: String read FModelTableName;
    property ModelFieldNames: String read FModelFieldNames;
    property FindDataset: TDBDataset read FFindDataset write FFindDataset;
    property FindState: TLinkSetState read FFindState;
    property LikePatterns: TStringList read FLikePatterns;
    property LikeFields: String read FLikeFields write FLikeFields;
    property FindValues: TStrings read FFindValues;
    property LikeValues: TStringList read FLikeValues;
    property LikeQuery: TLnQuery read FLikeQuery write FLikeQuery;
    property LikeList: TList read FLikeList write FLikeList;
    property IsFindStored: Boolean read FIsFindStored write FIsFindStored;
    property IsFirstFind: Boolean read FIsFirstFind write FIsFirstFind;
    property IsLikeFind: Boolean read FIsLikeFind write FIsLikeFind;
    property IFN: String read GetIFN write SetIFN;
    property IFNLink: TIFNLink read FIFNLink;
    property IFNStored: String read FIFNStored write FIFNStored;
    property OnStartFind: TStartFindEvent read FOnStartFind write FOnStartFind;
  published
    property Finds: TStrings read FFinds write SetFinds;
    property LinkState: TLinkSetState read FLinkState write FLinkState default ltNone;
    property LikeState: TXAlignment read FLikeState write FLikeState default xaMiddle;
    property IFNCheck: Boolean read FIFNCheck write FIFNCheck stored False;
    property IFNItem: TIFNItem read FIFNItem write FIFNItem;
    property IFNUnique: TIFNItem read FIFNItem write FIFNItem;
    property MaxLW: Integer read FMaxLabelWidth write FMaxLabelWidth default 0;
    property MaxEW: Integer read FMaxEditWidth write FMaxEditWidth default 0;
    property IsSetRange: Boolean read FIsSetRange write FIsSetRange default False;
  end;
{ TFindLink }

{ TCalcLink }
  TXTypeResult = (rsNone, rsGlobal, rsLocal);
  TCalcLinkType = dcCount..dcAverage;
  TCalcLinkOption = (coResult, coVisible, coAggregate, coAggregateUnion, coAggregateUnionTotal);

  TCalcLink = class(TPersistent)
{ private}
  public
    FTypeResult: TXTypeResult;
    FFieldNames: String;
    FResCalcNames: String;
    FVisCalcNames: String;
    FAgrCalcNames: String;
    FGroupByNames: String;
    FFields: TList;
    FResCalcs: TStringList;
    FVisCalcs: TStringList;
    FAgrCalcs: TStringList;
    FAgrGroupByCalcs: TStringList;
    FDataSet: TDataSet;
    FAgrLink: TAggregateLink; { Объект, который его создает }
    FSumCalcAuto: boolean; { False - нет автосуммирования, True - автосуммирование при выполнении запроса }
(*  FListTotal: TListTotal; { Функции на столюцы } *)
    procedure SetFieldNames(aValue: String);
    procedure SetResCalcNames(aValue: String);
    procedure SetVisCalcNames(aValue: String);
    procedure SetAgrCalcNames(aValue: String);
    procedure SetDataSet(aValue: TDataSet);
    procedure SetSumCalcAuto(aValue: boolean);
  { old funcs }
    function GetSumCalc: String;
    procedure SetSumCalc(aValue: String);
  public
    constructor Create(AOwner: TAggregateLink);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure UpdateFields(AddNames: String);
    procedure UpdateAggrFields(AddNames: String);
    procedure UpdateCalcs(aOption: TCalcLinkOption; AddNames: String);
    procedure UpdateCalcNames(aOption: TCalcLinkOption);
    procedure Clear;
    function GetCalcFields(aOption: TCalcLinkOption; aCalcName: String;
                AddNames: String): TList;
    function GetCalcFieldNames(aOption: TCalcLinkOption; aCalcName: String;
                aAllFields: Boolean; aSepChar: Char;
                AddNames: String): String;
    function GetFromGroupByNames: String;
    procedure SetCalcFieldNames(aOption: TCalcLinkOption; aCalcName, aFieldNames: String);
    function ChooseFields(aDataSet: TDataSet; aCalcOption: TCalcLinkOption; aCaption: String;
                   IsChangeVisible: Boolean): Boolean;
    function ChooseGroupBy(aDataSet: TDataSet; aCaption: String): Boolean;
    property Fields: TList read FFields;
    property ResCalcs: TStringList read FResCalcs;
    property VisCalcs: TStringList read FVisCalcs;
    property AgrCalcs: TStringList read FAgrCalcs;
    property AgrGroupByCalcs: TStringList read FAgrGroupByCalcs;
    property SumCalc: String read GetSumCalc write SetSumCalc stored False;
    property AgrLink: TAggregateLink read FAgrLink write FAgrLink;
(*  property ListTotal: TListTotal read FListTotal write FListTotal; *)
  published
    property FieldNames: String read FFieldNames write SetFieldNames;
    property GroupByNames: String read FGroupByNames write FGroupByNames;
    property ResCalcNames: String read FResCalcNames write SetResCalcNames;
    property VisCalcNames: String read FVisCalcNames write SetVisCalcNames;
    property AgrCalcNames: String read FAgrCalcNames write SetAgrCalcNames;
    property TypeResult: TXTypeResult read FTypeResult write FTypeResult default rsNone;
    property DataSet: TDataSet read FDataSet write SetDataSet;
    property SumCalcAuto: boolean read FSumCalcAuto write SetSumCalcAuto;
  end;
{ TCalcLink }

{ TAggregateLink }

  TAggregateLink = class(TSrcLinkItem)
  private
    FActive: Boolean;
    FAggregated: Boolean;
    FAggrWithIndex: Boolean;
    FIsFind: Boolean;
    FAggrDataSet: TDataSet;
    FAggrSource: TDataSource;
    FDataSource: TDataSource;
    FIFNLink: TIFNLink;
    FCurrentIFNLink: TIFNLink;
    FFind: TFindLink;
    FCalc: TCalcLink;
    FIFNItem: TIFNItem;
    FFilters: TLinkFilters;
    FFilterStream: TMemoryStream;
    procedure SetIFNLink(AItems: TIFNLink);
    function IsIFNLinkStored: Boolean;
    function IsFiltersStored: Boolean;
    procedure SetFilters(Value: TLinkFilters);
    procedure SetAggregated(Value: Boolean);
    procedure ChangeCommonIFN(aItem: TIFNItem);
  protected
    function GetLinkTableName: String; virtual;
    function GetLinkDataset: TDataset; virtual;
    property ActiveOwner: Boolean read FActive write FActive default False;
  public
    { Генерится текст запроса с группировкой по установкам пользователя }
    Function GetQueryTextOfGroupBy:string;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignLinkItem(AItem: TAggregateLink); virtual;
    function ChangeVisible: Boolean;
    procedure StoreVisible;
    function ChooseOrderFields(aCaption: String): Boolean;
    function ChooseContextFields(aCaption: String): Boolean;
    function ChooseCalcLinkFields(aCalcOption: TCalcLinkOption; aCaption: String;
                   IsChangeVisible: Boolean): Boolean;
    function ChooseGroupByCalcLinkFields(aCaption: String): Boolean;
    procedure GetIFNStrings(ANames: TStrings);
    procedure DefFillIndexList(AItems: TIFNLink); virtual;
    procedure OwnerFillIndexList(AItems: TIFNLink); virtual;
    procedure FillIndexList(AItems: TIFNLink);
    procedure FillIndexListCurrent;
    procedure ChangeLinkIFN(const aIFN: String); virtual;

    property IsFind: Boolean read FIsFind write FIsFind;
    property CurrentIFNLink: TIFNLink read FCurrentIFNLink;
    property AggrTemp: Boolean read FAggregated write FAggregated;
    property AggrDataSet: TDataset read FAggrDataSet;
    property AggrSource: TDataSource read FAggrSource;
    property DataSource: TDataSource read FDataSource write FDataSource;
    { Дополнительные фильтры, определяемые пользователем на RunTime }
    property FilterStream:TMemoryStream read FFilterStream write FFilterStream;
  published
    property Aggregated: Boolean read FAggregated write SetAggregated default False;
    property AggrWithIndex: Boolean read FAggrWithIndex write FAggrWithIndex default False;
    property IFNLink: TIFNLink read FIFNLink write SetIFNLink stored IsIFNLinkStored;
    property IFNItem: TIFNItem read FIFNItem write FIFNItem;
    property Find: TFindLink read FFind write FFind;
    property Calc: TCalcLink read FCalc write FCalc;
    property Filters: TLinkFilters read FFilters write SetFilters stored IsFiltersStored;
  end;
{ TAggregateLink }

procedure GetIndexNames(ADataSet: TDataSet; ANames: TStrings; AItems: TIFNLink;
                        AIFNMode: TIFNMode; IsOnlyUnique: Boolean);
Procedure SendChangeControlSource(aForm: TCustomForm; wValue, lValue: TDataSource);

Implementation

Uses TypInfo, Windows, SysUtils, BDE, BDEConst, Dialogs, FindDlgc, EtvDBFun, EtvOther,
     EtvPas, VgUtils, XApps, XCracks, {XDBTFC, XForms,} EtvTemp;

Procedure SendChangeControlSource(aForm: TCustomForm; wValue, lValue: TDataSource);
var i: Integer;
begin
  for i:=0 to aForm.ComponentCount-1 do
    if aForm.Components[i] is TWinControl then
      PostMessage(TWinControl(aForm.Components[i]).Handle, wm_ChangeControlSource,
      LongInt(wValue), LongInt(lValue));
end;

{ TIFNItem }

Constructor TIFNItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FOrderCalcs:= TStringList.Create;
  FContextCalcs:= TStringList.Create;
end;

Destructor TIFNItem.Destroy;
begin
  FContextCalcs.Free;
  FOrderCalcs.Free;
  Inherited Destroy;
end;

Function TIFNItem.GetDisplayName: string;
begin
  Result:= FDisplayName;
end;

Procedure TIFNItem.SetDisplayName(const Value: String);
begin
  FDisplayName:= Value;
end;

Function TIFNItem.GetString(aItems: TStrings; aLink: TSrcLinks): Integer;
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
  if (Result=-1) and (aLink is TIFNLink) and (TIFNLink(aLink).FOwner is TAggregateLink) then begin
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
  FieldLabels:=AItem.FieldLabels;
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
(*
    { Инициализация FFields }
    FFields:=SortingFromDataSet(aDataSet);
    S:=FFields;
*)
    { UpdateFields;}
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

procedure TIFNItem.UpdateOrderNames;
var i: Integer;
begin
  FOrders:= '';
  for i:=0 to OrderCalcs.Count-1 do FOrders:= FOrders+OrderCalcs[i]+';';
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
    if (FFields<>'')and Assigned(aDataSet) then
      aDataSet.GetFieldList(aFieldList, FFields);

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

procedure TIFNItem.UpdateContextNames;
var i: Integer;
begin
  FContexts:= '';
  for i:=0 to OrderCalcs.Count-1 do FContexts:= FContexts+ContextCalcs[i]+';';
  if FContexts<>'' then Delete(FContexts, Length(FContexts),1);
end;

function TIFNItem.ChooseContextFields(aDataSet: TDataSet; aCaption: String): Boolean;
var aDst, aSrc: String;
begin
  Result:= False;
  UpdateContexts(aDataset);
  aDst:= Fields;
  if ChooseContextIndexFields(aDataSet, aDst, aSrc, ContextCalcs, aCaption) then Result:= True;
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
  Result:=TIFNItem(inherited Add);
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
begin
  ANames.Clear;
  for i:= 0 to AItems.Count-1 do begin
    if (not IsOnlyUnique) or (IsOnlyUnique and (ixUnique in aItems[i].Options)) then
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
  if (FOwner is TAggregateLink) and (aIndex<>-1) and (CurrentIndex<>aIndex) then
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

{ TLinkFilter }

Constructor TLinkFilters.Create;
begin
  Inherited Create;
  FData:=TEtvFilter.Create(nil);
  FData.FilterSetAs:=fsTryFilter;
  {FData.FilterSetAs:=fsQueryFilter;}
  {FData.OnCreateQExtracts:=CreateQExtracts;}
end;

Type TEtvFilterSelf=class(TEtvFilter);

{
Procedure TLinkFilters.CreateQExtracts(Sender: TObject);
begin
  with TEtvFilterSelf(Sender) do begin
    QExtracts:=TDataSet(
      TDBFormControl(TXForm(Screen.ActiveForm).FormControl).
        ActivateMainQuery(nil, CreateSQLText(DataSet,GetTableName,'EFilter',
          ConstructSQLFilter(fuSet),
          SortingFromDataSet(DataSet),TableNameKind,FieldNameKind),false));
  end;
end;
}
Destructor TLinkFilters.Destroy;
begin
  if Assigned(FData) then FData.Free;
  Inherited;
end;

procedure TLinkFilters.ReadData(Stream: TStream);
begin
  FData.LoadFromStream(Stream);
end;

Procedure TLinkFilters.OldReadData(Stream: TStream);
{function TEtvFilter.LoadFromStream(Stream: TStream):string;}
var lFiltersCount,lConditionsCount,lDataSetsCount,i,j:integer;
    lFilterItem:TFilterItem;
    lConditionItem:TConditionItem;
    aName: String;
    aCurFilter: SmallInt;
    {lSubDataSets:TStringList;}

  Function LoadStr:string;
  var Size:integer;
  begin
    Stream.Read(Size,sizeof(Integer));
    SetString(Result, nil, Size);
    Stream.Read(Pointer(Result)^, Size);
  end;

  Function LoadVariant:variant;
  var Size:integer;
      IsPointer:boolean;
  begin
    Stream.Read(IsPointer,Sizeof(IsPointer));
    if IsPointer then Result:=LoadStr
    else begin
      Stream.Read(Size,sizeof(Integer));
      Stream.Read(TVarData(Result), Size);
    end;
  end;

begin
  with FData do begin
{!  Result:='';}
  {lSubDataSets:=TStringList.Create;}
    ClearAllFilters;
    with Stream do begin
      aName{Result}:=LoadStr;
      {read(lSubDataSetsCount,sizeof(Integer));
      for i:=0 to lSubDataSetsCount-1 do
        lSubDataSets.Add(LoadStr);}
      Read(aCurFilter,sizeof(aCurFilter));
      Read(lFiltersCount,sizeof(Integer));
      for i:=0 to lFiltersCount-1 do begin
        lFilterItem:=TFilterItem.Create;
        with lFilterItem do begin
          Name:=LoadStr;
          Read(AutoTotal,Sizeof(boolean));
          (* Read DataSets *)
          Read(lDataSetsCount,SizeOf(Integer));
          for j:=0 to lDataSetsCount-1 do begin
            if DataSets.Count-1<j then DataSets.Add(TDataSetItem.Create);
            with TDataSetItem(DataSets[j]) do begin
              Total:=LoadStr;
              Read(All,Sizeof(boolean));
            end;
          end;
          (* Read Conditions *)
          Read(lConditionsCount,sizeof(Integer));
          for j:=0 to lConditionsCount-1 do begin
            lConditionItem:=TConditionItem.Create;
            with lConditionItem do begin
              TableName:=LoadStr;
              FieldName:=LoadStr;
              LookFieldName:=LoadStr;
              Operation:=LoadStr;
              Read(BothFields,Sizeof(boolean));
              Value:=LoadVariant;
            end;
            Conditions.Add(lConditionItem);
          end;
        end;
        Filters.Add(lFilterItem);
      end;
    end;
    {lSubDataSets.Free;}
    CurFilter:= aCurFilter;
  end;
end;

Procedure TLinkFilters.OldReadData1(Stream: TStream);
{function TEtvFilter.LoadFromStream(Stream: TStream):string;}
var lFiltersCount,lConditionsCount,lDataSetsCount,i,j:integer;
    lFilterItem:TFilterItem;
    lConditionItem:TConditionItem;
    aName: String;
    aCurFilter: SmallInt;
    {lSubDataSets:TStringList;}

  Function LoadStr:string;
  var Size:integer;
  begin
    Stream.Read(Size,SizeOf(Integer));
    SetString(Result, nil, Size);
    Stream.Read(Pointer(Result)^, Size);
  end;

  Function LoadVariant:variant;
  var Size:integer;
      IsPointer:boolean;
  begin
    Stream.Read(IsPointer,Sizeof(IsPointer));
    if IsPointer then Result:=LoadStr
    else begin
      Stream.Read(Size,sizeof(Integer));
      Stream.Read(TVarData(Result), Size);
    end;
  end;

begin
  with FData do begin
{!  Result:='';}
  {lSubDataSets:=TStringList.Create;}
    ClearAllFilters;
    with Stream do begin
      aName{Result}:=LoadStr;
      Read(aCurFilter,SizeOf(aCurFilter));
      Read(lFiltersCount,SizeOf(Integer));
      for i:=0 to lFiltersCount-1 do begin
        lFilterItem:=TFilterItem.Create;
        with lFilterItem do begin
          Name:=LoadStr;
          Read(AutoTotal,SizeOf(boolean));
          OtherInfo:=LoadStr;
          (* Read DataSets *)
          Read(lDataSetsCount,SizeOf(Integer));
          for j:=0 to lDataSetsCount-1 do begin
            if DataSets.Count-1<j then DataSets.Add(TDataSetItem.Create);
            with TDataSetItem(DataSets[j]) do begin
              Total:=LoadStr;
              Read(All,Sizeof(boolean));
              OtherInfo:=LoadStr;
            end;
          end;
          (* Read conditions *)
          Read(lConditionsCount,SizeOf(Integer));
          for j:=0 to lConditionsCount-1 do begin
            lConditionItem:=TConditionItem.Create;
            with lConditionItem do begin
              TableName:=LoadStr;
              FieldName:=LoadStr;
              LookFieldName:=LoadStr;
              Operation:=LoadStr;
              Read(BothFields,Sizeof(boolean));
              Value:=LoadVariant;
              OtherInfo:=LoadStr;
            end;
            Conditions.Add(lConditionItem);
          end;
        end;
        Filters.Add(lFilterItem);
      end;
    end;
    CurFilter:= aCurFilter;
  end;
end;

procedure TLinkFilters.WriteData(Stream: TStream);
begin
  FData.SaveToStream(Stream);
end;

procedure TLinkFilters.DefineProperties(Filer: TFiler);

  function DoWrite: Boolean;
  begin
    Result := FData.FilterExist;
  end;

begin
{  Filer.DefineBinaryProperty('Data', OldReadData, WriteData, False);
  Filer.DefineBinaryProperty('Link', ReadData, WriteData, DoWrite);}
  Filer.DefineBinaryProperty('Datas', ReadData, WriteData, DoWrite);
  Filer.DefineBinaryProperty('Data', OldReadData1, WriteData, False);
  Filer.DefineBinaryProperty('Link', OldReadData, WriteData, False);
end;

procedure TLinkFilters.Assign(Source: TPersistent);
var i, j: Integer;
    AList, BList: TList;
    AFilterItem, BFilterItem: TFilterItem;
    AConditionItem, BConditionItem: TConditionItem;
    aDatasetItem, bDatasetItem: TDatasetItem;
begin
  if Source is TLinkFilters then begin
{     Data.DataSource:= TLinkFilters(Source).Data.DataSource;}

    BList:= TLinkFilters(Source).Data.Filters;
    AList:= Data.Filters;
{---------------}
    for i:=0 to BList.Count-1 do begin
      AFilterItem:= TFilterItem.Create;
      BFilterItem:= TFilterItem(BList[i]);
      with AFilterItem do begin
        Name:= BFilterItem.Name;
        for j:=0 to BFilterItem.Conditions.Count-1 do begin
          AConditionItem:= TConditionItem.Create;
          BConditionItem:= BFilterItem.Conditions[j];
          with AConditionItem do begin
            TableName:=BConditionItem.TableName;
            FieldName:=BConditionItem.FieldName;
            LookFieldName:=BConditionItem.LookFieldName;
            Operation:=BConditionItem.Operation;
            BothFields:=BConditionItem.BothFields;
            Value:=BConditionItem.Value;
            OtherInfo:= bConditionItem.OtherInfo;
          end;
          Conditions.Add(AConditionItem);
        end;
        AutoTotal:= BFilterItem.AutoTotal;
        OtherInfo:= bFilterItem.OtherInfo;
{       Total:= BFilterItem.Total;}
        for j:=0 to BFilterItem.DataSets.Count-1 do begin
          {if j>0 then}
          aDatasetItem:= TDatasetItem.Create;
{         else aDatasetItem:=Datasets[0];}
          bDatasetItem:= BFilterItem.Datasets[j];
          with aDatasetItem do begin
            TableName:= bDatasetItem.TableName;
            Total:= bDatasetItem.Total;
            All:= bDatasetItem.All;
            OtherInfo:= bDatasetItem.OtherInfo
          end;
          {if j>0 then }Datasets.Add(aDatasetItem);
        end;
      end;
      AList.Add(AFilterItem);
    end;
    Data.CurFilter:=TLinkFilters(Source).Data.CurFilter;
{---------------}
  end;
end;

{ TFindLink }

Constructor TFindLink.Create;
begin
  inherited Create;
  FFinds:= TStringList.Create;
  FIFNItem:= TIFNItem.Create(Nil);
  FIFNUnique:= TIFNItem.Create(Nil);
  FIFNLink:= Nil;
  FIFNCheck:= False;
{  FIFN:= '';}
  FOnStartFind:=Nil;
  FIsFindStored:= False;
  FFindDataset:=Nil;
  FLikeQuery:=Nil;
  FLikePatterns:=Nil;
  FLikeValues:=Nil;
  FLikeList:=Nil;
  FLikeFields:='';
  FLinkState:= ltNone;
  FLikeState:= xaMiddle;
  FIsSetRange:= False;
  FIFNStored:= '';
end;

Destructor TFindLink.Destroy;
begin
  FIFNUnique.Free;
  FIFNItem.Free;
  FFinds.Free;
  {
  if Assigned(FindDataset) and not(csDestroying in FindDataset.ComponentState) then begin
    FindDataset.Free;
    FindDataset:=nil;
  end;
  if Assigned(FLikeQuery)and not(csDestroying in FLikeQuery.ComponentState) then begin
    FLikeQuery.Free;
    FLikeQuery:=Nil;
  end;
  }
  if Assigned(FLikeList) then begin
    FLikeList.Clear;
    FLikeList.Free;
    FLikeList:=Nil;
  end;
  if Assigned(FLikePatterns) then begin
    FLikePatterns.Clear;
    FLikePatterns.Free;
    FLikePatterns:=Nil;
  end;
  if Assigned(FLikeValues) then begin
    FLikeValues.Clear;
    FLikeValues.Free;
    FLikeValues:=Nil;
  end;
  inherited;
end;

Procedure TFindLink.SetFinds(AItems: TStrings);
begin
  FFinds.Assign(AItems);
end;

procedure TFindLink.Assign(Source: TPersistent);
begin
  if Source is TFindLink then begin
    MaxLW:= TFindLink(Source).MaxLW;
    MaxEW:= TFindLink(Source).MaxEW;
    LinkState:= TFindLink(Source).LinkState;
    LikeState:= TFindLink(Source).LikeState;
    IFNCheck:= TFindLink(Source).IFNCheck;
    IsSetRange:= TFindLink(Source).IsSetRange;
    Finds:= TFindLink(Source).Finds;
    FIFNItem.Assign(TFindLink(Source).FIFNItem);
  end else Inherited;
end;

function TFindLink.GetIFN: String;
begin
  Result:= FIFNItem.Fields;
end;

procedure TFindLink.SetIFN(Value: String);
begin
  FIFNItem.Fields:= Value;
end;

procedure TFindLink.InitLikeQuery(aDataset: TDataset);
begin
  if not Assigned(FLikeList) then FLikeList:=TList.Create;
  if not Assigned(FLikeQuery) then begin
    FLikeQuery:=TLnQuery.Create(aDataset.Owner);
    FLikeQuery.DatabaseName:=TDBDataSet(aDataset).DatabaseName;
    // Инициализация UniqueFields
    if aDataSet is TLnTable then
      FLikeQuery.UniqueFields:=TLnTable(aDataSet).UniqueFields
    else FLikeQuery.UniqueFields:=TLnQuery(aDataSet).UniqueFields;
    if not Assigned(FLikePatterns) then FLikePatterns:=TStringList.Create;
  end;
end;

procedure TFindLink.InitLikes(aDataset: TDataSet);
begin
  if not Assigned(FLikeQuery) then begin
    InitLikeQuery(aDataset);
    if not Assigned(FLikeValues) then FLikeValues:=TStringList.Create;
  end;
end;

procedure TFindLink.CancelFind;
var i: Integer;
begin
  IsFirstFind:=False;
  SetFindState;
  if IsLikeFind and (FKeyCountStore<LikeList.Count) then
    for i:=FKeyCountStore to LikeList.Count-1 do LikeList.Delete(FKeyCountStore);
end;

procedure TFindLink.ChangeFindLikeStrings(aStrings: TStrings);
var Priz: Boolean;
    aFields: String;
begin
  aFields:=IFN{GetTableIndexNames(aTable)};
  FKeyCountStore:=LikeList.Count;
  if FFindState=ltTable then
    TLnTable(FFindDataset).SetUniqueFieldList(LikeList, aFields);

  Priz:=IsNotEqualLinkStrings(aFields, FLikeFields, aStrings, FLikePatterns);
  if Priz then
    ChangeFindLikeQuery(LikeQuery, FModelTableName, FLikeFields, LikeList, FLikePatterns);
end;

procedure TFindLink.ChangeFindLikeValues(aValues: Variant);
var Priz: Boolean;
    aFields: String;
begin
  aFields:=IFN{GetTableIndexNames(aTable)};
  FKeyCountStore:=LikeList.Count;
  if FFindState=ltTable then
    TLnTable(FFindDataset).SetUniqueFieldList(LikeList, aFields);

  Priz:=IsNotEqualLinkValues(aFields, FLikeFields, aValues, FLikes);
  if Priz then
    ChangeFindLikeQueryVar(LikeQuery, FModelTableName, FLikeFields, LikeList, FLikes);
end;

function TFindLink.ChangeLikeQuery(ADataSet: TDataSet; Const aTableName, aFieldsName: String;
                                   Const AStr:String): Boolean;
var i: Integer;
begin
  Result:=False;
  LikeList.Clear;
  aDataSet.GetFieldList(LikeList, AFieldsName);
  if LikeList.Count>0 then begin
    LikeValues.Clear;
    LikeValues.Add(AStr);
    for i:=1 to LikeList.Count-1 do LikeValues.Add('');
    Result:=IsNotEqualLinkStrings(aFieldsName, FLikeFields, LikeValues, FLikePatterns);
    if Result then
      ChangeFindLikeQuery(LikeQuery, aTableName, FLikeFields, LikeList, FLikePatterns);
{     Result:=ChangeFindLikeQuery(LikeQuery, aTableName, AFieldsName, FLikeFields,
                                 LikeValues, LikeList, FLikePatterns);}
  end;
end;

type
  TCrackBDEDataset = class(TBDEDataset)
  end;

procedure TFindLink.SetFindState;
begin
{  EditKey;}
  TCrackBDEDataset(FFindDataset).SetKeyBuffer(kiLookup, False);
end;

procedure TFindLink.GotoCurrentFind(IsGoto: Boolean);

{ По-моему, Валера вызывает эту процедуру только для Table'ов }
{ Аналог процедуры TTable.GoToCurrent }
procedure GotoCurrent(aDataset, aLinkDataset: TDBDataSet);
begin
  with aDataset do begin
    CheckBrowseMode;
    aLinkDataset.CheckBrowseMode;
    if (AnsiCompareText(DatabaseName, aLinkDataset.DatabaseName) <> 0) then
      DatabaseError(STableMismatch);
    aLinkDataset.UpdateCursorPos;
    Check(DbiSetToCursor(Handle, aLinkDataset.Handle));
    try
      { Если не синхронизировать индексы, то Table'ы могут и не синхронизироваться }
      Resync([rmExact, rmCenter]);
    except
      { А теперь попробуем тоже самое с одинаковыми индексами }
      if TTable(aLinkDataSet).IndexName<>TTable(aDataSet).IndexName then
        TTable(aLinkDataSet).IndexName:=TTable(aDataSet).IndexName;
      if TTable(aLinkDataSet).IndexFieldNames<>TTable(aDataSet).IndexFieldNames then
        TTable(aLinkDataSet).IndexFieldNames:=TTable(aDataSet).IndexFieldNames;
      aLinkDataset.UpdateCursorPos;
      Check(DbiSetToCursor(Handle, aLinkDataset.Handle));
      Resync([rmExact, rmCenter]);
    end;
  end;
end;

begin
  try
  if IsGoto then begin
    if ((FModelState=ltTable)and(FFindState=ltTable)) or
      ((FModelState=ltQuery)and(FFindState=ltQuery)) then
        GoToCurrent(TDBDataSet(FModelDataset), TDBDataSet(FFindDataset));
  end;
  finally
    SetFindState;
  end;
end;

function TFindLink.GotoNearestFind: Boolean;
var i: Word;
begin
  i:=MessageDlg('Таких записей не найдено! Найти первое ближайшее?',
    mtInformation, [mbYes, mbNo, mbCancel], 0);
  if i in [mrYes, mrNo] then begin
    if FFindState=ltTable then begin
      TTable(FFindDataset).GotoNearest;
      if i=mrYes then TTable(FFindDataset).Prior;
    end;
    Result:= True;
  end else Result:=False;
end;

function TFindLink.GetFindValues: Variant;
var i:integer;
    Year,Month,Day: Word;
    MonthStr,DayStr:string[2];
    Delta: ShortInt;
begin
  if Assigned(FLikeList) and (FLikeList.Count>0) then begin
    SetFindState;
    { Корректировка на 2000 год }
    with FFindDataSet do
      for i:=0 to FieldCount-1 do
        if (Fields[i] is TDateTimeField) and not (Fields[i].IsNull)
        and not(Fields[i].FieldKind=fkCalculated) then with TDateTimeField(Fields[i]) do
(*
          if AsDateTime>38353{01.01.2005} {54789}{01.01.2050} then begin
            DecodeDate(AsDateTime,Year,Month,Day);
            AsDateTime:=StrToDate_(IntToStr(Day)+'.'+IntToStr(Month)+'.'+IntToStr(Year-100))+
            Frac(AsDateTime);
            {AsDateTime:=AsDateTime+36524;}
          end else
            if AsDateTime<18264 then begin
              DecodeDate(AsDateTime,Year,Month,Day);
              AsDateTime:=StrToDate_(IntToStr(Day)+'.'+IntToStr(Month)+'.'+IntToStr(Year+100))+
              Frac(AsDateTime);
              {AsDateTime:=AsDateTime+36524;}
            end;
*)                                           {01.01.2010}
        if (AsDateTime<18264) or (AsDateTime>40179{54789}) then begin
          if (AsDateTime<18264) then Delta:=100 else Delta:=-100;
          DecodeDate(AsDateTime,Year,Month,Day);
          if Day<10 then DayStr:='0'+IntToStr(Day) else DayStr:=IntToStr(Day);
          if Month<10 then MonthStr:='0'+IntToStr(Month) else MonthStr:=IntToStr(Month);
          AsDateTime:=StrToDate_(DayStr+'.'+MonthStr+'.'+IntToStr(Year+Delta))+Frac(AsDateTime);
        end;
    Result:=FFindDataset.FieldValues[{LikeFields}GetFieldNamesByList(LikeList, NULL)];
  end else Result:= Unassigned;
end;

procedure TFindLink.GetFindStrings(aFindValues: TStrings);
var
  i: Integer;
begin
  aFindValues.Clear;
  SetFindState;
  for i:=0 to LikeList.Count-1 do
    AFindValues.Add(TField(LikeList.Items[i]).AsString);
end;

procedure TFindLink.CancelFindRange;
begin
  if (FFindState=ltTable) and FIsSetRange then TTable(FFindDataset).CancelRange;
end;

function TFindLink.SetFindRange(aValues: Variant): Boolean;
var i, j: Integer;
    bValue: Variant;
    aStored: String;
    aPriz: Boolean;

Function SetFindValues(B: Boolean; var ai:Integer): Boolean;
var i: Integer;
    S: String;
    Field: TField;
    Check: TFieldNotifyEvent;
begin
  Result:=False;
  if VarIsArray(aValues) then
    for i:=0 to LikeList.Count-1 do begin
      S:=AValues[i];
      if ((s<>'') and (not(TComponent(LikeList.Items[i]) is TDateTimeField)))or
      ((TComponent(LikeList.Items[i])is TDateTimeField)and(s<>'  .  .  ')) then begin
        Field:=TField(LikeList.Items[i]);
        Check:=Field.OnValidate;
        Field.OnValidate:=nil;
        if B then
          if Field.DataType=ftString then Field.AsString:=S+#255
          else Field.AsString:=S
        else Field.AsString:=S;
        Field.OnValidate:=Check;
        Result:=True;
      end else Break;
              { TField(LikeList.Items[i]).AsString :='';}
    end
  else begin
    S:=AValues; i:=0;
    if ((s<>'') and (not(TComponent(LikeList.Items[i]) is TDateTimeField)))or
    ((TComponent(LikeList.Items[i])is TDateTimeField)and(s<>'  .  .  ')) then begin
      Field:=TField(LikeList.Items[i]);
      Check:=Field.OnValidate;
      Field.OnValidate:=nil;
      if B then
        if Field.DataType=ftString then Field.AsString:=S+#255
        else Field.AsString:=S
      else Field.AsString:=S;
      Field.OnValidate:=Check;
      Result:=True;
    end;
    i:=1;
  end;
  ai:=i;
end;

begin
  Result:= False;
  if FIsSetRange then begin
    if FFindState=ltTable then begin
      if IsLikeFind then begin
        SetFindState;
        Result:=SetFindValues(False, i);
        TTable(FFindDataset).KeyFieldCount:=i;
      end else begin
        TTable(FFindDataset).SetRangeStart;
        SetFindValues(False, i);
        TTable(FFindDataset).SetRangeEnd;
        Result:=SetFindValues(True, i);
        TTable(FFindDataset).KeyFieldCount:=i;
        TTable(FFindDataset).ApplyRange;
      end;

      if TTable(FFindDataset).RecordCount=0 then begin
        TTable(FFindDataset).CancelRange;
        if GotoNearestFind then GotoCurrentFind(True);
        IsFirstFind:=False;
        Result:= False;
      end;
    end;
  end else begin
    if IsLikeFind then begin

    end else begin
      if VarIsArray(aValues) then begin
        j:= -1;
{       i:= LikeList.Count-1;}
        for i:=0 to LikeList.Count-1 do
          if aValues[i]<>Null then Inc(j);
{         while i>0 do begin
            if aValues[i]<>Null then Break
            else Dec(i);
          end;}
        if j=0 then begin
          bValue:= aValues[0];
{           VarClear(aValues);
          aValues:= bValue;}
        end else begin
          bValue:= VarArrayCreate([0, j], varVariant);
          j:=-1;
          for i:=0 to LikeList.Count-1 do
            if aValues[i]<>Null then begin
              Inc(j);
              bValue[j]:= aValues[i];
            end;
        end;
        aStored:= GetFieldNamesByList(LikeList, aValues);
        aPriz:= (j+1<LikeList.Count);
        if aPriz then begin
          FIFNStored:= IFN;
          IFN:= aStored;
        end;
        if FFindState=ltTable then begin
          TTable(FFindDataset).IndexFieldNames:= IFN;
        end;
        Result:= FFindDataset.Locate(aStored, bValue,
                    [{loCaseInsensitive, }loPartialKey]);
        if not Result then
          if VarIsArray(aValues) then begin
            Result:= True;
            for j:= 0 to i do
              if TField(LikeList[j]).Value<>aValues[j{i}] then begin
                Result:= False;
                Break;
              end;
          end else
            if TField(LikeList[0]).Value=aValues[0] then Result:= True;
      end else Result:= FFindDataset.Locate(GetFieldNamesByList(LikeList, NULL), aValues,
                                 [{loCaseInsensitive, }loPartialKey]);
      if (not Result) and (not GotoNearestFind) then SetFindState
      else GotoCurrentFind(True);
      IsFirstFind:= False;
    end;
  end;
end;

Function TFindLink.Execute(aDataSet: TDataset; aTableName, aFieldNames: String;
                   aIFNItem, aIFNUnique: TIFNItem; aIFNLink: TIFNLink): Boolean;
var aFindDlg: TLnFindDlg;
begin
  if not Assigned(aDataset) then begin
    Result:= False;
    Exit;
  end;
  FFindValues:=TStringList.Create;
  try
    if Assigned(FOnStartFind) then
      FOnStartFind(Self, FFindValues, FMaxLabelWidth, FMaxEditWidth, FIsFindStored);
    aFindDlg:=TLnFindDlg.Create(nil{Application});

    if not Assigned(FFindDataset) then IFNItem.Assign(aIFNItem)
    else begin
      { Контроль, м.б. в основной DataSet'е изменилось подмножество данных
      { - фильтр наложили или поменяли
      { - индекс поменяли. Индекс проверяется дальше в процедуре GoToCurrentFind
      {}
      if aDataSet.Filtered then
        if aDataSet.Filter<>FFindDataSet.Filter then with FFindDataSet do begin
          Close;
          Filter:=aDataSet.Filter;
          Filtered:=true;
          Open;
        end else
      else { У главного DataSet'а фильтр сняли, а у FFindDataSet'а еще нет }
        if FFindDataSet.Filtered then with FFindDataSet do begin
          Close;
          Filtered:=false;
          Filter:='';
          Open;
        end;
      if FIFNCheck then IFNItem.Assign(aIFNItem);
    end;

    if aDataset is TQuery then begin
      FModelState:= ltQuery;
      if FLinkState=ltNone then FFindState:= ltQuery
      else FFindState:= FLinkState;
    end else
    if aDataset is TTable then begin
      FModelState:= ltTable;
      if FLinkState=ltNone then FFindState:= ltTable
      else FFindState:= FLinkState;
    end else begin
      FModelState:= ltNone;
      FFindState:= ltNone;
    end;

    if (FFindDataset is TLnTable) and (TLnTable(FFindDataset).CloneMaster=aDataset) then begin
      if TTable(FFindDataset).IndexFieldNames<>IFNItem.Fields then
        TTable(FFindDataset).IndexFieldNames:=IFNItem.Fields;
    end else

    if (FFindDataset is TLnQuery) and (TLnQuery(FFindDataset).CloneMaster=aDataset) then begin
      if aIFNItem.Fields<>IFNItem.Fields then SortingToDataSet(FFindDataSet,IFNItem.Fields,false,false)
    end else begin
      if Assigned(FFindDataset) and (not (csDestroying in FFindDataset.ComponentState)) then begin
        {FFindDataset.Active:= False;
        FFindDataset.Free;}
      end else begin
(*
          FFindDataset:= GetLinkCloneDataset(aDataset, FModelState, FFindState,
                         aTableName, aFieldNames, True{False}, True, IFNItem.Fields, True);
*)
          FFindDataSet:=GetCloneDataSet(aDataSet,GetFieldListExt(aDataSet,AllFields,false));
          if FFindState=ltQuery then TQuery(FFindDataset).RequestLive:= True;
        end;
      end;
    FFindDataset.Active:=True;
    InitLikeQuery(TDBDataset(aDataset));

    FIFNLink:= aIFNLink;
    FIFNUnique.Assign(aIFNUnique);
    FModelDataset:= aDataset;
    FModelTableName:= aTableName;
    FModelFieldNames:= aFieldNames;
    FIsFirstFind:=False;
    FKeyCountStore:=0;
    aFindDlg.FindLink:= Self;

    aFindDlg.IndexCombo.SrcLinkItem:=nil;
    aFindDlg.IndexCombo.SrcLinks:= FIFNLink;
    aFindDlg.IndexCombo.SrcLinkItem:= IFNItem;

    aFindDlg.InitParams;
    try
      aFindDlg.InitDlg;
      Result:=(aFindDlg.ShowModal=idOk);
      if Result then begin
         { новые значения в шаблон }
        GetFindStrings(FFindValues);
{         aFindDlg.GoFind;}
      end;
    finally
      FIFNLink:=nil;
      aFindDlg.DestroyDlg;
      aFindDlg.Free;
    end;
  finally
    FFindValues.Free;
    FFindValues:=nil;
  end;
end;

{
  case aCalcType of
    dcCount:;
    dcSum:;
    dcMinimum:;
    dcMaximum:;
    dcAverage:;
    end;
}
{ TCalcLink }

Constructor TCalcLink.Create(AOwner: TAggregateLink);
begin
  Inherited Create;
  FFields:= TList.Create;
  FResCalcs:= TStringList.Create;
  FVisCalcs:= TStringList.Create;
  FAgrCalcs:= TStringList.Create;
  FAgrGroupByCalcs:= TStringList.Create;
  FAgrLink:=AOwner;
(*
  FListTotal:=TListTotal.Create;
  { Для отладки обязательно удавить }
  if AliasName='LOC_GKSM' then begin
    FListTotal.SetItemValue('Проверка FlistTotal №1','Check FListTotal №1');
  end;
*)
  FTypeResult:= rsNone;
  FFieldNames:= '';
  FResCalcNames:= '';
  FVisCalcNames:= '';
  FAgrCalcNames:= '';
  FSumCalcAuto:=False;
end;

Destructor TCalcLink.Destroy;
begin
  FFields.Free;
  FResCalcs.Free;
  FVisCalcs.Free;
  FAgrCalcs.Free;
  FAgrGroupByCalcs.Free;
(*
  FListTotal.Free;
*)
  Inherited Destroy;
end;

Procedure TCalcLink.Assign(Source: TPersistent);
begin
  if Source is TCalcLink then begin
    FieldNames:=TCalcLink(Source).FFieldNames;
    GroupByNames:=TCalcLink(Source).FGroupByNames;
    ResCalcNames:=TCalcLink(Source).FResCalcNames;
    VisCalcNames:=TCalcLink(Source).FVisCalcNames;
    AgrCalcNames:=TCalcLink(Source).FAgrCalcNames;
    TypeResult:=TCalcLink(Source).FTypeResult;
    FSumCalcAuto:=TCalcLink(Source).FSumCalcAuto;
  end else Inherited;
end;

procedure TCalcLink.SetDataSet(aValue: TDataSet);
begin
  if FDataSet<>aValue then begin
    Fields.Clear;
    FFieldNames:='';
    FDataSet:= aValue;
    if Assigned(FDataset) then UpdateFields('');
  end;
end;

procedure TCalcLink.UpdateCalcs(aOption: TCalcLinkOption; AddNames: String);
var i: Integer;
    S, S1: String;
    aList: TStringList;
    {aField: TField;}
begin
  case aOption of
    coResult: begin
                aList:= FResCalcs;
                S:= FResCalcNames;
              end;
    coVisible: begin
                 aList:= FVisCalcs;
                 S:= FVisCalcNames;
               end;
    coAggregate,coAggregateUnion,coAggregateUnionTotal:
               begin
                 aList:= FAgrCalcs;
                 S:= FAgrCalcNames;
               end;
  end;

  FFields.Clear;
  UpdateFields(AddNames);
  if aOption in [coAggregate] then begin
    { Замена в aDstList'е LookUp'ных полей на KeyField'овые }
    for i:=0 to FFields.Count-1 do with TField(FFields[i]) do
      if FieldKind=fkLookUp then FFields[i]:=DataSet.FieldByName(KeyFields);
(*
    i:= 0;
    while i<FFields.Count do begin
      aField:=FFields[i];
      if aField.FieldKind=fkLookup then begin
        FFields.Delete(i);
        if aField.KeyFields<>'' then
          ConcatFieldList(FDataset, aField.KeyFields, FFields);
      end else Inc(i);
    end;
*)
  end;
  if Assigned(aList) then begin
    aList.Clear;
    while Length(S)>0 do begin
      if aList.Count>FFields.Count then break;
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
    if aList.Count<FFields.Count then
      for i:= aList.Count to FFields.Count-1 do aList.Add('');
  end;
end;

procedure TCalcLink.UpdateCalcNames(aOption: TCalcLinkOption);
var i: Integer;
begin
  case aOption of
    coResult:  begin
                 FResCalcNames:= '';
                 for i:=0 to ResCalcs.Count-1 do begin
                   FResCalcNames:= FResCalcNames+ResCalcs[i]+';';
                 end;
                 if FResCalcNames<>'' then
                   Delete(FResCalcNames, Length(FResCalcNames),1);
               end;
    coVisible: begin
                 FVisCalcNames:= '';
                 for i:=0 to VisCalcs.Count-1 do
                   FVisCalcNames:= FVisCalcNames+VisCalcs[i]+';';
                 if FVisCalcNames<>'' then
                   Delete(FVisCalcNames, Length(FVisCalcNames),1);
               end;
    coAggregate: begin
                   FAgrCalcNames:= '';
                   for i:=0 to AgrCalcs.Count-1 do
                     FAgrCalcNames:= FAgrCalcNames+AgrCalcs[i]+';';
                   if FAgrCalcNames<>'' then
                     Delete(FAgrCalcNames, Length(FAgrCalcNames),1);
                 end;
  end;
end;

Function TCalcLink.GetCalcFields(aOption: TCalcLinkOption; aCalcName: String;
                                 AddNames: String): TList;
var aList: TList;
    i: Integer;
    lList: TStringList;
begin
  UpdateCalcs(aOption, AddNames);
  case aOption of
    coResult: lList:= FResCalcs;
    coVisible: lList:= FVisCalcs;
    coAggregate: lList:= FAgrCalcs;
  end;
  aList:= TList.Create;
  for i:= 0 to lList.Count-1 do
    if AnsiCompareText(lList[i], aCalcName)=0 then aList.Add(Fields[i]);
  if AddNames<>'' then ConcatFieldList(FDataset, AddNames, aList);
  Result:= aList;
end;

Function TCalcLink.GetCalcFieldNames(aOption: TCalcLinkOption; aCalcName:String; aAllFields:Boolean; aSepChar:Char; AddNames: String): String;
var aList: TList;
    i: Integer;
    S: String;
    lList: TStringList;
    aField: TField;
    TotalLabel:boolean;
begin
  S:='';
  TotalLabel:=false;
  if aAllFields then begin
    UpdateCalcs(aOption, AddNames);
    case aOption of
      coResult: lList:= FResCalcs;
      coVisible: lList:= FVisCalcs;
      coAggregate,coAggregateUnion,coAggregateUnionTotal: lList:= FAgrCalcs;
    end;
    for i:=0 to Fields.Count-1 do begin
      aField:= TField(Fields[i]);
      if aField.FieldKind=fkData then begin
        if (lList[i]<>'') and (aSepChar<>';') then
           S:= S+lList[i]+'('+aField.FieldName+') as '+aField.FieldName+aSepChar
        else
          { Мне думается, что "какая группировка - такая и сортировка". На всякий случай закомментарил старый вариант }
          { чтобы можно было бы вернуть при обнаружении глюков Lev 11.12.2009 }
(*
          if (aOption=coAggregateUnion) and (Pos(aField.FieldName,GroupByNames)=0) then
            if (Pos(aField.FieldName,Self.AgrLink.Ifnitem.Fields)=0) and (aField.DataType<>ftString) then
*)
          { Ниже - новый вариант }
          if (aOption=coAggregateUnion) and (Pos(aField.FieldName,GroupByNames)=0) then
            case aField.DataType of
              ftSmallint,
              ftInteger,
              ftWord,
              ftFloat,
              ftCurrency,
              ftLargeint: S:=S+'Max('+aField.FieldName+')+1 as '+aField.FieldName+aSepChar;
              ftDate: S:=S+'cast(null as Date) as '+aField.FieldName+aSepChar;
              ftTime: S:=S+'cast(null as Time) as '+aField.FieldName+aSepChar;
              ftDateTime: S:=S+'cast(null as DateTime) as '+aField.FieldName+aSepChar;
            else
              case aField.DataType of
                ftString: if not TotalLabel then begin { Контролируем, чтобы слово "ИТОГО" вставлялось один раз 11.12.2009 Lev }
                          S:= S+'Cast(''ИТОГО'' as char('+IntToStr(aField.Size)+')) as '+aField.FieldName+aSepChar;
                          TotalLabel:=true;
                        end else S:= S+'cast(null as char('+IntToStr(aField.Size)+')) as '+aField.FieldName+aSepChar;
                {ftDate:   S:= S+'''31.12.2050'''+aSepChar;}
                {ftInteger: S:= S+'999999999'+aSepChar;}
              end;
            end
          else
            if aOption=coAggregateUnionTotal then
              if (Pos(aField.FieldName,GroupByNames)<>0) then
                case aField.DataType of
                  {ftString: S:= S+'''ВСЕГО'''+aSepChar; Группируемые поля - строки - нам такого не надо :) 11.12.2009 Lev }
                  ftSmallint,
                  ftInteger,
                  ftWord,
                  ftFloat,
                  ftCurrency,
                  ftLargeint: S:=S+'Max('+aField.FieldName+')+1 as '+aField.FieldName+aSepChar;
                  ftDate: S:=S+'Max('+aField.FieldName+')+1 as '+aField.FieldName+aSepChar;
                  ftTime: S:=S+'cast(null as Time)'+aSepChar;
                  ftDateTime: S:=S+'cast(null as DateTime)'+aSepChar;
                else
                  S:=S+'''яяя'''+aSepChar // для правильной сортировки Chr(255)='я'
                end
              else
                if (aField.DataType=ftString) and not TotalLabel then begin
                  S:= S+'''ВСЕГО'' as '+aField.FieldName+aSepChar;
                  TotalLabel:=true;
                end else S:=S+'null as '+aField.FieldName+aSepChar
(*
              if Pos(aField.FieldName,GroupByNames)=0 then
                if (Pos(aField.FieldName,Self.AgrLink.Ifnitem.Fields)=0) {or (aField.DataType<>ftString)} then
                  S:=S+'null'+aSepChar
                else
                  case aField.DataType of
                    ftString: S:= S+'''ВСЕГО'''+aSepChar;
                    ftSmallint,
                    ftInteger,
                    ftWord,
                    ftFloat,
                    ftCurrency,
                    ftLargeint: S:=S+'Max('+aField.FieldName+') as '+aField.FieldName+aSepChar
                  else
                    S:=S+'null'+aSepChar
                  end
              else
                case aField.DataType of
                  ftString: S:= S+'''ВСЕГО'''+aSepChar;
                  ftSmallint,
                  ftInteger,
                  ftWord,
                  ftFloat,
                  ftCurrency,
                  ftLargeint: S:=S+'Max('+aField.FieldName+') as '+aField.FieldName+aSepChar
                else
                  S:=S+'null'+aSepChar
                end
*)
            else
              S:= S+aField.FieldName+aSepChar;
      end;
    end;
  end else begin
    aList:= GetCalcFields(aOption, aCalcName, AddNames);
    for i:= 0 to aList.Count-1 do S:= S+TField(aList[i]).FieldName+aSepChar;
    aList.Free;
  end;
  if S<>'' then Delete(S, Length(S), 1);
  Result:= S;
end;

Function TCalcLink.GetFromGroupByNames: String;
var i: Integer;
begin
 (* Result:=StringReplace(GroupByNames,';',',',[rfReplaceAll]) { 15.12.09 Lev. Но функция вроде будет работать медленнее, чем код ниже } *)
  Result:= GroupByNames;
  i:= 1;
  while i<Length(Result) do begin
    if Result[i]=';' then Result[i]:=',';
    Inc(i);
  end;
end;

Procedure TCalcLink.SetCalcFieldNames(aOption: TCalcLinkOption; aCalcName,
                                      aFieldNames: String);
var aList: TList;
    lList: TStringList;
    i, j: Integer;
begin
  UpdateCalcs(aOption, '');
  aList:= TList.Create;
  if Assigned(FDataSet) then FDataset.GetFieldList(aList, aFieldNames);
  case aOption of
    coResult: lList:= FResCalcs;
    coVisible: lList:= FVisCalcs;
    coAggregate: lList:= FAgrCalcs;
  end;
  for i:=0 to aList.Count-1 do begin
    j:= Fields.IndexOf(aList[i]);
    if j<>-1 then lList[i]:= aCalcName;
  end;
  aList.Free;
  UpdateCalcNames(aOption);
end;

procedure TCalcLink.Clear;
begin
  FieldNames:='';
  ResCalcNames:='';
  VisCalcNames:='';
  AgrCalcNames:='';
end;

procedure TCalcLink.UpdateFields(AddNames: String);
begin
  if (FFields.Count=0) {and (FFieldNames<>'')} and Assigned(FDataSet) then begin
    if FieldNames<>'' then
      FDataSet.GetFieldList(FFields, FieldNames)
    else begin
      if Assigned(FFields) then FFields.Free;
      FFields:=GetVisibleFields(FDataSet,false, false{true});
      FFieldNames:=GetFieldNamesByList(FFields,null);
    end;
    if AddNames<>'' then ConcatFieldList(FDataset, AddNames, FFields);
  end;
end;

procedure TCalcLink.UpdateAggrFields(AddNames: String);
var S: String;
begin
  S:= GetCalcFieldNames(coAggregate, '',True,';', '');
  if (FFields.Count=0) and (S<>'') and Assigned(FDataSet) then begin
    FDataSet.GetFieldList(FFields, S);
    if AddNames<>'' then ConcatFieldList(FDataset, AddNames, FFields);
  end;
end;

procedure TCalcLink.SetFieldNames(aValue: String);
begin
  if aValue<>FFieldNames then FFieldNames:= aValue;
  UpdateFields('');
end;

procedure TCalcLink.SetResCalcNames(aValue: String);
begin
  if aValue<>FResCalcNames then FResCalcNames:= aValue;
end;

procedure TCalcLink.SetVisCalcNames(aValue: String);
begin
  if aValue<>FVisCalcNames then FVisCalcNames:= aValue;
end;

procedure TCalcLink.SetAgrCalcNames(aValue: String);
begin
  if aValue<>FAgrCalcNames then FAgrCalcNames:= aValue;
end;

function TCalcLink.GetSumCalc: String;
begin
  Result:= GetCalcFieldNames(coResult, 'Sum', False, ';', '');
end;

procedure TCalcLink.SetSumCalc(aValue: String);
begin
  SetCalcFieldNames(coResult, 'Sum', aValue);
end;

procedure TCalcLink.SetSumCalcAuto(aValue: Boolean);
begin
  FSumCalcAuto:=aValue;
end;

function TCalcLink.ChooseFields(aDataSet: TDataSet; aCalcOption: TCalcLinkOption;
                   aCaption: String; IsChangeVisible: Boolean): Boolean;
var aDst, aSrc: String;
begin
  Result:=False;
  DataSet:=aDataSet;
  if IsChangeVisible then
    FieldNames:=GetVisibleFieldNames(aDataSet, True, True);
  UpdateCalcs(aCalcOption, '');
  aDst:= FieldNames;
  case aCalcOption of
    coResult:
      begin
        if ChooseResultCalcFields(DataSet, aDst, aSrc, ResCalcs, aCaption) then
          Result:= True;
      end;
    coVisible:
      begin
        if ChooseVisibleCalcFields(DataSet, aDst, aSrc, VisCalcs, aCaption) then
          Result:= True;
      end;
    coAggregate:
      begin
        if ChooseAggregateCalcFields(DataSet, aDst, aSrc, AgrCalcs, aCaption) then begin
          Result:= True;
          GroupByNames:= '';
        end;
      end;
  end;
  if Result then begin
    UpdateCalcNames(aCalcOption);
    Fields.Clear;
    FieldNames:= aDst;
    if IsChangeVisible then begin
      aDataSet.DisableControls;
      ChangeVisibleFields(aDataSet, aDst, aSrc);
      { 19.10.09 При смене видимости полей подкорректировали OldEditValues }
      if aDataSet is TLnTable then TLnTable(aDataSet).DoBeforeEdit;
      aDataSet.EnableControls;
    end;
  end;
end;

Function TCalcLink.ChooseGroupBy(aDataSet: TDataSet; aCaption: String): Boolean;
var aDst, aSrc: String;
begin
  Result:= False;
  DataSet:= aDataSet;
  aDst:= GroupByNames;
  if ChooseAggrGroupByCalcFields(DataSet, aDst, aSrc, AgrGroupByCalcs, aCaption) then begin
    Result:= True;
  end;
  if Result then begin
    GroupByNames:= aDst;
  end;
end;

{ TAggregateLink }

Constructor TAggregateLink.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FIFNLink:= TIFNLink.Create(Self);
  FIFNItem:= TIFNItem.Create(nil);
  FCurrentIFNLink:= TIFNLink.Create(Self);
{!  FFinds:= TStringList.Create;}
{  FFields:= ''{TStringList.Create};
{  FCalcs:= ''{TStringList.Create};
  FFind:= TFindLink.Create;
  FCalc:= TCalcLink.Create(Self);
  FFilters:= TLinkFilters.Create;
  FAggregated:= False;
  FAggrWithIndex:= False;
  FIsFind:= False;
end;

destructor TAggregateLink.Destroy;
begin
{  FCalcs.Free;}
{  FFields.Free;}
  FFilters.Free;
{  FFinds.Free;}
  FFind.Free;
  FCurrentIFNLink.Free;
  FIFNItem.Free;
  FIFNLink.Free;
  FCalc.Free;
  if Assigned(FilterStream) then FilterStream.Free;
  inherited;
end;

procedure TAggregateLink.AssignLinkItem(AItem: TAggregateLink);
begin
  FIFNLink.Assign(AItem.FIFNLink);
{  FIndexFieldNames:=AItem.FIndexFieldNames;}
  FIFNItem.Assign(aITem.FIFNItem);
{  FFinds.Assign(AItem.FFinds);
  MaxLW:= AItem.MaxLW;
  MaxEW:= AItem.MaxEW;}
  FFind.Assign(AItem.FFind);
(*
  { Если DataSourc'ы равны и DataSet - Open, то и фильтры у них равны }
  { идеология Igo }
  with FFilters.Data do
  if not(Assigned(DataSource) and
  (AItem.FFilters.Data.DataSource=DataSource) and (DataSource.DataSet.Active)) then
*)
  FFilters.Assign(AItem.FFilters);
{  FFields:= AItem.FFields;}
{  FFields.Assign(AItem.FFields);}
{  FCalcs:= AItem.FCalcs;}
  FCalc.Assign(AItem.FCalc);
{  FCalcs.Assign(AItem.FCalcs);}
  ActiveOwner:= AItem.ActiveOwner;
  AggrTemp:= aItem.AggrTemp;
  AggrWithIndex:= aItem.AggrWithIndex;
end;

procedure TAggregateLink.Assign(Source: TPersistent);
begin
  if Source is TAggregateLink then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      AssignLinkItem(TAggregateLink(Source));
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else inherited Assign(Source);
end;

Function TAggregateLink.GetLinkTableName: String;
begin
  Result:= '';
end;

Function TAggregateLink.GetQueryTextOfGroupBy:string;
var S, S1: String;
begin
  Result:='';
  if Assigned(Calc.DataSet) then begin
    S:=Calc.GetCalcFieldNames(coAggregate,'',True,',','');
  { S:= CreateQueryBaseOnFieldNames(Calc.DataSet, GetLinkTableName, S1);}
    if S<>'' then begin
  {   System.Delete(S,Length(S)-1,2);}
      S:= 'Select '+S+' from '+ GetLinkTableName;
    end else S:='Select * from '+ GetLinkTableName;
    S:=S+CreateQueryWhereOnFilter(Calc.DataSet);
    if FAggrWithIndex then
      S1:= Calc.GetCalcFieldNames(coAggregate, '',False, ',', IFNItem.Fields)
    else S1:= Calc.GetCalcFieldNames(coAggregate, '',False, ',', '');
    if Calc.GroupByNames='' then
      if FAggrWithIndex then
        Calc.GroupByNames:=
          Calc.GetCalcFieldNames(coAggregate, '',False, ';', IFNItem.Fields)
      else Calc.GroupByNames:= Calc.GetCalcFieldNames(coAggregate, '',False, ';', '')
    else S1:= Calc.GetFromGroupByNames;
    if S1<>'' then S:= S+' group by '+S1;
    S:=S+CreateQueryOrderOnFieldNames(Calc.DataSet, GetLinkTableName, IFNItem.Fields, True);
  {   CloneDatasetFieldNames(Calc.DataSet, FAggrDataset, '', True, False)}

(*
    CreateLinkDefFields(FAggrDataset);
    SetCompareDefFields(FAggrDataset, Calc.Dataset, Calc.FieldNames);
*)
  end;
  Result:=S;
end;

Procedure TAggregateLink.SetAggregated(Value: Boolean);
var S, S1, S2: String;
    i: Integer;
    WithUnion: boolean; { True - запрос развернутый, False - только итоги по обозначенным группам }
begin
  if Assigned(Calc.DataSet) then begin
    if Value then begin
      if Assigned(FAggrDataset) then begin
        FAggrDataset.Active:= False;
        for i:=0 to FAggrDataset.FieldCount-1 do
          FAggrDataset.Fields[0].Free;
        TLnQuery(FAggrDataset).SQL.Clear;
      end else FAggrDataset:= TLnQuery.Create(Calc.DataSet.Owner);
      try
        if MessageDlg('Выполнить подробный запрос с группировкой?',
          mtInformation, [mbYes, mbNo], 0)=mrYes then WithUnion:=true else WithUnion:=false;

        with TLnQuery(FAggrDataset) do begin
          DatabaseName:= TDBDataset(Calc.Dataset).DatabaseName;
          if WithUnion then
            S:= Calc.GetCalcFieldNames(coVisible, '',True,',', '')
          else
            S:= Calc.GetCalcFieldNames(coAggregateUnion, '',True,',', '');
  {       S:= CreateQueryBaseOnFieldNames(Calc.DataSet, GetLinkTableName, S1);}
          if S<>'' then begin
  {         System.Delete(S,Length(S)-1,2);}
            S:= 'Select 1 as NN,'+S+' from '+ GetLinkTableName;
          end else S:= 'Select * from '+ GetLinkTableName;
          S:= S+CreateQueryWhereOnFilter(Calc.DataSet);
(***** 09.05.07 Какая-то фигня на первый взгляд, м.б. и не нужна вовсе
          if FAggrWithIndex then
            S1:= Calc.GetCalcFieldNames(coAggregate, '',False, ',', IFNItem.Fields)
          else S1:= Calc.GetCalcFieldNames(coAggregate, '',False, ',', '');
*****)
          if WithUnion then begin
          { Добавляем вторую часть запроса для расчета итогов по намеченным группам}
            S1:=Calc.GetCalcFieldNames(coAggregateUnion, '',True,',', '');
            S:=S+' Union Select 2 as NN,'+S1+' from '+ GetLinkTableName;
            S:=S+CreateQueryWhereOnFilter(Calc.DataSet);
          end;
          if Calc.GroupByNames='' then
            if FAggrWithIndex then
              Calc.GroupByNames:=
                Calc.GetCalcFieldNames(coAggregate, '',False, ';', IFNItem.Fields)
            else Calc.GroupByNames:= Calc.GetCalcFieldNames(coAggregate, '',False, ';', '')
          else S1:= Calc.GetFromGroupByNames;

          if S1<>'' then S:= S+' group by '+S1;
          { Третья часть запроса - итоги по всем строкам }
          S1:=Calc.GetCalcFieldNames(coAggregateUnionTotal, '',True,',', '');
          S:=S+' Union Select 3 as NN,'+S1+' from '+ GetLinkTableName;
          S:=S+CreateQueryWhereOnFilter(Calc.DataSet);
          if FAggrWithIndex then begin
(*
            { Сортировку ставим принудительно, как групппировку. При внедрении передумал. 15.12.09 Lev }
            S1:=Calc.GetFromGroupByNames+',NN';
            S:= S+' order by '+S1;
*)
            //{ В порядке сортировке первыми ОБЯЗАТЕЛЬНО!!! должны быть поля, по которым происходит группировка }
            //{ После этих "обязательных" полей надо вставить наше новое поле "NN", чтобы итоговая сортировка работала корректно }
            //S2:=Calc.GetFromGroupByNames;
            //if WithUnion then begin
              S1:=CreateQueryOrderOnFieldNames(Calc.DataSet, GetLinkTableName, IFNItem.Fields, True); //Это полная сортировка в запросе
              // S1:=StringReplace(S1,S2,S2+',NN',[]);
              S1:=S1+',NN';
            //end else S1:=' order by '+S2+',NN'; // А Это получилась укороченная сортировка только по полям, которые участвуют в группировке (GROUP BY "ListFileds")
            S:= S+S1;
          end;
          SQL.Add(S);
  {       CloneDatasetFieldNames(Calc.DataSet, FAggrDataset, '', True, False)}
          CreateLinkDefFields(FAggrDataset);
          SetCompareDefFields(FAggrDataset, Calc.Dataset, Calc.FieldNames);
        end;
        FAggrDataset.Active:= Calc.DataSet.Active;
        if Assigned(FDataSource) then begin
          FAggrSource:= TDataSource.Create(FDataSource.Owner);
          FAggrSource.DataSet:= FAggrDataset;
        end;
      except
        FAggrDataset.Free; FAggrDataset:=nil;
      end;
    end else begin
      FAggrSource.Free; FAggrSource:=nil;
      CheckedRestoreDataSet:=false; FAggrDataset.Free; FAggrDataset:=nil; CheckedRestoreDataSet:=true;
    end;
    FAggregated:= Value;
  end;
end;

Procedure TAggregateLink.SetIFNLink(AItems: TIFNLink);
begin
  FIFNLink.Assign(AItems);
end;

Function TAggregateLink.IsIFNLinkStored: Boolean;
begin
  Result:= True{FIFNLink.Count>0};
end;

Function TAggregateLink.IsFiltersStored: Boolean;
begin
  Result := True;
end;

Procedure TAggregateLink.SetFilters(Value: TLinkFilters);
begin
  FFilters.Assign(Value);
end;

Function TAggregateLink.GetLinkDataset: TDataset;
begin
  Result:= Nil;
end;

Function TAggregateLink.ChooseOrderFields(aCaption: String): Boolean;
var aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then Result:= IFNItem.ChooseOrderFields(aDataset, aCaption)
     else Result:= False;
end;

Function TAggregateLink.ChooseContextFields(aCaption: String): Boolean;
var aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then Result:= IFNItem.ChooseContextFields(aDataset, aCaption)
     else Result:= False;
end;

Function TAggregateLink.ChooseCalcLinkFields(aCalcOption: TCalcLinkOption; aCaption: String;
                        IsChangeVisible: Boolean): Boolean;
var aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then begin
     Result:= Calc.ChooseFields(aDataset, aCalcOption, aCaption, IsChangeVisible);
     end else Result:= False;
end;

Function TAggregateLink.ChooseGroupByCalcLinkFields(aCaption: String): Boolean;
var aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then begin
     Result:= Calc.ChooseGroupBy(aDataset, aCaption);
     end else Result:= False;
end;

Procedure TAggregateLink.StoreVisible;
var aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then begin
     if Calc.FieldNames='' then
        Calc.FieldNames:= GetVisibleFieldNames(aDataset, True, True);
     if aDataset is TTable then IFNItem.Fields:= GetTableModelIFN(TTable(aDataset));
     end;
end;

Function TAggregateLink.ChangeVisible: Boolean;
var aDst, aSrc: String;
    aDataset: TDataset;
begin
  aDataset:= GetLinkDataset;
  if Assigned(aDataset) then begin
    aDst:= Calc.FieldNames;
    aSrc:= GetAddFieldNames(aDataSet, aDst, False, False, False);
    if aDst='' then begin
      aDst:=aSrc;
      aSrc:='';
    end;
    ChangeVisibleFields(aDataSet, aDst, aSrc);
    Result:=true;
  end else Result:= False;
end;

Procedure TAggregateLink.GetIFNStrings(ANames: TStrings);
begin
end;

Procedure TAggregateLink.DefFillIndexList(AItems: TIFNLink);
begin
end;

Procedure TAggregateLink.OwnerFillIndexList(AItems: TIFNLink);
begin
end;

Procedure TAggregateLink.FillIndexList(AItems: TIFNLink);
begin
  if ActiveOwner then OwnerFillIndexList(aItems)
  else aItems.Clear;;
  AddCollection(AItems, IFNLink);
  if FIFNLink.DefLink then DefFillIndexList(aItems);
end;

Procedure TAggregateLink.FillIndexListCurrent;
var aDataset: TDataset;
    aName: String;
begin
  FillIndexList(CurrentIFNLink);
  CurrentIFNLink.Mode:= IFNLink.Mode;
  if CurrentIFNLink.Mode=imFieldLabels then begin
    aDataset:= GetLinkDataset;
    CurrentIFNLink.Dataset:= aDataset;
    if aDataset is TTable then begin
      aName:=GetTableModelIFN(TTable(aDataset));
      CurrentIFNLink.CurrentIndex:= CurrentIFNLink.IndexOfFields(aName);
    end;
    if aDataSet is TQuery then begin
      aName:=SortingFromDataSet(aDataSet);
      CurrentIFNLink.CurrentIndex:= CurrentIFNLink.IndexOfFields(aName);
    end;
    if Assigned(aDataset) then CurrentIFNLink.ChangeFieldLabels(aDataset);
  end;
end;

procedure TAggregateLink.ChangeLinkIFN(const aIFN: String);
begin
end;

procedure TAggregateLink.ChangeCommonIFN(aItem: TIFNItem);
{var aDataset: TDataset;}
var bItem: TIFNItem;
begin
  if IsFind then bItem:= Find.IFNItem else bItem:= IFNItem;
  if AnsiCompareText(aItem.Fields, bItem.Fields)<>0 then begin
    bItem.Assign(aItem);
    ChangeLinkIFN(aItem.Fields);
{   aDataset:= GetLinkDataset;
    if aDataset is TTable then begin
    TTable(aDataset).IndexFieldNames:= Items[aIndex].Fields;
           end;}
  end;
end;

end.
