unit Tare;

interface

uses
  BEForms, StdCtrls, DBIndex, ExtCtrls, Controls, Grids, DBGrids,
  EtvGrid, XECtrls, ComCtrls, Classes, XMisc, SrcIndex, XDBForms, EtvContr, EtvPages,
  DBCtrls;

type
  TFormTare = class(TBEForm)
    EtvDbGrid1: TXEDbGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormTare: TFormTare;
}
implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormTare', TFormTare);
Finalization
  UnRegisterXForm(TFormTare);
end.
