unit PayDoc;

interface

uses
  Forms, ABEForms, DBCtrls, EtvContr, XECtrls, StdCtrls, ToolEdit, DB,
  RXDBCtrl, Mask, EtvLook, ExtCtrls, XCtrls, Controls, RXCtrls,
  DBIndex, Grids, DBGrids, EtvGrid, ComCtrls, Classes,
  XMisc, EtvShb, XDBForms, EtvRXCtl, SrcIndex, Menus, Buttons, Windows,
  EtvPages, EtvList, BBEForms, Math;

type
  TFormPayDoc = class(TBBEForm)
    EditTypeDoc: TXEDBLookupCombo;
    EditNumDoc: TXEDBEdit;
    XLabel1: TXLabel;
    EditDateDoc: TXEDBDateEdit;
    EditClientDName: TXEDBLookupCombo;
    EditBnDebtName: TXEDBLookupCombo;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    EditSumma: TXEDBEdit;
    XLabel5: TXLabel;
    XLabel6: TXLabel;
    XLabel7: TXLabel;
    XLabel8: TXLabel;
    EditClientKName: TXEDBLookupCombo;
    EditClientDNameStr: TXEDBEdit;
    EditClientKNameStr: TXEDBEdit;
    XLabel9: TXLabel;
    EditBnKredName: TXEDBLookupCombo;
    XLabel10: TXLabel;
    XLabel11: TXLabel;
    XLabel12: TXLabel;
    EditMfoK: TXEDBLookupCombo;
    EditSummaName: TXDBLabel;
    Shape1: TShape;
    Shape3: TShape;
    XLabel14: TXLabel;
    DBMemo1: TDBMemo;
    XLabel15: TXLabel;
    XLabel18: TXLabel;
    EditDatePay: TXEDBDateEdit;
    XLabel23: TXLabel;
    XLabel24: TXLabel;
    XLabel26: TXLabel;
    Shape9: TShape;
    EditTOperName: TXEDBLookupCombo;
    EtvDBLookupCombo6: TXEDBLookupCombo;
    XLabel28: TXLabel;
    EditContract: TXEDBEdit;
    XLabel34: TXLabel;
    XLabel35: TXLabel;
    EditBankPlaceNameD: TEtvDBText;
    EditMfoD: TXEDBLookupCombo;
    EditOrgDINN: TEtvDBText;
    EditBankPlaceNameK: TEtvDBText;
    EditOrgKINN: TEtvDBText;
    EtvDBText1: TEtvDBText;
    EtvDBText2: TEtvDBText;
    XLabel36: TXLabel;
    EditCurrencyName: TXEDBLookupCombo;
    EditCourse: TXEDBEdit;
    Shb: TEtvShb;
    PopupMenuClient: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    PanelCheck:TPanel;
    XDBLabel1: TXDBLabel;
    TransactGrid: TXEDbGrid;
    Note: TXEDBCombo;
    XEDBLookupCombo3: TXEDBLookupCombo;
    XEDBLookupCombo4: TXEDBLookupCombo;
    XLabel16: TXLabel;
    XLabel17: TXLabel;
    XLabel27: TXLabel;
    N5: TMenuItem;
    GFXPrint: TMenuItem;
    GFXView: TMenuItem;
    TXTPrint: TMenuItem;
    TXTView: TMenuItem;
    GFXSHBEdit: TMenuItem;
    EditPenalty: TXEDBCombo;
    XEDBLookupCombo5: TXEDBLookupCombo;
    XLabel19: TXLabel;
    EditSendToBank: TXEDBCombo;
    XLabel20: TXLabel;
    EditTimeSendToBank: TXEDBEdit;
    XLabel13: TXLabel;
    EditPacket: TXEDBEdit;
    N6: TMenuItem;
    EditConversion: TXEDBCombo;
    EditCurrencyConversionName: TXEDBLookupCombo;
    EditCourseConversion: TXEDBEdit;
    XLabel21: TXLabel;
    XLabel22: TXLabel;
    XLabel25: TXLabel;
    EtvTabSheet1: TEtvTabSheet;
    XEDbGrid1: TXEDbGrid;
    XLabel29: TXLabel;
    EditNumSendOfDate: TXEDBEdit;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    Button1: TButton;
    DBTextUser: TEtvDBText;
    DBTextTime: TEtvDBText;
    EtvDBText3: TEtvDBText;
    EtvDBText4: TEtvDBText;
    EditOrgKInnStr: TXEDBEdit;
    XLabel30: TXLabel;
    EditSummaConversion: TXEDBEdit;
    TabSheet4: TEtvTabSheet;
    XLabel32: TXLabel;
    XEDBEdit2: TXEDBEdit;
    XLabel31: TXLabel;
    XEDBEdit3: TXEDBEdit;
    XLabel33: TXLabel;
    XEDBEdit4: TXEDBEdit;
    XEDBDateEdit1: TXEDBDateEdit;
    EditCbsK: TEtvDBText;
    EditCbsD: TEtvDBText;
    XLabel37: TXLabel;
    XLabel38: TXLabel;
    EditBankIdD: TEtvDBText;
    XLabel39: TXLabel;
    XLabel40: TXLabel;
    EditBankIdK: TEtvDBText;
    XLabel41: TXLabel;
    XLabel42: TXLabel;
    XEDBEdit6: TXEDBEdit;
    XLabel43: TXLabel;
    EtvDBText5: TEtvDBText;
    EditMfoKK: TXEDBLookupCombo;
    procedure ButtonPrintClick(Sender: TObject);
    procedure ShbBeforeFieldPrint(Sender: TObject; var S: String;
      aDataSet: TDataSet; aFieldName: String);
    procedure SpeedButton1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxActiveClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure XLabel2DblClick(Sender: TObject);
    procedure XLabel8DblClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure XLabel35DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPayDoc: TFormPayDoc;

