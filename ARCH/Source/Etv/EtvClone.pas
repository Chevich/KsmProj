unit EtvClone;

interface
uses classes,db,
     EtvDB;

{$I Etv.inc}

type

TEtvRecordCloner=class(TComponent)
protected
  fConfirmDataSet,fConfirmSubDataSet,fTransaction:boolean;
  fDataLink:TDataLink;
  fSubDataSets:TDataSetCol;
  fOnCloneDataSet,fOnCloneSubDataSet:TDataSetNotifyEvent;
  procedure Notification(AComponent: TComponent;
                         Operation: TOperation); override;
  function GetDataSource: TDataSource;
  procedure SetDataSource(Value: TDataSource);

  procedure ReadSubDataSetData(Reader: TReader);
  procedure WriteSubDataSetData(Writer: TWriter);
  procedure DefineProperties(Filer: TFiler); override;

public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  procedure Clone;
published
  property ConfirmDataSet:boolean read fConfirmDataSet write fConfirmDataSet default true;
  property ConfirmSubDataSet:boolean read fConfirmSubDataSet write fConfirmSubDataSet default false;
  property DataSource:TDataSource read GetDataSource write SetDataSource;
  property Transaction:boolean read fTransaction write fTransaction default true;
  property SubDataSets:TDataSetCol read fSubDataSets stored false;
  property OnCloneDataSet:TDataSetNotifyEvent read fOnCloneDataSet write fOnCloneDataSet;
  property OnCloneSubDataSet:TDataSetNotifyEvent read fOnCloneSubDataSet write fOnCloneSubDataSet;
end;

implementation
uses Windows,Dialogs,
     {$IFDEF BDE_IS_USED}
     DbTables,
     {$ENDIF}
     EtvConst,EtvPas;

procedure TEtvRecordCloner.Notification(AComponent: TComponent; Operation: TOperation);
var i:integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    if(FDataLink <> nil) and (AComponent = DataSource) then
      DataSource := nil
    else if fSubdatasets <> nil then
      for i:=0 to fSubdatasets.Count-1 do
        if FSubDataSets[i]=AComponent then begin
          FSubDataSets.Items[i].Free;
          Break;
        end;
end;

function TEtvRecordCloner.GetDataSource: TDataSource;
begin
  if FDataLink <> nil then Result := FDataLink.DataSource
  else Result := nil;
end;

procedure TEtvRecordCloner.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource<>Value then begin
    FDataLink.DataSource := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TEtvRecordCloner.DefineProperties(Filer: TFiler);
  function WriteData: Boolean;
  begin
    Result := FSubDataSets.Count > 0;
  end;
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SubDataSetData',ReadSubDataSetData,WriteSubDataSetData,WriteData);
end;

procedure TEtvRecordCloner.ReadSubDataSetData(Reader: TReader);
begin
  Reader.ReadValue;
  Reader.ReadCollection(FSubDataSets);
end;

procedure TEtvRecordCloner.WriteSubDataSetData(Writer: TWriter);
begin
  Writer.WriteCollection(FSubDataSets);
end;

constructor TEtvRecordCloner.Create(AOwner: TComponent);
begin
  inherited;
  fDataLink :=TDataLink.Create;
  fSubDataSets:=TDataSetCol.Create(TDataSetColItem);
  ConfirmDataSet:=true;
  ConfirmSubDataSet:=false;
  fTransaction:=true;
end;

Destructor TEtvRecordCloner.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  fSubDataSets.Free;
  fSubDataSets:=nil;
  inherited;
end;

procedure TEtvRecordCloner.Clone;
var i,j:integer;
    RC:TRecordCloner;
    ListRecord,ListData:TList;
    lBuffer:TStrings;
    s:string;
    Need:Boolean;
begin
  if Assigned(fDataLink) and fDataLink.Active then begin
    Need:=true;
    if fConfirmDataSet then begin
      s:=ObjectStrProp(fDataLink.DataSet,'Caption');
      if s<>'' then s:=s+#10+SCloneRecordQuestion
      else s:=SCloneRecordQuestion;
      EtvApp.DisableRefreshForm;
      Need:=MessageDlg(S,mtConfirmation,mbOKCancel,0)<>idCancel;
      EtvApp.EnableRefreshForm;
    end;
    if Need then begin
      if fSubDataSets.Count=0 then begin
        CloneRecord(fDataLink.DataSet);
        if Assigned(fOnCloneDataSet) then fOnCloneDataSet(fDataLink.DataSet);
      end
      else begin
        {$IFDEF BDE_IS_USED}
        if (fDataLink.DataSet is TDBDataSet) and fTransaction then
          TDBDataSet(fDataLink.DataSet).Database.StartTransaction;
        {$ENDIF}
        try
          RC:=TRecordCloner.Create;
          ListData:=TList.Create;
          try
            for i:=0 to fSubDataSets.Count-1 do fSubDataSets[i].DisableControls;
            try
              for i:=0 to fSubDataSets.Count-1 do with fSubDataSets[i] do begin
                ListRecord:=TList.Create;
                ListData.Add(ListRecord);
                First;
                while Not EOF do begin
                  lBuffer:=TStringList.Create;
                  ListRecord.Add(lBuffer);
                  RC.GetData(fSubDataSets[i],lBuffer);
                  Next;
                end;
              end;
              CloneRecord(fDataLink.DataSet);
              if Assigned(fOnCloneDataSet) then fOnCloneDataSet(fDataLink.DataSet);
              try
                if fDataLink.DataSet.State in [dsInsert,dsEdit] then
                  fDataLink.DataSet.Post;
                for i:=0 to fSubDataSets.Count-1 do begin
                  ListRecord:=TList(ListData[i]);
                  if ListRecord.Count>0 then begin
                    Need:=true;
                    if fConfirmSubDataSet then begin
                      s:=ObjectStrProp(fSubDataSets[i],'Caption');
                      if s<>'' then begin
                        s:=s+#10+SCloneRecordQuestion;
                        EtvApp.DisableRefreshForm;
                        Need:=MessageDlg(S,mtConfirmation,mbOKCancel,0)<>idCancel;
                        EtvApp.EnableRefreshForm;
                      end else Need:=false;
                    end;
                    if Need then with fSubDataSets[i]  do begin
                      for j:=0 to ListRecord.Count-1 do begin
                        RC.SetData(fSubDataSets[i],TStrings(ListRecord[j]));
                        if Assigned(fOnCloneSubDataSet) then
                          fOnCloneSubDataSet(fSubDataSets[i]);
                        fSubDataSets[i].Post;
                      end;
                    end;
                  end;
                end;
              except
                ShowMessage('Критическая ошибка!');
                fDataLink.DataSet.Cancel;
              end;
            finally
              for i:=0 to fSubDataSets.Count-1 do fSubDataSets[i].EnableControls;
            end;
          finally
            for i:=0 to ListData.Count-1 do begin
              ListRecord:=TList(ListData[i]);
              for j:=0 to ListRecord.Count-1 do TStrings(ListRecord[j]).Free;
              ListRecord.Free;
            end;
            ListData.Free;
            RC.Free;
          end;
          {$IFDEF BDE_IS_USED}
          if (fDataLink.DataSet is TDBDataSet) and fTransaction then
            TDBDataSet(fDataLink.DataSet).Database.Commit;
          {$ENDIF}
        except
          {$IFDEF BDE_IS_USED}
          if (fDataLink.DataSet is TDBDataSet) and fTransaction then
            TDBDataSet(fDataLink.DataSet).Database.RollBack;
          {$ENDIF}
          Raise;
        end;
      end;
    end;
  end;
end;

end.
