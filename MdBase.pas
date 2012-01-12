Unit MdBase;

Interface

Uses
  Forms, EtvDBFun, Db, XTFC, DBTables, LnTables, Windows,
  Menus, Classes, XMisc, XEFields, EtvTable, XApps, XECtrls,
  XDBTFC, LnkSet, EtvDBase, ppEndUsr, UsersSet, XLnkPipe, EtvDB, ppComm,
  EtvLook, EtvList, ExtCtrls;

type
  TModuleBase = class(TDataModule)
    Popup: TControlMenu;
    KSMTools: TDBToolsControl;
    UsersC: TDBFormControl;
    KSMDatabase: TXDatabase;          
    Users: TLinkSource;
    UsersDeclar: TLinkTable;                   
    UsersDeclarEmpNo: TIntegerField;
    UsersDeclarName: TStringField;
    Workers: TLinkSource;
    WorkersDeclar: TLinkTable;
    WorkersDeclarTN: TIntegerField;
    WorkersDeclarFAM: TStringField;
    WorkersDeclarIM: TStringField;
    WorkersDeclarOTCH: TStringField;
    WorkersDeclarPol: TXEListField;
    WorkersDeclarDT_RJDN: TDateField;
    WorkersDeclarDT_UR: TDateField;
    WorkersDeclarTN_OSN: TIntegerField;
    WorkersDeclarDT_UVL: TDateField;
    WorkersDeclarPRICH_UVL: TIntegerField;
    WorkersLookup: TLinkQuery;
    WorkersC: TDBFormControl;
    WorkersLookupTn: TIntegerField;
    WorkersLookupFamImOtch: TStringField;
    Shop: TLinkSource;
    ShopDeclar: TLinkTable;
    ShopDeclarKod: TSmallintField;
    ShopDeclarName: TStringField;
    ShopLookup: TLinkQuery;
    ShopLookupKod: TSmallintField;
    ShopLookupName: TStringField;
    ShopC: TDBFormControl;
    Section: TLinkSource;
    SectionDeclar: TLinkTable;
    SectionDeclarShop: TSmallintField;
    SectionDeclarName: TStringField;
    SectionDeclarShopName: TXELookField;
    SectionLookup: TLinkQuery;
    SectionLookupName: TStringField;
    SectionC: TDBFormControl;
    DutySet: TLinkSource;
    Queries: TLinkSource;
    QueriesC: TDBFormControl;
    Reports: TLinkSource;
    ReportsDeclar: TLinkTable;
    ReportsC: TDBFormControl;
    ReportsKod: TIntegerField;
    ReportsName: TStringField;
    ReportsViewName: TStringField;
    ReportsOrderBy: TStringField;
    ReportsShbName: TStringField;
    ReportsSearchCondition: TStringField;
    ReportsSelectList: TStringField;
    MainPopup: TControlMenu;
    LinkMenuItem1: TLinkMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    KeyFindItem: TUserMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    ChangeIndexItem: TMenuItem;
    MenuItem11: TMenuItem;
    OnOffToolsItem: TMenuItem;
    ReturnOpenItem: TMenuItem;
    ReturnCloseItem: TMenuItem;
    InformItem: TMenuItem;
    Config: TLinkSource;
    ConfigDeclar: TLinkTable;
    ConfigC: TDBFormControl;
    ReportsDeclarFormName: TStringField;
    Config1: TLinkMenuItem;
    DutySetC: TDBFormControl;
    QueriesDeclar: TLinkQuery;
    QueriesProcess: TLinkQuery;
    QueriesLookup: TLinkQuery;
    ConfigSrc: TUserSource;
    Declars: TLnQuery;
    DeclarsUserName: TStringField;
    DeclarsName: TStringField;
    DeclarsPattern: TBlobField;
    Reps: TLnQuery;
    StringField2: TStringField;
    BlobField1: TBlobField;
    RepsSrc: TUserSource;
    Reporter: TppXDesigner;
    WorkersV: TLinkSource;
    WorkersVDeclar: TLinkTable;
    WorkersVDeclarTN: TIntegerField;
    WorkersVDeclarFam: TStringField;
    WorkersVDeclarIm: TStringField;
    WorkersVDeclarOtch: TStringField;
    WorkersVDeclarDateBorn: TDateField;
    WorkersVDeclarCeh: TSmallintField;
    WorkersVDeclarCehName: TStringField;
    WorkersVDeclarProf: TIntegerField;
    WorkersVDeclarProfName: TStringField;
    WorkersVDeclarDateUvl: TDateField;
    WorkersVDeclarPrUvl: TIntegerField;
    WorkersVDeclarPrUvlName: TStringField;
    WorkersVDeclarRazr: TIntegerField;
    WorkersVDeclarPol: TXEListField;
    WorkersVC: TDBFormControl;
    TableLock: TLinkSource;
    TableLockDeclar: TLinkTable;
    TableLockDeclarTableName: TStringField;
    TableLockDeclarTOper: TSmallintField;
    TableLockDeclarWriteFlag: TXEListField;
    TableLockC: TDBFormControl;
    TableLockDeclarWriteDates: TStringField;
    QueriesLookupidentity: TIntegerField;
    TableLockDeclarTableRemark: TStringField;
    TableLockDeclarWriteDateBeg: TDateField;
    TableLockDeclarWriteDateEnd: TDateField;
    TableLockDeclarNoDateBeg: TDateField;
    TableLockDeclarNoDateEnd: TDateField;
    TableLockDeclarNoDates: TStringField;
    {ConfigDeclarCurDate: TDateField;}
    ConfigDeclarCurMonth: TDateField;
    ConfigDeclarCurShbPath: TStringField;
    ConfigDeclarCurPeriod: TDateField;
    WorkersVDeclarDateWorkKsm: TDateField;
    WorkersVDeclarDateWorkTotal: TDateField;
    WorkersVDeclarDateWorkContinue: TDateField;
    WorkersVDeclarCategory: TIntegerField;
    WorkersVDeclarCategoryName: TStringField;
    WorkersVDeclarBrig: TIntegerField;
    WorkersVDeclarDateBorn1: TStringField;
    WorkersVDeclarYears: TSmallintField;
    WorkersVDeclarYearsWork: TSmallintField;
    WorkersVDeclarYearsWorkKsm: TSmallintField;
    WorkersVDeclarSovm: TIntegerField;
    CommonItem: TMenuItem;
    UnitM: TLinkSource;
    UnitMDeclar: TLinkTable;
    UnitMDeclarKod: TSmallintField;
    UnitMDeclarName: TStringField;
    UnitMDeclarShortN: TStringField;
    UnitMDeclarDivide: TXEListField;
    UnitMLookup: TLinkQuery;
    UnitMLookupKod: TSmallintField;
    UnitMLookupName: TStringField;
    UnitMLookupShortN: TStringField;
    UnitMC: TDBFormControl;
    Tare: TLinkSource;
    TareDeclar: TLinkTable;
    TareDeclarKod: TSmallintField;
    TareDeclarName: TStringField;
    TareDeclarWeight: TFloatField;
    TareLookup: TLinkQuery;
    TareLookupKod: TSmallintField;
    TareLookupName: TStringField;
    TareLookupWeight: TFloatField;
    TareAnalogue: TLinkQuery;
    TareAnalogueAnalTare: TSmallintField;
    TarePrice: TLinkSource;
    TarePriceDeclar: TLinkTable;
    TarePriceDeclarTare: TSmallintField;
    TarePriceDeclarTareName: TXELookField;
    TarePriceDeclarSDate: TDateField;
    TarePriceDeclarPrice: TIntegerField;
    TareC: TDBFormControl;
    TareAnal: TLinkSource;
    TareAnalDeclar: TLinkTable;
    TareAnalDeclarTare1: TSmallintField;
    TareAnalDeclarTareName1: TXELookField;
    TareAnalDeclarTare2: TSmallintField;
    TareAnalDeclarTareName2: TXELookField;
    TareAnalProcess: TLinkQuery;
    TareAnalC: TDBFormControl;
    UnitM1: TLinkMenuItem;
    TareAnal1: TLinkMenuItem;
    Tare1: TLinkMenuItem;
    Depot: TLinkSource;
    DepotDeclar: TLinkTable;
    DepotDeclarKod: TSmallintField;
    DepotDeclarName: TStringField;
    DepotDeclarShop: TIntegerField;
    DepotDeclarShopName: TXELookField;
    DepotLookup: TLinkQuery;
    DepotLookupKod: TSmallintField;
    DepotLookupName: TStringField;
    DepotC: TDBFormControl;
    Depot1: TLinkMenuItem;
    SectionLookupSection: TIntegerField;
    SectionDeclarSection: TIntegerField;
    AppControl: TXAppControl;
    ConfigDeclarBeginProcessCB: TDateTimeField;
    ConfigDeclarEndProcessCB: TDateTimeField;
    ConfigDeclarCalcNextPeriod: TXEListField;
    WorkersVDeclarEducation: TIntegerField;
    CloseActiveTables: TMenuItem;
    Timer: TTimer;
    TareDeclarsReturn: TXEListField;
    TareLookupsReturn: TXEListField;
    ConfigDeclarReportPeriod: TDateField;
    ConfigDeclarRegNumInFund: TStringField;
    ConfigDeclarPhoneForFund: TStringField;
    SectionLookupShop: TSmallintField;
    UsersDeclarFIO: TXELookField;
    TareDeclarAmountProd: TFloatField;
    TareDeclarProd: TIntegerField;
    SectionDeclarBrigade: TSmallintField;
    SectionDeclarSector: TSmallintField;
    ShopDeclarIndustrial: TXEListField;
    DepotDeclarAccount: TStringField;
    DepotLookupAccount: TStringField;
    DepotDeclarAccountName: TXELookField;
    UsersDeclarAccount: TStringField;
    ConfigDeclarNextPeriod: TDateField;
    UsersDeclarMemberOfGroups: TStringField;
    TareLSource: TProcSubSource;
    UnitMDeclarShortName: TStringField;
    TareAnalDeclarDateBeg: TDateField;
    SectionDeclarDepot: TSmallintField;
    SectionDeclarDepotName: TXELookField;
    procedure DisableTools(Sender: TObject);
    procedure SubBtnClick(Sender: TObject);
    procedure OnOffToolsItemClick(Sender: TObject);
    procedure ChangeIndexItemClick(Sender: TObject);
    procedure ToolsItemClick(Sender: TObject);
    function SQLString(aReport:integer; aWhere:String):String;
    procedure ModuleBaseCreate(Sender: TObject);
    procedure ToolsClick(Sender: TFormControl; BtnTag: Integer;
      BtnDown: Boolean);
    procedure DataModuleFormRebuildFormItemClick(Sender: TObject);
    procedure TableLockDeclarCalcFields(DataSet: TDataSet);
    procedure KSMDatabaseLoaded(Sender: TObject);
    procedure KSMDatabaseLogin(Database: TDatabase; LoginParams: TStrings);
    function  GetAnalTare(InTare:SmallInt):SmallInt;
    procedure AppControlIdle(Sender: TObject; var Done: Boolean);
    procedure AppControlMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure TimerTimer(Sender: TObject);
    procedure CloseActiveTablesClick(Sender: TObject);
    procedure ConfigDeclarReportPeriodValidate(Sender: TField);
    { Для показа пользователю только нужных отделов для задачи "Учет материалов"}
    function SectionNameFilter(Sender: TObject): String;
    procedure FormNotSupportedClick(Sender: TObject);
    procedure UsersDeclarCalcFields(DataSet: TDataSet);
  private
    FTest: Integer;
  public
    ReportParams:Variant;
    Function IsProgrammers: boolean;
  published
    property Test:integer read FTest write FTest;
  end;
  { Функция округления для белорусских рублей }
  Function RoundRB(aDate:TDateTime; aPrivate: boolean; aIsPrice: boolean): integer;
  { Общая функция округления для всех сумм }
  { У меня нет слов (одна нецензурщина просится на язык)!!! }
  { 09.11.2011 ВЕЛИКИЕ ПЛАНОВИКИ КСМ ПОСТАВИЛИ ЗАДАЧУ: ЦЕНЫ ОКРУГЛЯЮТСЯ ДО 100 РУБЛЕЙ, А СУММЫ ПО ЗАКОНОДАТЕЛЬСТВУ - ДО 50 рублей}
  { Ввел новый параметр aIsPrice:boolean }
  Function RoundSummaAll(aSumma: double; aCurrency: smallint; aDate: TDateTime; aPrivate:boolean; aIsPrice: boolean):double;
  Function UserInGroup(aGroupName: string): boolean;


