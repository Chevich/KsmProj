delete FROM "STA"."PersonForm1" where packet=7;
insert into STA.PersonForm1
 (IDW,sType,LastName,FirstName,MiddleName,Sex,Rezident,DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,PersNumOld,LastNameOld,FirstNameOld,
MiddleNameOld,DateBirthOld,Packet)
select ID,0,LastName,FirstName,MiddleName,Sex,(if CitizenShip=30 then 1 else 0 endif),DateBirth,PlaceBirth,AreaBirth,RegionBirth,CountryBirth,
  PassSer,PassNum,PassAuth,PersNum,PIndex,Address,PhoneWork,PhoneHome,DateFill,DatePass,null,null,null,null,null,
  7 from STA.Workers where ID in (
6183,6202,6308,6315,6439,6442,6515,6665,6848,6998,7197,7384,7485,
7559,8454,8641,8736,8806,9000,9070,9477,9554,10533,11529,7028,9280,9178
)
order by ceh,lastname,firstname;
update personform1 set areabirth=null where areabirth='';
update personform1 set regionbirth=null where regionbirth='';
call sta.personform1generate(7);
select recdata from sta.personform1rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00007.txt' format ascii;
