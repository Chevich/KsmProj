unit Pay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EtvFind, Db, Grids, DBGrids, EtvGrid, ComCtrls, StdCtrls, DBIndex,
  DBCtrls, RXDBCtrl, Buttons, ExtCtrls, RXCtrls, EtvLook, Mask, ToolEdit,
  EtvContr,fBase, EtvFilt, Menus, EtvPages, EtvSort,EtvOther;

type
  TFormPay = class(TFormBase)
    TabSheet1: TTabSheet;
    EtvDbGrid1: TEtvDbGrid;
    TabSheet2: TTabSheet;
    EtvDbGrid2: TEtvDbGrid;
    Panel2: TPanel;
    SpeedButton3: TSpeedButton;
    DBNavigator2: TDBNavigator;
    DBIndexCombo1: TDBIndexCombo;
    Panel3: TPanel;
    EtvDBLCCounts: TEtvDBLookupCombo;
    DBNavigator1: TDBNavigator;
    Image1: TImage;
    CheckBoxDate: TCheckBox;
    DateEdit1: TDateEdit;
    EtvDBLCPayCount: TEtvDBLookupCombo;
    CheckBoxCount: TCheckBox;
    CheckBoxOrg: TCheckBox;
    SpeedButton4: TSpeedButton;
    DateEdit2: TDateEdit;
    SpeedButton2: TSpeedButton;
    StaticTextKredit: TStaticText;
    DBNavigator3: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure EtvDBLCCountsClick(Sender: TObject);
    procedure CheckBoxDateClick(Sender: TObject);
    procedure CheckBoxCountClick(Sender: TObject);
    procedure EtvDBLCPayCountClick(Sender: TObject);
    procedure CheckBoxOrgClick(Sender: TObject);
    procedure DateEdit1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton4Click(Sender: TObject);
    procedure DBIndexCombo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure TabSheet1Enter(Sender: TObject);
    procedure TabSheet1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    procedure resetFilter;
    procedure resetTotal;
    { Public declarations }
  end;

var
  FormPay: TFormPay;
  Procedure CreateOtherOnFilterSave(aEtvFilter:TComponent);
//  Procedure CreateOtherOnFilterLoad(aEtvFilter:TComponent);

implementation
uses DataMod1, DataModC, EtvPas, EtvTable, EtvDBFun;
{$R *.DFM}

procedure TFormPay.FormCreate(Sender: TObject);
begin
  inherited;
  DmC.QCounts.Open;
  Dm1.QSprBCount.First;
  EtvDbLCPayCount.KeyValue:=DM1.QSprBCountBCount.value;
  DateEdit1.Date:=dm1.TBConfDatePay.value;
  EtvDbLCCounts.KeyValue:=DM1.QSprBCountBCount.value;
  DMC.QCounts.Filtered:=true;
  EtvDBLCCountsClick(self);
end;

