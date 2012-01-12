{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         VCL registration                              }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgVCLRg;

interface
uses DsgnIntf;

type
{ TListNamesProperty }
  TListNamesProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

procedure Register;

implementation
uses vgUtils, SysUtils, Classes, vgVCLRes, vgTools, Explorer,
  vgNLS, ExplCtrl, ExplFile, vgStndrt, vgCtrls, vgItemEd, ExplEdit
  {$IFDEF _D3_}, vgMSScr{$ENDIF};

{$R vgDVCL.dcr}

type
{ TExplorerFormClassListEditor }
  TExplorerFormClassListEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{$IFNDEF _D4_}
{ TVariantProperty }
  TVariantProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetProperties(Proc: TGetPropEditProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TVariantProperty }
  TVarTypeProperty = class(TPropertyEditor)
  private
    FVariantProperty: TVariantProperty;
    constructor Create(ADesigner: TFormDesigner; APropList: Pointer; APropCount: Integer; AVariantProperty: TVariantProperty);
  public
    destructor Destroy; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;
{$ENDIF}

{ TListNamesProperty }
function TListNamesProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{ TExplorerFormClassListEditor }
function TExplorerFormClassListEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TExplorerFormClassListEditor.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to ExplorerFormClassList.Count - 1 do
    Proc(ExplorerFormClassList.Items[I].GetClassType.ClassName);
end;

{$IFNDEF _D4_}
{ TVariantProperty }
function TVariantProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paSubProperties];
end;

type
  TPropertyEditorHack = class
    FDesigner: TFormDesigner;
    FPropList: PInstPropList;
    FPropCount: Integer;
  end;

procedure TVariantProperty.GetProperties(Proc: TGetPropEditProc);
begin
  Proc(TVarTypeProperty.Create(Designer, TPropertyEditorHack(Self).FPropList, PropCount, Self));
end;

function TVariantProperty.GetValue: string;
var
  V: Variant;
begin
  V := GetVarValue;
  case VarType(V) of
    varEmpty:
      Result := '';
    varNull:
      Result := 'Null';
    varByte, varSmallint, varInteger:
      Result := IntToStr(V);
    varSingle, varDouble, varCurrency:
      Result := FloatToStr(V);
    varDate:
      Result := DateTimeToStr(V);
    varString, varOleStr:
      Result := V;
    varBoolean:
      if V then Result := 'True' else Result := 'False';
  else
    Result := '(Variant)';
  end;
end;

procedure TVariantProperty.SetValue(const Value: string);
var
  V: Variant;
begin
  V := GetVarValue;
  if VarIsEmpty(V) or VarIsNull(V) then V := '';
  SetVarValue(VarAsType(Value, VarType(V)));
end;

{ TVarTypeProperty }
var
  VarTypes: TStrings;

constructor TVarTypeProperty.Create(ADesigner: TFormDesigner; APropList: Pointer; APropCount: Integer; AVariantProperty: TVariantProperty);
begin
  TPropertyEditorHack(Self).FDesigner := ADesigner;
  TPropertyEditorHack(Self).FPropList := APropList;
  TPropertyEditorHack(Self).FPropCount := APropCount;
  FVariantProperty := AVariantProperty;
end;

destructor TVarTypeProperty.Destroy;
begin
end;

function TVarTypeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TVarTypeProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to VarTypes.Count - 1 do Proc(VarTypes[I]);
end;

function TVarTypeProperty.GetValue: string;
var
  VarTyp, I: Integer;
begin
  VarTyp := VarType(FVariantProperty.GetVarValue);
  I := VarTypes.IndexOfObject(Pointer(VarTyp));
  try
    Result := VarTypes[I];
  except
    Result := '';
  end;
end;

procedure TVarTypeProperty.SetValue(const Value: string);
var
  I: Integer;
  VT: Integer;
  V: Variant;
