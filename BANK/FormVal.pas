unit FormVal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EtvFind, Db, Grids, DBGrids, EtvGrid, StdCtrls, DBIndex, DBCtrls,
  Buttons, ExtCtrls, ComCtrls, RXDBCtrl, RXCtrls, EtvLook, Mask, ToolEdit,
  EtvContr,fBase, EtvFilt, Menus, EtvPages, EtvSort;

type
  TFormValut = class(TFormBase)
    CheckBox1: TCheckBox;
    DBText1: TDBText;
    CheckBox2: TCheckBox;
    PanelCalc: TPanel;
    Label2: TLabel;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    EtvDBLookupCombo1: TEtvDBLookupCombo;
    Label4: TLabel;
    DateEdit1: TDateEdit;
    Label5: TLabel;
    LabelDateCourse: TLabel;
    RxLabel1: TRxLabel;
    LabelResult: TLabel;
    EtvDBLookupCombo2: TEtvDBLookupCombo;
    LabelCourse1: TLabel;
    LabelCourse2: TLabel;
    Label1: TLabel;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure DateEdit1AcceptDate(Sender: TObject; var Date: TDateTime;
      var Action: Boolean);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormValut: TFormValut;

implementation
uses datamod1,dbtables, DatamodV,etvPas;
{$R *.DFM}

procedure TFormValut.CheckBox1Click(Sender: TObject);
const s='KodOwner=1';
var fChange:boolean;
begin
  inherited;
  fChange:=false;
  if Assigned (DataSource.DataSet) then begin
    if (CheckBox1.checked) or (CheckBox2.checked) then begin
      if CheckBox1.checked then begin
        if DataSource.DataSet.tag<>8 then begin
          DataSource.DataSet.tag:=8;
          fChange:=true;
        end
      end else
        if DataSource.DataSet.tag<>0 then begin
          DataSource.DataSet.tag:=0;
          fChange:=true;
        end;
      if CheckBox2.Checked then begin
        if DataSource.DataSet.Filter<>s then begin
          DataSource.DataSet.Filter:=s;
          fChange:=false;
        end;
      end else
        if DataSource.DataSet.filter<>'' then begin
          DataSource.DataSet.filter:='';
          fChange:=false;
        end;
      if not DataSource.DataSet.Filtered then
        DataSource.DataSet.Filtered:=true
      else if fChange then begin
        DataSource.DataSet.DisableControls;
        DataSource.DataSet.Filtered:=false;
        DataSource.DataSet.Filtered:=true;
        DataSource.DataSet.EnableControls;
      end;
    end else if DataSource.DataSet.Filtered then DataSource.DataSet.Filtered:=false;
  end;
end;

procedure TFormValut.FormActivate(Sender: TObject);
begin
  inherited;
  dmv.ResetU;
  CheckBox1Click(Self);
end;

procedure TFormValut.MaskEdit1Change(Sender: TObject);
var Summa,SummaResult,DateVal:Double;
    i:integer;
    DateKurs:string;
    aCourse1,aCourse2:Double;
begin
  SummaResult:=0;
  Val(Trim(MaskEdit1.Text),Summa,i);
  if (i=0) and (Summa>0) and (EtvDBLookupCombo1.KeyValue<>null) and
    (EtvDBLookupCombo2.KeyValue<>null) then begin
    if DateEdit1.Date>0 then DateVal:=DateEdit1.Date
    else DateVal:=Now;
    DMV.CalcCurrency(Summa,EtvDBLookupCombo1.KeyValue,EtvDBLookupCombo2.KeyValue,
      DateToStr(DateVal),SummaResult,DateKurs,aCourse1,aCourse2);
  end;
  if (SummaResult>0) then begin
    LabelResult.Caption:=FloatToStr(SummaResult);
    LabelDateCourse.Caption:=DateKurs;
    LabelCourse1.Caption:=FloatToStr(aCourse1);
    LabelCourse2.Caption:=FloatToStr(aCourse2);
  end else begin
    LabelResult.Caption:='';
    LabelDateCourse.Caption:='';
    LabelCourse1.Caption:='';
    LabelCourse2.Caption:='';
  end;
end;

procedure TFormValut.DateEdit1AcceptDate(Sender: TObject;
  var Date: TDateTime; var Action: Boolean);
begin
  MaskEdit1Change(Sender);
end;

procedure TFormValut.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  KeyReturn(Sender, Key, Shift);
end;

end.
