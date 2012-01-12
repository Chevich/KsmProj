unit Menu;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, Buttons, ExtCtrls, StdCtrls, DB, DBTables,
  ComCtrls, ToolWin, DBCtrls, ImgList;

type
  TFormMenu = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N33: TMenuItem;
    N37: TMenuItem;
    N15: TMenuItem;
    N2: TMenuItem;
    N51: TMenuItem;
    N4: TMenuItem;
    N19: TMenuItem;
    N21: TMenuItem;
    ForLev1: TMenuItem;
    N34: TMenuItem;
    N20: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList2: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    N23: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    N22: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure ForLev1Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMenu: TFormMenu;

implementation
uses etvDB,EtvForms,fBase,datamod1, about, datamod2, DatamodV, DatamodC, DiDate1, DModPr;
{$R *.DFM}

procedure TFormMenu.N34Click(Sender: TObject);
begin
  DMV.TbVal.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N6Click(Sender: TObject);
begin
  DM1.TbSprCo.OnEditData(Self,viShow,nil);
end;
procedure TFormMenu.N15Click(Sender: TObject);
begin
  DM1.TbSprPlace.OnEditData(Self,viShow,nil);
end;
procedure TFormMenu.N18Click(Sender: TObject);
begin
  DM1.TbSprVa.OnEditData(Self,viShow,nil);
end;
procedure TFormMenu.N33Click(Sender: TObject);
begin
  DM1.TbSprBa.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N17Click(Sender: TObject);
begin
  DM1.TbSprPP.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N4Click(Sender: TObject);
begin
  DM1.TbSprKu.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N21Click(Sender: TObject);
begin
  DM1.TbSprTD.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.ForLev1Click(Sender: TObject);
begin
  DM1.TbSprTOp.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N8Click(Sender: TObject);
begin
  AboutForm:=TAboutForm.Create(Self);
  AboutForm.ShowModal;
end;

procedure TFormMenu.N13Click(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TFormMenu.N14Click(Sender: TObject);
begin
  Close;
end;

procedure TFormMenu.N16Click(Sender: TObject);
begin
  DM2.TbKart.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N20Click(Sender: TObject);
begin
  DM1.TbSprBCount.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N2Click(Sender: TObject);
begin
  DMV.TbValC.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N51Click(Sender: TObject);
begin
  DMC.TbPay.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N23Click(Sender: TObject);
begin
  DM1.TbSprTPlace.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N10Click(Sender: TObject);
begin
  if not Assigned(DialDate1) then begin
    DialDate1:=TDialDate1.create(Application);
    DialDate1.EditDateBeg.Date:=dm1.TBConfDatePay.value;
  end;
  if (DialDate1.ShowModal=mrOk) and (DialDate1.EditDateBeg.Date>0) then
    dmc.PrintPayOnDate(DialDate1.EditDateBeg.Text);
end;

procedure TFormMenu.N11Click(Sender: TObject);
begin
  DMV.PrintValut;
end;

procedure TFormMenu.N22Click(Sender: TObject);
begin
  DM1.TbSprTax.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N24Click(Sender: TObject);
var s,cap:string;
    Year, Month, Day:word;
begin
  DecodeDate(Now, Year, Month, Day);
  s:=IntToStr(Year);
  if InputQuery('Налоги за год','Введите год',s) then begin
    if s='' then s:=IntToStr(Year);
    cap:=DmPrint.QTaxYear.Caption;
    DmPrint.QTaxYear.Caption:=DmPrint.QTaxYear.Caption+' за '+s;
    DmPrint.QTaxYear.Params.ParamByName('Year').value:=StrToInt(s);
    ToFormReport(DmPrint.QTaxYear);
    DmPrint.QTaxYear.Caption:=cap;
  end;
end;

procedure TFormMenu.N25Click(Sender: TObject);
begin
  DMV.TbValVerb.OnEditData(Self,viShow,nil);
end;

procedure TFormMenu.N27Click(Sender: TObject);
begin
  DM1.TbBankProtocols.OnEditData(Self,viShow,nil);
end;

end.
