-- N+5 часть марлезонского балета от Леши ;-)

insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 13,ID,1,(if DateOn<'01.01.2003' then null else DateOn endif),DateOff,
(if ReasonOff=106 then 1 else if ReasonOff=103 then 2 endif endif)
from STA.Workers 
where ID in (
5940,6006,6162,6494,6543,6585,6592,6666,6685,6767,6824,6833,6871,6875,6887,
6929,6936,7047,7055,7056,7113,7166,7209,7263,7313,7342,7372,7411,7479,7548,7593,7656,
7742,7756,8219,8275,8494,8510,8589,8605,8633,8655,8657,8671,8820,8823,8855,8934,8957,9052,
9053,9057,9058,9226,9231,9298,9312,9404,9406,9658,9693,9732,9747,10885,11020,11849,
11850,11851,11855,11860,11871,11881,11884,11885,11886,11888,11891,11900,11925
)
order by id;

call sta.personform2generate(18);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00018.txt' format ascii;