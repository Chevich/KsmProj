{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         vgUtils unit.                                 }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{ $D-,L-}

unit vgUtils;

interface
uses Windows, SysUtils, Classes, TypInfo;

type
  EMessage            = class(Exception);
  EWarningMessage     = class(EMessage);
  EInformationMessage = class(EMessage);
  EFileOperation      = class(Exception);

  TMessageProc = procedure(const Msg: string);
  TWriteLogProc = procedure(const FileName, Msg: string);

  TDayTable = array[1..12] of Word;
  PDayTable = ^TDayTable;

  PIntArray = ^TIntArray;
  TIntArray = array [0..0] of Integer;

  PVariantArray = ^TVariantArray;
  TVariantArray = array[0..0] of Variant;

  PInstance = ^HINST;

  TComponentCallback = procedure (Instance: TComponent; Data: Pointer);

  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;

{ --- Exceptions }
procedure CheckCondition(Condition: Boolean; EClass: ExceptClass; EMessage: string);
{ Raises exception if not Condition }

procedure InformationMessage(const Msg: string);
{ Raises EInformationMessage exception with message }

procedure WarningMessage(const Msg: string);
{ Raises EWarningMessage exception with message }

{ --- Math }
function Max(A, B: Integer): Integer;
function Min(A, B: Integer): Integer;
{ Returns min or max value accordinally }

function RangeCheck(Value, Min, Max: Integer): Integer;
{ Controls that Value betweeen Min and Max and increase or decrease Result accordinaly }

function RoundFloat(Value: Extended; Digits: Integer): Extended;
{ Rounds Value to Digits digits after decimal point }

function CompareFloat(Value1, Value2: Extended; Digits: Integer): Integer;
{ Compares two given values and returns result of comparision }
{ Return values are the same as in CompareText function       }

function IsEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
function IsAboveFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
function IsBehindFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
function IsAboveEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
function IsBehindEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
{ Compares two values up to Digits digits after decimal point }

function StrToFloatDef(const Value: string; Default: Extended): Extended;
{ Converts Value into extended. }

{ Memory blocks }
function CompareMem(P1, P2: Pointer; Length: Integer): Boolean;
{ Compares to blocks of memory }

{ --- String routines }
function Bin2Hex(Bytes: PChar; Count: Integer): string;
procedure Hex2Bin(Hex: string; Bytes: PChar; Count: Integer);
{ Converts binary buffer into string and backward }

procedure AddDelimeted(var S: string; const SubStr, Delimeter: string);
function GetListString(Fmt: string; Strings: TStrings): string;
function ExtractDelimeted(const S, Delimeter: string; var Pos: Integer): string;
function ExtractDelimetedWord(const S, Delimeter: string; Number: Integer; var Pos: Integer): string;
procedure GetDelimetedStrings(const S, Delimeter: string; List: TStrings);
function PosText(const SubStr, S: string): Integer;

{ --- Macro }
function ForEachString(Strings: TStrings; Separator, StringMacro, Macro: string): string;
{ Expands macro Macro for each string from Strings.           }
{ Expanded macroses are concatenated with Separator separator }
{ Each occurence of StringMacro in Macro string is replaced   }
{ by string from Strings.                                     }

{ --- Lists of objects }
function ListAdd(var List: TList; Item: Pointer): Pointer;
{ Adds Item to list List. If List is nil than calls TList constructor }

procedure ListClear(var List: TList);
{ Macro for ListDestroy }

function ListCount(List: TList): Integer;
{ Returns count of items in List or zero if List = nil }

function ListDelete(var List: TList; Index: Integer): Pointer;
{ Deletes from List. If List is empty than destroys List }

procedure ListDestroy(var List: TList);
{ Destroys List and set it to nil }

procedure ListDestroyAll(var List: TList);
{ Destroys all items from TList as they are TObject descendents and List object }

procedure ListDestroyObjects(List: TList);
{ Destroys all items from TList as they are TObject descendents }
{ and clears the List }

procedure ListDestroyObjectsAll(var List: TList);
{ ListDestroyAll macro }

procedure ListFreeMem(List: TList);
{ Destroys all items from TList as they pointers allocated with GetMem }
{ and clears the List }

procedure ListFreeMemAll(var List: TList);
{ Destroys all items from TList as they pointers allocated with GetMem }
{ and frees the List }

procedure ListError(Index: Integer);
{ raises EListError exception }

function ListIndexOf(List: TList; Item: Pointer): Integer;
{ Returns index of Item in List }

procedure ListInsert(var List: TList; Index: Integer; Item: Pointer);
{ Inserts Item in List }

function ListItem(List: TList; Index: Integer): Pointer;
{ Returns item of List raises exception if List = nil }

function ListRemove(var List: TList; Item: Pointer): Pointer;
{ Removes Item from List. If List is empty than destroys List }

function ListRemoveLast(var List: TList): Pointer;
{ Same as ListRemove, but removes last item from List }

procedure ListSort(List: TList; Compare: TListSortCompare);
{ Sorts given List }

{ --- string lists }
procedure StringsAssignTo(List: TStrings; Strings: Array of string);
procedure ArrayAssignTo(List: TStrings; Strings: Array of string);
{ Assings a strings from List to Strings elements and backward }


{ --- Components and streams }
function IsClass(AClass: TClass; ParentClass: TClass): Boolean;
{ Returns True if AClass is ParentClass descendent }

procedure RegisterComponent(Instance: TComponent);
{ Register component Instance and all their recursive childrens             }
{ through RegisterClass procedure to make sure it can be readed from stream }

procedure CopyProps(Src: TComponent; Dst: TComponent);
{ Copies Src component and all their recursive childrens to Dst component   }
{ Note that Src.Owner cannot be nil                                         }

function CreateCloneOwner(Src: TComponent; AOwner: TComponent): TComponent;
{ Creates a clone of Src component with the Owner AOwner }

function CreateClone(Src: TComponent): TComponent;
{ Creates a clone of Src component with the same Owner }

function CreateComponentOwnerNeeded(var Instance; ComponentClass: TComponentClass;
  AOwner: TComponent): TComponent;
{ Creates a component with Owner if Instance is not assigned yet }

function CreateComponentNeeded(var Instance; ComponentClass: TComponentClass): TComponent;
{ Creates a component without Owner if Instance is not assigned yet }

function CreateCloneOwnerNeeded(var Instance; Src: TComponent; AOwner: TComponent): TComponent;
{ Creates a clone of Src component with the Owner AOwner if Instance is not Assigned and returns Instance }

function CreateCloneNeeded(var Instance; Src: TComponent): TComponent;
{ Creates a clone of Src component with the Owner AOwner if Instance is not Assigned and returns Instance }

procedure FreeObject(var Obj);
{ Frees Obj and initialize it to zero }

procedure CopyMethodProps(Src, Dst: TObject);
{ Copies method properties from Src to Dst objects }

procedure ClearMethodProps(Src: TObject);
{ Clear methods properties at Src object }

function UniqueName(Instance: TComponent; Name: string; Owner: TComponent): string;
{ Returns unique name to component Instance to make sure it valid for Owner }

procedure WriteAndRead(Src: TComponent; Dst: TComponent); { obsolete }
{ Macro for CopyProps procedure }

{ --- For Each component }
procedure ForComponents(AComponents: array of TComponent;
  Callback: TComponentCallback; Data: Pointer);
{ ForEach Callback }

procedure ForEachComponent(Instance: TComponent;
  ComponentClass: TComponentClass; Callback: TComponentCallback; Data: Pointer; Children: Boolean);
{ Recurrent Callback }

{ --- IniFiles and logs }
function AppPathFileName(FileName: TFileName): TFileName;
{ Returns the file name concated from application path and FileName }

procedure WriteBoolean(const IniFile, IniSection, Ident: string; const Value: Boolean; UseRegistry: Boolean);
procedure WriteFloat(const IniFile, IniSection, Ident: string; const Value: Double; UseRegistry: Boolean);
procedure WriteInteger(const IniFile, IniSection, Ident: string; const Value: Integer; UseRegistry: Boolean);
procedure WriteString(const IniFile, IniSection, Ident, Value: string; UseRegistry: Boolean);

