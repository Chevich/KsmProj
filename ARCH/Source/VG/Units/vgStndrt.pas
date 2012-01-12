{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         TMoneyString                                  }
{         TDateTimeStorage, TCurrencyStorage            }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgStndrt;

interface
uses Classes;

type
{ TLocaleStorage }
  TLocaleStorage = class(TComponent)
  private
    FSysDefault: Boolean;                
    FText: string;
    procedure SetSysDefault(Value: Boolean);
  protected
    function IsStored: Boolean;
    procedure Loaded; override;
    procedure DefaultChanged;
    procedure SetText(Value: string);
    procedure UpdateText; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Read; virtual;
    procedure Write; virtual;
  published
    property SysDefault: Boolean read FSysDefault write SetSysDefault default True;
    property Text: string read FText write SetText stored False;
  end;

{ TDateTimeStorage }
  TDateTimeStorage = class(TLocaleStorage)
  private
    FDate: string;
    FTime: string;
    FShortDateFormat: string;
    FLongDateFormat: string;
    FDateSeparator: Char;
    FTimeSeparator: Char;
    FTimeAMString: string;
    FTimePMString: string;
    FShortTimeFormat: string;
    FLongTimeFormat: string;
    FShortMonthNames: TStrings;
    FLongMonthNames: TStrings;
    FShortDayNames: TStrings;
    FLongDayNames: TStrings;
    FDateTime: Single;
    procedure SetDateTime(Value: Single);
    procedure SetDate(Value: string);
    procedure SetTime(Value: string);
    procedure SetShortDateFormat(Value: string);
    procedure SetLongDateFormat(Value: string);
    procedure SetDateSeparator(Value: Char);
    procedure SetTimeSeparator(Value: Char);
    procedure SetTimeAMString(Value: string);
    procedure SetTimePMString(Value: string);
    procedure SetShortTimeFormat(Value: string);
    procedure SetLongTimeFormat(Value: string);
    procedure SetShortMonthNames(Value: TStrings);
    procedure SetLongMonthNames(Value: TStrings);
    procedure SetShortDayNames(Value: TStrings);
    procedure SetLongDayNames(Value: TStrings);
    procedure StringsChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Read; override;
    procedure Write; override;
    procedure UpdateText; override;
  published
    property ShortDateFormat: string read FShortDateFormat write SetShortDateFormat stored IsStored;
    property LongDateFormat: string read FLongDateFormat write SetLongDateFormat stored IsStored;
    property DateSeparator: Char read FDateSeparator write SetDateSeparator stored IsStored;
    property TimeSeparator: Char read FTimeSeparator write SetTimeSeparator stored IsStored;
    property TimeAMString: string read FTimeAMString write SetTimeAMString stored IsStored;
    property TimePMString: string read FTimePMString write SetTimePMString stored IsStored;
    property ShortTimeFormat: string read FShortTimeFormat write SetShortTimeFormat stored IsStored;
    property LongTimeFormat: string read FLongTimeFormat write SetLongTimeFormat stored IsStored;

    property ShortMonthNames: TStrings read FShortMonthNames write SetShortMonthNames stored IsStored;
    property LongMonthNames: TStrings read FLongMonthNames write SetLongMonthNames stored IsStored;
    property ShortDayNames: TStrings read FShortDayNames write SetShortDayNames stored IsStored;
    property LongDayNames: TStrings read FLongDayNames write SetLongDayNames stored IsStored;

    property Value: Single read FDateTime write SetDateTime stored False;
    property TextDate: string read FDate write SetDate stored False;
    property TextTime: string read FTime write SetTime stored False;
  end;

