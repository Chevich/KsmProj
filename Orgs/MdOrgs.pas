Unit MdOrgs;

Interface

Uses
  Forms, Db, EtvDB, XTFC, DBTables, LnTables, Menus, Classes,
  XMisc, EtvTable, XEFields, XDBTFC, LnkSet, Graphics, Windows, EtvList,
  EtvLook;

type
  TModuleOrgs = class(TDataModule)
    Popup: TControlMenu;
    TOrgC: TDBFormControl;
    GrOrgC: TDBFormControl;
    GrOrg: TLinkSource;
    GrOrgDeclar: TLinkTable;
    TOrg: TLinkSource;
    TOrgDeclar: TLinkTable;
    OrgBank: TLinkSource;
    OrgBankDeclar: TLinkTable;
    Org: TLinkSource;
    OrgDeclar: TLinkTable;
    OrgLookup: TLinkTable;
    GrOrgDeclarKod: TSmallintField;
    GrOrgDeclarName: TStringField;
    TOrgDeclarKod: TSmallintField;
    TOrgDeclarName: TStringField;
    OrgDeclarKod: TIntegerField;
    OrgDeclarFullName: TStringField;
    OrgDeclarTActivity: TSmallintField;
    OrgDeclarCountry: TSmallintField;
    OrgDeclarPlace: TIntegerField;
    OrgDeclarPIndex: TIntegerField;
    OrgDeclarAddress: TStringField;
    OrgDeclarPhones: TStringField;
    OrgDeclarFax: TStringField;
    OrgDeclarTeleType: TStringField;
    OrgDeclarEMail: TStringField;
    OrgDeclarTOrg: TSmallintField;
    OrgDeclarDateCheck: TDateField;
    OrgDeclarSGroup: TSmallintField;
    OrgDeclarINN: TStringField;
    OrgDeclarTActivityName: TXELookField;
    OrgDeclarRezident: TXEListField;
    OrgDeclarPrCustomer: TXEListField;
    OrgDeclarPrSupplier: TXEListField;
    OrgBankD: TLinkSource;
    OrgBankDetailDeclar: TLinkTable;
    OrgBankDeclarIntegerField: TIntegerField;
    OrgBankDeclarKodBN: TStringField;
    OrgBankDeclarStringField: TStringField;
    OrgBankDeclarSmallintField2: TSmallintField;
    GrOrgLookupSmallintField: TSmallintField;
    GrOrgLookupStringField: TStringField;
    GrOrgLookup: TLinkQuery;
    TOrgLookupSmallintField: TSmallintField;
    TOrgLookupStringField: TStringField;
    TOrgLookup: TLinkQuery;
    OrgDeclarTOrgName: TXELookField;
    OrgDeclarSGroupName: TXELookField;
    OrgDeclarPlaceName: TXELookField;
    OrgC: TDBFormControl;
    OrgBankC: TDBFormControl;
    OrgBankDeclarAutoInc: TAutoIncField;
    OrgLookupKod: TIntegerField;
    OrgBankDetailDeclarOrg: TIntegerField;
    OrgBankDetailDeclarAutoInc: TAutoIncField;
    OrgBankDetailDeclarKodBn: TStringField;
    OrgBankDetailDeclarBCount: TStringField;
    OrgBankDetailDeclarTCount: TSmallintField;
    OrgBankDetailDeclarBankName: TXELookField;
    OrgBankDeclarOrgName: TXELookField;
    OrgBankDeclarKodOtd: TSmallintField;
    OrgBankDetailDeclarKodOtd: TSmallintField;
    OrgLookupINN: TStringField;
    OrgDeclarOKPO: TStringField;
    OrgBankDetailDeclarDateEnd: TDateField;
    OrgBankDeclarDateEnd: TDateField;
    OrgLookupOKPO: TStringField;
    OrgDeclarStation: TStringField;
    OrgDeclarOrgStation: TStringField;
    OrgDeclarStationName: TXELookField;
    OrgLookupAddress: TStringField;
    OrgLookupStation: TStringField;
    OrgLookupOrgStation: TStringField;
    OrgLookupFullName: TStringField;
    OrgDeclarName: TStringField;
    OrgDeclarRailBranch: TSmallintField;
    OrgDeclarRailBranchName: TXELookField;
    OrgBankD1: TLinkSubSource;
    OrgBankDDeclar: TLinkTable;
    OrgBankDDeclarAutoInc: TAutoIncField;
    OrgBankDDeclarOrg: TIntegerField;
    OrgBankDDeclarKodBn: TStringField;
    OrgBankDDeclarBankName: TXELookField;
    OrgBankDDeclarBCount: TStringField;
    OrgBankDDeclarTCount: TSmallintField;
    OrgBankDDeclarKodOtd: TSmallintField;
    OrgBankDDeclarDateEnd: TDateField;
    OrgLookupCountry: TSmallintField;
    OrgLookupRailBranch: TSmallintField;
    OrgBankLookup: TLinkTable;
    OrgBankLookup1: TLinkTable;
    OrgBankLookupAutoInc: TAutoIncField;
    OrgBankLookupOrg: TIntegerField;
    OrgBankLookupKodBn: TStringField;
    OrgBankLookupBCount: TStringField;
    OrgBankLookupBankName: TStringField;
    OrgBankLookupPlaceName: TStringField;
    OrgBankLookupDateEnd: TDateField;
    OrgDeclarChecked: TXEListField;
    OrgDeclarTimeCalcBalance: TDateTimeField;
    OrgBankDetailDeclarsUser: TStringField;
    OrgBankDetailDeclarsTime: TDateTimeField;
    OrgDeclarsUser: TStringField;
    OrgDeclarsTime: TDateTimeField;
    OrgP1: TProcSubSource;
    OrgProcess: TLinkTable;
    OrgProcessKod: TIntegerField;
    OrgBankLookup1AutoInc: TIntegerField;
    OrgBankLookup1Org: TIntegerField;
    OrgBankLookup1BCount: TStringField;
    OrgBankLookup1DateEnd: TDateField;
    OrgBankLookup1OrgName: TStringField;
    OrgBankLookup1KodBn: TSmallintField;
    OrgBankDeclarCountName: TStringField;
    OrgBankDetailDeclarCountName: TStringField;
    OrgLookupsGroup: TSmallintField;
    TActivity1: TLinkMenuItem;
    OrgLookupRezident: TSmallintField;
    OrgDeclarLicence: TStringField;
    OrgLookupLicence: TStringField;
    Businessman: TLinkSource;
    BusinessmanDeclar: TLinkTable;
    BusinessmanDeclarKod: TIntegerField;
    BusinessmanDeclarFam: TStringField;
    BusinessmanDeclarIm: TStringField;
    BusinessmanDeclarOtch: TStringField;
    BusinessmanDeclarAddress: TStringField;
    BusinessmanDeclarINN: TStringField;
    BusinessmanDeclarPIndex: TIntegerField;
    BusinessmanDeclarSeries: TStringField;
    BusinessmanDeclarPassport: TStringField;
    BusinessmanDeclarDatePassport: TDateField;
    BusinessmanC: TDBFormControl;
    BusinessmanDeclarLicence: TStringField;
    BusinessmanDeclarDateLicence: TDateField;
    BusinessmanDeclarOrgan: TStringField;
    BusinessmanDeclarKodName: TXELookField;
    OrgBankLookupAddress: TStringField;
    OrgProcessFullName: TStringField;
    OrgProcessINN: TStringField;
    OrgProcessCountry: TSmallintField;
    OrgProcessOKPO: TStringField;
    OrgProcessAddress: TStringField;
    OrgProcessStation: TStringField;
    OrgProcessOrgStation: TStringField;
    OrgProcessRailBranch: TSmallintField;
    OrgProcesssGroup: TSmallintField;
    OrgProcessRezident: TSmallintField;
    OrgProcessLicence: TStringField;
    OrgLookupName: TStringField;
    OrgBankP1: TProcSubSource;
    OrgBankProcess: TLinkTable;
    OrgBankProcessOrg: TIntegerField;
    OrgBankProcessKodBn: TStringField;
    OrgBankProcessBankName: TStringField;
    OrgBankProcessPlaceName: TStringField;
    OrgBankProcessBCount: TStringField;
    OrgBankProcessDateEnd: TDateField;
    OrgBankProcessAddress: TStringField;
    OrgBankProcessAutoInc: TIntegerField;
    ClientPlan: TLinkSource;
    ClientPlanDeclar: TLinkTable;
    ClientPlanDeclarClient: TIntegerField;
    ClientPlanDeclarPeriod: TDateField;
    ClientPlanDeclarProd: TIntegerField;
    ClientPlanDeclarPlan: TIntegerField;
    ClientPlanDeclarOrgName: TXELookField;
    ClientPlanDeclarProdName: TXELookField;
    ClientPlanC: TDBFormControl;
    PlanClient1: TLinkMenuItem;
    OrgBankLookupTCount: TSmallintField;
    OrgBankDeclarBankName2: TXELookField;
    OrgLookupPindex: TIntegerField;
    OrgDeclarLastDateInvoice: TDateField;
    OrgDeclarLastDatePay: TDateField;
    OrgLookupLastDateInvoice: TDateField;
    OrgLookupLastDatePay: TDateField;
    OrgLookupTimeCalcBalance: TDateTimeField;
    OrgDeclarTOwnerShip: TXEListField;
    OrgLookupTActivity: TSmallintField;
    OrgDeclarCountryName: TXELookField;
    OrgBankLookupRKC: TStringField;
    OrgBankDeclarCBS: TSmallintField;
    OrgBankLookupCBS: TSmallintField;
    OrgBankDetailDeclarCBS: TSmallintField;
    OrgBankLookupID: TIntegerField;
    OrgBankDeclarID: TIntegerField;
    OrgBankDetailDeclarID: TIntegerField;
    OrgBankDDeclarID: TIntegerField;
    OrgBankDDeclarCBS: TSmallintField;
    OrgBankProcessID: TIntegerField;
    OrgBankProcessCBS: TSmallintField;
    OrgBankLookupBankID: TIntegerField;
    OrgLSource: TProcSubSource;
    procedure ContractDeclarAfterPost(DataSet: TDataSet);
    procedure OrgSumma1Click(Sender: TObject);
    procedure ModuleOrgsCreate(Sender: TObject);
    { Написал общий обработчик 10.12.2003 в модуле TLnTable }
    {procedure OrgDeclarFullNameSetText(Sender: TField; const Text: String);}
    procedure OrgDeclarBeforePost(DataSet: TDataSet);
    procedure OrgDeclarAfterPost(DataSet: TDataSet);
    procedure OrgDeclarNameChange(Sender: TField);
    procedure OrgDeclarNewRecord(DataSet: TDataSet);
    procedure OrgCCreateForm(Sender: TObject);
    procedure OrgDeclarCheckedValidate(Sender: TField);
    procedure OrgBankDetailDeclarAfterPost(DataSet: TDataSet);
    (*procedure AutoIncBeforePost(DataSet: TDataSet);*)
    procedure CheckDuplicationKod;
    procedure OrgDeclarKodValidate(Sender: TField);
    procedure OrgLookupCalcFields(DataSet: TDataSet);
    procedure OrgBankLookupCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    {Procedure NewBankProperty(aKodBn,aBCount:string;aDialog:boolean);}
    Function NewBankProperty(aKodBn,aBCount:string;aDialog:boolean):boolean;
    { Последне время расчета баланса по клиенту aClient }
    Function GetClientTimeCalcBalance(aClient: integer):variant;
    { Public declarations }
  end;

