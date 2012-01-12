unit EtvDB;

interface
{$I Etv.inc}

Uses Classes, DB;

type
  TEtvLookFieldOption =
    (foAutoCodeName, foAutoDropDown, foAutoDropDownWidth,
     foEditWindow,foEditOnEnter, foKeyFieldEdit,
     {foOnlyEqualinFilter,}foUpDownInClose,
     foValueNotInLookup,foUserOption);
  TEtvLookFieldOptions = set of TEtvLookFieldOption;


TFieldNameKind=(fnNoQuotes,fnQuotes);

type
  TRecordCloner = class
  protected
    FBuffer: TStrings;
    FOldNew: TDataSetNotifyEvent;
    procedure DoNewRecord(DataSet: TDataSet);
  public
    procedure GetData(DataSet:TDataSet; aBuffer:TStrings);
    procedure SetData(DataSet:TDataSet; aBuffer:TStrings);
    procedure Clone(DataSet: TDataSet);
end;

procedure CloneRecord(DataSet: TDataSet);

type
TDataSetColItem=Class(TCollectionItem)
protected
  fDataSet:TDataSet;
published
  property DataSet:TDataSet read fDataSet write fDataSet;
end;

TDataSetCol=Class(TCollection)
protected
  function GetDataSet(aIndex:integer):TDataSet;
public
  function AddItem(aDataSet:TDataSet; aUnique:boolean):boolean;
  property DataSets[Index: Integer]:TDataSet read GetDataSet; Default;
end;

type
(* Variables and types are used for cooperation between DB forms *)
  TTypeShow=(viNone,viShow,viShowModal);
  TFieldReturn=class(TComponent)
    public
    Field:string;
    Value:Variant;
  end;
  TOnEditDataEvent=procedure(Sender: TObject;TypeShow:TTypeShow;FieldReturn:TFieldReturn) of object;
  TItemDataSet=class (* used by Grid and Lookup in DoEditData *)
    DataSet:TDataSet;
    Tag:longint;
  end;
var OkOnEditData:boolean;


type
  TEtvDataSetAction=(daInsert,daDelete,daClone,daPrint,daPrintRecord,
                     daUserAction1,daUserAction2,daUserAction3);
  TEtvDataSetActions=set of TEtvDataSetAction;
  TOnDataSetActionEvent=procedure (Sender: TObject; aDataSet:TDataSet;
    aAction:TEtvDataSetAction; var ActionNeed:boolean) of object;
const DefaultEtvDataSetAction=[daInsert,daDelete,daClone,daPrint,daPrintRecord];

{EtvApp}
type
TEtvApp=class
protected
  OldDMOnDestroy:TNotifyEvent;
  FRefreshForm:Integer;
  procedure BeforeDestroyData(Sender: TObject);
public
  constructor Create;
  procedure DisableRefreshForm;
  procedure EnableRefreshForm;
  procedure EnableRefreshFormNow;
  Procedure RefreshData(Sender:TObject);
  {$IFDEF BDE_IS_USED}
  procedure AllCheckBrowseMode(Sender: TObject);
  {$ENDIF}
  procedure ShowMessage(const Msg: string);
  procedure ShowErrorAdv(const Msg,Detail: string);
  procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
end;

function EtvApp:TEtvApp;
procedure CreateEtvApp(AOpen:boolean);

type
  TEtvDMInfo = class(TComponent) (* info about DataModule*)
  protected
    fCaption:string;
  published
    property Caption:String read fCaption write fCaption;
  end;

var RunEtvDateSetEditor:procedure(aDataSet:TDataSet);
    {$IFNDEF Delphi4}
    EtvInternalOpen:procedure(aDataSet:TDataSet);
    {$ENDIF}

IMPLEMENTATION

uses Windows,Dialogs,Forms,Stdctrls,SysUtils,
     {$IFDEF BDE_IS_USED}
     DbTables,
     {$ENDIF}
     EtvDBFun,EtvPas,DiAdv;

{ TRecordCloner }
procedure TRecordCloner.GetData(DataSet:TDataSet; aBuffer:TStrings);
var I: Integer;
    FieldVal: String;
    FStream: TStringStream;
begin
  with DataSet do begin
    CheckBrowseMode;
    for I:=0 to FieldCount - 1 do with Fields[I] do
      if CanModify and (not (Fields[i] is TAutoincField)) then
        if IsBlob then begin
          FStream := TStringStream.Create('');
          try
            TBlobField(Fields[I]).SaveToStream(FStream);
            aBuffer.Add(FStream.DataString);
          finally
            FStream.Free;
          end;
        end
        else begin
          if not isNull then begin
            SetLength(FieldVal, DataSize);
            GetData(Pointer(FieldVal));
            aBuffer.Add(FieldVal);
          end else aBuffer.Add('');
        end;
  end;
end;

procedure TRecordCloner.Clone(DataSet: TDataSet);
var lBuffer:TStrings;
begin
  lBuffer := TStringList.Create;
  try
    GetData(DataSet,lBuffer);
    SetData(DataSet,lBuffer);
  finally
    lBuffer.Free;
  end;
end;

procedure TRecordCloner.SetData(DataSet: TDataSet; aBuffer:TStrings);
begin
  FBuffer:=aBuffer;
  FOldNew := DataSet.OnNewRecord;
  DataSet.OnNewRecord := DoNewRecord;
  try
    DataSet.Insert;
  finally
    DataSet.OnNewRecord := FOldNew;
  end;
end;

procedure TRecordCloner.DoNewRecord(DataSet: TDataSet);
var
  I, J: Integer;
  FStream: TStringStream;
