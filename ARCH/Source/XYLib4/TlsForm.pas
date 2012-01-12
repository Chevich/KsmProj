{*******************************************************}
{                                                       }
{            X-library v.03.00                          }
{                                                       }
{   15.04.98                   				}
{                                                       }
{   Example DBTools form                                }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit TlsForm;

{N+,P+,S-,W-,R-}

Interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
     Menus, Forms, Dialogs, Buttons, ExtCtrls, DB, DBTables,
     XTFC, XTools;

type
  { TToolsForm }
  TToolsForm = class(TXToolForm)
    ReportsBtn: TSpeedButton;
    InquiryBtn: TSpeedButton;
    SearchBtn: TSpeedButton;
    ChangeBtn: TSpeedButton;
    CommonFindBtn: TSpeedButton;
    PrintBtn: TSpeedButton;
    StampBtn: TSpeedButton;
    TempBtn: TSpeedButton;
    FilterBtn: TSpeedButton;
    MainPanel: TPanel;
    SumBtn: TSpeedButton;
    CloseBtn: TSpeedButton;
    HelpBtn: TSpeedButton;
    ExitBtn: TSpeedButton;
    PutFilterBtn: TSpeedButton;
    ReturnOpenBtn: TSpeedButton;
    PrintPopup: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    StampPopup: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    F51: TMenuItem;
    F31: TMenuItem;
    CtrlF51: TMenuItem;
    CtrlF31: TMenuItem;
    AltDel1: TMenuItem;
    FilterPopup: TPopupMenu;
    ShiftF121: TMenuItem;
    F111: TMenuItem;
    CtrlF111: TMenuItem;
    F121: TMenuItem;
    CtrlF121: TMenuItem;
    N6: TMenuItem;
    ReturnCloseBtn: TSpeedButton;
    ClosePopup: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ExitPopup: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem8: TMenuItem;
    OrderPopup: TPopupMenu;
    VisibleItem: TMenuItem;
    MenuItem6: TMenuItem;
    SortItem: TMenuItem;
    ResultsItem: TMenuItem;
    ReportPopup: TPopupMenu;
    ReportItem: TMenuItem;
    MenuItem11: TMenuItem;
    N11: TMenuItem;
    InquiryPopup: TPopupMenu;
    MenuItem7: TMenuItem;
    EdInqItem: TMenuItem;
    MenuItem12: TMenuItem;
    FiltersItem: TMenuItem;
    FIlterMenuPopup: TPopupMenu;
    MenuItem13: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    CancelInqItem: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    AggrSelectItem: TMenuItem;
    N9: TMenuItem;
    CancelAggregateItem: TMenuItem;
    N23: TMenuItem;
    UniqueSortItem: TMenuItem;
    N12: TMenuItem;
    ContextItem: TMenuItem;
    N19: TMenuItem;
    FormatInqItemAsInDataBase: TMenuItem;
    SetAggregateItem: TMenuItem;
    AggrGroupByItem: TMenuItem;
    Excel1: TMenuItem;
    FormatInqItem: TMenuItem;
    procedure ExitBtnClick(Sender: TObject);
    procedure BtnClick(Sender: TObject);
    procedure ButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrintBtnClick(Sender: TObject);
    procedure TempBtnClick(Sender: TObject);
    procedure FilterBtnClick(Sender: TObject);
    procedure StampBtnClick(Sender: TObject);
    procedure PutFilterBtnClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure ChangeBtnClick(Sender: TObject);
    procedure ReportsBtnClick(Sender: TObject);
    procedure InquiryBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FReportStrings: TStrings;
    FDefReportStrings: TStrings;
    FDefReportIndex: Integer;
    FInquiryStrings: TStrings;
    FDefInquiryStrings: TStrings;
    FDefInquiryIndex: Integer;
    FFilterStrings: TStrings;
  public
    procedure SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);override;
    procedure ChangeHint(ATag: Integer; AHint: String); override;
    { При переключении фокуса с формы на форму необходимо контролировать  }
    { в каком состоянии (нажатом или отжатом) должны находиться некоторые }
    { кнопки (Фильтр,Суммирование - пока все) }
    procedure UpDateUpDownButttons;
  end;
{ TToolsForm }

Implementation

Uses DBCtrls, DBIndex, Splash, XMisc, XDBTFC;

{$R *.DFM}

{ TToolsForm }

