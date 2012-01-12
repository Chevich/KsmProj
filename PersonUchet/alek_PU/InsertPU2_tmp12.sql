-- N+4 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 12,ID,1,(if DateOn<'01.01.2003' then '01.01.2003' else DateOn endif),DateOff,
(if ReasonOff=106 then 1 else if ReasonOff=103 then 2 endif endif)
from STA.Workers 
where ID in (
11930,11935,11943,11945,11987,11988,11862,11923,11921,11915,11938,11941,11946,11993,
11995,12003,12005,11985,11920,11922,11994
)
order by ceh,lastname,firstname;

call sta.personform2generate(17);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00017.txt' format ascii;