unit XPipePrp;

interface

uses Classes, DsgnIntf, XLnkPipe, XDBTFC;

type

{ TXControlPipeLinkProperty }

  TXControlPipeLinkProperty = class(TComponentProperty)
  public
    function GetXPipeLinks: TXPipeLinks;
    procedure GetValues(Proc: TGetStrProc); override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TPipeControlEditor }

  TPipeControlEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TXPipeSourcesProperty }

  TXPipeSourcesProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TXPipeLinksProperty }

  TXPipeLinksProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

procedure SwapPipeLinks(AComponent: TDBFormControl; ADesigner: TFormDesigner);

implementation

uses TypInfo, SysUtils, Controls, LnkSet, DiDual, Forms, XMisc,
     ColnEdit, Consts, XReports;

function EditPipeSources(AComponent: TPipeControl; AList: TStringList;
                       ADesigner: TFormDesigner): Boolean;
var
  Form: TEtvDualListDlg;
  i, j: Integer;
  L1: TXPipeSources;
  Priz: Boolean;
  Src: TXPipeSourceItem;
  Comp: TPipeControl;
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
          if Assigned(L1[i].Source) then
             SrcList.Items.Add(L1[i].Source.Name);

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

       While i<Comp.Sources.Count do begin
             Priz:=True;
             for j:=0 to Form.SrcList.Items.Count-1 do
                 if AnsiCompareText(Comp.Sources[i].Source.Name, Form.SrcList.Items[j])=0 then begin
                    Priz:=False; Break;
                    end;
             if Priz then begin
                Comp.Sources[i].Free
                end else Inc(i);
             end;

       for i:=0 to Form.SrcList.Items.Count-1 do begin
           if Comp.Sources.IndexOfLinkName(Form.SrcList.Items[i])=-1 then begin
              Src:= Comp.Sources.Add;
              Src.Source:=TLinkSource(ADesigner.GetComponent(Form.SrcList.Items[i]));
              end;
           end;

    end;
  finally
    Form.Free;
  end;
end;

function EditPipeLinks(AComponent: TDBFormControl; AList: TStringList;
                       ADesigner: TFormDesigner): Boolean;
var
  Form: TEtvDualListDlg;
  i, j: Integer;
  L1: TXPipeLinks;
  Priz: Boolean;
  Src: TXPipeLinkItem;
  Comp: TDBFormControl;
  S: String;
begin
  Result := False;
  Form := TEtvDualListDlg.Create(Application);
  try
    with Form do begin
      Form.Caption := 'PipeControls selector';
      SrcLabel.Caption := 'Selected PipeControls';
      DstLabel.Caption := 'All PipeControls';

      L1:= AComponent.PipeLinks;
{      SrcList.Items.Assign(L1);}
      SrcList.Clear;
      DstList.Clear;
      for i:=0 to L1.Count-1 do
          if Assigned(L1[i].PipeLink) then
             SrcList.Items.Add(L1[i].PipeLink.Name);

      for i:=0 to AList.Count-1 do begin
          Priz:=True;
          for j:=0 to L1.Count-1 do
              if AnsiCompareText(AList[i], L1[j].PipeLink.Name)=0 then begin
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

       While i<Comp.PipeLinks.Count do begin
             Priz:=True;
             for j:=0 to Form.SrcList.Items.Count-1 do
                 if AnsiCompareText(Comp.PipeLinks[i].PipeLink.Name, Form.SrcList.Items[j])=0 then begin
                    Priz:=False; Break;
                    end;
             if Priz then begin
                Comp.PipeLinks[i].Free
                end else Inc(i);
             end;

       for i:=0 to Form.SrcList.Items.Count-1 do begin
           if Comp.PipeLinks.IndexOfLinkName(Form.SrcList.Items[i])=-1 then begin
              Src:= Comp.PipeLinks.Add;
              Src.PipeLink:=TPipeControl(ADesigner.GetComponent(Form.SrcList.Items[i]));
              end;
           end;

    end;
  finally
    Form.Free;
  end;
end;

procedure GetClassLinks(ADesigner: TFormDesigner; Proc: TGetStrProc; AClass: TClass);
var P: PTypeData;
begin
  New(P);
  P^.ClassType:= AClass;
  ADesigner.GetComponentNames(P, Proc);
  Dispose(P);
end;

procedure SwapPipeSources(AComponent: TPipeControl; ADesigner: TFormDesigner);
type
  TGetStrFunc = function(const Value: string): Integer of object;
