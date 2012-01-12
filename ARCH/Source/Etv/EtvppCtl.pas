unit EtvPpCtl;

interface

uses Forms,
     ppClass,ppReport,ppCtrls,ppViewr;

type
  TEtvPpDBText = class(TppDBText)
  protected
    fLookField:string;
    function  GetTheText: string; override;
    procedure SetLookField(aLookField:string);
  published
    property LookField:string read fLookField write SetLookField;
  end;

procedure SetViewerZoom(aReport:TppReport; aWindowState:TWindowState;
                        aZoom:TppZoomSettingType);

IMPLEMENTATION

uses Classes,DB,SysUtils,ppTypes,ppDBBDE,EtvLook,EtvList;

{TEtvDBLookText}
function TEtvPpDBText.GetTheText: string;
var OldVFieldIndex,i: Integer;
    Field:TField;
    var Pos: Integer;
    s:string;
begin
  Field:=nil;
  if (DataPipeLine is TPPBdePipeLine) and
     Assigned(TPPBdePipeLine(DataPipeLine).DataSource) and
     Assigned(TPPBdePipeLine(DataPipeLine).DataSource.DataSet) then
    Field:=TPPBdePipeLine(DataPipeLine).DataSource.DataSet.FindField(DataField);
  if Assigned(Field) and (Field is TEtvLookField) and
     (fLookField<>'') then with TEtvLookField(Field) do begin
    OldVFieldIndex:=VFieldIndex;
    Pos := 1;
    Result:='';
    while Pos <= Length(fLookField) do begin
      s:=ExtractFieldName(fLookField, Pos);
      for i:=0 to LookupFields.Count-1 do
        if AnsiCompareText(TField(LookupFields[i]).FieldName, s)=0 then begin
          VFieldIndex:=i;
          if Result<>'' then Result:=Result+' ';
          Result:=Result+Inherited GetTheText;
          Break;
        end;
    end;
    if OldVFieldIndex<>VFieldIndex then VFieldIndex:=OldVFieldIndex;
  end else if Assigned(Field) and (Field is TEtvListField) then
    Result:=TEtvListField(Field).AsString
  else Result:=Inherited GetTheText;
end;

procedure TEtvPpDBText.SetLookField(aLookField:string);
begin
  fLookField:=aLookField;
  Notify(DataPipeline, ppopDataChange); {ReportBuilder 4.0}
  {DataPipelineNotify(DataPipeline, ppacChange);} {ReportBuilder 3.52}
end;

procedure SetViewerZoom(aReport:TppReport; aWindowState:TWindowState;
                        aZoom:TppZoomSettingType);
begin
  if Assigned(aReport) and Assigned(aReport.PreviewForm) then with aReport do begin
    PreviewForm.WindowState:=aWindowState;
    {zsWholePage, zsPageWidth, zs100Percent, zsPercentage}
    TppViewer(PreviewForm.Viewer).ZoomSetting :=aZoom;
  end;
end;

initialization
  RegisterClasses([TEtvPpDBText]);
  ppRegisterComponent(TEtvPpDBText, 'Data Components', 6, 0, 'EtvPpDBText', HInstance);
end.
