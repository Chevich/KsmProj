-- Третья часть марлезонского балета от Леши ;-)
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 6,ID,1,'01.01.03',null,null
from STA.Workers where ID in (9003,11002,11005)
order by ceh,lastname,firstname;

call sta.personform2generate(8);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00008.txt' format ascii;
