unit EtvForms;

interface
uses Classes,Forms,DB,dbctrls,
     EtvDB;
     

{$I Etv.inc}

{const CM_FormDB = cm_Base + 98;
      FormDBInsertComponent=40;}
type

TFormDBOption = (foDataReadOnly, foPageOneRecord,
                 foFreeOnClose, foApplyOnClose,
                 foPC1ChangeSize, foAutoWidth,
                 foUserOption1,foUserOption2,foUserOption3);
TFormDBOptions = set of TFormDBOption;

const
TFormDBOptionsDefault=[foFreeOnClose,foApplyOnClose,foAutoWidth];

type
TFormDB = class;

TFormDBDataLink=Class(TDataLink)
  fFormDB:TFormDB;
  procedure ActiveChanged; override;
end;

TFormDB = class(TForm)
protected
  FDataLink: TDataLink;
  FDataSource: TDataSource;
  fOptions: TFormDBOptions;
  fFirstActive:boolean;
  fOldReadOnly:boolean;
  fOldCachedUpdates:boolean;
  fOldActive:boolean;
  fCapture:boolean;
  OldIndexFieldNames:string;
  OldIndexName:string;
  FOnClose: TCloseEvent;
  fFieldReturn:TFieldReturn;
  fFormDataSet:TDataSet;
  function GetDataSource: TDataSource;
  procedure SetDataSource(Value: TDataSource);
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  function IsForm: Boolean;
  procedure EtvClose(Sender: TObject; var Action: TCloseAction);
  procedure Loaded; override;
  procedure Activate; override;
  procedure Deactivate; override;
  procedure CaptureDataSet(ADataSet:TDataSet; Need:boolean); dynamic;
  procedure ReleaseDataSet(ADataSet:TDataSet); dynamic;
  {procedure CMFormDB(var Message: TMessage); message CM_FormDB;}
  procedure SetFieldReturn(Value:TFieldReturn);
  procedure CheckDBNavHints(aDBNav:TDBNavigator);
  procedure CheckLabel(aLabel:string);
public
  procedure CheckDataSet(ADataSet:TDataSet);
  property FormDataSet:TDataSet read fFormDataSet write fFormDataSet;
  property FieldReturn:TFieldReturn read fFieldReturn write SetFieldReturn;
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  function AutoWidth(aTextWidth,AddWidth:smallint; aLabelWidth:boolean):boolean;
  procedure AddSetup; dynamic;
procedure ShowForm(TypeShow:TTypeShow);
  procedure SetupParams(ALabel:string; AOptions:TFormDBOptions);
published
  property DataSource: TDataSource read GetDataSource write SetDataSource;
  property Options: TFormDBOptions read fOptions write fOptions default TFormDBOptionsDefault;
  property OnClose: TCloseEvent read FOnClose write FOnClose stored IsForm;
end;

TFormDBClass=class of TFormDB;

Function FindFormDB(ADataSet:TDataSet):TFormDB;
Function ToForm(FormDBClass:TFormDBClass; ADataSet:TDataSet;
                TypeShow:TTypeShow; AFieldReturn:TFieldReturn):TFormDB;
Function ToFormParam(FormDBClass:TFormDBClass; ADataSet:TDataSet;
                     TypeShow:TTypeShow; AFieldReturn:TFieldReturn; ALabel:string;
                     AOptions:TFormDBOptions):TFormDB;

IMPLEMENTATION

uses TypInfo,Controls,
     {$IFDEF BDE_IS_USED}
     DbTables,
     {$ENDIF}
     EtvConst,EtvPas,EtvDBFun, Misc;

procedure TFormDBDataLink.ActiveChanged;
begin
  if fFormDB <> nil then fFormDB.CheckDataSet(DataSet);
end;

{TFormDB}
procedure TFormDB.CheckLabel(aLabel:string);
var aCaption:string;
begin
  if ALabel<>'' then
    Caption:=ALabel
  else if Assigned(DataSource) and Assigned(DataSource.DataSet) then begin
    aCaption:=ObjectStrProp(DataSource.DataSet,'Caption');
    if aCaption<>'' then Caption:=aCaption;
  end;