{ TCurrencyStorage }
  TCurrencyStorage = class(TLocaleStorage)
  private
    { Private declarations }
    FCurrencyString: string;
    FCurrencyFormat: Byte;
    FNegCurrFormat: Byte;
    FThousandSeparator: Char;
    FDecimalSeparator: Char;
    FCurrencyDecimals: Byte;
    FValue: Single;
    procedure SetCurrencyString(Value: string);
    procedure SetCurrencyFormat(Value: Byte);
    procedure SetNegCurrFormat(Value: Byte);
    procedure SetThousandSeparator(Value: Char);
    procedure SetDecimalSeparator(Value: Char);
    procedure SetCurrencyDecimals(Value: Byte);
    procedure SetValue(Value: Single);
  protected
    { Protected declarations }
    procedure Loaded; override;
    procedure IncorrectValue;
    procedure UpdateText; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function GetText(
      ACurrencyString: string;
      ACurrencyFormat: Byte;
      ANegCurrFormat: Byte;
      AThousandSeparator: Char;
      ADecimalSeparator: Char;
      ACurrencyDecimals: Byte;
      AValue: Single): string;
    function ValueToStr(Value: Single): string;
    procedure Read; override;
    procedure Write; override;
  published
    { Published declarations }
    property CurrencyString: string read FCurrencyString write SetCurrencyString stored IsStored;
    property CurrencyFormat: Byte read FCurrencyFormat write SetCurrencyFormat stored IsStored;
    property NegCurrFormat: Byte read FNegCurrFormat write SetNegCurrFormat stored IsStored;
    property ThousandSeparator: Char read FThousandSeparator write SetThousandSeparator stored IsStored;
    property DecimalSeparator: Char read FDecimalSeparator write SetDecimalSeparator stored IsStored;
    property CurrencyDecimals: Byte read FCurrencyDecimals write SetCurrencyDecimals stored IsStored;
    property Value: Single read FValue write SetValue stored False;
  end;

{ TMoneyString }
  TStringResource = (srMaleOne, srFemaleOne, srTen, srFirstTen, srHundred,
    srThousand, srMillion, srCurrencySub, srCurrency);

  TMoneyFormat  = (mfVerbal, mfDigit);

  TMoneyString = class(TComponent)
  private
    FCurrencyGender: array [0..1] of Boolean;
    FDefault: Boolean;
    FDelimeter: string;
    FLists: array [TStringResource] of TStrings;
    FFormats: array [0..1] of TMoneyFormat;
    FUpperStart: Boolean;
    FValueNumber: Currency;
    FValueString: string;
    FZero: string;
    FZeroEmpty: array [0..1] of Boolean;
    function GetString(Strings: TStrings; Index: Integer): string;
    procedure ListChanged(Sender: TObject);
    function ListStored(Index: Integer): Boolean;
    procedure SetCurrencyGender(Index: Integer; Value: Boolean);
    procedure SetDefault(Value: Boolean);
    procedure SetDelimeter(Value: string);
    procedure SetFormat(Index: Integer; Value: TMoneyFormat);
    procedure SetList(Index: Integer; Value: TStrings);
    procedure SetUpperStart(Value: Boolean);
    procedure SetValueNumber(Value: Currency);
    procedure SetValueString(Value: string);
    procedure SetZero(Value: string);
    procedure SetZeroEmpty(Index: Integer; Value: Boolean);
    function ZeroStored: Boolean;
  public
    constructor Create(AOnwer: TComponent); override;
    destructor Destroy; override;
    function IntegerCurrencyStr(Value: Integer; Currency: TStrings): string;
    function IntegerGenderedToString(Value: Integer; MaleGender: Boolean): string;
    function IntegerToString(Value: Integer): string;
    function MoneyToString(Value: Currency): string;
    function Triada(Value: Integer; MaleGender: Boolean): string;
  published
    property CurrencySub: TStrings index 7 read FLists[srCurrencySub] write SetList stored ListStored;
    property Currency: TStrings index 8 read FLists[srCurrency] write SetList stored ListStored;
    property Default: Boolean read FDefault write SetDefault stored False default True;
    property Delimeter: string read FDelimeter write SetDelimeter;
    property FemaleOne: TStrings index 1 read FLists[srFemaleOne] write SetList stored ListStored;
    property FirstTen: TStrings index 3 read FLists[srFirstTen] write SetList stored ListStored;
    property FormatCurrency: TMoneyFormat index 0 read FFormats[0] write SetFormat default mfVerbal;
    property FormatCurrencySub: TMoneyFormat index 1 read FFormats[1] write SetFormat default mfVerbal;
    property Hundred: TStrings index 4 read FLists[srHundred] write SetList stored ListStored;
    property MaleCurrency: Boolean index 0 read FCurrencyGender[0] write SetCurrencyGender default True;
    property MaleCurrencySub: Boolean index 1 read FCurrencyGender[1] write SetCurrencyGender;
    property MaleOne: TStrings index 0 read FLists[srMaleOne] write SetList stored ListStored;
    property Thousand: TStrings index 5 read FLists[srThousand] write SetList stored ListStored;
    property Million: TStrings index 6 read FLists[srMillion] write SetList stored ListStored;
    property Ten: TStrings index 2 read FLists[srTen] write SetList stored ListStored;
    property UpperStart: Boolean read FUpperStart write SetUpperStart default True;
    property ValueNumber: Currency read FValueNumber write SetValueNumber stored False;
    property ValueString: string read FValueString write SetValueString stored False;
    property Zero: string read FZero write SetZero stored ZeroStored;
    property ZeroEmptyCurrency: Boolean index 0 read FZeroEmpty[0] write SetZeroEmpty default True;
    property ZeroEmptyCurrencySub: Boolean index 1 read FZeroEmpty[1] write SetZeroEmpty default True;
  end;

