unit JobHi;

interface

uses
  Forms, MBEForms, ToolEdit, RXDBCtrl, EtvContr, XECtrls, DBCtrls, EtvLook,
  StdCtrls, Mask, ExtCtrls, XCtrls, Controls, RXCtrls, DB,
  DBIndex, Grids, DBGrids, EtvGrid, ComCtrls, Classes, XMisc,
  Buttons, XDBForms, EtvShb, EtvRXCtl, SrcIndex, Menus, EtvList, EtvPages;

type
  TFormInvoice = class(TMBEForm)
    XLabel19: TXLabel;
    XLabel18: TXLabel;
    XLabel23: TXLabel;
    EditStockmanName: TXEDBLookupCombo;
    LabelContract: TXLabel;
    EditContract: TXEDBEdit;
    XLabel37: TXLabel;
    XDBLabel1: TXDBLabel;
    XLabel38: TXLabel;
    EditAutoInc: TXEDBEdit;
    XLabel39: TXLabel;
    EditNumInvoice: TXEDBEdit;
    XLabel40: TXLabel;
    EditDatePrice: TXEDBDateEdit;
    XLabel41: TXLabel;
    EditProdName: TXEDBLookupCombo;
    XLabel42: TXLabel;
    EditAmount: TXEDBEdit;
    XLabel43: TXLabel;
    EditDefective: TXEDBEdit;
    XLabel44: TXLabel;
    EditPrice: TXEDBEdit;
    XLabel45: TXLabel;
    EditSumma1: TXEDBEdit;
    XLabel46: TXLabel;
    EditTPriceName: TXEDBLookupCombo;
    XLabel47: TXLabel;
    EditPackage: TXEDBEdit;
    EditTareName1: TXEDBLookupCombo;
    XLabel48: TXLabel;
    XLabel49: TXLabel;
    EditClassCargo: TXEDBEdit;
    XLabel50: TXLabel;
    EditPayClaimName1: TXEDBLookupCombo;
    XLabel3: TXLabel;
    XEDBEdit1: TXEDBEdit;
    EditSupported: TXEDBCombo;
    CheckBoxSupported: TXCheckBox;
    XLabel7: TXLabel;
    TabSheet3: TEtvTabSheet;
    EditStationName: TXEDBLookupCombo;
    XLabel8: TXLabel;
    EditDirectName: TXEDBLookupCombo;
    GridBoundaryStations: TXEDbGrid;
    LabelDirection: TXLabel;
    XLabel11: TXLabel;
    EditRailBranchName: TXEDBLookupCombo;
    Label20: TXLabel;
    EditColumn_20: TXEDBEdit;
    XLabel10: TXLabel;
    EditGroupPos: TXEDBCombo;
    EditScheme: TXEDBCombo;
    Label4: TXLabel;
    EditColumn_4: TXEDBEdit;
    XLabel14: TXLabel;
    EditMassa: TEtvDBText;
    EditTareAmount: TEtvDBText;
    EditTareName: TEtvDBText;
    MemoProd: TMemo;
    LabelNameProdRail: TXLabel;
    Shb: TEtvShb;
    Button1: TButton;
    XLabel9: TXLabel;
    EditOrgStation: TXEDBEdit;
    EditDateShipmentRail: TXEDBDateEdit;
    EditPayerName: TXEDBLookupCombo;
    XLabel13: TXLabel;
    DBTextUser: TEtvDBText;
    DBTextTime: TEtvDBText;
    XEDBLookupCombo1: TXEDBLookupCombo;
    EditTransportClientName: TXEDBLookupCombo;
    LabelTransportClientName: TXLabel;
    EditTransportClientStr: TXEDBEdit;
    EtvTabSheet1: TEtvTabSheet;
    LabelTimeArrival: TXLabel;
    EditTimeArrival: TXEDBEdit;
    XLabel12: TXLabel;
    EditTimeLeave: TXEDBEdit;
    Panel2: TPanel;
    LabelNumDoc: TXLabel;
    EditKod: TXEDBEdit;
    EditSDate: TXEDBDateEdit;
    LabelNumAdd: TXLabel;
    EditWayPaper: TXEDBEdit;
    LabelTransport: TXLabel;
    EditTransport: TXEDBEdit;
    LabelTTransport: TXLabel;
    EditTTransportName: TXEDBLookupCombo;
    LabelTransPlantName: TXLabel;
    EditTransPlantName: TXEDBLookupCombo;
    EditTransPlantStr: TXEDBEdit;
    LabelDriver: TXLabel;
    EditDriver: TXEDBEdit;
    LabelTrailer: TXLabel;
    EditTrailer: TXEDBEdit;
    LabelSender: TXLabel;
    EditSenderName: TXEDBLookupCombo;
    XLabel2: TXLabel;
    DBTextSenderINN: TEtvDBText;
    XLabel4: TXLabel;
    DBTextSenderOKPO: TEtvDBText;
    EditCountSenderName: TXEDBLookupCombo;
    LabelOrg: TXLabel;
    EditOrgName: TXEDBLookupCombo;
    XLabel5: TXLabel;
    DBTextOrgINN: TEtvDBText;
    XLabel6: TXLabel;
    DBTextOrgOKPO: TEtvDBText;
    EditCountOrgName: TXEDBLookupCombo;
    LabelTrade: TLabel;
    LabelDepotName: TXLabel;
    EditDepotName: TXEDBLookupCombo;
    LabelPointUnloading: TXLabel;
    EditPointUnloading: TXEDBEdit;
    LabelSumma: TXLabel;
    EditSumma: TEtvDBText;
    LabelSumma1: TXLabel;
    EditSummaClose: TEtvDBText;
    LabelSummaName: TXLabel;
    EditSummaName: TXDBLabel;
    LabelDispatcherName: TXLabel;
    EditDispatcherName: TXEDBLookupCombo;
    LabelAllowerName: TXLabel;
    EditAllowerName: TXEDBLookupCombo;
    LabelTrustNum: TXLabel;
    EditTrustNum: TXEDBEdit;
    LabelTRustDate: TXLabel;
    EditTrustDate: TXEDBDateEdit;
    LabelTrust: TXLabel;
    EditTrust: TXEDBEdit;
    ButtonView: TSpeedButton;
    ButtonPrint: TSpeedButton;
    ButtonClone: TSpeedButton;
    ButtonLockOpen: TSpeedButton;
    ButtonLockClose: TSpeedButton;
    ButtonModify: TSpeedButton;
    LevButton1: TButton;
    XEDBLookupCombo2: TXEDBLookupCombo;
    {procedure EtvDbGrid1TitleClick(Column: TColumn);}
    procedure CheckBoxSupportedClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonPrintClick(Sender: TObject);
    function ShbCondition(Sender: TObject; aName: String): Boolean;
    {
    function ShbBeforeFieldPrint(Sender: TObject; aDataSet: TDataSet;
      aFieldNameName: String): String;

    function ShbAfterFieldPrint(Sender: TObject; aDataSet: TDataSet;
      aFieldNameName: String): String;
    }
    procedure ShbBeforeSumFieldPrint(Sender: TObject; Value: Variant;
      var S: String; aField: TField);
    procedure ShbBeforeFieldPrint(Sender: TObject; var S: String;
      aDataSet: TDataSet; aFieldName: String);
    procedure PageControl1PanelNavigatorClick(Sender: TObject;
      Button: TNavigateBtn);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1PanelNavigatorBeforeAction(Sender: TObject;
      Button: TNavigateBtn);
    procedure ButtonCloneClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ButtonLockOpenClick(Sender: TObject);
    procedure LabelTransPlantNameDblClick(Sender: TObject);
    procedure LabelTransportClientNameDblClick(Sender: TObject);
    procedure CheckBoxSupportedEnter(Sender: TObject);
    procedure CheckBoxSupportedExit(Sender: TObject);
    procedure LevButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure OnDataSet(DataSet:TDataSet);
    procedure OnSubDataSet(DataSet:TDataSet);
    { Public declarations }
  end;
{
var
  FormInvoice: TFormInvoice;
}
   var IsPrintOn: boolean; { Идет процесс печати }
       CopyInvoiceFlag:boolean;

