{*******************************************************}
{                                                       }
{   06.11.97                  				}
{                                                       }
{   TXAppControl - master of Application                }
{        with coommon PrintLink of project              }
{                                                       }
{  Last corrections 12.11.98                            }
{                                                       }
{*******************************************************}

Unit XApps;

Interface

Uses Windows, Classes, Forms, SysUtils, XReports;

Type

{ TXAppControl }

  TXAppControl = class(TComponent)
  private
    FSingleActive: Boolean;
    FSingleApp: Boolean;
    FPrintActive: Boolean;
    FAppWindow: HWND;
    FMutex: THandle;
    FPrintLink: TPrintLink;
    FAliasNames: TStrings;
    FAliasDefs: TStrings;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnException: TExceptionEvent;
    FOnIdle: TIdleEvent;
    FOnHelp: THelpEvent;
    FOnHint: TNotifyEvent;
    FOnShowHint: TShowHintEvent;
    FOnMessage: TMessageEvent;
    FOnMinimize: TNotifyEvent;
    FOnRestore: TNotifyEvent;
    FStopMsg: string;
    procedure SetPrintActive(Value: Boolean);
    procedure CheckTerminate;
    function GetMutexName: string;
    procedure AppActivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    function AppHelp(Command: Word; Data: Longint;
             var CallHelp: Boolean): Boolean;
    procedure AppHint(Sender: TObject);
    procedure AppShowHint(var HintStr: string; var CanShow: Boolean;
              var HintInfo: THintInfo);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure AppMinimize(Sender: TObject);
    procedure AppRestore(Sender: TObject);
    procedure InitAppControl;
    procedure SetAliasNames(AItems: TStrings);
    procedure SetAliasDefs(AItems: TStrings);
  protected
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SingleActive: Boolean read FSingleActive write FSingleActive default True;
    property SingleApp: Boolean read FSingleApp write FSingleApp default True;
    property AliasNames: TStrings read FAliasNames write SetAliasNames;
    property AliasDefs: TStrings read FAliasDefs write SetAliasDefs;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnException: TExceptionEvent read FOnException write FOnException;
    property OnIdle: TIdleEvent read FOnIdle write FOnIdle;
    property OnHelp: THelpEvent read FOnHelp write FOnHelp;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnShowHint: TShowHintEvent read FOnShowHint write FOnShowHint;
    property OnMessage: TMessageEvent read FOnMessage write FOnMessage;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property PrintActive: Boolean read FPrintActive write SetPrintActive default False;
    property PrintLink: TPrintLink read FPrintLink write FPrintLink;
    property StopMsg: string read FStopMsg write FStopMsg;
  end;
{ TXAppControl }