end;

procedure TFormDB.SetupParams(ALabel:string; AOptions:TFormDBOptions);
begin
  CheckLabel(aLabel);
  Options:=AOptions;
end;

constructor TFormDB.Create(aOwner: TComponent);
begin
  FDataLink := TFormDBDataLink.Create;
  TFormDBDataLink(FDataLink).fFormDB:=self;
  fOptions:=TFormDBOptionsDefault;
  inherited Create(aOwner);
  fDataSource:=nil;
  CheckLabel('');
  fCapture:=false;
  AMScaleForm(self,false);
end;

destructor TFormDB.Destroy;
begin
  if Assigned(DataSource) and Assigned(DataSource.DataSet) then
    CheckDataSet(nil);
  if Assigned(fDataSource) then fDataSource.free;
  fDataSource:=nil;
  inherited Destroy;
  FDataLink.free;
  FDataLink := nil;
end;

function TFormDB.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TFormDB.SetDataSource(Value: TDataSource);
var PropInfo: PPropInfo;
    DS:TDataSource;
    i:integer;
begin
  if Value <> nil then begin
    Value.FreeNotification(Self);
    if Not(csLoading in ComponentState) then
      for i:=0 to ComponentCount-1 do begin
        if GetPropInfo(Components[i].ClassInfo, 'DataField')=nil then begin
          PropInfo := GetPropInfo(Components[i].ClassInfo, 'DataSource');
          if PropInfo <> nil then begin
            DS:=TDataSource(GetOrdProp(Components[i],PropInfo));
            if (DS=FDataLink.DataSource) and
               ((Not(Components[i] is TControl)) or
                TControl(Components[i]).Enabled) then
              SetOrdProp(Components[i], PropInfo, Integer(Value));
          end;
        end;
      end;
  end;
  FDataLink.DataSource := Value;
  CheckLabel('');
end;

procedure TFormDB.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then begin
    if (FDataLink <> nil) and (AComponent = DataSource) then
      DataSource := nil;
    if AComponent=fFieldReturn then fFieldReturn:=nil;
  end;
  {if (Operation = opInsert) and HandleAllocated and
     (csDesigning in ComponentState) and
     (Not(csLoading in ComponentState)) then
    PostMessage(Handle,CM_FormDB,Integer(FormDBInsertComponent),Integer(aComponent));}
end;

function TFormDB.IsForm: Boolean;
begin
  Result := not IsControl;
end;

procedure TFormDB.EtvClose(Sender: TObject; var Action: TCloseAction);
begin
  if (foFreeOnClose in fOptions) or (formStyle=fsMDIChild) then Action:=caFree
  else Action:=caHide;
  if Assigned(DataSource) and assigned(DataSource.DataSet) and (DataSource.DataSet.Active) then begin
    if Not (foDataReadOnly in fOptions) then DataSource.DataSet.CheckBrowseMode;
    {$IFDEF BDE_IS_USED}
    if (foApplyOnClose in Options) and (DataSource.DataSet is TDBDataSet) and
      TDBDataSet(DataSource.DataSet).CachedUpdates and
      TDBDataSet(DataSource.DataSet).UpdatesPending then
      TDBDataSet(DataSource.DataSet).DataBase.ApplyUpdates([TDBDataSet(DataSource.DataSet)]);
    {$ENDIF}
    if Assigned(FieldReturn) then
      FieldReturn.Value:=DataSource.DataSet.FieldByName(FieldReturn.Field).value;
  end;
  if Assigned(fOnClose) then fOnClose(Sender, Action);
end;

procedure TFormDB.Loaded;
begin
  inherited Loaded;
  if not(csDesigning in ComponentState) then begin
    inherited OnClose:=EtvClose;
  end;
end;

procedure TFormDB.Activate;
begin
  if assigned(DataSource) and assigned(DataSource.Dataset) and
     Assigned(FieldReturn) then
    try
      LocateWOExcept(DataSource.DataSet,FieldReturn.Field,FieldReturn.Value,[])
    finally
    end;
  inherited Activate;
end;

