unit EtvRus;

interface

(* Val    Ïåğåâîä â ñëîâåñíóş çàïèñü *)
type
  TLnUserMetric = Array[0..1,1..3] of String;
  PLnUserMetric = ^TLnUserMetric;
  TLnMetricType = (mtSum, mtWeight, mtBigWeight, mtSumUser, mtPiece, mtNothing, mtFullNothing);
Function TranslateNumber(ANum: Double; IsUserMetric: Boolean; DecCnt: Byte; AMetric: PLnUserMetric;
                         IsAltFont: Boolean): String;
Function NumberToWords(ANum: Double; AType: TLnMetricType; aUserMetric:PLnUserMetric): String;

{ Âîçâğàùàåò äàòó aDate â ñòğîêîâîì âèäå òèïà: "15 ÿíâàğÿ 1998 ã."}
Function DateToStrEtv(aDate:TDateTime):String;

implementation
uses SysUtils;
var  aCurType: TLnMetricType;

{ïåğåâîä â ñëîâåñíóş çàïèñü}
Const

    tnKop=0;
    tnOne=1;
    tnThs=2;
    tnMln=3;
    tnMlr=4;
    tnTrl=5;

    tnMinusa = 'Œˆ“‘';
    tnMinusi = 'ÌÈÍÓÑ';
    Sm1a: Array[1..2,1..10] of String[6]=(
    ('„ˆH', '„‚€', '’ˆ', '—…’›…', 'Ÿ’œ',
    '˜…‘’œ', '‘…Œœ', '‚‘…Œœ','„…‚Ÿ’œ', ''),
    ('„H€', '„‚…', '’ˆ', '—…’›…', 'Ÿ’œ',
    '˜…‘’œ','‘…Œœ', '‚‘…Œœ', '„…‚Ÿ’œ', ''));
    Sm1i: Array[1..2,1..10] of String[6]=(
    ('ÎÄÈÍ', 'ÄÂÀ', 'ÒĞÈ', '×ÅÒÛĞÅ', 'ÏßÒÜ',
    'ØÅÑÒÜ', 'ÑÅÌÜ', 'ÂÎÑÅÌÜ','ÄÅÂßÒÜ', ''),
    ('ÎÄÍÀ', 'ÄÂÅ', 'ÒĞÈ', '×ÅÒÛĞÅ', 'ÏßÒÜ',
    'ØÅÑÒÜ','ÑÅÌÜ', 'ÂÎÑÅÌÜ', 'ÄÅÂßÒÜ', ''));

     Sm01a: Array[0..9] of String[12]=(
      '„…‘Ÿ’œ', '„ˆHH€„–€’œ', '„‚…H€„–€’œ', '’ˆH€„–€’œ', '—…’›H€„–€’œ',
      'Ÿ’H€„–€’œ', '˜…‘’H€„–€’œ', '‘…ŒH€„–€’œ', '‚‘…ŒH€„–€’œ', '„…‚Ÿ’H€„–€’œ'
      );
      Sm01i: Array[0..9] of String[12]=(
      'ÄÅÑßÒÜ', 'ÎÄÈÍÍÀÄÖÀÒÜ', 'ÄÂÅÍÀÄÖÀÒÜ', 'ÒĞÈÍÀÄÖÀÒÜ', '×ÅÒÛĞÍÀÄÖÀÒÜ',
      'ÏßÒÍÀÄÖÀÒÜ', 'ØÅÑÒÍÀÄÖÀÒÜ', 'ÑÅÌÍÀÄÖÀÒÜ', 'ÂÎÑÅÌÍÀÄÖÀÒÜ', 'ÄÅÂßÒÍÀÄÖÀÒÜ'
      );
      Sm2a: Array[2..9] of String[11]=(
      '„‚€„–€’œ', '’ˆ„–€’œ', '‘Š', 'Ÿ’œ„…‘Ÿ’', '˜…‘’œ„…‘Ÿ’',
      '‘…Œœ„…‘Ÿ’', '‚‘…Œœ„…‘Ÿ’', '„…‚ŸH‘’'
      );
      Sm2i: Array[2..9] of String[11]=(
      'ÄÂÀÄÖÀÒÜ', 'ÒĞÈÄÖÀÒÜ', 'ÑÎĞÎÊ', 'ÏßÒÜÄÅÑßÒ', 'ØÅÑÒÜÄÅÑßÒ',
      'ÑÅÌÜÄÅÑßÒ', 'ÂÎÑÅÌÜÄÅÑßÒ', 'ÄÅÂßÍÎÑÒÎ'
      );


     Sm3a: Array[1..9] of String[9]=(
      '‘’', '„‚…‘’ˆ', '’ˆ‘’A', '—…’›…‘’A', 'Ÿ’œ‘’',
      '˜…‘’œ‘’', '‘…Œœ‘’', '‚‘…Œœ‘’', '„…‚Ÿ’œ‘’'
      );
     Sm3i: Array[1..9] of String[9]=(
      'ÑÒÎ', 'ÄÂÅÑÒÈ', 'ÒĞÈÑÒÀ', '×ÅÒÛĞÅÑÒÀ', 'ÏßÒÜÑÎÒ',
      'ØÅÑÒÜÑÎÒ', 'ÑÅÌÜÑÎÒ', 'ÂÎÑÅÌÜÑÎÒ', 'ÄÅÂßÒÜÑÎÒ'
      );

     Rba: Array[0..5,1..3] of String[12] =(
      (' Š…‰Š€',' Š…‰Šˆ' ,' Š……Š'),
      (' “‹œ',' “‹Ÿ',' “‹…‰'),
      (' ’›‘Ÿ—€',' ’›‘Ÿ—ˆ',' ’›‘Ÿ—'),
      (' Œˆ‹‹ˆH',' Œˆ‹‹ˆH€',' Œˆ‹‹ˆH‚'),
      (' Œˆ‹‹ˆ€„',' Œˆ‹‹ˆ€„€',' Œˆ‹‹ˆ€„‚'),
      (' ’ˆ‹‹ˆ€„',' ’ˆ‹‹ˆ€„€',' ’ˆ‹‹ˆ€„‚')
      );
      Rbi: Array[0..5,1..3] of String[12] =(
      (' ÊÎÏÅÉÊÀ',' ÊÎÏÅÉÊÈ',' ÊÎÏÅÅÊ'),
      (' ĞÓÁËÜ',' ĞÓÁËß',' ĞÓÁËÅÉ'),
      (' ÒÛÑß×À',' ÒÛÑß×È',' ÒÛÑß×'),
      (' ÌÈËËÈÎÍ',' ÌÈËËÈÎÍÀ',' ÌÈËËÈÎÍÎÂ'),
      (' ÌÈËËÈÀĞÄ',' ÌÈËËÈÀĞÄÀ',' ÌÈËËÈÀĞÄÎÂ'),
      (' ÒĞÈËËÈÀĞÄ',' ÒĞÈËËÈÀĞÄÀ',' ÒĞÈËËÈÀĞÄÎÂ')
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
            S1:='“‹œ'
            else
            S1:='ÍÓËÜ';
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
            S1:='…€‚ˆ‹œ… —ˆ‘‹'
            else
            S1:='ÍÅÏĞÀÂÈËÜÍÎÅ ×ÈÑËÎ';
  end else
         if IsAltFont then
            S1:='—…œ ‹œ˜… —ˆ‘‹'
            else
            S1:='Î×ÅÍÜ ÁÎËÜØÎÅ ×ÈÑËÎ';
  Result:=S1;
end;

Const
      RWeightMetric: TLnUserMetric =(
      (' ÃĞ.',' ÃĞ.',' ÃĞ.'),
      (' ÊÃ.',' ÊÃ.',' ÊÃ.'));
      RBigWeightMetric: TLnUserMetric =(
      (' ÊÃ.',' ÊÃ.',' ÊÃ.'),
      (' ÒÍ.',' ÒÍ.',' ÒÍ.'));
      RPieceMetric: TLnUserMetric= (
      ( '','',''),
      (' ØÒÓÊÀ',' ØÒÓÊÈ',' ØÒÓÊ'));
      RNothingMetric:TLnUserMetric=(
      (' ÒÛÑß×ÍÀß',' ÒÛÑß×ÍÛÕ',' ÒÛÑß×ÍÛÕ'),
      (' ÖÅËÎÅ',' ÖÅËÛÕ',' ÖÅËÛÕ'));
      RFullNothingMetric:TLnUserMetric=(
      ('','',''),
      ('','',''));

Function NumberToWords(ANum: Double; AType: TLnMetricType; aUserMetric:PLnUserMetric): String;
begin
  aCurType:=AType; // Îïğåäåëåíèå òåêóùåé ìåòğèêè äëÿ îïğåäåëíèå ïğàâèëüíûõ ïàäåæîâ
  case AType of
    mtSumUser: Result:=TranslateNumber(ANum, True, 2, aUserMetric, False);
    mtSum: Result:=TranslateNumber(ANum, False, 2, Nil, False);
    mtWeight: Result:=TranslateNumber(ANum, True, 3, @RWeightMetric, False);
    mtBigWeight: Result:=TranslateNumber(ANum, True, 3, @RBigWeightMetric, False);
    mtPiece: Result:=TranslateNumber(ANum, True, 3, @RPieceMetric, False);
    mtNothing:
      begin
        { Çäåñü Frac ïğèìåíÿòü íåëüçÿ! Ò.ê. FloatToStr(FRac(7.05))='0.49999998' :( }
        Result:=TranslateNumber(ANum,True,
          {Length(FloatToStr(ANum))-Pos('.',FloatToStr(ANum))}3,
            @RNothingMetric, False);
      end;
    mtFullNothing: // Ïîëíîå îòñòóòñòâèå èíôû ïîñëå ÷èñëà ïğîïèñüş. Òîëüêî äëÿ öåëûõ ÷èñåë. Íàïğèìåğ, äëÿ "ÂÑÅÃÎ ÃĞÓÇÎÂÛÕ ÌÅÑÒ"
        Result:=TranslateNumber(ANum,True,3,@RFullNothingMetric,False);
  end;
end;

Const
Months:array[1..12] of string[8]=(
  'ÿíâàğÿ','ôåâğàëÿ','ìàğòà','àïğåëÿ','ìàÿ','èşíÿ','èşëÿ',
  'àâãóñòà','ñåíòÿáğÿ','îêòÿáğÿ','íîÿáğÿ','äåêàáğÿ');

Function DateToStrEtv(aDate:TDateTime):String;
begin
  if aDate=0 then Result:=''
  else Result:=FormatDateTime('d" "',aDate)+Months[StrToInt(FormatDateTime('mm',aDate))]+
    FormatDateTime('" "yyyy" ã."',aDate);
end;

end.
