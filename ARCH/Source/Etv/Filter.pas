unit Filter;

interface

uses
  Windows, Messages, Classes, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, DB,
  EtvMem,EtvFilt;

{$I Etv.Inc}

type

TViewItem=class
  Number:TLabel;
  DataSetName:TComboBox;
  fieldName:TComboBox;
  Operation:TComboBox;
  Value:TControl;
  LookSource:TDataSource;
end;

  TFormFilter = class(TForm)
    BitBtnSet: TBitBtn;
    BitBtnNone: TBitBtn;
    BitBtnCancel: TBitBtn;
    Scroll: TScrollBox;
    PanelHeader: TPanel;
    SBAddCond: TSpeedButton;
    SBDeleteCond: TSpeedButton;
    CheckBoxAutoTotal: TCheckBox;
    SBPred: TSpeedButton;
    SBNext: TSpeedButton;
    SBAdd: TSpeedButton;
    SBDelete: TSpeedButton;
    EditFilterName: TEdit;
    LNumberFilter: TLabel;
    SBRestore: TSpeedButton;
    LabelTotalHint: TLabel;
    LabelSubTotalHint: TLabel;
    PanelFooter: TPanel;
    procedure CheckBoxAutoTotalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SBAddCondClick(Sender: TObject);
    procedure SBAddCondFClick(Sender: TObject);
    procedure SBDeleteCondClick(Sender: TObject);
    procedure SBPredClick(Sender: TObject);
    procedure SBNextClick(Sender: TObject);
    procedure SBAddClick(Sender: TObject);
    procedure SBDeleteClick(Sender: TObject);
    procedure ChangeFilter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SBRestoreClick(Sender: TObject);
    procedure SBZoomClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  protected
    fTop,fHeight:integer;
    fChangeProcessing:boolean;
    fFilters:TEtvFilter;
    ListConditions:TListObj;
    ListTotals:TList;
    ListLabelTotals:TList;
    ListAllOrAny:TList;
    function CalcTop(Index:Smallint):integer;
    function CalcLeft(Index:Smallint):integer;
    procedure SetFilters(aFilters:TEtvFilter);
    procedure CheckFilters;
    procedure AddFilter;
    procedure DeleteFilter;
    procedure PredFilter;
    procedure NextFilter;
    procedure CheckConditions(AReset:boolean);
    procedure SetCondition(Index:smallint);
    procedure ResetConditions;
    procedure ClearCondition(Index:smallint);
    procedure ClearConditions(IndexBegin:smallint);
    procedure AddCondition(Index:smallint);
    procedure DeleteCondition(aIndex:smallint);
    procedure VisualizeFilter;
    procedure CreateNumber(index:smallint);
    procedure CreateDataSetName(index:smallint);
    procedure ComboBoxDChange(Sender: TObject);
    function CreateFieldName(index:smallint):TComboBox;
    procedure FillFieldName(index:smallint);
    procedure ComboBoxFNChange(Sender: TObject);
    procedure ComboBoxFNEnd(Sender: TObject);
    procedure CreateOperation(index:smallint);
    procedure FillOperation(index:smallint);
    procedure ComboBoxOChange(Sender: TObject);
    procedure ComboBoxOKeyPress(Sender: TObject; var Key: Char);
    procedure CreateValue(Index:smallint; aField:TField; aInsert:boolean);
    procedure CheckValue(Index:smallint; aInsert:boolean);
    procedure InsertValue(Index:smallint);
    function FieldByIndex(Index:smallint):TField;
    function TrueFilterField(aField:TField):boolean;
    procedure EnableLabels(aEnabled:boolean);
  public
    WidthDataSetName,
    WidthFieldName:integer;
    property EFilters:TEtvFilter read FFilters write SetFilters;
  published
    procedure EditValueChange(Sender: TObject);
  end;

{var
  FormFilter: TFormFilter;
}
implementation
uses TypInfo, Dialogs, SysUtils, Graphics,
     EtvConst,EtvPas,EtvDB,EtvContr;

{$R *.DFM}

const SizeAllOrAny=90;

function TFormFilter.CalcTop(Index:Smallint):integer;
begin
  if Index=0 then Result:=fTop
  else Result:=TViewItem(ListConditions.items[0]).FieldName.Top+fHeight*Index;
end;

function TFormFilter.CalcLeft(Index:Smallint):integer;
begin
  if Index=0 then Result:=2
  else Result:=TViewItem(ListConditions.items[0]).Number.Left;
end;

procedure TFormFilter.SetFilters(aFilters:TEtvFilter);
begin
  fFilters:=aFilters;
  VisualizeFilter;
  CheckFilters;
end;

