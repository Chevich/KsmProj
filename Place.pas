unit Place;

interface

uses
  ABEForms, DBCtrls, EtvContr, XECtrls, EtvLook, StdCtrls, Mask, Controls,
  RXCtrls, XCtrls, DBIndex, Nav, ExtCtrls, Grids,
  DBGrids, EtvGrid, ComCtrls, Classes, XMisc;

type
  TFormPlace = class(TABEForm)
    XLabel5: TXLabel;
    LabelKod: TXLabel;
    EditKod: TXEDBEdit;
    LabelName: TXLabel;
    EditName: TXEDBEdit;
    LabelTPLace: TXLabel;
    LabelRegion: TXLabel;
    LabelCountry: TXLabel;
    LabelPhoneKod: TXLabel;
    EditPhoneKod: TXEDBEdit;
    LabelSubRegion: TXLabel;
    LabelPrPlace: TXLabel;
    EditTPlace: TXEDBLookupCombo;
    EditRegion: TXEDBLookupCombo;
    EditCountry: TXEDBLookupCombo;
    EditSubRegion: TXEDBLookupCombo;
    EditPrPLace: TXEDBCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormPlace: TFormPlace;
}
implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormPlace', TFormPlace);
Finalization
  UnRegisterXForm(TFormPlace);
end.
