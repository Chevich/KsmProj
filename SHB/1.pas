Allower            TIntegerField     ��������  10
AllowerName        TXELookField[35]  ������ ��������  42  LOOKUP(Allower,AllowerLookup,EmpNo,EmpNo;Name)
Kod                TIntegerField     � ���������  10
SDate              TDateField        ����  10
Transport          TStringField[40]  ���������  40
WayPaper           TIntegerField     � �/�����  10
TTransport         TSmallintField    ��� ���������������  10
TTransportName     TXELookField[25]  ��� ���������������  25  LOOKUP(TTransport,TTransportLookup,Kod,Kod;Name)
TransPlant         TSmallintField    ��.�����������  10
TransPlantName     TXELookField[45]  ������������ �����������  45  LOOKUP(TransPlant,TransPlantLookup,Kod,Kod;Name)
Driver             TStringField[20]  ��� ��������  20
KodSender          TIntegerField     ����������������  10
SenderName         TXELookField[50]  ����������������  50  LOOKUP(KodSender,OrgLookup,Kod,Kod;Name)
KodCountSender     TIntegerField     �/���� ����������������  10
CountSenderName    TXELookField[42]  �/���� ����������������  42  LOOKUP(KodCountSender,OrgBankLookup,AutoInc,AutoInc;KodBn;BankName;BCount)
Contract           TStringField[15]  � ���������  15
KodOrg             TIntegerField     ���������������  10
OrgName            TXELookField[50]  ���������������  50  LOOKUP(KodOrg,OrgLookup,Kod,Kod;Name)
KodCountOrg        TIntegerField     �/���� ���������������  10
CountOrgName       TXELookField[42]  �/���� ���������������  42  LOOKUP(KodCountOrg,OrgBankLookup,AutoInc,AutoInc;KodBn;BankName;BCount)
Depot              TSmallintField    ����� ��������  10
DepotName          TXELookField[45]  ����� ��������  45  LOOKUP(Depot,DepotLookup,Kod,Kod;Name)
PointUnloading     TStringField[60]  ����� ���������  60
Trailer1           TStringField[10]  ������ �1  10
Trailer2           TStringField[10]  ������ �2  10
Massa              TFloatField       ����� ������, ��  10  CALC
Summa              TFloatField       �����  15  CALC
SummaName          TStringField[255] ����� ��������  255  CALC
Dispatcher         TIntegerField     ���������  10
DispatcherName     TXELookField[30]  ������ ��������  30  LOOKUP(Dispatcher,DispatcherLookup,EmpNo,EmpNo;Name)
TareName           TStringField[15]  ����  15  CALC
TareAmount         TIntegerField     ���-�� ����  10  CALC
TrustNum           TIntegerField     � ������������  10
TrustDate          TDateField        ���� ������������  10
Trust              TStringField[40]  ������������ ������  40
MassaName          TStringField[255] ����� ��������  255  CALC
Stockman           TIntegerField     ���������  10
StockmanName       TXELookField[25]  ������ �����  25  LOOKUP(Stockman,StockmanLookup,EmpNo,EmpNo;Name)
TimeArrival        TTimeField        ����� ��������  10
TimeLeave          TTimeField        ����� ������  10
LoadWork           TSmallintField    ����������-������������ ������  10
PayClaim           TIntegerField     ����.����.  10
PayClaimName       TXELookField[12]  � ����.���.  12  LOOKUP(PayClaim,PayDocLookup,AutoInc,AutoInc;Num)
SummaClose         TFloatField       ������� �� �����  15