implementation
uses SysUtils, vgVCLRes, vgUtils, Forms;

var
  StringResourcesDefault: array [TStringResource] of TStrings;

{ TLocaleStorage }
constructor TLocaleStorage.Create(AOwner: TComponent);
begin
  inherited;
  FSysDefault := True;
end;

procedure TLocaleStorage.DefaultChanged;
begin
  FSysDefault := False;
  UpdateText;
end;

function TLocaleStorage.IsStored: Boolean;
begin
  Result := not FSysDefault;
end;

procedure TLocaleStorage.Loaded;
begin
  inherited;
  if not FSysDefault and not (csDesigning in ComponentState) then
  begin
    Write;
    Application.UpdateFormatSettings := False;
  end;
end;

procedure TLocaleStorage.SetSysDefault(Value: Boolean);
begin
  if Value then Read;
  FSysDefault := Value;
end;

procedure TLocaleStorage.Read;
begin
  UpdateText;
end;

procedure TLocaleStorage.Write;
begin
end;

procedure TLocaleStorage.SetText(Value: string);
begin
end;

procedure TLocaleStorage.UpdateText;
begin
end;

{ TDateTimeStorage }
constructor TDateTimeStorage.Create(AOwner: TComponent);
begin
  inherited;
  FShortMonthNames := TStringList.Create;
  FLongMonthNames := TStringList.Create;
  FShortDayNames := TStringList.Create;
  FLongDayNames := TStringList.Create;
  Read;
  TStringList(FShortMonthNames).OnChange := StringsChanged;
  TStringList(FLongMonthNames).OnChange := StringsChanged;
  TStringList(FShortDayNames).OnChange := StringsChanged;
  TStringList(FLongDayNames).OnChange := StringsChanged;
  FDateTime := Now;
end;

destructor TDateTimeStorage.Destroy;
begin
  FShortMonthNames.Free;
  FLongMonthNames.Free;
  FShortDayNames.Free;
  FLongDayNames.Free;
  inherited;
end;

procedure TDateTimeStorage.Read;
begin
  FShortDateFormat := SysUtils.ShortDateFormat;
  FLongDateFormat := SysUtils.LongDateFormat;
  FDateSeparator := SysUtils.DateSeparator;
  FTimeSeparator := SysUtils.TimeSeparator;
  FTimeAMString := SysUtils.TimeAMString;
  FTimePMString := SysUtils.TimePMString;
  FShortTimeFormat := SysUtils.ShortTimeFormat;
  FLongTimeFormat := SysUtils.LongTimeFormat;
  //
  StringsAssignTo(FShortMonthNames, SysUtils.ShortMonthNames);
  StringsAssignTo(FLongMonthNames, SysUtils.LongMonthNames);
  StringsAssignTo(FShortDayNames, SysUtils.ShortDayNames);
  StringsAssignTo(FLongDayNames, SysUtils.LongDayNames);
  inherited;
