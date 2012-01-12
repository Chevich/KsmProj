{*******************************************************}
{                                                       }
{            X-library v.03.01                          }
{                                                       }
{   07.10.97                   				}
{                                                       }
{   TUserSource - user connected source                 }
{                                                       }
{   Last corrections 11.09.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}

Unit UsersSet;

Interface

Uses Classes, SysUtils, DB;

type

{ TUserSource }

  EPatternLoadError = class(Exception);
  EPatternSaveError = class(Exception);
  TUserState = (usOneUser, usGroupsRead, usGroupsChange, usAllUsers);
  TUserSaveType = (stFile, stBase, stUserBase);
  TUserFormatType = (ftBinary, ftASCII);
  TUserStreamEvent = procedure (Sender: TObject; Stream: TStream) of object;
  TUserGetName = function :String of Object;

  TUserSource = class(TDataSource)
  private
    FIgnoreErrors: Boolean;
    FUserState: TUserState;
    FUserSaveType: TUserSaveType;
    FFormatType: TUserFormatType;
    FUserField: String;
    FNameField: String;
    FPatternField: String;
    FCurrUser: String;
    FDefUser: String;
    FPatternName: String;
    FAddUsers: TStrings;
    FGroups: TStrings;
    FOnLoadStart: TUserStreamEvent;
    FOnLoadEnd: TNotifyEvent;
    FOnSaveStart: TNotifyEvent;
    FOnSaveEnd: TUserStreamEvent;
    FOnUserGetName: TUserGetName;
    procedure SetUserSaveType(Value: TUserSaveType);
    procedure SetAddUsers(AItems: TStrings);
    procedure SetGroups(AItems: TStrings);
    function GetReadUserCount: Integer;
    function GetReadUser(Index: Integer): String;
    function GetChangeUserCount: Integer;
    function GetChangeUser(Index: Integer): String;
    procedure ReadReferenceName(Reader: TReader; var Name: string);
    procedure ReadSetNameEvent(Reader: TReader; Component: TComponent; var Name: string);
    procedure ReadFindMethodEvent(Reader: TReader; const MethodName: string; var Address: Pointer;
                  var Error: Boolean);
    procedure ReadErrorEvent(Reader: TReader; const Message: string; var Handled: Boolean);
  protected
    function LoadStart: Boolean; virtual;
    procedure LoadEnd(aLoaded: Boolean); virtual;
    procedure DoOnLoadStart(aStream: TMemoryStream); virtual;
    procedure LoadCallback(Component: TComponent); virtual;
    function SaveStart: Boolean; virtual;
    procedure DoOnSaveEnd(aStream: TMemoryStream); virtual;
    procedure SaveEnd(aSaved: Boolean); virtual;
    function GetReadOnly:Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CheckDatabaseSettings: Boolean;
    function LocateRecord: Boolean;
    function LocateFile: Boolean;
    function LoadFromSource(APattern: TPersistent; ARoot: TComponent): Boolean;
    function SaveToSource(APattern: TPersistent; ARoot: TComponent): Boolean;
    function ConvertInSource: Boolean;
    function DeleteFromSource: Boolean;
    procedure GetChangeUsers(AList: TStrings);

    property OnLoadStart: TUserStreamEvent read FOnLoadStart write FOnLoadStart;
    property OnLoadEnd: TNotifyEvent read FOnLoadEnd write FOnLoadEnd;
    property OnSaveStart: TNotifyEvent read FOnSaveStart write FOnSaveStart;
    property OnSaveEnd: TUserStreamEvent read FOnSaveEnd write FOnSaveEnd;
    property ReadOnly: Boolean read GetReadOnly;
    property PatternName: String read FPatternName write FPatternName;
    property CurrUser: String read FCurrUser write FCurrUser;
    property ReadUserCount: Integer read GetReadUserCount;
    property ReadUsers[Index: Integer]: String read GetReadUser;
    property ChangeUserCount: Integer read GetChangeUserCount;
    property ChangeUsers[Index: Integer]: String read GetChangeUser;
  published
    property UserState: TUserState read FUserState write FUserState default usOneUser;
    property UserSaveType: TUserSaveType read FUserSaveType write SetUserSaveType default stFile;
    property DefUser: String read FDefUser write FDefUser;
    property FormatType: TUserFormatType read FFormatType write FFormatType default ftBinary;
    property UserField: String read FUserField write FUserField;
    property NameField: String read FNameField write FNameField;
    property PatternField: String read FPatternField write FPatternField;
    property UserAdds: TStrings read FAddUsers write SetAddUsers;
    property UserGroups: TStrings read FGroups write SetGroups;
    property OnUserGetName: TUserGetName read FOnUserGetName write FOnUserGetName;
  end;
{ TUserSource }

