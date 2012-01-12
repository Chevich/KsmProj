Unit LnTables;

Interface

Uses Classes, Controls, Forms,  DBTables, BDE, DB, DBCommon, EtvTable, EtvDBase, EtvFilt;

type
  TLinkSetState = (ltNone, ltTable, ltQuery, ltStoredProc);

  TLnQuery = class;

  TLnFilter=class(TEtvFilter)
  private

  protected

  public

  published

  end;

{ TLnTable }

  TLnTable = class(TEtvTable)
  private
    FIsTempEditValues: Boolean;
    FActiveLinks: Boolean;
    FIsClearLinks: Boolean;
    FIsAutoClosed: Boolean;
    FIsMasterClosed: Boolean;
    FCloneMaster: TDBDataSet;
    FTempMark: TBookMark;
    FTempState: TDataSetState;
    FTempFlag: TBookmarkFlag;
    FTempEditValues: Variant;
    FOldEditValues: Variant;
    FTempEditNames: String;
    FLinks: TList;
    FFilterStream: TMemoryStream;
    procedure SetActiveLinks(Value: Boolean);
    procedure SetCloneMaster(Value: TDBDataSet);
    procedure HandlerTStringFieldSetText(Sender: TField; const Text: string);
    procedure HandlerTDateTimeFieldSetText(Sender: TField; const Text: string);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure InternalOpen; override;
    procedure InternalClose; override;
    {procedure InternalInitRecord(Buffer: PChar); override;}
    procedure InitRecord(Buffer: PChar); override;
    procedure InternalEdit; override;
    procedure DoBeforeInsert; override;
    procedure DoBeforePost; override;
    procedure Cancel; override;
    function  CreateHandle: HDBICur; override;
{    procedure DoOnCalcFields; override;}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetUniqueKey: String;
    procedure SetUniqueFieldList(AList: TList; var AFields: String);
    procedure DoBeforeEdit; override;
    procedure AddField(Field: TField);
    procedure RemoveField(Field: TField);
    procedure OpenMoment;
    procedure CloseOnMoment;
    procedure CloseWithLinks;
(*
    { Проверяет корректность фильтра }
    function CreateExprFilter(const Expr: string; Options: TFilterOptions; Priority: Integer): HDBIFilter;
*)
    property ActiveLinks: Boolean read FActiveLinks write SetActiveLinks default False;
    property IsClearLinks: Boolean read FIsClearLinks write FIsClearLinks;
    property IsAutoClosed: Boolean read FIsAutoClosed write FIsAutoClosed;
    property IsMasterClosed: Boolean read FIsMasterClosed write FIsMasterClosed;
    property Links: TList read FLinks;
    property IsTempEditValues: Boolean read FIsTempEditValues write FIsTempEditValues;
    property OldEditValues: Variant read FOldEditValues write FOldEditValues;
    property TempEditValues: Variant read FTempEditValues write FTempEditValues;
    property TempEditNames: String read FTempEditNames write FTempEditNames;
    property CloneMaster: TDBDataSet read FCloneMaster write SetCloneMaster;
    { Дополнительные фильтры, определяемые пользователем на RunTime }
    property FilterStream:TMemoryStream read FFilterStream write FFilterStream;
  end;
{ TLnTable }

{ TLnQuery }

  TLnQuery = class(TEtvQuery)
  private
    FActiveLinks: Boolean;
    FIsClearLinks: Boolean;
    FIsAutoClosed: Boolean;
    FIsMasterClosed: Boolean;
    FCloneMaster: TDBDataSet;
    FLinks: TList;
    procedure SetActiveLinks(Value: Boolean);
    procedure SetCloneMaster(Value: TDBDataSet);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure InternalOpen; override;
    procedure InternalClose; override;
    function CreateHandle: HDBICur; override;
    function GetIsIndexField(Field: TField): Boolean; override;
  public
    { Дополнительные фильтры, определяемые пользователем на RunTime }
    FilterStream:TMemoryStream;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OpenMoment;
    procedure CloseOnMoment;
    procedure CloseWithLinks;

    property ActiveLinks: Boolean read FActiveLinks write SetActiveLinks default False;
    property IsClearLinks: Boolean read FIsClearLinks write FIsClearLinks;
    property IsAutoClosed: Boolean read FIsAutoClosed write FIsAutoClosed;
    property IsMasterClosed: Boolean read FIsMasterClosed write FIsMasterClosed;
    property Links: TList read FLinks;
    property IndexFieldCount: Integer read GetIndexFieldCount;
    property CloneMaster: TDBDataSet read FCloneMaster write SetCloneMaster;
  end;
{ TLnQuery }

