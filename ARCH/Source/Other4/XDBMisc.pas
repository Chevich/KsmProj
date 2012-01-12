{*******************************************************}
{                                                       }
{            X-library v.03.05                          }
{                                                       }
{   07.10.97                   				}
{                                                       }
{   Mixers DB-functions                                 }
{                                                       }
{   Last corrections 23.10.98                           }
{                                                       }
{*******************************************************}
Unit XDBMisc;

Interface

Uses Classes, DB, DBTables, ppTypes, XMisc;

type
  TUserCloneFieldProc = procedure (Master, Child: TField);
  TUserFieldClassProc = function (AField: TField; var AFieldClass: TFieldClass): Boolean;

Function CreateFieldList(aDataSet: TDataSet; aFieldNames: String): TList;

{ Если в списке aList нет полей из строки aFiledNames, то они добавляются }
{ в исходный список aList                                                 }
Procedure ConcatFieldList(aDataSet: TDataSet; aFieldNames: String; aList: TList);

{function GetFieldNamesByList(aFieldsList: TList; aLast: Integer): String;}
Function GetFieldNamesByList(aFieldsList: TList; aValues: Variant): String;
Function GetBoundFieldNames(ADataSet: TDataSet; AFields: String; aBoundsList: TList): String;
Function GetAddFieldNames(ADataSet: TDataSet; AFields: String;
         ABlobs, AOnlyNumeric,ChangeLookFieldForKeyField:boolean): String;
Function GetVisibleFieldNames(aDataSet: TDataSet; aVisible: Boolean; aBlobs:boolean): String;

Function ChooseOrderIndexFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseContextIndexFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseVisibleFields(aDataSet: TDataSet; var aDst, aSrc: String): Boolean;
Function ChooseVisibleCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseResultCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseAggregateCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseAggrGroupByCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcList: TStringList; aCaption: String): Boolean;
Function ChooseCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
               aCalcType: TppDBCalcType; aBoundsList: TList): Boolean;
Function CalcFieldTotals(aDataSet: TDataSet; aTableName: String; aDatabaseName: String;
                         aSumCalc: String): TStringList;

Procedure DeleteFields(ADataSet: TDataSet);
Function ChangeToLookField(AField: TField; var ALookField: TField): Boolean;
{ По обычному полю находит первое LookUp'ное поле в DataSet'e }
Function GetLookField(aField: TField):TField;
{ По строке=списку имен полей через ';' возвращает индекс нужного поля.
Необходима для позиционирования в согласованном массиве }
Function GetIndexOfField(aFieldName: string; aFieldNames: string):integer;

Procedure CloneCalcListFields(Child: TDataSet; MasterList: TList; CalcList: TStringList;
               IsNotData, IsMoveLookup: Boolean);