var
    Values: TStringList;
    AddValue: TGetStrFunc;
begin
  Values := TStringList.Create;
  Values.Sorted := True;
  try
    AddValue := Values.Add;
    GetClassLinks(ADesigner, TGetStrProc(AddValue), TLinkSource);
    if EditPipeSources(AComponent, Values, ADesigner) then ADesigner.Modified;
  finally
    Values.Free;
  end;
end;

procedure SwapPipeLinks(AComponent: TDBFormControl; ADesigner: TFormDesigner);
type
  TGetStrFunc = function(const Value: string): Integer of object;
var
    Values: TStringList;
    AddValue: TGetStrFunc;
begin
  Values := TStringList.Create;
  Values.Sorted := True;
  try
    AddValue := Values.Add;
    GetClassLinks(ADesigner, TGetStrProc(AddValue), TPipeControl);
    if EditPipeLinks(AComponent, Values, ADesigner) then ADesigner.Modified;
  finally
    Values.Free;
  end;
end;

{ TPipeControlEditor }

procedure TPipeControlEditor.ExecuteVerb(Index: Integer);
begin
  Case Index of
    0: ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
           TPipeControl(Component).FieldMaps, 'FieldMaps');
    1: ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
           TPipeControl(Component).DataMaps, 'DataMaps');
    2: ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
           TPipeControl(Component).Pipes, 'Pipes');
    3: SwapPipeSources(TPipeControl(Component), Designer);
  end;
end;

function TPipeControlEditor.GetVerb(Index: Integer): string;
begin
  Case Index of
    0: Result:= 'FieldMaps editor';
    1: Result:= 'DataMaps editor';
    2: Result:= 'Pipes editor';
    3: Result:= 'Add/Del Sources';
  end;
end;

function TPipeControlEditor.GetVerbCount: Integer;
begin
  Result := 4
end;

{ TXPipeSourcesProperty }

function TXPipeSourcesProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

function TXPipeSourcesProperty.GetValue: string;
begin
  if TCollection(GetOrdValue).Count>0 then
     if TCollection(GetOrdValue).Count=1 then
        FmtStr(Result, '(%s)', ['One source'])
        else FmtStr(Result, '(%s)', ['Some sources'])
     else FmtStr(Result, '(%s)', ['Not sources']);
end;

procedure TXPipeSourcesProperty.Edit;
begin
  SwapPipeSources(TPipeControl(GetComponent(0)), Designer);
end;

{ TXPipeLinksProperty }

function TXPipeLinksProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

function TXPipeLinksProperty.GetValue: string;
begin
  if TCollection(GetOrdValue).Count>0 then
     if TCollection(GetOrdValue).Count=1 then
        FmtStr(Result, '(%s)', ['One link'])
        else FmtStr(Result, '(%s)', ['Some links'])
     else FmtStr(Result, '(%s)', ['Not links']);
end;

procedure TXPipeLinksProperty.Edit;
begin
  SwapPipeLinks(TDBFormControl(GetComponent(0)), Designer);
end;

{ TXControlPipeLinkProperty }

function TXControlpipeLinkProperty.GetXPipeLinks: TXPipeLinks;
var Comp: TPersistent;
begin
  Comp:= GetComponent(0);
  Result:=TXReportItem(Comp).DBControl.PipeLinks;
end;

function TXControlPipeLinkProperty.GetValue: string;
begin
  if TComponent(GetOrdValue)<>Nil then
     Result:= TComponent(GetOrdValue).Name
     else Result:= Inherited GetValue;
end;

procedure TXControlPipeLinkProperty.SetValue(const Value: string);
var ALinks: TXPipeLinks;
    i: Integer;
begin
  if Value<>'' then begin
     ALinks:= GetXPipeLinks;
     for i:=0 to ALinks.Count-1 do
         if ALinks[i].PipeLink is TPipeControl then
            if ALinks[i].PipeLink.Name = Value then begin
               Inherited SetValue(Value);
               exit;
               end;
     raise EPropertyError.Create(SInvalidPropertyValue);
     end;
  Inherited SetValue(Value);
end;

procedure TXControlPipeLinkProperty.GetValues(Proc: TGetStrProc);
var ALinks: TXPipeLinks;
    i: Integer;
begin
  ALinks:= GetXPipeLinks;
  for i:=0 to ALinks.Count-1 do
      if ALinks[i].PipeLink is TPipeControl then
         Proc(ALinks[i].PipeLink.Name);
end;

end.