Const Date010499=36251;   { 01.04.1999 в формате TDateTime }
      Date01012000=36526; { 01.01.2000 в формате TDateTime }
      Date25032002=37340; { 25.03.2002 в формате TDateTime }
      Date01062002=37408; { 01.06.2002 в формате TDateTime }
      Date10012003=37631; { 10.03.2003 в формате TDateTime }
      Date01022008=39479; { 01.02.2008 в формате TDateTime }
      Date12112011=40859; { 12.11.2011 в формате TDatetime }

var
  ModuleBase: TModuleBase;
  CurPeriod, NextPeriod: string[10]; { Дата текущего расчетного периода в строковом виде }
  UserName : string[30];
  UserTN: integer;
  UserID: integer;
  FIN_BUH_FSG_Group:integer;

Implementation

Uses SysUtils, Messages, Dialogs, Misc, XForms, XDBForms, BEForms, MdCommon, MdWorkers, Graphics, BDE,
     Controls, TlsForm, sForm;

Var aIdle:integer=0;

{$R *.DFM}

{ Функция округления для белорусских рублей }
Function RoundRB(aDate:TDateTime; aPrivate: boolean; aIsPrice: boolean): integer;
begin
  if (aDate<Date010499) then Result:=100
  else if aDate<Date01012000 then Result:=1000
  else if (aDate<Date10012003) or not aPrivate then Result:=1
  else if (aDate>=Date01022008) and (aDate<Date12112011) and aPrivate then Result:=10
  else if (aDate>=Date12112011) and aPrivate then
    if aIsPrice then Result:=100 else Result:=50
  else Result:=5;
