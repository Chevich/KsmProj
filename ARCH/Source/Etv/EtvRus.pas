unit EtvRus;

interface

(* Val    ������� � ��������� ������ *)
type
  TLnUserMetric = Array[0..1,1..3] of String;
  PLnUserMetric = ^TLnUserMetric;
  TLnMetricType = (mtSum, mtWeight, mtBigWeight, mtSumUser, mtPiece, mtNothing, mtFullNothing);
Function TranslateNumber(ANum: Double; IsUserMetric: Boolean; DecCnt: Byte; AMetric: PLnUserMetric;
                         IsAltFont: Boolean): String;
Function NumberToWords(ANum: Double; AType: TLnMetricType; aUserMetric:PLnUserMetric): String;

{ ���������� ���� aDate � ��������� ���� ����: "15 ������ 1998 �."}
Function DateToStrEtv(aDate:TDateTime):String;

implementation
uses SysUtils;
var  aCurType: TLnMetricType;

{������� � ��������� ������}
Const

    tnKop=0;
    tnOne=1;
    tnThs=2;
    tnMln=3;
    tnMlr=4;
    tnTrl=5;

    tnMinusa = '�����';
    tnMinusi = '�����';
    Sm1a: Array[1..2,1..10] of String[6]=(
    ('���H', '���', '���', '������', '����',
    '�����', '����', '������','������', ''),
    ('��H�', '���', '���', '������', '����',
    '�����','����', '������', '������', ''));
    Sm1i: Array[1..2,1..10] of String[6]=(
    ('����', '���', '���', '������', '����',
    '�����', '����', '������','������', ''),
    ('����', '���', '���', '������', '����',
    '�����','����', '������', '������', ''));

     Sm01a: Array[0..9] of String[12]=(
      '������', '���HH������', '���H������', '���H������', '�����H������',
      '���H������', '����H������', '���H������', '�����H������', '�����H������'
      );
      Sm01i: Array[0..9] of String[12]=(
      '������', '�����������', '����������', '����������', '������������',
      '����������', '�����������', '����������', '������������', '������������'
      );
      Sm2a: Array[2..9] of String[11]=(
      '��������', '��������', '�����', '���������', '����������',
      '���������', '�����������', '����H����'
      );
      Sm2i: Array[2..9] of String[11]=(
      '��������', '��������', '�����', '���������', '����������',
      '���������', '�����������', '���������'
      );


     Sm3a: Array[1..9] of String[9]=(
      '���', '������', '�����A', '��������A', '�������',
      '��������', '�������', '���������', '���������'
      );
     Sm3i: Array[1..9] of String[9]=(
      '���', '������', '������', '���������', '�������',
      '��������', '�������', '���������', '���������'
      );

     Rba: Array[0..5,1..3] of String[12] =(
      (' �������',' �������' ,' ������'),
      (' �����',' �����',' ������'),
      (' ������',' ������',' �����'),
      (' ������H',' ������H�',' ������H��'),
      (' ��������',' ���������',' ����������'),
      (' ���������',' ����������',' �����������')
      );
      Rbi: Array[0..5,1..3] of String[12] =(
      (' �������',' �������',' ������'),
      (' �����',' �����',' ������'),
      (' ������',' ������',' �����'),
      (' �������',' ��������',' ���������'),
      (' ��������',' ���������',' ����������'),
      (' ���������',' ����������',' �����������')
      );

Function TranslateNumber(ANum: Double; IsUserMetric: Boolean; DecCnt: Byte; AMetric: PLnUserMetric;
                         IsAltFont: Boolean): String;

type String3=String[3];
     String2=String[2];

var S,S1,S2: String;
    i: Integer;

Function GetPostfix(C: Char; Ai: Byte; APriz: Boolean): String;
var j: Byte;
begin
  if APriz then j:=3 else
  if C in ['1'..'9'] then begin
     if C='1' then j:=1
        else
        if C<'5' then j:=2
           else j:=3;
     end else j:=3;
  if IsUserMetric and (Ai in [tnKop, tnOne]) then
     Result:=AMetric^[Ai][j]
     else
  if IsAltFont then Result:=Rba[Ai][j]
     else Result:=Rbi[Ai][j];
end;

Function Get1Fig(C: Char; Ai: Byte): String;
var Bi,i: Byte;
begin
  if (Ai=tnThs) or (Ai=tnKop) or ((Ai=tnOne) and (aCurType=mtBigWeight)) then Bi:=2 else Bi:=1;
  if C in ['1'..'9'] then
     i:=Ord(C)-48
     else i:=10;
  if IsAltFont then Result:=Sm1a[Bi][i]
     else Result:=Sm1i[Bi][i];
end;

function Get2Fig(S: String2; Ai: Byte): String;
begin
  Case S[1] of
    '-': begin
         if IsAltFont then
            Result:=tnMinusa
            else
            Result:=tnMinusi;
         Result:=Result+' '+Get1Fig(S[2],Ai);
         end;
    ' ','0': Result:= Get1Fig(S[2],Ai);
    '1': begin
         if IsAltFont then
         Result:= Sm01a[Ord(S[2])-48]
            else
         Result:= Sm01i[Ord(S[2])-48];
         Result:= Result+Get1Fig('0',Ai);
         end;
    else begin
         if IsAltFont then
    Result:= Sm2a[ord(S[1])-48]
            else
    Result:= Sm2i[ord(S[1])-48];
    Result:= Result+' '+Get1Fig(S[2],Ai);
    end;
    end;
end;

