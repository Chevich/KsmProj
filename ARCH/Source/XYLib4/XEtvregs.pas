Unit XEtvRegs;

Interface

Procedure Register;

Implementation

Uses Windows, Dialogs, Classes, DB, XECtrls, XEFields, XETrees;

Procedure Register;
begin
  RegisterComponents('XEtvLib', [TXEDBEdit,TXEDBDateEdit,TXEDBGrid,TXEDBCombo,
                               TXEDBLookupCombo, TXEDBTreeView]);
  RegisterFields([TXEListField, TXELookField]);
end;

end.
