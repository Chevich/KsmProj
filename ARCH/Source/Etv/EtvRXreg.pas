unit EtvRXreg;

interface
procedure Register;

implementation
uses Classes,DsgnIntf,EtvRXCtl,EtvDsgn;

procedure Register;
begin
  RegisterComponents('EtvDB', [TEtvDBDateEdit]);
  RegisterComponentEditor(TEtvDBDateEdit, TEtvDBFieldControlEditor);
end;

end.