begin
  I := VarTypes.IndexOf(Value);
  if I >= 0 then
  begin
    V := FVariantProperty.GetVarValue;
    VT := Integer(VarTypes.Objects[I]);
    try
      case VT of
        varEmpty:
          FVariantProperty.SetVarValue(Unassigned);
        varNull:
          FVariantProperty.SetVarValue(Null);
        varByte, varSmallint, varInteger:
          try
            FVariantProperty.SetVarValue(VarAsType(V, VT));
          except
            FVariantProperty.SetVarValue(VarAsType(0, VT));
          end;
        varSingle, varDouble, varCurrency, varDate:
          try
            FVariantProperty.SetVarValue(VarAsType(V, VT));
          except
            FVariantProperty.SetVarValue(VarAsType(0.0, VT));
          end;
        varBoolean:
          try
            if AnsiCompareText(V, 'True') = 0 then
              FVariantProperty.SetVarValue(True) else
              FVariantProperty.SetVarValue(False);
          except
            FVariantProperty.SetVarValue(False);
          end;
        varString, varOleStr:
          FVariantProperty.SetVarValue(VarAsType(V, VT));
      end;
    except
      FVariantProperty.SetVarValue(VarAsType('', VT))
    end;
  end;
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents(LoadStr(SRegSystem), [
    TvgThread, TBroadcaster, TDateTimeStorage, TCurrencyStorage,
    TTranslator {$IFDEF _D3_}, TMSSCScript{$ENDIF}]);

  {$IFDEF _D3_}
  RegisterCustomModule(TCustomSheetForm, TCustomModule);
  {$ENDIF}

  RegisterComponents(LoadStr(SRegTools), [TMoneyString, TFormLoader]);

  RegisterComponents(LoadStr(SRegControls), [
    TvgSplitter, TClickEdit, TJustifyEdit, TTitler, TvgPageControl, TvgNoteBook, TvgTabSet
    {, TvgTreeView, TvgListView}]);

  RegisterNoIcon([TvgTabSheet]);

  RegisterComponents(LoadStr(SRegExplorer), [
    TExplorerRootNode, TExplorerSource, TExplorerTreeView, TExplorerListView
    {$IFDEF _D3_}, TExplorerListBox {$ENDIF}, TExplorerTreeCombo]);
  RegisterNoIcon([TExplorerNode]);

  RegisterExplorerNodesClasses([
    TExplorerFolderNode, TExplorerActionNode, TExplorerSeparatorNode,
    TExplorerStringsNode, TExplorerFormNode,
    TExplorerDrivesNode]);

  RegisterComponentEditor(TItemList, TItemListEditor);
  RegisterComponentEditor(TExplorerNodes, TExplorerNodesEditor);
  RegisterPropertyEditor(TypeInfo(TClassName), TExplorerFormNode, '', TExplorerFormClassListEditor);
{$IFNDEF _D4_}
  RegisterPropertyEditor(TypeInfo(Variant), nil, '', TVariantProperty);
{$ENDIF}
end;

initialization
{$IFNDEF _D4_}
  VarTypes := TStringList.Create;

  VarTypes.AddObject('Empty', Pointer(varEmpty));
  VarTypes.AddObject('Null', Pointer(varNull));
  VarTypes.AddObject('Smallint', Pointer(varSmallInt));
  VarTypes.AddObject('Integer', Pointer(varInteger));
  VarTypes.AddObject('Single', Pointer(varSingle));
  VarTypes.AddObject('Double', Pointer(varDouble));
  VarTypes.AddObject('Currency', Pointer(varCurrency));
  VarTypes.AddObject('Date', Pointer(varDate));
  VarTypes.AddObject('OleStr', Pointer(varOleStr));
  VarTypes.AddObject('Dispatch', Pointer(varDispatch));
  VarTypes.AddObject('Error', Pointer(varError));
  VarTypes.AddObject('Boolean', Pointer(varBoolean));
  VarTypes.AddObject('Variant', Pointer(varVariant));
  VarTypes.AddObject('Unknown', Pointer(varUnknown));
  VarTypes.AddObject('Byte', Pointer(varByte));
  VarTypes.AddObject('String', Pointer(varString));
  VarTypes.AddObject('TypeMask', Pointer(varTypeMask));
  VarTypes.AddObject('Array', Pointer(varArray));
  VarTypes.AddObject('ByRef', Pointer(varByRef));
{$ENDIF}

finalization
{$IFNDEF _D4_}
  VarTypes.Free;
{$ENDIF}

end.
