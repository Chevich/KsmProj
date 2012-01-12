{*******************************************************}
{                                                       }
{            X-library v.03.01                          }
{                                                       }
{   07.10.97        					}
{                                                       }
{   TToolsControl - component for instruments of forms  }
{   TFormControl - component for forms managing         }
{   TFormTools - external tools to TFormControl         }
{                                                       }
{  corrections  09.06.98                                }
{  maked property TFormControl.FormTools: TFormTools    }
{  (collected Popupmenu, Tools, ToolsActive)            }
{                                                       }
{   Last corrections 24.09.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit XTFC;

Interface

Uses WinProcs, Messages, Classes, Graphics, Controls,
     Menus, Forms, Dialogs, Buttons, ExtCtrls, DB, DBTables,
     XForms, XTools, XSplash, XMisc;

Const
{ TagBtn functions }
     btNone            = 0;
     btInform          = 0;
     btHelp            = 1;
     btDate            = 2;
     btPrint           = 3;
     btSetupPrint      = 4;
     btKeyFind         = 5;
     btCommonFind      = 6;
     btTempRec         = 7;
     btCloseFilter     = 8;
     btSum             = 9;
     btNormalClose     = 10;
     btFreeClose       = 11;
     btReturnClose     = 12;
     btRFreeClose      = 13;
     btExit            = 14;
     btReturnOpen      = 15;
     btSumDown         = 200; { Нажатие кнопки суммирования программно без др. действий }
     btSumUp           = 201; { Отжатие кнопки суммирования программно без др. действий }
     btStraightPrint   = 252;
     btPreviewPrint    = 253;
     btLocalSetupPrint = 254;
     btEnd             = 255;

type

  TFormControl = class;
  TToolsControl = class;

{ TUserMenuItem }

  TUserMenuItem = class(TMenuItem)
  private
    FOnClick: TNotifyEvent;
  protected
    procedure GoClick(Sender: TObject); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

{ TLinkMenuItem }

  TLinkMenuItem = class(TMenuItem)
  private
    FFormControl: TFormControl;
    FOnClick: TNotifyEvent;
    procedure SetFormControl(Value: TFormControl);
  protected
    procedure GoClick(Sender: TObject); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property FormControl: TFormControl read FFormControl write SetFormControl;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

{ TMainMenuItem }

  TMainMenuItem = class(TMenuItem)
  private
    FLinkMenuItem: TLinkMenuItem;
    FOnClick: TNotifyEvent;
    procedure SetLinkMenuItem(Value: TLinkMenuItem);
  protected
    procedure GoClick(Sender: TObject); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LinkMenuItem: TLinkMenuItem read FLinkMenuItem write SetLinkMenuItem;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  { TControlMenu }

  TControlMenu = class(TPopupMenu)
  private
    FInMain: Boolean;
    FInPopup: Boolean;
    FTools: TToolsControl;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ReadState(Reader: TReader); override;
    procedure Loaded; override;
    procedure Popup(X, Y: Integer); override;

  published
    property Tools: TToolsControl read FTools write FTools;
    property InMain: Boolean read FInMain write FInMain default True;
    property InPopup: Boolean read FInpopup write FInPopup default True;
  end;

  { TControlMainMenu }

  TControlMainMenu = class(TMainMenu)
  public
    procedure ReadState(Reader: TReader); override;
  end;

  { TToolsControl }

  TToolsInform = class(TPersistent)
  private
    FPicture: TPicture;
    FOrgName: String;
    FTaskName: String;
    FAuthorsName: String;
    FProductName, FVersion, FComments: string;
    procedure SetPicture(Value: TPicture);
  public
    constructor Create;
    destructor Destroy; override;
  published
    property ProductName: string read FProductName write FProductName;
    property Version: string read FVersion write FVersion;
    property Comments: string read FComments write FComments;
    property Picture: TPicture read FPicture write SetPicture;
    property OrgName: String read FOrgName write FOrgName;
    property TaskName: String read FTaskName write FTaskName;
    property AuthorsName: String read FAuthorsName write FAuthorsName;
  end;

  TBtnClickEvent=procedure (Sender: TFormControl; BtnTag: LongInt; BtnDown: Boolean) of object;

  TToolsControl = class(TComponent)
  private
    FViewProgress: Boolean;
    FIsSplashed: Boolean;
    FInformActive: Boolean;
    FActive: Boolean;
    FFlag: Boolean;
    FIsDefaults: Boolean;
    wVersion: Word;
    dVersion: Word;
    FOldActivate: TNotifyEvent;
    FCount: Integer;
    FInform: TToolsInform;
    winFlags: LongInt;
    FFormName: String;
    FSplashClass: String;
    FToolsForm: TForm;
    FSplashForm: TForm;
    FBtnSender: TSpeedButton;
    FOnBtnClick: TBtnClickEvent;
    procedure AppActivate(Sender: TObject);
    function SubFunc(Sender: TObject): Boolean;
  protected
    function GetToolsForm: TForm;
    function GetSplashForm: TForm;
    property Flag: Boolean read FFlag write FFlag;
    property BtnSender: TSpeedButton read FBtnSender write FBtnSender;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitSplash;
    procedure StepSplash;
    procedure ShowSplash;
    procedure HideSplash;

    function InformExecute: Boolean;
    procedure SubClick(Sender: TObject);virtual;
    procedure ToolsSubClick(Sender: TObject; AFC: TFormControl);
    procedure ToolsShow{(ACurrentControl: TFormControl)};
    procedure ToolsHide{(ACurrentControl: TFormControl)};
    procedure ToolsClose{(ACurrentControl: TFormControl; var Action: TCloseAction)};
    Function DataActivate:boolean; virtual;
    Function DataDeactivate:boolean; virtual;
    property ToolsForm: TForm read FToolsForm;
  published
    property InformActive: Boolean read FInformActive write FInformActive default False;
    property Inform: TToolsInform read FInform write FInform;
    property SplashCount: Integer read FCount write FCount default 0;
    property IsSplashed: Boolean read FIsSplashed write FIsSplashed default False;
    property ViewProgress: Boolean read FViewProgress write FViewProgress default False;
    property SplashClass: String read FSplashClass write FSplashClass;
    property FormName: String read FFormName write FFormName;
    property IsDefaults: Boolean read FIsDefaults write FIsDefaults default False;
    property OnBtnClick: TBtnClickEvent read FOnBtnClick write FOnBtnClick;
  end;
{ TToolsControl }

{  TFormControl }

  TFormRect = class(TPersistent)
  private
    FActive: Boolean;
    FFormLeft:Integer;
    FFormTop: Integer;
    FFormWidth: Integer;
    FFormHeight: Integer;
    FPageIndex: Integer;
  public
    constructor Create;
  published
    property Active: Boolean read FActive write FActive Default True;
    property FormLeft:Integer read FFormLeft write FFormLeft default 200;
    property FormTop: Integer read FFormTop write FFormTop default 108;
    property FormWidth: Integer read FFormWidth write FFormWidth default 435;
    property FormHeight: Integer read FFormHeight write FFormHeight default 300;
    property PageIndex: Integer read FPageIndex write FPageIndex default 1;
  end;
{ TFormControl }

  TFormTools = class(TPersistent)
  private
    FToolsActive: Boolean;
    FControl: TFormControl;
    FTools: TToolsControl;
    FPopupMenu: TPopupMenu;
    procedure SetToolsActive(Value: Boolean);
    procedure ChangeToolsVisible(Value: Boolean);
    procedure ControlSysEvent(var Message: TWMSysCommand);
    procedure SetTools(Const ATools: TToolsControl);
  protected
    procedure ToolsChanged; virtual;
  public
    constructor Create(AControl: TFormControl);
    procedure SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);virtual;
    procedure ToolsSubClick(Sender: TObject);
    procedure ChangeHint(ATag: Integer; AHint: String);
    procedure Close;
    { Перерисовывает панель инструментов в новом месте согласно ккординат формы }
    procedure Update;
    procedure Activate;
    procedure Deactivate;
    property Control: TFormControl read FControl;
  published
    property ToolsActive: Boolean read FToolsActive write SetToolsActive default True;
    property Tools: TToolsControl read FTools write SetTools;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
  end;
{ TFormTools }

  TFormControl = class(TXLibControl)
  private
    FActive: Boolean;
    FDefModal: Boolean;
    FIsAutoEqual: Boolean;
    FIsReturnControl: Boolean;
    FFormName: String;
    FFormRect: TFormRect;
    FFormTools: TFormTools;
    FMenuItem: TLinkMenuItem;
    FReturnForm: TForm;
    FOpenReturnControl: TFormControl;
    FForm: TForm;
    FHelpContext: THelpContext;
    FCaption: String;
    FOnCreateForm: TNotifyEvent;
    FOnDestroyForm: TNotifyEvent;
    FOnActivateForm: TNotifyEvent;
    FOnDeactivateForm: TNotifyEvent;
    FOnCloseForm: TCloseEvent;
    FOnCloseQueryForm: TCloseQueryEvent;
    procedure SetActive(Value: Boolean);
    procedure SetCaption(Const Value: String);
    procedure SetMenuItem(Value: TLinkMenuItem);
{    procedure SetFormLink(Value: TFormLink);}
{    function IsFormLink: Boolean;}
  protected
    function GetDefaultClass: String; virtual;
    procedure ActivateTools; dynamic;
    procedure DeactivateTools; dynamic;
    function CreateTools: TFormTools; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadState(Reader: TReader); override;
    procedure ChangeCaption; virtual; abstract;
    procedure Loaded; override;
    procedure CreateLink; dynamic;
    function ChildFormCreate: Boolean;
    procedure CreateForms; dynamic;
    procedure DestroyForms; dynamic;
    procedure ActivateForm; virtual;
    procedure DeactivateForm; virtual;
    procedure ReturnSubClose; virtual;
    procedure GetToolStrings(ATag: Integer; AStrings: TStrings); virtual;
    procedure CloseForm(var Action: TCloseAction);
    procedure CloseQueryForm(var CanClose: Boolean);
    procedure Execute; virtual;
    procedure ReturnExecute; virtual;
    procedure SubClick(Sender: TObject);virtual;
    procedure ReturnFormShow; virtual;
    procedure PlayQueryFromKey(Index:byte); virtual;

    property Form: TForm read FForm write FForm;
    property IsAutoEqual: Boolean read FIsAutoEqual write FIsAutoEqual;
{    property FormLink: TFormLink read FFormLink write SetFormLink Stored IsFormLink;}
    property IsReturnControl: Boolean read FIsReturnControl write FIsReturnControl;
    property ReturnForm: TForm read FReturnForm write FReturnForm;
    property OpenReturnControl: TFormControl read FOpenReturnControl write FOpenReturnControl;
  published
    property Active: Boolean read FActive write SetActive default False;
    property DefModal: Boolean read FDefModal write FDefModal default False;
    property HelpContext: THelpContext read FHelpContext write FHelpContext;
    property FormName: String read FFormName write FFormName;
    property FormRect: TFormRect read FFormRect write FFormRect;
    property FormTools: TFormTools read FFormTools write FFormTools;
    property MenuItem: TLinkMenuItem read FMenuItem write SetMenuItem stored False;
    property OnCreateForm: TNotifyEvent read FOnCreateForm write FOnCreateForm;
    property OnDestroyForm: TNotifyEvent read FOnDestroyForm write FOnDestroyForm;
    property OnActivateForm: TNotifyEvent read FOnActivateForm write FOnActivateForm;
    property OnDeactivateForm: TNotifyEvent read FOnDeactivateForm write FOnDeactivateForm;
    property OnCloseForm: TCloseEvent read FOnCloseForm write FOnCloseForm;
    property OnCloseQueryForm: TCloseQueryEvent read FOnCloseQueryForm write FOnCloseQueryForm;
    property Caption: String read FCaption write SetCaption;
  end;
{ TFormControl }

  TSystemMenuItemProc = Function :Boolean;

