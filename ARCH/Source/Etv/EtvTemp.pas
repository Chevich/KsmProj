Unit EtvTemp;

Interface
Uses Classes, DBTables, DB,BDE,DBCommon;

Function WhereFromSQL(SQLText:string; ToOrderBy:boolean):string;
Procedure OpenDutyQuery(aDataBaseName,aText:string; HideError:boolean);
{ ����������� ����� Borland'������ ������� ��� ������ ����� ��� - 2 �����! }
{ �� 00 �� 29 ����� 2029 ��� ����� 19��, ��� � Windows �� ��������� }
Function StrToDate_(const S: string):TDateTime;
Function DateToStr_(Date: TDateTime): string;
// �������� ��� ������� VarToStr, �� ����������� �������� Null. ������ ������ ������ ���������� 'null'.
// ����� ��� ������ � ����������� �������� � �������, ������������ SQL-�������.
Function VarToStr_(const V: Variant): string;
Function HasProperty(aComponent: TComponent; const aProperty: String): Boolean;
var DQuery: TQuery;

Implementation
Uses TypInfo, SysUtils, Controls, Forms;

{ ����������� ����� Borland'������ ������� }
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
  if i=0 then Exit; { ��� ������� "where" � ������ SQLText'� }
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
  DQuery.Sql.Clear; { ���������� ������ ��������� }
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