Procedure CloneDatasetFieldNames(aMaster, aChild: TDataSet; Const aFieldNames: String; IsNotData, IsMoveLookup: Boolean);
Procedure CloneDataSetField(aDataSet: TDataSet; aFieldList: TList);
Procedure CreateLinkDefFields(aChild: TDataset);
{ В DataSet'e aChild путем сравнения с основным DataSet'ом создаются LookUp'ные поля, }
{ если они не были созданы раньше                                                     }
Procedure SetCompareDefFields(aChild, aMaster: TDataset; aFieldNames: String);
Function CreateQueryBaseOnFieldList(aTableName: String; aFieldList: TList; IsLookupScan: Boolean): String;
Function CreateQueryBaseOnFieldNames(aDataSet: TDataSet; aTableName: String;
               aFieldNames: String; IsLookupScan: Boolean): String;
Function CreateQueryOrderOnFieldList(aFieldList: TList; aTableName: String; IsLookupScan: Boolean): String;
Function CreateQueryOrderOnFieldNames(aDataSet: TDataSet; aTableName,
               aFieldNames: String; IsLookupScan: Boolean): String;
Function CreateQueryWhereOnFieldList(aFieldList: TList; aValueList: TStringList;
               aTableName: String; aLikeState: TXAlignment; IsLookupScan: Boolean): String;
Function CreateQueryWhereOnFieldListVar(aFieldList: TList; aValues: Variant;
               aTableName: String; aLikeState: TXAlignment; IsLookupScan: Boolean): String;
Function CreateQueryWhereOnFilter(aDataSet: TDataSet): String;

Function LinkDatasetLocate(aDataset: TDataset; aLinkDataset: TDataset; aFields: String): Boolean;
Function LinkDatasetListLocate(aDataset: TDataset; aLinkDataset: TDataset; aFieldsList: TList): Boolean;
Procedure ChangeFindLikeQuery(AQuery: TQuery; const ATableName: String;
                             var ALikeFields: String; ALikeList: TList;
                             APatterns: TStringList);
Function IsNotEqualLinkStrings(const ASourceFields: String; var ALikeFields: String;
                               AValues: TStrings; APatterns: TStrings): Boolean;
Function IsNotEqualLinkValues(const ASourceFields: String; var ALikeFields: String;
                             AValues: Variant; var APatterns: Variant): Boolean;
Procedure ChangeFindLikeQueryVar(AQuery: TQuery; const ATableName: String;
                                var ALikeFields: String; ALikeList: TList;
                                APatterns: Variant);

Procedure SetMinLengthFieldsByDataSet(aDataSet:TDBDataSet; AsInDataBase: boolean);

(*
//Autor:     Sergei Sotnik  mailto:sergei@alice.dp.ua
//Home page  http://www.alice.dp.ua/~sergei
Procedure ExportToExcel(aQuery:TQuery);
*)

var UserCloneFieldProc: TUserCloneFieldProc=nil;
    UserFieldClassProc: TUserFieldClassProc=nil;

Implementation

Uses SysUtils, Dialogs, EtvDBFun, DualFunc, EtvList, EtvTable,
     EtvPas, EtvTemp, EtvLook, LnTables;
(*
     { Для экспорта в Excel }
     Excel_TLB, ComObj;
//   Excel_TLB - Импортированная через "Project/Import type library"
//   библиотека EXCEL8.OLB
*)

Function LinkDatasetLocate(aDataset: TDataset; aLinkDataset: TDataset; aFields: String): Boolean;
var V: Variant;
begin
  Result:=False;
  if aFields<>'' then begin
    V:=aDataset.FieldValues[aFields];
    Result:= aLinkDataset.Locate(aFields, V, [loCaseInsensitive]);
    VarClear(V);
  end;
end;

Function GetFieldNamesByList(aFieldsList: TList; aValues: Variant): String;
{function GetFieldNamesByList(aFieldsList: TList; aLast: Integer): String;}
var i: Integer;
begin
{  if VarIsNull(aValues)or(aLast>=aFieldsList.Count) then aLast:= aFieldsList.Count-1;}
  Result:='';
{  for i:=0 to aLast do
      Result:=Result+TField(aFieldsList[i]).FieldName+';';}
  if not VarIsNull(aValues) then begin
    for i:=0 to aFieldsList.Count-1 do
      if aValues[i]<>Null then begin
        Result:=Result+TField(aFieldsList[i]).FieldName+';';
      end;
  end else begin
    for i:=0 to aFieldsList.Count-1 do
      Result:=Result+TField(aFieldsList[i]).FieldName+';';
  end;
  if Result<>'' then System.Delete(Result,Length(Result),1);
end;

Function LinkDatasetListLocate(aDataset: TDataset; aLinkDataset: TDataset; aFieldsList: TList): Boolean;
begin
  Result:=False;
  if Assigned(aFieldsList) and (aFieldsList.Count>0) then begin
//    {Result:= LinkDatasetLocate(aDataset, aLinkDataset, GetFieldNamesByList(aFieldsList, NULL));}
// Исправлено 31.03.2004 Lev. Чтобы в Locate не присутствовали CalcField's
     Result:= LinkDatasetLocate(aDataset, aLinkDataset, UniqueFieldsForDataSet(aDataSet));
  end;
end;

Function IsNotEqualLinkStrings(const ASourceFields: String; var ALikeFields: String;
                               AValues: TStrings; APatterns: TStrings): Boolean;
var i: Integer;
    Priz: Boolean;
begin
  Priz:=False;
  if ASourceFields<>ALikeFields then begin
    APatterns.Clear;
    APatterns.Assign(AValues);
    ALikeFields:=ASourceFields;
    Priz:=True;
  end else begin
    for i:=0 to APatterns.Count-1 do
      if AValues[i]<>APatterns[i] then begin
        APatterns.Clear;
        APatterns.Assign(AValues);
        Priz:=True;
        Break;
      end;
  end;
  Result:=Priz;
end;

Function IsNotEqualLinkValues(const ASourceFields: String; var ALikeFields: String;
                              AValues: Variant; var APatterns: Variant): Boolean;
var i: Integer;
    Priz: Boolean;
begin
  Priz:=False;
  if ASourceFields<>ALikeFields then begin
    VarClear(aPatterns);
    VarCopy(aPatterns, aValues);
    ALikeFields:=ASourceFields;
    Priz:=True;
  end else
    if VarIsArray(aPatterns) then begin
      for i:=0 to VarArrayHighBound(aPatterns.Count,1) do
        if AValues[i]<>APatterns[i] then begin
          VarClear(aPatterns);
          VarCopy(aPatterns, AValues);
          Priz:=True;
          Break;
        end;
    end else
      if AValues<>APatterns then begin
        VarClear(aPatterns);
        VarCopy(aPatterns, AValues);
        Priz:=True;
      end;
  Result:=Priz;
end;

Procedure ChangeFindLikeQuery(AQuery: TQuery; const ATableName: String;
                             var ALikeFields: String; ALikeList: TList;
                             APatterns: TStringList);
var S, aWhere: String;
    IsParams: boolean;
begin
  if Assigned(ALikeList) then begin
    with AQuery do begin
      Active:=False;
      SQL.Clear;
      S:=CreateQueryBaseOnFieldList(aTableName, aLikeList, True);
      S:=S+CreateQueryWhereOnFieldList(aLikeList, aPatterns, aTableName, xaMiddle, True);
      // Хитрый случай, когда в Lookup'ном DataSet'e есть условие where
      if TField(ALikeList[0]).DataSet is TEtvQuery then begin
        IsParams:=true;
        aWhere:=WhereFromSQL(TEtvQuery(TField(ALikeList[0]).DataSet).SQL.Text,true);
        if aWhere<>'' then S:=S+' and ('+aWhere+')';
      end else IsParams:=false;
      // Еще один хитрый случай, когда в Lookup'ном DataSet'e есть фильтр
      if TField(ALikeList[0]).DataSet.Filtered then begin
        Filter:=TField(ALikeList[0]).DataSet.Filter;
        Filtered:=true;
      end else begin
        Filtered:=false;
        Filter:='';
      end;
      S:=S+CreateQueryOrderOnFieldList(aLikeList, aTableName, True);
      SQL.Add(S);
      DeleteFields(AQuery);
      if IsParams then // А также клонируем параметры
        AQuery.Params.AssignValues(TEtvQuery(TField(ALikeList[0]).DataSet).Params);
      CloneDatasetFieldNames(TField(ALikeList[0]).DataSet,AQuery,ALikeFields,True, False);
      Active:=True;
      First;
    end;
    if AQuery.Active then
      LinkDatasetListLocate(AQuery, TTable(TField(ALikeList[0]).DataSet), ALikeList);
  end;
end;

Procedure ChangeFindLikeQueryVar(AQuery: TQuery; const ATableName: String;
                                var ALikeFields: String; ALikeList: TList;
                                APatterns: Variant);
var S: String;
begin
  if Assigned(ALikeList) then begin
     with AQuery do begin
       Active:=False;
       SQL.Clear;
       S:= CreateQueryBaseOnFieldList(aTableName, aLikeList, True);
       S:= S+CreateQueryWhereOnFieldListVar(aLikeList, aPatterns, aTableName, xaMiddle, True);
       S:= S+CreateQueryOrderOnFieldList(aLikeList, aTableName, True);
       SQL.Add(S);
       DeleteFields(AQuery);
       CloneDatasetFieldNames(TField(ALikeList[0]).DataSet,AQuery,ALikeFields,True, False);
       Active:=True;
       First;
     end;
     if AQuery.Active then
       LinkDatasetListLocate(AQuery, TTable(TField(ALikeList[0]).DataSet), ALikeList);
  end;
end;

Function GetBoundFieldNames(ADataSet: TDataSet; AFields: String; aBoundsList: TList): String;
var aList: TList;
    S: String;
    i: Integer;
begin
  aList:= TList.Create;
  S:='';
  try
    ADataSet.GetFieldList(aList, AFields);
    for i:=0 to aList.Count-1 do
      if aBoundsList.IndexOf(aList[i])<>-1 then S:= S+TField(aList[i]).FieldName+';';
    if S<>'' then SetLength(S, Length(S)-1);
  finally
    aList.Free;
  end;
  Result:= S;
end;

Function GetAddFieldNames(ADataSet: TDataSet; AFields: String;
         ABlobs, AOnlyNumeric,ChangeLookFieldForKeyField:boolean): String;
var AList: TList;
    S: String;
    i: Integer;
begin
  S:='';
  AList:= TList.Create;
  try
    ADataSet.GetFieldList(AList, AFields);
    for i:=0 to ADataSet.FieldCount-1 do
      if (AList.IndexOf(ADataSet.Fields[i])=-1) and (ADataSet.Fields[i].Tag<>8) then
        if AOnlyNumeric then begin
          if (ADataSet.Fields[i] is TNumericField) then
            S:=S+ADataSet.Fields[i].FieldName+';';
        end else
          if ((Not(ADataSet.Fields[i] is TBlobField)) or ABlobs) then
            if ChangeLookFieldForKeyField and ADataSet.Fields[i].LookUp then begin
              if Pos(ADataSet.Fields[i].KeyFields,AFields)=0 then
                S:=S+ADataSet.Fields[i].KeyFields+';'
            end else S:=S+ADataSet.Fields[i].FieldName+';';
    if S<>'' then SetLength(S, Length(S)-1);
  finally
    AList.Free;
  end;
  Result:= S;
end;

Function GetVisibleFieldNames(aDataSet: TDataSet; aVisible: Boolean; aBlobs:boolean): String;
var S: String;
    i: Integer;
begin
  S:='';
  if Assigned(aDataSet) then with aDataSet do begin
    for i:=0 to aDataSet.FieldCount-1 do
      if (Fields[i].Tag<>8) and (Not(aDataSet.Fields[i].Visible xor aVisible)) and
      (aBlobs or (not (Fields[i] is TBlobField))) then
        S:=S+aDataSet.Fields[i].FieldName+';';
    if S<>'' then SetLength(S, Length(S)-1);
  end;
  Result:=S;
end;

Function ChooseVisibleFields(aDataSet: TDataSet; var aDst, aSrc: String): Boolean;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, True, False, False);
  Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                          'Порядок и видимость полей',
                          'Видимые поля',
                          'Невидимые поля',
                           True, ';');
end;

Function GetFieldListNames(aList: TList; aSepChar: Char): String;
var i: Integer;
begin
  Result:='';
  for i:=0 to aList.Count-1 do Result:= Result+TField(aList[i]).FieldName+aSepChar;
  if Result<>'' then Delete(Result, Length(Result), 1);
end;