end;

Function RoundSummaAll(aSumma: double; aCurrency: smallint; aDate: TDateTime; aPrivate: boolean; aIsPrice: boolean):double;
var aRound:integer;
begin
  if aCurrency=974 then begin
    aRound:=RoundRB(aDate,aPrivate,aIsPrice);
    if aRound=1 then
      if aDate<Date25032002 then
        if aSumma<=1000 then aRound:=1 else aRound:=10;
      if (aDate>=Date25032002) and (aDate<Date10012003) then
        if aSumma<=1000 then aRound:=1 else aRound:=5;
      if (aDate>=Date10012003) and (aDate<Date12112011) then
        if aSumma<=1000 then aRound:=5 else aRound:=10;
      Result:=MRound(aSumma/aRound)*aRound;
  end else begin
    if aDate<Date01062002 then Result:=MRound(aSumma*10)/10
    else Result:=MRound(aSumma*100)/100;
  end;
end;

Function UserInGroup(aGroupName: string): boolean;
begin
  if Pos(aGroupName,ModuleBase.UsersDeclarMemberOfGroups.AsString)>0 then
    Result:=true
  else Result:=false;
end;

procedure TModuleBase.DisableTools(Sender: TObject);
begin
  KSMTools.ToolsClose{(TFormControl(Sender), Action)};
  KSMTools.ToolsHide{(TFormControl(Sender))};