Procedure TToolsForm.ChangeHint(ATag: Integer; AHint: String);
var i:byte;
begin
  case ATag of
    btCurrentFilter: FilterBtn.Hint:=AHint;
    btFilter: FilterBtn.Down:=True;
    btCancelFilter: FilterBtn.Down:=False;
{?!}
    btSum:
      begin
        if aHint='False' then
          SumBtn.Down:= False
        else if (aHint<>'') or SumBtn.Down then SumBtn.Down:=true;
        SubClick(SumBtn);
      end;
    btSumDown: SumBtn.Down:=true;
    btSumUp  : SumBtn.Down:=false;
    btResultCalc: SumBtn.Down:=AHint='True';
    btSetAggregate:
      begin
        VisibleItem.Enabled:=False;
        ResultsItem.Enabled:=False;
        FiltersItem.Enabled:=False;
        SortItem.Enabled:=False;
        ContextItem.Enabled:=False;
        UniqueSortItem.Enabled:=False;
        AggrSelectItem.Enabled:= False;
        AggrGroupByItem.Enabled:= False;
        SetAggregateItem.Enabled:= False;
        CancelAggregateItem.Enabled:= True;
        InquiryBtn.Enabled:=false;
      end;
    btCancelAggregate:
      begin
        InquiryBtn.Enabled:=True;
        VisibleItem.Enabled:=True;
        ResultsItem.Enabled:=True;
        FiltersItem.Enabled:=False;
        SortItem.Enabled:=True;
        ContextItem.Enabled:=True;
        UniqueSortItem.Enabled:=True;
        AggrSelectItem.Enabled:=True;
        AggrGroupByItem.Enabled:=True;
        SetAggregateItem.Enabled:=True;
        CancelAggregateItem.Enabled:=False;
      end;
  end;
end;

Procedure TToolsForm.BtnClick(Sender: TObject);
begin
  SubClick(Sender);
end;

Procedure TToolsForm.ExitBtnClick(Sender: TObject);
begin
  ExitPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.ButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SubSetFocus;
end;

Procedure TToolsForm.PrintBtnClick(Sender: TObject);
begin
  PrintPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.TempBtnClick(Sender: TObject);
begin
  if TempBtn.Down then FilterBtn.Enabled:=False
  else FilterBtn.Enabled:=True;
  if FilterBtn.Down then TComponent(Sender).Tag:=TComponent(Sender).Tag+128;
  SubClick(Sender);
  if FilterBtn.Down then TComponent(Sender).Tag:=TComponent(Sender).Tag-128;
end;

Procedure TToolsForm.FilterBtnClick(Sender: TObject);
var NewItem: TMenuItem;
    i: Integer;
begin
  if FilterBtn.Down then begin
    if Assigned(FFilterStrings) then begin
      for i:= 0 to FFilterStrings.Count-1 do begin
        FilterMenuPopup.Items.Remove(TMenuItem(FFilterStrings.Objects[i]));
        FFilterStrings.Objects[i].Free;
      end;
      FFilterStrings.Clear;
    end else FFilterStrings:= TStringList.Create;
    TFormControl(CurrentFormControl).GetToolStrings(btFilter, FFilterStrings);
    for i:= 0 to FFilterStrings.Count-1 do begin
      NewItem := TMenuItem.Create(Self);
      NewItem.Caption := FFilterStrings[i];
      if Assigned(FFilterStrings.Objects[i]) then NewItem.Checked:= True;
      FFilterStrings.Objects[i]:=NewItem;
      NewItem.Tag:= btFilter+i;
      NewItem.OnClick:= BtnClick;
      FilterMenuPopup.Items.Insert(i, NewItem);
    end;
    FilterMenuPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
  end else begin
    if TempBtn.Down then TComponent(Sender).Tag:=TComponent(Sender).Tag+128;
    SubClick(Sender);
    if TempBtn.Down then TComponent(Sender).Tag:=TComponent(Sender).Tag-128;
  end;
end;

Procedure TToolsForm.StampBtnClick(Sender: TObject);
begin
  StampPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.PutFilterBtnClick(Sender: TObject);
begin
  FilterPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.CloseBtnClick(Sender: TObject);
begin
  ClosePopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);
begin
  Inherited;
  ReturnCloseBtn.Enabled:=IsReturnClose;
  ReturnOpenBtn.Enabled:=IsReturnOpen;
end;

Procedure TToolsForm.ChangeBtnClick(Sender: TObject);
begin
  OrderPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.ReportsBtnClick(Sender: TObject);
