unit FactureVAT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, XMisc, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, Mask, EtvContr, XCtrls,
  RXCtrls, ToolEdit, RXDBCtrl, EtvLook, EtvRXCtl;

type
  TFormFactureVAT = class(TBBEForm)
    XEDbGrid1: TXEDbGrid;
    Panel1: TPanel;
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    XDBLabel1: TXDBLabel;
    EditNumFacture: TXEDBEdit;
    EditsDate: TXEDBDateEdit;
    EditClientName: TXEDBLookupCombo;
    CalcServiceButton: TRxSpeedButton;
    XLabel5: TXLabel;
    DBTextClientINN: TEtvDBText;
    DBTextClientAddress: TEtvDBText;
    XLabel6: TXLabel;
    XLabel7: TXLabel;
    EditBegPeriod: TXEDBDateEdit;
    XLabel10: TXLabel;
    EditEndPeriod: TXEDBDateEdit;
    XLabel8: TXLabel;
    EtvDBText1: TEtvDBText;
    XLabel9: TXLabel;
    EtvDBText2: TEtvDBText;
    procedure CalcServiceButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFactureVAT: TFormFactureVAT;

implementation
uses MdInvc;
{$R *.DFM}

procedure TFormFactureVAT.CalcServiceButtonClick(Sender: TObject);
begin
  inherited;
  with ModuleInvoice.RepFactureVAT do begin
    Template.LoadFromFile;
    Print;
  end;  
end;

Initialization
  RegisterAliasXForm('FormFactureVAT', TFormFactureVAT);
Finalization
  UnRegisterXForm(TFormFactureVAT);
end.