function Get3Fig(S: String3; Ai: Byte): String;
var S1: String2;
    S2: String;
begin
  if S[3]<>' ' then begin
     S1:=Copy(S,2,2); S2:=Get2Fig(S1,Ai);
     if (S[1]=' ') or (S[1]='0') then Result:=S2
        else begin
        if S2<>' ' then S2:=' '+S2;
         if IsAltFont then
        Result:=Sm3a[ord(S[1])-48]
            else
        Result:=Sm3i[ord(S[1])-48];
        Result:=Result+S2;
        end;
     end else Result:='';
end;

begin
 if IsUserMetric and (AMetric=Nil) then Exit;
 if ANum<1000000000000000. then
 try
   if Not IsUserMetric then DecCnt:=2;
   Str(ANum:16+DecCnt:DecCnt,S);
{      else begin
      Str(ANum:18:2,S);
      end;}
   S1:=Get3Fig(Copy(S,1,3), tnTrl);
   if S1<>'' then S1:=S1+GetPostfix(S[3],tnTrl, S[2]='1');

   For i:=tnMlr downto tnThs do begin
       S2:=Get3Fig(Copy(S,16-i*3,3), i);
       if S1<>'' then begin
          if S2<>'' then S1:=S1+' '+S2;
          end else S1:=S2;
       if S2<>'' then S1:=S1+GetPostfix(S[18-i*3],i, S[18-i*3-1]='1');
       end;

   if Copy(S,14,2)<>' 0' then begin
      S2:=Get3Fig(Copy(S,13,3), tnOne);
      if S1<>'' then S1:=S1+' '+S2 else S1:=S2;
      if S1<>'' then S1:=S1+GetPostfix(S[15],tnOne, S[14]='1');
      end else begin
         if IsAltFont then
            S1:='����'
            else
            S1:='����';
         S1:=S1+GetPostfix('0', tnOne, True);
      end;

   Case DecCnt of
   1:
   if Copy(S,17,1)<>'0' then begin
      S2:=Get1Fig(S[17], tnKop);
      if S1<>'' then S1:=S1+' '+S2 else S1:=S2;
      if S2<>'' then S1:=S1+GetPostfix(S[17],tnKop, False);
      end;
   2:
   if Copy(S,17,2)<>'00' then begin
      S2:=Get2Fig(Copy(S,17,2), tnKop);
      if S1<>'' then S1:=S1+' '+S2 else S1:=S2;
      if S2<>'' then S1:=S1+GetPostfix(S[18],tnKop, S[17]='1');
      end;
   3:
   if Copy(S,17,3)<>'000' then begin
      S2:=Get3Fig(Copy(S,17,3), tnKop);
      if S1<>'' then S1:=S1+' '+S2 else S1:=S2;
      if S2<>'' then S1:=S1+GetPostfix(S[19],tnKop, S[18]='1');
      end;
   end;

  except
         if IsAltFont then
            S1:='������������ �����'
            else
            S1:='������������ �����';
  end else
         if IsAltFont then
            S1:='����� ������� �����'
            else
            S1:='����� ������� �����';
  Result:=S1;
end;

Const
      RWeightMetric: TLnUserMetric =(
      (' ��.',' ��.',' ��.'),
      (' ��.',' ��.',' ��.'));
      RBigWeightMetric: TLnUserMetric =(
      (' ��.',' ��.',' ��.'),
      (' ��.',' ��.',' ��.'));
      RPieceMetric: TLnUserMetric= (
      ( '','',''),
      (' �����',' �����',' ����'));
      RNothingMetric:TLnUserMetric=(
      (' ��������',' ��������',' ��������'),
      (' �����',' �����',' �����'));
      RFullNothingMetric:TLnUserMetric=(
      ('','',''),
      ('','',''));

Function NumberToWords(ANum: Double; AType: TLnMetricType; aUserMetric:PLnUserMetric): String;
begin
  aCurType:=AType; // ����������� ������� ������� ��� ���������� ���������� �������
  case AType of
    mtSumUser: Result:=TranslateNumber(ANum, True, 2, aUserMetric, False);
    mtSum: Result:=TranslateNumber(ANum, False, 2, Nil, False);
    mtWeight: Result:=TranslateNumber(ANum, True, 3, @RWeightMetric, False);
    mtBigWeight: Result:=TranslateNumber(ANum, True, 3, @RBigWeightMetric, False);
    mtPiece: Result:=TranslateNumber(ANum, True, 3, @RPieceMetric, False);
    mtNothing:
      begin
        { ����� Frac ��������� ������! �.�. FloatToStr(FRac(7.05))='0.49999998' :( }
        Result:=TranslateNumber(ANum,True,
          {Length(FloatToStr(ANum))-Pos('.',FloatToStr(ANum))}3,
            @RNothingMetric, False);
      end;
    mtFullNothing: // ������ ����������� ���� ����� ����� ��������. ������ ��� ����� �����. ��������, ��� "����� �������� ����"
        Result:=TranslateNumber(ANum,True,3,@RFullNothingMetric,False);
  end;
end;

Const
Months:array[1..12] of string[8]=(
  '������','�������','�����','������','���','����','����',
  '�������','��������','�������','������','�������');

Function DateToStrEtv(aDate:TDateTime):String;
begin
  if aDate=0 then Result:=''
  else Result:=FormatDateTime('d" "',aDate)+Months[StrToInt(FormatDateTime('mm',aDate))]+
    FormatDateTime('" "yyyy" �."',aDate);
end;

end.
