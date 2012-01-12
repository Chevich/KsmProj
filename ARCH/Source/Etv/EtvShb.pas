(*
--- ����� ��������
  Unit ������ ��� �������� �������, ��� ������ ��������� ��������.
��������� ������� �������� ������ ������ � ��������� ����� �, ����
����������, ���������� ������������.
   ��������� ���������� � TStringList, ��� ����� ���� ������� �� �������
� �������.
   � ������� ����������� ������� � ����, �� ������� ������� ����������.
����� �������������� ����� �� �������� (� �� ������), �������� �������
��������� ������ ������ (if else), ���������� ��������� ��������.

  ��������� ��������� ���� TEtvShb, ��� ����� �������� �� ����� � ���������
��� ��������� � Runtime. ����������� ������ � ��������� ����� ��������
������������ ���� ��������. �����������, ���� �����, ����� � TDataSet'��
��� ������ AssignDataSet � ���� �������������� ������� - AssignAdditional.
��������� ����������� � �������� � ����������� ���� �� ������� -
Fill, RunViewer, RunModalViewer.

--- ���������

1) ��������
Caption - �������� ������ ��� ������ � ���������� �����, ����������
DosFile - ���������� ��������� Dos/Windows ����� �������.
FileName - ���� ������� ��� ����������. ���������� ������ ���� "Shb".
HeaderInText - ����� ��� ��� ������� ��������� (��. ������ ���������)
               �������� � �����.
2) ����
  Header:TStringList;  ���� ���������� ���������
  Text:TStringList;    ��� ���������
  Delimetr:char;       ������-�����������, �� ��������� '|',
    ���� ������ ���������� ��� ������ ����� � ��������� �����

3) ������
  procedure AssignAdditional(Name, Value:string; Alignment:TALignment;
    Pack:boolean); - ����������� ���� �������������� �������
    (��. ������ ���� ������ ����� 4)
  procedure AssignDataSet(Name:string; DataSet:TDataSet); ����������
    ���������� ���� TDataSet � ������ (��. ������ ���� ������ ����� 2)
  function Fill:boolean;  ��� ������� ��������� ��� ������. �� �� �
    ���� ��������. ��������� true - ���� ��� ������ ������.
  procedure RunViewer;       \ �������� Fill, ������� ��������� ��
  procedure RunModalViewer;  / �������(�������) � ������� ���������.

--- ���� ������

1.  DataModule:Table.Field,SubField - ������ �������� �� ������
���� DataModule �� ������, �.� ������ ���������� � ������� ':' -
    :Table.Field,SubField
������� ����� ������������� � ����� DataModule ���������.

2. Table.Field,SubField - ������ ���������� � �������� Table
��� ������� ':' ����� ���. � ���� ������ Table - �� ��������
��������� ����������. ����� ����� ����������� � ������ Table
��������������� ������������� ��� ������ ��������� ���������:
   procedure AssignDataSet(Name:string; DataSet:TDataSet);
 ���� ������ ������� ��������������� ���� ���������, �� ��������
����� ������ � ���� ����� ������� ��� �������� ������������.

3. SubField � ���������� ������� - ��� �������� ������ �� �����
�������� LookupResultField �, �����������, ������������ ������ �
��������� ������.

4. ������ ���������� ���������� ������� � ����� ������������ �������,
��� ���������� "A" - ��� ��������� �����. "����" ���� ������ � ��
�������� ����������� ���������� ��� ������ ��������� ���������:
procedure AssignAdditional(Name,Value:string;
                           Alignment:TALignment;Pack:boolean);
�������� Pack ����������, ����� �� ������������ ������ ������
������������ �������, ��� ����� ����������� ��� �������� ����������.

5. ������ ����������� ���� ������� ����� ������� ���� �� ���������
��������:
      VisibleFields  - �������� ��� ����, ��� Visible=true
      AllFields      - �������� ��� ����
      UserFields     - �������� ��� ����, ��� Tag<>8

--- ������������� ���� ������
  ������ ">" ���������� ������� ���� ������, ������� ������ ����
�������� ���������:
                  <     FieldName1    >
���
           �����_��_�������    FieldName1  >

 FieldName1 - ��� �������� ���� ������ (�������� ��. � ������� ����).
������� "<" � ">" ������������ ������� ������ � �� ����� �����.
���� ������ "<" �����������, ������� ������ �������������� �����
������ ������������� �������� ��� ������� ��� ������� ������.
������������ ������� �� �������� TField'�.
���������: ������ "<" �� �������� ��������� ������� ���� ������.

--- ���������������

   ���� �����-���� �������� �� ������ � ������� ������ ��� ������
�������� ������� �������, ���������� ����������� �������������� ���:
                    #NewName=OldName
��� ������ ��������� ���������������:
   #Name1=DM1:Table1.Field1,SubField1    \
   #Name2=DM1:Table1.Field1               \  ��� �������-����������
   #Name3=DM1:Table1                      /
   #Name4=DM1                           /
   #Name5=Table1.Field1,SubField1   \
   #Name6=Table1.Field1              \  ��� ������� - ��������
   #Name7=Table2                    /
�.�. ��������������� ������ ���� �� ������ ��������.

--- ������� �� ���������

  ���� ������� ����� ������� �������� �� ���������:
         #Default=TbName1   ���    #Default=DM1:TbName1
  ����� ���� ����� �������� �������� �������. ���������� �������� ��
��������� �������� �������������� ������� "A".

