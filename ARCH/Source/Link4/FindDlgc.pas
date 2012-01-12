{*******************************************************}
{                                                       }
{   Find dialog form                                    }
{                                                       }
{   Last corrections 11.02.99                           }
{                                                       }
{*******************************************************}

Unit FindDlgc;

Interface

Uses Forms, StdCtrls, Buttons, Controls, ExtCtrls, Classes,
     DB, DBTables, DBIndex, Grids, DBGrids, DBCtrls, LnTables, LnkMisc,
     SrcIndex;

type
  TLnFindDlg = class(TForm)
    EditPanel: TPanel;
    ToolsPanel: TPanel;
    BtnPanel: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    IndexPanel: TPanel;
    FindDataSource: TDataSource;
    IndexCheck: TCheckBox;
    ChangeKeyBtn: TSpeedButton;
    OkContextBtn: TBitBtn;
    CloseCheck: TCheckBox;
    IndexCombo: TSrcLinkCombo;
    NavPanel: TPanel;
    Nav1: TDBNavigator;
    LikeSource: TDataSource;
    procedure IndexComboChange(Sender: TObject);
    procedure IndexCheckClick(Sender: TObject);
    procedure ChangeKeyBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OKBtnClick(Sender: TObject);
    procedure OkContextBtnClick(Sender: TObject);
    procedure CloseCheckClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure Nav1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure IndexComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FIsNotInitParams: Boolean;
    LC:boolean;{!Igo}
    FIsNavCancel: Boolean;
    FStoreWidth: Integer;
    FormHeight: Integer;
    ATop,ALeft: Integer;
    Lw,Ew: Integer;
    TextWidth: Integer;{!Val}
    FFindLink: TFindLink;
    Lab: TLabel;
    Ed: TWinControl;
    Field: TField;
    Edits: TList;
    Labels: TStrings;
    function GetIFNCheck: Boolean;
    procedure SetIFNCheck(Value: Boolean);
    procedure SetFindLink(aFindLink: TFindLink);
    procedure UpdateFindLinkValues;
  public
    procedure InitParams;
    procedure DestroyDlg;
    procedure InitDlg;
    procedure DoneDlg;
    procedure GoFind;
    property IFNCheck: Boolean read GetIFNCheck write SetIFNCheck;
    property FindLink: TFindLink read FFindLink write SetFindLink;
  end;
  { TLnFindDlg }
{
var
  LnFindDlg: TLnFindDlg;}

implementation

uses Windows, Messages, Dialogs, BDE, XCracks, XDBMisc, FVisDisp;

{$R *.DFM}

function TLnFindDlg.GetIFNCheck: Boolean;
begin
  Result:=IndexCheck.Checked;
end;

procedure TLnFindDlg.UpdateFindLinkValues;
begin
end;

procedure TLnFindDlg.SetIFNCheck(Value: Boolean);
begin
  IndexCheck.Checked:=Value;
end;

procedure TLnFindDlg.SetFindLink(aFindLink: TFindLink);
begin
  if aFindLink<>FFindLink then begin
    FFindLink:=aFindLink;
    if Assigned(FFindLink) then begin
      {}
    end;
  end;
end;

procedure TLnFindDlg.InitParams;
begin
  FIsNotInitParams:=False;
  FindDataSource.DataSet:=FindLink.FindDataset;
  Labels:=TStringList.Create;
  Edits:=TList.Create;
  FStoreWidth:=Width;
  FIsNavCancel:=False;
  TWinControlSelf(NavPanel).SetZOrder(True);
  FindDataSource.AutoEdit:=False;
  IFNCheck:=FindLink.IFNCheck;
  FIsNotInitParams:=True;
end;

procedure TLnFindDlg.DestroyDlg;
begin
  DoneDlg;
  Edits.Free;
  Labels.Free;
end;

procedure TLnFindDlg.InitDlg;
var i: Integer;
    aDataset: TDataset;
