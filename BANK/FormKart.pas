unit FormKart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EtvFind, Db, Grids, DBGrids, EtvGrid, StdCtrls, DBIndex, DBCtrls,
  Buttons, ExtCtrls, ComCtrls, RXCtrls, Mask, EtvLook, RXSwitch, RXDBCtrl,
  EtvContr,fBase, EtvFilt, Menus, EtvPages, EtvSort;

type
  TFormKartoteka = class(TFormBase)
    ComboBox1: TComboBox;
    TabSKarta: TTabSheet;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBEdit7: TDBEdit;
    RxLabel2: TRxLabel;
    Panel2: TPanel;
    CheckBoxOrg: TCheckBox;
    RxLabel3: TRxLabel;
    DBText1: TDBText;
    EtvDbGrid1: TEtvDbGrid;
    DBNavigator1: TDBNavigator;
    RxLabel4: TRxLabel;
    DBText2: TDBText;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxOrgClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure SBFilterPanelClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure CheckAroundFilter; override;
  end;

var
  FormKartoteka: TFormKartoteka;

implementation
uses DataMod1,DataMod2,EtvTable;
{$R *.DFM}

procedure TFormKartoteka.CheckAroundFilter;
begin
  inherited;
  Dm2.QSum.Close;
  while Dm2.QSum.Sql.Count>1 do
    Dm2.QSum.Sql.Delete(Dm2.QSum.Sql.Count-1);
  if Efilter.Used<>fuNone then
    Dm2.QSum.Sql.Add('Where '+EFilter.ConstructFilter(nil,true,Efilter.Used));
  Dm2.QSum.Open;
end;

procedure TFormKartoteka.ComboBox1Change(Sender: TObject);
var s:string;
begin
  inherited;
  s:='';
  if Assigned(DataSource.Dataset) and DataSource.Dataset.Active then begin
    case ComboBox1.ItemIndex of
      1: s:='(NKart=99814)';
      2: s:='(NKart=99812)';
    end;
    if (CheckBoxOrg.Checked) and (DataSource.Dataset.FieldByName('MFO').AsString<>'') then begin
      if s<>'' then s:=s+' and ';
      s:=s+'(MFO='+DataSource.Dataset.FieldByName('MFO').AsString
          +') and (BCount='+DataSource.Dataset.FieldByName('BCount').AsString+')';
    end;

    EFilter.SetExternalInfo(nil,s);
    if Efilter.Used<>fuSet then EFilter.Used:=fuExternalSet
    else EFilter.Used:=fuSet;
    CheckAroundFilter;
  end;
end;

procedure TFormKartoteka.FormCreate(Sender: TObject);
begin
  inherited;
  ComboBox1.ItemIndex:=0;
  dm2.QKartA.Open;
  dm2.qsum.open;
  Panel2.Top:=PageControl1.Top+1;
end;

procedure TFormKartoteka.CheckBoxOrgClick(Sender: TObject);
begin
  inherited;
  ComboBox1Change(Sender);
end;

procedure TFormKartoteka.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dm2.qsum.close;
  dm2.QKartA.Close;
end;

procedure TFormKartoteka.Button1Click(Sender: TObject);
begin
  inherited;
  EtvDBGrid.Total:=Not EtvDBGrid.total;
end;

procedure TFormKartoteka.SBFilterPanelClick(Sender: TObject);
begin
  inherited;
  if FilterPanel.visible then Panel2.Top:=Panel2.top+fFilterPanelHeight
  else Panel2.Top:=Panel2.top-fFilterPanelHeight;
end;

end.
