unit SForm; {}

interface

uses
  XSBForm, Menus, XTFC, Dialogs, Controls, ComCtrls,
  ToolWin, StdCtrls, Mask, ToolEdit, XCtrls, RXCtrls, Buttons,
  Classes, ExtCtrls, XMisc, RXDBCtrl, EtvContr, XECtrls, DBCtrls,
  XDBForms, EtvRXCtl, ImgList, EtvPages;

type
  TFormStart = class(TXSDBForm)
    StaticText1: TStaticText;
    EditCurMonth: TXEDBDateEdit;
    DBNavigator1: TDBNavigator;
    ShopButton: TToolButton;
    sprMatBtn: TToolButton;
    BuhAccBtn: TToolButton;
    Idle: TXLabel;
    PersonBtn: TToolButton;
    ReviseBtn: TToolButton;
    ClentReportBtn: TToolButton;
    ClientBuildingGrodnoBtn: TToolButton;
    CommodityOutputBtn: TToolButton;
    WorkersVVBtn: TToolButton;
    MoneyUseVBtn: TToolButton;
    FactureBtn: TToolButton;
    WorkTimeButton: TToolButton;
    WorkTimeReportButton: TToolButton;
    SumBalanceButton: TToolButton;
    ProdRequestForShopButton: TToolButton;
    JobHiProtocolButton: TToolButton;
    ICTabSheet: TEtvTabSheet;
    ICToolBar: TToolBar;
    ICProdLimeUpdateButton: TToolButton;
    ICProdLimeButton: TToolButton;
    ICProdLimeHour2Button: TToolButton;
    ICProdLimeProtocolsButton: TToolButton;
    ICGasForLimeButton: TToolButton;
    ICProdLimeParametersButton: TToolButton;
    WProfAddVBtn: TToolButton;
    ToolButton1: TToolButton;
    procedure ServisBtnClick(Sender: TObject);
    procedure CurrDateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ProdBtnClick(Sender: TObject);
    procedure MatBtnClick(Sender: TObject);
    procedure OrgBtnClick(Sender: TObject);
    procedure ContrBtnClick(Sender: TObject);
    procedure PayBtnClick(Sender: TObject);
    procedure InvcBtnClick(Sender: TObject);
    procedure ShopBtnClick(Sender: TObject);
    procedure SectionBtnClick(Sender: TObject);
    procedure BankBtnClick(Sender: TObject);
    procedure AboutBtnClick(Sender: TObject);
    procedure MainDateAcceptDate(Sender: TObject; var Date: TDateTime;
      var Action: Boolean);
    procedure MainDateExit(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure StatBtnClick(Sender: TObject);
    procedure ShopButtonClick(Sender: TObject);
    procedure SprMatBtnClick(Sender: TObject);
    procedure BuhAccBtnClick(Sender: TObject);
    procedure PersonBtnClick(Sender: TObject);
    procedure ReviseBtnClick(Sender: TObject);
    procedure ClientBuildingGrodnoBtnClick(Sender: TObject);
    procedure CommodityOutputBtnClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure WorkersVVBtnClick(Sender: TObject);
    procedure MoneyUseVBtnClick(Sender: TObject);
    procedure FactureBtnClick(Sender: TObject);
    procedure WorkTimeButtonClick(Sender: TObject);
    procedure WorkTimeReportButtonClick(Sender: TObject);
    procedure SumBalanceButtonClick(Sender: TObject);
    procedure TuningSystemClick(Sender: TObject);
    procedure ProdRequestForShopButtonClick(Sender: TObject);
    procedure JobHiProtocolButtonClick(Sender: TObject);
    procedure ICProdLimeUpdateButtonClick(Sender: TObject);
    procedure ICProdLimeButtonClick(Sender: TObject);
    procedure ICProdLimeHour2ButtonClick(Sender: TObject);
    procedure ICProdLimeHour1ButtonClick(Sender: TObject);
    procedure ICProdLimeProtocolsButtonClick(Sender: TObject);
    procedure ICGasForLimeButtonClick(Sender: TObject);
    procedure ICProdLimeParametersButtonClick(Sender: TObject);
    procedure WProfAddVBtnClick(Sender: TObject);
  end;

var FormStart: TFormStart;

implementation

Uses Messages, Windows, DB, SysUtils, Forms, MdBase, MdProd, MdContr, MdPays, MdInvc,
     MdCommon, Registry, XApps, MdClientsAdd, MdOrgs, MdShop, mdMaterials,
     MdWorkers;

{$R *.DFM}

procedure TFormStart.ServisBtnClick(Sender: TObject);
begin
  inherited;
{ USetupForm.ShowModal;}
end;

procedure TFormStart.CurrDateBtnClick(Sender: TObject);
begin
  inherited;
  if not ((UserName='LEV') or (UserName='BAUSHA') or (UserName='SERGM') or
  (UserName='ALEK') or (UserName='ADMIN')) then Exit;
  with ModuleWorkers do begin
    {if UserName<>'LEV' then JobDeclar.ReadOnly:=true;}
    JobC.Execute;
  end;
end;

procedure TFormStart.FormCreate(Sender: TObject);
var Str:String;
    hBtn : HWND;
begin
  if Application.Terminated then Exit;
  inherited;
  //WProfAddVBtn.Caption:=' 1 '+#10#13+' 2 '; Неудачные пока попытки сделать Caption в ToolButton'е в 2 строки 
  //hBtn := GetDlgItem(Self.Handle, WProfAddVBtn.ComponentIndex);
  //SendMessage(hBtn, BM_SETSTYLE, BS_MULTILINE, 0);

  ClientHeight := 101; //aleksm
  FormControl:=ModuleBase.UsersC;
  MainDate.Date:=Date;
  if Copy(MainDate.Text,4,5)<>Copy(EditCurMonth.Text,4,5) then
    MainDate.Date:=EditCurMonth.Date;
{  with ModuleBase.UsersDeclar do begin
    Open;
    if Not FindKey([ModuleBase.KSMDataBase.UserName]) then begin
       ShowMessage('Пользователь '+ModuleBase.KSMDataBase.UserName+
          ' не зарегистрирован на сервере. Обратитесь к администратору баз данных!');
       Application.Terminate;
       end;
  end;}
{
  R:=TRegistry.Create;
  R.RootKey:=HKEY_CURRENT_CONFIG;
  R.OpenKey('Display\Settings', False); //если flase то пытается откpыть не создавая
  Str:=R.ReadString('BitsPerPixel');
}
(*
  { Установка текущего периода для итема меню по расчету баланса по клиентам }
  Str:='Расчет баланса за текущий период '+Copy(CurPeriod,4,5);
  ModuleClientsAdd.InvoicePayCalculatedItem.Caption:=Str;
  MainMenu1.Items[6].Items[6].Caption:=Str;
*)
  { Инициализация имени пользователя на главной форме }
  with ModuleBase do begin
    UsersDeclar.DisableControls;
    UsersDeclar.Close;
    with UsersDeclarFIO do begin
      FieldKind:=fkLookUp;
      LookupDataSet:=ModuleWorkers.WorkersVVLookUp;
    end;
    UsersDeclar.Open;
    UsersDeclar.OnCalcFields:=UsersDeclarCalcFields;
    UsersDeclar.Locate('Name',UserName,[]);
    UsersDeclar.EnableControls;
  end;
  { Некоторые итемы из менюшек некоторым юзерам недоступны... }
  { Отчет по контрактам }
  if (UserName='LEV') or (UserName='VERBICKIJ') or (UserName='FSGL') or (UserName='FSGT') or (UserName='SALECHIEF')
  or (UserName='COMDIV') then
    MainMenu1.Items[6].Items[11].Visible:=true;
  { Отчеты по материалам MInvoiceV}
  if (UserName='LEV') or (UserName='ADMIN') or (UserName='ANDY') then MainMenu1.Items[5].Items[5].Visible:=true;
  { История запросов }
  if (UserName='LEV') or (UserName='ANDY') then MainMenu1.Items[9].Items[8].Visible:=true;
  { Поручения директора }
  if (UserName='LEV') or (UserName='ИННА') or (UserName='LEO') then begin
     MainMenu1.Items[1].Items[7].Visible:=true;
     JobHiProtocolButton.Visible:=true;
  end;
  { Вкладка на панели кнопочек "Промконтроль" }
  if not UserInGroup('ICAccess') then ICTabSheet.TabVisible:=false;

  { Если пользователь - Лев, то таймер - визибле }
  if UserName='LEV' then Idle.Visible:=true;
  if UserName='FIN' then XDBLabel1.Caption:='Финансовый отдел';
end;

procedure TFormStart.ProdBtnClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ProdC.Execute;
end;

procedure TFormStart.MatBtnClick(Sender: TObject);
begin
  inherited;
  MdMat.MInvoiceC.Execute;
end;

procedure TFormStart.OrgBtnClick(Sender: TObject);
begin
  inherited;
  ModuleOrgs.OrgC.Execute;
end;

procedure TFormStart.ContrBtnClick(Sender: TObject);
begin
  inherited;
  ModuleContract.ContractC.Execute;
end;

procedure TFormStart.PayBtnClick(Sender: TObject);
begin
  inherited;
  ModulePays.PayDocC.Execute;
end;

procedure TFormStart.InvcBtnClick(Sender: TObject);
begin
  inherited;
  ModuleInvoice.InvoiceC.Execute;
end;

procedure TFormStart.ShopBtnClick(Sender: TObject);
begin
  inherited;
  ModuleBase.ShopC.Execute;
end;

procedure TFormStart.SectionBtnClick(Sender: TObject);
begin
  inherited;
  ModuleBase.SectionC.Execute;
end;

procedure TFormStart.BankBtnClick(Sender: TObject);
begin
  inherited;
  ModuleCommon.BankC.Execute;
end;

procedure TFormStart.AboutBtnClick(Sender: TObject);
begin
  inherited;
  ModuleBase.KSMTools.InformExecute;
end;

procedure TFormStart.MainDateAcceptDate(Sender: TObject;
  var Date: TDateTime; var Action: Boolean);
begin
  inherited;
  if Copy(DateToStr(Date),4,5)<>Copy(EditCurMonth.Text,4,5) then
    {MainDate.Date:=EditCurMonth.Date;}
    Action:=false;
end;

procedure TFormStart.MainDateExit(Sender: TObject);
begin
  inherited;
  if Copy(MainDate.Text,4,5)<>Copy(EditCurMonth.Text,4,5) then begin
    ShowMessage('Недопустимая дата. Присваивается дата'+#13+
                '          '+EditCurMonth.Text);
    MainDate.Date:=EditCurMonth.Date;
  end;
end;

procedure TFormStart.FormDeactivate(Sender: TObject);
begin
  inherited;
  MainDateExit(Sender);
end;

{ При переносе FormControl'ей с LinkSourc'ами в другие DataModul'и при наличии }
{ запросов необходима корректировка Inquiries[i].Source, i=0,...,Inquiries.Count-1 }
Procedure ChangeInquiresSources;
begin
(*
  with ModuleOrgs.OrgSummaC do begin
    Inquiries[0].Source:=ModuleClientsAdd.OrgSumma;
    Inquiries[1].Source:=ModuleClientsAdd.OrgSumma;
  end;
  with ModuleClientsAdd.OrgSummaC do begin
    Inquiries.Assign(ModuleOrgs.OrgSummaC.Inquiries);
    WriteUserData(Inquiries, Reports);
  end;
*)
end;

procedure TFormStart.StatBtnClick(Sender: TObject);
begin
  inherited;
  ChangeInquiresSources;
end;

procedure TFormStart.ShopButtonClick(Sender: TObject);
begin
  inherited;
  ModuleShop.ShopC.Execute;
end;

procedure TFormStart.SprMatBtnClick(Sender: TObject);
begin
  inherited;
  MdMat.MaterialsC.Execute;
end;

procedure TFormStart.BuhAccBtnClick(Sender: TObject);
begin
  inherited;
  ModuleCommon.AccountC.Execute;
end;

procedure TFormStart.PersonBtnClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.WorkersC.Execute;
end;

procedure TFormStart.ReviseBtnClick(Sender: TObject);
begin
  inherited;
  ModuleClientsAdd.ClientReportC.Execute;
end;

procedure TFormStart.ClientBuildingGrodnoBtnClick(Sender: TObject);
begin
  inherited;
  ModuleClientsAdd.ClientBuildingGrodnoRealC.Execute;
end;

procedure TFormStart.CommodityOutputBtnClick(Sender: TObject);
begin
  inherited;
  ModuleClientsAdd.CommodityOutputC.Execute;
end;

//by aleksm
procedure TFormStart.FormResize(Sender: TObject);
begin
  inherited;
  if ClientWidth < 591 then ClientWidth := 591;
  ClientHeight := 101;
end;

procedure TFormStart.WorkersVVBtnClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.WorkersVVC.Execute;
end;

procedure TFormStart.MoneyUseVBtnClick(Sender: TObject);
begin
  inherited;
  with ModulePays do begin
    MoneyUseV1Click(nil);
    MoneyUseVC.Execute;
  end;
end;

procedure TFormStart.FactureBtnClick(Sender: TObject);
begin
  inherited;
  ModuleInvoice.FactureC.Execute;
end;

procedure TFormStart.WorkTimeButtonClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.WorkTimeC.Execute;
end;

procedure TFormStart.WorkTimeReportButtonClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.WorkTimeReportC.Execute;
end;

procedure TFormStart.SumBalanceButtonClick(Sender: TObject);
begin
  inherited;
  ModuleClientsAdd.ClientReportTotalC.Execute;
end;

{ Пока используется для тестирования чего-нибудь }
procedure TFormStart.TuningSystemClick(Sender: TObject);
begin
  inherited;
  with ModuleBase do
    if Pos('BUH',UsersDeclarMemberOfGroups.AsString)>0 then
      ShowMessage('Пользователь '+UserName+' состоит в группе BUH')
    else ShowMessage('Пользователь '+UserName+' не состоит в группе BUH')
end;

procedure TFormStart.ProdRequestForShopButtonClick(Sender: TObject);
begin
  inherited;
  ModuleClientsAdd.ProdRequestForShopC.Execute;
end;

procedure TFormStart.JobHiProtocolButtonClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.JobHiProtocolC.Execute
end;

procedure TFormStart.ICProdLimeUpdateButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeUpdateClick(Sender);
end;

procedure TFormStart.ICProdLimeButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeC.Execute
end;

procedure TFormStart.ICProdLimeHour1ButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeHour1C.Execute
end;

procedure TFormStart.ICProdLimeHour2ButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeHour2C.Execute
end;

procedure TFormStart.ICProdLimeProtocolsButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeProtocolsC.Execute
end;

procedure TFormStart.ICGasForLimeButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICGasForLimeC.Execute
end;

procedure TFormStart.ICProdLimeParametersButtonClick(Sender: TObject);
begin
  inherited;
  ModuleProd.ICProdLimeParametersC.Execute
end;

procedure TFormStart.WProfAddVBtnClick(Sender: TObject);
begin
  inherited;
  ModuleWorkers.WProfAddVC.Execute;
end;

Initialization
  RegisterAliasXForm('FormStart', TFormStart);
Finalization
  UnRegisterXForm(TFormStart);
end.
 