end;

procedure TModuleBase.SubBtnClick(Sender: TObject);
begin
{
  Case TComponent(Sender).Tag of
    btInform: Informs.Execute;
    btHelp: Application.HelpContext(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl.HelpContext);
    btPrint:
            with TBForm(TDBFormControl(TToolsForm(TComponent(Sender).Owner).
                        CurrentFormControl).Form) do begin
                 if (PageControl1PanelNavigator.DataSource is TLinkSource) and
                    Assigned(TLinkSource(PageControl1PanelNavigator.DataSource).LinkDataSet)
                    then
             with BaseControl do
             if Assigned(PrintControl) then begin
             PrintControl.DataSet:=TLinkSource(PageControl1PanelNavigator.DataSource).DataSet;
             PrintControl.Print;
             end;
            end;

    btSetupPrint:
            with TBForm(TDBFormControl(TToolsForm(TComponent(Sender).Owner).
                        CurrentFormControl).Form) do begin
                 if (PageControl1PanelNavigator.DataSource is TLinkSource) and
                    Assigned(TLinkSource(PageControl1PanelNavigator.DataSource).LinkDataSet)
                    then
             with BaseControl do
             if Assigned(PrintControl) then begin
             PrintControl.DataSet:=TLinkSource(PageControl1PanelNavigator.DataSource).DataSet;
             PrintControl.SetupPrintDialog;
             end;
             end;
    btKeyFind:
               with TBForm(TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl).Form) do begin
               BaseControl.DataSource:=PageControl1PanelNavigator.DataSource;
               BaseControl.FindExecute;
               end;
    btGlobalFind: begin
               ShowMessage('GlobalFind');
               end;
    btTempRec:
               with TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl) do begin
               if TSpeedButton(Sender).Down then
                  Regime:=rmTemp
                  else Regime:=rmCommon;
               ChangeCaption;
               end;
    btTempRec+128:
               with TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl) do begin
               if TSpeedButton(Sender).Down then
                  Regime:=rmTemp
                  else Regime:=rmFilter;
               ChangeCaption;
               end;
    btFilter:
               with TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl) do begin
               if TSpeedButton(Sender).Down then
                  Regime:=rmFilter
                  else Regime:=rmCommon;
               ChangeCaption;
               end;
    btFilter+128:
               with TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl) do begin
               if TSpeedButton(Sender).Down then
                  Regime:=rmFilter
                  else Regime:=rmTemp;
               ChangeCaption;
               end;
    btSumm:
            with TBForm(TDBFormControl(TToolsForm(GetParentForm(TControl(Sender))).
                        CurrentFormControl).Form) do begin
                 if (PageControl1PanelNavigator.DataSource is TLinkSource) and
                    Assigned(TLinkSource(PageControl1PanelNavigator.DataSource).LinkDataSet)
                    then
                    TLinkSource(PageControl1PanelNavigator.DataSource).LinkDataSet.SummExecute;
            end;
  end;
  }
