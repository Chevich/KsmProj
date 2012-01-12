{$I XLib.inc }
Unit TFCProps;

Interface

Uses Classes, DsgnIntf, XDBTFC, ColnEdit;

Type

{ TInnerComponentProperty }

  TInnerComponentProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TFormControlEditor }

  TFormControlEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TDBFormControlEditor }

  TDBFormControlEditor = class(TFormControlEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TXLinkSourcesProperty }

  TXLinkSourcesProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TToolsControlEditor }

  TToolsControlEditor = class(TComponentEditor)
  private
    FCount: Integer;
    procedure CountFCs(Const S: String);
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

  TFormProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TXControlSourceProperty }

  TXControlSourceProperty = class(TComponentProperty)
  public
    function GetXSources: TXLinkSources;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TFormSourceProperty }

  TFormSourceProperty = class(TComponentProperty)
  public
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

  TXFormClassProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TXToolClassProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TXSplashClassProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetEditLimit: Integer; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

{ TPrintInquiryProperty }

  TPrintInquiryProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

Implementation

Uses TypInfo, SysUtils, Controls, DiDual,
     XTFC, ExptIntf, Consts, DB,
     EditIntf, {LibMain, }Forms, Dialogs, XMisc,
     LnkSet, XForms, XDBForms, XExps, DLinksEd, XReports;

Procedure GetClassLinks(ADesigner: IFormDesigner; Proc: TGetStrProc; AClass: TClass);
var P: PTypeData;
begin
  New(P);
  P^.ClassType:= AClass;
  ADesigner.GetComponentNames(P, Proc);
  Dispose(P);
end;

Function EditLinkSources(AComponent: TDBFormControl; AList: TStringList;
                         ADesigner: IFormDesigner): Boolean;
var
  Form: TEtvDualListDlg;
  i, j: Integer;
  L1: TXLinkSources;
  Priz: Boolean;
  Src: TXLinkSourceItem;
  Comp: TDBFormControl;
  S: String;
begin
  Result := False;
  Form := TEtvDualListDlg.Create(Application);
  try
    with Form do begin
      Form.Caption := 'LinkSources selector';
      SrcLabel.Caption := 'Selected LinkSources';
      DstLabel.Caption := 'All LinkSources';
      L1:= AComponent.Sources;
{      SrcList.Items.Assign(L1);}
      SrcList.Clear;
      DstList.Clear;
      for i:=0 to L1.Count-1 do
        if Assigned(L1[i].Source) then SrcList.Items.Add(L1[i].Source.Name);
      for i:=0 to AList.Count-1 do begin
        Priz:=True;
        for j:=0 to L1.Count-1 do
          if AnsiCompareText(AList[i], L1[j].Source.Name)=0 then begin
            Priz:=False; Break;
          end;
        if Priz then begin
          DstList.Items.Add(AList[i]);
        end;
      end;
    end;
    Result := (Form.ShowModal = mrOk);
    if Result then begin
       Comp:=AComponent;
       i:=0;
       while i<Comp.Sources.Count do begin
         Priz:=True;
         for j:=0 to Form.SrcList.Items.Count-1 do
           if AnsiCompareText(Comp.Sources[i].Source.Name, Form.SrcList.Items[j])=0 then begin
             Priz:=False;
             Break;
           end;
           if Priz then Comp.Sources[i].Free else Inc(i);
       end;

       for i:=0 to Form.SrcList.Items.Count-1 do
         if Comp.Sources.IndexOfLinkName(Form.SrcList.Items[i])=-1 then begin
           Src:= Comp.Sources.Add;
           Src.Source:=TLinkSource(ADesigner.GetComponent(Form.SrcList.Items[i]));
         end;
    end;
  finally
    Form.Free;
  end;
end;

Procedure SwapSources(AComponent: TDBFormControl; ADesigner: IFormDesigner);
type
  TGetStrFunc = function(const Value: string): Integer of object;
var Values: TStringList;
    AddValue: TGetStrFunc;