function ReadBoolean(const IniFile, IniSection, Ident: string; const DefValue: Boolean; UseRegistry: Boolean): Boolean;
function ReadFloat(const IniFile, IniSection, Ident: string; const DefValue: Double; UseRegistry: Boolean): Double;
function ReadInteger(const IniFile, IniSection, Ident: string; const DefValue: Integer; UseRegistry: Boolean): Integer;
function ReadString(const IniFile, IniSection, Ident, DefValue: string; UseRegistry: Boolean): string;
{ Writes/reads Value to or/from ini files or registry }

procedure AppWriteLog(const Msg: string);
{ Writes a Msg to file with file name AppFileName and .log extension }

procedure WriteLog(const FileName: TFileName; const Msg: string);
{ Writes a log message in the critical section      }
{ through WriteLogProc or DefaultWriteLog procedure }

function GetTempFileName(const Path: TFileName): string;
function BackupFile(const FileName: TFileName): Boolean;
procedure CheckBackupFile(const FileName: TFileName);
procedure CheckDeleteFile(const FileName: TFileName);
procedure CheckRenameFile(const OldName, NewName: TFileName);

procedure LoadComponent(const FileName: string; Instance: TComponent);
procedure SaveComponent(const FileName: string; Instance: TComponent);

function Win32Description: string;
{ Returns string like Windows NT 4.00 (Service Pack 3) }

procedure DefaultWriteLog(const FileName: TFileName; const Msg: string);
{ Writes a log message in file }

{ --- Variant }
function NvlInteger(V: Variant): Integer;
function NvlFloat(V: Variant): Double;
function NvlDateTime(V: Variant): TDateTime;
function NvlString(V: Variant): string;
{ Functions returns "zero" values when V is Null or   }
{ when V value is compatible with the function result }

function VarRecToVariant(VarRec: TVarRec): Variant;
{ Converts VarRec record into Variant }

function VarArrayFromConst(Args: array of const): Variant;
{ Converts array of const into Variant array with bounds 0, High(Args) }

function VarArrayFromConstCast(Args: array of const): Variant;
{ Converts array of pairs [Variant, Integer] into Variant array with bounds 0, High(Args) }
{ and casts each of elements to Integer varXXX }

function VarArrayCast(Values: Variant; Args: array of Integer): Variant;
{ Args is array of pairs [Index, varType]                       }
{ Function casts each Values[Index] to varType type             }

function VarArrayOfPairs(Args: array of const): Variant;
{ Args is array of pairs. Each pair converted into variant array. }
{ Result is variant array of variant arrays                       }

function VarArrayOfPairsCast(Values: Variant; Args: array of Integer): Variant;
{ Function casts second element of pair accordinally to Args }

function VarComparable(V1, V2: Variant): Boolean;
{ Returns true if V1 can be compared with V2 }

function VarIsEqual(V1, V2: Variant): Boolean;
{ Reruns true if V1 is comparable with V2 and equal }

procedure StringsFromVarArray(List: Variant; Strings: TStrings);
{ Converts array of Variant into list of strings }

function VarArrayFromStrings(Strings: TStrings): Variant;
{ Converts list of strings into Variant array }

procedure EnumStrings(List: TStrings; EnumProc: TGetStrProc);
{ Enums each elemnt of List }

procedure EnumVarArray(List: Variant; EnumProc: TGetStrProc);
{ Enums each elemnt of List }

type
  TVarFlag = (vfByRef, vfVariant);
  TVarFlags = set of TVarFlag;

procedure WriteVariant(Stream: TStream; const Value: Variant);
{ Writes Variant into stream }

function ReadVariant(Stream: TStream; var Flags: TVarFlags): Variant;
{ Reads Variant from stream }

function VariantToVarArray(const Value: Variant): Variant;
{ Converts Value into Variant array of bytes }

function VarArrayToVariant(const Value: Variant): Variant;
{ Converts Variant array of bytes into Variant }

{ --- Swap }
procedure SwapStrings(var Str1, Str2: string);
procedure SwapInteger(var Value1, Value2: Integer);

{ --- DateTime }
function IsLeapYear(Year: Word): Boolean;
function GetDayTable(Year: Word): PDayTable;

{ --- DLLs }
procedure PreloadLibraries(const DLLs: array of PChar; Handles: PInstance);
{ Loads DLL libraries in DLLs array for faster execution after startup }

procedure UnloadLibraries(Handles: PInstance; Count: Integer);
{ Frees DLL libraries loaded in PreloadLibraries procedure }

function RegisterServer(DLLName: string): Boolean;
{ Registers OLE server in filename DLLName and returns True if successfull }

{ --- VMT low-level }
function GetVirtualMethodAddress(AClass: TClass; AIndex: Integer): Pointer;
{ Returns address of virtual method of AClass with index AIndex }

function SetVirtualMethodAddress(AClass: TClass; AIndex: Integer;
  NewAddress: Pointer): Pointer;
{ Updates VMT of AClass and sets new method address of method with index AIndex }

function FindVirtualMethodIndex(AClass: TClass; MethodAddr: Pointer): Integer;
{ Iterates through VMT of AClass and seeks for method MethodAddr }

{ Misc }
function ResStr(Ident: {$IFDEF _D3_}string{$ELSE}Integer{$ENDIF}): string;
{ Macro for loading strings from resources }

{$IFDEF _D3_}
{ --- Resourcestring }
procedure StoreResString(P: PResStringRec);
{ Saves resourcestring information }

procedure RestoreResString(P: PResStringRec);
{ Restores resourcestring information }

procedure CopyResString(Source, Dest: PResStringRec; Store: Boolean);
{ Owerwrites resourcestring information to make Dest resourcesting   }
{ the same as Source                                                 }
{ Note that if Source and Dest are in different packages you should  }
{ always restore resourcestring information before unloading package }
{ that contains Source                                               }

{$ENDIF}

procedure GetEnvironment(Strings: TStrings);
{ Extracts environment strings and sets Strings as Values array }

const
  SEMAPHORE_MODIFY_STATE    =  $0002;
  SEMAPHORE_ALL_ACCESS      =  STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $0003;

{$IFNDEF _D3_}

  PROCESS_TERMINATE         =  $0001;
  PROCESS_CREATE_THREAD     =  $0002;
  PROCESS_VM_OPERATION      =  $0008;
  PROCESS_VM_READ           =  $0010;
  PROCESS_VM_WRITE          =  $0020;
  PROCESS_DUP_HANDLE        =  $0040;
  PROCESS_CREATE_PROCESS    =  $0080;
  PROCESS_SET_QUOTA         =  $0100;
  PROCESS_SET_INFORMATION   =  $0200;
  PROCESS_QUERY_INFORMATION =  $0400;
  PROCESS_ALL_ACCESS        =  STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or $0FFF;

{$ENDIF _D3_}

{ --- System }
function IsMainThread: Boolean;

function GetProcessHandle(ProcessID: DWORD): THandle;
{ Tryies to extract process handle from ProcessID         }

procedure BadVariantType(VType: Integer);
{ Raises EInvalidOp exception with SBadVariantType message }

{ --- TypInfo utilites }
procedure GetPropInfoList(List: TList; Instance: TObject; Filter: TTypeKinds);
{ Fills List with PPropInfo pointers }

var
  AppFileName      : string = '';
{ Variable used in Log procedures. Default is ParamStr(0) }

  InformationProc  : TMessageProc  = nil;
  WarningProc      : TMessageProc  = nil;

  WriteLogProc     : TWriteLogProc = nil;
{ When assigned, called by WriteLog procedure             }

  AppLogTimeout    : Integer       = 0;
{ Timeout for waiting for logfile to be opened }

