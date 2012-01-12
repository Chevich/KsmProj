{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         OLE Automation                                }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgOleUtl;

interface
uses Windows, Classes, OleConst, SysUtils,
  {$IFDEF _D3_} ActiveX, ComObj {$ELSE} Ole2, OleAuto {$ENDIF};

type
{ TDispInvokeCache }
  TDispInvokeCache = class
  private
    FDispatch: IDispatch;
    FEntries: TList;
    function FindDispIDs(ANames: PChar; ANameCount: Integer): Integer;
    function GetDispIDs(Names: PChar; NameCount: Integer; DispIDs: PDispIDList): Boolean;
    procedure UpdateCache(Names: PChar; NameCount: Integer; DispIDs: PDispIDList);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearCache;
    procedure Reset(Instance: Variant);
    procedure Copy(Cache: TDispInvokeCache);
    procedure Read(Stream: TStream);
    procedure Write(Stream: TStream);
    property Instance: IDispatch read FDispatch;
  end;

const
  MaxDispArgs = 32;
  DefLocale   = (LANG_ENGLISH + SUBLANG_DEFAULT * 1024) + (SORT_DEFAULT shl 16);

type
  TNames      = array [0..1023] of Char;
  PDispIDs    = ^TDispIDs;
  TDispIDs    = array [0..MaxDispArgs - 1] of TDispID;

procedure WideCharToNames(Names: PChar; NameCount: Byte; var WideNames: TNames; var Size: Word);

function VarToDispatch(Instance: Variant): IDispatch;

function VarToInterface(Instance: Variant): IDispatch;

procedure GetIDsOfNames(const Dispatch: IDispatch; Names: PChar; NameCount: Integer; DispIDs: Pointer);

