unit MFaktura;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, XMisc, EtvLook, ToolEdit,
  RXDBCtrl, EtvRXCtl, Mask, EtvContr,
  XTFC, XDBTFC, DBTables, EtvTable, LnTables, LnkSet,
  XEFields, Db, Menus, EtvDBase, UsersSet, XApps, VG, ppBands,
  ppCtrls, EtvPpCtl, ppPrnabl, ppClass, ppDB, ppProd, ppReport, ppComm,
  ppRelatv, ppCache, ppDBPipe, ppDBBDE, ppModule, daDatMod, SelectBox,
  ppVar, Commctrl, ppStrtch, ppMemo, EtvDB, BEForms,
  ImgList,
  Buttons, Materials, MdBase, MdCommon,MdGeography,MdOrgs, MInvoice, EtvDBFun, EtvBor, DBCommon,
     XDBMisc, Misc,  MdInvc, MdContr, RxSpin, MInvoiceCheckSS, MInvoiceDragInfo, EtvFilt, EtvMem, MServiceUnit,
  RXCtrls, XCtrls;


type
  TMFakturaForm = class(TABEForm)
    ENumDoc: TXEDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    cbUp: TCheckBox;
    EDataDoc: TXEDBDateEdit;
    EClientName: TXEDBLookupCombo;
    EDebitName: TXEDBLookupCombo;
    EKreditName: TXEDBLookupCombo;
    EDepotName: TXEDBLookupCombo;
    EObjZatrName: TXEDBLookupCombo;
    ECurrencyName: TXEDBLookupCombo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Labe29: TLabel;
    Labe39: TLabel;
    Label77: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    XEDbGrid1: TXEDbGrid;
    DBNavigator1: TDBNavigator;
    ETotal: TXEDBEdit;
    ESummaNDS: TXEDBEdit;
    ESumma: TXEDBEdit;
    ETotalBy: TXEDBEdit;
    ESummaNDSBy: TXEDBEdit;
    ESummaBy: TXEDBEdit;
    eKomment: TXEDBEdit;
    Label8: TLabel;
    ESectionD: TXEDBLookupCombo;
    ESectionK: TXEDBLookupCombo;
    XDBLabel1: TXDBLabel;
    procedure cbUpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ChangeVisibleCurrency(kod_val: integer); 
  end;

var
  MFakturaForm: TMFakturaForm;

implementation
  uses mdMaterials;
{$R *.DFM}

procedure TMFakturaForm.cbUpClick(Sender: TObject);
begin
  inherited;
  ESumma.Enabled := cbUP.Checked;
  ESummaBy.Enabled := cbUP.Checked;
  ETotal.Enabled := not cbUP.Checked;
  ETotalBy.Enabled := not cbUP.Checked;
  ChangeVisibleCurrency(mdMat.MFakturaDeclarCurrency.Value);
end;

procedure TMFakturaForm.ChangeVisibleCurrency(kod_val: integer);
begin
  if Assigned(Self) then
    try
      ETotalBy.Visible := kod_val <> 974;
      ESummaBy.Visible := kod_val <> 974;
      ESummaNDSBy.Visible := kod_val <> 974;
      XEDbGrid1.Columns[4].Visible:=kod_val <> 974;
    except
      ShowMessage('1');
    end;
end;

procedure TMFakturaForm.FormCreate(Sender: TObject);
begin
  inherited;
  cbUpClick(Self);
end;

Initialization
  RegisterAliasXForm('MFakturaForm', TMFakturaForm);
//  IsPrintOn:=false;
Finalization
  UnRegisterXForm(TMFakturaForm);
end.