end;

Procedure TModuleBase.OnOffToolsItemClick(Sender: TObject);
var Form: TForm;
    Ct: TFormControl;
begin
  Form:=Screen.ActiveForm;
  if Form is TXForm then With TXForm(Form) do begin
     if Assigned(FormControl) then begin
       Ct:=TFormControl(FormControl);
       Ct.FormTools.ToolsActive:=Not Ct.FormTools.ToolsActive;
        end;
     end;
end;

procedure TModuleBase.ChangeIndexItemClick(Sender: TObject);
var Form: TForm;
begin
  Form:=Screen.ActiveForm;
  if Form is TXDBForm then With TXDBForm(Form) do begin
    if XPageControl is TXDBPageControl then With TXDBPageControl(XPageControl) do begin
      if Assigned(Panel.IndexCombo) then begin
        Panel.IndexCombo.SetFocus;
        Panel.IndexCombo.DroppedDown:=True;
      end;
    end;
  end;
end;

procedure TModuleBase.ToolsItemClick(Sender: TObject);
var Form: TForm;
    Ct: TFormControl;
begin
  Form:=Screen.ActiveForm;
  if Form is TXForm then With TXForm(Form) do begin
    if Assigned(FormControl) then begin
      Ct:=TFormControl(FormControl);
      Ct.FormTools.ToolsSubClick(Sender);
    end;
  end;