Function ChooseOrderIndexFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, False, False, True);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  Functions.Clear;
  Functions.Add('Asc');
  Functions.Add('Desc');
  Functions.Add('По умолчанию');

  if aCaption<>'' then aCaption:= 'Порядок сортировки/'+aCaption+'/'
    else aCaption:= 'Порядок сортировки';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList, aCaption,
                               'Поля сортировки', 'Остальные поля', False, ';');
  if Result then begin
    aSrc:= GetFieldListNames(aSrcList,';');
    aDst:= GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseContextIndexFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                  aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, False, False, True);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  Functions.Clear;
  Functions.Add('Middle');
  Functions.Add('Left');
  Functions.Add('Right');
  Functions.Add('Без контекста');

  if aCaption<>'' then aCaption:= 'Контекстность полей/'+aCaption+'/'
  else aCaption:= 'Контекстность полей';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList,
                               aCaption, 'Поля контекста', 'Остальные поля', False, ';');
  if Result then begin
    aSrc:= GetFieldListNames(aSrcList,';');
    aDst:= GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseVisibleCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                 aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, True, False, False);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  Functions.Clear;
  Functions.Add('NoRep');
  Functions.Add('Без функции');

  if aCaption<>'' then aCaption:= 'Видимость полей/'+aCaption+'/'
  else aCaption:= 'Видимость полей';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList,
                               aCaption, 'Видимые поля', 'Невидимые поля', True, ';');
  if Result then begin
    aSrc:= GetFieldListNames(aSrcList,';');
    aDst:= GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseResultCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, True, False, False);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  Functions.Clear;
  Functions.Add('Count');
  Functions.Add('Sum');
  Functions.Add('Min');
  Functions.Add('Max');
  Functions.Add('Avr');
  Functions.Add('Без функции');

  if aCaption<>'' then aCaption:= 'Итоги полей/'+aCaption+'/'
  else aCaption:= 'Итоги полей';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList,
                               aCaption, 'Поля итогов', 'Остальные поля', True, ';');
  if Result then begin
    aSrc:= GetFieldListNames(aSrcList,';');
    aDst:= GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseAggregateCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                   aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, True, False, False);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  Functions.Clear;
  Functions.Add('Count');
  Functions.Add('Sum');
  Functions.Add('Min');
  Functions.Add('Max');
  Functions.Add('Avr');
  Functions.Add('Без функции');

  if aCaption<>'' then aCaption:= 'Агрегатная выборка/'+aCaption+'/'
  else aCaption:= 'Агрегатная выборка';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList,
                               aCaption, 'Выбранные поля', 'Остальные поля', True, ';');
  if Result then begin
    aSrc:= GetFieldListNames(aSrcList,';');
    aDst:= GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseAggrGroupByCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
                                     aCalcList: TStringList; aCaption: String): Boolean;
var aSrcList, aDstList: TList;
    i: Integer;
begin
  aSrc:=GetAddFieldNames(aDataSet, aDst, True, False, False);
  aSrcList:= TList.Create;
  aDataSet.GetFieldList(aSrcList, aSrc);
  aDstList:= TList.Create;
  aDataSet.GetFieldList(aDstList, aDst);
  for i:=0 to aSrcList.Count-1 do aCalcList.Add('');

  Functions.Clear;
  Functions.Add('Без функции');

  if aCaption<>'' then aCaption:= 'Group By/'+aCaption+'/'
  else aCaption:= 'Group By';
  Result:= ChooseFieldListFunc(aDataSet, aDstList, aSrcList, aCalcList,
                               aCaption, 'Выбранные поля', 'Остальные поля', True, ';');
  { Замена в aDstList'е LookUp'ных полей на KeyField'овые }
  for i:=0 to aDstList.Count-1 do with TField(aDstList[i]) do
    if FieldKind=fkLookUp then aDstList[i]:=DataSet.FieldByName(KeyFields);
  if Result then begin
    aSrc:=GetFieldListNames(aSrcList,';');
    aDst:=GetFieldListNames(aDstList,';');
  end;
  aSrcList.Free;
  aDstList.Free;
end;

Function ChooseCalcFields(aDataSet: TDataSet; var aDst, aSrc: String;
                          aCalcType: TppDBCalcType; aBoundsList: TList): Boolean;
begin
  case aCalcType of
    dcCount: aSrc:=GetAddFieldNames(aDataSet, aDst, False, False, False);
    dcSum: aSrc:=GetAddFieldNames(aDataSet, aDst, False, True, False);
    dcMinimum: aSrc:=GetAddFieldNames(aDataSet, aDst, False, False, False);
    dcMaximum: aSrc:=GetAddFieldNames(aDataSet, aDst, False, False, False);
    dcAverage: aSrc:=GetAddFieldNames(aDataSet, aDst, False, True, False);
  end;
  if Assigned(aBoundsList) then begin
    aDst:= GetBoundFieldNames(aDataSet, aDst, aBoundsList);
    aSrc:= GetBoundFieldNames(aDataSet, aSrc, aBoundsList);
  end;
  case aCalcType of
    dcCount: Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                                     'Поля для расчетов количеств',
                                     'Поля количеств',
                                     'Остальные поля', False, ';');
    dcSum: Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                                     'Поля для суммирования',
                                     'Поля суммирования',
                                     'Остальные поля', False, ';');
    dcMinimum: Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                                     'Поля для расчетов минимальных',
                                     'Поля минимальных',
                                     'Остальные поля', False, ';');
    dcMaximum: Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                                     'Поля для расчетов максимальных',
                                     'Поля максимальных',
                                     'Остальные поля', False, ';');
    dcAverage: Result:= ChooseFieldList(aDataSet, aDst, aSrc,
                                     'Поля для расчетов средних',
                                     'Поля средних',
                                     'Остальные поля', False, ';');
    end;
end;

Function CreateFilterCondition(aDataSet: TDataSet): String;
var SubCondition:string;
    DetailFieldName: string[20]; { Имя поля Detail таблицы, по которому осуществляется связь с Master-table }
                                 { При формировании Query для экспорта в Excel, нужно добавить условие в секцию "Where" }
    i,j,k: Integer;
begin
  Result:='';
  {*** LEV 25.11.2009 *** Работа над задачей "Протоколы совещаний" }
  { Разборки с MasterSource }                                             // Lev 26.04.2010 добавил условия dsInactive and RecordCount ниже
  if (aDataSet is TTable) and (aDataSet.State<>dsInactive) and Assigned(TTable(aDataSet).MasterSource) and (aDataSet.RecordCount>0) then begin
    { Имя поля у Detail таблицы, по которому образована связь Detail <--> Master }
    { Пока предполагаем, что поле - одно, если появятся случаи связи по нескольким полям, тогда и будем думать }
    DetailFieldName:=TTable(aDataSet).IndexFieldNames;
    i:=Pos(';',DetailFieldName);
    if i>0 then DetailFieldName:=Copy(DetailFieldName,1,i-1); { Если индекс не из одного поля }
    Result:='('+DetailFieldName+'='+aDataSet.FieldByName(DetailFieldName).AsString+')'
  end;

  if aDataSet.Filtered then
    if Result='' then Result:=aDataSet.Filter
    else Result:=Result+' and ('+aDataSet.Filter+')'; { На всякий случай берем в скобки, чтобы не нарушить логику предикатов }

  if Result='' then Exit;
  { Разборки с Null }
  j:=1; i:=1;
  while i>0 do begin
    SubCondition:=Copy(Result,j,MaxInt);
    i:=Pos('Null',SubCondition);
    if i>0 then begin
      if SubCondition[i-1]='=' then begin { Заменяем "=" на " is "}
        Result:=Copy(Result,1,j+i-3)+' is '+Copy(Result,j+i-1,MaxInt);
        Inc(i,3)
      end else begin { Заменяем "<>" на " is not "}
        Result:=Copy(Result,1,j+i-4)+' is not '+Copy(Result,j+i-1,MaxInt);
        Inc(i,6);
      end;
      Inc(j,i+4);
    end;
  end;
  { Разборки с именами полей }
  if aDataSet is TTable then with TTable(aDataSet) do
    for k:=0 to FieldCount-1 do with Fields[k] do begin
      j:=1; i:=1;
      while i>0 do begin
        SubCondition:=Copy(Result,j,MaxInt);
        i:=Pos(FieldName,SubCondition);
        { Проверка на совпадения части поля после поля }
        if (i>0) then
          if not(SubCondition[i+Length(FieldName)] in[' ','<','>','=','~']) then i:=0;
        { Проверка на совпадения части поля до поля }
        if (i>1) then
          if not(SubCondition[i-1] in['(']) then i:=0;
        if i>0 then begin
          Result:=Copy(Result,1,j+i-2)+TableName+'.'+Copy(Result,j+i-1,MaxInt);
          Inc(j,i+Length(TableName+'.')+Length(FieldName));
        end;
      end;
    end;
