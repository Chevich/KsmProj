-- N+2 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 10,ID,1,DateOn,null,null
from STA.Workers 
where ID in (11924,11949)
order by ceh,lastname,firstname;

call sta.personform2generate(15);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00015.txt' format ascii;