{ TLnStoredProc }

  TLnStoredProc = class(TStoredProc)
  private
    FActiveLinks: Boolean;
    FIsClearLinks: Boolean;
    FIsAutoClosed: Boolean;
    FIsMasterClosed: Boolean;
    FLinks: TList;
    procedure SetActiveLinks(Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure InternalOpen; override;
    procedure InternalClose; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure OpenMoment;
    procedure CloseOnMoment;
    procedure CloseWithLinks;
    property ActiveLinks: Boolean read FActiveLinks write SetActiveLinks default False;
    property IsClearLinks: Boolean read FIsClearLinks write FIsClearLinks;
    property IsAutoClosed: Boolean read FIsAutoClosed write FIsAutoClosed;
    property IsMasterClosed: Boolean read FIsMasterClosed write FIsMasterClosed;
    property Links: TList read FLinks;
  end;
{ TLnStoredProc }

{ TLnDatabase }

  TPDCreateEvent = function (Sender: TObject; Const AUserName: String): TForm of object;
  TPDUserInfoEvent = function (var AUserName, APassword: String): TForm of object;

  TLnDatabase = class(TEtvDataBase)
  private
    FActiveLinks: Boolean;
    FPrefixName: String;
    FOnPDCreate: TPDCreateEvent;
    FOnPDDestroy: TNotifyEvent;
    FOnPDUserInfo: TPDUserInfoEvent;
    procedure SetActiveLinks(Value: Boolean);
  protected
    function PDCreate(Const AUserName: String): TForm; virtual;
    procedure PDDestroy(AForm: TForm);virtual;
    procedure PDUserInfo(AForm: TForm; var AUserName, APassword: String);virtual;
    procedure PDExecute(LoginParams: TStrings); override;
  public
    property PrefixName: String read FPrefixName write FPrefixName ;
  published
    property ActiveLinks: Boolean read FActiveLinks write SetActiveLinks;
    property OnPDCreate: TPDCreateEvent read FOnPDCreate write FOnPDCreate;
    property OnPDDestroy: TNotifyEvent read FOnPDDestroy write FOnPDDestroy;
    property OnPDUserInfo: TPDUserInfoEvent read FOnPDUserInfo write FOnPDUserInfo;
  end;
{ TLnDatabase }

function GetTableModelIFN(aTable: TTable): String;
function GetCloneTableToQuery(aTable: TTable; AFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TLnQuery;
function GetCloneQueryToQuery(aQuery: TQuery; aTableName, aFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TLnQuery;
function GetCloneTableToTable(aTable: TTable; aFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TLnTable;
function GetCloneQueryToTable(aQuery: TQuery; aTableName, aFieldNames: String;
            IsNotData, IsMoveLookup: Boolean; aIFN: String; IsNewIFN: Boolean): TLnTable;
function GetLinkCloneDataset(aDataset: TDataset; aDatasetState, aResultState: TLinkSetState;
            aTableName, aFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TDBDataSet;
        { Клонирует DataSet с его Field'ами }
function GetCloneDataSet(aDataSet:TDataSet; aFieldList:TList):TDBDataSet;
function GetEtvTableName(aDataSet:TDataSet):String;

Implementation

Uses Windows, SysUtils, StdCtrls, DBConsts, Dialogs, IniFiles,
     LnPasw, XMisc, XCracks, XDBMisc, VgUtils, EtvTemp, Misc;

Function GetTableModelIFN(aTable: TTable): String;
begin
  Result:='';
  with aTable.IndexDefs do begin
    Update;
    if aTable.IndexName<>'' then with Items[IndexOf(aTable.IndexName)] do
      if ixExpression in Options then Result:=Expression
      else Result:=Fields
    else Result:=aTable.IndexFieldNames;
  end;
end;

Function GetCloneTableToTable(aTable: TTable; aFieldNames: String; IsNotData,
           IsMoveLookup: Boolean; aIFN: String; IsNewIFN: Boolean): TLnTable;
begin
  Result:=TLnTable.Create(aTable.Owner);
  Result.DatabaseName := aTable.DatabaseName;
  Result.CloneMaster:= aTable;
  if IsNewIFN then
    Result.IndexFieldNames:= aIFN
  else Result.IndexFieldNames:= GetTableModelIFN(aTable);
  Result.TableName := aTable.TableName;
  Result.TableType := aTable.TableType;
  CloneDatasetFieldNames(aTable, Result, aFieldNames, IsNotData, IsMoveLookup);
  Result.Active:= aTable.Active;
end;

Function GetCloneTableToQuery(aTable: TTable; AFieldNames: String; IsNotData,
                   IsMoveLookup: Boolean; aIFN: String; IsNewIFN: Boolean): TLnQuery;
var S: String;
begin
  Result:=TLnQuery.Create(aTable.Owner);
  Result.DatabaseName:=aTable.DatabaseName;
  S:=CreateQueryBaseOnFieldNames(aTable, aTable.TableName, aFieldNames, True);
  S:=S+CreateQueryWhereOnFilter(aTable);
  if IsNewIFN then
    S:=S+CreateQueryOrderOnFieldNames(aTable, aTable.TableName, aIFN, True)
  else S:=S+
    CreateQueryOrderOnFieldNames(aTable, aTable.TableName, GetTableModelIFN(aTable), True);
  Result.SQL.Add(S);
  CloneDatasetFieldNames(aTable, Result, aFieldNames, IsNotData, IsMoveLookup);
  { Подставляем аналогичную функцию для расчета Calculated полей }
  if Assigned(aTable.OnCalcFields) then Result.OnCalcFields:=aTable.OnCalcFields;
  Result.Active:= aTable.Active;
  { Caption для объектов типа Etv и выше }
  if aTable is TEtvTable then
    Result.Caption:=TEtvTable(aTable).Caption
end;

Function GetCloneQueryToTable(aQuery: TQuery; aTableName, aFieldNames: String;
            IsNotData, IsMoveLookup: Boolean; aIFN: String; IsNewIFN: Boolean): TLnTable;
begin
  Result:=TLnTable.Create(aQuery.Owner);
  Result.DatabaseName:= aQuery.DatabaseName;
  Result.TableName := aTableName;
{  Result.TableType := ;}
  CloneDatasetFieldNames(aQuery, Result, aFieldNames, IsNotData, IsMoveLookup);
  if aIFN<>'' then
    Result.IndexFieldNames:= aIFN
  else if IsNewIFN then Result.IndexFieldNames:= aIFN;
  Result.Active:= aQuery.Active;
end;

Function GetCloneQueryToQuery(aQuery: TQuery; aTableName, aFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TLnQuery;
var S: String;
begin
  Result:=TLnQuery.Create(aQuery.Owner);
  Result.DatabaseName := aQuery.DatabaseName;
  if IsNewIFN then begin
    S:= CreateQueryBaseOnFieldNames(aQuery, aTableName, aFieldNames, True);
    S:= S+CreateQueryWhereOnFilter(aQuery);
    S:= S+CreateQueryOrderOnFieldNames(aQuery, aTableName, aIFN, True);
    Result.SQL.Add(S);
  end else Result.SQL.Assign(aQuery.SQL);
  CloneDatasetFieldNames(aQuery, Result, aFieldNames, IsNotData, IsMoveLookup);
  Result.CloneMaster:= aQuery;
  Result.Active:= aQuery.Active;
end;

Function GetCloneDataSet(aDataSet:TDataSet; aFieldList:TList):TDBDataSet;
begin
  try
    Result:=TDBDataSet(CreateClone(TDBDataSet(aDataSet)));
    ClearMethodProps(TDBDataSet(Result));
    { У Гайтанова почему-то не клонируются Field'ы для TQuery }
    if aDataSet is TQuery then begin
      if (TDBDataSet(Result).FieldCount<>TDBDataSet(aDataSet).FieldCount) and
      (TDBDataSet(aDataSet).FieldCount<>0) or
      (TDBDataSet(Result).Fields[1].DisplayLabel<>TDBDataSet(aDataSet).Fields[1].DisplayLabel) then begin
        Result.Active:=false;
        TDBDataSet(Result).Fields.Clear;
        CloneDataSetField(TDBDataSet(Result),aFieldList);
      end;
      TLnQuery(Result).CloneMaster:=TDBDataSet(aDataSet);
    end else TLnTable(Result).CloneMaster:=TDBDataSet(aDataSet);
    Result.Active:=aDataSet.Active;
  finally
    aFieldList.Free;
  end;
end;

Function GetEtvTableName(aDataSet: TDataSet):string;
var Pos1,Pos2: integer;
begin
  Result:='';
  if aDataSet is TEtvTable then Result:=TEtvTable(aDataSet).TableName;
  if aDataSet is TEtvQuery then Result:=TEtvQuery(aDataSet).TableName;
  if (aDataSet is TEtvQuery) and (Result='') then begin
    Pos1:=Pos('from',TEtvQuery(aDataSet).SQL.Text)+5;
    Pos2:=Pos(' ',Copy(TEtvQuery(aDataSet).SQL.Text,Pos1,300));
    Result:=Copy(TEtvQuery(aDataSet).SQL.Text,Pos1,Pos2-1)
  end;
end;

Function GetLinkCloneDataset(aDataset: TDataset; aDatasetState, aResultState: TLinkSetState;
            aTableName, aFieldNames: String; IsNotData, IsMoveLookup: Boolean;
            aIFN: String; IsNewIFN: Boolean): TDBDataSet;
begin
  Result:= Nil;
  case aResultState of
    ltTable:
      case aDatasetState of
        ltTable: Result:= GetCloneTableToTable(TTable(aDataSet),aFieldNames, IsNotData, IsMoveLookup, aIFN, IsNewIFN);
        ltQuery: Result:= GetCloneQueryToTable(TQuery(aDataSet), aTableName, aFieldNames, IsNotData, IsMoveLookup,
                             aIFN, IsNewIFN);
      end;
    ltQuery:
      case aDatasetState of
        ltTable: Result:= GetCloneTableToQuery(TTable(aDataSet), aFieldNames, IsNotData, IsMoveLookup, aIFN, IsNewIFN);
        ltQuery: Result:= GetCloneQueryToQuery(TQuery(aDataSet), aTableName, aFieldNames, IsNotData, IsMoveLookup, aIFN, IsNewIFN);
      end;
  end;
end;

var XNotifySelect: TXNotifySelect;

Procedure Fields_Lock(Self, Select: TBDEDataSet); forward;

procedure LnEventExecute(ANotifyEvent: TXNotifySelect; Operation:TOperation;
                         ALinks: TList; AIsAutoClosed, AIsMasterClosed,
                         AIsClearLinks: Boolean);
begin
  case ANotifyEvent.SpellEvent of
    xeSetLink:
      if Operation = opInsert then begin
        ALinks.Add(ANotifyEvent.SpellChild);
      end else begin
        ALinks.Remove(ANotifyEvent.SpellChild);
        if (ALinks.Count = 0)and AIsAutoClosed then
          TDataSet(ANotifyEvent.SpellChild).Active:=False;
      end;
    xeUpdateLinks:
      if Operation=opInsert then begin
        if TBDEDataSet(ANotifyEvent.SpellChild).Active then
          Fields_Lock(TBDEDataSet(ANotifyEvent.SpellChild), TBDEDataSet(ANotifyEvent.SpellSelect));
      end else begin
        if AIsClearLinks then begin
          if AIsMasterClosed then
            while ALinks.Count>0 do begin
              TDataSet(ALinks.Items[0]).Active:=False;
            end;
          ALinks.Clear;
        end;
      end;
    end;
end;

Procedure ChangeDataBaseLinks(Base: TDatabase; AValue: Boolean; Select:TBDEDataSet);
var i: Integer;
    DataSet: TDataSet;
begin
  if Assigned(Base) then with Base do
    for i:=0 to DataSetCount-1 do begin
      DataSet:=DataSets[i];
      if Assigned(DataSet) then begin
        if AValue then
          XNotifySelect.GoSpellSelect(DataSet,xeUpdateLinks, DataSet, Select, opInsert)
        else TComponentSelf(DataSet).Notification(XNotifySelect, opRemove);
      end;
    end;
end;

Procedure Fields_Lock(Self, Select: TBDEDataSet);
var i: Integer;
    AField: TField;
begin
  with Self do
    for i:=0 to FieldCount-1 do begin
      AField:=Fields[i];
      if AField.Lookup then
        if Assigned(AField.LookupDataSet) and
        ((Select=Nil) or (Select=AField.LookupDataSet)) then begin
          XNotifySelect.GoSpellChild(AField.LookupDataSet, xeSetLink, Self, opInsert);
        end;
    end;
end;

Procedure Fields_UnLock(Self: TBDEDataSet);
var i: Integer;
    AField: TField;
begin
  with Self do begin
    for i:=0 to FieldCount-1 do begin
      AField:=Fields[i];
      if AField.Lookup then
        if Assigned(AField.LookupDataSet) and Assigned(AField.LookupDataSet.Owner) then begin
          XNotifySelect.GoSpellChild(AField.LookupDataSet, xeSetLink, Self, opRemove);
        end;
    end;
    XNotifySelect.GoSpellChild(Self, xeUpdateLinks, Self, opRemove);
  end;
end;

type EInvalidLnOperation = class(Exception);

{ TLnTable }

Constructor TLnTable.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FLinks:=TList.Create;
  FActiveLinks:=False;
  FIsAutoClosed:=False;
  FIsMasterClosed:=False;
  FIsClearLinks:=True;
end;

Destructor TLnTable.Destroy;
begin
  if Active then begin
    Fields_Unlock(Self);
    Active:=False;
  end;
  FLinks.Free;
  FLinks:=Nil;
  if Assigned(FilterStream) then FilterStream.Free;
  Inherited Destroy;
end;

Function TLnTable.CreateHandle: HDBICur;
begin
  if (FCloneMaster <> nil) and (FCloneMaster.Active) then
    Check(DbiCloneCursor(FCloneMaster.Handle, True, False, Result))
  else Result := Inherited CreateHandle;
end;

(*
 Эксперименты на ниве контроля корректности выражения Filter
 Функция из TDataSet.Protected
Function TLnTable.CreateExprFilter(const Expr: string; Options: TFilterOptions; Priority: Integer): HDBIFilter;
var Parser: TExprParser;
begin
  Parser := TExprParser.Create(Self, Expr, Options, [], '', nil);
  try
    Check(DbiAddFilter(Handle, 0, Priority, False, Parser.FilterData, nil, Result));
  finally
    Parser.Free;
  end;
end;
*)

Procedure TLnTable.SetCloneMaster(Value: TDBDataSet);
begin
  if FCloneMaster<>Value then begin
    FCloneMaster:= Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

Function TLnTable.GetUniqueKey: String;
var i: Integer;
begin
  Result:='';
  for i:=0 to IndexDefs.Count-1 do with IndexDefs[i] do
    if ixUnique in Options then begin
      if ixExpression in Options then Result:=Expression
      else Result:=Fields;
      Break;
    end;
end;

Procedure TLnTable.SetUniqueFieldList(AList: TList; var AFields: String);
var BList: TList;
    i: Integer;
begin
{  AList.Clear;
  GetFieldList(AList, GetFindIndexNames);}
  BList:=TList.Create;
  try
    GetFieldList(BList, GetUniqueKey);
    for i:=0 to BList.Count-1 do
      if AList.IndexOf(BList[i])=-1 then begin
        AList.Add(BList[i]);
        if AFields<>'' then AFields:=AFields+';';
        AFields:=AFields+TField(BList[i]).FieldName;
      end;
  finally
    BList.Clear;
    BList.Free;
  end;
end;

Procedure TLnTable.OpenMoment;
begin
  FIsClearLinks:=True;
  Active:=True;
end;

Procedure TLnTable.CloseOnMoment;
begin
  FIsClearLinks:=False;
  Active:=False;
end;

Procedure TLnTable.CloseWithLinks;
begin
  FIsClearLinks:=True;
  FIsMasterClosed:=True;
  Active:=False;
  FIsMasterClosed:=False;
end;

Procedure TLnTable.AddField(Field: TField);
begin
  TDataSetBorland(Self).FFields.Add(Field);
  TFieldBorland(Field).FDataSet := Self;
  DataEvent(deFieldListChange, 0)
end;

Procedure TLnTable.RemoveField(Field: TField);
begin
  TFieldBorland(Field).FDataSet := nil;
  TDataSetBorland(Self).FFields.Remove(Field);
  if not (csDestroying in ComponentState) then DataEvent(deFieldListChange, 0)
end;

{
procedure TLnTable.DoOnCalcFields;
var
  I: Integer;
begin
  for I := 0 to FieldCount - 1 do
    if Fields[i] is TLnMultiField then
    with TLnMultiField(Fields[I]) do
         CalcMultiValue;
  inherited DoOnCalcFields;
end;
}

Procedure TLnTable.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (aComponent=FCloneMaster)and Assigned(FCloneMaster) then begin
    if Operation=opRemove then begin
{!    Active:= False;}
      FCloneMaster:= Nil;
    end;
  end else
  if AComponent is TXNotifyEvent then
    if TXNotifyEvent(AComponent).SpellEvent=xeSetParams then begin
      if Operation=opInsert then begin
        FTempState:=State;
        DisableControls;
        if State in [dsEdit, dsInsert] then begin
          FTempFlag:=GetBookmarkFlag(ActiveBuffer);
          FIsTempEditValues:=True;
          Cancel;
        end;
        FTempMark:=GetBookmark;
      end else begin
        if Assigned(FTempMark) then begin
          InternalGotoBookmark(FTempMark);
          FreeBookmark(FTempMark);
        end;
        Resync([]);
        case FTempState of
          dsInsert:
            begin
              if FTempFlag=bfEOf then Append
              else Insert;
              FIsTempEditValues:=False;
            end;
          dsEdit:
            begin
              Edit;
              FIsTempEditValues:=False;
            end;
        end;
        EnableControls;
      end;
    end else
      LnEventExecute(TXNotifySelect(AComponent), Operation, FLinks,
        FIsAutoClosed, FIsMasterClosed, FIsClearLinks)
  else Inherited;
end;

Procedure TLnTable.HandlerTStringFieldSetText(Sender: TField; const Text: string);
begin
  if (Sender is TStringField) and (Text<>'') then
    TStringField(Sender).AsString:=SpaceCompress(Text)
  else TStringField(Sender).AsString:='';
end;

Procedure TLnTable.HandlerTDateTimeFieldSetText(Sender: TField; const Text: string);
var Year,Month,Day: Word;
    MonthStr,DayStr:string[2];
    Delta: integer;
    aDateTime: TDateTime;
begin
  if (Sender is TDateTimeField) and (Text<>'') then begin
    aDateTime:=StrToDate(Text);
       {    01.01.1950 (18264)  01.01.1920 (7306) 01.01.2010   }
    if (aDateTime<7306) or (aDateTime>40179{54789}) then begin
      if (aDateTime<7306) then Delta:=100 else Delta:=-100;
      DecodeDate(aDateTime,Year,Month,Day);
      if Day<10 then DayStr:='0'+IntToStr(Day)
      else DayStr:=IntToStr(Day);
      if Month<10 then MonthStr:='0'+IntToStr(Month)
      else MonthStr:=IntToStr(Month);
      aDateTime:=StrToDate_(DayStr+'.'+MonthStr+'.'+IntToStr(Year+Delta))+Frac(aDateTime);
      {AsDateTime:=AsDateTime+36524;}
      { Подкорректируем запоминаемые значения, чтобы не было проблем в дальнейшем }
      {if VarType(FOldEditValues)<>varEmpty then
        FOldEditValues[i]:=Fields[i].AsString}
    end;
    TDateTimeField(Sender).AsDateTime:=aDateTime;
  end;
end;

Procedure TLnTable.InternalOpen;
var i: integer;
begin
  Inherited;{BDE_InternalOpen(Self);}
  with TLnTable(Self) do begin
    for i:=0 to FieldCount-1 do with Fields[i] do
      case DataType of
        ftString: OnSetText:=HandlerTStringFieldSetText;
        {ftDateTime,ftDate: OnSetText:=HandlerTDateTimeFieldSetText;}
      end;
  end;
  if FActiveLinks then Fields_Lock(Self, Nil);
end;

Procedure TLnTable.InternalClose;
begin
  if FActiveLinks then Fields_Unlock(Self);
  Inherited InternalClose;
end;

Procedure TLnTable.InitRecord(Buffer: PChar);
var AState: TDataSetState;
begin
  Inherited InitRecord(Buffer);
  if FIsTempEditValues and (FTempEditNames<>'') then begin
    AState:=State;
    SetTempState(dsInsert);
    FieldValues[FTempEditNames]:=FTempEditValues;
    RestoreState(AState);
  end;
end;

Procedure TLnTable.DoBeforeEdit;
var Si: String;
    i: Integer;
begin
  if not FIsTempEditValues then begin
    Si:='';
    if VarIsEmpty(FOldEditValues) then
      FOldEditValues:=VarArrayCreate([0, FieldCount-1], varVariant);
    for i:=0 to FieldCount-1 do begin
      FOldEditValues[i]:=Fields[i].Value
    end;
(*
    for i:=0 to FieldCount-1 do
      Si:=Si+';'+Fields[i].FieldName;
    System.Delete(Si,1,1);
    FOldEditValues:=FieldValues[Si];
*)
  end;
  Inherited;
end;

Procedure TLnTable.DoBeforeInsert;
begin
  { 27.08.09 Lev Старые значения могут понадобиться для инициализации полей новой записи. }
  {if not VarIsEmpty(FOldEditValues) then VarClear(FOldEditValues); }
  { 03.12.09 - последствия исправления ошибок }
  { Если FOldEditValues еще не существовало }
  if VarIsEmpty(FOldEditValues) then FOldEditValues:=VarArrayCreate([0, FieldCount-1], varVariant);
  Inherited;
end;

Procedure TLnTable.DoBeforePost;
var i: Integer;
    Year,Month,Day: Word;
    MonthStr,DayStr:string[2];
    Delta: integer;
begin
  { Корректировка на 2000 год }
  for i:=0 to FieldCount-1 do begin
    if (Fields[i] is TDateTimeField) and not (Fields[i].IsNull) then
      with TDateTimeField(Fields[i]) do
         {    01.01.1950 (18264)  01.01.1920 (7306) 01.01.2015(42035) 01.01.2030(47484)}
      if (AsDateTime<7306) or (AsDateTime>47484{54789}) then begin
        if (AsDateTime<7306) then Delta:=100 else Delta:=-100;
        DecodeDate(AsDateTime,Year,Month,Day);
        if Day<10 then DayStr:='0'+IntToStr(Day)
        else DayStr:=IntToStr(Day);
        if Month<10 then MonthStr:='0'+IntToStr(Month)
        else MonthStr:=IntToStr(Month);
        AsDateTime:=StrToDate_(DayStr+'.'+MonthStr+'.'+IntToStr(Year+Delta))+Frac(AsDateTime);
        {AsDateTime:=AsDateTime+36524;}
        { Подкорректируем запоминаемые значения, чтобы не было проблем в дальнейшем }
        if VarType(FOldEditValues)<>varEmpty then FOldEditValues[i]:=Fields[i].AsString
        { 02.12.09 Lev - Строчка выше стояла ниже оператора End, что приводило к }
        { преждевременной инициализации СОХРАНЕННЫХ ЗНАЧЕНИЙ ПОЛЕЙ }
        { Например, при изменении в ТТН значения поля "Плательщик" не происходило изменения значений поля Client в строке STA.InvoiceProd }
        { Вывод: программы надо писать аккуратно и постоянно сомневаться }
      end;
  end;
  Inherited DoBeforePost;
  { А теперь запомнили старые значения }
  for i:=0 to FieldCount-1 do FOldEditValues[i]:=Fields[i].Value
end;

Procedure TLnTable.InternalEdit;
var AState: TDataSetState;
begin
  if FIsTempEditValues and (FTempEditNames<>'') then begin
    AState:=State;
    SetTempState(dsEdit);
    FieldValues[FTempEditNames]:=FTempEditValues;
    RestoreState(AState);
{   Move(FLinkBuffer^, ActiveBuffer^, TBDEDataSetBorland(Self).FRecBufSize);}
  end else Inherited InternalEdit;
end;

Procedure TLnTable.Cancel;
var Si: String;
    i: Integer;
begin
  if FIsTempEditValues then begin
    Si:='';
    for i:=0 to FieldCount-1 do
      if (Fields[i].FieldKind=fkData) and not(Fields[i].ReadOnly) then
        if State=dsInsert then begin
          if Fields[i].Value<>NULL then Si:=Si+';'+Fields[i].FieldName;
        end else
          if State=dsEdit then begin
            if Fields[i].Value<>FOldEditValues[i] then Si:=Si+';'+Fields[i].FieldName;
          end;
    if Si<>'' then begin
      System.Delete(Si,1,1);
      FTempEditNames:=Si;
      FTempEditValues:=FieldValues[FTempEditNames];
    end else FTempEditNames:='';
{   Move(ActiveBuffer^, FLinkBuffer^, TBDEDataSetBorland(Self).FRecBufSize);}
  end;
  Inherited Cancel;
end;

Procedure TLnTable.SetActiveLinks(Value: Boolean);
begin
  if Value<>FActiveLinks then begin
    FActiveLinks:=Value;
    if Value then begin
      ChangeDataBaseLinks(TDBDataSetBorland(Self).FDataBase, Value, Self);
    end else begin
      FIsClearLinks:=True;
      Fields_Unlock(Self);
    end;
  end;
end;

{ TLnQuery }

Constructor TLnQuery.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  { В Help'е пишут, что должно работать быстрее       }
  { Надеюсь, что приложение быстрее будет загружаться }
  UniDirectional:=true;
  UpdateMode:=upWhereKeyOnly;
  {*************************}
  FLinks:=TList.Create;
  FActiveLinks:=False;
  FIsAutoClosed:=False;
  FIsMasterClosed:=False;
  FIsClearLinks:=True;
end;

Destructor TLnQuery.Destroy;
begin
  if Active then begin
    Fields_Unlock(Self);
    Active:=False;
  end;
  FLinks.Free;
  FLinks:=Nil;
  if Assigned(FilterStream) then FilterStream.Free;
  Inherited Destroy;
end;

Function TLnQuery.CreateHandle: HDBICur;
begin
  if (FCloneMaster <> nil) and (FCloneMaster.Active) then
    Check(DbiCloneCursor(FCloneMaster.Handle, True, False, Result))
  else Result:=Inherited CreateHandle;
end;

Procedure TLnQuery.SetCloneMaster(Value: TDBDataSet);
begin
  if FCloneMaster<>Value then begin
    FCloneMaster:=Value;
    if Value<>nil then Value.FreeNotification(Self);
  end;
end;

Function TLnQuery.GetIsIndexField(Field: TField): Boolean;
begin
  if (State=dsSetKey) then Result:=True
  else Result:=Inherited GetIsIndexField(Field);
end;

Procedure TLnQuery.OpenMoment;
begin
  FIsClearLinks:=True;
  Active:=True;
end;

Procedure TLnQuery.CloseOnMoment;
begin
  FIsClearLinks:=False;
  Active:=False;
end;

Procedure TLnQuery.CloseWithLinks;
begin
  FIsClearLinks:=True;
  FIsMasterClosed:=True;
  Active:=False;
  FIsMasterClosed:=False;
end;

procedure TLnQuery.SetActiveLinks(Value: Boolean);
begin
  if Value<>FActiveLinks then begin
    FActiveLinks:=Value;
    if Value then begin
      ChangeDataBaseLinks(TDBDataSetBorland(Self).FDataBase, Value, Self);
    end else begin
      FIsClearLinks:=True;
      Fields_Unlock(Self);
    end;
  end;
end;

Procedure TLnQuery.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (aComponent=FCloneMaster)and Assigned(FCloneMaster) then begin
    if Operation=opRemove then begin
{!    Active:= False;}
      FCloneMaster:= Nil;
    end;
  end else
    if AComponent is TXNotifySelect then
      LnEventExecute(TXNotifySelect(AComponent), Operation, FLinks,
                      FIsAutoClosed, FIsMasterClosed, FIsClearLinks)
    else Inherited;
end;

Procedure TLnQuery.InternalOpen;
begin
  Inherited;{BDE_InternalOpen(Self);}
  Fields_Lock(Self, Nil);
end;

Procedure TLnQuery.InternalClose;
begin
  Fields_Unlock(Self);
  Inherited InternalClose;
end;

{ TLnStoredProc }

Constructor TLnStoredProc.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FLinks:=TList.Create;
  FActiveLinks:=False;
  FIsAutoClosed:=False;
  FIsMasterClosed:=False;
  FIsClearLinks:=True;
end;

Destructor TLnStoredProc.Destroy;
begin
  if Active then begin
    Fields_Unlock(Self);
    Active:=False;
  end;
  FLinks.Free;
  FLinks:=nil;
  Inherited Destroy;
end;

Procedure TLnStoredProc.OpenMoment;
begin
  FIsClearLinks:=True;
  Active:=True;
end;

Procedure TLnStoredProc.CloseOnMoment;
begin
  FIsClearLinks:=False;
  Active:=False;
end;

Procedure TLnStoredProc.CloseWithLinks;
begin
  FIsClearLinks:=True;
  FIsMasterClosed:=True;
  Active:=False;
  FIsMasterClosed:=False;
end;

Procedure TLnStoredProc.SetActiveLinks(Value: Boolean);
begin
  if Value<>FActiveLinks then begin
    FActiveLinks:=Value;
    if Value then begin
      ChangeDataBaseLinks(TDBDataSetBorland(Self).FDataBase, Value, Self);
    end else begin
      FIsClearLinks:=True;
      Fields_Unlock(Self);
    end;
  end;
end;

Procedure TLnStoredProc.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifySelect then
    LnEventExecute(TXNotifySelect(AComponent), Operation, FLinks,
                    FIsAutoClosed, FIsMasterClosed, FIsClearLinks)
  else Inherited;
end;

Procedure TLnStoredProc.InternalOpen;
begin
  Inherited;{BDE_InternalOpen(Self);}
  Fields_Lock(Self, Nil);
end;

Procedure TLnStoredProc.InternalClose;
begin
  Fields_Unlock(Self);
  Inherited InternalClose;
end;

{ TLnDatabase }

type ELnDatabaseError = class(Exception);

Procedure TLnDatabase.SetActiveLinks(Value: Boolean);
begin
  if Value<>FActiveLinks then begin
    ChangeDataBaseLinks(Self, Value, Nil);
    FActiveLinks:=Value;
  end;
end;

Function TLnDatabase.PDCreate(Const AUserName: String): TForm;
begin
  if Assigned(FOnPDCreate) then Result:=FOnPDCreate(Self, AUserName)
  else Result:=nil;
  if Result=nil then begin
    Result:= TLnPaswDlg.Create(Application);
    with TLnPaswDlg(result) do begin
      Caption:=Self.Caption;
      User.Text:=AUserName;
    end;
  end;
end;

Procedure TLnDatabase.PDDestroy(AForm: TForm);
begin
  if Assigned(FOnPDDestroy) then FOnPDDestroy(Self);
  if AForm is TLnPaswDlg then AForm.Free;
end;

Procedure TLnDatabase.PDUserInfo(AForm: TForm; var AUserName, APassword: String);
begin
  if Assigned(FOnPDUserInfo) then FOnPDUserInfo(AUserName, APassword);
  if AForm is TLnPaswDlg then
    with TLnPaswDlg(AForm) do begin
      AUserName:=User.Text;
      APassword:= Password.Text;
    end;
end;

var Form: TForm=Nil;

Procedure TLnDatabase.PDExecute(LoginParams: TStrings);
var {Form: TForm;}
    AUserName, APassword: String;
begin
  Form:=PDCreate(LoginParams.Values['USER NAME']);
  if Form<>nil then
  try
    if Form.ShowModal=mrOk then begin
      Application.ProcessMessages;
      PDUserInfo(Form, AUserName, APassword);
      UserName:=AUserName;
      Password:=APassword;
      LoginParams.Values['USER NAME']:=AUserName;
      LoginParams.Values['PASSWORD']:=APassword;
    end else
      raise ELnDatabaseError.Create('Отмена ввода пароля');
  finally
    PDDestroy(Form);
  end;
end;

Initialization
  XNotifySelect:=TXNotifySelect.Create(Nil);

Finalization
  XNotifySelect.Free;
  XNotifySelect:=Nil;
end.
