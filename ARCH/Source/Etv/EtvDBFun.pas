unit EtvDBFun;

interface
uses Classes, DB, Forms;
{$I Etv.inc}

Function AllFieldNames(aDataSet:TDataSet; ForQuery,Blobs,Quotes:boolean):string;

Function UniqueFieldsForDataSet(aDataSet:TDataSet):string;

Function SortingFromDataSet(aDataSet:TDataSet):string;

Function SortingToSQL(SQLText:string; NewSorting:string; Quotes:boolean):string;
Procedure SortingToDataSet(aDataSet:TDataSet; NewSorting:string;
                           KeepPosition,Quotes:boolean);

Procedure DataSetRefresh(aDataSet:TDataSet);

Function FieldsDisplayName(aDataSet:TDataSet; aFields:string):string;

Procedure GotoBookmarkWOExcept(aDataSet:TDataSet; aBookmark: TBookmark);
function LocateWOExcept(aDataSet:TDataSet; const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;

procedure CheckFieldNames(ADataSet:TDataSet; FieldNames:string);

Function LengthFields(aDataSet:TDataSet; s:string):smallint;
Function LengthResultFields(Field:TField):smallint;

procedure ModifyLookDataSetActive(ADataSet: TDataSet; AActive: Boolean);

Function AddFilterCondition(OldFilter,Add:string):string;

procedure OpenAllDataSets(aOwner:TComponent; aShowError:boolean);
procedure CloseAllDataSets(aOwner:TComponent; aShowError:boolean);

Procedure RefreshDataOnForm(Form:TForm; All:boolean);

procedure DataSrcKeyDown(Const DataSource: TDataSource; var Key: Word; Shift: TShiftState);
   (* information about Field *)
Function FieldInfo(AField:TField; LookupInfo:boolean):string;
Function FieldsInfo(ADataSet:TDataSet):string;

   (* information line of DataSet *)
Function DataSetInfo(ADataSet:TDataSet):string;

Procedure DataSetInfoToClipBoard(ADataSet:TDataSet);
Procedure FieldDataListToClipBoard(ADataSet:TDataSet);

Procedure DataSetAutoCorrect(ADataSet:TDataSet);

(* Get Labels from server BD (Need two View on the server) *)
Procedure DataSetLabel(ADataSet:TDataSet; aCreator:string);
(* Get Labels from server BD for View (Need two View on the server) *)
Procedure DataSetViewLabel(ADataSet:TDataSet);

Function GetFromSQLText(aDataBaseName, aText:string; HideError:boolean):variant;
Function GetArrFromSQLText(aDataBaseName, aText:string; HideError:boolean):variant;
Procedure ExecSQLText(aDataBaseName, aText:string; HideError:boolean);

function FieldDataByComma(aDataSet:TDataSet; aField:string):string;

{--------}
const VisibleFields='VisibleFields';
      InvisibleFields='InvisibleFields';
      AllFields='AllFields';
      UserFields='UserFields'; (* Tag<>8 *)
      VisibleUserFields='VisibleUserFields';
      InvisibleUserFields='InvisibleUserFields';

function GetVisibleFields(aDataSet:TDataSet; aBlobs:boolean; aLinkFields:boolean):TList;
function GetInvisibleFields(aDataSet:TDataSet; aBlobs:boolean):TList;
function GetUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
function GetVisibleUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
function GetInvisibleUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
function GetFieldListExt(aDataSet:TDataSet; aFields:string; aBlobs:boolean):TList;

(* dialog for choose fields *)
function ChooseFieldList(ADataSet:TDataSet; Var SrcFields, DstFields:string;
           aCaption,aSrcLabel,aDstLabel:string; aBlobs:boolean; Separate:char):boolean;

Procedure ChangeVisibleFields(ADataSet: TDataSet;
            AVisibleFields,AInvisibleFields: String);

Function FIsDBControl(A:Tcomponent;NameProp:string):TComponent;
Procedure IsDBControl(A:Tcomponent; var DSet,DSetLookup:TDataSet);

IMPLEMENTATION

uses TypInfo,Windows,Clipbrd,Dialogs,SysUtils,
     {$IFDEF BDE_IS_USED}
     DbTables,
     {$ENDIF}
     {$IFDEF DBCLIENT_IS_USED}
     dbClient,
     {$ENDIF}
     EtvConst,EtvPas,EtvDB,EtvOther,DiDual;

procedure DataSrcKeyDown(Const DataSource: TDataSource; var Key: Word; Shift: TShiftState);
{$IFDEF InsertDeleteFromControls}
var s:string;
{$ENDIF}
begin
  if Assigned(DataSource) and Assigned(DataSource.DataSet)and
                 DataSource.DataSet.Active then
    if (ssCtrl in Shift)
    {$IFDEF ForLev} or (Key in [VK_PRIOR,VK_NEXT]) {$ENDIF}
    then
      Case Key of
        VK_HOME: DataSource.DataSet.First;
        VK_END: DataSource.DataSet.Last;
        VK_PRIOR: DataSource.DataSet.Prior;
        VK_NEXT: DataSource.DataSet.Next;
        {$IFDEF InsertDeleteFromControls}
        VK_ADD: DataSource.DataSet.Insert;
        VK_SUBTRACT: begin
          EtvApp.DisableRefreshForm;
          try
            s:=ObjectStrProp(DataSource.DataSet,'Caption');
            if s<>'' then s:=s+#10+SDeleteRecordQuestion
            else s:=SDeleteRecordQuestion;
            if MessageDlg (S, mtConfirmation, mbOKCancel, 0) <> idCancel then
            DataSource.DataSet.Delete;
          finally
            EtvApp.EnableRefreshForm;
          end;
        end;
        {$ENDIF}
      end;
end;

function FindOrderBy(s:string; first:boolean):integer;
var i,j,L,k:integer;
    inString,inText:boolean;
begin
  Result:=0;
  j:=1;
  L:=length(S);
  while J<=L do begin
    i:=Pos('order',AnsiLowerCase(copy(s,j,l)))+(j-1);
    if i>j-1 then begin
      j:=i+5;
      inString:=false;
      inText:=false;
      for k:=1 to i-1 do begin
        if s[k]='''' then inString:=not inString;
        if (s[k]='"') and (not InString) then inText:=not inText;
      end;
      if not (inString or inText) then begin
        while (j<=L) and (s[j]<=' ') do inc(J);
        if AnsiLowerCase(copy(s,j,2))='by' then begin
          if First then result:=i else result:=j+2;
          Exit;
        end;
      end;
    end else Exit;
  end;
end;

Function SortingFromSQL(SQLText:string):string;
var i,l:integer;
    s:string;
    SeparateExists:boolean;
begin
  Result:='';
  i:=FindOrderBy(SQLText,false);
  if i>0 then begin
    s:=trim(copy(SQLText,i,maxint));
    L:=length(s);
    i:=1;
    SeparateExists:=true;
    while i<=L do begin
      while (i<=L) and (s[i]>' ') and (s[i]<>'"') and
            (s[i]<>',') and (s[i]<>';') do begin
        if SeparateExists then result:=result+s[i];
        inc(i);
      end;
      SeparateExists:=false;
      while (i<=L) and ((s[i]<=' ') or (s[i]=',') or (s[i]=',')) do begin
        if s[i]=',' then begin
          SeparateExists:=true;
          Result:=Result+';';
        end;
        inc(i);
      end;
    end;
  end;
end;

function AllFieldNames(aDataSet:TDataSet; ForQuery,Blobs,Quotes:boolean):string;
var i:integer;
begin
  Result:='';
  for i:=0 to aDataSet.FieldCount-1 do
    if (TField(aDataSet.Fields[i]).FieldKind=fkData) and
       (Blobs or (not(TField(aDataSet.Fields[i]) is TBlobField))) then begin
      if ForQuery then begin
        if Result<>'' then Result:=Result+',';
        if Quotes then Result:=Result+'"';
        Result:=Result+TField(aDataSet.Fields[i]).FieldName;
        if Quotes then Result:=Result+'"';
      end
      else begin
        if Result<>'' then Result:=Result+';';
        Result:=Result+TField(aDataSet.Fields[i]).FieldName;
      end;
    end;
  if (Result='') and ForQuery then Result:='*';
end;

function UniqueFieldsFromIndexDefs(aIndexDefs:TIndexDefs):string;
var i:integer;
begin
  Result:='';
  aIndexDefs.Update;
  for i:=0 to aIndexDefs.Count-1 do
    if (ixPrimary in aIndexDefs.Items[i].options) or
       (ixUnique in aIndexDefs.Items[i].options) then begin
      Result:=aIndexDefs.Items[i].Fields;
      Exit;
    end;
end;

{$IFDEF BDE_IS_USED}
function UniqueFieldsForDBDataSet(aDBDataSet:TDBDataSet):string;
var lTableName:string;
    lTable:TTable;
begin
  Result:='';
  lTableName:=ObjectStrProp(aDBDataSet,'TableName');
  if lTableName<>'' then begin
    lTable:=TTable.Create(nil);
    try
      lTable.DatabaseName:=aDBDataSet.DataBaseName;
      lTable.TableName:=LTableName;
      try
        Result:=UniqueFieldsFromIndexDefs(lTable.IndexDefs);
      except
      end;
    finally
      lTable.Free;
    end;
  end;
end;
{$ENDIF}

Function UniqueFieldsForDataSet(aDataSet:TDataSet):string;
var lIndexDefs:TIndexDefs;
  procedure Check;
    var PropInfo:PPropInfo;
  begin
    lIndexDefs:=nil;
    PropInfo := GetPropInfo(aDataSet.ClassInfo, 'IndexDefs');
    if PropInfo <> nil then
      lIndexDefs:=TIndexDefs(GetOrdProp(aDataSet, PropInfo));
  end;
begin
  Result:=ObjectStrProp(aDataSet,'UniqueFields');
  if Result='' then begin
    Check;
    {$IFDEF DBCLIENT_IS_USED}
    if (lIndexDefs=nil) and (aDataSet is TClientDataSet) then
      lIndexDefs:=TClientDataSet(aDataSet).IndexDefs;
    {$ENDIF}
    {$IFDEF BDE_IS_USED}
    if lIndexDefs=nil then begin
      if aDataSet is TTable then
        lIndexDefs:=TTable(aDataSet).IndexDefs
      else if aDataSet is TDBDataSet then
        Result:=UniqueFieldsForDBDataSet(TDBDataSet(aDataSet))
    end;
    {$ENDIF}
    if Assigned(lIndexDefs) then
      Result:=UniqueFieldsFromIndexDefs(lIndexDefs);
    if Result='' then Result:=AllFieldNames(aDataSet,False,false,false);
  end;
end;

Function SortingToSQL(SQLText:string; NewSorting:string; Quotes:boolean):string;
var i:integer;
    s:string;
begin
  if Quotes then begin
    s:='';
    i:= 1;
    while i<=Length(NewSorting) do begin
      if s<>'' then s:=s+',';
      s:=s+'"'+ExtractFieldName(NewSorting,i)+'"';
    end;
  end else begin
    s:=NewSorting;
    for i:=1 to length(s) do
      if s[i]=';' then s[i]:=',';
  end;

  i:=FindOrderBy(SQLText,true);
  if i>0 then Result:=copy(SQLText,1,i-1)
  else begin
    Result:=Trim(SQLText);
    if Result[length(Result)]=';' then Result:=copy(Result,1,length(Result)-1);
  end;
  if s<>'' then Result:=Result+#13#10+'order by '+s;
end;

Procedure SortingToDataSet(aDataSet:TDataSet; NewSorting:string;
                           KeepPosition,Quotes:boolean);
var PropInfo: PPropInfo;
    lSQL:TStrings;
    lFields:string;
    V:variant;
    lNewSorting:string;
    i:integer;
begin
  lNewSorting:=NewSorting;
  PropInfo:=GetPropInfo(aDataSet.ClassInfo, 'SQL');
  if PropInfo<>nil then begin
    lSQL:=TStrings(GetOrdProp(aDataSet, PropInfo));
    if aDataSet.Active then begin
      if KeepPosition then begin
        lFields:=UniqueFieldsForDataSet(aDataSet);
        if lFields<>'' then V:=aDataSet.FieldValues[lFields];
      end;
      aDataSet.DisableControls;
      try
        aDataSet.Close;
        lSQL.Text:=SortingToSQL(lSQL.Text,lNewSorting,Quotes);
        aDataSet.Open;
        if KeepPosition and (lFields<>'') then aDataSet.Locate(lFields,V,[]);
      finally
        aDataSet.EnableControls;
      end;
    end else lSQL.Text:=SortingToSQL(lSQL.Text, lNewSorting,Quotes);
  end else begin
    PropInfo:=GetPropInfo(aDataSet.ClassInfo, 'IndexFieldNames');
    if PropInfo<>nil then begin
      for i:=1 to length(lNewSorting) do
        if lNewSorting[i]=',' then lNewSorting[i]:=';';
      if aDataSet.Active and KeepPosition then begin
        lFields:=UniqueFieldsForDataSet(aDataSet);
        if lFields<>'' then begin
          V:=aDataSet.FieldValues[lFields];
          aDataSet.DisableControls;
          try
            SetStrProp(aDataSet,PropInfo,lNewSorting);
            aDataSet.Locate(lFields,V,[]);
          finally
            aDataSet.EnableControls;
          end;
        end else SetStrProp(aDataSet,PropInfo,lNewSorting);
      end else SetStrProp(aDataSet,PropInfo,lNewSorting);
    end;
  end;
end;

function SortingFromDataSet(aDataSet:TDataSet):string;
var PropInfo: PPropInfo;
    {$IFDEF BDE_IS_USED}
    j:integer;
    {$ELSE}
      {$IFDEF DBCLIENT_IS_USED}
    j:integer;
      {$ENDIF}
    {$ENDIF}
begin
  Result:='';

  {$IFDEF BDE_IS_USED}
  if aDataSet is TTable then with TTable(aDataSet) do
    for j:=0 to IndexFieldCount-1 do begin
      if j>0 then Result:=Result+';';
      Result:=Result+IndexFields[j].FieldName;
  end;
  {$ENDIF}
  {$IFDEF DBCLIENT_IS_USED}
  if aDataSet is TClientDataSet then with TClientDataSet(aDataSet) do
    for j:=0 to IndexFieldCount-1 do begin
      if j>0 then Result:=Result+';';
      Result:=Result+IndexFields[j].FieldName;
    end;
  {$ENDIF}
  if Result='' then Result:=ObjectStrProp(aDataSet,'IndexFieldNames');
  if Result='' then begin
    PropInfo:=GetPropInfo(aDataSet.ClassInfo, 'SQL');
    if PropInfo<>nil then
      Result:=SortingFromSQL(TStrings(GetOrdProp(aDataSet, PropInfo)).Text);
  end;
end;

Procedure DataSetRefresh(aDataSet:TDataSet);
{$IFDEF BDE_IS_USED}
var B:TBookMark;
{$ENDIF}
begin
  if Assigned(aDataSet) and aDataSet.Active then begin
    {$IFDEF BDE_IS_USED}
    if aDataSet is TQuery then with aDataSet do begin
      B:=GetBookmark; (* may be need to remake by locate *)
      DisableControls;
      try
        Close;
        Open;
        GotoBookmarkWOExcept(aDataSet,B);
      finally
        EnableControls;
        FreeBookmark(B);
      end;
    end else
    {$ENDIF}
    aDataSet.Refresh;
  end;
end;

function FieldsDisplayName(aDataSet:TDataSet; aFields:string):string;
var Pos:integer;
    lFieldName:string;
    lField:TField;
begin
  Result:='';
  Pos:=1;
  while Pos <= Length(aFields) do begin
    lFieldName:=ExtractFieldName(aFields, Pos);
    lField:=aDataSet.FindField(lFieldName);
    if Result<>'' then Result:=Result+',';
    if Assigned(lField) then Result:=Result+lField.DisplayName
    else Result:=Result+lFieldName;
  end;
end;

type TDataSetSelf=Class(TDataSet) end;
     {$IFDEF BDE_IS_USED}
     TBDEDataSetSelf=Class(TBDEDataSet) end;
     {$ENDIF}
     {$IFDEF DBCLIENT_IS_USED}
     TClientDataSetSelf=Class(TClientDataSet) end;
     {$ENDIF}

Procedure GotoBookmarkWOExcept(aDataSet:TDataSet; aBookmark: TBookmark);
begin
  if aBookmark<>nil then With TDataSetSelf(aDataSet) do begin
    CheckBrowseMode;
    DoBeforeScroll;
    InternalGotoBookmark(aBookmark);
    Resync([{rmExact, }rmCenter]);
    DoAfterScroll;
  end;
end;

function LocateWOExcept(aDataSet:TDataSet; const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;
begin
  Result:=false;

  {$IFDEF BDE_IS_USED}
  if aDataSet is TBDEDataSet then with TDataSetSelf(aDataSet) do begin
    DoBeforeScroll;
    Result:=TBDEDataSetSelf(aDataSet).LocateRecord(KeyFields, KeyValues, Options, True);
    if Result then begin
      Resync([{rmExact, }rmCenter]);
      DoAfterScroll;
    end;
  end;
  exit;
  {$ENDIF}
  {$IFDEF DBCLIENT_IS_USED}
  if aDataSet is TClientDataSet then with TDataSetSelf(aDataSet) do begin
    DoBeforeScroll;
    Result:=TClientDataSetSelf(aDataSet).LocateRecord(KeyFields, KeyValues, Options, True);
    if Result then begin
      Resync([{rmExact, }rmCenter]);
      DoAfterScroll;
    end;
    exit;
  end;
  {$ENDIF}
  try
    Result:=aDataSet.Locate(KeyFields, KeyValues, Options);
  except
  end;
end;

procedure CheckFieldNames(ADataSet:TDataSet; FieldNames:string);
var Pos: Integer;
begin
  Pos := 1;
  with ADataSet do
    while Pos <= Length(FieldNames) do
      FieldByName(ExtractFieldName(FieldNames, Pos));
end;

Function LengthFields(aDataSet:TDataSet; s:string):smallint;
var i:integer;
begin
  Result:=0;
  if Assigned(aDataSet) then begin
    i:=1;
    while i<=Length(s) do begin
      Result:=Result+aDataSet.FieldByName(ExtractFieldName(s, i)).DisplayWidth;
    end;
  end;
end;

Function LengthResultFields(Field:TField):smallint;
begin
  Result:=LengthFields(Field.LookupDataSet,ObjectStrProp(Field,'LookupResultField'));
end;

{ LookUp fields to Calculated and back}
procedure ModifyLookDataSetActive(ADataSet: TDataSet; AActive: Boolean);
var i:Integer;
    AField: TField;
begin
  if Assigned(ADataSet) then
    with ADataSet do begin
      for i:=0 to FieldCount-1 do begin
        AField:=Fields[i];
        if Assigned(AField.LookupDataSet) and
           (AField.LookUpDataSet.Active=not AActive) then
          AField.LookUpDataSet.Active:=AActive;
      end;
    end;
end;

Function AddFilterCondition(OldFilter,Add:string):string;
begin
  if OldFilter='' then Result:=Add
  else
    if Add<>'' then Result:='('+OldFilter+') and ('+Add+')'
    else Result:=OldFilter;
end;

procedure OpenAllDataSets(aOwner:TComponent; aShowError:boolean);
var s:string;
    i:integer;
begin
  s:='';
  for i:=0 to aOwner.ComponentCount-1 do begin
    if (aOwner.Components[i] is TDataSet)
       and (Not TDataSet(aOwner.Components[i]).Active) then
      try
        TDataSet(aOwner.Components[i]).Open
      Except
        if aShowError then
          s:=s+aOwner.Components[i].Name+#13+#10;
      end;
  end;
  if s<>'' then EtvApp.ShowMessage(s+#13+#10+'Not opened');
end;

procedure CloseAllDataSets(aOwner:TComponent; aShowError:boolean);
var s:string;
    i:integer;
begin
  s:='';
  for i:=0 to aOwner.ComponentCount-1 do begin
    if (aOwner.Components[i] is TDataSet)
       and (TDataSet(aOwner.Components[i]).Active) then
      try
        TDataSet(aOwner.Components[i]).Close
      Except
        if aShowError then
          s:=s+aOwner.Components[i].Name+#13+#10;
      end;
  end;
  if s<>'' then EtvApp.ShowMessage(s+#13+#10+'Not closed!!!');
end;

Function FieldInfo(AField:TField; LookupInfo:boolean):string;
var s:string;
begin
  with AField do begin
    Result:=ClassName;
    if AField is TStringField then
      Result:=Result+'['+IntToStr(TStringField(AField).size)+']';
    Result:=sform(FieldName,18,taLeftJustify)+' '+
      sform(Name,32,taLeftJustify)+' '+sform(Result,17,taLeftJustify);
    Result:=Result+' '+DisplayLabel+'  '+IntToStr(DisplayWidth);
    case FieldKind of
      fkCalculated: Result:=Result+'  CALC';
      fkInternalCalc: Result:=Result+'  InternalCALC';
      fkLookup: begin
        Result:=Result+'  LOOKUP';
        if LookupInfo then begin
          Result:=Result+'(';
          if KeyFields<>'' then Result:=Result+KeyFields+','
          else Result:=Result+'###,';
          if LookupDataSet<>nil then begin
            Result:=Result+LookupDataSet.Name;
            s:=ObjectStrProp(LookupDataset,'TableName');
            if s<>'' then Result:=Result+
              '{'+s+'}';
          end else Result:=Result+'###';
          Result:=Result+',';
          if LookupKeyFields<>'' then Result:=Result+LookupKeyFields+','
          else Result:=Result+'###,';
          if LookupResultField<>'' then
            {if AField is TEtvLookField then
              Result:=Result+TEtvLookField(AField).LookupResultField
            else} Result:=Result+LookupResultField
          else Result:=Result+'###';
          Result:=Result+')';
        end;
      end;
    end;
  end;
end;

Function FieldsInfo(ADataSet:TDataSet):string;
var i:smallint;
begin
  Result:='';
  if Not Assigned(ADataSet) then Exit;
  for i:=0 to ADataSet.FieldCount-1 do
    Result:=Result+FieldInfo(ADataSet.Fields[i],True)+#13+#10;
end;

Function DataSetInfo(ADataSet:TDataSet):string;
var s:string;
begin
  Result:=ADataset.name;
  s:=ObjectStrProp(ADataSet,'Caption');
  if s<>'' then Result:=Result+'  '+s;
  s:=ObjectStrProp(ADataSet,'DataBaseName');
  if s<>'' then Result:=Result+'  '+s;
  s:=ObjectStrProp(ADataSet,'TableName');
  if s<>'' then Result:=Result+'  '+s;
  if ADataSet.tag mod 10 =9 then Result:=Result+' | Auto open';
  if ADataSet.tag mod 100 div 10=9 then Result:=Result+' | Refresh';
  if ADataSet.Active=true then Result:=Result+' // Active';
end;

procedure DataSetInfoToClipBoard(ADataSet:TDataSet);
var s:string;
begin
  if Not Assigned(ADataSet) then Exit;
  s:='--- '+DataSetInfo(ADataSet)+' ---'+#13+#10+#13+#10;
    s:=s+FieldsInfo(ADataSet);
  Clipboard.SetTextBuf(PChar(s));
end;

procedure FieldDataListToClipBoard(ADataSet:TDataSet);
var s:string;
    i:integer;
begin
  if Not Assigned(ADataSet) then Exit;
  s:='';
  for i:=0 to ADataSet.fieldCount-1 do
    if ADataSet.Fields[i].FieldKind=fkData then begin
      if s<>'' then s:=s+',';
      s:=s+ADataSet.Fields[i].FieldName;
    end;
  if s<>'' then Clipboard.SetTextBuf(PChar(s));
end;

procedure DataSetAutoCorrect(ADataSet:TDataSet);
var OldActive:boolean;
    sInfo:string;
    L,I:smallint;
    fAutoCalcFields:boolean;
begin
  try
    sInfo:=SAutoCorrectInit;
    fAutoCalcFields:=false;

    OldActive:=ADataSet.Active;

    with ADataSet do begin
      for i:=0 to FieldCount-1 do begin
        sInfo:=SAutoCorrectFieldProcess+Fields[i].FieldName;
        if (Fields[i].fieldKind=fkLookup) then begin
          fAutoCalcFields:=true;
          if Fields[i].KeyFields<>'' then begin
            FieldByName(Fields[i].KeyFields).Visible:=false;
            FieldByName(Fields[i].KeyFields).Tag:=8;
          end;
          sInfo:=SAutoCorrectFieldLengthProcess+Fields[i].FieldName;
            (* calc of length *)
          if Assigned(Fields[i].LookupDataSet) then with Fields[i] do begin
            L:=LengthResultFields(Fields[i]);
            if L>0 then begin
              if Fields[i] is TStringField then begin
                if Active then Close;
                TStringField(Fields[i]).Size:=L;
              end;
              DisplayWidth:=L+5;
            end;
          end;
        end else begin
          sInfo:=SAutoCorrectFieldOtherProcess+Fields[i].FieldName;
          if ((Fields[i] is TSmallintField) or
              (Fields[i] is TWordField)) and
             (Fields[i].DisplayWidth>6) then Fields[i].DisplayWidth:=5;
          if Fields[i] is TBlobField then begin
            Fields[i].Visible:=false;
            if (Fields[i] is TMemoField) and (Fields[i].DisplayWidth=10) then
              Fields[i].DisplayWidth:=40;
          end;
        end;
        if Assigned(CreateOtherFieldAutoCorrect) then
          CreateOtherFieldAutoCorrect(Fields[i]);
      end;
      sInfo:=SAutoCorrectSetTableParams;
      if fAutoCalcFields and (Not ADataSet.AutoCalcFields) then
        ADataSet.AutoCalcFields:=true;
      if OldActive and (Not Active) then Open;
    end;
  except
    ShowMessage(SError+SInfo);
  end;
end;

function GetLabel(var SCap:string):string;
var j,j1:smallint;
begin
  j:=Pos('\',sCap);
  j1:=Pos('/',sCap);
  if (j1>0) and ((j1<j) or (j<=0)) then j:=j1;
  if j>0 then begin
    Result:=Copy(sCap,1,j-1);
    sCap:=Copy(sCap,j+1,Length(sCap));
  end else begin
    Result:=sCap;
    sCap:='';
  end;
  if Length(Result)>80 then Result:=Copy(Result,1,80);
  Result:=Trim(Result);
end;


procedure DataSetLabel(ADataSet:TDataSet; aCreator:string);
var TbTables,TbColumns:TDataSet;
    OldActive:boolean;
    sInfo,s,sCap:string;
    i:smallint;
    PropInfo: PPropInfo;
    lSQL:TStrings;
begin
  TbTables:=nil;
  TbColumns:=nil;
  try
    sInfo:=SAutoCorrectInit+' ('+SLabelPump+')';
    s:=ObjectStrProp(ADataSet,'TableName');
    if s='' then begin
      SInfo:=SLabelPumpTableMissing+' ('+SLabelPump+')';
      SysUtils.Abort;
    end;
    i:=Pos('.',s);
    if i>0 then s:=Copy(s,i+1,length(s)-i);

    OldActive:=ADataSet.Active;
    ADataSet.DisableControls;

    sInfo:=SLabelPumpAidTables+' ('+SLabelPump+')';

    if Assigned(OtherQueryClass) then begin
      TbTables:=OtherQueryClass.Create(nil);
      TbColumns:=OtherQueryClass.Create(nil);
    end
    {$IFDEF BDE_IS_USED}
    else begin
      TbTables:=TQuery.Create(nil);
      TbColumns:=TQuery.Create(nil);
    end
    {$ENDIF}
    ;
    if TbTables=nil then begin
      SInfo:=SNeedQueryClass;
      Abort;
    end;

    SetObjectStrProp(TbTables,'DataBaseName',ObjectStrProp(aDataSet,'DataBaseName'));
    SetObjectStrProp(TbColumns,'DataBaseName',ObjectStrProp(aDataSet,'DataBaseName'));

    PropInfo:=GetPropInfo(TbTables.ClassInfo, 'SQL');
    if PropInfo<>nil then begin
      lSQL:=TStrings(GetOrdProp(TbTables, PropInfo));
      lSQL.Add('Select * from Tables where TName='''+s+''' and Creator='''+aCreator+'''');
    end else begin
      SInfo:=SPropSQLAbsent;
      Abort;
    end;
    PropInfo:=GetPropInfo(TbColumns.ClassInfo, 'SQL');
    if PropInfo<>nil then begin
      lSQL:=TStrings(GetOrdProp(TbColumns, PropInfo));
      lSQL.Add('Select * from Columns where TName='''+s+''' and Creator='''+aCreator+'''');
    end;

    TbTables.Open;
    TbColumns.Open;

    sInfo:=SLabelPumpTableProcess+' ('+SLabelPump+')';

    if Not (TbTables.BOF and TbTables.EOF) then begin
      SCap:=TbTables.FieldByName('Remarks').AsString;
      SCap:=GetLabel(sCap);
      PropInfo := GetPropInfo(ADataSet.ClassInfo, 'Caption');
      if PropInfo <> nil then SetStrProp(ADataSet,PropInfo,SCap);


      with ADataSet do begin
        for i:=0 to FieldCount-1 do begin
          SCap:='';
          sInfo:=SLabelPumpFieldProcess+' '+Fields[i].FieldName+' ('+SLabelPump+')';
          if (Fields[i].fieldKind=fkLookup) then begin
            if Fields[i].KeyFields<>'' then begin
              if (TbColumns.Locate('CName',Fields[i].KeyFields,[])) and
                 (TbColumns.FieldByName('Remarks').Value<>null) then
                SCap:=TbColumns.FieldByName('Remarks').Value;
            end;
          end else begin
            if TbColumns.Locate('cname',Fields[i].FieldName,[]) then begin
              if TbColumns.FieldByName('Remarks').Value<>null then
                SCap:=TbColumns.FieldByName('Remarks').Value;
              sInfo:=SLabelPumpFieldCheckLength+' '+Fields[i].FieldName+' ('+SLabelPump+')';
              if (TbColumns.FindField('Required')<>nil) and
                 (TbColumns.FindField('Required').value<>null) then
                Fields[i].Required:=true;
              if (Fields[i] is TStringField) and
                 (TStringField(Fields[i]).size<>TbColumns.FieldByName('SLength').Value) then begin
                if Active then Close;
                TStringField(Fields[i]).Size:=TbColumns.FieldByName('SLength').Value;
              end;
            end;
          end;
          sInfo:=SLabelPumpFieldLabel+' '+Fields[i].FieldName+' ('+SLabelPump+')';
          if sCap<>'' then
            Fields[i].DisplayLabel:=GetLabel(sCap);
        end;
      end;
    end else ShowMessage(Format(SLabelPumpTableNotFound,[s]));
    if OldActive<> ADataSet.Active then
      ADataSet.Active:=not AdataSet.Active;
    ADataSet.EnableControls;
    TbColumns.free;
    TbTables.free;
  except
    ShowMessage(SError+SInfo);
    if assigned(TbColumns) then TbColumns.free;
    if assigned(TbTables) then TbTables.free;
  end;
end;

procedure DataSetViewLabel(ADataSet:TDataSet);
var TbTables:TDataSet;
    sInfo,s,sCap:string;
    i:smallint;
    PropInfo: PPropInfo;
    lSQL:TStrings;
begin
  TbTables:=nil;
  try
    sInfo:=SAutoCorrectInit+' ('+SLabelPumpView+')';
    s:=ObjectStrProp(ADataSet,'TableName');
    if s='' then begin
      SInfo:=SLabelPumpTableMissing+' ('+SLabelPumpView+')';
      SysUtils.Abort;
    end;
    i:=Pos('.',s);
    if i>0 then s:=Copy(s,i+1,length(s)-i);

    if Assigned(OtherQueryClass) then
      TbTables:=OtherQueryClass.Create(nil)
    {$IFDEF BDE_IS_USED}
    else TbTables:=TQuery.Create(nil)
    {$ENDIF}
    ;
    if TbTables=nil then begin
      SInfo:=SNeedQueryClass;
      Abort;
    end;

    SetObjectStrProp(TbTables,'DataBaseName',ObjectStrProp(aDataSet,'DataBaseName'));
    PropInfo:=GetPropInfo(TbTables.ClassInfo, 'SQL');
    if PropInfo<>nil then begin
      lSQL:=TStrings(GetOrdProp(TbTables, PropInfo));
      lSQL.Add('Select * from TablesV where TName='''+s+'''');
    end else begin
      SInfo:=SPropSQLAbsent;
      Abort;
    end;
    TbTables.Open;

    sInfo:=SLabelPumpTableProcess+' ('+SLabelPumpView+')';
    if not (TbTables.BOF and TbTables.EOF) then begin
      SCap:=TbTables.FieldByName('Remarks').AsString;
      S:=GetLabel(SCap);
      PropInfo := GetPropInfo(ADataSet.ClassInfo, 'Caption');
      if PropInfo <> nil then SetStrProp(ADataSet,PropInfo,S);

      sInfo:=SLabelPumpViewFieldsProcess+' ('+SLabelPumpView+')';
      with ADataSet do begin
        if (FieldCount=0) and (Not Active) then Open;
        while sCap<>'' do begin
          s:=GetLabel(sCap);
          i:=Pos('=',s);
          if i>0 then begin
            if Assigned(FindField(trim(Copy(s,1,i-1)))) then
              FindField(Trim(Copy(s,1,i-1))).DisplayLabel:=Trim(Copy(s,i+1,length(s)));
          end;
        end;

        for i:=0 to FieldCount-1 do begin
          if (Fields[i].fieldKind=fkLookup) and (Fields[i].KeyFields<>'') and
             Assigned(FindField(Fields[i].KeyFields)) then
            Fields[i].DisplayLabel:=FieldByName(Fields[i].KeyFields).DisplayLabel;
        end;
      end;
    end else ShowMessage(Format(SLabelPumpTableNotFound,[s]));
    TbTables.free;
  except
    ShowMessage(SError+SInfo);
    if assigned(TbTables) then TbTables.free;
  end;
end;

{-------}

function GetVisibleFields(aDataSet:TDataSet; aBlobs:boolean; aLinkFields:boolean):TList;
var i:integer;
    lField:TField;
begin
  Result:=nil;
  if Assigned(aDataSet) then With aDataSet do begin
    Result:=TList.Create;
    for i:=0 to FieldCount-1 do
      if Fields[i].Visible and
         (aBlobs or (not (Fields[i] is TBlobField))) then begin
        if aLinkFields then begin
          if (Fields[i].FieldKind=fkLookup) then begin
            lField:=ADataSet.FindField(Fields[i].KeyFields);
            if Assigned(lField) and (lField.Visible=false) and
              (Result.IndexOf(lField)<0) then Result.Add(lField);
          end;
        end;
        Result.Add(ADataSet.Fields[i])
      end;
  end;
end;

function GetInvisibleFields(aDataSet:TDataSet; aBlobs:boolean):TList;
var i:integer;
begin
  Result:=nil;
  if Assigned(aDataSet) then With aDataSet do begin
    Result:=TList.Create;
    for i:=0 to FieldCount-1 do
      if (not Fields[i].Visible) and
         (aBlobs or (not (Fields[i] is TBlobField))) then Result.Add(ADataSet.Fields[i])
  end;
end;

function GetUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
var i:integer;
begin
  Result:=nil;
  if Assigned(aDataSet) then With aDataSet do begin
    Result:=TList.Create;
    for i:=0 to FieldCount-1 do
      if (Fields[i].Tag<>8) and
         (aBlobs or (not (Fields[i] is TBlobField))) then Result.Add(ADataSet.Fields[i])
  end;
end;

function GetVisibleUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
var i:integer;
begin
  Result:=nil;
  if Assigned(aDataSet) then With aDataSet do begin
    Result:=TList.Create;
    for i:=0 to FieldCount-1 do
      if (Fields[i].Tag<>8) and Fields[i].visible and
         (aBlobs or (not (Fields[i] is TBlobField)))then Result.Add(ADataSet.Fields[i])
  end;
end;

function GetInvisibleUserFields(aDataSet:TDataSet; aBlobs:boolean):TList;
var i:integer;
begin
  Result:=nil;
  if Assigned(aDataSet) then With aDataSet do begin
    Result:=TList.Create;
    for i:=0 to FieldCount-1 do
      if (Fields[i].Tag<>8) and (Not Fields[i].visible) and
         (aBlobs or (not (Fields[i] is TBlobField))) then Result.Add(ADataSet.Fields[i])
  end;
end;

function GetFieldListExt(aDataSet:TDataSet; aFields:string; aBlobs:boolean):TList;
var i:integer;
begin
  if aFields=VisibleFields then Result:=GetVisibleFields(aDataSet,aBlobs,false)
  else if aFields=InvisibleFields then Result:=GetInvisibleFields(aDataSet,aBlobs)
  else if aFields=AllFields then begin
    Result:=TList.Create;
    for i:=0 to aDataSet.FieldCount-1 do
      if aBlobs or (Not (aDataSet.Fields[i] is TBlobField)) then
        Result.Add(aDataSet.Fields[i]);
  end
  else if aFields=UserFields then Result:=GetUserFields(aDataSet,aBlobs)
  else if aFields=VisibleUserFields then Result:=GetVisibleUserFields(aDataSet,aBlobs)
  else if aFields=InvisibleUserFields then Result:=GetInvisibleUserFields(aDataSet,aBlobs)
  else begin
    Result:=TList.Create;
    aDataSet.GetFieldList(Result,aFields);
    if (Not aBlobs) and assigned(Result) then
      For i:=Result.Count-1 downto 0 do
        if TField(Result[i]) is TBlobField then Result.Delete(i);
  end;
end;

function ChooseFieldList(ADataSet:TDataSet; Var SrcFields, DstFields:string;
           aCaption,aSrcLabel,aDstLabel:string; aBlobs:boolean; Separate:char):boolean;
var Dial:TEtvDualListDlg;
    i,j:integer;
    SrcFieldList,DstFieldList:TList;
    Exist:boolean;
begin
  Result:=false;
  if Assigned(ADataSet) then begin
    Dial:=TEtvDualListDlg.Create(nil);
    with Dial do Try
      if aCaption<>'' then Caption:=aCaption;
      if aSrcLabel<>'' then SrcLabel.Caption:=aSrcLabel;
      if aDstLabel<>'' then DstLabel.Caption:=aDstLabel;
      SrcList.Items.Clear;
      DstList.Items.Clear;
      SrcFieldList:=GetFieldListExt(aDataSet,ChangeSymbol(SrcFields,Separate,';'),aBlobs);
      try
        DstFieldList:=GetFieldListExt(aDataSet,ChangeSymbol(DstFields,Separate,';'),aBlobs);
        with aDataset do try
          if Assigned(SrcFieldList) then for i:=0 to SrcFieldList.Count-1 do begin
            Exist:=false;
            if Assigned(DstFieldList) then for j:=0 to DstFieldList.Count-1 do
              if SrcFieldList[i]=DstFieldList[j] then begin
                Exist:=true;
                break;
              end;
            if Not Exist then SrcList.Items.add(TField(SrcFieldList[i]).DisplayLabel)
          end;
          if Assigned(DstFieldList) then for i:=0 to DstFieldList.Count-1 do
            DstList.Items.add(TField(DstFieldList[i]).DisplayLabel);
          if (SrcList.Items.Count+DstList.Items.Count>0) and (ShowModal=idOk) then begin
            if Not Assigned(SrcFieldList) then SrcFieldList:=Tlist.Create;
            if Assigned(DstFieldList) then
              for i:=0 to DstFieldList.count-1 do
                SrcFieldList.Add(DstFieldList[i]);
            Result:=true;
            SrcFields:='';
            DstFields:='';
            for j:=0 to SrcList.Items.Count-1 do
              for i:=0 to SrcFieldList.count-1 do
                if TField(SrcFieldList[i]).DisplayLabel=SrcList.Items[j] then begin
                  if (Separate<>'') and (SrcFields<>'') then
                    SrcFields:=SrcFields+Separate;
                  SrcFields:=SrcFields+TField(SrcFieldList[i]).FieldName;
                  Break;
                end;
            for j:=0 to DstList.Items.Count-1 do
              for i:=0 to SrcFieldList.Count-1 do
                if TField(SrcFieldList[i]).DisplayLabel=DstList.Items[j] then begin
                  if (Separate<>'') and (DstFields<>'') then
                    DstFields:=DstFields+Separate;
                  DstFields:=DstFields+TField(SrcFieldList[i]).FieldName;
                  Break;
                end;
          end;
        finally
          DstFieldList.Free;
        end;
      finally
        SrcFieldList.Free;
      end;
    finally
      if Assigned(Dial) then Dial.Free;
    end;
  end;
end;

procedure ChangeVisibleFields(ADataSet: TDataSet;
            AVisibleFields,AInvisibleFields: String);
var AList:TList;
    aCount,i,j:Integer;
begin
  AList:= TList.Create;
  try
    ADataSet.GetFieldList(AList, AVisibleFields);
    for j:=0 to AList.Count-1 do
      for i:=0 to ADataSet.FieldCount-1 do
        if ADataSet.Fields[i]=AList[j] then begin
          ADataSet.Fields[i].Visible:=True;
          ADataSet.Fields[i].Index:=j;
          Break;
        end;
    aCount:=AList.Count;
    AList.Clear;
    ADataSet.GetFieldList(AList, AInvisibleFields);
    for j:=0 to AList.Count-1 do
      for i:=0 to ADataSet.FieldCount-1 do
        if ADataSet.Fields[i]=AList[j] then begin
          ADataSet.Fields[i].Visible:=false;
          ADataSet.Fields[i].Index:=j+aCount;
          Break;
        end;
  finally
    AList.Free;
  end;
end;

var Q:TDataSet;

Function GetFromSQLText(aDataBaseName, aText:string; HideError:boolean):variant;
var PropInfo: PPropInfo;
    lSQL:TStrings;
begin
  Result:=null;
  if Not Assigned(Q) then begin
    if Assigned(OtherQueryClass) then
      Q:=OtherQueryClass.Create(nil)
    {$IFDEF BDE_IS_USED}
    else Q:=TQuery.Create(nil)
    {$ENDIF}
    ;
    if Q=nil then begin
      EtvApp.ShowMessage('Function GetFromSQLText:'+#13+SNeedQueryClass);
      Exit;
    end;
  end;

  SetObjectStrProp(Q,'DataBaseName',aDataBaseName);
  PropInfo:=GetPropInfo(Q.ClassInfo, 'SQL');
  if PropInfo<>nil then begin
    lSQL:=TStrings(GetOrdProp(Q, PropInfo));
    lSQL.Clear;
    lSQL.Add(aText);
  end else begin
    EtvApp.ShowMessage(SPropSQLAbsent);
    Exit;
  end;

  try
    Q.Open;
    try
      if (Q.FieldCount>0) then Result:=Q.Fields[0].Value;
    finally
      Q.Close;
    end;
  except
    if Not HideError then Raise;
  end;
end;

Function GetArrFromSQLText(aDataBaseName, aText:string; HideError:boolean):variant;
var PropInfo: PPropInfo;
    lSQL:TStrings;
    VarArr: array of variant;
    i: integer;
begin
  Result:=null;
  VarArr:=nil;

  if Not Assigned(Q) then begin
    if Assigned(OtherQueryClass) then
      Q:=OtherQueryClass.Create(nil)
    {$IFDEF BDE_IS_USED}
    else Q:=TQuery.Create(nil)
    {$ENDIF}
    ;
    if Q=nil then begin
      EtvApp.ShowMessage('Function GetFromSQLText:'+#13+SNeedQueryClass);
      Exit;
    end;
  end;

  SetObjectStrProp(Q,'DataBaseName',aDataBaseName);
  PropInfo:=GetPropInfo(Q.ClassInfo, 'SQL');
  if PropInfo<>nil then begin
    lSQL:=TStrings(GetOrdProp(Q, PropInfo));
    lSQL.Clear;
    lSQL.Add(aText);
  end else begin
    EtvApp.ShowMessage(SPropSQLAbsent);
    Exit;
  end;

  try
    Q.Open;
    try
      //if (Q.FieldCount>0) then Result:=Q.Fields[0].Value;
      SetLength(VarArr, Q.FieldCount);
      for i:=0 to High(VarArr) do
        VarArr[i] := Q.Fields[i].Value;
      Result := VarArr;
    finally
      Q.Close;
    end;
  except
    if Not HideError then Raise;
  end;
end;

procedure ExecSQLText(aDataBaseName, aText:string; HideError:boolean);
var PropInfo: PPropInfo;
    lSQL:TStrings;
begin
  if Not Assigned(Q) then begin
    if Assigned(OtherQueryClass) then
      Q:=OtherQueryClass.Create(nil)
    {$IFDEF BDE_IS_USED}
    else Q:=TQuery.Create(nil)
    {$ENDIF}
    ;
    if Q=nil then begin
      EtvApp.ShowMessage('Procedure ExecSQLText:'+#13+SNeedQueryClass);
      Exit;
    end;
  end;

  SetObjectStrProp(Q,'DataBaseName',aDataBaseName);
  PropInfo:=GetPropInfo(Q.ClassInfo, 'SQL');
  if PropInfo<>nil then begin
    lSQL:=TStrings(GetOrdProp(Q, PropInfo));
    lSQL.Clear;
    lSQL.Add(aText);
  end else begin
    EtvApp.ShowMessage(SPropSQLAbsent);
    Exit;
  end;

  try
    {$IFDEF BDE_IS_USED}
    if Q is TQuery then TQuery(Q).ExecSQL
    else
    {$ENDIF}
    try
      Q.Open;
    finally
      if Q.Active then Q.Close;
    end;
  except
    if Not HideError then Raise;
  end;
end;

function FieldDataByComma(aDataSet:TDataSet; aField:string):string;
begin
  Result:='';
  aDataSet.Open;
  aDataSet.First;
  while not aDataSet.EOF do begin
    if Result<>'' then Result:=Result+', ';
    Result:=Result+aDataSet.FieldByName(aField).AsString;
    aDataSet.Next;
  end;
  aDataSet.Close;
end;

Procedure RefreshDataOnForm(Form:TForm; All:boolean);
var i:smallint;
    List:TList;
    T,TLookup:TDataSet;
    Need:boolean;
    lForm:TForm;
    {$IFDEF BDE_IS_USED}
    PropInfo: PPropInfo;
    DS:TDataSource;
    {$ENDIF}
  procedure CheckForList(T:TDataset; First:boolean);
  var j:smallint;
  begin
    if (T<>nil) and (List.IndexOf(T)<0) then begin
      if First then List.Insert(0,T)
      else List.Add(T);
      for j:=0 to T.FieldCount-1 do
        if assigned(T.Fields[j].LookupDataSet) then
          CheckForList(T.Fields[j].LookupDataSet,True);
    end;
  end;
begin
  if Form<>nil then lForm:=Form
  else if Screen<>nil then lForm:=Screen.ActiveForm
    else lForm:=nil;
  if lForm<>nil  then with lForm do begin
    List:=TList.Create;
    for i:=0 to ComponentCount-1 do begin
      IsDBControl(components[i],T,TLookup);
      CheckForList(TLookup,True);
      CheckForList(T,False);
    end;
    for i:=0 to List.Count-1 do try
      if TDataSet(List[i]).Active then begin
        if All or
           ((TDataSet(List[i]).tag mod 100 div 10=9) and
            (not (TDataSet(List[i]).State in [dsInsert,dsEdit]))) then begin
          Need:=true;

          {$IFDEF BDE_IS_USED}
          PropInfo := GetPropInfo(TDataSet(List[i]).ClassInfo, 'MasterSource');
          if PropInfo <> nil then begin
            DS:=TDataSource(GetOrdProp(TDataSet(List[i]),PropInfo));
            if Assigned(DS) and (DS.DataSet is TQuery) and
               (All or (DS.DataSet.Tag mod 100 div 10=9)) and
               (List.IndexOf(DS.DataSet)>=0) then
              Need:=false;
          end;
          if Need and (TDataSet(List[i]) is TQuery) and
             Assigned(TQuery(List[i]).DataSource) and
             Assigned(TQuery(List[i]).DataSource.DataSet) and
             (All or (TQuery(List[i]).DataSource.DataSet.Tag mod 100 div 10=9)) and
             (List.IndexOf(TQuery(List[i]).DataSource.DataSet)>=0) then
            Need:=false;
          {$ENDIF}
          if Need then DataSetRefresh(TDataSet(List[i]));
        end;
      end else if All or (TDataSet(List[i]).Tag mod 100 div 10<>8) then
        TDataSet(List[i]).Open;
    except
    end;
    List.free;
  end;
end;

Function FIsDBControl(A:TComponent; NameProp:string):TComponent;
var PropInfo: PPropInfo;
    aDataSource: TDataSource;
begin
  Result:=nil;
  if (NameProp='DataSource') or (NameProp='DataField') then
    PropInfo := GetPropInfo(A.ClassInfo,'DataSource');
  if (NameProp='ListSource') then
    PropInfo := GetPropInfo(A.ClassInfo,'ListSource');
  if PropInfo <> nil then begin
    aDataSource:=TDataSource(GetOrdProp(A, PropInfo));
    if NameProp='DataField' then begin
      PropInfo:=GetPropInfo(A.ClassInfo,'DataField');
      Result:=aDataSource.DataSet.FieldByName(GetStrProp(A,PropInfo))
    end;
    if (NameProp='DataSource') or (NameProp='ListSource') then
      Result:=aDataSource;
  end;
end;

Procedure IsDBControl(A:Tcomponent; var DSet,DSetLookup:TDataSet);
var DS:TComponent;
begin
  DS:=FIsDBControl(A,'DataSource');
  if Assigned(DS) then DSet:=TDataSource(DS).DataSet else DSet:=nil;
  DS:=FIsDBControl(A,'ListSource');
  if Assigned(DS) then DSetLookup:=TDataSource(DS).DataSet else DSetLookup:=nil;
end;

initialization

finalization
  if Assigned(Q) then Q.Free;
end.