var ModuleOrgs: TModuleOrgs;

Implementation

uses MdCommon, MdGeography, MdProd, EtvPas, Dialogs, SysUtils, EtvDBFun, MdBase, DlgClient,
     BEForms, EtvTemp,MdClientsAdd, Orgs;
var  ClientChanged:boolean;
{
uses KMd, ProdMd, BForms;
 }
{$R *.DFM}

Function TModuleOrgs.GetClientTimeCalcBalance(aClient: integer):variant;
begin
  Result:=GetFromSQLText(OrgDeclar.DataBaseName,
    'select TimeCalcBalance from STA.Org where Kod='+IntToStr(aClient),false);
  if Result=null then Result:=0;
end;

Procedure TModuleOrgs.ContractDeclarAfterPost(DataSet: TDataSet);
begin
{  ContractDeclar.Refresh}
end;
(*
procedure TOrgMod.AutoIncBeforePost(DataSet: TDataSet);
var Field:TField;
begin
  if DataSet.State=dsInsert then
    with AutoIncQuery do begin
      SQL.Add('select max(AutoInc) as MaxNum from '+TTable(DataSet).TableName);
      Open;
      Field:=DataSet.FieldByName('AutoInc');
      if Field.ReadOnly then begin
        Field.ReadOnly:=False;
        Field.Value:=MaxNum.Value+1;
        Field.ReadOnly:=True;
      end else Field.Value:=MaxNum.Value+1;
      Close;
      SQL.Clear;
    end;
end;
*)

