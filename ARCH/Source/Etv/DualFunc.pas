unit DualFunc;

interface
uses classes,db;

function ChooseFieldListFunc(ADataSet:TDataSet; Var SrcFieldList,DstFieldList:TList;
           SrcFieldsFunction:TStringList;
           aCaption,aSrcLabel,aDstLabel:string; aBlobs:boolean; Separate:char):boolean;

var Functions:TStringList;

Implementation
uses sysutils,menus,stdctrls,diDual,windows;

function FuncFromFF(S:string):string;
var i:integer;
begin
  Result:='';
  for i:=0 to Functions.Count-1 do
    if Pos(AnsiUpperCase(Functions[i])+'(',AnsiUpperCase(S))=1 then begin
      Result:=Functions[i];
      Break;
    end;
end;

function FieldFromFF(S:string):string;
var i,j:integer;
begin
  Result:=S;
  for i:=0 to Functions.Count-1 do
    if System.Pos(AnsiUpperCase(Functions[i])+'(',AnsiUpperCase(S))>0 then begin
      j:=length(Functions[i])+1;
      Result:=Copy(S,j+1,length(s)-j-1);
      Break;
    end;
end;

type
TPopupMenuDuFunc=class(TPopupMenu)
protected
  procedure Change(Sender: TObject);
public
  constructor Create(AOwner: TComponent); override;
end;

procedure TPopupMenuDuFunc.Change(Sender: TObject);
var i:integer;
begin
  with TListBox(PopupComponent) do if ItemIndex>=0 then begin
    i:=ItemIndex;
    if TMenuItem(Sender).MenuIndex=Functions.Count-1 then
      Items[ItemIndex]:=FieldFromFF(Items[ItemIndex])
    else Items[ItemIndex]:=Functions[TMenuItem(Sender).MenuIndex]+'('+FieldFromFF(Items[ItemIndex])+')';
    selected[i]:=true;
    ItemIndex:=i;
  end;

end;

constructor TPopupMenuDuFunc.Create(AOwner: TComponent);
var i:integer;
begin
  inherited;
  for i:=0 to Functions.Count-1 do begin
    Items.Insert(i,TMenuItem.Create(nil));
    Items[i].Caption:=Functions[i];
    Items[i].OnClick:=Change;
  end;
end;

function ChooseFieldListFunc(ADataSet:TDataSet; Var SrcFieldList,DstFieldList:TList;
           SrcFieldsFunction:TStringList;
           aCaption,aSrcLabel,aDstLabel:string; aBlobs:boolean; Separate:char):boolean;
var Dial:TEtvDualListDlg;
    i,j:integer;
    Exist:boolean;
    AllFieldsList:TList;
begin
  Result:=false;
  if Assigned(ADataSet) then begin
    Dial:=TEtvDualListDlg.Create(nil);
    with Dial do try
      Dial.SrcList.PopupMenu:=TPopupMenuDuFunc.Create(Dial.SrcList);
      if aCaption<>'' then Caption:=aCaption;
      if aSrcLabel<>'' then SrcLabel.Caption:=aSrcLabel;
      if aDstLabel<>'' then DstLabel.Caption:=aDstLabel;
      SrcList.Items.Clear;
      DstList.Items.Clear;
      with aDataset do begin
        if Assigned(SrcFieldList) then for i:=0 to SrcFieldList.Count-1 do begin
          if SrcFieldsFunction[i]<>'' then
            SrcList.Items.add(SrcFieldsFunction[i]+'('+TField(SrcFieldList[i]).DisplayLabel+')')
          else SrcList.Items.add(TField(SrcFieldList[i]).DisplayLabel);
        end;
        if Assigned(DstFieldList) then for i:=0 to DstFieldList.Count-1 do begin
          Exist:=false;
          if Assigned(SrcFieldList) then for j:=0 to SrcFieldList.Count-1 do
            if DstFieldList[i]=SrcFieldList[j] then begin
              Exist:=true;
              break;
            end;
          if Not Exist then DstList.Items.add(TField(DstFieldList[i]).DisplayLabel);
        end;
        if (SrcList.Items.Count+DstList.Items.Count>0) and (ShowModal=idOk) then begin
          AllFieldsList:=TList.Create;
          if Assigned(SrcFieldList) then
            for i:=0 to SrcFieldList.count-1 do
              AllFieldsList.Add(SrcFieldList[i]);
          if Assigned(DstFieldList) then
            for i:=0 to DstFieldList.count-1 do
              AllFieldsList.Add(DstFieldList[i]);
          Result:=true;
          SrcFieldList.Clear;
          DstFieldList.Clear;
          SrcFieldsFunction.Clear;

          for j:=0 to SrcList.Items.Count-1 do
            for i:=0 to AllFieldsList.count-1 do
              if TField(AllFieldsList[i]).DisplayLabel=FieldFromFF(SrcList.Items[j]) then begin
                SrcFieldList.Add(AllFieldsList[i]);
                SrcFieldsFunction.Add(FuncFromFF(SrcList.Items[j]));
                Break;
              end;
          for j:=0 to DstList.Items.Count-1 do
            for i:=0 to AllFieldsList.Count-1 do
              if TField(AllFieldsList[i]).DisplayLabel=FieldFromFF(DstList.Items[j]) then begin
                DstFieldList.Add(AllFieldsList[i]);
                Break;
              end;
          AllFieldsList.Free;
        end;
      end;
    finally
      Dial.Free;
    end;
  end;
end;

initialization
  Functions:=TStringList.Create;
  with Functions do begin
    Add('Sum');
    Add('Max');
    Add('Min');
    Add('Avg');
    Add('Count');
    Add('List');
    Add('Без функции');
  end;
finalization
  Functions.Free;
end.
