-- N+6 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 15,ID,1,(if DateOn<'01.01.2003' then '01.01.2003' else DateOn endif),
(if dateoff<='30.06.2003' then DateOff else null endif),
(if dateoff<='30.06.2003' then if ReasonOff=106 then 1 else if ReasonOff=103 then 2 endif endif else null endif)
from STA.Workers 
where ID in (6703, 12002)
order by id;

call sta.personform2generate(20);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00020.txt' format ascii;