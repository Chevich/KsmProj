call sta.personform2generate(9);
select recdata from sta.personform2rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00009.txt' format ascii;

call sta.personform1generate(7);
select recdata from sta.personform1rep order by recid;
output to 'd:\\WORKS\\PersonUchet\\Packs\\00007.txt' format ascii;