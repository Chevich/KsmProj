unit EtvDBase;

interface

uses Classes, DBTables;

type

{ TEtvDatabase }

  TEtvDatabase = class(TDatabase)
  protected
    FOnLogin: TLoginEvent;
    FOnLoaded: TNotifyEvent;
    FCaption:ShortString;
    FLoginCount: Integer;
    FUserName:string;
    FPassword:string;
    FDataOperation: procedure;
    procedure SetCaption(ACaption:ShortString);
    procedure ModelLogin(Database: TDatabase; LoginParams: TStrings);
    function BaseOpen: Boolean;
    function BaseLoaded: Boolean;
    function GetConnected: Boolean;
    procedure SetConnected(Value: Boolean);
    function BaseConnected(Value: Boolean): Boolean;
  {protected}
    procedure Loaded; override;
    procedure PDExecute(LoginParams: TStrings); virtual;
    procedure DoLoaded; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Open;
    property UserName:string read FUserName write FUserName;
    property Password:string read FPassword write FPassword;
  published
    property Connected: Boolean read GetConnected write SetConnected default False;
    property Caption:ShortString read fCaption Write SetCaption;
    property LoginCount: Integer read FLoginCount write FLoginCount default 3;
    property OnLogin: TLoginEvent read FOnLogin write FOnLogin;
    property OnLoaded: TNotifyEvent read FOnLoaded write FOnLoaded;
  end;

implementation

uses Windows, SysUtils, DB, Dialogs, Pasw, Forms, Controls, Messages,
     IniFiles,EtvConst;

{ TEtvDatabase }
type
  EEtvDatabaseError = class(Exception);

{ TEtvDatabase }

constructor TEtvDatabase.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FComponentStyle := FComponentStyle + [csInheritable];
  Inherited OnLogin:= ModelLogin;
  FLoginCount:= 3;
end;

function TEtvDatabase.BaseOpen: Boolean;
begin
  Try
  inherited Open;
  Result:=True;
  except
    on EDatabaseError do Result:=False;
  end;
end;

function TEtvDatabase.BaseLoaded: Boolean;
begin
  Try
    if Assigned(OnLoaded) then FOnLoaded(Self);
    inherited Loaded;
    Result:=True;
  except
    on EDatabaseError do begin
      Result:=False;
      {inherited OnLogin:=nil;}
    end;
  end;
end;

procedure TEtvDatabase.DoLoaded;
begin
end;

procedure TEtvDatabase.Loaded;
var B: Byte;
    Priz: Boolean;
begin
  if Application.Terminated then Exit;
  if LoginPrompt then begin
    try
      Priz:=True;
      for B:=1 to FLoginCount do begin
        Priz:=BaseLoaded;
        if Priz then Break;
      end;
      if not Priz then
        if csDesigning in ComponentState then ShowMessage(SDBPasswordIncorrect)
        else begin
          ShowMessage(SDBPasswordIncorrect+' '+SProgramDown);
          {if Assigned(Owner) then Owner.Free;}
          if not Application.Terminated then begin
            Application.Terminate;
            Application.ProcessMessages;
          end;
(*
          Application.Free;
          Application:=nil;
          Halt;
*)          
        end
      else DoLoaded;
    except
      on E:Exception do begin
        ShowMessage(E.Message);
        if not (csDesigning in ComponentState) then begin
          {if Assigned(Owner) then Owner.Free;}
          if not Application.Terminated then begin
            Application.Terminate;
            Application.ProcessMessages;
          end;
          {Application.Free;
          Application:= Nil;}
          {Halt;}
        end;
      end;
    end;
  end else Inherited Loaded;
end;

procedure TEtvDatabase.Open;
var B: Byte;
    Priz: Boolean;
begin
  if LoginPrompt then begin
    Priz:=True;
    for B:=1 to FLoginCount do begin
      Priz:= BaseOpen;
      if Priz then Break;
    end;
    if not Priz then
      if csDesigning in ComponentState then ShowMessage(SDBPasswordIncorrect)
      else begin
        ShowMessage(SDBPasswordIncorrect+' '+SProgramDown);
        {if Assigned(Owner) then Owner.Free;}
        if not Application.Terminated then begin
          Application.Terminate;
          Application.ProcessMessages;
        end;
{       Application.Free;
        Application:= Nil;
        Halt;
}
      end;
  end else Inherited Open;
