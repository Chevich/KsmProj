select number(), Firstname,lastname, TabNum, isCorrectPersN(PersNum, Sex, DateBirth) as IsCorrectNum, PersNum,DateBirth,Sex from sta.Workers where DateOff is null and Mix=0 and iscorrectnum=0 and left(PassNum,2)='สอ';
output to 'c:\\incorrectnum.txt' format text;
