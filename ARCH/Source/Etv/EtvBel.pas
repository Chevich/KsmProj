unit EtvBel;

interface

type TUnitWords=Array[1..3] of string;
     TKindWords=(kwMale,kwFemale,kwNeuter);
const Rub:TUnitWords=('������','����','���븢');

Function INumToText(aNum:integer; aUnitWords:TUnitWords; aMale:TKindWords): String;

{ ���������� ���� aDate � ��������� ���� ����: "15 ������ 1998 �."}
Function DateToStrEtv(aDate:TDateTime):String;

implementation
uses SysUtils;


Function INumToText(aNum:integer; aUnitWords:TUnitWords; aMale:TKindWords): String;
const Billions:TUnitWords=('������ ',' ������� ','������� ');
      Millions:TUnitWords=('����� ','������ ','������ ');
      Thousands:TUnitWords=('������ ','������ ','����� ');
var  lNum:integer;
     s:string;

function Below1000(n:integer; aUnitWords:TUnitWords; aMale:TKindWords):string;
type numarr=array[0..9] of string[15];
const Edinicy:numarr=('','���� ','��� ','��� ','������ ','���� ',
                      '����� ','��� ','����� ','������� ');
      Nadcat:numarr =('������� ','���������� ','���������� ',
                      '���������� ','������������ ','���������� ',
                      '���������� ','���������� ','������������ ',
                      '������������� ');
      Decatki:numarr=('','','�������� ','�������� ','����� ','���������� ',
                          '����������� ','��������� ','����������� ','���������� ');
      Sotni:numarr  =('','��� ','������� ','������ ','��������� ','������� ',
                      '�������� ','������ ','�������� ','���������� ');
var i:integer;
begin
  i:=n div 100;
  Result:=sotni[i];
  i:=n mod 100;
  if (i>=10) and (i<20) then Result:=Result+Nadcat[i-10]
  else begin
    Result:=Result+Decatki[i div 10];
    i:=i mod 10;
    if (aMale=kwMale) or (not (i in [1,2])) then Result:=Result+edinicy[i]
    else case i of
      1: if aMale=kwFemale then Result:=Result+'���� ' else Result:=Result+'���� ';
      2: if aMale=kwFemale then Result:=Result+'���� ' else Result:=Result+'��� ';
    end;
  end;
  if Result<>'' then
    if not(n mod 100 in [11..19]) then
      case  n mod 10 of
        1: Result:=Result+aUnitWords[1];
        2..4: Result:=Result+aUnitWords[2];
        else Result:=Result+aUnitWords[3];
      end
    else Result:=Result+aUnitWords[3];
end; (* of below1000 *)

begin
  lNum:=aNum div 1000000000;
  Result:=below1000(lNum,Billions,kwMale);

  aNum:=aNum-lNum*1000000000;
  lNum:=aNum div 1000000;
  s:=below1000(lNum,Millions,kwMale);
  if s<>'' then Result:=Result+' '+s;

  aNum:=aNum-lNum*1000000;
  lNum:=aNum div 1000;
  s:=below1000(lNum,Thousands,kwFemale);
  if s<>'' then Result:=Result+' '+s;

  lNum:=aNum-lNum*1000;
  s:=below1000(lNum,aUnitWords,aMale);
  if s<>'' then Result:=TrimLeft(Result)+' '+s
  else
    if Result<>'' then Result:=TrimLeft(Result)+' '+aUnitWords[3]
    else Result:='���� '+aUnitWords[3];

  {mm:=round(num-mm*100.0);
  stroka1:='���. '+chr(mm div 10+ord('0'))+chr(mm mod 10+ord('0'))+' ���.';
  if stroka<>'' then stroka:=stroka+stroka1
                else mills:=mills+stroka1;}
end;


Const
Months:array[1..12] of string[12]=(
  '��������','������','�������','��������','���','�������','�����',
  '����','�������','����������','��������','������');

Function DateToStrEtv(aDate:TDateTime):String;
begin
  Result:=FormatDateTime('d" "',aDate)+Months[StrToInt(FormatDateTime('mm',aDate))]+
    FormatDateTime('" "yyyy" �."',aDate);
end;

end.
