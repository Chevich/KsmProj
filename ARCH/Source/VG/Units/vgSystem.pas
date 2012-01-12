{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Special system classes                        }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgSystem;

interface
uses Windows, SysUtils, Classes;

type
{ TTlsBuffer }
  TTlsBuffer = class
  private
    FBlocks: TList;
    FSize: Integer;
    FTlsIndex: Integer;
    function GetMemory: Pointer;
    function GetTlsValue: Pointer;
    class procedure AddTlsBuffer(ATlsBuffer: TTlsBuffer);
    class procedure RemoveTlsBuffer(ATlsBuffer: TTlsBuffer);
  protected
    function AllocMemory(ASize: Integer): Pointer; virtual;
    procedure DoDetachThreadInternal;
    procedure FreeMemory(P: Pointer); virtual;
  public
    constructor Create(ASize: Integer);
    destructor Destroy; override;
    class procedure DoDetachThread;
    property Memory: Pointer read GetMemory;
    property Size: Integer read FSize;
    property TlsIndex: Integer read FTlsIndex;
  end;

{ TCustomThread }
  TCustomThread = class(TThread)
  protected
    procedure DoExecute; virtual;
    procedure DoHandleException(Sender: TObject); virtual;
    procedure Execute; override;
  end;

{ TCustomWaitThread }
  TCustomWaitThread = class(TCustomThread)
  private
    FEvent: THandle;
    FTimeout: Integer;
  protected
    procedure DoReset; virtual;
    procedure DoTimeout; virtual;
    procedure DoExecute; override;
  public
    constructor Create(CreateSuspended: Boolean; ATimeout: Integer);
    destructor Destroy; override;
    procedure Reset(TerminateThread: Boolean);
    property Timeout: Integer read FTimeout write FTimeout;
  end;

{ TWaitThread }
  TWaitThread = class(TCustomWaitThread)
  private
    FOnReset, FOnTimeout: TNotifyEvent;
  protected
    procedure DoReset; override;
    procedure DoTimeout; override;
  public
    property OnReset: TNotifyEvent read FOnReset write FOnReset;
    property OnTimeout: TNotifyEvent read FOnTimeout write FOnTimeout;
  end;

{ TThreadEx }
  TThreadEx = class(TCustomThread)
  private
    FOnExecute, FOnException: TNotifyEvent;
  protected
    procedure DoExecute; override;
    procedure DoHandleException(Sender: TObject); override;
  public
    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnException: TNotifyEvent read FOnException write FOnException;
  end;

{ TCustomMessageThread }
  TCustomMessageThread = class(TCustomThread)
  protected
    procedure DoAfterMessage(const Msg: TMsg; const RetValue: Integer); virtual;
    procedure DoBeforeMessage(var Msg: TMsg; var Handled: Boolean); virtual;
    procedure DoExecute; override;
  public
    destructor Destroy; override;
    procedure PostMessage(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
    procedure PostQuitMessage;
    procedure WaitForQuit;
  end;

{ TMessageThread }
  TAfterMessageEvent = procedure (const  Msg: TMsg; const RetValue: Integer) of object;
  TBeforeMessageEvent = procedure (var Msg: TMsg; var Handled: Boolean) of object;

  TMessageThread = class(TCustomMessageThread)
  private
    FOnAfterMessage: TAfterMessageEvent;
    FOnBeforeMessage: TBeforeMessageEvent;
  protected
    procedure DoAfterMessage(const Msg: TMsg; const RetValue: Integer); override;
    procedure DoBeforeMessage(var Msg: TMsg; var Handled: Boolean); override;
  public
    property OnAfterMessage: TAfterMessageEvent read FOnAfterMessage write FOnAfterMessage;
    property OnBeforeMessage: TBeforeMessageEvent read FOnBeforeMessage write FOnBeforeMessage;
  end;

{ TvgThreadList }
  TvgThreadList = class
  private
    FLock: TRTLCriticalSection;
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): Pointer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
    function IndexOf(Item: Pointer): Integer;
    function Add(Item: Pointer): Integer;
    procedure Insert(Index: Integer; Item: Pointer);
    procedure Remove(Item: Pointer);
    procedure Clear;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: Pointer read GetItem; default;
  end;

  TSignature = array [0..3] of Char;

