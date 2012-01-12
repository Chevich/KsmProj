unit Costs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MBEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, Vg, XETrees, EtvLook,
  Mask, EtvContr, RXCtrls, XCtrls;

type
  TFormCosts = class(TMBEForm)
    TreeViewCosts: TXEDBTreeView;
    XLabel1: TXLabel;
    EditKod: TXEDBEdit;
    XLabel2: TXLabel;
    EditName: TXEDBEdit;
    XLabel3: TXLabel;
    EditKodUpName: TXEDBLookupCombo;
    XLabel4: TXLabel;
    EditObjectName: TXEDBLookupCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCosts: TFormCosts;

implementation
Uses XMisc, MdMaterials;

{$R *.DFM}
Initialization
  RegisterAliasXForm('FormCosts', TFormCosts);
Finalization
  UnRegisterXForm(TFormCosts);
end.