begin
  if Assigned(FindDataSource.DataSet) then begin
    Width:=FStoreWidth;
    aDataset:=FindDataSource.DataSet;
    with aDataset do begin
      FindLink.LikeList.Clear;
      GetFieldList(FindLink.LikeList, FindLink.IFN);
      { Определили высоту формы }
      FormHeight:=FindLink.LikeList.Count;
      if FormHeight*28+ToolsPanel.Height+34>=Screen.Height then begin
        Height:=Screen.Height-34
      end else Height:=FormHeight*28+ToolsPanel.Height+34;
      ATop:=8;
      ALeft:=EditPanel.Left+4;
      Lw:=0; Ew:=0;

      for i:=0 to FindLink.LikeList.Count-1 do begin
        Field:=TField(FindLink.LikeList.Items[i]);
        if Field.Tag=8 then Field:=GetLookField(Field);
        Labels.Add(Field.DisplayLabel);
      {end;}
      {for i:=0 to Labels.Count-1 do begin}
        if Length(Labels[i])>Lw then Lw:=Length(Labels[i])+1;
        if Field.DisplayWidth>Ew then Ew:=Field.DisplayWidth+2;
      end;
      if (FindLink.MaxLW>0) and (Lw>FindLink.MaxLW) then Lw:=FindLink.MaxLW;
      if (FindLink.MaxEW>0) and (Ew>FindLink.MaxEW) then Ew:=FindLink.MaxLW;{?!}

      TextWidth:=Canvas.TextWidth('0');
      Lw:=Lw*TextWidth;
      Ew:=Ew*TextWidth;
      if Left+ALeft+Lw+Ew+16>=Screen.Width then begin
        Width:=Screen.Width-ALeft-8;
        Ew:=Screen.Width-ALeft-Lw-16;
      end else begin
        if Lw+Ew+8>Width then Width:=Lw+Ew+20;
      end;

      for i:=0 to FindLink.LikeList.Count-1 do begin
        Field:=TField(FindLink.LikeList.Items[i]);
        if Field.Tag=8 then Field:=GetLookField(Field);
        Lab:=TLabel.Create(Self);
        Labels.Objects[i]:=Lab;
        Lab.Top:=ATop;
        Lab.Left:=ALeft;
        Lab.Caption:=Labels.Strings[i];

        {LevTest:=false;}
        if Assigned(Field.LookupDataSet) then begin
          LC:=true;
          Ed:=GetDispLookCombo(Self);
        end else begin
          LC:=false;
          Ed:=GetDispDBEdit(Self);
        end;

        if LC then begin
          if i<FindLink.FindValues.Count then
            SetDispLookField(Ed, Field, FindDataSource, FindLink.FindValues[i],
              (i<FindLink.FindValues.Count) and (FindLink.FindValues[i]<>''))
          else SetDispLookField(Ed, Field, FindDataSource,'',
                 (i<FindLink.FindValues.Count));
        end else begin
          if i<FindLink.FindValues.Count then
            SetDispDBEditField(Ed, TField(FindLink.LikeList.Items[i]),
              FindDataSource, FindLink.FindValues[i], (i<FindLink.FindValues.Count))
          else SetDispDBEditField(Ed, TField(FindLink.LikeList.Items[i]),
                 FindDataSource, '', (i<FindLink.FindValues.Count));
        end;
(**)
        Ed.Top:=ATop;
        Ed.Left:=ALeft+Lw;
(*
        if Ew<=(TField(FindLink.LikeList.Items[i]).DisplayWidth+2)*TextWidth then Ed.Width:=Ew
        else Ed.Width:=(TField(FindLink.LikeList.Items[i]).DisplayWidth+2)*TextWidth;
*)
        if Ew<=(Field.DisplayWidth+2)*TextWidth then Ed.Width:=Ew
        else Ed.Width:=(Field.DisplayWidth+2)*TextWidth;
(**)
        Lab.FocusControl:=Ed;
        Edits.Add(Ed);
        EditPanel.InsertControl(Lab);
        EditPanel.InsertControl(Ed);
        if i=0 then ActiveControl:=Ed;
        Inc(ATop,28);
      end;
      FindLink.SetFindState;
    end;
  end;
end;

procedure TLnFindDlg.DoneDlg;
var
  i: Integer;