Var LastFormControl: TFormControl = nil;
    MainFormControl: TFormControl = nil;
    SystemControlMenu: TControlMenu = nil;
    SystemMainMenu: TMainMenu;
    SystemMenuItemProc: TSystemMenuItemProc = nil;
    SystemMenuItemObject: TObject = nil;
    ComputerName: string[30];

Implementation

Uses SysUtils, DBCtrls, DBIndex, XAbout, Misc;

var Buffer: Array[1..60] of Char;
    P: PChar;
    Len: DWord;

{ TUserMenuItem }

Constructor TUserMenuItem.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Inherited OnClick:=GoClick;
end;

Procedure TUserMenuItem.GoClick(Sender: TObject);
begin
  if Assigned(SystemMenuItemProc) then begin
    if not SystemMenuItemProc then
      if Assigned(FOnClick) then FOnClick(Sender);
  end else
    if Assigned(FOnClick) then FOnClick(Sender);
end;

{ TLinkMenuItem }

Constructor TLinkMenuItem.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FFormControl:=nil;
  Inherited OnClick:=GoClick;
end;

Destructor TLinkMenuItem.Destroy;
begin
  if Assigned(FFormControl) then FFormControl.FMenuItem:=nil;
  Inherited Destroy;
end;

Procedure TLinkMenuItem.GoClick(Sender: TObject);
begin
  {if not(Sender is TLinkMenuItem) then Exit;}
  if Assigned(FOnClick) then FOnClick(Sender);
  if Assigned(FFormControl) then FFormControl.Execute;