--- ���� �� �������
  ����������� ����� �� ���� ������� �������:
    For  Table1            For Table1
      ...          ���       ...
    End                    Sum
                             ...
                           End
���������� ����� ����� ���������� ��� ���� ������� Table1. ����
�������� ������� ����������� - �� Default �������(��. ������ �������
�� ���������) ������ Sum .. End  ����������� ����� �� �������� �����
� �������� �� ����� ���������� ������� �����. ��������� ����� ������
���������, �� �� � ������� Sum .. End.

--- ���� �� �������
  ������ ���������� ������������ ���� �� �� ������� �������, � �����-��
������, ����� ������ �������. � ���� ������ ������������:
    While Condition1                   While Condition1
      ...                    ���         ...
    End                                Sum
                                         ...
                                       End

    ����������� ������ ������� ������� ��� ������� OnCondition. ��
����� �������� �������� �������, ��� String. � ����� ������ ��� �����
"Condition1". ����������� ���� ������� �� ��� ����� � ��� ��������
���������(������ ����). ���� ��������, ���� ������� �� ������ False.
������ Sum .. End - ���������� ����� For.

--- �������� ��������
����������� ��������� ����������:
      If  Condition1                  If Condition1
        ..                 ���          ..
      End                             Else
                                        ..
                                      End

�������� ������� ���������� ����� �� ������� (��. ����)

--- ������� �������� � MEMO ����.
��� ���������� ���������� � ��������� ����� ���������� ��� �������
  1)  ���� ������� ������ ����� ����������:
       <    Name+          >     ...
       <   +Name           >     ...
         ..
       <   +Name           >     ...
  2) ����  ���������� ������ ���������� ���������� �� �����
      <     Name*          >     ...
    ��� ���� �������� ����� ����������� ������ ��� ���������� ������
    ����������, ������� ������ ����� ���������. ������ �� ��������
    Delimetr ����������

--- ���������
  ��� ������� ������� ���������, �.�. �������, ������������� �� ������
��������� ������������ ����:
  Header
    ..
  End

--- ������

1.  // - �������

2.  ����� "Blank" ��� ������ "@" � ����� ������ ��������, ��� ���
������ ����� ���������� ������ ���� ��� �� �����.

3. ����� "Page" ����� �������� �� ������ � ����� 12 - ������� �����
��������.

4. ���� ���� ��� ������� �� �������, �.�. ����������� ����� "End",
�� ���� ���� ����� ������ ������ �������

5. �������� ����� ������ ���������� �� ��������� ������

--- ������

#1=Sprot.LField,Name  ��������������� ������� "Sprot.LField,Name" �� "1"
#Tb1=dm1:TbSprOt ��������������� �������
#Default=SprOt  ������� �� ���������
// ��� ������� ���������� �� �����
  ����� �� ����� ��������� // ��� ������ �����, ������������ ��� ����

header   ��� ���������
  ����  <          A.Date      >
 �������������  <          Department.Name        >
end

FOR :tbsprBo     ���� �� �������
< :tbsprBo.kod > < :TbSprBo.Name      >  <  :TbSprBo.Summa  >
  for
<  Name                            >
  end
sum
==============================
 ����� : <    :TbSprBo.Summa >
End

Page

while TreeNode  ��� ���� �� �������
<                    1    >
  if IfNeed
<                    Name*  >
  else
  Kod>  <         Name+>               _______
        <        +Name >              |_______|
        <        +Name > @
        <        +Name > Blank
  end
end

< Tb1.VisibleFields                 >
// ����� �������
*)

unit EtvShb;

interface
uses classes,db,etvPas,EtvMem;

type
TAItem=class
  Pack:boolean;
  Alignment:TALignment;
  Name,Value:string;
end;
TTbItem=class
  WasOpen:boolean;
  DataSet:TDataSet;
  Name:string;
  {BookMark:TbookMark;}
end;
TDefItem=class
  Name:string;
  NewName:string;
end;
TRestItem=class
  DataSet:TDataSet;
  FieldName:string;
  Name:string;
  Rest:string;
end;
TSumItem=class
  Field:TField;
  Value:variant;
end;

TTypeBlock=(blNone,blFor,blWhile,blSum,blIf,blElse,blHeader);
TBlockItem=class
  Sum:boolean;
  TBlock:TTypeBlock;
  NumTb:Smallint;
  CurLine:smallint;
  SumLine:smallint;
  NameWhile:string;
end;

TShbConditionEvent=function(Sender: TObject; aName:string):boolean of object;
TShbFieldEvent=procedure(Sender: TObject; var S:string;
  aDataSet:TDataSet; aFieldName:string) of object;
TShbSumFieldEvent=procedure(Sender: TObject; Value:Variant; var S:string;
                            aField:TField) of object;

TWrt=(wrPrint,wrSum,wrPrintSum);

TEtvShb=class(TComponent)
protected
  fDOSFile:boolean;
  fHeaderInText:boolean;
  fHyphen:boolean;
  CurLine:word;
  fDefaultTable:smallint;
  Data:TStringList;
  Definitions,
  Blocks,
  Rests,
  Sums:TListObj;
  Memos:TStringList;
  fCondition:TShbConditionEvent;
  fWrt:TWrt;
  fBeforeFieldPrint:TShbFieldEvent;
  fBeforeSumFieldPrint:TShbSumFieldEvent;
  fCaption:String;
  fFileName:String;
  procedure ShowError(s:string);
  procedure ChangeToDef(var Name:string);
  function NumDataSet(Name:string; Absolut:boolean):smallint;
  function NumAdditional(Name:string):smallint;
  procedure OpenDataSets;
  procedure CloseDataSets;
  procedure SetFileName(AFileName:string);
  function ReadFile:boolean;
  function FillStr(Str:string):string;
