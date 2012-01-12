Allower            TIntegerField     Разрешил  10
AllowerName        TXELookField[35]  Отпуск разрешил  42  LOOKUP(Allower,AllowerLookup,EmpNo,EmpNo;Name)
Kod                TIntegerField     № накладной  10
SDate              TDateField        Дата  10
Transport          TStringField[40]  Транспорт  40
WayPaper           TIntegerField     № п/листа  10
TTransport         TSmallintField    Тип транспортировки  10
TTransportName     TXELookField[25]  Вид транспортировки  25  LOOKUP(TTransport,TTransportLookup,Kod,Kod;Name)
TransPlant         TSmallintField    Тр.предприятие  10
TransPlantName     TXELookField[45]  Транспортное предприятие  45  LOOKUP(TransPlant,TransPlantLookup,Kod,Kod;Name)
Driver             TStringField[20]  ФИО водителя  20
KodSender          TIntegerField     Грузоотправитель  10
SenderName         TXELookField[50]  Грузоотправитель  50  LOOKUP(KodSender,OrgLookup,Kod,Kod;Name)
KodCountSender     TIntegerField     Б/счет грузоотправителя  10
CountSenderName    TXELookField[42]  Б/счет грузоотправителя  42  LOOKUP(KodCountSender,OrgBankLookup,AutoInc,AutoInc;KodBn;BankName;BCount)
Contract           TStringField[15]  № контракта  15
KodOrg             TIntegerField     Грузополучатель  10
OrgName            TXELookField[50]  Грузополучатель  50  LOOKUP(KodOrg,OrgLookup,Kod,Kod;Name)
KodCountOrg        TIntegerField     Б/счет грузополучателя  10
CountOrgName       TXELookField[42]  Б/счет грузополучателя  42  LOOKUP(KodCountOrg,OrgBankLookup,AutoInc,AutoInc;KodBn;BankName;BCount)
Depot              TSmallintField    Пункт погрузки  10
DepotName          TXELookField[45]  Пункт погрузки  45  LOOKUP(Depot,DepotLookup,Kod,Kod;Name)
PointUnloading     TStringField[60]  Пункт разгрузки  60
Trailer1           TStringField[10]  Прицеп №1  10
Trailer2           TStringField[10]  Прицеп №2  10
Massa              TFloatField       Масса брутто, кг  10  CALC
Summa              TFloatField       Сумма  15  CALC
SummaName          TStringField[255] Сумма прописью  255  CALC
Dispatcher         TIntegerField     Диспетчер  10
DispatcherName     TXELookField[30]  Отпуск разрешил  30  LOOKUP(Dispatcher,DispatcherLookup,EmpNo,EmpNo;Name)
TareName           TStringField[15]  Тара  15  CALC
TareAmount         TIntegerField     Кол-во тары  10  CALC
TrustNum           TIntegerField     № доверенности  10
TrustDate          TDateField        Дата доверенности  10
Trust              TStringField[40]  Доверенность выдана  40
MassaName          TStringField[255] Масса прописью  255  CALC
Stockman           TIntegerField     Кладовщик  10
StockmanName       TXELookField[25]  Мастер смены  25  LOOKUP(Stockman,StockmanLookup,EmpNo,EmpNo;Name)
TimeArrival        TTimeField        Время прибытия  10
TimeLeave          TTimeField        Время убытия  10
LoadWork           TSmallintField    Погрузочно-разгрузочные работы  10
PayClaim           TIntegerField     Плат.треб.  10
PayClaimName       TXELookField[12]  № Плат.Док.  12  LOOKUP(PayClaim,PayDocLookup,AutoInc,AutoInc;Num)
SummaClose         TFloatField       Закрыта на сумму  15
