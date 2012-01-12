��� �� ������
-------------

select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm2))


�� �������
----------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm1))
and ((PassSer is not null) and (PassSer<>''))


�����
-----
select number(),id,Tabnum,LastName,FirstName,number(),PersNum,PassSer,PassNum from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and (ID not in (select  IDW from sta.PersonForm2))
and ((PassSer is null) or (PassSer=''))


������� ����� 01.01.2003 ��� �������������
------------------------

select number(),ID,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,DateOn,DateOff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>='01.01.03')
and (Mix=0 or Mix=2)
and (Certificate=0)
and (CitizenShip=30)
and (ID not in (select IDW from sta.PersonForm2));

����� ������
----------------------------------------------------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateon,dateoff,certificate,citizenShip from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn>'01.01.03')
and (Mix=0 or Mix=2)
and (CitizenShip=30)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is null) or (PassSer=''))



� ���� ��������� ������� ��� ����� ���������
--------------
select count(*) as cnt , tabnum, LastName from workers group by tabnum,LastName having cnt>1



����� �������� (����� ������)
-----------------------------

select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateoff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is null) or (PassSer=''))


������ �������� (����� ������)
------------------------------
select number(),id,Tabnum,LastName,FirstName,PersNum,PassSer,PassNum,dateoff from sta.Workers
where ((DateOff is null) or (DateOff>='01.01.03'))
and (Ceh is not null) 
and (DateOn<'01.01.03')
and (Mix=0 or Mix=2)
and ((ID not in (select IDW from sta.PersonForm2)) and (ID not in (select IDW from sta.PersonForm1)) )
and ((PassSer is not null) and (PassSer<>''))