end;

Function TModuleBase.SQLString(aReport:integer; aWhere:String):String;
begin
  Result:='';
  if not ReportsDeclar.Active then ReportsDeclar.Active:=true;
  if ReportsDeclar.FindKey([aReport]) then begin
    Result:='Select ';
    if (ReportsSelectList.Value=null) or (ReportsSelectList.Value='') then
      Result:=Result+'*'
    else Result:=Result+ReportsSelectList.Value;
    Result:=Result+' from '+ReportsViewName.Value;
    if ((ReportsSearchCondition.Value<>null) and (ReportsSearchCondition.Value<>'')) or
      (aWhere<>'') then
      Result:=Result+' where '+AddFilterCondition(ReportsSearchCondition.Value,aWhere);
    if (ReportsOrderBy.Value<>null) and (ReportsOrderBy.Value<>'') then
      Result:=Result+' order by '+ReportsOrderBy.Value;
  end;
end;

Procedure TModuleBase.ModuleBaseCreate(Sender: TObject);
const MaxParams=20;
var v:variant;

  procedure InsertItem1;
  var NewItem: TMenuItem;
      aToolsForm:TToolsForm;
  begin
    aToolsForm:=TToolsForm(Screen.CustomForms[1]);
    NewItem:=TMenuItem.Create(aToolsForm);
    try
      NewItem.Caption:='Закрыть активные формы и таблицы';
      NewItem.OnClick:=CloseActiveTablesClick;
      if Assigned(aToolsForm.ExitPopup.Items) then
        aToolsForm.ExitPopup.Items.Insert(1, NewItem);
    except
      NewItem.Free;
      raise; { reraise the exception }
    end;
  end;

begin
  if Application.Terminated then Exit;
  ReportParams:= VarArrayCreate([0,MaxParams],varVariant);
  ExecSQLText(KsmDatabase.DatabaseName,
              'SET TEMPORARY OPTION date_order = ''dmy'';'+
              'SET TEMPORARY OPTION date_format = ''dd.mm.yy'';'+
              'SET TEMPORARY OPTION timestamp_format = ''dd.MM.yy HH:NN:ss.SSS''',false);
  with ModuleBase do begin
    if not ConfigDeclar.Active then ConfigDeclar.Open;
    { Если параметр "-DirShb" не задан в командной строке, то его значение берем из базы (STA.AdmConfig) }
    if DirShb='' then DirShb:=ConfigDeclarCurShbPath.Value;
    CurPeriod:=ConfigDeclarCurPeriod.AsString;
    NextPeriod:=DateToStr(IncMonth(ConfigDeclarCurPeriod.AsDateTime,1));
  end;
  {WorkersDeclar.DisableControls;}
  V:=GetFromSQLText(KsmDataBase.DataBaseName,
    'select GetFin_Fsg_Buh_GroupID()',false);
  if V=null then FIN_BUH_FSG_Group:=0 else FIN_BUH_FSG_Group:=V;
  V:=GetFromSQLText(KsmDataBase.DataBaseName,
    'select user_id()',false);
  if V=null then UserID:=-1 else UserID:=V;
  UserTN:=UsersDeclarEmpNo.Value;
  InsertItem1;
end;

Procedure TModuleBase.ToolsClick(Sender: TFormControl;
  BtnTag: Integer; BtnDown: Boolean);

Procedure fDbiSetDateFormat;
var
  fDate : FMTDate;