begin
  Values := TStringList.Create;
  Values.Sorted := True;
  try
    AddValue := Values.Add;
    GetClassLinks(ADesigner, TGetStrProc(AddValue), TLinkSource);
    if EditLinkSources(AComponent, Values, ADesigner) then ADesigner.Modified;
  finally
    Values.Free;
  end;
end;

{ TInnerComponentProperty }

Function TInnerComponentProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList, paRevertable];
end;

Function TInnerComponentProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

Function TInnerComponentProperty.GetValue: string;
var Comp: TFormControl;
begin
  Comp:=TFormControl(GetComponent(0));
  if Assigned(Comp.Form) then
    Result := IFormDesigner(Comp.Form.Designer).GetComponentName(TComponent(GetOrdValue))
  else Result:='';
end;

Procedure TInnerComponentProperty.GetValues(Proc: TGetStrProc);
var Comp: TFormControl;
begin
  Comp:=TFormControl(GetComponent(0));
  if Assigned(Comp.Form) then
    IFormDesigner(Comp.Form.Designer).GetComponentNames(GetTypeData(GetPropType), Proc);
end;

Procedure TInnerComponentProperty.SetValue(const Value: string);
var
  Comp: TFormControl;
  Component: TComponent;
begin
  if Value = '' then Component := nil
  else begin
    Comp:=TFormControl(GetComponent(0));
    if Assigned(Comp.Form) then
      Component := IFormDesigner(Comp.Form.Designer).GetComponent(Value)
    else Component:=nil;
{    Component := Designer.GetComponent(Value);}
    if not (Component is GetTypeData(GetPropType)^.ClassType) then
      raise EPropertyError.Create(SInvalidPropertyValue);
  end;
  SetOrdValue(Longint(Component));
end;

{ TToolsControlEditor }

Procedure TToolsControlEditor.CountFCs(Const S: String);
begin
  if Pos('.',S)=0 then Inc(FCount);
end;

Procedure TToolsControlEditor.ExecuteVerb(Index: Integer);
var P: PTypeData;
var i, j: Integer;
    M: TIModuleInterface;
    FI: TIFormInterface;
    CI, CI1: TIComponentInterface;
    H: TComponent;
begin
  case Index of
    0: {if TToolsControl(Component).GetToolsForm(True)<>Nil then begin
          TToolsControl(Component).ShowModal;
          end};
    1:;
    2:;
    3: begin
         New(P);
         P^.ClassType:=TFormControl;
         FCount:=0;
         Designer.GetComponentNames(P, CountFCs);
         Dispose(P);
         TToolsControl(Component).SplashCount:=FCount;
         Designer.Modified;
       end;
    4: begin
         FCount:=0;
         for i:=0 to ToolServices.GetUnitCount-1 do begin
           M:=ToolServices.GetModuleInterface(ToolServices.GetUnitName(i));
           if Assigned(M) then
           try
             FI:=M.GetFormInterface;
             if Assigned(FI) then
               try
                 CI:=FI.GetFormComponent;
                 if Assigned(CI)then begin
                   H:=CI.GetComponentHandle;
                   if IsXFormClass(H.ClassType, 'TDataModule') then
                     for j:=0 to CI.GetComponentCount-1 do begin
                       CI1:=CI.GetComponent(j);
                       H:=CI1.GetComponentHandle;
                       if H is TFormControl then Inc(FCount);
                     end;
                 end;
               finally
                 FI.Free;
               end;
           finally
             M.Free;
           end;
         end;
         TToolsControl(Component).SplashCount:=FCount;
         Designer.Modified;
       end;
  end;
end;

Function TToolsControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Tools...';
    1: Result := 'Splash Show...';
    2: Result := 'Inf. Show... ';
    3: Result := 'Local FC''s count';
    4: Result := 'Global FC''s count';
  end;
end;

Function TToolsControlEditor.GetVerbCount: Integer;
begin
  Result := 5
end;

{ TFormControlEditor }