{ TCompressor }
  TCompressor = class
  private
    FBuff, FData: Pointer;
    FBuffSize: Integer;
    FStream: TStream;
  protected
    property Buff: Pointer read FBuff;
    property BuffSize: Integer read FBuffSize;
    property Data: Pointer read FData;
    property Stream: TStream read FStream;
  public
    constructor Create; virtual;
    procedure Compress(AStream: TStream; const ABuff; ACount: Integer; AData: Pointer); virtual;
    procedure UnCompress(AStream: TStream; const ABuff; ACount: Integer; AData: Pointer); virtual;
    class function Sign: TSignature; virtual;
  end;

{ TBlockCompressor }
  TBlockCompressor = class(TCompressor)
  private
    FSourcePos: Integer;
  protected
    procedure GetBlock(var Buffer; Count: Integer; var ActualCount: Integer);
    procedure PutBlock(var Buffer; Count: Integer; var ActualCount: Integer);
    property SourcePos: Integer read FSourcePos;
  end;

  TCompressorClass = class of TCompressor;

{ TCompressorList }
  TCompressorList = class
  private
    FItems: TList;
    function GetCompressor(Index: Integer): TCompressorClass;
    function GetCount: Integer;
  public
    destructor Destroy; override;
    function CreateCompressor(Sign: TSignature): TCompressor;
    function FindCompressor(Sign: TSignature): TCompressorClass;
    procedure RegisterCompressor(CompressorClass: TCompressorClass);
    procedure UnRegisterCompressor(CompressorClass: TCompressorClass);
    property Compressors[Index: Integer]: TCompressorClass read GetCompressor;
    property Count: Integer read GetCount;
  end;

  TFileAccessModes   = (famRead, famWrite);
  TFileAccessMode    = set of TFileAccessModes;

  TFileShareModes    = (fsmWrite, fsmRead);
  TFileShareMode     = set of TFileShareModes;

  TFileCreationMode  = (fcmCreateNew, fcmCreateAlways, fcmOpenExisting,
    fcmOpenAlways, fcmTruncateExisting);

{ TWinFileStream }
  TWinFileStream = class(THandleStream)
  public
    constructor Create(const FileName: TFileName; Access: TFileAccessMode;
      Share: TFileShareMode; Creation: TFileCreationMode; FileAttrsAndFlags: Integer;
      lpSecurity: PSecurityAttributes; TemplateHandle: Integer);
    destructor Destroy; override;
  end;

function CompressorList: TCompressorList;

{ --- Buffer compression }
procedure Compress(Sign: TSignature; Stream: TStream; const Buff; Count: Integer; Data: Pointer);
procedure UnCompress(Sign: TSignature; Stream: TStream; const Buff; Count: Integer; Data: Pointer);

{ --- Variant compression }
function CompressVariant(Sign: TSignature; const Value: Variant; AData: Pointer): Variant;
function UnCompressVariant(const Value: Variant; AData: Pointer): Variant;

const
  famAccessAll = [famRead, famWrite];

  ThreadPriorities: array [TThreadPriority] of Integer =
   (THREAD_PRIORITY_IDLE, THREAD_PRIORITY_LOWEST, THREAD_PRIORITY_BELOW_NORMAL,
    THREAD_PRIORITY_NORMAL, THREAD_PRIORITY_ABOVE_NORMAL,
    THREAD_PRIORITY_HIGHEST, THREAD_PRIORITY_TIME_CRITICAL);

implementation
uses Messages, Consts, vgVCLRes, vgUtils;

var
  FTlsBuffers: TList = nil;
  FTlsLock: TRTLCriticalSection;

{ TTlsBuffer }
constructor TTlsBuffer.Create(ASize: Integer);
begin
  AddTlsBuffer(Self);
  FSize := ASize;
  FTlsIndex := TlsAlloc;
  if FTlsIndex < 0 then
    raise Exception.Create(LoadStr(STlsCannotAlloc));
end;

destructor TTlsBuffer.Destroy;
begin
  while Assigned(FBlocks) do FreeMemory(FBlocks[0]);
  if (FTlsIndex >= 0) then TlsFree(FTlsIndex);
  RemoveTlsBuffer(Self);
  inherited;
end;

procedure TTlsBuffer.DoDetachThreadInternal;
begin
  FreeMemory(GetTlsValue);
end;

class procedure TTlsBuffer.DoDetachThread;
var
  I: Integer;
begin
  if Assigned(FTlsBuffers) then
  begin
    EnterCriticalSection(FTlsLock);
    try
      for I := 0 to FTlsBuffers.Count - 1 do
        TTlsBuffer(FTlsBuffers.Items[I]).DoDetachThreadInternal;
    finally
      LeaveCriticalSection(FTlsLock);
    end;
  end;
end;

