-- Третья часть марлезонского балета от Леши ;-)
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 5,ID,1,'01.01.03',null,null
from STA.Workers where ID in (6728,7542,7569,5877)
order by ceh, lastname,firstname;

call sta.personform2generate(6);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00006.txt' format ascii;