implementation
uses EtvDBFun,Dialogs,MdPays,SysUtils, MdOrgs, XApps, EtvRus, EtvBor,
     MdCommon, ppTypes, ppEndUsr, ppReport, XReports, GksmCons, MdBase,
     DiDate, Messages, Misc;

{$R *.DFM}

procedure TFormPayDoc.ButtonPrintClick(Sender: TObject);
var Shb: TEtvShb;
    aParam: TXStringsReport;
    aDeviceType: String;
    aSenderName:String;
    {PDataSet:TDataSet;}
    aDes:TppDesigner;
    aNumCopiesStr:string;
    aNumCopies:integer;
begin
  aSenderName:=TMenuItem(Sender).Name;
  inherited;
  if Pos('View',aSenderName)>0 then aDeviceType:='Screen'
  else aDeviceType:='Printer';
  {PDataSet:=EditNumDoc.DataSource.DataSet;}
  { Инициализация доп. значений }
  ModulePays.InitPayDocAdd({PDataSet}EditNumDoc.DataSource.DataSet);

  { Графическая ветка }
  if Pos('GFX',aSenderName)>0 then begin
    aNumCopiesStr:='4';
    if not InputQuery('Количество копий документа',
       'Введите количество копий печатаемого документа',aNumCopiesStr) then Exit;
    if aNumCopiesStr<>'' then
      aNumCopies:=StrToIntDef(aNumCopiesStr, 4)
    else Exit;
    ModulePays.PLPayDoc.RangeEndCount:=aNumCopies;

    with ModulePays do
      try
        CASE PayDocTDoc.Value of
        2:
          RepPayDoc.Template.FileName:=DirShb+'\RepOrder.rtm';
        7:
          RepPayDoc.Template.FileName:=DirShb+'\RepCheck.rtm';
        else
          RepPayDoc.Template.FileName:=DirShb+'\RepPayDoc2002.rtm';
        end;
            RepPayDoc.Template.LoadFromFile;
            { Устранение лишних пересылок данных при обращении к Grid'у }
            TCustomDBGridBorland(TransactGrid).FDataLink.BufferCount:=1;
            if aSenderName='GFXSHBEdit' then begin
              aDes:=TppDesigner.Create(Nil);
              aDes.Report:=RepPayDoc;
              aDes.ShowModal;
              if MessageDlg('Сохранить изменения?',mtConfirmation,
                [mbYes,mbNo],0)=mrYes then RepPayDoc.Template.SaveToFile;
              aDes.Free;
              Exit;
            end;
            RepPayDoc.DeviceType:=aDeviceType;
            RepPayDoc.Print;
            Exit;
      finally
      end;
  end;

  Shb:=TEtvShb.Create(Self);
  {DirShb:='P:\SHB';}
  {Выбор файла шаблона в зависимости от типа документа}
  CASE ModulePays.PayDocTDoc.Value of
    7:   Shb.FileName:=DirShb+'\Check';
  else
    Shb.FileName:=DirShb+'\PayDoc';
  end;
  Shb.Caption:='Платежный документ';

  if Assigned(Shb) then with Shb do begin
    AssignAdditional('PrintSetUp',#27#77#7#27#51#27#7,taLeftJustify,false);
    {AssignAdditional('DateDocStr',DateToStrEtv(ModulePays.PayDocDateDoc.Value),taRightJustify,false);}
    AssignAdditional('DateComingStr',DateToStrEtv(ModulePays.PayDocDateComing.Value),taRightJustify,false);
    AssignDataSet('PayDoc',ModulePays.PayDocS);
    AssignDataSet('SprTDoc',ModulePays.TDocDeclar);
    AssignDataSet('B',ModulePays.PayDocAddSet);
    if aSenderName='TXTPrint' then
      Shb.OnBeforeFieldPrint:=ShbBeforeFieldPrint
    else Shb.OnBeforeFieldPrint:=nil;

    {Fill;}
    if Shb.Fill and (Shb.Text.Count>0) then begin
      aParam:= TXStringsReport.Create;
      with aParam do begin
        aParam.PrintLink:= TPrintLink.Create(pdText);
        aParam.PrintLink.ZoomView:= 70;
        aParam.PrintLink.TextLink.SkipTextLines:= False;
        Lines:= Shb.Text;
        LinesCount:= Lines.Count;
        CreateReport('', Self, aDeviceType, pdText, True, False, False);
      end;
      aParam.PrintLink.Free;
      aParam.Free;
    end;
    {RunViewer;}
    Free;
    Exit;
  end;
end;

procedure TFormPayDoc.ShbBeforeFieldPrint(Sender: TObject; var S: String;
  aDataSet: TDataSet; aFieldName: String);
begin
  inherited;
  { Выделение жирным шрифтом }
  S:=#27+'E'+S+#27+'F';
end;

procedure TFormPayDoc.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  with ModulePays do begin
    if PayDocOrgD.IsNull then N1.Enabled:=true
    else N1.Enabled:=false;
    if PayDocOrgK.IsNull then N2.Enabled:=true
    else N2.Enabled:=false
  end;
  PopupMenuClient.Popup(SpeedButton1.ClientOrigin.X,
    SpeedButton1.ClientOrigin.Y+SpeedButton1.Height);
end;

procedure TFormPayDoc.N1Click(Sender: TObject);
begin
  inherited;
  if ModuleOrgs.NewBankProperty(ModulePays.PayDocMfoD.Value,
    ModulePays.PayDocBCountD.Value,true) then
    with ModuleOrgs do begin
      EditClientDName.SetFocus;
      OrgC.SelectedField:=ModulePays.PayDocOrgDName;
      OrgC.ReturnForm:=Self;
      ModulePays.PayDocC.OpenReturnControl:=OrgC;
      OrgC.ReturnExecute;
    end;
end;

procedure TFormPayDoc.N2Click(Sender: TObject);
begin
  inherited;
  if ModuleOrgs.NewBankProperty(ModulePays.PayDocMfoK.Value,
    ModulePays.PayDocBCountK.Value,true) then
    with ModuleOrgs do begin
      EditClientKName.SetFocus;
      OrgC.SelectedField:=ModulePays.PayDocOrgKName;
      OrgC.ReturnForm:=Self;
      ModulePays.PayDocC.OpenReturnControl:=OrgC;
      OrgC.ReturnExecute;
    end;
end;

(*
procedure TFormPayDoc.N3Click(Sender: TObject);
var lTotalDoc: variant;
begin
  inherited;
  lTotalDoc:=
    GetFromSQLText(ModulePays.PayDocS.DataBaseName,
    'Call STA.InitClientsInPayDoc()',false);
  ShowMessage('Модифицировано '+VarToStr(lTotalDoc)+' документов');
  if lTotalDoc>0 then ModulePays.PayDocS.Refresh;
end;
*)

Procedure TFormPayDoc.N3Click(Sender: TObject);
var DlgOneDate: TDialDate;
begin
  DlgOneDate:=TDialDate.Create(Application);
  with DlgOneDate do begin
    Caption:='Автоинициализация плательщиков';
  end;
  if (DlgOneDate.ShowModal in [idOk, idYes]) and (DlgOneDate.EditDateBeg.Date>0) and
  (DlgOneDate.EditDateEnd.Date>0) and (DlgOneDate.EditDateEnd.Date>=DlgOneDate.EditDateBeg.Date) then
    with DlgOneDate do try
      ExecSQLText(ModuleBase.KSMDataBase.DataBaseName,
        'Call STA.PayDocKreditUpdate('''+EditDateBeg.Text+''','''+EditDateEnd.Text+''')',false);
      ModulePays.PayDocs.Refresh;
      ModuleCommon.TransactDDeclar.Refresh;
    finally
      DlgOneDate.Release;
    end
  else Abort;
end;

procedure TFormPayDoc.FormCreate(Sender: TObject);
var DH : HDC;
    HResol, VResol: integer;
begin
  {inherited;}
  (*
  If FIN_BUH_FSG_Group=BUH then
  begin
    EditBnKredName.Readonly:=True;
    EditBnDebtName.Readonly:=True;
    EditMFOD.Readonly:=True;
    EditMFOK.Readonly:=True;
    XEDBLookupCombo1.ReadOnly:=false;
    EditDateComing.Readonly:=True;
    EtvDBLookupCombo6.Readonly:=True;
    XDBEdit10.ReadOnly:=True;
    EditClientKName.Readonly:=True;
    EditTOperName.Readonly:=True;
    EditBnKredName.TabStop:=False;
    EditBnDebtName.TabStop:=False;
    EditMFOD.TabStop:=False;
    EditMFOK.TabStop:=False;
    {XEDBLookupCombo1.TabStop:=False;}
    EditDateComing.TabStop:=False;
    EtvDBLookupCombo6.TabStop:=False;
    XDBEdit10.TabStop:=False;
    EditClientKName.TabStop:=False;
    EditTOperName.TabStop:=False;
    DBMemo1.DataField:='Destination';
  end;
  *)

  {Определяем разрешение экрана и в зависимости от этого масштабируем форму}
  {AMScaleForm(self);}

  //add scaling 2
  //if (PageControl1.TabHeight < Panel1.Height) then PageControl1.TabHeight := Panel1.Height;

  if UserName='ADMIN' then EditDatePay.ReadOnly:=false;
  with ModuleBase do
    if IsProgrammers then GfxShbEdit.Enabled:=true;
end;

Procedure TFormPayDoc.CheckBoxActiveClick(Sender: TObject);
begin
(*
  inherited;
  if CheckBoxActive.Checked then EditActive.Enabled:=true
  else EditActive.Enabled:=false;
*)
end;

Procedure TFormPayDoc.Button1Click(Sender: TObject);
var OldLayout,Layout: array[0.. KL_NAMELENGTH] of char;
begin
  with Self.PopupMenu do begin
    GetKeyboardLayoutName(OldLayout);
    if OldLayout <>'00000419' then
      LoadKeyboardLayout(StrPCopy(Layout,'00000419'),KLF_ACTIVATE);
    PostMessage(WindowHandle,WM_KEYDOWN,188,0);
//    PostMessage(WindowHandle,WM_KEYDOWN,76{74},0);
    {Popup(Button1.Left+Panel1.Left+Self.Left+Button1.Width,Button1.Top+Panel1.Top+Self.Top+Button1.Height);}
    Popup(Self.Left+1, Self.Top+1);
    {Popup(Self.Left+PageControl1.Left+Panel1.Left+Button1.Left+5, Self.Top+PageControl1.Top+Panel1.Top+Button1.Top+50);}
  end;
  LoadKeyboardLayout(StrPCopy(OldLayout,String(OldLayout)),KLF_ACTIVATE);
end;

procedure TFormPayDoc.XLabel2DblClick(Sender: TObject);
begin
  inherited;
  EditClientDName.Visible:= not EditClientDName.Visible;
  EditClientDNameStr.Visible:= not EditClientDNameStr.Visible;
end;

procedure TFormPayDoc.XLabel8DblClick(Sender: TObject);
begin
  inherited;
  EditClientKName.Visible:= not EditClientKName.Visible;
  EditClientKNameStr.Visible:= not EditClientKNameStr.Visible;
end;

Procedure TFormPayDoc.N6Click(Sender: TObject);
begin
  inherited;
  { Отправка помеченных документов в банк }
  if MessageDlg('Вы действительно хотите отправить помеченные документы в банк?',mtConfirmation,
     [mbYes,mbNo],0)=mrNo then Exit;
  ExecSQLText(ModuleBase.KSMDataBase.DataBaseName,'call STA.CreateBankPays()',false);
end;

procedure TFormPayDoc.XLabel35DblClick(Sender: TObject);
begin
  inherited;
  EditOrgKInn.Visible:= not EditOrgKInn.Visible;
  EditOrgKInnStr.Visible:= not EditOrgKInnStr.Visible;
end;

Initialization
  RegisterAliasXForm('FormPayDoc', TFormPayDoc);
Finalization
  UnRegisterXForm(TFormPayDoc);
end.