var SystemAppControl: TXAppControl=nil;
    SystemPrintLink: TPrintLink=nil;
    { ≈сли параметр DirShb задан в командной строке, то будет работать этот параметр, }
    { если же не задан, то значение беретс€ из таблицы AdmConfig  }
    DirShb: string;
    AliasName:string;
    Optimize, MessageInOptimize: boolean;
    AppUserName: string; { ќпределение UserName'а ч/з сервер }

Procedure CreateSystemAppControl;

Implementation

Uses Messages,Dialogs;

type EAppControlError = class(Exception);

Constructor TXAppControl.Create(AOwner: TComponent);
begin
  if Assigned(SystemAppControl) then begin
    raise EAppControlError.Create('This component is present!')
  end else begin
    inherited Create(AOwner);
    SystemAppControl:=Self;
    FSingleActive := True;
    FSingleApp := True;
    FPrintActive:= False;
    FStopMsg := 'ѕрограмма уже запущена';
    FMutex := CreateMutex(nil, True, PChar(GetMutexName));
    if (FMutex <> 0) and (GetLastError <> 0) then FMutex := 0;
    FAliasNames:= TStringList.Create;
    FAliasDefs:= TStringList.Create;
  end;
end;

Destructor TXAppControl.Destroy;
begin
  if Assigned(PrintLink) then begin
    if SystemPrintLink=FPrintLink then SystemPrintLink:=nil;
    PrintLink.Free;
  end;
  if FMutex <> 0 then begin
    CloseHandle(FMutex);
    FMutex:=0;
  end;
  if SystemAppControl=Self then SystemAppControl:=nil;
  FAliasNames.Free;
  FAliasDefs.Free;
  inherited Destroy;
end;

Procedure TXAppControl.ReadState(Reader: TReader);
begin
  inherited;
  InitAppControl;
end;

Procedure TXAppControl.InitAppControl;
var
  ClassChar, WindowChar: array[0..255] of char;
begin
  if not (csDesigning in ComponentState) then begin
     {replacing Application events}
    Application.OnActivate:=AppActivate;
    Application.OnDeactivate:=AppDeactivate;
    Application.OnException:=AppException;
    Application.OnIdle:=AppIdle;
    Application.OnHelp:=AppHelp;
    Application.OnHint:=AppHint;
    Application.OnShowHint:=AppShowHint;
    Application.OnMessage:=AppMessage;
    Application.OnMinimize:=AppMinimize;
    Application.OnRestore:=AppRestore;

    if (FMutex = 0) then begin
       {Find previous instance using Window Caption}
      GetClassName(Application.Handle, ClassChar, 255);
      GetWindowText(Application.Handle, WindowChar, 255);
      SetWindowText(Application.Handle, '');
      FAppWindow := FindWindow(ClassChar, WindowChar);
      SetWindowText(Application.Handle, WindowChar);
      if (FAppWindow <> 0) and FSingleApp then
        CheckTerminate;
    end;
  end;
end;

Procedure TXAppControl.AppActivate(Sender: TObject);
begin
  if Assigned(FOnActivate) then FOnActivate(Sender);
end;

Procedure TXAppControl.AppDeactivate(Sender: TObject);
begin
  if Assigned(FOnDeactivate) then FOnDeactivate(Sender);
end;

Procedure TXAppControl.AppException(Sender: TObject; E: Exception);
begin
  if Assigned(FOnException) then FOnException(Sender, E)
  else Application.ShowException(E);
end;

Procedure TXAppControl.AppIdle(Sender: TObject; var Done: Boolean);
begin
  if Assigned(FOnIdle) then FOnIdle(Sender, Done);
end;

Function TXAppControl.AppHelp(Command: Word; Data: Longint;
                              var CallHelp: Boolean): Boolean;
begin
  if Assigned(FOnHelp) then Result:= FOnHelp(Command, Data, CallHelp)
  else Result:=False;
end;

Procedure TXAppControl.AppHint(Sender: TObject);
begin
  if Assigned(FOnHint) then FOnHint(Sender);
end;

Procedure TXAppControl.AppShowHint(var HintStr: string; var CanShow: Boolean;
                                   var HintInfo: THintInfo);
begin
  if Assigned(FOnShowHint) then FOnShowHint(HintStr, CanShow, HintInfo);
end;

Procedure TXAppControl.AppMessage(var Msg: TMsg; var Handled: Boolean);
var i: LongInt;
begin
  {  орректна€ работа при работе с колесиком мышки в TDBGrid }
  { http://delphiworld.narod.ru/base/dbgrid_wheel_correct.html }
  { Mouse wheel behaves strangely with dgbgrids - this proc sorts this out }
  if Msg.message = WM_MOUSEWHEEL then begin
    Msg.message := WM_KEYDOWN;
    Msg.lParam := 0;
    i := Msg.wParam;
    if i > 0 then
      Msg.wParam := VK_UP
    else
      Msg.wParam := VK_DOWN;
    Handled := False;
  end;
  if Assigned(FOnMessage) then FOnMessage(Msg, Handled);
end;

Procedure TXAppControl.AppMinimize(Sender: TObject);
begin
  if Assigned(FOnMinimize) then FOnMinimize(Sender);
end;

Procedure TXAppControl.AppRestore(Sender: TObject);
begin
  if Assigned(FOnRestore) then FOnRestore(Sender);
end;

Procedure TXAppControl.SetPrintActive(Value: Boolean);
begin
  if Value<>FPrintActive then begin
    if FPrintActive then begin
      if FPrintLink<>nil then begin
        FPrintLink.Free;
        FPrintLink:=nil;
        SystemPrintLink:=nil;
      end;
    end else begin
      if FPrintLink=Nil then begin
        FPrintLink:=TPrintLink.Create(pdText);
        SystemPrintLink:= FPrintLink;
      end;
    end;
    FPrintActive:=Value;
  end;
end;

Function TXAppControl.GetMutexName: string;
var WindowText: array [0..255] of Char;
begin
  GetWindowText(Application.Handle, WindowText, 255);
  Result := 'TXAppControl in application ' + WindowText;
end;

Procedure TXAppControl.CheckTerminate;
var ActiveWindow: HWND;
begin
  if FStopMsg<>'' then
    MessageBox(Application.Handle, PChar(FStopMsg), PChar(Application.Title),
                MB_ICONEXCLAMATION);
  if FSingleActive then
    if IsIconic(FAppWindow) then
      {Restore when minimised}
      ShowWindow(FAppWindow, SW_RESTORE)
    else begin
      ActiveWindow := GetLastActivePopup(FAppWindow);
      if (ActiveWindow <> 0) and IsWindowVisible(ActiveWindow) and
      IsWindowEnabled(ActiveWindow) and (ActiveWindow <> FAppWindow) then
        BringWindowToTop(ActiveWindow);
    end;
  Application.Terminate;  
  Halt;
{ Application.Terminate;}
end;

Procedure TXAppControl.SetAliasNames(aItems: TStrings);
begin
  FAliasNames.Assign(aItems);
end;

Procedure TXAppControl.SetAliasDefs(aItems: TStrings);
begin
  FAliasDefs.Assign(aItems);
end;

Procedure CreateSystemAppControl;
begin
  if SystemAppControl=nil then begin
    SystemAppControl:=TXAppControl.Create(nil);
    SystemAppControl.InitAppControl;
  end;
end;

Procedure InitParams;
var i:byte;
begin
  DirShb:='';
  for i:=0 to ParamCount do
    if Pos('-DirShb=',ParamStr(i))>0 then begin
      DirShb:=Copy(ParamStr(i),9,255);
      Break;
    end;
  AliasName:='';
  for i:=0 to ParamCount do
    if Pos('-AliasName=',ParamStr(i))>0 then begin
      AliasName:=Copy(ParamStr(i),12,255);
      Break;
    end;
  Optimize:=false;
  for i:=0 to ParamCount do
    if Pos('-Optimize',ParamStr(i))>0 then begin
      Optimize:=true;
      Break;
    end;
  MessageInOptimize:=false;
  for i:=0 to ParamCount do
    if Pos('-MessageInOptimize',ParamStr(i))>0 then begin
      MessageInOptimize:=true;
      Break;
    end;
end;

var OldFindGlobalComponent: TFindGlobalComponent=nil;

Function XFindGlobalComponent(const Name: string): TComponent; far;
var i: Integer;
begin
  Result:= OldFindGlobalComponent(Name);
  if (not Assigned(Result)) and Assigned(SystemAppControl) then begin
    i:= SystemAppControl.AliasNames.IndexOf(Name);
    if (i<>-1) and (i<SystemAppControl.AliasDefs.Count) then begin
      Result:= OldFindGlobalComponent(SystemAppControl.AliasDefs[i]);
    end;
  end;
end;

Initialization
  InitParams;
  if Assigned(FindGlobalComponent) then begin
    OldFindGlobalComponent:= FindGlobalComponent;
    FindGlobalComponent:= XFindGlobalComponent;
  end;

Finalization
  if Assigned(SystemAppControl) then begin
    SystemAppControl.Free;
    SystemAppControl:=nil;
  end;
  if Assigned(OldFindGlobalComponent) then begin
    FindGlobalComponent:= OldFindGlobalComponent;
    OldFindGlobalComponent:=nil;
  end;
end.

