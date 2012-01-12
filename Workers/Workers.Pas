unit Workers;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MBEForms, StdCtrls, SrcIndex, XDBForms, ExtCtrls, Grids, DBGrids, MdWorkers,
  EtvGrid, XECtrls, ComCtrls, EtvPages, XMisc, RXCtrls, XCtrls, Mask,
  DBCtrls, EtvContr, EtvList, ToolEdit, RXDBCtrl, EtvRXCtl, EtvLook;

type
  TFormWorkers = class(TMBEForm)
    TabSheet3: TEtvTabSheet;
    TabSheet4: TEtvTabSheet;
    TabSheet5: TEtvTabSheet;
    XLabel46: TXLabel;
    EditArmyGroup: TXEDBLookupCombo;
    XLabel47: TXLabel;
    EditArmyCategory: TXEDBEdit;
    XLabel48: TXLabel;
    EditStaff: TXEDBLookupCombo;
    EditRank: TXEDBLookupCombo;
    XLabel49: TXLabel;
    XLabel50: TXLabel;
    EditSpec: TXEDBEdit;
    XLabel51: TXLabel;
    EditValidity: TXEDBLookupCombo;
    XLabel52: TXLabel;
    EditOffice: TXEDBEdit;
    EditValGroup: TXEDBEdit;
    XLabel53: TXLabel;
    XLabel54: TXLabel;
    EditValArticle: TXEDBEdit;
    XLabel55: TXLabel;
    EditValOrder: TXEDBEdit;
    XEDBDateEdit1: TXEDBDateEdit;
    XLabel56: TXLabel;
    XEDBEdit1: TXEDBEdit;
    XEDBEdit2: TXEDBEdit;
    XLabel57: TXLabel;
    XLabel58: TXLabel;
    XEDbGrid1: TXEDbGrid;
    EtvDbGrid2: TXEDbGrid;
    Panel1: TPanel;
    EditID: TXEDBEdit;
    XLabel2: TXLabel;
    EditTabNum: TXEDBEdit;
    XLabel3: TXLabel;
    EditSex: TXEDBCombo;
    XLabel44: TXLabel;
    EditMix: TXEDBCombo;
    EditPensioner: TXEDBCheckBox;
    XLabel4: TXLabel;
    EditLastName: TXEDBEdit;
    XLabel5: TXLabel;
    EditFirstName: TXEDBEdit;
    XLabel6: TXLabel;
    EditMiddleName: TXEDBEdit;
    EditDateBirth: TXEDBDateEdit;
    XLabel7: TXLabel;
    XLabel8: TXLabel;
    XLabel9: TXLabel;
    EditPlaceBirth: TXEDBEdit;
    EditAreaBirth: TXEDBEdit;
    XLabel10: TXLabel;
    EditRegionBirth: TXEDBEdit;
    XLabel11: TXLabel;
    Bevel2: TBevel;
    XLabel1: TXLabel;
    EditCountryBirthName: TXEDBLookupCombo;
    XLabel12: TXLabel;
    Bevel1: TBevel;
    XLabel15: TXLabel;
    EditGraduate: TXEDBEdit;
    EditTEducation: TXEDBLookupCombo;
    XLabel14: TXLabel;
    XLabel13: TXLabel;
    EditNationName: TXEDBLookupCombo;
    XLabel16: TXLabel;
    EditYearGrad: TXEDBDateEdit;
    EditSpecGrad: TXEDBEdit;
    XLabel17: TXLabel;
    EditProfGrad: TXEDBEdit;
    XLabel18: TXLabel;
    XLabel22: TXLabel;
    EditProfSecond: TXEDBEdit;
    EditProfPrimary: TXEDBEdit;
    XLabel21: TXLabel;
    EditDateDip: TXEDBDateEdit;
    XLabel20: TXLabel;
    XLabel19: TXLabel;
    EditDiploma: TXEDBEdit;
    EditCitizenshipName: TXEDBLookupCombo;
    XLabel24: TXLabel;
    EditExpPrim: TXEDBDateEdit;
    EditExpTotal: TXEDBDateEdit;
    XLabel25: TXLabel;
    XLabel26: TXLabel;
    EditExpCont: TXEDBDateEdit;
    EditDateOn: TXEDBDateEdit;
    XLabel27: TXLabel;
    XLabel28: TXLabel;
    EditMarital: TXEDBCombo;
    EditAmountFam: TXEDBEdit;
    XLabel45: TXLabel;
    XLabel34: TXLabel;
    EditPersNum: TXEDBEdit;
    EditDatePass: TXEDBDateEdit;
    XLabel33: TXLabel;
    EditPassAuth: TXEDBEdit;
    XLabel32: TXLabel;
    EditPassNum: TXEDBEdit;
    XLabel31: TXLabel;
    EditPassSer: TXEDBEdit;
    XLabel30: TXLabel;
    XLabel29: TXLabel;
    XLabel35: TXLabel;
    EditPIndex: TXEDBEdit;
    EditAddress: TXEDBEdit;
    XLabel36: TXLabel;
    EditPhoneHome: TXEDBEdit;
    XLabel37: TXLabel;
    XLabel38: TXLabel;
    EditCountryAddressName: TXEDBLookupCombo;
    XLabel41: TXLabel;
    LabelsTime: TXDBLabel;
    LabelsUser: TXDBLabel;
    XLabel40: TXLabel;
    EditCertificate: TXEDBCheckBox;
    EditReasonOffName: TXEDBLookupCombo;
    XLabel43: TXLabel;
    EditDateOff: TXEDBDateEdit;
    XLabel42: TXLabel;
    XLabel39: TXLabel;
    EditDateFill: TXEDBDateEdit;
    EditSoatoName: TXEDBLookupCombo;
    EditStreetName: TXEDBLookupCombo;
    EtvDbGrid3: TXEDbGrid;
    XLabel23: TXLabel;
    XLabel59: TXLabel;
    XLabel60: TXLabel;
    XLabel61: TXLabel;
    EditHouse: TXEDBEdit;
    XLabel62: TXLabel;
    EditHouseAdd: TXEDBEdit;
    XLabel63: TXLabel;
    EditFlat: TXEDBEdit;
    XLabel64: TXLabel;
    XEDBEdit3: TXEDBEdit;
    XEDBLookupCombo1: TXEDBLookupCombo;
    Button1: TButton;
    LabelPhoneCorp: TXLabel;
    EditPhoneCorp: TXEDBEdit;
    TabSheet7: TEtvTabSheet;
    XLabel65: TXLabel;
    EditStature: TXEDBEdit;
    XLabel66: TXLabel;
    XLabel67: TXLabel;
    XLabel68: TXLabel;
    XLabel69: TXLabel;
    XLabel70: TXLabel;
    XLabel71: TXLabel;
    XLabel72: TXLabel;
    XEDBEdit4: TXEDBEdit;
    XEDBEdit5: TXEDBEdit;
    XEDBEdit6: TXEDBEdit;
    XEDBEdit7: TXEDBEdit;
    XEDBEdit8: TXEDBEdit;
    XEDBEdit9: TXEDBEdit;
    XEDBEdit10: TXEDBEdit;
    TabSheet6: TEtvTabSheet;
    XEDbGrid2: TXEDbGrid;
    procedure EditDateOnExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SetColor(Acting: boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var FormWorkers: TFormWorkers;

implementation

uses DB, XEFields, XApps, EtvRus, EtvDB, EtvDBFun, TypInfo,
     EtvBor, EtvClone, ppTypes, ppEndUsr, ppReport, XReports, MdBase, MdOrgs,
     DlgUnLOck;

Type TWorkColor=array[0..1] of TColor;
Const WorkColor: TWorkColor=($00DEEDDF,$00EAFFEA); //TWorkColor=($00DEEDDF,$00FAFEE7);

{$R *.DFM}

procedure TFormWorkers.EditDateOnExit(Sender: TObject);
var i: integer;
    DT: String;
begin
(*
  inherited;
  DT:=TXEDBDateEdit(Sender).DataField;
  if i=0 then
    i:=1;
*)
end;

procedure TFormWorkers.Button1Click(Sender: TObject);
begin
  inherited;
  ModuleWorkers.RepWorkersHelp.Print;
end;

procedure TFormWorkers.SetColor(Acting: boolean);
var i: byte;
    PropInfo: PPropInfo;
begin
  with Panel1 do
    for i:=0 to ControlCount-1 do
      if Controls[i] is TWinControl then begin
        PropInfo:=GetPropInfo(Controls[i].ClassInfo,'Color');
        SetOrdProp(Controls[i],PropInfo,WorkColor[Byte(Acting)]);
        //Controls[i].Color:=WorkColor[Byte(Acting)]
      end;
end;

Initialization
  RegisterAliasXForm('FormWorkers', TFormWorkers);
Finalization
  UnRegisterXForm(TFormWorkers);
end.
 