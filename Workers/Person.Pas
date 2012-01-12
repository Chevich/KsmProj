unit Person;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, StdCtrls, SrcIndex, XDBForms, ExtCtrls, Grids, DBGrids, MdWorkers,
  EtvGrid, XECtrls, ComCtrls, EtvPages, DBCtrls, XCtrls, EtvLook, ToolEdit,
  RXDBCtrl, EtvRXCtl, EtvList, Mask, EtvContr, RXCtrls;

type
  TFormPerson = class(TABEForm)
    XLabel1: TXLabel;
    EditID: TXEDBEdit;
    XLabel3: TXLabel;
    EditSex: TXEDBCombo;
    XLabel4: TXLabel;
    EditLastName: TXEDBEdit;
    XLabel5: TXLabel;
    EditFirstName: TXEDBEdit;
    XLabel6: TXLabel;
    EditMiddleName: TXEDBEdit;
    XLabel7: TXLabel;
    EditDateBirth: TXEDBDateEdit;
    XLabel8: TXLabel;
    XLabel9: TXLabel;
    EditPlaceBirth: TXEDBEdit;
    XLabel10: TXLabel;
    EditAreaBirth: TXEDBEdit;
    XLabel11: TXLabel;
    EditRegion: TXEDBEdit;
    XLabel12: TXLabel;
    EditCountryName: TXEDBLookupCombo;
    XLabel29: TXLabel;
    XLabel30: TXLabel;
    EditPassSer: TXEDBEdit;
    XLabel31: TXLabel;
    EditPassNum: TXEDBEdit;
    XLabel32: TXLabel;
    EditPassAuth: TXEDBEdit;
    XLabel33: TXLabel;
    EditDatePass: TXEDBDateEdit;
    XLabel34: TXLabel;
    EditPersNum: TXEDBEdit;
    XLabel35: TXLabel;
    EditPIndex: TXEDBEdit;
    XLabel36: TXLabel;
    EditAddress: TXEDBEdit;
    XLabel37: TXLabel;
    EditPhoneHome: TXEDBEdit;
    XLabel39: TXLabel;
    EditDateFill: TXEDBDateEdit;
    XLabel40: TXLabel;
    LabelsUser: TXDBLabel;
    XLabel41: TXLabel;
    LabelsTime: TXDBLabel;
    EditIDWName: TXEDBLookupCombo;
    XLabel2: TXLabel;
    EditsType: TXEDBRadioGroup;
    Bevel2: TBevel;
    Bevel1: TBevel;
    EditRezident: TXEDBCombo;
    XLabel13: TXLabel;
    XLabel14: TXLabel;
    EditPhoneWork: TXEDBEdit;
    XLabel15: TXLabel;
    EditPacketNum: TXEDBEdit;
    Bevel3: TBevel;
    XLabel16: TXLabel;
    XLabel17: TXLabel;
    EditPersNumOld: TXEDBEdit;
    XLabel18: TXLabel;
    EditLastNameOld: TXEDBEdit;
    XLabel19: TXLabel;
    EditFirstNameOld: TXEDBEdit;
    XLabel20: TXLabel;
    EditMiddleNameOld: TXEDBEdit;
    XLabel21: TXLabel;
    EditDateBirthOld: TXEDBDateEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var FormPerson: TFormPerson;

Implementation
uses XMisc;

{$R *.DFM}

Initialization
  RegisterAliasXForm('FormPerson', TFormPerson);
Finalization
  UnRegisterXForm(TFormPerson);
end.