function TTlsBuffer.GetMemory: Pointer;
begin
  Result := GetTlsValue;
  if not Assigned(Result) then
  begin
    EnterCriticalSection(FTlsLock);
    try
      Result := AllocMemory(FSize);
      try
        ListAdd(FBlocks, Result);
      except
        FreeMemory(Result);
        raise;
      end;
    finally
      LeaveCriticalSection(FTlsLock);
    end;
    TlsSetValue(FTlsIndex, Result);
  end;
end;

function TTlsBuffer.GetTlsValue: Pointer;
begin
  Result := TlsGetValue(FTlsIndex);
end;

function TTlsBuffer.AllocMemory(ASize: Integer): Pointer;
begin
  Result := AllocMem(ASize);
end;

procedure TTlsBuffer.FreeMemory(P: Pointer);
begin
  if Assigned(P) then
  begin
    EnterCriticalSection(FTlsLock);
    try
      ListRemove(FBlocks, P);
      FreeMem(P);
    finally
      LeaveCriticalSection(FTlsLock);
    end;
  end;
end;

class procedure TTlsBuffer.AddTlsBuffer(ATlsBuffer: TTlsBuffer);
begin
  ListAdd(FTlsBuffers, ATlsBuffer);
  if FTlsBuffers.Count = 1 then
    InitializeCriticalSection(FTlsLock);
end;

class procedure TTlsBuffer.RemoveTlsBuffer(ATlsBuffer: TTlsBuffer);
begin
  ListRemove(FTlsBuffers, ATlsBuffer);
  if not Assigned(FTlsBuffers) then
    DeleteCriticalSection(FTlsLock);
end;

{ TCustomThread }
procedure TCustomThread.DoExecute;
begin
end;

procedure TCustomThread.DoHandleException(Sender: TObject);
begin
end;

procedure TCustomThread.Execute;
begin
  try
    DoExecute;
  except
    DoHandleException(Self);
  end;
end;

{ TCustomWaitThread }
constructor TCustomWaitThread.Create(CreateSuspended: Boolean; ATimeout: Integer);
begin
  inherited Create(CreateSuspended);
  FTimeout := ATimeout;
  FEvent := CreateEvent(nil, False, False, nil);
end;

destructor TCustomWaitThread.Destroy;
begin
  Reset(True);
  CloseHandle(FEvent);
  inherited
end;

procedure TCustomWaitThread.DoReset;
begin
end;

procedure TCustomWaitThread.DoTimeout;
begin
end;

procedure TCustomWaitThread.DoExecute;
begin
  while not Terminated do
    case WaitForSingleObject(FEvent, FTimeOut) of
      WAIT_OBJECT_0:
      try
        DoReset;
      except
        DoHandleException(Self);
      end;
      WAIT_TIMEOUT:
      try
        DoTimeout;
      except
        DoHandleException(Self);
      end;
    end;
end;

procedure TCustomWaitThread.Reset(TerminateThread: Boolean);
begin
  if TerminateThread then Terminate;
  if Suspended then Resume;
  SetEvent(FEvent);
end;

{ TWaitThread }
procedure TWaitThread.DoReset;
begin
  if Assigned(FOnReset) then FOnReset(Self);
end;

procedure TWaitThread.DoTimeout;
begin
  if Assigned(FOnTimeout) then FOnTimeout(Self);
end;

{ TThreadEx }
procedure TThreadEx.DoExecute;
begin
  if Assigned(FOnExecute) then FOnExecute(Self);
end;

procedure TThreadEx.DoHandleException(Sender: TObject);
begin
  if Assigned(FOnException) then FOnException(Self);
end;

{ TCustomMessageThread }
destructor TCustomMessageThread.Destroy;
begin
  WaitForQuit;
  inherited;
end;

procedure TCustomMessageThread.DoAfterMessage(const Msg: TMsg; const RetValue: Integer);
begin
end;

procedure TCustomMessageThread.DoBeforeMessage(var Msg: TMsg; var Handled: Boolean);
begin
end;

procedure TCustomMessageThread.DoExecute;
var
  Msg: TMsg;
  Handled: Boolean;
begin
  while GetMessage(Msg, 0, 0, 0) do
  begin
    DoBeforeMessage(Msg, Handled);
    if not Handled then
      DoAfterMessage(Msg, DispatchMessage(Msg));
  end;
end;

procedure TCustomMessageThread.PostMessage(Msg: UINT; wParam: WPARAM; lParam: LPARAM);
begin
  PostThreadMessage(ThreadID, Msg, wParam, lParam);
