{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Visual components                             }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgCtrls;

interface
uses Windows, Messages, Classes, Graphics, Controls, Menus, StdCtrls, Buttons,
  ExtCtrls, ComCtrls, Forms;

type

{ TvgSplitter }
  TvgSplitter = class(TGraphicControl)
  private
    FLineDC: HDC;
    FDownPos: TPoint;
    FSplit: Integer;
    FMinSize: Cardinal;
    FMaxSize: Integer;
    FControl: TControl;
    FNewSize: Integer;
    FActiveControl: TWinControl;
    FOldKeyDown: TKeyEvent;
    FBeveled: Boolean;
    FLineVisible: Boolean;
    FOnMoved: TNotifyEvent;
    procedure AllocateLineDC;
    procedure DrawLine;
    procedure ReleaseLineDC;
    procedure UpdateSize(X, Y: Integer);
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetBeveled(Value: Boolean);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure StopSizing;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align default alLeft;
    property Beveled: Boolean read FBeveled write SetBeveled default True;
    property Color;
    property MinSize: Cardinal read FMinSize write FMinSize default 30;
    property ParentColor;
    property Visible;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
  end;

const
  scDefButtonShortCut = scAlt + VK_DOWN;

type
  TGlyphKind = (gkCustom, gkDropDown);

