unit BBEForms;

interface

uses
  ABEForms, StdCtrls, DBIndex, ExtCtrls, XDBForms,
  Controls, Grids, DBGrids, EtvGrid, XECtrls, ComCtrls, Classes, XMisc,EtvContr,
  SrcIndex, EtvPages, Menus, DBCtrls;

type
  TBBEForm = class(TABEForm)
    DetailPages: TXPageControl;
    TabSheet1: TEtvTabSheet;
    TabSheet2: TEtvTabSheet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

Initialization
  RegisterXForm(TBBEForm);
Finalization
  UnRegisterXForm(TBBEForm);
end.
