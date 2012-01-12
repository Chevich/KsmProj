unit UnForming3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages ,XMisc, EtvLook, EtvList,
  ToolEdit, RXDBCtrl, EtvRXCtl, Mask, EtvContr, RXCtrls, XCtrls, RXSplit;

type
  TFormUnForming3 = class(TBBEForm)
    LabelID: TXLabel;
    EditID: TXEDBEdit;
    LabelDate: TXLabel;
    EditDate: TXEDBDateEdit;
    LabelShiftNum: TXLabel;
    EditShiftNum: TXEDBCombo;
    LabelShift: TXLabel;
    EditShift: TXEDBCombo;
    LabelForemanName: TXLabel;
    EditForemanName: TXEDBLookupCombo;
    LabelQualityInspectorName: TXLabel;
    EditQualityInspectorName: TXEDBLookupCombo;
    Grid2: TXEDbGrid;
    Grid3: TXEDbGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Grid1: TXEDbGrid;
    FormSheetPanel: TPanel;
    Splitter3: TSplitter;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUnForming3: TFormUnForming3;

implementation

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormUnForming3', TFormUnForming3);
Finalization
  UnRegisterXForm(TFormUnForming3);
end.
     