Procedure TModuleOrgs.OrgSumma1Click(Sender: TObject);
begin
  if CreateEtvProcess('command.com /c copy \\server_gksm\xchange\odbctext\org.txt c:\temp\org.',
    'Копирование ORG.TXT на локальную машину',true,true)<>0 then begin
    ShowMessage('Неудачное копирование файла ORG.TXT'+#13+
                'Обратитесь к разработчикам.');
    Abort;
  end;
end;

Procedure TModuleOrgs.ModuleOrgsCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  { Откроем, чтобы потом не мучаться }
  {OrgBankLookUp1.Open;}
end;

{
Procedure TModuleOrgs.OrgDeclarFullNameSetText(Sender: TField; const Text: String);
begin
  if (Sender.Name='OrgDeclarFullName') or (Sender.Name='OrgDeclarAddress') then
    TStringField(Sender).Value:=Trim(Text);
end;
}
(*
procedure TModuleOrgs.NewBankProperty(aKodBn,aBCount:string;aDialog:boolean);
var lClient:integer;
    ClientExist:boolean;
begin
  if Not OrgBankLookup.Locate('KodBn;BCount;DateEnd',
     VarArrayOf([aKodBn,aBCount,null]),[]) then begin
    ClientExist:=false;
    if aDialog then with DlgClientF do begin
      {А может у тебя уже есть диалог про клиента?}
      ShowModal;
      if (ModalResult in [idOk,idYes]) then begin
        if ClientLookUp.KeyValue=Null then lClient:=-1
        else begin
          lClient:=ClientLookUp.KeyValue;
          ClientExist:=true;
        end;
      end;
      {Exit;}
    end;
    {OrgC.Show;}
    if not OrgDeclar.Active then OrgDeclar.Open;
    ModuleBase.KSMDatabase.StartTransaction;
    try try
      if ClientExist then begin
        if Not OrgDeclar.Locate('Kod',lClient,[]) then begin
          ShowMessage('Клиент не найден');
          Exit;
        end;
      end else with OrgDeclar do begin
        DisableControls;
        Insert;
        FieldByName('Kod').Value:=
          GetDBValue(OrgDeclar.DataBaseName,'select IsNull(Max(kod),0)+1 from sta.Org');
        FieldByName('Name').Value:='Наименование клиента не определено';
        Post;
      end;
      with OrgBankDeclar do begin
        DisableControls;
        if not Active then Open;
        Insert;
        FieldByName('Org').Value:=OrgDeclarKod.Value;
        FieldByName('KodBn').Value:=aKodBn;
        FieldByName('BCount').Value:=aBCount;
        Post;
      end;
      ModuleBase.KSMDatabase.Commit;
    except
      ModuleBase.KSMDatabase.RollBack;
      raise
    end;
    finally
      OrgDeclar.EnableControls;
      OrgBankDeclar.EnableControls;
    end;
    OrgC.Execute;
  end else ShowMessage('Счет уже существует'+#13#10+
                       'Код клиента '+OrgBankLookupOrg.AsString);
end;
*)