begin
  fDate.szDateSeparator := '.';        { Specifies date separator character }
  fDate.iDateMode := 1;                { Date format. 0 = MDY, 1 = DMY, 2 = YMD. }
  fDate.bFourDigitYear := FALSE;       { If TRUE, write year as four digits. }
  fDate.bYearBiased := TRUE;           { On input add 1900 to year if TRUE. }
  fDate.bMonthLeadingZero := TRUE;     { Month displayed with a leading zero if TRUE. }
  fDate.bDayLeadingZero := TRUE;       { Day displayed with leading zero if TRUE. }
  Check(DbiSetDateFormat(fDate));
end;

begin
  Case BtnTag of
    btHelp: begin
              with ModuleBase.QueriesDeclar do begin
                {Close;
                Open;}
                ModifyLookDataSetActive(ModuleBase.QueriesDeclar,false);
                ModifyLookDataSetActive(ModuleBase.QueriesDeclar,true);
              end;
            end;
  end;
end;

procedure TModuleBase.DataModuleFormRebuildFormItemClick(Sender: TObject);
var ActForm:TForm;
begin
  ActForm:=Screen.ActiveForm;
  if ActForm.ClassName='TBEForm' then begin
    if TMenuItem(Sender).Name='RebuildFormVisibleItem' then ActForm.Tag:=8
    else ActForm.Tag:=9;
    TBEForm(ActForm).FormActivate(nil)
  end;
end;

Procedure TModuleBase.TableLockDeclarCalcFields(DataSet: TDataSet);
begin
  TableLockDeclarTableRemark.AsVariant:=
    GetFromSQLText(KSMDatabase.DataBaseName,
      'Select GetTableRemark('+''''+TableLockDeclarTableName.Value+''''+')',false);
end;

procedure TModuleBase.KSMDatabaseLoaded(Sender: TObject);
begin
  if AliasName<>'' then KSMDataBase.AliasName:=AliasName;
end;

Procedure TModuleBase.KSMDatabaseLogin(Database: TDatabase; LoginParams: TStrings);
begin
  UserName:=AnsiUpperCase(Copy(LoginParams[0],11,99));
end;

Function TModuleBase.IsProgrammers: boolean;
begin
  Result:=false;
  if (UserName='LEV') or (UserName='ADMIN') or (UserName='BAUSHA') then Result:=true;
end;

Function TModuleBase.GetAnalTare(InTare:SmallInt):SmallInt;
begin
  with TareAnalogue do begin
    ParamByName('InTare').Value:=InTare;
    Open;
    Result:=TareAnalogueAnalTare.Value;
    Close;
  end;
end;

