unit MdWorkers;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, ExpExcel, Controls, Forms, Dialogs,
  Db, DBTables, EtvTable, LnTables, LnkSet, XMisc, XTFC, XDBTFC, Menus,
  EtvList, XEFields, EtvLook, ppBands, ppCtrls, EtvPpCtl, ppStrtch, ppMemo,
  ppPrnabl, ppClass, ppProd, ppReport, ppDB, ppComm, ppRelatv, ppCache,
  ppDBPipe, ppDBBDE; 

type
  TModuleWorkers = class(TDataModule)
    TEducation: TLinkSource;
    TEducationDeclar: TLinkTable;
    TEducationDeclarKod: TSmallintField;
    TEducationDeclarName: TStringField;
    Popup: TControlMenu;
    TEducationC: TDBFormControl;
    N1: TMenuItem;
    N2: TMenuItem;
    TEducation1: TLinkMenuItem;
    Nation: TLinkSource;
    NationDeclar: TLinkTable;
    NationDeclarKod: TSmallintField;
    NationDeclarName: TStringField;
    TEducationLookup: TLinkQuery;
    NationC: TDBFormControl;
    Nation1: TLinkMenuItem;
    Profession: TLinkSource;
    ProfessionDeclar: TLinkTable;
    ProfessionDeclarKod: TIntegerField;
    ProfessionDeclarName: TStringField;
    ProfessionC: TDBFormControl;
    Profession1: TLinkMenuItem;
    ProfessionLookup: TLinkQuery;
    ProfessionLookupKod: TIntegerField;
    ProfessionLookupName: TStringField;
    NationLookup: TLinkQuery;
    NationLookupKod: TSmallintField;
    NationLookupName: TStringField;
    TEducationLookupKod: TSmallintField;
    TEducationLookupName: TStringField;
    Workers: TLinkSource;
    WorkersDeclar: TLinkTable;
    WorkersDeclarID: TAutoIncField;
    WorkersDeclarTabNum: TIntegerField;
    WorkersDeclarFirstName: TStringField;
    WorkersDeclarLastName: TStringField;
    WorkersDeclarMiddleName: TStringField;
    WorkersDeclarDateBirth: TDateField;
    WorkersDeclarPlaceBirth: TStringField;
    WorkersDeclarNationality: TSmallintField;
    WorkersDeclarEducation: TSmallintField;
    WorkersDeclarGraduate: TStringField;
    WorkersDeclarYearGrad: TDateField;
    WorkersDeclarSpecGrad: TStringField;
    WorkersDeclarProfGrad: TStringField;
    WorkersDeclarDiploma: TStringField;
    WorkersDeclarDateDip: TDateField;
    WorkersDeclarProfPrim: TStringField;
    WorkersDeclarProfSecond: TStringField;
    WorkersDeclarExpPrim: TDateField;
    WorkersDeclarExpTotal: TDateField;
    WorkersDeclarExpCont: TDateField;
    WorkersDeclarDateOn: TDateField;
    WorkersDeclarPassSer: TStringField;
    WorkersDeclarPassNum: TStringField;
    WorkersDeclarPassAuth: TStringField;
    WorkersDeclarDatePass: TDateField;
    WorkersDeclarPersNum: TStringField;
    WorkersDeclarAddress: TStringField;
    WorkersDeclarPhoneHome: TStringField;
    WorkersDeclarDateFill: TDateField;
    WorkersDeclarDateOff: TDateField;
    WorkersDeclarReasonOff: TSmallintField;
    WorkersDeclarAreaBirth: TStringField;
    WorkersDeclarRegionBirth: TStringField;
    WorkersDeclarCountryBirth: TSmallintField;
    WorkersDeclarPIndex: TStringField;
    WorkersDeclaritizenship: TSmallintField;
    WorkersDeclarsUser: TStringField;
    WorkersDeclarsTime: TDateTimeField;
    WorkersDeclarSex: TXEListField;
    WorkersDeclarNationalityName: TXELookField;
    WorkersDeclarTEducationName: TXELookField;
    ReasonOff: TLinkSource;
    ReasonOffDeclar: TLinkTable;
    ReasonOffDeclarKod: TIntegerField;
    ReasonOffDeclarName: TStringField;
    ReasonOffC: TDBFormControl;
    ReasonOff1: TLinkMenuItem;
    ReasonOffLookup: TLinkQuery;
    ReasonOffLookupKod: TIntegerField;
    ReasonOffLookupName: TStringField;
    WorkersDeclarReasonOffName: TXELookField;
    WorkersDeclarCountryBirthName: TXELookField;
    WorkersDeclarCitizenshipName: TXELookField;
    WorkersC: TDBFormControl;
    Workers1: TLinkMenuItem;
    WorkersDeclarMarital: TXEListField;
    PersonForm1: TLinkSource;
    PersonForm1Declar: TLinkTable;
    PersonForm1DeclarID: TAutoIncField;
    PersonForm1DeclarIDW: TIntegerField;
    PersonForm1DeclarLastName: TStringField;
    PersonForm1DeclarFirstName: TStringField;
    PersonForm1DeclarMiddleName: TStringField;
    PersonForm1DeclarDateBirth: TDateField;
    PersonForm1DeclarPlaceBirth: TStringField;
    PersonForm1DeclarAreaBirth: TStringField;
    PersonForm1DeclarRegionBirth: TStringField;
    PersonForm1DeclarCountryBirth: TSmallintField;
    PersonForm1DeclarPassSer: TStringField;
    PersonForm1DeclarPassNum: TStringField;
    PersonForm1DeclarPassAuth: TStringField;
    PersonForm1DeclarPersNum: TStringField;
    PersonForm1DeclarPIndex: TStringField;
    PersonForm1DeclarAddress: TStringField;
    PersonForm1DeclarPhoneWork: TStringField;
    PersonForm1DeclarPhoneHome: TStringField;
    PersonForm1DeclarDateFill: TDateField;
    PersonForm1DeclarsUser: TStringField;
    PersonForm1DeclarsTime: TDateTimeField;
    PersonForm1DeclarPacket: TIntegerField;
    PersonForm1DeclarRezident: TXEListField;
    PersonForm1DeclarSex: TXEListField;
    PersonForm1DeclarCountryBirthName: TXELookField;
    PersonForm1C: TDBFormControl;
    PersonForm11: TLinkMenuItem;
    PersonForm1DeclarIDWName: TXELookField;
    PersonForm1DeclarDatePass: TDateField;
    PersonForm1DeclarsType: TSmallintField;
    WorkersDeclarMix: TXEListField;
    PersonForm1DeclarPersNumOld: TStringField;
    PersonForm1DeclarLastNameOld: TStringField;
    PersonForm1DeclarFirstNameOld: TStringField;
    PersonForm1DeclarMiddleNameOld: TStringField;
    PersonForm1DeclarDateBirthOld: TDateField;
    WorkersDeclarPhoneWork: TStringField;
    PersonForm2C: TDBFormControl;
    PersonForm2Banner: TLinkSource;
    PersonForm2BannerDeclar: TLinkTable;
    PersonForm2BannerDeclarID: TAutoIncField;
    PersonForm2BannerDeclarsType: TSmallintField;
    PersonForm2BannerDeclarYear: TIntegerField;
    PersonForm2BannerDeclarDateFill: TDateField;
    PersonForm2BannerDeclarPacket: TIntegerField;
    PersonForm2BannerDeclarQuarter: TSmallintField;
    PersonForm21: TLinkMenuItem;
    PersonForm2: TLinkSource;
    PersonForm2Declar: TLinkTable;
    PersonForm2DeclarID: TIntegerField;
    PersonForm2DeclarIDB: TIntegerField;
    PersonForm2DeclarIDW: TIntegerField;
    PersonForm2DeclarDateOn: TDateField;
    PersonForm2DeclarDateOff: TDateField;
    PersonForm2DeclarReasonOff: TSmallintField;
    PersonForm2DeclarWorkerName: TXELookField;
    PersonForm2DeclarTypeContract: TXEListField;
    PersonForm2DeclarReasonOffName: TXELookField;
    PersonPacket: TLinkSource;
    PersonPacketDeclar: TLinkTable;
    PersonPacketDeclarID: TIntegerField;
    PersonPacketDeclarPersonForms1Num: TSmallintField;
    PersonPacketDeclarPersonForm2Num: TSmallintField;
    PersonPacketDeclarPersonForm3Num: TSmallintField;
    PersonPacketDeclarDateSend: TDateField;
    PersonForm2BannerDeclarIsLock: TSmallintField;
    WorkersVV: TLinkSource;
    WorkersVVLookup: TLinkQuery;
    WorkersVVLookupID: TIntegerField;
    WorkersVVLookupLastName: TStringField;
    WorkersVVLookupFirstName: TStringField;
    WorkersVVLookupMiddleName: TStringField;
    WorkersVVLookupFullName: TStringField;
    WorkersVVLookupTabNum: TIntegerField;
    WorkersVVLookupSex: TSmallintField;
    WorkersVVLookupSexName: TStringField;
    WorkersVVLookupCitizenship: TSmallintField;
    WorkersVVLookupCitizenshipName: TStringField;
    WorkersVVLookupDateBirth: TDateField;
    WorkersVVLookupPlaceBirth: TStringField;
    WorkersVVLookupAreaBirth: TStringField;
    WorkersVVLookupRegionBirth: TStringField;
    WorkersVVLookupCountryBirth: TSmallintField;
    WorkersVVLookupCountryBirthName: TStringField;
    WorkersVVLookupPassSer: TStringField;
    WorkersVVLookupPassNum: TStringField;
    WorkersVVLookupPassAuth: TStringField;
    WorkersVVLookupPersNum: TStringField;
    WorkersVVLookupDatePass: TDateField;
    WorkersVVLookupPIndex: TStringField;
    WorkersVVLookupAddress: TStringField;
    WorkersVVLookupPhoneHome: TStringField;
    WorkersVVLookupDateFill: TDateField;
    WorkersVVLookupCeh: TSmallintField;
    WorkersVVLookupCehName: TStringField;
    Category: TLinkSource;
    CategoryDeclar: TLinkTable;
    CategoryDeclarName: TStringField;
    CategoryC: TDBFormControl;
    Category1: TLinkMenuItem;
    CategoryLookup: TLinkQuery;
    CategoryLookupName: TStringField;
    WorkersDeclarCertificate: TSmallintField;
    Job: TLinkSource;
    JobDeclar: TLinkTable;
    JobDeclarID: TAutoIncField;
    JobDeclarDateOn: TDateField;
    JobDeclarDateOff: TDateField;
    JobDeclarTabNum: TIntegerField;
    JobDeclarTask: TStringField;
    JobDeclarTaskFull: TMemoField;
    JobDeclarStatus: TSmallintField;
    JobDeclarWorkerName: TXELookField;
    JobC: TDBFormControl;
    JobDeclarPriority: TXEListField;
    THome: TLinkSource;
    THomeDeclar: TLinkTable;
    THomeDeclarKod: TSmallintField;
    THomeDeclarName: TStringField;
    THomeC: TDBFormControl;
    N3: TMenuItem;
    THome1: TLinkMenuItem;
    LineHostel: TLinkSource;
    LineHostelDeclar: TLinkTable;
    LineHostelDeclarNumLine: TAutoIncField;
    LineHostelDeclarTabNum: TIntegerField;
    LineHostelDeclarSquare: TFloatField;
    LineHostelDeclarTHome: TSmallintField;
    LineHostelDeclarDateRegistry: TDateField;
    LineHostelDeclarNumLineRegistry: TSmallintField;
    LineHostelDeclarFIO: TXELookField;
    WorkersVVLookupPosition: TIntegerField;
    WorkersVVLookupPositionName: TStringField;
    WorkersVVLookupDateOn: TDateField;
    WorkersVVLookupDateOff: TDateField;
    WorkersVVLookupReasonOff: TSmallintField;
    WorkersVVLookupReasonOffName: TStringField;
    LineHostelDeclarDateBirth: TDateField;
    LineHostelDeclarDateOn: TDateField;
    LineHostelDeclarCehName: TStringField;
    LineHostelDeclarPositionName: TStringField;
    LineHostelDeclarDateOff: TDateField;
    LineHostelDeclarReasonOffName: TStringField;
    THomeLookup: TLinkQuery;
    THomeLookupKod: TSmallintField;
    THomeLookupName: TStringField;
    LineHostelDeclarTHomeName: TXELookField;
    LineHostelC: TDBFormControl;
    LineHostel1: TLinkMenuItem;
    LineHostelDeclarAddress: TStringField;
    LineHostelDeclarAmountFam: TSmallintField;
    WorkersVVLookupAmountFam: TSmallintField;
    WorkersDeclarAmountFam: TSmallintField;
    VacHome: TLinkSource;
    VacHomeDeclar: TLinkTable;
    VacHomeDeclarKod: TSmallintField;
    VacHomeDeclarName: TStringField;
    VacHomeLookup: TLinkQuery;
    VacHomeLookupKod: TSmallintField;
    VacHomeLookupName: TStringField;
    VacHomeC: TDBFormControl;
    VacHome1: TLinkMenuItem;
    LineHostelDeclarVacancy: TSmallintField;
    LineHostelDeclarVacancyName: TXELookField;
    WorkOrdersOffHour: TLinkSource;
    WorkOrdersOffHourDeclar: TLinkTable;
    WorkOrdersOffHourDeclarNum: TStringField;
    WorkOrdersOffHourDeclarsDate: TDateField;
    WorkOrdersOffHourDeclarID: TAutoIncField;
    WorkOrdersOffHourC: TDBFormControl;
    WorkOrdersOffHour1: TLinkMenuItem;
    WorkOffHour: TLinkSource;
    WorkOffHourDeclar: TLinkTable;
    WorkOffHourDeclarTabNum: TIntegerField;
    WorkOffHourDeclarIDOrder: TIntegerField;
    WorkOffHourDeclarFIO: TXELookField;
    WorkOrdersOffHourLookup: TLinkQuery;
    WorkOrdersOffHourLookupID: TIntegerField;
    WorkOrdersOffHourLookupNum: TStringField;
    WorkOrdersOffHourLookupsDate: TDateField;
    WorkOffHourDeclarsDate: TDateField;
    WorkOffHourDeclarOrderName: TXELookField;
    WorkOffHourC: TDBFormControl;
    WorkOffHour1: TLinkMenuItem;
    WorkOffHourV: TLinkSource;
    WorkOffHourVDeclar: TLinkTable;
    WorkOffHourVDeclarTabNum: TIntegerField;
    WorkOffHourVDeclarFullName: TStringField;
    WorkOffHourVDeclarCeh: TSmallintField;
    WorkOffHourVDeclarCehName: TStringField;
    WorkOffHourVDeclarPosition: TIntegerField;
    WorkOffHourVDeclarPositionName: TStringField;
    WorkOffHourVDeclarsYear: TSmallintField;
    WorkOffHourVDeclarsCount: TIntegerField;
    WorkOffHourVC: TDBFormControl;
    WorkOffHourV1: TLinkMenuItem;
    N4: TMenuItem;
    Military: TLinkSource;
    MilitaryDeclar: TLinkTable;
    MilitaryDeclarID: TIntegerField;
    MilitaryDeclarCategory: TSmallintField;
    MilitaryDeclarStaff: TSmallintField;
    MilitaryDeclarRank: TSmallintField;
    MilitaryDeclarSpec: TStringField;
    MilitaryDeclarValidity: TSmallintField;
    MilitaryDeclarOffice: TStringField;
    ArmyGroup: TLinkSource;
    ArmyGroupDeclar: TLinkTable;
    ArmyGroupLookup: TLinkQuery;
    ArmyGroupC: TDBFormControl;
    ArmyStaff: TLinkSource;
    ArmyStaffDeclar: TLinkTable;
    ArmyStaffDeclarKod: TSmallintField;
    ArmyStaffDeclarName: TStringField;
    ArmyStaffLookup: TLinkQuery;
    ArmyStaffLookupKod: TSmallintField;
    ArmyStaffLookupName: TStringField;
    ArmyStaffC: TDBFormControl;
    ArmyRank: TLinkSource;
    ArmyRankDeclar: TLinkTable;
    ArmyRankDeclarKod: TSmallintField;
    ArmyRankDeclarName: TStringField;
    ArmyRankLookup: TLinkQuery;
    ArmyRankLookupKod: TSmallintField;
    ArmyRankLookupName: TStringField;
    ArmyRankC: TDBFormControl;
    MilitaryDeclarsGroup: TSmallintField;
    MilitaryDeclarsGroupName: TXELookField;
    MilitaryDeclarStaffName: TXELookField;
    MilitaryDeclarRankName: TXELookField;
    ArmyValidity: TLinkSource;
    ArmyValidityC: TDBFormControl;
    ArmyValidityDeclar: TLinkTable;
    ArmyValidityDeclarKod: TSmallintField;
    ArmyValidityDeclarName: TStringField;
    ArmyValidityLookup: TLinkQuery;
    ArmyValidityLookupKod: TSmallintField;
    ArmyValidityLookupName: TStringField;
    MilitaryDeclarValGroup: TStringField;
    MilitaryDeclarValArticle: TStringField;
    MilitaryDeclarValOrder: TStringField;
    MilitaryDeclarValidityName: TXELookField;
    N5: TMenuItem;
    ArmyGroup1: TLinkMenuItem;
    ArmyStaff1: TLinkMenuItem;
    ArmyRank1: TLinkMenuItem;
    ArmyValidity1: TLinkMenuItem;
    Family: TLinkSource;
    FamilyDeclar: TLinkTable;
    FamilyDeclarID: TIntegerField;
    FamilyDeclarWho: TSmallintField;
    FamilyDeclarFirstName: TStringField;
    FamilyDeclarLastName: TStringField;
    FamilyDeclarMiddleName: TStringField;
    FamilyDeclarDateBirth: TDateField;
    FamilyDeclarComment: TStringField;
    FamilyWho: TLinkSource;
    FamilyWhoC: TDBFormControl;
    FamilyWhoDeclar: TLinkTable;
    FamilyWhoDeclarKod: TSmallintField;
    FamilyWhoDeclarName: TStringField;
    FamilyWhoLookup: TLinkQuery;
    FamilyWhoLookupKod: TSmallintField;
    FamilyWhoLookupName: TStringField;
    FamilyDeclarWhoName: TXELookField;
    ArmyGroupDeclarKod: TSmallintField;
    ArmyGroupDeclarName: TStringField;
    ArmyGroupLookupKod: TSmallintField;
    ArmyGroupLookupName: TStringField;
    MilitaryDeclarSpecNum: TStringField;
    MilitaryDeclarSpecArticle: TStringField;
    MilitaryDeclarSpecDate: TDateField;
    Career: TLinkSource;
    CareerDeclar: TLinkTable;
    CareerDeclarsDate: TDateField;
    CareerDeclarCeh: TSmallintField;
    CareerDeclarCategory: TSmallintField;
    CareerDeclarWageGrade: TSmallintField;
    CareerDeclarDocReason: TStringField;
    CareerDeclarCehName: TXELookField;
    CareerDeclarSection: TIntegerField;
    CareerDeclarSectionName: TXELookField;
    CareerDeclarCategoryName: TXELookField;
    CareerDeclarPosition: TIntegerField;
    CareerDeclarPositionName: TXELookField;
    CareerDeclarFitness: TXEListField;
    CareerDeclarWorkCondition: TXEListField;
    CareerDeclarDateOff: TDateField;
    CareerDeclarTemp: TXEListField;
    WorkersDeclarPensioner: TSmallintField;
    CareerDeclarID: TIntegerField;
    WorkersVVDeclar: TLinkTable;
    WorkersVVDeclarID: TIntegerField;
    WorkersVVDeclarLastName: TStringField;
    WorkersVVDeclarFirstName: TStringField;
    WorkersVVDeclarMiddleName: TStringField;
    WorkersVVDeclarFullName: TStringField;
    WorkersVVDeclarTabNum: TIntegerField;
    WorkersVVDeclarSexName: TStringField;
    WorkersVVDeclarCitizenship: TSmallintField;
    WorkersVVDeclarCitizenshipName: TStringField;
    WorkersVVDeclarDateBirth: TDateField;
    WorkersVVDeclarPlaceBirth: TStringField;
    WorkersVVDeclarAreaBirth: TStringField;
    WorkersVVDeclarRegionBirth: TStringField;
    WorkersVVDeclarCountryBirth: TSmallintField;
    WorkersVVDeclarCountryBirthName: TStringField;
    WorkersVVDeclarPassSer: TStringField;
    WorkersVVDeclarPassNum: TStringField;
    WorkersVVDeclarPassAuth: TStringField;
    WorkersVVDeclarPersNum: TStringField;
    WorkersVVDeclarDatePass: TDateField;
    WorkersVVDeclarPIndex: TStringField;
    WorkersVVDeclarAddress: TStringField;
    WorkersVVDeclarPhoneHome: TStringField;
    WorkersVVDeclarDateFill: TDateField;
    WorkersVVDeclarDateOn: TDateField;
    WorkersVVDeclarDateOff: TDateField;
    WorkersVVDeclarReasonOff: TSmallintField;
    WorkersVVDeclarReasonOffName: TStringField;
    WorkersVVDeclarAmountFam: TSmallintField;
    WorkersVVDeclarDateOffCareer: TDateField;
    WorkersVVDeclarCeh: TSmallintField;
    WorkersVVDeclarCehName: TStringField;
    WorkersVVDeclarSection: TIntegerField;
    WorkersVVDeclarSectionName: TStringField;
    WorkersVVDeclarCategory: TSmallintField;
    WorkersVVDeclarCategoryName: TStringField;
    WorkersVVDeclarPosition: TIntegerField;
    WorkersVVDeclarPositionName: TStringField;
    WorkersVVDeclarFitness: TSmallintField;
    WorkersVVDeclarWageGrade: TSmallintField;
    WorkersVVDeclarArmyGroup: TSmallintField;
    WorkersVVDeclarArmyGroupName: TStringField;
    WorkersVVDeclarArmyCategory: TSmallintField;
    WorkersVVDeclarStaff: TSmallintField;
    WorkersVVDeclarStaffName: TStringField;
    WorkersVVDeclarRank: TSmallintField;
    WorkersVVDeclarRankName: TStringField;
    WorkersVVDeclarSpec: TStringField;
    WorkersVVDeclarValidity: TSmallintField;
    WorkersVVDeclarValidityName: TStringField;
    WorkersVVDeclarArmyOffice: TStringField;
    WorkersVVDeclarValGroup: TStringField;
    WorkersVVDeclarValArticle: TStringField;
    WorkersVVDeclarValOrder: TStringField;
    WorkersVVDeclarSpecNum: TStringField;
    WorkersVVDeclarSpecArticle: TStringField;
    WorkersVVDeclarSpecDate: TDateField;
    WorkersVVC: TDBFormControl;
    WorkersVVDeclarDateOnCareer: TDateField;
    WorkersVVDeclarWorkCondition: TXEListField;
    WorkersVVDeclarTemp: TXEListField;
    WorkersVV1: TLinkMenuItem;
    WorkersVVDeclarDateBirth1: TStringField;
    WorkersVVDeclarMix: TXEListField;
    CategoryDeclarKod: TSmallintField;
    CategoryLookupKod: TSmallintField;
    WHolidays: TLinkSource;
    HolidaysDeclar: TLinkTable;
    HolidaysDeclarID: TIntegerField;
    HolidaysDeclarType: TSmallintField;
    HolidaysDeclarMain: TSmallintField;
    HolidaysDeclarPeriod: TDateField;
    HolidaysDeclarReason: TStringField;
    HolidaysDeclarContract: TSmallintField;
    HolidaysDeclarTypeAdd: TSmallintField;
    HolidaysDeclarAdditional: TSmallintField;
    HolidaysDeclarDateOn: TDateField;
    HolidaysDeclarDateOff: TDateField;
    HolidaysDeclarTotal: TSmallintField;
    WContract: TLinkSource;
    WContractDeclar: TLinkTable;
    WContractDeclarID: TIntegerField;
    WContractDeclarDateOn: TDateField;
    WContractDeclarDateOff: TDateField;
    WContractDeclarProf: TIntegerField;
    WContractDeclarShop: TSmallintField;
    WContractDeclarReason: TStringField;
    WContractDeclarProfName: TXELookField;
    WContractDeclarShopName: TXELookField;
    WorkersDeclarCountryAddress: TSmallintField;
    WorkersDeclarSoato: TStringField;
    WorkersDeclarHouse: TSmallintField;
    WorkersDeclarHouseAdd: TStringField;
    WorkersDeclarFlat: TStringField;
    WorkersDeclarPassKod: TSmallintField;
    WorkersDeclarSoatoName: TXELookField;
    WorkersDeclarCountryAddressName: TXELookField;
    WorkersDeclarStreetName: TXELookField;
    TPersDoc: TLinkSource;
    TPersDocDeclar: TLinkTable;
    TPersDocDeclarKod: TSmallintField;
    TPersDocDeclarName: TStringField;
    TPersDocC: TDBFormControl;
    TPersDoc1: TLinkMenuItem;
    TPersDocLookup: TLinkQuery;
    TPersDocLookupKod: TSmallintField;
    TPersDocLookupName: TStringField;
    WorkersDeclarPassKodName: TXELookField;
    WorkersDeclarStreet: TStringField;
    WorkersHelp: TLinkSource;
    WorkersHelpDeclar: TLinkTable;
    WorkersHelpDeclarTabNum: TIntegerField;
    WorkersHelpDeclarsDate: TDateField;
    WorkersHelpDeclarSumma: TFloatField;
    WorkersHelpC: TDBFormControl;
    WorkersHelp1: TLinkMenuItem;
    WorkersHelpDeclarTabNumName: TXELookField;
    PLWorkersHelp: TppBDEPipeline;
    RepWorkersHelp: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppMemo1: TppMemo;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    EtvPpDBText1: TEtvPpDBText;
    EtvPpDBText2: TEtvPpDBText;
    EtvPpDBText3: TEtvPpDBText;
    ppLine1: TppLine;
    ppShape1: TppShape;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppMemo2: TppMemo;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLabel31: TppLabel;
    ppMemo3: TppMemo;
    ppMemo4: TppMemo;
    ppLabel32: TppLabel;
    ppLabel33: TppLabel;
    ppLabel34: TppLabel;
    ppLabel35: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppLabel38: TppLabel;
    ppLabel39: TppLabel;
    ppLabel40: TppLabel;
    ppLabel41: TppLabel;
    ppLabel42: TppLabel;
    ppLabel43: TppLabel;
    ppLabel44: TppLabel;
    ppLabel45: TppLabel;
    ppLabel46: TppLabel;
    ppMemo5: TppMemo;
    ppLabel47: TppLabel;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppMemo6: TppMemo;
    ppLabel50: TppLabel;
    EtvPpDBText4: TEtvPpDBText;
    EtvPpDBText5: TEtvPpDBText;
    EtvPpDBText6: TEtvPpDBText;
    EtvPpDBText7: TEtvPpDBText;
    EtvPpDBText8: TEtvPpDBText;
    EtvPpDBText9: TEtvPpDBText;
    EtvPpDBText10: TEtvPpDBText;
    EtvPpDBText11: TEtvPpDBText;
    ppLabel51: TppLabel;
    EtvPpDBText12: TEtvPpDBText;
    ppLabel52: TppLabel;
    ppLabel53: TppLabel;
    EtvPpDBText13: TEtvPpDBText;
    ppLabel54: TppLabel;
    EtvPpDBText14: TEtvPpDBText;
    ppLabel55: TppLabel;
    EtvPpDBText15: TEtvPpDBText;
    ppLabel56: TppLabel;
    WorkersHelpV: TLinkSource;
    WorkersHelpVDeclar: TLinkTable;
    WorkersHelpVDeclarTabNum: TIntegerField;
    WorkersHelpVDeclarJan: TFloatField;
    WorkersHelpVDeclarFeb: TFloatField;
    WorkersHelpVDeclarMar: TFloatField;
    WorkersHelpVDeclarApr: TFloatField;
    WorkersHelpVDeclarMay: TFloatField;
    WorkersHelpVDeclarJun: TFloatField;
    WorkersHelpVDeclarJul: TFloatField;
    WorkersHelpVDeclarAug: TFloatField;
    WorkersHelpVDeclarSep: TFloatField;
    WorkersHelpVDeclarOct: TFloatField;
    WorkersHelpVDeclarNov: TFloatField;
    WorkersHelpVDeclarDec: TFloatField;
    WorkersHelpVDeclarTotal: TFloatField;
    PLWorkersHelpV: TppBDEPipeline;
    WorkersHelpVDeclarID: TIntegerField;
    EtvPpDBText17: TEtvPpDBText;
    EtvPpDBText18: TEtvPpDBText;
    EtvPpDBText19: TEtvPpDBText;
    EtvPpDBText20: TEtvPpDBText;
    EtvPpDBText21: TEtvPpDBText;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppLabel59: TppLabel;
    ppLabel60: TppLabel;
    ppLabel61: TppLabel;
    ppLabel62: TppLabel;
    EtvPpDBText16: TEtvPpDBText;
    EtvPpDBText22: TEtvPpDBText;
    ppLabel63: TppLabel;
    ppLabel64: TppLabel;
    EtvPpDBText23: TEtvPpDBText;
    EtvPpDBText24: TEtvPpDBText;
    ppLabel65: TppLabel;
    ppLabel66: TppLabel;
    EtvPpDBText25: TEtvPpDBText;
    EtvPpDBText26: TEtvPpDBText;
    LineHome: TLinkSource;
    LineHomeDeclar: TLinkTable;
    LineHomeDeclarNumLine: TIntegerField;
    LineHomeDeclarNumLinePriv: TIntegerField;
    LineHomeDeclarTabNum: TIntegerField;
    LineHomeDeclarFioOld: TStringField;
    LineHomeDeclarTotalRegistr: TSmallintField;
    LineHomeDeclarSquare: TFloatField;
    LineHomeDeclarTHome: TSmallintField;
    LineHomeDeclarDatePriv: TDateField;
    LineHomeDeclarTPriv: TSmallintField;
    LineHomeDeclarDateRegistry: TDateField;
    LineHomeDeclarNumLineRegistry: TSmallintField;
    LineHomeC: TDBFormControl;
    N6: TMenuItem;
    N7: TMenuItem;
    LineHome1: TLinkMenuItem;
    SprTPriv: TLinkSource;
    SprTPrivDeclar: TLinkTable;
    SprTPrivDeclarKod: TSmallintField;
    SprTPrivDeclarName: TStringField;
    SprTPrivLookup: TLinkQuery;
    SprTPrivLookupKod: TSmallintField;
    SprTPrivLookupName: TStringField;
    SprTPrivC: TDBFormControl;
    SprTPriv1: TLinkMenuItem;
    LineHomeDeclarTabNumName: TXELookField;
    LineHomeDeclarDateField: TDateField;
    LineHomeDeclarDateField2: TDateField;
    LineHomeDeclarStringField: TStringField;
    LineHomeDeclarStringField2: TStringField;
    LineHomeDeclarAmountFam: TSmallintField;
    WorkersVVDeclarOldAddress: TStringField;
    WorkersVVDeclarSOATO: TStringField;
    WorkersVVDeclarTypeCity: TStringField;
    WorkersVVDeclarCityName: TStringField;
    WorkersVVDeclarObl: TStringField;
    WorkersVVDeclarRaion: TStringField;
    WorkersVVDeclarSovet: TStringField;
    WorkersVVDeclarTypeStreet: TStringField;
    WorkersVVDeclarStreet: TStringField;
    WorkersVVDeclarStreetName: TStringField;
    WorkersVVDeclarHouse: TSmallintField;
    WorkersVVDeclarHouseAdd: TStringField;
    WorkersVVDeclarFlat: TStringField;
    WorkersVVDeclarYears: TSmallintField;
    WorkersVVDeclarYearsWorkKsm: TSmallintField;
    WorkersVVDeclarExpTotal: TDateField;
    WorkersVVDeclarYearsWork: TSmallintField;
    LineHomeDeclarDateOff: TDateField;
    LineHomeDeclarReasonOffName: TStringField;
    LineHomeDeclarTHomeName: TXELookField;
    LineHomeDeclarTPrivName: TXELookField;
    WorkOffHourDeclarID: TAutoIncField;
    WorkersVVDeclarFIO: TStringField;
    WorkersVVDeclarMarital: TXEListField;
    AuthorityC: TDBFormControl;
    Authority: TLinkSource;
    WorkersVVDeclarTEducation: TSmallintField;
    WorkersVVDeclarGraduate: TStringField;
    WorkersVVDeclarDateGrad: TDateField;
    WorkersVVDeclarSpecGrad: TStringField;
    WorkersVVDeclarProfGrad: TStringField;
    WorkersVVDeclarDiploma: TStringField;
    WorkersVVDeclarDateDip: TDateField;
    WorkersVVDeclarProfPrimary: TStringField;
    WorkersVVDeclarProfSecond: TStringField;
    WorkersVVDeclarExpPrim: TDateField;
    WorkersVVDeclarExpCont: TDateField;
    WorkersVVDeclarTEducationName: TStringField;
    AuthorityDeclar: TLinkTable;
    AuthorityDeclarDocNum: TIntegerField;
    AuthorityDeclarDateOn: TDateField;
    AuthorityDeclarDateOff: TDateField;
    AuthorityDeclarOwnerTN: TIntegerField;
    AuthorityDeclarSupplier: TIntegerField;
    AuthorityDeclarGoods: TStringField;
    WorkersSalary: TLinkSource;
    WorkersSalaryDeclar: TLinkTable;
    WorkersSalaryDeclarPeriod: TDateField;
    WorkersSalaryDeclarSumma: TFloatField;
    WorkersSalaryDeclarTabNum: TIntegerField;
    WorkersSalaryDeclarTabNumName: TXELookField;
    WorkersSalaryC: TDBFormControl;
    WorkersSalary1: TLinkMenuItem;
    AverageWage: TLinkSource;
    AverageWageDeclar: TLinkTable;
    AverageWageDeclarPeriod: TDateField;
    AverageWageDeclarSumma: TFloatField;
    AverageWageC: TDBFormControl;
    N8: TMenuItem;
    AverageWage1: TLinkMenuItem;
    WorkersSalaryForPension: TLinkSource;
    WorkersSalaryForPensionDeclar: TLinkTable;
    WorkersSalaryForPensionDeclarsYear: TDateField;
    WorkersSalaryForPensionDeclarJan: TFloatField;
    WorkersSalaryForPensionDeclarFeb: TFloatField;
    WorkersSalaryForPensionDeclarMar: TFloatField;
    WorkersSalaryForPensionDeclarApr: TFloatField;
    WorkersSalaryForPensionDeclarMay: TFloatField;
    WorkersSalaryForPensionDeclarJun: TFloatField;
    WorkersSalaryForPensionDeclarJul: TFloatField;
    WorkersSalaryForPensionDeclarAug: TFloatField;
    WorkersSalaryForPensionDeclarSep: TFloatField;
    WorkersSalaryForPensionDeclarOct: TFloatField;
    WorkersSalaryForPensionDeclarNov: TFloatField;
    WorkersSalaryForPensionDeclarDec: TFloatField;
    WorkersSalaryForPensionDeclarTotal: TFloatField;
    WorkersSalaryForPensionC: TDBFormControl;
    WorkersSalaryForPension1: TLinkMenuItem;
    WorkersSalaryCoeff: TLinkSource;
    WorkersSalaryCoeffDeclar: TLinkTable;
    WorkersSalaryCoeffDeclarPeriod: TDateField;
    WorkersSalaryCoeffDeclarSumma: TFloatField;
    WorkersSalaryCoeffDeclarSalaryAverage: TFloatField;
    WorkersSalaryCoeffDeclarCoeff: TFloatField;
    WorkersSalaryCoeffDeclarIndividualCoeff: TFloatField;
    WorkersSalaryCoeffC: TDBFormControl;
    WorkersSalaryCoeff1: TLinkMenuItem;
    LineHomeV: TLinkSource;
    LineHomeVDeclar: TLinkTable;
    LineHomeVDeclarNumLine: TIntegerField;
    LineHomeVDeclarTabNum: TIntegerField;
    LineHomeVDeclarFIO: TStringField;
    LineHomeVDeclarDateBirth: TDateField;
    LineHomeVDeclarDateWork: TDateField;
    LineHomeVDeclarCeh: TSmallintField;
    LineHomeVDeclarCehName: TStringField;
    LineHomeVDeclarProf: TIntegerField;
    LineHomeVDeclarProfName: TStringField;
    LineHomeVDeclarDateOff: TDateField;
    LineHomeVDeclarReasonOff: TSmallintField;
    LineHomeVDeclarReasonOffName: TStringField;
    LineHomeVDeclarRazr: TSmallintField;
    LineHomeVDeclarFioOld: TStringField;
    LineHomeVDeclarAmountFam: TSmallintField;
    LineHomeVDeclarTotalRegistr: TSmallintField;
    LineHomeVDeclarSquare: TFloatField;
    LineHomeVDeclarTHome: TSmallintField;
    LineHomeVDeclarTHomeName: TStringField;
    LineHomeVDeclarNumLinePriv: TIntegerField;
    LineHomeVDeclarDatePriv: TDateField;
    LineHomeVDeclarTPriv: TSmallintField;
    LineHomeVDeclarTPrivName: TStringField;
    LineHomeVDeclarDateRegistry: TDateField;
    LineHomeVDeclarNumLineRegistry: TSmallintField;
    LineHomeVDeclarPol: TStringField;
    LineHomeVC: TDBFormControl;
    LineHomeV1: TLinkMenuItem;
    WorkersDeclarPhoneCorp: TStringField;
    WorkTime: TLinkSource;
    WorkTimeC: TDBFormControl;
    WorkTimeDeclar: TLinkTable;
    WorkTimeDeclarPeriod: TDateField;
    WorkTimeDeclarShop: TSmallintField;
    WorkTimeDeclarCategory: TSmallintField;
    WorkTimeDeclarID: TAutoIncField;
    WorkTimeDeclarShopName: TXELookField;
    WorkTimeDeclarSectionName: TXELookField;
    WorkTimeDeclarCategoryName: TXELookField;
    WorkTime1: TLinkMenuItem;
    WorkTimeTypes: TLinkSource;
    WorkTimeTypesDeclar: TLinkTable;
    WorkTimeTypesC: TDBFormControl;
    WorkTimeTypes1: TLinkMenuItem;
    WorkTimeTypesDeclarKod: TSmallintField;
    WorkTimeTypesDeclarName: TStringField;
    WorkTimeTypesLookup: TLinkQuery;
    WorkTimeTypesLookupKod: TSmallintField;
    WorkTimeTypesLookupName: TStringField;
    WorkTimeDeclarSection: TIntegerField;
    WorkTimeReport: TLinkSource;
    WorkTimeReportDeclar: TLinkTable;
    WorkTimeReportDeclarID: TIntegerField;
    WorkTimeReportDeclarPeriod: TDateField;
    WorkTimeReportDeclarShop: TSmallintField;
    WorkTimeReportDeclarSection: TIntegerField;
    WorkTimeReportDeclarWorkFact: TFloatField;
    WorkTimeReportDeclarEducationalHoliday: TFloatField;
    WorkTimeReportDeclarHoliday: TFloatField;
    WorkTimeReportDeclarImproveProf: TFloatField;
    WorkTimeReportDeclarDisablement: TFloatField;
    WorkTimeReportDeclarMissions: TFloatField;
    WorkTimeReportDeclarStateDuty: TFloatField;
    WorkTimeReportDeclarMotherDay: TFloatField;
    WorkTimeReportDeclarDaysUpToCourt: TFloatField;
    WorkTimeReportDeclarHolidayInitWorker: TFloatField;
    WorkTimeReportDeclarHolidayInitAdmin: TFloatField;
    WorkTimeReportDeclarAbsence: TFloatField;
    WorkTimeReportDeclarFreeDays: TFloatField;
    WorkTimeReportDeclarWorkHours: TFloatField;
    WorkTimeReportDeclarOverTime: TFloatField;
    WorkTimeReportDeclarNightTime: TFloatField;
    WorkTimeReportDeclarEveningTime: TFloatField;
    WorkTimeReportDeclarStandIdle: TFloatField;
    WorkTimeReportDeclarDelay: TFloatField;
    WorkTimeReportC: TDBFormControl;
    N9: TMenuItem;
    WorkTimeReport1: TLinkMenuItem;
    WorkTimeDeclarWorkFact: TFloatField;
    WorkTimeDeclarEducationalHoliday: TFloatField;
    WorkTimeDeclarHoliday: TFloatField;
    WorkTimeDeclarImproveProf: TFloatField;
    WorkTimeDeclarDisablement: TFloatField;
    WorkTimeDeclarMissions: TFloatField;
    WorkTimeDeclarStateDuty: TFloatField;
    WorkTimeDeclarMotherDay: TFloatField;
    WorkTimeDeclarDaysUpToCourt: TFloatField;
    WorkTimeDeclarHolidayInitWorker: TFloatField;
    WorkTimeDeclarHolidayInitAdmin: TFloatField;
    WorkTimeDeclarAbsence: TFloatField;
    WorkTimeDeclarFreeDays: TFloatField;
    WorkTimeDeclarWorkHours: TFloatField;
    WorkTimeDeclarOverTime: TFloatField;
    WorkTimeDeclarNightTime: TFloatField;
    WorkTimeDeclarEveningTime: TFloatField;
    WorkTimeDeclarStandIdle: TFloatField;
    WorkTimeDeclarDelay: TFloatField;
    WorkTimeDeclarCheck: TFloatField;
    WorkTimeDeclarAbsenceDebatable: TFloatField;
    WorkTimeDeclarCheckUp: TFloatField;
    WorkTimeReportDeclarShopName: TStringField;
    WorkTimeReportDeclarIndustrialName: TStringField;
    WorkTimeReportDeclarSectionName: TStringField;
    WorkTimeReportDeclarCategoryName: TStringField;
    WorkTimeReportDeclarAbsenceDebatable: TFloatField;
    WorkTimeReportDeclarCheckUp: TFloatField;
    WorkTimeReportDeclarIndustrial: TSmallintField;
    WorkTimeReportDeclarCategory: TIntegerField;
    WorkTimeInitItem: TMenuItem;
    WorkTimeDeclarManDayTotal: TFloatField;
    WorkTimeDeclarNumberOnAverage: TFloatField;
    WorkTimeDeclarDaysInPeriod: TSmallintField;
    WorkTimeReportDeclarManDayTotal: TFloatField;
    WorkTimeReportDeclarNumberOnAverage: TFloatField;
    WorkTimeReportDeclarDaysInPeriod: TFloatField;
    ProxysTC: TDBFormControl;
    ProxysT: TLinkSource;
    ProxysTDeclar: TLinkTable;
    ProxysTDeclarID: TIntegerField;
    ProxysTDeclarTN: TIntegerField;
    ProxysTDeclarDateOn: TDateField;
    ProxysTDeclarDateOff: TDateField;
    ProxysTDeclarClient: TIntegerField;
    ProxysTDeclarDoc: TStringField;
    ProxysTDeclarFullName: TXELookField;
    ProxysT1: TLinkMenuItem;
    ProxysTDeclarPassNum: TStringField;
    ProxysTDeclarDatePass: TDateField;
    ProxysTDeclarPassAuth: TStringField;
    ProxysTDeclarClientName: TXELookField;
    ProxysTDeclarPosition: TStringField;
    ProxysTDeclarPositionName: TXELookField;
    LineHomeVDeclarAddress: TStringField;
    LineHomeDeclarAddress: TStringField;
    WorkTimeReportDeclarAverageNumber: TFloatField;
    WorkTimeDeclarAverageNumber: TFloatField;
    Education: TLinkSource;
    EducationDeclar: TLinkTable;
    EducationDeclarKod: TSmallintField;
    EducationDeclarName: TStringField;
    EducationDeclarTEducation: TSmallintField;
    EducationDeclarPIndex: TStringField;
    EducationDeclarAddress: TStringField;
    EducationDeclarRector: TStringField;
    EducationDeclarPhones: TStringField;
    EducationDeclarWebSite: TStringField;
    EducationDeclarEMail: TStringField;
    EducationDeclarTEducationName: TXELookField;
    EducationC: TDBFormControl;
    Education1: TLinkMenuItem;
    TEducationDeclarWebLink: TStringField;
    WContractDeclarActive: TXEListField;
    EducationLookup: TLinkQuery;
    EducationLookupKod: TSmallintField;
    EducationLookupName: TStringField;
    EducationLookupTEducation: TSmallintField;
    EducationLookupTEducationName: TXELookField;
    WorkersDeclarEducation2: TSmallintField;
    WorkersDeclarEducationName: TXELookField;
    WorkersVVDeclarContractDateOn: TDateField;
    WorkersVVDeclarContractDateOff: TDateField;
    WorkersVVDeclarContractProf: TIntegerField;
    WorkersVVDeclarContractProfName: TStringField;
    WorkersVVDeclarContractShop: TSmallintField;
    WorkersVVDeclarContractReason: TStringField;
    WorkersVVDeclarContractActive: TXEListField;
    WContractMessages: TLinkSource;
    WContractMessagesDeclar: TLinkTable;
    WContractMessagesDeclarID: TIntegerField;
    WContractMessagesDeclarFIO: TStringField;
    WContractMessagesDeclarCeh: TSmallintField;
    WContractMessagesDeclarCehName: TStringField;
    WContractMessagesDeclarPosition: TIntegerField;
    WContractMessagesDeclarPositionName: TStringField;
    WContractMessagesDeclarTabNum: TIntegerField;
    WContractMessagesDeclarIDW: TIntegerField;
    WContractMessagesDeclaraMessage: TStringField;
    WContractMessagesC: TDBFormControl;
    WContractMessages1: TLinkMenuItem;
    WorkersVVLookup1: TLinkTable;
    WorkersVVLookup1ID: TIntegerField;
    WorkersVVLookup1FullName: TStringField;
    WorkersVVLookup1TabNum: TIntegerField;
    WorkersVVLookup1DateBirth: TDateField;
    WorkersVVLookup1Address: TStringField;
    WorkersVVLookup1DateOn: TDateField;
    WorkersVVLookup1AmountFam: TSmallintField;
    WorkersVVLookup1CehName: TStringField;
    WorkersVVLookup1SectionName: TStringField;
    WorkersVVLookup1Position: TIntegerField;
    WorkersVVLookup1PositionName: TStringField;
    WorkersVVLookup1FIO: TStringField;
    WorkersVVLookupFIO: TStringField;
    WorkersVVLookup2: TLinkQuery;
    WorkersVVLookup2ID: TIntegerField;
    WorkersVVLookup2TabNum: TIntegerField;
    WorkersVVLookup2FIO: TStringField;
    WorkersVVLookup2Position: TIntegerField;
    WorkersVVLookup2Ceh: TSmallintField;
    JobHi: TLinkSource;
    JobHiDeclar: TLinkTable;
    JobHiDeclarText: TStringField;
    JobHiDeclarDateOff: TDateField;
    JobHiDeclarNote: TStringField;
    JobHiDeclarID: TAutoIncField;
    TConference: TLinkSource;
    TConferenceDeclar: TLinkTable;
    TConferenceLookup: TLinkQuery;
    TConferenceLookupKod: TSmallintField;
    TConferenceLookupName: TStringField;
    TConferenceDeclarKod: TSmallintField;
    TConferenceDeclarName: TStringField;
    TConferenceC: TDBFormControl;
    N10: TMenuItem;
    TConference1: TLinkMenuItem;
    JobHiProtocolC: TDBFormControl;
    JobHiDeclarNoteOff: TXEListField;
    JobHiProtocol1: TLinkMenuItem;
    JobHiExecutorsD: TLinkSource;
    JobHiExecutorsDDeclar: TLinkTable;
    JobHiExecutorsDDeclarIDJobHi: TIntegerField;
    JobHiExecutorsDDeclarTabNum: TIntegerField;
    JobHiExecutorsDDeclarID: TAutoIncField;
    JobHiExecutorsDDeclarTabNumName: TXELookField;
    JobHiDeclarExecutors: TStringField;
    TConferenceDeclarGenetive: TStringField;
    JobHiProtocol: TLinkSource;
    JobHiProtocolDeclar: TLinkTable;
    JobHiProtocolDeclarDateOn: TDateField;
    JobHiProtocolDeclarTConference: TSmallintField;
    JobHiProtocolDeclarID: TAutoIncField;
    JobHiProtocolDeclarTConferenceName: TXELookField;
    TConferenceLookupGenitive: TStringField;
    JobHiDeclarIDProtocol: TIntegerField;
    JobHiDeclarDateExec: TDateField;
    JobHiDeclarConfirm: TSmallintField;
    JobHiExecutorsDDeclarDateExec: TDateField;
    JobHiExecutorsDDeclarNote: TStringField;
    JobHiExecutorsDDeclarNoteOff: TXEListField;
    WorkersVVDeclarContractDuration: TFloatField;
    WSizes: TLinkSource;
    WSizesDeclar: TLinkTable;
    WSizesDeclarID: TIntegerField;
    WSizesDeclarStature: TFloatField;
    WSizesDeclarSizeWorkWhear: TFloatField;
    WSizesDeclarSizeWorkShoes: TFloatField;
    WSizesDeclarSizeHeadWear: TFloatField;
    WSizesDeclarSizeGasMask: TFloatField;
    WSizesDeclarSizeRespirator: TFloatField;
    WSizesDeclarSizeWorkingMittens: TFloatField;
    WSizesDeclarSizeWorkingGloves: TFloatField;
    WProfAdd: TLinkSource;
    WProfAddDeclar: TLinkTable;
    WProfAddDeclarID: TIntegerField;
    WProfAddDeclarProf: TIntegerField;
    WProfAddDeclarJustification: TStringField;
    WProfAddDeclarProfName: TXELookField;
    WProfAddDeclarLevel: TStringField;
    WProfAddV: TLinkSource;
    WProfAddVDeclar: TLinkTable;
    WProfAddVDeclarID: TIntegerField;
    WProfAddVDeclarTabNum: TIntegerField;
    WProfAddVDeclarFullName: TStringField;
    WProfAddVDeclarProf: TIntegerField;
    WProfAddVDeclarProfName: TStringField;
    WProfAddVDeclarLevel: TStringField;
    WProfAddVDeclarJustification: TStringField;
    WProfAddVC: TDBFormControl;
    WProfAddV1: TLinkMenuItem;
    WProfAddVDeclarCeh: TSmallintField;
    WProfAddVDeclarCehName: TStringField;
    WProfAddVDeclarPosition: TIntegerField;
    WProfAddVDeclarPositionName: TStringField;
    WProfAddVDeclarDateOff: TDateField;
    Procedure WorkersDeclarAfterPost(DataSet: TDataSet);
    Procedure PersonForm1ButtonClick(Sender: TObject);
    Procedure LineHostelButtonClick(Sender: TObject);
    Procedure LineHomeButtonClick(Sender: TObject);
    Procedure WContractMessagesClick(Sender: TObject);
    procedure PersonForm1CCreateForm(Sender: TObject);
    procedure PersonForm2BannerDataChange(Sender: TObject; Field: TField);
    procedure PersonForm2BannerDeclarBeforePost(DataSet: TDataSet);
    procedure LineHostelDeclarCalcFields(DataSet: TDataSet);
    procedure WorkOffHourDeclarBeforePost(DataSet: TDataSet);
    procedure MilitaryDataChange(Sender: TObject; Field: TField);
    procedure WorkersDeclarRegionBirthValidate(Sender: TField);
    procedure GridDblClick(Sender: TObject);
    procedure WorkersSalaryDeclarBeforePost(DataSet: TDataSet);
    procedure WorkersSalaryDeclarNewRecord(DataSet: TDataSet);
    procedure WorkersSalaryDeclarAfterInsert(DataSet: TDataSet);
    procedure WorkersSalaryForPensionCCreateForm(Sender: TObject);
    procedure WorkersCCreateForm(Sender: TObject);
    procedure LineHomeVCCreateForm(Sender: TObject);
    procedure WorkTimeDeclarBeforePost(DataSet: TDataSet);
    procedure WorkTimeDeclarNewRecord(DataSet: TDataSet);
    procedure WorkTimeReportCCreateForm(Sender: TObject);
    procedure WorkTimeDeclarCalcFields(DataSet: TDataSet);
    procedure WorkTimeDeclarAfterPost(DataSet: TDataSet);
    procedure ModuleWorkersCreate(Sender: TObject);
    procedure WorkTimeInitItemClick(Sender: TObject);
    procedure ProxysTCCreateForm(Sender: TObject);
    procedure CalcReportClick(Sender: TObject);
    procedure ProxysTDeclarCalcFields(DataSet: TDataSet);
    procedure SetGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetGridFont(Sender: TObject; Field: TField; Font: TFont);
    procedure WorkersDeclarAfterScroll(DataSet: TDataSet);
    procedure JobHiProtocolCCreateForm(Sender: TObject);
    procedure JobHiExecutorsDDeclarAfterPost(DataSet: TDataSet);
    procedure JobHiDeclarConfirmValidate(Sender: TField);
    procedure JobHiProtocolDataChange(Sender: TObject; Field: TField);
    procedure JobHiDeclarAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleWorkers: TModuleWorkers;

