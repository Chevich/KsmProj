select * from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03')) 
and (Passser is not null) 
and ((PersNum is null) or (PersNum=''))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2) order by ceh, lastname,firstname