procedure GetBlobFieldAsStream(ADataSet: TDataSet; AFieldName: String; AStream: TStream);
procedure SetBlobFieldFromStream(ADataSet: TDataSet; AFieldName: String; AStream: TStream);

Implementation

Uses Dialogs, XMisc;

Procedure GetBlobFieldAsStream(ADataSet: TDataSet; AFieldName: String; AStream: TStream);
var
  AValue: String;
  CValue: PChar;
  ASize: Integer;
  AField: TBlobField;
begin
  AField:=TBlobField(ADataSet.FindField(AFieldName));
  if AField=nil then Exit;
  if (AField is TBlobField) then TBlobField(AField).SaveToStream(AStream)
  else begin
    AValue := AField.AsString;
    ASize := Length(AValue) + 1;
    GetMem(CValue, ASize);
    CValue := PChar(AValue);
    AStream.WriteBuffer(CValue, ASize);
    FreeMem(CValue, ASize);
  end;
end;

Procedure SetBlobFieldFromStream(ADataSet: TDataSet; AFieldName: String; AStream: TStream);
var AField: TField;
begin
  AField:= ADataSet.FindField(AFieldName);
  if AField=nil then Exit;
  if AField is TBlobField then TBlobField(AField).LoadFromStream(AStream);
end;

{ TUserSource }

Constructor TUserSource.Create(AOwner: TComponent);
begin
  inherited;
  FCurrUser:= '';
  FUserField:= '';
  FNameField:= '';
  FPatternField:= '';
  FDefUser:= '';
  FPatternName:= '';
  FAddUsers:= TStringList.Create;
  FGroups:= TStringList.Create;
  FUserSaveType:= stFile;
  FUserState:= usOneUser;
end;

Destructor TUserSource.Destroy;
begin
  FGroups.Free;
  FAddUsers.Free;
  inherited;
end;

Function TUserSource.GetReadUserCount: Integer;
begin
  Result:=0;
  case FUserState of
{    usOneUser:}
    usGroupsRead, usGroupsChange: Inc(Result, FGroups.Count);
    usAllUsers: Inc(Result, FGroups.Count+FAddUsers.Count);
  end;
end;

Function TUserSource.GetReadUser(Index: Integer): String;
var i: Integer;
begin
  if Index<0 then Result:=''
  else begin
    i:= Index;
    if (i-FGroups.Count)<0 then begin
      Result:= FGroups[i];
      Exit;
    end else Dec(i, FGroups.Count);
    if (i-FAddUsers.Count)<0 then begin
      Result:= FAddUsers[i];
    end else Result:='';
  end;
end;

Function TUserSource.GetChangeUserCount: Integer;
begin
  Result:=0;
  case FUserState of
{    usOneUser:}
{    usGroupsRead: Inc(Result, FGroups.Count);}
    usGroupsChange: Inc(Result, FGroups.Count);
    usAllUsers: Inc(Result, FGroups.Count+FAddUsers.Count);
  end;
end;

Function TUserSource.GetChangeUser(Index: Integer): String;
begin
  Result:=GetReadUser(Index);
end;

Procedure TUserSource.GetChangeUsers(AList: TStrings);
var i: Integer;
begin
  for i:= 0 to ChangeUserCount-1 do
    if AList.IndexOf(ChangeUsers[i])=-1 then AList.Add(ChangeUsers[i]);
