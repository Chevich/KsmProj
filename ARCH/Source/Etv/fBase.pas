unit fBase;

interface

uses Windows, Classes, Controls, StdCtrls, Forms, DBCtrls, DB,
     DBGrids, Grids, ExtCtrls, Menus, Buttons, ComCtrls,
     EtvGrid,EtvFind,EtvContr,EtvForms,EtvFilt,EtvPages,EtvSort;

{$I Etv.inc}

type
  TFormBase = class(TFormDB)
    Panel1: TPanel;
    DBNav: TDBNavigator;
    DBSortingCombo: TEtvDBSortingCombo;
    FindDlg: TEtvFindDlg;
    SpeedButton1: TSpeedButton;
    PageControl1: TEtvPageControl;
    TabSGrid: TEtvTabSheet;
    EtvDbGrid: TEtvDbGrid;
    BitBtnOk: TBitBtn;
    SBFilterPanel: TSpeedButton;
    FilterPanel: TPanel;
    SBFilterEdit: TSpeedButton;
    SBFilterNone: TSpeedButton;
    SBFilterSet: TSpeedButton;
    ComboBoxFilterList: TComboBox;
    EFilter: TEtvFilter;
    SBFilterExternalSet: TSpeedButton;
    SpeedButtonTools: TSpeedButton;
    PopupMenuTools: TPopupMenu;
    ItemRefresh: TMenuItem;
    ItemPrinterSetup: TMenuItem;
    N1: TMenuItem;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EtvDbGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure SBFilterPanelClick(Sender: TObject);
    procedure SBFilterEditClick(Sender: TObject);
    procedure ComboBoxFilterListChange(Sender: TObject);
    procedure SBFilterSetClick(Sender: TObject);
    procedure SBFilterNoneClick(Sender: TObject);
    procedure SBFilterExternalSetClick(Sender: TObject);
    procedure SpeedButtonToolsClick(Sender: TObject);
    procedure ItemRefreshClick(Sender: TObject);
    procedure ItemPrinterSetupClick(Sender: TObject);
    { private declarations }
  protected
    fFilterPanelHeight:integer;
    procedure CheckAroundFilter; dynamic;
    procedure CheckFilterList;
  public
    {$IFNDEF Delphi4}
    function FormState: TFormState;
    {$ENDIF}
    constructor Create(AOwner: TComponent); override;
    procedure AddSetup; override;
  end;

var FormBase: TFormBase;

Function ToFormReport(ADataSet:TDataSet):TFormDB;

procedure RunEtvBaseDateSetEditor(aDataSet:TDataSet);

IMPLEMENTATION

uses Dialogs, Graphics,
     EtvBor,EtvPas,EtvConst,EtvDB,EtvDBFun;
{$R *.DFM}

{$IFNDEF Delphi4}
function TFormBase.FormState: TFormState;
begin
  Result:=TCustomFormBorland(Self).FFormState;
end;
{$ENDIF}

procedure TFormBase.AddSetup;
var Tabs:TTabSheet;
    Scroll:TScrollBox;
    i,j:integer;
    LabelFont:TFont;
    lAutoWidth,PageNeed:boolean;
begin
  PageNeed:=false;
  for i:=0 to DataSource.DataSet.FieldCount-1 do
    if (DataSource.DataSet.Fields[i] is TBlobField) and
       (DataSource.DataSet.Fields[i].Tag<>8) then begin
      PageNeed:=true;
      Break;
    end;
  if foAutoWidth in Options then
    lAutoWidth:=AutoWidth(EtvDBGrid.Canvas.TextWidth('0'),45,EtvDBGrid.TitleRows<=0)
  else lAutoWidth:=true;
  if (((Not lAutoWidth) or PageNeed) and (PageControl1.PageCount=1)) or
     (foPageOneRecord in Options) then begin
    TabsGrid.TabVisible:=true;
    Tabs:=TTabSheet.Create(Self);
    Tabs.Caption:=SOneRecordTabs;
    Tabs.PageControl:=PageControl1;
    Scroll:=TScrollBox.Create(Self);
    Scroll.Align:=alClient;
    Scroll.Width:=PageControl1.Width-8;
    Tabs.InsertControl(Scroll);
    if not DataSource.DataSet.CanModify then begin
      LabelFont:=TFont.Create;
      Scroll.Font.Style:=[fsBold];
    end else LabelFont:=nil;
    i:=0;
    for j:=0 to DataSource.DataSet.fieldCount-1 do
      if TField(DataSource.DataSet.fields[j]).tag<>8 then Inc(i);
    if i<=5 then ConstructOneRecordEdit(Scroll,DataSource,LabelFont,0,true,false)
    else ConstructOneRecordEdit(Scroll,DataSource,LabelFont,0,false,false);
    if Assigned(LabelFont) then LabelFont.Free;
  end;
End;

constructor TFormBase.Create(AOwner: TComponent);
begin
  inherited;
  Caption:=SfBaseCaption;
  BitBtnOk.Caption:=SButtonReturn;
  if TabsGrid.Caption='' then
    TabsGrid.Caption:=SGridTabs;
  fFilterPanelHeight:=28;
  ItemPrinterSetup.Caption:=SPrinterSetup;
  ItemRefresh.Caption:=SItemRefresh;
  if SpeedButton1.Hint='' then SpeedButton1.Hint:=SFindKeyDialogHint;
  if BitBtnOk.Hint='' then BitBtnOk.Hint:=SButtonReturnHint;
  if DBSortingCombo.Hint='' then DBSortingCombo.Hint:=SSortingComboHint;
  if SBFilterPanel.Hint='' then SBFilterPanel.Hint:=SButtonFilterPanelHint;
  if SBFilterEdit.Hint='' then SBFilterEdit.Hint:=SButtonFilterEditHint;
  if SBFilterSet.Hint='' then SBFilterSet.Hint:=SFilterDlgBtnSetHint;
  if SBFilterExternalSet.Hint='' then SBFilterExternalSet.Hint:=SFilterDlgBtnExternalSetHint;
  if SBFilterNone.Hint='' then SBFilterNone.Hint:=SFilterDlgBtnNoneHint;
  if ComboBoxFilterList.Hint='' then ComboBoxFilterList.Hint:=SComboFilterListHint;
