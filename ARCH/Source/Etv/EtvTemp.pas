Unit EtvTemp;

Interface
Uses Classes, DBTables, DB,BDE,DBCommon;

Function WhereFromSQL(SQLText:string; ToOrderBy:boolean):string;
Procedure OpenDutyQuery(aDataBaseName,aText:string; HideError:boolean);
{ Подправляет глюки Borland'овской функции для случая когда ГОД - 2 ЦИФРЫ! }
{ от 00 до 29 будет 2029 год иначе 19хх, как в Windows по умолчанию }
Function StrToDate_(const S: string):TDateTime;
Function DateToStr_(Date: TDateTime): string;
// Работает как обычная VarToStr, за исключением значения Null. Вместо пустой строки возвращает 'null'.
// Нужно для работы с параметрами процедур и функций, передаваемых SQL-серверу.
Function VarToStr_(const V: Variant): string;
Function HasProperty(aComponent: TComponent; const aProperty: String): Boolean;
var DQuery: TQuery;

Implementation
Uses TypInfo, SysUtils, Controls, Forms;

{ Подправляет глюки Borland'овской функции }
Function StrToDate_(const S: string):TDateTime;
var S1:string;
    aYear: string[2];
begin
  S1:=S;
  if Length(S1)=8 then begin
    aYear:=Copy(S1,7,2);
    if StrToInt(aYear)<30 then
      S1:=Copy(S1,1,6)+'20'+aYear
    else S1:=Copy(S1,1,6)+'19'+aYear
  end;
  Result:=StrToDate(S1);
end;

Function DateToStr_(Date:TDateTime):string;
var S1:string;
    aYear: string[2];
begin
  S1:=DateToStr(Date);
  if Length(S1)=8 then begin
    aYear:=Copy(S1,7,2);
    if StrToInt(aYear)<30 then
      S1:=Copy(S1,1,6)+'20'+aYear
    else S1:=Copy(S1,1,6)+'19'+aYear
  end;
  Result:=S1;
end;

Function WhereFromSQL(SQLText:string; ToOrderBy:boolean):string;
var i,j:integer;
begin
  j:=0;
  Result:='';
  i:=Pos('where', AnsiLowerCase(SQLText));
  if i=0 then Exit; { нет условия "where" в данном SQLText'е }
  if not ToOrderBy then j:=Pos('group by',AnsiLowerCase(SQLText));
  if j=0 then j:=Pos('order by',AnsiLowerCase(SQLText));
  if j=0 then j:=Length(SQLText)+1;
  Result:=Copy(SQLText,i+Length('where '),j-i-Length('where '));
end;

Procedure OpenDutyQuery(aDataBaseName,aText:string; HideError:boolean);
var OldCursor: TCursor;
begin
  if Not Assigned(DQuery) then DQuery:=TQuery.Create(nil);
  DQuery.DataBaseName:=aDataBaseName;
  DQuery.Sql.Clear; { Предыдущий запрос очищается }
  DQuery.Sql.Add(aText);
  if Assigned(Screen) then begin
    OldCursor:=Screen.Cursor;
    Screen.Cursor:=crSQLWait;
  end;
  try
    try
      DQuery.Open;
    except
      if Not HideError then Raise;
    end;
  finally
    if Assigned(Screen) then Screen.Cursor:=OldCursor;
  end
end;

Function HasProperty(aComponent: TComponent; const aProperty: String): Boolean;
var PropInfo: PPropInfo;
begin
  Result:=false;
  PropInfo:=GetPropInfo(aComponent.ClassInfo,aProperty);
  if Assigned(PropInfo) then Result:=true;
end;

Function VarToStr_(const V: Variant): string;
begin
  if not VarIsNull(V) then begin
    Result:=VarToStr(V);
    if VarType(V)=varString then Result:=''''+Result+'''';
  end else Result:='null'
end;

Initialization

Finalization
  if Assigned(DQuery) then DQuery.Free;
end.