end;

Function TEtvDatabase.BaseConnected(Value: Boolean): Boolean;
begin
  try
  Inherited Connected:=Value;
  Result:=True;
  except
    on EDatabaseError do
       Result:=False;
  end;
end;

Function TEtvDatabase.GetConnected: Boolean;
begin
  Result:=Inherited Connected;
end;

Procedure TEtvDatabase.SetConnected(Value: Boolean);
var B:Byte;
    Priz:Boolean;
begin
  if (Not (csLoading in ComponentState)) and
  Value and (Inherited Connected = False) and LoginPrompt then begin
    Priz:=True;
    for B:=1 to FLoginCount do begin
      Priz:= BaseConnected(Value);
      if Priz then break;
    end;
    if not Priz then
      if csDesigning in ComponentState then ShowMessage(SDBPasswordIncorrect)
      else begin
        ShowMessage(SDBPasswordIncorrect+' '+SProgramDown);
        {if Assigned(Owner) then Owner.Free;}
        if not Application.Terminated then begin
          Application.Terminate;
          Application.ProcessMessages;
        end;
        {
        Application.Free;
        Application:=nil;
        Halt;}
      end;
  end else Inherited Connected:= Value;
end;

Procedure TEtvDatabase.PDExecute(LoginParams: TStrings);
begin
  with TPasswordDlg.Create(Application) do begin
    Caption:=Self.Caption;
    User.Text:=LoginParams.Values['USER NAME'];
    if ShowModal=mrOk then begin
      Application.ProcessMessages;
      LoginParams.Values['USER NAME'] := User.Text;
      fUserName:=User.Text;
      LoginParams.Values['PASSWORD'] := Password.Text;
      fPassword:=Password.Text;
    end else raise EEtvDatabaseError.Create(SCancelDialPassword);
    PostMessage(HWND_BROADCAST, wm_ActivateApp, Word(True), 0);
    Free;
  end;
end;

Procedure TEtvDatabase.ModelLogin(Database: TDatabase; LoginParams: TStrings);
var Buffer: Array[1..60] of Char;
    P: PChar;
    Len: DWord;
    MIni: TIniFile;
    S:String;
    i: Integer;
    Priz, Prizu, Prizp: Boolean;
begin
  Priz:=False;
  Prizu:=False;
  Prizp:=False;
  {Application.HandleMessage;}
  if Application.Terminated then Exit;
  {ShowMessage('Программная ошибка. Вызовите авторов!');}
  if ParamCount=0 then begin
    PDExecute(LoginParams);
    Priz:=True;
  end else
    for i:=1 to ParamCount do begin
      S:=ParamStr(i);
      if S='-p' then begin
        MIni := TIniFile.Create('connect.Ini');
        with MIni do begin
          S:=ReadString('CONNECT', 'UserName', 'ERROR');
          if S<>'ERROR' then LoginParams.Values['USER NAME'] := S;
          FUserName:=S;
          S:=ReadString('CONNECT', 'Password', 'ERROR');
          if S<>'ERROR' then LoginParams.Values['PASSWORD'] := S;
          FPassword:=S;
        end;
        MIni.Free;
        Priz:=True;
        Break;
      end else
        if S='-u' then begin
          P:=Addr(Buffer); Len:=60;
          GetUserName(P,Len);
          LoginParams.Values['USER NAME'] := Buffer;
          PDExecute(LoginParams);
          Priz:=True;
        end else
          if Pos('-u',S)>0 then begin
            LoginParams.Values['USER NAME'] := Copy(S,3,255);
            FUserName:=Copy(S,3,255);
            Prizu:=True;
          end else
            if Pos('-p',S)>0 then begin
              LoginParams.Values['PASSWORD'] := Copy(S,3,255);
              FPassword:=Copy(S,3,255);
              Prizp:=True;
            end;
    end;
  if (not Priz)and PrizU and PrizP then Priz:=True;
  if not Priz then PDExecute(LoginParams);
  Params.Assign(LoginParams);
  if Assigned(FOnLogin) then FOnLogin(Database, LoginParams);
end;
(* Val EtvDataBase end *)

Procedure TEtvDataBase.SetCaption(ACaption:ShortString);
begin
  fCaption:=ACaption;
end;

end.