end;

procedure TFormBase.FormCreate(Sender: TObject);
begin
  CheckDBNavHints(DBNav);
  if PageControl1.ActivePage=TabsGrid then
    ActiveControl:=EtvDBGrid;
end;

procedure TFormBase.SpeedButton1Click(Sender: TObject);
begin
  FindDlg.Execute;
end;

procedure TFormBase.EtvDbGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyReturn(Sender,Key,Shift);
end;                

procedure TFormBase.FormActivate(Sender: TObject);
begin
  if Assigned(FieldReturn) and
     (fsModal in FormState) then BitBtnOk.visible:=true
  else BitBtnOk.visible:=false;
  if (foDataReadOnly in Options) then begin
    DBNav.VisibleButtons:=[nbFirst,nbPrior,nbNext,nbLast,nbRefresh];
    EtvDBGrid.Options:=EtvDBGrid.Options-[dgEditing];
  end;
  CheckAroundFilter;
end;

procedure TFormBase.SBFilterPanelClick(Sender: TObject);
begin
  try
    if foPC1ChangeSize in Options then begin
      LockWindowUpdate(Self.handle);
      if FilterPanel.Visible then
        PageControl1.Height:=PageControl1.Height+fFilterPanelHeight
      else PageControl1.Height:=PageControl1.Height-fFilterPanelHeight;
    end;
    if SBFilterPanel.down then begin
      FilterPanel.Height:=fFilterPanelHeight;
      FilterPanel.visible:=true;
    end else FilterPanel.visible:=false;
  finally
    if foPC1ChangeSize in Options then LockWindowUpdate(0);
  end;
end;

procedure TFormBase.SBFilterEditClick(Sender: TObject);
begin
  EFilter.Execute;
  CheckAroundFilter;
end;

procedure TFormBase.CheckFilterList;
var i:smallint;
begin
  With ComboBoxFilterList do begin
    Items.Clear;
    for i:=0 to EFilter.Filters.Count-1 do
      Items.add(TFilterItem(EFilter.Filters[i]).Name);
    ItemIndex:=EFilter.CurFilter;
    Hint:=SListOfFilter;
    if EFilter.CurFilter>=0 then Hint:=Hint+#10+
      SCurrentFilter+EFilter.ConstructFilterInfo(nil);
  end;
end;

procedure TFormBase.CheckAroundFilter;
begin
  CheckFilterList;
  if EFilter.FilterExist then begin
    SBFilterSet.Enabled:=true;
    ComboBoxFilterList.Enabled:=true;
  end
  else begin
    SBFilterSet.Enabled:=false;
    ComboBoxFilterList.Enabled:=false;
  end;
  case EFilter.Used of
    fuNone: SBFilterNone.Down:=True;
    fuSet: SBFilterSet.Down:=True;
    fuExternalSet: SBFilterExternalSet.Down:=True;
  end;
  if EFilter.ExternalInfoExist then SBFilterExternalSet.Enabled:=true
  else SBFilterExternalSet.Enabled:=false;
end;

procedure TFormBase.ComboBoxFilterListChange(Sender: TObject);
begin
  try
    EFilter.CurFilter:=ComboBoxFilterList.ItemIndex;
  finally
    CheckAroundFilter;
  end;
end;

procedure TFormBase.SBFilterSetClick(Sender: TObject);
begin
  try
    EFilter.Used:=fuSet;
  finally
    CheckAroundFilter;
  end;
end;

procedure TFormBase.SBFilterExternalSetClick(Sender: TObject);
begin
  try
    EFilter.Used:=fuExternalSet;
  finally
    CheckAroundFilter;
  end;
end;

procedure TFormBase.SBFilterNoneClick(Sender: TObject);
begin
  EFilter.Used:=fuNone;
  CheckAroundFilter;
end;

Function ToFormReport(ADataSet:TDataSet):TFormDB;
begin
  Result:=ToFormParam(TFormBase,ADataSet,viShow,nil,'',[foDataReadOnly,foFreeOnClose]);
end;

procedure TFormBase.SpeedButtonToolsClick(Sender: TObject);
begin
  PopupMenuTools.Popup(SpeedButtonTools.ClientOrigin.X,
    SpeedButtonTools.ClientOrigin.Y+SpeedButtonTools.Height);
end;

procedure TFormBase.ItemRefreshClick(Sender: TObject);
begin
 RefreshDataOnForm(Self,True);
end;

procedure TFormBase.ItemPrinterSetupClick(Sender: TObject);
var PrinterSetupDialog:TPrinterSetupDialog;
begin
  PrinterSetupDialog:=TPrinterSetupDialog.Create(nil);
  try
    PrinterSetupDialog.Execute;
  finally
    PrinterSetupDialog.Free;
  end;
end;

procedure RunEtvBaseDateSetEditor(aDataSet:TDataSet);
var F:TFormDB;
begin
  F:=TFormBase.Create(nil);
  try
    F.CheckDataSet(aDataSet);
    if aDataSet.Active then begin
      F.AddSetup;
      F.ShowForm(viShowModal);
    end else F.Release;
    F:=nil;
  except
    if Assigned(F) then F.Release;
  end;
end;

initialization
  RunEtvDateSetEditor:=RunEtvBaseDateSetEditor;

end.
