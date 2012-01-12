-- Третья часть марлезонского балета от Леши ;-)
insert into STA.PersonForm2
    (IDB,IDW,TypeContract,DateOn,DateOff,ReasonOff)
select 3,ID,1,'01.01.03',null,null
from STA.Workers where ID in (
5940,6043,6307,6408,6562,6624,6686,6693,7025,7333,7405,7572,7739,7930,
8642,8875,9028,9029,9069,9143,9159,9284,9296,9406,9407,9445,9583,9617,
9796,10012,10046,10894,11473,11927)
order by ceh, lastname,firstname