{ TCustomClickEdit }
  TCustomClickEdit = class(TCustomEdit)
  private
    FAlignment: TAlignment;
    FButton: TSpeedButton;
    FBtnControl: TWinControl;
    FButtonShortCut: TShortCut;
    FCanvas: TControlCanvas;
    FFocused: Boolean;
    FCaret: Boolean;
    FGlyphKind: TGlyphKind;
    FOnButtonClick: TNotifyEvent;
    procedure EditButtonClick(Sender: TObject);
    function GetButtonEnabled: Boolean;
    function GetButtonVisible: Boolean;
    function GetButtonWidth: Integer;
    function GetGlyph: TBitmap;
    function GetNumGlyphs: TNumGlyphs;
    function IsCustomGlyph: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetButtonEnabled(Value: Boolean);
    procedure SetButtonWidth(Value: Integer);
    procedure SetButtonVisible(Value: Boolean);
    procedure SetCaret(Value: Boolean);
    procedure SetEditRect;
    procedure SetFocused(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphKind(Value: TGlyphKind);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure ButtonClick; dynamic;
    procedure ButtonReleased; dynamic;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetTextMargins: TPoint;
    function IsCombo: Boolean; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    property Alignment: TAlignment read FAlignment write SetAlignment;
    property ButtonEnabled: Boolean read GetButtonEnabled write SetButtonEnabled default True;
    property ButtonShortCut: TShortCut read FButtonShortCut write FButtonShortCut default scDefButtonShortCut;
    property ButtonVisible: Boolean read GetButtonVisible write SetButtonVisible default True;
    property ButtonWidth: Integer read GetButtonWidth write SetButtonWidth default 15;
    property Caret: Boolean read FCaret write SetCaret default True;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustomGlyph;
    property GlyphKind: TGlyphKind read FGlyphKind write SetGlyphKind default gkCustom;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property OnButtonClick: TNotifyEvent read FOnButtonClick write FOnButtonClick;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TClickEdit }
  TClickEdit = class(TCustomClickEdit)
  published
    property Alignment;
    property ButtonEnabled;
    property ButtonShortCut;
    property ButtonVisible;
    property ButtonWidth;
    property Caret;
    property Glyph;
    property GlyphKind;
    property NumGlyphs;
    property OnButtonClick;
{$IFDEF _D3_}
{$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property ImeMode;
    property ImeName;
{$ENDIF}
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property MaxLength;
    property OEMConvert;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF _D4_}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{ TJustifyEdit }
  TJustifyEdit = class(TClickEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ButtonVisible default False;
  end;

{ TCustomComboBoxEdit }
  TDropDownAlign = (daLeft, daRight);

  TCustomComboBoxEdit = class(TCustomClickEdit)
  private
    FDisplayEmpty: string;
    FDropDownAlign: TDropDownAlign;
    FDropDownHeight, FDropDownWidth: Integer;
    FDroppedDown: Boolean;
    FPopup, FPopupControl: TWinControl;
    procedure HidePopupControl;
    procedure ShowPopupControl;
    procedure SetDisplayEmpty(Value: string);
  protected
    procedure ButtonClick; override;
    procedure ButtonReleased; override;
    procedure CloseUp(Accept: Boolean);
    procedure CreatePopupControl(var Control: TWinControl); dynamic; abstract;
    procedure CreateWnd; override;
    procedure DoCloseUp(Accept: Boolean); dynamic;
    procedure DoShow; dynamic;
    procedure DropDown;
    procedure WndProc(var Message: TMessage); override;
    function IsCombo: Boolean; override;
    property DisplayEmpty: string read FDisplayEmpty write SetDisplayEmpty;
    property DropDownAlign: TDropDownAlign read FDropDownAlign write FDropDownAlign default daLeft;
    property DropDownHeight: Integer read FDropDownHeight write FDropDownHeight default 100;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth default 0;
    property DroppedDown: Boolean read FDroppedDown;
    property PopupControl: TWinControl read FPopupControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TTitlerPaintEvent = procedure (Sender: TObject; Canvas: TCanvas) of object;

{ TTitler }
  TTitler = class(TCustomPanel)
  private
    { Private declarations }
    FTitles: TStrings;
    FTimer: TTimer;
    FPosition: Integer;
    FStep: Integer;
    FOnPaintAfter, FOnPaintBefore: TTitlerPaintEvent;
    procedure DoTimer(Sender: TObject);
    function GetInterval: Integer;
    procedure SetInterval(Value: Integer);
    procedure SetStep(Value: Integer);
    procedure SetTitles(Value: TStrings);
    procedure TitlesChanged(Sender: TObject);
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Invalidate; override;
    procedure Reset;
    property Position: Integer read FPosition;
  published
    { Published declarations }
{$IFDEF _D3_}
{$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property ImeMode;
    property ImeName;
{$ENDIF}
    property Titles: TStrings read FTitles write SetTitles;
    property Interval: Integer read GetInterval write SetInterval default 50;
    property OnPaintAfter: TTitlerPaintEvent read FOnPaintAfter write FOnPaintAfter;
    property OnPaintBefore: TTitlerPaintEvent read FOnPaintBefore write FOnPaintBefore;
    property Step: Integer read FStep write SetStep default 1;
    property Align;
    property Alignment;
    property BevelInner;
    property BevelOuter default bvNone;
    property BevelWidth;
    property BorderStyle default bsSingle;
    property BorderWidth;
    property Color default clBlack;
    property Cursor;
    property Enabled;
    property Font;
    property Height;
    property HelpContext;
    property Hint;
    property Left;
    property Locked;
    property Name;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Tag;
    property Top;
    property Visible;
    property Width;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
{$IFDEF _D4_}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{$IFDEF _D4_}
{ TvgTabSheet }
  TvgTabSheet = class(TTabSheet)
  end;

{ TvgPageControl }
  TvgPageControl = class(TPageControl)
  end;
{$ELSE}

{ TvgTabSheet }
  TvgTabSheet = class(TTabSheet)
  private
    FImageIndex: Integer;
    procedure SetImageIndex(Value: Integer);
  protected
    procedure SetParent(AParent: TWinControl); override;
  published
    property ImageIndex: Integer read FImageIndex write SetImageIndex default 0;
  end;

  TTabPosition = (tpTop, tpBottom, tpLeft, tpRight);
  TTabStyle = (tsTabs, tsButtons, tsFlatButtons);

  TDrawTabEvent = procedure(Control: TCustomTabControl; TabIndex: Integer;
    const Rect: TRect; Active: Boolean) of object;
  TTabGetImageEvent = procedure(Sender: TObject; TabIndex: Integer;
    var ImageIndex: Integer) of object;

{ TvgPageControl }
  TvgPageControl = class(TPageControl)
  private
    { Private declarations }
    FCanvas: TCanvas;
    FHotTrack: Boolean;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FOwnerDraw: Boolean;
    FRaggedRight: Boolean;
    FTabPosition: TTabPosition;
    FStyle: TTabStyle;
    FOnDrawTab: TDrawTabEvent;
    FOnGetImageIndex: TTabGetImageEvent;
    procedure ImageListChange(Sender: TObject);
    procedure SetHotTrack(Value: Boolean);
    procedure SetImages(Value: TCustomImageList);
    procedure SetOwnerDraw(Value: Boolean);
    procedure SetRaggedRight(Value: Boolean);
    procedure SetTabPosition(Value: TTabPosition);
    procedure SetStyle(Value: TTabStyle);
    procedure TabsChanged;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
  protected
    { Protected declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DrawTab(TabIndex: Integer; const Rect: TRect; Active: Boolean); dynamic;
    function GetImageIndex(TabIndex: Integer): Integer; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateTabImages;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    property Images: TCustomImageList read FImages write SetImages;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw default False;
    property RaggedRight: Boolean read FRaggedRight write SetRaggedRight default False;
    property TabPosition: TTabPosition read FTabPosition write SetTabPosition default tpTop;
    property Style: TTabStyle read FStyle write SetStyle default tsTabs;
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
    property OnGetImageIndex: TTabGetImageEvent read FOnGetImageIndex write FOnGetImageIndex;
  end;
{$ENDIF}

  {$IFNDEF _D4_}
  TCustomDrawTarget = (dtControl, dtItem, dtSubItem);

  TCustomDrawStage = (cdPrePaint, cdPostPaint, cdPreErase, cdPostErase);

  TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked,
    cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);

  TTVCustomDrawEvent = procedure(Sender: TCustomTreeView; const ARect: TRect;
    var DefaultDraw: Boolean) of object;

  TTVCustomDrawItemEvent = procedure(Sender: TCustomTreeView; Node: TTreeNode;
    State: TCustomDrawState; var DefaultDraw: Boolean) of object;

  {$ENDIF}

{ TCustomExplorerTreeView }
  TTVGetItemParamsEvent = procedure (Sender: TObject; Node: TTreeNode; AFont: TFont;
    var Background: TColor; var State: TCustomDrawState) of object;

{ TvgCustomTreeView }
  TvgCustomTreeView = class(TCustomTreeView)
  private
    {$IFNDEF _D3_}
    FRightClickSelect: Boolean;
    FRClickNode: TTreeNode;
    {$ENDIF}
    {$IFNDEF _D4_}
    FStyles: array [0..3] of Boolean;
    FCanvas: TCanvas;
    FCanvasChanged: Boolean;

    {$ENDIF}
    FOnGetItemParams: TTVGetItemParamsEvent;
    {$IFNDEF _D4_}
    FOnCustomDraw: TTVCustomDrawEvent;
    FOnCustomDrawItem: TTVCustomDrawItemEvent;
    {$ENDIF}
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
    {$IFNDEF _D4_}
    procedure CanvasChanged(Sender: TObject);
    procedure SetStyle(Index: Integer; Value: Boolean);
    {$ENDIF}
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GetItemParams(Node: TTreeNode; AFont: TFont; var Background: TColor; var State: TCustomDrawState); virtual;
    {$IFNDEF _D4_}
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
    function CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean; virtual;
    function CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
      Stage: TCustomDrawStage): Boolean; virtual;
    {$IFNDEF _D3_}
    property RightClickSelect: Boolean read FRightClickSelect write FRightClickSelect default False;
    {$ENDIF}
    property AutoExpand: Boolean index 0 read FStyles[0] write SetStyle default False;
    property HotTrack: Boolean index 1 read FStyles[1] write SetStyle default False;
    property RowSelect: Boolean index 2 read FStyles[2] write SetStyle default False;
    property ToolTips: Boolean index 3 read FStyles[3] write SetStyle default True;
    {$ENDIF}
    property OnGetItemParams: TTVGetItemParamsEvent read FOnGetItemParams write FOnGetItemParams;
    {$IFNDEF _D4_}
    property OnCustomDraw: TTVCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property OnCustomDrawItem: TTVCustomDrawItemEvent read FOnCustomDrawItem write FOnCustomDrawItem;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SelectNode(Node: TTreeNode);
    {$IFNDEF _D4_}
    property Canvas: TCanvas read FCanvas;
    {$ENDIF}
  end;

{ TvgTreeView }
  TvgTreeView = class (TvgCustomTreeView)
  published
    property Align;
    {$IFDEF _D3_}
    {$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property ParentBiDiMode;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    {$ENDIF}
    property ImeMode;
    property ImeName;
    {$ENDIF}
    property AutoExpand;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HotTrack;
    property Images;
    property Indent;
    property Items;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelect;
    property RowSelect;
    property ShowButtons;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ToolTips;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsing;
    property OnCollapsed;
    property OnCompare;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF _D4_}
    property OnStartDock;
    property OnEndDock;
    {$ENDIF}
  end;

{ TvgNotebook }
  TTabSetAlign = (taNone, taTop, taBottom, taLeft, taRight);

  TvgNotebook = class(TNotebook)
  private
    { Private declarations }
    FTabSetAlign: TTabSetAlign;
    FBorderWidth: TBorderWidth;
    procedure SetBorderWidth(Value: TBorderWidth);
    procedure SetTabSetAlign(Value: TTabSetAlign);
  protected
    { Protected declarations }
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property BorderWidth: TBorderWidth read FBorderWidth write SetBorderWidth default 2;
    property TabSetAlign: TTabSetAlign read FTabSetAlign write SetTabSetAlign default taNone;
  end;

{ TvgTabSet }
  TvgTabSet = class;

  TvgTabList = class(TStringList)
  private
    FTabs: TvgTabSet;
  protected
    procedure Changed; override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    procedure Insert(Index: Integer; const S: string); override;
    procedure Delete(Index: Integer); override;
    function Add(const S: string): Integer; override;
    procedure Clear; override;
  end;

  TTabSetStyle = TTabStyle;
  TTabChangeEvent = procedure(Sender: TObject; NewTab: Integer;
    var AllowChange: Boolean) of object;
  TDrawTabSetEvent = procedure(Sender: TObject; TabCanvas: TCanvas; R: TRect;
    Index: Integer; Selected: Boolean) of object;

  TvgTabSetStyle = (tsNormal, tsOwnerDraw);

  TvgTabSet = class(TCustomControl)
  private
    FAlignment: TAlignment;
    FAutoSizeX, FAutoSizeY: Boolean;
    FFirstVisible: Integer;
    FDefaultFocusFont: Boolean;
    FFocusFont: TFont;
    FMargins: array [0..4] of Integer;
    FMemBitmap: TBitmap;
    FOffsetX, FOffsetY: Integer;
    FTabStyle: TvgTabSetStyle;
    FFocusOffset: Integer;
    FRoundBorders: Boolean;
    FTabs: TStrings;
    FTabIndex, FStreamedTabIndex: Integer;
    FTabsAlign: TTabSetAlign;
    FTabsHeight, FTabsWidth: Integer;
    FUpDown: TUpDown;
    { Events }
    FOnDrawTab: TDrawTabSetEvent;
    FOnChange: TTabChangeEvent;
    procedure FontChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSizeX(Value: Boolean);
    procedure SetAutoSizeY(Value: Boolean);
    procedure SetDefaultFocusFont(Value: Boolean);
    procedure SetFirstVisible(Value: Integer);
    procedure SetFocusFont(Value: TFont);
    procedure SetFocusOffset(Value: Integer);
    procedure SetMargins(Index: Integer; Value: Integer);
    procedure SetRoundBorders(Value: Boolean);
    procedure SetTabStyle(Value: TvgTabSetStyle);
    procedure SetTabIndex(Value: Integer);
    procedure SetTabList(Value: TStrings);
    procedure SetTabsAlign(Value: TTabSetAlign);
    procedure SetTabsHeight(Value: Integer);
    procedure SetTabsWidth(Value: Integer);
    function StoreFocusFont: Boolean;
    procedure UpdateTabSizes;
    procedure UpDownClick(Sender: TObject; Button: TUDBtnType);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure DrawTab(TabCanvas: TCanvas; R: TRect; Index: Integer;
      Selected: Boolean); virtual;
    procedure DrawTabText(TabCanvas: TCanvas; R: TRect; Index: Integer; Selected: Boolean);
    procedure SelectNext(Direction: Boolean);
    procedure Paint; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CanChange(NewIndex: Integer): Boolean;
    function ItemAtPos(Pos: TPoint): Integer;
    function ItemRect(Item: Integer): TRect;
    property Canvas;
  published
{$IFDEF _D3_}
{$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
    property ImeMode;
    property ImeName;
{$ENDIF}
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property AutoSizeX: Boolean read FAutoSizeX write SetAutoSizeX default True;
    property AutoSizeY: Boolean read FAutoSizeY write SetAutoSizeY default True;
    property DefaultFocusFont: Boolean read FDefaultFocusFont write SetDefaultFocusFont default True;
    property FocusFont: TFont read FFocusFont write SetFocusFont stored StoreFocusFont;
    property FocusOffset: Integer read FFocusOffset write SetFocusOffset default 2;
    property MarginLeft: Integer index 0 read FMargins[0] write SetMargins default 2;
    property MarginRight: Integer index 1 read FMargins[1] write SetMargins default 2;
    property MarginTop: Integer index 2 read FMargins[2] write SetMargins default 2;
    property MarginBottom: Integer index 3 read FMargins[3] write SetMargins default 2;
    property MarginStart: Integer index 4 read FMargins[4] write SetMargins default 0;
    property RoundBorders: Boolean read FRoundBorders write SetRoundBorders default True;
    property TabStyle: TvgTabSetStyle read FTabStyle write SetTabStyle default tsNormal;
    property TabsAlign: TTabSetAlign read FTabsAlign write SetTabsAlign default taBottom;
    property TabsHeight: Integer read FTabsHeight write SetTabsHeight default 20;
    property TabsWidth: Integer read FTabsWidth write SetTabsWidth default 30;
    property TabIndex: Integer read FTabIndex write SetTabIndex default -1;
    property Tabs: TStrings read FTabs write SetTabList;
    property OnChange: TTabChangeEvent read FOnChange write FOnChange;
    property OnDrawTab: TDrawTabSetEvent read FOnDrawTab write FOnDrawTab;
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Caption;
    property Color;
    property Ctl3D;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF _D4_}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{ TClipboardShortCuts }
const
  scCopy      = scCtrl + ord('C');
  scCut       = scCtrl + ord('X');
  scDelete    = VK_DELETE;
  scPaste     = scCtrl + ord('V');
  scSelectAll = scCtrl + ord('A');

  scCopy2      = scCtrl + VK_INSERT;
  scCut2       = scShift+ VK_DELETE;
  scDelete2    = scCtrl + VK_DELETE;
  scPaste2     = scShift+ VK_INSERT;
  scSelectAll2 = scCtrl + ord('A');

type
  TClipboardAction = (caCopy, caCut, caDelete, caPaste, caSelectAll);
  TClipboardActions = set of TClipboardAction;

  TClipboardShortCuts = class(TPersistent)
  private
    FActions: TClipboardActions;
    FShortCuts: array [0..4] of TShortCut;
    FShortCuts2: array [0..4] of TShortCut;
    function StoreActions: Boolean;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    function IsAction(Key: Word; Shift: TShiftState; Action: TClipboardAction): Boolean;
    function IsShortCutAction(ShortCut: TShortCut; Action: TClipboardAction): Boolean;
  published
    property Actions: TClipboardActions read FActions write FActions stored StoreActions;
    property Copy1st: TShortCut read FShortCuts[0] write FShortCuts[0] default scCopy;
    property Copy2nd: TShortCut read FShortCuts2[0] write FShortCuts2[0] default scCopy2;
    property Cut1st: TShortCut read FShortCuts[1] write FShortCuts[1] default scCut;
    property Cut2nd: TShortCut read FShortCuts2[1] write FShortCuts2[1] default scCut2;
    property Delete1st: TShortCut read FShortCuts[2] write FShortCuts[2] default scDelete;
    property Delete2nd: TShortCut read FShortCuts2[2] write FShortCuts2[2] default scDelete2;
    property Paste1st: TShortCut read FShortCuts[3] write FShortCuts[3] default scPaste;
    property Paste2nd: TShortCut read FShortCuts2[3] write FShortCuts2[3] default scPaste2;
    property SelectAll1st: TShortCut read FShortCuts[4] write FShortCuts[4] default scSelectAll;
    property SelectAll2nd: TShortCut read FShortCuts2[4] write FShortCuts2[4] default scSelectAll2;
  end;

  TCustomSheetForm = class;

  TSheetFormEvent = procedure (Sender: TObject;
    SheetForm: TCustomSheetForm) of object;

  TSheetFormGetControlEvent = procedure (Sender: TObject;
    SheetForm: TCustomSheetForm; var Control: TWinControl) of object;

{ TFormLoader }
  TFormLoader = class(TComponent)
  private
    FActiveForm: TCustomSheetForm;
    FActiveSheet: TWinControl;
    FActiveSpeedBar: TWinControl;
    FActiveMenu: TMainMenu;
    FForms: TList;
    FMenu: TMainMenu;
    FSpeedBar: TWinControl;
    FWorkplace: TWinControl;
    FOnActivate, FOnDeactivate, FOnInsert, FOnRemove: TSheetFormEvent;
    FOnGetSpeedBar, FOnGetWorkplace: TSheetFormGetControlEvent;
    function GetForm(Index: Integer): TCustomSheetForm;
    function GetFormCount: Integer;
    procedure LoadForm(AForm: TCustomSheetForm);
    procedure SetActiveForm(Value: TCustomSheetForm);
    procedure SetActiveMenu(Value: TMainMenu);
    procedure SetActiveSheet(Value: TWinControl);
    procedure SetActiveSpeedBar(Value: TWinControl);
    procedure SetMenu(Value: TMainMenu);
    procedure SetWorkplace(Value: TWinControl);
    procedure SetSpeedBar(Value: TWinControl);
  protected
    procedure DoActivate(SheetForm: TCustomSheetForm); dynamic;
    procedure DoDeactivate(SheetForm: TCustomSheetForm); dynamic;
    procedure DoInsert(SheetForm: TCustomSheetForm); dynamic;
    procedure DoRemove(SheetForm: TCustomSheetForm); dynamic;
    function GetSpeedBar(SheetForm: TCustomSheetForm): TWinControl; dynamic;
    function GetWorkplace(SheetForm: TCustomSheetForm): TWinControl; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property ActiveMenu: TMainMenu read FActiveMenu write SetActiveMenu;
    property ActiveSheet: TWinControl read FActiveSheet write SetActiveSheet;
    property ActiveSpeedBar: TWinControl read FActiveSpeedBar write SetActiveSpeedBar;
  public
    destructor Destroy; override;
    procedure AddForm(AForm: TCustomSheetForm; Activate: Boolean);
    function FindNextForm(AForm: TCustomSheetForm; GoForward: Boolean): TCustomSheetForm;
    function IndexOf(AForm: TCustomSheetForm): Integer;
    procedure InsertForm(Index: Integer; AForm: TCustomSheetForm; Activate: Boolean);
    procedure RemoveForm(AForm: TCustomSheetForm);
    property ActiveForm: TCustomSheetForm read FActiveForm write SetActiveForm;
    property FormCount: Integer read GetFormCount;
    property Forms[Index: Integer]: TCustomSheetForm read GetForm;
  published
    property Menu: TMainMenu read FMenu write SetMenu;
    property SpeedBar: TWinControl read FSpeedBar write SetSpeedBar;
    property Workplace: TWinControl read FWorkplace write SetWorkplace;
    property OnActivate: TSheetFormEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TSheetFormEvent read FOnDeactivate write FOnDeactivate;
    property OnGetSpeedBar: TSheetFormGetControlEvent read FOnGetSpeedBar write FOnGetSpeedBar;
    property OnGetWorkplace: TSheetFormGetControlEvent read FOnGetWorkplace write FOnGetWorkplace;
    property OnInsert: TSheetFormEvent read FOnInsert write FOnInsert;
    property OnRemove: TSheetFormEvent read FOnRemove write FOnRemove;
  end;

{ TCustomSheetForm }
  TCustomSheetForm = class(TForm)
  private
    FFormLoader: TFormLoader;
    FSheet: TWinControl;
    FSpeedBar: TWinControl;
    function GetIndex: Integer;
    procedure SetFormLoader(Value: TFormLoader);
    procedure SetSheet(Value: TWinControl);
    procedure SetSpeedBar(Value: TWinControl);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    property Index: Integer read GetIndex;
    property FormLoader: TFormLoader read FFormLoader write SetFormLoader;
  published
    property Sheet: TWinControl read FSheet write SetSheet;
    property SpeedBar: TWinControl read FSpeedBar write SetSpeedBar;
  end;

  TRegisterFormClassProc = procedure (FormClass: TFormClass);
  TRegisterFormClassProcA = procedure (FormClass: TFormClass; const Description: String);

function CharToShortCut(C: Char): TShortCut;

implementation
uses Consts, ComCtl98, SysUtils, vgUtils, vgVCLUtl, CommCtrl;

type
  PNMCustomDraw = PNMCustomDrawInfo;

const
  DefOffset        = 2;
  Delimeter        = '|';

  hzHeight         = 16;
  hzWidth          = 24;

  vtHeight         = 24;
  vtWidth          = 16;

{$IFNDEF _D4_}
procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then Style := Style and not Value
    else Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;
{$ENDIF}

function CharToShortCut(C: Char): TShortCut;
var
  Key: Word;
  Shift: TShiftState;
  VK: SHORT;
begin
  VK := VkKeyScan(C);
  Key := Lo(VK);
  Shift := [];
  if Hi(VK) and 1 = 1 then Shift := Shift + [ssShift];
  if Hi(VK) and 2 = 2 then Shift := Shift + [ssCtrl];
  if Hi(VK) and 4 = 4 then Shift := Shift + [ssAlt];
  Result := ShortCut(Key, Shift);
end;

procedure DrawLine(Canvas: TCanvas; C: TColor; X1, Y1, X2, Y2: Integer);
begin
  with Canvas do
  begin
    Pen.Color := C;
    MoveTo(X1, Y1);
    LineTo(X2, Y2);
  end;
end;

procedure DrawVert(Canvas: TCanvas; X1, Y1, Height: Integer;
  Left, FullTop, FullBottom: Boolean);
begin
  Canvas.Pen.Width := 1;
  if Left then
  begin
    DrawLine(Canvas, clBtnHighlight, X1, Y1, X1, Y1 + Height);
  end else begin
    DrawLine(Canvas, clBlack, X1, Y1, X1, Y1 + Height);
    DrawLine(Canvas, clBtnShadow, X1 - 1, Y1 + Integer(FullTop)* 1,
      X1 - 1, Y1 + Height - Integer(FullBottom) * 1);
  end;
end;

procedure DrawHorz(Canvas: TCanvas; X1, Y1, Width: Integer;
  Top, FullLeft, FullRight: Boolean);
begin
  Canvas.Pen.Width := 1;
  if Top then
  begin
    DrawLine(Canvas, clBtnHighlight, X1, Y1, X1 + Width, Y1);
  end else begin
    DrawLine(Canvas, clBlack, X1, Y1, X1 + Width, Y1);
    DrawLine(Canvas, clBtnShadow, X1 + Integer(FullLeft) * 1, Y1 - 1,
      X1 + Width - Integer(FullRight) * 1, Y1 - 1);
  end;
end;

{ TvgSplitter }

type
  THack = class(TWinControl)
  public
    property OnKeyDown;
  end;

{$IFNDEF _D3_}
function ValidParentForm(Control: TControl): TForm;
begin
  Result := GetParentForm(Control);
  if not Assigned(Result) then Abort;
end;
{$ENDIF}

constructor TvgSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csDisplayDragImage];
  Align := alLeft;
  Width := 3;
  Cursor := crHSplit;
  FMinSize := 30;
  FBeveled := True;
