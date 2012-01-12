unit MInvoiceCheckSS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, DBCtrls, EtvLook, XECtrls, RXCtrls, XCtrls, Db, StdCtrls,
  Buttons, ComCtrls;

type
  TFMInvoiceCheckSS = class(TForm)
    XLabel13: TXLabel;
    LookupEditAccount_SSName: TXEDBLookupCombo;
    Panel4: TPanel;
    XLabel11: TXLabel;
    XEDBLookupCombo1: TXEDBLookupCombo;
    Panel5: TPanel;
    XLabel12: TXLabel;
    XEDBLookupCombo2: TXEDBLookupCombo;
    dsAccount: TDataSource;
    dsObjZatr: TDataSource;
    dsStatRash: TDataSource;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ID: integer;
    function Execute(FID: integer): boolean;
  end;

var
  FMInvoiceCheckSS: TFMInvoiceCheckSS;

implementation
  uses mdMaterials, MdCommon, EtvDBFun;
{$R *.DFM}

{ TFMInvoiceCheckSS }

function TFMInvoiceCheckSS.Execute(FID: integer): boolean;
begin
  ID := FID;
  Self.Show;
  Result := True;
  Self.Caption:='Автом. присвоение ('+IntToStr(ID)+')';
end;

procedure TFMInvoiceCheckSS.FormCreate(Sender: TObject);
begin
  if not ModuleCommon.AccountLookup.Active then
    ModuleCommon.AccountLookup.Active := True;
  if not mdMat.MObjZatrLookup.Active then
    mdMat.MObjZatrLookup.Active := True;
  if not mdMat.MStatRashLookup.Active then
    mdMat.MStatRashLookup.Active := True;
end;

procedure TFMInvoiceCheckSS.btnOkClick(Sender: TObject);
begin
  try
  ExecSQLText(ModuleCommon.AccountLookup.DataBaseName,
     'call STA.SetMInvoiceT_SS('+IntToStr(ID)+','''+LookupEditAccount_SSName.Text+''','+
       XEDBLookupCombo1.Text+','+XEDBLookupCombo2.Text+',0.5);',false);
  except
  ModalResult:=mrOk;
  end;
  Close;
end;

procedure TFMInvoiceCheckSS.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