end;

Procedure TLinkMenuItem.SetFormControl(Value: TFormControl);
begin
  if FFormControl<>Value then begin
    if Assigned(FFormControl) then begin
{     if Assigned(FFormControl.FMenuItem)and()}
      FFormControl.FMenuItem:=nil;
    end;
    FFormControl:=Value;
    if Value<>nil then Value.MenuItem:=Self;
  end;
end;

{ TMainMenuItem }

Constructor TMainMenuItem.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FLinkMenuItem:=nil;
  Inherited OnClick:=GoClick;
end;

Procedure TMainMenuItem.GoClick(Sender: TObject);
begin
  if Assigned(FOnClick) then FOnClick(Sender);
  if Assigned(FLinkMenuItem) then FLinkMenuItem.GoClick(Sender);
end;

Procedure TMainMenuItem.SetLinkMenuItem(Value: TLinkMenuItem);
begin
  if FLinkMenuItem<>Value then begin
    FLinkMenuItem:=Value;
  end;
end;

{ TToolsInform }

Constructor TToolsInform.Create;
begin
  Inherited Create;
  FPicture:= TPicture.Create;
{  FOrgName:=DefaultOrganization;
  FTaskName:='';
  FAuthorsName:=DefaultAuthors;}
end;

Destructor TToolsInform.Destroy;
begin
  FPicture.Free;
  FPicture:=nil;
  Inherited Destroy;
end;

Procedure TToolsInform.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

{ TToolsControl }

Constructor TToolsControl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FInform:= TToolsInform.Create;
  FViewProgress:=False;
  FIsSplashed:=False;
  FFormName:= tcDefaultClass;
  FSplashClass:= scDefaultClass;
end;

Destructor TToolsControl.Destroy;
begin
  FInform.Free;
  FInform:=nil;
  Inherited Destroy;
end;

Function TToolsControl.GetToolsForm: TForm;
var i: Integer;
    Instance: TComponent;
    InstanceClass: TComponentClass;
