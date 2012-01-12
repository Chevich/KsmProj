unit Orgs;

interface

uses
  MBEForms, DBCtrls, EtvContr, XECtrls, EtvLook, StdCtrls, Mask, ToolEdit,
  RXDBCtrl, Controls, RXCtrls, XCtrls, DBIndex, ExtCtrls, Grids, DBGrids,
  EtvGrid, ComCtrls, Classes, XMisc, XDBForms, EtvRXCtl, SrcIndex,
  Menus, EtvList, EtvPages;

type
  TFormOrgs = class(TMBEForm)
    LabelBossOrg: TXLabel;
    LabelTActivity: TXLabel;
    LabelTOrg: TXLabel;
    LabelCheckDate: TXLabel;
    CheckDate: TXEDBDateEdit;
    TabSheet4: TTabSheet;
    DBGrid1: TXEDbGrid;
    EditSGroup: TXEDBLookupCombo;
    EditActivity: TXEDBLookupCombo;
    EditTOrg: TXEDBLookupCombo;
    XLabel3: TXLabel;
    EditOrgName: TXEDBLookupCombo;
    XLabel4: TXLabel;
    EditAutoInc: TXEDBEdit;
    XLabel5: TXLabel;
    EditBankName: TXEDBLookupCombo;
    XLabel6: TXLabel;
    EditBCount: TXEDBEdit;
    XLabel7: TXLabel;
    EditTCount: TXEDBEdit;
    XEDBDateEdit1: TXEDBDateEdit;
    XLabel9: TXLabel;
    DBTextTime: TDBText;
    LabelTime: TXLabel;
    DBTextUser: TDBText;
    LabelUser: TXLabel;
    XLabel14: TXLabel;
    XEDBEdit1: TXEDBEdit;
    XLabel15: TXLabel;
    EditLicence: TXEDBEdit;
    Panel1: TPanel;
    LabelKod: TXLabel;
    LabelName: TXLabel;
    XLabel13: TXLabel;
    EditKodOrg: TXEDBEdit;
    EditName: TXEDBEdit;
    DBText1: TDBText;
    LabelFullName: TXLabel;
    EditFullName: TXEDBEdit;
    LabelPostRekvizit: TXLabel;
    LabelCountry: TXLabel;
    EditCountry: TXEDBLookupCombo;
    LabelRezident: TXLabel;
    EditRezident: TXEDBCombo;
    LabelPIndex: TXLabel;
    EditPIndex: TXEDBEdit;
    LabelPlace: TXLabel;
    EditPlace: TXEDBLookupCombo;
    LabelAddress: TXLabel;
    EditAddress: TXEDBEdit;
    LabelPhone: TXLabel;
    EditPhone: TXEDBEdit;
    LabelTeletype: TXLabel;
    EditTeletype: TXEDBEdit;
    LabelFax: TXLabel;
    EditFax: TXEDBEdit;
    LabelEMail: TXLabel;
    EditEMail: TXEDBEdit;
    XLabel10: TXLabel;
    EditStation: TXEDBLookupCombo;
    XLabel1: TXLabel;
    EditRailBranch: TXEDBLookupCombo;
    XLabel11: TXLabel;
    EditOrgStation: TXEDBEdit;
    LabelRelation: TXLabel;
    EditPrCustomer: TXEDBCombo;
    XLabel2: TXLabel;
    EditPrSupplier: TXEDBCombo;
    LabelINN: TXLabel;
    EditINN: TXEDBEdit;
    XLabel8: TXLabel;
    EditOKPO: TXEDBEdit;
    XLabel12: TXLabel;
    EditChecked: TXEDBCombo;
    Bevel: TBevel;
    Bevel1: TBevel;
    XLabel16: TXLabel;
    XLabel17: TXLabel;
    LastDateInvoice: TXEDBDateEdit;
    XEDBDateEdit2: TXEDBDateEdit;
    XLabel18: TXLabel;
    XEDBCombo1: TXEDBCombo;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckDateDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormOrgs: TFormOrgs;
}
implementation
uses Windows,SysUtils, MdOrgs;
{!!uses MdOrgs;}

{$R *.DFM}

procedure TFormOrgs.Button1Click(Sender: TObject);
begin
  inherited;
{
  with ModuleOrgs do begin
    BankSimple.Active:=true;
    BankSimple.DisableControls;
    BankSimple.IndexName:='SprBank_KodOtd';
    with OrgBankSimple do begin
      First;
      while not Eof do begin
        if (Abs(OrgBankSimpleKodBn.Value)<32768) and
        BankSimple.FindKey([OrgBankSimpleKodBn.Value]) then begin
          OrgBankSimple.Edit;
          OrgBankSimpleKodBn.Value:=BankSimpleKod.Value;
        end;
        Next;
      end;
    end;
  end;
  }
end;

Procedure TFormOrgs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i:byte;
begin
  inherited;
  if Key=VK_F12 then with ModuleOrgs.OrgC.Form do begin
    i:=Pos('Всего: ',Caption);
    if i>0 then Caption:=Copy(Caption,1,i+6)
    else Caption:=Caption+'   Всего: ';
    Caption:=Caption+IntToStr(ModuleOrgs.OrgDeclar.RecordCount);
    {Form.Repaint;}
  end;
end;

Procedure TFormOrgs.CheckDateDblClick(Sender: TObject);
begin
  Inherited;
  LabelUser.Visible:=not LabelUser.Visible;
  LabelTime.Visible:=not LabelTime.Visible;
  DBTextTime.Visible:=not DBTextTime.Visible;
  DBTextUser.Visible:=not DBTextUser.Visible;
end;

Initialization
  RegisterAliasXForm('FormOrgs', TFormOrgs);
Finalization
  UnRegisterXForm(TFormOrgs);
end.