Implementation
  uses XECtrls, MdBase, MdGeography, Buttons, ToolEdit, EtvDBFun, BEForms, Misc, Person2, Workers,
    MdClientsAdd, DiDate, MdOrgs, XApps, JobHiProtocol;

var
  PersonForm1Button: TBitBtn;
  LineHostelButton: TBitBtn;
  LineHomeButton: TBitBtn;
  WContractMessagesButton: TBitBtn;
  WContractDateOff: TDateEdit;
  aPeriod: TDateTime;
  aTabNum: integer;
  aShop: smallint;
  aSection: integer;
  aCategory: byte;

{$R *.DFM}

procedure TModuleWorkers.WorkersDeclarAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

{ Процедура заполняет необходимые поля в форме "Анкета застрахованного лица" }
{ на основе карточки работника из таблицы STA.Workers                        }
Procedure TModuleWorkers.PersonForm1ButtonClick(Sender: TObject);
begin
  if MessageDlg('Проинициализировать поля анкеты'#13+
           'на основе карточки работник КСМ?',mtWarning,[mbYes, mbNo],0)<>idYes then Abort;
  if not (PersonForm1Declar.State in [dsEdit, dsInsert]) then begin
    ShowMessage('Таблица должна находиться в состоянии "Вставка" или "Изменение"');
    Exit;
  end;
  if PersonForm1DeclarIDW.AsString='' then begin
    ShowMessage('Поле работник КСМ должно быть заполнено');
    Abort;
  end;
  { Собственно инициализация полей анкеты, за исключением поля Rezident }
  PersonForm1Declar.FieldValues['LastName;FirstName;MiddleName;Sex;DateBirth;PlaceBirth;AreaBirth;RegionBirth;CountryBirth;PassSer;PassNum;PassAuth;DatePass;PersNum;PIndex;Address;PhoneHome;DateFill']:=
  WorkersVVLookup.FieldValues['LastName;FirstName;MiddleName;Sex;DateBirth;PlaceBirth;AreaBirth;RegionBirth;CountryBirth;PassSer;PassNum;PassAuth;DatePass;PersNum;PIndex;Address;PhoneHome;DateFill'];
  { Если страна гражданства - Беларусь (код=30), то клиент - резидент, иначе - увы... }
  PersonForm1DeclarRezident.Value:=Byte(WorkersVVLookupCitizenShip.Value=30);
  { Если тип анкеты - изменение анкетных данных, то инициализируем старые значения требуемых полей }
  if PersonForm1DeclarsType.Value in [1,2] then
    PersonForm1Declar.FieldValues['PersNumOld;LastNameOld;FirstNameold;MiddleNameOld']:=
      WorkersVVLookup.FieldValues['PersNum;LastName;FirstName;MiddleName'];