Procedure TFormDB.Deactivate;
begin
  if assigned(DataSource) and assigned(DataSource.DataSet) and
     (DataSource.DataSet.Active) and (Not (foDataReadOnly in fOptions)) then
    DataSource.DataSet.CheckBrowseMode;
  inherited Deactivate;
end;

Function TFormDB.AutoWidth(aTextWidth,AddWidth:smallint; aLabelWidth:boolean):boolean;
var i,j,AWidth:integer;
begin
  Result:=true;
  if aTextWidth<=0 then aTextWidth:=Canvas.TextWidth('0');
  if Assigned(Datasource) and Assigned(DataSource.DataSet) and
     (DataSource.DataSet.FieldCount>0) then begin
    (* Width of form *)
    AWidth:=0;
    for i := 0 to DataSource.DataSet.FieldCount - 1 do
      if DataSource.DataSet.Fields[i].visible then begin
        j:=DataSource.DataSet.Fields[i].DisplayWidth;
        if aLabelWidth and
           (length(DataSource.DataSet.Fields[i].DisplayLabel)>j) then
          j:=length(DataSource.DataSet.Fields[i].DisplayLabel);
        AWidth:=AWidth+j+1;
      end;
    AWidth:=AWidth*ATextWidth+AddWidth;

    if AWidth>Screen.Width then begin
      AWidth:=Screen.Width;
      Result:=false;
    end;
    if AWidth>Width then Width:=AWidth;
    if Width+Left>Screen.Width then
      Left:=Screen.Width-width;
  end;
end;

procedure TFormDB.AddSetup;
begin
  if foAutoWidth in Options then AutoWidth(0,45,true);
end;

procedure TFormDB.ShowForm(TypeShow:TTypeShow);
var Exist:boolean;
begin
  if (TypeShow=viShowModal) and (formStyle<>fsMDIChild) then begin
    if visible then visible:=false;
    if windowState=wsMinimized then windowState:=wsNormal;
    if ShowModal=mrOk then OkOnEditData:=true
    else OkOnEditData:=false;
  end else
  if TypeShow<>viNone then begin
    Exist:=false;
    if not visible then begin
      visible:=true;
      Exist:=true;
    end;
    if windowState=wsMinimized then begin
      windowState:=wsNormal;
      Exist:=true;
    end;
    if not Exist then begin
      if (formStyle=fsMDIChild) then bringToFront;
      SetFocus;
    end;
  end;
end;

procedure TFormDB.CheckDataSet(ADataSet:TDataSet);
begin
  if Not Assigned(DataSource) then begin
    if Not Assigned(fDataSource) then fDataSource:=TDataSource.Create(nil);
    DataSource:=fDataSource;
  end;
  if DataSource.DataSet<>aDataSet then begin
    if Assigned(DataSource.DataSet) then ReleaseDataSet(DataSource.DataSet);
    DataSource.DataSet:=aDataSet;
    if Assigned(aDataSet) then CaptureDataSet(aDataSet,true);
  end else CaptureDataSet(aDataSet,false);
  CheckLabel('');
end;

procedure TFormDB.CaptureDataSet(ADataSet:TDataSet; Need:boolean);
begin
  if Need or (Not fCapture) then begin
    fCapture:=true;
    if Assigned(ADataset) then begin
      fOldActive:=ADataSet.Active;
      {$IFDEF BDE_IS_USED}
      if ADataSet is TTable then with TTable(ADataSet) do begin
        fOldCachedUpdates:=CachedUpdates;
        if not(foDataReadOnly in fOptions) and fOldCachedUpdates then begin
          if fOldActive then Close;
          CachedUpdates:=false;
        end;
        fOldReadOnly:=ReadOnly;
        if fOldReadOnly<>(foDataReadOnly in fOptions) then begin
          if Active then Close;
          ReadOnly:=foDataReadOnly in fOptions;
        end;
        OldIndexFieldNames:=IndexFieldNames;
        OldIndexName:=IndexName;
      end;
      {$ENDIF}
      if Not ADataSet.Active then ADataSet.Open;
    end;
  end;
end;