procedure VarDispInvoke(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl;

procedure DispatchInvoke(const Dispatch: IDispatch; DispIDs: PDispIDList;
  CallDesc: PCallDesc; Params: Pointer; Result: PVariant);

procedure InitHook;
procedure DoneHook;

implementation
uses vgUtils;

type
  PDispInvokeEntry = ^TDispInvokeEntry;
  TDispInvokeEntry = record
    Size: Word;
    Names: TNames;
    Count: Byte;
    DispIDs: TDispIDs;
  end;

procedure WideCharToNames(Names: PChar; NameCount: Byte; var WideNames: TNames; var Size: Word);
var
  I, N: Integer;
  Ch: WideChar;
begin
  I := 0;
  N := 0;
  Size := 0;
  repeat
    repeat
      Ch := WideChar(Names[I]);
      WideNames[I] := Char(Ch);
      Inc(Size);
      Inc(I);
    until Char(Ch) = #0;
    Inc(N);
  until N = NameCount;
end;

function VarToDispatch(Instance: Variant): IDispatch;
begin
  if TVarData(Instance).VType = varDispatch then
    Result := IDispatch(TVarData(Instance).VDispatch)
  else if TVarData(Instance).VType = (varDispatch or varByRef) then
    Result := IDispatch(TVarData(Instance).VPointer^)
  else
    Result := nil;
end;

function VarToInterface(Instance: Variant): IDispatch;
begin
  Result := VarToDispatch(Instance);
  if not Assigned(Result) then
    raise EOleError.Create(ResStr(SVarNotObject));
end;

var
  FCacheList: TList = nil;
  Hooked: Boolean = False;
  OldVarDispProc: Pointer;

procedure InitHook;
begin
  if not Hooked then
  begin
    OldVarDispProc := VarDispProc;
    VarDispProc := @VarDispInvoke;
    Hooked := True;
  end;
end;

procedure DoneHook;
begin
  if Hooked then
  begin
    VarDispProc := OldVarDispProc;
    Hooked := False;
  end;
end;

procedure GetIDsOfNamesInternal(const Dispatch: IDispatch; Names: PChar;
  NameCount: Integer; DispIDs: Pointer);

  procedure Error;
  begin
    raise EOleError.CreateFmt(ResStr(SNoMethod), [Names]);
  end;

{$IFDEF _D3_ }
type
  PNamesArray = ^TNamesArray;
  TNamesArray = array[0..MaxDispArgs - 1] of PWideChar;
var
  N, SrcLen, DestLen: Integer;
  Src: PChar;
  Dest: PWideChar;
  NameRefs: PNamesArray;
  StackTop: Pointer;
  Temp: {$IFDEF _D4_} HResult {$ELSE} Integer {$ENDIF};
begin
  Src := Names;
  N := 0;
  asm
    MOV  StackTop, ESP
    MOV  EAX, NameCount
    INC  EAX
    SHL  EAX, 2  // sizeof pointer = 4
    SUB  ESP, EAX
    LEA  EAX, NameRefs
    MOV  [EAX], ESP
  end;
  repeat
    SrcLen := StrLen(Src);
    DestLen := MultiByteToWideChar(0, 0, Src, SrcLen, nil, 0) + 1;
    asm
      MOV  EAX, DestLen
      ADD  EAX, EAX
      ADD  EAX, 3      // round up to 4 byte boundary
      AND  EAX, not 3
      SUB  ESP, EAX
      LEA  EAX, Dest
      MOV  [EAX], ESP
    end;
    if N = 0 then NameRefs[0] := Dest else NameRefs[NameCount - N] := Dest;
    MultiByteToWideChar(0, 0, Src, SrcLen, Dest, DestLen);
    Dest[DestLen-1] := #0;
    Inc(Src, SrcLen+1);
    Inc(N);
  until N = NameCount;

  Temp := Dispatch.GetIDsOfNames(GUID_NULL, NameRefs, NameCount, DefLocale, DispIDs);

  if Temp = DISP_E_UNKNOWNNAME then Error else OleCheck(Temp);
  asm
    MOV  ESP, StackTop
  end;
end;

{$ELSE}

var
  I, N: Integer;
  Ch: WideChar;
  P: PWideChar;
  NameRefs: array[0..MaxDispArgs - 1] of PWideChar;
  WideNames: array[0..1023] of WideChar;
begin
  I := 0;
  N := 0;
  repeat
    P := @WideNames[I];
    if N = 0 then NameRefs[0] := P else NameRefs[NameCount - N] := P;
    repeat
      Ch := WideChar(Names[I]);
      WideNames[I] := Ch;
      Inc(I);
    until Char(Ch) = #0;
    Inc(N);
  until N = NameCount;

  if Dispatch.GetIDsOfNames(GUID_NULL, @NameRefs, NameCount,
    DefLocale, DispIDs) <> 0 then Error;
end;
{$ENDIF}

function FindCache(Dispatch: IDispatch): TDispInvokeCache;
var
  I: Integer;
begin
  if Assigned(FCacheList) then
    for I := 0 to FCacheList.Count - 1 do
    begin
      Result := FCacheList[I];
      if Result.FDispatch = Dispatch then Exit;
    end;
  Result := nil;
end;

procedure GetIDsOfNames(const Dispatch: IDispatch; Names: PChar; NameCount: Integer; DispIDs: Pointer);
var
  Cache: TDispInvokeCache;
begin
  Cache := FindCache(Dispatch);
  if not (Assigned(Cache) and Cache.GetDispIDs(Names, NameCount, DispIDs)) then
  begin
    GetIDsOfNamesInternal(Dispatch, Names, NameCount, DispIDs);

    if Assigned(Cache) then
      Cache.UpdateCache(Names, NameCount, DispIDs);
  end;
end;

procedure DispatchInvoke(const Dispatch: IDispatch; DispIDs: PDispIDList;
  CallDesc: PCallDesc; Params: Pointer; Result: PVariant);
begin
{$IFDEF _D3_}
  ComObj.DispatchInvoke(Dispatch, CallDesc, DispIDs, Params, Result);
{$ELSE}
  OleAuto.DispInvoke(Dispatch, CallDesc, DispIDs, Params, Result);
{$ENDIF}
end;

procedure VarDispInvoke(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl;
var
  Dispatch: IDispatch;
  DispIDs: array[0..MaxDispArgs - 1] of Integer;
begin
  Dispatch := VarToInterface(Instance);

  GetIDsOfNames(Dispatch, @CallDesc^.ArgTypes[CallDesc^.ArgCount],
    CallDesc^.NamedArgCount + 1, @DispIDs);

  if Result <> nil then VarClear(Result^);

  DispatchInvoke(IDispatch(Dispatch), @DispIDs, CallDesc, @Params, Result);
end;

{ TDispInvokeCache }
constructor TDispInvokeCache.Create;
begin
  ListAdd(FCacheList, Self);
  InitHook;
end;

destructor TDispInvokeCache.Destroy;
begin
  Reset(Null);
  ListRemove(FCacheList, Self);
  inherited;
end;

procedure TDispInvokeCache.ClearCache;
begin
  ListFreeMemAll(FEntries);
end;

function TDispInvokeCache.FindDispIDs(ANames: PChar; ANameCount: Integer): Integer;
var
  P: PDispInvokeEntry;
  I: Integer;
  Size: Word;
  Names: TNames;
begin
  Result := -1;
  if Assigned(FEntries) then
  begin
    WideCharToNames(ANames, ANameCount, Names, Size);
    for I := 0 to FEntries.Count - 1 do
    begin
      P := FEntries[I];
      if (Size = P^.Size) and (CompareMem(@P^.Names, @Names, Size)) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TDispInvokeCache.GetDispIDs(Names: PChar; NameCount: Integer; DispIDs: PDispIDList): Boolean;
var
  P: PDispInvokeEntry;
  I: Integer;
begin
  I := FindDispIDs(Names, NameCount);
  if (I >= 0) then
  begin
    P := FEntries[I];
    Move(P^.DispIDs, DispIDs^, SizeOf(TDispIDs));
    Result := True;
  end else
    Result := False;
end;

procedure TDispInvokeCache.UpdateCache(Names: PChar; NameCount: Integer; DispIDs: PDispIDList);
var
  P: PDispInvokeEntry;
begin
  GetMem(P, SizeOf(TDispInvokeEntry));
  try
    WideCharToNames(Names, NameCount, P^.Names, P^.Size);
    P^.Count := NameCount;
    Move(DispIDs^, P^.DispIDs, SizeOf(TDispIDs));
    ListAdd(FEntries, P);
  except
    FreeMem(P);
    raise;
  end;
end;

procedure TDispInvokeCache.Reset(Instance: Variant);
begin
  ClearCache;
  FDispatch := VarToDispatch(Instance);
end;

procedure TDispInvokeCache.Copy(Cache: TDispInvokeCache);
var
  F: TStream;
begin
  F := TMemoryStream.Create;
  try
    Cache.Write(F);
    F.Position := 0;
    Read(F);
  finally
    F.Free;
  end;
end;

procedure TDispInvokeCache.Read(Stream: TStream);
var
  P: PDispInvokeEntry;
  I, Count: Integer;
begin
  ClearCache;
  Stream.ReadBuffer(Count ,SizeOf(I));
  for I := 0 to Count - 1 do
  begin
    GetMem(P, SizeOf(P^));
    if not Assigned(FEntries) then FEntries := TList.Create;
    FEntries.Add(P);
    with P^ do
    begin
      Stream.ReadBuffer(Size, SizeOf(Size));
      Stream.ReadBuffer(Names, Size);
      Stream.ReadBuffer(Count, SizeOf(Count));
      Stream.ReadBuffer(DispIDs, Count * SizeOf(Integer));
    end;
  end;
end;

procedure TDispInvokeCache.Write(Stream: TStream);
var
  P: PDispInvokeEntry;
  I: Integer;
begin
  if Assigned(FEntries) then
  begin
    I := FEntries.Count;
    Stream.WriteBuffer(I ,SizeOf(I));
    for I := 0 to FEntries.Count - 1 do
    begin
      P := FEntries[I];
      with P^ do
      begin
        Stream.WriteBuffer(Size, SizeOf(Size));
        Stream.WriteBuffer(Names, Size);
        Stream.WriteBuffer(Count, SizeOf(Count));
        Stream.WriteBuffer(DispIDs, Count * SizeOf(Integer));
      end;
    end;
  end else begin
    I := 0;
    Stream.WriteBuffer(I ,SizeOf(I));
  end;
end;

end.
