-- N+7 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 16,ID,1,DateOn,null,null
from STA.Workers 
where ID in (12023,12021,12022,12011,12030)
order by lastname,firstname;

call sta.personform2generate(21);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00021.txt' format ascii;