-- Четвертая часть марлезонского балета от Леши ;-)
-- Новые после 1 января 2003
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 4,ID,1,DateOn,null,null
from STA.Workers where 
((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>='01.01.03')
and (Mix=0 or Mix=2)
and (Certificate=0)
and (CitizenShip=30)
and (ID <> 11878)
order by ceh, lastname,firstname