end;

{ Процедура пересчитывает очередь на общежитие }
Procedure TModuleWorkers.LineHostelButtonClick(Sender: TObject);
begin
  if MessageDlg('Расчитать очередь на общежитие'#13+
           'на основе даты подачи заявления?',mtWarning,[mbYes, mbNo],0)<>idYes then Abort;
  if (LineHostelDeclar.State in [dsEdit, dsInsert]) then begin
    ShowMessage('Таблица должна находиться в состоянии "Просмотр"');
    Exit;
  end;
  { Закрыли таблицу со старыми значениями }
  LineHostelDeclar.Close;
  { Запустили расчет очереди }
  ExecSQLText(LineHostelDeclar.DataBaseName,'Call STA.CalculateLineHostel()',false);
  { Открыли таблицу с новыми значениями }
  LineHostelDeclar.Open;
  ShowMessage('Расчет произведен');
end;

{ Процедура пересчитывает очередь на жилье }
Procedure TModuleWorkers.LineHomeButtonClick(Sender: TObject);
begin
  if MessageDlg('Расчитать очередь на жилье'#13+
           'на основе даты подачи заявления?',mtWarning,[mbYes, mbNo],0)<>idYes then Abort;
  if (LineHomeDeclar.State in [dsEdit, dsInsert]) then begin
    ShowMessage('Таблица должна находиться в состоянии "Просмотр"');
    Exit;
  end;
  { Закрыли таблицу со старыми значениями }
  LineHomeDeclar.Close;
  { Запустили расчет очереди }
  ExecSQLText(LineHomeDeclar.DataBaseName,'Call STA.CalculateLineHome()',false);
  { Открыли таблицу с новыми значениями }
  LineHomeDeclar.Open;
  ShowMessage('Расчет произведен');