end;

procedure TvgSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS
    or DCX_LOCKWINDOWUPDATE);
end;

procedure TvgSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if Align in [alLeft, alRight] then
    P.X := Left + FSplit else
    P.Y := Top + FSplit;
  with P do PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

procedure TvgSplitter.ReleaseLineDC;
begin
  ReleaseDC(Parent.Handle, FLineDC);
end;

procedure TvgSplitter.Paint;
var
  FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  if Beveled then
  begin
    if Align in [alLeft, alRight] then
      InflateRect(R, -1, 2) else
      InflateRect(R, 2, -1);
    OffsetRect(R, 1, 1);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnHighlight));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
    OffsetRect(R, -2, -2);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnShadow));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
  end;
end;

procedure TvgSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

  function FindControl: TControl;
  var
    P: TPoint;
    I: Integer;
  begin
    Result := nil;
    P := Point(Left, Top);
    case Align of
      alLeft: Dec(P.X);
      alRight: Inc(P.X, Width);
      alTop: Dec(P.Y);
      alBottom: Inc(P.Y, Height);
    else
      Exit;
    end;
    for I := 0 to Parent.ControlCount - 1 do
    begin
      Result := Parent.Controls[I];
      if Result.Visible and PtInRect(Result.BoundsRect, P) then Exit;
    end;
    Result := nil;
  end;

var
  I: Integer;
begin
  inherited;
  if (Button = mbLeft) then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if Align in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - Integer(FMinSize);
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alLeft, alRight] then Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - Integer(FMinSize);
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alTop, alBottom] then Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
          FOldKeyDown := THack(FActiveControl).OnKeyDown;
          THack(FActiveControl).OnKeyDown := FocusKeyDown;
        end;
      DrawLine;
    end;
  end;
end;

procedure TvgSplitter.UpdateSize(X, Y: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    FSplit := X - FDownPos.X
  else
    FSplit := Y - FDownPos.Y;
  S := 0;
  case Align of
    alLeft: S := FControl.Width + FSplit;
    alRight: S := FControl.Width - FSplit;
    alTop: S := FControl.Height + FSplit;
    alBottom: S := FControl.Height - FSplit;
  end;
  FNewSize := S;
  if S < Integer(FMinSize) then
    FNewSize := FMinSize
  else if S > FMaxSize then
    FNewSize := FMaxSize;
  if S <> FNewSize then
  begin
    if Align in [alRight, alBottom] then
      S := S - FNewSize else
      S := FNewSize - S;
    Inc(FSplit, S);
  end;
end;

procedure TvgSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    UpdateSize(X, Y);
    DrawLine;
  end;
end;

procedure TvgSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    case Align of
      alLeft: FControl.Width := FNewSize;
      alTop: FControl.Height := FNewSize;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    StopSizing;
  end;
end;

procedure TvgSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

procedure TvgSplitter.SetBeveled(Value: Boolean);
begin
  FBeveled := Value;
  Repaint;
end;

procedure TvgSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      THack(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

type
  TEditSpeedButton = class(TSpeedButton)
  private
    FEdit: TCustomClickEdit;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  end;

procedure TEditSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if (csDesigning in FEdit.ComponentState) then Exit;
  inherited;
  if (FState = bsDown) and (FEdit.IsCombo) then
  begin
    Update;
    Click;
  end;
end;

procedure TEditSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FEdit.ButtonReleased;
end;

{ TCustomClickEdit }
constructor TCustomClickEdit.Create(AOwner: TComponent);
begin
  inherited;
  FBtnControl := TWinControl.Create(nil);
  FBtnControl.Align := alRight;
  FBtnControl.Cursor := crArrow;
  TControlHack(FBtnControl).Color := clBtnFace;
  FBtnControl.Parent := Self;

  FButton := TEditSpeedButton.Create(nil);
  TEditSpeedButton(FButton).FEdit := Self;
  FButton.OnClick := EditButtonClick;
  FButton.Align := alRight;
  FButton.Parent := FBtnControl;
  FButtonShortCut := scDefButtonShortCut;
  FCaret := True;
  SetButtonWidth(15);
end;

destructor TCustomClickEdit.Destroy;
begin
  FButton.Free;
  FBtnControl.Free;
  inherited;
end;

procedure TCustomClickEdit.ButtonClick;
begin
  if Assigned(FOnButtonClick) then FOnButtonClick(Self);
end;

procedure TCustomClickEdit.ButtonReleased;
begin
end;

procedure TCustomClickEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := FBtnControl.Enabled and Enabled;
end;

procedure TCustomClickEdit.CMEnter(var Message: TCMEnter);
begin
  SetFocused(True);
  inherited;
end;

procedure TCustomClickEdit.CMExit(var Message: TCMExit);
begin
  SetFocused(False);
  DoExit;
end;

procedure TCustomClickEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TCustomClickEdit.CreateWnd;
begin
  inherited;
  SetEditRect;
end;

procedure TCustomClickEdit.EditButtonClick(Sender: TObject);
begin
  ButtonClick;
end;

function TCustomClickEdit.GetButtonEnabled: Boolean;
begin
  Result := FBtnControl.Enabled;
end;

function TCustomClickEdit.GetButtonVisible: Boolean;
begin
  Result := FBtnControl.Visible;
end;

function TCustomClickEdit.GetButtonWidth: Integer;
begin
  Result := FBtnControl.Width - 1;
end;

function TCustomClickEdit.GetTextMargins: TPoint;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  if NewStyleControls then
  begin
    if BorderStyle = bsNone then I := 0 else
      if Ctl3D then I := 1 else I := 2;
    Result.X := SendMessage(Handle, EM_GETMARGINS, 0, 0) and $0000FFFF + I;
    Result.Y := I;
  end else
  begin
    if BorderStyle = bsNone then I := 0 else
    begin
      DC := GetDC(0);
      GetTextMetrics(DC, SysMetrics);
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextMetrics(DC, Metrics);
      SelectObject(DC, SaveFont);
      ReleaseDC(0, DC);
      I := SysMetrics.tmHeight;
      if I > Metrics.tmHeight then I := Metrics.tmHeight;
      I := I div 4;
    end;
    Result.X := I;
    Result.Y := I;
  end;
end;

function TCustomClickEdit.GetGlyph: TBitmap;
begin
  Result := FButton.Glyph;
end;

function TCustomClickEdit.GetNumGlyphs: TNumGlyphs;
begin
  Result := FButton.NumGlyphs;
end;

function TCustomClickEdit.IsCombo: Boolean;
begin
  Result := False;
end;

function TCustomClickEdit.IsCustomGlyph: Boolean;
begin
  Result := FGlyphKind = gkCustom;
end;

procedure TCustomClickEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (ShortCut(Key, Shift) = FButtonShortCut) and ButtonVisible and ButtonEnabled then
  begin
    ButtonClick;
    Key := 0;
  end;
end;

procedure TCustomClickEdit.KeyPress(var Key: Char);
begin
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
    GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
  inherited KeyPress(Key);
  if Key = Char(VK_RETURN) then Key := #0;
end;

procedure TCustomClickEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TCustomClickEdit.SetButtonEnabled(Value: Boolean);
begin
  if csDesigning in ComponentState then
  begin
    FBtnControl.Enabled := Value;
    FButton.Enabled := Enabled and Value;
  end else
    FButton.Enabled := Value;
end;

procedure TCustomClickEdit.SetButtonWidth(Value: Integer);
begin
  FBtnControl.Width := Value + 1;
  FButton.SetBounds(1, 0, FBtnControl.Width - 1, Height);
  SetEditRect;
  Invalidate;
end;

procedure TCustomClickEdit.SetButtonVisible(Value: Boolean);
begin
  FBtnControl.Visible := Value;
  SetEditRect;
  Invalidate;
end;

procedure TCustomClickEdit.SetCaret(Value: Boolean);
begin
  if (FCaret <> Value) then
  begin
    FCaret := Value;
    if FFocused then
      if not Caret then HideCaret(Handle) else ShowCaret(Handle);
  end;
end;

procedure TCustomClickEdit.SetEditRect;
var
  R: TRect;
begin
  if HandleAllocated then
  begin
    R := Rect(0, 0, ClientWidth - FBtnControl.Width - 2, ClientHeight + 1);
    SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@R));
  end;