procedure TFormFilter.CreateNumber(index:smallint);
begin
  with TViewItem(ListConditions.items[Index]) do begin
    Number:=TLabel.Create(nil);
    Number.Caption:=IntToStr(Index+1);
    Number.Top:=CalcTop(Index)+5;
    Number.Left:=CalcLeft(Index);
    Scroll.InsertControl(Number);
  end;
end;

procedure TFormFilter.CreateDataSetName(index:smallint);
var i:integer;
begin
  with TViewItem(ListConditions.items[Index]) do begin
    DataSetName:=TComboBox.Create(nil);
    with DataSetName do begin
      Style:={csDropDownList;}csOwnerDrawFixed;
      Top:=Number.Top-5;
      Left:=Number.Left+15;
      Width:=WidthDataSetName;
      Color:=clSilver;
      Tag:=Index;
      OnKeyDown:=EtvApp.EditKeyDown;
      OnChange:=ComboBoxDChange;
      Scroll.InsertControl(DataSetName);
      Items.Add(EFilters.GetTableCaption);
      ItemIndex:=0;
      for i:=0 to EFilters.SubDataSets.Count-1 do
        Items.Add(EFilters.SubDataSets.Caption[i]);
    end;
  end;
end;

function TFormFilter.CreateFieldName(index:smallint):TComboBox;
begin
  with TViewItem(ListConditions.items[Index]) do begin
    FieldName:=TComboBox.Create(nil);
    with FieldName do begin
      Style:={csDropDownList;}csOwnerDrawFixed;
      Top:=Number.top-5;
      Left:=Number.Left+15;
      if EFilters.Enhanced then Left:=Left+WidthDataSetName;
      Width:=WidthFieldName;
       Tag:=Index;
      OnKeyDown:=EtvApp.EditKeyDown;
      OnChange:=ComboBoxFNChange;
      OnExit:=ComboBoxFNEnd;
      Scroll.InsertControl(FieldName);
      FillFieldName(Index);
    end;
    Result:=FieldName;
  end;
end;

procedure TFormFilter.FillFieldName(index:smallint);
var i:smallint;
    lDataSet:TDataSet;
begin
  with TViewItem(ListConditions.items[Index]) do begin
    lDataSet:=EFilters.ChooseCondDataSet(Index);
    FieldName.Items.Clear;
    if Assigned(lDataSet) then with FieldName do begin
      for i:=0 to lDataSet.FieldCount-1 do
       if TrueFilterField(lDataSet.Fields[i]) then
         Items.Add(lDataSet.Fields[i].DisplayName);
    end;
  end;
end;

procedure TFormFilter.CreateOperation(index:smallint);
begin
  with TViewItem(ListConditions.items[Index]) do begin
    Operation:=TComboBox.Create(nil);
    with Operation do begin
      Top:=FieldName.Top;
      Left:=FieldName.Left+FieldName.Width;
      Width:=38;
      Color:=clSilver;
      Font.Color:=clRed;
      Font.Style:=[fsBold];
      Tag:=Index;
      OnKeyDown:=EtvApp.EditKeyDown;
      OnChange:=ComboBoxOChange;
      OnKeyPress:=ComboBoxOKeyPress;
      Scroll.InsertControl(Operation);
    end;
  end;
end;

procedure TFormFilter.FillOperation(index:smallint);
var Field:TField;
    PropInfo: PPropInfo;
    lOptions:boolean;
begin
  with TViewItem(ListConditions.items[Index]).Operation do begin
    Items.Clear;
    Field:=FieldByIndex(Index);
    Items.Add('=');
    Items.Add('<>');
    lOptions:=false;
    if Assigned(Field) then begin
      PropInfo:=GetPropInfo(Field.ClassInfo,'OnlyEqualInFilter');
      if (PropInfo<>nil) then try (* For EtvLookField *)
        lOptions:=Boolean(GetOrdProp(Field, PropInfo));
      except
        lOptions:=false;
      end;
    end;
    if Not lOptions then begin
      Items.Add('<');
      Items.Add('>');
      Items.Add('<=');
      Items.Add('>=');
    end;
    if (EFilters.FilterSetAs<>fsFilter) and
       ((Field is TStringField) or (Field is TMemoField)) and
       (Field.FieldKind=fkData) then
      Items.Add(S_Like);
    Text:=TConditionItem(TFilterItem(EFilters.
      Filters[EFilters.CurFilter]).Conditions[Index]).Operation;
  end;
end;

type TWinControlSelf=class(TWinControl)
     end;

