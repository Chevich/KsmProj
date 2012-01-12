{$I XLib.inc }
Unit XECtrls;

Interface

Uses Classes, Graphics, Controls, DB, DBCtrls, ExtCtrls, Messages,
     XCtrls, EtvList, EtvContr, EtvLook, EtvGrid, XMisc, EtvRxCtl;

type

{ TXEDBRadioGroup }
  TXEDBRadioGroup = class(TDBRadioGroup)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;
{ TXDEBRadioGroup }

  TXEDBCheckBox = class(TDBCheckBox)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

{ TXEDBEdit }

  TXEDBEdit = class(TEtvDBEdit)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

{ TXEDBDateEdit }

  TXEDBDateEdit = class(TEtvDBDateEdit)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

{ TXEDBCombo }

  TXEDBCombo=class(TEtvDBCombo)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

  TXEDBMemo = class(TDBMemo)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

{ TXEDBLookupCombo }

  TXEDBLookupCombo = class(TEtvDBLookupCombo)
  private
    FIsContextOpen: Boolean;
    FStoreDataSet: TDataSet;
    FStoreColor: TColor;
    FStoreHeadColor:TColor;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure XOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TXEDBInplaceLookUpCombo }

  TXEDBInplaceLookUpCombo = class(TEtvInplaceLookupCombo)
  private
    FIsContextOpen: Boolean;
    FStoreDataSet: TDataSet;
    FStoreColor: TColor;
    FStoreHeadColor:TColor;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure SetHideFlag(Value: Boolean);
    procedure XOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TXEDbGrid }

  TXEDbGrid = class(TEtvDbGrid)
  private
    FIsStoredDataSource: Boolean;
    FStoredDataSource: TDataSource;
    FStoredControlSource: TDataSource;
    FStoredColumn: Integer;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMChangePageSource(var Msg: TMessage); message WM_ChangePageSource;
    procedure WMChangeControlSource(var Msg: TMessage); message WM_ChangeControlSource;
    procedure ReadDataSource(Reader: TReader);
    procedure WriteDataSource(Writer: TWriter);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure ReadIsDataSource(Reader: TReader);
    procedure WriteIsDataSource(Writer: TWriter);
  protected
    function CreateInplaceLookupCombo:TEtvInplaceLookupCombo; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler);override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ColEnter; override;
  public
    MarkGridColor: TColor;
    MarkGridFontColor: TColor;
    constructor Create(AOwner: TComponent); override;
    procedure SetDefaultGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetDefaultGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure FormatColumns(AsInDataBase: boolean);
  published
    property DataSource read GetDataSource write SetDataSource stored False;
  end;

var XNotifyEvent: TXNotifyEvent;

Implementation

Uses TypInfo, Windows, Dialogs, Forms, DBTables, DBGrids, LnTables, EtvBor, LnkSet, EtvDB, FVisDisp, EtvPopup,
     SysUtils, XTFC, XDBTFC, XForms, XDBMisc, LnkMisc, EtvTemp, EtvOther, TlsForm, ETVPas;

var aTick: byte;

{ TXEDBCheckBox }

Procedure TXEDBCheckBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  KeyReturn(Self,Key,Shift);
end;

Procedure TXEDBCheckBox.WMSetFocus(var Message: TWMSetFocus);
begin
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
//  CreateCaret(Handle, 0, Font.Size div 2, Height);
//  ShowCaret(Handle);
end;

procedure TXEDBCheckBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource) and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetParams:
        begin
          if Operation = opInsert then begin
            TXEDBLookupCombo(TXNotifyEvent(AComponent).SpellChild).KeyValue:=Self.Text;
            TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue:=Self.Text;
          end else begin
            Field.AsString:=
                  TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue;
          end;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

{ TXEDBRadioGroup }

Procedure TXEDBRadioGroup.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  KeyReturn(Self,Key,Shift);
end;

Procedure TXEDBRadioGroup.WMSetFocus(var Message: TWMSetFocus);
begin
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
end;

procedure TXEDBRadioGroup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource) and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetParams:
        begin
          if Operation = opInsert then begin
            TXEDBLookupCombo(TXNotifyEvent(AComponent).SpellChild).KeyValue:=Self.Text;
            TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue:=Self.Text;
          end else begin
            Field.AsString:=
                  TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue;
          end;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

{ TXEDBEdit }

Procedure TXEDBEdit.WMSetFocus(var Message: TWMSetFocus);
(*
const FirstFFF:boolean=true;
      I: integer=0;
var FFF: TextFile;
    UUU: String;
*)
begin
  Inherited;
  {******************************************************
  if FirstFFF then begin
    AssignFile(FFF,'c:\temp\tempik.tmp');
    Rewrite(FFF);
    FirstFFF:=false;
  end else begin
    AssignFile(FFF,'c:\temp\tempik.tmp');
    Append(FFF);
  end;
  Inc(I);
  if Assigned(DataSource) then UUU:=DataSource.Name else UUU:='нет';
  writeln(FFF,IntToStr(I)+' '+UUU);
  CloseFile(FFF);
  {******************************************************}
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
  CreateCaret(Handle, 0, Font.Size div 4, Abs(Font.Height)+4);
  ShowCaret(Handle);
end;

Procedure TXEDBEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource) and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetParams:
        begin
          if Operation = opInsert then begin
            TXEDBLookupCombo(TXNotifyEvent(AComponent).SpellChild).KeyValue:=Self.Text;
            TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue:=Self.Text;
          end else begin
            Field.AsString:=
                  TDBLookupComboBoxBorland(TXNotifyEvent(AComponent).SpellChild).FDataList.KeyValue;
          end;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

{ TXEDBDateEdit }

Procedure TXEDBDateEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
  CreateCaret(Handle, 0, Font.Size div 4, Abs(Font.Height)+4);
  ShowCaret(Handle);
end;

Procedure TXEDBDateEdit.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource)and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

{ TXEDBCombo }

Procedure TXEDBCombo.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
end;

Procedure TXEDBCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource)and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

Procedure TXEDBMemo.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
  CreateCaret(Handle, 0, Font.Size div 4, Abs(Font.Height)+4);
  ShowCaret(Handle);
end;

Procedure TXEDBMemo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource) and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited Notification(AComponent, Operation);
end;

{ common procedures }

Procedure XEDBSetLookupMode(Self: TDBLookupControl; Value: Boolean);
begin
  with TDBLookupControlBorland(Self) do
    if FLookupMode <> Value then
      if Value then begin
        FMasterField:=GetFieldProperty(FDataField.DataSet, Self, FDataField.KeyFields);
        FLookupSource.DataSet:=FDataField.LookupDataSet;
        FKeyFieldName:=FDataField.LookupKeyFields;
        FLookupMode:=True;
        FListLink.DataSource:=FLookupSource;
      end else begin
        FListLink.DataSource:=nil;
        FLookupMode:=False;
        FKeyFieldName:='';
        FLookupSource.DataSet:=nil;
        FMasterField:=FDataField;
      end;