end;

procedure TCustomClickEdit.SetFocused(Value: Boolean);
begin
  if FFocused <> Value then
  begin
    FFocused := Value;
    if (FAlignment <> taLeftJustify) then Invalidate;
  end;
end;

procedure TCustomClickEdit.SetGlyph(Value: TBitmap);
begin
  FButton.Glyph := Value;
  FGlyphKind := gkCustom;
end;

procedure TCustomClickEdit.SetGlyphKind(Value: TGlyphKind);
begin
  if FGlyphKind <> Value then
  begin
    FGlyphKind := Value;
    case FGlyphKind of
      gkDropDown:
        begin
          FButton.Glyph.Handle := LoadBitmap(0, PChar(32738));
          NumGlyphs := 1;
          SetButtonWidth(GetSystemMetrics(SM_CXVSCROLL));
        end;
      end;
  end;
end;

procedure TCustomClickEdit.SetNumGlyphs(Value: TNumGlyphs);
begin
  case FGlyphKind of
    gkDropDown:
      FButton.NumGlyphs := 1
  else
    FButton.NumGlyphs := Value;
  end;
end;

procedure TCustomClickEdit.WMPaint(var Message: TWMPaint);
var
  Left: Integer;
  Margins: TPoint;
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
  S: string;
  BtnWidth: Integer;
