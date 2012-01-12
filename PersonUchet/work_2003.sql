ÅÙÅ ÍÅ ÏÎÄÀËÈ
-------------

select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm2))


ÑÎ ÑÒÀÐÛÌÈ
----------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm1))
and ((PassSer is not null) and (PassSer<>''))


ÍÎÂÛÅ
-----
select number(),id,Tabnum,LastName,FirstName,number(),PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm2))
and ((PassSer is null) or (PassSer=''))


ÏÐÈÍßÒÛ ÏÎÑËÅ 01.01.2003 ÁÅÇ ÑÂÈÄÅÒÅËÜÑÒÂÀ
------------------------

select number(),ID,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,DateOn,DateOff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>='01.01.03')
and (Mix=0 or Mix=2)
and (Certificate=0)
and (CitizenShip=30)
and (ID not in (select IDW from sta.PersonForm2));

ÍÎÂÀß ÂÅÐÑÈß
----------------------------------------------------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateon,dateoff,certificate,citizenShip from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>'01.01.03')
and (Mix=0 or Mix=2)
and (CitizenShip=30)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is null) or (PassSer=''))



Ó ÊÎÃÎ ÍÅÑÊÎËÜÊÎ ÇÀÏÈÑÅÉ ÏÎÄ ÎÄÍÈÌ ÒÀÁÅËÜÍÛÌ
--------------
select count(*) as cnt , tabnum, LastName from workers group by tabnum,LastName having cnt>1



ÍÎÂÛÅ ÏÀÑÏÎÐÒÀ (ÍÎÂÛÉ ÇÀÏÐÎÑ)
-----------------------------

select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateoff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is null) or (PassSer=''))


ÑÒÀÐÛÅ ÏÀÑÏÎÐÒÀ (ÍÎÂÛÉ ÇÀÏÐÎÑ)
------------------------------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateoff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is not null) and (PassSer<>''))