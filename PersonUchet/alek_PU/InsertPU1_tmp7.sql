delete FROM "STA"."PersonForm1" where packet=25;
insert into STA.PersonForm1
(IDW,sType,LastName,FirstName,MiddleName,Sex,Rezident,DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,PersNumOld,LastNameOld,FirstNameOld,
MiddleNameOld,DateBirthOld,Packet)
select ID,0,LastName,FirstName,MiddleName,Sex,(if CitizenShip=30 then 1 else 0 endif),DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,null,null,null,null,null,
  25 from STA.Workers where TabNum in (20118,4896,16292,1599,1598,16291,4911,15168,20126,1602,4918,282,9167,1597,20177,393)
order by ceh,lastname,firstname;

update personform1 set areabirth=null where areabirth='';
update personform1 set regionbirth=null where regionbirth='';

call sta.personform1generate(25);
select recdata from sta.personform1rep order by recid;
output to 'W:\\WORKS\\PersonUchet\\Packs\\00025.txt' format ascii;