Procedure TFormControlEditor.ExecuteVerb(Index: Integer);
var S: String;
    Module: TIModuleInterface;
    aItem: TXLinkSourceItem;
    {FFFFF: TextFile;}
begin
  with TFormControl(Component) do
  case Index of
    0:
{      if Assigned(FormLink) and Assigned(FormLink.Owner) then}
      if Assigned(Form) then
{         with TForm(FormLink.Owner) do begin}
         with Form do begin
           S:=Name;
           Module:=ToolServices.GetFormModuleInterface(S);
           if Module<>nil then
             try
               TFormControl(Component).CreateLink;
               Module.ShowForm;
             finally
               Module.Free;
             end;
         end
      else
        if FormName<>'' then begin
          S:=GetXSource(FormName);
          if S<>'' then begin
            Module:=ToolServices.GetModuleInterface(S);
            if Module=nil then begin
              ToolServices.OpenFile(S);
              Module:=ToolServices.GetModuleInterface(S);
            end;
            if Module<>nil then
              try
  {             ActivateLinks(False);}
                Module.ShowForm;
              finally
                Module.Free;
              end
            else ShowMessage('Module '+S+' not loaded!');
          end else ExecuteVerb(1);
            {ShowMessage('Class '+FormName+' not found in this project!');}
          end;
    1:
     begin
       IsAutoEqual:=True;
       if ChildFormCreate then begin
         try
{***************
           ShowMessage('Ok');
           {TFormControl(Component).CreateLink;}
{***************}
           if not Assigned(Form) then begin
             ShowMessage('Not defined form in FormControl!');
             Exit;
           end;
           if Component is TDBFormControl then
           with TDBFormControl(Component) do
             if Assigned(CurrentSource) then begin
(*
               AssignFile(FFFFF,'c:\temp\tempik.tmp');
               Append(FFFFF);
               Writeln(FFFFF,'CurrentSource:='+CurrentSource.Name);
               Close(FFFFF);
*)
               if Form is TXDBForm then with TXDBForm(Form) do begin
                 aItem:=FindDataItem(CurrentSource);
                 (*** TEST
                 if Assigned(XPageControl) and Assigned(aItem) then
                   XPageControl.ChangeLink(TLinkSource(CurrentSource).DeclarLink,
                                           aItem.XDataLink);
                 ***)
               end;
             end;
           Form.ShowModal;
           with FormRect do if Active then begin
             FormLeft:=Form.Left;
             FormTop:=Form.Top;
             FormWidth:=Form.Width;
             FormHeight:=Form.Height;
           end;
           IsAutoEqual:=False;
         finally
{!          FormLink:=Nil;}
     {       TFormControl(Component).ActiveControl:=Nil;
            TFormControl(Component).Form.ActiveControl:=Nil;}
           Form.Free;
           Form:=nil;
           Designer.Modified;
         end;
       end;
     end;
   end;
end;

Function TFormControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Form Show...';
    1: Result := 'Data design';
  end;
end;

Function TFormControlEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

{ TDBFormControlEditor }

Procedure TDBFormControlEditor.ExecuteVerb(Index: Integer);
{var i: Integer;
    Comp: TDBFormControl;
    Src: TDataSource;}
begin
  case Index of
    2: SwapSources(TDBFormControl(Component), Designer);
    3: ShowCollectionEditorClass(Designer, TXInquiriesEditor, Component,
           TDBFormControl(Component).Inquiries, 'Inquiries');
    4: ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
           TDBFormControl(Component).Reports, 'Reports');
{    5: begin
       Comp:= TDBFormControl(Component);
       i:=0;
       While i< Comp.Inquiries.Count do begin
           Src:= Comp.Inquiries[i].Source;
           if (Src is TLinkSource)and(Comp.Sources.IndexOfLink(Src)=-1) then begin
              Comp.Sources.Add.Source:=Src;
              Comp.InQuiries[i].Free;
              end else
              Inc(i);
           end;
       end;}
    else Inherited ExecuteVerb(Index);
  end;
end;