end;

procedure TCustomMessageThread.PostQuitMessage;
begin
  Self.PostMessage(WM_QUIT, 0, 0);
end;

procedure TCustomMessageThread.WaitForQuit;
begin
  if not (Terminated or Suspended) then
  begin
    PostQuitMessage;
    Terminate;
    WaitFor;
  end;
end;

{ TMessageThread }
procedure TMessageThread.DoAfterMessage(const Msg: TMsg; const RetValue: Integer);
begin
  if Assigned(FOnAfterMessage) then FOnAfterMessage(Msg, RetValue);
end;

procedure TMessageThread.DoBeforeMessage(var Msg: TMsg; var Handled: Boolean);
begin
  Handled := False;
  if Assigned(FOnBeforeMessage) then FOnBeforeMessage(Msg, Handled);
end;

{ TvgThreadList }
constructor TvgThreadList.Create;
begin
  InitializeCriticalSection(FLock);
end;

destructor TvgThreadList.Destroy;
begin
  Clear;
  DeleteCriticalSection(FLock);
  inherited;
end;

function TvgThreadList.GetCount: Integer;
begin
  Lock;
  try
    Result := ListCount(FItems);
  finally
    Unlock;
  end;
end;

function TvgThreadList.GetItem(Index: Integer): Pointer;
begin
  Lock;
  try
    Result := ListItem(FItems, Index);
  finally
    Unlock;
  end;
end;

function TvgThreadList.IndexOf(Item: Pointer): Integer;
begin
  Lock;
  try
    Result := ListIndexOf(FItems, Item);
  finally
    Unlock;
  end;
end;

procedure TvgThreadList.Lock;
begin
  EnterCriticalSection(FLock);
end;

procedure TvgThreadList.Unlock;
begin
  LeaveCriticalSection(FLock);
end;

function TvgThreadList.Add(Item: Pointer): Integer;
begin
  Lock;
  try
    Result := Count;
    Insert(Result, Item);
  finally
    Unlock;
  end;
end;

procedure TvgThreadList.Insert(Index: Integer; Item: Pointer);
begin
  Lock;
  try
    ListInsert(FItems, Index, Item);
  finally
    Unlock;
  end;
end;

procedure TvgThreadList.Clear;
begin
  Lock;
  try
    ListClear(FItems);
  finally
    Unlock;
  end;
end;

procedure TvgThreadList.Remove(Item: Pointer);
begin
  Lock;
  try
    if ListIndexOf(FItems, Item) >= 0 then
      ListRemove(FItems, Item);
  finally
    Unlock;
  end;
end;

var
  FCompressorList: TCompressorList = nil;

function CompressorList: TCompressorList;
begin
  if not Assigned(FCompressorList) then FCompressorList := TCompressorList.Create;
  Result := FCompressorList;
end;

procedure Compress(Sign: TSignature; Stream: TStream; const Buff; Count: Integer; Data: Pointer);
var
  Compressor: TCompressor;
begin
  Compressor := CompressorList.CreateCompressor(Sign);
  try
    Compressor.Compress(Stream, Buff, Count, Data);
  finally
    Compressor.Free;
  end;
end;

procedure UnCompress(Sign: TSignature; Stream: TStream; const Buff; Count: Integer; Data: Pointer);
var
  Compressor: TCompressor;
begin
  Compressor := CompressorList.CreateCompressor(Sign);
  try
    Compressor.UnCompress(Stream, Buff, Count, Data);
  finally
    Compressor.Free;
  end;
end;

function CompressVariant(Sign: TSignature; const Value: Variant; AData: Pointer): Variant;
var
  Data: Pointer;
  F, C: TMemoryStream;
begin
  F := TMemoryStream.Create;
  try
    WriteVariant(F, Value);
    C := TMemoryStream.Create;
    try
      Compress(Sign, C, F.Memory^, F.Size, AData);
      Result := VarArrayCreate([0, C.Size + SizeOf(TSignature) - 1], varByte);
      Data := VarArrayLock(Result);
      try
        Move(PChar(@Sign)^, Data^, SizeOf(TSignature));
        Move(C.Memory^, (PChar(Data) + SizeOf(TSignature))^, C.Size);
      finally
        VarArrayUnlock(Result);
      end;
    finally
      C.Free;
    end;
  finally
    F.Free;
  end;
end;

function UnCompressVariant(const Value: Variant; AData: Pointer): Variant;
var
  Sign: TSignature;
  Data: Pointer;
  F, U: TMemoryStream;
  TmpFlags: TVarFlags;
