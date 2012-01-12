{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         National Language Support                     }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgNLS;

interface
uses SysUtils, Classes;

const
  DefDelimeter = '.';

type
  TTranslatePropStringEvent = procedure (Sender: TObject; Instance: TObject; const PropName: string;
    const OldPropValue: string; var NewPropValue: string) of object;
  TTranslatePropInstanceEvent = procedure (Sender: TObject; Instance: TObject) of object;

{ TTranslator }
  TTranslator = class(TComponent)
  private
    FRoot: TObject;
    FTransList: TList;
    FTransStack: string;
    FDelimeter: Char;
    FOnTranslatePropString: TTranslatePropStringEvent;
    FOnTranslatePropInstance: TTranslatePropInstanceEvent;
  protected
    procedure DoTranslatePropString(Instance: TObject; const PropName: string;
      const OldPropValue: string; var NewPropValue: string); dynamic;
    procedure DoTranslatePropInstance(Instance: TObject); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    function TranslatePath: string;
    function TranslatePathProp(const PropName: string): string;
    procedure TranslatePropClass(Instance: TObject; const PropName: string);
    procedure TranslatePropString(Instance: TObject; const PropName: string);
    procedure TranslateProps(Instance: TObject);
    property Root: TObject read FRoot;
  published
    property Delimeter: Char read FDelimeter write FDelimeter default DefDelimeter;
    property OnTranslatePropString: TTranslatePropStringEvent read FOnTranslatePropString write FOnTranslatePropString;
    property OnTranslatePropInstance: TTranslatePropInstanceEvent read FOnTranslatePropInstance write FOnTranslatePropInstance;
  end;

procedure CreateTranslateImage(Instance: TObject; ADelimeter: Char;
  Language: Integer; Image: TStrings);
procedure CreateTranslateImageToFile(Instance: TObject; ADelimeter: Char;
  Language: Integer; const AFileName: TFileName);
{ Creates an string properties image with default language Language }

procedure TranslateFromImage(Instance: TObject; ADelimeter: Char;
  Language: Integer; Image: TStrings);
procedure TranslateFromImageFile(Instance: TObject; ADelimeter: Char;
  Language: Integer; const AFileName: TFileName);
{ Uses string properties image and translates translated in image file properties for given Language }

implementation
uses TypInfo, vgUtils;

const
  StringProps = [tkString, tkLString];
  ClassProps  = [tkClass];

{ TTranslator }
constructor TTranslator.Create(AOwner: TComponent);
begin
  inherited;
  FDelimeter := DefDelimeter;
end;

procedure TTranslator.DoTranslatePropString(Instance: TObject; const PropName: string;
  const OldPropValue: string; var NewPropValue: string);
begin
  if Assigned(FOnTranslatePropString) then
    FOnTranslatePropString(Self, Instance, PropName, OldPropValue, NewPropValue);
end;

procedure TTranslator.DoTranslatePropInstance(Instance: TObject);
var
  NewPropValue, OldPropValue: string;
begin
  if Instance is TStrings then
  begin
    OldPropValue := TStrings(Instance).Text;
    NewPropValue := OldPropValue;
    DoTranslatePropString(Instance, 'Text', OldPropValue, NewPropValue);
    if OldPropValue <> NewPropValue then
      TStrings(Instance).Text := NewPropValue;
  end;

  if Assigned(FOnTranslatePropInstance) then
    FOnTranslatePropInstance(Self, Instance);
end;

function TTranslator.TranslatePath: string;
begin
  Result := FTransStack;
end;

function TTranslator.TranslatePathProp(const PropName: string): string;
begin
  Result := TranslatePath + Delimeter + PropName;
end;

procedure TTranslator.TranslatePropClass(Instance: TObject; const PropName: string);
var
  PropValue: TObject;
  SaveStack: string;
begin
  PropValue := TObject(GetOrdProp(Instance, GetPropInfo(Instance.ClassInfo, PropName)));
  if Assigned(PropValue) and not (PropValue is TComponent) then
  begin
    SaveStack := FTransStack;
    FTransStack := FTransStack + Delimeter + PropName;
    try
      TranslateProps(PropValue);
    finally
      FTransStack := SaveStack;
    end;
  end;
end;

procedure TTranslator.TranslatePropString(Instance: TObject; const PropName: string);
var
  OldPropValue, NewPropValue: string;
begin
  OldPropValue := GetStrProp(Instance, GetPropInfo(Instance.ClassInfo, PropName));
  NewPropValue := OldPropValue;
  DoTranslatePropString(Instance, PropName, OldPropValue, NewPropValue);
  if OldPropValue <> NewPropValue then
    SetStrProp(Instance, GetPropInfo(Instance.ClassInfo, PropName), NewPropValue);
end;

procedure TTranslator.TranslateProps(Instance: TObject);
  procedure DoTranslate(Instance: TComponent; Data: Pointer);
  begin
    if Instance.Name <> '' then
      TTranslator(Data).TranslateProps(Instance);
  end;

  function GetStackDelta: string;
  begin
    if Instance is TComponent then
      Result := TComponent(Instance).Name else
      Result := '';
  end;

var
  I: Integer;
  StackDelta: string;
  List: TList;
  First: Boolean;
