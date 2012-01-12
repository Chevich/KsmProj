{*******************************************************}
{                                                       }
{            X-library v.03.01                          }
{                                                       }
{   15.04.98                   				}
{                                                       }
{   Reports editor form                                 }
{                                                       }
{   Last corrections 09.07.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit FSetReps;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SrcIndex, Buttons, ExtCtrls, XDBTFC, UsersSet;

type
  TEdRepsForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    UserBox: TListBox;
    CaptionEdit: TEdit;
    TypeGroup: TRadioGroup;
    ExitBtn: TSpeedButton;
    CancelBtn: TSpeedButton;
    ReadBtn: TSpeedButton;
    WriteBtn: TSpeedButton;
    LeftBtn: TSpeedButton;
    RightBtn: TSpeedButton;
    AddBtn: TSpeedButton;
    DelBtn: TSpeedButton;
    ReportsCombo: TSrcLinkCombo;
    ReadInMemCheck: TCheckBox;
    EditReportBtn: TSpeedButton;
    NameEdit: TEdit;
    Label2: TLabel;
    ViewReportBtn: TSpeedButton;
    PrintBtn: TSpeedButton;
    PrintGroup: TRadioGroup;
    procedure ExitBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ReadBtnClick(Sender: TObject);
    procedure WriteBtnClick(Sender: TObject);
    procedure LeftBtnClick(Sender: TObject);
    procedure RightBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure ReportsComboChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EditReportBtnClick(Sender: TObject);
    procedure ViewReportBtnClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure PrintGroupClick(Sender: TObject);
  private
    FControl: TDBFormControl;
    FReports: TXReports;
    FUserSource: TUserSource;
    FCurrentReport: Integer;
    procedure GetCurrentReport;
    procedure SetCurrentReport;
    procedure SetReports(AValue: TXReports);
    procedure SetUserSource(AValue: TUserSource);
  public
    property Control: TDBFormControl read FControl write FControl;
    property Reports: TXReports read FReports write SetReports;
    property UserSource: TUserSource read FUserSource write SetUserSource;
    property CurrentReport: Integer read FCurrentReport write FCurrentReport;
  end;
{ TEdRepsForm }

var EdRepsForm: TEdRepsForm;

Implementation

{$IFDEF Report_Builder}
Uses DB, ppTypes, XReports;
{$ENDIF}

{$R *.DFM}

{ TEdRepsForm }
Procedure TEdRepsForm.GetCurrentReport;
begin
  if FReports.Count=0 then begin
    LeftBtn.Enabled:= False;
    RightBtn.Enabled:= False;
    DelBtn.Enabled:= False;
    EditReportBtn.Enabled:= False;
    ViewReportBtn.Enabled:= False;
    UserBox.ItemIndex:=-1;
    CaptionEdit.Text:='';
    NameEdit.Text:='';
    PrintBtn.Enabled:= False;
    PrintGroup.Enabled:= False;
  end else begin
    LeftBtn.Enabled:=True;
    RightBtn.Enabled:=True;
    DelBtn.Enabled:=True;
    EditReportBtn.Enabled:= True;
    ViewReportBtn.Enabled:= True;
    PrintGroup.Enabled:= True;
    PrintGroup.ItemIndex:= Ord(FReports[FCurrentReport].PrintActive);
    PrintBtn.Enabled:= FReports[FCurrentReport].PrintActive;
    if FCurrentReport=0 then begin
      LeftBtn.Enabled:=False;
    end;
    if FCurrentReport=FReports.Count-1 then begin
      RightBtn.Enabled:=False;
    end;
    if FReports[FCurrentReport].Caption='' then
      CaptionEdit.Text:='<Пусто>'
    else CaptionEdit.Text:=FReports[FCurrentReport].Caption;
    NameEdit.Text:=FReports[FCurrentReport].ReportName;
    UserBox.ItemIndex:=UserBox.Items.IndexOf(FReports[FCurrentReport].UserName);
    TypeGroup.ItemIndex:= Ord(FReports[FCurrentReport].TypeReport);
    ReadInMemCheck.Checked:= FReports[FCurrentReport].ReadInMem;
    ReportsCombo.ItemIndex:=ReportsCombo.Items.IndexOfObject(FReports[FCurrentReport]);
  end;
end;

Procedure TEdRepsForm.SetCurrentReport;
var aDataSet, bDataSet: TDataSet;
begin
  if FReports.Count>0 then begin
    if CaptionEdit.Text<>'<Пусто>' then
      FReports[FCurrentReport].Caption:= CaptionEdit.Text;
    FReports[FCurrentReport].ReportName:= NameEdit.Text;
    FReports[FCurrentReport].TypeReport:=TXReportType(TypeGroup.ItemIndex);
    if Assigned(FReports[FCurrentReport].PrintLink) and
    Assigned(FReports[FCurrentReport].PrintLink.DataCalc) then
    if Assigned(FControl) and Assigned(FControl.CurrentSource) and
    (FReports[FCurrentReport].TypeReport = rtSimple) then begin
      aDataSet:= FControl.CurrentSource.DataSet;
      bDataSet:= FReports[FCurrentReport].PrintLink.DataCalc.DataSet;
      FReports[FCurrentReport].PrintLink.DataCalc.DataSet:= aDataSet;
      if bDataSet<>aDataSet then begin
        FReports[FCurrentReport].PrintLink.DataCalc.Clear;
        if Assigned(aDataSet) then FReports[FCurrentReport].PrintLink.SetVisibleFields;
      end;
    end else FReports[FCurrentReport].PrintLink.DataCalc.DataSet:=nil;
    FReports[FCurrentReport].ReadInMem:= ReadInMemCheck.Checked;
    if UserBox.ItemIndex=-1 then FReports[FCurrentReport].UserName:=''
    else FReports[FCurrentReport].UserName:=UserBox.Items[UserBox.ItemIndex];
  end;
end;

Procedure TEdRepsForm.ExitBtnClick(Sender: TObject);
begin
  ModalResult:= mrOk;
  SetCurrentReport;
end;

Procedure TEdRepsForm.CancelBtnClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

Procedure TEdRepsForm.SetReports(AValue: TXReports);
begin
  FReports:= AValue;
  FCurrentReport:= 0;
  GetCurrentReport;
end;

Procedure TEdRepsForm.SetUserSource(AValue: TUserSource);
begin
  FUserSource:= AValue;
  if Assigned(FUserSource) then FUserSource.GetChangeUsers(UserBox.Items);
end;

Procedure TEdRepsForm.ReadBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then
    if MessageDlg('Восстановить объявления отчетов?',
    mtInformation, [mbYes, mbNo], 0)=mrYes then begin
      Reports.Clear;
      FControl.ReadUserData(nil, Reports);
      FCurrentReport:=0;
      GetCurrentReport;
    end;
end;

Procedure TEdRepsForm.WriteBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then
    if MessageDlg('Записать объявления отчетов?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
      SetCurrentReport;
      FControl.WriteUserData(FControl.Inquiries, Reports);
    end;
end;

Procedure TEdRepsForm.LeftBtnClick(Sender: TObject);
begin
  if FCurrentReport>0 then begin
    SetCurrentReport;
    Dec(FCurrentReport);
    GetCurrentReport;
  end;
end;

Procedure TEdRepsForm.RightBtnClick(Sender: TObject);
begin
  if FCurrentReport<FReports.Count-1 then begin
    SetCurrentReport;
    Inc(FCurrentReport);
    GetCurrentReport;
  end;
end;

Procedure TEdRepsForm.AddBtnClick(Sender: TObject);
begin
  FCurrentReport:=FReports.Add.Index;
  if Assigned(FControl) then begin
    FReports[FCurrentReport].Caption:= 'Отчет № '+IntToStr(FCurrentReport+1{+FControl.Reports.Count});
    if Assigned(FUserSource) then
      FReports[FCurrentReport].UserName:=FUserSource.DefUser;
    ReportsCombo.Items.AddObject(FReports[FCurrentReport].Caption, FReports[FCurrentReport]);
  end;
  GetCurrentReport;
end;

Procedure TEdRepsForm.DelBtnClick(Sender: TObject);
begin
  if MessageDlg('Удалить объявление отчета?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
    ReportsCombo.Items.Delete(FCurrentReport);
    FReports[FCurrentReport].Free;
    if (FReports.Count=FCurrentReport) and (FCurrentReport>0) then Dec(FCurrentReport);
    GetCurrentReport;
  end;
end;

Procedure TEdRepsForm.ReportsComboChange(Sender: TObject);
begin
  SetCurrentReport;
  FCurrentReport:= ReportsCombo.ItemIndex;
  GetCurrentReport;
end;

Procedure TEdRepsForm.FormActivate(Sender: TObject);
begin
  GetCurrentReport;
end;

Procedure TEdRepsForm.EditReportBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentReport;
    FControl.EditReport(FReports[FCurrentReport]);
  end;
end;

Procedure TEdRepsForm.ViewReportBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentReport;
    FControl.PlayReport(FReports[FCurrentReport]);
  end;
end;

Procedure TEdRepsForm.PrintBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentReport;
    if Assigned(FReports[FCurrentReport].PrintLink) then
      if FReports[FCurrentReport].PrintLink.ShowPrintDialog then begin
      end;
  end;
end;

Procedure TEdRepsForm.PrintGroupClick(Sender: TObject);
begin
  FReports[FCurrentReport].PrintActive:= Boolean(PrintGroup.ItemIndex);
  GetCurrentReport;
end;

end.