procedure TFormFilter.CreateValue(Index:smallint; aField:TField; aInsert:boolean);
begin
  with TViewItem(ListConditions.items[Index]) do begin
    if aField.FieldKind=fkLookup then begin
      LookSource:=TDataSource.Create(nil);
      LookSource.DataSet:=aField.LookupDataSet;
    end;
    Value:=EditForField(nil,aField, 0, LookSource);
    With Value do begin
      Top:=Operation.Top;
      Left:=Operation.Left+Operation.Width;
      Tag:=Index;
      if Left+Width+14>Self.Width then begin
        Width:=Self.Width-Left-14;
        if Width<10 then Width:=10;
        {$IFDEF Delphi4}
        Anchors:=Anchors+[akRight];
        {$ENDIF}
      end
    end;

    if Value is TWinControl then
      TWinControlSelf(Value).OnExit:=EditValueChange;

    if Assigned(EFilters.OnCreateValue) then
      EFilters.OnCreateValue(aField,Value);
    if aInsert then InsertValue(Index)
  end;
end;

procedure TFormFilter.InsertValue(Index:smallint);
var lControl:TControl;
    lValue:variant;
begin
  lControl:=TViewItem(ListConditions[index]).Value;
  lValue:=TConditionItem(TFilterItem(EFilters.
        Filters[EFilters.CurFilter]).Conditions[Index]).Value;

  Scroll.InsertControl(lControl);
  TWinControl(lControl).TabOrder:=
    TViewItem(ListConditions.items[Index]).Operation.TabOrder+1;

  ValueToEditForField(lControl,FieldByIndex(Index),lValue);
end;

function TFormFilter.FieldByIndex(Index:smallint):TField;
begin
  Result:=nil;
  with TConditionItem(TFilterItem(EFilters.
         Filters[EFilters.CurFilter]).Conditions[Index]) do begin
    if LookFieldName<>'' then
    Result:=EFilters.ChooseCondDataSet(Index).FindField(LookFieldName);
    if Not Assigned(Result) then
    Result:=EFilters.ChooseCondDataSet(Index).FindField(FieldName);
  end;
end;

procedure TFormFilter.CheckValue(Index:smallint; aInsert:boolean);
var Field:TField;
begin
  if Assigned(TViewITem(ListConditions[index]).Value) then begin
    TViewItem(ListConditions[index]).Value.Free;
    TViewItem(ListConditions[index]).Value:=nil;
  end;
  if Assigned(TViewITem(ListConditions[index]).LookSource) then begin
    TViewItem(ListConditions[index]).LookSource.Free;
    TViewITem(ListConditions[index]).LookSource:=nil;
  end;
  with TConditionItem(TFilterItem(EFilters.
         Filters[EFilters.CurFilter]).Conditions[Index]) do begin
    Field:=FieldByIndex(Index);
    if Assigned(Field) then begin
     CreateValue(Index,Field,aInsert);
    end;
  end;
  FillOperation(index);
end;

procedure TFormFilter.EditValueChange(Sender: TObject);
begin
  with TConditionItem(TFilterItem(EFilters.Filters[EFilters.CurFilter]).
       Conditions[TControl(Sender).Tag]) do
    Value:=ValueFromEditForField(TControl(Sender),
      EFilters.ChooseCondDataSet(TControl(Sender).Tag).FindField(FieldName),
      true,true);
end;

(*
procedure TFormFilter.EditValueChange(Sender: TObject);
Var Field:TField;
    PropInfo: PPropInfo;
    Exist:boolean;
    lText:string;
begin
  with TConditionItem(TFilterItem(EFilters.Filters[EFilters.CurFilter]).
       Conditions[TControl(Sender).Tag]) do begin
    if Sender is TDBLookupComboBox then
      Value:=TDBLookupComboBox(Sender).KeyValue
    else begin
      Field:=EFilters.ChooseCondDataSet(TControl(Sender).Tag).FindField(FieldName);
      if Sender is TComboBox then
        if TComboBox(Sender).ItemIndex>=0 then begin
          Value:=TComboBox(Sender).ItemIndex;
          if (Field is TEtvListField) and
             (TEtvListField(Field).Values[Value]='') then
            Value:=null;
        end else Value:=Null
      else begin
        Exist:=false;
        if Field is TDateField then begin
          PropInfo := GetPropInfo(Sender.ClassInfo, 'Date');
          if PropInfo <> nil then begin
            Value:=GetFloatProp(Sender,PropInfo);
            Exist:=true;
          end;
        end;
        if Not Exist then begin
          lText:=ObjectStrProp(Sender,'Text');
          if lText<>'' then begin
            Try
              if Field is TDateField then
{Lev}
                Value:=StrToDate_(lText)
{Lev}
              else if Field is TFloatField then
                Value:=StrToFloat(lText)
              else if Field is TIntegerField then
                Value:=StrToInt(lText)
              else Value:=lText;
            except
              PropInfo := GetPropInfo(Sender.ClassInfo, 'Text');
              if PropInfo <> nil then
                SetStrProp(Sender,PropInfo,'');
            end;
          end else Value:=Null;
        end;
      end;
    end;
  end;
end;
*)