end;

Procedure XEDBDataLinkRecordChanged(Self: TDBLookupComboBox);
begin
  with Self, TDBLookupControlBorland(Self) do
    if FMasterField <> nil then
      KeyValue:= FMasterField.Value
    else KeyValue:=Null;
end;

Procedure XEDBChangeDataField(Self: TDBLookupComboBox; Field: TField);
begin
  XEDBSetLookupMode(Self, False);
  TDBLookupControlBorland(Self).FDataField:=Field;
  XEDBSetLookupMode(Self, True);
  XEDBDataLinkRecordChanged(Self);
end;

Procedure XEDBPaint(Self: TEtvCustomDBLookupCombo; FIsContextOpen: Boolean;
                    FStoreColor, FStoreHeadColor: TColor);
begin
  if not FIsContextOpen then
    with TDBLookupComboBoxBorland(self).FDataList do begin
      Color:=FStoreColor;
      Self.HeadColor:=FStoreHeadColor;
    end;
end;

{ Lev 17.04.99 The Begin  }
procedure XEDBSetIsContextOpen(Self: TEtvCustomDBLookupCombo; AValue: Boolean;
                               var FIsContextOpen: Boolean; FStoreColor, FStoreHeadColor: TColor;
                               FStoreDataSet: TDataSet);
var LC:TDBLookupControlBorland;
    OldTag: Integer;
    LS: TLinkSource;
begin
  LC:=TDBLookupControlBorland(Self);
  if (FIsContextOpen<>AValue) and Assigned(FStoreDataSet) then
    try
    {with LC.FDataField do}
      if AValue then begin
        if FStoreDataSet is TLinkQuery then
          LS:=TLinkQuery(FStoreDataSet).LinkSource
        else LS:=TLinkTable(FStoreDataSet).LinkSource;
        if LC.FLookUpMode then begin
          // Для исключения лишней работы в обработчиках конкретных DataSet'ов
          OldTag:=LC.FDataField.DataSet.Tag;
          LC.FDataField.DataSet.Tag:=99;
          //
          LC.FDataField.DataSet.DisableControls;
          TFieldBorland(LC.FDataField).FLookupDataSet:=LS.LikeQuery;
        end else LC.FlistLink.DataSource.DataSet:=LS.LikeQuery;
        if LC.FLookUpMode then XEDBChangeDataField(Self, LC.FDataField);
        Self.Color:=clLime or clSilver;
        TDBLookupComboBoxBorland(self).FDataList.Color:=clLime or clSilver;
        if Assigned(Self.Field) and (Self.Field is TEtvLookField) then
          TEtvLookField(Self.Field).HeadColor:=clYellow
        else Self.HeadColor:=clYellow;
        {Self.Field.HeadColor:=clYellow;}
        // После закрытия по таймеру всех таблиц надо открыть Query
        if not LS.LikeQuery.Active then LS.LikeQuery.Open;
        Self.HeadLineStr:='Выборка по "'+LS.LikePatterns[0]+'" - '+IntToStr(LS.LikeQuery.RecordCount)+' записей';
(*
        if LC.FlookUpMode then LC.FDataField.DataSet.EnableControls;
        FIsContextOpen:=True;
*)
      end else begin
        if LC.FLookUpMode then begin
          // Для исключения лишней работы в обработчиках конкретных DataSet'ов
          OldTag:=LC.FDataField.DataSet.Tag;
          LC.FDataField.DataSet.Tag:=99;
          //
          LC.FDataField.DataSet.DisableControls;
          TFieldBorland(LC.FDataField).FLookupDataSet:=FStoreDataSet;
        end else LC.FlistLink.DataSource.DataSet:=FStoreDataSet;
        if LC.FLookUpMode then XEDBChangeDataField(Self,LC.FDataField);

        LC.FListLink.DataSet.Locate(LC.FListField.FieldName,TDBLookupComboBoxBorland(self).
          FDataList.KeyValue, [loCaseInsensitive, loPartialKey]);
        Self.HeadLineStr:='';

        if Assigned(Self.Field) and (Self.Field is TEtvLookField) then
          TEtvLookField(Self.Field).HeadColor:=FStoreHeadColor
        else Self.HeadColor:=FStoreHeadColor;

        Self.Color:=FStoreColor;
(*
        if LC.FlookUpMode then LC.FDataField.DataSet.EnableControls;
        FIsContextOpen:=False;
*)
      end;
    finally
      if LC.FlookUpMode then begin
        LC.FDataField.DataSet.EnableControls;
        // Для исключения лишней работы в обработчиках конкретных DataSet'ов
        LC.FDataField.DataSet.Tag:=OldTag;
      end;
      FIsContextOpen:=aValue;
   end;
end;
{ Lev 17.04.99 The End }

Procedure XEDBContextUse(Self: TEtvCustomDBLookupCombo;
                         var FIsContextOpen: Boolean; FStoreColor, FStoreHeadColor: TColor;
                         FStoreDataSet: TDataSet);
begin
  XEDBSetIsContextOpen(Self, Not FIsContextOpen, FIsContextOpen, FStoreColor,
                       FStoreHeadColor, FStoreDataSet);
end;

{ Lev 17.04.99 The Begin }
Procedure XEDBContextCreate(Self: TEtvCustomDBLookupCombo; Const AStr:String;
                            var FIsContextOpen: Boolean; FStoreColor,
                            FStoreHeadColor: TColor; var FStoreDataSet: TDataSet);
var
  LinkSet: TLinkSource;
  LC:TDBLookupControlBorland;
  LDataSet: TDataSet;   { LookUpDataSet }
  LResultField: String; { LookUpResultField }
  OldTag: integer;
