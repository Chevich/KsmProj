create global temporary table sta.PersonForm1Rep (
   RecID integer not null,
   RecSubID integer not null,
   RecData varchar(600) not null
)
;

create procedure STA.PersonForm1Generate(in packetid integer)
begin
  delete from sta.PersonForm1Rep;

  insert into PersonForm1Rep select 1,0,'ÇÃËÂ=1.3=' as ReportRows;

  insert into PersonForm1Rep select 2,0,'<ÏÀ×Ê='+a.INN+'='+b.RegNumInFund+'='+UPPER(FullName)+'='+cast(packetid as varchar)+'= = =1=' as ReportRows from sta.Org as a,sta.AdmConfig as b where a.Kod = '900000';

  insert into PersonForm1Rep select 3,0,'ÒÈÏÄ=ÏÓ-1='+cast(count(*) as varchar)+'= = = =>' as ReportRows from PersonForm1 where Packet = packetid;

  insert into PersonForm1Rep select 4,a.sType,UPPER('<ÏÓ-1='+
      (if a.sType = 0 then 'Ð' else if a.sType = 1 then 'È' else if a.sType = 2 then 'Â' endif endif endif)+'='+d.RegNumInFund+'='+
      coalesce(a.LastName,' ')+'='+
      coalesce(a.FirstName,' ')+'='+
      coalesce(a.MiddleName,' ')+'='+
      coalesce(if a.Sex = 0 then 'Æ' else if a.Sex = 1 then 'Ì' endif endif,' ')+'='+coalesce(cast(a.Rezident as varchar),' ')+'='+
      coalesce(convert(varchar(10),a.DateBirth,103),' ')+'='+
      coalesce(a.PlaceBirth,' ')+'='+
      coalesce(a.AreaBirth,' ')+'='+
      coalesce(a.RegionBirth,' ')+'='+
      coalesce(c.Name,' ')+'='+
      coalesce(a.PassSer,' ')+'='+
      coalesce(a.PassNum,' ')+'='+
      coalesce(convert(varchar(10),a.DatePass,103),' ')+'='+
      coalesce(a.PassAuth,' ')+'='+
      coalesce(a.PersNum,' ')+'='+
      coalesce(a.PIndex,' ')+'='+
      coalesce(a.Address,' ')+'='+
      coalesce(a.PhoneWork,' ')+'='+
      coalesce(a.PhoneHome,' ')+'='+
      convert(varchar(10),a.DateFill,103)+'='+
      coalesce(a.PersNumOld,' ')+'='+
      coalesce(a.LastNameOld,' ')+'='+
      coalesce(a.FirstNameOld,' ')+'='+
      coalesce(a.MiddleNameOld,' ')+'='+
      coalesce(convert(varchar(10),a.DateBirthOld,103),' ')+'=>') as ReportRows from
      sta.Org as b,sta.AdmConfig as d,sta.PersonForm1 as a left outer join sta.SprCountry as c on a.CountryBirth = c.Kod where b.Kod = '900000' and a.Packet = packetid order by
      1 asc,2 asc
end
;