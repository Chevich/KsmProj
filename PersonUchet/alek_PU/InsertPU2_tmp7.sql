-- Четвертая часть марлезонского балета от Леши ;-)
-- Новые после 1 января 2003 (part 2)
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 7,ID,1,DateOn,null,null
from STA.Workers where 
((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>='01.01.03')
and (Mix=0 or Mix=2)
and (Certificate=0)
and (CitizenShip=30)
and (ID not in (11878,11947,11940))
and (ID not in (select IDW from sta.PersonForm2))
order by ceh, lastname,firstname;

call sta.personform2generate(9);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00009.txt' format ascii;