end;

Procedure TUserSource.SetAddUsers(AItems: TStrings);
begin
  FAddUsers.Assign(AItems);
end;

Procedure TUserSource.SetGroups(AItems: TStrings);
begin
  FGroups.Assign(AItems);
end;

Procedure TUserSource.SetUserSaveType(Value: TUserSaveType);
begin
  if FUserSaveType<>Value then begin
    if not (csReading in ComponentState) then begin
      if (Value = stBase) and ((FNameField='')or(FPatternField='')) then Exit;
      if (Value = stUserBase) and ((FUserField='') or (FNameField='') or (FPatternField=''))
        then Exit;
    end;
    FUserSaveType:= Value;
  end;
end;

Function TUserSource.CheckDatabaseSettings: Boolean;
begin
  Result:=(DataSet<>nil) and (PatternField<>'') and (NameField<>'');
end;

Function TUserSource.LocateFile: Boolean;
begin
  if FileExists(PatternName) then Result:= True
  else Result:= False;
end;

Function TUserSource.LocateRecord: Boolean;
var AName, AUser: String;
    V: Variant;
begin
  if FUserSaveType = stUserBase then begin
    AUser:= CurrUser;
    if (AUser='') and Assigned(OnUserGetName) then
      AUser:= OnUserGetName;
  end;
  AName:= PatternName;
  if DataSet = nil then Result:= False
  else
    if FUserSaveType = stBase then
      Result:= DataSet.Locate(NameField, AName, [loCaseInsensitive])
    else begin
      V:= VarArrayCreate([0,1], varVariant);
      V[0]:= AUser;
      V[1]:= AName;
      Result:= DataSet.Locate(UserField+';'+NameField, V, [loCaseInsensitive]);
    end;
end;

Function TUserSource.LoadStart: Boolean;
begin
  Result := True
end;

Procedure TUserSource.DoOnLoadStart(aStream: TMemoryStream);
begin
  if Assigned(FOnLoadStart) then FOnLoadStart(Self, aStream);
end;

Procedure TUserSource.LoadCallback(Component: TComponent);
begin

end;

Procedure TUserSource.LoadEnd(aLoaded: Boolean);
begin

end;

Function TUserSource.SaveStart: Boolean;
begin
  Result := True
end;

Procedure TUserSource.DoOnSaveEnd(aStream: TMemoryStream);
begin
  if Assigned(FOnSaveEnd) then OnSaveEnd(Self, aStream);
end;

Procedure TUserSource.SaveEnd(aSaved: Boolean);
begin

end;

Function TUserSource.GetReadOnly:Boolean;
begin
  {return true if a file exists with read-only attribute set}
  Result:=FileExists(PatternName) and
    (Boolean(faReadOnly) and (FileGetAttr(PatternName)>0));
end;

Procedure TUserSource.ReadReferenceName(Reader: TReader; var Name: string);
begin
  ShowMessage(Name);
end;

Procedure TUserSource.ReadErrorEvent(Reader: TReader; const Message: string;
                                     var Handled: Boolean);
begin
  ShowMessage(Message);
end;

Procedure TUserSource.ReadSetNameEvent(Reader: TReader; Component: TComponent;
                                       var Name: string);
begin
  ShowMessage(Name);
end;

procedure TUserSource.ReadFindMethodEvent(Reader: TReader; const MethodName: string;
                                          var Address: Pointer; var Error: Boolean);
begin
  ShowMessage(MethodName);
end;

Function TUserSource.LoadFromSource(APattern: TPersistent; ARoot: TComponent): Boolean;
var
  ATextStream,
  ABinaryStream,
  ALoadStream,
  AObjectStream: TMemoryStream;
  ALoaded: Boolean;
  AMsg: String;
  AField: TField;