begin
  if not(csDesigning in ComponentState) then begin
    if FFormName='' then Result:=nil
    else begin
      i:=RegisterXToolList.IndexOf(FFormName);
      if i=-1 then begin
        ShowMessage('Error XTool('+Name+') registration');
        Result:=nil;
        Application.Terminate;
        {Halt;}
      end else begin
        InstanceClass:=TXToolClass(RegisterXToolList.Objects[i]);
        Instance := TComponent(InstanceClass.NewInstance);
        try
          Instance.Create(Self);
          Result:=TForm(Instance);
        except
          Result:=nil;
          Instance.Free;
          raise;
        end;
      end;
    end;
  end else Result:=nil;
end;

Function TToolsControl.GetSplashForm: TForm;
var i: Integer;
    Instance: TComponent;
    InstanceClass: TComponentClass;
begin
  if not(csDesigning in ComponentState) then begin
    if FSplashClass='' then Result:=nil
    else begin
      i:=RegisterXSplashList.IndexOf(FSplashClass);
      if i=-1 then begin
        ShowMessage('Error XSplash('+Name+') registration');
        Result:=nil;
        Application.Terminate;
        {Halt;}
      end else begin
        InstanceClass:=TXSplashClass(RegisterXSplashList.Objects[i]);
        Instance := TComponent(InstanceClass.NewInstance);
        try
          Instance.Create(Self);
          Result:=TForm(Instance);
        except
          Result:=nil;
          Instance.Free;
          raise;
        end;
      end;
    end;
  end else Result:=nil;
end;

Procedure TToolsControl.ToolsShow;
begin
  if not FActive then FActive:=True;
  if not TXToolForm(FToolsForm).IsLinkVisible then
  if not FToolsForm.Visible then begin
    FToolsForm.PopupMenu:= TFormControl(TXToolForm(FToolsForm).CurrentFormControl).Form.PopupMenu;
    TXToolForm(FToolsForm).IsLinkVisible:=True;
    FToolsForm.Visible:=True;
    if Assigned(TFormControl(TXToolForm(FToolsForm).CurrentFormControl).Form) then
      PostMessage(TFormControl(TXToolForm(FToolsForm).CurrentFormControl).Form.Handle,wm_SetFocus,0,0);
  end;
end;

Procedure TToolsControl.ToolsHide;
begin
  if not TXToolForm(FToolsForm).IsLinkVisible then begin
    if FActive then begin
      FToolsForm.Visible:=False;
    end;
  end;
end;

Procedure TToolsControl.ToolsClose;
begin
  TXToolForm(FToolsForm).IsLinkVisible:=False;
end;

Function TToolsControl.DataActivate:boolean;
begin
  if FFlag then begin
    if Assigned(FBtnSender) then SubClick(BtnSender);
    FFlag:=false;
    Result:=true;
  end else Result:=false;
end;

Function TToolsControl.DataDeactivate:boolean;
begin
  if FToolsForm.Active then begin
    FFlag:=True;
    BtnSender:=nil;
    Result:=true;
    Exit;
  end;
  Result:=false;
end;

Function TToolsControl.SubFunc(Sender: TObject): Boolean;
var BtnTag: LongInt;
begin
  Result:=False;
  BtnTag:=TComponent(Sender).Tag;
  case BtnTag of
    btInform: InformExecute;
    btNormalClose: if Assigned(FToolsForm) then TXToolForm(FToolsForm).SubClose;
    btReturnClose: if Assigned(FToolsForm) then TXToolForm(FToolsForm).ReturnSubClose;
    btReturnOpen: if Assigned(FToolsForm) then TXToolForm(FToolsForm).ReturnSubOpen;
    btExit: if Assigned(FToolsForm) then TXToolForm(FToolsForm).SubExit;
    else Result:=True;
  end;
end;

Procedure TToolsControl.SubClick(Sender: TObject);
var FC: TFormControl;
begin
  if SubFunc(Sender) then begin
    FC:=TFormControl(TXToolForm(TComponent(Sender).Owner{GetParentForm(TControl(Sender))}).CurrentFormControl);
    if Assigned(FC) then begin
      if FIsDefaults then FC.SubClick(Sender);
      if Assigned(FOnBtnClick) then
        FOnBtnClick(FC, TComponent(Sender).Tag, (Sender is TSpeedButton)and TSpeedButton(Sender).Down);
    end;
  end;
end;

Procedure TToolsControl.ToolsSubClick(Sender: TObject; AFC: TFormControl);
begin
  if SubFunc(Sender) and Assigned(AFC) then begin
    if FIsDefaults then AFC.SubClick(Sender);
    if Assigned(FOnBtnClick) then
      FOnBtnClick(AFC,TComponent(Sender).Tag,
        (Sender is TSpeedButton) and TSpeedButton(Sender).Down);
  end;
end;

Procedure TToolsControl.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
  InitSplash;
  Try
    FToolsForm:=GetToolsForm
  except
    ShowMessage('Error Tools form create!');
    raise;
  end;
end;

Procedure TToolsControl.InitSplash;
begin
  if FIsSplashed and (not(csDesigning in ComponentState)) and (not Assigned(FSplashForm)) then begin
    try
      FSplashForm:=GetSplashForm
    except
      ShowMessage('Error Splash form create!');
      raise;
    end;
    FOldActivate:=Application.OnActivate;
    Application.OnActivate:=AppActivate;
    FSplashForm.Show;
  end;
  if Assigned(FSplashForm) then
    with TXSplashForm(FSplashForm) do begin
      if FInformActive then begin
        XHardLabel:=FInform.OrgName;
        XTaskLabel:=FInform.TaskName;
        XAutsLabel:=FInform.AuthorsName;
        if Assigned(FInform.Picture.Graphic) then XImage.Picture.Assign(FInform.Picture);
      end;
      VisProgress:=FViewProgress;
      XProgress:=0;
      XProgressCount:=FCount;
      Update;
    end;