Function TModuleOrgs.NewBankProperty(aKodBn,aBCount:string;aDialog:boolean):boolean;
var lClient:Variant;
    lClientStr:string[6];
begin
  Result:=false;
  if aDialog then begin
    DlgClientF:=TDlgClientF.Create(nil);
    with DlgClientF do
    try
      ShowModal;
      if (ModalResult in [idOk,idYes]) then begin
        lClient:=ClientLookUp.KeyValue
      end else Exit;
    finally
      DlgClientF.Free;
    end;
  end;
  if lClient=Null then lClientStr:='NULL'
  else lClientStr:=IntToStr(lClient);
  lClient:=
    GetFromSQLText(OrgDeclar.DataBaseName,
    'Call STA.AddClientBankProperty('+''''+aKodBn+''''+','+''''+aBCount+''''+
    ','+lClientStr+')',false);
  if lClient<>null then with OrgDeclar do begin
    DisableControls;
    if not Active then Open else Refresh;
    OrgDeclar.Locate('Kod',lClient,[]);
    EnableControls;
    Result:=true;
    {OrgC.Execute;}
  end;
end;

Procedure TModuleOrgs.OrgDeclarBeforePost(DataSet: TDataSet);
var aValue: variant;
begin
  ClientChanged:=false;
  if (OrgDeclar.State=dsInsert) and (OrgDeclarAddress.IsNull or (OrgDeclarAddress.AsString='')) then begin
    ShowMessage('Поле "Адрес" должно быть заполнено');
    Abort;
  end;
  // Проверка на дублирование кодов УНН
  aValue:=GetFromSQLText(OrgDeclar.DataBaseName,'select Min(Kod) from STA.Org where (INN='''+
    OrgDeclarINN.AsString+''') and (Kod<>'+OrgDeclarKod.AsString+')',false);
  if aValue<>null then
    if MessageDlg('ВНИМАНИЕ!!! ДУБЛИРОВАНИЕ КОДОВ УНН!!! '#13+
      'У клиента с кодом '+IntToStr(aValue)+' такой же УНН '+OrgDeclarINN.AsString+#13+
      'ВЫ УВЕРЕНЫ, ЧТО ХОТИТЕ СОХРАНИТЬ ДАННУЮ ИНФОРМАЦИЮ?',
      mtWarning,[mbYes, mbNo],0)<>idYes then Abort;

  if OrgDeclar.State=dsInsert then Exit;
  if (OrgDeclar.State=dsEdit) then begin
    { Контроль за изменением кода "Частного лица" }
    if ((OrgDeclar.OldEditValues[OrgDeclarKod.Index]=0) or
    (OrgDeclar.OldEditValues[OrgDeclarKod.Index]=300016) or
    (OrgDeclar.OldEditValues[OrgDeclarKod.Index]=900000)) and OrgDeclar.Modified then begin
      ShowMessage('Нельзя изменять значения данной записи');
      Abort;
    end;
    if (OrgDeclarKod.Value<>OrgDeclar.OldEditValues[OrgDeclarKod.Index]) then
      ClientChanged:=true;
    { Контроль за изменением  полей записи финансовым отделом }
(*
    with ModuleBase do
      if (UserName='FIN') and (OrgDeclarChecked.Value=1) then begin
        ShowMessage('Не имеете права редактировать эту запись');
        Abort
      end;
*)
  end;
end;

Procedure TModuleOrgs.OrgDeclarAfterPost(DataSet: TDataSet);
begin
  if ClientChanged then OrgBankDetailDeclar.Refresh;
  OrgDeclar.Refresh;
end;

Procedure TModuleOrgs.OrgDeclarNameChange(Sender: TField);
begin
  if OrgDeclarFullName.Value='' then
    OrgDeclarFullName.Value:=OrgDeclarName.Value;
end;

Procedure TModuleOrgs.OrgDeclarNewRecord(DataSet: TDataSet);
begin
  with ModuleBase do begin
    if (UserName='FIN') then begin
      OrgDeclarPrSupplier.Value:=0;
      {OrgDeclarChecked.Value:=0;}
    end;
    if (UserName='FSGT') or (UserName='FSGL') then begin
      {OrgDeclarPrCustomer.Value:=0;}
      OrgDeclarChecked.Value:=1;
    end;
    if (UserName='FSGT') or (UserName='FSGL') then OrgDeclarPrCustomer.Value:=0;
  end;
end;

Procedure TModuleOrgs.OrgCCreateForm(Sender: TObject);
begin
  with ModuleBase do
    if (UserName='FSGL') or (UserName='FSGT') or IsProgrammers then
      OrgDeclarChecked.ReadOnly:=false;

  with TFormOrgs(OrgC.Form) do begin
    PageControl1.ActivePage:=FormSheet;
    ActiveControl:=EditKodOrg;
  end;
end;

Procedure TModuleOrgs.OrgDeclarCheckedValidate(Sender: TField);
begin
  if OrgDeclarChecked.Value=0 then begin
    ShowMessage('Не имеете права изменять значение поля Checked');
    Abort;
  end;
end;

Procedure TModuleOrgs.OrgBankDetailDeclarAfterPost(DataSet: TDataSet);
begin
  OrgBankDetailDeclar.Refresh;
end;

{ Контроль на дублирование № накладной+Дата выписки документа }
Procedure TModuleOrgs.CheckDuplicationKod;
begin
  if not OrgProcess.Active then OrgProcess.Open;
  if OrgProcess.Locate('Kod',OrgDeclarKod.Value,[]) then begin
    MessageDlg('Поле: '+OrgDeclarKod.DisplayLabel+' '+OrgDeclarKod.AsString+#13+
     'Дублирование значений',mtWarning,[mbOk],0);
    Abort;
  end;
end;

Procedure TModuleOrgs.OrgDeclarKodValidate(Sender: TField);
begin
  if (Sender=OrgDeclarKod) and (OrgDeclar.State in [dsInsert,dsEdit]) then begin
    CheckDuplicationKod;
    if Length(OrgDeclarKod.AsString)>6 then begin
      MessageDlg('Поле: '+OrgDeclarKod.DisplayLabel+' '+OrgDeclarKod.AsString+#13+
       'Длина поля больше 6 !!!',mtWarning,[mbOk],0);
      Abort;
    end;
  end;
end;

procedure TModuleOrgs.OrgLookupCalcFields(DataSet: TDataSet);
begin
  if not OrgProcess.Active then OrgProcess.Open;
  if OrgProcess.Locate('Kod',OrgLookupKod.Value,[]) then begin
    OrgLookupFullName.AsString:=OrgProcessFullName.AsString;
    OrgLookupINN.AsString:=OrgProcessINN.AsString;
    OrgLookupCountry.AsInteger:=OrgProcessCountry.AsInteger;
    OrgLookupOKPO.AsString:=OrgProcessOKPO.AsString;
    OrgLookupAddress.AsString:=OrgProcessAddress.AsString;
    OrgLookupStation.AsString:=OrgProcessStation.AsString;
    OrgLookupOrgStation.AsString:=OrgProcessOrgStation.AsString;
    OrgLookupRailBranch.AsInteger:=OrgProcessRailBranch.AsInteger;
    OrgLookupsGroup.AsInteger:=OrgProcesssGroup.AsInteger;
    OrgLookupRezident.AsInteger:=OrgProcessRezident.AsInteger;
    OrgLookupLicence.AsString:=OrgProcessLicence.AsString;
  end;
end;

Procedure TModuleOrgs.OrgBankLookupCalcFields(DataSet: TDataSet);
begin
  if not OrgBankProcess.Active then OrgBankProcess.Open;
  if OrgBankProcess.Locate('Org;AutoInc',VarArrayOf([OrgBankLookupOrg.AsInteger,OrgBankLookupAutoInc.AsInteger]),[]) then begin
    OrgBankLookupKodBn.AsString:=OrgBankProcessKodBn.AsString;
    OrgBankLookupBankName.AsString:=OrgBankProcessBankName.AsString;
    OrgBankLookupPlaceName.AsString:=OrgBankProcessPlaceName.AsString;
    {OrgBankLookupBCount.AsString:=OrgBankProcessBCount.AsString;}
    OrgBankLookupDateEnd.AsDateTime:=OrgBankProcessDateEnd.AsDateTime;
    OrgBankLookupAddress.AsString:=OrgBankProcessAddress.AsString;
  end;
end;

end.
