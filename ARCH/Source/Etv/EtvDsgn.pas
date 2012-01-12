unit EtvDsgn;

interface
uses DsgnIntf,classes,db;

{$I Etv.Inc}

type
  TEtvDBCustomControlEditor = class(TComponentEditor)
    procedure ToDataSet(DataS:TComponent);
    procedure ToField(DataSource:TDataSource; DataField:string);
  end;

  TEtvDBControlEditor = class(TEtvDBCustomControlEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

  TEtvDBFieldControlEditor = class(TEtvDBCustomControlEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

procedure SetDesignerToComponent(Comp:TComponent);

type
TDataSetListProperty=class(TClassProperty)
  fSource,fTarget:TStrings;
public
  procedure AddToStrings(const S: string);
  procedure Edit; override;
  function GetAttributes: TPropertyAttributes; override;
end;

IMPLEMENTATION

Uses TypInfo,exptIntf,EditIntf,LibIntf,DsDesign,
     sysutils,Clipbrd,Dialogs,graphics,Windows,
     EtvPas,EtvDBFun,EtvDB,DiDual;

procedure SetDesignerToComponent(Comp:TComponent);
var i: Integer;
    MI: TIModuleInterface;
    FI: TIFormInterface;
    CI: TIComponentInterface;
begin
  for i:=0 to ToolServices.GetUnitCount-1 do begin
    MI:=ToolServices.GetModuleInterface(ToolServices.GetUnitName(i));
    if Assigned(MI) then
      try
        FI:=MI.GetFormInterface;
        if Assigned(FI) then
          try
            CI:=FI.GetComponentFromHandle(Comp);
            if Assigned(CI) then begin
              CI.Focus;
              CI.Free;
            end;
          finally
            FI.Free;
          end;
      finally
        MI.Free;
      end;
  end;
end;

{TEtvDBCustomControlEditor}
Procedure TEtvDBCustomControlEditor.ToField(DataSource:TDataSource; DataField:string);
var aField:TField;
begin
  if (DataField<>'') and Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
    aField:=DataSource.DataSet.FindField(DataField);
    if Assigned(aField) then begin
      SetDesignerToComponent(aField);
      DelphiIDE.ModalEdit(#0,nil);
    end;
  end;
end;

procedure TEtvDBCustomControlEditor.ToDataSet(DataS:TComponent);
begin
  if Assigned(DataS) then begin
    if (DataS is TDataSource) and Assigned(TDataSource(DataS).DataSet) then begin
      SetDesignerToComponent(TDataSource(DataS).DataSet);
      DelphiIDE.ModalEdit(#0,Nil);
    end;
    if (DataS is TDataSet) then begin
      SetDesignerToComponent(TDataSet(DataS));
      DelphiIDE.ModalEdit(#0,Nil);
    end;
  end;
end;

{TEtvDBControlEditor}
Function TEtvDBControlEditor.GetVerbCount:integer;
begin
  Result:=1;
end;

Function TEtvDBControlEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='Go to DataSet';
  end;
end;

procedure TEtvDBControlEditor.ExecuteVerb(Index:integer);
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(Component.ClassInfo, 'DataSource');
  if PropInfo <> nil then
    ToDataSet(TDataSource(GetOrdProp(Component, PropInfo)));
end;

{TEtvDBFieldControlEditor}
Function TEtvDBFieldControlEditor.GetVerbCount:integer;
begin
  Result:=2;
end;

Function TEtvDBFieldControlEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='Go to DataSet';
    1: Result:='Go to DataField';
  end;
end;

procedure TEtvDBFieldControlEditor.ExecuteVerb(Index:integer);
var PropInfo: PPropInfo;
    DS:TDataSource;
begin
  PropInfo := GetPropInfo(Component.ClassInfo, 'DataSource');
  if PropInfo <> nil then begin
    DS:=TDataSource(GetOrdProp(Component, PropInfo));
    if Assigned(DS) then
      case Index of
        0: ToDataSet(DS);
        1: ToField(DS,ObjectStrProp(Component,'DataField'));
      end;
  end;
end;

{TDataSetListProperty}
function TDataSetListProperty.GetAttributes:TPropertyAttributes;
begin
  Result:=[paDialog{,paRevertable}];
end;

procedure TDataSetListProperty.AddToStrings(const S: string);
begin
  if fSource.IndexOf(S)=-1 then fTarget.Add(S);
end;

procedure TDataSetListProperty.Edit;
var Dial:TEtvDualListDlg;
    i:integer;
    lCollection:TDataSetCol;
begin
    Dial:=TEtvDualListDlg.Create(nil);
    lCollection:=TDataSetCol(GetOrdValue);
    with Dial do try
      Caption:='List of Datasets';
      SrcLabel.Caption:='Used';
      DstLabel.Caption:='Not Used';
      SrcList.Items.Clear;
      for i:=0 to lCollection.Count-1 do
        SrcList.Items.add(Self.Designer.GetComponentName(lCollection[i]));
      DstList.Items.Clear;
      fSource:=SrcList.Items;
      fTarget:=DstList.Items;
      Self.Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo),AddToStrings);
      if ShowModal=idOk then begin
        lCollection.Clear;
        for i:=0 to SrcList.Items.Count-1 do
          {if GetComponent(0) is TEtvFilter then
            TEtvFilter(GetComponent(0)).
              AddSubDataSet(TDataSet(Self.Designer.GetComponent(SrcList.Items[i])))
          else} begin
            if lCollection.AddItem(TDataSet(Self.Designer.GetComponent(SrcList.Items[i])),true) then
              lCollection[i].FreeNotification(TComponent(GetComponent(0)));
          end;
        Self.Designer.Modified;
      end;
    finally
      Dial.Free;
    end;
end;

end.
