Unit Prod;

Interface

uses
  MBEForms, DBCtrls, EtvLook, XECtrls, StdCtrls, Mask, EtvContr, Controls,
  RXCtrls, XCtrls, DBIndex, ExtCtrls, Grids, Forms,
  DBGrids, EtvGrid, ComCtrls, Classes, XMisc, VG, EtvShb, RXSwitch,
  XETrees, Dialogs, ExtDlgs, XDBForms, Menus, SrcIndex, EtvPages;

type
  TFormProd = class(TMBEForm)
    XLabel1: TXLabel;
    EditKod: TXEDBEdit;
    XLabel2: TXLabel;
    EditName: TXEDBEdit;
    XLabel5: TXLabel;
    EditUnitMName: TXEDBLookupCombo;
    XLabel6: TXLabel;
    EditSLength: TXEDBEdit;
    XLabel7: TXLabel;
    EditWidth: TXEDBEdit;
    XLabel8: TXLabel;
    EditHeight: TXEDBEdit;
    XLabel9: TXLabel;
    EditMassa: TXEDBEdit;
    XLabel12: TXLabel;
    EditShopName: TXEDBLookupCombo;
    XLabel10: TXLabel;
    EditVolume: TXEDBEdit;
    XLabel11: TXLabel;
    EditFullName: TXEDBEdit;
    XLabel13: TXLabel;
    EditStandard: TXEDBEdit;
    XLabel14: TXLabel;
    EditKodUpName: TXEDBLookupCombo;
    SwitchTree: TRxSwitch;
    XLabel15: TXLabel;
    TreeViewProd: TXEDBTreeView;
    ButtonModifyPrice: TRxSpeedButton;
    ButtonReportProd: TRxSpeedButton;
    ButtonTreeTable: TRxSpeedButton;
    ButtonSortTypeTree: TRxSpeedButton;
    XLabel3: TXLabel;
    EditConversion: TXEDBEdit;
    TabSheet3: TTabSheet;
    XEDbGrid1: TXEDbGrid;
    TabSheet4: TTabSheet;
    GridPlanProd: TXEDbGrid;
    XLabel4: TXLabel;
    EditSquare: TXEDBEdit;
    ButtonRebuildTree: TRxSpeedButton;
    ButtonReportProdPrice: TRxSpeedButton;
    ButtonExpand: TRxSpeedButton;
    ButtonCollapse: TRxSpeedButton;
    ButtonExpandBranch: TRxSpeedButton;
    RxSpeedButton1: TRxSpeedButton;
    TabSheet5: TTabSheet;
    EditDescription: TDBRichEdit;
    FontDialog1: TFontDialog;
    DBImage1: TDBImage;
    OpenPictureDialog1: TOpenPictureDialog;
    TreeStaticText: TStaticText;
    TabSheet6: TTabSheet;
    Grid2: TXEDbGrid;
    XLabel16: TXLabel;
    EditOldKod: TXEDBEdit;
    XEDBLookupCombo1: TXEDBLookupCombo;
    XLabel17: TXLabel;
    Panel1: TPanel;
    Splitter1: TSplitter;
    EtvTabSheet1: TEtvTabSheet;
    XEDbGrid2: TXEDbGrid;
    XEDBLookupCombo2: TXEDBLookupCombo;
    EditDensity: TXEDBEdit;
    XLabel18: TXLabel;
    procedure SwitchTreeClick(Sender: TObject);
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonModifyPriceClick(Sender: TObject);
    procedure ButtonReportProdClick(Sender: TObject);
    procedure ButtonTreeTableClick(Sender: TObject);
    function EtvShbCondition(Sender: TObject; aName: String): Boolean;
    procedure ButtonSortTypeTreeClick(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure DetailPagesChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure ButtonRebuildTreeClick(Sender: TObject);
    procedure ButtonExpandClick(Sender: TObject);
    procedure ButtonExpandBranchClick(Sender: TObject);
    procedure ButtonCollapseClick(Sender: TObject);
    procedure ButtonCollapseBranchClick(Sender: TObject);    
    procedure DetailPagesChange(Sender: TObject);
    procedure EditDescriptionDblClick(Sender: TObject);
    procedure DBImage1DblClick(Sender: TObject);
    procedure EtvDbGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EtvDbGrid1TitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    Shb:TEtvShb;
    { Public declarations }
  end;

Implementation

Uses SysUtils, Windows, Messages, Graphics, DB, DBTables, MdProd, EtvDbFun,
     XCracks, EtvPas, EtvRus, EtvFilt, PriceDlg, DlgOneDate, MdBase, XApps, Misc;

{ Код отчета из таблицы Reports }
Const Rep: array[1..3] of byte=(3,4,3);

var ExitKod: integer;
    EtvFilter:TEtvFilter;
    S:String;
    ReportForBranch, { Отчет только по ветке           }
    ExpandAll,       { Открыть всю ветку (дерево)      }
    StateOn,
    PageFocused: boolean;
    Report:byte; { 0 - Справочник продукции КСМ        }
                 { 1 - Отчет по ценам на заданную дату }
                 { 2 - Отчет по ценам по диапазону дат }
                 { 3 - Отчет по ценам на панели        }

{$R *.DFM}

procedure TFormProd.SwitchTreeClick(Sender: TObject);
var i:integer;
    {kod:integer;}
begin
  inherited;
  with TreeViewProd do begin
    if not SyncDataSet then begin
      {Kod:=ModuleProd.ProdDeclarKod.Value;}
      {ModuleProd.ProdDeclar.DisableControls;}
      {DataSource:=nil;
      DataSource:=ModuleProd.ProdCProdSrc;}
      with ModuleProd.ProdDeclar do
        if (IndexName<>'ProdKodUp') and (IndexFieldNames<>'KodUp') then
          SortingToDataSet(TTable(ModuleProd.ProdDeclar),'KodUp',false,false);
      PageControl1PanelNavigator.BeforeAction:=TreeViewProd.NavigatorClick;
      with FormSheet do
        for i:=0 to ControlCount-1 do
          if Controls[i].Tag=99 then begin
            if Controls[i] is TEtvDBLookupCombo then
              TEtvDBLookupCombo(Controls[i]).OnKeyDown:=EditKeyDown
            else TWinControlSelf(Controls[i]).OnKeyDown:=EditKeyDown;
          end;
      SyncDataSet:=true;
      {GoToNode(Kod); ---- }
      {ModuleProd.ProdDeclar.EnableControls;}
    end else begin
      PageControl1PanelNavigator.BeforeAction:=nil;
      with FormSheet do
        for i:=0 to ControlCount-1 do
          if Controls[i].Tag=99 then begin
             if Controls[i] is TEtvDBLookupCombo then
               TEtvDBLookupCombo(Controls[i]).OnKeyDown:=nil {EditKodUpNameKeyDown}
             else TWinControlSelf(Controls[i]).OnKeyDown:=nil;
          end;
      SyncDataSet:=false;
    end;
  end;
end;

procedure TFormProd.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Sender is TEtvDBLookUpCombo) and TEtvDBLookUpCombo(Sender).ListVisible then Exit;
  with PageControl1PanelNavigator do
    Case Key of
      VK_HOME: if ssCtrl in Shift then BeforeAction(TreeViewProd,nbFirst);
      VK_END:  if ssCtrl in Shift then BeforeAction(TreeViewProd,nbLast);
      VK_PRIOR: BeforeAction(TreeViewProd,nbPrior);
      VK_NEXT:  BeforeAction(TreeViewProd,nbNext);
    end;
  if ((ssCtrl in Shift) and (Key in [VK_HOME,VK_END])) or (Key in [VK_PRIOR,VK_NEXT])
    then Key:=0;