begin
  if ((FAlignment = taLeftJustify) or FFocused) and
    not (csPaintCopy in ControlState) then
  begin
    inherited;
    Exit;
  end;
{ Since edit controls do not handle justification unless multi-line (and
  then only poorly) we will draw right and center justify manually unless
  the edit has the focus. }
  if FBtnControl.Visible then
    BtnWidth := FBtnControl.Width else
    BtnWidth := 0;
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    FCanvas.Control := Self;
  end;
  DC := Message.DC;
  if DC = 0 then DC := BeginPaint(Handle, PS);
  FCanvas.Handle := DC;
  try
    FCanvas.Font := Font;
    with FCanvas do
    begin
      R := ClientRect;
      if not (NewStyleControls and Ctl3D) and (BorderStyle = bsSingle) then
      begin
        Brush.Color := clWindowFrame;
        FrameRect(R);
        InflateRect(R, -1, -1);
      end;
      Brush.Color := Color;
      S := Text;
      if (csPaintCopy in ControlState) then
      begin
        case CharCase of
          ecUpperCase: S := AnsiUpperCase(S);
          ecLowerCase: S := AnsiLowerCase(S);
        end;
      end;
      if PasswordChar <> #0 then FillChar(S[1], Length(S), PasswordChar);
      Margins := GetTextMargins;
      case FAlignment of
        taLeftJustify: Left := Margins.X;
        taRightJustify: Left := ClientWidth - BtnWidth - TextWidth(S) - Margins.X - 1;
      else
        Left := (ClientWidth - BtnWidth - TextWidth(S)) div 2;
      end;
      TextRect(R, Left, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

procedure TCustomClickEdit.WMSetFocus(var Message: TMessage);
begin
  inherited;
  if not FCaret then HideCaret(Handle);
end;

procedure TCustomClickEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  SetEditRect;
end;

{ TJustifyEdit }
constructor TJustifyEdit.Create(AOwner: TComponent);
begin
  inherited;
  ButtonVisible := False;
end;

{ TCustomPopupWindow }
type
  TCustomPopupWindow = class(TWinControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

procedure TCustomPopupWindow.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    Style := WS_CHILD or WS_BORDER or WS_CLIPCHILDREN;
    ExStyle := WS_EX_TOOLWINDOW;
    WndParent := GetDesktopWindow;
  end;
end;

{ TCustomComboBoxEdit }
constructor TCustomComboBoxEdit.Create(AOwner: TComponent);
begin
  inherited;
  ButtonWidth := GetSystemMetrics(SM_CXHTHUMB);
  GlyphKind := gkDropDown;
  FPopup := TCustomPopupWindow.Create(Self);
  CreatePopupControl(FPopupControl);
  FPopupControl.Parent := FPopup;
  FPopupControl.Align := alClient;
  FDropDownAlign := daLeft;
  FDropDownHeight := 100;
end;

destructor TCustomComboBoxEdit.Destroy;
begin
  CloseUp(False);
  FPopup.Free;
  inherited;
end;

procedure TCustomComboBoxEdit.ButtonClick;
begin
  DropDown;
end;

procedure TCustomComboBoxEdit.ButtonReleased;
begin
end;

procedure TCustomComboBoxEdit.CloseUp(Accept: Boolean);
begin
  if FDroppedDown then
  begin
    DoCloseUp(Accept);
    HidePopupControl;
    FDroppedDown := False;
  end;
end;

procedure TCustomComboBoxEdit.CreateWnd;
begin
  inherited;
  FPopupControl.HandleNeeded;
end;

procedure TCustomComboBoxEdit.DoCloseUp(Accept: Boolean);
begin
end;

procedure TCustomComboBoxEdit.DoShow;
begin
end;

procedure TCustomComboBoxEdit.DropDown;
begin
  if not FDroppedDown then
  begin
    ShowPopupControl;
    FDroppedDown := True;
    DoShow;
  end
end;

function TCustomComboBoxEdit.IsCombo: Boolean;
begin
  Result := True;
end;

procedure TCustomComboBoxEdit.HidePopupControl;
begin
  SetWindowPos(FPopup.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
    SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  FPopup.Visible := False;
end;

procedure TCustomComboBoxEdit.ShowPopupControl;
var
  P: TPoint;
  Y: Integer;
begin
  FPopup.Height := FDropDownHeight;
  if FDropDownWidth = 0 then
    FPopup.Width := Width else
    FPopup.Width := FDropDownWidth;

  P := Parent.ClientToScreen(Point(Left, Top));
  Y := P.Y + Height;
  if Y + FPopup.Height > Screen.Height then
    Y := P.Y - FPopup.Height;
  case DropDownAlign of
    daLeft:
      begin
        if P.X + FPopup.Width > Screen.Width then
          Dec(P.X, FPopup.Width - Width);
      end;
    daRight:
      begin
        Dec(P.X, FPopup.Width - Width);
        if P.X < 0 then Inc(P.X, FPopup.Width - Width);
      end;
  end;
  if P.X < 0 then P.X := 0
  else if P.X + FPopup.Width > Screen.Width then
    P.X := Screen.Width - FPopup.Width;

  if CanFocus then SetFocus;

  SetWindowPos(FPopup.Handle, HWND_TOP, P.X, Y, 0, 0,
    SWP_SHOWWINDOW or SWP_NOSIZE);
  FPopup.Visible := True;

  SetWindowPos(FPopupControl.Handle, HWND_TOP, 0, 0, 0, 0,
    SWP_SHOWWINDOW or SWP_NOSIZE);
end;

procedure TCustomComboBoxEdit.SetDisplayEmpty(Value: string);
begin
  if (FDisplayEmpty <> Value) then
  begin
    FDisplayEmpty := Value;
    Invalidate;
  end;
end;

procedure TCustomComboBoxEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CM_CANCELMODE:
    begin
      if not (csDesigning in ComponentState) then CloseUp(False);
      inherited;
    end;
    CM_COLORCHANGED:
    begin
      inherited;
      TControlHack(FPopup).Color := Self.Color;
    end;
    CM_FONTCHANGED:
    begin
      inherited;
      TControlHack(FPopup).Font := Self.Font;
    end;
    WM_CHAR:
      if DroppedDown then
      begin
        if Message.wParam = 13 then
          CloseUp(True)
        else if Message.wParam = 27 then
          CloseUp(False);
        inherited;
      end;
    WM_KEYDOWN, WM_KEYUP:
      begin
        with Message do
          Result := FPopupControl.Perform(Msg, WParam, LParam)
      end;
    WM_LBUTTONDOWN:
      begin
        if not (csDesigning in ComponentState) then
          if DroppedDown then CloseUp(False) else DropDown
        else inherited;
      end;
    WM_SETCURSOR:
      if not (csDesigning in ComponentState) then
      begin
        with TWMSetCursor(Message) do
        if not Caret then
        begin
          if Cursor = crDefault then
            Windows.SetCursor(Screen.Cursors[crArrow]) else
            Windows.SetCursor(Screen.Cursors[Cursor]);
          Result := 1;
        end;
      end else
        inherited;
      WM_KILLFOCUS:
      begin
        if not (csDesigning in ComponentState) then CloseUp(False);
        inherited;
      end;
  else
    inherited;
  end;
end;

{ TTitler }
constructor TTitler.Create(AOwner: TComponent);
begin
  inherited;
  Alignment := taCenter;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  Color := clBlack;
  Height := 50;
  Width := 50;
  Font.Color := clLime;

  FTimer := TTimer.Create(Self);
  FTimer.OnTimer := DoTimer;
  FTitles := TStringList.Create;
  TStringList(FTitles).OnChange := TitlesChanged;
  FStep := 1;
  Interval := 50;
end;

destructor TTitler.Destroy;
begin
  FTitles.Free;
  FTimer.Free;
  inherited;
end;

procedure TTitler.Invalidate;
var
  R: TRect;
begin
  if HandleAllocated then
  begin
    R := GetClientRect;
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TTitler.Reset;
begin
  FPosition := 0;
  Invalidate;
end;

function TTitler.GetInterval: Integer;
begin
  Result := FTimer.Interval;
end;

procedure TTitler.SetInterval(Value: Integer);
begin
  FTimer.Interval := Value;
end;

procedure TTitler.SetStep(Value: Integer);
begin
  if (FStep = Value) or (Value < 1) then Exit;
  FStep := Value;
  Invalidate;
end;

procedure TTitler.SetTitles(Value: TStrings);
begin
  FTitles.Assign(Value);
end;

procedure TTitler.TitlesChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TTitler.Paint;
var
  CR: TRect;
  R: TRect;
  OldBkMode: Integer;
  FBmp: TBitmap;
begin
  CR := ClientRect;
  FBmp := TBitmap.Create;
  try
    FBmp.Width := CR.Right + 1;
    FBmp.Height := CR.Bottom + 1;
    with FBmp.Canvas do
    begin
      Brush.Color := Self.Color;
      FillRect(CR);
      OldBkMode := GetBkMode(Handle);
      if Assigned(FOnPaintBefore) then
      begin
        FOnPaintBefore(Self, FBmp.Canvas);
        SetBkMode(Handle, TRANSPARENT);
      end else
        SetBkMode(Handle, OPAQUE);
      Font := Self.Font;
      if FPosition > TextHeight('0') * FTitles.Count + Height then
        FPosition := 0;
      R := Rect(2, -FPosition + Height, Width - 3, CR.Bottom - 1);
      DrawText(Handle, PChar(FTitles.Text), -1, R, DT_EXPANDTABS or Alignments[Alignment]);
      SetBkMode(Handle, OldBkMode)
    end;
    if Assigned(FOnPaintAfter) then
      FOnPaintBefore(Self, FBmp.Canvas);
    Canvas.CopyRect(ClientRect, FBmp.Canvas, ClientRect);
  finally
    FBmp.Free;
  end;
end;

procedure TTitler.DoTimer(Sender: TObject);
begin
  Inc(FPosition, FStep);
  Invalidate;
end;

{$IFNDEF _D4_ }
{ TvgTabSheet }
procedure TvgTabSheet.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    if TabVisible then (PageControl as TvgPageControl).UpdateTabImages;
  end;
end;

procedure TvgTabSheet.SetParent(AParent: TWinControl);
begin
  inherited;
  if Parent is TvgPageControl then TvgPageControl(Parent).UpdateTabImages;
end;

{$ENDIF}
{$IFNDEF _D3_}
{ TvgPageControl }
const
  TCS_SCROLLOPPOSITE    = $0001;
  TCS_BOTTOM            = $0002;
  TCS_RIGHT             = $0002;
  TCS_FORCEICONLEFT     = $0010;
  TCS_FORCELABELLEFT    = $0020;
  TCS_HOTTRACK          = $0040;
  TCS_VERTICAL          = $0080;
  TCS_TABS              = $0000;
  TCS_BUTTONS           = $0100;
  TCS_SINGLELINE        = $0000;
  TCS_MULTILINE         = $0200;
  TCS_RIGHTJUSTIFY      = $0000;
  TCS_FIXEDWIDTH        = $0400;
  TCS_RAGGEDRIGHT       = $0800;
  TCS_FOCUSONBUTTONDOWN = $1000;
  TCS_OWNERDRAWFIXED    = $2000;
  TCS_TOOLTIPS          = $4000;
  TCS_FOCUSNEVER        = $8000;
{$ENDIF}

{$IFNDEF _D4_}
const
  TCS_FLATBUTTONS       = $0008;
{$ENDIF}

{$IFNDEF _D4_}
var
  TabsRegistered: Boolean = False;

constructor TvgPageControl.Create(AOwner: TComponent);
begin
  inherited;
  FCanvas := TControlCanvas.Create;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  if not TabsRegistered then
  begin
    RegisterClass(TvgTabSheet);
    TabsRegistered := True;
  end;
end;

destructor TvgPageControl.Destroy;
begin
  FCanvas.Free;
  FImageChangeLink.Free;
  inherited;
end;

procedure TvgPageControl.CreateParams(var Params: TCreateParams);
const
  AlignStyles: array[Boolean, TTabPosition] of DWORD =
    ((0, TCS_BOTTOM, TCS_VERTICAL, TCS_VERTICAL or TCS_RIGHT),
     (0, TCS_BOTTOM, TCS_VERTICAL or TCS_RIGHT, TCS_VERTICAL));
  TabStyles: array[TTabStyle] of DWORD = (TCS_TABS, TCS_BUTTONS,
    TCS_BUTTONS or TCS_FLATBUTTONS);
  RRStyles: array[Boolean] of DWORD = (0, TCS_RAGGEDRIGHT);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or WS_CLIPCHILDREN or AlignStyles[False, FTabPosition] or
      TabStyles[FStyle] or RRStyles[FRaggedRight];
    if FHotTrack and (not (csDesigning in ComponentState)) then
      Style := Style or TCS_HOTTRACK;
    if FOwnerDraw then Style := Style or TCS_OWNERDRAWFIXED;
    WindowClass.Style := WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW) or CS_DBLCLKS;
  end;
end;

procedure TvgPageControl.CreateWnd;
begin
  inherited;
  if (Images <> nil) and Images.HandleAllocated then
    Perform(TCM_SETIMAGELIST, 0, Images.Handle);
end;

procedure TvgPageControl.DrawTab(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
begin
  if Assigned(FOnDrawTab) then
    FOnDrawTab(Self, TabIndex, Rect, Active) else
    FCanvas.FillRect(Rect);
end;

function TvgPageControl.GetImageIndex(TabIndex: Integer): Integer;
begin
  if Pages[TabIndex] is TvgTabSheet then
    Result := (Pages[TabIndex] as TvgTabSheet).ImageIndex else
    Result := TabIndex;
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, TabIndex, Result);
end;

procedure TvgPageControl.ImageListChange(Sender: TObject);
begin
  Perform(TCM_SETIMAGELIST, 0, TCustomImageList(Sender).Handle);
end;

procedure TvgPageControl.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Images) then SetImages(nil);
end;

procedure TvgPageControl.UpdateTabImages;
var
  I: Integer;
  TCItem: TTCItem;
begin
  TCItem.mask := TCIF_IMAGE;
  for I := 0 to PageCount - 1 do
  begin
    TCItem.iImage := GetImageIndex(I);
    SendMessage(Handle, TCM_SETITEM, I, Longint(@TCItem));
  end;
  TabsChanged;
end;

procedure TvgPageControl.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    RecreateWnd;
  end;
end;

procedure TvgPageControl.SetImages(Value: TCustomImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
    Perform(TCM_SETIMAGELIST, 0, Images.Handle);
  end else
    Perform(TCM_SETIMAGELIST, 0, 0);
end;

procedure TvgPageControl.SetOwnerDraw(Value: Boolean);
begin
  if FOwnerDraw <> Value then
  begin
    FOwnerDraw := Value;
    RecreateWnd;
  end;
end;

procedure TvgPageControl.SetRaggedRight(Value: Boolean);
begin
  if FRaggedRight <> Value then
  begin
    FRaggedRight := Value;
    SetComCtlStyle(Self, TCS_RAGGEDRIGHT, Value);
  end;
end;

procedure TvgPageControl.SetTabPosition(Value: TTabPosition);
begin
  if FTabPosition <> Value then
  begin
    FTabPosition := Value;
    RecreateWnd;
  end;
end;

procedure TvgPageControl.SetStyle(Value: TTabStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    RecreateWnd;
    Invalidate;
  end;
end;

procedure TvgPageControl.TabsChanged;
begin
  if HandleAllocated then
    SendMessage(Handle, WM_SIZE, SIZE_RESTORED, Word(Width) or Word(Height) shl 16);
  Realign;
end;

procedure TvgPageControl.CNDrawItem(var Message: TWMDrawItem);
var
  SaveIndex: Integer;
begin
  with Message.DrawItemStruct^ do
  begin
    SaveIndex := SaveDC(hDC);
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    DrawTab(itemID, rcItem, itemState and ODS_SELECTED <> 0);
    FCanvas.Handle := 0;
    RestoreDC(hDC, SaveIndex);
  end;
  Message.Result := 1;
end;

procedure TvgPageControl.WMDrawItem(var Message: TWMDrawItem);
begin
  DefaultHandler(Message);
end;
{$ENDIF}


{ TvgCustomTreeView }
constructor TvgCustomTreeView.Create(AOwner: TComponent);
begin
  inherited;
{$IFNDEF _D4_}
  FStyles[3] := True;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  TControlCanvas(FCanvas).OnChange := CanvasChanged;
{$ENDIF}
end;

destructor TvgCustomTreeView.Destroy;
begin
{$IFNDEF _D4_}
  FCanvas.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TvgCustomTreeView.CNNotify(var Message: TWMNotify);
var
  AFont: TFont;
  ABackgrnd: TColor;
  State: TCustomDrawState;
  Node: TTreeNode;
{$IFNDEF _D4_}
  R: TRect;
  DefaultDraw: Boolean;
  TmpItem: TTVItem;
  {$IFNDEF _D3_}
  MousePos: TPoint;
  {$ENDIF}
{$ENDIF}
begin
  with Message do
    case NMHdr^.code of
      NM_CUSTOMDRAW:
      {$IFDEF _D4_}
        if Assigned(OnCustomDrawItem) then
          inherited
        else
      {$ELSE}
        if not Assigned(OnCustomDrawItem) then
      {$ENDIF}
        begin
          with PNMCustomDrawInfo(Message.NMHdr)^ do
          begin
            case dwDrawStage of
              CDDS_PREPAINT:
                Message.Result := CDRF_NOTIFYITEMDRAW;
              CDDS_ITEMPREPAINT:
                begin
                  State := TCustomDrawState(Word(uItemState));
                  AFont := TFont.Create;
                  try
                    AFont.Assign(Self.Font);
                    ABackgrnd := GetBkColor(hdc);
                    AFont.Color := GetTextColor(hdc);
                    Node := Items.GetNode(HTreeItem(dwItemSpec));
                    GetItemParams(Node, AFont, ABackgrnd, State);
                    uItemState := Word(State);
                    SetTextColor(hdc, ColorToRGB(AFont.Color));
                    SetBkColor(hdc, ColorToRGB(ABackgrnd));
                    SelectObject(hdc, AFont.Handle);
                  finally
                    AFont.Free;
                  end;
                  Message.Result := CDRF_DODEFAULT;
                end;
            else
              Message.Result := 0;
            end;
          end;
        end
      {$IFDEF _D4_}
        ;
      {$ELSE}
        else
        with PNMCustomDraw(NMHdr)^ do
        begin
          Result := CDRF_DODEFAULT;
          if dwDrawStage = CDDS_PREPAINT then
          begin
            if IsCustomDrawn(dtControl, cdPrePaint) then
            begin
              FCanvas.Handle := hdc;
              FCanvas.Font := Font;
              FCanvas.Brush := Brush;
              R := ClientRect;
              DefaultDraw := CustomDraw(R, cdPrePaint);
              FCanvas.Handle := 0;
              if not DefaultDraw then
              begin
                Result := CDRF_SKIPDEFAULT;
                Exit;
              end;
            end;
            if IsCustomDrawn(dtControl, cdPostPaint) then
              Result := CDRF_NOTIFYPOSTPAINT;
            if IsCustomDrawn(dtItem, cdPrePaint) then
              Result := Result or CDRF_NOTIFYITEMDRAW else
              Result := Result or CDRF_DODEFAULT;
          end
          else if dwDrawStage = CDDS_ITEMPREPAINT then
          begin
            FillChar(TmpItem, SizeOf(TmpItem), 0);
            TmpItem.hItem := HTREEITEM(dwItemSpec);
            Node := Items.GetNode(TmpItem.hItem);
            if Node <> nil then
            begin
              FCanvas.Handle := hdc;
              FCanvas.Font := Font;
              FCanvas.Brush := Brush;
              { Unlike the list view, the tree view doesn't override the text
                foreground and background colors of selected items. }
              if uItemState and CDIS_SELECTED <> 0 then
              begin
                FCanvas.Font.Color := clHighlightText;
                FCanvas.Brush.Color := clHighlight;
              end;
              FCanvas.Font.OnChange := CanvasChanged;
              FCanvas.Brush.OnChange := CanvasChanged;
              DefaultDraw := CustomDrawItem(Node,
                TCustomDrawState(Word(uItemState)), cdPrePaint);
              if not DefaultDraw then
                Result := Result or CDRF_SKIPDEFAULT
              else if FCanvasChanged then
              begin
                FCanvasChanged := False;
                FCanvas.Font.OnChange := nil;
                FCanvas.Brush.OnChange := nil;
                with PNMTVCustomDraw(NMHdr)^ do
                begin
                  clrText := ColorToRGB(FCanvas.Font.Color);
                  clrTextBk := ColorToRGB(FCanvas.Brush.Color);
                  SelectObject(hdc, FCanvas.Font.Handle);
                  Result := Result or CDRF_NEWFONT;
                end;
              end;
              FCanvas.Handle := 0;
              if IsCustomDrawn(dtItem, cdPostPaint) then
                Result := Result or CDRF_NOTIFYPOSTPAINT;
            end;
          end;
        end;
      {$ENDIF}
      {$IFNDEF _D3_}
      NM_RCLICK:
        begin
          if RightClickSelect then
          begin
            GetCursorPos(MousePos);
            with PointToSmallPoint(ScreenToClient(MousePos)) do
            begin
              FRClickNode := GetNodeAt(X, Y);
              Perform(WM_RBUTTONUP, 0, MakeLong(X, Y));
            end;
          end
          else FRClickNode := Pointer(1);
        end;
      {$ENDIF}
    else
      inherited;
    end;
end;

procedure TvgCustomTreeView.CreateParams(var Params: TCreateParams);
{$IFNDEF _D4_}
const
  ToolTipStyles: array[Boolean] of DWORD = (TVS_NOTOOLTIPS, 0);
  AutoExpandStyles: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  HotTrackStyles: array[Boolean] of DWORD = (0, TCS_HOTTRACK);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
{$ENDIF}
begin
  inherited;
{$IFNDEF _D4_}
  with Params do
  begin
    Style := Style or
      ToolTipStyles[ToolTips] or AutoExpandStyles[AutoExpand] or
      HotTrackStyles[HotTrack] or RowSelectStyles[RowSelect];
  end;
{$ENDIF}
end;

{$IFNDEF _D4_}
function TvgCustomTreeView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  { Tree view doesn't support erase notifications }
  if Stage = cdPrePaint then
  begin
    if Target = dtItem then
      Result := Assigned(FOnCustomDrawItem)
    else if Target = dtControl then
      Result := Assigned(FOnCustomDraw)
    else
      Result := False;
  end
  else
    Result := False;
end;

procedure TvgCustomTreeView.CanvasChanged(Sender: TObject);
begin
  FCanvasChanged := True;
end;

function TvgCustomTreeView.CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean;
begin
  Result := True;
  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ARect, Result);
end;

function TvgCustomTreeView.CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
begin
  Result := True;
  if Assigned(FOnCustomDrawItem) then FOnCustomDrawItem(Self, Node, State, Result);
end;
{$ENDIF}

procedure TvgCustomTreeView.GetItemParams(Node: TTreeNode; AFont: TFont;
  var Background: TColor; var State: TCustomDrawState);
begin
  if Assigned(FOnGetItemParams) then FOnGetItemParams(Self, Node, AFont, Background, State);
end;

procedure TvgCustomTreeView.SelectNode(Node: TTreeNode);
begin
  if Selected <> Node then
  begin
    Selected := Node;
    Change(Node);
    if Assigned(Node) then
    begin
      Node.Focused := True;
      Node.MakeVisible;
    end;
  end;
end;

{$IFNDEF _D4_}
procedure TvgCustomTreeView.SetStyle(Index: Integer; Value: Boolean);
begin
  if (FStyles[Index] <> Value) then
  begin
    FStyles[Index] := Value;
    RecreateWnd;
  end;
end;
{$ENDIF}

procedure TvgCustomTreeView.WMRButtonDown(var Msg: TWMRButtonDown);
var
  Node: TTreeNode;
begin
  Node := GetNodeAt(Msg.XPos, Msg.YPos);
  if Assigned(Node) then SelectNode(Node);
  inherited;
end;


{ TvgNotebook }
constructor TvgNotebook.Create(AOwner: TComponent);
begin
  inherited;
  FBorderWidth := 2;
  FTabSetAlign := taNone;
end;

procedure TvgNotebook.Paint;
var
  R: TRect;
begin
  with Canvas do
  begin
    R := ClientRect;
    Brush.Color := Self.Color;
    FillRect(R);
    if BorderWidth = 0 then Exit;
    if FTabSetAlign <> taTop then
      DrawHorz(Canvas, 0, 0, Width, True,
        FTabSetAlign <> taLeft, FTabSetAlign <> taRight);
    if FTabSetAlign <> taBottom then
      DrawHorz(Canvas, 0, Height - 1, Width, False,
        FTabSetAlign <> taLeft, FTabSetAlign <> taRight);
    if FTabSetAlign <> taLeft then
      DrawVert(Canvas, 0, 0, Height, True,
        FTabSetAlign <> taTop, FTabSetAlign <> taBottom);
    if FTabSetAlign <> taRight then
      DrawVert(Canvas, Width - 1, 0, Height, False,
        FTabSetAlign <> taTop, FTabSetAlign <> taBottom);
 end;
end;

procedure TvgNotebook.AlignControls(AControl: TControl; var Rect: TRect);
begin
  InflateRect(Rect, -BorderWidth, -BorderWidth);
  Dec(Rect.Right); Dec(Rect.Bottom);
  inherited AlignControls(AControl, Rect);
end;

procedure TvgNotebook.SetBorderWidth(Value: TBorderWidth);
begin
  if FBorderWidth <> Value then begin
    FBorderWidth := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TvgNotebook.SetTabSetAlign(Value: TTabSetAlign);
begin
  if FTabSetAlign <> Value then
  begin
    FTabSetAlign := Value;
    Invalidate;
  end;
end;

{ TvgTabList }
function TvgTabList.Add(const S: string): Integer;
begin
  Result := GetCount;
  Insert(Result, S);
end;

procedure TvgTabList.Insert(Index: Integer; const S: string);
begin
  inherited Insert(Index, S);
  if Assigned(FTabs) and ((Index <= FTabs.FTabIndex) or (FTabs.FTabIndex < 0)) then
    Inc(FTabs.FTabIndex);
end;

procedure TvgTabList.Delete(Index: Integer);
var
  OldIndex: Integer;
begin
  OldIndex := FTabs.Tabindex;
  inherited Delete(Index);
  if OldIndex < Count then
    FTabs.FTabIndex := OldIndex else
    FTabs.FTabIndex := Count - 1;
  if OldIndex = Index then FTabs.Click;  { deleted selected tab }
end;

procedure TvgTabList.Changed;
begin
  FTabs.UpdateTabSizes;
  FTabs.Invalidate;
end;

procedure TvgTabList.Clear;
begin
  inherited Clear;
  FTabs.FTabIndex := -1;
  FTabs.SetFirstVisible(0);
end;

procedure TvgTabList.SetUpdateState(Updating: Boolean);
begin
  if Assigned(FTabs) and FTabs.HandleAllocated then
    SendMessage(FTabs.Handle, WM_SETREDRAW, Integer(not Updating), 0);
end;

{ TvgTabSet }
constructor TvgTabSet.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csCaptureMouse, csDoubleClicks, csOpaque];
  Width := 200;
  Height := 21;

  FUpDown := TUpDown.Create(nil);
  FUpDown.OnClick := UpDownClick;
  FUpDown.Parent := Self;

  FTabs := TvgTabList.Create;
  TvgTabList(FTabs).FTabs := Self;
  
  FMemBitmap := TBitmap.Create;
  FFocusFont := TFont.Create;
  FFocusFont.OnChange := FontChanged;
  FocusOffset := 2;
  FAlignment := taCenter;
  FAutoSizeX := True; FAutoSizeY := True;
  FDefaultFocusFont := True;
  FMargins[0] := 2; FMargins[1] := 2;
  FMargins[2] := 2; FMargins[3] := 2;
  FMargins[4] := 0;
  FTabsAlign := taBottom;
  FOffsetX := DefOffset; FOffsetY := 0;
  FRoundBorders := True;
  FTabIndex := -1;
  FTabsHeight := 20;
  FTabsWidth := 30;
  FStreamedTabIndex := -1;
  FTabStyle := tsNormal;
end;

destructor TvgTabSet.Destroy;
begin
  FTabs.Free;
  FFocusFont.Free;
  FMemBitmap.Free;
  FUpDown.Free;
  inherited;
end;

function TvgTabSet.CanChange(NewIndex: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnChange) then FOnChange(Self, NewIndex, Result);
end;

procedure TvgTabSet.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Canvas.Font := Font;
  if FDefaultFocusFont then SetDefaultFocusFont(True);
  Invalidate;
end;

procedure TvgTabSet.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTALLKEYS;
end;

procedure TvgTabSet.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateTabSizes;
  Invalidate;
end;

procedure TvgTabSet.CMDialogChar(var Message: TCMDialogChar);
var
  I: Integer;
begin
  for I := 0 to FTabs.Count - 1 do
  begin
    if IsAccel(Message.CharCode, FTabs[I]) then
    begin
      Message.Result := 1;
      if FTabIndex <> I then
        SetTabIndex(I);
      Exit;
    end;
  end;
  inherited;
end;

procedure TvgTabSet.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    Style := Style and not (CS_VREDRAW or CS_HREDRAW);
end;

procedure TvgTabSet.DrawTabText(TabCanvas: TCanvas; R: TRect; Index: Integer;
  Selected: Boolean);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  TmpRect: TRect;
  I, J, H: Integer;
  Text, DrawText: String;
begin
  with TabCanvas do
  begin
    if Selected then Font := Self.FFocusFont else Font := Self.Font;
    Text := FTabs[Index];
    DrawText := '';
    I := 1; J := 1;
    while I <= Length(Text) do
    begin
      if DrawText <> '' then
      begin
        DrawText := DrawText + #13#10;
        Inc(J);
      end;
      DrawText := DrawText + ExtractDelimeted(Text, Delimeter, I);
    end;

    H := TextHeight('Wg') * J;

    TmpRect := R;
    with TmpRect do
    begin
      Top := Max(Top, ((Bottom + Top) - H) div 2 - 1);
      Bottom := Min(Bottom, Top + H);
    end;
    Windows.DrawText(Handle, PChar(DrawText), -1, TmpRect, (DT_EXPANDTABS or
      DT_VCENTER) or Alignments[FAlignment]);
  end;

  if (FTabStyle = tsOwnerDraw) and Assigned(FOnDrawTab) then
    FOnDrawTab(Self, TabCanvas, R, Index, Selected);
end;

procedure TvgTabSet.SelectNext(Direction: Boolean);
var
  NewIndex: Integer;
begin
  if Tabs.Count > 1 then
  begin
    NewIndex := TabIndex;
    if Direction then
      Inc(NewIndex)
    else Dec(NewIndex);
    if NewIndex = Tabs.Count then
      NewIndex := 0
    else if NewIndex < 0 then
      NewIndex := Tabs.Count - 1;
    SetTabIndex(NewIndex);
  end;
end;

procedure TvgTabSet.FontChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TvgTabSet.Loaded;
begin
  inherited;
  SetTabIndex(FStreamedTabIndex);
end;

procedure TvgTabSet.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetAutoSizeX(Value: Boolean);
begin
  if FAutoSizeX <> Value then
  begin
    FAutoSizeX := Value;
    UpdateTabSizes;
  end;
end;

procedure TvgTabSet.SetAutoSizeY(Value: Boolean);
begin
  if FAutoSizeY <> Value then
  begin
    FAutoSizeY := Value;
    UpdateTabSizes;
  end;
end;

procedure TvgTabSet.SetFirstVisible(Value: Integer);
begin
  if (FFirstVisible <> Value) then
  begin
    if FTabs.Count = 0 then Value := 0;

    if (Value <= 0) and ((Value < FTabs.Count) or (FTabs.Count = 0)) then
    begin
      FFirstVisible := Value;
      Invalidate;
    end;
  end;
end;

procedure TvgTabSet.SetDefaultFocusFont(Value: Boolean);
begin
  if Value then
  begin
    SetFocusFont(Self.Font);
  end;
  FDefaultFocusFont := Value;
end;

procedure TvgTabSet.SetFocusFont(Value: TFont);
begin
  FFocusFont.Assign(Value);
  FDefaultFocusFont := False;
end;

procedure TvgTabSet.SetFocusOffset(Value: Integer);
begin
  if (FFocusOffset <> Value) and (Value >= 0) then
  begin
    FFocusOffset := Value;
    UpdateTabSizes;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetMargins(Index: Integer; Value: Integer);
begin
  if Value <> FMargins[Index] then
  begin
    FMargins[Index] := Value;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetRoundBorders(Value: Boolean);
begin
  if (FRoundBorders <> Value)  then
  begin
    FRoundBorders := Value;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetTabStyle(Value: TvgTabSetStyle);
begin
  if FTabStyle <> Value then
  begin
    FTabStyle := Value;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetTabIndex(Value: Integer);
begin
  if csLoading in ComponentState then
  begin
    FStreamedTabIndex := Value;
    Exit;
  end;
  if Value <> FTabIndex then
  begin
    if (Value < -1) or (Value >= Tabs.Count) then
      raise Exception.{$IFDEF _D3_}Create{$ELSE}CreateRes{$ENDIF}(SInvalidTabIndex);
    if CanChange(Value) then
    begin
      FTabIndex := Value;
      Repaint;
      Click;
    end;
  end;
end;

procedure TvgTabSet.SetTabList(Value: TStrings);
begin
  FTabs.Assign(Value);
  FTabIndex := -1;
  if FTabs.Count > 0 then TabIndex := 0 else Invalidate;
end;

procedure TvgTabSet.SetTabsAlign(Value: TTabSetAlign);
begin
  if Value = taNone then Value := taTop;
  if FTabsAlign <> Value then
  begin
    FTabsAlign := Value;
    case FTabsAlign of
      taLeft, taRight:
        begin FOffsetX := 0; FOffsetY := DefOffset; end;
      taTop, taBottom:
        begin FOffsetX := DefOffset; FOffsetY := 0; end;
    end;
    UpdateTabSizes;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetTabsHeight(Value: Integer);
begin
  if (FTabsHeight <> Value) and (Value > 0) then
  begin
    FTabsHeight := Value;
    UpdateTabSizes;
    Invalidate;
  end;
end;

procedure TvgTabSet.SetTabsWidth(Value: Integer);
begin
  if (FTabsWidth <> Value) and (Value > 0) then
  begin
    FTabsWidth := Value;
    UpdateTabSizes;
    Invalidate;
  end;
end;

function TvgTabSet.StoreFocusFont: Boolean;
begin
  Result := not FDefaultFocusFont;
end;

procedure TvgTabSet.UpdateTabSizes;
begin
  case FTabsAlign of
    taLeft, taRight:
    begin
      if FAutoSizeX then SetTabsWidth(Width - FocusOffset);
      FUpDown.Orientation := udVertical;
      FUpDown.SetBounds((Width - vtWidth - MarginStart) div 2, Height - vtHeight, vtWidth, vtHeight);
      FUpDown.Visible := FTabs.Count * FTabsHeight > Height;
      FUpDown.Max := Max(0, FTabs.Count - (Height - MarginStart) div FTabsHeight);
      FUpDown.Position := FUpDown.Max;
    end;
    taTop, taBottom:
    begin
      if FAutoSizeY then SetTabsHeight(Height - FocusOffset);
      FUpDown.Orientation := udHorizontal;
      FUpDown.SetBounds(Width - hzWidth, (Height - hzHeight - MarginStart) div 2 , hzWidth, hzHeight);
      FUpDown.Visible := FTabs.Count * FTabsWidth > Width;
      FUpDown.Max := Max(0, FTabs.Count - (Width - MarginStart) div FTabsWidth);
      FUpDown.Position := 0
    end;
  end;
end;

procedure TvgTabSet.UpDownClick(Sender: TObject; Button: TUDBtnType);
begin
  if (csDesigning in ComponentState) then Exit;

  if FTabsAlign in [taTop, taBottom] then
    case Button of
      btNext: Button := btPrev;
      btPrev: Button := btNext;
    end;

  case Button of
    btNext:
      begin
        if FFirstVisible < 0 then
          SetFirstVisible(FFirstVisible + 1);
      end;
    btPrev:
      begin
        if (- FFirstVisible) < FTabs.Count then
          SetFirstVisible(FFirstVisible - 1);
      end;
  end;
end;

procedure TvgTabSet.Paint;
var
  I: Integer;
begin
  inherited;
  FMemBitmap.Width := ClientWidth;
  FMemBitmap.Height := ClientHeight;
  with FMemBitmap.Canvas do
  begin
    Brush.Color := Self.Color;
    FillRect(Rect(0, 0, FMemBitmap.Width, FMemBitmap.Height));
    for I := 0 to FTabs.Count - 1 do
      if I <> FTabIndex then
        DrawTab(FMemBitmap.Canvas, ItemRect(I), I, False);
    case FTabsAlign of
      taLeft:
        DrawVert(FMemBitmap.Canvas, 1, 0, FMemBitmap.Height,
          False, False, False);
      taRight:
        DrawVert(FMemBitmap.Canvas, FMemBitmap.Width - 1, 0, FMemBitmap.Height,
          True, False, False);
      taTop:
        DrawHorz(FMemBitmap.Canvas, 0, 1, FMemBitmap.Width,
          False, False, False);
      taBottom:
        DrawHorz(FMemBitmap.Canvas, 0, FMemBitmap.Height - 1, FMemBitmap.Width,
          True, False, False);
    end;
    if FTabIndex >= 0 then
      DrawTab(FMemBitmap.Canvas, ItemRect(FTabIndex), FTabIndex, True)
  end;
  Canvas.Draw(0, 0, FMemBitmap);
end;

function TvgTabSet.ItemAtPos(Pos: TPoint): Integer;
  function TestItem(I: Integer): Boolean;
  begin
    Result := PtInRect(ItemRect(I), Pos)
  end;
var
  I: Integer;
begin
  Result := -1;
  if (Pos.Y < 0) or (Pos.Y > ClientHeight) then Exit;

  if (FTabIndex >= 0) and TestItem(FTabIndex) then
  begin
    Result := FTabIndex;
    Exit;
  end;

  for I := 0 to FTabs.Count - 1 do
    if (I <> FTabIndex) and TestItem(I) then
    begin
      Result := I;
      Break;
    end;
end;

function TvgTabSet.ItemRect(Item: Integer): TRect;
var
  X, Y: Integer;
begin
  if (Item >= 0) and (Item < FTabs.Count) then
  begin
    X := FOffsetX; Y := FOffsetY;
    case FTabsAlign of
      taRight:
        begin X := ClientWidth - FTabsWidth; end;
      taBottom:
        begin Y := ClientHeight - FTabsHeight; end;
    end;
    case FTabsAlign of
      taLeft, taRight:
        Inc(Y, (Item + FFirstVisible) * FTabsHeight + MarginStart);
      taTop, taBottom:
        Inc(X, (Item + FFirstVisible) * FTabsWidth + MarginStart);
    end;
    Result := Bounds(X, Y, FTabsWidth, FTabsHeight);
    if Item = FTabIndex then
    begin
      case FTabsAlign of
        taLeft, taRight:
          InflateRect(Result, 0, DefOffset);
        taTop, taBottom:
          InflateRect(Result, DefOffset, 0);
      end;
      case FTabsAlign of
        taLeft:
          Inc(Result.Right, FFocusOffset);
        taRight:
          Dec(Result.Left, FFocusOffset);
        taTop:
          Inc(Result.Bottom, FFocusOffset);
        taBottom:
          Dec(Result.Top, FFocusOffset);
      end;
    end;
    {
    case FTabsAlign of
      taLeft, taRight:
        begin
          if Tabs.Count * FTabsHeight + MarginStart > Height then
          begin
            J := Height div (FTabsHeight + MarginStart) - 1;
            if J < 0 then J := 0;
            if FTabIndex > J then
            begin
              I := FTabIndex - J; if I < 0 then I := 0;
              OffsetRect(Result, 0, - I * FTabsHeight);
            end;
          end;
        end;
      taTop, taBottom:
        begin
          if Tabs.Count * FTabsWidth + MarginStart > Width then
          begin
            J := Width div (FTabsWidth + MarginStart) - 1;
            if J < 0 then J := 0;
            if FTabIndex > J then
            begin
              I := FTabIndex - J; if I < 0 then I := 0;
              OffsetRect(Result, - I * FTabsWidth, 0);
            end;
          end;
        end;
    end;
    }
  end else
    Result := Rect(0, 0, 0, 0);
end;

procedure TvgTabSet.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) then
  begin
    I := ItemAtPos(Point(X, Y));
    if I >= 0 then SetTabIndex(I);
  end;
end;

procedure TvgTabSet.DrawTab(TabCanvas: TCanvas; R: TRect; Index: Integer;
      Selected: Boolean);
const
  RoundOffs = 2;

  function ROffs(Left, Top: Boolean): Integer;
  var
    DoOffs: Boolean;
  begin
    Result := 0; DoOffs := False;
    if not FRoundBorders then Exit;
    case FTabsAlign of
      taTop:
        DoOffs := not Top;
      taBottom:
        DoOffs := Top;
      taLeft:
        DoOffs := not Left;
      taRight:
        DoOffs := Left;
    end;
    if DoOffs then
    begin
      Result := RoundOffs;
      if (not Left) and (FTabsAlign <> taRight)
        or (not Top) and (FTabsAlign <> taBottom) then Inc(Result, 1);
    end;
  end;
var
  X, Y: Integer;
  Xhtl, Yhtl, Xhtr, Yhtr,
  Xvtr, Yvtr, Xvbr, YVbr,
  Xhbr, Yhbr, Xhbl, Yhbl,
  Xvbl, YVbl, Xvtl, YVtl: Integer;
  procedure DrawLT;
  begin
    DrawLine(TabCanvas, clBtnHighlight, Xvtl, Yvtl, Xhtl, Yhtl);
  end;
  procedure DrawRT;
  begin
    DrawLine(TabCanvas, clBlack, Xhtr, Yhtr, Xvtr, Yvtr);
  end;
  procedure DrawLB;
  begin
    DrawLine(TabCanvas, clBtnShadow, Xvbl, Yvbl, Xhbl, Yhbl);
  end;
  procedure DrawRB;
  begin
    DrawLine(TabCanvas, clBlack, Xhbr, Yhbr,
      Xvbr + Integer(FTabsAlign <> taRight), Yvbr - Integer(FTabsAlign <> taRight));
  end;
begin
  TabCanvas.Brush.Color := Self.Color;
  X := R.Left;
  Y := R.Top;
  TabCanvas.FillRect(R);

  { Right line and Bottom line must be 1 point shorter }
  if FTabsAlign <> taTop then
  begin
    Xhtl := X + ROffs(True, True);  Yhtl := Y;
    Xhtr := R.Right - ROffs(False, True);
    Yhtr := Y;
    DrawHorz(TabCanvas, Xhtl, Yhtl, Xhtr - Xhtl, True, False, False);
  end;
 if FTabsAlign <> taBottom then
  begin
    Xhbl := X + ROffs(True, False); Yhbl := R.Bottom - 1;
    Xhbr := R.Right - ROffs(False, False); Yhbr := R.Bottom - 1;
    DrawHorz(TabCanvas, Xhbl, Yhbl, Xhbr - Xhbl, False, False, False);
  end;
  if FTabsAlign <> taLeft then
  begin
    Xvtl := X; Yvtl := Y + ROffs(True, True);
    Xvbl := X; Yvbl := R.Bottom - ROffs(True, False);
    DrawVert(TabCanvas, Xvtl, Yvtl, Yvbl - Yvtl, True, False, False);
  end;
  if FTabsAlign <> taRight then
  begin
    Xvtr := R.Right - 1; Yvtr := Y + ROffs(False, True);
    Xvbr := R.Right - 1; Yvbr := R.Bottom - ROffs(False, False);
    DrawVert(TabCanvas, Xvtr, Yvtr, Yvbr - Yvtr, False, False, False);
  end;

  case FTabsAlign of
    taLeft:
      begin DrawRT; DrawRB; end;
    taRight:
      begin DrawLT; DrawLB; end;
    taTop:
      begin DrawLB; DrawRB; end;
    taBottom:
      begin DrawLT; DrawRT; end;
  end;

  Inc(R.Top, MarginTop + 1); Inc(R.Left, MarginLeft + 1);
  Dec(R.Right, MarginRight + 2); Dec(R.Bottom, MarginBottom + 2);

  DrawTabText(TabCanvas, R, Index, Selected);
end;

{ TClipboardShortCuts }
constructor TClipboardShortCuts.Create;
begin
  inherited Create;
  FActions := [caCopy, caCut, caDelete, caPaste, caSelectAll];
  FShortCuts[0] := scCopy;     FShortCuts[1] := scCut;
  FShortCuts[2] := scDelete;   FShortCuts[3] := scPaste;
  FShortCuts[4] := scSelectAll;
  FShortCuts2[0] := scCopy2;   FShortCuts2[1] := scCut2;
  FShortCuts2[2] := scDelete2; FShortCuts2[3] := scPaste2;
  FShortCuts2[4] := scSelectAll2;
end;

procedure TClipboardShortCuts.Assign(Source: TPersistent);
begin
  if (Source is TClipboardShortCuts) then
  with Source as TClipboardShortCuts do
  begin
    Self.FActions := FActions;
    Self.FShortCuts := FShortCuts;
    Self.FShortCuts2 := FShortCuts2;
  end;
  inherited;
end;

function TClipboardShortCuts.IsAction(Key: Word; Shift: TShiftState; Action: TClipboardAction): Boolean;
begin
  Result := IsShortCutAction(ShortCut(Key, Shift), Action);
end;

function TClipboardShortCuts.IsShortCutAction(ShortCut: TShortCut; Action: TClipboardAction): Boolean;
begin
  Result := (Action in Actions) and ((ShortCut = FShortCuts[Integer(Action)])
    or (ShortCut = FShortCuts2[Integer(Action)]));
end;

function TClipboardShortCuts.StoreActions: Boolean;
begin
  Result := FActions <> [caCopy, caCut, caDelete, caPaste, caSelectAll];
end;

{ TFormLoader }
destructor TFormLoader.Destroy;
begin
  while Assigned(FForms) do Forms[0].FormLoader := nil;
  inherited;
end;

procedure TFormLoader.DoActivate(SheetForm: TCustomSheetForm);
begin
  if not (csDestroying in ComponentState) and Assigned(FOnActivate) then FOnActivate(Self, SheetForm);
end;

procedure TFormLoader.DoDeactivate(SheetForm: TCustomSheetForm);
begin
  if not (csDestroying in ComponentState) and Assigned(FOnDeactivate) then FOnDeactivate(Self, SheetForm);
end;

procedure TFormLoader.DoInsert(SheetForm: TCustomSheetForm);
begin
  if Assigned(FOnInsert) then FOnInsert(Self, SheetForm);
end;

procedure TFormLoader.DoRemove(SheetForm: TCustomSheetForm);
begin
  if not (csDestroying in ComponentState) and Assigned(FOnRemove) then FOnRemove(Self, SheetForm);
end;

function TFormLoader.FindNextForm(AForm: TCustomSheetForm; GoForward: Boolean): TCustomSheetForm;
var
  I, J: Integer;
begin
  I := ListIndexOf(FForms, AForm);
  if I >= 0 then
  begin
    J := I;
    repeat
      if GoForward then
        J := (J + 1) mod ListCount(FForms) else
        J := (J - 1) mod ListCount(FForms);
      if J < 0 then J := ListCount(FForms) - 1;
      Result := ListItem(FForms, J);
      if I <> J then Exit;
    until J = I;
  end;
  Result := nil;
end;

function TFormLoader.GetForm(Index: Integer): TCustomSheetForm;
begin
  Result := ListItem(FForms, Index);
end;

function TFormLoader.GetFormCount: Integer;
begin
  Result := ListCount(FForms);
end;

function TFormLoader.GetSpeedBar(SheetForm: TCustomSheetForm): TWinControl;
begin
  Result := FSpeedBar;
  if Assigned(FOnGetSpeedBar) then FOnGetSpeedBar(Self, SheetForm, Result);
end;

function TFormLoader.GetWorkplace(SheetForm: TCustomSheetForm): TWinControl;
begin
  Result := FWorkPlace;
  if Assigned(FOnGetWorkplace) then FOnGetWorkplace(Self, SheetForm, Result);
end;

function TFormLoader.IndexOf(AForm: TCustomSheetForm): Integer;
begin
  Result := ListIndexOf(FForms, AForm);
end;

procedure TFormLoader.AddForm(AForm: TCustomSheetForm; Activate: Boolean);
begin
  InsertForm(FormCount, AForm, Activate)
end;

procedure TFormLoader.InsertForm(Index: Integer; AForm: TCustomSheetForm; Activate: Boolean);
var
  I: Integer;
begin
  I := ListIndexOf(FForms, AForm);
  if not Assigned(AForm.FormLoader) and (I < 0) then
  begin
    ListInsert(FForms, Index, AForm);
    AForm.FFormLoader := Self;
    DoInsert(AForm);
    LoadForm(AForm);
  end;
  if Activate and (AForm.FormLoader = Self) then SetActiveForm(AForm);
end;

procedure TFormLoader.LoadForm(AForm: TCustomSheetForm);
begin
  if Assigned(AForm.Sheet) then
  begin
    AForm.Sheet.Visible := False;
    AForm.Sheet.Parent := GetWorkplace(AForm);
  end;
  if Assigned(AForm.SpeedBar) then
  begin
    AForm.SpeedBar.Visible := False;
    AForm.SpeedBar.Parent := GetSpeedBar(AForm);
  end;
  if Assigned(AForm.OnShow) then AForm.OnShow(AForm);
end;

procedure TFormLoader.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = FMenu) then
      SetMenu(nil)
    else if (AComponent = FActiveMenu) then
      SetActiveMenu(nil)
    else if (AComponent = FWorkplace) then
      SetWorkplace(nil)
    else if (AComponent = FSpeedBar) then
      SetSpeedBar(nil)
    else if (AComponent = FActiveSpeedBar) then
      SetActiveSpeedBar(nil);
  end;
