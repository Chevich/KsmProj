unit EtvOther;

interface
uses Classes, Controls, db, dbgrids;

type TCreateOtherControl=function(aOwner:TComponent; Field:TField):TControl;

var
    {Controls for use in Etv}
    CreateOtherText:TCreateOtherControl;
    CreateOtherEdit:TCreateOtherControl;
    CreateOtherDateEdit:TCreateOtherControl;
    CreateOtherIntEdit:TCreateOtherControl;
    CreateOtherMemo:TCreateOtherControl;
    {CreateOtherImage:TCreateOtherControl;}
    CreateOtherLookupComboBox:TCreateOtherControl;

    {DBControls for use in Etv}
    CreateOtherDBText:TCreateOtherControl;
    CreateOtherDBEdit:TCreateOtherControl;
    CreateOtherDBDateEdit:TCreateOtherControl;
    CreateOtherDBIntEdit:TCreateOtherControl;
    CreateOtherDBMemo:TCreateOtherControl;
    CreateOtherDBImage:TCreateOtherControl;
    CreateOtherDBLookupComboBox:TCreateOtherControl;

    {Controls for use in EtvDBGrid}
    CreateOtherDBGridControls:
      function(aOwner:TDBGrid; Field:TField; c:Char):TWinControl;

    (* print from Etvdbgrid *)
    CreateOtherDBGridPrint: procedure(aGrid:TDBGrid);
    CreateOtherDBGridPrintRecord: procedure(aGrid:TDBGrid);

    {class of query for EtvFilter}
type TOtherQueryClass=class of TDataset;
var OtherQueryClass:TOtherQueryClass;
    {Load and save data of EtvFilter}
    CreateOtherOnFilterLoad:procedure(aEtvFilter:TComponent);
    CreateOtherOnFilterSave:procedure(aEtvFilter:TComponent);

    {Additional field auto correction}
    CreateOtherFieldAutoCorrect:procedure(aField:TField);

implementation

end.
