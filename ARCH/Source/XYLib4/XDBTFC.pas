{*******************************************************}
{                                                       }
{            X-library v.03.01                          }
{                                                       }
{   07.10.97      					}
{                                                       }
{   TXSourceDataLink - datalink of linksources          }
{   TXLinkSourceItem                                    }
{   TXLinkSources                                       }
{   TXInquiryDataLink - ? datalink of Inquiries         }
{   TXInquiryItem - stored link with TLinkSource        }
{   TXInquiries - collection of TXInquiryItems          }
{   TXReportItem - report item                          }
{   TXReports -                                         }
{                                                       }
{   TDBFormControl - form control of LinkSets           }
{   TXDatabase - database of projects                   }
{   TDBToolsControl - users tools control               }
{                                                       }
{  corrections  15.04.98                                }
{  This similar by Alex Plas PlDBForm                   }
{  TXDataset, TXDataSource components removed           }
{  and add TXSourceDataLink                             }
{                                                       }
{  Last corrections 12.02.99                            }
{                                                       }
{*******************************************************}
{$I XLib.inc}

Unit XDBTFC;

Interface

Uses Classes, Controls, Forms, XTFC, DB, DBTables, LnTables, LnkSet, EtvFilt, UsersSet,
     LnkMisc, XReports, EtvMem
{$IFDEF Report_Builder}
     , ppTypes, ppEndUsr, XLnkPipe
{$ENDIF}
     ;

const
     btFilterDlg  = 16;
     btVisFields  = 17;
     btIndexFields= 18;
     btResultCalc = 19;
     btEditReport = 20;
     btEditInquiry = 21;
     btCancelInquiry = 22;
     btCurrFilterDlg = 23;
     btAggrSelectCalc = 24;
     btSetAggregate = 25;
     btCancelAggregate = 26;
     btIFNUnique = 27;
     btIFNContext = 28;
{Lev}
     btFormatInquiryAsInDataBase=29;
     btFormatInquiry=30;
     {btSetAggrWithIndex = 30;}
{Lev}
     btAggrGroupByCalc = 31;
     btRecordCountView = 32;
{200-255 зарезервировано в модуле XTFC }
     btDefInquiry  = 256;
     btUserInquiry = 320;

     btCurrentFilter = 512;
     btCancelFilter = 513;
     btFilter     = 514;
     btExportToExcel=1000;
     btDefReport  = 768;
     btUserReport = 832;
     btLevTest = 999;
     btLevTest_1 = 998;

type

  TDBFormControl = class;
  TXLinkSourceItem = class;
  TXLinkSources = class;
  TXInquiryItem = class;
  TXInquiries = class;
  TXReports = class;
  TXReportItem = class;

{ TXSourceDataLink }

  TXSourceDataLink = class(TDataLink)
  private
    FXItem: TXLinkSourceItem;
    procedure StateChanged;
    procedure FormChanged;
  protected
    procedure ActiveChanged; override;
    {procedure DataSetChanged; override;}
    procedure EditingChanged; override;
  public
    constructor Create(AXItem: TXLinkSourceItem);
  end;

{ TXLinkSourceItem }
  TXLinkSourceItem = class(TCollectionItem)
  private
    FDataLink: TXSourceDataLink;
    FCurrentFilter: TEtvFilter;
    procedure StateChanged(AState: TDataSetState);
    function GetDisplayName: string; override;
    function  GetSource: TDataSource;
    procedure SetSource(Value: TDataSource);
    function GetSources: TXLinkSources;
    function GetDBControl: TDBFormControl;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignLinkItem(AItem: TXLinkSourceItem); virtual;
    property XDataLink: TXSourceDataLink read FDataLink;
    property Sources: TXLinkSources read GetSources;
    property DBControl: TDBFormControl read GetDBControl;
    property CurrentFilter: TEtvFilter read FCurrentFilter write FCurrentFilter;
  published
    property Source: TDataSource read GetSource write SetSource;
  end;
{ TXLinkSourceItem }

{ TXLinkSources }
  TXLinkSources = class(TCollection)
  private
    FControl: TDBFormControl;
    function GetItem(Index: Integer): TXLinkSourceItem;
    procedure SetItem(Index: Integer; Value: TXLinkSourceItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AControl: TDBFormControl);
    function Add: TXLinkSourceItem;
    function IndexOfLink(ALink: TDataSource): Integer;
    function IndexOfLinkName(Const AName: String): Integer;
    procedure GetSrcStrings(AItems: TStrings);
    property Items[Index: Integer]: TXLinkSourceItem read GetItem write SetItem; default;
  end;
{ TXLinkSources }

{ TXInquiryDataLink }
  TXInquiryDataLink = class(TDataLink)
  private
    FXItem: TXInquiryItem;
    procedure StateChanged;
  protected
    procedure ActiveChanged; override;
    {procedure DataSetChanged; override;}
    procedure EditingChanged; override;
  public
    constructor Create(AXItem: TXInquiryItem);
  end;
{ TXInquiryDataLink }

{ TXInquiryItem }
  TXInquiryItem = class(TAggregateLink)
  private
    FFilterCheck: Boolean;
    FIndexCheck: Boolean;
    FGroupIndex: Integer;
    FCaption: String;
    FUserName: String;
    FReportName: String;
    FDataLink: TXInquiryDataLink;
    FPrintLink: TPrintLink;
    procedure SetCaption(const Value: string);
    function GetDisplayName: string; override;
    procedure StateChanged(AState: TDataSetState);
    function  GetSource: TDataSource;
    procedure SetSource(Value: TDataSource);
    procedure RemoveSource(Value: TDataSource);
    function GetSources: TXInquiries;
    function GetDBControl: TDBFormControl;
    function IsStoreUserName: Boolean;
    procedure SetFilterIndex(Value: Integer);
    function GetFilterIndex: Integer;
    function GetReportItemIndex: Integer;
    function GetPrintActive: Boolean;
    procedure SetPrintActive(Value: Boolean);
  protected
    function GetLinkTableName: String; override;
    function GetLinkDataset: TDataset; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure AssignLinkItem(AItem: TAggregateLink); override;
    function GetCurrentFilterName: String;
    procedure GetFilterNames(AItems: TStrings);
    procedure GetIFNsNames(AItems: TStrings);
    procedure ChangeIFN;
    procedure ChooseIFNOrder;
    procedure ChooseIFNContext;
    function ChooseCalcFields(aCalcOption: TCalcLinkOption): Boolean;
    function ChooseGroupByCalcFields: Boolean;
    procedure ChangeLinkIFN(const aIFN: String); override;
    property Inquiries: TXInquiries read GetSources;
    property DBControl: TDBFormControl read GetDBControl;
    property FilterIndex: Integer read GetFilterIndex write SetFilterIndex;
    property ReportItemIndex: Integer read GetReportItemIndex;
  published
    property FilterCheck: Boolean read FFilterCheck write FFilterCheck default False;
    property IndexCheck: Boolean read FIndexCheck write FIndexCheck default False;
    property GroupIndex: Integer read FGroupIndex write FGroupIndex default 0;
    property Caption: string read FCaption write SetCaption;
    property Source: TDataSource read GetSource write SetSource;
    property ActiveOwner;
    property UserName: String read FUserName write FUserName stored IsStoreUserName;
    property ReportName: String read FReportName write FReportName;
    property PrintActive: Boolean read GetPrintActive write SetPrintActive default False;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
  end;
{ TXInquiryItem }

{ TXInquiries }
  TXInquiries = class(TCollection)
  private
    FControl: TDBFormControl;
    function GetItem(Index: Integer): TXInquiryItem;
    procedure SetItem(Index: Integer; Value: TXInquiryItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AControl: TDBFormControl);
    function Add: TXInquiryItem;
    function IndexOfLink(Const AName: String): Integer;
    function GetCopyLinks: TXInquiries;
    function GetUserLinks(Const AUserName: String; IsMove, IsExclude: Boolean): TXInquiries;
    procedure SetUserName(Const AUserName: String);
    procedure GetSrcStrings(AItems: TStrings);
    property Items[Index: Integer]: TXInquiryItem read GetItem write SetItem; default;
  end;
{ TXInquiries }