procedure TModuleBase.CloseActiveTablesClick(Sender: TObject);
var i,j:integer;
begin
  { Проверяем DataSet'ы на состояние dsBrowse }
  with KSMDataBase do begin
    i:=DataSetCount-1;
    j:=0;
    repeat
      if not ((DataSets[i].Name='UsersDeclar') or
      (DataSets[i].Name='WorkersLookup') or (DataSets[i].Name='ConfigDeclar') or
      (DataSets[i].Name='Declars') or (DataSets[i].Name='OrgBankLookup1')) then begin
        if not(DataSets[i].State in [dsBrowse,dsSetKey]) then SysUtils.Abort;
        Dec(i);
      end else Dec(i);
    until i=0;
  end;
  { Закрываем Формы }

  with Screen do begin
    for i:=0 to FormCount-1 do begin
      if not ({(CustomForms[i].Name='ToolsForm') or}
        (Forms[i].Name='FormStart') or (Forms[i].Name='ppDesignerWindow') or
        (Forms[i].Name='DialParamPayDoc')) then begin
        // Снимаем запросы, если они установлены перед закрытием форм
        // Есть пока проблемы с запросами, где используется контекстный поиск ~
        // При минимизации проекта и последующей активации некорректно обрабатываются
        // соответствующие DataSet'ы
        if (Forms[i] is TBEForm) and Assigned(TDBFormControl(TBEForm(Forms[i]).FormControl).CurrentInquiryItem) then
        with TDBFormControl(TBEForm(Forms[i]).FormControl) do begin
          PlayInquiry(nil);
          FormTools.ChangeHint(btSumUp, '') // Кнопку Суммирования отжимаем
        end;  
        // Отключаем мерзкие деревья
        if ((Forms[i].Name='FormMat') or (Forms[i].Name='FormProd')) then begin
          Forms[i].Tag:=1;
          Forms[i].Close;
          {Forms[i].Tag:=0;}
        end else Forms[i].Close;

      end;
    end;
  end;
  { Закрываем DataSet'ы }
  with KSMDataBase do begin
    i:=DataSetCount-1;
    j:=0;
    repeat
      if not ((DataSets[i].Name='UsersDeclar') or
      (DataSets[i].Name='WorkersLookup') or (DataSets[i].Name='ConfigDeclar') or
      (DataSets[i].Name='Declars') or (DataSets[i].Name='OrgBankLookup1')) then begin
        {DataSets[i].DisableControls;}
        DataSets[i].Close;
        Dec(i);
      end else Dec(i);
    until i=0;
  end;
  Application.Minimize;
end;

procedure TModuleBase.AppControlIdle(Sender: TObject; var Done: Boolean);
var i: integer;
begin
  if Assigned(FormStart) and Application.Active then begin
    Timer.Enabled:=true;
    if UserName='LEV' then begin
      FormStart.Idle.Caption:=IntToStr(aIdle);
    end;
  end;
end;

procedure TModuleBase.AppControlMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if (Msg.Message=WM_MouseMove) or (Msg.Message=WM_KeyDown) then begin
    aIdle:=0;
    Timer.Enabled:=false;
  end;
end;

procedure TModuleBase.TimerTimer(Sender: TObject);
begin
  Inc(aIdle);
  if aIdle>720 then begin
    try
      Application.Restore;
      FormStart.SetFocus;
      CloseActiveTablesClick(nil);
      Timer.Enabled:=false;
      {Application.Minimize;}
    finally
      aIdle:=0;
    end;
  end;
end;

procedure TModuleBase.ConfigDeclarReportPeriodValidate(Sender: TField);
begin
  { Проверка, чтобы число всегда было "01"}
  if Copy(DateToStr(ConfigDeclarReportPeriod.AsDateTime),1,2)<>'01' then begin
    ShowMessage('Число у отчетного периода всегда должно быть "01"!!!');
    SysUtils.Abort;
  end;
  { Проверка, чтобы отчетный период был не менее "01.11.00"}
  if ConfigDeclarReportPeriod.AsDateTime<StrToDate('01.11.2000') then begin
    ShowMessage('Отчетный период не может быть ранее "01.11.2000"!!!');
    SysUtils.Abort;
  end;
end;

{ Для показа пользователю только нужных отделов для задачи "Учет материалов"}
function TModuleBase.SectionNameFilter(Sender: TObject): String;
begin
  {       Отдел гл. механика   Отдел кап. стр-ва   Отдел снабжения   Отдел гл. энергетика }
  Result:='(Section=250500) or (Section=250600) or (Section=251500) or (Section=251600) or (Section=252000)';
end;

procedure TModuleBase.FormNotSupportedClick(Sender: TObject);
begin
  if UserName<>'Admin' then begin
    ShowMessage('Справочник работающих больше не поддерживается'+#13+
                'См. форму "Кадры" и "Отчеты по работникам"'+#13+
                'По техническим вопросам обращайтесь в отдел ИАП'+#13+
                'По наличию информации - в отдел кадров');
    SysUtils.Abort;
  end;
end;

procedure TModuleBase.UsersDeclarCalcFields(DataSet: TDataSet);
begin
  UsersDeclarMemberOfGroups.Value:=GetFromSQLText(KsmDataBase.DataBaseName,
    'select FMemberOfGroups('''+UsersDeclarName.AsString+''')',false)
end;

Initialization
  { Если надо отловить Access Violation, то надо поставить эту переменную в True }
  { Эта переменная живет в XMisc и в обычном режиме закомментарена               }
  {CaptureErrorMode:=false;}
end.