implementation

uses Graphics, MdInvc, MdProd, XEFields, Windows, Dialogs, XApps, EtvRus, EtvDB, EtvDBFun,
     EtvBor, EtvClone, ppTypes, ppEndUsr, ppReport, XReports, SysUtils, MdBase, MdOrgs,
     DlgUnLOck;

var {MassaNameAdd:String;}
    SumMassa{,SumAmount}: double;
    {UnitMStr:string[20];}
    InvoiceProdDDeclarSource:TDataSource;
    InvoiceRailDeclarSource:TDataSource;

{$R *.DFM}

{
procedure TFormInvoice.EtvDbGrid1TitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field.FieldName<>'ProdName' then Exit;
  with TXELookField(Column.Field) do
    if LookUpFilterUp<>'' then begin
      LookUpFilterUp:='';
      LookUpLevelDown:='';
      LookUpFilterField:='AmountDown';
      LookUpFilterKey:='0';
      Column.Title.Caption:='Продукция (ЛИСТЬЯ)';
    end else begin
      LookUpFilterUp:='KodUp';
      LookUpLevelDown:='AmountDown';
      LookUpFilterField:='';
      LookUpFilterKey:='';
      Column.Title.Caption:='Продукция (ДЕРЕВО)';
    end;
end;
}
procedure TFormInvoice.CheckBoxSupportedClick(Sender: TObject);
begin
  inherited;
  if CheckBoxSupported.Checked then EditSupported.Enabled:=true
  else EditSupported.Enabled:=false;
end;

procedure TFormInvoice.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const FlagLookUp:boolean=true;
var i:byte;
    {Buf:array[0..700] of char;}
    {PBuf:PChar;}
begin
  inherited;
  if Key=VK_F12 then with ModuleInvoice.InvoiceDeclar do begin
    Close;
    if FlagLookUp then begin
      for i:=0 to FieldCount-1 do with Fields[i] do
        if FieldKind=fkLookUp then begin
          Visible:=false;
          FieldKind:=fkCalculated;
          with FieldByName(KeyFields) do begin
            Tag:=0;
            Visible:=true;
          end;
        end;
      AutoCalcFields:=false;
    end else begin
      for i:=0 to FieldCount-1 do with Fields[i] do
        if (FieldKind=fkCalculated) and Assigned(LookUpDataSet) then begin
          Visible:=true;
          FieldKind:=fkLookUp;
          with FieldByName(KeyFields) do begin
            Tag:=8;
            Visible:=false;
          end;
        end;
      AutoCalcFields:=true;
    end;
    FlagLookUp:=not FlagLookUp;
    Open;
  end;
(*
  if Key=VK_F11 then with ModuleInvoice,ModuleInvoice.InvoiceDeclar do begin
    if State<>dsBrowse then Exit;
    { Исключаем поле с именем 'Kod' }
    DisableControls;
    lVar:=FieldValues['SDate;WayPaper;Transport;TTransport;TransPlant;Driver;Trailer1;'+
      'Client;KodCountOrg;Depot;PointUnloading;Dispatcher;Allower;TrustNum;TrustDate;'+
      'Trust;Supported;Stockman;TransportPay'];
    OldKod:=FieldValues['Kod'];
    Insert;
    FieldValues['SDate;WayPaper;Transport;TTransport;TransPlant;Driver;Trailer1;'+
      'Client;KodCountOrg;Depot;PointUnloading;Dispatcher;Allower;TrustNum;TrustDate;'+
      'Trust;Supported;Stockman;TransportPay']:=lVar;
    FieldValues['Kod']:='+'+OldKod;
    EnableControls;
    {Post;}
    {GetMem(Buf,RecordSize+1);
    PBuf:=InvoiceDeclar.ActiveBuffer;
    Move(PBuf^,Buf[0],InvoiceDeclar.RecordSize);
    Insert;
    ABuf:=ActiveBuffer;
    Move(Buf[0],ABuf^,RecordSize);}
    CloneRecord(ModuleInvoice.InvoiceDeclar);
  end;
*)
end;