end;

Procedure TToolsControl.StepSplash;
begin
  if Assigned(FSplashForm) then TXSplashForm(FSplashForm).AutoSplash;
end;

Procedure TToolsControl.ShowSplash;
begin
  if Assigned(FSplashForm) then FSplashForm.Show;
end;

Procedure TToolsControl.HideSplash;
begin
  if Assigned(FSplashForm) then FSplashForm.Hide;
end;

Function TToolsControl.InformExecute: Boolean;

var Syst:TSystemInfo;
    OS: TOSVersionInfo;
    Status: TMemoryStatus;
begin
  if (not Assigned(AboutBox)) and InformActive then begin
    AboutBox := TAboutBox.Create(Application);
  end;

  { Set dialog strings }
  if Application.Title='' then
    AboutBox.ProductName.Caption := FInform.ProductName
  else AboutBox.ProductName.Caption := Application.Title;
  AboutBox.Version.Caption := FInform.Version;
  AboutBox.Copyright.Caption := FInform.AuthorsName;
  AboutBox.Comments.Caption := FInform.Comments;
  AboutBox.Caption := 'О программе ';

  { Get Win/Dos version numbers }
  OS.dwOSVersionInfoSize:=SizeOf(TOSVersionInfo);
  GetVersionEx(OS);
  wVersion := LoWord(OS.dwMajorVersion);
  dVersion := HiWord(OS.dwMajorVersion);
  AboutBox.WinVersion.Caption := IntToStr(LO(wVersion)) + '.' +
                                 IntToStr(HI(wVersion));

  P:=Addr(Buffer);  Len:=60;
  GetUserName(P,Len);
  AboutBox.UserName.Caption:=Buffer;

  AboutBox.ComputerName.Caption :=ComputerName;

  GetSystemInfo(Syst);
  WinFlags:=Syst.dwProcessorType;
  { Get CPU type }
  case WinFlags of
    386: AboutBox.CPU.Caption := 'Intel 386';
    486: AboutBox.CPU.Caption := 'Intel 486';
    586: AboutBox.CPU.Caption := 'Intel Pentium';
  end;

  AboutBox.FreeDisk.Caption := IntToStr(DiskFree(3) div 1000000) + ' MB';
  Status.dwLength:=SizeOf(TMemoryStatus);
  GlobalMemoryStatus(Status);
  AboutBox.TotalSpace.Caption := IntToStr(Status.dwTotalPhys);
  AboutBox.PercentUse.Caption := IntToStr(Status.dwMemoryLoad)+'%';
  with AboutBox do begin
    ProgramIcon.Picture.Graphic := Application.Icon;
    Result := (ShowModal = IDOK);
  end;
end;

Procedure TToolsControl.AppActivate(Sender: TObject);
begin
  if Assigned(FSplashForm) and isAppActive then begin
    FSplashForm.Hide;
    FSplashForm.Release;
    FSplashForm:=nil;
    Application.OnActivate:=FOldActivate;
  end;
end;

{ TControlMenu }

Constructor TControlMenu.Create(AOwner: TComponent);
begin
  Inherited;
  FInMain:= True;
  FInPopup:= True;
end;

Procedure TControlMenu.ReadState(Reader: TReader);
var i: Integer;
    It: TMenuItem;

  procedure MainAdd(AM, BM: TMenuItem);
  var CM: TMenuItem;
      k,l: Integer;
  begin
    for k:=0 to BM.Count-1 do begin
      if AM.Caption=BM.Items[k].Caption then begin
        CM:=BM.Items[k];
        for l:=0 to AM.Count-1 do begin
          It:=AM.Items[0];
          AM.Delete(0);
          MainAdd(It,CM);
        end;
        Exit;
      end;
    end;
    BM.Add(AM);
{
    BM.OnClick:=AM.OnClick;
    BM.OnDrawItem:=AM.OnDrawItem;
    BM.OnMeasureItem:=AM.OnMeasureItem;
}
    BM.Items[BM.Count-1].OnClick:=AM.OnClick;
    BM.Items[BM.Count-1].OnDrawItem:=AM.OnDrawItem;
    BM.Items[BM.Count-1].OnMeasureItem:=AM.OnMeasureItem;
  end;

  procedure MainDup(AM, BM: TMenuItem);
  var CM: TMenuItem;
      k,l: Integer;
  begin
    for k:=0 to BM.Count-1 do begin
      if AM.Caption=BM.Items[k].Caption then begin
        CM:=BM.Items[k];
        for l:=0 to AM.Count-1 do begin
          MainDup(AM.Items[l],CM);
        end;
        Exit;
      end;
    end;

    if AM is TLinkMenuItem then begin
      CM:=TMainMenuItem.Create(Nil);
      TMainMenuItem(CM).LinkMenuItem:=TLinkMenuItem(AM);
    end else if AM is TMenuItem then CM:=TMenuItem.Create(nil);
    if Assigned(CM) then begin
      CM.Break:=AM.Break;
      CM.Caption:=AM.Caption;
      CM.Checked:=AM.Checked;
      CM.Default:=AM.Default;
      CM.Enabled:=AM.Enabled;
      CM.GroupIndex:=AM.GroupIndex;
      CM.HelpContext:=AM.HelpContext;
      CM.Hint:=AM.Hint;
      CM.RadioItem:=AM.RadioItem;
      CM.ShortCut:=AM.ShortCut;
      CM.Tag:=AM.Tag;
      CM.Visible:=AM.Visible;
      CM.Name:=AM.Name;
   { Lev 26.03.99 }
      CM.OnClick:=AM.OnClick;
      CM.OnDrawItem:=AM.OnDrawItem;
      CM.OnMeasureItem:=AM.OnMeasureItem;
   { Lev }
      for k:=0 to AM.Count-1 do begin
        MainDup(AM.Items[k],CM);
      end;
      BM.Add(CM);
    end;
  end;