const
  EasyArrayTypes = [varSmallInt, varInteger, varSingle, varDouble, varCurrency,
                    varDate, varBoolean, varByte];

  VariantSize: array[0..varByte] of Word  = (0, 0, SizeOf(SmallInt), SizeOf(Integer),
    SizeOf(Single), SizeOf(Double), SizeOf(Currency), SizeOf(TDateTime), 0, 0,
    SizeOf(Integer), SizeOf(WordBool), 0, 0, 0, 0, 0, SizeOf(Byte));

const
  IniFileExt       = '.ini';

implementation
uses Consts, vgVCLRes, {$IFDEF _D3_}ActiveX, ComObj{$ELSE}Ole2, OleAuto{$ENDIF},
  IniFiles, Registry, Math;

var
  FLogLock: TRTLCriticalSection;

procedure CheckCondition(Condition: Boolean; EClass: ExceptClass; EMessage: string);
begin
  if not Condition then raise EClass.Create(EMessage);
end;

procedure InformationMessage(const Msg: string);
begin
  if Assigned(InformationProc) then
    InformationProc(Msg) else raise EInformationMessage.Create(Msg);
end;

procedure WarningMessage(const Msg: string);
begin
  if Assigned(WarningProc) then
    WarningProc(Msg) else raise EWarningMessage.Create(Msg);
end;

function Max(A, B: Integer): Integer;
begin
  if A > B then Result := A else Result := B;
end;

function Min(A, B: Integer): Integer;
begin
  if A < B then Result := A else Result := B;
end;

function RangeCheck(Value, Min, Max: Integer): Integer;
begin
  if Value < Min then Result := Min
  else if Value > Max then Result := Max
  else Result := Value;
end;

function RoundFloat(Value: Extended; Digits: Integer): Extended;
var
  StrFmt: string;
begin
  StrFmt := '%.' + IntToStr(Digits) + 'f';
  Result := StrToFloat(Format(StrFmt, [Value]));
end;

function CompareFloat(Value1, Value2: Extended; Digits: Integer): Integer;
var
  Delta: Extended;
begin
  Value1 := Value1 - Value2;
  Delta := IntPower(1E1, - Digits);
  if Abs(Value1) <= Delta then Result := 0
  else if (Value1 > 0) then Result := 1
  else Result := -1;
end;

function IsEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
begin
  Result := CompareFloat(Value1, Value2, Digits) = 0;
end;

function IsAboveFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
begin
  Result := CompareFloat(Value1, Value2, Digits) = 1;
end;

function IsBehindFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
begin
  Result := CompareFloat(Value1, Value2, Digits) = -1;
end;

function IsAboveEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
begin
  Result := CompareFloat(Value1, Value2, Digits) >= 0;
end;

function IsBehindEqualFloat(Value1, Value2: Extended; Digits: Integer): Boolean;
begin
  Result := CompareFloat(Value1, Value2, Digits) <= 0;
end;

function StrToFloatDef(const Value: string; Default: Extended): Extended;
begin
  try
    Result := StrToFloat(Value);
  except
    on EConvertError do
      Result := Default
    else
      raise;
  end;
end;

function Bin2Hex(Bytes: PChar; Count: Integer): string;
var
  I: Integer;
begin
  Result := '';
  if Assigned(Bytes) then
  for I := 0 to Count - 1 do
    Result := Result + IntToHex(Byte((Bytes + I)^), 2);
end;

procedure Hex2Bin(Hex: string; Bytes: PChar; Count: Integer);
var
  I: Integer;
  C: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    C := StrToInt('$' + Copy(Hex, 1 + I * 2, 2));
    (PChar(Bytes) + I)^ := Chr(C);
  end;
end;

function CompareMem(P1, P2: Pointer; Length: Integer): Boolean; assembler;
{$IFNDEF _D3_}
asm
        PUSH    ESI
        PUSH    EDI
        MOV     ESI,P1
        MOV     EDI,P2
        MOV     EDX,ECX
        XOR     EAX,EAX
        AND     EDX,3
        SHR     ECX,1
        SHR     ECX,1
        REPE    CMPSD
        JNE     @@2
        MOV     ECX,EDX
        REPE    CMPSB
        JNE     @@2
@@1:    INC     EAX
@@2:    POP     EDI
        POP     ESI
end;
{$ELSE}
asm
        JMP     SysUtils.CompareMem
end;
{$ENDIF}

procedure AddDelimeted(var S: string; const SubStr, Delimeter: string);
begin
  if S <> '' then S := S + Delimeter;
  S := S + SubStr;
end;

function GetListString(Fmt: string; Strings: TStrings): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Strings.Count - 1 do
    Result := Result + Format(Fmt, [Strings[I]]);
end;

function ExtractDelimeted(const S, Delimeter: string; var Pos: Integer): string;
var
  Tmp: string;
  I: Integer;
begin
  Tmp := Copy(S, Pos, MaxInt);
  I := System.Pos(Delimeter, Tmp) - 1;
  if I >= 0 then
  begin
    Result := Trim(Copy(S, Pos, I));
    Pos := I + Length(Delimeter) + Pos;
  end else begin
    Result := Trim(Tmp);
    Pos := Length(S) + 1;
  end;
end;

function ExtractDelimetedWord(const S, Delimeter: string; Number: Integer; var Pos: Integer): string;
var
  Tmp: string;
begin
  while (Number > 0) and (Pos <= Length(S)) do
  begin
    Tmp := ExtractDelimeted(S, Delimeter, Pos);
    Dec(Number);
  end;
  if Number = 0 then Result := Tmp else Result := '';
end;

procedure GetDelimetedStrings(const S, Delimeter: string; List: TStrings);
var
  Pos: Integer;
begin
  Pos := 1;
  List.BeginUpdate;
  try
    while (Pos <= Length(S)) do
      List.Add(ExtractDelimeted(S, Delimeter, Pos));
  finally
    List.EndUpdate;
  end;
end;

function PosText(const SubStr, S: string): Integer;
begin
  Result := Pos(AnsiUpperCase(SubStr), AnsiUpperCase(S));
end;

function ForEachString(Strings: TStrings; Separator, StringMacro, Macro: string): string;
var
  I, Pos: Integer;
  S, Tmp: string;
begin
  Result := '';
  for I := 0 to Strings.Count - 1 do
  begin
    if I > 0 then Result := Result + Separator;
    S := Strings[I];
    Tmp := Macro;
    Pos := System.Pos(StringMacro, Tmp);
    while Pos > 0 do
    begin
      Delete(Tmp, Pos, Length(StringMacro));
      Insert(S, Tmp, Pos);
      Pos := System.Pos(StringMacro, Tmp);
    end;
    Result := Result + Tmp;
  end;
end;

function ListAdd(var List: TList; Item: Pointer): Pointer;
begin
  if List = nil then List := TList.Create;
  List.Add(Item);
  Result := Item;
end;

procedure ListClear(var List: TList);
begin
  ListDestroy(List);
end;

function ListCount(List: TList): Integer;
begin
  if Assigned(List) then Result := List.Count else Result := 0;
end;

function ListDelete(var List: TList; Index: Integer): Pointer;
begin
  Result := ListItem(List, Index);
  List.Delete(Index);
  if List.Count = 0 then ListDestroy(List);
end;

procedure ListDestroy(var List: TList);
begin
  if Assigned(List) then
  begin
    List.Free;
    List := nil;
  end;
end;

procedure ListDestroyAll(var List: TList);
begin
  if Assigned(List) then
  begin
    ListDestroyObjects(List);
    ListDestroy(List);
  end;
end;

procedure ListDestroyObjects(List: TList);
var
  P: TObject;
begin
  while ListCount(List) > 0 do
  begin
    P := List.Last;
    List.Delete(List.Count - 1);
    P.Free;
  end;
end;

procedure ListDestroyObjectsAll(var List: TList);
begin
  ListDestroyObjects(List);
  ListDestroy(List);
end;

procedure ListFreeMem(List: TList);
var
  P: Pointer;
begin
  while ListCount(List) > 0 do
  begin
    P := List.Last;
    List.Delete(List.Count - 1);
    FreeMem(P);
  end;
