unit DiFind;

interface

uses Windows,forms,StdCtrls,Db,ExtCtrls,Controls,Classes,Buttons;

type
  TDialFind = class(TForm)
    Bevel1: TBevel;
    Panel: TPanel;
    BtnFind: TBitBtn;
    BtnCancel: TBitBtn;
    DataSource: TDataSource;
    CheckBoxCase: TCheckBox;
    CheckBoxNoPartial: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialFind: TDialFind;

implementation

Uses Messages,DBCtrls,
     EtvConst;

{$R *.DFM}

procedure TDialFind.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if (Self.ActiveControl is TDBEdit) or (Self.ActiveControl is TDBLookupComboBox) then begin
    if (Self.ActiveControl is TDBLookupComboBox) then
      TDBLookupComboBox(Self.ActiveControl).closeup(true);
    PostMessage(TWinControl(Sender).Handle,wm_KeyDown,VK_TAB,0);
    {CanClose:=False;}
  end;
end;

procedure TDialFind.FormCreate(Sender: TObject);
begin
  Caption:=SKeyDlgCaption;
  BtnFind.Caption:=SFindBtnCaption;
  BtnCancel.Caption:=SCancelCaption;
  CheckBoxCase.Caption:=SCaseSensitive;
  CheckBoxNoPartial.Caption:=SKeyDlgNoPartialKey;
end;

end.