begin
  Inherited ReadState(Reader);
  if not (csDesigning in ComponentState) then begin
    if Assigned(SystemControlMenu) then begin
      for i:=0 to Items.Count-1 do begin
        It:=Items[0];
        if FInMain then MainDup(It,SystemMainMenu.Items);
        Items.Delete(0);
        if FInPopup then MainAdd(It,SystemControlMenu.Items);
      end;
{     It:= TMenuItem.Create(Owner);
      It.Caption:='Hello';
      Items.Add(It);}
    end;
  end;
end;

Procedure TControlMenu.Loaded;
var i: Integer;
    Fr: TFormControl;
begin
  Inherited Loaded;
  if not (csDesigning in ComponentState) then
    if Assigned(SystemControlMenu) then begin
      if Assigned(Tools) then SystemControlMenu.Tools:=Tools;
      for i:=0 to Owner.ComponentCount-1 do
        if Owner.Components[i] is TFormControl then begin
          Fr:=Owner.Components[i] as TFormControl;
          if Fr.FormTools.FPopupMenu=Self then begin
            Fr.FormTools.FPopupMenu:=SystemControlMenu;
            if not Assigned(Fr.FormTools.Tools) then
              Fr.FormTools.Tools:=SystemControlMenu.Tools;
          end;
        end;
{     Free;}
    end;
end;

Procedure TControlMenu.Popup(X, Y: Integer);
begin
  if Self=SystemControlMenu then inherited
  else {inherited;}
    if Assigned(SystemControlMenu) then SystemControlMenu.Popup(X, Y);
end;

{ TControlMainMenu }

Procedure TControlMainMenu.ReadState(Reader: TReader);
var i: Integer;
    It: TMenuItem;
begin
  Inherited ReadState(Reader);
  if not (csDesigning in ComponentState) then begin
    for i:=0 to SystemMainMenu.Items.Count-1 do begin
      It:=SystemMainMenu.Items[0];
      SystemMainMenu.Items.Delete(0);
      Items.Add(It);
    end;
  end;
end;

{ TFormRect }

Constructor TFormRect.Create;
begin
  Inherited;
  FActive:=True;
  FFormLeft:= 200;
  FFormTop:= 108;
  FFormWidth:= 435;
  FFormHeight:= 300;
  FPageIndex:= 1;
end;

{ TFormTools }

Constructor TFormTools.Create(AControl: TFormControl);
begin
  Inherited Create;
  FControl:= AControl;
  FToolsActive:=True;
end;

Procedure TFormTools.SetTools(const ATools: TToolsControl);
begin
  if ATools<>FTools then begin
    FTools:= ATools;
    ToolsChanged;
  end;
end;

Procedure TFormTools.ToolsChanged;
begin
end;

Procedure TFormTools.SetToolsActive(Value: Boolean);
begin
  if FToolsActive<>Value then begin
    FToolsActive:=Value;
    ChangeToolsVisible(Value);
  end;
end;

Procedure TFormTools.ChangeToolsVisible(Value: Boolean);
{var Action: TCloseAction;}
begin
  if Assigned(FTools) then
    if Value then FTools.ToolsShow{(Self)}
    else begin
{     Action:=caHide;}
      FTools.ToolsClose{(Self, Action)};
      FTools.ToolsHide{(Self)};
    end;
end;

Procedure TFormTools.SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);
begin
  if Assigned(FTools) and Assigned(FTools.FToolsForm) then
    TXToolForm(FTools.FToolsForm).SetConfigParams(IsReturnClose, IsReturnOpen);
end;

Procedure TFormTools.ChangeHint(ATag: Integer; AHint: String);
begin
  if Assigned(FTools) and Assigned(FTools.FToolsForm) then
    TXToolForm(FTools.FToolsForm).ChangeHint(ATag, AHint);
end;

Procedure TFormTools.ControlSysEvent(var Message: TWMSysCommand);
var i,j: Integer;
begin
  if (Message.CmdType and $FFF0 = SC_MINIMIZE) then
  if Assigned(FTools) then begin
    for i:=0 to Screen.FormCount-1 do begin
      if Screen.Forms[i]=FTools.FToolsForm then begin
        for j:=i+1 to Screen.FormCount-1 do
          if (Screen.Forms[j].Visible) and (Screen.Forms[j].WindowState<>wsMinimized) then begin
            Postmessage(Screen.Forms[j].Handle,wm_SetFocus,0,0);
            Exit;
          end;
          for j:=0 to i-1 do
            if (Screen.Forms[j].Visible) and (Screen.Forms[j].WindowState<>wsMinimized) then begin
              PostMessage(Screen.Forms[j].Handle,wm_SetFocus,0,0);
              Exit;
            end;
          Break;
      end;
    end;
{   FTools.FToolsForm.Sendtoback;}
  { Action:=caHide;
    FTools.ToolsClose(Self, Action);
    FTools.ToolsHide(Self);}
  end;
