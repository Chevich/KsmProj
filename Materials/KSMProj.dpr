Program KSMProj;

Uses
  {MsCheck,}
  Forms,
  Splash,
  TlsForm,
  SaErrors,
  XSBForm in 'C:\B\XYLIB4\XSBForm.pas' {XSDBForm},
  BEForms in 'C:\B\XYLib4\BEForms.pas' {BEForm},
  ABEForms in 'C:\B\XYLib4\ABEForms.pas' {ABEForm},
  BBEForms in 'C:\B\XYLib4\BBEForms.pas' {BBEForm},
  MBEForms in 'C:\B\XYLib4\MBEForms.pas' {MBEForm},
  mdMaterials in 'mdMaterials.pas',
  Materials in 'Materials.pas' {FormMat},
  MainForm in 'MainForm.pas' {StartForm},
  MInvoice in 'MInvoice.pas' {MInvoiceForm};

{$R *.RES}
begin
  Application.Initialize;
  Application.Title := 'Реализация';
  Application.CreateForm(TStartForm, StartForm);
  Application.CreateForm(TMdMat, MdMat);
  Application.CreateForm(TFormMat, FormMat);
  Application.CreateForm(TMInvoiceForm, MInvoiceForm);
  Application.OnException:=SaErr.HandleDBExcept;
  Application.Run;
end.