end;

procedure TFormLoader.RemoveForm(AForm: TCustomSheetForm);
var
  I: Integer;
  IsActive: Boolean;
  NextForm: TCustomSheetForm;
  Action: TCloseAction;
begin
  if AForm.FormLoader <> Self then Exit;
  I := ListIndexOf(FForms, AForm);
  if I >= 0 then
  begin
    Action := caHide;
    if Action in [caNone, caMinimize] then Exit;
    IsActive := (AForm = ActiveForm);
    if IsActive and not (csDestroying in ComponentState) then
      NextForm := FindNextForm(AForm, I = 0) else
      NextForm := nil;
    if IsActive then
      if Assigned(NextForm) then
        SetActiveForm(NextForm) else
        SetActiveForm(nil);
    DoRemove(AForm);
    ListDelete(FForms, I);
    AForm.FFormLoader := nil;
  end;
end;

procedure TFormLoader.SetActiveForm(Value: TCustomSheetForm);
begin
  if (FActiveForm <> Value) then
  begin
    if Assigned(FActiveForm) then
    begin
      DoDeactivate(FActiveForm);
      if Assigned(FActiveForm.OnDeactivate) then
        FActiveForm.OnDeactivate(FActiveForm);
    end;
    FActiveForm := Value;
    if Assigned(FActiveForm) then
    begin
      SetActiveMenu(FActiveForm.Menu);
      SetActiveSpeedBar(FActiveForm.SpeedBar);
      SetActiveSheet(FActiveForm.Sheet);
      if Assigned(FActiveForm.OnActivate) then
        FActiveForm.OnActivate(FActiveForm);
      DoActivate(FActiveForm);
    end else begin
      SetActiveSpeedBar(nil);
      SetActiveSheet(nil);
      SetActiveMenu(nil);
    end;
  end;