Function TDBFormControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    2: Result:= 'Add/Del Sources';
    3: Result:= 'Inquiries editor';
    4: Result:= 'Reports editor';
{    5: Result:= 'Temp InquiriesToSources';}
    else Result:= Inherited GetVerb(Index);
  end;
end;

Function TDBFormControlEditor.GetVerbCount: Integer;
begin
  Result := 5;
end;

{ TXLinkSourcesProperty }

Function TXLinkSourcesProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

Function TXLinkSourcesProperty.GetValue: string;
begin
  if TCollection(GetOrdValue).Count>0 then
    if TCollection(GetOrdValue).Count=1 then FmtStr(Result, '(%s)', ['One source'])
    else FmtStr(Result, '(%s)', ['Some sources'])
  else FmtStr(Result, '(%s)', ['Not sources']);
end;

Procedure TXLinkSourcesProperty.Edit;
begin
  SwapSources(TDBFormControl(GetComponent(0)), Designer);
end;

{ TXControlSourceProperty }

Function TXControlSourceProperty.GetXSources: TXLinkSources;
var Comp: TPersistent;
begin
  Comp:= GetComponent(0);
  if Comp is TDBFormControl then Result:=TDBFormControl(Comp).Sources
  else Result:=TXInquiryItem(Comp).DBControl.Sources;
end;

Function TXControlSourceProperty.GetValue: string;
begin
  if TComponent(GetOrdValue)<>nil then Result:= TComponent(GetOrdValue).Name
  else Result:= Inherited GetValue;
end;

Procedure TXControlSourceProperty.SetValue(const Value: string);
var ALinks: TXLinkSources;
    i, j: Integer;
begin
  if Value<>'' then begin
    ALinks:= GetXSources;
    for i:=0 to ALinks.Count-1 do
      if ALinks[i].Source is TLinkSource then
        for j:=0 to TLinkSource(ALinks[i].Source).Sources.Count-1 do begin
          if TComponent(TLinkSource(ALinks[i].Source).Sources[j]).Name = Value then begin
            Inherited SetValue(Value);
            Exit;
          end;
        end;
    raise EPropertyError.Create(SInvalidPropertyValue);
  end;
  Inherited SetValue(Value);
end;

Procedure TXControlSourceProperty.GetValues(Proc: TGetStrProc);
var ALinks: TXLinkSources;
    i, j: Integer;
begin
  ALinks:= GetXSources;
  for i:=0 to ALinks.Count-1 do
    if ALinks[i].Source is TLinkSource then
      for j:=0 to TLinkSource(ALinks[i].Source).Sources.Count-1 do
        Proc(TComponent(TLinkSource(ALinks[i].Source).Sources[j]).Name);
end;

{ TFormSourceProperty }

Function TFormSourceProperty.GetValue: string;
{var FCName, ModName: String;}
begin
  if (Designer.Form is TXForm) and (TComponent(GetOrdValue)<>nil){ and
  GetFirstXControl(Designer.Form.ClassName,FCName,ModName)} then begin
    Result:= TComponent(GetOrdValue).Name;
  end else Result:=Inherited GetValue;
end;

Procedure TFormSourceProperty.SetValue(const Value: string);
var ALinks: TXLinkSources;
    S: String;
    FCName, ModName: String;
    Module: TIModuleInterface;
    FI: TIFormInterface;
    CI: TIComponentInterface;
    H: TComponent;

Function IsSetValue: Boolean;
var i, j: Integer;
begin
  Result:= False;
  if (H is TDBFormControl) then begin
    ALinks:=TDBFormControl(H).Sources;
    S:=Designer.GetComponentName(H);
    i:=Pos('.',S);
    if i>0 then S:=Copy(S,1,i) else S:='';
    for i:=0 to ALinks.Count-1 do
      if ALinks[i].Source is TLinkSource then
        for j:=0 to TLinkSource(ALinks[i].Source).Sources.Count-1 do
          if TComponent(TLinkSource(ALinks[i].Source).Sources[j]).Name = Value then begin
            S:=S+TComponent(TLinkSource(ALinks[i].Source).Sources[j]).Name;
            Inherited SetValue(S);
            Result:=True;
          end;
  end;
