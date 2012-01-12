Program KSMProj;
{ -DirShb=D:\B\Shb - запускать Run с этим параметром для работы с локальной пакой шаблонов, при разработке новых шаблонов и тестировании }
Uses
  {VCLDB40;VCLDBX40;}
  {MsCheck,}
  Dialogs,
  XApps,
  Splash,
  Forms,
  TlsForm,
  SaErrors,
  MdBase in 'MdBase.pas' {ModuleBase: TDataModule},
  XSBForm in 'd:\b\XYLIB4\XSBForm.pas' {XSDBForm},
  SForm in 'SForm.pas' {FormStart},
  MdGeography in 'Geography\MdGeography.pas' {ModuleGeography: TDataModule},
  MdCommon in 'Common\MdCommon.pas' {ModuleCommon: TDataModule},
  MdProd in 'Product\MdProd.pas' {ModuleProd: TDataModule},
  MdOrgs in 'Orgs\MdOrgs.pas' {ModuleOrgs: TDataModule},
  MdContr in 'Contract\MdContr.pas' {ModuleContract: TDataModule},
  MdPays in 'Pays\MdPays.pas' {ModulePays: TDataModule},
  MdInvc in 'Invoice\MdInvc.pas' {RepInvoice: TDataModule},
  MdClientsAdd in 'Orgs\MdClientsAdd.pas' {ModuleClientsAdd: TDataModule},
  MdShop in 'Shop\MdShop.pas' {ModuleShop: TDataModule},
  mdMaterials in 'Materials\mdMaterials.pas' {mdMat: TDataModule},
  MdWorkers in 'Workers\MdWorkers.pas' {ModuleWorkers: TDataModule},
  ABEForms in 'd:\b\XYLib4\ABEForms.pas' {ABEForm},
  BEForms in 'd:\b\XYLib4\BEForms.pas' {BEForm},
  BBEForms in 'd:\b\XYLib4\BBEForms.pas' {BBEForm},
  MBEForms in 'd:\b\XYLib4\MBEForms.pas' {MBEForm},
  Bank in 'Common\Bank.pas' {FormBank},
  Prod in 'Product\Prod.pas' {FormProd},
  ProdMat in 'Product\ProdMat.pas' {FormProdMat},
  ProdPlan in 'Product\ProdPlan.pas' {FormProdPlan},
  Tare in 'Product\Tare.pas' {FormTare},
  Orgs in 'Orgs\Orgs.Pas' {FormOrgs},
  ContrProd in 'Contract\ContrProd.pas' {FormContractProd},
  Contract in 'Contract\Contract.pas' {FormContract},
  Invoice in 'Invoice\Invoice.pas' {FormInvoice},
  PayDoc in 'Pays\PayDoc.pas' {FormPayDoc},
  PriceDlg in 'Product\PriceDlg.pas' {FormPriceDlg},
  DiDate in 'd:\b\Etv\DiDate.pas' {DialDate},
  DlgOneDate in 'DlgOneDate.pas' {DialogOneDate},
  DlgClient in 'DlgClient.pas' {DlgClientF},
  DlgUnLOck in 'Invoice\DlgUnLock.pas' {FormDlgUnLock},
  DlgAct in 'DlgAct.pas' {DialParamPayDoc},
  Person2 in 'Workers\Person2.Pas' {FormPerson2},
  Workers in 'Workers\Workers.Pas' {FormWorkers},
  Shop in 'Shop\Shop.Pas' {FormShop},
  SelectBox in 'Materials\SelectBox.pas' {FormSelect},
  MInvoiceCalc in 'Materials\MInvoiceCalc.pas' {MInvoiceCalcForm},
  Materials in 'Materials\Materials.pas' {FormMat},
  MInvoice in 'Materials\MInvoice.Pas' {MInvoiceForm},
  MInvoiceDragInfo in 'Materials\MInvoiceDragInfo.Pas' {MInvoiceDragInfoForm},
  Person in 'Workers\Person.pas' {FormPerson},
  MInvoiceCheckSS in 'Materials\MInvoiceCheckSS.pas' {FMInvoiceCheckSS},
  MServiceUnit in 'Materials\MServiceUnit.pas' {MServiceForm},
  FactureVAT in 'Invoice\FactureVAT.pas' {FormFactureVAT},
  Facture in 'Invoice\Facture.pas' {FormFacture},
  MFaktura in 'Materials\MFaktura.pas' {MFakturaForm},
  WorkTime in 'Workers\WorkTime.pas' {FormWorkTime},
  JobHiProtocol in 'Workers\JobHiProtocol.pas' {FormJobHi},
  UnForming1 in 'Product\UnForming1.pas' {FormUnForming1},
  UnForming2 in 'Product\UnForming2.pas' {FormUnForming2},
  UnForming3 in 'Product\UnForming3.pas' {FormUnForming3},
  UnForming5 in 'Product\UnForming5.pas' {FormUnForming5};

  {$R *.RES}

Procedure OptimizeLoad;
begin
  Application.Minimize;
  Application.Restore;
end;

begin
  try
    Application.Initialize;
    if Optimize then OptimizeLoad;

    Application.Title := 'Реализация продукции';

    Application.CreateForm(TModuleBase, ModuleBase);
  if Optimize then begin
      ModuleBase.KsmTools.IsSplashed:=false;
      OptimizeLoad;
      Screen.Forms[0].FormStyle:=fsStayOnTop;
      //Screen.Forms[0].WindowState:=wsNormal;
      if MessageInOptimize then ShowMessage('After Create TModuleBase');
    end;
    {Screen.Forms[0].Show;}
    Application.CreateForm(TModuleGeography, ModuleGeography);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleGeography');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleCommon, ModuleCommon);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleCommon');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleProd, ModuleProd);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleProd');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleOrgs, ModuleOrgs);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleOrgs');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleContract, ModuleContract);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleContract');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModulePays, ModulePays);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModulePays');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleInvoice, ModuleInvoice);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleInvoice');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleClientsAdd, ModuleClientsAdd);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleClientsAdd');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleShop, ModuleShop);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleShop');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TmdMat, mdMat);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TMdMat');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}

    Application.CreateForm(TModuleWorkers, ModuleWorkers);
    if Optimize then begin
      if MessageInOptimize then ShowMessage('After Create TModuleWorkers');
      OptimizeLoad;
    end;
    {Screen.Forms[0].Show;}
    {
    Application.CreateForm(TModuleAuto, ModuleAuto);
    if Optimize then begin
      ShowMessage('After Create TModuleAuto');
      OptimizeLoad;
    end;
    }
    {Screen.Forms[0].Show;}

    Application.CreateForm(TFormStart, FormStart);
    Application.OnException:=SaErr.HandleDBExcept;
    { Чтобы нормально работала функция Round при округлении чисел типа n.5 }
    (*Set8087CW(Default8087CW or $0800);*)
    { ******************************** }
  except
  end;
(*
  Application.Minimize;

  Application.MainForm.WindowState:=wsMinimized;
  Application.MainForm.WindowState:=wsNormal;
*)
  if Optimize then OptimizeLoad;
(*Application.ProcessMessages;*)
  //Set8087CW(Default8087CW); { Эксперименты с точностью вычисления вещественных чисел }
  { См. Неочевидные особенности вещественных чисел - http://www.delphikingdom.com/asp/viewitem.asp?catalogid=374}
  Application.Run;
end.