procedure TFormDB.ReleaseDataSet(ADataSet:TDataSet);
begin
  {$IFDEF BDE_IS_USED}
  if (ADataSet is TTable) then with TTable(ADataSet) do begin
    if (fOldCachedUpdates<>CachedUpdates) then begin
      if Active then Close;
      CachedUpdates:=fOldCachedUpdates;
    end;
    if (fOldReadOnly<>ReadOnly) then begin
      if Active then Close;
      ReadOnly:=fOldReadOnly;
    end;
    if OldIndexFieldNames<>IndexFieldNames then
      IndexFieldNames:=OldIndexFieldNames;
    if OldIndexName<>IndexName then IndexName:=OldIndexName;
  end;
  {$ENDIF}
  if ADataSet.Active<>fOldActive then ADataSet.Active:=fOldActive;
end;

{procedure TFormDB.CMFormDB(var Message: TMessage);
var PropInfo: PPropInfo;
begin
  if (Message.wParam=FormDBInsertComponent) then begin
    PropInfo := GetPropInfo(TComponent(Message.lParam).ClassInfo, 'DataSource');
    if PropInfo <> nil then
      SetOrdProp(TComponent(Message.lParam), PropInfo, Integer(DataSource));
    if TComponent(Message.lParam) is TDBNavigator then
      CheckDBNavHints(TDBNavigator(TComponent(Message.lParam)));
  end;
end;}

procedure TFormDB.SetFieldReturn(Value:TFieldReturn);
begin
  fFieldReturn:=Value;
  if Assigned(Value) then
    Value.FreeNotification(Self);
end;

procedure TFormDB.CheckDBNavHints(aDBNav:TDBNavigator);
begin
  if aDBNav.Hints.count=0 then begin
    aDBNav.Hints.Add(SNavFirst);
    aDBNav.Hints.Add(SNavPrior);
    aDBNav.Hints.Add(SNavNext);
    aDBNav.Hints.Add(SNavLast);
    aDBNav.Hints.Add(SNavInsert);
    aDBNav.Hints.Add(SNavDelete);
    aDBNav.Hints.Add(SNavEdit);
    aDBNav.Hints.Add(SNavPost);
    aDBNav.Hints.Add(SNavCancel);
    aDBNav.Hints.Add(SNavRefresh);
  end;
end;

Function FindFormDB(ADataSet:TDataSet):TFormDB;
var i:integer;
begin
  Result:=nil;
  if Assigned(Screen) then
    for i:=0 to Screen.FormCount-1 do
      if (Screen.Forms[i] is TFormDB) and
         (TFormDB(Screen.Forms[i]).FormDataSet=ADataSet)
          then begin
        Result:=TFormDB(Screen.Forms[i]);
        Exit;
      end;
end;

Function ToForm(FormDBClass:TFormDBClass; ADataSet:TDataSet;
                TypeShow:TTypeShow; AFieldReturn:TFieldReturn):TFormDB;
begin
  Result:=FindFormDB(ADataSet);
  if Not Assigned(Result) then begin
    Result:=FormDBClass.Create(Application);
    Result.FormDataSet:=ADataSet;
    Result.CheckDataSet(aDataSet);
    Result.AddSetup;
  end else if Assigned(Screen) and (Result=Screen.ActiveForm) then Exit;
  Result.FieldReturn:=AFieldReturn;
  Result.ShowForm(TypeShow);
end;

Function ToFormParam(FormDBClass:TFormDBClass; ADataSet:TDataSet;
                     TypeShow:TTypeShow; AFieldReturn:TFieldReturn; ALabel:string;
                     AOptions:TFormDBOptions):TFormDB;
begin
  Result:=FindFormDB(ADataSet);
  if Not Assigned(Result) then begin
    Result:=FormDBClass.Create(Application);
    Result.FormDataSet:=ADataSet;
    Result.SetupParams(ALabel,AOptions);
    Result.CheckDataSet(aDataSet);
    Result.AddSetup;
  end else if Assigned(Screen) and (Result=Screen.ActiveForm) then Exit;
  Result.FieldReturn:=AFieldReturn;
  Result.ShowForm(TypeShow);
end;

end.

