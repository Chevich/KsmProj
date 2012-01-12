-- N часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 8,ID,1,'01.01.03',null,null
from STA.Workers where ID in (8941,9172,11332,9049,6302)
order by ceh,lastname,firstname;

call sta.personform2generate(11);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00011.txt' format ascii;
