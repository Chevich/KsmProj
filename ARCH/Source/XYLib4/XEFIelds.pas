Unit XEFields;

Interface

Uses Classes, DB, EtvLook,EtvList,XDBMisc;

type

{ TXELookField }

  TXELookFieldClass = Class of TXELookField;

  TXELookField = class(TEtvLookField)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner:TComponent); override;
  end;

{ TXEListField }

  TXEListField = class(TEtvListField)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

  TFieldsInfoProc = function (ADataSet:TDataSet):string;

Function DefaultFieldsInfo(ADataSet:TDataSet):string;

var FieldsInfoProc: TFieldsInfoProc=DefaultFieldsInfo;

Implementation

Uses EtvBor, EtvDB,EtvDBFun, XMisc;

{ TXELookField }
Constructor TXELookField.Create(AOwner:TComponent);
begin
  Inherited;
  Options:=[foKeyFieldEdit,foEditWindow];
end;

Procedure TXELookField.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then begin
    case TXNotifyEvent(AComponent).SpellEvent of
      xeSetParams:
        begin
{         TFieldBorland(Self).FLookupResultField:=}
          fLookupResultFields:=TXNotifyString(AComponent).SpellStr;
          TFieldBorland(Self).FLookupResultField:= AllLookupFields;
          ChangeLookupFields;
{          ChangeLookupFields;}
        end;
      xeSetDataSet:
        begin
          ChangeLookupFields;
        end;
    end;
    if TXNotifyEvent(AComponent).SpellEvent=xeSetParams then begin
    end;
  end else Inherited;
end;

{ TXEListField }

Procedure TXEListField.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then begin
  end else Inherited;
end;

Function DefaultFieldsInfo(ADataSet:TDataSet):string;
begin
  Result:='AbstractInfo'#13+#10;
end;

Function GetXEFieldClass(AField: TField; var AFieldClass: TFieldClass): Boolean;
begin
  if (aField is TXELookField) or (aField is TXEListField) then begin
    AFieldClass:=TFieldClass(aField.ClassType);
    Result:=True;
  end else Result:=False;
end;

Procedure XEAssignCloneField(Master, Child: TField);
begin
  if Child is TXEListField then
    TXEListField(Child).Values:=TXEListField(Master).Values
  else
    if Child is TXELookField then
      with TXELookField(Child) do begin
        LookupResultField:= TXELookField(Master).lookupResultField;
        ListFieldIndex:=TXELookField(Master).ListFieldIndex;
        Options:=TXELookField(Master).Options;
        {LookupMSField:=TXELookField(Master).LookupMSField; need remake}
        LookupFilterField:=TXELookField(Master).LookupFilterField;
        LookupLevelUp:=TXELookField(Master).LookupLevelUp;
        LookupFilterKey:=TXELookField(Master).LookupFilterKey;
        HeadLine:=TXELookField(Master).HeadLine;
        HeadColor:=TXELookField(Master).HeadColor;
        ChangeLookupFields;
      end;
end;

Initialization
  FieldsInfoProc:=EtvDBFun.FieldsInfo;
  UserCloneFieldProc:=XEAssignCloneField;
  UserFieldClassProc:=GetXEFieldClass;
Finalization
  FieldsInfoProc:=nil;
  UserCloneFieldProc:=nil;
end.
