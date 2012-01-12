-- N+1 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 9,ID,1,DateOn,null,null
from STA.Workers 
where ID in (11989,11990,11991,11992,11997,12006,12007,12008,12009,12010)
order by ceh,lastname,firstname;

call sta.personform2generate(14);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00014.txt' format ascii;