end;

procedure TDateTimeStorage.Write;
begin
  SysUtils.ShortDateFormat := FShortDateFormat;
  SysUtils.LongDateFormat := FLongDateFormat;
  SysUtils.DateSeparator := FDateSeparator;
  SysUtils.TimeSeparator := FTimeSeparator;
  SysUtils.TimeAMString := FTimeAMString;
  SysUtils.TimePMString := FTimePMString;
  SysUtils.ShortTimeFormat := FShortTimeFormat;
  SysUtils.LongTimeFormat := FLongTimeFormat;
  //
  ArrayAssignTo(FShortMonthNames, SysUtils.ShortMonthNames);
  ArrayAssignTo(FLongMonthNames, SysUtils.LongMonthNames);
  ArrayAssignTo(FShortDayNames, SysUtils.ShortDayNames);
  ArrayAssignTo(FLongDayNames, SysUtils.LongDayNames);
end;

procedure TDateTimeStorage.SetDateTime(Value: Single);
begin
  FDateTime := Value;
  UpdateText;
end;

procedure TDateTimeStorage.SetDate(Value: string);
begin
end;

procedure TDateTimeStorage.SetTime(Value: string);
begin
end;

procedure TDateTimeStorage.SetShortMonthNames(Value: TStrings);
begin
  FShortMonthNames.Assign(Value);
end;

procedure TDateTimeStorage.SetLongMonthNames(Value: TStrings);
begin
  FLongMonthNames.Assign(Value);
end;

procedure TDateTimeStorage.SetShortDayNames(Value: TStrings);
begin
  FShortDayNames.Assign(Value);
end;

procedure TDateTimeStorage.SetLongDayNames(Value: TStrings);
begin
  FLongDayNames.Assign(Value);
end;

procedure TDateTimeStorage.SetShortDateFormat(Value: string);
begin
  if FShortDateFormat <> Value then
  begin
    FShortDateFormat := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetLongDateFormat(Value: string);
begin
  if FLongDateFormat <> Value then
  begin
    FLongDateFormat := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetDateSeparator(Value: Char);
begin
  if FDateSeparator <> Value then
  begin
    FDateSeparator := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetTimeSeparator(Value: Char);
begin
  if FTimeSeparator <> Value then
  begin
    FTimeSeparator := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetTimeAMString(Value: string);
begin
  if FTimeAMString <> Value then
  begin
    FTimeAMString := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetTimePMString(Value: string);
begin
  if FTimePMString <> Value then
  begin
    FTimePMString := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetShortTimeFormat(Value: string);
begin
  if FShortTimeFormat <> Value then
  begin
    FShortTimeFormat := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.SetLongTimeFormat(Value: string);
begin
  if FLongTimeFormat <> Value then
  begin
    FLongTimeFormat := Value;
    DefaultChanged;
  end;
end;

procedure TDateTimeStorage.StringsChanged(Sender: TObject);
begin
  DefaultChanged;
end;

procedure TDateTimeStorage.UpdateText;
var
  TmpShortDateFormat: string;
  TmpLongDateFormat: string;
  TmpDateSeparator: Char;
  TmpTimeSeparator: Char;
  TmpTimeAMString: string;
  TmpTimePMString: string;
  TmpShortTimeFormat: string;
  TmpLongTimeFormat: string;
  TmpShortMonthNames, TmpLongMonthNames,
  TmpShortDayNames, TmpLongDayNames: TStrings;
