Program KSMProj;

Uses
  {VCLDB40;VCLDBX40;}
  {MsCheck,}
  Splash,
  Forms,
  TlsForm,
  SaErrors,
  MdBase in '..\MdBase.pas' {ModuleBase: TDataModule},
  XSBForm in 'C:\B\XYLIB4\XSBForm.pas' {XSDBForm},
  SForm in '..\SForm.pas' {FormStart},
  MdGeography in '..\Geography\MdGeography.pas' {ModuleGeography: TDataModule},
  MdCommon in '..\Common\MdCommon.pas' {ModuleCommon: TDataModule},
  MdProd in '..\Product\MdProd.pas' {ModuleProd: TDataModule},
  MdOrgs in '..\Orgs\MdOrgs.pas' {ModuleOrgs: TDataModule},
  MdContr in '..\Contract\MdContr.pas' {ModuleContract: TDataModule},
  MdPays in '..\Pays\MdPays.pas' {ModulePays: TDataModule},
  MdInvc in '..\Invoice\MdInvc.pas' {ModuleInvoice: TDataModule},
  MdClientsAdd in '..\Orgs\MdClientsAdd.pas' {ModuleClientsAdd: TDataModule},
  MdShop in '..\Shop\MdShop.pas' {ModuleShop: TDataModule},
  mdMaterials in '..\Materials\mdMaterials.pas' {mdMat: TDataModule},
  ABEForms in 'C:\B\XYLib4\ABEForms.pas' {ABEForm},
  BEForms in 'C:\B\XYLib4\BEForms.pas' {BEForm},
  BBEForms in 'C:\B\XYLib4\BBEForms.pas' {BBEForm},
  MBEForms in 'C:\B\XYLib4\MBEForms.pas' {MBEForm},
  Bank in '..\Common\Bank.pas' {FormBank},
  Prod in '..\Product\Prod.pas' {FormProd},
  ProdMat in '..\Product\ProdMat.pas' {FormProdMat},
  ProdPlan in '..\Product\ProdPlan.pas' {FormProdPlan},
  Tare in '..\Product\Tare.pas' {FormTare},
  Orgs in '..\Orgs\Orgs.Pas' {FormOrgs},
  ContrProd in '..\Contract\ContrProd.pas' {FormContractProd},
  Contract in '..\Contract\Contract.pas' {FormContract},
  PayDoc in '..\Pays\PayDoc.pas' {FormPayDoc},
  Invoice in '..\Invoice\Invoice.pas' {FormInvoice},
  PriceDlg in '..\Product\PriceDlg.pas' {FormPriceDlg},
  DiDate in '..\C:\B\Etv\DiDate.pas' {DialDate},
  DlgOneDate in '..\DlgOneDate.pas' {DialogOneDate},
  DlgClient in '..\DlgClient.pas' {DlgClientF},
  DlgUnLOck in '..\Invoice\DlgUnLock.pas' {FormDlgUnLock},
  DlgAct in '..\DlgAct.pas' {DialParamPayDoc},
  Shop in '..\Shop\Shop.Pas' {FormShop},
  selectBox in '..\Materials\selectBox.pas' {FormSelect},
  Materials in '..\Materials\Materials.pas' {FormMat},
  MInvoice in '..\Materials\MInvoice.Pas' {MInvoiceForm};

{$R *.RES}
begin
  try
    Application.Initialize;
    Application.Title := 'Реализация';
    Application.CreateForm(TModuleBase, ModuleBase);
  Application.CreateForm(TModuleGeography, ModuleGeography);
  Application.CreateForm(TModuleCommon, ModuleCommon);
  Application.CreateForm(TModuleProd, ModuleProd);
  Application.CreateForm(TModuleOrgs, ModuleOrgs);
  Application.CreateForm(TModuleContract, ModuleContract);
  Application.CreateForm(TModulePays, ModulePays);
  Application.CreateForm(TModuleInvoice, ModuleInvoice);
  Application.CreateForm(TModuleClientsAdd, ModuleClientsAdd);
  Application.CreateForm(TModuleShop, ModuleShop);
  Application.CreateForm(TmdMat, mdMat);
  Application.CreateForm(TFormStart, FormStart);
  Application.CreateForm(TDialAct, DialAct);
  Application.CreateForm(TMInvoiceForm, MInvoiceForm);
  Application.OnException:=SaErr.HandleDBExcept;
    { Чтобы нормально работала функция Round при округлении чисел типа n.5 }
    (*Set8087CW(Default8087CW or $0800);*)
    { ******************************** }
  except
  end;
  Application.Run;
end.
