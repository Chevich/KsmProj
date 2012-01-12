unit DlgClient;

Interface

Uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, EtvLook, XECtrls, MdOrgs, Db, LnkSet;

type
  TDlgClientF = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    ClientLookup: TXEDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    LabelTimeCalcBalance: TLabel;
    procedure ClientLookupKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ClientLookupCloseUp(Sender: TObject);
  private
    Client: integer;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

var
  DlgClientF: TDlgClientF;

implementation

{$R *.DFM}

constructor TDlgClientF.Create(AOwner: TComponent);
begin
  Client:=0;
  inherited;
end;

procedure TDlgClientF.ClientLookupKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var aListVisible: boolean;
begin
  case Key of
    Word('Z'):
      if (ssCtrl in Shift) then begin
        if Not (ssShift in Shift) then Key:=0
        else with ModuleOrgs.OrgLookUp do begin
          aListVisible:=ClientLookUp.ListVisible;
          ClientLookUp.CloseUp(false);
          Active:=false;
          if ClientLookUp.ListField='Kod;Name' then begin
            ClientLookUp.ListField:='Name;Kod';
            {SQL[1]:='order by Name';}
            IndexFieldNames:='Name';
          end else begin
            ClientLookUp.ListField:='Kod;Name';
            {SQL[1]:='order by Kod';}
            IndexFieldNames:='Kod';
          end;
          Active:=true;
          if aListVisible then ClientLookUp.DropDown;
        end;
      end;
  end;
end;

procedure TDlgClientF.ClientLookupCloseUp(Sender: TObject);
begin
  if (ClientLookUp.KeyValue<>null) and (ClientLookUp.KeyValue<>Client) then begin
    Client:=ClientLookUp.KeyValue;
    LabelTimeCalcBalance.Caption:=VarToStr(ModuleOrgs.GetClientTimeCalcBalance(Client));
  end;
end;

end.