end;

Function CreateQueryWhereOnFilter(aDataSet: TDataSet): String;
begin
  Result:=CreateFilterCondition(aDataSet);
  if Result<>'' then Result:= ' where '+Result;
end;

{ queries servis }

var QueriesProcess, QueriesLookup: TQuery;
{$IFDEF DEBUG}
	DebugStr(' ');
{$ENDIF}

Function CalcFieldTotals(aDataSet: TDataSet; aTableName: String; aDatabaseName: String;
                         aSumCalc: String): TStringList;
var TotalFields: TList;  {список полей, по которым будем пересчитывать итоги }
    i:byte;
    aFieldList:string;
    aSearchCondition:string;
    aFilterCondition:string;
    aQuote:string[1];
    // by Fialko
    aMasterSourceString,aMasterField,aJoinedField,aJoinedString:String;
    //end
    IsSTATable:boolean;

  procedure Quoted_Identifier_Switch(aSwitch:boolean);
  begin
    with QueriesLookup do begin
      SQL.Clear;
      if aSwitch then SQL.Add('SET temporary option quoted_identifier=OFF')
      else SQL.Add('SET temporary option quoted_identifier="ON"');
      Prepare;
      ExecSQL;
      Sql.Clear;
    end;
  end;

  procedure CalcTotals(aTableName:String; SearchCondition:String; aFieldList:String);
  begin
    with QueriesProcess do begin
      SQL.Clear;
      SQL.Add('call STA.CalcTotals('+'"'+aTableName+'"'+','+'"'+SearchCondition+'"'+','+aFieldList+');');
      Quoted_Identifier_Switch(true);
      try
        QueriesProcess.Open;
      finally
        Quoted_Identifier_Switch(false);
      end;
    end;
  end;

  procedure CalcTotalsNotSTA(aTableName:String; SearchCondition:String; aFieldList:String);
  begin
    with QueriesProcess do begin
      SQL.Clear;
      if SearchCondition<>'' then SearchCondition:=' where '+SearchCondition;
      SQL.Add('select '+aFieldList+' from '+aTableName+SearchCondition);
      try
        QueriesProcess.Open;
      finally
      end;
    end;
  end;