begin
  Result:= True;
  FIgnoreErrors := False;
  ALoaded := True;
  ABinaryStream := nil;
  ATextStream   := nil;

  AMsg := 'File not found';
  if FUserSaveType in [stBase, stUserBase] then begin
    {find pattern record in Database}
    DataSet.Open;
    if (not(CheckDatabaseSettings) or not(LocateRecord)) then begin
      Result:=False;
      Exit;
{     raise EPatternLoadError.Create('Record not found ' + PatternName)}
    end;
  end
  {find pattern file}
  else if (FUserSaveType = stFile) and not LocateFile then begin
    Result:=False;
    Exit;
{   raise EPatternLoadError.Create(AMsg + ' ' + PatternName);}
  end;
  {allow descendant classes to check whether its OK to load a template}
  if not LoadStart then Exit;

  ALoadStream := TMemoryStream.Create;
  if FUserSaveType in [stBase, stUserBase] then begin
    AField:= DataSet.FieldByName(PatternField);
    {save pattern in blob to the TextStream}
    if (AField.DataType = ftBlob) then
      try
        GetBlobFieldAsStream(DataSet, PatternField, ALoadStream);
      except
        ALoadStream.Free;
        {error reading template from database}
        raise EPatternLoadError.Create('Error reading pattern');
      end
    else {field is not a blob field}
      raise EPatternLoadError.Create('Field is not a blob field '+PatternField);
  end else
    if (FUserSaveType = stFile) then begin
      {load template from file into TextStream}
      ALoadStream.LoadFromFile(PatternName);
    end;
  try
    try
      {call OnLoadStart event}
      DoOnLoadStart(ALoadStream);
      AObjectStream := ALoadStream;
      ALoadStream   := nil;
      AObjectStream.Seek(0, soFromBeginning);
      {convert text stream to binary if necessary}
      if (FFormatType=ftASCII) then begin
        ATextStream:=AObjectStream;
        ABinaryStream:=TMemoryStream.Create;
        {convert & copy binary MemoryStream content to text FileStream }
        ObjectTextToBinary(ATextStream, ABinaryStream);
      end else begin
        ATextStream   := nil;
        ABinaryStream := AObjectStream;
      end;
      {read template from MemoryStream}
      LoadXComponentFromStream(aBinaryStream, aPattern, aRoot,
        ReadReferenceName, ReadSetNameEvent, ReadFindMethodEvent, ReadErrorEvent);
    except
      ALoaded := False;
      ShowMessage('Ошибка чтения в '+Name);
      Result:= False;
{      raise;}
    end;
  finally
    if Assigned(ALoadStream) then begin
      ALoadStream.Clear;
      ALoadStream.Free;
    end;  
    if Assigned(ABinaryStream) then begin
      ABinaryStream.Clear;
      ABinaryStream.Free;
    end;
    if Assigned(ATextStream) then begin
      ATextStream.Clear;
      ATextStream.Free;
    end;
    {if Assigned(AObjectStream) then AObjectStream.Free;}
    LoadEnd(ALoaded);
    if Assigned(FOnLoadEnd) then FOnLoadEnd({FOwner}Nil);
  end;
end;

Function TUserSource.SaveToSource(APattern: TPersistent; ARoot: TComponent): Boolean;
var
  ABinaryStream,
  AObjectStream,
  ATextStream,
  ASaveStream: TMemoryStream;
  AFileStream: TStream;
  AField: TField;
