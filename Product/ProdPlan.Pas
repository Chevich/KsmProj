unit ProdPlan;

interface

uses
  BEForms, DBCtrls, EtvContr, XECtrls, StdCtrls, Mask, ToolEdit, RXDBCtrl,
  EtvLook, Controls, RXCtrls, XCtrls, DBIndex,
  ExtCtrls, Grids, DBGrids, EtvGrid, ComCtrls, Classes, XMisc,
  EtvRXCtl, SrcIndex, XDBForms, MBEForms, Vg, XETrees, EtvPages, RXSplit;

type
  TFormProdPlan = class(TMBEForm)
    XLabel1: TXLabel;
    EditGrProdName: TXEDBLookupCombo;
    EditDateP: TXEDBDateEdit;
    XLabel2: TXLabel;
    EditProdName: TXEDBLookupCombo;
    XLabel4: TXLabel;
    EditShopName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    EditSPlan: TXEDBEdit;
    XLabel3: TXLabel;
    TreeViewWork: TXEDBTreeView;
    LabelAmountDown: TXLabel;
    DBTextAmountDown: TEtvDBText;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel1: TPanel;
    LabelKod: TXLabel;
    LabelKodUp: TXLabel;
    LabelName: TXLabel;
    EditKod: TXEDBEdit;
    EditLookUpKodUp: TXEDBLookupCombo;
    XEDBEdit1: TXEDBEdit;
    XLabel6: TXLabel;
    XEDBLookupCombo1: TXEDBLookupCombo;
    LabelProdName: TXLabel;
    EditLookUpProdName: TXEDBLookupCombo;
    DateFilterBtn: TRxSpeedButton;
    DateEdit1: TDateEdit;
    ReportBtn: TRxSpeedButton;
    Calc51Btn: TRxSpeedButton;
    XLabel7: TXLabel;
    XLabel8: TXLabel;
    EditLookUpProdNameEditLookUpProd2Name: TXEDBLookupCombo;
    EditLookupTareName: TXEDBLookupCombo;
    procedure DateFilterBtnClick(Sender: TObject);
    procedure TreeViewWorkChange(Sender: TObject; Node: TTreeNode);
    procedure ReportBtnClick(Sender: TObject);
    procedure Calc51BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
{
var
  FormProdPlan: TFormProdPlan;
}
implementation

uses SysUtils, MdProd, sForm, Dialogs, EtvDBFun, MdClientsAdd;

{$R *.DFM}

procedure TFormProdPlan.DateFilterBtnClick(Sender: TObject);
begin
  inherited;
  with ModuleProd.WorkDayDeclar do begin
    DisableControls;
    if DateFilterBtn.Down then begin
(*
      if MessageDlg('УСТАНОВИТЬ ДАТУ РАБОТЫ С ЗАДАЧЕЙ '+DateEdit1.Text+'?',mtConfirmation,[mbYes,mbCancel],0)<>
        mrYes then Exit;
      if MessageDlg('ПРИ РАБОТЕ С ДАТОЙ '+DateEdit1.Text+' ПЕРВЫЙ РАЗ'+#13+
        'В РАБОЧЕЙ ТАБЛИЦЕ ДОБАВЛЯЮТСЯ НОВЫЕ СТРОКИ'+#13+
        'ВЫ УВЕРЕНЫ В СВОЕМ ВЫБОРЕ?',mtConfirmation,[mbYes,mbCancel],0)<>
        mrYes then Exit;
      ExecSQLText(DataBaseName,'call STA.WInitWorkDay('''+DateEdit1.Text+''')',false);
*)
      Filter:='sDate='''+DateEdit1.Text+'''';
      aDate:=DateEdit1.Date;
      //DateFilterBtn.Down:=true;
    end else begin
      //DateFilterBtn.Down:=false;
      Filter:='1=2';
    end;
    EnableControls;
  end;
end;

procedure TFormProdPlan.TreeViewWorkChange(Sender: TObject;
  Node: TTreeNode);
  var aSet: variant;
begin
  inherited;
  with ModuleProd do begin
    aSet:=GetFromSQLText(WorkDayDeclar.DataBaseName,'Select GetSetOfMasters('+IntToStr(TvgDBTreeNode(Node).ID)+')',false);
    if aSet<>null then begin
      if not WSetsOfMastersDeclar.Active then WSetsOfMastersDeclar.Open;
      WSetsOfMastersDeclar.Locate('Kod',aSet,[]);
      WorkDayDeclarShift1.DisplayLabel:='Смена '+WSetsOfMastersDeclarWorkerName1.StringByLookName('LastName');
      WorkDayDeclarShift2.DisplayLabel:='Смена '+WSetsOfMastersDeclarWorkerName2.StringByLookName('LastName');
      WorkDayDeclarShift3.DisplayLabel:='Смена '+WSetsOfMastersDeclarWorkerName3.StringByLookName('LastName');
      WorkDayDeclarShift4.DisplayLabel:='Смена '+WSetsOfMastersDeclarWorkerName4.StringByLookName('LastName');
    end else begin
      WorkDayDeclarShift1.DisplayLabel:='Смена 1';
      WorkDayDeclarShift2.DisplayLabel:='Смена 2';
      WorkDayDeclarShift3.DisplayLabel:='Смена 3';
      WorkDayDeclarShift4.DisplayLabel:='Смена 4';
    end;
  end;
end;

procedure TFormProdPlan.ReportBtnClick(Sender: TObject);
begin
  inherited;
  with ModuleProd do begin
    WorkReportC.Execute;
    // Инициализация значений для запроса по даным формы
    TEdit(TBEForm(WorkReportC.Form).FindComponent('Edit'+'WorkReport')).Text:=
      IntToStr(TvgDBTreeNode(TreeViewWork.Selected).ID);
    TDateEdit(TBEForm(WorkReportC.Form).FindComponent('ReportPeriod'+'WorkReport')).Text:=DateEdit1.Text;
    WorkReportC.Form.SetFocus;
    ModuleClientsAdd.CalcReportClick(TBEForm(WorkReportC.Form).FindComponent('BtnCalc'+'WorkReport'));
  end;
end;

procedure TFormProdPlan.Calc51BtnClick(Sender: TObject);
begin
  inherited;
  ExecSQLText(ModuleProd.WorkDayDeclar.DataBaseName,'STA.WorkCalcBranch51('''+DateEdit1.Text+''')',false);
  ShowMessage('Расчет по ветке 51-Расформовка за '+DateEdit1.Text+' произведен');
end;

Initialization
  RegisterAliasXForm('FormProdPlan', TFormProdPlan);
Finalization
  UnRegisterXForm(TFormProdPlan);
end.
 