end;

{ Процедура вычисляет ошибки отдела кадров по заполнению контрактов }
Procedure TModuleWorkers.WContractMessagesClick(Sender: TObject);
begin
  with TLinkTable(TBEForm(TBitBtn(Sender).Owner).Grid.DataSource.DataSet) do begin
    { Закрыли таблицу со старыми значениями }
    DisableControls;
    Close;
    { Запустили расчет ошибок }
    ExecSQLText(DataBaseName,'Call STA.GetWContractMessages(0,'''+WContractDateOff.Text+''')',false);
    { Открыли таблицу с новыми значениями }
    Open;
    EnableControls;
  end;
  ShowMessage('Расчет произведен');
end;

Procedure TModuleWorkers.PersonForm1CCreateForm(Sender: TObject);
var FC: TDBFormControl;
begin
(* Есть общий механизм проверки - удалить попозже. 19.03.2010
  if (UserName<>'KADR') and (UserName<>'LEO') and (UserName<>'JURIST') and (UserName<>'LEV') and (UserName<>'NICK')
  and (UserName<>'ANDY') and (UserName<>'ALEK') and (UserName<>'SERGM') and (UserName<>'ECON') then begin
    ShowMessage('У вас нет прав на работу с этой формой');
    Abort;
  end;
*)
  if Sender.ClassName<>'TDBFormControl' then Exit;
  FC:=TDBFormControl(Sender);
  with TBEForm(FC.Form) do begin
    if FC.Name='PersonForm1C' then begin
      Grid.TitleRows:=3;
      PersonForm1Button:=TBitBtn.Create(FC.Form);
      with PersonForm1Button do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        TabStop:=false;
        Name:='PersonForm1Button';
        Caption:='Инициализация';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=PersonForm1ButtonClick;
      end;
    end else if FC.Name='LineHostelC' then begin
      Grid.TitleRows:=2;
      LineHostelButton:=TBitBtn.Create(FC.Form);
      with LineHostelButton do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        TabStop:=false;
        Name:='LineHostelButton';
        Caption:='Расчет очереди';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=LineHostelButtonClick;
      end
    end else if FC.Name='LineHomeC' then begin
      Grid.TitleRows:=3;
      LineHomeButton:=TBitBtn.Create(FC.Form);
      with LineHomeButton do begin
        Top:=0;
        Left:=125;
        Width:=105;
        Height:=22;
        TabStop:=false;
        Name:='LineHomeButton';
        Caption:='Расчет очереди';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=LineHomeButtonClick;
      end
    end else if FC.Name='WContractMessagesC' then begin
      Grid.TitleRows:=3;
      WContractMessagesButton:=TBitBtn.Create(FC.Form);
      with WContractMessagesButton do begin
        Top:=0;
        Left:=125;
        Width:=120;
        Height:=22;
        TabStop:=false;
        Name:='WContractMessagesButton';
        Caption:='Расчет сообщений';
        Font.Name:='Arial Narrow';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        OnClick:=WContractMessagesClick;
      end;
      { Добавляем дату для выявления заканчивающихся контрактов }
      WContractDateOff:=TDateEdit.Create(FC.Form);
      with WContractDateOff do begin
        Top:=0;
        Left:=WContractMessagesButton.Left+WContractMessagesButton.Width+25;
        Width:=80;
        Height:=20;
        Name:='WContractDateOff';
        Font.Style:=[fsBold];
        Parent:=PageControl1TabPanel;
        TabStop:=true;
        TabOrder:=0;
        if Date=0 then Date:=SysUtils.Date;
      end;
    end else Grid.TitleRows:=3;
    if FC.Name='WProfAddVC' then begin
      Grid.Color:=$00D5F0E5;
    end;
    if FC.Name='WorkersVVC' then begin
      Grid.Color:=$00FAFEE7;
      Grid.OnSetColor:=SetGridColor;
      Grid.OnSetFont:=SetGridFont;
    end;
    Grid.OnDblClick:=GridDblClick;
  end;
end;

Procedure TModuleWorkers.PersonForm2BannerDataChange(Sender: TObject; Field: TField);
begin
  { Исключаем лишнюю работу }
  if (not((Assigned(Field) and (Field.FieldName='TTransport'))
    or ((Sender=nil) and (Field=nil))))
    and not(Assigned(Sender) and (Sender.ClassName='TLinkSource')) then Exit;

  { Идет обработка комбинации клавиш <Ctrl+Shift+Z> }
  if (Sender is TLinkSource) and (TLinkSource(Sender).DataSet.Tag=99) then Exit;

  with PersonForm2.DataSet,TFormPerson2(PersonForm2C.Form) do begin
    { Обработка замков на накладные }
    if PersonForm2BannerDeclarIsLock.Value=0 then begin
      ButtonLockOpen.Visible:=true;
      ButtonLockClose.Visible:=false;
    end else begin
      ButtonLockOpen.Visible:=false;
      ButtonLockClose.Visible:=true;
    end;

    { Обработка CheckListBox'а, определяющего Quarter }
    EditQuarter.Checked[0]:=Boolean(PersonForm2BannerDeclarQuarter.Value and 1);
    EditQuarter.Checked[1]:=Boolean(PersonForm2BannerDeclarQuarter.Value and 2);
    EditQuarter.Checked[2]:=Boolean(PersonForm2BannerDeclarQuarter.Value and 4);
    EditQuarter.Checked[3]:=Boolean(PersonForm2BannerDeclarQuarter.Value and 8);
  end;
end;

procedure TModuleWorkers.PersonForm2BannerDeclarBeforePost(
  DataSet: TDataSet);
begin
  with TFormPerson2(PersonForm2C.Form).EditQuarter do
  PersonForm2BannerDeclarQuarter.Value:=
    Byte(Checked[0])+2*Byte(Checked[1])+4*Byte(Checked[2])+8*Byte(Checked[3])
end;

procedure TModuleWorkers.LineHostelDeclarCalcFields(DataSet: TDataSet);
var aField: TField;
begin
  with DataSet do begin
{
    with TXELookField(FieldByName('FIO')) do begin
      ValueByLookNameToField('DateBirth',FieldByName('DateBirth'));
      ValueByLookNameToField('DateOn',FieldByName('DateOn'));
      ValueByLookNameToField('CehName',FieldByName('CehName'));
      ValueByLookNameToField('PositionName',FieldByName('PositionName'));
      ValueByLookNameToField('DateOff',FieldByName('DateOff'));
      ValueByLookNameToField('ReasonOffName',FieldByName('ReasonOffName'));
      ValueByLookNameToField('Address',FieldByName('Address'));
      ValueByLookNameToField('AmountFam',FieldByName('AmountFam'));
    end;
}
    {if not WorkersVVVLookup.Active then WorkersVVVLookup.Open;}
    if WorkersVVLookup.Locate('TabNum',FieldByName('TabNum').Value,[]) then begin
      aField:=FindField('DateBirth');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('DateBirth').Value;
      aField:=FindField('DateOn');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('DateOn').Value;
      aField:=FindField('CehName');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('CehName').Value;
      aField:=FindField('PositionName');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('PositionName').Value;
      aField:=FindField('DateOff');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('DateOff').Value;
      aField:=FindField('ReasonOffName');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('ReasonOffName').Value;
      aField:=FindField('Address');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('Address').Value;
      aField:=FindField('AmountFam');
      if aField<>nil then aField.Value:=WorkersVVLookup.FieldByName('AmountFam').Value;
    end;
(*
    aField:=FindField('DateBirth');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('DateBirth');
    aField:=FindField('DateOn');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('DateOn');
    aField:=FindField('CehName');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('CehName');
    aField:=FindField('PositionName');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('PositionName');
    aField:=FindField('DateOff');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('DateOff');
    aField:=FindField('ReasonOffName');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('ReasonOffName');
    aField:=FindField('Address');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('Address');
    aField:=FindField('AmountFam');
    if aField<>nil then aField.Value:=TXELookField(FieldByName('TabNumName')).ValueByLookName('AmountFam');
*)
  end;
end;

procedure TModuleWorkers.WorkOffHourDeclarBeforePost(DataSet: TDataSet);
begin
  if WorkOffHourDeclarsDate.Value=0 then
    WorkOffHourDeclarsDate.Value:=WorkOffHourDeclarOrderName.ValueByLookName('sDate');
end;

procedure TModuleWorkers.MilitaryDataChange(Sender: TObject; Field: TField);
begin
  If (Assigned(Field)) and (Field.FieldName<>'Validity') then Exit;
  If Assigned(WorkersC.Form) then with TFormWorkers(WorkersC.Form) do
    CASE MilitaryDeclarValidity.Value of
     3:
       Begin
         Xlabel53.Visible:=True;
         Xlabel54.Visible:=True;
         Xlabel55.Visible:=True;
         EditValGroup.Visible:=True;
         EditValArticle.Visible:=True;
         EditValOrder.Visible:=True;
       End;
    Else
       Begin
         Xlabel53.Visible:=False;
         Xlabel54.Visible:=False;
         Xlabel55.Visible:=False;
         EditValGroup.Visible:=False;
         EditValArticle.Visible:=False;
         EditValOrder.Visible:=False;
       End;
     End;
end;

Procedure TModuleWorkers.WorkersDeclarRegionBirthValidate(Sender: TField);
begin
  if not(Sender.FieldName='RegionBirth') then Exit;
  if (Pos('ОБЛАСТЬ',AnsiUpperCase(Sender.AsString))=0) and (Pos('КРАЙ',AnsiUpperCase(Sender.AsString))=0)
  and (Pos('РЕСПУБЛИКА',AnsiUpperCase(Sender.AsString))=0) then begin
    ShowMessage('В поле обязтельно присутствие'+#13+'одного из слов:'+#13+'Область, Край, Республика');
    Abort;
  end;
end;

Procedure TModuleWorkers.GridDblClick(Sender: TObject);
begin
  inherited;
  if (TXEDbGrid(Sender).DataSource.Name='WorkersVV') or (TXEDbGrid(Sender).DataSource.Name='WContractMessages') or
  (TXEDbGrid(Sender).DataSource.Name='WProfAddV') then
    with TXEDbGrid(Sender) do begin
      { Активизируем соответствующую карточку }
      if not Assigned(WorkersC.Form) or not WorkersC.Form.Active then
        WorkersC.Execute;
      if WorkersDeclar.Locate('TabNum', TXEDbGrid(Sender).DataSource.Dataset.FieldByName('TabNum').Value,[]) then
        WorkersC.Execute;
    end;
end;

procedure TModuleWorkers.WorkersSalaryDeclarBeforePost(DataSet: TDataSet);
begin
  aTabNum:=WorkersSalaryDeclarTabNum.Value;
  aPeriod:=WorkersSalaryDeclarPeriod.Value;
end;

procedure TModuleWorkers.WorkersSalaryDeclarNewRecord(DataSet: TDataSet);
begin
  WorkersSalaryDeclarTabNum.Value:=aTabNum;
  WorkersSalaryDeclarPeriod.Value:=IncMonth(aPeriod,1);
end;

procedure TModuleWorkers.WorkersSalaryDeclarAfterInsert(DataSet: TDataSet);
begin
  if Screen.ActiveForm.ActiveControl is TXEDBGrid then
    TXEDBGrid(Screen.ActiveForm.ActiveControl).SelectedField:=WorkersSalaryDeclarSumma
end;

procedure TModuleWorkers.WorkersSalaryForPensionCCreateForm(Sender: TObject);
begin
  ModuleClientsAdd.CreateReportForm(Sender);
end;

procedure TModuleWorkers.WorkersCCreateForm(Sender: TObject);
var i:byte;
begin
(* Удалить попозже 19.03.2010  
  if (UserName<>'KADR') and (UserName<>'LEO') and (UserName<>'JURIST') and (UserName<>'LEV') and (UserName<>'NICK')
  and (UserName<>'ANDY') and (UserName<>'ALEK') and (UserName<>'SERGM') and (UserName<>'ECON') then begin
    ShowMessage('У вас нет прав на работу с этой формой');
    Abort;
  end;
*)
  with TFormWorkers(WorkersC.Form) do begin
(*
    { доступ к редактированию служебных телефонов }
    if (UserName='SERGEY') or (UserName='МАРШЕВСКИЙ И.Я.') or (UserName='LEV') or (UserName='KADR') then begin
      LabelPhoneCorp.Visible:=true;
      EditPhoneCorp.DataField:='PhoneCorp';
      EditPhoneCorp.Visible:=true;
      EditPhoneCorp.Enabled:=true;
    end;
*)
    for i:=0 to ComponentCount-1 do
      if Components[i] is TXEDBGrid then
        TXEDBGrid(Components[i]).TitleRows:=2
  end;
end;

procedure TModuleWorkers.LineHomeVCCreateForm(Sender: TObject);
begin
  with TBEForm(TDBFormControl(Sender).Form) do begin
    Grid.TitleRows:=5;
    Grid.TitleAlignment:=taCenter;
  end;
end;

procedure TModuleWorkers.WorkTimeDeclarBeforePost(DataSet: TDataSet);
begin
  aPeriod:=WorkTimeDeclarPeriod.Value;
  aShop:=WorkTimeDeclarShop.Value;
  aSection:=WorkTimeDeclarSection.Value;
  aCategory:=WorkTimeDeclarCategory.Value;
end;

procedure TModuleWorkers.WorkTimeDeclarNewRecord(DataSet: TDataSet);
begin
  if aPeriod=0 then
    WorkTimeDeclarPeriod.Value:=ModuleBase.ConfigDeclarCurMonth.Value
  else WorkTimeDeclarPeriod.Value:=aPeriod;
  WorkTimeDeclarShop.Value:=aShop;
  WorkTimeDeclarSection.Value:=aSection;
  WorkTimeDeclarCategory.Value:=aCategory;
end;

procedure TModuleWorkers.WorkTimeReportCCreateForm(Sender: TObject);
begin
  ModuleClientsAdd.CreateReportForm(Sender);
end;

procedure TModuleWorkers.WorkTimeDeclarCalcFields(DataSet: TDataSet);
var DaysInMonth: byte;
begin
  DaysInMonth:=GetFromSQLText(TDBDataSet(DataSet).DataBaseName,
          'select DaysInMonth('''+DataSet.FieldByName('Period').AsString+''')',false);
  with DataSet do begin
    if FieldByName('Period').Value<>null then begin
      FieldByName('Check').AsFloat:=
      Round((FieldByName('WorkFact').AsFloat+FieldByName('EducationalHoliday').AsFloat+FieldByName('Holiday').AsFloat+
      FieldByName('ImproveProf').AsFloat+FieldByName('Disablement').AsFloat+FieldByName('Missions').AsFloat+
      FieldByName('StateDuty').AsFloat+FieldByName('MotherDay').AsFloat+FieldByName('DaysUpToCourt').AsFloat+
      FieldByName('HolidayInitWorker').AsFloat+FieldByName('HolidayInitAdmin').AsFloat+FieldByName('Absence').AsFloat+
      FieldByName('FreeDays').AsFloat+FieldByName('StandIdle').AsFloat+FieldByName('AbsenceDebatable').AsFloat+FieldByName('CheckUp').AsFloat)/DaysInMonth*100)/100
    end;
  end;
end;

procedure TModuleWorkers.WorkTimeDeclarAfterPost(DataSet: TDataSet);
begin
  DataSet.Refresh;
end;

procedure TModuleWorkers.ModuleWorkersCreate(Sender: TObject);
begin
  if Application.Terminated then Exit;
  DataSetLabel(WorkTimeReportDeclar,'STA');
end;

procedure TModuleWorkers.WorkTimeInitItemClick(Sender: TObject);
begin
  DialDate:=TDialDate.Create(Application);
  with DialDate do begin
    VisibleSecondDate(false,50);
    EditDateBeg.Date:=Now;
    Caption:='Укажите новый период';
    if (ShowModal in [idOk, idYes]) and (EditDateBeg.Date>0) then
      try
        ExecSQLText(WorkTimeDeclar.DataBaseName,
          'Call STA.WorkTimeInit('''+EditDateBeg.Text+''')',false);
      finally
        Release;
      end
    else Abort;
  end;
end;

procedure TModuleWorkers.ProxysTCCreateForm(Sender: TObject);
var aReportName: string[50];
    aBitBtn: TBitBtn;
begin
  with TDBFormControl(Sender),TBEForm(TDBFormControl(Sender).Form) do begin
    aReportName:=Copy(TDBFormControl(Sender).Name,1,Length(TDBFormControl(Sender).Name)-1);
    aBitBtn:=TBitBtn.Create(Form);
    with aBitBtn do begin
      Parent:=PageControl1TabPanel;
      Anchors:=[akTop,akLeft];
      Top:=0;
      Left:=205;
      Width:=100;
      Height:=22;
      Name:='BtnCalc'+aReportName;
      Font.Style:=[fsBold];
      Caption:='Печать';
      OnClick:=CalcReportClick;
      TabStop:=true;
      TabOrder:=1;
    end;
  end;
end;

procedure TModuleWorkers.CalcReportClick(Sender: TObject);
var NumDov:integer;
begin
  with ProxysTDeclar do begin
    DisableControls;
    NumDov:=FieldByName('ID').Value;
    Close;
    ProxysTDeclar.Filter:='ID='+IntToStr(NumDov);
    Filtered:=true;
    Open;
    ExportToExcel(ProxysTDeclar,'Data',ProxysTC.Caption,1,DirSHB+'\ProxysTC.xls','');
    Close;
    Filtered:=false;
    Filter:='';
    Open;
    EnableControls;
  end;
//  ExecSQLText(aDeclar.DataBaseName,'call STA.Get'+aReportName+'('+ProxysTDeclar.FieldByName('ID').AsString+')',false);
end;

procedure TModuleWorkers.ProxysTDeclarCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('Position').AsString:=TEtvLookField(FieldByName('FullName')).StringByLookName('Position');
    FieldByName('PassNum').AsString:=TEtvLookField(FieldByName('FullName')).StringByLookName('PassSer')+' '+TEtvLookField(FieldByName('FullName')).StringByLookName('PassNum');
    FieldByName('DatePass').Value:=TEtvLookField(FieldByName('FullName')).ValueByLookName('DatePass');
    FieldByName('PassAuth').AsString:=TEtvLookField(FieldByName('FullName')).StringByLookName('PassAuth');
  end;
end;

procedure TModuleWorkers.SetGridColor(Sender: TObject; Field: TField; var Color: TColor);
begin
  if Sender.ClassName<>'TXEDbGrid' then Exit;
  if not TXEDbGrid(Sender).DataSource.DataSet.FieldByName('DateOff').IsNull then
    Color:=clBtnFace//$00DEEDDF;//$00CDE1DB//$00D5EAC5//$00ECEDE7//$00CCEAAC;
end;

procedure TModuleWorkers.SetGridFont(Sender: TObject; Field: TField; Font: TFont);
begin
  if Sender.ClassName<>'TXEDbGrid' then Exit;
  with TXEDbGrid(Sender).DataSource.DataSet do
    if (FieldByName('DateOffCareer').IsNull) and (FieldByName('DateOff').IsNull) then begin
      //Font.Style:=[fsItalic];
      Font.Color:=clNavy//$00B00000;
    end;
end;

procedure TModuleWorkers.WorkersDeclarAfterScroll(DataSet: TDataSet);
begin
  TFormWorkers(WorkersC.Form).SetColor(DataSet.FieldByName('DateOff').IsNull)
end;

procedure TModuleWorkers.JobHiProtocolCCreateForm(Sender: TObject);
begin
  with TFormJobHiProtocol(JobHiProtocolC.Form) do begin
    with Grid do begin
      TitleRows:=2;
      Font.Name:='ArialNarrow';
      Font.Size:=9;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=8;
    end;
    with Grid1 do begin
      TitleRows:=2;
      Font.Name:='ArialNarrow';
      Font.Size:=9;
      TitleFont.Name:='Arial Narrow';
      TitleFont.Size:=8;
    end;
  end;
end;

procedure TModuleWorkers.JobHiExecutorsDDeclarAfterPost(DataSet: TDataSet);
begin
  JobHiDeclar.Refresh;
end;

procedure TModuleWorkers.JobHiDeclarConfirmValidate(Sender: TField);
begin
  if Sender.Value=1 then with TFormJobHiProtocol(JobHiProtocolC.Form) do begin
    if MessageDlgPos('УВАЖАЕМЫЙ ЛЕОНИД АЛЕКСАНДРОВИЧ!'#13+
      'ВЫ УТВЕРЖДАЕТЕ ТЕКСТ ПОРУЧЕНИЯ, ИСПОЛНИТЕЛЕЙ И СРОКИ?',mtWarning,[mbYes, mbNo],0,
      DbCtrlGrid1.Left+EditConfirm.Left,DbCtrlGrid1.Top+EditConfirm.Top+EditConfirm.Height+80)<>idYes then begin
      Sender.Value:=0;
      Abort;
    end;
  end;
end;

procedure TModuleWorkers.JobHiProtocolDataChange(Sender: TObject; Field: TField);
begin
  with JobHiProtocolDeclar do
    JobHiProtocolC.Caption:='Протокол №'+FieldByName('ID').AsString+' '+
      TXELookField(FieldByName('TConferenceName')).StringByLookName('Genitive')+' от '+FieldByName('DateOn').AsString
end;

procedure TModuleWorkers.JobHiDeclarAfterScroll(DataSet: TDataSet);
var aColor:TColor;
begin
  with DataSet.FieldByName('NoteOff') do
    if Value=Null then aColor:=clWindow
  else case DataSet.FieldByName('NoteOff').AsInteger of
         1: aColor:=$00D5FBD0; { Светло-зеленый }
         0: aColor:=$00DCD9FF; { Светло-красный }
       end;
  TFormJobHiProtocol(JobHiProtocolC.Form).DBCtrlGridSetColorForRow(aColor);
end;

end.