procedure TFormPay.EtvDBLCCountsClick(Sender: TObject);
begin
  if EtvDbLCCounts.KeyValue<>null then begin
    DMC.QCounts.Filter:='BCountEnterprise='''+EtvDBLCCounts.KeyValue+'''';
  end;
end;

procedure TFormPay.CheckBoxDateClick(Sender: TObject);
begin
  DateEdit1.Enabled:=CheckBoxDate.Checked;
  DateEdit2.Enabled:=CheckBoxDate.Checked;
  ResetFilter;
end;

procedure TFormPay.CheckBoxCountClick(Sender: TObject);
begin
  if CheckBoxCount.Checked then
    EtvDBLCPayCount.ListSource:=dm1.DSSprCount
  else EtvDBLCPayCount.ListSource:=nil;
  ResetFilter;
end;

procedure TFormPay.EtvDBLCPayCountClick(Sender: TObject);
begin
  ResetFilter;
end;

procedure TFormPay.CheckBoxOrgClick(Sender: TObject);
begin
  ResetFilter;
end;

procedure TFormPay.ResetFilter;
var s:string;
    fChange:boolean;
    BMark:TBookMark;
begin
  inherited;
  if Assigned(Datasource.Dataset) and DataSource.Dataset.Active then begin
    Screen.Cursor:=crHourglass;
    DataSource.DataSet.DisableControls;

    if (CheckBoxCount.checked) and (EtvDbLCPayCount.KeyValue<>null) then
      s:='(BCountEnterprise='''+EtvDBLCPayCount.KeyValue+''')';

    if CheckBoxDate.checked then begin
      if s<>'' then s:=s+' and ';
      if DateEdit2.date>DateEdit1.Date then
        s:=s+'(sDate>='''+DateToStr(DateEdit1.Date)+''') and'
            +'(sDate<='''+DateToStr(DateEdit2.Date)+''')'
      else s:=s+'(sDate='''+DateToStr(DateEdit1.Date)+''')';
    end;

    if (CheckBoxOrg.Checked) and
       ((dmC.TbPayMFO.AsString<>'') or (dmC.TbPayBCount.AsString<>'')) then begin
      if dmC.TbPayMFO.AsString<>'' then begin
        if s<>'' then s:=s+' and ';
        s:=s+'(MFO='''+dmC.TbPayMFO.AsString+''')';
      end;
      if dmC.TbPayBCount.AsString<>'' then begin
        if s<>'' then s:=s+' and ';
        s:=s+'(BCount='''+dmC.TbPayBCount.AsString+''')';
      end;
    end;

    BMark:=DataSource.DataSet.GetBookMark;
    FChange:=false;
    // добавлено Шурой
    if Trim(EFilter.ConstructFilter(nil,false,fuSet))<>'' then
    s:=s+' and '+EFilter.ConstructFilter(nil,false,fuSet);
    // конец
    if s<>'' then begin
      if s<>DataSource.Dataset.filter then begin
        DataSource.Dataset.filter:=s;
        FChange:=true;
      end;
      if not DataSource.Dataset.filtered then begin
        DataSource.Dataset.filtered:=true;
        FChange:=true;
      end;
    end else if DataSource.Dataset.filtered then begin
      DataSource.Dataset.filtered:=false;
      FChange:=true;
    end;
    if fChange then ResetTotal;
    if Assigned(BMark) then begin
      if fChange then
        TEtvTable(DataSource.DataSet).GotoBookMarkWOExcept(BMark);
      DataSource.DataSet.FreeBookMark(BMark);
    end;
    DataSource.DataSet.EnableControls;
    Screen.Cursor:=crDefault;
  end;
end;

procedure TFormPay.ResetTotal;
var CrossTotal:Currency;
begin
  if EtvDBGrid.Total then begin
  //  закаметарен, дабы иметь возможность видеть обороты по всем счетам. @Шура
{    if not ((CheckBoxCount.checked) and (EtvDbLCPayCount.KeyValue<>null)) then begin
      EtvDBGrid.SetItemTotal('SummaK','XXX');
      EtvDBGrid.SetItemTotal('SummaD','XXX');
    end
    else}
  // Конец странного куска :-)
    with dmc.QPayTotal.SQL do begin
      while Count>1 do Delete(Count-1);
      Add('where (Summa>0)');
      if dmc.TbPay.filtered and (dmc.TbPay.filter<>'') then
        Add('and '+dmc.TbPay.filter);
      dmc.QPayTotal.Open;
      EtvDBGrid.SetItemTotal('SummaK',
      FloatToStrF(dmc.QPayTotalSummaDK.AsCurrency,ffNumber,16,0));
      dmc.QPayTotal.Close;

      while Count>1 do Delete(Count-1);
      Add('where (Summa<0)');
      if dmc.TbPay.filtered and (dmc.TbPay.filter<>'') then
        Add('and '+dmc.TbPay.filter);
      dmc.QPayTotal.Open;
      EtvDBGrid.SetItemTotal('SummaD',
      FloatToStrF(-dmc.QPayTotalSummaDK.value,ffNumber,16,0));
      dmc.QPayTotal.Close;
      // для расчета валютной суммы по калк-полю
      with DMC do
      if TbPayCross.Visible then begin
        TbPay.DisableControls;
        TbPay.first;
        while not TbPay.eof do begin
          Application.ProcessMessages;
          CrossTotal:=CrossTotal+TbPayCross.Value;
          TbPay.Next
        end;
        EtvDBGrid.SetItemTotal('Cross',
        FloatToStrF(CrossTotal,ffNumber,16,3));
        TbPay.first;
        TbPay.EnableControls;
      end;
      //конец
    end;
  end;
end;

procedure TFormPay.DateEdit1Exit(Sender: TObject);
begin
  inherited;
  ResetFilter;
end;

procedure TFormPay.FormActivate(Sender: TObject);
var dd,ddTotal: double;
begin
  inherited;
  ResetFilter;
  ddTotal:=0;
  with StaticTextKredit do begin
    // Считаем долги по лизингу
    dd:=VarAsType(GetFromSQLText('DBGKSM',
        'select Sum(SummaBy) as SummaBy from STA.SprBCount where (Name like ''%лизинг%'') and (Summa>=0)',true),varDouble);
    Caption:=' Лизинг: '+Format('%11.2n',[dd])+' | ';
    ddTotal:=ddTotal+dd;
    // Считаем долги по кредитам
    dd:=VarAsType(GetFromSQLText('DBGKSM',
        'select Sum(SummaBy) as SummaBy from STA.SprBCount where (Name like ''%кред%'') and not(Name like ''%[%][%]%'') and (Summa<>0)',true),varDouble);
    Caption:=Caption+'Кредиты: '+Format('%11.2n',[dd])+' | ';
    ddTotal:=ddTotal+dd;
    // Считаем долги по процентам
    dd:=VarAsType(GetFromSQLText('DBGKSM',
        'select IsNull(Sum(SummaBy),0) as SummaBy from STA.SprBCount where (Name like ''%[%][%]%'') and (Summa<>0)',true),varDouble);
    {Caption:=Caption+'%%: '+Format('%11.2n',[dd])+' | ';}
    Caption:=Caption+'%%: на забалансовых счетах банка | ';
    ddTotal:=ddTotal+dd;
    Caption:=Caption+'Всего: '+Format('%11.2n',[ddTotal])+' ';
    Left:=Left-20;
  end;
end;

procedure TFormPay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if DMC.QCounts.Active then DMC.TbCounts.Close;
end;


procedure TFormPay.SpeedButton4Click(Sender: TObject);
begin
  EtvDBGrid.Total:=not EtvDBGrid.total;
  if EtvDBGrid.Total then begin
    Screen.Cursor:=crHourglass;
    ResetTotal;
    Screen.Cursor:=crDefault;
  end;
end;


procedure TFormPay.DBIndexCombo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  KeyReturn(Sender,Key,Shift);
end;

procedure TFormPay.DateEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  KeyReturn(Sender,Key,Shift);
end;

procedure TFormPay.DateEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  KeyReturn(Sender,Key,Shift);
end;

procedure TFormPay.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  EFilter.Show;
  ResetFilter;
end;

procedure CreateOtherOnFilterSave(aEtvFilter:TComponent);
begin
end;

procedure TFormPay.TabSheet1Enter(Sender: TObject);
begin
  inherited;
  StaticTextKredit.Visible:=true;
end;

procedure TFormPay.TabSheet1Exit(Sender: TObject);
begin
  inherited;
  StaticTextKredit.Visible:=false;
end;

Initialization
CreateOtherOnFilterLoad:=CreateOtherOnFilterSave;

end.