begin
  J := 0;
  with DataSet do
    for I := 0 to FieldCount - 1 do
      with Fields[I] do
        if (CanModify) and (not (Fields[i] is TAutoincField)) then
          try
            try
              if IsBlob then
                begin
                  FStream := TStringStream.Create(FBuffer[J]);
                  try
                    TBlobField(Fields[I]).LoadFromStream(FStream);
                  finally
                    FStream.Free;
                  end;
                end
              else
                SetData(Pointer(FBuffer[J]));
            finally
              Inc(J);
            end;
          except
          end;
(* »наче получаетс€ не клонирование, а какой-то гибрид
  if @FOldNew <> nil then
    FOldNew(DataSet);
*)
end;

procedure CloneRecord(DataSet: TDataSet);
var RC:TRecordCloner;
begin
  RC:=TRecordCloner.Create;
  try
    Windows.Beep(512,150);
    RC.Clone(DataSet);
  finally
    RC.Free;
  end;
end;

{TDataSetCol}
function TDataSetCol.GetDataSet(aIndex:integer):TDataSet;
begin
  if aIndex<Count then Result:=TDataSetColItem(Items[aIndex]).DataSet
  else Result:=nil;
end;

function TDataSetCol.AddItem(aDataSet:TDataSet; aUnique:boolean):Boolean;
var i:smallint;
begin
  Result:=false;
  if aUnique then
    for i:=0 to Count-1 do
      if Self[i]=aDataSet then begin
        EtvApp.ShowMessage(aDataSet.Name+' is not added to collection,'+
            #10+'it is in collection already');
        Exit;
      end;
  (Add as TDataSetColItem).DataSet:=aDataSet;
  Result:=true;
end;

{EtvApp}
var fEtvApp:TEtvApp;

function EtvApp:TEtvApp;
begin
  if Not Assigned(fEtvApp) then fEtvApp:=TEtvApp.Create;
  Result:=fEtvApp;
end;

constructor TEtvApp.Create;
begin
 Inherited;
 FRefreshForm:=0;
end;

procedure TEtvApp.DisableRefreshForm;
begin
  inc(FRefreshForm);
end;

procedure TEtvApp.EnableRefreshForm;
begin
  if FRefreshForm>0 then Dec(FRefreshForm);
end;

procedure TEtvApp.EnableRefreshFormNow;
begin
  if FRefreshForm>0 then begin
    Dec(FRefreshForm);
    if FRefreshForm=0 then RefreshData(Self);
  end;
end;

Procedure TEtvApp.RefreshData(Sender:TObject);
begin
  if (Screen.ActiveForm<>nil) and (Screen.ActiveForm.Tag=9) and
     (FRefreshForm=0) then
    RefreshDataOnForm(Screen.ActiveForm,false);
end;

{$IFDEF BDE_IS_USED}
procedure TEtvApp.AllCheckBrowseMode(Sender: TObject);
var i,j:Integer;
begin
  (*All CheckBrowseMode*)
  for i:=0 to Session.DataBaseCount-1 do
    for j:=0 to Session.DataBases[i].DataSetCount-1 do
      Try
        with Session.DataBases[i].DataSets[j] do
          if Active then CheckBrowseMode;
      except
      end;
end;
{$ENDIF}

procedure TEtvApp.BeforeDestroyData(Sender: TObject);
begin
  {$IFDEF BDE_IS_USED}
  AllCheckBrowseMode(Sender);
  {$ENDIF}
  if Assigned(OldDMOnDestroy) then OldDMOnDestroy(Sender);
end;

procedure TEtvApp.ShowMessage(const Msg: string);
begin
  EtvApp.DisableRefreshForm;
  try
    Dialogs.ShowMessage(Msg);
  finally
    EtvApp.EnableRefreshForm;
  end;
end;

procedure TEtvApp.ShowErrorAdv(const Msg,Detail: string);
begin
  EtvApp.DisableRefreshForm;
  try
    with DlgErrorAdv do begin
      if ViewDetail then ButtonDetailClick(nil);
      LabelError.Caption:=Msg;
      MemoDetail.Text:=Detail;
      ButtonDetail.Enabled:=Detail<>'';
      ShowModal;
    end;
  finally
    EtvApp.EnableRefreshForm;
  end;
end;

procedure TEtvApp.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Sender is TCustomComboBox) and (Key=vk_Return) and (Shift=[ssCtrl]) then begin
    TCustomComboBox(Sender).DroppedDown:=not TCustomComboBox(Sender).DroppedDown;
    Key:=0;
  end;
  KeyReturn(Sender,Key,Shift);
end;

procedure CreateEtvApp(AOpen:boolean);
var i,j:integer;
begin
  if Assigned(Screen) then begin
    Screen.OnActiveFormChange:=EtvApp.RefreshData;
    (* auto Open *)
    if AOpen then
      for i:=0 to Screen.DatamoduleCount-1 do
        for j:=0 to Screen.DataModules[i].ComponentCount-1 do
          if (Screen.DataModules[i].Components[j] is TDataSet) then begin
            if (Screen.DataModules[i].Components[j].tag mod 10=9) then
              try
                TDataSet(Screen.DataModules[i].Components[j]).Open;
              except
              end;
          end;
  end else EtvApp.ShowMessage('Screen dont initialize');
  if Assigned(Application) then begin
    if Assigned(Application.MainForm) then
      RefreshDataOnForm(Application.MainForm,false);
    if Screen.DatamoduleCount>0 then begin
      EtvApp.OldDMOnDestroy:=Screen.DataModules[Screen.DatamoduleCount-1].OnDestroy;
      Screen.DataModules[Screen.DatamoduleCount-1].OnDestroy:=EtvApp.BeforeDestroyData;
    end;
  end;
end;

initialization
  OkOnEditData:=false;
finalization
  if assigned(fEtvApp) then fEtvApp.Free;
end.



