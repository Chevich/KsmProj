{*******************************************************}
{                                                       }
{            X-library v.03.00                          }
{                                                       }
{   15.04.98                   				}
{                                                       }
{   Inquiries editor form                               }
{                                                       }
{   Last corrections 07.07.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit FSetInq;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, ComCtrls, ToolWin, ExtCtrls, SrcIndex, Buttons, XDBTFC, UsersSet,
     Menus, Mask;

type
  TEdInquiryForm = class(TForm)
    EditPanel: TPanel;
    VisCheck: TCheckBox;
    SortCheck: TCheckBox;
    SumCheck: TCheckBox;
    SumCalcAutoCheck: TCheckBox;
    NameEdit: TEdit;
    ToolPanel: TPanel;
    ExitBtn: TSpeedButton;
    ReadBtn: TSpeedButton;
    WriteBtn: TSpeedButton;
    LeftBtn: TSpeedButton;
    RightBtn: TSpeedButton;
    InquiryCombo: TSrcLinkCombo;
    UserBox: TListBox;
    Label1: TLabel;
    AddBtn: TSpeedButton;
    DelBtn: TSpeedButton;
    CancelBtn: TSpeedButton;
    FiltrBtn: TSpeedButton;
    CurrentBtn: TSpeedButton;
    VisLab: TLabel;
    SortLab: TLabel;
    SumLab: TLabel;
    IndexBtn: TSpeedButton;
    FiltersCheck: TCheckBox;
    IndexCheck: TCheckBox;
    LinkBtn: TSpeedButton;
    CancelLinkBtn: TSpeedButton;
    CurrIndexLab: TLabel;
    Bevel1: TBevel;
    FilterCombo: TSrcLinkCombo;
    FilterDialogCheck: TCheckBox;
    IFNsCombo: TSrcLinkCombo;
    IndexDialogCheck: TCheckBox;
    Label2: TLabel;
    ReportPanel: TPanel;
    ParamsRepBtn: TSpeedButton;
    Label3: TLabel;
    ReportsCombo: TSrcLinkCombo;
    ClearRepBtn: TSpeedButton;
    CreateRepBtn: TSpeedButton;
    DeleteRepBtn: TSpeedButton;
    CountCheck: TCheckBox;
    CountLab: TLabel;
    MinCheck: TCheckBox;
    MinLab: TLabel;
    MaxCheck: TCheckBox;
    MaxLab: TLabel;
    AverCheck: TCheckBox;
    AverLab: TLabel;
    PrintGroup: TRadioGroup;
    PrintBtn: TSpeedButton;
    FieldsPanel: TPanel;
    FieldsPopup: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    AggrSelectItem: TMenuItem;
    AggrGroupByItem: TMenuItem;
    AggrIndexCheck: TCheckBox;
    Label4: TLabel;
    AggregateCheck: TCheckBox;
    Label5: TLabel;
    CopyFrom: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    CopyTo: TMaskEdit;
    SpeedButton1: TSpeedButton;
    procedure ExitBtnClick(Sender: TObject);
    procedure LeftBtnClick(Sender: TObject);
    procedure RightBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure ReadBtnClick(Sender: TObject);
    procedure WriteBtnClick(Sender: TObject);
    procedure CurrentBtnClick(Sender: TObject);
    procedure VisBtnClick(Sender: TObject);
    procedure IFNOrderBtnClick(Sender: TObject);
    procedure FiltrBtnClick(Sender: TObject);
    procedure LinkBtnClick(Sender: TObject);
    procedure CancelLinkBtnClick(Sender: TObject);
    procedure InquiryComboChange(Sender: TObject);
    procedure FilterComboChange(Sender: TObject);
    procedure IndexBtnClick(Sender: TObject);
    procedure ParamsRepBtnClick(Sender: TObject);
    procedure ClearRepBtnClick(Sender: TObject);
    procedure ReportsComboChange(Sender: TObject);
    procedure DeleteRepBtnClick(Sender: TObject);
    procedure CreateRepBtnClick(Sender: TObject);
    procedure CountBtnClick(Sender: TObject);
    procedure IFNContextBtnClick(Sender: TObject);
    procedure PrintGroupClick(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure FieldsPanelClick(Sender: TObject);
    procedure AggrSelectItemClick(Sender: TObject);
    procedure AggrGroupByItemClick(Sender: TObject);
    procedure CopyButonClick(Sender: TObject);
  private
    FControl: TDBFormControl;
    FInquiries: TXInquiries;
    FUserSource: TUserSource;
    FCurrentLink: Integer;
    FIsLinkInquiry: Boolean;
    procedure SetUserSource(AValue: TUserSource);
    procedure SetInquiries(AValue: TXInquiries);
    procedure GetCurrentLink;
    procedure SetCurrentLink;
  public
    constructor Create(AOwner: TComponent); override;
    property Control: TDBFormControl read FControl write FControl;
    property Inquiries: TXInquiries read FInquiries write SetInquiries;
    property UserSource: TUserSource read FUserSource write SetUserSource;
    property CurrentLink: Integer read FCurrentLink write FCurrentLink;
    property IsLinkInquiry: Boolean read FIsLinkInquiry write FIsLinkInquiry;
  end;
{ TEdInquiryForm }

var EdInquiryForm: TEdInquiryForm;

Implementation

Uses LnkMisc, XDBMisc, FEdIFNs, ppTypes, LnkSet, XReports;

{$R *.DFM}

Constructor TEdInquiryForm.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FIsLinkInquiry:= False;
end;

Procedure TEdInquiryForm.GetCurrentLink;
begin
  if FInquiries.Count=0 then begin
    LeftBtn.Enabled:=False;
    RightBtn.Enabled:=False;
    DelBtn.Enabled:=False;
    CurrentBtn.Enabled:=False;
    ReportsCombo.Visible:=False;
    ParamsRepBtn.Enabled:=False;
    ClearRepBtn.Enabled:=False;
    UserBox.ItemIndex:=-1;
    NameEdit.Text:='';
    PrintBtn.Enabled:=False;
    PrintGroup.Enabled:=False;
  end else begin
    LeftBtn.Enabled:=True;
    RightBtn.Enabled:=True;
    DelBtn.Enabled:=True;
    CurrentBtn.Enabled:=True;
    ReportsCombo.Visible:=True;
    PrintGroup.Enabled:=True;
    PrintGroup.ItemIndex:=Ord(FInquiries[FCurrentLink].PrintActive);
    PrintBtn.Enabled:=FInquiries[FCurrentLink].PrintActive;
    if FCurrentLink=0 then begin
      LeftBtn.Enabled:=False;
    end;
    if FCurrentLink=FInquiries.Count-1 then begin
      RightBtn.Enabled:=False;
    end;
    if FInquiries[FCurrentLink].Caption='' then
      NameEdit.Text:='<Пусто>'
    else NameEdit.Text:=FInquiries[FCurrentLink].Caption;
    UserBox.ItemIndex:=UserBox.Items.IndexOf(FInquiries[FCurrentLink].UserName);
    {if UserBox.ItemIndex=-1 then UserBox.ItemIndex:=0;}
    SortLab.Caption:=FInquiries[FCurrentLink].IFNItem.Fields;
    SortCheck.Checked:= SortLab.Caption<>'';

    VisLab.Caption:= FInquiries[FCurrentLink].Calc.FieldNames;
    VisCheck.Checked:= VisLab.Caption<>'';
    CountLab.Caption:=FInquiries[FCurrentLink].Calc.GetCalcFieldNames(coResult, 'Count', False, ';', '');
    CountCheck.Checked:= CountLab.Caption<>'';
    SumLab.Caption:=FInquiries[FCurrentLink].Calc.GetCalcFieldNames(coResult, 'Sum', False, ';', '');
    SumCheck.Checked:= SumLab.Caption<>'';
    MinLab.Caption:=FInquiries[FCurrentLink].Calc.GetCalcFieldNames(coResult, 'Min', False, ';', '');
    MinCheck.Checked:= MinLab.Caption<>'';
    MaxLab.Caption:=FInquiries[FCurrentLink].Calc.GetCalcFieldNames(coResult, 'Max', False, ';', '');
    MaxCheck.Checked:= MaxLab.Caption<>'';
    AverLab.Caption:=FInquiries[FCurrentLink].Calc.GetCalcFieldNames(coResult, 'Avr', False, ';', '');
    AverCheck.Checked:= AverLab.Caption<>'';

    FiltersCheck.Checked:= FInquiries[FCurrentLink].Filters.Data.FilterExist;
    FilterCombo.Items.Clear;
    FInquiries[FCurrentLink].GetFilterNames(FilterCombo.Items);
    FilterCombo.ItemIndex:= FInquiries[FCurrentLink].FilterIndex;
    FilterDialogCheck.Checked:= FInquiries[FCurrentLink].FilterCheck;
    IndexCheck.Checked:= FInquiries[FCurrentLink].IFNLink.Count>0;
    IFNsCombo.Items.Clear;
    FInquiries[FCurrentLink].GetIFNsNames(IFNsCombo.Items);
{!!!     IFNsCombo.ItemIndex:= FInquiries[FCurrentLink].IFNsIndex;}
    IndexDialogCheck.Checked:= FInquiries[FCurrentLink].IndexCheck;
    InquiryCombo.ItemIndex:=InquiryCombo.Items.IndexOfObject(FInquiries[FCurrentLink]);

    ReportsCombo.ItemIndex:=ReportsCombo.Items.IndexOf(FInquiries[FCurrentLink].ReportName);
    ParamsRepBtn.Enabled:=ReportsCombo.ItemIndex<>-1;
    ClearRepBtn.Enabled:=ReportsCombo.ItemIndex<>-1;
    AggregateCheck.Checked:=FInquiries[FCurrentLink].AggrTemp;
    AggrIndexCheck.Checked:=FInquiries[FCurrentLink].AggrWithIndex;
    SumCalcAutoCheck.Checked:=FInquiries[FCurrentLink].Calc.SumCalcAuto;
  end;
end;

Procedure TEdInquiryForm.SetCurrentLink;
begin
  if FInquiries.Count>0 then begin
    if NameEdit.Text<>'<Пусто>' then FInquiries[FCurrentLink].Caption:= NameEdit.Text;
    if UserBox.ItemIndex=-1 then FInquiries[FCurrentLink].UserName:= ''
    else FInquiries[FCurrentLink].UserName:= UserBox.Items[UserBox.ItemIndex];
    FInquiries[FCurrentLink].FilterCheck:= FilterDialogCheck.Checked;
    FInquiries[FCurrentLink].IndexCheck:= IndexDialogCheck.Checked;
    FInquiries[FCurrentLink].AggrTemp:= AggregateCheck.Checked;
    FInquiries[FCurrentLink].AggrWithIndex:= AggrIndexCheck.Checked;
    FInquiries[FCurrentLink].Calc.SumCalcAuto:=SumCalcAutoCheck.Checked;
  end;
end;

Procedure TEdInquiryForm.SetUserSource(AValue: TUserSource);
begin
  FUserSource:= AValue;
  if Assigned(FUserSource) then FUserSource.GetChangeUsers(UserBox.Items);
end;

Procedure TEdInquiryForm.SetInquiries(AValue: TXInquiries);
begin
  FInquiries:= AValue;
  FCurrentLink:= 0;
  GetCurrentLink;
end;

Procedure TEdInquiryForm.ExitBtnClick(Sender: TObject);
begin
  ModalResult:= mrOk;
  SetCurrentLink;
end;

Procedure TEdInquiryForm.LeftBtnClick(Sender: TObject);
begin
  if FCurrentLink>0 then begin
    SetCurrentLink;
    Dec(FCurrentLink);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.RightBtnClick(Sender: TObject);
begin
  if FCurrentLink<FInquiries.Count-1 then begin
    SetCurrentLink;
    Inc(FCurrentLink);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.AddBtnClick(Sender: TObject);
begin
{  FInquiries.Add.Index:= FCurrentLink;}
  FCurrentLink:=FInquiries.Add.Index;
  if Assigned(FControl) then begin
    FInquiries[FCurrentLink].Source:= FControl.CurrentSource;
    FInquiries[FCurrentLink].Caption:= 'Запрос № '+IntToStr(FCurrentLink+1{+FControl.Inquiries.Count});
    if Assigned(FUserSource) then begin
      FInquiries[FCurrentLink].UserName:=FUserSource.DefUser;
      if (FInquiries[FCurrentLink].UserName='') and (FCurrentLink>0) then
        FInquiries[FCurrentLink].UserName:=FInquiries[0].UserName;
    end;
    InquiryCombo.Items.AddObject(FInquiries[FCurrentLink].Caption, FInquiries[FCurrentLink]);
  end;
  GetCurrentLink;
end;

Procedure TEdInquiryForm.DelBtnClick(Sender: TObject);
begin
  if MessageDlg('Удалить запрос?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
    InquiryCombo.Items.Delete(FCurrentLink);
    FInquiries[FCurrentLink].Free;
    if (FInquiries.Count=FCurrentLink) and (FCurrentLink>0) then Dec(FCurrentLink);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.FormActivate(Sender: TObject);
begin
  GetCurrentLink;
end;

Procedure TEdInquiryForm.CancelBtnClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

Procedure TEdInquiryForm.ReadBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then
    if MessageDlg('Восстановить запросы?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
      FIsLinkInquiry:= False;
      FControl.CurrentFilter:=nil;
      Inquiries.Clear;
      FControl.ReadUserData(Inquiries, nil);
      FCurrentLink:=0;
      GetCurrentLink;
    end;
end;

Procedure TEdInquiryForm.WriteBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then
    if MessageDlg('Записать запросы?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
      SetCurrentLink;
      FControl.WriteUserData(Inquiries,FControl.Reports);
    end;
end;

Procedure TEdInquiryForm.CurrentBtnClick(Sender: TObject);
var ASource: TLinkSource;
begin
  if Assigned(FControl) then begin
    ASource:= TLinkSource(FControl.CurrentSource);
    if (ASource is TLinkSource) and Assigned(ASource.DataSet) then begin
      FInquiries[FCurrentLink].Calc.Assign(TLinkSource(ASource).LinkMaster.Calc);
      FInquiries[FCurrentLink].Calc.FieldNames:=GetVisibleFieldNames(ASource.DataSet, True, True);

      if ASource.DataSet is TLinkTable then
        FInquiries[FCurrentLink].IFNItem.Fields:=TLinkTable(ASource.DataSet).IndexFieldNames;
      FInquiries[FCurrentLink].Filters.Assign(TLinkSource(ASource).LinkMaster.Filters);
      GetCurrentLink;
    end;
  end;
end;

Procedure TEdInquiryForm.VisBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetInquiryCalcFields(FInquiries[FCurrentLink], coVisible);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.IFNOrderBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetIFNOrder(FInquiries[FCurrentLink]);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.IFNContextBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetIFNContext(FInquiries[FCurrentLink]);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.FiltrBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    if FControl.SetSourceFilters(FInquiries[FCurrentLink])<>idCancel then
      FControl.ActivateFilter
    else if Assigned(FControl.CurrentFilter) then FControl.ActivateFilter;
    FIsLinkInquiry:= True;
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.LinkBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    FControl.PlayInquiry(FInquiries[FCurrentLink]);
    FIsLinkInquiry:= True;
  end;
end;

Procedure TEdInquiryForm.CancelLinkBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    FControl.PlayInquiry(nil);
    FIsLinkInquiry:= False;
  end;
end;

Procedure TEdInquiryForm.InquiryComboChange(Sender: TObject);
begin
  SetCurrentLink;
  FCurrentLink:= InquiryCombo.ItemIndex;
  GetCurrentLink;
end;

Procedure TEdInquiryForm.FilterComboChange(Sender: TObject);
begin
  if FilterCombo.Items.Count>0 then begin
    FInquiries[FCurrentLink].FilterIndex:= FilterCombo.ItemIndex;
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.IndexBtnClick(Sender: TObject);
begin
  EdIFNsForm:= TEdIFNsForm.Create(Application);
  EdIFNsForm.IFNLink:= FInquiries[FCurrentLink].IFNLink;
  EdIFNsForm.CurrentSource:= FControl.CurrentSource;
  EdIFNsForm.ShowModal;
  EdIFNsForm.Free;
end;

Procedure TEdInquiryForm.ParamsRepBtnClick(Sender: TObject);
var aParams: TPrintLink;
begin
  aParams:= TPrintLink.Create(pdText);
  with aParams do begin
    if ShowPrintDialog then begin
    end;
  end;
  aParams.Free;
end;

Procedure TEdInquiryForm.ClearRepBtnClick(Sender: TObject);
begin
  ReportsCombo.ItemIndex:=-1;
  FInquiries[FCurrentLink].ReportName:= '';
  GetCurrentLink;
end;

Procedure TEdInquiryForm.ReportsComboChange(Sender: TObject);
begin
  if (ReportsCombo.Items.Count>0) and (ReportsCombo.ItemIndex<>-1) then begin
    FInquiries[FCurrentLink].ReportName:= ReportsCombo.Items[ReportsCombo.ItemIndex];
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.DeleteRepBtnClick(Sender: TObject);
var i: Integer;
begin
  if Assigned(FControl) and (ReportsCombo.Items.Count>0) then begin
    i:=FControl.Reports.IndexOfCaption(FInquiries[FCurrentLink].ReportName);
    FControl.Reports[i].Free;
    FInquiries[FCurrentLink].ReportName:= '';
    ReportsCombo.Items.Delete(i);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.CreateRepBtnClick(Sender: TObject);
var Repitem: TXReportItem;
begin
  if Assigned(FControl) then begin
    RepItem:= FControl.Reports.SpecialAdd(rtSimple, pdText);
    FInquiries[FCurrentLink].ReportName:= RepItem.Caption;
    ReportsCombo.Items.Add(RepItem.Caption);
{     FCurrentLink:= ReportsCombo.Items.Count-1;}
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.CountBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetInquiryCalcFields(FInquiries[FCurrentLink], coResult);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.PrintBtnClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    if Assigned(FInquiries[FCurrentLink].PrintLink) then
      if FInquiries[FCurrentLink].PrintLink.ShowPrintDialog then begin
      end;
  end;
end;

Procedure TEdInquiryForm.PrintGroupClick(Sender: TObject);
begin
  FInquiries[FCurrentLink].PrintActive:= Boolean(PrintGroup.ItemIndex);
  GetCurrentLink;
end;

Procedure TEdInquiryForm.FieldsPanelClick(Sender: TObject);
begin
  FieldsPopup.Popup(Left+FieldsPanel.Left, Top+FieldsPanel.Top);
end;

Procedure TEdInquiryForm.AggrSelectItemClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetInquiryCalcFields(FInquiries[FCurrentLink], coAggregate);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.AggrGroupByItemClick(Sender: TObject);
begin
  if Assigned(FControl) then begin
    SetCurrentLink;
    FControl.SetInquiryGroupByCalcFields(FInquiries[FCurrentLink]);
    GetCurrentLink;
  end;
end;

Procedure TEdInquiryForm.CopyButonClick(Sender: TObject);
begin
  FCurrentLink:=StrToInt(CopyTo.Text);
  FInquiries.Insert(FCurrentLink);
  FInquiries[FCurrentLink].AssignLinkItem(FInquiries[StrToInt(CopyFrom.Text)]);
  if Assigned(FControl) then begin
    FInquiries[FCurrentLink].Source:= FControl.CurrentSource;
    FInquiries[FCurrentLink].Caption:= 'Запрос № '+IntToStr(FCurrentLink+1{+FControl.Inquiries.Count});
    if Assigned(FUserSource) then
      FInquiries[FCurrentLink].UserName:=FUserSource.DefUser;
    InquiryCombo.Items.AddObject(FInquiries[FCurrentLink].Caption, FInquiries[FCurrentLink]);
  end;
  GetCurrentLink;
end;

end.
   