{ TXReportItem }
  TXReportType = (rtNone, rtEtvShb, rtRBuilder, rtSimple);

  TXReportItem = class(TCollectionItem)
  private
    FInMem: Boolean;
    FReadInMem: Boolean;
    FReportName: String;
    FCaption: String;
    FUserName: String;
    FReportType: TXReportType;
{$IFDEF Report_Builder}
{    FPipeLink: TPipeControl;}
    FPrintLink: TPrintLink;
{$ENDIF}
    FReport: TComponent;
    procedure SetCaption(const Value: string);
    procedure SetReportName(const Value: string);
    procedure SetReportType(Value: TXReportType);
    function GetDisplayName: string; override;
    function GetReports: TXReports;
    function GetDBControl: TDBFormControl;
    procedure SetUniqueReportName;
    function IsStoreUserName: Boolean;
    function GetPrintActive: Boolean;
    procedure SetPrintActive(Value: Boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignReportItem(AItem: TXReportItem); virtual;
    property Reports: TXReports read GetReports;
    property DBControl: TDBFormControl read GetDBControl;
    property InMem: Boolean read FInMem;
  published
    property Caption: String read FCaption write SetCaption;
    property TypeReport: TXReportType read FReportType write SetReportType default rtNone;
{    property ReportType: TXReportType read FReportType write SetReportType stored False;}

{$IFDEF Report_Builder}
{    property PipeLink: TPipeControl read FPipeLink write FPipeLink;}
    property PrintActive: Boolean read GetPrintActive write SetPrintActive default False;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
{$ENDIF}
    property ReportName: String read FReportName write SetReportName;
    property Report: TComponent read FReport write FReport;
    property ReadInMem: Boolean read FReadInMem write FReadInMem default False;
    property UserName: String read FUserName write FUserName stored IsStoreUserName;
  end;
{ TXReportItem }

{ TXReports }
  TXReports = class(TCollection)
  private
    FControl: TDBFormControl;
    function GetItem(Index: Integer): TXReportItem;
    procedure SetItem(Index: Integer; Value: TXReportItem);
  protected
    function GetOwner: TPersistent; override;
    function TryName(const Test: string): Boolean;
  public
    constructor Create(AControl: TDBFormControl);
    function Add: TXReportItem;
    function SpecialAdd(aTypeReport: TXReportType; aTypePrint: TXPrintDevice): TXReportItem;
    function IndexOfReport(Const AName: String): Integer;
    function IndexOfCaption(Const ACaption: String): Integer;
    function GetCopyReports: TXReports;
    function GetUserReports(Const AUserName: String; IsMove, IsExclude: Boolean): TXReports;
    procedure SetUserName(Const AUserName: String);
    procedure GetSrcStrings(AItems: TStrings);
    procedure Assign(Source: TPersistent); override;
    property Items[Index: Integer]: TXReportItem read GetItem write SetItem; default;
  end;
{ TXReports }

{ TDBToolsControl }
  TDBToolsControl = class(TToolsControl)
  private
    FUserSource: TUserSource;
    FReportSource: TUserSource;
{$IFDEF Report_Builder}
    FReporter: TppDesigner;
    FTypePrint: TXPrintDevice;
    FTypeDevice: TppDeviceType;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property UserSource: TUserSource read FUserSource write FUserSource;
    property ReportSource: TUserSource read FReportSource write FReportSource;
{$IFDEF Report_Builder}
    property Reporter: TppDesigner read FReporter write FReporter;
    property TypePrint: TXPrintDevice read FTypePrint write FTypePrint;
    property TypeDevice: TppDeviceType read FTypeDevice write FTypeDevice;
{$ENDIF}
  end;
{ TDBToolsControl }

{ TDBFormControl }
  TRegimeStyle = (rmNone, rmView, rmEdit, rmInsert, rmSearch, rmFilter, rmModel);
{
  fcNone - no tool operations
  fcAutoNone - change in automatic operations
  fcSelf - self tool operations
  fcTools - operations from TDBToolsControl
}
  TXFormControlType = (fcNone, fcAutoNone, fcSelf, fcTools);

  TDBFormTools = class(TFormTools)
  private
    FDBActive: Boolean;
    FUserType: TXFormControlType;
    FReportType: TXFormControlType;
    FReporterType: TXFormControlType;
    FUserSource: TUserSource;
    FReportSource: TUserSource;
{$IFDEF Report_Builder}
    FReporter: TppDesigner;
    FTypePrint: TXPrintDevice;
    FTypeDevice: TppDeviceType;
    FTypeTools: TXFormControlType;
{$ENDIF}
    procedure SetDBActive(Value: Boolean);
  protected
    procedure ToolsChanged; override;
  public
    constructor Create(AControl: TFormControl);
  published
    property DBActive: Boolean read FDBActive write SetDBActive default True;
    property UserType: TXFormControlType read FUserType write FUserType default fcNone;
    property ReportType: TXFormControlType read FReportType write FReportType default fcNone;
    property ReporterType: TXFormControlType read FReporterType write FReporterType default fcNone;
    property UserSource: TUserSource read FUserSource write FUserSource;
    property ReportSource: TUserSource read FReportSource write FReportSource;
{$IFDEF Report_Builder}
    property Reporter: TppDesigner read FReporter write FReporter;
    property TypePrint: TXPrintDevice read FTypePrint write FTypePrint;
    property TypeDevice: TppDeviceType read FTypeDevice write FTypeDevice;
    property TypeTools: TXFormControlType read FTypeTools write FTypeTools;
{$ENDIF}
  end;
{ TDBFormTools }

  TDBFormControl = class(TFormControl)
  private
    FDefDBCaption: Boolean;
    FDefRecCount: Boolean;
    FRegime: TRegimeStyle;           { В каком режиме находится текущий DataSet }
                                     { Для отображивания в заголовке окна       }
    FCurrentRecordCount: LongInt;
    FOldRecordCount: LongInt; { В этой переменной запоминаем RecordCount осн. DataSet'а }
                           { Нужно для скорости переключения при возврате к осн. DataSet'У }
    FXLinkSources: TXLinkSources;
    FXInquiries: TXInquiries;
    FSelectedField: TField;
    FCurrentSource: TDataSource;
    FCurrentItem: TXLinkSourceItem;
    FDefSource: TDataSource;
    FLastControl: TWinControl;
    FReports: TXReports;
    FCurrentFilter: TEtvFilter;
    {FOldFilter: TEtvFilter;}
    FCurrentInquiryItem: TXInquiryItem;
{$IFDEF Report_Builder}
{    FPipeLinks: TXPipeLinks;}
{    procedure SetPipeLinks(Value: TXPipeLinks);
    function IsStorePipeLinks: Boolean;}
    function GetCurrentPrintType: TXPrintDevice;
{$ENDIF}
    function IsStoreData: Boolean;
    function IsStoreSources: Boolean;
    function IsStoreReports: Boolean;
    function IsStoreInquiries: Boolean;
    procedure SetXLinkSources(Value: TXLinkSources);
    procedure SetXInquiries(Value: TXInquiries);
    procedure SetReports(Value: TXReports);
    procedure SetCurrentSource(Value: TDataSource);
    procedure SetDefDBCaption(Value: Boolean);
    procedure SetDefRecCount(Value: Boolean);
    function GetPostChecked: Boolean;
    function GetCurrUserSource: TUserSource;
    function GetFilterItem(Index: Integer): TEtvFilter;
    function GetUserInquiry(Index: Integer; IsUser: Boolean): Integer;
    function GetUserReport(Index: Integer; IsUser: Boolean): Integer;
    procedure SetDefCurrentFilter(AFilter: TEtvFilter; ASource: TDataSource);
    procedure SetCurrentFilter(AFilter: TEtvFilter);
    procedure ChangeCurrentRecordCount(aDataSource: TDataSource);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDefaultClass: String; override;
    procedure CreateLink; override;
    procedure ReadState(Reader: TReader); override;
    procedure WriteState(Writer: TWriter); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure ActivateTools; override;
    procedure DeactivateTools; override;
    function CreateTools: TFormTools; override;
    function GetCurrentLink: TAggregateLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure ChangeCaption; override;
    procedure ChangeIndexCombo;
    procedure CheckActiveControl(Value: TDataSource);
    procedure ActivateForm; override;
    procedure DeactivateForm; override;
    procedure SubClick(Sender: TObject); override;
    procedure Execute; override;
    procedure ReturnExecute; override;
    procedure ReturnSubClose; override;
    procedure ActivateLinks(IsLoaded: Boolean); override;
    { Делает на форме и всех ее компонентах активным запрос, сформированный по SQLText }
    Function ActivateMainQuery(aQuery:TQuery; SQLText:string; ClearCurrentFilter:boolean):TDataSet;
    { Восстанавливает на форме основной DataSet }
    procedure DeactivateMainQuery(aDestroyDataSet, ReturnCurrentFilter:boolean);
    procedure GetToolStrings(ATag: Integer; AStrings: TStrings);override;
    function  FindDataItem(ASource: TDataSource): TXLinkSourceItem;
    procedure ReturnFormShow; override;
    procedure WriteUserData(AInquiries: TXInquiries; AReports: TXReports);
    procedure ReadUserData(AInquiries: TXInquiries; AReports: TXReports);
    procedure SetIFNOrder(AItem: TXInquiryItem);
    procedure SetIFNContext(AItem: TXInquiryItem);
    procedure SetInquiryCalcFields(aItem: TXInquiryItem; aCalcOption: TCalcLinkOption);
    procedure SetInquiryGroupByCalcFields(aItem: TXInquiryItem);
    procedure SetInquiryAggregate(aItem: TXInquiryItem; IsIndex: Boolean);
    procedure CancelInquiryAggregate(aItem: TAggregateLink);
    procedure CheckFilter;
    { При переключении фокуса с формы на форму или внутри формы с Grid'а или на Grid }
    { надо проконтролировать нажатие кнопки "Сумма" в зависимости от наличия итогов  }
    { в Grid'е (EtvGrid.Total)                                                       }
    procedure CheckTotal;
    procedure ActivateFilter;
    { Вызывает внутри себя ф-ию Filter.Show и возвращает рез-т ее работы }
    function SetSourceFilters(AItem: TXInquiryItem; aConditions: TListObj=nil):integer;
    Procedure PlayInquiry(aItem: TXInquiryItem; aConditions: TListObj=nil);
    procedure PlayReport(AItem: TXReportItem);
    procedure EditReport(AItem: TXReportItem);
    function  ppReadReport(AItem: TXReportItem): Boolean;
    function  GetCurrentInquiryCaption: String;
    { Наложен ли фильтр на текущий DataSet }
    function  IsCurrentSourceFiltered: boolean;
    { Выполнение запроса по команде с клавиатуры }
    procedure PlayQueryFromKey(Index:byte); override;
{$IFDEF Report_Builder}
    procedure UpdateXLinkItem(Index: Integer);
    procedure UpdateXLinkItems;
    property  CurrentPrintType: TXPrintDevice read GetCurrentPrintType;
{$ENDIF}

    property CurrentSource: TDataSource read FCurrentSource write SetCurrentSource;
    property CurrentItem: TXLinkSourceItem read FCurrentItem;
    property CurrentInquiryItem: TXInquiryItem read FCurrentInquiryItem write FCurrentInquiryItem;
    property PostChecked: Boolean read GetPostChecked;
    property SelectedField: TField read FSelectedField write FSelectedField;
    property Regime: TRegimeStyle read FRegime write FRegime default rmView;
    property CurrUserSource: TUserSource read GetCurrUserSource;
    property CurrentFilter: TEtvFilter read FCurrentFilter write SetCurrentFilter;
    // Нужен для определения FilterStream для запросов и основного Link'a
    property CurrentLink: TAggregateLink read GetCurrentLink;
    property CurrentRecordCount: LongInt read FCurrentRecordCount write FCurrentRecordCount;
  published
    property DefDBCaption: Boolean read FDefDBCaption write SetDefDBCaption default True;
    property DefRecCount: Boolean read FDefRecCount write SetDefRecCount default False;
    property DefSource: TDataSource read FDefSource write FDefSource;
    property Sources: TXLinkSources read FXLinkSources write SetXLinkSources stored IsStoreSources;
    property Inquiries: TXInquiries read FXInquiries write SetXInquiries stored IsStoreInquiries;
{$IFDEF Report_Builder}
{    property PipeLinks: TXPipeLinks read FPipeLinks write SetPipeLinks stored IsStorePipeLinks;}
{$ENDIF}
    property Reports: TXReports read FReports write SetReports stored IsStoreReports;
  end;
{ TDBFormControl }

{ TXSaveDBFormControl }
  TXSaveDBFormControl = class(TComponent)
  private
    FInquiries: TCollection;
    FReports: TCollection;
    procedure SetInquiries(Value: TCollection);
    procedure SetReports(AItems: TCollection);
    function IsStoreReports: Boolean;
    function IsStoreInquiries: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Inquiries: TCollection read FInquiries write SetInquiries stored IsStoreInquiries;
    property Reports: TCollection read FReports write SetReports stored IsStoreReports;
  end;
{ TXSaveDBFormControl }

  TXDatabase = class(TLnDataBase)
  private
    FLogSource: TDataSource;
    FLogField: String;
    FTools: TDBToolsControl;
    procedure SetTools(ATools: TDBToolsControl);
  protected
    function PDCreate(Const AUserName: String): TForm; override;
    procedure PDDestroy(AForm: TForm);override;
    procedure DoLoaded; override;
  published
    property Tools: TDBToolsControl read FTools write SetTools;
    property LogSource: TDataSource read FLogSource write FLogSource;
    property LogField: String read FLogField write FLogField;
  end;

Function GetLinkedDBFormControl(ASource: TDataSource): TDBFormControl;
Function GetActiveFormControl: TDBFormControl;

Implementation

Uses TypInfo, Windows, SysUtils, Messages, Dialogs, Buttons, XDBForms, ComCtrls,
     EtvBor, EtvDB, EtvPas, Misc, XMisc, XDBMisc, FSetInq, FSetReps, XApps, EtvLook, EtvGrid,
     EtvTable, {EtvForms,} BEForms, EtvDBFun, EtvTemp, EtvList, TlsForm, ExpExcel, EtvOther
{$IFDEF Report_Builder}
     , XTxtDev, ppComm
{$ENDIF}
     ;

ResourceString
{$IFDEF RussianLang }
  dsStateCaptions   =
    ''#13#10 +
    'Просмотр'#13#10 +
    'Изменение'#13#10 +
    'Вставка'#13#10 +
    'Поиск'#13#10 +
    'Расчеты'#13#10 +
    'Фильтр'#13#10;
{$ELSE}
  dsStateCaptions   =
    ''#13#10 +
    'Browse'#13#10 +
    'Edit'#13#10 +
    'Insert'#13#10 +
    'SetKey'#13#10 +
    'CalcFields'#13#10 +
    'Filter'#13#10;
{$ENDIF}

var XActiveDBFormList: TList;
    XNotifyEvent: TXNotifyEvent;
    OldDataSet: TDataSet; { Временный DataSet для "отлова" моментов перехода в }
                          { фильтрах с TTable на TQuery и обратно              }
                          { Удалить когда Игорь сделает проперть в EtvFilter   }
    aCurrentLink: TAggregateLink;

Function GetCurrentFormControl: TDBFormControl;
begin
  if Assigned(Screen) and (Screen.ActiveForm is TXDBForm) then
    Result:=TDBFormControl(TXDBForm(Screen.ActiveForm).FormControl)
  else Result:=nil;
end;

Function TDBFormControl.GetCurrentLink: TAggregateLink;
begin
  Result:=nil;
  if Assigned(FCurrentInquiryItem) then Result:=FCurrentInquiryItem
  else
    if Assigned(FCurrentSource) and Assigned(TLinkSource(FCurrentSource).DeclarLink) then
      Result:=TLinkSource(FCurrentSource).DeclarLink;
end;

Procedure SetLengthFieldsByData(aDataSet:TDBDataSet);
var lTableName,s:string;
    Q:TEtvQuery;
    Exist:boolean;
    list:tstrings;
    i,l:integer;
    lFunc: String;
begin
  lTableName:=ObjectStrProp(aDataSet,'TableName');
  Q:= Nil;
  List:= Nil;
  if lTableName<>'' then
  try
    Q:=TEtvQuery.Create(nil);
    Q.DatabaseName:=aDataSet.DatabaseName;
    Exist:=false;
    s:='';
    list:=TStringList.Create;
    for i:=0 to aDataSet.FieldCount-1 do
      if (aDataSet.fields[i].FieldKind=fkData) and
      (aDataSet.fields[i].Visible) and
      (not(aDataSet.fields[i] is TBlobField)) and
      (not(aDataSet.fields[i] is TDateField)) and
      (not(aDataSet.fields[i] is TEtvListField)) then begin
        Exist:=true;
        if s<>'' then s:=s+',';
        if aDataSet.fields[i] is TFloatField then lFunc:='LengthNum'
        else lFunc:='Length';
        s:=s+'max('+lFunc+'('+aDataSet.fields[i].FieldName+'))';
        List.Add(aDataSet.fields[i].FieldName);
      end;
    if Exist then begin
      Q.SQL.Add('select '+s+' from '+lTableName);
      if (ADataSet.Filter<>'') and (ADataSet.Filtered) then begin
        s:=ADataSet.Filter;
        while (pos('=NULL',s)>0) or (pos('= NULL',s)>0) do begin
          l:=pos('=NULL',s);
          if l<=0 then l:=pos('= NULL',s);
          s:=copy(s,1,l-1)+'is '+copy(s,l+1,length(s));
        end;
        while (pos('<>NULL',s)>0) or (pos('<> NULL',s)>0) do begin
          l:=pos('<>NULL',s);
          if l<=0 then l:=pos('<> NULL',s);
          s:=copy(s,1,l-1)+'is not '+copy(s,l+1,length(s));
        end;
        Q.SQL.Add('where '+s);
      end;
      try
        ADataSet.DisableControls;
        try
          Q.Open;
          if not (Q.BOF and Q.EOF) then
            for i:=0 to Q.FieldCount-1 do
              if (Q.Fields[i].value>0) and
              (Q.Fields[i].value<=255) then
                ADataSet.FieldByName(List[i]).DisplayWidth:=Q.Fields[i].value;
          Q.Close;
        except
          {EtvApp.ShowMessage(SSetLengthFieldsByDataError);}
          ShowMessage('Ошибка выполнения процедуры SetLengthFieldsByData'+#13+
                      'Позовите авторов задачи');
        end;
      finally
        ADataSet.EnableControls;
      end;
    end;
  finally
    List.Free;
    Q.Free;
  end;
end;

(*
Procedure SetLengthFieldsByDataNew(aDataSet:TDBDataSet);
const MaxEtvLook=50; { Мах EtvLookField на один DataSet }
var lTableName,s:string;
    Q:TEtvQuery;
    Exist:boolean;
    list:tstrings;
    i,l:integer;
    lFunc: String;
    lFieldName:String;
    lOriginFieldName:String;
    lJoinString: String;
    EtvLookInfo:array[1..MaxEtvLook,0..3] of string;
    EtvLookCount: byte; { всего луковых полей на датасет }
    EtvLookCurrent: byte;
    aField:TField;
    AliasNum:string[3];

Procedure InitEtvLookFieldInfo(aDataSet:TDBDataSet);
var i:integer;
    lOriginFieldName:String;
    Q:TQuery;
begin
  EtvLookCount:=0;
  Q:=TQuery.Create(nil);
  Q.DataBaseName:=aDataSet.DataBaseName;
  with aDataSet do
  try
    for i:=0 to FieldCount-1 do
      if (Fields[i].Visible) and (Fields[i] is TEtvLookField) and
      (Fields[i].FieldKind=fkLookup) and
      { Исключая составные поля }
      (Pos('+',Fields[i].LookUpKeyFields)=0) and (Pos('.',Fields[i].LookUpKeyFields)=0) then
      with TEtvLookField(Fields[i]) do begin
        Q.SQL.Clear;
        lOriginFieldName:=TLnQuery(LookUpDataSet).TableName+'.'+
          LookUpField[LookUpResultCount-1].FieldName;
        { Проверка на существование такого поля в БД }
{
        if AnsiUpperCase(lOriginFieldName)<>VarToStr(GetFromSQLText(aDataSet.DataBaseName,
          'select UCase(Creator+''.''+TName+''.''+CName) from STA.Columns where '+
          'Creator+''.''+TName+''.''+CName='''+lOriginFieldName+'''',true)) then Continue;
}
        Q.SQL.Add('select col_length('''+TLnQuery(LookUpDataSet).TableName+''','''+
                   LookUpField[LookUpResultCount-1].FieldName+''')');
        Q.Open;
        if Q.Fields[0].Value=null then Continue;
{
        if GetFromSQLText(aDataSet.DataBaseName,'select col_length('''+
           TLnQuery(LookUpDataSet).TableName+''','''+
           LookUpField[LookUpResultCount-1].FieldName+''')',true)=null then Continue;
}
        Inc(EtvLookCount);
        if EtvLookCount>MaxEtvLook then
          ShowMessage('Преполнение переменной MaxEtvLook. Сообщите программистам!');
        { Имя LookUp'ного DataSet'a }
        EtvLookInfo[EtvLookCount,0]:=TLnQuery(LookUpDataSet).TableName;
        { Имя LookUp'ного поля, DisplayWidth которого будем корректировать }
        EtvLookInfo[EtvLookCount,1]:=LookUpField[LookUpResultCount-1].FieldName;
        { Имя ключевого поля LookUp'ного DataSet'a (Код) }
        EtvLookInfo[EtvLookCount,2]:=LookUpKeyFields;
        { Имя ключевого поля Основного DataSet'a (Код) }
        EtvLookInfo[EtvLookCount,3]:=KeyFields;
      end;
  finally
    Q.Free;
  end;
end;

begin
  lTableName:=ObjectStrProp(aDataSet,'TableName');
  Q:=nil;
  List:=nil;
  if lTableName<>'' then
  try
    Q:=TEtvQuery.Create(nil);
    Q.DatabaseName:=aDataSet.DatabaseName;
    Exist:=false;
    s:='';
    list:=TStringList.Create;
    InitEtvLookFieldInfo(aDataSet);
    EtvLookCurrent:=0;
    lJoinString:='';
    for i:=0 to aDataSet.FieldCount-1 do with aDataSet.Fields[i] do
      if ((FieldKind=fkData) or (FieldKind=fkLookUp)) and
      (aDataSet.fields[i].Visible) and
      (not(aDataSet.fields[i] is TBlobField)) and
      (not(aDataSet.fields[i] is TDateField)) and
      (not(aDataSet.fields[i] is TEtvListField)) then begin
        Exist:=true;

        if aDataSet.fields[i] is TFloatField then lFunc:='LengthNum'
        else lFunc:='Length';
        if (FieldKind=fkLookUp) and (EtvLookCurrent<EtvLookCount) then begin
          if (EtvLookInfo[EtvLookCurrent+1,3]=KeyFields) then begin
            Inc(EtvLookCurrent);
            AliasNum:='a'+IntToStr(EtvLookCurrent);
            lFieldName:=AliasNum+'.'+EtvLookInfo[EtvLookCurrent,1];
            lJoinString:=lJoinString+' join '+EtvLookInfo[EtvLookCurrent,0]+' as '+
            AliasNum+' on '+
            lTableName+'.'+EtvLookInfo[EtvLookCurrent,3]+'*='+
            AliasNum+'.'+EtvLookInfo[EtvLookCurrent,2];
          end else Continue;
        end else lFieldName:=lTableName+'.'+FieldName;
        if s<>'' then s:=s+',';
        s:=s+'max('+lFunc+'('+lFieldName+'))';
        List.Add(FieldName);
      end;
    if Exist then begin
      Q.SQL.Add('select '+s+' from '+lTableName+lJoinString);
      if (ADataSet.Filter<>'') and (ADataSet.Filtered) then begin
        s:=ADataSet.Filter;
        { Разборки с синтаксисом NULL }
        while (pos('=NULL',s)>0) or (pos('= NULL',s)>0) do begin
          l:=pos('=NULL',s);
          if l<=0 then l:=pos('= NULL',s);
          s:=copy(s,1,l-1)+'is '+copy(s,l+1,length(s));
        end;
        while (pos('<>NULL',s)>0) or (pos('<> NULL',s)>0) do begin
          l:=pos('<>NULL',s);
          if l<=0 then l:=pos('<> NULL',s);
          s:=copy(s,1,l-1)+'is not '+copy(s,l+1,length(s));
        end;
        { Добавляем имя таблицы в исходный фильтр, чтобы не было конфликтов на сервере }
        for i:=0 to aDataSet.FieldCount-1 do with aDataSet.Fields[i] do begin
          l:=Pos('('+FieldName,s);
          if l>0 then
            s:=copy(s,1,l)+lTableName+'.'+copy(s,l+1,length(s))
        end;
        Q.SQL.Add('where '+s);
      end;
      { Изменяем DisplayWidth у TField'ов }
      try
        EtvLookCurrent:=0;
        ADataSet.DisableControls;
        try
          Q.Open;
          if not (Q.BOF and Q.EOF) then
            for i:=0 to Q.FieldCount-1 do
              if (Q.Fields[i].value>0) and
              (Q.Fields[i].value<=255) then begin
                aField:=ADataSet.FieldByName(List[i]);
                case aField.FieldKind of
                  fkData:
                    begin
                      aField.DisplayWidth:=Q.Fields[i].Value;
                      if (aField is TFloatField) and (TFloatField(aField).DisplayFormat<>'') then
                        aField.DisplayWidth:=aField.DisplayWidth+Q.Fields[i].Value div 3-1;
                    end;
                  fkLookUp:
                    begin
                      Inc(EtvLookCurrent);
                      aField.DisplayWidth:=LengthResultFields(aField)+
                      2*TEtvLookField(aField).LookUpResultCount-aField.LookUpDataSet.
                        FieldByName(EtvLookInfo[EtvLookCurrent,1]).DisplayWidth+Q.Fields[i].value;
                    end;
                end;
              end;
          Q.Close;
        except
          {EtvApp.ShowMessage(SSetLengthFieldsByDataError);}
          ShowMessage('Ошибка выполнения процедуры SetLengthFieldsByData'+#13+
                      'Позовите авторов задачи');
        end;
      finally
        ADataSet.EnableControls;
      end;
    end;
  finally
    List.free;
    Q.Free;
  end;
end;
*)

Function GetLinkedDBFormControl(ASource: TDataSource): TDBFormControl;
var i, j: Integer;
begin
  Result:=nil;
  for i:=0 to XActiveDBFormList.Count-1 do begin
    j:= TDBFormControl(XActiveDBFormList[i]).Sources.IndexOfLink(ASource);
    if j<>-1 then begin
      Result:= TDBFormControl(XActiveDBFormList[i]);
      Break;
    end;
  end;
end;

Function GetActiveFormControl: TDBFormControl;
begin
  if Screen.ActiveForm is TBEForm then
    Result:=TDBFormControl(TBEForm(Screen.ActiveForm).FormControl)
  else Result:=nil
end;

{ TXSourceDataLink }

Constructor TXSourceDataLink.Create(AXItem: TXLinkSourceItem);
begin
  Inherited Create;
  FXItem:= AXItem;
end;

Procedure TXSourceDataLink.StateChanged;
begin
  if Assigned(DataSet) then FXItem.StateChanged(DataSet.State)
    else FXItem.StateChanged(dsInactive);
end;

Procedure TXSourceDataLink.FormChanged;
{var aFC: TDBFormControl;
    aName: string;
    aSrcLinks: TSrcLinks;}
begin
  FXItem.DBControl.ChangeIndexCombo;
(*
  if Assigned(aFC) and (aFC.Form is TXDBForm) then with aFC do begin
    aSrcLinks:=TXDBForm(aFC.Form).XPageControl.Panel.IndexCombo.SrcLinks;
    if Assigned(aSrcLinks) then begin
      if Dataset is TLnTable then begin
        aName:=GetTableModelIFN(TLnTable(Dataset));
        aSrcLinks.CurrentIndex:=TIFNLink(aSrcLinks).IndexOfFields(aName);
      end;
      TXDBForm(aFC.Form).XPageControl.Panel.IndexCombo.ActiveChanged;
    end;
  end;
*)
end;

Procedure TXSourceDataLink.ActiveChanged;
begin
  StateChanged;
  FormChanged;
end;

{  Похоже, выполнялась лишняя работа}
(*
Procedure TXSourceDataLink.DataSetChanged;
begin
  FormChanged;
end;
*)

Procedure TXSourceDataLink.EditingChanged;
begin
  StateChanged;
end;

{ TXLinkSourceItem }

Constructor TXLinkSourceItem.Create(Collection: TCollection);
begin
  Inherited Create(Collection);
  FDataLink := TXSourceDataLink.Create(Self);
end;

Destructor TXLinkSourceItem.Destroy;
begin
  FDataLink.Free;
  Inherited;
end;

Function TXLinkSourceItem.GetSources: TXLinkSources;
begin
  Result:= TXLinkSources(Collection);
end;

Function TXLinkSourceItem.GetDBControl: TDBFormControl;
begin
  if Assigned(Collection) then Result:=TDBFormControl(Sources.GetOwner)
  else Result:=nil;
end;

Function FirstSourceFocused(AControl, XControl: TWinControl; ASource: TDataSource): Boolean;
var i: Integer;
begin
  Result:= False;
  i:=0;
  while (i<AControl.ControlCount){and(AControl.Controls[i]<>XControl)} do begin
    if (AControl.Controls[i] is TWinControl)and
    (TWinControl(AControl.Controls[i]).TabOrder<XControl.TabOrder) then begin
      XNotifyEvent.GoSpellChild(AControl.Controls[i], xeIsThisLink, ASource, opInsert);
      if XNotifyEvent.SpellEvent = xeNone then begin
        TWinControl(AControl.Controls[i]).SetFocus;
        Result:=True;
        Break;
      end;
    end;
    Inc(i);
  end;
end;

Function FirstSourceParentFocused(AControl, XControl: TWinControl; ASource: TDataSource): Boolean;
var BControl: TWInControl;
begin
  Result:= False;
  if AControl is TTabSheet then begin
    BControl:= AControl.Parent.Parent;
    if BControl is TTabSheet then
      Result:= FirstSourceParentFocused(BControl, AControl.Parent, ASource)
    else
      Result:= FirstSourceFocused(AControl, XControl, ASource);
  end;
  if (not Result) and (not(XControl is TPageControl)) then
    Result:= FirstSourceFocused(AControl, XControl.Parent, ASource);
end;

Procedure TXLinkSourceItem.StateChanged(AState: TDataSetState);
var AControl, AParent: TWinControl;
begin
  if Assigned(Collection) and Assigned(DBControl) then begin
    TXLinkSources(Collection).FControl.ChangeCaption;
    if (AState=dsInsert) and (Source is TLinkSource)and
    (dfFirstControl in TLinkSource(Source).Options) then
      with DBControl do
        if Assigned(Form)and Assigned(Form.ActiveControl) and
        Assigned(Form.ActiveControl.Parent) then begin
          AControl:=Form.ActiveControl;
          AParent:=AControl.Parent;
          FirstSourceParentFocused(AParent, AControl, Source);
        end;
  end;
end;

Procedure TXLinkSourceItem.AssignLinkItem(AItem: TXLinkSourceItem);
begin
  Source:= TXLinkSourceItem(AItem).Source;
end;

Procedure TXLinkSourceItem.Assign(Source: TPersistent);
begin
  if Source is TXLinkSourceItem then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      AssignLinkItem(TXLinkSourceItem(Source));
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else Inherited Assign(Source);
end;

Function TXLinkSourceItem.GetDisplayName: string;
begin
  Result := '';
  if Assigned(Source) then Result:= Source.Name;
  if Result = '' then Result := inherited GetDisplayName;
end;

Function  TXLinkSourceItem.GetSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

Procedure TXLinkSourceItem.SetSource(Value: TDataSource);
begin
  if FDataLink.DataSource<>Value then begin
    FDataLink.DataSource := Value;
    if Assigned(Value) and Assigned(TXLinkSources(Collection).FControl) then
      Value.FreeNotification(TXLinkSources(Collection).FControl);
  end;
end;

{ TXLinkSources }

Constructor TXLinkSources.Create(AControl: TDBFormControl);
begin
  Inherited Create(TXLinkSourceItem);
  FControl := AControl;
end;

Function TXLinkSources.Add: TXLinkSourceItem;
begin
  Result := TXLinkSourceItem(inherited Add);
end;

Function TXLinkSources.GetItem(Index: Integer): TXLinkSourceItem;
begin
  Result := TXLinkSourceItem(inherited GetItem(Index));
end;

Function TXLinkSources.GetOwner: TPersistent;
begin
  Result := FControl;
end;

Procedure TXLinkSources.SetItem(Index: Integer; Value: TXLinkSourceItem);
begin
  Inherited SetItem(Index, Value);
end;

Function TXLinkSources.IndexOfLink(ALink: TDataSource): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (Assigned(Items[i].Source))and(Items[i].Source=ALink) then begin
      Result:=i;
      Break;
    end;
end;

Function TXLinkSources.IndexOfLinkName(Const AName: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (Assigned(Items[i].Source)) and
    (AnsiCompareText(Items[i].Source.Name, AName)=0) then begin
      Result:=i;
      Break;
    end;
end;

Procedure TXLinkSources.Update(Item: TCollectionItem);
begin
  if Assigned(FControl) then
    if Assigned(Item)then FControl.UpdateXLinkItem(Item.Index)
    else FControl.UpdateXLinkItems;
end;

Procedure TXLinkSources.GetSrcStrings(AItems: TStrings);
var i: Integer;
begin
  for i:=0 to Count-1 do AItems.AddObject(Items[i].Source.Name, Items[i]);
end;

{ TXInquiryDataLink }

Constructor TXInquiryDataLink.Create(AXItem: TXInquiryItem);
begin
  Inherited Create;
  FXItem:= AXItem;
end;

Procedure TXInquiryDataLink.StateChanged;
begin
  if Assigned(DataSet) then FXItem.StateChanged(DataSet.State)
  else FXItem.StateChanged(dsInactive);
end;

Procedure TXInquiryDataLink.ActiveChanged;
begin
  StateChanged;
end;

(*
  Похоже, что выполнялась лишняя работа
Procedure TXInquiryDataLink.DataSetChanged;
begin
  StateChanged;
end;
*)

Procedure TXInquiryDataLink.EditingChanged;
begin
  StateChanged;
end;

{ TXInquiryItem }

Constructor TXInquiryItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataLink := TXInquiryDataLink.Create(Self);
  FFilterCheck:= False;
  FIndexCheck:= False;
  FGroupIndex:= 0;
end;

Destructor TXInquiryItem.Destroy;
begin
  FDataLink.Free;
  FPrintLink.Free;
  Inherited;
end;

Function TXInquiryItem.IsStoreUserName: Boolean;
var AControl: TDBFormControl;
begin
  AControl:= DBControl;
  Result:= Assigned(AControl) and AControl.IsStoreData;
end;

Function TXInquiryItem.GetSources: TXInquiries;
begin
  Result:= TXInquiries(Collection);
end;

Function TXInquiryItem.GetDBControl: TDBFormControl;
begin
  if Assigned(Collection) then Result:=TDBFormControl(Inquiries.GetOwner)
  else Result:=nil;
end;

Procedure TXInquiryItem.AssignLinkItem(AItem: TAggregateLink);
begin
  Inherited AssignLinkItem(AItem);
  Source:= TXInquiryItem(AItem).Source;
  Caption:= TXInquiryItem(AItem).Caption;
  UserName:= TXInquiryItem(AItem).UserName;
  FilterCheck:= TXInquiryItem(AItem).FilterCheck;
  ReportName:= TXInquiryItem(AItem).ReportName;
  PrintActive:= TXInquiryItem(AItem).PrintActive;
  if GetPrintActive then PrintLink.Assign(TXInquiryItem(AItem).PrintLink)
end;

Function TXInquiryItem.GetLinkTableName: String;
begin
  if Source is TLinkSource then Result:= TLinkSource(Source).TableName
  else Result:=Inherited GetLinkTableName;
end;

Function TXInquiryItem.GetLinkDataset: TDataset;
begin
  if Assigned(Source) then Result:= Source.Dataset
  else Result:=nil;
end;

Procedure TXInquiryItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then begin
    FCaption := Value;
{?    Changed(False);}
  end;
end;

Function TXInquiryItem.GetDisplayName: string;
begin
  Result := FCaption;
  if Result = '' then Result:=Inherited GetDisplayName;
end;

Procedure TXInquiryItem.StateChanged(AState: TDataSetState);
begin
  if Assigned(Collection) and Assigned(TXInquiries(Collection).FControl) then begin
    if (Source is TLinkSource) and TLinkSource(Source).RecCountChanged then begin
      TLinkSource(Source).RecCountChanged:= False;
      if dfSumCount in TLinkSource(Source).Options then
        TXInquiries(Collection).FControl.FormTools.ChangeHint(btSum, '')
      else TXInquiries(Collection).FControl.FormTools.ChangeHint(btSum, 'False');
      TXInquiries(Collection).FControl.ChangeCurrentRecordCount(Source);
      TXInquiries(Collection).FControl.ChangeCaption;
    end;
  end;
end;

Function TXInquiryItem.GetSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

Procedure TXInquiryItem.SetSource(Value: TDataSource);
begin
  if FDataLink.DataSource<>Value then begin
    FDataLink.DataSource := Value;
    Filters.Data.DataSource:= Value;
    if Assigned(Value) and Assigned(TXInquiries(Collection).FControl) then
      Value.FreeNotification(TXInquiries(Collection).FControl);
  end;
end;

Procedure TXInquiryItem.RemoveSource(Value: TDataSource);
begin
  if FDataLink.DataSource=Value then FDataLink.DataSource:=nil;
end;

Procedure TXInquiryItem.ChangeIFN;
var aSource: TDataSource;
begin
  aSource:= Source;
  if (aSource is TLinkSource)and(TLinkSource(aSource).IsDeclar) then
    TLinkSource(aSource).DeclarLink.ChangeLinkIFN(IFNItem.Fields);
end;

Procedure TXInquiryItem.ChangeLinkIFN(const aIFN: String);
var aLink: TLinkSetItem;
    i: Integer;
begin
  if DataSource is TLinkSource then begin
    i:= IFNLink.IndexOfFields(aIFN);
    if i<>-1 then IFNItem.Assign(IFNLink[i]);
    aLink:= TLinkSource(DataSource).DeclarLink;
    if Assigned(aLink) then aLink.ChangeLinkIFN(aIFN);
  end;
end;

Procedure TXInquiryItem.ChooseIFNOrder;
begin
  if ChooseOrderFields(Caption) then begin
    ChangeIFN;
    Calc.GroupByNames:='';
  end;
end;

Procedure TXInquiryItem.ChooseIFNContext;
begin
  if ChooseContextFields(Caption) then ChangeIFN;
end;

Function TXInquiryItem.ChooseCalcFields(aCalcOption: TCalcLinkOption): Boolean;
begin
  Result:= ChooseCalcLinkFields(aCalcOption, Caption, True);
end;

Function TXInquiryItem.ChooseGroupByCalcFields: Boolean;
begin
  Result:= ChooseGroupByCalcLinkFields(Caption);
end;

Function TXInquiryItem.GetCurrentFilterName: String;
begin
  if Filters.Data.FilterExist then
    Result:=TFilterItem(Filters.Data.Filters[Filters.Data.CurFilter]).Name
  else Result:='';
end;

Function TXInquiryItem.GetFilterIndex: Integer;
begin
  Result:= Filters.Data.CurFilter;
end;

Procedure TXInquiryItem.SetFilterIndex(Value: Integer);
begin
  if Filters.Data.CurFilter<>Value then Filters.Data.CurFilter:= Value;
end;

Procedure TXInquiryItem.GetFilterNames(AItems: TStrings);
var AFilt: TEtvFilter;
    i: Integer;
begin
  AFilt:= Filters.Data;
  if AFilt.FilterExist then begin
    for i:=0 to AFilt.Filters.Count-1 do
      AItems.AddObject(TFilterItem(AFilt.Filters[i]).Name, AFilt.Filters[i]);
  end;
end;

Procedure TXInquiryItem.GetIFNsNames(AItems: TStrings);
var i: Integer;
begin
  for i:=0 to IFNLink.Count-1 do
    AItems.AddObject(IFNLink[i].DisplayName, IFNLink[i]);
end;

Function TXInquiryItem.GetReportItemIndex: Integer;
begin
  if Assigned(DBControl) then
    Result:= DBControl.Reports.IndexOfCaption(Caption)
  else Result:= -1;
end;

Function TXInquiryItem.GetPrintActive: Boolean;
begin
  Result:= Assigned(FPrintLink);
end;

Procedure TXInquiryItem.SetPrintActive(Value: Boolean);
begin
  if Value<>GetPrintActive then
    if Value then FPrintLink:= TPrintLink.Create(pdText)
    else begin
      FPrintLink.Free;
      FPrintLink:=nil;
    end;
end;

{ TXInquiries }

Constructor TXInquiries.Create(AControl: TDBFormControl);
begin
  Inherited Create(TXInquiryItem);
  FControl := AControl;
end;

Function TXInquiries.Add: TXInquiryItem;
begin
  Result:=TXInquiryItem(Inherited Add);
end;

Function TXInquiries.GetItem(Index: Integer): TXInquiryItem;
begin
  Result:=TXInquiryItem(Inherited GetItem(Index));
end;

Function TXInquiries.GetOwner: TPersistent;
begin
  Result:=FControl;
end;

Procedure TXInquiries.SetItem(Index: Integer; Value: TXInquiryItem);
begin
  Inherited SetItem(Index, Value);
end;

Procedure TXInquiries.Update(Item: TCollectionItem);
begin
  if Assigned(FControl) then
    if Assigned(Item)then FControl.UpdateXLinkItem(Item.Index)
    else FControl.UpdateXLinkItems;
end;

Function TXInquiries.IndexOfLink(Const AName: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (Assigned(Items[i].Source)) and
    (AnsiCompareText(Items[i].Source.Name, AName)=0) then begin
      Result:=i;
      Break;
    end;
end;

Function TXInquiries.GetCopyLinks: TXInquiries;
var i: Integer;
begin
  Result:= TXInquiries.Create(FControl);
  i:=0;
  while i<Count do begin
    Result.Add.Assign(Items[i]);
    Inc(i);
  end;
end;

Function TXInquiries.GetUserLinks(Const AUserName: String; IsMove, IsExclude: Boolean): TXInquiries;
var i: Integer;
begin
  Result:= TXInquiries.Create(FControl);
  i:=0;
  while i<Count do begin
    if IsExclude then begin
      if CompareText(Items[i].UserName, AUserName) <> 0 then begin
        Result.Add.Assign(Items[i]);
        if IsMove then begin
          Items[i].Free;
          Continue;
        end;
      end;
    end else
      if CompareText(Items[i].UserName, AUserName) = 0 then begin
        Result.Add.Assign(Items[i]);
        if IsMove then begin
          Items[i].Free;
          Continue;
        end;
      end;
    Inc(i);
  end;
end;

Procedure TXInquiries.SetUserName(Const AUserName: String);
var i: Integer;
begin
  for i:=0 to Count-1 do Items[i].UserName:= AUserName;
end;

Procedure TXInquiries.GetSrcStrings(AItems: TStrings);
var i: Integer;
begin
  for i:=0 to Count-1 do AItems.AddObject(Items[i].Caption, Items[i]);
end;

{ TXReportItem }

Constructor TXReportItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  if Assigned(Collection) and Assigned(DBControl) then SetUniqueReportName;
  FReportType:= rtNone;
  FReport:=nil;
  FInMem:= False;
  FReadInMem:= False;
end;

Destructor TXReportItem.Destroy;
begin
  if Assigned(FReport) and (not (csDestroying in FReport.ComponentState)) then begin
    FReport.Free;
    FReport:=nil;
  end;
  FPrintLink.Free;
  Inherited;
end;

Procedure TXReportItem.SetUniqueReportName;
var
  i: Integer;
  Fmt, S: string;

begin
  Fmt:=DBControl.Name;
  Fmt:= Fmt+'Rep%d';
  for i := 1 to High(Integer) do begin
    S := Format(Fmt, [I]);
    if Reports.TryName(S) then begin
      FReportName:=S;
      Exit;
    end;
  end;
  raise Exception.CreateFmt('Cannot create unique report name for %s.', [DBControl.Name]);
end;

Function TXReportItem.IsStoreUserName: Boolean;
var AControl: TDBFormControl;
begin
  AControl:= DBControl;
  Result:= Assigned(AControl) and AControl.IsStoreData;
end;

Function TXReportItem.GetReports: TXReports;
begin
  Result:= TXReports(Collection);
end;

Function TXReportItem.GetDBControl: TDBFormControl;
begin
  if Assigned(Collection) then Result:=TDBFormControl(Reports.GetOwner)
  else Result:=nil;
end;

Procedure TXReportItem.AssignReportItem(AItem: TXReportItem);
begin
  FInMem:= AItem.InMem;
  Caption:= AItem.Caption;
  FReportType:= AItem.TypeReport;
  FReport:= AItem.Report;
  AItem.FReport:=Nil;
  ReportName:= AItem.ReportName;
  ReadInMem:= AItem.ReadInMem;
  UserName:= AItem.UserName;
{$IFDEF Report_Builder}
{  PipeLink:= AItem.PipeLink;}
  PrintLink.Assign(AItem.PrintLink);
{$ENDIF}
end;

Procedure TXReportItem.Assign(Source: TPersistent);
begin
  if Source is TXReportItem then begin
    if Assigned(Collection) then Collection.BeginUpdate;
    try
      AssignReportItem(TXReportItem(Source));
    finally
      if Assigned(Collection) then Collection.EndUpdate;
    end;
  end else Inherited Assign(Source);
end;

Procedure TXReportItem.SetReportName(const Value: string);
begin
  if FReportName <> Value then begin
    FReportName := Value;
    Changed(False);
  end;
end;

Procedure TXReportItem.SetCaption(const Value: string);
begin
  if FCaption <> Value then begin
    FCaption := Value;
    Changed(False);
  end;
end;

Function TXReportItem.GetDisplayName: string;
begin
  Result := FReportName;
  if Result = '' then Result:=Inherited GetDisplayName;
end;

Procedure TXReportItem.SetReportType(Value: TXReportType);
begin
  if FReportType<>Value then begin
    if FReportType<>rtNone then begin
      FReport.Free;
      FReport:=nil;
    end;
    FReportType:= Value;
    case FReportType of
      rtRBuilder:
        if Assigned(DBControl) and (not ((csReading in DBControl.ComponentState)
        or (csWriting in DBControl.ComponentState))) then begin
          DBControl.ppReadReport(Self);
        end;
    end;
  end;
end;

Function TXReportItem.GetPrintActive: Boolean;
begin
  Result:= Assigned(FPrintLink);
end;

Procedure TXReportItem.SetPrintActive(Value: Boolean);
begin
  if Value<>GetPrintActive then
    if Value then FPrintLink:=TPrintLink.Create(pdText)
    else begin
      FPrintLink.Free;
      FPrintLink:=nil;
    end;
end;

{ TXReports }

Constructor TXReports.Create(AControl: TDBFormControl);
begin
  Inherited Create(TXReportItem);
  FControl := AControl;
end;

Procedure TXReports.Assign(Source: TPersistent);
begin
  Inherited;
  if Source is TXReports then FControl:=TXReports(Source).FControl;
end;

Function TXReports.Add: TXReportItem;
begin
  Result:= TXReportItem(inherited Add);
end;

Function TXReports.SpecialAdd(aTypeReport: TXReportType; aTypePrint: TXPrintDevice): TXReportItem;
var aDataSet, bDataSet: TDataSet;
begin
  Result:= Add;
  Result.TypeReport:= aTypeReport;
{!  Result.TypePrint:= aTypePrint;}
  Result.Caption:= 'Отчет № '+IntToStr(Count-1);
  case aTypeReport of
    rtNone:;
    rtEtvShb: Result.Caption:= Result.Caption+' (шаблон)';
    rtRBuilder: Result.Caption:= Result.Caption+' (общий)';
    rtSimple:
      begin
        Result.Caption:= Result.Caption+' (простой)';
        if Assigned(FControl) and Assigned(FControl.CurrentSource) then begin
          aDataSet:= FControl.CurrentSource.DataSet;
          bDataSet:= Result.PrintLink.DataCalc.DataSet;
          Result.PrintLink.DataCalc.DataSet:= aDataSet;
          if bDataSet<>aDataSet then begin
            Result.PrintLink.DataCalc.Clear;
            if Assigned(aDataSet) then Result.PrintLink.SetVisibleFields;
          end;
        end else Result.PrintLink.DataCalc.DataSet:=nil;
      end;
  end;
end;

Function TXReports.GetItem(Index: Integer): TXReportItem;
begin
  Result:=TXReportItem(Inherited GetItem(Index));
end;

Function TXReports.GetOwner: TPersistent;
begin
  Result := FControl;
end;

Procedure TXReports.SetItem(Index: Integer; Value: TXReportItem);
begin
  Inherited SetItem(Index, Value);
end;

Function TXReports.IndexOfReport(Const AName: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (AnsiCompareText(Items[i].ReportName, AName)=0) then begin
      Result:=i;
      Break;
    end;
end;

Function TXReports.IndexOfCaption(Const ACaption: String): Integer;
var i: Integer;
begin
  Result:= -1;
  for i:=0 to Count-1 do
    if (AnsiCompareText(Items[i].Caption, ACaption)=0) then begin
      Result:= i;
      Break;
    end;
end;

Function TXReports.TryName(const Test: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count-1 do
    if CompareText(Items[I].ReportName, Test) = 0 then Exit;
  Result := True;
end;

Function TXReports.GetCopyReports: TXReports;
var i: Integer;
begin
  Result:= TXReports.Create(FControl);
  i:=0;
  while i<Count do begin
    Result.Add.Assign(Items[i]);
    Inc(i);
  end;
end;

Function TXReports.GetUserReports(Const AUserName: String; IsMove, IsExclude: Boolean): TXReports;
var i: Integer;
begin
  Result:= TXReports.Create(FControl);
  i:=0;
  while i<Count do begin
    if IsExclude then begin
      if CompareText(Items[i].UserName, AUserName) <> 0 then begin
        Result.Add.Assign(Items[i]);
        if IsMove then begin
          Items[i].Free;
          Continue;
        end;
      end;
    end else
      if CompareText(Items[i].UserName, AUserName) = 0 then begin
        Result.Add.Assign(Items[i]);
        if IsMove then begin
          Items[i].Free;
          Continue;
        end;
      end;
    Inc(i);
  end;
end;

Procedure TXReports.SetUserName(Const AUserName: String);
var i: Integer;
begin
  for i:=0 to Count-1 do Items[i].UserName:= AUserName;
end;

Procedure TXReports.GetSrcStrings(AItems: TStrings);
var i: Integer;
begin
  for i:=0 to Count-1 do AItems.AddObject(Items[i].Caption, Items[i]);
end;

{ TDBToolsControl }

var DataStateCaptions: TStringList;

Constructor TDBToolsControl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FUserSource:=nil;
end;

Destructor TDBToolsControl.Destroy;
begin
  Inherited Destroy;
end;

{ TDBFormTools }

Constructor TDBFormTools.Create(AControl: TFormControl);
begin
  Inherited Create(AControl);
  FUserSource:=nil;
  FUserType:= fcNone;
  FReportSource:=nil;
  FReportType:= fcNone;
{$IFDEF Report_Builder}
  FReporter:=nil;
{$ENDIF}
  FReporterType:= fcNone;
  DBActive:= True;
end;

Procedure TDBFormTools.SetDBActive(Value: Boolean);
begin
  if Value<>FDBActive then begin
    if Value then XActiveDBFormList.Add(Control)
    else XActiveDBFormList.Remove(Control);
    FDBActive:= Value;
  end;
end;

Procedure TDBFormTools.ToolsChanged;
begin
  if Assigned(Tools) then begin
    if FUserType=fcAutoNone then FUserType:= fcTools;
    if FReportType=fcAutoNone then FReportType:= fcTools;
    if FReporterType=fcAutoNone then FReporterType:= fcTools;
    if FTypeTools=fcAutoNone then FTypeTools:= fcTools;
  end;
end;

{ TDBFormControl }

Constructor TDBFormControl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FRegime:=rmView;
  FXLinkSources:=TXLinkSources.Create(Self);
  FXInquiries:=TXInquiries.Create(Self);
{$IFDEF Report_Builder}
{  FPipeLinks:= TXPipeLinks.Create(Self);}
{$ENDIF}
  FReports:=TXReports.Create(Self);
  FDefDBCaption:=True;
  FDefRecCount:=False;
  FCurrentSource:=nil;
  FDefSource:=nil;
  FLastControl:=nil;
end;

Destructor TDBFormControl.Destroy;
begin
{$IFDEF Report_Builder}
{  FPipeLinks.Free;}
{$ENDIF}
  FReports.Free;
  if Assigned(FXInquiries) then FXInquiries.Free;
  FXLinkSources.Free;
  Inherited Destroy;
end;

Procedure TDBFormControl.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
end;

Function TDBFormControl.IsStoreData: Boolean;
begin
  Result:=(TDBFormTools(FormTools).FUserType = fcNone) or (CurrUserSource=nil);
end;

{$IFDEF Report_Builder}
{
function TDBFormControl.IsStorePipeLinks: Boolean;
begin
  Result:= PipeLinks.Count>0;
end;

procedure TDBFormControl.SetPipeLinks(Value: TXPipeLinks);
begin
  FPipeLinks.Assign(Value);
end;
}

Function TDBFormControl.GetCurrentPrintType: TXPrintDevice;
begin
  with TDBFormTools(FormTools) do
  if FTypeTools = fcSelf then Result:= FTypePrint
  else
    if (FTypeTools = fcTools) and (FormTools.Tools is TDBToolsControl) then
      Result:= TDBToolsControl(FormTools.Tools).FTypePrint
    else Result:=pdNone;
end;

{$ENDIF}

Function TDBFormControl.IsStoreSources: Boolean;
begin
  Result:= Sources.Count>0;
end;

Function TDBFormControl.IsStoreReports: Boolean;
begin
  Result:= Reports.Count>0;
end;

Function TDBFormControl.IsStoreInquiries: Boolean;
begin
  Result:= Inquiries.Count>0;
end;

Function TDBFormControl.GetCurrUserSource: TUserSource;
begin
  with TDBFormTools(FormTools) do
  if FUserType = fcSelf then Result:= FUserSource
  else
    if (FUserType = fcTools) and (FormTools.Tools is TDBToolsControl) then
      Result:= TDBToolsControl(FormTools.Tools).FUserSource
    else Result:=nil;
end;

Procedure TDBFormControl.WriteUserData(AInquiries: TXInquiries; AReports: TXReports);
var CC: TXSaveDBFormControl;
    AUserSource: TUserSource;
    i: Integer;
    BInquiries: TXInquiries;
    BReports: TXReports;
begin
  if not IsStoreData then begin
    CC:=TXSaveDBFormControl.Create(Self);
    AUserSource:= CurrUserSource;
    try
      AUserSource.PatternName:= Name;
      for i:=0 to AUserSource.ChangeUserCount-1 do begin
        BInquiries:= AInquiries.GetUserLinks(AUserSource.ChangeUsers[i], False, False);
        BReports:=AReports.GetUserReports(AUserSource.ChangeUsers[i], False, False);
        CC.Inquiries.Assign(BInquiries);
        CC.Reports.Assign(BReports);
        BInquiries.Free;
        BReports.Free;
        AUserSource.CurrUser:= AUserSource.ChangeUsers[i];
        try
          AUserSource.SaveToSource(CC, Self);
        except
          ShowMessage('Error write to userSource');
          raise;
        end;
      end;
    finally
      CC.Free;
    end;
  end;
end;

Procedure TDBFormControl.ReadUserData(AInquiries: TXInquiries; AReports: TXReports);
var CC: TXSaveDBFormControl;
    AUserSource: TUserSource;
    i: Integer;
begin
  if not IsStoreData then begin
    CC:= TXSaveDBFormControl.Create(Self);
    AUserSource:= CurrUserSource;
    try
      AUserSource.PatternName:= Name;
      for i:=0 to AUserSource.ChangeUserCount-1 do begin
        AUserSource.CurrUser:= AUserSource.ChangeUsers[i];
        CC.Reports.Clear;
        CC.Inquiries.Clear;
        try
          AUserSource.LoadFromSource(CC, Self);
        except
          Showmessage('Error read from userSource');
          raise; {Continue;}
        end;
        if Assigned(AInquiries) then begin
          TXInquiries(CC.Inquiries).SetUserName(AUserSource.ChangeUsers[i]);
          AddCollection(AInquiries, CC.Inquiries);
        end;
        if Assigned(AReports) then begin
          TXReports(CC.Reports).SetUserName(AUserSource.ChangeUsers[i]);
          AddCollection(AReports, CC.Reports);
        end;
      end;
    finally
      CC.Free;
    end;
  end;
end;

Procedure TDBFormControl.WriteState(Writer: TWriter);
var AInquiries: TXInquiries;
    AReports: TXReports;
begin
  if not IsStoreData then begin
    AInquiries:= FXInquiries;
    AReports:= FReports;
    WriteUserData(FXInquiries, FReports);
    FXInquiries:=FXInquiries.GetUserLinks('', False, False);
    FReports:=FReports.GetUserReports('', False, False);
    Inherited WriteState(Writer);
    FXInquiries.Free;
    FReports.Free;
    FXInquiries:= AInquiries;
    FReports:=AReports;
  end else Inherited WriteState(Writer);
end;

Procedure TDBFormControl.GetChildren(Proc: TGetChildProc; Root: TComponent);
var i: Integer;
begin
  Inherited GetChildren(Proc, Root);
  for i:=0 to Reports.Count-1 do
    if Reports[i].TypeReport=rtRBuilder then Proc(Reports[i].FReport);
 {  if Inquiries.Count>0 then Proc(TComponent(Inquiries));}
end;

Procedure TDBFormControl.Loaded;
begin
  if Application.Terminated then Exit;
  Inherited Loaded;
  ReadUserData(Inquiries, Reports);
  ActivateLinks(True);
{  if Inquiries.Count>0 then
    WriteUserData(Inquiries, Reports);}
end;

Function TDBFormControl.CreateTools: TFormTools;
begin
  Result:= TDBFormTools.Create(Self);
end;

Procedure TDBFormControl.SetXLinkSources(Value: TXLinkSources);
begin
  FXLinkSources.Assign(Value);
end;

Procedure TDBFormControl.SetXInquiries(Value: TXInquiries);
begin
  FXInquiries.Assign(Value);
end;

Procedure TDBFormControl.SetReports(Value: TXReports);
begin
  FReports.Assign(Value);
end;

Function TDBFormControl.GetDefaultClass: String;
begin
  Result:= fcDBDefaultClass;
end;

Function TDBFormControl.FindDataItem(ASource: TDataSource): TXLinkSourceItem;
var i: Integer;
begin
  Result:=nil;
  for i:= 0 to FXLinkSources.Count-1 do
    if FXLinkSources[i].Source=ASource then begin
      Result:= FXLinkSources[i];
      Break;
    end;
end;

Procedure TDBFormControl.UpdateXLinkItem(Index: Integer);
begin
  with Inquiries[Index] do begin
  end;
end;

Procedure TDBFormControl.UpdateXLinkItems;
var
  I,ACount: Integer;
begin
  ACount := Inquiries.Count;
  for I:=0 to ACount-1 do UpdateXLinkItem(I);
end;

Procedure TDBFormControl.Notification(AComponent: TComponent; Operation: TOperation);
var i: Integer;
begin
  Inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent is TDataSource) then begin
    for i:=0 to FXInquiries.Count-1 do
      FXInquiries.Items[i].RemoveSource(TDataSource(AComponent));
    for i:=0 to Sources.Count-1 do{+?TLinkSubSource etc.}
      if Sources[i].Source=AComponent then begin
        Sources[i].Free;
        Break;
      end;
  end;
end;

Procedure TDBFormControl.Execute;
begin
  { Контроль на доступ юзера к форме }
  if GetFromSQLText(TLinkSource(DefSource).DataBaseName,'select STA.FCheckProtection('''+Self.Name+''','''+AppUserName+''')',false)=0 then begin
    ShowMessage('Уважаемый пользователь '+AppUserName+'!'+#13+'У вас нет доступа для работы с этой формой.');
    Abort;
  end;
  { Дальнейшие действия по открытию формы }
  Inherited;
end;

Procedure TDBFormControl.ReturnExecute;
var FormLinkSet, LnkSet: TLinkSource;
begin
  if Assigned(SelectedField) then
    if Assigned(SelectedField.LookupDataSet) then begin
      if SelectedField.LookupDataSet is TLinkQuery then LnkSet:=TLinkQuery(SelectedField.LookupDataSet).LinkSource;
      if SelectedField.LookupDataSet is TLinkTable then LnkSet:=TLinkTable(SelectedField.LookupDataSet).LinkSource;
      if SelectedField.DataSet is TLinkTable then
        FormLinkSet:=TLinkTable(SelectedField.DataSet).LinkSource
      else FormLinkSet:=nil;
      if Assigned(FormLinkSet) then begin
        FormLinkSet.PostChecked:=False;
      end;
      if Assigned(LnkSet) and Assigned(LnkSet.Declar) then with LnkSet do begin
        if (SelectedField.DataSet is TLinkTable) and (TLinkTable(SelectedField.DataSet).ReadOnly=false) then
          IsSetReturn:=True;
        Declar.Active:=True;
        try
          { Случай для дерева в форме "Накладные по материалам". Сначала позиционируемся по Дереву, т.к. оно Master, }
          { далее по общему алгоритму.                                                                               }
          if Assigned(TLnTable(Declar).MasterSource) and
            Assigned(TLnTable(Declar).MasterSource.DataSet.FieldByName('KodUp')) then
          with TLnTable(TLnTable(Declar).MasterSource.DataSet) do begin
            DisableControls;
            Active:=true;
            Locate('Kod',TEtvLookField(SelectedField).ValueByLookName('KodUp'),[]);
            EnableControls;
          end;
          Declar.Locate(SelectedField.LookupKeyFields,SelectedField.DataSet.
                            FindField(SelectedField.KeyFields).Value,[]);
          { ***************************************************************************************************** }
        except
        { Если в основном DataSet'е нет полей SelectedField.LookupKeyFields }
        { то встаем просто на первую запись                                 }
          Declar.First;
        end;
      end;
    end;
  Inherited;
  if Form is TXDBForm then with TXDBForm(Form) do
    if Assigned(XPageControl) and (FormRect.PageIndex>-1) and
    (XPageControl.PageCount>FormRect.PageIndex) then begin
      if XPageControl.CanChange then begin
        XPageControl.ActivePage:=XPageControl.Pages[FormRect.PageIndex];
        XPageControl.Change;
      end;
    end;
end;

Function TDBFormControl.GetFilterItem(Index: Integer): TEtvFilter;
var i, n: Integer;
    Filt: TEtvFilter;
begin
  Result:=nil; n:=-1;
  if Assigned(FCurrentSource) then begin
    Filt:=TLinkSource(FCurrentSource).LinkMaster.Filters.Data;
    if n+Filt.Filters.Count<Index then Inc(n, Filt.Filters.Count)
    else begin
      Filt.CurFilter:=Index-(n+1);
      Result:= Filt;
      Exit;
    end;
  end;
  for i:=0 to Inquiries.Count-1 do begin
    Filt:= Inquiries[i].Filters.Data;
    if n+Filt.Filters.Count<Index then Inc(n, Filt.Filters.Count)
    else begin
      Filt.CurFilter:=Index-(n+1);
      Result:= Filt;
      Exit;
    end;
  end;
end;

Procedure TDBFormControl.GetToolStrings(ATag: Integer; AStrings: TStrings);
var i, j: Integer;
    Filt: TEtvFilter;
begin
  case ATag of
    btDefInquiry:
      begin
        for i:=0 to Inquiries.Count-1 do
          if Inquiries[i].UserName='' then
            if Inquiries[i].Caption<>'' then AStrings.Add(Inquiries[i].Caption)
            else AStrings.Add('Запрос № '+IntToStr(i+1));
      end;
    btUserInquiry:
      begin
        for i:=0 to Inquiries.Count-1 do
          if Inquiries[i].UserName<>'' then
            if Inquiries[i].Caption<>'' then AStrings.Add(Inquiries[i].Caption)
            else AStrings.Add('Запрос № '+IntToStr(i));
      end;
    btDefReport:
      begin
        for i:=0 to Reports.Count-1 do
          if Reports[i].UserName='' then
            if Reports[i].Caption<>'' then AStrings.Add(Reports[i].Caption)
            else AStrings.Add('Отчет № '+IntToStr(i+1));
      end;
    btUserReport:
      begin
        for i:=0 to Reports.Count-1 do
          if Reports[i].UserName<>'' then
            if Reports[i].Caption<>'' then AStrings.Add(Reports[i].Caption)
            else AStrings.Add('Отчет № '+IntToStr(i));
      end;
    btFilter:
      begin
        if Assigned(FCurrentSource) then begin
          Filt:= TLinkSource(FCurrentSource).LinkMaster.Filters.Data;
          for j:=0 to Filt.Filters.Count-1 do
            if (Filt=CurrentFilter) and (Filt.CurFilter=j) then
              AStrings.AddObject(TFilterItem(Filt.Filters[j]).Name, Filt.Filters[j])
            else AStrings.Add(TFilterItem(Filt.Filters[j]).Name);
        end;
        for i:=0 to Inquiries.Count-1 do begin
          Filt:= Inquiries[i].Filters.Data;
          for j:=0 to Filt.Filters.Count-1 do
            if (Filt=CurrentFilter)and(Filt.CurFilter=j) then
              AStrings.AddObject(TFilterItem(Filt.Filters[j]).Name, Filt.Filters[j])
            else AStrings.Add(TFilterItem(Filt.Filters[j]).Name);
        end;
      end;
  end;
end;

Procedure TDBFormControl.SetIFNOrder(AItem: TXInquiryItem);
begin
  if Assigned(FCurrentSource) and Assigned(FCurrentSource.DataSet) then begin
    if not Assigned(AItem) then begin
      if Assigned(FCurrentInquiryItem) then FCurrentInquiryItem.ChooseIFNOrder
      else TLinkSource(FCurrentSource).ChooseIFNOrderDeclar;
    end else aItem.ChooseOrderFields(aItem.Caption);
  end;
end;

Procedure TDBFormControl.SetIFNContext(AItem: TXInquiryItem);
begin
  if Assigned(FCurrentSource) and Assigned(FCurrentSource.DataSet) then begin
    if not Assigned(AItem) then begin
      if Assigned(FCurrentInquiryItem) then FCurrentInquiryItem.ChooseIFNContext
      else TLinkSource(FCurrentSource).ChooseIFNContextDeclar;
    end else aItem.ChooseContextFields(aItem.Caption);
  end;
end;

Procedure TDBFormControl.SetInquiryCalcFields(AItem: TXInquiryItem; aCalcOption: TCalcLinkOption);
var aResult: Boolean;
    i: integer;
    aGrid: TEtvDBGrid;
begin
  if (FCurrentSource is TLinkSource) and Assigned(FCurrentSource.DataSet) then begin
    if not Assigned(AItem) then begin
      if Assigned(FCurrentInquiryItem) then
        aResult:= FCurrentInquiryItem.ChooseCalcFields(aCalcOption)
      else aResult:= TLinkSource(FCurrentSource).ChooseCalcFieldsDeclar(aCalcOption);
      if aResult then begin
        case aCalcOption of
          coResult: FormTools.ChangeHint(btSum, '');
          coVisible:;
          coAggregate:;
        end;
        { Перестраиваем форму для одной записи }
        Self.Form.Tag:=8;
        TBEForm(Self.Form).FormActivate(nil);
      end

    end else begin
      aResult:=aItem.ChooseCalcLinkFields(aCalcOption, aItem.Caption, False);
    end;
    { Перестраиваем столбцы }
    if Screen.ActiveControl is TEtvDBGrid then aGrid:=(Screen.ActiveControl as TEtvDBGrid)
    else aGrid:=TBEForm(Self.Form).Grid;
    if aResult then with aGrid do begin
      Columns.RebuildColumns;
      i:=Columns.Count-1;
      while i>=0 do begin
        if not Columns[i].Field.Visible then Columns[i].Destroy;
        Dec(i)
      end;
    end;
  end;
end;

Procedure TDBFormControl.SetInquiryGroupByCalcFields(AItem: TXInquiryItem);
{var aResult: Boolean;}
begin
  if (FCurrentSource is TLinkSource) and Assigned(FCurrentSource.DataSet) then begin
    if not Assigned(AItem) then begin
      if Assigned(FCurrentInquiryItem) then
        {aResult:= }FCurrentInquiryItem.ChooseGroupByCalcFields
      else {aResult:= }TLinkSource(FCurrentSource).ChooseGroupByFieldsDeclar;
    end else begin
      aItem.ChooseGroupByCalcLinkFields(aItem.Caption);
    end;
  end;
end;

{var OldEtvFilter:TLinkFilters;}

Procedure TDBFormControl.SetInquiryAggregate(aItem: TXInquiryItem; IsIndex: Boolean);
{var aDataSet:TDBDataSet;}
begin
  if (FCurrentSource is TLinkSource) and Assigned(FCurrentSource.DataSet) then begin
    { Если запрос с группировкой устанавливает пользователь самостоятельно }
    if not Assigned(AItem) then begin
      { Если уже наложен какой-либо запрос на основную таблицу }
      if Assigned(FCurrentInquiryItem) then begin
        FCurrentInquiryItem.DataSource:=FCurrentSource;
        FCurrentInquiryItem.Calc.Dataset:=FCurrentSource.Dataset;
        FCurrentInquiryItem.AggrWithIndex:=IsIndex;
        FCurrentInquiryItem.Aggregated:= True;
        if FCurrentInquiryItem.Aggregated then begin
          with TLinkSource(FCurrentSource).LinkSets.DeclarLink do begin
            DataSet:=TDBDataSet(FCurrentInquiryItem.AggrSource.DataSet);
            CheckedRestoreDataSet:=false; { Отключаем приставучий контроль Игоря Кравченко при событии DataLink.ActiveChange }
            FCurrentSource.DataSet:=DataSet;
            CheckedRestoreDataSet:=true;
            DataSet.FindField('NN').Visible:=false;
            {IFNItem.UpdateOrders(DataSet);}
          end;
          {SendChangeControlSource(Form, FCurrentSource, FCurrentInquiryItem.AggrSource);}
          FormTools.ChangeHint(btSetAggregate, '');
        end;
        { Запрос на основной таблице отсутствует }
      end else with TLinkSource(FCurrentSource) do begin
        if IsDeclar then begin
          LinkSets.DeclarLink.Calc.Dataset:=FCurrentSource.Dataset;
          (*
          LinkSets.DeclarLink.AggrWithIndex:=IsIndex;
          LinkSets.DeclarLink.Aggregated:=True;
          *)
          ActivateMainQuery(nil,DeclarLink.GetQueryTextOfGroupBy,true);
          FormTools.ChangeHint(btSetAggregate, '');
        end;
(*
        if LinkSets.DeclarLink.Aggregated then begin
          {
          SendChangeControlSource(Form, FCurrentSource,
            TLinkSource(FCurrentSource).LinkSets.DeclarLink.AggrSource);
           }
{
          FCurrentSource.DataSet:=
            TLinkSource(FCurrentSource).LinkSets.DeclarLink.AggrSource.DataSet;
}
          with LinkSets.DeclarLink do begin
            {OldEtvFilter:=CurrentFilter;
            CurrentFilter:=nil;}
            {aDataSet:=DataSet;
            aDataSet.Close;}
            DataSet:=TDBDataSet(AggrSource.DataSet);
            FCurrentSource.DataSet:=DataSet;
            {aDataSet.Open;}
            {IFNItem.UpdateOrders(DataSet);}
          end;
          FormTools.ChangeHint(btSetAggregate, '');
        end;
*)
      end;
      { Установка запроса с группировкой из настроенного запроса }
    end else begin
      aItem.DataSource:= FCurrentSource;
      aItem.Calc.Dataset:= FCurrentSource.Dataset;
{     aItem.AggrWithIndex:= IsIndex;
      aItem.Aggregated:= True;
}
      if aItem.Aggregated then begin
        SendChangeControlSource(Form, FCurrentSource, aItem.AggrSource);
        FormTools.ChangeHint(btSetAggregate, '');
      end;
    end;
  end;
end;

Procedure TDBFormControl.CancelInquiryAggregate(aItem: TAggregateLink);
begin
  if FCurrentSource is TLinkSource then with TLinkSource(FCurrentSource) do begin
    if not Assigned(AItem) then begin
      if Assigned(FCurrentInquiryItem) then begin
        FCurrentInquiryItem.Aggregated:= False;
        if not FCurrentInquiryItem.Aggregated then begin
          SendChangeControlSource(Form, FCurrentSource, nil);
          with LinkSets.DeclarLink do begin
            DataSet:=TDBDataSet(FCurrentInquiryItem.Calc.DataSet);
            FCurrentSource.DataSet:=DataSet;
            {IFNItem.UpdateOrders(DataSet);}
          end;
          FormTools.ChangeHint(btCancelAggregate, '');
        end;
      end else begin
(*
        if IsDeclar then
          TLinkSource(FCurrentSource).LinkSets.DeclarLink.Aggregated:= False;
*)
        if true {not TLinkSource(FCurrentSource).LinkSets.DeclarLink.Aggregated} then begin
            {SendChangeControlSource(Form, FCurrentSource, Nil);}
          DeactivateMainQuery(true,true);
(*
          with TLinkSource(FCurrentSource).LinkSets.DeclarLink do begin
            DataSet:=TDBDataSet(Calc.DataSet);
            {DataSet.Open;}
            FCurrentSource.DataSet:=DataSet;
            {IFNItem.UpdateOrders(DataSet);}
          end;
*)
          FormTools.ChangeHint(btCancelAggregate, '');
        end;
      end;
    end else begin
      aItem.Aggregated:= False;
      if not aItem.Aggregated then begin
        SendChangeControlSource(Form, FCurrentSource, nil);
        FormTools.ChangeHint(btCancelAggregate, '');
      end;
    end;
  end;
end;

Procedure TDBFormControl.SetDefCurrentFilter(AFilter: TEtvFilter; ASource: TDataSource);
begin
  if Assigned(AFilter) then FCurrentFilter:=AFilter
  else
    if FCurrentSource is TLinkSource then
      FCurrentFilter:=TLinkSource(ASource).LinkMaster.Filters.Data
    else FCurrentFilter:=nil;
end;

Procedure TDBFormControl.SetCurrentFilter(AFilter: TEtvFilter);
begin
  if Assigned(FCurrentFilter) and (AFilter<>FCurrentFilter) and
  FCurrentFilter.FilterExist then begin
    {FCurrentSource.DataSet.Close;}
    {FCurrentFilter.Used:=fuNone;}
    FormTools.ChangeHint(btCancelFilter, '');
    FormTools.ChangeHint(btCurrentFilter, 'Выбор фильтра');
  end;
  SetDefCurrentFilter(AFilter, FCurrentSource);
end;

Procedure TDBFormControl.CheckFilter;
begin
  if Assigned(FCurrentFilter) then
    case FCurrentFilter.Used of
      fuSet:
        begin
          FormTools.ChangeHint(btFilter, '');
          FormTools.ChangeHint(btCurrentFilter, TFilterItem(FCurrentFilter.
                               Filters[FCurrentFilter.CurFilter]).Name);
        end;
      fuNone{, fuUnlimitedSet}:
        begin
          FormTools.ChangeHint(btCancelFilter, '');
          FormTools.ChangeHint(btCurrentFilter, 'Выбор фильтра');
        end;
    end
  else begin
    FormTools.ChangeHint(btCancelFilter, '');
    FormTools.ChangeHint(btCurrentFilter, 'Выбор фильтра');
  end;
end;

Procedure TDBFormControl.CheckTotal;
var i:integer;
    kkk: integer;
    Flag:boolean;
begin
  Flag:=false;
  if (Form is TBEForm) then with TBEForm(Form) do
    for i:=0 to ComponentCount-1 do
      if (Components[i] is TEtvDBGrid) then begin
        { а) Фокус установлен на Gride - разбираемся с кнопкой на панели инструментов }
        if (TEtvDBGrid(Components[i]).DataSource=FCurrentSource) then begin
          Flag:=true; { Grid нашелся  }
          if TEtvDBGrid(Components[i]).Total then
            FormTools.ChangeHint(btSumDown, '') { кнопку нажимаем}
          else FormTools.ChangeHint(btSumUp, ''); { кнопку отжимаем}
        end
        { б) Есть Gride отдельно стоящий, надобы проверить, м.б. по нему посчитать итоги }
        { Если в LinkSetItem'е выставлены исходные параметры для расчета итогов, но итоги не посчитаны, то - считаем }
        else with TEtvDBGrid(Components[i]) do begin
          if kkk=0 then kkk:=1;
        end;
      end;
  { Grid с фокусом не нашелся }
  if not Flag then FormTools.ChangeHint(btSumUp, '');{ кнопку отжимаем}
end;

Procedure TDBFormControl.ChangeCurrentRecordCount(aDataSource: TDataSource);
var S: String;
    ClientFilter:String;
    SQLFilter:string;
begin
  if (aDataSource is TLinkSource) and Assigned(aDataSource.Dataset) and
  (dfRecCount in TLinkSource(aDataSource).Options) and FDefRecCount then begin
    with aDataSource.DataSet do
      if (Filter<>'') and Filtered then
        if Assigned(FCurrentFilter) then
          ClientFilter:=FCurrentFilter.ConstructFilter(aDataSource.DataSet,true,fuSet)
        else ClientFilter:=Filter { Но в этом случае потенциальные проблемы с null'ами }
      else ClientFilter:='';
    { Общий кусочек для TTable и TQuery }
    S:='Select Count(*) from '+TLinkSource(aDataSource).TableName;
    if aDataSource.DataSet is TQuery then with TQuery(aDataSource.DataSet) do begin
      { Обработка для Query }
      SQLFilter:=WhereFromSQL(SQL.Text, True);
      { Есть ли Псевдоним для DataSet'а в случае сложного запроса }
      if Pos('efilter',AnsiLowerCase(SQLFilter))>0 then
        S:=S+' EFilter ';
    end else SQLFilter:='';
    if ClientFilter<>'' then S:=S+' where '+ClientFilter;
    if SQLFilter<>'' then
      if ClientFilter<>'' then S:=S+' and ('+SQLFilter+')'
      else S:=S+' where '+SQLFilter;
    if ((aDataSource.DataSet is TTable) and (ClientFilter='')) or
    ((aDataSource.DataSet is TQuery) and
    (Pos('group by',AnsiLowerCase(TQuery(aDataSource.DataSet).SQL.Text))>0)) then
      FCurrentRecordCount:=aDataSource.Dataset.RecordCount
    else FCurrentRecordCount:=
      GetFromSQLText(TDBDataSet(aDataSource.DataSet).DataBaseName,S,false);
  end;
  {FCurrentRecordCount:=aDataSource.Dataset.RecordCount;}
end;

Procedure TDBFormControl.ActivateFilter;
begin
  if Assigned(FCurrentFilter) then with FCurrentFilter do begin
    if FCurrentFilter.FilterExist then begin
      OldDataSet:=DataSet;
      {DataSet.Filter:='';}
      Used:=fuSet;
      if FilterProceed<>fpNone then begin
        case FilterProceed of
          fpToExtracts: ActivateMainQuery(TQuery(DataSet),'',False);
          fpToOrig:     DeactivateMainQuery(false,false);
        end;
        OldDataSet.Open;
      end;
      { Анализ ситуации перехода на TQuery и обратно в запросах }
      if not Assigned(Self.DefSource) then
        ShowMessage('Необходимо задать параметр DefSource у компонента '+Self.Name)
      else
        if (DataSet is TLinkTable) and (TLinkSource(Self.DefSource).LinkSets.DeclarIndex=1) then
          TLinkSource(Self.DefSource).LinkSets.SetDeclarIndex(0);

(*
      { Анализ ситуации перехода на TQuery и обратно }
      if (OldDataSet<>DataSet) then begin
        { Был TTable - стал TQuery }
        if DataSet is TQuery then ActivateMainQuery(TQuery(DataSet),'',False);
        { Был TQuery - стал TTable }
        if DataSet is TTable then DeactivateMainQuery(false,false);
        OldDataSet.Open;
      end;
*)
      FormTools.ChangeHint(btFilter, '');
      FormTools.ChangeHint(btCurrentFilter, TFilterItem(FCurrentFilter.
                           Filters[FCurrentFilter.CurFilter]).Name);
    end else begin
      OldDataSet:=DataSet;
      FCurrentFilter.Used:=fuNone;
      if FilterProceed<>fpNone then begin
        case FilterProceed of
          fpToExtracts: ActivateMainQuery(TQuery(DataSet),'',False);
          fpToOrig:     DeactivateMainQuery(false,false);
        end;
        OldDataSet.Open;
      end;
(*
      { Анализ ситуации перехода на TQuery и обратно }
      if (OldDataSet<>DataSet) then begin
        { Был TTable - стал TQuery }
        if DataSet is TQuery then ActivateMainQuery(TQuery(DataSet),'',False);
        { Был TQuery - стал TTable }
        if DataSet is TTable then DeactivateMainQuery(false,false);
        OldDataSet.Open;
      end;
*)
      FormTools.ChangeHint(btCancelFilter, '');
      FormTools.ChangeHint(btCurrentFilter, 'Выбор фильтра');
    end;
    {FCurrentSource.DataSet.Open;}
    if FCurrentSource.DataSet.Active and (OldDataSet=DataSet) then begin
      ChangeCurrentRecordCount(FCurrentSource{FCurrentFilter.DataSource});
      ChangeCaption;
    end;
  end;
end;

Function TDBFormControl.SetSourceFilters(AItem: TXInquiryItem; AConditions: TListObj=nil):Integer;
var i:integer;
    OldFilter: TEtvFilter;
begin
  Result:=idCancel;
  if Form is TXDBForm then with TXDBForm(Form) do
    if Assigned(XPageControl) then begin
      OldFilter:=CurrentFilter;
      if not Assigned(AItem) then begin
        aCurrentLink:=TLinkSource(FCurrentSource).DeclarLink;
        CurrentFilter:=nil;
      end else begin
        aCurrentLink:=aItem;
        CurrentFilter:=AItem.Filters.Data;
        if AConditions<>nil then
          TFilterItem(CurrentFilter.Filters[0]).ChangeConditions(AConditions)
      end;
      { Добавляем SubDataSet'ы }
      for i:=0 to Sources.Count-1 do
        if Sources[i].Source.DataSet is TTable then
          with TTable(Sources[i].Source.DataSet) do
            if Assigned(MasterSource) and (MasterSource.Name=CurrentSource.Name)
            and (CurrentFilter.CheckSubDataSet(Sources[i].Source.DataSet)) then
              CurrentFilter.AddSubDataSet(Sources[i].Source.DataSet,'');
      Result:=CurrentFilter.Show;
      // Возврат старого фильтра в случае "Отмены"
      if (Result=idCancel) and Assigned(OldFilter) then
        CurrentFilter:=OldFilter;
      {ChangeCurrentRecordCount(FCurrentFilter.DataSource);}
    end;
  {CheckFilter;}
  {ChangeCaption;}
end;

Function TDBFormControl.GetUserInquiry(Index: Integer; IsUser: Boolean): Integer;
var i: Integer;
begin
  Result:= -1;
  if Inquiries.Count>0 then
    for i:=0 to Inquiries.Count-1 do begin
      if Inquiries[i].UserName='' then begin
        if not IsUser then begin
          if Index=0 then begin
            Result:=i;
            Break;
          end;
          Dec(Index);
        end;
      end else
        if IsUser then begin
          if Index=0 then begin
            Result:=i;
            Break;
          end;
          Dec(Index);
        end;
    end;
end;

Function TDBFormControl.GetUserReport(Index: Integer; IsUser: Boolean): Integer;
var i: Integer;
begin
  Result:= -1;
  if Reports.Count>0 then
    for i:=0 to Reports.Count-1 do begin
      if Reports[i].UserName='' then begin
        if not IsUser then begin
          if Index=0 then begin
            Result:=i;
            Break;
          end;
          Dec(Index);
        end;
      end else begin
        if IsUser then begin
          if Index=0 then begin
            Result:=i;
            Break;
          end;
          Dec(Index);
        end;
      end;
    end;
end;

{var OldIFNItem:TIFNItem;}
    {OldLink: TAggregateLink;}
Procedure TDBFormControl.PlayInquiry(aItem: TXInquiryItem; aConditions: TListObj=nil);
var aLink: TAggregateLink;
    FilterEnabled: integer;
begin
  if (Assigned(aItem) and (aItem.Source<>FCurrentSource)) or
  (not Assigned(aItem) and Assigned(FCurrentInquiryItem) and
  (FCurrentInquiryItem.Source<>FCurrentSource)) then begin
    ShowMessage('Перейдите на таблицу: '+Caption);
    Exit;
  end;
  if (FCurrentSource is TLinkSource) and Assigned(FCurrentSource.DataSet) then begin
    if Assigned(aItem) then
      { Проверка на установку того же самого запроса }
      if Assigned(FCurrentInquiryItem) and (FCurrentInquiryItem=aItem)
      { Позволяем устанавливать тот же самый запрос если есть предустановка фильтров }
      and not aItem.FilterCheck then Exit else
         { Чтоб второй раз не отменять запрос }
    else if not Assigned(FCurrentInquiryItem) then Exit;

    FCurrentSource.DataSet.DisableControls;
    if Assigned(FCurrentInquiryItem) then aLink:=FCurrentInquiryItem
    else aLink:=TLinkSource(FCurrentSource).DeclarLink;

    if Assigned(aItem) then begin
      {PlayInquiry(nil);}
      // Если в прошлом запросе у Filter'а DataSet is TQuery, то фильтр снимаем, иначе
      // потеряем оригинальный датасет (TTable)
      if Assigned(OldDataSet) and Assigned(FCurrentFilter) and (OldDataSet<>FCurrentFilter.DataSet) then
        FCurrentFilter.Used:=fuNone;

      { Установка видимых-невидимых полей }
      if not Assigned(FCurrentInquiryItem) then
        TLinkSource(FCurrentSource).StoreVisibleDeclar
      else FCurrentInquiryItem.StoreVisible;
      aItem.ChangeVisible;

      { Закрываем DataSet для скорости }
      FCurrentSource.DataSet.Close;
      { Смена фильтра }

      { Сохранили старое значение }
      if not Assigned(FCurrentInquiryItem) then
        {TLinkSource(FCurrentSource).LinkMaster.IFNItem.AssignIFNItem(aLink.IFNItem);}
        TLinkSource(FCurrentSource).LinkMaster.CurrentIFNLink.Assign(aLink.CurrentIFNLink);
      {OldIFNItem:=aLink.IFNItem;}

      { Переключение IndexCombo на текущий IfnItem }
      with TXDBForm(Form).XPageControl.Panel.IndexCombo do begin
        SrcLinks:=aItem.CurrentIFNLink;
        SrcLinkItem:=aItem.IFNItem;
      end;
      {TLinkSource(Self.FCurrentSource).DeclarLink.IFNLink:=aItem.IFNLink;}
      TLinkSource(FCurrentSource).DeclarLink.IFNItem.AssignIFNItem(aItem.IFNItem);

      { Установка сортировки. Т.к. DataSet закрыт, то индекс поменять очень быстро }
      if aItem.IndexCheck then SetIFNOrder(aItem);
      aItem.ChangeIFN;

      { Наложение фильтра }
      (* aCurrentLink:=aItem; // Для корректной работы с Aggregate.FilterStream *)
      FilterEnabled:=idOk;
      if aItem.FilterCheck then FilterEnabled:=SetSourceFilters(AItem,AConditions)
      else CurrentFilter:=AItem.Filters.Data;
      if FilterEnabled<>idCancel then ActivateFilter
      else CheckFilter;

      if aItem.Aggregated then begin
        aItem.AggrTemp:= False;
        SetInquiryAggregate(aItem, aItem.AggrWithIndex);
      end;

{     btSetAggrWithIndex: SetInquiryAggregate(Nil, True);}

{        if aItem.Aggregated then begin
           aItem.AggrTemp:= False;
           aItem.Aggregated:= True;
           end;}
    end else begin
      {TLinkSource(Self.FCurrentSource).DeclarLink.IFNLink:=aItem.IFNLink;}
      { Для скорости! }
      FCurrentSource.DataSet.Close;
      {CurrentFilter.Used:=fuNone;}
      with FCurrentFilter do begin
        {OldDataSet:=DataSet;}
        CurrentFilter.Used:=fuNone;
        if FilterProceed<>fpNone then begin
          case FilterProceed of
            fpToExtracts: ActivateMainQuery(TQuery(DataSet),'',False);
            fpToOrig:     DeactivateMainQuery(false,false);
          end;
        end;
(*
        { Анализ ситуации перехода на TQuery и обратно }
        if (OldDataSet<>DataSet) then begin
          { Был TTable - стал TQuery }
          if DataSet is TQuery then ActivateMainQuery(TQuery(DataSet),'',False);
          { Был TQuery - стал TTable }
          if DataSet is TTable then DeactivateMainQuery(false,false);
        end;
*)
      end;

      {TLinkSource(Self.FCurrentSource).DeclarLink.IFNItem.AssignIFNItem(OldIFNItem);}
      with TLinkSource(FCurrentSource) do begin
        {DeclarLink.IFNItem.AssignIFNItem(LinkMaster.IFNItem);}
        DeclarLink.CurrentIFNLink.Assign(LinkMaster.CurrentIFNLink);
        with TXDBForm(Form).XPageControl.Panel.IndexCombo do begin
          {SrcLinkItem:=nil;}
          SrcLinks:=DeclarLink.CurrentIFNLink;
          SrcLinkItem:=DeclarLink.IFNItem;
        end;
      end;

      TLinkSource(FCurrentSource).ChangeVisibleDeclar;
      TLinkSource(FCurrentSource).ChangeIFNDeclar;

(*
      // Дальнейшая инициализация aCurrentLink
      aCurrentLink:=TLinkSource(FCurrentSource).DeclarLink;
*)
      CurrentFilter:={Nil}TLinkSource(FCurrentSource).GetFilterDeclar;
      ActivateFilter;
      if aLink.Aggregated then begin
        CancelInquiryAggregate(aLink);
        aLink.AggrTemp:= True;
      end;
  {   if bItem.Aggregated then begin
        bItem.Aggregated:= False;
        bItem.AggrTemp:= True;
      end;}
    end;
                                               { тот же самый запрос повторили, но поменяли условие }
    if Assigned(aItem) and ((aItem.Calc.SumCalcAuto) or ((FCurrentInquiryItem=aItem) and TToolsForm(FormTools.Tools.ToolsForm).SumBtn.Down)) then begin { АвтоСуммирование столбцов }
      FCurrentInquiryItem:=aItem; {*** Пришлось тут повторяться по поводу этого присвоения из-за запуска механизма автосуммирования ***}
      FormTools.ChangeHint(btSum,'True')
    end else begin
      FCurrentInquiryItem:=aItem; {***}
      FormTools.ChangeHint(btSum,'False');
      {TBEForm(Self.Form).Grid.Total:=false;}
    end;

    {OldLink:=aCurrentLink;}
    with FCurrentSource.DataSet do begin
      if not Active then begin
        Open;
        { Не было перехода с TTable на TQuery или наоборот в EtvFiltr'е }
        { Т.к. если было, то эти процедуры уже отработали }
        ChangeCurrentRecordCount(FCurrentSource);
      end;
      { Форматирование выполняем если RecordCount<1000 и если наложен фильтр }
      if (RecordCount<10000) or ((Filtered) and (Filter<>'')) then
        TBEForm(TDBFormControl(Self).Form).Grid.FormatColumns(true);
      { Перестраиваем форму для одной записи, иначе - глюки }
      if (Form is TBEForm) and Assigned(TBEForm(Form).Scroll) then begin
        Form.Tag:=8;
        TBEForm(Self.Form).FormActivate(nil);
      end;
      EnableControls;
      CheckActiveControl(FCurrentSource);
    end;
    ChangeCaption;
  end;
  {aCurrentLink:=CurrentLink; // Дальнейшая инициализация aCurrentLink}
end;

Procedure TDBFormControl.PlayReport(AItem: TXReportItem);
begin
  with AItem do
    case TypeReport of
      rtRBuilder:
        begin
          if not Assigned(Report) and
          (TDBFormTools(FormTools).ReporterType in [fcSelf, fcTools]) then begin
            ppReadReport(AItem);
          end;
          if Assigned(Report) then begin
{$IFDEF Report_Builder}
            TXLinkReport(Report).SaveAsTemplate:=True;
            TXLinkReport(Report).ReportItem:= AItem;
            if Assigned(aItem.PrintLink) then
              {TXDBReport(Report).Device:= AItem.PrintLink.TypeDevice;}
              TXDBReport(Report).DeviceType:= AItem.PrintLink.DeviceType;
            TXDBReport(Report).Print;
            TXLinkReport(Report).SaveAsTemplate:=False;
{$ENDIF}
           end;
        end;
      rtSimple: PrintLink.GetFieldsXReport(Self, True);
    end;
end;

Procedure TDBFormControl.EditReport(AItem: TXReportItem);
{$IFDEF Report_Builder}
var Des: TppDesigner;
{$ENDIF}
begin
  with AItem do
    if (TypeReport=rtRBuilder) then begin
      if not Assigned(Report) and
      (TDBFormTools(FormTools).ReporterType in [fcSelf, fcTools]) then begin
        ppReadReport(AItem);
      end;
      if Assigned(Report) then begin
{$IFDEF Report_Builder}
        TXLinkReport(Report).SaveAsTemplate:=True;
        TXLinkReport(Report).ReportItem:= AItem;
        case TDBFormTools(FormTools).ReporterType of
          fcSelf:
            begin
              Des:= TDBFormTools(FormTools).Reporter;
              if Assigned(Des) then begin
                Des.Report:= TXDBReport(Report);
                Des.ShowModal;
              end;
            end;
          fcTools:
            if Assigned(FormTools.Tools) then begin
              Des:= TDBToolsControl(FormTools.Tools).Reporter;
              if Assigned(Des) then begin
                Des.Report:= TXDBReport(Report);
{*!!!            if Assigned(PipeLink) then begin
                TXDBReport(Report).DataPipeLine:= PipeLink.RootPipeLine;
                Des.FieldAliases        := PipeLink.GetFieldAliases;
                Des.OnGetAliasForField  := PipeLink.GetAliasForField;
                Des.OnGetDisplayFormats := PipeLink.GetDisplayFormats;
                Des.OnGetFieldForAlias  := PipeLink.GetFieldForAlias;
                end;}
                Des.ShowModal;
              end;
            end;
          else begin
            Des:= TppXDesigner.Create(Nil);
            Des.Report:= TXDBReport(Report);
            Des.ShowModal;
            Des.Free;
          end;
      end;
      TXLinkReport(Report).SaveAsTemplate:=False;
{$ENDIF}
    end;
  end;
end;

Function TDBFormControl.ppReadReport(AItem: TXReportItem): Boolean;
var ASource: TUserSource;
begin
{$IFDEF Report_Builder}
  Result:= False;
  try
    case TDBFormTools(FormTools).ReportType of
      fcSelf:
        begin
          ASource:= TDBFormTools(FormTools).ReportSource;
          if Assigned(ASource) then begin
            try
              ASource.PatternName:= AItem.ReportName;
              AItem.FReport:= TXLinkReport.Create(Owner);
              Result:= ASource.LoadFromSource(AItem.FReport, {Self}Owner);
              if Result then Exit;
            except
              ShowMessage('Ошибка чтения '+AItem.ReportName);
  {           raise;}
            end;
          end;
        end;
      fcTools:
        if Assigned(FormTools.Tools) then begin
          ASource:= TDBToolsControl(FormTools.Tools).ReportSource;
          if Assigned(ASource) then begin
            try
              ASource.PatternName:= AItem.ReportName;
              AItem.FReport:= TXLinkReport.Create(Owner);
              Result:= ASource.LoadFromSource(AItem.FReport, {Self}Owner);
              if Result then Exit;
            except
              ShowMessage('Ошибка чтения '+AItem.ReportName);
  {           raise;}
            end;
          end;
        end;
    end;
  {!!!}
    if not Assigned(AItem.FReport) then begin
      AItem.FReport:= TXLinkReport.Create(Owner);
      TXLinkReport(AItem.FReport).Name:= AItem.ReportName;
      TXLinkReport(AItem.FReport).Template.Description:= AItem.Caption;
      Result:= True;
    end else
      if not Result then begin
        TXLinkReport(AItem.FReport).Name:= AItem.ReportName;
        TXLinkReport(AItem.FReport).Template.Description:= AItem.Caption;
        Result:= True;
      end;
  finally
    TXLinkReport(AItem.FReport).Control:= Self;
  end;
{$ENDIF}
end;

Function TDBFormControl.GetCurrentInquiryCaption: String;
begin
  if Assigned(FCurrentInquiryItem) and (FCurrentInquiryItem.Caption<>'') then
    Result:= FCurrentInquiryItem.Caption
  else Result:= Caption;
end;

{ Наложен ли фильтр на текущий DataSet }
Function TDBFormControl.IsCurrentSourceFiltered: boolean;
begin
  Result:=FCurrentFilter.FilterExist;
end;

{ Выполнение запроса по команде с клавиатуры }
Procedure TDBFormControl.PlayQueryFromKey(Index:byte);
begin
  if Inquiries.Count-1>=Index then PlayInquiry(Inquiries[Index]);
end;

{ обработчик событий нажатия кнопки на панели управления }
Procedure TDBFormControl.SubClick(Sender: TObject);
var aInquiries: TXInquiries;
    aReports: TXReports;
    i: Integer;
    aLink: TAggregateLink;
    aDataset, bDataset: TDataset;
    aList: TList;
    aExcelFileName:string;

Function GetSet:TDataSet;
begin
  {aDataSet:= TLinkSource(FCurrentSource).GetCloneDataset(ltQuery, '');}
  if FCurrentSource.DataSet is TTable then
    try
      aList:=GetVisibleFields(FCurrentSource.DataSet,false,true);
      Result:=TLinkSource(FCurrentSource).GetCloneDataset(ltQuery,
        GetFieldNamesByList(aList,null));
    finally
      aList.Free;
    end
(* Перспективное направление *)
  else
    try
      aList:=GetVisibleFields(FCurrentSource.DataSet,false,true);
      Result:=GetCloneDataSet(FCurrentSource.DataSet,
           GetVisibleFields(FCurrentSource.DataSet,false,true));
    finally
      aList.Free;
    end
end;

Procedure PlaySimpleReport(isNotDefault: Boolean; isDialog: Boolean; aTypeDevice: String{TppDeviceType});
var aToolsActive, isAggregated: Boolean;
    S: String;
    aPrintLink: TPrintLink;
    k: integer;
begin
  aToolsActive:= FormTools.ToolsActive;
  FormTools.ToolsActive:= False;
  aDataSet:=GetSet;
(**)
  aPrintLink:= TPrintLink.Create(pdText);
  with aDataSet do
    for k:=0 to aDataSet.FieldCount-1 do begin
      if (Fields[k] is TEtvLookField) and (Fields[k].FieldKind=fkLookUp) and
      Assigned(Fields[k].LookUpDataSet) and Fields[k].LookUpDataSet.Active and
      (Fields[k].LookUpDataSet.RecordCount<10000) then
        TQuery(Fields[k].LookUpDataSet).FetchAll
    end;
  if (aDataSet is TBDEDataSet) and aDataSet.Active then TQuery(aDataSet).FetchAll;

  try
    if Assigned(aDataSet) then begin
      if Assigned(FCurrentInquiryItem) and Assigned(FCurrentInquiryItem.PrintLink) then
        aPrintLink.Assign(FCurrentInquiryItem.PrintLink)
      else
        if Assigned(SystemPrintLink) then aPrintLink.Assign(SystemPrintLink);
      aPrintLink.UpLink.Title:= GetCurrentInquiryCaption;
      if Assigned(FCurrentInquiryItem) then begin
        isAggregated:=FCurrentInquiryItem.Aggregated;
        aPrintLink.DataCalc:=FCurrentInquiryItem.Calc;
        { Если нажата сумма, то будут итоги, в противном случае - нет }
        if not TToolsForm(TDBFormControl(Self).FormTools.Tools.ToolsForm).SumBtn.Down
          then aPrintLink.DataCalc.TypeResult:=rsNone;

        {aPrintLink.DataCalc.Assign(FCurrentInquiryItem.Calc);}
      end else begin
        isAggregated:=TLinkSource(FCurrentSource).DeclarLink.Aggregated;
        aPrintLink.DataCalc:=TLinkSource(FCurrentSource).GetCalcDeclar;
        {aPrintLink.DataCalc.Assign(TLinkSource(FCurrentSource).GetCalcDeclar);}
      end;
      bDataset:=aPrintLink.DataCalc.DataSet;

      if isAggregated then begin
        S:=aPrintLink.DataCalc.FieldNames;
        aPrintLink.DataCalc.FieldNames:=aPrintLink.DataCalc.GetCalcFieldNames(coAggregate, '',True,';', '');
      end;
      aPrintLink.DataCalc.DataSet:= aDataset;
      aPrintLink.SetVisibleFields;
      if isNotDefault then aPrintLink.DeviceType:= aTypeDevice;
      if not isDialog then
        aPrintLink.GetVisibleFieldsXReport(Self, True)
      else
        if aPrintLink.ShowPrintDialog then begin
          if Assigned(FCurrentInquiryItem) and Assigned(FCurrentInquiryItem.PrintLink) then
            FCurrentInquiryItem.PrintLink.Assign(aPrintLink);
          aPrintLink.GetVisibleFieldsXReport(Self, True);
        end;
      if isAggregated then begin
        aPrintLink.DataCalc.FieldNames:= S;
      end;
      aDataSet.Active:= False;
      aPrintLink.DataCalc.Dataset:= bDataset;
    end;
  finally
    aDataSet.Free;
    aPrintLink.Free;
    FormTools.ToolsActive:= aToolsActive;
  end;
end;

begin
  Inherited SubClick(Sender);
  case TComponent(Sender).Tag of
    btKeyFind:
      if FCurrentSource is TLinkSource then begin
        TLinkSource(FCurrentSource).FindExecute('', False);
      end;
    btCommonFind:
      begin
        {ShowMessage('GlobalFind');}
        RefreshDataOnForm(nil,true);
      end;
    btSum:
      if Assigned(Form) and (Sender is TSpeedButton) and (FCurrentSource is TLinkSource) then begin
        if Assigned(FCurrentInquiryItem) then aLink:= FCurrentInquiryItem
        else aLink:= TLinkSource(FCurrentSource).DeclarLink;
        if TSpeedButton(Sender).Down then begin
          XNotifyEvent.GoSpellChild(Form.ActiveControl, xeSumExecute, aLink, opInsert);
          aLink.Calc.TypeResult:= rsGlobal;
        end else begin
          XNotifyEvent.GoSpell(Form.ActiveControl, xeSumExecute, opRemove);
          aLink.Calc.TypeResult:= rsNone;
        end;
        {if XNotifyEvent.SpellEvent<>xeNone then ShowMessage('Вычисления!');  Lev 07.10.09 Непонятное сообщение }
           {if Assigned(Form) then TXDBForm(Form).SummExecute;}
      end;
{$IFDEF Report_Builder}
    btPrint:
      if (FCurrentSource is TLinkSource) and Assigned(FCurrentSource.DataSet) then begin
        PlaySimpleReport(False, False, {dvScreen}'Screen');
      end;
    btStraightPrint:
      if (FCurrentSource is TLinkSource)and Assigned(FCurrentSource.DataSet) then begin
        PlaySimpleReport(True, False, {dvPrinter}'Printer');
      end;
    btPreviewPrint:
      if (FCurrentSource is TLinkSource)and Assigned(FCurrentSource.DataSet) then begin
        PlaySimpleReport(True, False, {dvScreen}'Screen');
      end;
    btLocalSetupPrint:
      if (FCurrentSource is TLinkSource)and Assigned(FCurrentSource.DataSet) then begin
        PlaySimpleReport(False, True, {dvScreen}'Screen');
      end;
    btSetupPrint: if Assigned(SystemPrintLink) then SystemPrintLink.ShowPrintDialog;
{$ENDIF}
    btTempRec:
      begin
        if TSpeedButton(Sender).Down then Regime:=rmModel
        else Regime:=rmView;
        ChangeCaption;
      end;
    btTempRec+128:
      begin
        if TSpeedButton(Sender).Down then Regime:=rmModel
        else Regime:=rmFilter;
        ChangeCaption;
      end;
    btFilterDlg:
      begin
        if SetSourceFilters(nil)<>idCancel then ActivateFilter
        else if Assigned(CurrentFilter) then ActivateFilter
      end;
    btCurrFilterDlg:
      begin
        if Assigned(CurrentFilter) then begin
          CurrentFilter.Execute;
          ChangeCurrentRecordCount(FCurrentFilter.DataSource);
          CheckFilter;
        end;
        FormTools.ChangeHint(btCancelFilter, '');
        ChangeCaption;
      end;
    btCurrentFilter:
      if (FCurrentSource is TLinkSource) and Assigned(CurrentFilter) and
      (CurrentFilter.FilterExist) then begin
         CurrentFilter.Used:=fuSet;
         ChangeCurrentRecordCount(FCurrentFilter.DataSource);
         FormTools.ChangeHint(btCurrentFilter, TFilterItem(CurrentFilter.
                                               Filters[CurrentFilter.CurFilter]).Name);
         FormTools.ChangeHint(btSum, '');
         ChangeCaption;
      end else FormTools.ChangeHint(btCancelFilter, '');
    btCancelFilter:
      begin
        FormTools.ChangeHint(btCancelFilter, '');
      end;
    btCloseFilter:
      if (FCurrentSource is TLinkSource) and Assigned(CurrentFilter) and
      (CurrentFilter.Used=fuSet) then with FCurrentFilter do begin
        {OldDataSet:=DataSet;}
        CurrentFilter.Used:=fuNone;
        if FilterProceed<>fpNone then begin
          case FilterProceed of
            fpToExtracts: ActivateMainQuery(TQuery(DataSet),'',False);
            fpToOrig:     DeactivateMainQuery(false,false);
          end;
        end;
(*
           { Анализ ситуации перехода на TQuery и обратно }
        if (OldDataSet<>DataSet) then begin
          { Был TTable - стал TQuery }
          if DataSet is TQuery then ActivateMainQuery(TQuery(DataSet),'',False);
          { Был TQuery - стал TTable }
          if DataSet is TTable then DeactivateMainQuery(false,false);
        end;
*)
        ChangeCurrentRecordCount(FCurrentFilter.DataSource);
        FormTools.ChangeHint(btCurrentFilter, 'Выбор фильтра');
        FormTools.ChangeHint(btSum, '');
        Regime:=rmView;
        ChangeCaption;
      end else FormTools.ChangeHint(btCancelFilter, '');
    btFilter..btFilter+125:
      begin
        CurrentFilter:=GetFilterItem(TComponent(Sender).Tag-btFilter);
        ActivateFilter;
        FormTools.ChangeHint(btSum, '');
        ChangeCaption;
      end;
    btFilter+128:
      begin
        if TSpeedButton(Sender).Down then Regime:=rmFilter
        else Regime:=rmModel;
        ChangeCaption;
      end;
    btVisFields: SetInquiryCalcFields(nil, coVisible);
    btIndexFields: SetIFNOrder(nil);
    btIFNContext: SetIFNContext(nil);
    btIFNUnique:
      if Assigned(FCurrentSource) then TLinkSource(FCurrentSource).ChooseIFNUnique;
    btResultCalc: SetInquiryCalcFields(nil, coResult);
    btAggrSelectCalc: SetInquiryCalcFields(nil, coAggregate);
    btAggrGroupByCalc: SetInquiryGroupByCalcFields(nil);
    btRecordCountView: DefRecCount:=not DefRecCount;
    btSetAggregate: SetInquiryAggregate(nil, TRUE);
{Lev - Это вообще лишняя работа - отсутствие сортировки - это тоже сортировка!}
    {btSetAggrWithIndex: SetInquiryAggregate(Nil, True);}
    btCancelAggregate: CancelInquiryAggregate(nil);
    btCancelInquiry: PlayInquiry(nil);
{Lev }
    btFormatInquiryAsInDataBase:
      begin
        if (Self.Form.ActiveControl=TBEForm(Self.Form).Grid) then begin
          if Assigned(TBEForm(Self.Form).Grid.DataSource) then begin
            TBEForm(Self.Form).Grid.FormatColumns(true);
            {TBEForm(Self.Form).Grid.DataSource:=nil;
            TBEForm(Self.Form).Grid.DataSource:=CurrentSource;}
          end
        end else
          SetMinLengthFieldsByDataSet(TLinkTable(TLinkSource(CurrentItem.Source).DataSet),true);
      end;
    btFormatInquiry:
      begin
        if (Self.Form.ActiveControl=TBEForm(Self.Form).Grid) then begin
          if Assigned(TBEForm(Self.Form).Grid.DataSource) then begin
            TBEForm(Self.Form).Grid.FormatColumns(false);
            {TBEForm(Self.Form).Grid.DataSource:=nil;
            TBEForm(Self.Form).Grid.DataSource:=CurrentSource;}
          end
        end else
          SetMinLengthFieldsByDataSet(TLinkTable(TLinkSource(CurrentItem.Source).DataSet),false);
      end;
    btExportToExcel:
      if (
      (AppUserName='LEV')
      or (AnsiUpperCase(VarToStr(GetFromSQLText(TDBDataSet(FCurrentSource.DataSet).DataBaseName,
'select group_name from sysgroups where (member_name=current user) and group_name=''PLAN''',
      false)))='PLAN')
      // 23.04.2001 дал доступ всем USER'ам
      or (AnsiUpperCase(VarToStr(GetFromSQLText(TDBDataSet(FCurrentSource.DataSet).DataBaseName,
'select group_name from sysgroups where (member_name=current user) and group_name=''PUBLIC''',
      false)))='PUBLIC')
      or (AppUserName='VERBICKIJ') or (AppUserName='JURIST')
      or (AppUserName='MECH') or (AppUserName='ADMIN')
      ) and (AnsiUpperCase(AppUserName)<>'*МАРШЕВСКИЙ И.Я.')
(*
      and not(AnsiUpperCase(VarToStr(GetFromSQLText(TDBDataSet(FCurrentSource.DataSet).DataBaseName,
'select group_name from sysgroups where (member_name=current user) and group_name=''TECHNOLOG''',
      false)))='TECHNOLOG')
*)      
      then begin
        aDataSet:=GetSet;
        try
          {Корректируем заголовок DataSet'а}
          TEtvQuery(aDataSet).Caption:=Caption;
          if FileExists(DirShb+'\'+Name+'.xls') then aExcelFileName:=DirShb+'\'+Name+'.xls'
          {if Name='AccountFlowTC' then aExcelFileName:=DirShb+'\TemplateOrder2.xls'}
          else aExcelFileName:='';
          ExportToExcel(TEtvQuery(aDataSet),'',GetCurrentInquiryCaption,0,aExcelFileName,Name,TBEForm(Self.Form).Grid);
          { Сохраняем информацию о запросе в таблице с историей }
          { Достаем номер соединения с БД пользователя }
          i:=GetFromSQLText(TEtvQuery(aDataSet).DataBaseName,'(select connection_property(''Number''))',false);
          // Примерный запрос, чтобы понятнее было при отладке
          //Call STA.ExportToExcelHistorySave(i,AppUserName,ComputerName,GetLocalIP,aDataSet.RecordCount,Copy(TEtvQuery(aDataSet).SQL.Text,1,255))
          ExecSQLText(TEtvQuery(aDataSet).DataBaseName,
            'Call STA.ExportToExcelHistorySave('+IntToStr(i)+','''+AppUserName+''','''+ComputerName+''','''+GetLocalIP+''','+
              IntToStr(aDataSet.RecordCount)+','
              +QuotedStr(Copy(TEtvQuery(aDataSet).SQL.Text,1,Length(TEtvQuery(aDataSet).SQL.Text)-2))+ // SQL-запрос
              ','''+TLinkSource(TDBFormControl(Self).DefSource).TableName+''','+QuotedStr(TEtvQuery(aDataSet).SQL.Text)+')',false);
        finally
          aDataSet.Free;
        end;
      end else
        ShowMessage('Данная функция недоступна');
{Lev }
    btDefInquiry..btDefInquiry+63, btUserInquiry..btUserInquiry+63:
      begin
        if TComponent(Sender).Tag<btUserInquiry then
          i:= GetUserInquiry(TComponent(Sender).Tag-btDefInquiry, False)
        else i:= GetUserInquiry(TComponent(Sender).Tag-btUserInquiry, True);
        if i=-1 then Exit;
        PlayInquiry(Inquiries[i]);
      end;
    btDefReport..btDefReport+63, btUserReport..btUserReport+63:
      begin
        if TComponent(Sender).Tag<btUserReport then
          i:= GetUserReport(TComponent(Sender).Tag-btDefReport, False)
        else i:= GetUserReport(TComponent(Sender).Tag-btUserReport, True);
        if i=-1 then Exit;
        PlayReport(Reports[i]);
      end;
    btEditReport:
      begin
        EdRepsForm:= TEdRepsForm.Create(Application);
        AReports:= Reports;
        EdRepsForm.Control:=Self;
        EdRepsForm.Reports:= AReports.GetCopyReports;
        EdRepsForm.Reports.GetSrcStrings(EdRepsForm.ReportsCombo.Items);
        if EdRepsForm.ReportsCombo.Items.Count>0 then
          EdRepsForm.ReportsCombo.ItemIndex:=0;
        EdRepsForm.UserSource:= CurrUserSource;
        if EdRepsForm.ShowModal=mrOk then begin
          AReports.Free;
          FReports:= EdRepsForm.Reports;
        end else begin
          EdRepsForm.Reports.Free;
        end;
        EdRepsForm.Free;
      end;
    btEditInquiry:
      if (AppUserName='LEV') or (AppUserName='ANDY') or (AppUserName='BAUSHA') then begin
        // Сначала снять запрос, а потом редактировать - иначе глюки после редактирования и записи
        PlayInquiry(nil);
        // Глюки отловить! Строчку удалить! (Стихи :) )
        EdInquiryForm:=TEdInquiryForm.Create(Application);
        AInquiries:=Inquiries;
        EdInquiryForm.Control:=Self;
  {     CurrentFilter:= Nil;}
        EdInquiryForm.Inquiries:=AInquiries.GetCopyLinks;
        EdInquiryForm.Inquiries.GetSrcStrings(EdInquiryForm.InquiryCombo.Items);
        if EdInquiryForm.InquiryCombo.Items.Count>0 then
          EdInquiryForm.InquiryCombo.ItemIndex:=0;
        Reports.GetSrcStrings(EdInquiryForm.ReportsCombo.Items);
        EdInquiryForm.UserSource:= CurrUserSource;
        if EdInquiryForm.ShowModal=mrOk then begin
          CurrentFilter:=nil;
          AInquiries.Free;
          FXInquiries:= EdInquiryForm.Inquiries;
        end else begin
          if EdInquiryForm.IsLinkInquiry then CurrentFilter:=nil;
          EdInquiryForm.Inquiries.Free;
        end;
        EdInquiryForm.Free;
      end else
        ShowMessage('Пользователь '+AppUserName+' не имеет права на эти действия');
    btLevTest:
      begin
        ActivateMainQuery(nil,
         'Select Prod,ProdName,Sum(Amount) as Amount,Price,Sum(Summa) as Summa from STA.InvoiceV where (sDate=''01.04.99'') and (Prod=1105) and (Supported=1) group by Prod,ProdName,Price order by Price',
          true);
      end;
    btLevTest_1:
      begin
        DeactivateMainQuery(true,true);
      end;
  end;
end;

Procedure TDBFormControl.ActivateLinks(IsLoaded: Boolean);
var i: Integer;
begin
  for i:=0 to Sources.Count-1 do begin {?TLinkSubSource}
    if Sources[i].Source is TLinkSource then
      TLinkSource(Sources[i].Source).ActivateLink(IsLoaded)
  end;
end;

Function TDBFormControl.ActivateMainQuery(aQuery:TQuery; SQLText:string; ClearCurrentFilter:boolean):TDataSet;
begin
  Result:=nil;
  if Assigned(FCurrentSource) then with TLinkSource(FCurrentSource) do begin
    if LinkSets.DeclarIndex=0 then begin
      { Запоминаем текущий фильтр при своем DataSet'е }
      if ClearCurrentFilter and Assigned(CurrentFilter) then with GetFilterDeclar do begin
        DeclarLink.Filters.Assign(LinkMaster.Filters);
        {FOldFilter:=CurrentFilter;}
        {AllFilterSleep:=true;}
        DataSource:=nil;
      end;
      { Уничтожаем контроли на сгенерированной на RunTim'е форме }
      if (Form is TBEForm) and Assigned(TBEForm(Form).Scroll) then
        TBEForm(Form).Scroll.DestroyComponents;
      { Заводим новый Главный DataSet типа Query со всеми ВП механизмами }
      LinkSets.AddDeclarQuery(aQuery,SQLText);
(*
      { Переключаем компоненты управления на текущий Link }
      TXDBForm(Form).XPageControl.ChangeLink(DeclarLink,FindDataItem(LinkSets[LinkSets.DeclarIndex].DataSource).FDataLink);
      ChangeIndexCombo;
      DeclarLink.DataSet.Open;
*)
      { Перестраиваем форму для одной записи }
      if (Form is TBEForm) and Assigned(TBEForm(Form).Scroll) then begin
        Form.Tag:=8;
        TBEForm(Self.Form).FormActivate(nil);
      end;
      { Очищаем текущий фильтр для нового DataSet'а }
      if ClearCurrentFilter and Assigned(CurrentFilter) then with LinkMaster.Filters.Data do begin
        ClearAllFilters;
        Used:=fuNone;
        FCurrentFilter:=nil;
      end;
      {LinkMaster.GetLinkDataSet;}
      { Переключаем все контроли на новую DataSourc'у }
      FCurrentSource:=nil;
      CurrentSource:=TLinkSource(LinkSets[LinkSets.DeclarIndex].DataSource);
      {AllFilterSleep:=false;}
      Result:=CurrentSource.DataSet;
    end
  end;
end;

Procedure TDBFormControl.DeactivateMainQuery(aDestroyDataSet,ReturnCurrentFilter:boolean);
var OldDeclarIndex:integer;
begin
  if Assigned(FCurrentSource) then with TLinkSource(FCurrentSource) do
    if LinkSets.DeclarIndex>0 then begin
      OldDeclarIndex:=LinkSets.DeclarIndex;
      {AllFilterSleep:=true;}
      if (Form is TBEForm) and Assigned(TBEForm(Form).Scroll) then
        TBEForm(Form).Scroll.DestroyComponents;
      LinkSets.SetDeclarIndex(0);
      { Перестраиваем форму для одной записи }
      if (Form is TBEForm) and Assigned(TBEForm(Form).Scroll) then begin
        Form.Tag:=8;
        TBEForm(Self.Form).FormActivate(nil);
      end;
      { Возврат старого фильтра на место }
      if ReturnCurrentFilter and (DeclarLink.Filters.Data.Filters.Count>0) then
      with DeclarLink.Filters.Data do begin
        LinkMaster.Filters.Assign(DeclarLink.Filters);
        LinkMaster.Filters.Data.Used:=fuSet;
        FCurrentFilter:=LinkMaster.Filters.Data;
      end;
      FCurrentSource:=nil;
      CurrentSource:=TLinkSource(LinkSets[0].DataSource);
      { Удалили временный MainDataSet }
      if not aDestroyDataSet then LinkSets[OldDeclarIndex].DataSet:=nil;
      LinkSets[OldDeclarIndex].Free;
      {AllFilterSleep:=false;}
    end;
end;

Procedure TDBFormControl.SetDefRecCount(Value: Boolean);
begin
  if Value<>FDefRecCount then begin
    FDefRecCount:=Value;
    if FDefRecCount then ChangeCurrentRecordCount(FCurrentSource);
    ChangeCaption;
  end;
end;

Procedure TDBFormControl.SetDefDBCaption(Value: Boolean);
begin
  if Value<>FDefDBCaption then begin
    FDefDBCaption:=Value;
    ChangeCaption;
  end;
end;

Procedure TDBFormControl.ChangeCaption;
var S, S1: String;
    i: Integer;
begin
  if Assigned(Form) and FDefDBCaption then begin
    S:='';
    if FCurrentSource is TLinkSource then
      with TLinkSource(FCurrentSource) do
        if Assigned(Declar) then begin
          i:=Ord(Declar.State);
          if i<DataStateCaptions.Count then S:= '('+DataStateCaptions[i]+')' else S:='';
          if (Sources.Count>1) and (Caption<>'') then S:='['+Caption+' '+S+']';
          if (dfRecCount in TLinkSource(FCurrentSource).Options) and FDefRecCount then
            S:=': '+IntToStr(CurrentRecordCount)+' зап.:'+S;
        end;

    S1:= GetCurrentInquiryCaption;
    if S1<>'' then
      if S<>'' then Form.Caption:=S1+' '+S
      else Form.Caption:=S1
    else Form.Caption:=S;
  end else Form.Caption:=Caption;
end;

Procedure TDBFormControl.ChangeIndexCombo;
var aName: string;
    aSrcLinks: TSrcLinks;
begin
  if not(Form is TXDBForm) then Exit;
  aSrcLinks:=nil;
  if Assigned(TXDBForm(Form).XPageControl) then
    aSrcLinks:=TXDBForm(Form).XPageControl.Panel.IndexCombo.SrcLinks;
  if Assigned(aSrcLinks) and Assigned(FCurrentSource.DataSet) then begin
    if FCurrentSource.DataSet is TLnTable then
      aName:=GetTableModelIFN(TLnTable(FCurrentSource.Dataset))
    else { Обработка для TQuery }
      aName:=SortingFromDataSet(FCurrentSource.DataSet);
    aSrcLinks.CurrentIndex:=TIFNLink(aSrcLinks).IndexOfFields(aName);
    TXDBForm(Form).XPageControl.Panel.IndexCombo.ActiveChanged;
  end;
end;

Procedure TDBFormControl.CheckActiveControl(Value: TDataSource);
var Comp: TWinControl;
    Priz: Boolean;
begin
  if Form is TXDBForm then with TXDBForm(Form) do begin
    Comp:=nil;
    if Assigned(Value) then begin
      if Assigned(Value.DataSet) then begin
        if (Value.DataSet is TLinkTable) or (Value.DataSet is TLinkQuery) then begin
          Comp:=Form.ActiveControl;
          Priz:=False;
          if Assigned(Comp) then begin
            XNotifyEvent.GoSpell(Comp, xeIsLookField, opInsert);
            Priz:=XNotifyEvent.SpellEvent=xeNone;
          end;
          TFormControl(FormControl).FormTools.SetConfigParams(TLinkSource(Value).IsSetReturn, Priz);
        end;
      end;
    end;
    FLastControl:=Comp;
  end;
end;

Procedure TDBFormControl.SetCurrentSource(Value: TDataSource);
{const FirstFFF:boolean=true;}
var
  aItem: TXLinkSourceItem;
  {Comp: TWinControl;}
  {Priz: Boolean;}
{
  FFF: Text;
  UUU: String;
}
begin
  aItem:=nil;
{  if Value<>FCurrentSource then }
  begin
    {******************************************************
    if FirstFFF then begin
      AssignFile(FFF,'c:\temp\tempik.tmp');
      Rewrite(FFF);
      FirstFFF:=false;
    end else begin
      AssignFile(FFF,'c:\temp\tempik.tmp');
      Append(FFF);
    end;
    if Assigned(Value) then UUU:=Value.Name else UUU:='нет';
    writeln(FFF,'SetCurrentSource '+UUU);
    CloseFile(FFF);
    {******************************************************}

    if Form is TXDBForm then with TXDBForm(Form) do begin
      if Assigned(Value) then aItem:=FindDataItem(Value)
      else aItem:=nil;
      {Comp:=nil;}
      if Assigned(Value) then begin
        if Assigned(FCurrentItem) and (AItem<>FCurrentItem) then
          FCurrentItem.CurrentFilter:=CurrentFilter;
        if Assigned(AItem) and (AItem<>FCurrentItem) then begin
          SetDefCurrentFilter(AItem.CurrentFilter, Value);
        end;
        CheckFilter;
        FCurrentItem:= AItem;
      end;
      if FCurrentSource<>Value then begin
        if (FCurrentSource is TLinkSource)and Assigned(FCurrentSource.DataSet) then begin
          {1}if not TLinkSource(FCurrentSource).CheckBrowseSources then begin
            if Assigned(FLastControl) then with FLastControl do begin
              Show;
              SetFocus;
(* На будущее. Проблемы с передачей фокуса в проблемных ситуациях, когда нельзя запостить
   таблицу, а пользователь кликает мышкой на какой-нибудь DBEdit с другой DataSourc'ой
   В теперешнем варианте событие BeforePost отрабатывает 2 раза (пометки {1} и {2}),
   а надо, чтобы один. Проблема в том, что если пользователь кликнул на Edit, то там после
   возврата фокуса в Grid, остается мигать курсор, что не есть красиво :(

              if Hint<>'' then begin
                ShowMessage(FLastControl.Hint);
                Hint:='';
              end;
*)
            {2}FCurrentSource.DataSet.CheckBrowseMode;
              Exit;
            end;
          end;
   {!!!
              if DataSource.DataSet is TLinkTable then
                 if (DataSource.DataSet as TLinkTable).RefreshTable<>Nil then
                    (DataSource.DataSet as TLinkTable).RefreshTable.Refresh;
   }
        end;
      end;
      CheckActiveControl(Value);
      {FLastControl:=Comp;}
    end;
    if (FCurrentSource<>Value) and (Value is TLinkSource) then with TLinkSource(Value) do begin
      ChangeCurrentRecordCount(Value);
      if Form is TXDBForm then with TXDBForm(Form) do
        if Assigned(XPageControl) and Assigned(aItem) then
          if (Assigned(FCurrentInquiryItem)) and (LinkSets.DeclarIndex=0) then
            XPageControl.ChangeLink(FCurrentInquiryItem, aItem.FDataLink)
          else XPageControl.ChangeLink(DeclarLink, aItem.FDataLink);

      if TLinkSource(Value).LinkMaster.Aggregated then FormTools.ChangeHint(btSetAggregate,'')
      else FormTools.ChangeHint(btCancelAggregate,'');
      if TLinkSource(Value).LinkMaster.Calc.TypeResult<>rsNone then begin
        FormTools.ChangeHint(btResultCalc,'True');
        FormTools.ChangeHint(btSum,'');
      end else FormTools.ChangeHint(btResultCalc,'');
    end;
    if Value is TLinkSource then begin FCurrentSource:=Value;
  {   CurrentFilter:= Nil;}
      CheckFilter;
      CheckTotal;
      ChangeCaption;
      aCurrentLink:=CurrentLink; // Начальная инициализация aCurrentLink
    end;
  end;
end;

Procedure TDBFormControl.ActivateTools;
begin
  Inherited ActivateTools;
  ActivateLinks(False);
end;

Procedure TDBFormControl.DeactivateTools;
var i: Integer;
begin
  Inherited DeactivateTools;
  if (not (csDesigning in ComponentState)) and PostChecked then begin
    for i:=0 to Sources.Count-1 do begin
      if Sources[i].Source is TLinkSource then begin
        TLinkSource(Sources[i].Source).MultiModified:= True;
        TLinkSource(Sources[i].Source).CheckBrowseSources;
      end;
    end;
    CurrentSource:=nil;
    {FormTools.ChangeHint(btCalcSum, '');}
  end;
end;

Procedure TDBFormControl.ActivateForm;
begin
  Inherited;
  CheckFilter;
  CheckTotal;
  ChangeCaption;
end;

Procedure  TDBFormControl.DeactivateForm;
begin
  Inherited;
end;

Procedure TDBFormControl.CreateLink;
var i,j: Integer;
begin
  try
    Inherited;
    if IsAutoEqual and Assigned(Form) then begin
      j:=0;
      for i:=0 to Form.ComponentCount-1 do begin
        if j>Sources.Count-1 then Break;
        XNotifyEvent.GoSpellChild(Form.Components[i], xeSetSource,
                                  TComponent(Sources[j].Source), opInsert);
        if XNotifyEvent.SpellEvent=xeNone then Inc(j);
      end;
    end;
  except
    ShowMessage('DBFormControl Error CreateLink>'+Name);
    Raise;
  end;
end;

Procedure TDBFormControl.ReturnSubClose;
var LnkSet: TLinkSource;
begin
  if Assigned(Form) then
    if Assigned(ReturnForm) then begin
      if Assigned(SelectedField) then
        if Assigned(SelectedField.LookupDataSet) then begin
          if (SelectedField.LookupDataSet is TLinkQuery) then LnkSet:=TLinkQuery(SelectedField.LookupDataSet).LinkSource;
          if (SelectedField.LookupDataSet is TLinkTable) then LnkSet:=TLinkTable(SelectedField.LookupDataSet).LinkSource;
          if Assigned(LnkSet) and LnkSet.IsSetReturn then begin
            IsReturnControl:=True;
            if CurrentSource is TLinkSource then
              TLinkSource(CurrentSource).IsReturnValue:=True;
              Form.Close;
          end;
        end;
    end;
end;

Function TDBFormControl.GetPostChecked: Boolean;
var i: Integer;
begin
  Result:=True;
  for i:=0 to Sources.Count-1 do begin
    if Sources[i].Source is TLinkSource then
      if not TLinkSource(Sources[i].Source).PostChecked then begin
        Result:=False;
        Break;
      end;
  end;
end;

Procedure TDBFormControl.ReturnFormShow;
begin
  if IsReturnControl then begin
{?->  if CurrentSource is TLinkSource then
        TLinkSource(CurrentSource).IsReturnValue:=True;}
    IsReturnControl:=False;
    if Assigned(ReturnForm) then begin
      ReturnForm.Show;
    end;
  end;
end;

{ TXSaveDBFormControl }

Constructor TXSaveDBFormControl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FInquiries:= TXInquiries.Create(nil);
  FReports:= TXReports.Create(nil);
end;

Destructor TXSaveDBFormControl.Destroy;
begin
  FInquiries.Free;
  FReports.Free;
  Inherited Destroy;
end;

Function TXSaveDBFormControl.IsStoreReports: Boolean;
begin
  Result:= Reports.Count>0;
end;

Function TXSaveDBFormControl.IsStoreInquiries: Boolean;
begin
  Result:= Inquiries.Count>0;
end;

Procedure TXSaveDBFormControl.SetInquiries(Value: TCollection);
begin
  FInquiries.Assign(Value);
end;

Procedure TXSaveDBFormControl.SetReports(AItems: TCollection);
begin
  FReports.Assign(AItems);
end;

{ TXDatabase }

Function TXDatabase.PDCreate(const AUserName: String): TForm;
begin
  Result:=Inherited PDCreate(AUserName);
  IsAppActive:=False;
end;

Procedure TXDatabase.PDDestroy(AForm: TForm);
begin
  IsAppActive:=True;
  PostMessage(HWND_BROADCAST, wm_ActivateApp, Word(True), 0);
  Inherited;
end;

Procedure TXDatabase.SetTools(ATools: TDBToolsControl);
begin
  if ATools<>FTools then begin
    FTools:= ATools;
    if Assigned(FTools) and Assigned(FTools.UserSource) then
      FTools.UserSource.DefUser:=UserName;
  end;
end;

Procedure TXDatabase.DoLoaded;
begin
  Inherited;
  if Assigned(FTools) and Assigned(FTools.UserSource) then begin
    FTools.UserSource.DefUser:=UserName;
  end;
  if Assigned(FLogSource) then begin
    if FLogSource is TLinkSource then begin
      TLinkSource(FLogSource).LinkSets.SetSourceIndexes;
    end;
    if Assigned(FLogSource.DataSet) then begin
      FLogSource.DataSet.Open;
      if not FLogSource.DataSet.Locate(LogField, UserName, [loCaseInsensitive]) then begin
        ShowMessage('Пользователь '+UserName+
          ' не зарегистрирован на сервере. Обратитесь к администратору баз данных!');
        Application.Terminate;
      end;
    end;
  end;
  { Определение юзера с сервера }
  AppUserName:=AnsiUpperCase(GetFromSQLText(DataBaseName,'select user_name()',false));
end;

{ Пока не нужна. Авось потом пригодится
Function GetCurrentFilterStream: TMemoryStream;
var aLink: TAggregateLink;
begin
  aLink=GetCurrentLink;
  if Assigned(aLink) then
    Result:=aLink.FilterStream
  else Result:=nil;
end;
}

Type TEtvFilterSelf=class(TEtvFilter);

Procedure LinkFilterSave(EtvFilter:TComponent);
var {PropInfo: PPropInfo;}
    Stream:TMemoryStream;
    aLink: TAggregateLink;
    L:integer;
begin
  with TEtvFilterSelf(EtvFilter) do begin
    Stream:=nil;
    try
(*  Этот вариант сделать вместе с Igo
      PropInfo:=GetPropInfo(DataSet.ClassInfo,'FilterStream');
      if PropInfo<>nil then begin
        Stream:=TMemoryStream(GetOrdProp(DataSet,PropInfo));
*)
(*
      if DataSet is TLnTable then Stream:=TLnTable(DataSet).FilterStream
      else if DataSet is TLnQuery then Stream:=TLnQuery(DataSet).FilterStream;
*)
      aLink:=aCurrentLink;
      if not Assigned(aLink) then begin
        ShowMessage('No Current Link. From LinkFilterSave. Exit from procedure');
        Exit;
      end;
      Stream:=aLink.FilterStream;;
      if not Assigned(Stream) then begin
        Stream:=TMemoryStream.Create;
{*** !!!!!!!!!!!!!!!!!! ***}
{*** Заменить на более красивое решение ч/з PropInfo
        if DataSet is TLnTable then TLnTable(DataSet).FilterStream:=Stream
        else if DataSet is TLnQuery then TLnQuery(DataSet).FilterStream:=Stream;
*** !!!!!!!!!!!!!!!!!! ***}
        aLink.FilterStream:=Stream;
      end;
(*
      end else begin
        if not Assigned(Stream) then begin
          Stream:=TMemoryStream.Create;
{*** !!!!!!!!!!!!!!!!!! ***}
{*** Заменить на более красивое решение ч/з PropInfo }
          if DataSet is TLnTable then TLnTable(DataSet).FilterStream:=Stream
          else if DataSet is TLnQuery then TLnQuery(DataSet).FilterStream:=Stream;
{*** !!!!!!!!!!!!!!!!!! ***}
        end;
      end;
*)
      Stream.Seek(0,soFromBeginning);
      { Дозаписываем в поток недостающие переменные fOldFilter, fOldFiltered }
      { Есть еще fOldOnFilterRecord, но пока им не пользуемся }
      L:=Length(fOldFilter);
      Stream.Write(L,SizeOf(L));
      Stream.Write(Pointer(fOldFilter)^,L);
      Stream.Write(fOldFiltered,SizeOf(boolean));
      SaveToStream(Stream);
    finally
      {Stream.Free;}
    end;
  end;
end;

procedure LinkFilterLoad(EtvFilter:TComponent);
var Stream:TMemoryStream;
    Size: integer;
    aLink: TAggregateLink;
begin
  with TEtvFilterSelf(EtvFilter) do begin
    if Assigned(DataSet) and (Dataset=QExtracts) then begin
      try
        {Stream:=nil;}
        (*
        if DataSet is TLnTable then Stream:=TLnTable(DataSet).FilterStream
        else if DataSet is TLnQuery then Stream:=TLnQuery(DataSet).FilterStream;
        *)
        // Выход на соответсвующий TAggregateLink.FilterStream;
        aLink:=aCurrentLink;
        if not Assigned(aLink) then begin
          ShowMessage('No Current Link. From LinkFilterLoad. Exit from procedure');
          Exit;
        end;
        Stream:=aLink.FilterStream;;

        if Assigned(Stream) then begin
          { Досчитываем из потока недостающие переменные fOldFilter, fOldFiltered }
          { Есть еще fOldOnFilterRecord, но пока им не пользуемся }
          Stream.Seek(0,soFromBeginning);
          Stream.Read(Size,SizeOf(Integer));
          SetString(fOldFilter, nil, Size);
          Stream.Read(Pointer(fOldFilter)^,Size);
          Stream.Read(fOldFiltered,SizeOf(boolean));
          LoadFromStream(Stream);
        end;
      except
      end;
    end;
  end;
end;

Initialization
  DataStateCaptions := TStringList.Create;
  DataStateCaptions.Text := dsStateCaptions;
  XActiveDBFormList:= TList.Create;
  XNotifyEvent:=TXNotifyEvent.Create(nil);
  CreateOtherOnFilterLoad:= LinkFilterLoad;
  CreateOtherOnFilterSave:= LinkFilterSave;
Finalization
  DataStateCaptions.Free;
  XActiveDBFormList.Free;
  XNotifyEvent.Free;
  XNotifyEvent:=nil;
  CreateOtherOnFilterLoad:= nil;
  CreateOtherOnFilterSave:= nil;
end.