end;

procedure ListFreeMemAll(var List: TList);
begin
  ListFreeMem(List);
  ListDestroy(List);
end;

procedure ListSort(List: TList; Compare: TListSortCompare);
begin
  if Assigned(List) then List.Sort(Compare);
end;

procedure ListError(Index: Integer);
begin
{$IFDEF _D3_}
  TList.Error(SListIndexError, Index);
{$ELSE}
  raise EListError.CreateRes(SListIndexError);
{$ENDIF}
end;

function ListIndexOf(List: TList; Item: Pointer): Integer;
begin
  if Assigned(List) then Result := List.IndexOf(Item) else Result := -1;
end;

procedure ListInsert(var List: TList; Index: Integer; Item: Pointer);
begin
  if not Assigned(List) then List := TList.Create;
  List.Insert(Index, Item);
end;

function ListItem(List: TList; Index: Integer): Pointer;
begin
  if Assigned(List) then
    Result := List[Index]
  else begin
    Result := nil;
    ListError(Index);
  end;
end;

function ListRemove(var List: TList; Item: Pointer): Pointer;
var
  I: Integer;
begin
  if Assigned(List) then
  begin
    I := List.IndexOf(Item);
    if I >= 0 then
    begin
      Result := ListDelete(List, I);
      Exit;
    end;
  end;
  Result := nil;
end;

function ListRemoveLast(var List: TList): Pointer;
begin
  if Assigned(List) and (List.Count > 0) then
    Result := ListRemove(List, List.Last) else
    Result := nil;
end;

procedure StringsAssignTo(List: TStrings; Strings: Array of string);
var
  I: Integer;
begin
  List.BeginUpdate;
  try
    List.Clear;
    for I := Low(Strings) to High(Strings) do List.Add(Strings[I]);
  finally
    List.EndUpdate;
  end;
end;

procedure ArrayAssignTo(List: TStrings; Strings: Array of string);
var
  I: Integer;
begin
  for I := Low(Strings) to High(Strings) do
    if I < List.Count then Strings[I] := List[I] else Strings[I] := '';
end;

function IsClass(AClass: TClass; ParentClass: TClass): Boolean;
begin
  Result := False;
  while (AClass <> nil) do
  begin
    if AClass = ParentClass then
    begin
      Result := True;
      Break;
    end;
    AClass := AClass.ClassParent;
  end;
end;

type
  TClassRegistrator = class(TObject)
    procedure RegisterClass(Instance: TComponent);
  end;

  TComponentHack = class(TComponent)
  end;

  TSetNameHelper = class
    OldName: string;
    procedure SetName(Reader: TReader; Component: TComponent; var Name: string);
  end;

procedure TClassRegistrator.RegisterClass(Instance: TComponent);
begin
  Classes.RegisterClass(TComponentClass(Instance.ClassType));
  TComponentHack(Instance).GetChildren(Self.RegisterClass {$IFDEF _D3_}, nil {$ENDIF});
end;

procedure TSetNameHelper.SetName(Reader: TReader; Component: TComponent; var Name: string);
begin
  Name := UniqueName(Component, OldName, Component.Owner);
end;

procedure RegisterComponent(Instance: TComponent);
begin
  with TClassRegistrator.Create do
  try
    RegisterClass(Instance);
  finally
    Free;
  end;
end;

procedure CopyProps(Src: TComponent; Dst: TComponent);
var
  F: TStream;
  Reader: TReader;
  Writer: TWriter;
  NameHelper: TSetNameHelper;
  FOwner: TComponent;
begin
  F := TMemoryStream.Create;
  try
    Writer := TWriter.Create(F, 1024);
    try
      if Assigned(Src.Owner) then
        FOwner := Src.Owner else
        FOwner := Dst.Owner;
      Writer.Root := FOwner;
      Writer.WriteComponent(Src);
    finally
      Writer.Free;
    end;
    RegisterComponent(Src);
    F.Position := 0;
    Reader := TReader.Create(F, 1024);
    try
      NameHelper := TSetNameHelper.Create;
      try
        NameHelper.OldName := Dst.Name;
        Reader.Root := FOwner;
        Reader.OnSetName := NameHelper.SetName;
        Reader.BeginReferences;
        try
          Reader.ReadComponent(Dst);
          Reader.FixupReferences;
        finally
          Reader.EndReferences;
        end;
      finally
        NameHelper.Free;
      end;
    finally
      Reader.Free;
    end;
  finally
    F.Free;
  end;
end;

function CreateCloneOwner(Src: TComponent; AOwner: TComponent): TComponent;
begin
  Result := TComponentClass(Src.ClassType).Create(AOwner);
  try
    CopyProps(Src, Result);
  except
    Result.Free;
    raise;
  end;
end;

function CreateClone(Src: TComponent): TComponent;
begin
  Result := CreateCloneOwner(Src, Src.Owner)
end;

function CreateComponentOwnerNeeded(var Instance; ComponentClass: TComponentClass;
  AOwner: TComponent): TComponent;
begin
  if not Assigned(Pointer(Instance)) then
    TComponent(Instance) := ComponentClass.Create(AOwner);

  Result := TComponent(Instance);
end;

function CreateComponentNeeded(var Instance; ComponentClass: TComponentClass): TComponent;
begin
  Result := CreateComponentOwnerNeeded(Instance, ComponentClass, nil);
end;

function CreateCloneOwnerNeeded(var Instance; Src: TComponent; AOwner: TComponent): TComponent;
begin
  if not Assigned(Pointer(Instance)) then
    TComponent(Instance) := CreateCloneOwner(Src, AOwner);

  Result := TComponent(Instance)
end;

function CreateCloneNeeded(var Instance; Src: TComponent): TComponent;
begin
  Result := CreateCloneOwnerNeeded(Instance, Src, Src.Owner);
end;

procedure FreeObject(var Obj); assembler;
asm
  MOV     ECX, [EAX]
  TEST    ECX, ECX
  JE      @@exit
  PUSH    EAX
  MOV     EAX, ECX
  MOV     ECX, [EAX]
  MOV     DL,1
  CALL    dword ptr [ECX - 4] { vtDestroy }
  POP     EAX
  XOR     ECX, ECX
  MOV     [EAX], ECX
@@exit:
end;

procedure CopyMethodProps(Src, Dst: TObject);
var
  I, Count: Integer;
  PropList: PPropList;
  PropInfo: PPropInfo;
  Method: TMethod;
begin
  if not Dst.InheritsFrom(Src.ClassType) then Exit;
  PropList := nil;
  Count := GetTypeData(Src.ClassInfo)^.PropCount;
  try
    ReAllocMem(PropList, Count * SizeOf(Pointer));
    GetPropInfos(Src.ClassInfo, PropList);
    for I := 0 to Count - 1 do
    begin
      PropInfo := PropList^[I];
      if PropInfo^.PropType^.Kind = tkMethod then
      begin
        Method := GetMethodProp(Src, PropInfo);
        SetMethodProp(Dst, PropInfo, Method);
      end;
    end;
  finally
    ReAllocMem(PropList, 0);
  end;
end;

procedure ClearMethodProps(Src: TObject);
var I, Count: Integer;
    PropList: PPropList;
    PropInfo: PPropInfo;
    Method: TMethod;
begin
  PropList:=nil;
  Count:=GetTypeData(Src.ClassInfo)^.PropCount;
  try
    ReAllocMem(PropList,Count*SizeOf(Pointer));
    GetPropInfos(Src.ClassInfo, PropList);
    with Method do begin
      Code:=nil;
      Data:=nil;
    end;
    for i:=0 to Count-1 do begin
      PropInfo:=PropList^[I];
      if PropInfo^.PropType^.Kind =tkMethod then begin
        {Method:=GetMethodProp(Src, PropInfo);}
        SetMethodProp(Src, PropInfo, Method);
      end;
    end;
  finally
    ReAllocMem(PropList, 0);
  end;
end;

