delete FROM "STA"."PersonForm1" where packet=12;
insert into STA.PersonForm1
 (IDW,sType,LastName,FirstName,MiddleName,Sex,Rezident,DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,PersNumOld,LastNameOld,FirstNameOld,
MiddleNameOld,DateBirthOld,Packet)
select ID,0,LastName,FirstName,MiddleName,Sex,(if CitizenShip=30 then 1 else 0 endif),DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,null,null,null,null,null,
  12 from STA.Workers where ID in (7531,7599)
order by ceh,lastname,firstname;

update personform1 set areabirth=null where areabirth='';
update personform1 set regionbirth=null where regionbirth='';

call sta.personform1generate(12);
select recdata from sta.personform1rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00012.txt' format ascii;