begin
  TmpShortMonthNames := nil;
  TmpLongMonthNames := nil;
  TmpShortDayNames := nil;
  TmpLongDayNames := nil;
  try
    TmpShortMonthNames := TStringList.Create;
    TmpLongMonthNames := TStringList.Create;
    TmpShortDayNames := TStringList.Create;
    TmpLongDayNames := TStringList.Create;
    // saving
    TmpShortDateFormat := SysUtils.ShortDateFormat;
    TmpLongDateFormat := SysUtils.LongDateFormat;
    TmpDateSeparator := SysUtils.DateSeparator;
    TmpTimeSeparator := SysUtils.TimeSeparator;
    TmpTimeAMString := SysUtils.TimeAMString;
    TmpTimePMString := SysUtils.TimePMString;
    TmpShortTimeFormat := SysUtils.ShortTimeFormat;
    TmpLongTimeFormat := SysUtils.LongTimeFormat;

    StringsAssignTo(TmpShortMonthNames, SysUtils.ShortMonthNames);
    StringsAssignTo(TmpLongMonthNames, SysUtils.LongMonthNames);
    StringsAssignTo(TmpShortDayNames, SysUtils.ShortDayNames);
    StringsAssignTo(TmpLongDayNames, SysUtils.LongDayNames);

    Write;

    FText := DateTimeToStr(FDateTime);
    FDate := DateToStr(FDateTime);
    FTime := TimeToStr(FDateTime);
    // restoring
    SysUtils.ShortDateFormat := TmpShortDateFormat;
    SysUtils.LongDateFormat := TmpLongDateFormat;
    SysUtils.DateSeparator := TmpDateSeparator;
    SysUtils.TimeSeparator := TmpTimeSeparator;
    SysUtils.TimeAMString := TmpTimeAMString;
    SysUtils.TimePMString := TmpTimePMString;
    SysUtils.ShortTimeFormat := TmpShortTimeFormat;
    SysUtils.LongTimeFormat := TmpLongTimeFormat;

    ArrayAssignTo(TmpShortMonthNames, SysUtils.ShortMonthNames);
    ArrayAssignTo(TmpLongMonthNames, SysUtils.LongMonthNames);
    ArrayAssignTo(TmpShortDayNames, SysUtils.ShortDayNames);
    ArrayAssignTo(TmpLongDayNames, SysUtils.LongDayNames);
  finally
    TmpShortMonthNames.Free;
    TmpLongMonthNames.Free;
    TmpShortDayNames.Free;
    TmpLongDayNames.Free;
  end;
end;

{ TCurrencyStorage }
constructor TCurrencyStorage.Create(AOwner: TComponent);
begin
  inherited;
  Read;
  FText := '';
end;

procedure TCurrencyStorage.Loaded;
begin
  inherited;
  if (csDesigning in ComponentState) then SetValue(FValue);
end;

procedure TCurrencyStorage.Read;
begin
  FCurrencyString := SysUtils.CurrencyString;
  FCurrencyFormat := SysUtils.CurrencyFormat;
  FNegCurrFormat := SysUtils.NegCurrFormat;
  FThousandSeparator := SysUtils.ThousandSeparator;
  FDecimalSeparator := SysUtils.DecimalSeparator;
  FCurrencyDecimals := SysUtils.CurrencyDecimals;
  inherited;
end;

procedure TCurrencyStorage.Write;
begin
  SysUtils.CurrencyString := Self.CurrencyString;
  SysUtils.CurrencyFormat := Self.CurrencyFormat;
  SysUtils.NegCurrFormat := Self.NegCurrFormat;
  SysUtils.ThousandSeparator := Self.ThousandSeparator;
  SysUtils.DecimalSeparator := Self.DecimalSeparator;
  SysUtils.CurrencyDecimals := Self.CurrencyDecimals;
end;

function TCurrencyStorage.GetText(
      ACurrencyString: string;
      ACurrencyFormat: Byte;
      ANegCurrFormat: Byte;
      AThousandSeparator: Char;
      ADecimalSeparator: Char;
      ACurrencyDecimals: Byte;
      AValue: Single): string;
var
  SaveCurrencyString: string;
  SaveCurrencyFormat: Byte;
  SaveNegCurrFormat: Byte;
  SaveThousandSeparator: Char;
  SaveDecimalSeparator: Char;
  SaveCurrencyDecimals: Byte;