end;

(*
Function Permission(aUserList:String);
begin
  with ModuleBase.KSMDataBase do
    if (UpperCase(UserName)<>'SHMIDT') and (UpperCase(UserName)<>'LEV') and
       (UpperCase(UserName)<>'GAL') then begin
      ShowMessage('Данная команда не доступна пользователю '+UpperCase(UserName));
      Exit;
    end;
end;
*)

Procedure TFormProd.ButtonModifyPriceClick(Sender: TObject);
const ccVolume=idOk;
      ccKoeff=idYes;
      ccBid=idIgnore;
      aDate:TDateTime=0;
      aKoeff:Double=0;
      aKoeffExtra:Double=0;
      aTare:SmallInt=0;
      aTPrice:SmallInt=1;
      aKoeffRateVAT:Real=1;
      aDate2000=36526;
var FormPriceDlg: TFormPriceDlg;
    OldNode: TvgDBTreeNode;
    CountProd,UnCountProd: integer;
    Node: TTreeNode;
    V:Variant;
    DlgResult:integer;
    aBid:Double;
    aAround: Integer;
    {aDate: TDateTime;}
    FirstEntry: boolean;
    UpdateExistRecord:boolean;
label ExitLabel;
begin
  inherited;
  with ModuleBase do
    if not IsProgrammers and (UserName<>'SHMIDT') and (UserName<>'GAL')
    and (UserName<>'NATA') and (UserName<>'INNA') and (UserName<>'KISEL') then begin
      ShowMessage('Данная команда не доступна пользователю '+UserName);
      Exit;
    end;
  if not TreeViewProd.Focused then begin
    ShowMessage('Данная команда должна выполняться из дерева');
    Exit;
  end;
  OldNode:=TvgDBTreeNode(TreeViewProd.Selected);
  { Проверка на синхронизацию с формой }
  if not TreeViewProd.SyncDataSet then begin
    SwitchTree.ToggleSwitch;
    SwitchTreeClick(nil);
  end;
  { У ветки нет детей !!!}
  if ModuleProd.ProdDeclarAmountDown.Value=0 then begin
    ShowMessage('У выбранной ветки нет листьев!'+#13+'Выберите другую ветку');
    Exit;
  end;
  FirstEntry:=true;
  { Задание параметров переоценки }
  FormPriceDlg:=TFormPriceDlg.Create(nil);
  with FormPriceDlg do begin
    Caption:=Caption+TreeViewProd.Selected.Text{+' : '+IntToStr(OldNode.ID)};
    if aDate=0 then EditDate.Date:=Now
    else begin
      EditDate.Date:=aDate;
      EditKoeff.Value:=aKoeff;
      EditExtra.Value:=aKoeffExtra;
      EditTare.Value:=aTare;
      EditTPrice.Value:=aTPrice;
      EditKoeffRateVAT.Value:=aKoeffRateVAT;
    end;
    FormPriceDlg.ShowModal;
    { Создание новых цен по группе продукции }
    { ModalResult: 1 - mrOk, 2 - mrCancel, 6 - mrYes, 5 - mrIgnore }
    DlgResult:=FormPriceDlg.ModalResult;
    aDate:=EditDate.Date;
    aTare:=MRound(EditTare.Value);
    aTPrice:=MRound(EditTPrice.Value);
    aKoeff:=EditKoeff.Value;
    aKoeffExtra:=EditExtra.Value;
    aKoeffRateVAT:=EditKoeffRateVAT.Value;
    UpdateExistRecord:=CheckBoxUpdateExistRecord.Checked;
    FormPriceDlg.Free;
    if DlgResult=idCancel then Exit; { mrCamcel }
    { Инициализируем в Koeff цену за м3 или Коффициент переоценки }
    case DlgResult of
      ccVolume:
        with ModuleProd do begin
          PriceOnDate(ProdDeclarKod.Value,aTare,aTPrice,0,DateToStr(aDate),
            ThisPrice,ThisRateVAT,aBid,ThisExtra,ThisDatePrice,ThisPriceGross);
          if ThisPrice<=0 then begin
            ShowMessage('Некорректная цена за м3. Проверьте еще раз');
            Exit;
          end;
        end;
      ccKoeff:
        if aKoeff=1 then begin
          ShowMessage('Коэффициент не может быть равен 1');
          Exit;
        end;
      ccBid:
        begin
          if (aKoeff=null) or (aKoeff<=0) then begin
            ShowMessage('Неверная торговая надбавка');
            Exit;
          end;
        end;
    end;
    if MessageDlg('Вы действительно желаете произвести обработку по продукции:'+#13+
      TreeViewProd.Selected.Text,mtConfirmation,[mbYes,mbNo],0)=mrNo then Exit;
  end;

  with ModuleProd, TreeViewProd do begin
    { Ускоряем работу с ProdPriceDDeclar, ProdDeclar }
    ModifyLookDataSetActive(ProdDeclar,false);
    ProdPriceDDeclar.DisableControls;
    ModifyLookDataSetActive(ProdPriceDDeclar,false);
    CountProd:=0; UnCountProd:=0;
    if not OldNode.Expanded then
      if DlgResult<>ccBid then OldNode.ExpandSafe(false) else OldNode.ExpandSafe(true);
    {Node:=Selected.GetFirstChild;}
    if DlgResult=ccBid then begin
      Node:=OldNode;
      while Node.GetLastChild<>nil do Node:=Node.GetLastChild;
      if Node.GetNext<>nil then
        ExitKod:=TvgDBTreeNode(Node.GetNext).ID
      else ExitKod:=-1;
      Node:=OldNode.GetFirstChild;
    end else Node:=Selected.GetFirstChild;
    if Node=nil then begin
      ShowMessage('Не найден первый листок');
      GoTo ExitLabel;
    end else
    while Node<>nil do begin
      Selected:=Node;
        { Работа с ProdPriceDDeclar }
        { Есть уже хотя бы одна цена }
      if (ProdDeclarAmountDown.Value=0) and
        (MessageDlg('Обработать продукцию:'+TreeViewProd.Selected.Text,mtConfirmation,[mbYes,mbNo],0)=mrYes) then
        case DlgResult of
          ccKoeff:
            if not ProdPriceDDeclar.Eof then with ProdPriceDDeclar do begin
              Last;
              if (ProdPriceDPrice.Value>0) and (ProdPriceDSDate.Value<>aDate) then begin
                V:=FieldValues['Prod;SDate;Price;TPrice;BaseTPrice;Tare;RateVAT;Bid;Extra'];
                if UpdateExistRecord then Edit else Insert;
                FieldValues['Prod;SDate;Price;TPrice;BaseTPrice;Tare;RateVAT;Bid;Extra']:=V;
                FieldValues['SDate']:=aDate;
                aAround:=RoundRB(aDate,false,false);
                { Округление }
                FieldValues['Price']:=Integer(MRound(ProdPriceDPrice.Value*aKoeff/aAround)*aAround);
                Post;
                Inc(CountProd);
              end else begin
                ShowMessage('Невозможно создать новую цену по продукции'+#13+
                ProdPriceDProd.AsString+#13+'или цен вообще нет'+#13+
                'или неверно задана дата переоценки');
                Inc(UnCountProd);
              end;
            end else Inc(UnCountProd);
          ccVolume:
            if ProdDeclarVolume.Value>0 then
              with ProdPriceDDeclar do begin
                if UpdateExistRecord then begin
                  if Locate('Prod;Tare;TPrice;BaseTPrice;SDate',
                  VarArrayOf([ProdDeclarKod.Value,aTare,aTPrice,0,aDate]),[]) then Edit
                  else Insert;
                end else Insert;
                FieldValues['Prod']:=ProdDeclarKod.Value;
                FieldValues['Tare']:=aTare;
                FieldValues['TPrice']:=aTPrice;
                FieldValues['BaseTPrice']:=0;
                FieldValues['SDate']:=aDate;
                aAround:=RoundRB(aDate,false,false);
                FieldValues['Bid']:=aKoeff;
                FieldValues['RateVAT']:=aKoeffRateVAT;
                FieldValues['Extra']:=aKoeffExtra;
                FieldValues['Price']:=Integer(MRound(ProdDeclarVolume.Value*ThisPrice/aAround)*aAround);
                FieldValues['PriceGross']:=
                  Integer(MRound(ProdDeclarVolume.Value*ThisPriceGross/aAround)*aAround);
                Post;
                Inc(CountProd);
              end
            else begin
              ShowMessage('Невозможно создать новую цену по продукции'+#13+
              ProdDeclarName.AsString+#13+'неверный объем');
              Inc(UnCountProd);
            end;
          ccBid:
            begin
              { Готовим Query запрос }
              with ModuleBase.QueriesDeclar do begin
                if FirstEntry then begin
                  SQL.Clear;
                  SQL.Add('call STA.SetProdBid(:InProd,:InDate,:InBid)');
                  Params[0].DataType:=ftInteger;
                  Params[1].DataType:=ftDate;
                  Params[2].DataType:=ftFloat;
                  Params[0].Value:=ProdDeclarKod.Value;
                  Params[1].Value:=aDate;
                  Params[2].Value:=aKoeff;
                  Prepare;
                  FirstEntry:=false;
                end else { Меняется только код продукции }
                  Params[0].Value:=ProdDeclarKod.Value;
                ExecSQL;
              end;
              Inc(CountProd);
            end;
        end
      else Inc(UnCountProd);
      if DlgResult<>ccBid then Node:=Selected.GetNextSibling
      else begin
        if TvgDBTreeNode(Node.GetNext).ID=ExitKod then Node:=nil
        else Node:=Selected.GetNext;
      end;
    end;
    Selected:=OldNode;
    ShowMessage('Обработка по группе: '+ProdDeclarName.Value+' - закончена'+#13+
                'Обработано    -  '+IntToStr(CountProd)+#13+
                'Необработано -  '+IntToStr(UnCountProd)+'  вид(а)ов) продукции');
 ExitLabel:
    ModifyLookDataSetActive(ProdPriceDDeclar,true);
    ProdPriceDDeclar.EnableControls;
    ModifyLookDataSetActive(ProdDeclar,true);
  end;
end;

procedure TFormProd.ButtonReportProdClick(Sender: TObject);
var Node:TTreeNode;
    i :byte;
begin
  inherited;
  DialogOneDate:=TDialogOneDate.Create(Application);

  if TComponent(Sender).Name='ButtonReportProd' then begin
    Report:=0;
    with DialogOneDate do begin
      BitBtn1.Caption:='OK';
      BitBtn3.Visible:=false;
    end;
  end else Report:=1;

  with DialogOneDate,ModuleBase do begin
    if Report=1 then begin
      Caption:='Отчет по ценам на продукцию';
      CheckBoxFilterCondition.Visible:=true;
    end else DialogOneDate.Caption:='Справочник продукции КСМ';
    if VarIsEmpty(ReportParams[0]) then EditDateBeg.Date:=Now
    else begin
      EditDateBeg.Date:=ReportParams[0];
      EditDateEnd.Date:=ReportParams[1];
    end;
  end;
  if (DialogOneDate.ShowModal in [mrOk,mrYes]) and (DialogOneDate.EditDateBeg.Date>0) then
  with DialogOneDate do try
    ModuleBase.ReportParams[0]:=EditDateBeg.Date;
    if ModalResult=mrYes then Report:=3;
    if (Report=1) and (EditDateEnd.Date>0) then begin
      Report:=2;
      ModuleBase.ReportParams[1]:=EditDateEnd.Date;
    end;
    ReportForBranch:=CheckBoxCurBranch.Checked;
    ExpandAll:=CheckBoxExpandAll.Checked;
    if ReportForBranch and not Assigned(TreeViewProd.Selected) then begin
      ShowMessage('Не выбрана ветка для отчета');
      Abort;
    end;
    Shb:=TEtvShb.Create(Self);
    with Shb do
      case Report of
        0:   begin
               Name:='Prod';
               FileName:=DirShb+'\Prod';
               Caption:='Справочник продукции КСМ';
             end;
        1,2: begin
               Name:='ProdPrice';
               FileName:=DirShb+'\ProdPrice';
               Caption:='Справочник цен на продукцию';
             end;
        3:   begin
               if MessageDlg('Да - Полный справочник цен   Нет - Усеченный ',
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                 begin
                   Name:='ProdPrice1';
                   FileName:=DirShb+'\ProdPrice1'
                 end else begin
                   Name:='ProdPrice2';
                   FileName:=DirShb+'\ProdPrice2';
                 end;
               Caption:='Справочник цен на панели';
             end;
      end;
    Shb.Hyphen:=true;
    Shb.OnCondition:=EtvShbCondition;
    {Shb.DOSFile:=false;}
    if Assigned(Shb) then with Shb do begin
      {try}
        if Report in[1..3] then
          AssignAdditional('Filter','',taLeftJustify,false);
        if Report=2 then
          AssignAdditional('DateStr',DateToStrEtv(EditDateEnd.Date),taLeftJustify,false)
        else AssignAdditional('DateStr',DateToStrEtv(EditDateBeg.Date),taLeftJustify,false);
        AssignAdditional('BranchName','',taLeftJustify,false);
        if ReportForBranch then
          if Report<>3 then
            AssignAdditional('BranchName','Ветка :'+TreeViewProd.Selected.Text,taLeftJustify,false)
          else with ModuleProd do begin
            ProdDeclar.Locate('Kod',TvgDBTreeNode(TreeViewProd.Selected).ID,[]);
            AssignAdditional('BranchName','Группа :'+ProdDeclarFullName.Value,taLeftJustify,false);
          end;
        { Цена за м.куб и процент торговой надбавки для справочника цен на панели }
        if Report=3 then with ModuleProd do begin
          PriceOnDate(TvgDBTreeNode(TreeViewProd.Selected).ID,1,EditTPrice.AsInteger,0,EditDateBeg.Text,
            ThisPrice,ThisRateVAT,ThisBid,ThisExtra,ThisDatePrice,ThisPriceGross);
          AssignAdditional('PriceM3',FloatToStr(ThisPrice),taRightJustify,false);
          AssignAdditional('Bid',FloatToStr(ThisBid),taRightJustify,false);
        end;
        AssignDataSet('Prod',ModuleProd.ProdDeclar);
        if Report>0 then begin
          AssignDataSet('ProdPrice',ModuleBase.QueriesDeclar);
          with ModuleBase,ModuleBase.QueriesDeclar do begin
            Filter:='';
            SQL.Clear;
            SQL.Add(SQLString(Rep[Report],''));
            TableName:=CutFirstWord(ReportsViewName.Value,['.']);
            for i:=0 to Params.Count-1 do begin
              Params[i].DataType:=ftDate;{FieldByName(Params[i].Name).DataType;}
              Params[i].Value:=ReportParams[i];
            end;
            Open;
            { Определение цены за М3  }
            if CheckBoxFilterCondition.Checked then begin
              DataSetViewLabel(ModuleBase.QueriesDeclar);
              EtvFilter:=TEtvFilter.Create(nil);
              with EtvFilter do try
                {OneFilter:=true;}
                DataSource:=Queries;
                if Show=idOk then begin
                  S:=ConstructFilter(nil,true,fuSet);
                  SQL.Clear;
                  SQL.Add(SQLString(Rep[Report],S));
                  for i:=0 to Params.Count-1 do begin
                    Params[i].DataType:=ftDate;{FieldByName(Params[i].Name).DataType;}
                    Params[i].Value:=ReportParams[i];
                  end;
                  Open;
                  DataSetViewLabel(ModuleBase.QueriesDeclar);
                  AssignAdditional('Filter',ConstructFilterInfo(nil),taLeftJustify,false);
                end;
              finally
                Free;
              end;
            end;
          end;
        end;
        ModuleProd.ProdDeclar.DisableControls;
        { Делаем подготовительную работу для дерева }
          Node:=TreeViewProd.Selected;
          RunModalViewer;
          ModuleProd.ProdDeclar.EnableControls;
          if not SwitchTree.StateOn then TreeViewProd.SyncDataSet:=false;
          if Node<>nil then TreeViewProd.Selected:=Node;
        {TreeViewProd.Visible:=true;}
      {finally
        Free;
      end;}
    end;
  finally
    {if Report>0 then EtvFilter.Free;}
    DialogOneDate.Free;
    Shb.Free;
  end;
end;

function TFormProd.EtvShbCondition(Sender: TObject; aName: String): Boolean;
Const Prod=1;
      AmountDownNotIsNull=2;
      ProdPrice=3;
      DrawLine=4;
      EndList=5;
      LengthList=50;
      NumEntry: byte=0;
      ProdPriceFirst:boolean=true;
      DrawLineFlag:boolean=true;
      TotalPrice: double=0;
      RowCount: integer=0; { Счетчик строк для листа }
Var   Entry: byte;
      NumList:integer;
      Node:TTreeNode;
begin
  if aName='Prod' then Entry:=Prod
  else if aName='AmountDownNotIsNull' then Entry:=AmountDownNotIsNull
  else if aName='ProdPrice' then Entry:=ProdPrice
  else if aName='DrawLine' then Entry:=DrawLine
  else if aName='EndList' then Entry:=EndList;
  inherited;
  Result:=false;
  case Entry of
    Prod:
      with TreeViewProd do begin
        case NumEntry of
          0: begin
               if ReportForBranch then begin
                 if ExpandAll then TvgDBTreeNode(Selected).ExpandSafe(True)
               end else begin
                 if ExpandAll then FullExpandSafe;
               end;
               SyncDataSet:=true;
               if Not ReportForBranch then Selected:=Items.GetFirstNode
               else begin
                 Node:=Selected;
                 while Node.GetLastChild<>nil do Node:=Node.GetLastChild;
                 if Node.GetNext<>nil then
                   ExitKod:=TvgDBTreeNode(Node.GetNext).ID
                 else ExitKod:=-1;
               end;
               S:=ModuleBase.QueriesDeclar.Filter;
               if S<>'' then S:=S+' and ';
               NumEntry:=1;
             end;
          1: begin
               Selected:=Selected.GetNextVisible;
               NumEntry:=2;
             end;
          2: if ExpandAll then
               Selected:=Selected.GetNextVisible
             else Selected:=Selected.GetNextSibling;
        end;
        if (Selected<>nil) and (not ReportForBranch or
        (TvgDBTreeNode(Selected).ID<>ExitKod)) then with ModuleProd do begin
          Result:=true;
        end else begin
          if TEtvShb(Sender).Name='ProdPrice' then begin
            Shb.AssignAdditional('TotalPrice',FloatToStr(TotalPrice),taRightJustify,false);
            TotalPrice:=0;
          end;
          NumEntry:=0;
          RowCount:=0;
          DrawLineFlag:=true;
        end;
      end;
    AmountDownNotIsNull:
      begin
        if ModuleProd.ProdDeclarAmountDown.Value>0 then Result:=true;
        if Report=3 then with ModuleBase.QueriesDeclar do
          Filter:=S+'(Prod='+ModuleProd.ProdDeclarKod.AsString+')';
      end;
    ProdPrice:
      with ModuleBase.QueriesDeclar do begin
        if ProdPriceFirst then begin
          Filter:=S+'(Prod='+ModuleProd.ProdDeclarKod.AsString+')';
          ProdPriceFirst:=false;
        end else Next;
        if not Eof then begin
          Result:=true;
          TotalPrice:=TotalPrice+FieldByName('Price').AsFloat;
          Inc(RowCount);
        end else begin
          Result:=false;
          ProdPriceFirst:=true;
        end;
      end;
    DrawLine:
      if ModuleProd.ProdDeclarAmountDown.Value>0 then begin
        if Not DrawLineFlag then begin
          DrawLineFlag:=true;
          Result:=true;
        end;
      end else begin
        if DrawLineFlag then begin
          DrawLineFlag:=false;
          Result:=true;
        end;
      end;
    EndList:
      begin
        if ((RowCount mod LengthList)=0) and not(ModuleBase.QueriesDeclar.Eof) then begin
          Shb.AssignAdditional('NumList',IntToStr(RowCount div LengthList+1),taLeftJustify,false);
          Result:=true;
        end;
      end;
  end;
end;

procedure TFormProd.ButtonSortTypeTreeClick(Sender: TObject);
const Rezh:byte=0;
begin
  inherited;
  TreeStaticText.Caption:='Ждите идет сортировка ...';
  Screen.Cursor:=crHourglass;
  ModuleProd.ProdDeclar.DisableControls;
  Rezh:=(Rezh+1) mod 3;
  Case Rezh of
    0: begin
         with TreeViewProd do begin
           SortType:=stData;
           DefaultSortProc:=@CustomSortProc;
           TreeViewProd.CustomSort(DefaultSortProc,0);
         end;
         TreeStaticText.Caption:='Сортировка по коду';
      end;
    1: begin
         TreeViewProd.SortType:=stText;
         TreeStaticText.Caption:='Сортировка по наименованию';
       end;
    2: begin
         with TreeViewProd do begin
           SortType:=stData;
           DefaultSortProc:=@SortProc1;
           TreeViewProd.CustomSort(DefaultSortProc,0);
         end;
         TreeStaticText.Caption:='Сортировка для панелей';
       end;
  end;
  ModuleProd.ProdDeclar.EnableControls;
  Screen.Cursor:=crDefault;
end;

procedure TFormProd.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if TPageControl(Sender).ActivePage.Name='FormSheet' then
    if SwitchTree.StateOn then begin
      SwitchTree.ToggleSwitch;
      SwitchTreeClick(nil);
    end;
end;

{ Событие происходит перед тем, как страница в PageControl'е поменяется }
procedure TFormProd.DetailPagesChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  if (TPageControl(Sender).ActivePage.Name<>'TabSheet2') and
    ((EtvDBGrid1.Focused) or (GridPlanProd.Focused)) then PageFocused:=true
  else PageFocused:=false;
  if TPageControl(Sender).ActivePage.Name='TabSheet2' then
    if SwitchTree.StateOn then begin
      StateOn:=true;
      SwitchTree.ToggleSwitch;
      SwitchTreeClick(nil);
    end else StateOn:=false;
end;

{ Событие происходит после того, как страница в PageControl'е поменялась }
procedure TFormProd.DetailPagesChange(Sender: TObject);
begin
  inherited;
  if TPageControl(Sender).ActivePage.Name='TabSheet2' then begin
    if StateOn then begin
      TreeViewProd.GoToNode(ModuleProd.ProdDeclarKod.Value);
      SwitchTree.ToggleSwitch;
      SwitchTreeClick(nil);
    end;
    if PageFocused then TreeViewProd.SetFocus;
  end;
end;

procedure TFormProd.ButtonRebuildTreeClick(Sender: TObject);
var Kod: integer;
begin
  inherited;
  { Перестроить дерево }
  with TreeViewProd do begin
    if not Assigned(Selected) then Selected:=Items.GetFirstNode;
    Kod:=TvgDBTreeNode(Selected).ID;
    DataSource:=nil;
    DataSource:=ModuleProd.Prod;
    GoToNode(Kod);
  end;
end;

procedure TFormProd.ButtonTreeTableClick(Sender: TObject);
begin
  inherited;
  { Тормозючий процесс выполняется на Client'е примерно за 5-6 мин.
  with ModuleProd do
    GenerateTreeTable(ProdLookup,ProdTreeDeclar,ProdLookupKod,ProdLookupKodUp,ProdLookupAmountDown);
   }
  { То же самое на сервере 10-15 сек. }
    { Готовим Query запрос }
  with ModuleBase.QueriesDeclar do begin
    SQL.Clear;
    SQL.Add('call STA.GenerateProdTree()');
    ExecSQL;
    ShowMessage('Таблица ProdTree сформирована!');
  end;
end;

procedure TFormProd.ButtonExpandClick(Sender: TObject);
begin
  inherited;
  with TreeViewProd do begin
    if Not Assigned(Selected) then Selected:=Items[0];
    FullExpandSafe;
    TopItem:=Selected;
    {Selected:=Selected;}
  end;
end;

procedure TFormProd.ButtonExpandBranchClick(Sender: TObject);
var Node: TTreeNode;
begin
  inherited;
  with TreeViewProd do begin
    if Not Assigned(Selected) then Exit;
    Node:=Selected;
    TvgDBTreeNode(Selected).ExpandSafe(true);
    Selected:=Node;
  end;
end;

procedure TFormProd.ButtonCollapseClick(Sender: TObject);
begin
  inherited;
  with TreeViewProd do begin
    FullCollapse;
    Selected:=Items[0];
    TopItem:=Selected;
  end;
end;

procedure TFormProd.ButtonCollapseBranchClick(Sender: TObject);
begin
  inherited;
  with TreeViewProd do begin
    if Not Assigned(Selected) then Exit;
    Selected.Collapse(true);
    {TopItem:=Selected;}
  end;
end;

procedure TFormProd.EditDescriptionDblClick(Sender: TObject);
begin
  inherited;
  with FontDialog1 do begin
    Execute;
    EditDescription.Font:=Font;
  end;
end;

procedure TFormProd.DBImage1DblClick(Sender: TObject);
begin
  inherited;
  if OpenPictureDialog1.Execute then begin
    with ModuleProd do begin
      if ProdDeclar.State=dsBrowse then ProdDeclar.Edit;
      if ProdDeclar.State in [dsEdit,dsInsert] then
        ProdDeclarPhoto.loadFromFile(OpenPictureDialog1.filename);
    end;
  end;
end;

var OldValues:Variant;

procedure TFormProd.EtvDbGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
const MaxRows=25;
      LimRows:integer=-1; { Кол-во выделенных строк }
      First:boolean=true;
      Si:string='';
var   i:byte;
      MyBookMark:TBookMark;
begin
  inherited;
  if (Shift=[ssCtrl]) and (Key=VK_INSERT) and (TDBGrid(Sender).Name='EtvDbGrid1') and
  (EtvDBGrid1.SelectedRows.Count>0) then begin
    LimRows:=EtvDBGrid1.SelectedRows.Count-1;
    if LimRows>MaxRows then begin
      ShowMessage('Слишком много выделенных строк');
      Exit;
    end;
    if First then begin
      OldValues:=VarArrayCreate([0, MaxRows],varVariant);
      First:=false;
    end;
    with ModuleProd.ProdPriceDDeclar do begin
      Si:='';
      for i:=1 to FieldCount-1 do Si:=Si+';'+Fields[i].FieldName;
      System.Delete(Si,1,1);
      DisableControls;
      MyBookMark:=GetBookMark;
      for i:=0 to LimRows do begin
        GotoBookMark(Pointer(EtvDBGrid1.SelectedRows[i]));
        OldValues[i]:=FieldValues[Si];
      end;
      EtvDBGrid1.SelectedRows.Clear;
      GotoBookMark(MyBookMark);
      FreeBookMark(MyBookMark);
      EnableControls;
    end;
  end;
  if (Shift=[ssShift,ssCtrl]) and (Key=VK_INSERT) and (LimRows>-1)
  and (TDBGrid(Sender).Name='EtvDbGrid1') then begin
    with ModuleProd.ProdPriceDDeclar do begin
      if MessageDlg('Вставить запомненные записи в таблицу?',
        mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;
      DisableControls;
      MyBookMark:=GetBookMark;
      for i:=0 to LimRows do begin
        Insert;
        FieldValues[Si]:=OldValues[i];
        try
          Post;
        except
          Cancel;
        end;
      end;
      GotoBookMark(MyBookMark);
      FreeBookMark(MyBookMark);
      EnableControls;
    end;
    {LimRows:=-1;}
  end;
end;

procedure TFormProd.EtvDbGrid1TitleClick(Column: TColumn);
begin
  inherited;
  with EtvDBGrid1 do begin
    if (dgMultiSelect in Options) then begin
      Options:=Options-[dgMultiSelect];
      with TitleFont do begin
        Style:=Style-[fsBold];
        Color:=clBlack;
      end;
      ShowMessage('Режим работы с группой записей ОТКЛЮЧЕН');
    end else begin
      Options:=Options+[dgMultiSelect];
      with TitleFont do begin
        Style:=Style+[fsBold];
        Color:=clRed;
      end;
      ShowMessage('Режим работы с группой записей ВКЛЮЧЕН');
    end;
  end;
end;

procedure TFormProd.FormCreate(Sender: TObject);
begin
  inherited;
  with ModuleBase do
    if (UserName='LEV') then ButtonTreeTable.Enabled:=true
end;

procedure TFormProd.FormActivate(Sender: TObject);
begin
  inherited;
  if TFormProd(Sender).Tag=1 then begin
    TreeViewProd.DataSource:=ModuleProd.Prod;
    TFormProd(Sender).Tag:=0
  end;
end;

procedure TFormProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  // Отключаем дерево, чтобы не глючило
  if TFormProd(Sender).Tag=1 then begin
    TreeViewProd.DataSource:=nil;
  end;
end;

Initialization
  RegisterAliasXForm('FormProd', TFormProd);
Finalization
  UnRegisterXForm(TFormProd);
end.
