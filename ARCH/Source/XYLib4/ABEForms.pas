unit ABEForms;

interface

uses
  BEForms, StdCtrls, DBIndex, ExtCtrls,
  Controls, Grids, DBGrids, EtvGrid, XECtrls, ComCtrls, Classes, XMisc,
  XDBForms, SrcIndex, EtvContr, EtvPages, Menus, DBCtrls;

type
  TABEForm = class(TBEForm)
    FormSheet: TEtvTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Initialization
  RegisterXForm(TABEForm);
Finalization
  UnRegisterXForm(TABEForm);
end.
