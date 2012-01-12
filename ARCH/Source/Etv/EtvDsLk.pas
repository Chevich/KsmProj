unit EtvDsLk;

interface

uses Classes,DBReg,
     EtvDsgn;

{$I Etv.Inc}

type
  TEtvDBLookupComboEditor = class(TEtvDBCustomControlEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

TEtvLookupFieldProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;
TEtvFieldProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;

TEtvLookupProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;
TEtvLookProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;

TEtvLookupResultProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;

TEtvLookupLevelFieldProperty = class(TDBStringProperty)
public
  procedure GetValueList(List: TStrings); override;
end;

IMPLEMENTATION

uses DB,
     EtvLook,EtvOther;

{TEtvDBLookupComboEditor}
Function TEtvDBLookupComboEditor.GetVerbCount:integer;
begin
  Result:=4;
end;

Function TEtvDBLookupComboEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='Auto size';
    1: Result:='Go to DataField';
    2: Result:='Go to DataSet';
    3: Result:='Go to LookupDataSet';
  end;
end;

procedure TEtvDBLookupComboEditor.ExecuteVerb(Index:integer);
var L:smallint;
    aField:TField;
    Exist:boolean;
begin
  case Index of
    0: begin
      L:=TEtvDBLookupCombo(Component).AutoWidth;
      if L>0 then Designer.Modified;
    end;
    1: With TEtvDBLookupCombo(Component) do
      ToField(DataSource,DataField);
    2: With TEtvDBLookupCombo(Component) do
      ToDataSet(DataSource);
    3: With TEtvDBLookupCombo(Component) do begin
      Exist:=false;
      if (DataField<>'') and Assigned(DataSource) and
         Assigned(DataSource.DataSet) then begin
        aField:=DataSource.DataSet.FindField(DataField);
        if Assigned(aField) and (aField.FieldKind=fkLookup) then begin
          Exist:=true;
          ToDataSet(aField.LookupDataSet);
        end;
      end;
      if (Not Exist) then ToDataSet(ListSource);
    end;
  end;
end;

procedure TEtvLookupFieldProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TField do if LookupDataSet <> nil then
    For i:=0 to LookupDataSet.FieldCount-1 do
      List.Add(LookupDataSet.Fields[i].FieldName);
end;

procedure TEtvFieldProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TField do if DataSet <> nil then
    For i:=0 to DataSet.FieldCount-1 do
      if DataSet.Fields[i].FieldName<>FieldName then
        List.Add(DataSet.Fields[i].FieldName);
end;

procedure TEtvLookupProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TEtvCustomDBLookupCombo do
    if (ListSource<>nil) and (ListSource.DataSet<>nil) then
      For i:=0 to ListSource.DataSet.FieldCount-1 do
        List.Add(ListSource.DataSet.Fields[i].FieldName);
end;

procedure TEtvLookProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TEtvCustomDBLookupCombo do
    if (DataSource<>nil) and (DataSource.DataSet<>nil) then
      For i:=0 to DataSource.DataSet.FieldCount-1 do
        List.Add(DataSource.DataSet.Fields[i].FieldName);
end;

procedure TEtvLookupResultProperty.GetValueList(List: TStrings);
var Pos:integer;
    s:string;
    lField:TField;
begin
  with GetComponent(0) as TEtvDBText do
    if Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
      lField:=DataSource.DataSet.FindField(DataField);
      if Assigned(lField) and (lField is TEtvLookField) then begin
        s:=TEtvLookField(lField).AllLookupFields;
        Pos:=1;
        while Pos <= Length(s) do
          List.Add(ExtractFieldName(s, Pos));
      end;
    end;
end;

procedure TEtvLookupLevelFieldProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TEtvLookupLevelItem do if DataSet <> nil then
    For i:=0 to DataSet.FieldCount-1 do
      List.Add(DataSet.Fields[i].FieldName);
end;

end.
