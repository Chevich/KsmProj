insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 1,ID,1,'01.01.03',null,null
from STA.Workers where ((DateOff is null) or (DateOff>='01.01.03')) and (PersNum is not null) and (Ceh in(2,9)) and (DateOn<'01.01.03')
and (Mix=0)
