insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 1,ID,1,'01.01.03',null,null
from STA.Workers where ((DateOff is null) or (DateOff>='01.01.03')) and (Passser is null) and (PersNum is not null) and (PersNum<>'') and (Ceh in(1,2,9,8,18,21,30,33,25,27)) and (DateOn<'01.01.03')
and (Mix=0) and (id not in(9003,8954,6686,6498))