var NewItem: TMenuItem;
    i: Integer;
begin
  if Assigned(FDefReportStrings) then begin
    for i:= 0 to FDefReportStrings.Count-1 do begin
      ReportPopup.Items.Remove(TMenuItem(FDefReportStrings.Objects[i]));
      FDefReportStrings.Objects[i].Free;
    end;
    FDefReportStrings.Clear;
  end else FDefReportStrings:= TStringList.Create;
  TFormControl(CurrentFormControl).GetToolStrings(btDefReport, FDefReportStrings);
  if Assigned(FReportStrings) then begin
    for i:= 0 to FReportStrings.Count-1 do begin
      ReportPopup.Items.Remove(TMenuItem(FReportStrings.Objects[i]));
      FReportStrings.Objects[i].Free;
    end;
    FReportStrings.Clear;
  end else FReportStrings:= TStringList.Create;
  TFormControl(CurrentFormControl).GetToolStrings(btUserReport, FReportStrings);
  FDefReportIndex:= FDefReportStrings.Count+1;
  for i:= 0 to FDefReportStrings.Count-1 do begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := FDefReportStrings[i];
    FDefReportStrings.Objects[i]:=NewItem;
    NewItem.Tag:= btDefReport+i;
    NewItem.OnClick:= BtnClick;
    ReportPopup.Items.Insert(i, NewItem);
  end;
  for i:= 0 to FReportStrings.Count-1 do begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := FReportStrings[i];
    FReportStrings.Objects[i]:=NewItem;
    NewItem.Tag:= btUserReport+i;
    NewItem.OnClick:= BtnClick;
    ReportPopup.Items.Insert(FDefReportIndex+i, NewItem);
  end;
  ReportPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

Procedure TToolsForm.InquiryBtnClick(Sender: TObject);
var NewItem: TMenuItem;
    i: Integer;
begin
  if Assigned(FDefInquiryStrings) then begin
    for i:= 0 to FDefInquiryStrings.Count-1 do begin
      InquiryPopup.Items.Remove(TMenuItem(FDefInquiryStrings.Objects[i]));
      FDefInquiryStrings.Objects[i].Free;
    end;
    FDefInquiryStrings.Clear;
  end else FDefInquiryStrings:= TStringList.Create;
  TFormControl(CurrentFormControl).GetToolStrings(btDefInquiry, FDeFInquiryStrings);
  if Assigned(FInquiryStrings) then begin
    for i:= 0 to FInquiryStrings.Count-1 do begin
      InquiryPopup.Items.Remove(TMenuItem(FInquiryStrings.Objects[i]));
      FInquiryStrings.Objects[i].Free;
    end;
    FInquiryStrings.Clear;
  end else FInquiryStrings:= TStringList.Create;
  TFormControl(CurrentFormControl).GetToolStrings(btUserInQuiry, FInquiryStrings);
  FDefInquiryIndex:= FDeFInquiryStrings.Count+1;
  for i:= 0 to FDefInquiryStrings.Count-1 do begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := FDefInquiryStrings[i];
    FDefInquiryStrings.Objects[i]:=NewItem;
    NewItem.Tag:= btDefInquiry+i;
    NewItem.OnClick:= BtnClick;
    InquiryPopup.Items.Insert(i, NewItem);
  end;
  for i:= 0 to FInquiryStrings.Count-1 do begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := FInquiryStrings[i];
    FInquiryStrings.Objects[i]:=NewItem;
    NewItem.Tag:= btUserInquiry+i;
    NewItem.OnClick:= BtnClick;
    InquiryPopup.Items.Insert(FDefInquiryIndex+i, NewItem);
  end;
  InquiryPopup.Popup(Left+TSpeedButton(Sender).Left, Top+TSpeedButton(Sender).Top);
end;

procedure TToolsForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FFilterStrings) then FFilterStrings.Free;
  if Assigned(FDefInquiryStrings) then FDefInquiryStrings.Free;
  if Assigned(FInquiryStrings) then FInquiryStrings.Free;
  if Assigned(FDefReportStrings) then FDefReportStrings.Free;
  if Assigned(FReportStrings) then FReportStrings.Free;
end;

procedure TToolsForm.UpDateUpDownButttons;
begin
  {if CurrentFormControl}
end;

Initialization
  RegisterAliasXTool(tcDefaultClass, TToolsForm);
Finalization
  UnRegisterXTool(TToolsForm);
end.
 