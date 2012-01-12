-- N+3 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 11,ID,1,(if DateOn<'01.01.2003' then '01.01.2003' else DateOn endif),DateOff,
(if ReasonOff=106 then 1 else if ReasonOff=103 then 2 endif endif)
from STA.Workers 
where ID in (
6183,6202,6308,6315,6439,6442,6515,6848,6998,7028,7197,7384,7485,7559,8454,8641,
8736,9000,9070,9178,9280,9477,9554,10533,11859,

8806,11529
)
order by ceh,lastname,firstname;

call sta.personform2generate(16);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00016.txt' format ascii;