begin
  for i:=0 to Labels.Count-1 do Labels.Objects[i].Free;
  for i:=0 to Edits.Count-1 do TWinControl(Edits.Items[i]).Free;
  Labels.Clear;
  Edits.Clear;
end;

procedure TLnFindDlg.GoFind;
var aValues: Variant{TStringList};
    i: Integer;
    IsPriz: Boolean;
begin
  IsPriz:=True;
  if not Assigned(FindDataSource.DataSet) then Exit;
  if FindLink.IsFirstFind then begin
    if FindLink.IsLikeFind then begin
      LinkDatasetListLocate(FindLink.LikeQuery, FindLink.FindDataset, FindLink.LikeList);
        LinkDatasetListLocate(FindLink.LikeQuery, FindLink.ModelDataset, FindLink.LikeList);
    end else{ ATable.Next};
  end else begin
    FindLink.IsFirstFind:=True;
    begin
      FindLink.CancelFindRange;
      UpdateFindLinkValues;
      aValues:=FindLink.GetFindValues;
      if FindLink.IsLikeFind then begin
        LikeSource.DataSet:=FindLink.LikeQuery;
        FindLink.ChangeFindLikeValues(aValues);
        LinkDatasetListLocate(FindLink.LikeQuery, FindLink.FindDataset, FindLink.LikeList);
        LinkDatasetListLocate(FindLink.LikeQuery, FindLink.ModelDataset, FindLink.LikeList);
      end else begin
        LikeSource.DataSet:=FindLink.FindDataset;
      end;
      if FindLink.IsLikeFind then begin
        NavPanel.Visible:=True;
        IndexCombo.Enabled:=False;
  {     FindLink.SetFindState;}
        for i:=0 to Edits.Count-1 do
          TWinControl(Edits[i]).Enabled:=False;
      end else
        if FindLink.SetFindRange(aValues) and FindLink.IsSetRange then begin
          if not FindLink.IsLikeFind then begin
            FindLink.FindDataset.First;
            NavPanel.Visible:=True;
            IndexCombo.Enabled:=False;
            for i:=0 to Edits.Count-1 do
              TWinControl(Edits[i]).Enabled:=False;
          end else TTable(FindLink.FindDataset).GoToNearest;
          FindLink.GotoCurrentFind(IsPriz);
        end;
    end;
  end;
  VarClear(AValues);
end;

Procedure TLnFindDlg.IndexComboChange(Sender: TObject);
begin
  if ((not IndexCombo.DroppedDown) or (IndexCombo.IsKeyReturn))
  and Assigned(FindDataSource.DataSet) then begin
    DoneDlg;
    if FindLink.FindState=ltTable then begin
      {FindLink.IFN:=TTable(FindLink.FindDataset).IndexFieldNames;}
      FindLink.IFN:=FindLink.IfnLink.Items[IndexCombo.SrcLinks.CurrentIndex].Fields;
      TTable(FindLink.FindDataset).IndexFieldNames;
      if IndexCheck.Checked then begin
        if FindLink.ModelState=ltTable then begin
          TTable(TLnTable(FindLink.FindDataset).CloneMaster).IndexFieldNames:=FindLink.IFN;
          {???}
        end;
      end;
    end;
    InitDlg;
    IndexCombo.ActiveChanged;
  end;
end;

procedure TLnFindDlg.IndexCheckClick(Sender: TObject);
begin
  if FIsNotInitParams then begin
    if Assigned(FindDataSource.DataSet) then begin
      if FindLink.FindState=ltTable then begin
        if IndexCheck.Checked then
          if FindLink.ModelState=ltTable then
            TTable(TLnTable(FindLink.FindDataset).CloneMaster).IndexFieldNames:=
              TLnTable(FindLink.FindDataset).IndexFieldNames;
      end;
    end;
    SelectFirst;
  end;
  FindLink.IFNCheck:=IndexCheck.Checked;
end;