end;

begin
  if (Value<>'') and (Designer.Form is TXForm) then begin
    H:=TXForm(Designer.Form).FormControl;
    if Assigned(H) then begin
      if IsSetValue then Exit;
    end;
    if GetFirstXControl(Designer.Form.ClassName,FCName,ModName) then begin
      Module:=ToolServices.GetModuleInterface(ModName);
      if Module<>nil then
        try
          FI:=Module.GetFormInterface;
          if Assigned(FI) then
            try
              CI:=FI.FindComponent(FCName);
              if Assigned(CI)then begin
                H:=CI.GetComponentHandle;
                if IsSetValue then Exit;
              end;
            finally
              FI.Free;
            end;
        finally
          Module.Free;
        end;
    end;
  end;
  Inherited SetValue(Value);
end;

Procedure TFormSourceProperty.GetValues(Proc: TGetStrProc);
var ALinks: TXLinkSources;
    FCName, ModName: String;
    Module: TIModuleInterface;
    FI: TIFormInterface;
    CI: TIComponentInterface;
    H: TComponent;

Function SetProcLink: Boolean;
var i, j: Integer;
begin
  if (H is TDBFormControl) then begin
    ALinks:=TDBFormControl(H).Sources;
    for i:=0 to ALinks.Count-1 do
      if ALinks[i].Source is TLinkSource then
        for j:=0 to TLinkSource(ALinks[i].Source).Sources.Count-1 do
          Proc(TComponent(TLinkSource(ALinks[i].Source).Sources[j]).Name);
    Result:=True;
  end else Result:=False;
end;

begin
  if Designer.Form is TXForm then begin
    H:=TXForm(Designer.Form).FormControl;
    if Assigned(H) then begin
      if SetProcLink then exit;
    end;
    if GetFirstXControl(Designer.Form.ClassName,FCName,ModName) then begin
      Module:=ToolServices.GetModuleInterface(ModName);
      if Module<>nil then
        try
          FI:=Module.GetFormInterface;
          if Assigned(FI) then
          try
            CI:=FI.FindComponent(FCName);
            if Assigned(CI)then begin
              H:=CI.GetComponentHandle;
              if SetProcLink then Exit;
            end;
          finally
            FI.Free;
          end;
        finally
          Module.Free;
        end;
    end;
  end;
  Inherited GetValues(Proc);
end;

{ TFormProperty }

Function TFormProperty.GetValue: string;
var S: String;
    i: Integer;
begin
  S:= Designer.GetComponentName(TComponent(GetOrdValue));
  i:=Pos('.',S);
  if i>0 then S:=Copy(S,1,i-1);
  Result:=S;
end;

Procedure TFormProperty.SetValue(const Value: string);
var S: String;
begin
  S:=Value;
  if S<>'' then S:= S+'.FormLink';
  Inherited SetValue(S);
end;

Procedure TFormProperty.GetValues(Proc: TGetStrProc);
var FC: TFormControl;
    i, j: Integer;
    M: TIModuleInterface;
    FI: TIFormInterface;
    CI: TIComponentInterface;
    H: TComponent;
    S: String;

begin
  FC:=TFormControl(GetComponent(0));
  if FC.FormName<>'' then begin
    i:=RegisterXFormList.IndexOf(FC.FormName);
    if i<>-1 then begin
      S:=TXFormClass(RegisterXFormList.Objects[i]).ClassName;
    end;
    for i:=0 to ToolServices.GetUnitCount-1 do begin
      M:=ToolServices.GetModuleInterface(ToolServices.GetUnitName(i));
      if Assigned(M) then
        try
          FI:=M.GetFormInterface;
          if Assigned(FI) then
          try
            CI:=FI.GetFormComponent;
            if Assigned(CI) then begin
              H:=CI.GetComponentHandle;
              if IsXFormClass(H.ClassType, S) and (FI.FindComponent('FormLink')<>nil) then
                Proc(H.Name);
              end;
          finally
            FI.Free;
          end;
        finally
          M.Free;
        end;
    end;
  end;