begin
  Result := '';
  if (csLoading in ComponentState) then Exit;
  SaveCurrencyString := SysUtils.CurrencyString;
  SaveCurrencyFormat := SysUtils.CurrencyFormat;
  SaveNegCurrFormat := SysUtils.NegCurrFormat;
  SaveThousandSeparator := SysUtils.ThousandSeparator;
  SaveDecimalSeparator := SysUtils.DecimalSeparator;
  SaveCurrencyDecimals := SysUtils.CurrencyDecimals;

  try
    SysUtils.CurrencyString := ACurrencyString;
    SysUtils.CurrencyFormat := ACurrencyFormat;
    SysUtils.NegCurrFormat := ANegCurrFormat;
    SysUtils.ThousandSeparator := AThousandSeparator;
    SysUtils.DecimalSeparator := ADecimalSeparator;
    SysUtils.CurrencyDecimals := ACurrencyDecimals;

    Result := FloatToStrF(AValue, ffCurrency, 19, ACurrencyDecimals);

  finally
    SysUtils.CurrencyString := SaveCurrencyString;
    SysUtils.CurrencyFormat := SaveCurrencyFormat;
    SysUtils.NegCurrFormat := SaveNegCurrFormat;
    SysUtils.ThousandSeparator := SaveThousandSeparator;
    SysUtils.DecimalSeparator := SaveDecimalSeparator;
    SysUtils.CurrencyDecimals := SaveCurrencyDecimals;
  end;
end;

function TCurrencyStorage.ValueToStr(Value: Single): string;
begin
  Result := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
end;

procedure TCurrencyStorage.SetCurrencyString(Value: string);
const
  MaxCurrencyString = 10;
begin
  Value := Copy(Value, 1, MaxCurrencyString);
  FText := GetText(
    Value,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
  FCurrencyString := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.SetCurrencyFormat(Value: Byte);
begin
  FText := GetText(
    FCurrencyString,
    Value,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
  FCurrencyFormat := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.SetNegCurrFormat(Value: Byte);
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    Value,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
  FNegCurrFormat := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.SetThousandSeparator(Value: Char);
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    Value,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
  FThousandSeparator := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.SetDecimalSeparator(Value: Char);
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    Value,
    FCurrencyDecimals,
    FValue);
  FDecimalSeparator := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.SetCurrencyDecimals(Value: Byte);
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    Value,
    FValue);
  FCurrencyDecimals := Value;
  DefaultChanged;
end;

procedure TCurrencyStorage.UpdateText;
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    FValue);
end;

procedure TCurrencyStorage.SetValue(Value: Single);
begin
  FText := GetText(
    FCurrencyString,
    FCurrencyFormat,
    FNegCurrFormat,
    FThousandSeparator,
    FDecimalSeparator,
    FCurrencyDecimals,
    Value);
  FValue := Value;
end;

procedure TCurrencyStorage.IncorrectValue;
begin
  raise EInvalidOp.Create('Incorrect value');
end;

{ TMoneyString }
var
  StringResourcesLoaded: Boolean = False;

constructor TMoneyString.Create(AOnwer: TComponent);
var
  I: TStringResource;
begin
  inherited;
  if not StringResourcesLoaded then
  begin
    for I := Low(StringResourcesDefault) to High(StringResourcesDefault) do
    begin
      StringResourcesDefault[I] := TStringList.Create;
      StringResourcesDefault[I].Text := LoadStr(SsrMaleOne - Integer(I));
    end;
    StringResourcesLoaded := True;
  end;

  FCurrencyGender[0] := True;
  FUpperStart := True;
  FZeroEmpty[0] := True;
  FZeroEmpty[1] := True;
    
  for I := Low(TStringResource) to High(TStringResource) do
  begin
    FLists[I] := TStringList.Create;
    TStringList(FLists[I]).OnChange := ListChanged;
  end;

  SetDefault(True);
end;

destructor TMoneyString.Destroy;
var
  I: TStringResource;
begin
  for I := Low(TStringResource) to High(TStringResource) do
    FLists[I].Free;
  inherited;
end;

