unit EtvList;

interface
uses Messages, Classes, StdCtrls, Controls, DB, DBCtrls;
type
  TEtvListField = class(TSmallIntField)
  protected
    FValues: TStrings;
    function GetEditFormat: String;
    function GetDisplayFormat: String;
    function GetMinValue: Longint;
    function GetMaxValue: LongInt;
    procedure SetValues(Value: TStrings);
    procedure GetText(var Text: string; DisplayText: Boolean); override;
    function GetAsString: string; override;
    procedure SetAsInteger(Value: Longint); override;
    procedure SetAsString(const Value: string); override;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DisplayFormat: String read GetDisplayFormat;
    property EditFormat: String read GetEditFormat;
    property Values: TStrings read FValues write SetValues;
    property MinValue: Longint Read GetMinValue;
    property MaxValue: Longint Read GetMaxvalue;
  end;

{ TEtvDBCombo }
TEtvCustomDBCombo=class(TDBComboBox) (* For EtvList*)
protected {private}
  function GetComboBoxStyle:TComboBoxStyle;
  procedure SetComboBoxStyle(aValue:TComboBoxStyle);
  function GetItems: Integer;
  function GetDataField: string;
  procedure SetDataField(const Value: string);
  function GetDataSource: TDataSource;
  procedure SetDataSource(Value: TDataSource);
  procedure SetParent(AParent: TWinControl); override;
protected
  procedure PumpValues(Sender: TObject);
  procedure Loaded; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
  procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
public
  constructor Create(AOwner: TComponent); override;
published
  property DataField: string read GetDataField write SetDataField;
  property DataSource: TDataSource read GetDataSource write SetDataSource;
  property Style: TComboBoxStyle Read GetComboBoxStyle write SetComboBoxStyle;
  property Items: Integer read GetItems;
end;

TEtvDBCombo=class(TEtvCustomDBCombo) (* For EtvList*)
protected
  procedure Loaded; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
end;

function CreateEtvCombo(aOwner:TComponent; Field:TField):TControl;
function CreateEtvDBCombo(aOwner:TComponent; Field:TField):TControl;

procedure CreateOtherEtvListFieldAutoCorrect(aField:TField);

IMPLEMENTATION

uses Windows, DBConsts,
     EtvOther,EtvBor,EtvPas,EtvPopup;

{ TEtvListField }
constructor TEtvListField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValues := TStringList.Create;
  Alignment:=taLeftJustify;
  Inherited MinValue:=0;
end;

destructor TEtvListField.Destroy;
begin
  FValues.Free;
  inherited Destroy;
end;

procedure TEtvListField.ReadState(Reader: TReader);
begin
  Inherited;
  Inherited MaxValue:=FValues.Count-1;
end;

procedure TEtvListField.SetValues(Value: TStrings);
begin
  FValues.Assign(Value);
  Inherited MaxValue:=FValues.Count-1;
  if Assigned(DataSet) then DataChanged;
end;

procedure TEtvListField.GetText(var Text: string; DisplayText: Boolean);
begin
  Text:=GetAsString;
end;

function TEtvListField.GetAsString: string;
var L: Longint;
begin
  if GetValue(L) then begin
    if (L>=Inherited MinValue)and(L<=Inherited MaxValue) then Result:=FValues[L]
    else Result:='';
  end else Result:='';
end;

procedure TEtvListField.SetAsInteger(Value: Longint);
begin
  if (Value>=0) and (Value<=MaxValue) and (FValues[Value]='') then
    Clear
  else Inherited;
end;

procedure TEtvListField.SetAsString(const Value: string);
var L: Integer;
begin
  if Value='' then Clear
  else begin
    L:=FValues.IndexOf(Value);
    if L=-1 then
      DataBaseErrorFmt(SFieldValueError, [DisplayName])
    else SetAsInteger(L);
  end;
end;

function TEtvListField.GetEditFormat: String;
begin
  Result:=Inherited EditFormat;
end;

function TEtvListField.GetDisplayFormat: String;
begin
  Result:=Inherited DisplayFormat;
end;

function TEtvListField.GetMinValue: Longint;
begin
  Result:=Inherited MinValue;
end;

function TEtvListField.GetMaxValue: LongInt;
begin
  Result:= Inherited MaxValue;
end;

{TEtvCustomDBCombo}
constructor TEtvCustomDBCombo.Create(AOwner: TComponent);
begin
  Inherited;
  Inherited Style:=csDropDownList;
end;

function TEtvCustomDBCombo.GetComboBoxStyle:TComboBoxStyle;
begin
  Result:=Inherited Style;
end;