function TFormFilter.TrueFilterField(aField:TField):boolean;
begin
  if (aField.Tag mod 10<>8) and (aField.FieldKind<>fkCalculated) then Result:=true
  else Result:=false;
end;

procedure TFormFilter.EnableLabels(aEnabled:boolean);
begin
  if aEnabled then begin
    LabelTotalHint.font.color:=clBlack;
    LabelSubTotalHint.font.color:=clBlack;
  end else begin
    LabelTotalHint.font.color:=clGray;
    LabelSubTotalHint.font.color:=clGray;
  end;
end;

procedure TFormFilter.CheckFilters;
var i:integer;
begin
  fChangeProcessing:=true;
  if EFilters.OneFilter then SBAdd.Enabled:=false
  else SBAdd.Enabled:=true;
  if EFilters.Filters.Count>0 then begin
    CheckBoxAutoTotal.Enabled:=true;
    if not EFilters.OneFilter then SBDelete.Enabled:=true
    else SBDelete.Enabled:=false;
    if EFilters.CurFilter>0 then SBPred.Enabled:=true
    else SBPred.Enabled:=false;
    if EFilters.CurFilter<EFilters.Filters.Count-1 then SBNext.Enabled:=true
    else SBNext.Enabled:=false;
    with TFilterItem(EFilters.Filters[EFilters.CurFilter]) do begin
      EditFilterName.Enabled:=true;
      EditFilterName.Text:=Name;
      CheckBoxAutoTotal.Checked:=AutoTotal;

      TEdit(ListTotals[0]).Text:=DataSetItemByName('').Total;
      for i:=1 to ListTotals.Count-1 do
        TEdit(ListTotals[i]).Text:=
          DataSetItemByName(EFilters.SubDataSets.TableName[i-1]).Total;
      for i:=0 to ListTotals.Count-1 do
        TEdit(ListTotals[i]).Enabled:=not AutoTotal;

      for i:=0 to ListLabelTotals.Count-1 do
        TLabel(ListLabelTotals[i]).Enabled:=not AutoTotal;
      for i:=0 to ListAllOrAny.Count-1 do begin
        TCheckBox(ListAllOrAny[i]).Checked:=
          DataSetItemByName(EFilters.SubDataSets.TableName[i]).All;
        TCheckBox(ListAllOrAny[i]).Enabled:=not AutoTotal;
      end;
      EnableLabels(not AutoTotal);
      if not EFilters.OneFilter then
        LNumberFilter.Caption:=IntToStr(EFilters.CurFilter+1)+'/'+
                               IntToStr(EFilters.Filters.Count)
      else LNumberFilter.Caption:='';
    end;
  end else begin
    SBPred.Enabled:=false;
    SBNext.Enabled:=false;
    SBDelete.Enabled:=false;

    EditFilterName.Text:='';
    EditFilterName.Enabled:=false;
    CheckBoxAutoTotal.Enabled:=false;

    for i:=0 to ListTotals.Count-1 do begin
      TEdit(ListTotals[i]).Text:='';
      TEdit(ListTotals[i]).Enabled:=false;
    end;
    for i:=0 to ListLabelTotals.Count-1 do
      TLabel(ListLabelTotals[i]).Enabled:=false;
    for i:=0 to ListAllOrAny.Count-1 do begin
      TCheckBox(ListAllOrAny[i]).Checked:=false;
      TCheckBox(ListAllOrAny[i]).Enabled:=false;
    end;
    EnableLabels(false);

    LNumberFilter.Caption:='';
  end;
  {LockWindowUpdate(Scroll.Handle);}
  CheckConditions(true);
  if ListConditions.Count>0 then
    ActiveControl:=TViewItem(ListConditions[0]).FieldName;
  {LockWindowUpdate(0);}
  if Assigned(EFilters.OnSetToEditWindow) then
    EFilters.OnSetToEditWindow(Self);
  fChangeProcessing:=false;
end;

procedure TFormFilter.CheckConditions(AReset:boolean);
begin
  if EFilters.CurFilter>=0 then begin
    with TFilterItem(EFilters.Filters[EFilters.CurFilter]) do begin
      SBAddCond.Enabled:=true;
      {SBAddCondF.Enabled:=true;}
      if Conditions.Count>0 then SBDeleteCond.Enabled:=true
      else SBDeleteCond.Enabled:=false;
    end;
    if AReset then ResetConditions;
  end else begin
    SBAddCond.Enabled:=false;
    {SBAddCondF.Enabled:=false;}
    SBDeleteCond.Enabled:=false;
    ClearConditions(0);
  end;
end;

