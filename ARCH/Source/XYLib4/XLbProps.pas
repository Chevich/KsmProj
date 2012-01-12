Unit XLbProps;

Interface

Uses Windows, Classes, DsgnIntf, Menus, DBReg;

Type

  { TFormControlProperty }

  TFormControlProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  { TMenuItemCaptionProperty }

  TMenuItemCaptionProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  { TLinkMenuItemProperty }

  TLinkMenuItemProperty = class(TComponentProperty)
  public
    procedure PopupProc(Sender: TObject);
    function GetAttributes: TPropertyAttributes; override;
    procedure GetProperties(Proc: TGetPropEditProc); override;
    function GetValue: string; override;
    procedure Edit; override;
    procedure SetValue(const Value: string); override;
  end;

  { TLogFieldProperty }

  TLogFieldProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  { TUserNameLinkProperty }

  TUserNameLinkProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  { TUserNameReportProperty }

  TUserNameReportProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

  { TXReportItemProperty }

  TXReportItemProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

Implementation

Uses SysUtils, TypInfo, Consts, DB,{ RepDlg,} DsDesign,
     DBTables, Dialogs, {DBDual,} DBConsts,{ LsColEdt,}
     Forms, Controls, {MnuBuild,}{ MIF,}
     XTFC, DBXplor, LnkSet, XDBTFC, UsersSet
{$IFDEF Report_Builder}
     , ppCDShow
{$ENDIF}
     ;

{ TFormControlProperty }

Procedure TFormControlProperty.GetValues(Proc: TGetStrProc);
var P: PTypeData;
begin
  New(P);
  P^.ClassType:=TFormControl;
  Designer.GetComponentNames(P, Proc);
  Dispose(P);
end;

{ TMenuItemCaptionProperty }

Function TMenuItemCaptionProperty.GetAttributes: TPropertyAttributes;
var Comp: TComponent;
begin
  Comp:=TComponent(GetComponent(0));
  if (Comp is TLinkMenuItem) or (Comp.Name='') then Result:=Inherited GetAttributes
  else Result:=[paMultiSelect, paValueList, paSortList, paRevertable];
end;

Function TMenuItemCaptionProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

Function TMenuItemCaptionProperty.GetValue: string;
begin
  Result := GetStrValue;
end;

Procedure TMenuItemCaptionProperty.GetValues(Proc: TGetStrProc);
var P: PTypeData;
begin
  New(P);
  P^.ClassType:=TFormControl;
  Designer.GetComponentNames(P, Proc);
  Dispose(P);
end;

type
  TxComponent = class(TPersistent)
  private
    FOwner: TComponent;
    FName: TComponentName;
    FTag: Longint;
    FComponents: TList;
    FFreeNotifies: TList;
    FDesignInfo: Longint;
    FVCLComObject: Pointer;
  end;

Procedure TMenuItemCaptionProperty.SetValue(const Value: string);
var
  Component: TComponent;
  C: TLinkMenuItem;
  i: Integer;
  Par, Comp, DelIt: TMenuItem;
  aName: TComponentName;
begin
  if Value = '' then Component:=nil
  else begin
    Component := Designer.GetComponent(Value);
    if not (Component is TFormControl) then begin
      Inherited SetValue(Value);
      Exit;
    end;
    Comp:=TMenuItem(GetComponent(0));
    Par:=Comp.Parent;
    with Comp do begin
      i:=TMenuItem(Comp).MenuIndex;
      C:= TLinkMenuItem.Create(Comp.Owner);
      C.Break:=Break;
      C.Caption:=Caption;
      C.Checked:=Checked;
      C.Default:=Default;
      C.Enabled:=Enabled;
      C.GroupIndex:=GroupIndex;
      C.HelpContext:=HelpContext;
      C.Hint:=Hint;
      C.RadioItem:=RadioItem;
      C.ShortCut:=ShortCut;
      C.Tag:=Tag;
      C.Visible:=Visible;
      C.FormControl:=TFormControl(Component);
      AName:=Comp.Name;
    end;
    Par.Insert(i,C);
    for i:=0 to Screen.FormCount-1 do
      if Screen.Forms[i].ClassName='TMenuBuilder' then begin
        DelIt:= Screen.Forms[i].PopupMenu.Items[1];
        if Assigned(DelIt) then DelIt.Click;
      end;
    C.Name:=AName;
  end;
end;

{ TLinkMenuItemProperty }

Function TLinkMenuItemProperty.GetAttributes: TPropertyAttributes;
var Comp: TFormControl;
begin
  Comp:=TFormControl(GetComponent(0));
  if Comp.MenuItem=nil then
     {if Comp.PopupMenu=Nil then }Result:= Inherited GetAttributes
     {else Result:=[paReadOnly, paDialog]}
  else Result:=[paMultiSelect, paValueList, paSortList, paRevertable, paSubProperties];
end;

Procedure TLinkMenuItemProperty.GetProperties(Proc: TGetPropEditProc);
var i: Integer;
    Components: TComponentList;
begin
  Components:=TComponentList.Create;
  try
    for i:=0 to PropCount-1 do Components.Add(TComponent(GetOrdValueAt(i)));
    GetComponentProperties(Components, tkProperties, Designer, Proc);
  finally
    Components.Free;
  end;
end;