end;

Procedure TFormTools.ToolsSubClick(Sender: TObject);
begin
  if Assigned(FTools) then FTools.ToolsSubClick(Sender, FControl);
end;

Procedure TFormTools.Update;
begin
  FTools.ToolsHide;
  if Assigned(FControl.FForm) then
    if TXToolForm(FTools.FToolsForm).Horizontal then begin
      FTools.FToolsForm.Left:=0;
      FTools.FToolsForm.Top:=0;
    end else begin
      FTools.FToolsForm.Left:=FControl.FForm.Left+FControl.FForm.Width;//-5;
      FTools.FToolsForm.Top:=FControl.FForm.Top;
    end;
  FTools.ToolsShow;
end;

Procedure TFormTools.Activate;
begin
  if Assigned(FTools) then
    if TXToolForm(FTools.FToolsForm).CurrentFormControl <> FControl then begin
      if Assigned(TXToolForm(FTools.FToolsForm).CurrentFormControl) then
        TFormControl(TXToolForm(FTools.FToolsForm).CurrentFormControl).DeactivateTools;
      FControl.ActivateTools;
      TXToolForm(FTools.FToolsForm).IsLinkVisible:=False; {!!!?}
      FTools.ToolsHide{(TFormControl(TXToolForm(FTools.FToolsForm).CurrentFormControl))};
      TXToolForm(FTools.FToolsForm).CurrentFormControl:=FControl;
      if Assigned(FControl.FForm) then
        if TXToolForm(FTools.FToolsForm).Horizontal then begin
          FTools.FToolsForm.Left:=0;
          FTools.FToolsForm.Top:=0;
        end else begin
          FTools.FToolsForm.Left:=FControl.FForm.Left+FControl.FForm.Width;//-5
          FTools.FToolsForm.Top:=FControl.FForm.Top;
        end;
    end;

  if Assigned(LastFormControl) and (LastFormControl<>FControl) and
  Assigned(LastFormControl.FFormTools.FTools) then begin
{   Action:=caHide;}
    LastFormControl.FFormTools.FTools.ToolsClose{(LastFormControl, Action)};
    LastFormControl.FFormTools.FTools.ToolsHide{(LastFormControl)};
  end;
  ChangeToolsVisible(FToolsActive);
end;

Procedure TFormTools.Deactivate;
begin
  if Assigned(FTools){ and FToolsActive }then begin
    FTools.ToolsHide{(Self)};
  end;
end;

Procedure TFormTools.Close;
begin
  if Assigned(FTools) then FTools.ToolsClose{(Self, Action)};
end;

{  TFormControl }

Constructor TFormControl.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FMenuItem:=nil;
  FForm:=nil;
  FActive:=False;
  FIsReturnControl:=False;
  FFormRect:=TFormRect.Create;
  FFormTools:=CreateTools;
  FReturnForm:=nil;
  FOpenReturnControl:=nil;
  FIsAutoEqual:=False;
  FFormName:=GetDefaultClass;
end;

Function TFormControl.GetDefaultClass: String;
begin
  Result:= fcDefaultClass;
end;

Destructor TFormControl.Destroy;
begin
  if Assigned(FMenuItem) then FMenuItem.FFormControl:=nil;
{ if Assigned(FForm) then begin
    FForm.Free;
    FForm:=Nil;
  end;}
{? FReturnForm}
  FFormTools.Free;
  FFormRect.Free;
  Inherited Destroy;
end;

Function TFormControl.CreateTools: TFormTools;
begin
  Result:= TFormTools.Create(Self);
end;

Procedure TFormControl.ReturnSubClose;
begin
end;

Procedure TFormControl.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
{  if Assigned(FTools)and Assigned(FTools.FSplashForm) then
     TXSplashForm(FTools.FSplashForm).AutoSplash;}
  if FormName='FormStart' then MainFormControl:=Self;
  if Assigned(SystemSplashForm) then SystemSplashForm.AutoSplash;
end;

Procedure TFormControl.Loaded;
begin
  Inherited Loaded;
{  if Assigned(FTools)and Assigned(FTools.FSplashForm) then
     TXSplashForm(FTools.FSplashForm).AutoSplash;}
  if Assigned(SystemSplashForm) then SystemSplashForm.AutoSplash;
end;

Function TFormControl.ChildFormCreate: Boolean;
var i: Integer;
    Instance: TComponent;
    InstanceClass: TComponentClass;
begin
  Result:=True;
  if FFormName='' then TXForm.Create(Self)
  else begin
    i:=RegisterXFormList.IndexOf(FFormName);
    if i=-1 then begin
      ShowMessage('Error XForm('+Name+') registration');
      Result:=False;
    end else begin
      InstanceClass:=TXFormClass(RegisterXFormList.Objects[i]);
      Instance := TComponent(InstanceClass.NewInstance);
{     TComponent(Reference) := Instance;}
      try
        Instance.Create(Self);
      except
        Result:=False;
{       TComponent(Reference) := nil;}
        if not(csDestroying in Instance.ComponentState) then Instance.Free;
        Abort;
        {raise;}
      end;
    end;
  end;
