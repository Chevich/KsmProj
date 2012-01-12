insert into STA.PersonForm1
 (IDW,sType,LastName,FirstName,MiddleName,Sex,Rezident,DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,PersNumOld,LastNameOld,FirstNameOld,
MiddleNameOld,DateBirthOld,Packet)
select ID,0,LastName,FirstName,MiddleName,Sex,(if CitizenShip=30 then 1 else 0 endif),DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,null,null,null,null,null,0
 from STA.Workers where DateOff is null order by ID