public
  Delimetr:char;
  Additional,DataSets:TListObj;
  Header:TStringList;  (* ��������� *)
  Text:TStringList;  (* ��������� *)
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  procedure AssignAdditional(Name,Value:string; Alignment:TALignment;Pack:boolean);
  procedure AssignDataSet(Name:string; DataSet:TDataSet);
  function Fill:boolean; (* ���������� Viewer *)
  procedure RunViewer;
  procedure RunModalViewer;
published
  property Caption:String read fCaption write fCaption;
  property FileName:String read fFileName write SetFileName;
  property DOSFile:boolean read fDOSFile write fDOSFile;
  property HeaderInText:boolean read fHeaderInText write fHeaderInText;
  property Hyphen:boolean read fHyphen write fHyphen;
  property OnBeforeFieldPrint:TShbFieldEvent
    read fBeforeFieldPrint write fBeforeFieldPrint;
  property OnBeforeSumFieldPrint:TShbSumFieldEvent
    read fBeforeSumFieldPrint write fBeforeSumFieldPrint;
  property OnCondition:TShbConditionEvent read fCondition write fCondition;
end;

implementation
uses Windows,Forms,SysUtils,dialogs,Controls,
     EtvView,EtvForms,EtvPrint,EtvDb,EtvLook,EtvDBFun;

procedure TEtvShb.ShowError(s:string);
begin
  EtvApp.DisableRefreshForm;
  if MessageDlg(s, mtError, [mbOk, mbCancel],0) = idCancel then begin
    EtvApp.EnableRefreshForm;
    Abort;
  end else EtvApp.EnableRefreshForm;
end;

Procedure TEtvShb.ChangeToDef(var Name:string);
var i:smallint;
    s:string;
begin
  if Assigned(Definitions) then
    for i:=0 to Definitions.count-1 do begin
      s:=AnsiUpperCase(TDefItem(Definitions.items[i]).NewName);
      if (Copy(AnsiUpperCase(Name),1,Length(s))=s) and
         ((Length(s)=Length(Name)) or
          (Name[Length(s)+1] in [':','.',','])) then begin
        Name:=TDefItem(Definitions.items[i]).Name+copy(Name,Length(s)+1,length(Name));
        Exit;
      end;
    end;
end;

Function TEtvShb.NumDataSet(Name:string; Absolut:boolean):smallint;
var i,j:smallint;
    DmName,TbName:string;
begin
  Result:=-1;
  for i:=0 to DataSets.Count-1 do
    if AnsiUpperCase(TTbItem(DataSets.items[i]).Name)=AnsiUpperCase(Name) then begin
      Result:=i;
      Exit;
    end;
  if Absolut and (Pos(':',Name)>0) then begin
    DmName:=AnsiUpperCase(Copy(Name,1,Pos(':',Name)-1));
    TbName:=AnsiUpperCase(Copy(Name,Pos(':',Name)+1,length(Name)));
    For i:=0 to Screen.DataModuleCount-1 do
      if (DmName='') or (AnsiUpperCase(Screen.DataModules[i].Name)=DmName) then
        For j:=0 to Screen.DataModules[i].ComponentCount-1 do begin
          if (TbName=AnsiUpperCase(Screen.DataModules[i].Components[j].Name)) and
             (Screen.DataModules[i].Components[j] is TDataSet) then begin
            AssignDataSet(Name,TDataSet(Screen.DataModules[i].Components[j]));
            Result:=DataSets.Count-1;
            Exit;
          end;
    end;
  end;
end;

Function TEtvShb.NumAdditional(Name:string):smallint;
var i:smallint;
begin
  Result:=-1;
  for i:=0 to Additional.Count-1 do
    if AnsiUpperCase(TaItem(Additional.items[i]).Name)=AnsiUpperCase(Name) then begin
      Result:=i;
      Exit;
    end;
end;

Procedure TEtvShb.OpenDataSets;
var i:smallint;
begin
  for i:=0 to DataSets.Count-1 do
    if Assigned(TTbItem(DataSets.items[i]).DataSet) and
       (Not TTbItem(DataSets.items[i]).DataSet.Active) then
      TTbItem(DataSets.items[i]).DataSet.Open;
end;

Procedure TEtvShb.CloseDataSets;
var i:smallint;
begin
  for i:=0 to DataSets.Count-1 do
    if Assigned(TTbItem(DataSets.items[i]).DataSet) and
       (Not TTbItem(DataSets.items[i]).WasOpen) and
       TTbItem(DataSets.items[i]).DataSet.Active then
      TTbItem(DataSets.items[i]).DataSet.Close;
end;

procedure TEtvShb.SetFileName(AFileName:String);
begin
  fFileName:=AFileName;
end;

function TEtvShb.ReadFile:boolean;
var f:System.text;
    s,NewN,OldN:string;
    Exist:boolean;
    numStr:smallint;
    DefItem:TDefItem;