function TMoneyString.GetString(Strings: TStrings; Index: Integer): string;
begin
  if Index < Strings.Count then
    Result := Strings[Index] else
    Result := '';
end;

procedure TMoneyString.ListChanged(Sender: TObject);
var
  I: TStringResource;
begin
  for I := Low(TStringResource) to High(TStringResource) do
  begin
    if FLists[I] = Sender then
    begin
      FDefault := not ListStored(Integer(I));
      Break;
    end;
  end;
  SetValueString('');
end;

function TMoneyString.ListStored(Index: Integer): Boolean;
begin
  Result := (FLists[TStringResource(Index)].Text <> StringResourcesDefault[TStringResource(Index)].Text);
end;

function TMoneyString.Triada(Value:Integer; MaleGender: Boolean): string;
var
  Tmp: Integer;
begin
  Tmp := Value div 100;
  Value := Value mod 100;

  if (Tmp > 0) then
  begin
    Result := GetString(FLists[srHundred], Tmp - 1);
    if Value > 0 then Result := Result + ' ';
  end else
    Result := '';

  Tmp := Value div 10;
  Value := Value mod 10;

  if (Tmp > 1) then
  begin
    Result := Result + GetString(FLists[srTen], Tmp - 1);
    Tmp := Value;
    if (Tmp > 0) then
    begin
      Result := Result + ' ';
      if MaleGender then
        Result := Result + GetString(FLists[srMaleOne], Tmp - 1) else
        Result := Result + GetString(FLists[srFemaleOne], Tmp - 1);
    end;
  end else begin
    Tmp := Tmp * 10 + Value;
    case Tmp of
      1..9:
        begin
          if MaleGender then
            Result := Result + GetString(FLists[srMaleOne], Tmp - 1) else
            Result := Result + GetString(FLists[srFemaleOne], Tmp - 1);
        end;
      10:
        begin
          Result := Result + GetString(FLists[srTen], 0);
        end;
      11..19:
        begin
          Result := Result + GetString(FLists[srFirstTen], Tmp - 11);
        end;
    end;
  end;
end;

function TMoneyString.IntegerCurrencyStr(Value: Integer; Currency: TStrings): string;
begin
  if Value mod 100 in [11..19] then
    Result := GetString(Currency, 2)
  else case (Value mod 10) of
    0, 5..9:
      Result := GetString(Currency, 2);
    1:
      Result := GetString(Currency, 0);
    2..4:
      Result := GetString(Currency, 1);
  end;
end;

function TMoneyString.IntegerGenderedToString(Value: Integer; MaleGender: Boolean): string;
var
  Tmp: Integer;
begin
  if Value = 0 then
  begin
    Result := FZero;
    Exit;
  end;
  
  Tmp := Value div 1000000;
  Value := Value mod 1000000;
  if Tmp > 0 then
  begin
    Result := IntegerGenderedToString(Tmp, True) + ' ' +
              IntegerCurrencyStr(Tmp, FLists[srMillion]);
    if Value > 0 then Result := Result + ' ';
  end else
    Result := '';

  Tmp := Value div 1000;
  Value := Value mod 1000;
  if Tmp > 0 then
  begin
    Result := Result +
      IntegerGenderedToString(Tmp, False) + ' ' +
      IntegerCurrencyStr(Tmp, FLists[srThousand]);
    if Value > 0 then Result := Result + ' ';
  end;

  Tmp := Value;
  if (Tmp > 0) then
    Result := Result + Triada(Tmp, MaleGender);
end;

function TMoneyString.IntegerToString(Value: Integer): string;
begin
  Result := IntegerGenderedToString(Value, True);
end;

function TMoneyString.MoneyToString(Value: Currency): string;
var
  Curr, CurrSub: Integer;
  Tmp, ResultSub: string;