begin
  { Check for possible cross-references }
  First := not Assigned(FTransList);
  if First then FRoot := Instance;

  if (ListIndexOf(FTransList, Instance) >= 0) or (Instance is TComponent)
    and (Instance <> FRoot) and (ListIndexOf(FTransList, TComponent(Instance).Owner) < 0) then Exit;

  ListAdd(FTransList, Instance);
  try
    StackDelta := GetStackDelta;
    if StackDelta <> '' then
      AddDelimeted(FTransStack, StackDelta, Delimeter);

    List := TList.Create;
    try
      DoTranslatePropInstance(Instance);

      { String properties }
      GetPropInfoList(List, Instance, StringProps);
      for I := 0 to List.Count - 1 do
        TranslatePropString(Instance, PPropInfo(List[I]).Name);

      { Class properties }
      GetPropInfoList(List, Instance, ClassProps);
      for I := 0 to List.Count - 1 do
        TranslatePropClass(Instance, PPropInfo(List[I]).Name);

      { Nested components }
      if Instance is TComponent then
        ForEachComponent(TComponent(Instance), TComponent, @DoTranslate, Self, False);
    finally
      List.Free;
    end;
  finally
    if First then
    begin
      ListClear(FTransList);
      FRoot := nil;
      FTransStack := '';
    end else
      if StackDelta <> '' then
        FTransStack := Copy(FTransStack, 1, Length(FTransStack) - Length(StackDelta) - 1);
  end;
end;

type
{ TImageTranslator }
  TImageTranslator = class(TTranslator)
  private
    FImage: TStrings;
    FLanguage: Integer;
    FPropValue: TStrings;
  public
    constructor CreateNew(Image: TStrings; Language: Integer);
    destructor Destroy; override;
    property Image: TStrings read FImage;
    property Language: Integer read FLanguage;
    property PropValue: TStrings read FPropValue;
  end;

{ TWriteTranslator }
  TWriteTranslator = class(TImageTranslator)
  public
    procedure DoTranslatePropString(Instance: TObject; const PropName: string;
      const OldPropValue: string; var NewPropValue: string); override;
  end;

{ TReadTranslator }
  TReadTranslator = class(TImageTranslator)
  public
    procedure DoTranslatePropString(Instance: TObject; const PropName: string;
      const OldPropValue: string; var NewPropValue: string); override;
  end;

{ TImageTranslator }
constructor TImageTranslator.CreateNew(Image: TStrings; Language: Integer);
begin
  inherited Create(nil);
  FPropValue := TStringList.Create;
  FImage := Image;
  FLanguage := Language;
end;

destructor TImageTranslator.Destroy;
begin
  FPropValue.Free;
  inherited;
end;

{ TWriteTranslator }
procedure TWriteTranslator.DoTranslatePropString(Instance: TObject; const PropName: string;
  const OldPropValue: string; var NewPropValue: string);
var
  I: Integer;
begin
  if (NewPropValue = '') or (Instance is TComponent) and (CompareText(PropName, 'NAME') = 0) then Exit;
  PropValue.Text := NewPropValue;
  { Property path:Language:TransFlag:string count }
  {   string1 }
  {   string2 }
  Image.Add(Format('%s%s%d%1:s%3:d', [TranslatePathProp(PropName), Delimeter, Language, PropValue.Count]));
  { Property value }
  for I := 0 to PropValue.Count - 1 do
    Image.Add('  ' + PropValue[I]);
end;

{ TReadTranslator }
procedure TReadTranslator.DoTranslatePropString(Instance: TObject; const PropName: string;
  const OldPropValue: string; var NewPropValue: string);
var
  I, J: Integer;
  Tmp, PropPath: string;
begin
  if (NewPropValue = '') or (Instance is TComponent) and (CompareText(PropName, 'NAME') = 0) then Exit;
  PropValue.Text := OldPropValue;
  { Property path:Language:TransFlag:string count }
  {   string1 }
  {   string2 }
  PropPath := Format('%s%s%d%1:s%3:d', [TranslatePathProp(PropName), Delimeter, Language, PropValue.Count]);
  I := Image.IndexOf(PropPath) + 1;
  if I > 0 then
  begin
    for J := 0 to Min(Image.Count - I - 1, PropValue.Count - 1) do
    begin
      Tmp := Image[I + J];
      Delete(Tmp, 1, 2);
      PropValue[J] := Tmp
    end;
    NewPropValue := PropValue.Text;
    SetLength(NewPropValue, Length(NewPropValue) - 2);
  end;
end;

procedure CreateTranslateImage(Instance: TObject; ADelimeter: Char;
  Language: Integer; Image: TStrings);
begin
  with TWriteTranslator.CreateNew(Image, Language) do
  try
    Delimeter := ADelimeter;
    FImage.BeginUpdate;
    try
      TranslateProps(Instance);
    finally
      FImage.EndUpdate;
    end;
  finally
    Free;
  end;
end;

procedure CreateTranslateImageToFile(Instance: TObject; ADelimeter: Char;
  Language: Integer; const AFileName: TFileName);
var
  Image: TStrings;
begin
  Image := TStringList.Create;
  try
    CreateTranslateImage(Instance, ADelimeter, Language, Image);
    Image.SaveToFile(AFileName);
  finally
    Image.Free;
  end;
end;

procedure TranslateFromImage(Instance: TObject; ADelimeter: Char; Language: Integer; Image: TStrings);
begin
  with TReadTranslator.CreateNew(Image, Language) do
  try
    Delimeter := ADelimeter;
    TranslateProps(Instance);
  finally
    Free;
  end;
end;
procedure TranslateFromImageFile(Instance: TObject; ADelimeter: Char; Language: Integer; const AFileName: TFileName);
var
  Image: TStrings;
begin
  Image := TStringList.Create;
  try
    Image.LoadFromFile(AFileName);
    TranslateFromImage(Instance, ADelimeter, Language, Image);
  finally
    Image.Free;
  end;
end;

end.

