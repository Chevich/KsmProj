unit selectBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, RXCtrls, XCtrls, StdCtrls, DBCtrls, EtvList, XECtrls, EtvLook,
  Db, LnkSet;

type
  TFormSelect = class(TForm)
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DepotLookup: TXEDBLookupCombo;
    DataSource1: TDataSource;
    MaterialLookup: TXEDBLookupCombo;
    DataSource2: TDataSource;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Depot:Integer;
    Material:Integer;
  end;

var
  FormSelect: TFormSelect;

implementation
Uses mdMaterials,MdBase;
{$R *.DFM}

procedure TFormSelect.SpeedButton1Click(Sender: TObject);
begin
  if (MaterialLookup.KeyValue<>null) then
    Material:=Integer(MaterialLookup.KeyValue);
  if (DepotLookup.KeyValue<>null) then
    Depot:=Integer(DepotLookup.KeyValue);
  if Depot<>0 then ModalResult:=mrOk
    else begin showMessage('Выберете склад!!!'); abort; end;
end;

procedure TFormSelect.SpeedButton2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TFormSelect.FormCreate(Sender: TObject);
begin
  Depot:=0;
  Material:=0;
end;

end.