procedure TEtvCustomDBCombo.SetComboBoxStyle(aValue:TComboBoxStyle);
begin
  if aValue in [csDropDownList,csOwnerDrawFixed,csOwnerDrawVariable] then
    inherited Style:=aValue;
end;

function TEtvCustomDBCombo.GetItems: Integer;
begin
  Result:= Inherited Items.Count;
end;

function TEtvCustomDBCombo.GetDataField: string;
begin
  Result:=Inherited DataField;
end;

procedure TEtvCustomDBCombo.SetDataField(const Value: string);
begin
  Inherited DataField:=Value;
  PumpValues(Self);
end;

function TEtvCustomDBCombo.GetDataSource: TDataSource;
begin
  Result:=Inherited DataSource;
end;

procedure TEtvCustomDBCombo.SetDataSource(Value: TDataSource);
begin
  Inherited DataSource:=Value;
  PumpValues(Self);
end;

procedure TEtvCustomDBCombo.SetParent(AParent: TWinControl);
begin
  inherited;
  if Assigned(Parent) then PumpValues(Self);
end;

procedure TEtvCustomDBCombo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_Delete,VK_Back:
      if Assigned(Field) and (Field is TEtvListField) and Field.CanModify then begin
        DataSource.Edit;
        Field.Clear;
        Key:=0;
      end;
    VK_RETURN: if (ssCtrl in Shift) then begin
      PostMessage(Handle, CB_SHOWDROPDOWN, LongInt(True), 0);
      Key:=0;
    end;
  end;
  inherited;
end;

procedure TEtvCustomDBCombo.KeyPress(var Key: Char);
begin
  if (Key in ['0'..'9']) and (not DroppedDown) and
     Assigned(Field) and (Field is TEtvListField) and
     Field.CanModify and
     (Ord(Key)-Ord('0')<=TEtvListField(Field).MaxValue) then begin
    DataSource.Edit;
    Field.Value:=Ord(Key)-ord('0');
    Key:=#0;
  end;
  inherited;
end;

procedure TEtvCustomDBCombo.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if (not Focused) and
     (Message.XPos < (Width - GetSystemMetrics(SM_CXHSCROLL))) then begin
    SetFocus;
    BeginDrag(False);
    Exit;
  end;
  inherited;
end;

procedure TEtvCustomDBCombo.PumpValues(Sender: TObject);
begin
  if Assigned(Parent) then
    if Assigned(Field) and (Field is TEtvListField) then
      Inherited Items:=TEtvListField(Field).Values
    else Inherited Items.Clear;
end;

procedure TEtvCustomDBCombo.Loaded;
begin
  inherited;
  TDBComboBoxBorland(Self).fDataLink.OnActiveChange:=PumpValues;
  PumpValues(Self);
end;

{TEtvDBCombo}
procedure TEtvDBCombo.Loaded;
begin
  inherited;
  if (not(csDesigning in ComponentState)) and (PopupMenu=nil) then
    PopupMenu:=PopupMenuEtvDBFieldControls;
end;

procedure TEtvDBCombo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Inherited;
  {if Not DroppedDown then DataSrcKeyDown(DataSource,Key,Shift);}
  KeyReturn(Self,Key,Shift);
end;

function CreateEtvCombo(aOwner:TComponent; Field:TField):TControl;
begin
  Result:=nil;
  if Field is TEtvListField then
    Result:=TComboBox.Create(aOwner);
end;

function CreateEtvDBCombo(aOwner:TComponent; Field:TField):TControl;
begin
  Result:=nil;
  if Field is TEtvListField then begin
    Result:=TEtvDBCombo.Create(aOwner);
    TEtvDBCombo(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
  end;
end;

var fOldCreateOtherFieldAutoCorrect:procedure(aField:TField);
procedure CreateOtherEtvListFieldAutoCorrect(aField:TField);
var i,l:integer;
begin
  if Assigned(fOldCreateOtherFieldAutoCorrect) then
    fOldCreateOtherFieldAutoCorrect(aField);
  if (aField.fieldKind=fkData) and (aField is TEtvListField) then begin
    L:=0;
    for i:=0 to TEtvListField(aField).values.Count-1 do
      if L<Length(TEtvListField(aField).values[i]) then
        L:=Length(TEtvListField(aField).values[i]);
    if L>0 then aField.DisplayWidth:=L+3;
  end;
end;

initialization
  CreateOtherIntEdit:=CreateEtvCombo;
  CreateOtherDBIntEdit:=CreateEtvDBCombo;

  fOldCreateOtherFieldAutoCorrect:=CreateOtherFieldAutoCorrect;
  CreateOtherFieldAutoCorrect:=CreateOtherEtvListFieldAutoCorrect;

finalization

end.
