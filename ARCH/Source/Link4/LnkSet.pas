{*******************************************************}
{                                                       }
{            X-library v.03.05                          }
{                                                       }
{   07.10.97                   				}
{                                                       }
{   Mixer of (datasets + datasources) with compatible   }
{   Fields (for Query and Table one TableName)          }
{                                                       }
{   TLinkSetItem - table edit's linkset                 }
{   TLinkSets - collection of table edit's linksets     }
{   TLinkTable - sub TTable for TLinkSource             }
{   TLinkQuery - sub TQuery for TLinkSource             }
{   TLinkStoredProc - sub TStoredProc for TLinkSource   }
{   TLinkSubSource - sub source for TLinkSource         }
{   TLinkSource - one TableName container               }
{                                                       }
{   Last corrections 09.02.99                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}

Unit LnkSet;

Interface

Uses Classes, Controls, SysUtils, Graphics, Messages, DB, DBTables, EtvFilt,
     EtvBor, LnTables, LnkMisc;

type

  TLinkSets = class;
  TLinkSource = class;

  TLinkSetStyle = (ldNone, ldDeclar, ldProcess, ldLookup);

{ TLinkMaster }

  TLinkMaster = class(TAggregateLink)
  private
    function GetLinkSource: TLinkSource;
  protected
    function GetOwner: TPersistent; override;
    function GetLinkTableName: String; override;
  public
    function GetLinkDataset: TDataset; override;
    constructor Create(ASource: TLinkSource);
    procedure DefFillIndexList(AItems: TIFNLink); override;
    property LinkSource: TLinkSource read GetLinkSource;
  end;
{ TLinkMaster }

{ TLinkSetItem }

  TLinkSetItem = class(TAggregateLink)
  private
    FStyle: TLinkSetStyle;
    FLinkState: TLinkSetState;
    FDataSet: TDBDataSet; { Текущий ДатаСет }
    FOnStartFind: TStartFindEvent;
{    FSource: TComponent;}
    procedure ChangeDatabaseName(const Value: String);
    procedure ChangeSessionName(const Value: String);
    procedure SetLinkState(Value: TLinkSetState);
    { Для временной подмены DataSet'а на РанТайме }
    procedure SetDataSet(aDataSet:TDBDataSet);
    function GetLinkSets: TLinkSets;
    function GetLinkSource: TLinkSource;
    procedure SetUniqueDataSetName;
    procedure SetUniqueSourceName;
    function GetModelIFN: String;
    procedure SetModelIFN(Value: String);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
  protected
    function GetDisplayName: string; override;
    function GetLinkTableName: String; override;
    function GetLinkDataset: TDataset; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function IsDeclarSource: Boolean;
    function IsDeclar: Boolean;
    function IsLookup: Boolean;
    function IsProcess: Boolean;
    function IsLinkDataSet: Boolean;
    procedure OwnerFillIndexList(AItems: TIFNLink); override;
    procedure DefFillIndexList(AItems: TIFNLink); override;
    procedure AssignLinkItem(AItem: TAggregateLink); virtual;
    procedure ChangeDataSetName(const Value: TFileName);
    function FindExecute(aIFN: String; IsNewIFN: Boolean): Boolean;
    function GetCloneDataset(aState: TLinksetState; aFieldNames: String): TDBDataSet;
    procedure ChooseIFNOrder;
    procedure ChooseIFNContext;
    procedure ChangeLinkIFN(const aIFN: String); override;
    procedure ChangeIFN;
    function ChooseCalcFields(aCalcOption: TCalcLinkOption): Boolean;
    function ChooseGroupByFields: Boolean;
    property LinkSets: TLinkSets read GetLinkSets;
    property LinkSource: TLinkSource read GetLinkSource;
    property ModelIFN: String read GetModelIFN write SetModelIFN stored False;
  published
    property Style: TLinkSetStyle read FStyle write FStyle default ldNone;
    property LinkState: TLinkSetState read FLinkState write SetLinkState default ltNone;
    property DataSet: TDBDataSet read FDataSet write SetDataSet;
    property ActiveOwner;
    property Source: TDataSource read GetDataSource write SetDataSource;
    property OnStartFind: TStartFindEvent read FOnStartFind write FOnStartFind;
  end;
{ TLinkSetItem }

  TLinkSets = class(TCollection)
  private
    FDeclarIndex,
    FLookupIndex,
    FProcessIndex: Integer;
    FSource: TLinkSource;
    function GetItem(Index: Integer): TLinkSetItem;
    procedure SetItem(Index: Integer; Value: TLinkSetItem);
    function GetDeclarLink: TLinkSetItem;
    {procedure SetDeclarLink(aLinkSetItem:TLinkSetItem);}
    function GetLookupLink: TLinkSetItem;
    function GetProcessLink: TLinkSetItem;
    function GetDeclar: TDBDataSet;
    function GetLookup: TDBDataSet;
    function GetProcess: TDBDataSet;
    procedure SetActiveDeclar(Value: Boolean);
    procedure ChangeSourceName(AName, BName: TComponentName);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ASource: TLinkSource);
    function AddDeclar(aDataSet:TDBDataSet): TLinkSetItem;
    { Добавляет в коллекцию Item'ов еще один основной и делает его активным }
    { Нужен для переключения формы на другой DataSet, основанный, например  }
    { на основе запрося с применением оператора "LIKE"                      }
    function AddDeclarQuery(aQuery:TQuery; SQLText:string):TLinkSetItem;
    function AddLookup: TLinkSetItem;
    function AddProcess: TLinkSetItem;
    procedure ForEachDataSet(Proc: TGetChildProc);
    procedure SetDeclarIndex(aDeclarIndex:integer);
    procedure SetLookupIndex;
    procedure SetProcessIndex;
    procedure SetSourceIndexes;
    function IsDeclar: Boolean;
    function IsLookup: Boolean;
    function IsProcess: Boolean;
    property ActiveDeclar: Boolean write SetActiveDeclar;
    property Items[Index: Integer]: TLinkSetItem read GetItem write SetItem; default;
    property DeclarIndex: Integer read FDeclarIndex write FDeclarIndex;
    property LookupIndex: Integer read FLookupIndex write FLookupIndex;
    property ProcessIndex: Integer read FProcessIndex write FProcessIndex;
    property Declar: TDBDataSet read GetDeclar;
    property Lookup: TDBDataSet read GetLookup;
    property Process: TDBDataSet read GetProcess;
    property DeclarLink: TLinkSetItem read GetDeclarLink{ write SetDeclarLink};
    property LookupLink: TLinkSetItem read GetLookupLink;
    property ProcessLink: TLinkSetItem read GetProcessLink;
  end;
{ TLinkSets }

{ TLinkTable }
  TLinkTable = class(TLnTable)
  private
    FLinkIndex: Integer;
    FLinkSource: TLinkSource;
    function IsStoredActive: Boolean;
    procedure SetLink(Link: TLinkSource);
    function GetDatabaseName: String;
    procedure SetDatabaseName(const Value: string);
    function GetSessionName: String;
    procedure SetSessionName(const Value: string);
    function GetTableName: TFileName;
    procedure SetTableName(const Value: TFileName);
  protected
    procedure DoBeforeClose; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure InternalDelete; override;
    procedure ReadState(Reader: TReader); override;
  public
    destructor Destroy; override;
    procedure DoBeforePost; override;
    property LinkSource: TLinkSource read FLinkSource write FLinkSource stored False;
    property LinkIndex: Integer read FLinkIndex write FLinkIndex;
  published
    property Active stored IsStoredActive;
    property TableName: TFileName read GetTableName write SetTableName;
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property SessionName: string read GetSessionName write SetSessionName;
  end;
{ TLinkTable }

{ TLinkQuery }

  TLinkQuery = class(TLnQuery)
  private
    FLinkIndex: Integer;
    FLinkSource: TLinkSource;
    function IsStoredActive: Boolean;
    procedure SetLink(Link: TLinkSource);
    function GetDatabaseName: String;
    procedure SetDatabaseName(const Value: string);
    function GetSessionName: String;
    procedure SetSessionName(const Value: string);
  protected
    procedure DoBeforeClose; override;
    procedure DoBeforePost; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure InternalDelete; override;
    procedure ReadState(Reader: TReader); override;
  public
    destructor Destroy; override;
    procedure Post; override;
    property LinkIndex: Integer read FLinkIndex write FLinkIndex;
    property LinkSource: TLinkSource read FLinkSource write FLinkSource stored False;
  published
    property Active stored IsStoredActive;
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property SessionName: string read GetSessionName write SetSessionName;
  end;
{ TLinkQuery }

{ TLinkStoredProc }

  TLinkStoredProc = class(TLnStoredProc)
  private
    FLinkIndex: Integer;
    FLinkSource: TLinkSource;
    function IsStoredActive: Boolean;
    procedure SetLink(Link: TLinkSource);
  protected
    procedure DoBeforeClose; override;
    procedure DoBeforePost; override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure ReadState(Reader: TReader); override;
  public
    destructor Destroy; override;
    procedure Post; override;
    property LinkSource: TLinkSource read FLinkSource write FLinkSource stored False;
    property LinkIndex: Integer read FLinkIndex write FLinkIndex;
  published
    property Active stored IsStoredActive;
  end;
{ TLinkStoredProc }

{ TLinkSubSource }

  TLinkSubSource = class(TDataSource)
  private
    FLinkIndex: Integer;
    FLinkSource: TLinkSource;
    procedure SetLink(Link: TLinkSource);
  protected
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure ReadState(Reader: TReader); override;
  public
    destructor Destroy; override;
    property LinkSource: TLinkSource read FLinkSource write FLinkSource stored False;
    property LinkIndex: Integer read FLinkIndex write FLinkIndex;
  end;
{ TLinkSubSource }

{ TProcSubSource }

  TProcSubSource = class(TDataSource)
  private
    FLinkIndex: Integer;
    FLinkSource: TLinkSource;
    procedure SetLink(Link: TLinkSource);
  protected
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure ReadState(Reader: TReader); override;
  public
    destructor Destroy; override;
    property LinkSource: TLinkSource read FLinkSource write FLinkSource stored False;
    property LinkIndex: Integer read FLinkIndex write FLinkIndex;
  end;
{ TProcSubSource }

{ TLinkSource }

  TLinksOption = (dfActivate, dfDeactivate, dfSimpleAutoClose, dfAddAutoClose,
                  dfAutoPost, dfFirstControl, dfRecCount, dfSumCount);
{
  dfActivate - открытие Simple только по Activate формы
  dfDeactivate - закрытие Simple по потере формой фокуса
  dfSimpleAutoClose - закрытие Simple по закрытию таблиц с lookup-fields
  dfAddAutoClose - закрытие Pzmdata и Search по закрытию таблиц с lookup-filds
  dfAutoPost - refresh linkdataset по деактивации формы
  dfFirstControl - установить на первый контроль в DeclarItem
  dfRecCount - пересчитывать количество записей
  dfSumCount - пересчитывать строку суммирования
}
  TLinksOptions = set of TLinksOption;

  TLinkSource = class(TDataSource)
  private
    FActive: Boolean;
    FPostChecked: Boolean;
    FLockSpecials: Boolean;
    FMultiModified: Boolean;
    FRecCountChanged: Boolean;
    FIsSetReturn: Boolean;
    FIsReturnValue: Boolean;
    FOptions: TLinksOptions;
    FBookm: TBookMark;
    FLinkMaster: TLinkMaster;
    FLinkSets: TLinkSets;
    FInner:TLnTable;
    FSources: TList;
    FProcSources: TList;
    FIFNUnique: TIFNItem;
{$IFDEF UseXPrinter}
    FOnLnPrintEvent: TNotifyEvent;
    procedure LnPrinting(ADataSet: TObject);

    function PrintGetTab(Sender: TObject; AIndex: Integer; var AColWidth:LongInt;
                               var IsTab: Boolean): Boolean;
    procedure PrintProgress(Sender: TObject; var Done: Boolean);
    procedure PrintProgressBgn(Sender: TObject);
    procedure PrintProgressEnd(Sender: TObject);
    procedure PrintProgressBrk(Sender: TObject; var Done: Boolean);
    procedure PrintWriteTitle(Sender: TObject);
    procedure PrintWriteRecord(Sender: TObject);
    procedure PrintWriteDump(Sender: TObject);
    procedure PrintWriteTotals(Sender: TObject);
{$ENDIF}
    procedure SetActive(Value: Boolean);
    function GetCaption: String;
    procedure SetCaption(const Value: String);
    function GetDatabaseName: String;
    procedure SetDatabaseName(const Value: string);
    function GetSessionName: String;
    procedure SetSessionName(const Value: string);
    function GetTableName: TFileName;
    procedure SetTableName(const Value: TFileName);

    procedure PushDataSet(Value: TDBDataSet);
    procedure PopDataSet(Value: TDBDataSet);
    procedure SetPostChecked(Value: Boolean);
    procedure SetLinkSets(Value: TLinkSets);
    function GetDeclar: TDBDataSet;
    {procedure SetDeclarLink(aLinkSetItem:TLinkSetItem);}
    function GetDeclarLink: TLinkSetItem;
    function GetLookup: TDBDataSet;
    function GetProcess: TDBDataSet;

    function GetName: TComponentName;
    procedure SetName(const AName: TComponentName);
    function IsLinkSetsStored: Boolean;
    procedure SetOptions(Value: TLinksOptions);
    function GetLikePatterns: TStringList;
    function GetLikeQuery: TQuery;
    procedure SetLikeQuery(aQuery: TQuery);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function IsStoredActive: Boolean;
    function IsSetActive: Boolean;
    procedure DoCheckPostedMode(Value: Boolean);
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded;override;

    function CheckBrowseSources: Boolean;
    function IsDeclar: Boolean;
    function IsLookup: Boolean;
    function IsProcess: Boolean;
    (* Закомментарил 25.12.2004. Вроде бы не нужна. Попозже удалить.
    procedure ChangeLookQueryField(AField: TField; aLC:TDBLookupControlBorland; aLDataSet:TDataSet; aLookUpResultField:string);
    *)
    procedure CreateLikeQuery(ADataSet: TDataSet);
    function ChangeLikeQuery(ADataSet: TDataSet; Const AFieldsName: String; Const AStr:String): Boolean;
    function FindExecute(aIFN: String; IsNewIFN: Boolean): Boolean;
{$IFDEF UseXPrinter}
    function PrintExecute: Boolean;
{$ENDIF}
    procedure SummExecute;

    procedure FillIndexList(AItems: TIFNLink);
    function GetCloneDataset(aState: TLinksetState; aFieldNames: String): TDBDataSet;
    procedure ChooseIFNOrderDeclar;
    procedure ChooseIFNContextDeclar;
    procedure ChangeIFNDeclar;
    procedure ChooseIFNUnique;
    function ChooseCalcFieldsDeclar(aCalcOption: TCalcLinkOption): Boolean;
    function ChooseGroupByFieldsDeclar: Boolean;
    procedure ChangeVisibleDeclar;
    procedure StoreVisibleDeclar;
    function GetFilterDeclar: TEtvFilter;
    function GetCalcDeclar: TCalcLink;

    procedure ActivateLink(IsLoaded: Boolean);
    property IsSetReturn: Boolean read FIsSetReturn write FIsSetReturn;
    property IsReturnValue: Boolean read FIsReturnValue write FIsReturnValue;

    property Sources: TList read FSources;
    property ProcSources: TList read FProcSources;
    property Declar: TDBDataSet read GetDeclar;
    property DeclarLink: TLinkSetItem read GetDeclarLink{write SetDeclarLink};
    property Lookup: TDBDataSet read GetLookup;
    property Process: TDBDataSet read GetProcess;

    property MultiModified: Boolean read FMultiModified write FMultiModified;
    property Inner: TLnTable read FInner write FInner stored False;
    property LikePatterns: TStringList read GetLikePatterns;
    property LikeQuery: TQuery read GetLikeQuery write SetLikeQuery;
    property PostChecked: Boolean read FPostChecked write SetPostChecked;
    property RecCountChanged: Boolean read FRecCountChanged write FRecCountChanged;
  published
    property Name: TComponentName read GetName write SetName;
    property Options: TLinksOptions read FOptions write SetOptions
                                     default [dfActivate, dfAutoPost, dfFirstControl, dfRecCount];
    property DataSet stored False;
    property Caption: String read GetCaption write SetCaption stored False;
    property LinkMaster: TLinkMaster read FLinkMaster write FLinkMaster;
    property LinkSets: TLinkSets read FLinkSets write SetLinkSets stored IsLinkSetsStored;

    property Active: Boolean read FActive write SetActive default False;
    property TableName: TFileName read GetTableName write SetTableName;
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property SessionName: string read GetSessionName write SetSessionName;
    property IFNUnique: TIFNItem read FIFNUnique write FIFNUnique;

{$IFDEF UseXPrinter}
    property OnPrint: TNotifyEvent read FOnLnPrintEvent write FOnLnPrintEvent;
{$ENDIF}
  end;
{ TLinkSource }

function TryName(const Test: string; Comp: TComponent): Boolean;
Function IsLinkDataSet(aDataSet:TDataSet): Boolean;
procedure ChangeLinkQuery(AQuery: TQuery; const TableName: TFileName; Const AInds: String);
procedure ChangeLookQueryField(AField: TField; aLC:TDBLookupControlBorland; aLDataSet:TDataSet; aLookUpResultField:string);

Implementation

Uses Windows, DBITypes, DBIProcs, StdCtrls, Dialogs, Forms, XMisc,
     XApps, TypInfo, EtvDB, EtvLook, EtvDBFun, XForms, XDBTFC, EtvOther, EtvTemp,
{$IFDEF UseXPrinter}
     XPrints, Progress,
{$ENDIF}
     FindDlgc,  EtvTable, EtvPas, XDBMisc;

var XNotifyEvent: TXNotifyEvent;
    XNotifyString: TXNotifyString;

{ Common functions }

Procedure ChangeLinkQuery(aQuery: TQuery; const TableName: TFileName; Const AInds: String);
var S, aWhere {SPref}: String;
    aSavedParams: TParams;
    IsParams: boolean;
begin
  if Assigned(AQuery) and (TableName<>'') then begin
    aWhere:=WhereFromSQL(AQuery.SQL.Text, true);
    if aQuery.ParamCount>0 then begin
      IsParams:=true;
      aSavedParams:=TParams.Create;
      aSavedParams.Assign(aQuery.Params);
    end else IsParams:=false;
    aQuery.SQL.Clear;
    S:= CreateQueryBaseOnFieldNames(aQuery, TableName, '', False);
    aQuery.SQL.Add(S);
    if aWhere<>'' then
      aQuery.SQL.Add(' where '+aWhere);
    S:= CreateQueryOrderOnFieldNames(aQuery, TableName, aInds, False);
    // Добавляем в ORDER BY Unique поле, если надо
    // Поле должно быть одно, как правило "Kod"
    if TEtvQuery(aQuery).UniqueFields<>'' then
      S:=S+','+TEtvQuery(aQuery).UniqueFields;
    aQuery.SQL.Add(S);
    if IsParams then begin
      aQuery.Params.AssignValues(aSavedParams);
      aSavedParams.Free;
    end;
  end;
end;

{ Lev. Time Of Correction 18.04.99 The Begin }
procedure ChangeLookQueryField(AField: TField; aLC:TDBLookupControlBorland;
          aLDataSet:TDataSet; aLookUpResultField:string);
var FieldSet: TDataSet;
    S, S1, aWhere: String;
    i,j,n: Integer;
    ADataSet: TDataSet;
begin
  if ((Assigned(AField) and (AField is TEtvLookField)) or
  (Assigned(aLC) and Assigned(aLC.FlistLink.DataSource) and
  (aLC.FListFieldName<>'') and (aLC.FKeyFieldName<>'')))
  and ((aLDataSet is TLnQuery) or (aLDataSet is TLnTable)) then begin
    ADataSet:=TDataSet(aLDataSet);
    // Проверка, чтобы у Query было заполнено поле TableName (проблема разработчика)
    if (ADataSet is TLnQuery) and (TLnQuery(ADataSet).TableName='') then begin
      ShowMessage('Внимание разработчика!'+#13+'У объекта TLnQuery :'+ADataSet.Name+' - не заполнено поле TableName');
    end;
    { Special actions for AField }
    if Assigned(AField) then begin
      FieldSet:=AField.DataSet;
      if (FieldSet is TLinkTable) and Assigned(TLinkTable(FieldSet).LinkSource) then
        TLinkTable(FieldSet).LinkSource.FLockSpecials:=True;
    end;
    ADataSet.DisableControls;
    if Assigned(AField) then XNotifyEvent.GoSpell(FieldSet, xeSetParams, opInsert);
    if ADataSet is TLnQuery then
      TLnQuery(ADataSet).CloseOnMoment
    else TLnTable(ADataSet).CloseOnMoment;
    S:=aLookupResultField;
    i:=Pos(';',S);
    if i>0 then begin
      n:=1; j:=i; S1:=S;
      while j>0 do begin
        Inc(n);
        S1:=Copy(S1,j+1,255);
        j:=Pos(';',S1);
      end;
      Repeat
        i:=Pos(';',S);
        S1:=Copy(S,1,i-1);
        Delete(S,1,i);
        S:=S+';'+S1;
        i:=Pos(';',S);
        S1:=Copy(S,1,i-1);
        if not(ADataSet.FieldByName(S1).Lookup or ADataSet.FieldByName(S1).Calculated) then
          Break;
        Dec(n);
      until n=0;

      for i:=0 to ADataSet.FieldCount-1 do begin
        if ADataSet.Fields[i].Calculated then Continue;
        if ADataSet.Fields[i].Lookup then
          if ADataSet.Fields[i].FieldName=S1 then begin
            ADataSet.FieldByName(ADataSet.Fields[i].KeyFields).Index:=ADataSet.FieldCount-1;
            Break;
          end else Continue;
        ADataSet.Fields[i].Index:=ADataSet.FieldCount-1;
        Break;
      end;
      {ADataSet.SQL.Clear;}
      if ADataSet is TLnQuery then
        ChangeLinkQuery(TLnQuery(ADataSet), TLnQuery(ADataSet).TableName, S1)
      else begin
        if (Pos(TLnTable(ADataSet).UniqueFields,S1)=0) {and (Pos(S1,TLnTable(ADataSet).UniqueFields)=0)} then
          S1:=S1+';'+TLnTable(ADataSet).UniqueFields;
        TLnTable(ADataSet).IndexFieldNames:=S1;
      end;
      if Assigned(AField) then XNotifyString.GoSpellStr(AField, xeSetParams, S, opInsert)
      else
        {aLC.FListFieldName:=S;}
        TEtvCustomDBLookUpCombo(aLC).ListField:=S;
    end;
    if ADataSet is TQuery then TLnQuery(ADataSet).OpenMoment
    else TLnTable(ADataSet).OpenMoment;
    if Assigned(AField) then begin
      XNotifyEvent.GoSpell(FieldSet, xeSetParams, opRemove);
      if FieldSet is TLinkTable and Assigned(TLinkTable(FieldSet).LinkSource) then
        TLinkTable(FieldSet).LinkSource.FLockSpecials:=False;
    end;
    ADataSet.EnableControls;
  end;
end;
{ Lev. Time Of Correction 18.04.99 The End }

Function TryName(const Test: string; Comp: TComponent): Boolean;
var
  I: Integer;
begin
  Result := False;
  if not Assigned(Comp) then begin
    Result:=true;
    Exit;
  end;
  for I := 0 to Comp.ComponentCount-1 do
    if CompareText(Comp.Components[I].Name, Test) = 0 then Exit;
  Result := True;
end;

Function IsLinkDataSet(aDataSet:TDataSet): Boolean;
begin
  Result:=false;
  if (aDataSet is TLinkQuery) or (aDataSet is TLinkTable) then Result:=true;
end;

{ TLinkMaster }

Constructor TLinkMaster.Create(ASource: TLinkSource);
begin
  Inherited Create(Nil);
  DataSource:= ASource;
  Filters.Data.DataSource:= ASource;
end;

Function TLinkMaster.GetOwner: TPersistent;
begin
  Result:= DataSource;
end;

Function TLinkMaster.GetLinkTableName: string;
begin
  Result:= LinkSource.TableName;
end;

Function TLinkMaster.GetLinkDataset: TDataset;
begin
  if LinkSource.IsDeclar then begin
    LinkSource.LinkMaster.Assign(LinkSource.DeclarLink);
    Result:= LinkSource.DeclarLink.Dataset; {?maybe of DeclarLink}
  end else Result:=nil;
end;

Function TLinkMaster.GetLinkSource: TLinkSource;
begin
  Result:=TLinkSource(DataSource);
end;

Procedure TLinkMaster.DefFillIndexList(AItems: TIFNLink);
begin
  LinkSource.FillIndexList(AItems);
end;

{ TLinkSetItem }

Constructor TLinkSetItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  {Filters.Data.DataSource:=LinkSource;}
  FOnStartFind:=Nil;
end;

Destructor TLinkSetItem.Destroy;
begin
  if not (csDestroying in LinkSource.ComponentState) then begin
    if IsDeclarSource and (Index=0) then LinkSets.FDeclarIndex:=-1;
    if IsLookup then LinkSets.SetLookupIndex;
    if IsProcess then LinkSets.SetProcessIndex;
    if IsLinkDataSet then FDataSet.Free;
    if Assigned(DataSource)and(DataSource<>LinkSource) then DataSource.Free;
  end;
  inherited;
end;

Procedure TLinkSetItem.AssignLinkItem(AItem: TAggregateLink);
begin
  Inherited AssignLinkItem(AItem);
  Dataset:= TLinkSetItem(AItem).DataSet;
  DataSource:= TLinkSetItem(AItem).DataSource;
  if Assigned(DataSource) then DataSource.Dataset:= Dataset;
  Style:= TLinkSetItem(AItem).Style;
  LinkState:= TLinkSetItem(AItem).LinkState;
  Filters.Data.DataSource:= DataSource;
end;

Function TLinkSetItem.GetLinkTableName: String;
begin
  Result:= LinkSource.TableName;
end;

Function TLinkSetItem.GetLinkDataset: TDataset;
begin
  Result:= Dataset;
end;

Function TLinkSetItem.GetDataSource: TDataSource;
begin
  Result:= DataSource;
end;

Procedure TLinkSetItem.SetDataSource(Value: TDataSource);
begin
  DataSource:= Value;
end;

Procedure TLinkSetItem.ChooseIFNOrder;
begin
  if ChooseOrderFields(LinkSource.Caption) then begin
    ChangeLinkIFN(IFNItem.Fields);
    Calc.GroupByNames:='';
  end;
end;

Procedure TLinkSetItem.ChooseIFNContext;
begin
  if ChooseContextFields(LinkSource.Caption) then
    ChangeLinkIFN(IFNItem.Fields);
end;

Function TLinkSetItem.ChooseCalcFields(aCalcOption: TCalcLinkOption): Boolean;
begin
  Result:= ChooseCalcLinkFields(aCalcOption, LinkSource.Caption, True);
end;

Function TLinkSetItem.ChooseGroupByFields: Boolean;
begin
  Result:= ChooseGroupByCalcLinkFields(LinkSource.Caption);
end;

Procedure TLinkSetItem.ChangeIFN;
begin
  ChangeLinkIFN(IFNItem.Fields);
end;

Function TLinkSetItem.GetCloneDataset(aState: TLinksetState; aFieldNames: String): TDBDataSet;
begin
  if Aggregated then
    Result:=GetLinkCloneDataset(AggrDataset, ltQuery, aState, LinkSource.TableName,
                                aFieldNames, True, False, '', False)
  else Result:=GetLinkCloneDataset(FDataset, {LinkSets.DeclarLink.}LinkState, aState,
                  LinkSource.TableName, aFieldNames, True, False, ModelIFN, True);
end;

Procedure TLinkSetItem.OwnerFillIndexList(AItems: TIFNLink);
begin
  LinkSource.LinkMaster.FillIndexList(AItems)
end;

Procedure TLinkSetItem.DefFillIndexList(AItems: TIFNLink);
begin
  if Assigned(FDataSet) then begin
    LinkSource.FillIndexList(AItems);
  end;
end;

Procedure TLinkSetItem.SetUniqueDataSetName;
var
  i: Integer;
  Fmt, S: string;
begin
  Fmt:=LinkSource.Name;
  case FStyle of
    ldDeclar: Fmt:= Fmt+'Declar';
    ldLookup: Fmt:= Fmt+'Lookup';
    ldProcess: Fmt:= Fmt+'Process';
  end;
  if TryName(Fmt, FDataSet.Owner) then begin
    FDataSet.Name:=Fmt;
    Exit;
  end;
  Fmt:=Fmt+'%d';
  for i := 1 to High(Integer) do begin
    S := Format(Fmt, [I]);
    if TryName(S, FDataSet.Owner) then begin
      FDataSet.Name:=S;
      Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique name for %s.', [FDataSet.ClassName]);
end;

Procedure TLinkSetItem.SetUniqueSourceName;
var
  i: Integer;
  Fmt, S: string;
begin
  Fmt:=LinkSource.Name;
  case FStyle of
    ldDeclar: Fmt:= Fmt+'D';
    ldLookup: Fmt:= Fmt+'L';
    ldProcess: Fmt:= Fmt+'P';
  end;
  Fmt:=Fmt+'%d';
  for i := 1 to High(Integer) do begin
    S := Format(Fmt, [I]);
    if TryName(S, DataSource.Owner) then begin
      DataSource.Name:=S;
      Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique name for %s.', [DataSource.ClassName]);
end;

Function TLinkSetItem.IsLinkDataSet: Boolean;
begin
  Result:= (FStyle<>ldNone)and Assigned(FDataSet);
end;

Function TLinkSetItem.IsDeclarSource: Boolean;
begin
  Result:= (FStyle=ldDeclar) and (DataSource=LinkSource) and Assigned(FDataSet);
end;

Function TLinkSetItem.IsDeclar: Boolean;
begin
  Result:= (FStyle=ldDeclar)and Assigned(FDataSet);
end;

Function TLinkSetItem.IsLookup: Boolean;
begin
  Result:= (FStyle=ldLookup)and Assigned(FDataSet);
end;

Function TLinkSetItem.IsProcess: Boolean;
begin
  Result:= (FStyle=ldProcess)and Assigned(FDataSet);
end;

Function TLinkSetItem.GetDisplayName: string;
begin
  if (Not Assigned(DataSource))and(Not Assigned(FDataSet)) then
    case FStyle of
      ldNone: Result := inherited GetDisplayName;
      ldDeclar: Result := 'Declar Item';
      ldLookup: Result := 'Lookup Item';
      ldProcess: Result := 'Process Item';
    end
  else
    case FStyle of
      ldNone: Result := '/N/';
      ldDeclar: Result := '/D/';
      ldLookup: Result := '/L/';
      ldProcess: Result := '/P/';
    end;
  if Assigned(DataSource) then Result:=Result+' '+DataSource.Name;
  if Assigned(FDataSet) then Result:=Result+' ['+FDataSet.Name+']'
end;

Function TLinkSetItem.GetLinkSets: TLinkSets;
begin
  Result:= TLinkSets(Collection);
end;

Function TLinkSetItem.GetLinkSource: TLinkSource;
begin
  if Assigned(Collection) then
    Result:=TLinkSource(LinkSets.GetOwner)
  else Result:=nil;
end;

Procedure TLinkSetItem.ChangeDataSetName(const Value: TFileName);
var SavActive: Boolean;
begin
  if Assigned(FDataSet) then begin
    SavActive:=FDataSet.Active;
    FDataSet.Active:=False;
    case FLinkState of
      ltTable:
        begin
          TTable(FDataSet).TableName:=Value;
        end;
      ltQuery:
        begin
          ChangeLinkQuery(TLinkQuery(FDataSet), Value, ModelIFN);
        end;
      ltStoredProc:
        begin
        end;
    end;
    FDataSet.Active:=SavActive;
  end;
end;

Function TLinkSetItem.GetModelIFN: String;
begin
  if Assigned(FDataSet)and (FLinkState=ltTable) then begin
    Result:= GetTableModelIFN(TTable(FDataSet));
    IFNItem.Fields:= Result;
  end else Result:= IFNItem.Fields;
end;

Procedure TLinkSetItem.SetModelIFN(Value: String);
begin
  if Assigned(FDataSet)and (FLinkState=ltTable) then
    TTable(FDataSet).IndexFieldNames:= Value;
  IFNItem.Fields:= Value;
end;

Procedure TLinkSetItem.ChangeLinkIFN(const aIFN: String);
var SavActive: Boolean;
    aTableName: String;
    aDataset: TDataset;
    aFindState: TLinkSetState;
    {B:TBookMark;}
    {lFields:String;}
    {V:variant;}
begin
  if IsFind then begin
    aDataset:=Find.FindDataset;
    aFindState:= Find.FindState;
  end else begin
    aDataset:= FDataset;
    aFindState:= FLinkState;
  end;
  if Assigned(aDataSet) then begin
    aTableName:= LinkSource.TableName;
    case aFindState of
      ltTable:
        begin
          if aTableName<>TTable(FDataSet).TableName then begin
            SavActive:=aDataSet.Active;
            aDataSet.Active:=False;
            TTable(aDataSet).TableName:= aTableName;
            aDataSet.Active:=SavActive;
            TTable(aDataSet).IndexFieldNames:=aIFN;
          end else begin
(*
            with TTable(aDataSet) do begin
              DisableControls;
              lFields:='AutoInc';{UniqueFieldsForDataSet(aDataSet);}
              if lFields<>'' then V:=aDataSet.FieldValues[lFields];
              {B:=aDataSet.GetBookMark;}
              Close;
              IndexFieldNames:=aIFN;
              Open;
              {Locate(lFields,V,[]);}
              {GotoBookMark(B);}
              EnableControls;
            end;
*)
            SortingToDataSet(aDataSet,aIFN,false,false);
            if (Screen.ActiveForm is TXForm) then
              TDBFormControl(TXForm(Screen.ActiveForm).FormControl).ChangeIndexCombo;
          end;
        end;
      ltQuery:
        begin
         (*
          SavActive:=aDataSet.Active;
          aDataSet.Active:=False;
          ChangeLinkQuery(TLinkQuery(aDataSet), aTableName, aIFN);
          aDataSet.Active:=SavActive;
          *)
          SortingToDataSet(aDataSet,aIFN,false,false);
          if (Screen.ActiveForm is TXForm) then
            TDBFormControl(TXForm(Screen.ActiveForm).FormControl).ChangeIndexCombo;
        end;
      ltStoredProc:
        begin
        end;
    end;
  end;
end;

Procedure TLinkSetItem.ChangeDatabaseName(const Value: String);
begin
  if Assigned(FDataSet) then FDataSet.DatabaseName:= Value;
end;

Procedure TLinkSetItem.ChangeSessionName(const Value: String);
begin
  if Assigned(FDataSet) then FDataSet.SessionName:= Value;
end;

Procedure TLinkSetItem.SetLinkState(Value: TLinkSetState);
var aLinkSource: TLinkSource;
    Priz, SavActive: Boolean;
begin
  ALinkSource:=LinkSource;
  if Assigned(ALinkSource) then begin
    if FLinkState<>Value then begin
      if not (csLoading in LinkSource.ComponentState) then
        Priz:= FLinkState<>ltNone;
      if Priz then begin
        SavActive:= FDataset.Active;
        FDataset.Active:= False;
        ALinkSource.PushDataset(FDataset);
        FDataSet.Free;
        FDataSet:=nil;
      end;

      FLinkState:=Value;
{           DataSet:= LinkSource.CreateLinkSetItem(FStyle, FLinkState);}
{----}
      if not (csLoading in ALinkSource.ComponentState) then
      if FLinkState=ltNone then FDataSet:=nil
      else begin
        case FLinkState of
          ltTable:
            begin
              if not Assigned(FDataSet)then
                FDataSet:= TLinkTable.Create(ALinkSource.Owner);
              TLinkTable(FDataSet).LinkSource:=ALinkSource;
            end;
          ltQuery:
            begin
              if not Assigned(FDataSet)then
                FDataSet:= TLinkQuery.Create(LinkSource.Owner);
              TLinkQuery(FDataSet).LinkSource:=ALinkSource;
            end;
          ltStoredProc:
            begin
              if not Assigned(FDataSet)then
                FDataSet:= TLinkStoredProc.Create(ALinkSource.Owner);
              TLinkStoredProc(FDataSet).LinkSource:=ALinkSource;
            end;
        end;

        FDataSet.DatabaseName:=ALinkSource.DatabaseName;
        if FDataSet.Name='' then SetUniqueDataSetName;

        case FLinkState of
          ltTable:
            begin
              TLinkTable(FDataSet).TableName:=ALinkSource.TableName;
              TLinkTable(FDataSet).IndexFieldNames:=ModelIFN;
            end;
          ltQuery:
            begin
              { Если в Query текста нет, то ... }
              if not Assigned(TQuery(FDataSet).SQL) then
                ChangeLinkQuery(TLinkQuery(FDataSet), ALinkSource.TableName, ModelIFN);
            end;
          ltStoredProc:
            begin
            end;
        end;

        if Assigned(DataSource) then begin
          if DataSource.DataSet<>FDataSet then
            DataSource.DataSet:=FDataSet;
{         Filters.Data.Dataset:= FDataset;}
        end;
        if Priz then begin
          ALinkSource.PopDataset(FDataSet);
          FDataset.Active:= SavActive;
        end;
      end;
{----}
    end;
  end;
end;

{ Меняние DataSet'а на RunTime }
Procedure TLinkSetItem.SetDataSet(aDataSet:TDBDataSet);
begin
  FDataSet:=aDataSet;
  if FDataSet is TTable then FLinkState:=ltTable else
  if FDataSet is TQuery then FLinkState:=ltQuery else
  if FDataSet is TStoredProc then FLinkState:=ltStoredProc;
end;

function TLinkSetItem.FindExecute(aIFN: String; IsNewIFN: Boolean): Boolean;
begin
  if IsNewIFN then ModelIFN:= aIFN;
  if (LinkState in [ltTable, ltQuery])and Assigned(FDataset) then begin
    FillIndexListCurrent;
    Find.OnStartFind:= FOnStartFind;
    IsFind:= True;
    try
      Result:= Find.Execute(FDataset, LinkSource.TableName, '', IFNItem, LinkSource.IFNUnique, CurrentIFNLink);
    finally
      IsFind:= False;
    end;
  end else Result:= False;
end;

{ TLinkSets }

Constructor TLinkSets.Create(ASource: TLinkSource);
begin
  inherited Create(TLinkSetItem);
  FSource := ASource;
  FDeclarIndex:=-1;
  FLookupIndex:=-1;
  FProcessIndex:=-1;
end;

Procedure TLinkSets.ChangeSourceName(AName, BName: TComponentName);
var i, Pos1: Integer;
begin
  for i:=0 to Count-1 do begin
    if Assigned(Items[i].DataSet) then begin
      Pos1:= Pos(BName,Items[i].DataSet.Name);
      if Pos1=1 then begin
        try
          Items[i].DataSet.Name:=AName+Copy(Items[i].DataSet.Name,Length(BName)+1,255);
        except
        end;
      end;
    end;
    if Assigned(Items[i].DataSource) then begin
      Pos1:= Pos(BName,Items[i].DataSource.Name);
      if Pos1=1 then begin
        try
          Items[i].DataSource.Name:=AName+Copy(Items[i].DataSource.Name,Length(BName)+1,255);
        except
        end;
      end;
    end;
  end;
end;

Function TLinkSets.GetItem(Index: Integer): TLinkSetItem;
begin
  Result:=TLinkSetItem(inherited GetItem(Index));
end;

Procedure TLinkSets.SetItem(Index: Integer; Value: TLinkSetItem);
begin
  inherited SetItem(Index, Value);
end;

Function TLinkSets.GetOwner: TPersistent;
begin
  Result:=FSource;
end;

Function TLinkSets.AddDeclar(aDataSet:TDBDataSet): TLinkSetItem;
begin
  Result:=TLinkSetItem(Inherited Add);
  Result.FDataSet:=aDataSet;
  Result.FStyle:=ldDeclar;
  if FDeclarIndex=-1 then begin
    FDeclarIndex:=Result.Index;
    Result.DataSource:=FSource;
  end else begin
    Result.DataSource:=FSource;
(*
   Исправил Лев. Такая ситуация возможно вообще не случится
   Result.DataSource:=TLinkSubSource.Create(FSource.Owner);
   FSource.FSources.Add(Result.DataSource);
   Result.SetUniqueSourceName;
*)
  end;
end;

Function TLinkSets.AddDeclarQuery(aQuery:TQuery; SQLText:string):TLinkSetItem;
var i:integer;
    EField: TField;
    aFieldNames:String;
    aFieldList: TList;
begin
  Result:=AddDeclar(aQuery);
  {Result.FillIndexListCurrent;}
  Result.LinkState:=ltQuery;
  with TLnQuery(Result.DataSet) do begin
    Caption:=ObjectStrProp(Declar,'Caption');
    TableName:=ObjectStrProp(Declar,'TableName');
    DataBaseName:=ObjectStrProp(Declar,'DataBaseName');
    if not Assigned(aQuery) then begin
      SQL.Clear;
      SQL.Add(SQLText);
      { Создает объекты TField для TQuery }
      CreateLinkDefFields(Result.Dataset);
      aFieldNames:=AllFieldNames(Result.DataSet,false,false,false);
      while Result.DataSet.FieldCount > 0 do Result.DataSet.Fields[0].Free;
      aFieldList:=TList.Create;
      DeclarLink.DataSet.GetFieldList(aFieldList,aFieldNames);
      for i:=0 to aFieldList.Count-1 do begin
        TField(CloneComponent(TField(aFieldList[i]))).DataSet:=Result.DataSet;
        EField:=GetLookField(TField(aFieldList[i]));
        if EField<>nil then
          TField(CloneComponent(EField)).DataSet:=Result.DataSet;
      end;
      {SetCompareDefFields(Result.Dataset, DeclarLink.Dataset,DeclarLink.Calc.FieldNames);}
      Open;
      aFieldList.Free;
    end;
  end;
  SetDeclarIndex(Result.Index);
  Result.IfnItem.Fields:=SortingFromDataSet(Result.DataSet);
  {Result.FillIndexListCurrent;}
end;

Function TLinkSets.AddLookup: TLinkSetItem;
begin
  Result:=TLinkSetItem(Inherited Add);
  Result.FStyle:=ldLookup;
(********* ДОБАВИЛ ДЛЯ ТЕСТИРОВАНИЯ 19.02.09 ************)
(* Пока непонятно. Эти DataSource нужны лишь иногда, и вроде бы лучше их создавать на RunTime и пользоваться, чем создавать всегда *)
(* Result.DataSource:=TProcSubSource.Create(FSource.Owner);
(* FSource.FProcSources.Add(Result.DataSource);
(* Result.SetUniqueSourceName;
(********* ДОБАВИЛ ДЛЯ ТЕСТИРОВАНИЯ 19.02.09 ************)
  if FLookupIndex=-1 then FLookupIndex:=Result.Index;
end;

Function TLinkSets.AddProcess: TLinkSetItem;
begin
  Result := TLinkSetItem(Inherited Add);
  Result.FStyle:=ldProcess;
  Result.DataSource:=TProcSubSource.Create(FSource.Owner);
  FSource.FProcSources.Add(Result.DataSource);
  Result.SetUniqueSourceName;
  if FDeclarIndex=-1 then FProcessIndex:=Result.Index;
end;

Procedure TLinkSets.SetDeclarIndex(aDeclarIndex:Integer);
var i: Integer;
begin
  for i:=aDeclarIndex to Count-1 do
    if Items[i].IsDeclarSource then begin
      FDeclarIndex:=i;
      if FSource.DataSet<>Items[i].DataSet then
        FSource.DataSet:=Items[i].DataSet;
      Break;
    end;
  if FDeclarIndex=-1 then begin
    for i:=aDeclarIndex to Count-1 do
      if Items[i].IsDeclar then begin
        FDeclarIndex:= i;
{            FLookupIndex:= i;}
        FSource.DataSet:=Items[i].DataSet;
        Items[i].DataSource:=FSource;
        Break;
      end;
  end;
end;

Procedure TLinkSets.SetLookupIndex;
var i: Integer;
begin
  for i:=0 to Count-1 do
    if Items[i].IsLookup then begin
      FLookupIndex:= i;
      Break;
    end;
end;

Procedure TLinkSets.SetProcessIndex;
var i: Integer;
begin
  for i:=0 to Count-1 do
    if Items[i].IsProcess then begin
      FProcessIndex:= i;
      Break;
    end;
end;

Procedure TLinkSets.SetSourceIndexes;
begin
  SetDeclarIndex(0);
  SetLookupIndex;
  SetProcessIndex;
end;

Procedure TLinkSets.ForEachDataSet(Proc: TGetChildProc);
var i: Integer;
begin
  for i:=0 to Count-1 do
    if Assigned(Items[i].DataSet) then Proc(Items[i].DataSet);
end;

Function TLinkSets.IsDeclar: Boolean;
begin
  Result:=Declar<>Nil;
end;

Function TLinkSets.IsLookup: Boolean;
begin
  Result:= Lookup<>Nil;
end;

Function TLinkSets.IsProcess: Boolean;
begin
  Result:= Process<>Nil;
end;

Function TLinkSets.GetDeclarLink: TLinkSetItem;
begin
  if FDeclarIndex<>-1 then Result:= Items[FDeclarIndex]
  else Result:=nil;
end;

Function TLinkSets.GetLookupLink: TLinkSetItem;
begin
  if FLookupIndex<>-1 then Result:= Items[FLookupIndex]
  else Result:=nil;
end;

Function TLinkSets.GetProcessLink: TLinkSetItem;
begin
  if FProcessIndex<>-1 then Result:= Items[FProcessIndex]
  else Result:=nil;
end;

Function TLinkSets.GetDeclar: TDBDataSet;
begin
  if FDeclarIndex<>-1 then Result:= Items[FDeclarIndex].DataSet
  else Result:=nil;
end;

Function TLinkSets.GetLookup: TDBDataSet;
begin
  if FLookupIndex<>-1 then Result:= Items[FLookupIndex].DataSet
  else Result:=nil;
end;

Function TLinkSets.GetProcess: TDBDataSet;
begin
  if FProcessIndex<>-1 then Result:= Items[FProcessIndex].DataSet
  else Result:=nil;
end;

Procedure TLinkSets.SetActiveDeclar(Value: Boolean);
var i: Integer;
begin
  for i:=0 to Count-1 do
    if (Items[i].Style=ldDeclar) and Assigned(Items[i].DataSet) then
      Items[i].DataSet.Active:=Value;
end;

{ TLinkTable }

Destructor TLinkTable.Destroy;
begin
  inherited Destroy;
end;

Function TLinkTable.IsStoredActive: Boolean;
begin
  Result:= Assigned(LinkSource) and LinkSource.IsStoredActive;
end;

Function TLinkTable.GetDatabaseName: String;
begin
  Result:= Inherited DatabaseName;
end;

Procedure TLinkTable.SetDatabaseName(const Value: string);
begin
  if not (csReading in ComponentState) and Assigned(LinkSource) then
    LinkSource.SetDatabaseName(Value)
  else Inherited DatabaseName:= Value;
end;

Function TLinkTable.GetSessionName: String;
begin
  Result:= Inherited SessionName;
end;

Procedure TLinkTable.SetSessionName(const Value: string);
begin
  if not (csReading in ComponentState) and Assigned(LinkSource) then
    LinkSource.SetSessionName(Value)
  else Inherited SessionName:= Value;
end;

Function TLinkTable.GetTableName: TFileName;
begin
  Result:= Inherited TableName;
end;

Procedure TLinkTable.SetTableName(const Value: TFileName);
begin
  if not (csReading in ComponentState) and Assigned(LinkSource) then begin
    if Value=LinkSource.TableName then Inherited TableName:=Value
    else begin
      if Value<>'' then LinkSource.SetTableName('');
      LinkSource.SetTableName(Value);
    end;
  end else Inherited TableName:= Value;
end;

Procedure TLinkTable.InternalDelete;
begin
  Inherited;
  if Assigned(LinkSource) then LinkSource.RecCountChanged:= True;
end;

Procedure TLinkTable.DoBeforePost;
begin
  if State=dsInsert then begin
    Inherited DoBeforePost;
    if Assigned(LinkSource) then LinkSource.RecCountChanged:= True;
  end else Inherited DoBeforePost;
  if Assigned(LinkSource) then LinkSource.MultiModified:= True;
end;

Procedure TLinkTable.DoBeforeClose;
begin
  CheckBrowseMode;
  Inherited;
end;

Function TLinkTable.HasParent: Boolean;
begin
  HasParent := True;
end;

Function TLinkTable.GetParentComponent: TComponent;
begin
  Result := LinkSource;
end;

Procedure TLinkTable.SetLink(Link: TLinkSource);
begin
  LinkSource:=Link;
end;

Procedure TLinkTable.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetLink(AParent as TLinkSource);
end;

Procedure TLinkTable.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then SetLink(TLinkSource(Reader.Parent));
end;

{ TLinkQuery }

Destructor TLinkQuery.Destroy;
begin
  inherited Destroy;
end;

Function TLinkQuery.IsStoredActive: Boolean;
begin
  Result:= Assigned(LinkSource) and LinkSource.IsStoredActive;
end;

Function TLinkQuery.GetDatabaseName: String;
begin
  Result:= Inherited DatabaseName;
end;

Procedure TLinkQuery.SetDatabaseName(const Value: string);
begin
  if not (csReading in ComponentState) and Assigned(LinkSource) then
    LinkSource.SetDatabaseName(Value)
  else Inherited DatabaseName:= Value;
end;

Function TLinkQuery.GetSessionName: String;
begin
  Result:= Inherited SessionName;
end;

Procedure TLinkQuery.SetSessionName(const Value: string);
begin
  if not (csReading in ComponentState) and Assigned(LinkSource) then
    LinkSource.SetSessionName(Value)
  else Inherited SessionName:= Value;
end;

procedure TLinkQuery.InternalDelete;
begin
  Inherited;
  if Assigned(LinkSource) then LinkSource.RecCountChanged:= True;
end;

procedure TLinkQuery.Post;
begin
  if State=dsInsert then begin
    Inherited;
    if Assigned(LinkSource) then LinkSource.RecCountChanged:= True;
  end else Inherited;
  if Assigned(LinkSource) then LinkSource.MultiModified:= True;
end;

procedure TLinkQuery.DoBeforeClose;
begin
  CheckBrowseMode;
  Inherited;
end;

Function TLinkQuery.HasParent: Boolean;
begin
  HasParent := True;
end;

Function TLinkQuery.GetParentComponent: TComponent;
begin
  Result := LinkSource;
end;

Procedure TLinkQuery.SetLink(Link: TLinkSource);
begin
  LinkSource:=Link;
end;

Procedure TLinkQuery.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetLink(AParent as TLinkSource);
end;

Procedure TLinkQuery.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then
    SetLink(TLinkSource(Reader.Parent));
end;

Procedure TLinkQuery.DoBeforePost;
begin
  if Database.IsSqlBased then AutoIncBeforePost(Self, LinkSource.TableName, DatabaseName);
  inherited DoBeforePost;
end;

{ TLinkStoredProc }

Destructor TLinkStoredProc.Destroy;
begin
  inherited Destroy;
end;

Function TLinkStoredProc.IsStoredActive: Boolean;
begin
  Result:= Assigned(LinkSource) and LinkSource.IsStoredActive;
end;

Procedure TLinkStoredProc.Post;
begin
  inherited;
  if Assigned(LinkSource) then LinkSource.MultiModified:= True;
end;

Procedure TLinkStoredProc.DoBeforeClose;
begin
  CheckBrowseMode;
  Inherited;
end;

Function TLinkStoredProc.HasParent: Boolean;
begin
  HasParent := True;
end;

Function TLinkStoredProc.GetParentComponent: TComponent;
begin
  Result := LinkSource;
end;

Procedure TLinkStoredProc.SetLink(Link: TLinkSource);
begin
  LinkSource:=Link;
end;

Procedure TLinkStoredProc.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetLink(AParent as TLinkSource);
end;

Procedure TLinkStoredProc.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then SetLink(TLinkSource(Reader.Parent));
end;

Procedure TLinkStoredProc.DoBeforePost;
begin
  if Database.IsSqlBased then AutoIncBeforePost(Self, LinkSource.TableName, DatabaseName);
  inherited DoBeforePost;
end;

{ TLinkSubSource }

Destructor TLinkSubSource.Destroy;
begin
  if Assigned(LinkSource) and (not (csDestroying in LinkSource.ComponentState)) then begin
    LinkSource.FSources.Remove(Self);
  end;
  inherited Destroy;
end;

Function TLinkSubSource.HasParent: Boolean;
begin
  HasParent := True;
end;

Function TLinkSubSource.GetParentComponent: TComponent;
begin
  Result := LinkSource;
end;

Procedure TLinkSubSource.SetLink(Link: TLinkSource);
begin
  LinkSource:=Link;
  LinkSource.FSources.Add(Self);
end;

Procedure TLinkSubSource.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetLink(AParent as TLinkSource);
end;

Procedure TLinkSubSource.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then SetLink(TLinkSource(Reader.Parent));
end;

{ TProcSubSource }

Destructor TProcSubSource.Destroy;
begin
  if Assigned(LinkSource) and (not (csDestroying in LinkSource.ComponentState)) then begin
    LinkSource.FProcSources.Remove(Self);
  end;
  inherited Destroy;
end;

Function TProcSubSource.HasParent: Boolean;
begin
  HasParent := True;
end;

function TProcSubSource.GetParentComponent: TComponent;
begin
  Result := LinkSource;
end;

procedure TProcSubSource.SetLink(Link: TLinkSource);
begin
  LinkSource:=Link;
  LinkSource.FProcSources.Add(Self);
end;

procedure TProcSubSource.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetLink(AParent as TLinkSource);
end;

procedure TProcSubSource.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then SetLink(TLinkSource(Reader.Parent));
end;

{ TLinkSource }

Constructor TLinkSource.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FActive:=False;
  FMultiModified:= False;
  FSources:= TList.Create;
  FSources.Add(Self);
  FProcSources:= TList.Create;
  FLinkMaster:= TLinkMaster.Create(Self);
  FLinkSets := TLinkSets.Create(Self);
  FInner:= TLinkTable.Create(Self);
  FIFNUnique:= TIFNItem.Create(Nil);
  FLockSpecials:=False;
{  FFindTable:=Nil;
  FLikeQuery:=Nil;
  FLikePatterns:=Nil;
  FLikeValues:=Nil;
  FLikeList:=Nil;
  FLikeFields:='';}

{!!!}
  FIsSetReturn:=False;
  FIsReturnValue:=False;
  FPostChecked:=True;
  FRecCountChanged:= False;
{!!!  FCurrentLink:=Nil;}
  FOptions:=[dfActivate, dfAutoPost, dfFirstControl, dfRecCount];
end;

Destructor TLinkSource.Destroy;
begin
  {?DestroySimple}
{  if Assigned(FindTable) then begin
     FindTable.Free;
     FindTable:=Nil;
     end;
  if Assigned(FLikeQuery) then begin
     FLikeQuery.Free;
     FLikeQuery:=Nil;
     end;
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
     end;}
  FIFNUnique.Free;
  FProcSources.Free; FProcSources:=nil;
  FSources.Free; FSources:=nil;
  FInner.Free; FInner:=nil;
  FLinkSets.Free; FLinkSets:=nil;
  FLinkMaster.Destroy; FLinkMaster:=nil;
  Inherited Destroy;
end;

procedure TLinkSource.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

procedure TLinkSource.Loaded;
begin
  if Application.Terminated then Exit;
  LinkSets.SetSourceIndexes;
  inherited Loaded;
//  if Optimize then ShowMessage(TLinkSource(Self).Name);
  if IsSetActive and IsDeclar then begin
    FLinkSets.ActiveDeclar:= Active;
{   Declar.Active:= Value;}
    FActive:=Declar.Active;
  end;
  {FLinkMaster.AssignLinks;}
end;

Function TLinkSource.GetName: TComponentName;
begin
  Result:= Inherited Name;
end;

Procedure TLinkSource.SetName(const AName: TComponentName);
var BName: TComponentName;
begin
  BName:= Inherited Name;
  Inherited Name:= AName;
  if BName<>AName then LinkSets.ChangeSourceName(AName, BName);
end;

Function TLinkSource.IsLinkSetsStored: Boolean;
begin
  Result:= LinkSets.Count>0;
end;

Function TLinkSource.IsDeclar: Boolean;
begin
  Result:= FLinkSets.IsDeclar;
end;

Function TLinkSource.IsLookup: Boolean;
begin
  Result:= FLinkSets.IsLookup;
end;

Function TLinkSource.IsProcess: Boolean;
begin
  Result:= FLinkSets.IsProcess;
end;

Function TLinkSource.GetDeclar: TDBDataSet;
begin
  Result:= FLinkSets.Declar;
end;

Function TLinkSource.GetDeclarLink: TLinkSetItem;
begin
  Result:= FLinkSets.DeclarLink;
end;

Function TLinkSource.GetLookup: TDBDataSet;
begin
  Result:= FLinkSets.Lookup;
end;

Function TLinkSource.GetProcess: TDBDataSet;
begin
  Result:= FLinkSets.Process;
end;

Procedure TLinkSource.SetActive(Value: Boolean);
begin
  if FActive <> Value then begin
    FActive:=Value;
    if not (csLoading in ComponentState) then
      if IsSetActive and IsDeclar then begin
        FLinkSets.ActiveDeclar:= Value;
{       Declar.Active:= Value;}
        FActive:=Declar.Active;
      end;
  end;
end;

Function TLinkSource.GetDatabaseName: String;
begin
  Result:=FInner.DatabaseName
end;

Procedure TLinkSource.SetDatabaseName(const Value: string);
var i: Integer;
begin
  if Value<>FInner.DatabaseName then begin
    FInner.DatabaseName:=Value;
    for i:=0 to LinkSets.Count-1 do
      FLinkSets[i].ChangeDatabaseName(Value);
  end;
end;

Function TLinkSource.GetSessionName: String;
begin
  Result:=FInner.SessionName;
end;

Procedure TLinkSource.SetSessionName(const Value: string);
var i: Integer;
begin
  if Value<>FInner.SessionName then begin
    FInner.SessionName:= Value;
    for i:=0 to LinkSets.Count-1 do
      FLinkSets[i].ChangeSessionName(Value);
  end;
end;

Function TLinkSource.GetTableName: TFileName;
begin
  Result:=FInner.TableName;
end;

Procedure TLinkSource.SetTableName(const Value: TFileName);
var i: Integer;
begin
  if Value<>FInner.TableName then begin
    FInner.TableName:=Value;
    // Подправил 15.03.2004 {*Lev*} Чтобы принудительно не присваивалось значение.
    // Необходимо в некоторых случаях использовать View на основе основных таблиц
    {for i:=0 to LinkSets.Count-1 do LinkSets[i].ChangeDataSetName(Value);}
  end;
end;

Procedure TLinkSource.GetChildren(Proc: TGetChildProc; Root: TComponent);
var i: Integer;
begin
  inherited GetChildren(Proc, Root);
  LinkSets.ForEachDataSet(Proc);
  for i:=1 to FSources.Count-1 do Proc(FSources[i]);
  for i:=0 to FProcSources.Count-1 do Proc(FProcSources[i]);
end;

Procedure TLinkSource.PushDataSet(Value: TDBDataSet);
var i: Integer;
    S: String;
begin
  for i:=0 to Value.FieldCount-1 do begin
    Value.Fields[0].DataSet:=FInner;
  end;
  S:= Value.Name;
  Value.Name:='';
  FInner.Name:= S;
end;

Procedure TLinkSource.PopDataSet(Value: TDBDataSet);
var i: Integer;
    S: String;
begin
  for i:=0 to FInner.FieldCount-1 do begin
    FInner.Fields[0].DataSet:=Value;
  end;
  S:=FInner.Name;
  FInner.Name:='';
  Value.Name:=S;
end;

Procedure TLinkSource.CreateLikeQuery(aDataSet:TDataSet);
begin
  if IsDeclar then LinkSets.DeclarLink.Find.InitLikes(aDataSet);
end;

Function TLinkSource.ChangeLikeQuery(ADataSet: TDataSet; Const AFieldsName: String;
                                     Const AStr:String): Boolean;
begin
  if IsDeclar then
    Result:= LinkSets.DeclarLink.Find.ChangeLikeQuery(aDataset, GetEtvTableName(aDataSet), aFieldsName, aStr)
  else Result:= False;
end;
{
procedure TLinkSource.GetLikeValues;
begin
  GetFindLikeValues(LikeQuery, FLikeFields, LikeValues, LikeList);
end;

procedure TLinkSource.FirstLikeQuery;
begin
  LikeQuery.First;
  GetLikeValues;
end;

procedure TLinkSource.LastLikeQuery;
begin
  LikeQuery.Last;
  GetLikeValues;
end;

procedure TLinkSource.NextLikeQuery;
begin
  LikeQuery.Next;
  GetLikeValues;
end;

procedure TLinkSource.PriorLikeQuery;
begin
  LikeQuery.Prior;
  GetLikeValues;
end;}

Function TLinkSource.GetLikePatterns: TStringList;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.Find.LikePatterns
  else Result:=nil;
end;

Function TLinkSource.GetLikeQuery: TQuery;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.Find.LikeQuery
  else Result:=nil;
end;

Procedure TLinkSource.SetLikeQuery(aQuery: TQuery);
begin
  if IsDeclar then LinkSets.DeclarLink.Find.LikeQuery:=TLnQuery(aQuery);
end;

Function TLinkSource.FindExecute(aIFN: String; IsNewIFN: Boolean): Boolean;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.FindExecute(aIFN, IsNewIFN)
    else Result:= False;
end;

{$IFDEF UseXPrinter}

Function TLinkSource.PrintGetTab(Sender: TObject; AIndex: Integer; var AColWidth:LongInt; var IsTab: Boolean): Boolean;
begin
  with TDataSet(Sender) do begin
    IsTab:=Fields[AIndex].Visible;
    if IsTab then
      AColWidth:=XPrinter.GetMaxTabLen(Fields[AIndex].DisplayLabel,
        Fields[AIndex].DisplayWidth);
      Result:= AIndex<FieldCount;
  end;
end;

Procedure TLinkSource.PrintProgressBgn(Sender: TObject);
{
var
  i,j,RecsCount: LongInt;}
begin
  FBookm := TDataSet(Sender).GetBookMark;
  with TDataSet(Sender) do begin
    DisableControls;
    First;
{?}
{
              if FIsTotals then (FDataSet as TLinkTable).LinkSource.ClearTotals;
}
{
       i:=XPrinter.SkipLinesCount(FromPage);
       RecsCount:=RecordCount;
       j:=(RecsCount+Params.LinesCount) div Params.LinesCount;
       if ToPage>j then begin
          ToPage:=j
          end else begin
          j:=ToPage;
          RecsCount:=j*Params.LinesCount;
          end;
       RecsCount:=RecsCount-i;
{??? StartProgress(RecsCount) }
  end;
end;

Procedure TLinkSource.PrintProgressEnd(Sender: TObject);
begin
  TDataSet(Sender).GotoBookMark(FBookm);
  TDataSet(Sender).FreeBookMark(FBookm);
  XPrinter.Finish;
  TDataSet(Sender).EnableControls;
end;

Procedure TLinkSource.PrintProgressBrk(Sender: TObject; var Done: Boolean);
begin
  PrintProgressEnd(Sender);
end;

Procedure TLinkSource.PrintProgress(Sender: TObject; var Done: Boolean);
begin
  ProgressForm.Value:=ProgressForm.Value+1;
{??? Puls}
  if ProgressForm.Value>ProgressForm.Max then
    ProgressForm.Value:=0;
{}
  XPrinter.WriteHeader;
  XPrinter.WriteRecord;
  XPrinter.RecCounter:=XPrinter.RecCounter+1;
  TDataSet(Sender).Next;
  if XPrinter.IsEndRecPage then begin
    XPrinter.PageJump;
{    if FPageNo > FToPage then break;}
  end else
    if TDataSet(Sender).EOF then begin
      if XPrinter.IsTextType then begin
        while Not XPrinter.IsEndRecPage do begin
          XPrinter.WriteDump;
          XPrinter.RecCounter:=XPrinter.RecCounter+1;
        end;
        XPrinter.PageJump;
      end;
{     if ProgressForm.Value<ProgressForm.Max then
        MessageDlg('Преждевременный конец', mtError, [mbOk], 0);}
      ProgressForm.Value:=ProgressForm.Max;
      Done:=False;
    end;
end;

function Max(a, b: longint): longint;
begin
  if a>b then Result:=a
  else Result:=b;
end;

Procedure TLinkSource.PrintWriteTitle(Sender: TObject);
var i: Integer;
    Col: Integer;
begin
  with TDataSet(Sender) do begin
    Col:=1;
    for i:=0 to FieldCount-1 do
      if Fields[i].Visible then begin
        XPrinter.WriteTextRect(Col, Fields[i].Alignment, Fields[i].DisplayLabel,
        Max(Length(Fields[i].Displaylabel), Fields[i].DisplayWidth), True);
        Inc(Col);
      end;
  end;
end;

Procedure TLinkSource.PrintWriteRecord(Sender: TObject);
var i: Integer;
    Col: Integer;
begin
  with TDataSet(Sender) do begin
    Col:=1;
    for i:=0 to FieldCount-1 do
      if Fields[i].Visible then begin
        XPrinter.WriteTextRect(Col, Fields[i].Alignment, Fields[i].DisplayText,
        Max(Length(Fields[i].Displaylabel), Fields[i].DisplayWidth), False);
        Inc(Col);
      end;
  end;
end;

Procedure TLinkSource.PrintWriteDump(Sender: TObject);
var i: Integer;
    Col: Integer;
begin
  with TDataSet(Sender) do begin
    Col:=1;
    for i:=0 to FieldCount-1 do
      if Fields[i].Visible then begin
        XPrinter.WriteTextRect(Col, Fields[i].Alignment, ' ',
        Max(Length(Fields[i].Displaylabel), Fields[i].DisplayWidth), False);
        Inc(Col);
      end;
  end;
end;

Procedure TLinkSource.PrintWriteTotals(Sender: TObject);
var i: Integer;
{    Col: Integer;}
begin
  with TDataSet(Sender) do begin
{       Col:=1;}
    for i:=0 to FieldCount-1 do
      if Fields[i].Visible then begin
{       XPrinter.WriteTextRect(Col, Fields[i].Alignment, ' ',
        Max(Length(Fields[i].Displaylabel), Fields[i].DisplayWidth), False);
        Inc(Col);}
      end;
  end;
end;

procedure TLinkSource.LnPrinting(ADataSet: TObject);
begin
  if Assigned(LinkMaster.Print.Params) then
     XPrinter.XParams:= LinkMaster.Print.Params;
end;

function TLinkSource.PrintExecute: Boolean;
begin
  Result:=False;
  if (ldDeclar in FLinkOptions)and(DeclarState=ltTable) then begin
    if Assigned(XPrinter) then begin
      with XPrinter do begin
        OnGetPrinterTab:=PrintGetTab;
        OnWriteTitle:= PrintWriteTitle;
        OnWriteRecord:= PrintWriteRecord;
        OnWriteDump:= PrintWriteDump;
        OnWriteTotals:= PrintWriteTotals;
      end;
      LnPrinting(Declar);
      if Assigned(FOnLnPrintEvent) then FOnLnPrintEvent(Self);
      if XPrinter.Start then with SystemAppControl do begin
        ProgressCaption:='Печать таблицы';
        ProgressTitle:='Ждите! Идет печать...';
        ProgressObject:=Declar;
        OnProgressBgn:=PrintProgressBgn;
        OnProgressEnd:=PrintProgressEnd;
        OnProgressBrk:=PrintProgressBrk;
        OnProgress:=PrintProgress;
        ProgressActive:=True;
      end;
    end;
  end;
end;

{$ENDIF}

procedure TLinkSource.SummExecute;
begin
{!!!
if ldLookup in FLinkOptions then
   LinkMaster.Calc.SummExecute(Lookup)
   else
   if ldProcess in FLinkOptions then
   LinkMaster.Calc.SummExecute(Process)
   else
   if ldDeclar in FLinkOptions then
   LinkMaster.Calc.SummExecute(Declar);
}
end;

Function TLinkSource.GetCaption: String;
var PropInfo: PPropInfo;
begin
  Result:='';
  if Assigned(Declar) then begin
    PropInfo := GetPropInfo(Declar.ClassInfo, 'Caption');
    if Assigned(PropInfo) then Result:=GetStrProp(Declar,PropInfo);
  end;
end;

Procedure TLinkSource.SetCaption(const Value: String);
var PropInfo: PPropInfo;
begin
  if Assigned(Declar) then begin
    PropInfo := GetPropInfo(Declar.ClassInfo, 'Caption');
    if Assigned(PropInfo) then SetStrProp(Declar, PropInfo, Value);
  end;
end;

Procedure TLinkSource.SetPostChecked(Value: Boolean);
begin
  if FPostChecked<>Value then begin
    DoCheckPostedMode(Value);
    FPostChecked:=Value;
  end;
end;

Procedure TLinkSource.SetLinkSets(Value: TLinkSets);
begin
  FLinkSets.Assign(Value);
end;

{New join functions}

Procedure TLinkSource.ActivateLink(IsLoaded: Boolean);
var ASource:TDataSource;
    I:Integer;
begin
  if (not Application.Terminated) and (((not IsLoaded) and (dfActivate in FOptions)) or
  (IsLoaded and not(dfActivate in FOptions))) then begin
  { if Assigned(DataSet) then DataSet.Active:= Active;}
    for i:=0 to Sources.Count-1 do begin
      ASource:=TDataSource(Sources[i]);
      if Assigned(ASource.DataSet) then ASource.DataSet.Active:=Active;
    end;
  end;
end;

Procedure TLinkSource.DoCheckPostedMode(Value: Boolean);
{var i: Integer;}
begin
{!!!
  for i:=0 to FSources.Count-1 do begin
      TDBFormControl(TXDataSource(FSources.Items[0]).Master).PostChecked:=Value;
      end;}
end;

Procedure TLinkSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then begin
    case TXNotifyEvent(AComponent).SpellEvent of
      {old!!!}
      xeIsDeclar: if IsDeclar then TXNotifyEvent(AComponent).SpellEvent:= xeNone;
      xeGetDataSet: TXNotifyEvent(AComponent).SpellChild:= Declar;
    end;
  end else Inherited;
end;

Function TLinkSource.IsStoredActive: Boolean;
begin
{  Result:= True;}
  Result:=False;
end;

Function TLinkSource.IsSetActive: Boolean;
begin
{  Result:= True;}
  Result:=not (dfActivate in FOptions);
end;

Procedure TLinkSource.SetOptions(Value: TLinksOptions);
begin
  if FOptions <> Value then begin
    if (dfActivate in Value) and (not(dfActivate in FOptions)) then begin
      if (not (csLoading in ComponentState)) and (csDesigning in ComponentState) then begin
        FLinkSets.ActiveDeclar:=False;
      end;
{     Include(FOptions, dfActivate);}
    end;
    if (dfActivate in FOptions)and(Not(dfActivate in Value)) then begin
      if (not (csLoading in ComponentState)) and (csDesigning in ComponentState) then begin
        FLinkSets.ActiveDeclar:=Active;
      end;
{     Exclude(FOptions, dfActivate);}
    end;
    FOptions := Value;
{?! InvalidateForm;}
  end;
end;

(* Закомментарил 25.12.2004. Вроде бы не нужна. Попозже удалить.
Procedure TLinkSource.ChangeLookQueryField(AField: TField; aLC:TDBLookupControlBorland; aLDataSet:TDataSet; aLookUpResultField:string);
begin
  if TableName<>'' then begin
    LnkSet.ChangeLookQueryField(AField, aLC, aLDataSet, aLookUpResultField, GetEtvTableName(aLDataSet))
  end;
end;
*)

Procedure TLinkSource.FillIndexList(AItems: TIFNLink);
var i: Integer;
begin
  case DeclarLink.LinkState of
    ltTable:
      with FInner do begin
        IndexDefs.Update;{!}
        for i := 0 to IndexDefs.Count - 1 do with IndexDefs[i] do
          if not (ixExpression in Options) and (System.Pos('(foreign key)',Name)=0) then begin
            if AItems.IndexOfFields(IndexDefs[i].Fields) < 0 then
              AItems.Add.AssignIndexDef(IndexDefs[I]);
          end;
      end;
    ltQuery:
      begin
        AItems.Add.Assign(DeclarLink.IFNItem);
      end;
  end;
end;

Function TLinkSource.GetCloneDataset(aState: TLinksetState; aFieldNames: String): TDBDataSet;
begin
  Result:= Nil;
  if IsDeclar then Result:= DeclarLink.GetCloneDataset(aState, aFieldNames);
end;

Procedure TLinkSource.ChooseIFNOrderDeclar;
begin
  if IsDeclar then LinkSets.DeclarLink.ChooseIFNOrder;
end;

Procedure TLinkSource.ChooseIFNContextDeclar;
begin
  if IsDeclar then LinkSets.DeclarLink.ChooseIFNContext;
end;

Function TLinkSource.ChooseCalcFieldsDeclar(aCalcOption: TCalcLinkOption): Boolean;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.ChooseCalcFields(aCalcOption)
  else Result:= False;
end;

Function TLinkSource.ChooseGroupByFieldsDeclar: Boolean;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.ChooseGroupByFields
  else Result:= False;
end;

Procedure TLinkSource.ChooseIFNUnique;
begin
  if IsDeclar and FIFNUnique.ChooseOrderFields(LinkSets.DeclarLink.Dataset,
     'Уникальность:'+Caption) then;
end;

Procedure TLinkSource.ChangeIFNDeclar;
begin
  if IsDeclar then LinkSets.DeclarLink.ChangeIFN;
end;

Procedure TLinkSource.ChangeVisibleDeclar;
begin
  if IsDeclar then LinkSets.DeclarLink.ChangeVisible;
end;

Procedure TLinkSource.StoreVisibleDeclar;
begin
  if IsDeclar then LinkSets.DeclarLink.StoreVisible;
end;

Function TLinkSource.GetFilterDeclar: TEtvFilter;
begin
  if IsDeclar then Result:=LinkSets.DeclarLink.Filters.Data
  else Result:=nil;
end;

Function TLinkSource.GetCalcDeclar: TCalcLink;
begin
  if IsDeclar then Result:= LinkSets.DeclarLink.Calc
  else Result:=nil;
end;

Function TLinkSource.CheckBrowseSources: Boolean;
begin
  Result:= True;
  try
    if dfAutoPost in FOptions then begin
      if Assigned(Declar) and Declar.Active and (Declar.State in dsEditModes) then
        Declar.CheckBrowseMode;
      if MultiModified and Assigned(Lookup) and
      ((Lookup is TLinkQuery) or (Lookup is TLinkTable)) and (Lookup.Active) then begin
        MultiModified:= False;
        if Lookup is TLinkQuery then
          TLinkQuery(Lookup).IsClearLinks:=False
        else
          TLinkTable(Lookup).IsClearLinks:=False;
        Lookup.Close;
        if Lookup is TLinkQuery then
          TLinkQuery(Lookup).IsClearLinks:=true
        else
          TLinkTable(Lookup).IsClearLinks:=true;
        Lookup.Open;
      end;
    end;
  except
    Result:= False;
  end;
end;

Initialization
  OtherQueryClass:=TLinkQuery;
  RegisterClasses([TLinkTable, TLinkQuery, TLinkStoredProc, TLinkSubSource, TProcSubSource]);
  XNotifyEvent:=TXNotifyEvent.Create(Nil);
  XNotifyString:=TXNotifyString.Create(Nil);

Finalization
  XNotifyEvent.Free;
  XNotifyEvent:=Nil;
  XNotifyString.Free;
  XNotifyString:=Nil;
end.
