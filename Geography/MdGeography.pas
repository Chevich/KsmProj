unit MdGeography;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EtvLook, XEFields, XTFC, Menus, XMisc, XDBTFC, DBTables, EtvTable,
  LnTables, LnkSet, Db, EtvList;

type
  TModuleGeography = class(TDataModule)
    TPlace: TLinkSource;
    TPlaceDeclar: TLinkTable;
    TPlaceDeclarKod: TSmallintField;
    TPlaceDeclarName: TStringField;
    TPlaceLookup: TLinkQuery;
    TPlaceLookupSmallintField: TSmallintField;
    TPlaceLookupStringField: TStringField;
    TPlaceC: TDBFormControl;
    Country: TLinkSource;
    CountryDeclar: TLinkTable;
    CountryLookup: TLinkTable;
    PlaceLookup: TLinkTable;
    CountryDeclarKod: TSmallintField;
    CountryDeclarKod2: TStringField;
    CountryDeclarName: TStringField;
    CountryDeclarPhoneKod: TStringField;
    CountryLookupKod: TSmallintField;
    CountryLookupKod2: TStringField;
    CountryLookupName: TStringField;
    Popup: TControlMenu;
    CommonItems: TMenuItem;
    GeoItems: TMenuItem;
    SprCountry1: TLinkMenuItem;
    SprPlace1: TLinkMenuItem;
    SprTPlace1: TLinkMenuItem;
    N1: TMenuItem;
    Rail1: TLinkMenuItem;
    SprStation1: TLinkMenuItem;
    RailDirection1: TLinkMenuItem;
    BoundaryStation1: TLinkMenuItem;
    RailBranch1: TLinkMenuItem;
    CountryC: TDBFormControl;
    Rail: TLinkSource;
    RailDeclar: TLinkTable;
    RailDeclarKod: TSmallintField;
    RailDeclarName: TStringField;
    RailDeclarFullName: TStringField;
    RailDeclarCountry: TSmallintField;
    RailDeclarCountryName: TXELookField;
    RailLookup: TLinkQuery;
    RailLookupKod: TSmallintField;
    RailLookupName: TStringField;
    RailLookupFullName: TStringField;
    RailLookupCountry: TSmallintField;
    RailLookupCountryName: TXELookField;
    RailC: TDBFormControl;
    RailDirection: TLinkSource;
    RailDirectionDeclar: TLinkTable;
    RailDirectionDeclarKod: TSmallintField;
    RailDirectionDeclarName: TStringField;
    RailDirectionLookup: TLinkQuery;
    RailDirectionLookupKod: TSmallintField;
    RailDirectionLookupName: TStringField;
    RailDirectionC: TDBFormControl;
    Place: TLinkSource;
    PlaceDeclar: TLinkTable;
    PlaceDeclarKod: TIntegerField;
    PlaceDeclarName: TStringField;
    PlaceDeclarTPlace: TSmallintField;
    PlaceDeclarTPlaceName: TXELookField;
    PlaceDeclarRegion: TIntegerField;
    PlaceDeclarRegionName: TXELookField;
    PlaceDeclarCountry: TSmallintField;
    PlaceDeclarCountryName: TXELookField;
    PlaceDeclarPhoneKod: TStringField;
    PlaceDeclarSubRegion: TIntegerField;
    PlaceDeclarSubRegionName: TXELookField;
    PlaceDeclarPrPlace: TXEListField;
    PlaceLookup1Kod: TIntegerField;
    PlaceLookup1Name: TStringField;
    PlaceLookupKod: TIntegerField;
    PlaceLookupStringField: TStringField;
    PlaceLookupRegion: TIntegerField;
    PlaceLookupRegionName: TXELookField;
    PlaceLookupSubRegion: TIntegerField;
    PlaceLookupSubRegionName: TXELookField;
    PlaceProcess: TLinkTable;
    PlaceProcessKod: TIntegerField;
    PlaceProcessName: TStringField;
    PlaceC: TDBFormControl;
    Station: TLinkSource;
    StationDeclar: TLinkTable;
    StationLookup: TLinkTable;
    StationDeclarKod: TStringField;
    StationDeclarName: TStringField;
    StationDeclarRail: TSmallintField;
    StationDeclarRailName: TXELookField;
    StationLookupKod: TStringField;
    StationLookupName: TStringField;
    StationLookupRail: TSmallintField;
    StationLookupRailName: TXELookField;
    StationC: TDBFormControl;
    RailBranch: TLinkSource;
    RailBranchDeclar: TLinkTable;
    RailBranchDeclarKod: TSmallintField;
    RailBranchDeclarName: TStringField;
    RailBranchLookup: TLinkQuery;
    RailBranchLookupKod: TSmallintField;
    RailBranchLookupName: TStringField;
    RailBranchC: TDBFormControl;
    BoundaryStationD: TLinkSource;
    BoundaryStationDeclarD: TLinkTable;
    BoundaryStationDeclarDDirection: TSmallintField;
    BoundaryStationDeclarDOrder: TSmallintField;
    BoundaryStationDeclarDStation: TStringField;
    BoundaryStationDeclarDStationName: TXELookField;
    BoundaryStation: TLinkSource;
    BoundaryStationDeclar: TLinkTable;
    BoundaryStationDeclarDirection: TSmallintField;
    BoundaryStationDeclarDirectionName: TXELookField;
    BoundaryStationDeclarOrder: TSmallintField;
    BoundaryStationDeclarStation: TStringField;
    BoundaryStationDeclarStationName: TXELookField;
    BoundaryStationC: TDBFormControl;
    CountryDeclarNationality: TStringField;
    Soato: TLinkSource;
    SoatoDeclar: TLinkTable;
    SoatoDeclarKod: TStringField;
    SoatoDeclarName: TStringField;
    SoatoDeclarObl: TStringField;
    SoatoDeclarRaion: TStringField;
    SoatoDeclarSovet: TStringField;
    SoatoDeclarTip: TStringField;
    SoatoC: TDBFormControl;
    Soato1: TLinkMenuItem;
    SoatoLookup: TLinkTable;
    SoatoLookupKod: TStringField;
    SoatoLookupName: TStringField;
    SoatoLookupObl: TStringField;
    SoatoLookupRaion: TStringField;
    SoatoLookupSovet: TStringField;
    SoatoLookupTip: TStringField;
    Street: TLinkSource;
    StreetDeclar: TLinkTable;
    StreetC: TDBFormControl;
    Street1: TLinkMenuItem;
    StreetLookup: TLinkTable;
    StreetLookupName: TStringField;
    StreetDeclarSOATO: TStringField;
    StreetDeclarKUL: TStringField;
    StreetDeclarTUL: TStringField;
    StreetDeclarNTU: TStringField;
    StreetDeclarName: TStringField;
    StreetDeclarGNI: TStringField;
    StreetDeclarND_CS: TStringField;
    StreetDeclarND_CP: TStringField;
    StreetDeclarND_NS: TStringField;
    StreetDeclarND_NP: TStringField;
    StreetDeclarDateL: TDateField;
    StreetLookupSOATO: TStringField;
    StreetLookupKUL: TStringField;
    StreetLookupTUL: TStringField;
    StreetLookupNTU: TStringField;
    StreetLookupGNI: TStringField;
    StreetDeclarSoatoName: TXELookField;
    StreetDeclarKod: TStringField;
    StreetLookupKod: TStringField;
    procedure PlaceDeclarKodValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleGeography: TModuleGeography;

Implementation

{$R *.DFM}
Procedure TModuleGeography.PlaceDeclarKodValidate(Sender: TField);
begin
  if (Sender=PlaceDeclarKod) and (PlaceDeclar.State in [dsInsert,dsEdit]) then begin
   { Контроль на дублирование кода }
   if PlaceLookup.Locate('Kod',PlaceDeclarKod.Value,[]) then begin
     MessageDlg('Поле: '+PlaceDeclarKod.DisplayLabel+' '+PlaceDeclarKod.AsString+#13+
                'Дублирование значений',mtWarning,[mbOk],0);
     Abort;
   end;
  end;
end;

end.


