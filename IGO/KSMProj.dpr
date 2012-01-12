Program KSMProj;

Uses
  {MsCheck,}
  Forms,
  Splash,
  TlsForm,
  SaErrors,
  MdBase in 'Y:\USERS\KSM\MdBase.pas' {ModuleBase: TDataModule},
  XSBForm in 'C:\B\XYLIB4\XSBForm.pas' {XSDBForm},
  SForm in 'Y:\USERS\KSM\SForm.pas' {FormStart},
  MdCommon in 'Y:\USERS\KSM\Common\MdCommon.pas' {ModuleCommon: TDataModule},
  MdProd in 'Y:\USERS\KSM\Product\MdProd.pas' {ModuleProd: TDataModule},
  MdOrgs in 'Y:\USERS\KSM\Orgs\MdOrgs.pas' {ModuleOrgs: TDataModule},
  MdContr in 'Y:\USERS\KSM\Contract\MdContr.pas' {ModuleContract: TDataModule},
  MdPays in 'Y:\USERS\KSM\Pays\MdPays.pas' {ModulePays: TDataModule},
  MdInvc in 'Y:\USERS\KSM\Invoice\MdInvc.pas' {ModuleInvoice: TDataModule},
  BEForms in 'C:\B\XYLib4\BEForms.pas' {BEForm},
  ABEForms in 'C:\B\XYLib4\ABEForms.pas' {ABEForm},
  BBEForms in 'C:\B\XYLib4\BBEForms.pas' {BBEForm},
  MBEForms in 'C:\B\XYLib4\MBEForms.pas' {MBEForm},
  Place in 'Y:\USERS\KSM\Common\Place.pas' {FormPlace},
  Bank in 'Y:\USERS\KSM\Common\Bank.pas' {FormBank},
  Prod in 'Y:\USERS\KSM\Product\Prod.pas' {FormProd},
  ProdMat in 'Y:\USERS\KSM\Product\ProdMat.pas' {FormProdMat},
  ProdPlan in 'Y:\USERS\KSM\Product\ProdPlan.pas' {FormProdPlan},
  Tare in 'Y:\USERS\KSM\Product\Tare.pas' {FormTare},
  Orgs in 'Y:\USERS\KSM\Orgs\Orgs.Pas' {FormOrgs},
  ContrProd in 'Y:\USERS\KSM\Contract\ContrProd.pas' {FormContractProd},
  Contract in 'Y:\USERS\KSM\Contract\Contract.pas' {FormContract},
  PayDoc in 'Y:\USERS\KSM\Pays\PayDoc.pas' {FormPayDoc},
  Invoice in 'Y:\USERS\KSM\Invoice\Invoice.pas' {FormInvoice},
  PriceDlg in 'Y:\USERS\KSM\Product\PriceDlg.pas' {FormPriceDlg},
  DiDate in 'C:\B\Etv\DiDate.pas' {DialDate},
  DlgOneDate in 'Y:\USERS\KSM\DlgOneDate.pas' {DialogOneDate},
  DlgPrmPd in 'Y:\USERS\KSM\DlgPrmPd.pas' {DialParamPayDoc},
  DlgClient in 'Y:\USERS\KSM\DlgClient.pas' {DlgClientF};

{$R *.RES}
begin
  Application.Initialize;
  Application.Title := 'Реализация';
  Application.CreateForm(TModuleBase, ModuleBase);
  Application.CreateForm(TModuleCommon, ModuleCommon);
  Application.CreateForm(TModuleProd, ModuleProd);
  Application.CreateForm(TModuleOrgs, ModuleOrgs);
  Application.CreateForm(TModuleContract, ModuleContract);
  Application.CreateForm(TModulePays, ModulePays);
  Application.CreateForm(TModuleInvoice, ModuleInvoice);
  Application.CreateForm(TFormStart, FormStart);
  Application.CreateForm(TDialParamPayDoc, DialParamPayDoc);
  {Application.CreateForm(TDlgClientF, DlgClientF);}
  Application.OnException:=SaErr.HandleDBExcept;
  Application.Run;
end.
