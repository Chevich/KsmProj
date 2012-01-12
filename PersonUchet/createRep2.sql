create global temporary table sta.PersonForm2Rep (
   RecID integer not null,
   RecSubID integer not null,
   RecData varchar(600) not null
)
;

create procedure STA.PersonForm2Generate(in packetid integer)
begin
  delete from sta.PersonForm2Rep;

  insert into PersonForm2Rep select 1,0,'ЗГЛВ=1.3=' as ReportRows;

  insert into PersonForm2Rep select 2,0,'<ПАЧК='+a.INN+'='+b.RegNumInFund+'='+UPPER(FullName)+'='+cast(packetid as varchar)+'= = =1=' as ReportRows from sta.Org as a,sta.AdmConfig as b where a.Kod = '900000';

  insert into PersonForm2Rep select 3,0,'ТИПД=ПУ-2=1= = = =>' as ReportRows; /*число листов потом!*/

  insert into PersonForm2Rep select 4,0,'<ПУ-2='+
      (if a.sType = 0 then 'Р' else if a.sType = 1 then 'И' else if a.sType = 2 then 'К' else 
               if a.sType = 3 then 'О' endif endif endif endif)+
      '='+b.RegNumInFund+'= = ='+(select cast(count(*) as varchar) from sta.PersonForm2 as d where d.IDB=a.ID)+'='+b.PhoneForFund+
      '='+convert(varchar(10),a.DateFill,103)+'='+
      coalesce((if mod(a.Quarter,2)=1 then '1' endif)+(if floor(mod(a.Quarter,4)/2)=1 then '2' endif)+(if floor(mod(a.Quarter,8)/4)=1 then '3' endif)+(if floor(mod(a.Quarter,16)/8)=1 then '4' endif),' ')+
      '='+cast(a."Year" as varchar)+'=' as PacketRows
      from sta.PersonForm2Banner as a, sta.AdmConfig as b 
      where a.Packet=packetid; 

  insert into PersonForm2Rep select 5,a.ID,
      'ДВИЖ='+
      UPPER(b.LastName+'='+
      left(b.FirstName,1)+'='+
      left(b.MiddleName,1)+'='+
      b.PersNum+'='+
      coalesce(convert(varchar(10),a.DateOn,103),' ')+'='+
      '0'+coalesce(cast(a.TypeContract as varchar),' ')+'='+
      coalesce(convert(varchar(10),a.DateOff,103),' ')+'='+
      ' '+'='+
      coalesce(cast(a.ReasonOff as varchar),' ')+'='
      ) as ReportRows 
      from sta.PersonForm2 as a join sta.Workers as b on b.ID=a.IDW
      where a.IDB=(select "ID" from PersonForm2Banner where Packet=packetid)
      order by a.ID;

  update PersonForm2Rep set RecID=6, RecData=RecData+'>' 
      where RecID=5 and RecSubID=(select max(RecSubID) from PersonForm2Rep where RecID=5);
end
;