function UniqueName(Instance: TComponent; Name: string; Owner: TComponent): string;
var
  I: Integer;
  Tmp: TComponent;
begin
  I := 0;
  Result := Name;
  if Assigned(Owner) then
  begin
    Tmp := Owner.FindComponent(Result);
    if Assigned(Tmp) and (Tmp <> Instance) then
    while (Tmp <> nil) do
    begin
      Result := Format('%s_%d', [Name, I]);
      Inc(I);
      Tmp := Owner.FindComponent(Result);
    end;
  end else begin
    Result := '';
    if Assigned(FindGlobalComponent) then
    begin
      Result := Name;
      while FindGlobalComponent(Result) <> nil do
      begin
        Result := Format('%s_%d', [Name, I]);
        Inc(I);
      end;
    end;
  end;
end;

procedure WriteAndRead(Src: TComponent; Dst: TComponent);
begin
  CopyProps(Src, Dst);
end;

procedure ForComponents(AComponents: array of TComponent;
  Callback: TComponentCallback; Data: Pointer);
var
  I: Integer;
begin
  for I := Low(AComponents) to High(AComponents) do
    Callback(AComponents[I], Data);
end;

procedure ForEachComponent(Instance: TComponent;
  ComponentClass: TComponentClass; Callback: TComponentCallback; Data: Pointer; Children: Boolean);
var
  I: Integer;
  C: TComponent;
begin
  for I := 0 to Instance.ComponentCount - 1 do
  begin
    C := Instance.Components[I];
    if C is ComponentClass then Callback(C, Data);
    if Children then ForEachComponent(C, ComponentClass, Callback, Data, Children);
  end;
end;

function AppPathFileName(FileName: TFileName): TFileName;
begin
  if ExtractFilePath(FileName) = '' then
    Result := ExtractFilePath(AppFileName) + FileName else
    Result := FileName;
end;

procedure WriteBoolean(const IniFile, IniSection, Ident: string; const Value: Boolean; UseRegistry: Boolean);
begin
  WriteInteger(IniFile, IniSection, Ident, Integer(Value), UseRegistry);
end;

procedure WriteFloat(const IniFile, IniSection, Ident: string; const Value: Double; UseRegistry: Boolean);
begin
  WriteString(IniFile, IniSection, Ident, FloatToStr(Value), UseRegistry);
end;

procedure WriteInteger(const IniFile, IniSection, Ident: string; const Value: Integer; UseRegistry: Boolean);
begin
  WriteString(IniFile, IniSection, Ident, IntToStr(Value), UseRegistry);
end;

procedure WriteString(const IniFile, IniSection, Ident, Value: string; UseRegistry: Boolean);
  function WriteIni: TObject;
  begin
    Result := TIniFile.Create(AppPathFileName(IniFile) + IniFileExt);
    with TIniFile(Result) do
      WriteString(IniSection, Ident, Value);
  end;

  function WriteReg: TObject;
  begin
    Result := TRegIniFile.Create(IniFile);
    with TRegIniFile(Result) do
      WriteString(IniSection, Ident, Value);
  end;
var
  Obj: TObject;
begin
  Obj := nil;
  try
    if UseRegistry then
      Obj := WriteReg else
      Obj := WriteIni;
  finally
    Obj.Free;
  end;
end;

function ReadBoolean(const IniFile, IniSection, Ident: string; const DefValue: Boolean; UseRegistry: Boolean): Boolean;
begin
  Result := Boolean(ReadInteger(IniFile, IniSection, Ident, Integer(DefValue), UseRegistry));
end;

function ReadFloat(const IniFile, IniSection, Ident: string; const DefValue: Double; UseRegistry: Boolean): Double;
var
  S: string;
begin
  S := ReadString(IniFile, IniSection, Ident, FloatToStr(DefValue), UseRegistry);
  try
    Result := StrToFloat(S);
  except
    Result := DefValue;
  end;
end;

function ReadInteger(const IniFile, IniSection, Ident: string; const DefValue: Integer; UseRegistry: Boolean): Integer;
begin
  try
    Result := StrToInt(ReadString(IniFile, IniSection, Ident, IntToStr(DefValue), UseRegistry));
  except
    Result := DefValue;
  end;
end;

function ReadString(const IniFile, IniSection, Ident, DefValue: string; UseRegistry: Boolean): string;
var
  S: string;
  function ReadIni: TObject;
  begin
    Result := TIniFile.Create(AppPathFileName(IniFile) + IniFileExt);
    with TIniFile(Result) do
      S := ReadString(IniSection, Ident, DefValue);
  end;

  function ReadReg: TObject;
  begin
    Result := TRegIniFile.Create(IniFile);
    with TRegIniFile(Result) do
      S := ReadString(IniSection, Ident, DefValue);
  end;
var
  Obj: TObject;
begin
  Obj := nil;
  try
    if UseRegistry then
      Obj := ReadReg else
      Obj := ReadIni;
    Result := S;
  finally
    Obj.Free;
  end;
end;

procedure AppWriteLog(const Msg: string);
begin
  WriteLog(Copy(AppFileName, 1, Length(AppFileName) - 3) + 'log', Msg);
end;

procedure DefaultWriteLog(const FileName: TFileName; const Msg: string);
var
  Handle: THandle;
  S: TStream;