end;

procedure TFormLoader.SetActiveMenu(Value: TMainMenu);
begin
  if (FActiveMenu <> Value) then
  begin
    if Assigned(FActiveMenu) and Assigned(FMenu) then
      FMenu.UnMerge(FActiveMenu);
    FActiveMenu := Value;
    if Assigned(FActiveMenu) then
    begin
      FreeNotification(FActiveMenu);
      if Assigned(FMenu) then
        FMenu.Merge(FActiveMenu);
    end;
  end;
end;

procedure TFormLoader.SetActiveSheet(Value: TWinControl);
begin
  if (FActiveSheet <> Value) then
  begin
    if Assigned(FActiveSheet) and not (csDestroying in FActiveSheet.ComponentState) then
      FActiveSheet.Visible := False;
    FActiveSheet := Value;
    if Assigned(FActiveSheet) then
    begin
      FreeNotification(FActiveSheet);
      FActiveSheet.Visible := True;
      FActiveSheet.Parent := GetWorkplace(FActiveForm);
    end;
  end;
end;

procedure TFormLoader.SetActiveSpeedBar(Value: TWinControl);
begin
  if (FActiveSpeedBar <> Value) then
  begin
    if Assigned(FActiveSpeedBar) and not (csDestroying in FActiveSpeedBar.ComponentState) then
      FActiveSpeedBar.Visible := False;
    FActiveSpeedBar := Value;
    if Assigned(FActiveSpeedBar) then
    begin
      FreeNotification(FActiveSpeedBar);
      FActiveSpeedBar.Visible := True;
      FActiveSpeedBar.Parent := GetSpeedBar(ActiveForm);
    end;
  end;