end;

{ TXFormClassProperty }

Procedure TXFormClassProperty.GetValues(Proc: TGetStrProc);
var i, j: Integer;
    M: TIModuleInterface;
    S: String;
begin
  for i:= 0 to RegisterXFormList.Count-1 do begin
    Proc(RegisterXFormList.Strings[i]);
  end;

  for i:= 0 to GetXTypeCount-1 do begin
    Proc(GetXType(i));
  end;
end;

Function TXFormClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect,paValueList, paSortList, paRevertable];
end;

Function TXFormClassProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

Function TXFormClassProperty.GetValue: string;
var AClass: TXFormClass;
    i: Integer;
begin
  Result:=GetStrValue;
{  i:=RegisterXFormList.IndexOfObject(TObject(GetOrdValue));
  if i<>-1 then Result:=RegisterXFormList.Strings[i]
     else Result:='';}
end;

Procedure TXFormClassProperty.SetValue(const Value: string);
var AClass: TXFormClass;
    i: Integer;
begin
  if Value='' then SetStrValue(Value)
  else begin
    i:=GetXIndexOf(Value);
    if i<>-1 then SetStrValue(Value)
    else begin
      i:=RegisterXFormList.IndexOf(Value);
      if i<>-1 then SetStrValue(Value)
      else raise EPropertyError.Create(SInvalidPropertyValue);
    end;
  end;
end;

{ TXToolClassProperty }

Procedure TXToolClassProperty.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  for i:=0 to RegisterXToolList.Count-1 do Proc(RegisterXToolList.Strings[i]);
end;

Function TXToolClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paMultiSelect,paValueList, paSortList, paRevertable];
end;

Function TXToolClassProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

Function TXToolClassProperty.GetValue: string;
var AClass: TXFormClass;
    i: Integer;
begin
  Result:=GetStrValue;
end;

Procedure TXToolClassProperty.SetValue(const Value: string);
var AClass: TXFormClass;
    i: Integer;
begin
  if Value='' then SetStrValue(Value)
  else begin
    i:= RegisterXToolList.IndexOf(Value);
    if i<>-1 then begin
      SetStrValue(Value);
    end else raise EPropertyError.Create(SInvalidPropertyValue);
  end;
end;

{ TXSplashClassProperty }

Procedure TXSplashClassProperty.GetValues(Proc: TGetStrProc);
var i: Integer;
begin
  for i:= 0 to RegisterXSplashList.Count-1 do Proc(RegisterXSplashList.Strings[i]);
end;

Function TXSplashClassProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect,paValueList, paSortList, paRevertable];
end;

Function TXSplashClassProperty.GetEditLimit: Integer;
begin
  Result := 127;
end;

Function TXSplashClassProperty.GetValue: string;
begin
  Result:=GetStrValue;
end;

Procedure TXSplashClassProperty.SetValue(const Value: string);
var AClass: TXFormClass;
    i: Integer;
begin
  if Value='' then SetStrValue(Value)
  else begin
    i:= RegisterXSplashList.IndexOf(Value);
    if i<>-1 then SetStrValue(Value)
    else raise EPropertyError.Create(SInvalidPropertyValue);
  end;
end;

{ TPrintInquiryProperty }

Function TPrintInquiryProperty.GetAttributes: TPropertyAttributes;
begin
  if Pointer(GetOrdValue)<>nil then Result:= [paReadOnly, paDialog, paSubProperties]
  else Result := [paReadOnly];
end;

Function TPrintInquiryProperty.GetValue: string;
begin
  if Pointer(GetOrdValue)<>nil then FmtStr(Result, '(%s)', ['PrintLink'])
  else FmtStr(Result, '(%s)', ['Not Active']);
end;

Procedure TPrintInquiryProperty.Edit;
begin
  if Pointer(GetOrdValue)<>nil then
    if TPrintLink(GetOrdValue).ShowPrintDialog then Designer.Modified;
end;

end.
