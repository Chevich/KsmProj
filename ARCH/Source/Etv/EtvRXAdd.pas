unit EtvRXAdd;

interface

implementation
uses EtvOther,EtvRXCtl;

initialization
CreateOtherDateEdit:=CreateRXDateEdit;
CreateOtherDBDateEdit:=CreateRXDBDateEdit;
CreateOtherDBGridControls:=CreateRXDBGridDateEdit;
finalization
end.
