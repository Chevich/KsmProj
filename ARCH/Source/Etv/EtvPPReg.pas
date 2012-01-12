unit EtvPPReg;

interface

procedure Register;

implementation

{$R EtvPPReg.dcr}

uses Classes,Windows,DsgnIntf,DbReg,DB,EtvLook,EtvPPCtl,ppClass,ppDBBDE;

type
  TEtvPpLookupResultProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

procedure TEtvPpLookupResultProperty.GetValueList(List: TStrings);
var Pos:integer;
    s:string;
    lField:TField;
begin
  with GetComponent(0) as TEtvPpDBText do
    if (DataPipeLine is TPPBdePipeLine) and
       Assigned(TPPBdePipeLine(DataPipeLine).DataSource) and
       Assigned(TPPBdePipeLine(DataPipeLine).DataSource.DataSet) then begin
      lField:=TPPBdePipeLine(DataPipeLine).DataSource.DataSet.FindField(DataField);
      if Assigned(lField) and (lField is TEtvLookField) then begin
        s:=TEtvLookField(lField).AllLookupFields;
        Pos:=1;
        while Pos <= Length(s) do
          List.Add(ExtractFieldName(s, Pos));
      end;
    end;
end;

procedure Register;
begin
  RegisterNoIcon([TEtvPpDBText]);
  RegisterPropertyEditor(TypeInfo(string), TEtvPpDBText, 'LookField', TEtvPpLookupResultProperty);
end;

end.