procedure TFormInvoice.FormCreate(Sender: TObject);
begin
  inherited;
  {ModuleInvoice.InvoiceDataChange(Self,nil);}
  {TabSheet3.TabVisible:=false;
  DetailPages.ActivePage:=TabSheet1;}
  with ModuleBase do if IsProgrammers then ButtonModify.Visible:=true;
  PageControl1.ActivePage:=FormSheet;
  Self.ActiveControl:=EditKod;
  if UserName='LEV' then LevButton1.Visible:=true;
end;

Procedure TFormInvoice.ButtonPrintClick(Sender: TObject);
var aParam: TXStringsReport;
    aDeviceType: String;
    aMarginTop: Integer;
    aDes: TppDesigner;
    aReport: TppReport;
    IDataSet:TDataSet;  { InvoiceDataSet }
    TTransprt: byte;           { Тип транспортировки }
    MessDlg: Word;
    FilterTransport: boolean;
    FilterTareReturn: boolean;
begin
  Inherited;
  InvoiceProdRowCount:=0;
  {
  if First then begin
    aReport:=TppReport.Create(Self);
    First:=false;
  end;
  }
  { Определили текущий DataSet для Invoice }
  IDataSet:=EditKod.DataSource.DataSet;
  if (IDataSet.State<>dsBrowse) or (ModuleInvoice.InvoiceProdDDeclar.State<>dsBrowse) then begin
    ShowMessage('Таблицы должны находиться в состоянии просмотра'+#13+
                'Проверьте, сохранены ли последние изменения в документе');
    Exit;
  end;
  // Проверка корректности информации по ТТН. 06.07.2009 Lev
  // Пока проверяется логика данных по залоговой таре. Потом м.б. еще чего возникнет.
  ExecSQLText(ModuleInvoice.InvoiceDeclar.DataBaseName,'call STA.CheckInvoiceProd2009('''+EditKod.Text+''','''+EditSDate.Text+''')',false);

  // Установка флага по сравнению с датой 01.05.09. С этой даты действует другая инструкция по заполнению накладных
  if IDataSet.FieldByName('sDate').AsDateTime<StrToDateTime('01.05.09') then RepInvoice2009:=false
  else RepInvoice2009:=true;

  if TButton(Sender).Name='ButtonPrint' then aDeviceType:='Printer'
  else aDeviceType:='Screen';

  with ModuleInvoice,IDataSet do
  try
    IsPrintOn:=true;
    IDataSet.DisableControls;
    InvoiceProdDDeclar.DisableControls;
    {Встали на первую запись - необходимо для некоторых процессов}
    InvoiceProdDDeclar.First;
    {InvoiceProdDDeclar.BlockReadSize:=2;}
    InvoiceRailDeclar.DisableControls;
    { б) Насильно возвр
    { Инициализация дополнительного DataSet'а }
    InitInvoiceAdd(IDataSet);

    { Механизмы Иго отключают MasterSourc'ы, а в данной ситуации они как раз необходимы }
    { а) Запоминаем старое состояние }
    InvoiceProdDDeclarSource:=InvoiceProdDDeclar.MasterSource;
    InvoiceRailDeclarSource:=InvoiceRailDeclar.MasterSource;
    { б) Насильно возвращаем MasterSourc'ы, где они должны жить для этого процесса }
    InvoiceProdDDeclar.MasterSource:=Invoice;
    InvoiceRailDeclar.MasterSource:=Invoice;
    TTransprt:=FieldByName('TTransport').AsInteger;
    begin
      if TTransprt in [0..4] then begin
{ Временно закомментировано, т.к. гл.бух не организовала работу
  на выписке для печати ТТН для ж/д накладных
 Без Льва не трогать!
}
        if TTransprt in[3,4] then
          case MessageDlg('Да - ТТН, НЕТ - Ж/д бланк', mtConfirmation,[mbYes,mbNo],0) of
            mrYes: TTransprt:=1;
            mrCancel: Exit;
          end;

        if (TTransprt in [0,1,2]) then begin
          MessDlg:=MessageDlg('Да - Текстовый режим печати, Нет - графический', mtConfirmation,[mbYes,mbNo],0);
          if MessDlg=mrCancel then Exit;
        end;

        if ((TTransprt in [0,1,2]) and (MessDlg=mrNo)) or (TTransprt in [3,4]) then try
          case TTransprt of
            0,1,2: if FieldByName('TTransport').AsInteger in [1,2] then begin
                   aReport:={TestInvoice}RepInvoice;
                   if not RepInvoice2009 then
                     aReport.Template.FileName:=DirShb+'\RepInvoice.rtm'
                   else aReport.Template.FileName:=DirShb+'\RepInvoice2009.rtm';
                 end else aReport:=RepinvoiceRail;
            3  : aReport:=RepInside;
            4  : aReport:=RepAbroad;
          end;
          aReport.Template.LoadFromFile;
          repeat
            aMarginTop:=5;
            if not RepInvoice2009 then
              aMarginTop:=aMarginTop+13
              { Для ТТН отступ сверху 5 мм для бумаги 289*203 мм, но т.к. принтер может печатать с 2 сторон только }
              { на нескольких стандартных типах бумаги, то обманываем принтер и ставим ему тип бумаги Letter 279*216 мм }
              { и поэтому отступ сверху для нормальной работы увеличиваем еще на 13 мм }
            { С 01.05.09 другие бланки, поэтому и отступ чуть другой }
            else aMarginTop:=aMarginTop+8;
            if TTransprt>2 then
            try
              aMarginTop:=StrToInt(InputBox('Установка параметров печати','Введите отступ сверху в мм', '25'));
            except
            end;
          until aMarginTop>=0;
          aReport.PrinterSetup.MarginTop:=aMarginTop;
          if (aReport=RepInvoice) or (aReport=RepInvoiceRail) then
            if (TButton(Sender).Name='ButtonPrint') or (TButton(Sender).Name='ButtonView') then begin
              if MessageDlg('Вы желаете напечатать типографский бланк накладной:',mtConfirmation,
                 [mbYes,mbNo],0)=mrNo then CopyInvoiceFlag:=true
              else CopyInvoiceFlag:=false;
            end else begin
              CopyInvoiceFlag:=true;
            end;
          { Обработка полей при печати копии ТН (вертикальной накладной. ТТН обрабатывается в ModuleInvoice.RepInvoiceStartPage }
          if aReport=RepInvoiceRail then begin
            ppLabelCopy1.Visible:=CopyInvoiceFlag;
            ppLabelTTN1.Visible:=CopyInvoiceFlag;
            EtvPpDBTextNum1.Visible:=CopyInvoiceFlag;
          end;
          FilterTransport:=false;
          FilterTareReturn:=false;
          if (aReport.Name='RepInvoice') or (aReport.Name='RepInvoiceRail') then begin
            { Накладываем фильтр для Вербицкого }

            if (GetFromSQLText(InvoiceDeclar.DataBaseName,
             'if Exists(select * from STA.InvoiceProd where (NumInvoice='''+EditKod.Field.AsString+''') and (sDate='''+
                EditSDate.Text+''') and (Prod in (46001,46002))) then select 1 else select 0 end if',false)=1) and

            //if Exists(select * from STA.InvoiceProd where (NumInvoice=EditKod.Field.AsString) and (sDate=EditSDate.Text) and (Prod in (46001,46002)) then select 1 else select 0 end if


            (MessageDlg('Распечатать без транспортных услуг?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then with InvoiceProdDDeclar do begin
              FilterTransport:=true;
              Filter:='(Prod<>46001) and (Prod<>46002)';
            end;
            { Накладываем фильтр для печати ТТН без возвратной тары }
            if (GetFromSQLText(InvoiceDeclar.DataBaseName,
             'if Exists(select * from STA.InvoiceProd where (NumInvoice='''+EditKod.Field.AsString+''') and (sDate='''+
                EditSDate.Text+''') and (GetKodDepositTare(Prod) is not null) and (Amount<0)) then select 1 else select 0 end if',false)=1) and

            (MessageDlg('Распечатать без возвращенной залоговой тары?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then with InvoiceProdDDeclar do begin
              FilterTareReturn:=true;
              if FilterTransport then 
                Filter:=Filter+'and not((Prod>=90031) and (Prod<=90034)) or (Amount>0)'
              else Filter:='not((Prod>=90031) and (Prod<=90034)) or (Amount>0)';
            end;
            if FilterTransport or FilterTareReturn then InvoiceProdDDeclar.Filtered:=true;
{
            if MessageDlg('Распечатать без возврата залоговой тары?',mtConfirmation,
              [mbYes,mbNo],0)=mrYes then with InvoiceProdDDeclar do begin
              FilterTareReturn:=true;
              Filter:='((Prod<>90031) and (Prod<>90032) and (Prod<>90033) and (Prod<>90034)) or (Amount>0)';
              Filtered:=true;
            end;
}
            ppGroupFooterBand2.BeforePrint:=ppGroupFooterBand2BeforePrint;
            { Устранение лишних пересылок данных при обращении к Grid'у }
            TCustomDBGridBorland(EtvDBGrid1).FDataLink.BufferCount:=1;
          end;

          if TButton(Sender).Name='ButtonModify' then begin
            with ModuleBase do
              if not IsProgrammers then begin
                ShowMessage('Данная команда не доступна пользователю '+UserName);
                Exit;
              end;
            aDes:=TppDesigner.Create(Nil);
            aDes.Report:=aReport;
            aDes.ShowModal;
            if MessageDlg('Вы желаете сохранить произведенные изменения?',mtConfirmation,
              [mbYes,mbNo],0)=mrYes then aReport.Template.SaveToFile;
            aDes.Free;
            Exit;
          end;
          aReport.DeviceType:=aDeviceType;
          aReport.Print;
          Exit;
        finally
          {Снимаем фильтр с таблички InvoiceProd , если он наложен }
          if FilterTransport or FilterTareReturn then with InvoiceProdDDeclar do begin
            Filtered:=false;
            Filter:='';
          end;
        end;
      end;
    end;
    if TButton(Sender).Name='ButtonModify' then Exit;

{ Для теста. Не забыть закомментарить перед отдачей модуля в работу! }
{DirShb:='P:\SHB';}
{ Для теста. Не забыть закомментарить перед отдачей модуля в работу! }
    if FieldByName('TTransport').AsInteger in [1,2] then
      Shb.FileName:=DirShb+'\Invoice'
    else begin
      Shb.FileName:=DirShb+'\Invoice_Rail';
      if Pos('ПЕРЕРАСЧЕТ ОТГРУЗКИ',AnsiUpperCase(FieldByName('PointUnloading').AsString))>0 then
        Shb.FileName:=Shb.FileName+'1';
    end;
    if Assigned(Shb) then with ModuleInvoice,Shb do begin
      { Определение бартерного договора }
      AssignDataSet('Invoice',IDataSet);
      AssignDataSet('InvoiceProd',ModuleInvoice.InvoiceProdDDeclar);
      AssignDataSet('B',ModuleInvoice.InvoiceADDSet);
      {AssignDataSet('InvoiceProdProcess',ModuleInvoice.InvoiceProdDProcess1);}
      {Fill;}
      if (TButton(Sender).Name='ButtonPrint') or (TButton(Sender).Name='ButtonView') then begin
        if MessageDlg('Вы желаете напечатать типографский бланк накладной:',mtConfirmation,
           [mbYes,mbNo],0)=mrNo then CopyInvoiceFlag:=true
        else CopyInvoiceFlag:=false;
        Shb.OnBeforeFieldPrint:=ShbBeforeFieldPrint
      end else begin
        CopyInvoiceFlag:=true;
        Shb.OnBeforeFieldPrint:=nil;
      end;
      { Распечатка без транспортных услуг, если надо }
      if MessageDlg('Распечатать без транспортных услуг?',mtConfirmation,
        [mbYes,mbNo],0)=mrYes then with InvoiceProdDDeclar do begin
        FilterTransport:=true;
        Filter:='(Prod<>46001) and (Prod<>46002)';
        Filtered:=true;
      end;
{
      if MessageDlg('Распечатать без возврата залоговой тары?',mtConfirmation,
        [mbYes,mbNo],0)=mrYes then with InvoiceProdDDeclar do begin
        FilterTareReturn:=true;
        Filter:='((Prod<>90031) and (Prod<>90032) and (Prod<>90033) and (Prod<>90034)) or (Amount>0)';
        Filtered:=true;
      end;
}
      if FieldByName('TTransport').AsInteger in [1,2] then
        ShowMessage('ВСТАВЬТЕ  АЛЬБОМНЫЙ(ГОРИЗОНТАЛЬНЫЙ)  БЛАНК  ТТН-1  В  ПРИНТЕР...')
      else ShowMessage('ВСТАВЬТЕ  КНИЖНЫЙ(ВЕРТИКАЛЬНЫЙ)  БЛАНК  ТН-2  В  ПРИНТЕР...');
      if Shb.Fill and (Shb.Text.Count>0) then begin
        aParam:= TXStringsReport.Create;
        with aParam do begin
          aParam.PrintLink:= TPrintLink.Create(pdText);
          aParam.PrintLink.ZoomView:=57;
          aParam.PrintLink.TextLink.SkipTextLines:= False;
          aParam.PrintLink.TextLink.TypeNLQ:=nxDraft{nxNoChange}{nxRoman};
          aParam.PrintLink.TextLink.TypeText:=txNone{txNoChange};
          Lines:= Shb.Text;
          LinesCount:= Lines.Count;
          CreateReport('', Self, aDeviceType, pdText, True, False, False);
        end;
        aParam.PrintLink.Free;
        aParam.Free;
      end;
    end;
      {RunModalViewer;}
  finally
    {Снимаем фильтр с таблички InvoiceProd , если он наложен }
    if FilterTransport {or FilterTareReturn} then with InvoiceProdDDeclar do begin
      Filtered:=false;
      Filter:='';
    end;
    { б) Возвращаем в проперти MasterSourc'ы те значения, которые были на входе в процедуру}
    InvoiceProdDDeclar.MasterSource:=InvoiceProdDDeclarSource;
    InvoiceRailDeclar.MasterSource:=InvoiceRailDeclarSource;
    IDataSet.EnableControls;
    InvoiceProdDDeclar.EnableControls;
    InvoiceRailDeclar.EnableControls;
    IsPrintOn:=false;
  end;
end;

Function TFormInvoice.ShbCondition(Sender: TObject; aName: String): Boolean;
Const PrintInit=0;
      NotSelfRemoval=1;
      PrintSetUp=2;
      UserQuery=3;
      InvoiceProdLabel=4;
      InvoiceProd_=5;
      RailTarif=6;
      IsTare=7;
Var Entry: byte;
    SetPrinter:String;
    {MassaForOneRow: String;}
    InitMassa: boolean;
begin
  if aName='PrintInit' then Entry:=PrintInit
  else if aName='NotSelfRemoval' then Entry:=NotSelfRemoval
  else if aName='PrintSetUp' then Entry:=PrintSetUp
  else if aName='UserQuery' then Entry:=UserQuery
  else if aName='InvoiceProdLabel' then Entry:=InvoiceProdLabel
  else if aName='InvoiceProd_' then Entry:=InvoiceProd_
  else if aName='RailTarif' then Entry:=RailTarif
  else if aName='IsTare' then Entry:=IsTare;
  Result:=false;
  with ModuleInvoice,TEtvShb(Sender) do
  case Entry of
    PrintInit:
      begin
        SetPrinter:=#27#80; { Установка шага 10 cpi }
        SetPrinter:=#18#27#51;
        if CopyInvoiceFlag then SetPrinter:=SetPrinter+#27
        else SetPrinter:=SetPrinter+#27{#36};
        SetPrinter:=SetPrinter+#27#85#49;
        AssignAdditional('PrintSetUp',SetPrinter,taLeftJustify,false);
        SumMassa:=0;
        {SumAmount:=0;}
        InvoiceProdRowCount:=0;
        Result:=true;
      end;
    PrintSetUp:
      begin
        if (InvoiceDeclarTTransport.Value in [1,2]) then
          SetPrinter:={#15}#27#33#4#27#51#24#27#85#48{#27#69}
        else SetPrinter:={#15}#27#33#5#27#51#27#27#85#48{#27#69};
        AssignAdditional('PrintSetUp',SetPrinter,taLeftJustify,false);
        Result:=true;
      end;
    NotSelfRemoval:
      begin
        { Центровывоз (TTransport=2) до 15.10.07, позже руководство затребовало печатать всегда }
        { по требованию аудитора }
        if EditKod.DataSource.DataSet.FieldByName('TTransport').AsInteger<=2 then Result:=true;
      end;
    UserQuery: if CopyInvoiceFlag then Result:=true;
    InvoiceProd_:
      begin
        { Если продукция - транспортные услуги или ж/д тариф и условия поставки - 2 }
        { то эту строку не печатаем, она нам нужна для статистики                   }
(*
        while (DeclarProdD.Value>46000) and (DeclarProdD.Value<46010) and
          (DeclarTPriceD.Value=2) and not InvoiceProdDDeclar.Eof do InvoiceProdDDeclar.Next;
        if InvoiceProdDDeclar.Eof then Exit;
*)
        if InvoiceProdRowCount>0 then InvoiceProdDDeclar.Next else InvoiceProdDDeclar.First;
        if (DeclarProdD.Value>46000) and (DeclarProdD.Value<46010)
          and ((DeclarTPriceNameD.ValueByLookName('IncTransport')=1) or (DeclarAmountD.AsInteger=0)) or InvoiceProdDDeclar.Eof then begin
          { Инициализация "Кол-ва продукции прописью" }
          ppGroupFooterBand2BeforePrint(nil);
          Exit;
        end;
        { Инициализация дополнительных переменных    }
        PLInvoiceProdTraversal(nil);
        Result:=true;
      end;
    InvoiceProdLabel:
      begin
        InitMassa:=false;
        {Inc(InvoiceProdRowCount);}
(*
        { Корректировка массы по накладной }
        if MassaNameAdd<>'' then begin
          MassaForOneRow:=InputBox('Изменение расчетного веса',
            'Введите вес по строке №'+IntToStr(InvoiceProdRowCount),'');
          AssignAdditional('M',MassaForOneRow,taRightJustify, false);
          SumMassa:=SumMassa+StrToFloat(MassaForOneRow);
          InitMassa:=true;
        end;
        if (DeclarProdD.Value<45000) or (DeclarProdD.Value>90000) then begin
          AssignAdditional('Amount',DeclarAmountD.AsString,taRightJustify, false);
          AssignAdditional('Price',DeclarPriceD.AsString,taRightJustify, false);
          if not InitMassa then begin
            AssignAdditional('M',ModuleInvoice.DeclarWeightD.AsString,taRightJustify, false);
            SumMassa:=SumMassa+DeclarWeightD.Value;
          end;
          {SumAmount:=SumAmount+DeclarAmountD.Value;}
          { Наименование единицы измерения }
          {UnitMStr:=DeclarProdNameD.StringByLookName('UnitMName');}
        end else begin
          AssignAdditional('Price','',taRightJustify, false);
          AssignAdditional('Amount','',taRightJustify, false);
          if not InitMassa then AssignAdditional('M','',taRightJustify, false);
        end;
        { Всего масса  }
        AssignAdditional('SumM',FloatToStr(SumMassa),taRightJustify, false);
        { Всего количество }
        {AssignAdditional('SumAm',FloatToStr(SumAmount),taRightJustify, false);}
*)
        if not(CopyInvoiceFlag) and (Shb.FileName=DirShb+'\Invoice_Rail1') and
        (ModuleInvoice.InvoiceProdDDeclar.RecordCount>28) then Result:=false
        else Result:=true;
      end;
    RailTarif:
      begin
        if (DeclarProdD.Value=46002) and (DeclarTPriceNameD.ValueByLookName('IncTransport')=0)
          and (DeclarAmountD.AsInteger=0) then Result:=true;
      end;
    IsTare:
      begin
        { Есть упаковка }
        if EditKod.DataSource.DataSet.FieldByName('TareAmount').AsInteger>0 then Result:=true;
      end;
  end;
end;
{
function TFormInvoice.ShbBeforeFieldPrint(Sender: TObject;
  aDataSet: TDataSet; aFieldNameName: String): String;
begin
  inherited;
  if (aDataSet<>ModuleInvoice.InvoiceProdDDeclar) and
    (aFieldNameName<>'TrustStr') then Result:=#27+'E'
  else Result:='';
  if aFieldNameName='StockmanName' then Result:=Result+#27+'-1';
end;

function TFormInvoice.ShbAfterFieldPrint(Sender: TObject;
  aDataSet: TDataSet; aFieldNameName: String): String;
begin
  inherited;
  if (aDataSet<>ModuleInvoice.InvoiceProdDDeclar) and
    (aFieldNameName<>'TrustStr') then Result:=#27+'F'
  else Result:='';
  if aFieldNameName='StockmanName' then Result:=Result+#27+'-0';
end;
}
procedure TFormInvoice.ShbBeforeSumFieldPrint(Sender: TObject;
  Value: Variant; var S: String; aField: TField);
begin
  inherited;
(*
  if aField.Name='DeclarAmountD' then
    Shb.AssignAdditional('AmountName', NumberToWords(VarAsType(Value,varDouble),
      mtNothing{mtPiece}, nil)+
      ' '+ModuleInvoice.DeclarProdNameD.StringByLookName('UnitMName'), taLeftJustify, false)
*)
  if aField.Name='DeclarSummaD' then begin
(*
    { Всего масса  }
    TEtvShb(Sender).AssignAdditional('SumM',FloatToStr(SumMassa),taRightJustify, false);
    { Всего количество }
    TEtvShb(Sender).AssignAdditional('SumAm',FloatToStr(SumAmount),taRightJustify, false);
*)
    { ВСего количество прописью }
(*
    Shb.AssignAdditional('AmountName', NumberToWords(SumAmount,
      mtNothing,nil)+' '+UnitMStr,taLeftJustify,false)
*)
  end;
end;

Procedure TFormInvoice.ShbBeforeFieldPrint(Sender: TObject; var S: String;
  aDataSet: TDataSet; aFieldName: String);
begin
  inherited;
  if aDataSet=ModuleInvoice.InvoiceProdDDeclar then S:=AnsiUpperCase(S);
  (*
  if (aFieldName<>'TrustStr') and (aFieldName<>'PrintSetUp')
    and (aDataSet<>ModuleInvoice.InvoiceProdDDeclar) then S:=#27+'E'+S+#27+'F';
  *)
  if aFieldName='StockmanName' then S:=#27+'-1'+S+#27+'-0';
end;

Procedure TFormInvoice.PageControl1PanelNavigatorClick(Sender: TObject; Button: TNavigateBtn);
var i:byte;
begin
  if Button<>nbRefresh then Exit;
  with ModuleInvoice.InvoiceDeclar do begin
    DisableControls;
    for i:=0 to FieldCount-1 do with Fields[i] do
      if (FieldKind=fkLookUp) and (Assigned(LookUpDataSet)) then begin
        LookUpDataSet.Close;
        LookUpDataSet.Open;
      end;
    EnableControls;
    Refresh;
  end;
  inherited;
end;

Procedure TFormInvoice.Button1Click(Sender: TObject);
begin
  inherited;
  with ModuleInvoice do begin
(*
    ModuleOrgs.OrgLookUp.Close;
    ModuleOrgs.OrgLookUp.Open;
    InvoiceDeclar.Refresh;
*)
    if InvoiceRailDeclar.State<>dsEdit then InvoiceRailDeclar.Edit;
    with InvoiceDeclarOrgName do begin
      ValueByLookNameToField('Station',InvoiceRailStation);
      ValueByLookNameToField('RailBranch',InvoiceRailBranch);
      ValueByLookNameToField('OrgStation',InvoiceRailOrgStation);
    end;
  end;
end;

Procedure DataSetLookUpRefresh(aDataSet:TDataSet);
var i:byte;
begin
  with aDataSet do begin
    DisableControls;
    for i:=0 to FieldCount-1 do with Fields[i] do
      if (FieldKind=fkLookUp) and (Assigned(LookUpDataSet)) then begin
        LookUpDataSet.Close;
        DataSetLookUpRefresh(LookUpDataSet);
        LookUpDataSet.Open;
      end;
    EnableControls;
  end;
end;

Procedure TFormInvoice.PageControl1PanelNavigatorBeforeAction(Sender: TObject; Button: TNavigateBtn);
var DS:TDataSource;
begin
  inherited;
  if Button<>nbRefresh then Exit;
  with ModuleInvoice do begin
    DataSetLookUpRefresh(InvoiceDeclar);
    InvoiceDeclar.Refresh;
    DataSetLookUpRefresh(InvoiceProdDeclar);
    InvoiceProdDeclar.Refresh;
    DataSetLookUpRefresh(InvoiceProdDDeclar);
    DS:=InvoiceProdDDeclar.MasterSource;
    InvoiceProdDDeclar.MasterSource:=nil;
    InvoiceProdDDeclar.Refresh;
    InvoiceProdDDeclar.MasterSource:=DS;
    {DataSetLookUpRefresh(InvoiceRailDeclar);
    InvoiceRailDeclar.Refresh;}
  end;
end;

procedure TFormInvoice.ButtonCloneClick(Sender: TObject);
var EC:TEtvRecordCloner;
begin
  {inherited;}
  { Контроль, чтобы механизм клонирования работал только с TTable }
  if EditKod.DataSource.DataSet.Name<>'InvoiceDeclar' then Exit;
  with ModuleInvoice do begin
    if InvoiceDeclarIsLock.Value=1 then begin
      ShowMessage('КЛОНИРОВАНИЕ ЗАКРЫТЫХ НА ЗАМОК НАКЛАДНЫХ НЕВОЗМОЖНО!!!'+#13+
                  'НЕОБХОДИМО ПРЕДВАРИТЕЛЬНО СНЯТЬ ЗАМОК...'+#13+
                  'ЕСЛИ СНИМЕТЕ ЗАМОК, НЕ ЗАБУДЬТЕ(!!!) ПОТОМ ЗАМОК УСТАНОВИТЬ!');
      Exit;
    end;
    { Механизмы Иго отключают MasterSourc'ы, а в данной ситуации они как раз необходимы }
    { а) Запоминаем старое состояние }
    InvoiceProdDDeclarSource:=InvoiceProdDDeclar.MasterSource;
    InvoiceRailDeclarSource:=InvoiceRailDeclar.MasterSource;
    { б) Насильно возвращаем MasterSourc'ы, где они должны жить для этого процесса }
    InvoiceProdDDeclar.MasterSource:=Invoice;
    InvoiceRailDeclar.MasterSource:=Invoice;
    EC:=TEtvRecordCloner.Create(nil);
    try
      CloneRegime:=true;
      InvoiceDeclar.DisableControls;
      EC.Transaction:=true;
      EC.DataSource:=Invoice;
      EC.ConfirmSubDataSet:=true;
      EC.OnCloneDataSet:=OnDataSet;
      EC.OnCloneSubDataSet:=OnSubDataSet;
      EC.SubDataSets.AddItem(InvoiceProdDDeclar,true);
      if InvoiceDeclarTTransport.Value in [3,4] then begin
        EC.SubDataSets.AddItem(InvoiceRailDeclar,true);
      end;
      InvoiceDeclarKod.OnValidate:=nil;
      InvoiceDeclarSDate.OnValidate:=nil;
      InvoiceRailDeclar.BeforeInsert:=nil;
      EC.Clone;
    finally
      EC.Free;
      { б) Возвращаем в проперти MasterSourc'ы те значения, которые были на входе в процедуру}
      InvoiceProdDDeclar.MasterSource:=InvoiceProdDDeclarSource;
      InvoiceRailDeclar.MasterSource:=InvoiceRailDeclarSource;
      InvoiceDeclarKod.OnValidate:=InvoiceDeclarKodValidate;
      InvoiceDeclarSDate.OnValidate:=InvoiceDeclarSDateValidate;
      InvoiceRailDeclar.BeforeInsert:=InvoiceRailDeclarBeforeInsert;
      InvoiceDeclar.Refresh;
      InvoiceDeclar.EnableControls;
      CloneRegime:=false;
    end;
  end;
end;

procedure TFormInvoice.OnDataSet(DataSet:TDataSet);
var S:String;
    FlagExit: byte;
begin
  S:=DataSet.FieldByName('Kod').AsString;
  FlagExit:=0;
  with ModuleInvoice do repeat
    if InputQuery('','Введите № нового документа',S) then begin
      {DataSet.FieldByName('Kod').AsString:=S;}
      if not InvoiceProcess.Active then InvoiceProcess.Open;
      if InvoiceProcess.Locate('Kod;SDate',
        VarArrayOf([S{DataSet.FieldByName('Kod').Value},DataSet.FieldByName('SDate').Value]),[]) then
        ShowMessage('Накладная № '+S+' за '+DataSet.FieldByName('SDate').AsString+' уже существует'+#13+
        'Введите другой № накладной')
      else FlagExit:=1
    end else FlagExit:=2;
  until FlagExit<>0;
  if FlagExit=2 then Abort
  else DataSet.FieldByName('Kod').AsString:=S;
end;

procedure TFormInvoice.OnSubDataSet(DataSet:TDataSet);
begin
  with ModuleInvoice do begin
    if DataSet.Name='InvoiceProdDDeclar' then begin
      DeclarNumInvoiceD.Value:=InvoiceDeclarKod.Value;
      DeclarSDateD.Value:=InvoiceDeclarSDate.Value;
    end;
    if DataSet.Name='InvoiceRailDeclar' then begin
      InvoiceRailNumInvoice.Value:=InvoiceDeclarKod.Value;
      InvoiceRailDeclarSDate.Value:=InvoiceDeclarSDate.Value;
    end;
  end;
end;

procedure TFormInvoice.PageControl1Change(Sender: TObject);
begin
  inherited;
  with ModuleInvoice do begin
    { Отключаем подключенные MasterSources }
    if TPageControl(Sender).ActivePage.Name='GridSheet' then begin
      InvoiceProdDDeclar.MasterSource:=nil;
      InvoiceRailDeclar.MasterSource:=nil;
    end;
    { Подключаем отключенные MasterSources }
    if TPageControl(Sender).ActivePage.Name='FormSheet' then begin
      InvoiceProdDDeclar.MasterSource:=Invoice;
      InvoiceRailDeclar.MasterSource:=Invoice;
    end;
  end;
end;

procedure TFormInvoice.ButtonLockOpenClick(Sender: TObject);
begin
  inherited;
  with ModuleInvoice do begin
    if (InvoiceDeclar.State<>dsBrowse) or (InvoiceProdDDeclar.State<>dsBrowse) then begin
      ShowMessage('Таблицы должны находиться в состоянии просмотра'+#13+
                  'Проверьте, сохранены ли последние изменения в документе');
      Exit;
    end;
    if TSpeedButton(Sender).Name='ButtonLockOpen' then begin
      { Запись закрываем на замок }
      if (GetFromSQLText(InvoiceDeclar.DataBaseName,
        'select CheckUserLockInvoice()',false)=1) {and (InvoiceDeclarsUser.Value=UserName)} then begin
        { Первое китайское предупреждение }
        if MessageDlg('Внимание! Установка ЗАМКА!!! Предупреждение №1'+#13+
          'Изменить информацию по накладной будет НЕВОЗМОЖНО!'+#13+
          'Снять замок очень СЛОЖНО!'+#13+
          'ДА - Подтвердить установку замка   НЕТ - Отмена'
          , mtConfirmation,[mbYes,mbNo],0)=mrYes then begin

          { Последнее китайское предупреждение }
          if MessageDlg('Внимание! Установка ЗАМКА!!! Предупреждение №2'+#13+
            'Изменить информацию по накладной будет НЕВОЗМОЖНО!'+#13+
            'Снять замок очень СЛОЖНО!'+#13+
            'ДА - Подтвердить установку замка   НЕТ - Отмена'
            , mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
          end else Exit;
        end else Exit;
      end else begin
        ShowMessage('У вас отсутствуют права на установку замка'+#13+
                    'или не Вы последний изменяли запись');
        Exit;
      end;
      ExecSQLText(InvoiceDeclar.DataBaseName,
        'Update STA.Invoice set IsLock=1 where ID='+InvoiceDeclarID.AsString,false);
      ShowMessage('ЗАМОК НА НАКЛАДНУЮ № '+
        InvoiceDeclarKod.AsString+' от '+InvoiceDeclarsDate.AsString+' УСТАНОВЛЕН')
    end else begin
      { Снимаем замок с записи }
      try
        FormDlgUnLock:=TFormDlgUnLock.Create(Application);
        with FormDlgUnLock do begin
          if (ShowModal in [idOk,idYes]) then begin
            if (GetFromSQLText(InvoiceDeclar.DataBaseName,
              'select STA.CheckUserUnLockInvoice('''+EmpNo.Text+''','''+Fam.Text+''','''+
              Im.Text+''','''+Otch.Text+''','''+DateBorn.Text+''','''+
              DateWorkKSM.Text+''')',true)<>1) or
              (NumInvoice.Text<>InvoiceDeclarKod.AsString) or
              (DateInvoice.Text<>InvoiceDeclarsDate.AsString) then begin
              ShowMessage('Неверно заполнены контрольные данные');
              Exit;
            end;
            {
            if (InvoiceDeclarsUser.Value<>UserName) then begin
              ShowMessage('Не Вы ставили замок - не Вам его и открывать!');
              Exit;
            end;
            }
          end else Exit;
        end;
        ExecSQLText(InvoiceDeclar.DataBaseName,
          'Update STA.Invoice set IsLock=0 where ID='+InvoiceDeclarID.AsString,false);
        ShowMessage('ЗАМОК С НАКЛАДНОЙ № '+
          InvoiceDeclarKod.AsString+' от '+InvoiceDeclarsDate.AsString+' СНЯТ')
      finally
        FormDlgUnLock.Release;
      end;
    end;
    InvoiceDeclar.Refresh;
  end;
end;

procedure TFormInvoice.LabelTransPlantNameDblClick(Sender: TObject);
begin
  inherited;
  EditTransPlantName.Visible:=not EditTransPlantName.Visible;
  EditTransPlantStr.Visible:=not EditTransPlantStr.Visible;
end;

procedure TFormInvoice.LabelTransportClientNameDblClick(Sender: TObject);
begin
  inherited;
  EditTransportClientName.Visible:=not EditTransportClientName.Visible;
  EditTransportClientStr.Visible:=not EditTransportClientStr.Visible;
end;

procedure TFormInvoice.CheckBoxSupportedEnter(Sender: TObject);
begin
  with TCheckBox(Sender) do begin
    Font.Style:=Font.Style+[fsBold];
    Font.Color:=clRed;
    Color:=clWhite;
  end;
  inherited;
end;

procedure TFormInvoice.CheckBoxSupportedExit(Sender: TObject);
begin
  inherited;
  with TCheckBox(Sender) do begin
    Font.Style:=Font.Style-[fsBold];
    Font.Color:=clBlack;
    Color:=clBtnFace;
  end;
end;

procedure TFormInvoice.LevButton1Click(Sender: TObject);
begin
  inherited;
  with ModuleInvoice.InvoiceProdDDeclar do begin
    DisableControls;
    First;
    while not Eof do begin
      Edit;
      ModuleInvoice.DeclarProdD.Value:=ModuleInvoice.DeclarProdD.Value;
      Post;
      Next;
    end;
    First;
    EnableControls;
    ShowMessage('Ok!');
  end;
end;

Initialization
  RegisterAliasXForm('FormInvoice', TFormInvoice);
  IsPrintOn:=false;
Finalization
  UnRegisterXForm(TFormInvoice);
end.