begin
  result:= True;
  ASaveStream := nil;
  AObjectStream := nil;
  if (FUserSaveType in [stBase, stUserBase]) and not CheckDatabaseSettings then Exit;
  if not SaveStart then Exit;
  if Assigned(FOnSaveStart) then FOnSaveStart({FOwner}nil);
  {write Template to MemoryStream}
  ABinaryStream := TMemoryStream.Create;
  StoreXComponentToStream(aBinaryStream, aPattern, aRoot);
  try
    {if ASCII must convert to Text }
    if FFormatType=ftASCII then begin
      ATextStream:= TMemoryStream.Create;
      try
        {convert & copy binary BinaryStream content to TextStream }
        ABinaryStream.Seek(0, soFromBeginning);
        ObjectBinaryToText(ABinaryStream, ATextStream);
      except
        ATextStream.Free;
        raise
      end;
        AObjectStream := ATextStream;
    end else if FFormatType = ftBinary then begin
      AObjectStream := ABinaryStream;
      ABinaryStream := nil;
    end else begin
      AObjectStream := nil;
      ABinaryStream := nil;
    end;
    {copy object stream to save stream }
    AObjectStream.Seek(0, soFromBeginning);
    ASaveStream   := AObjectStream;
    AObjectStream := nil;
    ASaveStream.Seek(0, soFromBeginning);
    {call OnSaveEnd event}
    DoOnSaveEnd(ASaveStream);
    if (FUserSaveType = stFile) then begin
      {raise error if file is read-only}
      if ReadOnly then
        raise EPatternSaveError.Create('File is read-only');
      AFileStream := TFileStream.Create(PatternName, fmOpenReadWrite or fmShareExclusive or fmCreate);
      ASaveStream.SaveToStream(AFileStream);
      AFileStream.Free;
    end else if (FUserSaveType in [stBase, stUserBase]) then begin
      DataSet.Open;
      if PatternField = '' then begin
        Showmessage('Нет имени для сохранения в '+Name);
        Result:=False;
        Exit;
{       raise EPatternSaveError.Create('No pattern field name');}
      end;
      AField:= DataSet.FieldByName(PatternField);

      if AField.DataType <> ftBlob then
        raise EPatternSaveError.Create('Not blob field type');
       {edit existing record, or add a new record, if needed}
      if LocateRecord then begin
        DataSet.Edit;
        SetBlobFieldFromStream(DataSet, PatternField, ASaveStream);
      end else begin
        DataSet.Insert;
        if FUserSaveType = stUserBase then
          DataSet.FieldByName(UserField).Value:= CurrUser;
        DataSet.FieldByName(NameField).Value:= PatternName;
        SetBlobFieldFromStream(DataSet, PatternField, ASaveStream);
      end;
      DataSet.Post;
    end;
  finally
    if Assigned(ABinaryStream) then ABinaryStream.Free;
    if Assigned(AObjectStream) then AObjectStream.Free;
    if Assigned(ASaveStream) then ASaveStream.Free;
    SaveEnd(True);
  end;
end;

Function TUserSource.ConvertInSource: Boolean;
var aStream, aTextStream: TMemoryStream;
begin
  if FUserSaveType in [stBase, stUserBase] then begin
    aStream:= TMemoryStream.Create;
    aTextStream:= nil;
    try
      try
        GetBlobFieldAsStream(DataSet, PatternField, aStream);
      except
        aStream.Free;
        aStream:=nil;
        raise EPatternLoadError.Create('Error reading pattern');
      end;
      aTextStream:= TMemoryStream.Create;
      try
        aStream.Seek(0, soFromBeginning);
        ObjectBinaryToText(aStream, aTextStream);
      except
        aStream.Free;
        aTextStream.Free;
        aStream:=nil;
        aTextStream:=nil;
        raise;
      end;
      aStream.Seek(0, soFromBeginning);
      aStream.Size:= 0;

      try
        aTextStream.Seek(0, soFromBeginning);
        ObjectTextToBinary(aTextStream, aStream);
      except
        aStream.Free;
        aTextStream.Free;
        aStream:= Nil;
        aTextStream:= Nil;
        raise;
      end;

      try
        aStream.Seek(0, soFromBeginning);
        DataSet.Edit;
        SetBlobFieldFromStream(DataSet, PatternField, aStream);
      except
        aStream.Free;
        aTextStream.Free;
        aStream:=nil;
        aTextStream:=nil;
        raise EPatternLoadError.Create('Error writing pattern');
      end;
      DataSet.Post;
    finally
      aStream.Free;
      aTextStream.Free;
    end;
  end;
end;

Function TUserSource.DeleteFromSource: Boolean;
begin
  Result:= False;
  if Assigned(DataSet) then begin
    if LocateRecord then begin
      DataSet.Delete;
      Result:= True;
    end;
  end;
end;

end.
