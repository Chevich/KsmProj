unit DlgAct;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DiDate, StdCtrls, Buttons, Mask, ToolEdit, RXCtrls, ExtCtrls, MdBase, MdCommon,
  MdOrgs, MdContr, DBCtrls, EtvLook, XECtrls, Db;

type
  TDialAct = class(TDialDate)
    LabelCurrency: TRxLabel;
    LookupCurrency: TXEDBLookupCombo;
    LookupClient: TXEDBLookupCombo;
    LabelClient: TRxLabel;
    LabelTare: TRxLabel;
    LookupTare: TXEDBLookupCombo;
    LabelDaysOnWay: TRxLabel;
    EditDaysOnWay: TMaskEdit;
    LabelAccount: TRxLabel;
    LookupAccount: TXEDBLookupCombo;
    LabelContract: TRxLabel;
    LookupContract: TXEDBLookupCombo;
    EditAddParam: TMaskEdit;
    procedure LookupContractEnter(Sender: TObject);
    function LookupAccountFilter(Sender: TObject): String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialAct: TDialAct;

implementation

{$R *.DFM}

procedure TDialAct.LookupContractEnter(Sender: TObject);
begin
  inherited;
  LookUpContract.LookupFilterKey:=LookupClient.Text;
end;

function TDialAct.LookupAccountFilter(Sender: TObject): String;
begin
  inherited;
  Result:='InteractionAssetsFlag>0';
end;

end.