end;

procedure TFormLoader.SetMenu(Value: TMainMenu);
begin
  if (FMenu <> Value) then
  begin
    if Assigned(FMenu) and Assigned(FActiveMenu) then FMenu.UnMerge(FActiveMenu);
    FMenu := Value;
    if Assigned(FMenu) then
    begin
      FreeNotification(Value);
      if Assigned(FActiveMenu) then FMenu.Merge(FActiveMenu);
    end;
  end;
end;

procedure TFormLoader.SetSpeedBar(Value: TWinControl);
var
  I: Integer;
  Form: TCustomSheetForm;
begin
  if (FSpeedBar <> Value) then
  begin
    for I := 0 to FormCount - 1 do
    begin
      Form := Forms[I];
      if not (csDestroying in Form.ComponentState) and Assigned(Form.SpeedBar) then
      begin
        Form.SpeedBar.Visible := Form = FActiveForm;
        Form.SpeedBar.Parent := Value;
      end;
    end;
    if Assigned(Value) then FreeNotification(Value);
    FSpeedBar := Value;
  end;
end;

procedure TFormLoader.SetWorkplace(Value: TWinControl);
var
  I: Integer;
  Form: TCustomSheetForm;
begin
  if (FWorkplace <> Value) then
  begin
    FWorkplace := Value;
    for I := 0 to FormCount - 1 do
    begin
      Form := Forms[I];
      if not (csDestroying in Form.ComponentState) and Assigned(Form.Sheet) then
      begin
        Form.Sheet.Visible := Form = FActiveForm;
        Form.Sheet.Parent := GetWorkPlace(Form);
      end;
    end;
    if Assigned(Value) then FreeNotification(Value);
  end;
end;

{ TCustomSheetForm }
destructor TCustomSheetForm.Destroy;
begin
  Destroying;
  SetFormLoader(nil);
  inherited;
end;

function TCustomSheetForm.GetIndex: Integer;
begin
  if Assigned(FFormLoader) then
    Result := FFormLoader.IndexOf(Self) else
    Result := -1;
end;

procedure TCustomSheetForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = FSpeedBar) then
      SetSpeedBar(nil);
  end;
end;

procedure TCustomSheetForm.SetFormLoader(Value: TFormLoader);
begin
  if (FFormLoader <> Value) then
  begin
    if Assigned(FFormLoader) then FFormLoader.RemoveForm(Self);
    if Assigned(Value) then Value.InsertForm(Value.FormCount - 1, Self, True);
  end;
end;

procedure TCustomSheetForm.SetSheet(Value: TWinControl);
begin
  if (FSheet <> Value) then
  begin
    FSheet := Value;
    if Assigned(FSheet) then
    begin
      FreeNotification(FSheet);
      if (FSheet = FSpeedBar) then SetSpeedBar(nil);
    end;
    if Assigned(FFormLoader) and (FFormLoader.ActiveForm = Self) then
      FFormLoader.ActiveSheet := Value;
  end;
end;

procedure TCustomSheetForm.SetSpeedBar(Value: TWinControl);
begin
  if (FSpeedBar <> Value) then
  begin
    FSpeedBar := Value;
    if Assigned(FSpeedBar) then
    begin
      FreeNotification(FSpeedBar);
      if (FSheet = FSpeedBar) then SetSheet(nil);
    end;
    if Assigned(FFormLoader) and (FFormLoader.ActiveForm = Self) then
      FFormLoader.ActiveSpeedBar := Value;
  end;
end;

end.