Function TLinkMenuItemProperty.GetValue: string;
begin
  Result:= Inherited GetValue;
{  if Result='' then FmtStr(Result, '(%s)', [GetPropType^.Name]);}
end;

Procedure TLinkMenuItemProperty.PopupProc(Sender: TObject);
begin
  TForm(Value).PopupMenu.Popup(0,0);
end;

Procedure TLinkMenuItemProperty.Edit;
var Comp: TFormControl;
    F: TForm;
begin
  Comp:=TFormControl(GetComponent(0));
  if Comp.FormTools.PopupMenu<>nil then begin
{!!! F:=TMiff.Create(Application);
     F.PopupMenu:=Comp.Popupmenu;
     F.ShowModal;
     F.Free;}
  end;
end;

Procedure TLinkMenuItemProperty.SetValue(const Value: string);
var
  Component: TComponent;
  C: TLinkMenuItem;
  i: Integer;
  Par, DelIt: TMenuItem;
  AName: TComponentName;
begin
  if Value = '' then Inherited SetValue(Value)
  else begin
    Component := Designer.GetComponent(Value);
    if Component is TMenuItem then begin
      if not (Component is TLinkMenuItem) then begin
        Par:=TMenuItem(Component).Parent;
        i:=TMenuItem(Component).MenuIndex;
        C:= TLinkMenuItem.Create(Component.Owner);
        with TMenuItem(Component) do begin
          C.Break:=Break;
          C.Caption:=Caption;
          C.Checked:=Checked;
          C.Default:=Default;
          C.Enabled:=Enabled;
          C.GroupIndex:=GroupIndex;
          C.HelpContext:=HelpContext;
          C.Hint:=Hint;
          C.RadioItem:=RadioItem;
          C.ShortCut:=ShortCut;
          C.Tag:=Tag;
          C.Visible:=Visible;
          C.FormControl:=TFormControl(GetComponent(0));
          AName:=Component.Name;
        end;
{!      Par.Delete(i);
      Component.Owner.RemoveComponent(Component);}
        Par.Insert(i,C);
        for i:=0 to Screen.FormCount-1 do
          if Screen.Forms[i].ClassName='TMenuBuilder' then begin
            DelIt:= Screen.Forms[i].PopupMenu.Items[1];
            if Assigned(DelIt) then DelIt.Click;
          end;
        C.Name:=AName;
      end;
      Inherited SetValue(Value);
    end;
  end;
end;

{ TLogFieldProperty }

Procedure TLogFieldProperty.GetValueList(List: TStrings);
var i: Integer;
    ASource: TDataSource;
begin
  ASource:= (GetComponent(0) as TXDatabase).LogSource;
  if Assigned(ASource) then
    with ASource do if DataSet <> nil then
      for i:=0 to DataSet.FieldCount-1 do List.Add(DataSet.Fields[i].FieldName);
end;

{ TUserNameLinkProperty }

Procedure CompareAddStrings(Dest, Source: TStrings);
var i: Integer;
begin
  with Dest do begin
    BeginUpdate;
    try
      for i:=0 to Source.Count-1 do
        if IndexOf(Source[i])=-1 then AddObject(Source[i], Source.Objects[i]);
    finally
      EndUpdate;
    end;
  end;
end;

Procedure TUserNameLinkProperty.GetValueList(List: TStrings);
var {i: Integer;}
    AControl: TDBFormControl;
    ASource: TUserSource;
begin
  AControl:=(GetComponent(0) as TXInquiryItem).DBControl;
  if Assigned(AControl) then begin
    ASource:= AControl.CurrUserSource;
    if Assigned(ASource) then
      with ASource do begin
        GetChangeUsers(List);
{       CompareAddStrings(List,UserAdds);
        CompareAddStrings(List,UserGroups);
        if List.IndexOf(UserName)=-1 then List.Add(UserName);}
      end;
  end;
end;

{ TUserNameReportProperty }

Procedure TUserNameReportProperty.GetValueList(List: TStrings);
var i: Integer;
    AControl: TDBFormControl;
    ASource: TUserSource;
begin
  AControl:= (GetComponent(0) as TXReportItem).DBControl;
  if Assigned(AControl) then begin
    ASource:= AControl.CurrUserSource;
    if Assigned(ASource) then
      with ASource do begin
        for i:= 0 to ChangeUserCount-1 do
          if List.IndexOf(ChangeUsers[i])=-1 then List.Add(ChangeUsers[i]);
{             CompareAddStrings(List,UserAdds);
             CompareAddStrings(List,UserGroups);
             if List.IndexOf(UserName)=-1 then List.Add(UserName);}
      end;
  end;
end;

{ TXReportItemProperty }

Function TXReportItemProperty.GetAttributes: TPropertyAttributes;
begin
  if Pointer(GetOrdValue)<>nil then Result:=[paReadOnly, paDialog]
  else Result:=[paReadOnly];
end;

Function TXReportItemProperty.GetValue: string;
begin
  if Pointer(GetOrdValue)<>nil then FmtStr(Result,'(%s)',['XReport'])
  else FmtStr(Result, '(%s)', ['Not Active']);
end;

Procedure TXReportItemProperty.Edit;
begin
{$IFDEF Report_Builder}
  ppShowComponentDesigner(Designer, TComponent(GetOrdValue));
{$ENDIF}
end;

end.
