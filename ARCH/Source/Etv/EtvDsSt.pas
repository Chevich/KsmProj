unit EtvDsSt;

interface
uses EtvDsgn,DsgnIntf,Classes,db;

{$I Etv.Inc}

type
  TEtvDataSetEditor = class(TComponentEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

  TEtvDMEditor = class(TComponentEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

  TEtvDataSourceEditor = class(TEtvDBCustomControlEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

IMPLEMENTATION

Uses TypInfo,exptIntf,EditIntf,LibIntf,DsDesign,
     sysutils,Clipbrd,Dialogs,graphics,Windows,
     {$IFDEF BDE_IS_USED}
     DBXplor,
     DbTables,
     {$ENDIF}
     EtvPas,EtvDBFun,EtvDB;

{TEtvDataSetEditor}
const QuantityLines=9;

Function TEtvDataSetEditor.GetVerbCount:integer;
begin
  Result:=QuantityLines{+(TDataSet(Component).fieldCount)};
end;

Function TEtvDataSetEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='Fields Editor..';
    1: Result:=DataSetInfo(TDataSet(Component));
    2: Result:='Explore';
    3: Result:='Refresh dataset structure';
    4: Result:='Copy list of data fields to clipboard';
    5: Result:='Copy info of fields to clipboard';
    6: Result:='Auto correct';
    7: Result:='Pump Display Labels. Auto correct';
    8: Result:='Run edit form';
    {else Result:=FieldInfo(TDataSet(Component).Fields[Index-QuantityLines],false);}
  end;
end;

procedure TEtvDataSetEditor.ExecuteVerb(Index:integer);
{$IFDEF BDE_IS_USED}
var  db:TDataBase;
{$ENDIF}
begin
  Case Index of
    0: {$IFDEF Delphi5}
       ShowFieldsEditor(Designer, TDataSet(Component),TDSDesigner);
       {$ELSE}
       ShowDatasetDesigner(Designer, TDataSet(Component));
       {$ENDIF}
    1: begin
      if TDataSet(Component).Active then TDataSet(Component).close
      else TDataSet(Component).Open;
      Designer.Modified;
    end;
    2: {$IFDEF BDE_IS_USED}
       if Component is TDBDataSet then ExploreDataSet(TDBDataSet(Component))
       {$ENDIF}
       ;
    3: {$IFDEF BDE_IS_USED}
       if Component is TDBDataSet then with TDBDataSet(Component) do begin
         if Assigned(Session.FindDataBase(DataBaseName)) then begin
           DB:=Session.FindDataBase(DataBaseName);
           if ObjectStrProp(Component,'TableName')<>'' then begin
             DB.FlushSchemaCache(ObjectStrProp(Component,'TableName'));
             Self.Designer.Modified;
           end;
         end;
       end
       else EtvApp.ShowMessage('It works only for TDBDataSets');
       {$ELSE}
       EtvApp.ShowMessage('It works only for TDBDataSets'+#13+
                          '"BDE_IS_USED" must be on in the Etv.Inc');
       {$ENDIF}
    4: FieldDataListToClipBoard(TDataSet(Component));
    5: DataSetInfoToClipBoard(TDataSet(Component));
    6: begin
      DataSetAutoCorrect(TDataSet(Component));
      Designer.Modified;
    end;
    7: begin
      DataSetLabel(TDataSet(Component),'STA');
      DataSetAutoCorrect(TDataSet(Component));
      Designer.Modified;
    end;
    8: begin
      try
        if Assigned(RunEtvDateSetEditor) then
          RunEtvDateSetEditor(TDataSet(Component))
        else EtvApp.ShowMessage('This feature is available in the comlete version of Etv Library only');
      except
        on E: Exception do EtvApp.ShowMessage(E.Message);
      end;
    end;
    {else begin
      Designer.SelectComponent(TDataSet(Component).Fields[Index-QuantityLines]);
      DelphiIDE.ModalEdit(#0,Nil);
    end;                          }
  end;
end;

{TEtvDMEditor}
Function TEtvDMEditor.GetVerbCount:integer;
var dm:TComponent;
    i:smallInt;
begin
  Result:=3;  (* Active and Close all DataSets *)
  dm:=Component.owner;
  for i:=0 to dm.ComponentCount-1 do
    if dm.Components[i] is TDataSet then Result:=Result+1;
end;

Function TEtvDMEditor.GetVerb(Index:integer):string;
var dm:TComponent;
    i,ind:smallint;
begin
  case Index of
    0: Result:=TEtvDMInfo(Component).Caption;
    1: Result:='Open all DataSets';
    2: Result:='Close all DataSets';
    else begin
      dm:=Component.owner;
      ind:=2;
      for i:=0 to DM.ComponentCount-1 do begin
        if dm.Components[i] is TDataSet then Inc(Ind);
        if ind=index then begin
          Result:=DataSetInfo(TDataSet(dm.Components[i]));
          break;
        end;
      end;
    end;
  end;
end;

procedure TEtvDMEditor.ExecuteVerb(Index:integer);
var dm:TComponent;
    i,ind:smallint;
begin
  dm:=Component.owner;
  case Index of
    0: ;
    1: begin (* Open all DataSets *)
      OpenAllDataSets(DM,true);
      Designer.Modified;
    end;
    2: begin (* Close all DataSets *)
      CloseAllDataSets(DM,true);
      Designer.Modified;
    end;
    else begin
      ind:=2;
      for i:=0 to DM.ComponentCount-1 do begin
        if dm.Components[i] is TDataSet then Inc(Ind);
        if ind=index then begin
          Designer.SelectComponent(dm.components[i]);
          break;
        end;
      end;
    end;
  end;
end;

{TEtvDataSourceEditor}
Function TEtvDataSourceEditor.GetVerbCount:integer;
begin
  Result:=1;
end;

Function TEtvDataSourceEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='Go to DataSet';
  end;
end;

procedure TEtvDataSourceEditor.ExecuteVerb(Index:integer);
begin
  case Index of
    0: ToDataSet(TDataSource(Component))
  end;
end;

end.