begin
  LC:=TDBLookupControlBorland(Self);
  if not((Assigned(LC.FDataField) and LC.FDataField.Lookup) or
  (Assigned(LC.FlistLink.DataSource) and (LC.FListFieldName<>'') and
  (LC.FKeyFieldName<>''))) then Exit;
  { Инициализация LookupDataSet'а и LookUpResultField'ов }
  if LC.FLookupMode then begin
    LDataSet:=LC.FDataField.LookUpDataSet;
    {LResultField:=TEtvLookField(LC.FDataField).LookUpResultField;}
    LResultField:=LC.FDataField.LookUpResultField;
    if TEtvLookField(Self.Field).LookupFilterField<>'' then
      LResultField:=LResultField+';'+TEtvLookField(Self.Field).LookupFilterField;
  end else begin
    LDataSet:=LC.FListLink.DataSource.DataSet;
    LResultField:=LC.FListFieldName;
  end;
  if FIsContextOpen then
    if FStoreDataSet is TLinkQuery then
      LinkSet:=TLinkQuery(FStoreDataSet).LinkSource
    else LinkSet:=TLinkTable(FStoreDataSet).LinkSource
  else
    if LDataSet is TLinkQuery then
      LinkSet:=TLinkQuery(LDataSet).LinkSource
    else LinkSet:=TLinkTable(LDataSet).LinkSource;
  if Assigned(LinkSet) then {with LC.FDataField do} begin
    LinkSet.CreateLikeQuery(LDataSet);
    if LC.FLookUpMode then begin
      OldTag:=LC.FDataField.DataSet.Tag;
      LC.FDataField.DataSet.Tag:=99;
      LC.FDataField.DataSet.DisableControls;
    end;
    if not FIsContextOpen then FStoreDataSet:=LDataSet;
    if LinkSet.ChangeLikeQuery(FStoreDataSet, LResultField, AStr) then FIsContextOpen:=False;
    XEDBContextUse(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
    if LC.FLookUpMode then begin
      LC.FDataField.DataSet.EnableControls;
      LC.FDataField.DataSet.Tag:=OldTag;
    end;
  end;
end;
{ Lev 17.04.99 The End }

Procedure XEDBContextInit(Self: TEtvCustomDBLookupCombo;
                          var FIsContextOpen: Boolean; FStoreColor,
                          FStoreHeadColor: TColor; FStoreDataSet: TDataSet);
begin
  Self.Color:=FStoreColor;
  Self.HeadColor:=FStoreHeadColor;
  XEDBSetIsContextOpen(Self, False, FIsContextOpen, FStoreColor,
                       FStoreHeadColor, FStoreDataSet);
end;

type
  TXEPopupDataList = class(TEtvPopupDataList)
  end;

Function XEDBNotContextSearchKey(Self: TEtvCustomDBLookupCombo;
           var Key: Char; var FIsContextOpen{, Flag}: Boolean; FStoreColor, FStoreHeadColor: TColor;
           var FStoreDataSet: TDataSet): boolean;
var s:string;
    aSearchOptions: TLocateOptions;
    aFSearchTextOfDataList: String;
begin
  Result:=True;
  if Self.ListVisible then
    with Self, TDBLookupControlBorland(Self) do
      {TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList)}
      if (FListField<>nil) and (FListField.FieldKind=fkData) and
      ((FListField.DataType=ftString) or
      ((FListField.DataType in [ftInteger,ftSmallInt,ftAutoInc]) and
      (Key in [{Char(VK_Back),}#0,#27,'0'..'9']))) then {Lev 30/04/97}
        case Key of
          #27:
            if FIsContextOpen then begin
              XEDBContextInit(Self,FIsContextOpen,FStoreColor,FStoreHeadColor,FStoreDataSet);
              Invalidate;
              Result:=False;
            end;
(*
          #27: FSearchText := '';
          Char(VK_Back):
            begin
              S:=FSearchText;
              Delete(S,Length(S),1);
              TDBLookupControlBorland(self).FSearchText:=S;
              TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList).FSearchText:=S;
              Invalidate;
              Result:=False;
            end;
*)
          #0,#8,#32..#255:
            if FListActive and not ReadOnly and ((FDataLink.DataSource = nil) or
            (FMasterField<>nil) and FMasterField.CanModify) then begin
              aFSearchTextOfDataList:=TDBLookupControlBorland(TDBLookupComboBoxBorland(Self).FDataList).FSearchText;
              if Length(FSearchText)<32 then begin
                if Key=#8 then
                  S:=Copy(aFSearchTextOfDataList,1,Length(aFSearchTextOfDataList)-1)
                else begin
                  S:=aFSearchTextOfDataList;
                  if Key<>#0 then S:=S+Key
                end;
                {S:=AnsiUpperCase(S);}
                if Length(aFSearchTextOfDataList)=0 then aSearchOptions:=[loPartialKey{, loCaseInsensitive}]
                else aSearchOptions:=[loPartialKey{, loCaseInsensitive}];
                if (Key=#0) and (S<>'') and FListLink.DataSet.Locate(FListField.FieldName,S,aSearchOptions) then begin
                  // Меняем первую букву на Заглавную или наобоброт, что первое нашли...
                  if Key<>#8 then
                    S:=Copy(FListField.AsString,1,Length(aFSearchTextOfDataList){+1});
                  {TXEDBLookupCombo(Self).SelectKeyValue(FKeyField.Value);}
                  TXEPopupDataList(TDBLookupComboBoxBorland(Self).FDataList).SelectCurrent;
                  {SelectKeyValue(FKeyField.Value);}
{                 FSearchText := S;
                  TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList).FSearchText:=S;}
                end;
                if FListField.DataType in [ftInteger, ftSmallInt, ftAutoInc] then
                  if Length(FSearchText)<8 then begin
{                   FSearchText := S;}
                    TDBLookupControlBorland(TDBLookupComboBoxBorland(Self).FDataList).FSearchText:=S;
                  end else
                else begin
                  FSearchText:=S;
                  TDBLookupControlBorland(TDBLookupComboBoxBorland(Self).FDataList).FSearchText:=S;
                end;
                Invalidate;
                Result:=False;
              end;
            end;
        end; { case }
end;

Procedure XEDBSetContextKey(Self: TEtvCustomDBLookupCombo;
            var FIsContextOpen: Boolean; FStoreColor, FStoreHeadColor: TColor;
            var FStoreDataSet: TDataSet);
begin
  if Self.ListVisible then with Self, TDBLookupControlBorland(self) do
    if (FListField<>nil) and (FListField.FieldKind=fkData) then begin
      if TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList).FSearchText<>'' then
        XEDBContextCreate(Self, TDBLookupControlBorland(TDBLookupComboBoxBorland(Self).
          FDataList).FSearchText, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet)
      else begin
        XEDBContextUse(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
        if FIsContextOpen then begin
          if FStoreDataSet is TLinkQuery then
            TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList).FSearchText:=
              TLinkQuery(FStoreDataSet).LinkSource.LikePatterns[0]
          else
            TDBLookupControlBorland(TDBLookupComboBoxBorland(self).FDataList).FSearchText:=
              TLinkTable(FStoreDataSet).LinkSource.LikePatterns[0];
        end;
      end;
      Invalidate;
    end;
end;

{ TXEDBLookupCombo }

Constructor TXEDBLookupCombo.Create(AOwner: TComponent);
begin
  Inherited;
  FStoreDataSet:=nil;
  FIsContextOpen:=False;
  FStoreColor:=Color;
  EtvLookTimer.OnTimer:=XOnTimer;
  EtvLookTimer.Interval:=1;
  {FStoreHeadColor:=HeadColor;}
end;

Procedure TXEDBLookupCombo.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
  FStoreColor:=Color;
  {FStoreHeadColor:=HeadColor;}
end;

Procedure TXEDBLookupCombo.Paint;
begin
  XEDBPaint(Self, FIsContextOpen, FStoreColor, FStoreHeadColor);
  Inherited Paint;
end;

Procedure TXEDBLookupCombo.XOnTimer(Sender: TObject);
var aKey:Char;
begin
  Inc(aTick);
  if aTick>0 then begin
    try
      {Вызов функции поиска в Lookup'е}
      aKey:=#0;
      KeyPress(aKey);
    finally
      EtvLookTimer.Enabled:=false;
      aTick:=0;
    end;
  end;
end;

Procedure TXEDBLookupCombo.KeyPress(var Key: Char);
begin
  if XEDBNotContextSearchKey(Self, Key, FIsContextOpen,
                                   FStoreColor, FStoreHeadColor, FStoreDataSet) then
  Inherited KeyPress(Key);
  if Self.ListVisible then begin
    EtvLookTimer.Enabled := false ;
    EtvLookTimer.Enabled := true ;
  end;
end;

Function XEDBSystemLookup: Boolean;
begin
  if TXEDBLookupCombo(SystemMenuItemObject).ListVisible then
    with TXEDBLookupCombo(SystemMenuItemObject) do begin
      XEDBSetContextKey(TXEDBLookupCombo(SystemMenuItemObject), FIsContextOpen,
        FStoreColor, FStoreHeadColor, FStoreDataSet);
      Result:=True;
    end else Result:=False;
end;

Procedure SetOpenReturnControl(AField: TField; ADataSource: TDataSource; AOwner: TComponent);
var LinkSet{, FormLinkSet}: TLinkSource;
    DBF1: TDBFormControl;
begin
  if Assigned(AField) then begin
    if AField.LookupDataSet is TLinkQuery then LinkSet:=TLinkQuery(AField.LookupDataSet).LinkSource;
    if AField.LookupDataSet is TLinkTable then LinkSet:=TLinkTable(AField.LookupDataSet).LinkSource;
    {if (ADataSource is TLinkSource) then FormLinkSet:=TLinkSource(ADataSource)
    else FormLinkSet:=nil;}
    if Assigned(LinkSet) then begin
{     if Assigned(FormLinkSet) then begin
      FormLinkSet.IsCheckPostedMode:=False;
      end;}
{!}
{     XNotifySelect.GoSpellSelect(LinkSet,xeSetParams, AField, AOwner, opInsert);}
      if (AOwner is TXForm) and (TXForm(AOwner).FormControl is TDBFormControl) then begin
        DBF1:= GetLinkedDBFormControl(LinkSet);
        if Assigned(DBF1) then begin
          DBF1.SelectedField:= AField;
          DBF1.ReturnForm:= TForm(AOwner);
          TDBFormControl(TXForm(AOwner).FormControl).OpenReturnControl:= DBF1;
        end;
      end;
{!}
(*
        if (XNotifySelect.SpellEvent=xeNone) and (AOwner is TXForm) then with TXForm(AOwner) do
{           if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
              TFormControl(XFormLink.LinkControl).OpenReturnControl:=TFormControl(XNotifySelect.SpellSelect);}
           if Assigned(FormControl) then
              TFormControl(FormControl).OpenReturnControl:=TFormControl(XNotifySelect.SpellSelect);
*)
    end;
  end;
end;

Procedure ClearOpenReturnControl(AOwner: TComponent);
begin
  if AOwner is TXForm then with TXForm(AOwner) do
{     if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
        TFormControl(XFormLink.LinkControl).OpenReturnControl:=Nil;}
  if Assigned(FormControl) then TFormControl(FormControl).OpenReturnControl:=nil;
end;

Procedure TXEDBLookupCombo.WMSetFocus(var Message: TWMSetFocus);
var LinkSet, FormLinkSet: TLinkSource;
    ADataSet: TDataSet;
    AField: TField;
    DBF1: TDBFormControl;
begin
  Inherited;
  FStoreColor:=Color;
  FStoreHeadColor:=GetHeadColor;
  SystemMenuItemObject:=Self;
  SystemMenuItemProc:=XEDBSystemLookup;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
  if Assigned(TDBLookupControlBorland(Self).FDataField) then
    if TDBLookupControlBorland(Self).FDataField.Lookup then begin
      if (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkQuery) then
        LinkSet:=TLinkQuery(TDBLookupControlBorland(Self).FDataField.LookupDataSet).LinkSource;
      if (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkTable) then
        LinkSet:=TLinkTable(TDBLookupControlBorland(Self).FDataField.LookupDataSet).LinkSource;
      if Assigned(LinkSet) then begin
{!
        XNotifySelect.GoSpellSelect(LinkSet,xeSetParams,TDBLookupControlBorland(Self).FDataField,
                                       Owner, opRemove);
}
{!}
        DBF1:= GetLinkedDBFormControl(LinkSet);
        if Assigned(DBF1) and (DBF1.ReturnForm=Owner) then begin
          LinkSet.IsSetReturn:= False;
          DBF1.ReturnForm:=nil;
          if LinkSet.IsReturnValue then begin
            LinkSet.IsReturnValue:=False;
            ADataSet:=TDBLookupControlBorland(Self).FDataField.LookupDataSet;
            if IsLinkDataSet(ADataSet) then begin
              if ADataSet is TLinkQuery then
                AField:=TLinkQuery(ADataSet).LinkSource.Declar.FindField(
                  TDBLookupControlBorland(Self).FDataField.LookupKeyFields)
              else
                AField:=TLinkTable(ADataSet).LinkSource.Declar.FindField(
                  TDBLookupControlBorland(Self).FDataField.LookupKeyFields);
              SelectKeyValue(AField.Value);
            end;
            if (DataSource is TLinkSource) then FormLinkSet:=TLinkSource(DataSource)
            else FormLinkSet:=nil;
            if Assigned(FormLinkSet) then begin
              FormLinkSet.PostChecked:=True;
            end;
          end;
        end;

      end;
    end;
  SetOpenReturnControl(TDBLookupControlBorland(Self).FDataField, DataSource, Owner);
end;

{ Lev. Time Of Correction 18.04.99 The Begin }
Procedure TXEDBLookupCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  if (Assigned(TDBLookupControlBorland(Self).FDataField) or
  (Assigned(TDBLookupControlBorland(Self).FlistLink.DataSource) and
  (TDBLookupControlBorland(Self).FListFieldName<>'') and
  (TDBLookupControlBorland(Self).FKeyFieldName<>''))) and FIsContextOpen then
    XEDBContextInit(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
  ClearOpenReturnControl(Owner);
  SystemMenuItemObject:=nil;
  SystemMenuItemProc:=nil;
  Inherited;
end;

{ Lev. Time Of Correction 18.04.99 The Begin }
Procedure TXEDBLookupCombo.KeyDown(var Key: Word; Shift: TShiftState);
var Priz1: Boolean;
    LC:TDBLookupControlBorland;
    OldTag: integer;
    LDataSet: TDataSet;   { LookUpDataSet }
    LResultField: String; { LookUpResultField }
begin
  case Key of
    Word('F'):
      if (ssCtrl in Shift) then begin
        Key:=0;
        XEDBSetContextKey(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
      end;
{
    Word('S'):
      if (ssCtrl in Shift) and TDBLookupControlBorland(Self).FDataField.Lookup and
      (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkQuery) then begin
        Key:=0;
        if Owner is TXForm then with TXForm(Owner) do
          if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
            if Assigned(TFormControl(XFormLink.LinkControl).OpenReturnControl) then
              TFormControl(XFormLink.LinkControl).OpenReturnControl.ReturnExecute;
      end;
}
(*  Бред Льва Михайловича
    Word('S'):
      if (ssShift in Shift) {True} then begin
        Key:=0;
        with TDBFormControl(TXForm(Screen.ActiveForm).FormControl) do
          with TToolsForm(FormTools.Tools.ToolsForm) do
            if ReturnOpenBtn.Enabled then begin
              ReturnSubOpen;
              SubSetFocus;
            end;
                   {FormTools.Tools.SubClick(TToolsForm(FormTools.Tools.ToolsForm).ReturnOpenBtn);}
                 {OpenReturnControl.ReturnExecute;}
      end;
*)
    Word('Z'):
      if (ssCtrl in Shift) then
        if not (ssShift in Shift) then Key:= 0
        else
        try
          LC:=TDBLookupControlBorland(Self);
          { Инициализация LookupDataSet'а и LookUpResultField'ов }
          if LC.FLookupMode then begin
            LDataSet:=LC.FDataField.LookUpDataSet;
            LResultField:=TEtvLookField(LC.FDataField).LookUpResultField;
          end else begin
            LDataSet:=LC.FListLink.DataSource.DataSet;
            LResultField:=LC.FListFieldName;
          end;
          // Для исключения лишней работы в обработчиках конкретных DataSet'ов
          if Assigned(Self.DataSource) then begin
            OldTag:=Self.DataSource.DataSet.Tag;
            Self.DataSource.DataSet.Tag:=99;
          end;
          if (Assigned(LC.FDataField) and LC.FDataField.Lookup and
          not(foAutoDropDownWidth in TEtvLookField(LC.FDataField).Options)) or
          (Assigned(LC.FlistLink.DataSource) and (LC.FListFieldName<>'') and
          (LC.FKeyFieldName<>'')) and IsLinkDataSet(LDataSet) then begin
            Key:=0;
            Cursor:=crHourGlass;
            Priz1:= ListVisible;
            if Priz1 then CloseUp(False);
            ChangeLookQueryField(LC.FDataField,LC,LDataSet,LResultField);
            if Assigned(LC.FDataField) then XEDBChangeDataField(Self, LC.FDataField);
            DoEnter;
            LC.SetFocus;
            if Priz1 then DropDown;
            Cursor:=crDefault;
          end;
        finally
          if Assigned(Self.DataSource) then Self.DataSource.DataSet.Tag:=OldTag;
        end;
  end;
  Inherited KeyDown(Key, Shift);
end;
{ Lev. Time of Correction 18.04.99 The End }

Procedure TXEDBLookupCombo.KeyUp(var Key: Word; Shift: TShiftState);
begin
(*
  Inherited;
  case Key of
    Word('S'):
      if (ssCtrl in Shift) {True} then begin
        Key:=0;
        with TDBFormControl(TXForm(Screen.ActiveForm).FormControl) do
          with TToolsForm(FormTools.Tools.ToolsForm) do
            if ReturnOpenBtn.Enabled then begin
              ReturnSubOpen;
              SubSetFocus;
            end;
      end;
  end;
*)
end;

Procedure TXEDBLookupCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeIsLookField:
        begin
          if TDBLookupControlBorland(Self).FDataField is TEtvLookField then
            TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetSource:
        begin
          if (not Assigned(ListSource)) and (not Assigned(DataSource)) then
            ListSource:=TDataSource(TXNotifyEvent(AComponent).SpellChild);
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetParams:
        begin
          if Operation=opInsert then begin
            ListField:=TLnTable(TXNotifyEvent(AComponent).SpellChild).IndexFieldNames;
            KeyField:=TLnTable(TXNotifyEvent(AComponent).SpellChild).IndexFieldNames;
            DropDown;
          end;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource) and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
    end
  else Inherited Notification(AComponent, Operation);
end;

{TXEDBInplaceLookupCombo}

Constructor TXEDBInplaceLookupCombo.Create(AOwner: TComponent);
begin
  Inherited;
  FStoreDataSet:=nil;
  FIsContextOpen:=False;
  FStoreColor:=Color;
  FStoreHeadColor:=HeadColor;
  EtvLookTimer.OnTimer:=XOnTimer;
  EtvLookTimer.Interval:=1;
end;

Procedure TXEDBInplaceLookupCombo.XOnTimer(Sender: TObject);
var aKey:Char;
begin
  Inc(aTick);
  if aTick>0 then begin
    try
      {Вызов функции поиска в Lookup'е}
      aKey:=#0;
      KeyPress(aKey);
    finally
      EtvLookTimer.Enabled:=false;
      aTick:=0;
    end;
  end;
end;

Procedure TXEDBInplaceLookupCombo.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
  FStoreColor:=Color;
  {FStoreHeadColor:=HeadColor;}
end;

Procedure TXEDBInplaceLookupCombo.Paint;
begin
  XEDBPaint(Self, FIsContextOpen, FStoreColor, FStoreHeadColor);
  Inherited Paint;
end;

Procedure TXEDBInplaceLookupCombo.KeyPress(var Key: Char);
begin
  if XEDBNotContextSearchKey(Self, Key, FIsContextOpen,
                                 FStoreColor, FStoreHeadColor, FStoreDataSet) then
    Inherited KeyPress(Key);
  if Self.ListVisible then begin
    EtvLookTimer.Enabled := false ;
    EtvLookTimer.Enabled := true ;
  end;
end;

Function XEDBSystemLookupInplace: Boolean;
begin
  if TXEDBInplaceLookupCombo(SystemMenuItemObject).ListVisible then
    with TXEDBInplaceLookupCombo(SystemMenuItemObject) do begin
      SetHideFlag(False);
      XEDBSetContextKey(TXEDBInplaceLookupCombo(SystemMenuItemObject), FIsContextOpen,
        FStoreColor, FStoreHeadColor, FStoreDataSet);
      SetHideFlag(True);
      Result:=True;
    end else Result:=False;
end;

Procedure TXEDBInplaceLookupCombo.WMSetFocus(var Message: TWMSetFocus);
var LinkSet, FormLinkSet: TLinkSource;
    ADataSet: TDataSet;
    AField: TField;
    DBF1: TDBFOrmControl;
begin
  Inherited;
  SystemMenuItemObject:=Self;
  SystemMenuItemProc:=XEDBSystemLookupInplace;
  if Assigned(TDBLookupControlBorland(Self).FDataField) then begin
    if TDBLookupControlBorland(Self).FDataField.Lookup then begin
      if (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkQuery) then
        LinkSet:=TLinkQuery(TDBLookupControlBorland(Self).FDataField.LookupDataSet).LinkSource;
      if (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkTable) then
        LinkSet:=TLinkTable(TDBLookupControlBorland(Self).FDataField.LookupDataSet).LinkSource;
      if Assigned(LinkSet) then begin
{          XNotifySelect.GoSpellSelect(LinkSet,xeSetParams,TDBLookupControlBorland(Self).FDataField,
                                       Owner, opRemove);}
        DBF1:= GetLinkedDBFormControl(LinkSet);
        if Assigned(DBF1) and (DBF1.ReturnForm=Owner) then begin
          LinkSet.IsSetReturn:= False;
          DBF1.ReturnForm:=nil;
          if LinkSet.IsReturnValue then begin
            LinkSet.IsReturnValue:=False;
            ADataSet:=TDBLookupControlBorland(Self).FDataField.LookupDataSet;
            if IsLinkDataSet(ADataSet) then begin
              if ADataSet is TLinkQuery then
                AField:=TLinkQuery(ADataSet).LinkSource.Declar.FindField(
                  TDBLookupControlBorland(Self).FDataField.LookupKeyFields)
              else
                AField:=TLinkTable(ADataSet).LinkSource.Declar.FindField(
                  TDBLookupControlBorland(Self).FDataField.LookupKeyFields);
              SelectKeyValue(AField.Value);
            end;
            if (DataSource is TLinkSource) then FormLinkSet:=TLinkSource(DataSource)
            else FormLinkSet:=nil;
            if Assigned(FormLinkSet) then begin
              FormLinkSet.PostChecked:=True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

Procedure TXEDBInplaceLookupCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  if Assigned(TDBLookupControlBorland(Self).FDataField) then
    XEDBContextInit(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
  SystemMenuItemObject:=nil;
  SystemMenuItemProc:=nil;
  Visible:=false;
  Inherited;
end;

Procedure TXEDBInplaceLookupCombo.SetHideFlag(Value: Boolean);
begin
  TXEDBGrid(Lookup).EtvAutoHide:=Value;
end;

Procedure TXEDBInplaceLookupCombo.KeyDown(var Key: Word; Shift: TShiftState);
var Priz1: Boolean;
    LC:TDBLookupControlBorland;
begin
  case Key of
    Word('F'),VK_RETURN:
      if ((ssCtrl in Shift) and (Key=Word('F'))) or ((Key=VK_Return) and (FIsContextOpen=true))  then begin
        Key:=0;
        SetHideFlag(False);
        XEDBSetContextKey(Self, FIsContextOpen, FStoreColor, FStoreHeadColor, FStoreDataSet);
        SetHideFlag(True);
      end;
{
    Word('S'): if (ssCtrl in Shift) and
        TDBLookupControlBorland(Self).FDataField.Lookup and
        (TDBLookupControlBorland(Self).FDataField.LookupDataSet is TLinkQuery)
        then begin
        Key:=0;
        if Owner is TXForm then with TXForm(Owner) do
           if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
              if Assigned(TFormControl(XFormLink.LinkControl).OpenReturnControl) then
                 TFormControl(XFormLink.LinkControl).OpenReturnControl.ReturnExecute;
        end;
        }
    Word('Z'):
      if (ssCtrl in Shift) then
        if not (ssShift in Shift) then Key:= 0
        else begin
          LC:=TDBLookupControlBorland(Self);
          if LC.FDataField.Lookup and IsLinkDataSet(LC.FDataField.LookupDataSet) {and
          (not (foAutoDropDownWidth in TEtvLookField(LC.FDataField).Options))} then begin
            Key:=0;
            SetHideFlag(False);
            Cursor:=crHourGlass;
            Priz1:= ListVisible;
            // Меняем значение Tag=Word('Z'), для дальнейшей обработки
            Tag:=Word('Z');
            if Priz1 then CloseUp(False);
            if Tag<>0 then Tag:=0;
            ChangeLookQueryField(LC.FDataField,nil,
              LC.FDataField.LookUpDataSet,TEtvLookField(Self.Field).LookupResultField);
            XEDBChangeDataField(Self, LC.FDataField);
            DoEnter;
            LC.SetFocus;
            if Priz1 then DropDown;
            Cursor:=crDefault;
            SetHideFlag(True);
          end;
        end;
  end;
  Inherited KeyDown(Key, Shift);
end;

{ TXEDbGrid }

Constructor TXEDBGrid.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FStoredDataSource:=nil;
  FStoredControlSource:=nil;
  FStoredColumn:= 0;
  FIsStoredDataSource:= False;
  MarkGridFontColor:=clPurple;
  GridAcceptKey:=true;
end;

procedure TXEDBGrid.SetDefaultGridColor(Sender: TObject; Field: TField; var Color: TColor);
Const MaxChars=70;
var aCharBuffer: array[0..MaxChars] of Char;
    i: integer;
begin
  {FillChar(aCharBuffer,MaxChars,#0);}
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxChars);
  {Заменяем символ #0 на пробел }
  for i:=0 to MaxChars do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i],32);
  if Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0 then Color:=$00B4FEFE
    else if Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0 then Color:=$00D5FFFE
      else if Pos('+ ',aCharBuffer)>0 then Color:=$00D2F2F7//$00F4F5D8
        else Color:=TXEDBGrid(Sender).Color;
  {if Copy(ClientBuildingGrodnoRealDeclarClientName.AsString,1,5)='Всего' then Color:=$00D5FFFE;}
  // $00FFF8E6; //$00CCEACC;//$00C6FDD8;//$00C6CDFD;//$00A0CD8F;//$00C6DDA4
end;

procedure TXEDBGrid.SetDefaultGridFont(Sender: TObject; Field: TField; Font: TFont);
Const MaxChars=255;
var aCharBuffer: array[0..MaxChars] of Char;
    i: byte;
begin
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxChars);
  {Заменяем символ #0 на пробел }
  for i:=0 to MaxChars do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i],32);
  if (Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0) or (Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0) then begin
    Font.Style:=[fsBold];
    Font.Color:=MarkGridFontColor;
  end
end;

Procedure TXEDBGrid.FormatColumns(AsInDataBase: boolean);
var i,j:integer;
begin
  if Assigned(DataSource) then begin
    SetMinLengthFieldsByDataSet(TDBDataSet(DataSource.DataSet),AsInDataBase);
    { Корректировка ширины столбцов с учетом итоговой строки }
    if Assigned(fListTotal) then
      for i:=0 to ListTotal.Count-1 do
        for j:=0 to Columns.Count-1 do
          if (AnsiUpperCase(Columns[j].FieldName)=AnsiUpperCase(
          TItemTotal(ListTotal[i]).FieldName)) and (TItemTotal(ListTotal[i]).Value<>'')
          and (Length(TItemTotal(ListTotal[i]).Value)>Columns[j].Field.DisplayWidth) then
            Columns[j].Field.DisplayWidth:=Length(TItemTotal(ListTotal[i]).Value);
  end;
  {for i:=0 to Columns.Count-1 do Columns[i].Visible:=Columns[i].Field.Visible;}
  Columns.RebuildColumns;
  i:=Columns.Count-1;
  while i>=0 do begin
    if Assigned(Columns[i].Field) and not Columns[i].Field.Visible then Columns[i].Destroy;
    Dec(i)
  end;
end;

Procedure TXEDBGrid.WMSetFocus(var Message: TWMSetFocus);
var LinkSet, FormLinkSet: TLinkSource;
    ADataSet: TDataSet;
    AField: TField;
    DBF1: TDBFormControl;
begin
  Inherited;
  HideEditor;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
  if Assigned(Columns[SelectedIndex].Field) then begin
    if (IsEtvField=efLookup) then begin
      if (Columns[SelectedIndex].Field.LookupDataSet is TLinkQuery) then
        LinkSet:=TLinkQuery(Columns[SelectedIndex].Field.LookupDataSet).LinkSource;
      if (Columns[SelectedIndex].Field.LookupDataSet is TLinkTable) then
        LinkSet:=TLinkTable(Columns[SelectedIndex].Field.LookupDataSet).LinkSource;
      if Assigned(LinkSet) then begin
{       XNotifySelect.GoSpellSelect(LinkSet,xeSetParams,Columns[SelectedIndex].Field,
                                       Owner, opRemove);}
        DBF1:= GetLinkedDBFormControl(LinkSet);
        if Assigned(DBF1) and (DBF1.ReturnForm=Owner) then begin
          LinkSet.IsSetReturn:= False;
          DBF1.ReturnForm:=nil;
          if LinkSet.IsReturnValue then begin
            LinkSet.IsReturnValue:=False;
            ADataSet:=Columns[SelectedIndex].Field.LookupDataSet;
            if IsLinkDataSet(ADataSet) then begin
              if ADataSet is TLinkQuery then
                AField:=TLinkQuery(ADataSet).LinkSource.Declar.FindField(
                  Columns[SelectedIndex].Field.LookupKeyFields)
              else
                AField:=TLinkTable(ADataSet).LinkSource.Declar.FindField(
                  Columns[SelectedIndex].Field.LookupKeyFields);
              if DataLink.Edit then
                DataSource.DataSet.FindField(
                  Columns[SelectedIndex].Field.KeyFields).Value:=AField.Value;
            end;
            if (DataSource is TLinkSource) then FormLinkSet:=TLinkSource(DataSource)
            else FormLinkSet:=nil;
            if Assigned(FormLinkSet) then FormLinkSet.PostChecked:=True;
          end;
        end;
      end;
    end;
  end;
  if IsEtvField=efLookup then
    SetOpenReturnControl(Columns[SelectedIndex].Field, DataSource, Owner);
end;

Procedure TXEDBGrid.WMKillFocus(var Message: TWMKillFocus);
begin
  Inherited;
end;

Procedure TXEDBGrid.ColEnter;
var Priz: Boolean;
begin
  Priz:=IsEtvField=efLookup;
  Inherited;
  if (IsEtvField=efLookup) or Priz then begin
    XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
    if IsEtvField=efLookup then
      SetOpenReturnControl(Columns[SelectedIndex].Field, DataSource, Owner)
    else ClearOpenReturnControl(Owner);
  end;
end;

procedure TXEDBGrid.Notification(AComponent: TComponent; Operation: TOperation);
var aTotals: TStringList;
    i: Integer;
begin
(*** TEST!!!   Writeln(FFFF,'TXEDBGrid.Notification #1 :',AComponent.Name); ***)
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeSumExecute:
        {if TLinkSource(DataSource).IsDeclar then }
        begin
          if Operation=opInsert then begin
            ListTotal.ClearFull;
{!          TLinkSource(DataSource).LinkMaster.Calc.Dataset:= DataSource.Dataset;}
            TAggregateLink(TXNotifyEvent(AComponent).SpellChild).Calc.Dataset:= DataSource.Dataset;
            aTotals:=CalcFieldTotals(DataSource.DataSet, TLinkSource(DataSource).TableName,
                       TLinkSource(DataSource).DatabaseName{'AO_GKSM_InProgram'},
                       TAggregateLink(TXNotifyEvent(AComponent).SpellChild).Calc.SumCalc
{                          TLinkSource(DataSource).DeclarLink.Calc.SumCalc}
                          {TLinkSource(DataSource).LinkMaster.Calc.SumCalc});
            if Assigned(aTotals) then begin // Ситуация при вставке записи в MasterTable Lev 03.05.2010
              for i:=0 to aTotals.Count-1 do
                SetItemTotal(TField(aTotals.Objects[i]).FieldName, aTotals[i]);
              Total:= True;
              aTotals.Free;
            end else Total:=false;
          end else Total:= False;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeIsLookField:
        begin
          if IsEtvField=efLookup then TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeSetSource:
        begin
          if not Assigned(DataSource) then begin
            DataSource:=TDataSource(TXNotifyEvent(AComponent).SpellChild);
            if Assigned(DataSource.DataSet) then
              DataSource.DataSet.Active:=(Operation=opInsert) and TLinkSource(DataSource).Active;
            end;
            TXNotifyEvent(AComponent).SpellEvent:=xeNone;
          end;
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource)and
        (DataSource = TXNotifyEvent(AComponent).SpellChild) then begin
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
    end
  else Inherited;
(*** TEST!!! Writeln(FFFF,'TXEDBGrid.Notification #2 :',AComponent.Name); ***)
end;

Function TXEDBGrid.GetDataSource: TDataSource;
begin
  if FIsStoredDataSource then Result:=FStoredDataSource
  else Result:=Inherited DataSource;
end;

Procedure TXEDBGrid.SetDataSource(Value: TDataSource);
begin
  if FIsStoredDataSource then FStoredDataSource:=Value
  else Inherited DataSource:=Value;
end;

Procedure TXEDBGrid.ReadIsDataSource(Reader: TReader);
begin
  FIsStoredDataSource:=Reader.ReadBoolean;
end;

Procedure TXEDBGrid.WriteIsDataSource(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsStoredDataSource);
end;

Function TXEDBGrid.CreateInplaceLookupCombo:TEtvInplaceLookupCombo;
begin
  Result:=TXEDBInplaceLookupCombo.Create(Self);
end;

Procedure TXEDBGrid.ReadDataSource(Reader: TReader);
begin
  Reader.ReadIdent;
end;

Procedure TXEDBGrid.WriteDataSource(Writer: TWriter);
var S: String;
begin
  if DataSource.Owner<>Owner then S:=DataSource.Owner.Name+'.' else S:='';
  Writer.WriteIdent(S+DataSource.Name);
end;

Procedure TXEDBGrid.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('IsStoredDataSource', ReadIsDataSource, WriteIsDataSource, True{FIsStoredDataSource});
  Filer.DefineProperty('DataSource', ReadDataSource, WriteDataSource, Assigned(DataSource));
  Inherited;
end;

Procedure TXEDBGrid.WMChangePageSource(var Msg: TMessage);
begin
  if Msg.WParam=0 then begin
    if not Assigned(FStoredDataSource) then begin
      FStoredDataSource:=DataSource;
      FStoredColumn:=SelectedIndex;
      Inherited DataSource:=nil;
    end;
    FIsStoredDataSource:=True;
  end else begin
    FIsStoredDataSource:=False;
    if Assigned(FStoredDataSource) then begin
      DataSource:=FStoredDataSource;
      SelectedIndex:=FStoredColumn;
      FStoredDataSource:=nil;
    end;
  end;
end;

Procedure TXEDBGrid.WMChangeControlSource(var Msg: TMessage);
var wSource, lSource: TDataSource;
begin
  lSource:= TDataSource(Msg.lParam);
  wSource:= TDataSource(Msg.wParam);
  if Assigned(lSource) then begin
    if wSource=DataSource then begin
      FStoredControlSource:= DataSource;
      DataSource:= lSource;
    end;
  end else
    if wSource=FStoredControlSource then begin
      DataSource:= FStoredControlSource;
      FStoredControlSource:=nil;
    end;
end;

Procedure TXEDBGrid.KeyDown(var Key: Word; Shift: TShiftState);
var EtvField:TEtvLookField;
begin
  case Key of
{
    Word('S'): if (ssCtrl in Shift) and
        (IsEtvField=efLookup) and
        (Columns[SelectedIndex].Field.LookupDataSet is TLinkQuery)
        then begin
        Key:=0;
        if Owner is TXForm then with TXForm(Owner) do
           if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
              if Assigned(TFormControl(XFormLink.LinkControl).OpenReturnControl) then
                 TFormControl(XFormLink.LinkControl).OpenReturnControl.ReturnExecute;
        end;
        }
    Word('Z'):
      if (ssCtrl in Shift) then
        if not (ssShift in Shift) then Key:=0
        else
          if IsEtvField=efLookup then begin
            EtvField:=TEtvLookField(Columns[SelectedIndex].Field);
            if IsLinkDataSet(EtvField.LookupDataSet) and not(foAutoDropDownWidth in EtvField.Options) then begin
              Key:=0;
              Cursor:=crHourGlass;
              ChangeLookQueryField(EtvField,nil,EtvField.LookUpDataSet,EtvField.LookUpResultField);
              Cursor:=crDefault;
            end;
          end;
  end;
  Inherited KeyDown(Key, Shift);
end;

{ Mixer }

Function GetXELookup(AOwner: TComponent): TWinControl;
begin
  Result:=TXEDBLookupCombo.Create(AOwner);
{  Result:=TDBLookupComboBox.Create(AOwner);}
end;

Procedure SetXELookupField(AControl: TWinControl; AField: TField; aDataSource: TDataSource);
var aLookField: TField;
begin
  with TDBLookupComboBox(AControl) do begin
    if ChangeToLookField(aField, aLookField) then aField:=aLookField;
    DataField:=AField.FieldName;
    DataSource:=ADataSource;
  end;
end;

Procedure SetXELookupKeyValue(AControl: TWinControl; AValue: String);
begin
  TDBLookupComboBox(AControl).KeyValue:=AValue;
end;

Function  GetXEEdit(AOwner: TComponent): TWinControl;
begin
  Result:=TXEDBEdit.Create(AOwner);
end;

Procedure SetXEEditField(AControl: TWinControl; AField: TField; ADataSource: TDataSource);
begin
  TDBEdit(AControl).DataField:=AField.FieldName;
  TDBEdit(AControl).DataSource:=ADataSource;
end;

Procedure SetXEEditKeyValue(AControl: TWinControl; AValue: String);
begin
  TDBEdit(AControl).Text:=AValue;
end;

type TControlSelf=class(TControl) end;

Function GetXEOtherDBEdit(aOwner:TComponent; Field:TField):TControl;
begin
  Result:= TXEDBEdit.Create(aOwner);
  TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
end;

Function GetXEOtherDBDateEdit(aOwner:TComponent; Field:TField):TControl;
begin
  Result:= TXEDBDateEdit.Create(aOwner);
  TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
end;

Function GetXEOtherDBComboBox(aOwner:TComponent; Field:TField):TControl;
begin
  Result:=nil;
  if Field is TEtvListField then begin
    Result:= TXEDBCombo.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
  end;
end;

Function GetXEOtherDBMemo(aOwner:TComponent; Field:TField):TControl;
begin
  Result:= TXEDBMemo.Create(aOwner);
  TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
end;

Function GetXEOtherDBLookupComboBox(aOwner:TComponent; Field:TField):TControl;
begin
  Result:= TXEDBLookupCombo.Create(aOwner);
  TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
end;

Initialization
  DFGetLookCombo:=GetXELookup;
  DFSetLookField:=SetXELookupField;
  DFSetLookKeyValue:=SetXELookupKeyValue;
  DFGetDBEdit:=GetXEEdit;
  DFSetDBEditField:=SetXEEditField;
  DFSetDBEditKeyValue:=SetXEEditKeyValue;

  XNotifyEvent:=TXNotifyEvent.Create(nil);
  CreateOtherDBEdit:= GetXEOtherDBEdit;
  CreateOtherDBDateEdit:= GetXEOtherDBDateEdit;
  CreateOtherDBIntEdit:= GetXEOtherDBComboBox;
  CreateOtherDBMemo:= GetXEOtherDBMemo;
  CreateOtherDBLookupComboBox:= GetXEOtherDBLookupComboBox;

finalization
  DFGetLookCombo:=nil;
  DFSetLookField:=nil;
  DFSetLookKeyValue:=nil;
  DFGetDBEdit:=nil;
  DFSetDBEditField:=nil;
  DFSetDBEditKeyValue:=nil;

  XNotifyEvent.Free;
  XNotifyEvent:=nil;

  CreateOtherDBEdit:=nil;
  CreateOtherDBDateEdit:=nil;
  CreateOtherDBIntEdit:=nil;
  CreateOtherDBMemo:=nil;
  CreateOtherDBLookupComboBox:=nil;
end.
