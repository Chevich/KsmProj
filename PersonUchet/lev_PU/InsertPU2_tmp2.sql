-- Вторая часть марлезонского балета ;-)
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 2,ID,1,'01.01.03',null,null
from STA.Workers where (((DateOff is null) or (DateOff>='01.01.03')) and (Passser is null) and (PersNum is not null) and (PersNum<>'')
and (Ceh in(29,36,26,24,28,17,13,12,46,40,41,42,43,44,11,31,15,7,14,5,16,3,34,35)) and (DateOn<'01.01.03')
and (Mix=0 or Mix=2) and (ID not in (8447,11878))) or (ID in (8822,9871,11020,6498,6494,8954)) order by ceh, lastname,firstname
