unit EtvBel;

interface

type TUnitWords=Array[1..3] of string;
     TKindWords=(kwMale,kwFemale,kwNeuter);
const Rub:TUnitWords=('рубель','рублі','рублёў');

Function INumToText(aNum:integer; aUnitWords:TUnitWords; aMale:TKindWords): String;

{ Возвращает дату aDate в строковом виде типа: "15 января 1998 г."}
Function DateToStrEtv(aDate:TDateTime):String;

implementation
uses SysUtils;


Function INumToText(aNum:integer; aUnitWords:TUnitWords; aMale:TKindWords): String;
const Billions:TUnitWords=('мільярд ',' мільярда ','мільярдаў ');
      Millions:TUnitWords=('мільён ','мільёна ','мільёнаў ');
      Thousands:TUnitWords=('тысяча ','тысячы ','тысяч ');
var  lNum:integer;
     s:string;

function Below1000(n:integer; aUnitWords:TUnitWords; aMale:TKindWords):string;
type numarr=array[0..9] of string[15];
const Edinicy:numarr=('','адзін ','два ','тры ','чатыры ','пяць ',
                      'шэсць ','сем ','восем ','дзевяць ');
      Nadcat:numarr =('дзесяць ','адзінаццаць ','дванаццаць ',
                      'трынаццаць ','чатырнаццаць ','пятнаццаць ',
                      'шаснаццаць ','семнаццаць ','васемнаццаць ',
                      'дзевятнаццаць ');
      Decatki:numarr=('','','дваццаць ','трыццаць ','сорак ','пяцьдзесят ',
                          'шэсцьдзесят ','семдзесят ','восемдзесят ','дзевяноста ');
      Sotni:numarr  =('','сто ','дзвесце ','трыста ','чатырыста ','пяцьсот ',
                      'шэсцьсот ','семсот ','восемсот ','дзевяцьсот ');
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
      1: if aMale=kwFemale then Result:=Result+'адна ' else Result:=Result+'адно ';
      2: if aMale=kwFemale then Result:=Result+'дзве ' else Result:=Result+'два ';
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
    else Result:='нуль '+aUnitWords[3];

  {mm:=round(num-mm*100.0);
  stroka1:='руб. '+chr(mm div 10+ord('0'))+chr(mm mod 10+ord('0'))+' коп.';
  if stroka<>'' then stroka:=stroka+stroka1
                else mills:=mills+stroka1;}
end;


Const
Months:array[1..12] of string[12]=(
  'студзеня','лютага','сакавіка','красавіка','мая','чэрвеня','ліпеня',
  'жніўня','верасня','кастрычніка','лістапада','снежня');

Function DateToStrEtv(aDate:TDateTime):String;
begin
  Result:=FormatDateTime('d" "',aDate)+Months[StrToInt(FormatDateTime('mm',aDate))]+
    FormatDateTime('" "yyyy" г."',aDate);
end;

end.