procedure TLnFindDlg.ChangeKeyBtnClick(Sender: TObject);
begin
  if FindLink.IFNItem.ChooseOrderFields(FindLink.FindDataset, 'поиск') then begin
    DoneDlg;
    if FindLink.FindState=ltTable then begin
      TTable(FindLink.FindDataset).IndexFieldNames:=FindLink.IFN;
      IndexCombo.SrcLinkItem:=FindLink.IFNItem;
      IndexCombo.SrcLinks.CurrentIndex:=TIFNLink(IndexCombo.SrcLinks).IndexOfFields(FindLink.IFN);
      if IndexCheck.Checked then begin
        if FindLink.ModelState=ltTable then
          TTable(TLnTable(FindLink.FindDataset).CloneMaster).IndexFieldNames:=FindLink.IFN;
      end;
    end;
(*
        else
     if (FindLink.FindState=ltQuery)and(FindLink.ModelState=ltQuery) then begin
       if Assigned(FindLink.FindDataset) then begin
         FindLink.FindDataset.Active:=False;
         FindLink.FindDataset.Free;
       end;
       FindLink.FindDataset:=GetLinkCloneDataset(FindLink.ModelDataset, FindLink.ModelState, FindLink.FindState,
                          FindLink.ModelTableName, FindLink.ModelFieldNames, True{False}, True, FindLink.IFN, True);
        TQuery(FindLink.FindDataset).RequestLive:=True;
        FindDataSource.Dataset:=FindLink.FindDataset;
     end;
*)
    InitDlg;
  end;
end;

procedure TLnFindDlg.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult=mrOk then begin
    CanClose:=CloseCheck.Checked;
    if (not CanClose) and Assigned(FindDataSource.DataSet) then GoFind;
  end;
  if (ModalResult=mrCancel)and FIsNavCancel then begin
    FIsNavCancel:=False;
    CanClose:=False;
  end;
  if CanClose and (ModalResult=mrOk) then GoFind;
end;

procedure TLnFindDlg.OKBtnClick(Sender: TObject);
begin
  FindLink.IsLikeFind:=False;
  SelectFirst;
end;

procedure TLnFindDlg.OkContextBtnClick(Sender: TObject);
begin
  FindLink.IsLikeFind:=True;
  SelectFirst;
end;

procedure TLnFindDlg.CloseCheckClick(Sender: TObject);
begin
  FindLink.IsFirstFind:=False;
  SelectFirst;
end;

procedure TLnFindDlg.CancelBtnClick(Sender: TObject);
var i: Integer;
begin
  if FindLink.IsFirstFind then begin
    FIsNavCancel:=True;
    IndexCombo.Enabled:=True;
    for i:=0 to Edits.Count-1 do TWinControl(Edits[i]).Enabled:=True;
    NavPanel.Visible:=False;
    FindLink.CancelFind;
  end;
  SelectFirst;
end;

Procedure TLnFindDlg.Nav1Click(Sender: TObject; Button: TNavigateBtn);
begin
  GoFind;
end;

Procedure TLnFindDlg.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((ActiveControl is TDBLookUpComboBox) and
  (TDBLookUpComboBox(ActiveControl).ListVisible)) then Exit;

  if (Key=VK_Return) and (Shift=[]) and
  (EditPanel.ControlCount>0) and
  (ActiveControl=EditPanel.Controls[EditPanel.ControlCount-1])
  then begin
    OkBtn.Click;
    ModalResult:=mrOk;
    Key:=0;
  end else
    if ssCtrl in Shift then begin
      case Key of
        Word('F'): OkContextBtn.Click;
        Word('C'): CancelBtn.Click;
        Word('B'): begin
                     IndexCheck.Checked:=not IndexCheck.Checked;
                     IndexCheckClick(Sender);
                   end;
        Word('P'): begin
                     CloseCheck.Checked:=not CloseCheck.Checked;
                     CloseCheckClick(Sender);
                   end;
        Word('K'): if IndexCombo.Focused and (not IndexCombo.DroppedDown) then SelectFirst
                   else begin
                     IndexCombo.SetFocus;
                     IndexCombo.DroppedDown:=True;
                   end;
      end;
     if Key in [Word('F'),Word('S'),Word('C'),Word('B'),Word('P'),Word('K')] then Key:=0;
    end;
  Inherited;
end;

procedure TLnFindDlg.IndexComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_RETURN then IndexComboChange(Sender);
end;

end.