begin
  try
    Handle := CreateFile(PChar(FileName), GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
    if Handle <> INVALID_HANDLE_VALUE then
    try
      S := THandleStream.Create(Handle);
      try
        S.Position := S.Size;
        S.Write(PChar(Msg + #13#10)^, Length(Msg) + 2);
      finally
        S.Free;
      end;
    finally
      CloseHandle(Handle);
    end;
  except end;
end;

procedure WriteLog(const FileName: TFileName; const Msg: string);
var
  Tmp: string;
begin
  Tmp := DateTimeToStr(Now) + ' ' + Msg;
  EnterCriticalSection(FLogLock);
  try
    if Assigned(WriteLogProc) then
      WriteLogProc(FileName, Tmp)
    else
      DefaultWriteLog(FileName, Tmp);
  finally
    LeaveCriticalSection(FLogLock);
  end
end;

function GetTempFileName(const Path: TFileName): string;
var
  TmpFileName: array [0..MAX_PATH] of Char;
begin
  Windows.GetTempFileName(PChar(Path), PChar('tmp'), 0, TmpFileName);
  Result := StrPas(TmpFileName);
end;

function BackupFile(const FileName: TFileName): Boolean;
var
  BakFileName: string;
begin
  Result := True;
  if FileExists(FileName) then
  begin
    BakFileName := ChangeFileExt(FileName, '.bak');
    if FileExists(BakFileName) then
      Result := DeleteFile(BakFileName);
    if Result then
      Result := RenameFile(FileName, BakFileName);
  end;
end;

procedure CheckBackupFile(const FileName: TFileName);
var
  BakFileName: string;
begin
  if FileExists(FileName) then
  begin
    BakFileName := ChangeFileExt(FileName, '.bak');
    if FileExists(BakFileName) then
      CheckDeleteFile(BakFileName);
    CheckRenameFile(FileName, BakFileName);
  end;
end;

procedure CheckDeleteFile(const FileName: TFileName);
begin
  CheckCondition(DeleteFile(FileName), EFileOperation, FmtLoadStr(SCannotDeleteFile, [FileName]));
end;

procedure CheckRenameFile(const OldName, NewName: TFileName);
begin
  CheckCondition(RenameFile(OldName, NewName), EFileOperation, FmtLoadStr(SCannotRenameFile, [OldName, NewName]));
end;

procedure LoadComponent(const FileName: string; Instance: TComponent);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    Stream.ReadComponent(Instance);
  finally
    Stream.Free;
  end;
end;

procedure SaveComponent(const FileName: string; Instance: TComponent);
var
  TmpFileName: string;
  Stream: TStream;
begin
  TmpFileName := GetTempFileName(ExtractFilePath(AppFileName));
  try
    Stream := TFileStream.Create(TmpFileName, fmCreate);
    try
      Stream.WriteComponent(Instance);
    finally
      Stream.Free;
    end;
    CheckBackupFile(FileName);
    CheckRenameFile(TmpFileName, FileName);
  except
    DeleteFile(TmpFileName);
    raise;
  end;
end;

function Win32Description: string;
var
  Ver: TOsVersionInfo;
  S: string;
begin
  Ver.dwOSVersionInfoSize := SizeOf(Ver);
  GetVersionEx(Ver);
  with Ver do
  begin
    case dwPlatformId of
      VER_PLATFORM_WIN32_WINDOWS:
        S := 'Windows';
      VER_PLATFORM_WIN32_NT:
        S := 'Windows NT'
    else
        S := 'Win32s';
    end;
    Result := Format('%s %d.%.2d (%s)', [S, dwMajorVersion, dwMinorVersion, szCSDVersion]);
  end;
end;

function NvlInteger(V: Variant): Integer;
begin
  Result := 0;
  if not VarIsNull(V) then
  try
    Result := VarAsType(V, varInteger);
  except end;
end;

function NvlFloat(V: Variant): Double;
begin
  Result := 0;
  if not VarIsNull(V) then
  try
    Result := VarAsType(V, varDouble);
  except end;
end;

function NvlDateTime(V: Variant): TDateTime;
begin
  Result := 0;
  if not VarIsNull(V) then
  try
    Result := VarAsType(V, varDate);
  except end;
  if Result = 0 then Result := EncodeDate(1, 1, 1);
end;

function NvlString(V: Variant): string;
begin
  case TVarData(V).VType of
    varOleStr, varString: Result := V
  else
    Result := '';
  end;
end;

const
  VarTypesNumeric: array [0..5] of Integer = (varSmallInt, varInteger, varSingle, varDouble, varCurrency, varByte);
  VarTypesString:  array [0..1] of Integer = (varString, varOleStr);
  VarTypesNull:    array [0..0] of Integer = (varNull);
  VarTypesDate:    array [0..0] of Integer = (varDate);
  VarTypesBoolean: array [0..0] of Integer = (varBoolean);
  VarTypesEmpty:   array [0..0] of Integer = (varEmpty);

function VarComparable(V1, V2: Variant): Boolean;
  function IsType(VarType: Integer; VarTypes: array of Integer): Boolean;
  var
    I: Integer;
  begin
    for I := Low(VarTypes) to High(VarTypes) do
    begin
      Result := VarType = VarTypes[I];
      if Result then Exit;
    end;
    Result := False;
  end;
var
  Type1, Type2: Integer;
  function IsBothType(VarTypes: array of Integer): Boolean;
  begin
    Result := IsType(Type1, VarTypes) and IsType(Type2, VarTypes);
  end;
begin
  Type1 := TVarData(V1).VType; Type2 := TVarData(V2).VType;
  Result := (
    IsBothType(VarTypesNumeric) or IsBothType(VarTypesString) or
    IsBothType(VarTypesNull) or IsBothType(VarTypesDate) or
    IsBothType(VarTypesBoolean) or IsBothType(VarTypesEmpty));
end;

function VarIsEqual(V1, V2: Variant): Boolean;
begin
  Result := VarComparable(V1, V2) and (V1 = V2);
end;

function VarRecToVariant(VarRec: TVarRec): Variant;
begin
  with VarRec do case VType of
    vtInteger:    Result := VInteger;
    vtBoolean:    Result := VBoolean;
    vtChar:       Result := VChar;
    vtExtended:   Result := VExtended^;
    vtString:     Result := VString^;
    vtPChar:      Result := StrPas(VPChar);
    vtObject:     Result := VObject.ClassName;
    vtClass:      Result := VClass.ClassName;
    vtWideChar:   Result := VWideChar;
    vtPWideChar:  Result := VPWideChar^;
    vtAnsiString: Result := string(VAnsiString);
    vtCurrency:   Result := VCurrency^;
    vtVariant:    Result := VVariant^;
  {$IFDEF _D3_}
    vtInterface:  Result := IUnknown(VInterface);
    vtWideString: Result := WideString(VWideString);
  {$ENDIF}
  end;
end;

function VarArrayFromConst(Args: array of const): Variant;
var
  I: Integer;
begin
  if High(Args) = 0 then
    Result := VarRecToVariant(Args[0])
  else begin
    Result := VarArrayCreate([0, High(Args)], varVariant);
    for I := 0 to High(Args) do
      Result[I] := VarRecToVariant(Args[I]);
  end;
end;

function VarArrayFromConstCast(Args: array of const): Variant;
var
  I, Count: Integer;
begin
  Count := (High(Args) + 1) div 2;
  if Count <= 0 then
  begin
    Result := Null;
    Exit;
  end;
  if Count = 1 then
    Result := VarAsType(VarRecToVariant(Args[0]), Args[1].VInteger)
  else begin
    Result := VarArrayCreate([0, Count - 1], varVariant);
    for I := 0 to Count - 1 do
      Result[I] := VarAsType(VarRecToVariant(Args[I * 2]), Args[I * 2 + 1].VInteger)
  end;
end;

function VarArrayCast(Values: Variant; Args: array of Integer): Variant;
var
  I, Count: Integer;
begin
  Result := Values;
  Count := (High(Args) - Low(Args) + 1) div 2;
  for I := 0 to Count - 1 do
    Result[Args[I * 2]] := VarAsType(Result[Args[I * 2]], Args[I * 2 + 1])
end;

function VarArrayOfPairs(Args: array of const): Variant;
var
  V: Variant;
  I, Count: Integer;
begin
  Count := (High(Args) - Low(Args) + 1) div 2;
  Result := VarArrayCreate([0, Count - 1], varVariant);
  for I := 0 to Count - 1 do
  begin
    V := VarArrayCreate([0, 1], varVariant);
    V[0] := VarRecToVariant(Args[I * 2]);
    V[1] := VarRecToVariant(Args[I * 2 + 1]);
    Result[I] := V;
  end;
end;

function VarArrayOfPairsCast(Values: Variant; Args: array of Integer): Variant;
var
  V: Variant;
  I, Count: Integer;
begin
  Result := Values;
  Count := (High(Args) - Low(Args) + 1) div 2;
  for I := 0 to Count - 1 do
  begin
    V := Result[Args[I * 2]];
    V[1] := VarAsType(V[1], Args[I * 2 + 1]);
    Result[Args[I * 2]] := V;
  end;
end;

procedure StringsFromVarArray(List: Variant; Strings: TStrings);
var
  I: Integer;
begin
  Strings.BeginUpdate;
  try
    Strings.Clear;
    if VarIsArray(List) and (VarArrayDimCount(List) = 1) then
      for I := VarArrayLowBound(List, 1) to VarArrayHighBound(List, 1) do
        Strings.Add(List[I]);
  finally
    Strings.EndUpdate;
  end;
end;

function VarArrayFromStrings(Strings: TStrings): Variant;
var
  I: Integer;
begin
  Result := Null;
  if Strings.Count > 0 then
  begin
    Result := VarArrayCreate([0, Strings.Count - 1], varOleStr);
    for I := 0 to Strings.Count - 1 do Result[I] := VarAsType(Strings[I], varOleStr);
  end;
end;

procedure EnumStrings(List: TStrings; EnumProc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to List.Count - 1 do EnumProc(List[I]);
end;

procedure EnumVarArray(List: Variant; EnumProc: TGetStrProc);
var
  S: TStrings;
begin
  S := TStringList.Create;
  try
    StringsFromVarArray(List, S);
    EnumStrings(S, EnumProc);
  finally
    S.Free;
  end;
end;

procedure BadVariantType(VType: Integer);
begin
  raise EInvalidOp.CreateFmt(LoadStr(SBadVariantType), [IntToHex(VType, 4)]);
end;

procedure WriteArray(Stream: TStream; const Value: Variant);
var
  VType, VSize, i, DimCount, ElemSize: Integer;
  VarArrayPtr: PSafeArray;
  LoDim, HiDim, Indices: PIntArray;
  V: Variant;
  P: Pointer;
begin
  VType := VarType(Value);
  Stream.WriteBuffer(VType, SizeOf(Integer));
  DimCount := VarArrayDimCount(Value);
  Stream.WriteBuffer(DimCount, SizeOf(DimCount));
  VarArrayPtr := PSafeArray(TVarData(Value).VArray);
  VSize := SizeOf(Integer) * DimCount;
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      for i := 1 to DimCount do
      begin
        LoDim[i - 1] := VarArrayLowBound(Value, i);
        HiDim[i - 1] := VarArrayHighBound(Value, i);
      end;
      Stream.WriteBuffer(LoDim^,VSize);
      Stream.WriteBuffer(HiDim^,VSize);
      if VType and varTypeMask in EasyArrayTypes then
      begin
        ElemSize := SafeArrayGetElemSize(VarArrayPtr);
        VSize := 1;
        for i := 0 to DimCount - 1 do
          VSize := (HiDim[i] - LoDim[i] + 1) * VSize;
        VSize := VSize * ElemSize;
        P := VarArrayLock(Value);
        try
          Stream.WriteBuffer(VSize, SizeOf(VSize));
          Stream.WriteBuffer(P^,VSize);
        finally
          VarArrayUnlock(Value);
        end;
      end else
      begin { For varOleStr and varVariant }
        GetMem(Indices, VSize);
        try
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            if VType and varTypeMask <> varVariant then
            begin
              OleCheck(SafeArrayGetElement(VarArrayPtr, Indices^, TVarData(V).VPointer));
              TVarData(V).VType := VType and varTypeMask;
            end else
              OleCheck(SafeArrayGetElement(VarArrayPtr, Indices^, V));
            WriteVariant(Stream, V);
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

procedure WriteVariant(Stream: TStream; const Value: Variant);
var
  I, VType: Integer;
  S: string;
begin
  VType := VarType(Value);
  if VarIsArray(Value) then
    WriteArray(Stream, Value) else
  case (VType and varTypeMask) of
    varEmpty, varNull: Stream.WriteBuffer(VType, SizeOf(Integer));
    varString:
    begin
      S := Value;
      I := Length(S);
      Stream.WriteBuffer(VType, SizeOf(Integer));
      Stream.WriteBuffer(I, SizeOf(Integer));
      Stream.WriteBuffer(TVarData(Value).VString^, I);
    end;
    varOleStr:
    begin
      S := Value;
      I := Length(S);
      Stream.WriteBuffer(VType, SizeOf(Integer));
      Stream.WriteBuffer(I, SizeOf(Integer));
      Stream.WriteBuffer(TVarData(Value).VOleStr^, I * 2);
    end;
    varDispatch:
      BadVariantType(VType);
    varVariant:
    begin
      if VType and varByRef <> varByRef then BadVariantType(VType);
      i := varByRef;
      Stream.WriteBuffer(i, SizeOf(Integer));
      WriteVariant(Stream, Variant(TVarData(Value).VPointer^));
    end;
    varUnknown:
      BadVariantType(VType);
  else
    Stream.WriteBuffer(VType, SizeOf(Integer));
    if VType and varByRef = varByRef then
      Stream.WriteBuffer(TVarData(Value).VPointer^, VariantSize[VType and varTypeMask]) else
      Stream.WriteBuffer(TVarData(Value).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

function ReadArray(Stream: TStream; VType: Integer): Variant;
var
  Flags: TVarFlags;
  LoDim, HiDim, Indices, Bounds: PIntArray;
  DimCount, VSize, i: Integer;
  P: Pointer;
  V: Variant;
  VarArrayPtr: PSafeArray;
begin
  Stream.ReadBuffer(DimCount, SizeOf(DimCount));
  VSize := DimCount * SizeOf(Integer);
  GetMem(LoDim, VSize);
  try
    GetMem(HiDim, VSize);
    try
      Stream.ReadBuffer(LoDim^, VSize);
      Stream.ReadBuffer(HiDim^, VSize);
      GetMem(Bounds, VSize * 2);
      try
        for i := 0 to DimCount - 1 do
        begin
          Bounds[i * 2] := LoDim[i];
          Bounds[i * 2 + 1] := HiDim[i];
        end;
        Result := VarArrayCreate(Slice(Bounds^,DimCount * 2), VType and varTypeMask);
      finally
        FreeMem(Bounds);
      end;
      VarArrayPtr := PSafeArray(TVarData(Result).VArray);
      if VType and varTypeMask in EasyArrayTypes then
      begin
        Stream.ReadBuffer(VSize, SizeOf(VSize));
        P := VarArrayLock(Result);
        try
          Stream.ReadBuffer(P^, VSize);
        finally
          VarArrayUnlock(Result);
        end;
      end else
      begin { For varVariant and varOleStr }
        GetMem(Indices, VSize);
        try
          FillChar(Indices^, VSize, 0);
          for I := 0 to DimCount - 1 do
            Indices[I] := LoDim[I];
          while True do
          begin
            V := ReadVariant(Stream, Flags);
            if VType and varTypeMask = varVariant then
              OleCheck(SafeArrayPutElement(VarArrayPtr, Indices^, V)) else
              OleCheck(SafeArrayPutElement(VarArrayPtr, Indices^, TVarData(V).VPointer^));
            Inc(Indices[DimCount - 1]);
            if Indices[DimCount - 1] > HiDim[DimCount - 1] then
              for i := DimCount - 1 downto 0 do
                if Indices[i] > HiDim[i] then
                begin
                  if i = 0 then Exit;
                  Inc(Indices[i - 1]);
                  Indices[i] := LoDim[i];
                end;
          end;
        finally
          FreeMem(Indices);
        end;
      end;
    finally
      FreeMem(HiDim);
    end;
  finally
    FreeMem(LoDim);
  end;
end;

function ReadVariant(Stream: TStream; var Flags: TVarFlags): Variant;
var
  I, VType: Integer;
  S: string;
  TmpFlags: TVarFlags;
{$IFNDEF _D3_}
  W: PWideChar;
{$ELSE}
  W: WideString;
{$ENDIF}
begin
  Flags := [];
  Stream.ReadBuffer(VType, SizeOf(VType));
  if VType and varByRef = varByRef then Include(Flags, vfByRef);
  { special case for varVariant byRef }
  if VType = varByRef then
  begin
    Include(Flags, vfVariant);
    Result := ReadVariant(Stream, TmpFlags);
    Exit;
  end;
  if vfByRef in Flags then VType := VType xor varByRef;
  if (VType and varArray) = varArray then
    Result := ReadArray(Stream, VType) else
  case VType and varTypeMask of
    varEmpty: VarClear(Result);
    varNull: Result := NULL;
    varString:
    begin
      Stream.ReadBuffer(I, SizeOf(Integer));
      SetLength(S, I);
      Stream.ReadBuffer(S[1], I);
      Result := S;
    end;
    varOleStr:
    begin
      Stream.ReadBuffer(I, SizeOf(Integer));
      {$IFNDEF _D3_}
      W := SysAllocStringLen(nil, I);
      try
        Stream.ReadBuffer(W^, I * 2);
        TVarData(Result).VType := varOleStr;
        TVarData(Result).VOleStr := W;
      except
        SysFreeString(W);
        raise;
      end;
      {$ELSE}
      SetLength(W, I);
      Stream.ReadBuffer(W[1], I * 2);
      Result := W;
      {$ENDIF}
    end;
    varDispatch, varUnknown:
      BadVariantType(VType);
  else
    TVarData(Result).VType := VType;
    Stream.ReadBuffer(TVarData(Result).VPointer, VariantSize[VType and varTypeMask]);
  end;
end;

function VariantToVarArray(const Value: Variant): Variant;
var
  Data: PChar;
  F: TMemoryStream;
begin
  F := TMemoryStream.Create;
  try
    WriteVariant(F, Value);
    Result := VarArrayCreate([0, F.Size - 1], varByte);
    Data := VarArrayLock(Result);
    try
      Move(F.Memory^, Data^, F.Size);
    finally
      VarArrayUnlock(Result);
    end;
  finally
    F.Free;
  end;
end;

function VarArrayToVariant(const Value: Variant): Variant;
var
  F: TMemoryStream;
  TmpFlags: TVarFlags;
  Data: Pointer;
begin
  F := TMemoryStream.Create;
  try
    Data := VarArrayLock(Value);
    try
      F.WriteBuffer(Data^, VarArrayHighBound(Value, 1) - VarArrayLowBound(Value, 1) + 1);
    finally
      VarArrayUnlock(Value);
    end;
    F.Position := 0;
    Result := ReadVariant(F, TmpFlags);
  finally
    F.Free;
  end;
end;

procedure SwapStrings(var Str1, Str2: string);
var
  Tmp: string;
begin
  Tmp := Str1; Str1 := Str2; Str2 := Tmp;
end;

procedure SwapInteger(var Value1, Value2: Integer);
var
  Tmp: Integer;
begin
  Tmp := Value1;
  Value1 := Value2;
  Value2 := Tmp;
end;

function IsLeapYear(Year: Word): Boolean;
begin
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

function GetDayTable(Year: Word): PDayTable;
const
  DayTable1: TDayTable = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  DayTable2: TDayTable = (31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
  DayTables: array[Boolean] of PDayTable = (@DayTable1, @DayTable2);
begin
  Result := DayTables[IsLeapYear(Year)];
end;

procedure PreloadLibraries(const DLLs: array of PChar; Handles: PInstance);
var
  I: Integer;
  Handle: HINST;
begin
  for I := Low(DLLs) to High(DLLs) do
  begin
    Handle := LoadLibrary(DLLs[I]);
    Handles^ := Handle;
    Inc(LongInt(Handles), SizeOf(HINST));
  end;
end;

procedure UnloadLibraries(Handles: PInstance; Count: Integer);
var
  I: Integer;
  Handle: HINST;
begin
  for I := 0 to Count - 1 do
  begin
    Handle := Handles^;
    if Handle <> 0 then
      FreeLibrary(Handle);
    Inc(LongInt(Handles), SizeOf(HINST));
  end;
end;

function RegisterServer(DLLName: string): Boolean;
var
  Handle: THandle;
  DllRegServ: procedure;
begin
  Result := False;
  try
    Handle := LoadLibrary(PChar(DLLName));
    if Handle >= HINSTANCE_ERROR then
    try
      DllRegServ := GetProcAddress(Handle, 'DllRegisterServer');
      if Assigned(DllRegServ) then
      begin
        DllRegServ;
        Result := True;
      end;
    finally
      FreeLibrary(Handle);
    end;
  except
    Result := False;
  end;
end;

{ Copied from RxLib }
{ SetVirtualMethodAddress procedure. Destroy destructor has index 0,
  first user defined virtual method has index 1. }

type
  PPointer = ^Pointer;

function GetVirtualMethodAddress(AClass: TClass; AIndex: Integer): Pointer;
var
  Table: PPointer;
begin
  Table := PPointer(AClass);
  Inc(Table, AIndex - 1);
  Result := Table^;
end;

function SetVirtualMethodAddress(AClass: TClass; AIndex: Integer;
  NewAddress: Pointer): Pointer;
const
  PageSize = SizeOf(Pointer);
var
  Table: PPointer;
  SaveFlag: DWORD;
begin
  Table := PPointer(AClass);
  Inc(Table, AIndex - 1);
  Result := Table^;
  if VirtualProtect(Table, PageSize, PAGE_EXECUTE_READWRITE, @SaveFlag) then
  try
    Table^ := NewAddress;
  finally
    VirtualProtect(Table, PageSize, SaveFlag, @SaveFlag);
  end;
end;

function FindVirtualMethodIndex(AClass: TClass; MethodAddr: Pointer): Integer;
begin
  Result := 0;
  repeat
    Inc(Result);
  until (GetVirtualMethodAddress(AClass, Result) = MethodAddr);
end;

function ResStr(Ident: {$IFDEF _D3_}string{$ELSE}Integer{$ENDIF}): string;
begin
{$IFDEF _D3_}
  Result := Ident;
{$ELSE}
  Result := LoadStr(Ident);
{$ENDIF}
end;

{$IFDEF _D3_}
type
  PStoredResStringData = ^TStoredResStringData;
  TStoredResStringData = record
    Addr: Pointer;
    Data: TResStringRec;
  end;

var
  StoredResStrings: TList = nil;

function FindStoredResStringData(P: PResStringRec): PStoredResStringData;
var
  I: Integer;
begin
  if Assigned(StoredResStrings) then
  begin
    for I := 0 to StoredResStrings.Count - 1 do
    begin
      Result := StoredResStrings[I];
      if Result^.Addr = P then Exit;
    end;
  end;
  Result := nil;
end;

procedure StoreResString(P: PResStringRec);
var
  Tmp: PStoredResStringData;
begin
  if not Assigned(FindStoredResStringData(P)) then
  begin
    GetMem(Tmp, SizeOf(TStoredResStringData));
    try
      Tmp^.Addr := P;
      Move(P^, Tmp^.Data, SizeOf(TResStringRec));
    except
      FreeMem(Tmp);
      raise;
    end;
    ListAdd(StoredResStrings, Tmp);
  end;
end;

procedure RestoreResString(P: PResStringRec);
var
  Tmp: PStoredResStringData;
begin
  Tmp := FindStoredResStringData(P);
  if Assigned(Tmp) then
  begin
    CopyResString(@Tmp^.Data, P, False);
    ListRemove(StoredResStrings, Tmp);
    FreeMem(Tmp);
  end;
end;

procedure FreeStoredResStrings;
var
  I: Integer;
  Tmp: PStoredResStringData;
begin
  if Assigned(StoredResStrings) then
  begin
    for I := StoredResStrings.Count - 1 downto 0 do
    begin
      Tmp := StoredResStrings[I];
      RestoreResString(Tmp^.Addr);
    end;
  end;
end;

procedure CopyResString(Source, Dest: PResStringRec; Store: Boolean);
var
  SaveFlag: Integer;
begin
  if VirtualProtect(Dest, SizeOf(TResStringRec), PAGE_READWRITE, @SaveFlag) then
  try
    if Store then StoreResString(Dest);
    Move(Source^, Dest^, SizeOf(TResStringRec));
  finally
    VirtualProtect(Dest, SizeOf(TResStringRec), SaveFlag, @SaveFlag);
  end;
end;
{$ENDIF}

procedure GetEnvironment(Strings: TStrings);
var
  P: PChar;
  I: Integer;
begin
  P := GetEnvironmentStrings;
  try
    Strings.BeginUpdate;
    try
      while P^ <> #0 do
      begin
        I := Pos('=', P);
        Strings.Values[Copy(P, 1, I - 1)] := Copy(P, I + 1, 255);
        P := P + StrLen(P) + 1;
      end;
    finally
      Strings.EndUpdate;
    end;
  finally
    FreeEnvironmentStrings(P);
  end;
end;

function IsMainThread: Boolean;
begin
 Result := GetCurrentThreadID = MainThreadID;
end;

function GetProcessHandle(ProcessID: DWORD): THandle;
begin
  Result := OpenProcess(PROCESS_ALL_ACCESS, True, ProcessID);
end;

procedure GetPropInfoList(List: TList; Instance: TObject; Filter: TTypeKinds);
var
  Count: Integer;
begin
  List.Clear;
  try
    Count := GetPropList(Instance.ClassInfo, Filter, nil);
    List.Count := Count;
    GetPropList(Instance.ClassInfo, Filter, PPropList(List.List));
  except
    List.Clear;
    raise;
  end;
end;

initialization
  InitializeCriticalSection(FLogLock);
  AppFileName := ParamStr(0);

finalization
  DeleteCriticalSection(FLogLock);
{$IFDEF _D3_}
  FreeStoredResStrings;
{$ENDIF}

end.