end;

Procedure TFormControl.CreateForms;
begin
  if Assigned(FOnCreateForm) then FOnCreateForm(Self);
end;

Procedure TFormControl.DestroyForms;
begin
  if Assigned(FOnDestroyForm) then FOnDestroyForm(Self);
end;

Procedure TFormControl.SetCaption(Const Value: String);
begin
  if Value<>FCaption then begin
    FCaption:=Value;
    if Assigned(FForm) then FForm.Caption:=Value;
  end;
  ChangeCaption;
end;

Procedure TFormControl.SetActive(Value: Boolean);
begin
  if FActive<>Value then FActive:=Value;
end;

Procedure TFormControl.SubClick(Sender: TObject);
begin
  case TComponent(Sender).Tag of
    btHelp: Application.HelpContext(HelpContext);
  end;
end;

(*
function TFormControl.IsFormLink: Boolean;
begin
  Result:=Assigned(FFormLink);
end;

procedure TFormControl.SetFormLink(Value: TFormLink);
begin
  if FFormLink<>Value then begin
     if FFormLink<>Nil then begin
        if Assigned(FFormLink) then
           if Not (csDesigning in ComponentState) then
              TXForm(FFormLink.Owner).SysEvent:=Nil;
           FFormLink.LinkControl:=Nil;
        end;
     FFormLink:=Value;
     if Value<>Nil then begin
        Value.FreeNotification(Self);
        if Assigned(FFormLink) then begin
           FForm:= TForm(FFormLink.Owner);
           FFormLink.LinkControl:=Self;
           if Not (csDesigning in ComponentState) then
              TXForm(FFormLink.Owner).SysEvent:=ControlSysEvent;
           end;
        end;{ else FForm:=Nil;}
     end;
end;
*)

Procedure TFormControl.SetMenuItem(Value: TLinkMenuItem);
begin
  if FMenuItem<>Value then begin
    if FMenuItem<>nil then FMenuItem.FFormControl:=nil;
    FMenuItem:=Value;
    if Value<>nil then Value.FormControl:=Self;
  end;
end;

Procedure TFormControl.CreateLink;
begin
  if Assigned(FForm)then begin
    Form.PopupMenu:= FFormTools.FPopupMenu;
    if not Assigned(FForm.ActiveControl) then
      FForm.ActiveControl:=TXForm(FForm).DefaultXControl;
    if not (csDesigning in ComponentState) then
      TXForm(FForm).SysEvent:=FormTools.ControlSysEvent;
  end
end;

Procedure TFormControl.Execute;
begin
  if FActive then begin
    if not Assigned(FForm) then begin
      FIsAutoEqual:=True;
      if not ChildFormCreate then Exit;
    end;
    Form.WindowState:=wsNormal;
    if ((Screen.ActiveForm<>Form) or (not Screen.ActiveForm.Visible)) then begin
      {Application.ProcessMessages;}
      if FDefModal then Form.ShowModal else Form.Show;
    end;
  end;
end;

Procedure TFormControl.ReturnExecute;
begin
  Execute;
end;

Procedure TFormControl.ReturnFormShow;
begin
end;

Procedure TFormControl.PlayQueryFromKey(Index:byte);
begin
end;

Procedure TFormControl.ActivateTools;
begin
end;

Procedure TFormControl.DeactivateTools;
begin
end;

Procedure  TFormControl.ActivateForm;
var Action: TCloseAction;
begin
  if Assigned(FForm)then if FForm=Application.MainForm then
    FForm.Caption:=Application.Title
  else FForm.Caption:=FCaption;
  if Assigned(FForm.ActiveControl) then FForm.ActiveControl.SetFocus;
  if Assigned(FOnActivateForm) then FOnActivateForm(Self);
  FFormTools.Activate;
end;

Procedure TFormControl.DeactivateForm;
begin
  {if Assigned(FForm)then FActiveControl:=FForm.ActiveControl;}
  FFormTools.Deactivate;
  if Assigned(FOnDeactivateForm) then FOnDeactivateForm(Self);
  LastFormControl:=Self;
  CurrentXControl:=nil;
end;

Procedure  TFormControl.CloseForm;
begin
  FFormTools.Close;
  if Assigned(FOnCloseForm) then FOnCloseForm(Self, Action);
  DeactivateTools;
end;

Procedure  TFormControl.CloseQueryForm;
begin
  if Assigned(FOnCloseQueryForm) then FOnCloseQueryForm(Self, CanClose);
end;

Procedure TFormControl.GetToolStrings(ATag: Integer; AStrings: TStrings);
begin
end;

Initialization
  RegisterClasses([TLinkMenuItem, TUserMenuItem]);
  SystemControlMenu:= TControlMenu.Create(nil);
  SystemMainMenu:= TMainMenu.Create(nil);
  {P:=Addr(Buffer); Len:=60;
  GetComputerName(P,Len);}
  ComputerName:=GetSystemComputerName

Finalization
  SystemControlMenu.Free;
  SystemMainMenu.Free;
end.