begin
  Curr := Trunc(Value);
  CurrSub := Round(Frac(Value) * 100);

  if CurrSub = 100 then
  begin
    CurrSub := 0;
    Inc(Curr);
  end;
    

  { Currency string }
  if FFormats[0] = mfVerbal then
  begin
    if not ((Curr = 0) and FZeroEmpty[0]) then
      Result := IntegerGenderedToString(Curr, FCurrencyGender[0]) else
      Result := '';
  end else begin
    if not ((Curr = 0) and FZeroEmpty[0]) then
      Result := Format('%.2d', [Curr]) else
      Result := '';
  end;

  if (Result <> '') then
  begin
    Tmp := IntegerCurrencyStr(Curr, FLists[srCurrency]);
    if Tmp <> '' then Result := Result + ' ' + Tmp;
  end;

  { CurrencySub string }
  if FFormats[1] = mfVerbal then
  begin
    if not ((CurrSub = 0) and FZeroEmpty[1]) then
      ResultSub := IntegerGenderedToString(CurrSub, FCurrencyGender[1]) else
      ResultSub := '';
  end else begin
    if not ((CurrSub = 0) and FZeroEmpty[1]) then
      ResultSub := Format('%.2d', [CurrSub]) else
      ResultSub := '';
  end;

  if (ResultSub <> '') then
  begin
    Tmp := IntegerCurrencyStr(CurrSub, FLists[srCurrencySub]);
    if Tmp <> '' then ResultSub := ResultSub + ' ' + Tmp;
  end;

  { Concate Currency and CurrencySub strings }
  if Result <> '' then
  begin
    if ResultSub <> '' then
    begin
      if FDelimeter = '' then
        Result := Result + ' ' + ResultSub else
        Result := Result + ' ' + Delimeter + ' ' + ResultSub;
    end;
  end else
    Result := Result + ResultSub;

  if FUpperStart and (Length(Result) > 0) then Result[1] := AnsiUpperCase(Result[1])[1];
end;

procedure TMoneyString.SetCurrencyGender(Index: Integer; Value: Boolean);
begin
  if FCurrencyGender[Index] <> Value then
  begin
    FCurrencyGender[Index] := Value;
    SetValueString('');
  end;
end;

procedure TMoneyString.SetDefault(Value: Boolean);
var
  I: TStringResource;
begin
  if FDefault <> Value then
  begin
    if Value then
    begin
      for I := Low(TStringResource) to High(TStringResource) do
        SetList(Integer(I), StringResourcesDefault[I]);

      FZero := LoadStr(SsrZero);
    end;
    FDefault := Value;
  end;
end;

procedure TMoneyString.SetDelimeter(Value: string);
begin
  if (FDelimeter <> Value) then
  begin
    FDelimeter := Value;
    SetValueString('');
  end;
end;

procedure TMoneyString.SetFormat(Index: Integer; Value: TMoneyFormat);
begin
  if (FFormats[Index] <> Value) then
  begin
    FFormats[Index] := Value;
    SetValueString('');
  end;
end;

procedure TMoneyString.SetList(Index: Integer; Value: TStrings);
begin
  FLists[TStringResource(Index)].Assign(Value);
end;

procedure TMoneyString.SetUpperStart(Value: Boolean);
begin
  if (FUpperStart <> Value) then
  begin
    FUpperStart := Value;
    SetValueString('');
  end;
end;

procedure TMoneyString.SetValueNumber(Value: Currency);
begin
  if FValueNumber <> Value then
  begin
    FValueString := MoneyToString(Value);
    FValueNumber := Value;
  end;
end;

procedure TMoneyString.SetValueString(Value: string);
begin
  FValueString := MoneyToString(FValueNumber);
end;

procedure TMoneyString.SetZero(Value: string);
begin
  if (FZero <> Value) then
  begin
    FZero := Value;
    FDefault := FDefault and not ZeroStored;
    SetValueString('');
  end;
end;

procedure TMoneyString.SetZeroEmpty(Index: Integer; Value: Boolean);
begin
  if (FZeroEmpty[Index] <> Value) then
  begin
    FZeroEmpty[Index] := Value;
    SetValueString('');
  end;
end;

function TMoneyString.ZeroStored: Boolean;
begin
  Result := FZero <> LoadStr(SsrZero);
end;

end.