procedure TFormFilter.ResetConditions;
var i:smallint;
begin
  if EFilters.CurFilter>=0 then begin
    with TFilterItem(EFilters.Filters[EFilters.CurFilter]) do begin
      for i:=0 to Conditions.Count-1 do begin
        if ListConditions.Count-1<i then AddCondition(i);
        SetCondition(i);
        CheckValue(i,true);
      end;
      ClearConditions(Conditions.Count);
    end;
  end;
end;

procedure TFormFilter.SetCondition(Index:smallint);
var i,j,ind:smallint;
    lDataSet:TDataSet;

begin
  with TConditionItem(TFilterItem(EFilters.
         Filters[EFilters.CurFilter]).Conditions[Index]) do begin
    lDataSet:=EFilters.ChooseCondDataSet(Index);
    if Not Assigned(lDataSet) then begin
      EtvApp.ShowMessage('Component '+EFilters.Name+
                          #10+'Detail table '+TableName+' is absent in SubDataSets');
      TableName:='';
      FieldName:='';
      Operation:='=';
      Value:=null;
      lDataSet:=EFilters.ChooseCondDataSet(Index);
      fillFieldName(Index);
    end;
    if EFilters.Enhanced then begin
      TViewItem(ListConditions[Index]).DataSetName.ItemIndex:=
        EFilters.IndexCondDataSet(Index);
      FillFieldName(index);
    end;
    i:=-1;
    ind:=-1;
    for j:=0 to lDataSet.FieldCount-1 do
      if TrueFilterField(lDataSet.Fields[j]) then begin
        inc(i);
        if lDataSet.Fields[j].FieldName=FieldName then begin
          ind:=i;
          if LookFieldName='' then Break;
        end;
        if lDataSet.Fields[j].FieldName=LookFieldName then begin
          ind:=i;
          Break;
        end;
      end;
    TViewItem(ListConditions[Index]).FieldName.ItemIndex:=ind;
    TViewItem(ListConditions[Index]).Operation.Text:=Operation;
  end;
end;

procedure TFormFilter.ClearCondition(Index:smallint);
begin
  with TViewItem(ListConditions[Index]) do begin
    if EFilters.Enhanced then DataSetName.Free;
    Number.Free;
    FieldName.Free;
    Operation.Free;
    if Assigned(Value) then Value.Free;
    if Assigned(LookSource) then LookSource.Free;
  end;
  ListConditions.DeleteFull(Index);
end;

procedure TFormFilter.ClearConditions(IndexBegin:smallint);
begin
  while ListConditions.Count>IndexBegin do
    ClearCondition(ListConditions.Count-1);
end;

procedure TFormFilter.AddCondition(Index:smallint);
begin
  if Index>TFilterItem(EFilters.Filters[EFilters.
     CurFilter]).Conditions.Count-1 then EFilters.AddCondition;
  ListConditions.Add(TViewItem.Create);
  CreateNumber(Index);
  if EFilters.Enhanced then CreateDataSetName(Index);
  ActiveControl:=CreateFieldName(Index);
  CreateOperation(Index);
  CheckConditions(false);
end;

procedure TFormFilter.DeleteCondition(aIndex:Smallint);
var i:smallint;
begin
  EFilters.DeleteCondition(aIndex);
  ClearCondition(aIndex);
  i:=aIndex;
  if i>ListConditions.Count-1 then Dec(i);
  if i>=0 then ActiveControl:=TViewItem(ListConditions[i]).FieldName;
  for i:=aIndex to ListConditions.Count-1 do
    with TViewItem(ListConditions[i]) do begin
      Number.Top:=Number.Top-fHeight;
      Number.Caption:=IntToStr(I+1);
      Number.Tag:=i;
      if EFilters.Enhanced then begin
        DataSetName.Top:=DataSetName.Top-fHeight;
        DataSetName.Tag:=i;
      end;
      FieldName.Top:=FieldName.Top-fHeight;
      FieldName.Tag:=i;
      Operation.Top:=Operation.Top-fHeight;
      Operation.Tag:=i;
      if Assigned(Value) then begin
        Value.Top:=Value.Top-fHeight;
        Value.Tag:=i;
      end;
    end;
  CheckConditions(False);
end;

procedure TFormFilter.VisualizeFilter;
var i:integer;
    EditTotal:TEdit;
    lTop,lLeft:integer;
    LabelTotal:TLabel;
    AllOrAny:TCheckBox;
begin
  for i:=0 to ListTotals.Count-1 do TObject(ListTotals[i]).free;
  ListTotals.Clear;
  for i:=0 to ListLabelTotals.Count-1 do TObject(ListLabelTotals[i]).free;
  ListLabelTotals.Clear;
  for i:=0 to ListAllOrAny.Count-1 do TObject(ListAllOrAny[i]).free;
  ListAllOrAny.Clear;
  if Assigned(EFilters) and Assigned(EFilters.DataSet) then begin
    lTop:=323-(EFilters.SubDataSets.Count+1)*21;
    Scroll.Height:=lTop-Scroll.Top-2;
    for i:=0 to EFilters.SubDataSets.Count do begin
      EditTotal:=TEdit.Create(Self);
      ListTotals.Add(EditTotal);
      EditTotal.Top:=lTop;
      {$IFDEF Delphi4}
      EditTotal.Anchors:=[akLeft,akRight,akBottom];
      {$ENDIF}
      lLeft:=0;
      if EFilters.Enhanced then begin
        LabelTotal:=TLabel.Create(Self);
        ListLabelTotals.Add(LabelTotal);
        LabelTotal.AutoSize:=false;
        LabelTotal.Top:=lTop;
        LabelTotal.Left:=3;
        LabelTotal.Width:=WidthDataSetName;
        {$IFDEF Delphi4}
        LabelTotal.Anchors:=[akLeft,akBottom];
        {$ENDIF}
        if i=0 then
          LabelTotal.Caption:=EFilters.GetTableCaption
        else
          LabelTotal.Caption:=EFilters.SubDataSets.Caption[i-1];
        LabelTotal.Parent:=Self;
        {Self.InsertControl(LabelTotal);}
        lLeft:=lLeft+WidthDataSetName+3;
        if i>0 then begin
          AllOrAny:=TCheckBox.Create(Self);
          ListAllOrAny.Add(AllOrAny);
          AllOrAny.Caption:=SFilterDlgAllOrAnyCaption;
          AllOrAny.Hint:=SFilterDlgAllOrAnyHint;
          AllOrAny.Top:=lTop+2;
          AllOrAny.Left:=lLeft;
          AllOrAny.Width:=SizeAllOrAny;
          AllOrAny.OnClick:=ChangeFilter;
          AllOrAny.OnKeyDown:=EtvApp.EditKeyDown;
          {$IFDEF Delphi4}
          AllOrAny.Anchors:=[akLeft,akBottom];
          {$ENDIF}
          Self.InsertControl(AllOrAny);
          AllOrAny.TabOrder:=BitBtnSet.TabOrder;
          lLeft:=lLeft+SizeAllOrAny;
        end;
      end;
      EditTotal.Left:=lLeft;
      EditTotal.Width:=Self.Width-8-EditTotal.Left;
      {EditTotal.Hint:=SFilterDlgTotalHint;}
      EditTotal.OnExit:=ChangeFilter;
      EditTotal.OnKeyDown:=EtvApp.EditKeyDown;
      Self.InsertControl(EditTotal);
      EditTotal.TabOrder:=BitBtnSet.TabOrder;
      lTop:=lTop+21;
    end;
  end;

  if Assigned(EFilters) and (EFilters.SubDataSets.Count>0) then
    LabelSubTotalHint.Caption:=SFilterDlgSubTotalHint
  else LabelSubTotalHint.Caption:='';

  if Assigned(EFilters.OnVisualizeFilters) then
    EFilters.OnVisualizeFilters(self);
end;

procedure TFormFilter.AddFilter;
begin
  ActiveControl:=nil;
  EFilters.AddFilter;
  CheckFilters;
end;
procedure TFormFilter.DeleteFilter;
begin
  EFilters.DeleteFilter;
  CheckFilters;
end;
procedure TFormFilter.PredFilter;
begin
  ActiveControl:=nil;
  EFilters.PredFilter;
  CheckFilters;
end;
procedure TFormFilter.NextFilter;
begin
  ActiveControl:=nil;
  EFilters.NextFilter;
  CheckFilters;
end;
procedure TFormFilter.ComboBoxDChange(Sender: TObject);
begin
  with TConditionItem(TFilterItem(EFilters.Filters[EFilters.CurFilter]).
                      Conditions[TControl(Sender).Tag]) do begin
    if TComboBox(Sender).ItemIndex<1 then TableName:=''
    else
      TableName:=EFilters.SubDataSets.TableName[TComboBox(Sender).ItemIndex-1];
    FieldName:='';
    FillFieldName(TControl(Sender).Tag);
    Operation:='=';
    FillOperation(TControl(Sender).Tag);
    Value:=null;
    if Assigned(TViewITem(ListConditions[TControl(Sender).Tag]).Value) then begin
      TViewItem(ListConditions[TControl(Sender).Tag]).Value.Free;
      TViewItem(ListConditions[TControl(Sender).Tag]).Value:=nil;
    end;
  end;
end;

procedure TFormFilter.ComboBoxFNChange(Sender: TObject);
var i:smallint;
    lDataSet:TDataSet;
begin
  lDataSet:=EFilters.ChooseCondDataSet(TControl(Sender).Tag);
  for i:=0 to lDataSet.FieldCount-1 do
    if (TComboBox(Sender).Text=lDataSet.Fields[i].DisplayLabel) and
       TrueFilterField(lDataSet.Fields[i]) then
      with TConditionItem(TFilterItem(EFilters.Filters[EFilters.
             CurFilter]).Conditions[TControl(Sender).Tag]) do begin
        if lDataSet.Fields[i].FieldKind=fkLookup then begin
          FieldName:=lDataSet.Fields[i].KeyFields;
          LookFieldName:=lDataSet.Fields[i].FieldName;
        end else begin
          FieldName:=lDataSet.Fields[i].FieldName;
          LookFieldName:='';
        end;
        Operation:='=';
        FillOperation(TControl(Sender).Tag);
        Value:=null;
        if TComboBox(Sender).DroppedDown then CheckValue(TControl(Sender).Tag,false)
        else CheckValue(TControl(Sender).Tag,true);
        Exit;
      end;
  SetCondition(TControl(Sender).Tag);
end;

procedure TFormFilter.ComboBoxFNEnd(Sender: TObject);
var index:integer;
begin
  Index:=TControl(Sender).Tag;
  with TViewItem(ListConditions[Index]) do
    if Assigned(Value) and (Not Assigned(Value.Parent)) then
      InsertValue(Index);
end;

procedure TFormFilter.ComboBoxOChange(Sender: TObject);
begin
  if TComboBox(Sender).Items.IndexOf(TComboBox(Sender).Text)>=0 then
    with TFilterItem(EFilters.Filters[EFilters.CurFilter]) do begin
      TConditionItem(Conditions[TControl(Sender).Tag]).Operation:=
        TComboBox(Sender).Text;
    end
  else TComboBox(Sender).Text:='';
end;

{++++++++++++++}

procedure TFormFilter.CheckBoxAutoTotalClick(Sender: TObject);
var u:boolean;
    i:integer;
begin
  u:=CheckBoxAutoTotal.Checked or (Not CheckBoxAutoTotal.Enabled);
  for i:=0 to ListTotals.Count-1 do
    TEdit(ListTotals[i]).Enabled:=not u;
  for i:=0 to ListLabelTotals.Count-1 do
    TLabel(ListLabelTotals[i]).Enabled:=not u;
  for i:=0 to ListAllOrAny.Count-1 do
    TCheckBox(ListAllOrAny[i]).Enabled:=not u;
  EnableLabels(not u);
  ChangeFilter(nil);
end;

procedure TFormFilter.FormCreate(Sender: TObject);
begin
  Caption:=SFilterDlgCaption;
  SBPred.Hint:=SFilterDlgBtnPredHint;
  SBNext.Hint:=SFilterDlgBtnNextHint;
  SBAdd.Hint:=SFilterDlgBtnAddHint;
  SBDelete.Hint:=SFilterDlgBtnDeleteHint;
  SBRestore.Hint:=SFilterDlgBtnRestoreHint;
  EditFilterName.Hint:=SFilterDlgFilterNameHint;
  SBAddCond.Caption:=SFilterDlgBtnAddCondCaption;
  SBAddCond.Hint:=SFilterDlgBtnAddCondHint;
  SBDeleteCond.Caption:=SFilterDlgBtnDeleteCondCaption;
  SBDeleteCond.Hint:=SFilterDlgBtnDeleteCondHint;
  CheckBoxAutoTotal.Caption:=SFilterDlgAutoTotalCaption;
  BitBtnSet.Caption:=SFilterDlgBtnSetCaption;
  BitBtnSet.Hint:=SFilterDlgBtnSetHint;
  BitBtnNone.Caption:=SFilterDlgBtnNoneCaption;
  BitBtnNone.Hint:=SFilterDlgBtnNoneHint;
  BitBtnCancel.Caption:=SCancelCaption;
  BitBtnCancel.Hint:=SFilterDlgBtnCancelHint;
  LabelTotalHint.Caption:=SFilterDlgTotalHint;
  {$IFDEF Delphi4}
  EditFilterName.Anchors:=[akLeft,akTop,akRight];
  LNumberFilter.Anchors:=[akTop,akRight];
  Scroll.Anchors:=[akLeft,akTop,akBottom];
  BitBtnSet.Anchors:=[akLeft,akBottom];
  BitBtnNone.Anchors:=[akLeft,akBottom];
  BitBtnCancel.Anchors:=[akLeft,akBottom];
  LabelTotalHint.Anchors:=[akLeft,akRight,akBottom];
  LabelSubTotalHint.Anchors:=[akLeft,akRight,akBottom];
  {$ENDIF}
  ListConditions:=TListObj.Create;
  fChangeProcessing:=false;
  fTop:=3;
  fHeight:=23;
  WidthDataSetName:=175;
  WidthFieldName:=150;
  ListTotals:=TList.Create;
  ListLabelTotals:=TList.Create;
  ListAllOrAny:=TList.Create;
  EditFilterName.OnKeyDown:=EtvApp.EditKeyDown;
  {Left:=0; Top:=0;}
  if Screen.Width>800 then begin
   Self.ScaleBy(115,100);
   Height:=Round(Height*1.15);
   Width:=Round(Width*1.15);
  end;
end;

procedure TFormFilter.FormDestroy(Sender: TObject);
begin
  if Assigned(ListConditions) then begin
    ClearConditions(0);
    ListConditions.free;
  end;
  if Assigned(ListTotals) then ListTotals.Free;
  if Assigned(ListLabelTotals) then ListLabelTotals.Free;
  if Assigned(ListAllOrAny) then ListAllOrAny.Free;
end;

procedure TFormFilter.SBAddCondClick(Sender: TObject);
begin
  AddCondition(TFilterItem(EFilters.Filters[EFilters.CurFilter]).
    Conditions.Count);
end;

procedure TFormFilter.SBAddCondFClick(Sender: TObject);
begin
  {AddCondition(True);}
end;

procedure TFormFilter.SBDeleteCondClick(Sender: TObject);
var Index:integer;
    Exist:boolean;
begin
  if Assigned(ActiveControl) then begin
    Index:=ActiveControl.Tag;
    if ListConditions.Count-1>=Index then begin
      Exist:=false;
      with TViewItem(ListConditions.items[Index]) do begin
        if EFilters.Enhanced and (DataSetName=ActiveControl) then Exist:=true;
        if FieldName=ActiveControl then Exist:=true;
        if Operation=ActiveControl then Exist:=true;
        if Value=ActiveControl then Exist:=true;
        if Exist then begin
          ActiveControl:=nil;
          DeleteCondition(Index);
        end;
      end;
    end;
  end;
end;

procedure TFormFilter.SBPredClick(Sender: TObject);
begin
  PredFilter;
end;

procedure TFormFilter.SBNextClick(Sender: TObject);
begin
  NextFilter;
end;

procedure TFormFilter.SBAddClick(Sender: TObject);
begin
  AddFilter;
end;

procedure TFormFilter.SBDeleteClick(Sender: TObject);
begin
  if MessageDlg(SFilterDlgBtnDeleteHint,
       mtConfirmation, [mbYes, mbNo],0) = idYes then
    DeleteFilter;
end;

procedure TFormFilter.ChangeFilter(Sender: TObject);
var sAllOrAny:string;
    i:integer;
    lTotals:TStringList;
begin
  if not fChangeProcessing then begin
    lTotals:=TStringList.Create;
    for i:=0 to ListTotals.Count-1 do
      lTotals.Add(TEdit(ListTotals[i]).text);
    sAllOrAny:='';
    for i:=0 to ListAllOrAny.Count-1 do
      if TCheckBox(ListAllOrAny[i]).Checked then sAllOrAny:=sAllOrAny+'0'
      else sAllOrAny:=sAllOrAny+'1';
    EFilters.FilterParams(EditFilterName.Text,
      CheckBoxAutoTotal.Checked,lTotals,sAllOrAny);
    lTotals.Free;
    if Assigned(EFilters.OnGetFromEditWindow) then
      EFilters.OnGetFromEditWindow(Self);
  end;
end;

procedure TFormFilter.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift=[ssCtrl] then
    case Key of
      VK_Add:
        begin
          SBAddCond.Click;
          key:=0;
        end;
      VK_SUBTRACT:
        begin
          SBDeleteCond.Click;
          Key:=0;
        end;
    end;
{Lev - 09.12.2000}
  if Shift=[] then
    case Key of
      VK_F2:
        begin
          BitBtnSet.Click;
          Key:=0;
        end;
    end;
{Lev - 09.12.2000}
end;

procedure TFormFilter.ComboBoxOKeyPress(Sender: TObject; var Key: Char);
begin
  if Not (Key in [#27,#13]) then key:=#0;
end;

procedure TFormFilter.SBRestoreClick(Sender: TObject);
begin
  EFilters.LoadFromBase;
  CheckFilters;
end;

procedure TFormFilter.SBZoomClick(Sender: TObject);
begin
(*
  ScaleBy(StrToInt(EditZoom.Text)+100,100);
*)
end;

procedure TFormFilter.FormResize(Sender: TObject);
begin
  { Выравниваем Scroll под ширину окна }
  Scroll.Width:=Self.Width-5;
end;

end.