begin
  F := TMemoryStream.Create;
  try
    Data := VarArrayLock(Value);
    try
      Move(Data^, Sign, SizeOf(TSignature));
      F.WriteBuffer((PChar(Data) + SizeOf(TSignature))^,
        VarArrayHighBound(Value, 1) - VarArrayLowBound(Value, 1) - SizeOf(TSignature) + 1);
    finally
      VarArrayUnlock(Value);
    end;
    U := TMemoryStream.Create;
    try
      UnCompress(Sign, U, F.Memory^, F.Size, AData);
      U.Position := 0;
      Result := ReadVariant(U, TmpFlags)
    finally
      U.Free;
    end;
  finally
    F.Free;
  end;
end;

{ TCompressor }
constructor TCompressor.Create;
begin
end;

class function TCompressor.Sign: TSignature;
begin
  Result := (#0#0#0#0);
end;

procedure TCompressor.Compress(AStream: TStream; const ABuff; ACount: Integer; AData: Pointer);
begin
  FStream := AStream;
  FBuff := @ABuff;
  FBuffSize := ACount;
  FData := AData;
end;

procedure TCompressor.UnCompress(AStream: TStream; const ABuff; ACount: Integer; AData: Pointer);
begin
  FStream := AStream;
  FBuff := @ABuff;
  FBuffSize := ACount;
  FData := AData;
end;

{ TBlockCompressor }
procedure TBlockCompressor.GetBlock(var Buffer; Count: Integer; var ActualCount: Integer);
begin
  ActualCount := Min(Count, BuffSize - SourcePos);
  Move(Pointer(Integer(Buff) + SourcePos)^, Buffer, ActualCount);
  FSourcePos := FSourcePos + ActualCount;
end;

procedure TBlockCompressor.PutBlock(var Buffer; Count: Integer; var ActualCount: Integer);
begin
  ActualCount := Stream.Write(Buffer, Count);
end;

{ TCompressorList}
destructor TCompressorList.Destroy;
begin
  ListClear(FItems);
  inherited;
end;

function TCompressorList.GetCompressor(Index: Integer): TCompressorClass;
begin
  Result := ListItem(FItems, Index);
end;

function TCompressorList.GetCount: Integer;
begin
  Result := ListCount(FItems);
end;

function TCompressorList.CreateCompressor(Sign: TSignature): TCompressor;
var
  C: TCompressorClass;
begin
  C := FindCompressor(Sign);
  if not Assigned(C) then
    raise EInvalidOp.Create(Format(LoadStr(SUknownCompressorSign), [Sign]));
  Result := C.Create;
end;

function TCompressorList.FindCompressor(Sign: TSignature): TCompressorClass;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := Compressors[I];
    if Result.Sign = Sign then Exit;
  end;
  Result := nil;
end;

procedure TCompressorList.RegisterCompressor(CompressorClass: TCompressorClass);
begin
  if FindCompressor(CompressorClass.Sign) = nil then
    ListAdd(FItems, CompressorClass);
end;

procedure TCompressorList.UnRegisterCompressor(CompressorClass: TCompressorClass);
begin
  ListRemove(FItems, CompressorClass);
end;

{ TWinFileStream }
constructor TWinFileStream.Create(const FileName: TFileName; Access: TFileAccessMode;
  Share: TFileShareMode; Creation: TFileCreationMode; FileAttrsAndFlags: Integer;
  lpSecurity: PSecurityAttributes; TemplateHandle: Integer);

const
  CreationMode: array [TFileCreationMode] of Integer = (
    CREATE_NEW, CREATE_ALWAYS, OPEN_EXISTING, OPEN_ALWAYS, TRUNCATE_EXISTING);

var
  AHandle: Integer;
begin
  AHandle := CreateFile(PChar(FileName), Byte(Access) and 3 shl 29,
    Byte(Share) and 3, lpSecurity, CreationMode[Creation],
    FileAttrsAndFlags, TemplateHandle);

  if AHandle < 0 then
  begin
    if Creation in [fcmCreateNew, fcmCreateAlways] then
      raise EFCreateError.CreateFmt(ResStr(SFCreateError), [FileName]) else
      raise EFOpenError.CreateFmt(ResStr(SFOpenError), [FileName]);
  end;
  inherited Create(AHandle);
end;

destructor TWinFileStream.Destroy;
begin
  if Handle >= 0 then FileClose(Handle);
  inherited;
end;

initialization

finalization
   FCompressorList.Free;

end.