begin
  // Нехороший случай - итоги считаем в DetailTable, а в MasterTable происходит вставка новой записи
  // В такой ситуации просто тихо выходим из процедуры (по-английски) :). Lev 03.05.2010
  if Assigned(TTable(aDataSet).MasterSource) and (TTable(aDataSet).MasterSource.State=dsInsert) then Exit;
  if AnsiUpperCase(Copy(aTableName,1,3))='STA' then IsSTATable:=true else IsSTATable:=False;
  Result:= TStringList.Create;
  TotalFields:= TList.Create;
  try
    aSearchCondition:='';
    QueriesProcess.DatabaseName:=aDatabaseName;
    QueriesLookup.DatabaseName:=aDatabaseName;
    aDataSet.GetFieldList(TotalFields, aSumCalc);
    if (TotalFields.Count=0) {or (aDataSet.RecordCount=0)} then Exit;
    { Формированеие условия where на основе aDataSet=TQuery }
    if aDataSet is TQuery then
      aSearchCondition:=WhereFromSQL(TQuery(aDataSet).SQL.Text, True);
    { Формирование условия where на основе property Filter DataSet'a }
    aFilterCondition:=CreateFilterCondition(aDataSet);
    if aFilterCondition<>'' then
      if aSearchCondition='' then aSearchCondition:=aFilterCondition
      else aSearchCondition:=aSearchCondition+' and ('+aFilterCondition+')';

    { Формирование параметра FieldList }
    if IsSTATable then begin
      aFieldList:='';
      for i:=0 to TotalFields.Count-1 do
        aFieldList:=aFieldList+''''+TField(TotalFields[i]).FieldName+''',';
      if aFieldList<>'' then Delete(aFieldList,length(aFieldList),1);

      // by Fialko для корректного расчета при наличии связи Detail --> Master у датасета
      if aDataSet is TTable then                        // Lev 29.04.2010
        if Assigned(TTable(aDataSet).MasterSource) {and (aDataSet.RecordCount>0)} then begin
          aMasterSourceString:=TTable(aDataSet).MasterFields+';';
          aJoinedString:=TTable(aDataSet).IndexFieldNames+';';
          Repeat
            aMasterField:=Copy(aMasterSourceString,1,pos(';',aMasterSourceString)-1);
            aJoinedField:=Copy(aJoinedString,1,pos(';',aJoinedString)-1);
            if aSearchCondition<>'' then aSearchCondition:=aSearchCondition+' and ';
              case aDataSet.FieldByName(aJoinedField).DataType of
                ftString,ftMemo,ftFmtMemo,ftFixedChar,ftWideString,
                ftDate,ftTime,ftDateTime : aQuote:='''';
                ftSmallint,ftInteger,ftWord,ftFloat,ftCurrency,ftBytes,ftVarBytes,ftAutoInc,ftTypedBinary,
                ftLargeInt : aQuote:='';
                Else Raise EDatabaseError.Create('Не могу наложить фильтр master-table!')
              end;
            aSearchCondition:=aSearchCondition+aJoinedField+'='+aQuote+
              TTable(aDataSet).MasterSource.DataSet.FieldByName(aMasterField).asString+aQuote;
            delete(aMasterSourceString,1,pos(';',aMasterSourceString));
            delete(aJoinedString,1,pos(';',aJoinedString))
          Until pos(';',aMasterSourceString)=0;
          // by Lev Если Quota=''', то в конец aSearchCondition надо еще раз ее прилепить, иначе - глюк...
          {if aQuote=''' then aSearchCondition:=aSearchCondition+aQuote;}
        end;
      // end Fialko
      CalcTotals(aTableName,aSearchCondition,aFieldList);
    end else begin
      aFieldList:='';
      for i:=0 to TotalFields.Count-1 do
        aFieldList:='Sum('+TField(TotalFields[i]).FieldName+') as i'+IntToStr(i+1)+',';
      if aFieldList<>'' then Delete(aFieldList,length(aFieldList),1);
      CalcTotalsNotSTA(aTableName,aSearchCondition,aFieldList);
    end;

    for i:=0 to TotalFields.Count-1 do
      Result.AddObject(FormatFloat({'###,##0.00'}TNumericField(TotalFields[i]).DisplayFormat,
        QueriesProcess.FieldByName('i'+IntToStr(i+1)).AsFloat),
          TField(TotalFields[i]));
  finally
    QueriesProcess.Sql.Clear;
    TotalFields.Free;
  end;
end;

Procedure DeleteFields(ADataSet: TDataSet);
var i: Integer;
begin
  for i:=0 to ADataSet.FieldCount-1 do ADataSet.Fields[0].Free;
end;

Procedure AssignCloneField(Master, Child: TField);
begin
  with Child do begin
    Alignment:=Master.Alignment;
    DisplayLabel:=Master.DisplayLabel;
    DisplayWidth:=Master.DisplayWidth;
    KeyFields:=Master.KeyFields;
    LookupKeyFields:=Master.LookupKeyFields;
    LookupResultField:=Master.LookupResultField;
    LookupDataSet:=Master.LookupDataSet;
    LookupCache:=Master.LookupCache;
    ReadOnly:=Master.ReadOnly;
    Required:=Master.Required;
    Visible:=Master.Visible;
    Origin:=Master.Origin;
    ImportedConstraint:=Master.ImportedConstraint;
    CustomConstraint:=Master.CustomConstraint;
    DefaultExpression:=Master.DefaultExpression;
    ConstraintErrorMessage:=Master.ConstraintErrorMessage;
    OnChange:=Master.OnChange;
    OnGetText:=Master.OnGetText;
    OnSetText:=Master.OnSetText;
    OnValidate:=Master.OnValidate;
{!} Size:=Master.Size;
    case DataType of
      ftString:
        begin
          EditMask:=Master.EditMask;
          {Size}
          TStringField(Child).Transliterate:=TStringField(Master).Transliterate;
        end;
      ftInteger, ftSmallInt, ftWord, ftAutoInc:
        begin
          TNumericField(Child).DisplayFormat:=TNumericField(Master).DisplayFormat;
          TNumericField(Child).EditFormat:=TNumericField(Master).EditFormat;
          TIntegerField(Child).MaxValue:=TIntegerField(Master).MaxValue;
          TIntegerField(Child).MinValue:=TIntegerField(Master).MinValue;
        end;
      ftFloat, ftCurrency:
        begin
          TNumericField(Child).DisplayFormat:=TNumericField(Master).DisplayFormat;
          TNumericField(Child).EditFormat:=TNumericField(Master).EditFormat;
          TFloatField(Child).Currency:=TFloatField(Master).Currency;
          TFloatField(Child).MaxValue:=TFloatField(Master).MaxValue;
          TFloatField(Child).MinValue:=TFloatField(Master).MinValue;
          TFloatField(Child).Precision:=TFloatField(Master).Precision;
        end;
      ftBCD:
        begin
          TNumericField(Child).DisplayFormat:=TNumericField(Master).DisplayFormat;
          TNumericField(Child).EditFormat:=TNumericField(Master).EditFormat;
          TBCDField(Child).Currency:=TBCDField(Master).Currency;
          TBCDField(Child).MaxValue:=TBCDField(Master).MaxValue;
          TBCDField(Child).MinValue:=TBCDField(Master).MinValue;
          Size:=Master.Size;
        end;
      ftBoolean:
        begin
          TBooleanField(Child).DisplayValues:=TBooleanField(Master).DisplayValues;
        end;
      ftDateTime, ftDate, ftTime:
        begin
          TDateTimeField(Child).DisplayFormat:=TDateTimeField(Master).DisplayFormat;
          EditMask:=Master.EditMask;
        end;
      ftBytes, ftVarBytes:
        begin
          Size:=Master.Size;
        end;
      ftBlob, ftMemo, ftGraphic:
        begin
          TBlobField(Child).BlobType:=TBlobField(Master).BlobType;
          Size:=Master.Size;
          TBlobField(Child).Transliterate:=TBlobField(Master).Transliterate;
        end;
    end;
  end;
  if Assigned(UserCloneFieldProc) then UserCloneFieldProc(Master, Child);
end;

Function ChangeToLookField(AField: TField; var ALookField: TField): Boolean;
begin
  aLookField:=GetLookField(aField);
  Result:=aLookField<>nil;
end;

{ По обычному полю находит первое LookUp'ное поле в DataSet'e }
Function GetLookField(aField: TField):TField;
var i: Integer;
begin
  Result:=nil;
  if Assigned(aField.DataSet) then with aField.DataSet do
    for i:=0 to FieldCount-1 do
      if (Fields[i].FieldKind=fkLookup) and
      (FieldByName(Fields[i].KeyFields)=aField) then begin
        Result:=Fields[i];
        Exit;
      end;
end;

Function CreateDataField(aDataSet: TDataSet; aMasterField: TField): TField;
var aFieldClass: TFieldClass;
begin
  if not (Assigned(UserFieldClassProc) and UserFieldClassProc(aMasterField, aFieldClass)) then
    aFieldClass:=DefaultFieldClasses[aMasterField.DataType];
  Result:= aFieldClass.Create(aDataSet.Owner);
  Result.FieldName:= aMasterField.FieldName;
  Result.DataSet:= aDataSet;
  Result.FieldKind:= fkData;
{     Result:=aDataSet.FieldDefs.Find(aMasterField.FieldName).CreateField(aDataSet);}
end;

Function CreateCommonField(aChild: TDataset; aMasterField: TField): TField;
var aFieldClass: TFieldClass;
begin
  if not (Assigned(UserFieldClassProc) and UserFieldClassProc(aMasterField, aFieldClass)) then
    aFieldClass:=DefaultFieldClasses[aMasterField.DataType];
  Result:= aFieldClass.Create(aChild.Owner);
  Result.FieldKind:=aMasterField.FieldKind;
  Result.FieldName:=aMasterField.FieldName;
  AssignCloneField(aMasterField, Result);
  Result.DataSet:= aChild;
  Result.Index:=aMasterField.Index;
end;

type TDatasetSelf = class(TDataset)
     end;

Procedure CreateLinkDefFields(aChild: TDataset);
begin
  aChild.FieldDefs.Update;
  TDatasetSelf(aChild).CreateFields;
end;

Procedure SetCompareDefFields(aChild, aMaster: TDataset; aFieldNames: String);
var i, j, k: Integer;
    aList: TList;
    Priz: Boolean;
    aField: TField;
    S, S1: String;
begin
  aList:= TList.Create;
  try
    aMaster.GetFieldList(aList, aFieldNames);
    for i:=0 to aList.Count-1 do begin
      Priz:= True;
      for j:=0 to aChild.FieldCount-1 do begin
        if (AnsiCompareStr(TField(aList[i]).FieldName,aChild.Fields[j].FieldName)=0) then begin
          {aChild.Fields[j].DisplayLabel:=TField(aList[i]).DisplayLabel;}
          Priz:= False;
          Break;
        end;
      end;
      if Priz and (TField(aList[i]).FieldKind=fkLookup) then begin
        CreateCommonField(aChild, TField(aList[i]));
      end;
    end;
  finally
    aList.Free;
  end;

  for i:=0 to aChild.FieldCount-1 do begin
    for j:=0 to aMaster.FieldCount-1 do begin
      if AnsiCompareStr(aChild.Fields[i].FieldName, aMaster.Fields[j].FieldName)=0 then begin
        if aMaster.Fields[j] is TEtvListField then begin
          aChild.Fields[i].Free;
          aField:=CreateCommonField(aChild, aMaster.Fields[j]);
          aField.Index:=i;
        end;
        AssignCloneField(aMaster.Fields[j], aChild.Fields[i]);
        Break;
      end;
      if Pos('('+aMaster.Fields[j].FieldName+')', aChild.Fields[i].FieldName)>0 then begin
        S:=aChild.Fields[i].DisplayLabel;
        AssignCloneField(aMaster.Fields[j], aChild.Fields[i]);
        k:=Pos(aMaster.Fields[j].FieldName, S);
        System.Delete(S, k,Length(aMaster.Fields[j].FieldName));
        S1:=aChild.Fields[i].DisplayLabel;
        System.Insert(S1, S, k);
        aChild.Fields[i].DisplayLabel:=S;
        aChild.Fields[i].DisplayWidth:=aChild.Fields[i].DisplayWidth+
          (Length(aChild.Fields[i].FieldName)-Length(aMaster.Fields[j].FieldName)+1);
        Break;
      end;
    end;
  end;
end;

Procedure CloneCalcListFields(Child: TDataSet; MasterList: TList; CalcList: TStringList;
                              IsNotData, IsMoveLookup: Boolean);
var i: Integer;
    AField: TField;
{    AFieldClass: TFieldClass;}
begin
  with Child do begin
    FieldDefs.Update;
    for i:=0 to MasterList.Count-1 do begin
{ Это вставил Lev 22.04.99 по совету Igo вместо закомментаренного ниже текста
Начало... }
      AField:=TField(MasterList[i]);
      if not (AField is TBlobField) then begin
        TField(CloneComponent(TField(MasterList[i]))).DataSet:=Child;
        {lDataSet.Fields[lDataSet.fieldCount-1].ReadOnly:=false;}
      end;
{...Конец }
(*
      if TField(MasterList[i]).FieldKind=fkData then begin
        AField:= CreateDataField(Child,TField(MasterList[i]));
        AssignCloneField(TField(MasterList[i]), AField);
        if IsMoveLookup and ChangeToLookField(TField(MasterList[i]), BField)then begin
          AField.LookupDataSet:=BField.LookupDataSet;
          AField.LookupKeyFields:=BField.LookupKeyFields;
          AField.LookupResultField:=BField.LookupResultField;
          AField.DisplayLabel:=BField.DisplayLabel;
          AField.DisplayWidth:=BField.DisplayWidth;
        end;
      end else if IsNotData then begin
        aField:= CreateCommonField(Child, TField(MasterList[i]));
      end;
*)
    end;
  end;
end;

Procedure CloneDatasetFieldNames(aMaster, aChild: TDataSet; Const aFieldNames: String; IsNotData, IsMoveLookup: Boolean);
var aList: TList;
    i: Integer;
begin
  AList:=TList.Create;
  if aFieldNames='' then
    for i:=0 to aMaster.FieldCount-1 do aList.Add(aMaster.Fields[i])
  else aMaster.GetFieldList(aList, aFieldNames);
  CloneCalcListFields(aChild, aList, nil, IsNotData, IsMoveLookup);
  AList.Free;
end;

Procedure CloneDataSetField(aDataSet: TDataSet; aFieldList: TList);
var i:integer;
begin
  for i:=0 to aFieldList.Count-1 do begin
    {if not (Fields[i] is TBlobField) then begin}
    if aDataSet.FindField(TField(aFieldList[i]).FieldName)=nil then begin
      TField(CloneComponent(TField(aFieldList[i]))).DataSet:=aDataSet;
      aDataSet.Fields[aDataSet.FieldCount-1].ReadOnly:=false;
    end;
  end;
end;

Function GetQueryFieldName(aFieldName: String; aTableName: String): String;
begin
  Result:= aFieldName;
{Lev 20.05.2000}
  {if Pos(' ', Result)>0 then Result:= aTableName+'.'+'"'+Result+'"';}
{Lev 20.05.2000}
end;

Function CreateQueryBaseOnFieldList(aTableName: String; aFieldList: TList; IsLookupScan: Boolean): String;
var S: String;
    aField: TField;
    i: Integer;
begin
  S:='';
  if aTableName<>'' then begin
    if Assigned(aFieldList) then
      for i:=0 to aFieldList.Count-1 do begin
        aField:=TField(aFieldList[i]);
        if aField.FieldKind=fkData then begin
          S:=S+GetQueryFieldName(aField.FieldName, aTableName)+', ';
        end else
          if IsLookupScan and (aField.FieldKind=fkLookup) then begin
            aField:=aField.DataSet.FieldByName(aField.KeyFields);
            if (aFieldList.IndexOf(aField)=-1) and (aField.FieldKind=fkData) then begin
              S:=S+GetQueryFieldName(aField.FieldName, aTableName)+', ';
            end;
          end;
      end;
    if S<>'' then begin
      System.Delete(S,Length(S)-1,2);
      S:= 'Select '+S+' from '+ATableName;
    end else S:= 'Select * from '+ATableName;
  end;
  Result:= S;
end;

Function CreateQueryBaseOnFieldNames(aDataSet: TDataSet; aTableName: String;
                                     aFieldNames: String; IsLookupScan: Boolean): String;
var aList: TList;
begin
  {aList:= TList.Create;}
  aList:=GetFieldListExt(aDataSet,{AllFields}VisibleUserFields,false);
  try
    {aDataSet.GetFieldList(aList, aFieldNames);}
    Result:= CreateQueryBaseOnFieldList(aTableName, aList, IsLookupScan);
  finally
    aList.Free;
  end;
end;

Function CreateQueryOrderOnFieldList(aFieldList: TList; aTableName: String; IsLookupScan: Boolean): String;
var i: Integer;
    AField: TField;
    S: String;
begin
  S:='';
  if Assigned(aFieldList) then
    for i:=0 to aFieldList.Count-1 do begin
      aField:=TField(aFieldList[i]);
      if (aField.FieldKind=fkData) {and (aField.Visible)} then begin
        S:=S+GetQueryFieldName(aField.FieldName, aTableName)+',';
      end else
        if IsLookupScan and (aField.FieldKind=fkLookup) then begin
          aField:=aField.DataSet.FieldByName(aField.KeyFields);
          if aFieldList.IndexOf(AField)=-1 then begin
            S:=S+GetQueryFieldName(aField.FieldName, aTableName)+',';
          end;
        end;
    end;
  if S<>'' then begin
    System.Delete(S,Length(S),1);
    S:= ' order by '+S;
  end;
  Result:= S;
end;

Function CreateFieldList(aDataSet: TDataSet; aFieldNames: String): TList;
begin
  Result:= TList.Create;
  try
    aDataset.GetFieldList(Result, aFieldNames);
  except
    Result.Free;
    Result:=nil;
  end;
end;

Procedure ConcatFieldList(aDataSet: TDataSet; aFieldNames: String; aList: TList);
var bList: TList;
    i: Integer;
begin
  bList:= TList.Create;
  try
    aDataset.GetFieldList(bList, aFieldNames);
    for i:=0 to bList.Count-1 do if aList.IndexOf(bList[i])=-1 then aList.Add(bList[i]);
  finally
    bList.Clear;
    bList.Free;
  end;
end;

Function CreateQueryOrderOnFieldNames(aDataSet: TDataSet; aTableName,
                                      aFieldNames: String; IsLookupScan: Boolean): String;
var aList: TList;
    S: String;
    i: Integer;
begin
  if (aDataset.FieldCount>0)and(aFieldNames<>'') then begin
    aList:= CreateFieldList(aDataset, aFieldNames);
{     aList:= TList.Create;}
    if Assigned(aList) then
    try
{        aDataSet.GetFieldList(aList, aFieldNames);}
      Result:= CreateQueryOrderOnFieldList(aList, aTableName, IsLookupScan);
    finally
      aList.Free;
    end;
  end else begin
    Result:= '';
    if aFieldNames<>'' then
    repeat
      i:= Pos(';', aFieldNames);
      if i>0 then begin
        S:= copy(aFieldNames,1,i-1);
        Delete(aFieldNames,1,i);
      end else S:=aFieldNames;
      if aDataSet.FieldByName(S).Visible then
        Result:= Result+GetQueryFieldName(S, aTableName)+', ';
    until i=0;
    if Result<>'' then begin
      System.Delete(Result, Length(Result)-1,2);
      Result:= ' order by '+Result;
    end;
  end;
end;

Function CreateQueryWhereOnFieldList(aFieldList: TList; aValueList: TStringList;
               aTableName: String; aLikeState: TXAlignment; IsLookupScan: Boolean): String;
var S: String;
    Priz: Boolean;
    i: Integer;
    aField: TField;
begin
  S:= '';
  Priz:=False;
  if Assigned(aFieldList) and Assigned(aValueList) then
    for i:=0 to aValueList.Count-1 do begin
      aField:=TField(aFieldList[i]);
      if aField.FieldKind=fkData then begin
        if aValueList[i]<>'' then begin
          S:= S+'('+GetQueryFieldName(aField.FieldName, aTableName)+' like ';
          if aLikeState in [xaLeft, xaMiddle] then S:= S+#39#37;
          S:= S+aValueList[i];
          if aLikeState in [xaMiddle, xaRight] then S:= S+#37#39;
          S:= S+')';
          S:=S+' and ';
          Priz:=True;
        end;
      end else
        if IsLookupScan and (aField.FieldKind=fkLookup) then begin
          aField:=aField.DataSet.FieldByName(aField.KeyFields);
          if aFieldList.IndexOf(aField)=-1 then begin
            if aValueList[i]<>'' then begin
              S:= S+'('+GetQueryFieldName(aField.FieldName, aTableName)+' like ';
              if aLikeState in [xaLeft, xaMiddle] then S:= S+#39#37;
              S:= S+aValueList[i];
              if aLikeState in [xaMiddle, xaRight] then S:= S+#37#39;
              S:=S+' and ';
              Priz:=True;
            end;
          end;
        end;
    end;
  if Priz then begin
    System.Delete(S,Length(S)-4,5);
    S:= ' where '+S;
  end;
  Result:= S;
end;

Function CreateQueryWhereOnFieldListVar(aFieldList: TList; aValues: Variant;
               aTableName: String; aLikeState: TXAlignment; IsLookupScan: Boolean): String;
var S: String;
    Priz: Boolean;
    i: Integer;

  {cast(BIOLIFE.DB."species no" as char(10))}
  procedure SelectOneField(aField: TField; aValue: Variant);
  begin
    if aField.FieldKind=fkData then begin
      if VarAsType(aValue,varString)<>'' then begin
        if aField is TNumericField then
          S:=S+'(cast('+GetQueryFieldName(aField.FieldName, aTableName)+
               'as char('+IntToStr(255)+')) like '
        else S:= S+'('+GetQueryFieldName(aField.FieldName, aTableName)+' like ';
        if aLikeState in [xaLeft, xaMiddle] then S:= S+#39#37;
        S:= S+VarAsType(aValue,varString);
        if aLikeState in [xaMiddle, xaRight] then S:= S+#37#39;
        S:= S+') and ';
        Priz:=True;
      end;
    end else
      if IsLookupScan and (aField.FieldKind=fkLookup) then begin
        aField:=aField.DataSet.FieldByName(aField.KeyFields);
        if aFieldList.IndexOf(aField)=-1 then begin
          if VarAsType(aValue,varString)<>'' then begin
            S:= S+'('+GetQueryFieldName(aField.FieldName, aTableName)+' like ';
            if aLikeState in [xaLeft, xaMiddle] then S:= S+#39#37;
            S:= S+VarAsType(aValue,varString);
            if aLikeState in [xaMiddle, xaRight] then S:= S+#37#39;
            S:=S+' and ';
            Priz:=True;
          end;
        end;
      end;
  end;

begin
  S:= '';
  Priz:=False;
  if not VarIsEmpty(aValues) then
    if VarIsArray(aValues) then
      for i:=0 to VarArrayHighBound(aValues,1) do
        SelectOneField(TField(aFieldList[i]), aValues[i])
    else SelectOneField(TField(aFieldList[0]), aValues);
  if Priz then begin
    System.Delete(S,Length(S)-4,5);
    S:= ' where '+S;
  end;
  Result:= S;
end;

Procedure SetMinLengthFieldsByDataSet(aDataSet:TDBDataSet; AsInDataBase: boolean);
const MaxEtvLook=50; { Мах EtvLookField на один DataSet }
var lTableName,s:string;
    Q:TEtvQuery;
    Exist:boolean;
    list:tstrings;
    i,l:integer;
    lFunc: String;
    lFieldName:String;
    lJoinString: String;
    EtvLookInfo:array[1..MaxEtvLook,0..3] of string;
    EtvLookCount: byte; { всего луковых полей на датасет }
    EtvLookCurrent: byte;
    aPos,k,aDisplayWidth: byte;
    aField:TField;
    AliasNum:string[3];
    aDisplayFormat:string[20]; // Часть DisplayFormat до символа ";"
    IsFraction: array[0..255] of byte; // Массив для хранения кол-ва символов на дробную часть+".", заданное в DisplayFormat поля
    GroupSeparatorCount: array[0..255] of byte; // Массив для хранения кол-ва символов -разделителей групп разрядов

Procedure InitEtvLookFieldInfo(aDataSet:TDBDataSet);
var i:integer;
    QQ:TQuery;
begin
  EtvLookCount:=0;
  QQ:=TQuery.Create(nil);
  QQ.DataBaseName:=aDataSet.DataBaseName;
  with aDataSet do
  try
    for i:=0 to FieldCount-1 do
      if (Fields[i].Visible) and (Fields[i] is TEtvLookField) and
      (Fields[i].FieldKind=fkLookup) and
      { Исключая составные поля }
      (Pos('+',Fields[i].LookUpKeyFields)=0) and (Pos('.',Fields[i].LookUpKeyFields)=0) then
      with TEtvLookField(Fields[i]) do begin
        QQ.SQL.Clear;
        { Проверка на существование такого поля в БД }
{
        lOriginFieldName:=TLnQuery(LookUpDataSet).TableName+'.'+
          LookUpField[LookUpResultCount-1].FieldName;

        if AnsiUpperCase(lOriginFieldName)<>VarToStr(GetFromSQLText(aDataSet.DataBaseName,
          'select UCase(Creator+''.''+TName+''.''+CName) from STA.Columns where '+
          'Creator+''.''+TName+''.''+CName='''+lOriginFieldName+'''',true)) then Continue;
}
        QQ.SQL.Add('select col_length('''+GetEtvTableName(LookUpDataSet)+''','''+
                   LookUpField[LookUpResultCount-1].FieldName+''')');
        QQ.Open;
        if QQ.Fields[0].Value=null then Continue;
{
        if GetFromSQLText(aDataSet.DataBaseName,'select col_length('''+
           TLnQuery(LookUpDataSet).TableName+''','''+
           LookUpField[LookUpResultCount-1].FieldName+''')',true)=null then Continue;
}
        Inc(EtvLookCount);
        if EtvLookCount>MaxEtvLook then
          ShowMessage('Преполнение переменной MaxEtvLook. Сообщите программистам!');
        { Имя LookUp'ного DataSet'a }
        EtvLookInfo[EtvLookCount,0]:=GetEtvTableName(LookUpDataSet);
        { Имя LookUp'ного поля, DisplayWidth которого будем корректировать }
        EtvLookInfo[EtvLookCount,1]:=LookUpField[LookUpResultCount-1].FieldName;
        { Имя ключевого поля LookUp'ного DataSet'a (Код) }
        EtvLookInfo[EtvLookCount,2]:=LookUpKeyFields;
        { Имя ключевого поля Основного DataSet'a (Код) }
        EtvLookInfo[EtvLookCount,3]:=KeyFields;
      end;
  finally
    QQ.Free;
  end;
end;

begin
  lTableName:=ObjectStrProp(aDataSet,'TableName');
  Q:=nil;
  List:=nil;
  if lTableName<>'' then
  try
    Q:=TEtvQuery.Create(nil);
    Q.DatabaseName:=aDataSet.DatabaseName;
    Exist:=false;
    s:='';
    list:=TStringList.Create;
    InitEtvLookFieldInfo(aDataSet);
    EtvLookCurrent:=0;
    lJoinString:='';
    l:=-1;
    for i:=0 to aDataSet.FieldCount-1 do with aDataSet.Fields[i] do
      if ((FieldKind=fkData) or (FieldKind=fkLookUp)) and
      (aDataSet.fields[i].Visible) and
      (not(aDataSet.fields[i] is TBlobField)) and
      {(not(aDataSet.fields[i] is TDateField)) and}
      (not(aDataSet.Fields[i] is TEtvListField)) then begin
        Exist:=true;
        Inc(l);
        case aDataSet.Fields[i].DataType of
          ftFloat,ftSmallInt,ftInteger:
            { Есть дробная часть }
            with TNumericField(aDataSet.Fields[i]) do
              if DisplayFormat<>'' then begin
                { Анализируем DisplayFormat }
                aPos:=Pos(';',DisplayFormat);
                if aPos>0 then aDisplayFormat:=Copy(DisplayFormat,1,aPos-1)
                else aDisplayFormat:=DisplayFormat;
                aPos:=Pos('.',aDisplayFormat);
                if aPos>0 then // Посчитали длину дробной части с точкой, которую задал программист
                  IsFraction[l]:=Length(Copy(aDisplayFormat,aPos,Length(aDisplayFormat)-aPos+1))
                else IsFraction[l]:=0;
                // Учет числа разделителей разрядов при формировании ширины столбца
                GroupSeparatorCount[l]:=0;
                for k:=1 to Length(aDisplayFormat) do if aDisplayFormat[k]=' ' then Inc(GroupSeparatorCount[l]);
                //lFunc:='LengthNumCeiling'
                lFunc:='Length'
              end else begin
                IsFraction[l]:=0; // Ширина столбца будет как вернул SQL
                //lFunc:='LengthNum'
                lFunc:='Length'
              end;
          else lFunc:='Length';
        end;
        if (FieldKind=fkLookUp) and (EtvLookCurrent<EtvLookCount) then begin
          if (EtvLookInfo[EtvLookCurrent+1,3]=KeyFields) then begin
            Inc(EtvLookCurrent);
            AliasNum:='a'+IntToStr(EtvLookCurrent);
            lFieldName:=AliasNum+'.'+EtvLookInfo[EtvLookCurrent,1];
            lJoinString:=lJoinString+' left outer join '+EtvLookInfo[EtvLookCurrent,0]+' as '+
            AliasNum+' on '+
            lTableName+'.'+EtvLookInfo[EtvLookCurrent,3]+'='+
            AliasNum+'.'+EtvLookInfo[EtvLookCurrent,2];
          end else Continue;
        end else lFieldName:=lTableName+'.'+FieldName;
        if s<>'' then s:=s+',';
        s:=s+'max('+lFunc+'('+lFieldName+'))';
        List.Add(FieldName);
      end;
    if Exist then begin
      Q.SQL.Add('select '+s+' from '+lTableName+lJoinString);
      if (ADataSet.Filter<>'') and (ADataSet.Filtered) then begin
        s:=ADataSet.Filter;
        { Разборки с синтаксисом NULL }
        while (pos('=NULL',s)>0) or (pos('= NULL',s)>0) do begin
          l:=pos('=NULL',s);
          if l<=0 then l:=pos('= NULL',s);
          s:=copy(s,1,l-1)+'is '+copy(s,l+1,length(s));
        end;
        while (pos('<>NULL',s)>0) or (pos('<> NULL',s)>0) do begin
          l:=pos('<>NULL',s);
          if l<=0 then l:=pos('<> NULL',s);
          s:=copy(s,1,l-1)+'is not '+copy(s,l+1,length(s));
        end;
        { Добавляем имя таблицы в исходный фильтр, чтобы не было конфликтов на сервере }
        for i:=0 to aDataSet.FieldCount-1 do with aDataSet.Fields[i] do
          while Pos('('+FieldName,s)>0 do
            begin
              l:=Pos('('+FieldName,s);
              s:=copy(s,1,l)+lTableName+'.'+copy(s,l+1,length(s))
            end;
        Q.SQL.Add('where '+s);
      end;
      { Изменяем DisplayWidth у TField'ов }
      try
        EtvLookCurrent:=0;
        ADataSet.DisableControls;
        try
          Q.Open;
          if not (Q.BOF and Q.EOF) then
            for i:=0 to Q.FieldCount-1 do
              if (Q.Fields[i].value>0) and
              (Q.Fields[i].value<=255) then begin
                aField:=ADataSet.FieldByName(List[i]);
                case aField.FieldKind of
                  fkData:
                    begin
                      aDisplayWidth:=Q.Fields[i].Value;
                      case aField.DataType of
                        ftFloat,ftSmallInt,ftInteger:
                          if (TNumericField(aField).DisplayFormat<>'') then begin
                            { Учли кол-во пробелов }
                            //l:=Q.Fields[i].Value;
                            //if IsFraction[i] then l:=l-3;
                            //l:=l+(l div 3);
                            //if IsFraction[i] then l:=l+3; // Учли ".##"
                            //l:=((Q.Fields[i].Value-Byte(IsFraction[i])) div 3)-1;
                            // if l>=2 then l:=l-Byte(IsFraction[i])-((Q.Fields[i].Value+1) mod 3)+1;
                            // aDisplayWidth:=aDisplayWidth+l-Byte(IsFraction[i])+1;
                            // 21.01.11 Lev. Новая версия форматирования столбца типа Numeric(a,b)

                            // Разбираемся с дробной частью числа
                            // Посчитали кол-во знаков после точки в исходной таблице. Если <>0, то добавим еще 1 на символ "."
                            l:=GetFromSQLText(aDataSet.DataBaseName,
                              'select FFractionLength('''+lTableName+''','''+aField.FieldName+''')',false);
                            if l>0 then Inc(l);
                              aDisplayWidth:=aDisplayWidth-l+IsFraction[i];
                            // Учет разделителей групп разрядов
                            aDisplayWidth:=aDisplayWidth+GroupSeparatorCount[i];
                            { Учет разделителя целой и дробной части }
                            (*
                            if Pos('.,00',TFloatField(aField).DisplayFormat)>0 then
                              aDisplayWidth:=aDisplayWidth-3;
                            *)
                          end;
                        ftDate: aDisplayWidth:=8;
                        ftDateTime: aDisplayWidth:=15;
                      end;
                      if (AsInDataBase) or (aDisplayWidth<aField.DisplayWidth) then
                        aField.DisplayWidth:=aDisplayWidth
                    end;
                  fkLookUp:
                    begin
                      Inc(EtvLookCurrent);
                      if AsInDataBase then
                        aField.DisplayWidth:=LengthResultFields(aField)+
                          2*TEtvLookField(aField).LookUpResultCount-aField.LookUpDataSet.
                            FieldByName(EtvLookInfo[EtvLookCurrent,1]).DisplayWidth+Q.Fields[i].value;
                    end;
                end;
              end;
          Q.Close;
        except
          {EtvApp.ShowMessage(SSetLengthFieldsByDataError);}
          ShowMessage('Ошибка выполнения процедуры SetLengthFieldsByData'+#13+
                      'Позовите авторов задачи');
        end;
      finally
        ADataSet.EnableControls;
      end;
    end;
  finally
    List.free;
    Q.Free;
  end;
end;

Function GetIndexOfField(aFieldName: string; aFieldNames: string):integer;
var S: string;
    aPosBeg, aPosEnd :smallint;
begin
  Result:=0;
  S:=aFieldNames+';';
  aPosEnd:=-1;
  while aPosEnd<>0 do begin
    aPosBeg:=0;
    aPosEnd:=Pos(';',S);
    if Copy(S,aPosBeg+1,aPosEnd-1)=aFieldName then Exit;
    S:=Copy(S,aPosEnd+1,255);
    Inc(Result);
  end;
  ShowMessage('НЕКОРРЕКТНЫЙ ВЫЗОВ ФУНКЦИИ GetIndexOfField! СООБЩИТЕ РАЗРАБОТЧИКАМ!')
end;

Initialization
  QueriesProcess:=TQuery.Create(nil);
  QueriesLookup:=TQuery.Create(nil);
Finalization
  QueriesLookup.Free;
  QueriesProcess.Free;
end.