begin
  Result:=false;
  AssignFile(f,fFileName+'.shb');
  {$I-}
  Reset(f);
  {$I+}
  if IOResult<>0 then begin
    EtvApp.ShowMessage('������ '+fCaption+#10+'���� '+fFilename+#10+'������ ��� ���������� � �����!');
    Exit;
  end;
  Data:=TStringList.Create;
  numStr:=0;
  while not(EOF(F)) do begin
    Readln(f,S);
    if fDosFile then s:=Oem2Char(s);
    inc(NumStr);
    if (s<>'') and (Pos('//',s)>0) then begin
      s:=Copy(s,1,Pos('//',s)-1);
      if s='' then Continue;
    end;
    if Pos('PAGE',AnsiUpperCase(s))>0 then
      s:=copy(s,1,Pos('PAGE',AnsiUpperCase(s))-1)+#12+
           copy(s,Pos('PAGE',AnsiUpperCase(s))+4,length(s));
    if (s<>'') and (s[1]='#') then begin
      (* Definition *)

      Exist:=true;
      if Pos('=',s)>0 then begin
        NewN:=trim(copy(s,2,Pos('=',s)-2));
        OldN:=trim(copy(s,Pos('=',s)+1,length(s)));
        OldN:=CutFirstWord(OldN,FiguresCharSet+['.',',']);

        if (OldN<>'') and (NewN<>'') then begin
          DefItem:=TDefItem.Create;
          DefItem.Name:=OldN;
          DefItem.NewName:=NewN;
          Definitions.Add(DefItem);
        end else Exist:=false;
      end else Exist:=false;
      if Not Exist then
        ShowError('�������� ���������������!'+
          #10+'���� '+fFileName+
          #10+'������ � '+IntToStr(NumStr));
      Continue;
    end;
    while (s<>'') and (s[length(s)]=' ') do s:=copy(s,1,length(s)-1);
    Data.Add(s);
  end;
  close(f);
  CurLine:=0;
  Result:=true;
end;

Constructor TEtvShb.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  fCaption:='';
  fFileName:='';
  fDefaultTable:=0;
  fDOSFile:=false;
  fHeaderInText:=true;
  fHyphen:=false;
  Delimetr:='|';
  Definitions:=TListObj.Create;
  Rests:=TListObj.Create;
  Sums:=TListObj.Create;
  DataSets:=TListObj.create;
  Memos:=TStringList.Create;
  Additional:=TListObj.create;
  AssignDataSet('a',nil);
end;

Destructor TEtvShb.Destroy;
begin
  if Assigned(Data) then Data.free;
  if Assigned(Header) then Header.free;
  if Assigned(Text) then Text.free;
  if Assigned(Additional) then Additional.free;
  if Assigned(DataSets) then DataSets.free;
  if Assigned(Definitions) then Definitions.free;
  if Assigned(Blocks) then Blocks.free;
  if Assigned(Rests) then Rests.free;
  if Assigned(Sums) then Sums.free;
  if Assigned(Memos) then Memos.free;
  inherited Destroy;
end;

Function TEtvShb.FillStr(str:string):string;
var s,sMemos,Name,TbName,FieldName,SubFieldName,Restik:string;
    TbIndex:smallint;
    i,j,k,IndMemos:integer;
    Exist:boolean;
    Field:TField;
    InfiniteResting,Resting:boolean;
    RestItem:TRestItem;

function Wrt(Var S:String; Str:string;Align:TAlignment; Pack,Number:boolean;
             aDataSet:TDataSet; aFieldName:string):string;
var s0:string;
    u:smallint;
    Exist:boolean;
begin
  while Pos(#13+#10,Str)>0 do
    Str:=Copy(Str,1,Pos(#13+#10,Str)-1)+' '+Copy(Str,Pos(#13+#10,Str)+2,Length(str));
  if Number and (Length(Str)>i-j+1) then Str:=SymbRepeat('*',i-j+1);
  s0:=sform(Str,i-j+1,Align);
  if Resting and (Align=taLeftJustify) and (Not Pack) then begin
    u:=i-j+1;
    if (Length(str)>Length(s0)) and (str[u+1]<>' ') and
       (Not(str[u] in [' ','-','.',',',';',':','!','?'])) then begin
      Exist:=false;
      if fHyphen then begin
        if (str[u] in Letters) and (str[u-1] in Letters) then
          if str[u+1] in Letters then begin
            Dec(u);
            s0:=copy(s0,1,u)+'-';
            Exist:=true;
          end else
            if str[u-2] in Letters then begin
              Dec(u,2);
              s0:=copy(s0,1,u)+'- ';
              Exist:=true;
            end;
      end;
      if Not Exist then begin
        while(s0<>'') and (Not (s0[length(s0)] in [' ','-','.',',',';',':','!','?'])) do begin
          s0:=copy(s0,1,Length(s0)-1);
          dec(u);
        end;
        if s0='' then begin
          s0:=sform(Str,(i-j+1)-1,taLeftJustify)+'-';
          u:=(i-j+1)-1;
        end;
        s0:=sform(s0,i-j+1,taLeftJustify);
      end;
    end;
    Result:=TrimLeft(Copy(Str,u+1,Length(str))); (* ������� ������ *)
  end else Result:='';
  if Pack then s0:=Trim(s0);
  if Assigned(fBeforeFieldPrint) then fBeforeFieldPrint(self,S0,aDataSet,aFieldName);
  S:=Copy(s,1,j-1)+s0+copy(s,i+1,length(s)-i);
  i:=i - ((i-j+1)-Length(s0));
end;

procedure AddSum(aField:TField);
var i,index:smallint;
    SumItem:TSumItem;
begin
  if Field is TNumericField then begin
    index:=-1;
    for i:=0 to Sums.Count-1 do
      if TSumItem(Sums[i]).Field=aField then begin
        Index:=i;
        Break;
      end;
    if Index=-1 then begin
      SumItem:=TSumItem.Create;
      SumItem.Field:=aField;
      SumItem.Value:=0;
      Sums.Add(SumItem);
      Index:=Sums.Count-1;
    end;
    if aField.Value<>null then
      TSumItem(Sums[index]).value:=TSumItem(Sums[index]).value+aField.Value;
  end;
end;

procedure WrtSum(aField:TField);
var i:smallint;
    s0:string;
begin
  for i:=0 to Sums.Count-1 do
    if TSumItem(Sums[i]).Field=aField then begin
      s0:='';
      if aField is TNumericField then
        s0:=FormatFloat(TNumericField(aField).DisplayFormat,TSumItem(Sums[i]).value);
      if Assigned(fBeforeSumFieldPrint) then
        fBeforeSumFieldPrint(self,TSumItem(Sums[i]).value,s0,aField);
      Wrt(S,s0,aField.Alignment,false,true,aField.DataSet,aField.FieldName);
      Sums.DeleteFull(i);
      Break;
    end;
end;

Begin
  s:=Str;
  i:=1;
  while i<=Length(s) do begin
    if s[i]='>' then begin
      j:=i-1;
      while (j>0) and (s[j]=' ') do Dec(j);
      while (j>0) and
            (s[j] in ['*','+','0'..'9',':','.',',','_','a'..'z','A'..'Z','�'..'�','�'..'�']) do
        Dec(j);
      Name:=Trim(copy(s,j+1,i-j-1));
      while (j>0) and (s[j]=' ') do Dec(j);
      if (j=0) or (s[j]<>'<') then Inc(j);

      Resting:=false;
      InfiniteResting:=false;
      if Name<>'' then begin
        if Name[1]='+' then begin
          Name:=Copy(Name,2,Length(Name)-1);
          Resting:=true;
          ChangeToDef(Name);
          Exist:=false;
          for k:=0 to Rests.count-1 do
            if AnsiUpperCase(TRestItem(Rests[k]).name)=AnsiUpperCase(Name) then begin
              TRestItem(Rests[k]).Rest:=
                Wrt(S,TRestItem(Rests[k]).Rest,taLeftJustify,false,false,
                TRestItem(Rests[k]).DataSet,TRestItem(Rests[k]).FieldName);
              if TRestItem(Rests[k]).Rest='' then Rests.DeleteFull(k);
              Exist:=true;
              break;
            end;
          if Not Exist then Wrt(S,'',taLeftJustify,false,false,nil,'');
          Inc(I);
          Continue;
        end;
        if Name[Length(Name)]='+' then begin
          Name:=Copy(Name,1,Length(Name)-1);
          Resting:=true;
        end;
        if Name[Length(Name)]='*' then begin
          Name:=Copy(Name,1,Length(Name)-1);
          Resting:=true;
          InfiniteResting:=true;
        end;
      end;

      ChangeToDef(Name);
      if Pos('.',Name)>0 then begin
        TbName:=copy(Name,1,Pos('.',Name)-1);
        FieldName:=copy(Name,Pos('.',Name)+1,Length(Name));
        TbIndex:=NumDataSet(TbName,true);
      end else begin
        if Name<>'' then begin
          TbIndex:=fDefaultTable;
          TbName:=TTbItem(DataSets.items[TbIndex]).name;
          FieldName:=Name;
        end else begin
          TbIndex:=-1;
          TbName:='';
        end;
      end;
      if Pos(',',FieldName)>0 then begin
        SubFieldName:=Copy(FieldName,pos(',',FieldName)+1,length(FieldName));
        FieldName:=Copy(FieldName,1,pos(',',FieldName)-1);
      end else SubFieldName:='';
      if TbIndex>=0 then begin
        Restik:='';
        Exist:=false;
        if TbIndex=0 then begin
          k:=NumAdditional(FieldName);
          if k>=0 then begin
            Restik:=wrt(S,TaItem(Additional.items[k]).Value,
                TaItem(Additional.items[k]).Alignment,
                TaItem(Additional.items[k]).Pack,false,
                nil,TaItem(Additional.items[k]).Name);
            exist:=true;
          end;
        end
        else begin
          if (AnsiCompareText(FieldName,VisibleFields)=0) or
             (AnsiCompareText(FieldName,AllFields)=0) or
             (AnsiCompareText(FieldName,UserFields)=0) then begin
            Restik:=wrt(S,DataSetPrintRecord(TTbItem(DataSets.items[TbIndex]).DataSet,FieldName),
                taLeftJustify,false,False,
                TTbItem(DataSets.items[TbIndex]).DataSet,FieldName);
            Exist:=true;
          end else begin
            Field:=TTbItem(DataSets.items[TbIndex]).DataSet.FindField(FieldName);
            if Assigned(Field) then begin
              if (Field is TEtvLookField) and (SubFieldName<>'') then begin
                if TEtvLookField(Field).CheckByLookName(SubFieldName) then
                  case fWrt of
                    wrPrint: Restik:=wrt(S,TEtvLookField(Field).StringByLookName(SubFieldName),
                      TEtvLookField(Field).FieldByLookName(SubFieldName).Alignment,false,
                      TEtvLookField(Field).FieldByLookName(SubFieldName) is TNumericField,
                      Field.DataSet,Field.FieldName);
                    wrSum: AddSum(TEtvLookField(Field).FieldByLookName(SubFieldName));
                    wrPrintSum: WrtSum(TEtvLookField(Field).FieldByLookName(SubFieldName));
                  end
                else ShowError('������� '+SubFieldName+' �� �������!'+
                           #10+'���� '+FieldName+
                           #10+'������� '+TbName+
                           #10+'���� '+fFileName+
                           #10+'�������� ������ # '+IntToStr(CurLine+1));
              end else
                case fWrt of
                  wrPrint: if (Field is TNumericField) and (Field.Value<>null) then
                      Restik:=wrt(S,FormatFloat(TNumericField(Field).DisplayFormat,Field.value),
                        Field.Alignment,false,true,Field.DataSet,Field.FieldName)
                    else
                      Restik:=wrt(S,Field.AsString,Field.Alignment,false,Field is TNumericField,
                        Field.DataSet,Field.FieldName);
                  wrSum: AddSum(Field);
                  wrPrintSum: WrtSum(Field);
                end;
              Exist:=true;
            end;
          end;
        end;
        if Not Exist then ShowError('���� '+FieldName+' � ������ ��������� �����'+
          #10+'�� �������!'+
          #10+'������� '+TbName+
          #10+'���� '+fFileName+
          #10+'�������� ������ # '+IntToStr(CurLine+1));
        if Resting and (Restik<>'') then begin
          if InfiniteResting then begin
            IndMemos:=0;
            while Restik<>'' do begin
              if Memos.Count-1<IndMemos then Memos.Add('');
              sMemos:=Memos[IndMemos];
              while Length(sMemos)<I do sMemos:=sMemos+' ';
              if TbIndex>0 then
                Restik:=Wrt(sMemos,Restik,taLeftJustify,false,false,
                  TTbItem(DataSets.items[TbIndex]).DataSet,FieldName)
              else Restik:=Wrt(sMemos,Restik,taLeftJustify,false,false,nil,FieldName);
              Memos[IndMemos]:=sMemos;
              Inc(IndMemos);
            end;
          end else begin
            RestItem:=TrestItem.create;
            RestItem.Name:=name;
            if TbIndex>0 then RestItem.DataSet:=TTbItem(DataSets.items[TbIndex]).DataSet
            else RestItem.DataSet:=nil;
            RestItem.FieldName:=FieldName;
            RestItem.Rest:=Restik;
            Rests.Add(RestItem);
          end;
        end;
      end else if TbName<>'' then
        ShowError('������� '+TbName+' � ������ ��������� ������'+
          #10+'�� �������!'+
          #10+'���� '+fFileName+
          #10+'�������� ������ # '+IntToStr(CurLine+1));
    end;
    Inc(i);
  end;
  Result:=s;
  if Memos.Count>0 then for i:=1 to length(Str) do
    if Str[i]=Delimetr then
      for indMemos:=0 to Memos.Count-1 do begin
        while Length(Memos[IndMemos])<I do
          Memos[IndMemos]:=Memos[IndMemos]+' ';
        if Memos[IndMemos][i]=' ' then
          Memos[IndMemos]:=Copy(Memos[IndMemos],1,i-1)+Delimetr+
                           Copy(Memos[IndMemos],i+1,Length(Memos[IndMemos]));
      end;
end;

Function TEtvShb.Fill;
var s,NameBlock:string;
    NumTb:smallint;
    i,j,IndMemos:integer;
    Exist:boolean;
    BlockItem:TBlockItem;
    TBlock:TTypeBlock;
    fHeader:boolean;

function FindKeyWord(s:string):TTypeBlock;
begin
  Result:=blNone;
  if (s<>'') then begin
    if AnsiUpperCase(copy(trim(s),1,3))='FOR' then Result:=blFor
    else if AnsiUpperCase(copy(trim(s),1,5))='WHILE' then Result:=blWhile
     else if AnsiUpperCase(copy(trim(s),1,3))='SUM' then Result:=blSum
      else if AnsiUpperCase(copy(trim(s),1,2))='IF' then Result:=blIf
       else if AnsiUpperCase(copy(trim(s),1,4))='ELSE' then Result:=blElse
        else if AnsiUpperCase(copy(trim(s),1,6))='HEADER' then
          Result:=blHeader;
  end;
end;

procedure GotoEnd;
var CountWord:smallint;
begin
  CountWord:=1;
  Inc(CurLine);
  while CurLine<=Data.Count-1 do begin
    if ((Data[CurLine]<>'') and
        (AnsiUpperCase(copy(trim(Data[CurLine]),1,3))='END')) then begin
      Dec(CountWord);
      if CountWord=0 then Exit;
    end;
    if not (FindKeyWord(Data[CurLine]) in [blNone,blSum,blElse]) then Inc(CountWord);
    Inc(CurLine);
  end;
end;

function GotoElse:boolean;
var CountWord:smallint;
    TBlock:TTypeBlock;
begin
  Result:=false;
  CountWord:=1;
  Inc(CurLine);
  while CurLine<=Data.Count-1 do begin
    if ((Data[CurLine]<>'') and
        (AnsiUpperCase(copy(trim(Data[CurLine]),1,3))='END')) then begin
      Dec(CountWord);
      if CountWord=0 then Exit;
    end;
    TBlock:=FindKeyWord(Data[CurLine]);
    if (CountWord=1) and (TBlock=blElse) then begin
      Result:=true;
      Exit;
    end else
      if not (TBlock in [blNone,blSum,blElse]) then Inc(CountWord);
    Inc(CurLine);
  end;
end;

Begin
  Result:=false;
  if Not ReadFile then Exit;
  for i:=0 to Definitions.Count-1 do
    if AnsiUpperCase(TDefItem(Definitions.items[i]).NewName)='DEFAULT' then
      for j:=0 to DataSets.Count-1 do
        if AnsiUpperCase(TDefItem(Definitions.items[i]).Name)=
           AnsiUpperCase(TTbItem(DataSets.items[j]).Name) then begin
          fDefaultTable:=j;
          break;
        end;
  if Not Assigned(Text) then Text:=TStringList.Create;
  Text.Clear;
  if Not Assigned(Header) then Header:=TStringList.Create;
  Header.Clear;

  OpenDataSets;
  if Not Assigned(Blocks) then Blocks:=TListObj.Create;
  fHeader:=false;
  fWrt:=wrPrint;
  while (CurLine<=Data.count-1) or (Blocks.Count>0) do begin
    if CurLine<=Data.count-1 then begin
      s:=Data[CurLine];

      TBlock:=FindKeyWord(s);
      if TBlock=blHeader then fHeader:=true;

      if TBlock<>blNone then begin
        case TBlock of
          blFor: begin
            NameBlock:=copy(trim(s),4,length(s));
            NameBlock:=CutFirstWord(Trim(NameBlock),FiguresCharSet+RussianCharSet+[':']);
            if NameBlock='' then NumTb:=fDefaultTable
            else NumTb:=NumDataSet(NameBlock,true);

            if NumTb>0 then begin
              Exist:=false;
              for i:=0 to Blocks.count-1 do
                if TBlockItem(Blocks[i]).NumTb=NumTb then Exist:=true;
              if Not Exist then begin
                TTbItem(Datasets.items[NumTb]).DataSet.First;
                if Not TTbItem(Datasets.items[NumTb]).DataSet.EOF then begin
                  BlockItem:=TBlockItem.create;
                  BlockItem.TBlock:=blFor;
                  BlockItem.NumTb:=NumTb;
                  BlockItem.CurLine:=CurLine+1;
                  BlockItem.Sum:=false;
                  Blocks.Add(BlockItem);
                end else GotoEnd;
              end
              else ShowError('������� ���� �� ����� �������'+
                    #10+'������� '+NameBlock+
                  #10+'���� '+fFileName+
                  #10+'�������� ������ # '+IntToStr(CurLine+1));
            end else ShowError('� ������ ��������� ������'+
                #10+'����������� ������� ��� ����� '+NameBlock+'!'+
                #10+'���� '+fFileName+
                #10+'�������� ������ # '+IntToStr(CurLine+1));
          end;
          blWhile: begin
            NameBlock:=copy(trim(s),6,length(s));
            NameBlock:=CutFirstWord(Trim(NameBlock),FiguresCharSet+RussianCharSet);
            if Assigned(fCondition) and fCondition(self,NameBlock) then begin
              BlockItem:=TBlockItem.create;
              BlockItem.TBlock:=blWhile;
              BlockItem.NameWhile:=NameBlock;
              BlockItem.CurLine:=CurLine+1;
              BlockItem.Sum:=false;
              Blocks.Add(BlockItem);
            end else GotoEnd;
          end;
          blSum: Begin
            if (Blocks.Count>0) and (fWrt=wrPrint) and (TBlockItem(Blocks.Items[Blocks.Count-1]).tBlock in [blFor,blWhile]) then begin
              TBlockItem(Blocks.Items[Blocks.Count-1]).Sum:=true;
              TBlockItem(Blocks.Items[Blocks.Count-1]).SumLine:=CurLine+1;
              fWrt:=wrSum;
            end else ShowError('����� ��� ����� ��� ����� � �����'+
                  #10+'���� '+fFileName+
                  #10+'�������� ������ # '+IntToStr(CurLine+1));
          end;
          blIf: begin
            NameBlock:=copy(trim(s),3,length(s));
            NameBlock:=CutFirstWord(Trim(NameBlock),RussianCharSet);
            if Assigned(fCondition) and fCondition(self,NameBlock) then begin
              BlockItem:=TBlockItem.create;
              BlockItem.TBlock:=blIf;
              Blocks.Add(BlockItem);
            end else begin
              if GotoElse then begin
                BlockItem:=TBlockItem.create;
                BlockItem.TBlock:=blElse;
                Blocks.Add(BlockItem);
              end;
            end;
          end;
          blElse: begin
            if (Blocks.Count>0) and (TBlockItem(Blocks.Items[Blocks.Count-1]).tBlock=blIf) then begin
              Blocks.DeleteFull(Blocks.Count-1);
              GotoEnd;
            end else ShowError('ELSE ��� IF'+
                  #10+'���� '+fFileName+
                  #10+'�������� ������ # '+IntToStr(CurLine+1));
          end;
          blHeader: begin
            BlockItem:=TBlockItem.create;
            BlockItem.TBlock:=blHeader;
            Blocks.Add(BlockItem);
          end;
        end;
        Inc(CurLine);
        Continue;
      end;
    end;
    (* Check for "End of .." *)
    if (Blocks.Count>0) and
       ((CurLine>Data.count-1) or
        ((Data[curline]<>'') and
         (AnsiUpperCase(copy(trim(Data[curline]),1,3))='END'))) then begin
      case TBlockItem(Blocks.Items[Blocks.Count-1]).TBlock of
        blFor: begin
          TTbItem(DataSets.Items[TBlockItem(Blocks.Items[Blocks.Count-1]).NumTb]).DataSet.Next;
          if Not TTbItem(DataSets.Items[TBlockItem(Blocks.Items[Blocks.Count-1]).NumTb]).DataSet.EOF then begin
            CurLine:=TBlockItem(Blocks.Items[Blocks.Count-1]).CurLine;
            fWrt:=wrPrint;
          end else begin
            if TBlockItem(Blocks.Items[Blocks.Count-1]).Sum then begin
              TBlockItem(Blocks.Items[Blocks.Count-1]).TBlock:=blSum;
              fWrt:=wrPrintSum;
              CurLine:=TBlockItem(Blocks.Items[Blocks.Count-1]).SumLine;
            end else begin
              Blocks.DeleteFull(Blocks.Count-1);
              Inc(CurLine);
            end;
          end;
        end;
        blWhile: begin
          if Assigned(fCondition) and
             fCondition(self,TBlockItem(Blocks.Items[Blocks.Count-1]).NameWhile) then begin
            CurLine:=TBlockItem(Blocks.Items[Blocks.Count-1]).CurLine;
            fWrt:=wrPrint;
          end else begin
            if TBlockItem(Blocks.Items[Blocks.Count-1]).Sum then begin
              TBlockItem(Blocks.Items[Blocks.Count-1]).TBlock:=blSum;
              fWrt:=wrPrintSum;
              CurLine:=TBlockItem(Blocks.Items[Blocks.Count-1]).SumLine;
            end else begin
              Blocks.DeleteFull(Blocks.Count-1);
              Inc(CurLine);
            end;
          end;
        end;
        blSum: begin
          fWrt:=wrPrint;
          Blocks.DeleteFull(Blocks.Count-1);
          Inc(CurLine);
        end;
        blIf,blElse: begin
          Blocks.DeleteFull(Blocks.Count-1);
          Inc(CurLine);
        end;
        blHeader: begin
          Blocks.DeleteFull(Blocks.Count-1);
          Inc(CurLine);
          fHeader:=false;
        end;
      end;
      Continue;
    end;

    if CurLine<=Data.count-1 then begin
      Memos.Clear;
      s:=FillStr(s);
      if fWrt<>wrSum then begin
        Exist:=true;
        if (Pos('@',s)>0) then begin
          s:=copy(s,1,Pos('@',s)-1);
          if trim(s)='' then Exist:=false;
        end;
        if (Pos('BLANK',AnsiUpperCase(s))>0) then begin
          s:=copy(s,1,Pos('BLANK',AnsiUpperCase(s))-1);
          if (trim(s))='' then Exist:=false;
        end;
        if Exist then begin
          if fHeader then Header.Add(s);
          if (Not fHeader) or (fHeaderInText) then Text.Add(s);
          for IndMemos:=0 to Memos.Count-1 do begin
            if fHeader then Header.Add(Memos[IndMemos]);
            if (Not fHeader) or (fHeaderInText) then Text.Add(Memos[IndMemos]);
          end;
        end;
      end;
      Inc(CurLine);
    end;
  end;
  CloseDataSets;
  Result:=True;
end;

procedure TEtvShb.AssignAdditional(Name,Value:string; Alignment:TALignment;Pack:boolean);
var aItem:TaItem;
    i:smallint;
begin
  i:=NumAdditional(Name);
  if i>=0 then begin
    TaItem(Additional.items[i]).Value:=Value;
    TaItem(Additional.items[i]).Alignment:=Alignment;
    TaItem(Additional.items[i]).Pack:=Pack;
  end else begin
    aItem:=TaItem.Create;
    aItem.Name:=Name;
    aItem.Value:=value;
    aItem.Alignment:=Alignment;
    aItem.Pack:=Pack;
    Additional.Add(aItem);
  end;
end;

procedure TEtvShb.AssignDataSet(Name:string; DataSet:TDataSet);
var TbItem:TTbItem;
begin
  if NumDataSet(Name,false)>0 then begin
    TTbItem(DataSets.items[NumDataSet(Name,false)]).DataSet:=DataSet;
    if Assigned(DataSet) then
      TTbItem(DataSets.items[NumDataSet(Name,false)]).WasOpen:=DataSet.Active;
  end
  else begin
    TbItem:=TTbItem.Create;
    TbItem.Name:=Name;
    TbItem.DataSet:=DataSet;
    if Assigned(DataSet) then TbItem.WasOpen:=DataSet.Active;
    DataSets.Add(TbItem);
    
  end;
end;

Procedure TEtvShb.RunViewer;
begin
  if Fill then begin
    if (Text.count>0) then begin
      Screen.Cursor:=crHourGlass;
      FormView:=TFormView.Create(Application);
      FormView.Caption:=fCaption;
      FormView.RichEdit.Lines.Assign(Text);
      Text.Clear;
      Screen.Cursor:=crDefault;
      FormView.ShowReport(false);
    end else EtvApp.ShowMessage('����� ����');
  end;
end;

Procedure TEtvShb.RunModalViewer;
begin
  if Fill then begin
    if Text.count>0 then begin
      Screen.Cursor:=crHourGlass;
      FormView:=TFormView.Create(Application);
      FormView.Caption:=fCaption;
      FormView.RichEdit.Lines.Assign(Text);
      Text.Clear;
      Screen.Cursor:=crDefault;
      FormView.ShowReport(true);
    end else EtvApp.ShowMessage('����� ����');
  end;
end;

end.

