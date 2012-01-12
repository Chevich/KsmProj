-- N+5 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 14,ID,1,(if DateOn<'01.01.2003' then '01.01.2003' else DateOn endif),
(if dateoff<='30.06.2003' then DateOff else null endif),
(if dateoff<='30.06.2003' then if ReasonOff=106 then 1 else if ReasonOff=103 then 2 endif endif else null endif)
from STA.Workers 
where ID in (
11916,11887,11899,11967,11969,11002,6665,6202,
9284,11927,11473,10894,11864,11908,11918,11874,9272,9763,7147,11968,11964,11960,
7244,11866,9716
)
order by id;

call sta.personform2generate(19);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00019.txt' format ascii;