{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Explorer library: controls                    }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit ExplCtrl;

interface
uses Windows, Messages, CommCtrl, Classes, Graphics, Controls, StdCtrls, Explorer, vgCtrls, ComCtrls;

type
{ TExplorerTreeNode }
  TExplorerTreeNode = class(TTreeNode)
  private
    FExplorerNodes: TExplorerNodes;
  protected
    procedure SetExplorerNodes(Value: TExplorerNodes);
  public
    destructor Destroy; override;
    property ExplorerNodes: TExplorerNodes read FExplorerNodes;
  end;

{ TCustomExplorerTreeView }
  TCustomExplorerTreeView = class(TvgCustomTreeView)
  private
    FChildrenChanging: Boolean;
    FExpandingNodes: TExplorerNodes;
    FExploreRoot: Boolean;
    FExplorerLink: TExplorerLink;
    FCollapsing: Boolean;
    FSaveSelected: TExplorerNodes;
    FShortCuts: TClipboardShortCuts;
    FSkipKeyPress: Boolean;
    FStreamedExplorerSource: TExplorerSource;
    function GetExplorerSource: TExplorerSource;
    function GetNodeTypes: TExplorerNodeTypes;
    function GetSelectedExplorerNodes: TExplorerNodes;
    function GetOnAcceptNode: TExplorerAcceptNodeEvent;
    function InternalCreateNode(ANode: TTreeNode; AExplorerNodes: TExplorerNodes;
      Visible: Boolean): TTreeNode;
    procedure InternalNotifyChange(AExplorerNodes: TExplorerNodes);
    procedure InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    procedure SetExploreRoot(Value: Boolean);
    procedure SetExplorerSource(Value: TExplorerSource);
    procedure SetNodeTypes(Value: TExplorerNodeTypes);
    procedure SetSelectedExplorerNodes(AExplorerNodes: TExplorerNodes);
    procedure SetShortCuts(Value: TClipboardShortCuts);
    procedure SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
    procedure UpdateImageLists;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
  protected
    function CanEdit(Node: TTreeNode): Boolean; override;
    function CanExpand(Node: TTreeNode): Boolean; override;
    procedure Change(Node: TTreeNode); override;
    procedure Collapse(Node: TTreeNode); override;
    function CreateNode: TTreeNode; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure DestroyWnd; override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TTVItem); override;
    procedure KeyDown(var Key: Word; ShiftState: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; ShiftState: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifyChange(AExplorerNodes: TExplorerNodes);
    procedure NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    procedure SetHasChildren(Node: TTreeNode);
    property ExploreRoot: Boolean read FExploreRoot write SetExploreRoot default True;
    property ExplorerSource: TExplorerSource read GetExplorerSource write SetExplorerSource;
    property NodeTypes: TExplorerNodeTypes read GetNodeTypes write SetNodeTypes default ntNodeTypesAll;
    property SelectedExplorerNodes: TExplorerNodes read GetSelectedExplorerNodes write SetSelectedExplorerNodes;
    property ShortCuts: TClipboardShortCuts read FShortCuts write SetShortCuts;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function FindNode(ExplorerNodes: TExplorerNodes): TTreeNode;
    procedure RestoreSelection;
    procedure SaveSelection;
    procedure SelectNode(Node: TTreeNode);
    property OnAcceptNode: TExplorerAcceptNodeEvent read GetOnAcceptNode write SetOnAcceptNode;
  end;

{ TExplorerTreeView }
  TExplorerTreeView = class(TCustomExplorerTreeView)
  public
    property SelectedExplorerNodes;
    property Items;
  published
    property ExploreRoot;
    property ExplorerSource;
    property NodeTypes;
    property ShortCuts;
    property OnAcceptNode;
    property HotTrack;
    property RowSelect;
    property ToolTips;
    property OnGetItemParams;
    {$IFDEF _D3_}
    {$IFDEF _D4_}
    property BorderWidth;
    property Anchors;
    property BiDiMode;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property ImeMode;
    property ImeName;
    property RightClickSelect;
    {$ENDIF}
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor default False;
    property ParentCtl3D;
    property Ctl3D;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    {$IFDEF _D4_}
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;

{ TExplorerListItem }
  TExplorerListItem = class(TListItem)
  private
    FExplorerNodes: TExplorerNodes;
  protected
    procedure SetExplorerNodes(Value: TExplorerNodes);
  public
    destructor Destroy; override;
    property ExplorerNodes: TExplorerNodes read FExplorerNodes;
  end;

{ TCustomExplorerListView }
  TLVGetItemParamsEvent = procedure (Sender: TObject; Item: TListItem; AFont: TFont;
    var Background: TColor; var State: TCustomDrawState) of object;

  TCustomExplorerListView = class(TCustomListView)
  private
    FChildrenChanging: Boolean;
    {$IFDEF _D3_}
    FCreating: Boolean;
    {$ENDIF}
    FExplorerLink: TExplorerLink;
    FSelection: TList;
    FSaveFocused: TExplorerNodes;
    FShortCuts: TClipboardShortCuts;
    FSkipKeyPress: Boolean;
    FStreamedExplorerSource: TExplorerSource;
    FOnGetItemParams: TLVGetItemParamsEvent;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    function GetExplorerSource: TExplorerSource;
    function GetNodeTypes: TExplorerNodeTypes;
    function GetSelectedExplorerNodes: TExplorerNodes;
    function GetOnAcceptNode: TExplorerAcceptNodeEvent;
    function InternalCreateItem(AExplorerNodes: TExplorerNodes): TListItem;
    procedure InternalNotifyChange(AExplorerNodes: TExplorerNodes);
    procedure InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    procedure SetBkColor(Value: TColor);
    procedure SetExplorerSource(Value: TExplorerSource);
    procedure SetNodeTypes(Value: TExplorerNodeTypes);
    procedure SetSelectedExplorerNodes(AExplorerNodes: TExplorerNodes);
    procedure SetShortCuts(Value: TClipboardShortCuts);
    procedure SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
    procedure UpdateImageLists;
    procedure WMRButtonDown(var Msg: TWMRButtonDown); message WM_RBUTTONDOWN;
  protected
    function CanEdit(Item: TListItem): Boolean; override;
    {$IFDEF _D3_}
    procedure Change(Item: TListItem; Change: Integer); override;
    {$ENDIF}
    procedure CreateWnd; override;
    function CreateListItem: TListItem; override;
    procedure DblClick; override;
    procedure DestroyWnd; override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TLVItem); override;
    procedure GetItemParams(Item: TListItem; AFont: TFont; var Background: TColor; var State: TCustomDrawState); virtual;
    procedure KeyDown(var Key: Word; ShiftState: TShiftState); override;
    procedure KeyUp(var Key: Word; ShiftState: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifyChange(AExplorerNodes: TExplorerNodes);
    procedure NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    property ExplorerSource: TExplorerSource read GetExplorerSource write SetExplorerSource;
    property NodeTypes: TExplorerNodeTypes read GetNodeTypes write SetNodeTypes default ntNodeTypesAll;
    property SelectedExplorerNodes: TExplorerNodes read GetSelectedExplorerNodes write SetSelectedExplorerNodes;
    property ShortCuts: TClipboardShortCuts read FShortCuts write SetShortCuts;
    property OnGetItemParams: TLVGetItemParamsEvent read FOnGetItemParams write FOnGetItemParams;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function FindItem(ExplorerNodes: TExplorerNodes): TListItem;
    procedure RestoreSelection;
    procedure SaveSelection;
    procedure SelectItem(Item: TListItem);
    property OnAcceptNode: TExplorerAcceptNodeEvent read GetOnAcceptNode write SetOnAcceptNode;
  end;

  TExplorerListView = class(TCustomExplorerListView)
  public
    property Items;
    property SelectedExplorerNodes;
  published
    property ExplorerSource;
    property NodeTypes;
    property ShortCuts;
    property OnAcceptNode;
    property Align;
    property OnGetItemParams;
    { Fixing recreating window exceptions }
    property Columns;
    {$IFDEF _D3_}
    {$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property DragKind;
    property FlatScrollBars;
    property FullDrag;
    property ParentBiDiMode;
    property HotTrackStyles;
    property OwnerData;
    property OwnerDraw;
    {$ENDIF}
    property ImeMode;
    property ImeName;
    property GridLines;
    property HotTrack;
    property Checkboxes;
    property RowSelect;
    {$ENDIF}
    property BorderStyle;
    property Color;
    property ColumnClick;
    property OnClick;
    property OnDblClick;
    property Ctl3D;
    property DragMode;
    property ReadOnly default False;
    property Enabled;
    property Font;
    property HideSelection;
    property IconOptions;
    property AllocBy;
    property MultiSelect;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property TabOrder;
    property TabStop default True;
    property ViewStyle;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnColumnClick;
    property OnCompare;
    property OnDeletion;
    property OnEdited;
    property OnEditing;
    property OnEnter;
    property OnExit;
    property OnInsert;
    property OnDragDrop;
    property OnDragOver;
    property DragCursor;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    {$IFDEF _D4_}
    property OnEndDock;
    property OnStartDock;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDrawItem;
    property OnSelectItem;
    {$ENDIF}
  end;

{$IFDEF _D3_}
{ TCustomExplorerListBox }
  TCustomExplorerListBox = class(TCustomListBox)
  private
  { Horizontal scrolling copied from RX library's TTextListBox component }
    FChildrenChanging: Boolean;
    FDragImage: {$IFDEF _D4_} TDragImageList {$ELSE} TImageList {$ENDIF};
    FExplorerLink: TExplorerLink;
    FMaxWidth: Integer;
    FRefs: TList;
    FSaveFocused: TExplorerNodes;
    FSelection: TList;
    FShortCuts: TClipboardShortCuts;
    FSkipKeyPress: Boolean;
    FStreamedExplorerSource: TExplorerSource;
    function GetExplorerNodes(Index: Integer): TExplorerNodes;
    function GetExplorerSource: TExplorerSource;
    function GetItemWidth(Index: Integer): Integer;
    function GetNodeTypes: TExplorerNodeTypes;
    function GetSelectedExplorerNodes: TExplorerNodes;
    function GetOnAcceptNode: TExplorerAcceptNodeEvent;
    procedure InternalCreateItem(AExplorerNodes: TExplorerNodes);
    procedure InternalNotifyChange(AExplorerNodes: TExplorerNodes);
    procedure InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    procedure ResetHorizontalExtent;
    procedure SetExplorerSource(Value: TExplorerSource);
    procedure SetHorizontalExtent;
    procedure SetNodeTypes(Value: TExplorerNodeTypes);
    procedure SetSelectedExplorerNodes(Value: TExplorerNodes);
    procedure SetShortCuts(Value: TClipboardShortCuts);
    procedure SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
  protected
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure DeleteString(Index: Integer); override;
    procedure DestroyWnd; override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    {$IFDEF _D4_}
    function GetDragImages: TDragImageList; override;
    {$ELSE}
    function GetDragImages: TCustomImageList; override;
    {$ENDIF}
    function GetItemData(Index: Integer): LongInt; override;
    procedure KeyDown(var Key: Word; ShiftState: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; ShiftState: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NotifyChange(AExplorerNodes: TExplorerNodes);
    procedure NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
    procedure ResetContent; override;
    procedure SetItemData(Index: Integer; AData: LongInt); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    function FindItem(ExplorerNodes: TExplorerNodes): Integer;
    procedure RestoreSelection;
    procedure SaveSelection;
    property ExplorerNodes[Index: Integer]: TExplorerNodes read GetExplorerNodes;
    property ExplorerSource: TExplorerSource read GetExplorerSource write SetExplorerSource;
    property NodeTypes: TExplorerNodeTypes read GetNodeTypes write SetNodeTypes default ntNodeTypesAll;
    property SelectedExplorerNodes: TExplorerNodes read GetSelectedExplorerNodes write SetSelectedExplorerNodes;
    property ShortCuts: TClipboardShortCuts read FShortCuts write SetShortCuts;
    property OnAcceptNode: TExplorerAcceptNodeEvent read GetOnAcceptNode write SetOnAcceptNode;
  end;

  TExplorerListBox = class(TCustomExplorerListBox)
  public
    property Items;
    property SelectedExplorerNodes;
  published
    property ExplorerSource;
    property NodeTypes;
    property ShortCuts;
    property OnAcceptNode;
    {$IFDEF _D4_}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property ImeMode;
    property ImeName;
    property Align;
    property BorderStyle;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property IntegralHeight;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF _D4_}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;
{$ENDIF}

{ TCustomExplorerTreeCombo }
  TCustomExplorerTreeCombo = class(TCustomComboBoxEdit)
  private
    FCanvas: TCanvas;
    FStreamedExplorerSource: TExplorerSource;
    function GetExploreRoot: Boolean;
    function GetExplorerSource: TExplorerSource;
    function GetNodeTypes: TExplorerNodeTypes;
    function GetTreeView: TExplorerTreeView;
    procedure SetExploreRoot(Value: Boolean);
    procedure SetExplorerSource(Value: TExplorerSource);
    procedure SetNodeTypes(Value: TExplorerNodeTypes);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    { TreeView properties }
    function GetTVShowButtons: Boolean;
    procedure SetTVShowButtons(Value: Boolean);
    function GetTVShowLines: Boolean;
    procedure SetTVShowLines(Value: Boolean);
    function GetTVShowRoot: Boolean;
    procedure SetTVShowRoot(Value: Boolean);
    function GetTVReadOnly: Boolean;
    procedure SetTVReadOnly(Value: Boolean);
    function GetTVIndent: Integer;
    procedure SetTVIndent(Value: Integer);
    function GetTVShortCuts: TClipboardShortCuts;
    procedure SetTVShortCuts(Value: TClipboardShortCuts);
    //function GetTVAutoExpand: Boolean;
    //procedure SetTVAutoExpand(Value: Boolean);
    function GetTVHotTrack: Boolean;
    procedure SetTVHotTrack(Value: Boolean);
    function GetTVRowSelect: Boolean;
    procedure SetTVRowSelect(Value: Boolean);
    function GetTVToolTips: Boolean;
    procedure SetTVToolTips(Value: Boolean);
    { TreeView events }
    function GetTVOnClick: TNotifyEvent;
    procedure SetTVOnClick(Value: TNotifyEvent);
    function GetTVOnDragDrop: TDragDropEvent;
    procedure SetTVOnDragDrop(Value: TDragDropEvent);
    function GetTVOnDragOver: TDragOverEvent;
    procedure SetTVOnDragOver(Value: TDragOverEvent);
    function GetTVOnStartDrag: TStartDragEvent;
    procedure SetTVOnStartDrag(Value: TStartDragEvent);
    function GetTVOnEndDrag: TEndDragEvent;
    procedure SetTVOnEndDrag(Value: TEndDragEvent);
    function GetTVOnMouseDown: TMouseEvent;
    procedure SetTVOnMouseDown(Value: TMouseEvent);
    function GetTVOnMouseMove: TMouseMoveEvent;
    procedure SetTVOnMouseMove(Value: TMouseMoveEvent);
    function GetTVOnMouseUp: TMouseEvent;
    procedure SetTVOnMouseUp(Value: TMouseEvent);
    function GetTVOnDblClick: TNotifyEvent;
    procedure SetTVOnDblClick(Value: TNotifyEvent);
    function GetTVOnKeyDown: TKeyEvent;
    procedure SetTVOnKeyDown(Value: TKeyEvent);
    function GetTVOnKeyPress: TKeyPressEvent;
    procedure SetTVOnKeyPress(Value: TKeyPressEvent);
    function GetTVOnKeyUp: TKeyEvent;
    procedure SetTVOnKeyUp(Value: TKeyEvent);
    function GetTVOnEditing: TTVEditingEvent;
    procedure SetTVOnEditing(Value: TTVEditingEvent);
    function GetTVOnEdited: TTVEditedEvent;
    procedure SetTVOnEdited(Value: TTVEditedEvent);
    function GetTVOnExpanding: TTVExpandingEvent;
    procedure SetTVOnExpanding(Value: TTVExpandingEvent);
    function GetTVOnExpanded: TTVExpandedEvent;
    procedure SetTVOnExpanded(Value: TTVExpandedEvent);
    function GetTVOnCollapsing: TTVCollapsingEvent;
    procedure SetTVOnCollapsing(Value: TTVCollapsingEvent);
    function GetTVOnCompare: TTVCompareEvent;
    procedure SetTVOnCompare(Value: TTVCompareEvent);
    function GetTVOnCollapsed: TTVExpandedEvent;
    procedure SetTVOnCollapsed(Value: TTVExpandedEvent);
    function GetTVOnChanging: TTVChangingEvent;
    procedure SetTVOnChanging(Value: TTVChangingEvent);
    function GetTVOnChange: TTVChangedEvent;
    procedure SetTVOnChange(Value: TTVChangedEvent);
    function GetTVOnDeletion: TTVExpandedEvent;
    procedure SetTVOnDeletion(Value: TTVExpandedEvent);
    function GetTVOnGetImageIndex: TTVExpandedEvent;
    procedure SetTVOnGetImageIndex(Value: TTVExpandedEvent);
    function GetTVOnGetSelectedIndex: TTVExpandedEvent;
    procedure SetTVOnGetSelectedIndex(Value: TTVExpandedEvent);
    {$IFDEF _D4_}
    function GetTVOnCustomDraw: TTVCustomDrawEvent;
    procedure SetTVOnCustomDraw(Value: TTVCustomDrawEvent);
    function GetTVOnCustomDrawItem: TTVCustomDrawItemEvent;
    procedure SetTVOnCustomDrawItem(Value: TTVCustomDrawItemEvent);
    {$ENDIF}
  protected
    procedure CreatePopupControl(var Control: TWinControl); override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
    property ExploreRoot: Boolean read GetExploreRoot write SetExploreRoot default True;
    property ExplorerSource: TExplorerSource read GetExplorerSource write SetExplorerSource;
    property NodeTypes: TExplorerNodeTypes read GetNodeTypes write SetNodeTypes default ntNodeTypesAll;
    property TreeView: TExplorerTreeView read GetTreeView;
    { TreeView properties }
    property TVShortCuts: TClipboardShortCuts read GetTVShortCuts write SetTVShortCuts;
    //property TVAutoExpand: Boolean read GetTVAutoExpand write SetTVAutoExpand default False;
    property TVHotTrack: Boolean read GetTVHotTrack write SetTVHotTrack default False;
    property TVRowSelect: Boolean read GetTVRowSelect write SetTVRowSelect default False;
    property TVToolTips: Boolean read GetTVToolTips write SetTVToolTips default True;
    property TVShowButtons: Boolean read GetTVShowButtons write SetTVShowButtons default True;
    property TVShowLines: Boolean read GetTVShowLines write SetTVShowLines default True;
    property TVShowRoot: Boolean read GetTVShowRoot write SetTVShowRoot default True;
    property TVReadOnly: Boolean read GetTVReadOnly write SetTVReadOnly default False;
    property TVIndent: Integer read GetTVIndent write SetTVIndent;
    { TreeView events }
    property TVOnClick: TNotifyEvent read GetTVOnClick write SetTVOnClick;
    property TVOnDragDrop: TDragDropEvent read GetTVOnDragDrop write SetTVOnDragDrop;
    property TVOnDragOver: TDragOverEvent read GetTVOnDragOver write SetTVOnDragOver;
    property TVOnStartDrag: TStartDragEvent read GetTVOnStartDrag write SetTVOnStartDrag;
    property TVOnEndDrag: TEndDragEvent read GetTVOnEndDrag write SetTVOnEndDrag;
    property TVOnMouseDown: TMouseEvent read GetTVOnMouseDown write SetTVOnMouseDown;
    property TVOnMouseMove: TMouseMoveEvent read GetTVOnMouseMove write SetTVOnMouseMove;
    property TVOnMouseUp: TMouseEvent read GetTVOnMouseUp write SetTVOnMouseUp;
    property TVOnDblClick: TNotifyEvent read GetTVOnDblClick write SetTVOnDblClick;
    property TVOnKeyDown: TKeyEvent read GetTVOnKeyDown write SetTVOnKeyDown;
    property TVOnKeyPress: TKeyPressEvent read GetTVOnKeyPress write SetTVOnKeyPress;
    property TVOnKeyUp: TKeyEvent read GetTVOnKeyUp write SetTVOnKeyUp;
    property TVOnEditing: TTVEditingEvent read GetTVOnEditing write SetTVOnEditing;
    property TVOnEdited: TTVEditedEvent read GetTVOnEdited write SetTVOnEdited;
    property TVOnExpanding: TTVExpandingEvent read GetTVOnExpanding write SetTVOnExpanding;
    property TVOnExpanded: TTVExpandedEvent read GetTVOnExpanded write SetTVOnExpanded;
    property TVOnCollapsing: TTVCollapsingEvent read GetTVOnCollapsing write SetTVOnCollapsing;
    property TVOnCompare: TTVCompareEvent read GetTVOnCompare write SetTVOnCompare;
    property TVOnCollapsed: TTVExpandedEvent read GetTVOnCollapsed write SetTVOnCollapsed;
    property TVOnChanging: TTVChangingEvent read GetTVOnChanging write SetTVOnChanging;
    property TVOnChange: TTVChangedEvent read GetTVOnChange write SetTVOnChange;
    property TVOnDeletion: TTVExpandedEvent read GetTVOnDeletion write SetTVOnDeletion;
    property TVOnGetImageIndex: TTVExpandedEvent read GetTVOnGetImageIndex write SetTVOnGetImageIndex;
    property TVOnGetSelectedIndex: TTVExpandedEvent read GetTVOnGetSelectedIndex write SetTVOnGetSelectedIndex;
    {$IFDEF _D4_}
    property TVOnCustomDraw: TTVCustomDrawEvent read GetTVOnCustomDraw write SetTVOnCustomDraw;
    property TVOnCustomDrawItem: TTVCustomDrawItemEvent read GetTVOnCustomDrawItem write SetTVOnCustomDrawItem;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

{ TExplorerTreeCombo }
  TExplorerTreeCombo = class(TCustomExplorerTreeCombo)
  public
    property TreeView;
  published
    property DisplayEmpty;
    property DropDownAlign;
    property DropDownHeight;
    property DropDownWidth;
    property ExplorerSource;
    property NodeTypes;
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
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
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
    { TreeView properties }
    property TVShortCuts;
    //property TVAutoExpand;
    property TVHotTrack;
    property TVRowSelect;
    property TVToolTips;
    property TVShowButtons;
    property TVShowLines;
    property TVShowRoot;
    property TVReadOnly;
    property TVIndent;
    { TreeView events }
    property TVOnClick;
    property TVOnDragDrop;
    property TVOnDragOver;
    property TVOnStartDrag;
    property TVOnEndDrag;
    property TVOnMouseDown;
    property TVOnMouseMove;
    property TVOnMouseUp;
    property TVOnDblClick;
    property TVOnKeyDown;
    property TVOnKeyPress;
    property TVOnKeyUp;
    property TVOnEditing;
    property TVOnEdited;
    property TVOnExpanding;
    property TVOnExpanded;
    property TVOnCollapsing;
    property TVOnCompare;
    property TVOnCollapsed;
    property TVOnChanging;
    property TVOnChange;
    property TVOnDeletion;
    property TVOnGetImageIndex;
    property TVOnGetSelectedIndex;
    {$IFDEF _D4_}
    property TVOnCustomDraw;
    property TVOnCustomDrawItem;
    {$ENDIF}
  end;

implementation
uses ComCtl98, Menus, vgUtils, vgVCLUtl, Forms, SysUtils;

{ TExplorerTreeNode }
procedure TExplorerTreeNode.SetExplorerNodes(Value: TExplorerNodes);
begin
  if (FExplorerNodes <> Value) then
  begin
    if Assigned(FExplorerNodes) then TCustomExplorerTreeView(TreeView).FExplorerLink.RemoveReference(FExplorerNodes);
    FExplorerNodes := Value;
    if Assigned(FExplorerNodes) then TCustomExplorerTreeView(TreeView).FExplorerLink.InsertReference(FExplorerNodes, Self);
  end;
end;

destructor TExplorerTreeNode.Destroy;
var
  Node: TTreeNode;
begin
  Node := Parent;
  if Assigned(Node) and (GetNextSibling = nil) and (GetPrevSibling = nil) then
    Node.Collapse(True);
  SetExplorerNodes(nil);
  inherited;
end;

{ TTreeViewExplorerLink }
type
  TTreeViewExplorerLink = class(TExplorerLink)
  private
    FTreeView: TCustomExplorerTreeView;
  public
    procedure ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes); override;
  end;

procedure TTreeViewExplorerLink.ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes);
begin
  case Event of
    eeActiveChange:
      begin
        FTreeView.UpdateImageLists;
        FTreeView.NotifyChange(ExplorerNodes);
      end;
    eeNodesChange:
      if AcceptsNodes(FTreeView, ExplorerNodes) then
        FTreeView.NotifyChange(ExplorerNodes);
    eeNodesChangeChildren:
      if (ExplorerNodes <> FTreeView.FExpandingNodes) and (NodeTypes * Self.NodeTypes <> []) then
        FTreeView.NotifyChangeChildren(ExplorerNodes);
    eeDisableControls:
      FTreeView.Items.BeginUpdate;
    eeEnableControls:
      FTreeView.Items.EndUpdate;
    eeSmallImagesChange, eeStateImagesChange:
      FTreeView.UpdateImageLists;
    eeSetSelected:
      FTreeView.SetSelectedExplorerNodes(ExplorerNodes);
  end;
end;

{ TCustomExplorerTreeView }
constructor TCustomExplorerTreeView.Create(AOwner: TComponent);
begin
  inherited;
  FShortCuts := TClipboardShortCuts.Create;
  FExploreRoot := True;
  FExplorerLink := TTreeViewExplorerLink.Create(False);
  TTreeViewExplorerLink(FExplorerLink).FTreeView := Self;
end;

destructor TCustomExplorerTreeView.Destroy;
begin
  SetExplorerSource(nil);
  FExplorerLink.Free;
  FShortCuts.Free;
  inherited;
end;

function TCustomExplorerTreeView.CanEdit(Node: TTreeNode): Boolean;
begin
  Result := inherited CanEdit(Node);
  if Assigned(Node) then ExplorerSource.DoEditing((Node as TExplorerTreeNode).ExplorerNodes, Result);
  if not Result then MessageBeep(0);
end;

function TCustomExplorerTreeView.CanExpand(Node: TTreeNode): Boolean;
begin
  Result := not (csDestroying in ComponentState) and inherited CanExpand(Node);
  if Result and Assigned(ExplorerSource) then
  begin
    FExpandingNodes := (Node as TExplorerTreeNode).ExplorerNodes;
    try
      ExplorerSource.DoExpanding(FExpandingNodes);
      NotifyChangeChildren(FExpandingNodes);
    finally
      FExpandingNodes := nil;
    end;
  end;
end;

procedure TCustomExplorerTreeView.Change(Node: TTreeNode);
begin
  if not FChildrenChanging then inherited;
end;

procedure TCustomExplorerTreeView.Collapse(Node: TTreeNode);
var
  Child: TTreeNode;
begin
  inherited;
  if not Node.Deleting then
  begin
    FCollapsing := True;
    try
      Child := Node.GetFirstChild;
      while Assigned(Child) do
      begin
        Child.DeleteChildren;
        Child := Node.GetNextChild(Child);
      end;
    finally
      FCollapsing := False;
    end;
  end;
end;

function TCustomExplorerTreeView.CreateNode: TTreeNode;
begin
  Result := TExplorerTreeNode.Create(Items);
end;

procedure TCustomExplorerTreeView.CreateParams(var Params: TCreateParams);
{$IFNDEF _D4_}
const
  ToolTipStyles: array[Boolean] of DWORD = (TVS_NOTOOLTIPS, 0);
  //AutoExpandStyles: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  HotTrackStyles: array[Boolean] of DWORD = (0, TCS_HOTTRACK);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
{$ENDIF}
begin
  inherited;
{$IFNDEF _D4_}
  with Params do
  begin
    Style := Style or
      ToolTipStyles[ToolTips] or //AutoExpandStyles[AutoExpand] or
      HotTrackStyles[HotTrack] or RowSelectStyles[RowSelect];
  end;
{$ENDIF}
end;

procedure TCustomExplorerTreeView.CreateWnd;
begin
  inherited;
  if Assigned(ExplorerSource) then FExplorerLink.ExplorerEvent(ExplorerSource.ExplorerRoot, eeActiveChange, []);
end;

procedure TCustomExplorerTreeView.DblClick;
var
  Node: TTreeNode;
begin
  inherited;
  Node := Selected;
  if Assigned(Node) then ExplorerSource.DoDblClick((Node as TExplorerTreeNode).ExplorerNodes);
end;

procedure TCustomExplorerTreeView.DestroyWnd;
begin
  if Assigned(ExplorerSource) then
    FExplorerLink.ExplorerEvent(nil, eeActiveChange, []);
  inherited;
end;

procedure TCustomExplorerTreeView.DoStartDrag(var DragObject: TDragObject);
var
  Node: TTreeNode;
begin
  inherited;
  if not Assigned(DragObject) then
  begin
    Node := Selected;
    if Assigned(Node) then
      with (Node as TExplorerTreeNode) do
        if ExplorerNodes.CanDrag then
        begin
          DragObject := TExplorerDragObject.Create(Self);
          try
            TExplorerDragObject(DragObject).Items.AddItem(ExplorerNodes);
          except
            DragObject.Free;
            DragObject := nil;
            raise;
          end;
        end;
  end;
end;

procedure TCustomExplorerTreeView.DragDrop(Source: TObject; X, Y: Integer);
var
  Node: TTreeNode;
  Dest: TExplorerNodes;
begin
  if Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    Node := GetNodeAt(X, Y);
    if Assigned(Node) then
      Dest := (Node as TExplorerTreeNode).ExplorerNodes else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      ExplorerSource.DoDragDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
  inherited;
end;

procedure TCustomExplorerTreeView.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Node: TTreeNode;
  Dest: TExplorerNodes;
begin
  inherited;
  if not Accept and Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    Node := GetNodeAt(X, Y);
    if Assigned(Node) then
      Dest := (Node as TExplorerTreeNode).ExplorerNodes else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      Accept := ExplorerSource.CanDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
end;

procedure TCustomExplorerTreeView.Edit(const Item: TTVItem);
var
  S: String;
  Node: TTreeNode;
begin
  with Item do
   if pszText <> nil then
   begin
     S := pszText;
     Node := GetTreeNodeFromItem(Self, Item);
     if Assigned(OnEdited) then OnEdited(Self, Node, S);
     if Assigned(Node) then ExplorerSource.DoEdit((Node as TExplorerTreeNode).ExplorerNodes, S);
   end;
end;

procedure TCustomExplorerTreeView.KeyDown(var Key: Word; ShiftState: TShiftState);
var
  Node: TTreeNode;
  Nodes: TExplorerNodes;
  List: TExplorerNodesList;
begin
  inherited;
  Node := Selected;
  if not (csDesigning in ComponentState)
    and Assigned(ExplorerSource) and Assigned(ExplorerSource.ExplorerRoot) and not IsEditing then
  begin
    List := TExplorerNodesList.Create(False);
    try
      if Assigned(Node) then
      begin
        Nodes := (Node as TExplorerTreeNode).ExplorerNodes;
        List.AddItem(Nodes);
      end else
        Nodes := ExplorerSource.ExplorerRoot;
      with FShortCuts do
        if IsAction(Key, ShiftState, caCopy) then
        begin
          if ExplorerSource.CanCopy(List) then
            ExplorerClipboard.Copy(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caCut) then
        begin
          if ExplorerSource.CanCut(List) then
            ExplorerClipboard.Cut(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caDelete) then
        begin
          if ExplorerSource.CanDelete(List) then
            ExplorerSource.DoDelete(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caPaste) then
        begin
          if Assigned(Nodes) and ExplorerSource.CanPaste(Nodes) then
            ExplorerClipboard.Paste(Nodes);
          FSkipKeyPress := True;
        end else begin
          inherited;
          Exit;
        end;
      Key := 0;
    finally
      List.Free;
    end;
  end;
end;

procedure TCustomExplorerTreeView.KeyPress(var Key: Char);
begin
  if not FSkipKeyPress then inherited else Key := #0;
end;

procedure TCustomExplorerTreeView.KeyUp(var Key: Word; ShiftState: TShiftState);
begin
  if not IsEditing then with FShortCuts do
    if IsAction(Key, ShiftState, caCopy) or IsAction(Key, ShiftState, caCut) or
       IsAction(Key, ShiftState, caDelete) or IsAction(Key, ShiftState, caPaste) then
    FSkipKeyPress := False;
  inherited;
end;

procedure TCustomExplorerTreeView.Loaded;
begin
  inherited;
  SetExplorerSource(FStreamedExplorerSource);
end;

function TCustomExplorerTreeView.FindNode(ExplorerNodes: TExplorerNodes): TTreeNode;
begin
  Result := FExplorerLink.FindReference(ExplorerNodes);
end;

function TCustomExplorerTreeView.GetExplorerSource: TExplorerSource;
begin
  Result := FExplorerLink.ExplorerSource;
end;

function TCustomExplorerTreeView.GetNodeTypes: TExplorerNodeTypes;
begin
  Result := FExplorerLink.NodeTypes;
end;

function TCustomExplorerTreeView.GetSelectedExplorerNodes: TExplorerNodes;
var
  Node: TTreeNode;
begin
  Node := Selected;
  if Assigned(Node) then
    Result := (Node as TExplorerTreeNode).ExplorerNodes else
    Result := nil;
end;

function TCustomExplorerTreeView.GetOnAcceptNode: TExplorerAcceptNodeEvent;
begin
  Result := FExplorerLink.OnAcceptNode;
end;

procedure TCustomExplorerTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = ExplorerSource) then
      SetExplorerSource(nil)
    else if (AComponent = FSaveSelected) then
      FSaveSelected := nil;
  end;
end;

procedure TCustomExplorerTreeView.NotifyChange(AExplorerNodes: TExplorerNodes);
begin
  if HandleAllocated then InternalNotifyChange(AExplorerNodes);
end;

procedure TCustomExplorerTreeView.NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
begin
  if not FChildrenChanging and not FCollapsing and HandleAllocated then InternalNotifyChangeChildren(AExplorerNodes);
end;

function TCustomExplorerTreeView.InternalCreateNode(ANode: TTreeNode; AExplorerNodes: TExplorerNodes; Visible: Boolean): TTreeNode;
var
  IsNew: Boolean;
  I: Integer;
begin
  if Visible then Items.BeginUpdate;
  try
    Result := FindNode(AExplorerNodes);
    if not Assigned(Result) then
    begin
      Result := Items.AddChild(ANode, AExplorerNodes.Text);
      IsNew := True;
    end else begin
      IsNew := False;
      if (Result.Text <> AExplorerNodes.Text) then
        Result.Text := AExplorerNodes.Text;
    end;
    with (Result as TExplorerTreeNode) do
    begin
      SetExplorerNodes(AExplorerNodes);
      I := ExplorerSource.GetImageIndex(AExplorerNodes, False);
      if IsNew or (ImageIndex <> I) then
        ImageIndex := I;
      I := ExplorerSource.GetOverlayIndex(AExplorerNodes);
      if IsNew or (OverlayIndex <> I) then
        OverlayIndex := I;
      I := ExplorerSource.GetSelectedIndex(AExplorerNodes);
      if IsNew or (SelectedIndex <> I) then
        SelectedIndex := I;
      I := ExplorerSource.GetStateIndex(AExplorerNodes);
      if IsNew or (StateIndex <> I) then
        StateIndex := I;
      SetHasChildren(Result);
    end;
  finally
    if Visible then Items.EndUpdate;
  end;
end;

procedure TCustomExplorerTreeView.InternalNotifyChange(AExplorerNodes: TExplorerNodes);
var
  I: Integer;
  Node: TTreeNode;
begin
  if Assigned(AExplorerNodes) then
  begin
    if (AExplorerNodes = ExplorerSource.ExplorerRoot) then
    begin
      if FExploreRoot then
        InternalCreateNode(nil, AExplorerNodes, True)
      else if FExplorerLink.AcceptsChildren(Self, AExplorerNodes) then
      begin
        Items.BeginUpdate;
        try
          for I := 0 to AExplorerNodes.Count - 1 do
            if FExplorerLink.AcceptsNodes(Self, AExplorerNodes[I]) then
              InternalCreateNode(nil, AExplorerNodes[I], True);
        finally
          Items.EndUpdate;
       end;
      end;
    end else begin
      Node := FindNode(AExplorerNodes);
      if Assigned(Node) then
        InternalCreateNode(Node, AExplorerNodes, True)
    end;
  end else begin
    Items.BeginUpdate;
    try
      Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TCustomExplorerTreeView.InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
var
  Node, Child, NextChild: TTreeNode;
  Nodes: TExplorerNodes;
  I: Integer;
  IsRoot, Expanded, SaveExpanded: Boolean;
begin
  FChildrenChanging := True;
  try
    IsRoot := not FExploreRoot and (AExplorerNodes = ExplorerSource.ExplorerRoot);
    if IsRoot then Node := nil else Node := FindNode(AExplorerNodes);
    if IsRoot or Assigned(Node) and Node.IsVisible then
    begin
      Expanded := IsRoot or Assigned(Node) and Node.IsVisible and Node.Expanded;
      if Expanded then Items.BeginUpdate;
      try
        SaveSelection;
        SaveExpanded := False;
        I := 0;
        if IsRoot then
        begin
          Child := Items.GetFirstNode;
          while Assigned(Child) do
          begin
            NextChild := Child.GetNextSibling;
            Nodes := (Child as TExplorerTreeNode).ExplorerNodes;
            if (Nodes.Parent <> AExplorerNodes) or
              (FExplorerLink.AcceptIndex(Self, Nodes) <> I) then
              Child.Delete else Inc(I);
            Child := NextChild;
          end;
        end else begin
          Child := Node.GetFirstChild;
          while Assigned(Child) do
          begin
            NextChild := Node.GetNextChild(Child);
            Nodes := (Child as TExplorerTreeNode).ExplorerNodes;
            if (Nodes.Parent <> AExplorerNodes) or
              (FExplorerLink.AcceptIndex(Self, Nodes) <> I) then
            begin
              if not Assigned(NextChild) then
              begin
                SaveExpanded := Node.Expanded;
                if SaveExpanded then Node.Expanded := False;
              end;
              Child.Delete;
            end else
              Inc(I);
            Child := NextChild;
          end;
        end;

        if FExplorerLink.AcceptsChildren(Self, AExplorerNodes) then
        begin
          if Expanded then Items.BeginUpdate;
          try
            for I := 0 to AExplorerNodes.Count - 1 do
              if FExplorerLink.AcceptsNodes(Self, AExplorerNodes[I]) then
                InternalCreateNode(Node, AExplorerNodes[I], Expanded);
          finally
            if Expanded then Items.EndUpdate;
          end;
        end;

        if not IsRoot then SetHasChildren(Node);
        if SaveExpanded and Node.HasChildren then Node.Expanded := True;
        if Expanded then RestoreSelection;
      finally
        if Expanded then Items.EndUpdate;
      end;
    end;
  finally
    FChildrenChanging := False;
  end;
end;

procedure TCustomExplorerTreeView.RestoreSelection;
var
  Node: TTreeNode;
begin
  FChildrenChanging := False;
  while Assigned(FSaveSelected) do
  begin
    Node := FindNode(FSaveSelected);
    if Assigned(Node) then
    begin
      SelectNode(Node);
      Exit;
    end else
      FSaveSelected := FSaveSelected.Parent;
  end;
end;

procedure TCustomExplorerTreeView.SaveSelection;
begin
  FSaveSelected := SelectedExplorerNodes;
  if Assigned(FSaveSelected) then FreeNotification(FSaveSelected);
end;

procedure TCustomExplorerTreeView.SelectNode(Node: TTreeNode);
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

procedure TCustomExplorerTreeView.SetHasChildren(Node: TTreeNode);
var
  Nodes: TExplorerNodes;
  HasChildren, NewHasChildren: Boolean;
  ANodeTypes: TExplorerNodeTypes;
begin
  Nodes := (Node as TExplorerTreeNode).ExplorerNodes;
  HasChildren := Node.HasChildren;
  if Assigned(OnAcceptNode) then ANodeTypes := ntNodeTypesAll else ANodeTypes := NodeTypes;
  NewHasChildren := { HasChildren and } FExplorerLink.AcceptsChildren(Self, Nodes) or
    not Nodes.Expanded and Nodes.CanExpand(ANodeTypes);
  if HasChildren <> NewHasChildren then Node.HasChildren := NewHasChildren;
end;

procedure TCustomExplorerTreeView.SetExploreRoot(Value: Boolean);
begin
  if (FExploreRoot <> Value) then
  begin
    FExploreRoot := Value;
    if Assigned(ExplorerSource) then
    begin
      FExpandingNodes := ExplorerSource.ExplorerRoot;
      if Assigned(FExpandingNodes) then
      try
        NotifyChange(nil);
        if not FExploreRoot then
        begin
          ExplorerSource.DoExpanding(FExpandingNodes);
          NotifyChangeChildren(FExpandingNodes);
        end else
          NotifyChange(FExpandingNodes);
      finally
        FExpandingNodes := nil;
      end;
    end;
  end;
end;

procedure TCustomExplorerTreeView.SetExplorerSource(Value: TExplorerSource);
begin
  if (csLoading in ComponentState) then
    FStreamedExplorerSource := Value
  else
    FExplorerLink.ExplorerSource := Value;
  if Assigned(Value) then FreeNotification(Value);
end;

procedure TCustomExplorerTreeView.SetNodeTypes(Value: TExplorerNodeTypes);
begin
  FExplorerLink.NodeTypes := Value;
end;

procedure TCustomExplorerTreeView.SetSelectedExplorerNodes(AExplorerNodes: TExplorerNodes);
var
  Node: TTreeNode;
  Nodes, Root: TExplorerNodes;
  List: TList;
  Updating: Boolean;
begin
  if not HandleAllocated then Exit;
  Nodes := AExplorerNodes;
  if ExplorerSource.ExplorerRoot.IsParentOf(Nodes) then
  begin
    List := TList.Create;
    try
      Root := ExplorerSource.ExplorerRoot;
      repeat
        List.Add(Nodes);
        Node := FindNode(Nodes);
        if Nodes = Root then
          Nodes := nil
        else
          Nodes := Nodes.Parent;
      until Assigned(Node) or not Assigned(Nodes);

      Updating := List.Count > 2;
      if Updating then Items.BeginUpdate;
      try
        while Assigned(Node) do
        begin
          SelectNode(Node);
          if TExplorerTreeNode(Node).ExplorerNodes <> AExplorerNodes then
            Node.Expand(False) else Break;

          Node := FindNode(List.Last);
          List.Delete(List.Count - 1);
        end;
      finally
        if Updating then Items.EndUpdate;
      end;
    finally
      List.Free;
    end;
  end;
end;

procedure TCustomExplorerTreeView.SetShortCuts(Value: TClipboardShortCuts);
begin
  FShortCuts.Assign(Value);
end;

procedure TCustomExplorerTreeView.SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
begin
  FExplorerLink.OnAcceptNode := Value;
end;

procedure TCustomExplorerTreeView.UpdateImageLists;
begin
  if Assigned(ExplorerSource) then
  begin
    if Images <> ExplorerSource.GetSmallImages then
      Images := ExplorerSource.GetSmallImages;
    if StateImages <> ExplorerSource.GetStateImages then
      StateImages := ExplorerSource.GetStateImages;
  end else begin
    if Images <> nil then Images := nil;
    if StateImages <> nil then StateImages := nil;
  end;
end;

procedure TCustomExplorerTreeView.WMRButtonDown(var Msg: TWMRButtonDown);
var
  Node: TTreeNode;
  Menu: TPopupMenu;
  P: TPoint;
begin
  Node := GetNodeAt(Msg.XPos, Msg.YPos);
  if Assigned(Node) then
  begin
    SelectNode(Node);
    Menu := (Node as TExplorerTreeNode).ExplorerNodes.PopupMenu;
    if Assigned(Menu) then
    begin
      P := ClientToScreen(Point(Msg.XPos, Msg.YPos));
      Menu.Popup(P.X, P.Y);
    end;
  end;
  inherited;
end;

{ TExplorerListItem }
destructor TExplorerListItem.Destroy;
begin
  SetExplorerNodes(nil);
  inherited;
end;

procedure TExplorerListItem.SetExplorerNodes(Value: TExplorerNodes);
begin
  if (FExplorerNodes <> Value) then
  begin
    if Assigned(FExplorerNodes) then TCustomExplorerListView(ListView).FExplorerLink.RemoveReference(FExplorerNodes);
    FExplorerNodes := Value;
    if Assigned(FExplorerNodes) then TCustomExplorerListView(ListView).FExplorerLink.InsertReference(FExplorerNodes, Self);
  end;
end;

{ TListViewExplorerLink }
type
  TListViewExplorerLink = class(TExplorerLink)
  private
    FExpandingNodes: TExplorerNodes;
    FListView: TCustomExplorerListView;
  public
    procedure ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes); override;
  end;

procedure TListViewExplorerLink.ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes);
var
  Item: TListItem;
begin
  case Event of
    eeActiveChange:
      begin
        FListView.UpdateImageLists;
        if Assigned(ExplorerNodes) then
        begin
          FExpandingNodes := ExplorerNodes;
          try
            ExplorerSource.DoExpanding(ExplorerNodes);
            FListView.NotifyChangeChildren(ExplorerNodes);
          finally
            FExpandingNodes := nil;
          end;
        end else
          FListView.NotifyChange(nil);
      end;
    eeNodesChange:
      if AcceptsNodes(FListView, ExplorerNodes) then
        FListView.NotifyChange(ExplorerNodes);
    eeNodesChangeChildren:
      if (FExpandingNodes <> ExplorerNodes) and (NodeTypes * Self.NodeTypes <> []) then
        FListView.NotifyChangeChildren(ExplorerNodes);
    eeDisableControls:
      FListView.Items.BeginUpdate;
    eeEnableControls:
      FListView.Items.EndUpdate;
    eeLargeImagesChange, eeSmallImagesChange, eeStateImagesChange:
      FListView.UpdateImageLists;
    eeSetSelected:
      if (ExplorerNodes.Parent = ExplorerSource.ExplorerRoot) and FListView.HandleAllocated then
      begin
        Item := FListView.FindItem(ExplorerNodes);
        if Assigned(Item) then
          FListView.SelectedExplorerNodes := ExplorerNodes;
      end;
  end;
end;

{ TCustomExplorerListView }
constructor TCustomExplorerListView.Create(AOwner: TComponent);
begin
  inherited;
  FShortCuts := TClipboardShortCuts.Create;
  FExplorerLink := TListViewExplorerLink.Create(False);
  TListViewExplorerLink(FExplorerLink).FListView := Self;
end;

function TCustomExplorerListView.CanEdit(Item: TListItem): Boolean;
begin
  Result := inherited CanEdit(Item);
  if Assigned(Item) then ExplorerSource.DoEditing((Item as TExplorerListItem).ExplorerNodes, Result);
  if not Result then MessageBeep(0);
end;

{$IFDEF _D3_}
procedure TCustomExplorerListView.Change(Item: TListItem; Change: Integer);
var
  Nodes: TExplorerNodes;
begin
  inherited;
  if Assigned(Item) and CheckBoxes and not FCreating and (Change = LVIF_STATE) then
  begin
    Nodes := TExplorerListItem(Item).ExplorerNodes;
    if Assigned(Nodes) and Nodes.Enabled then Nodes.Checked := Item.Checked;
  end;
end;
{$ENDIF}

function TCustomExplorerListView.CreateListItem: TListItem;
begin
  Result := TExplorerListItem.Create(Items);
end;

procedure TCustomExplorerListView.CreateWnd;
begin
  inherited;
  SetBkColor(Color);
  if Assigned(ExplorerSource) then FExplorerLink.ExplorerEvent(ExplorerSource.ExplorerRoot, eeActiveChange, []);
end;

destructor TCustomExplorerListView.Destroy;
begin
  SetExplorerSource(nil);
  FExplorerLink.Free;
  FShortCuts.Free;
  inherited;
end;

procedure TCustomExplorerListView.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then SetBkColor(Color);
end;

procedure TCustomExplorerListView.CNNotify(var Message: TWMNotify);
var
  Item: TListItem;
  AFont: TFont;
  ABackgrnd: TColor;
  var State: TCustomDrawState;
begin
  {$IFDEF _D4_}
  if Assigned(OnCustomDrawItem) then
  begin
    inherited;
    Exit;
  end;
  {$ENDIF}
  case Message.NMHdr^.code of
    NM_CUSTOMDRAW:
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
                Item := Items[dwItemSpec];
                GetItemParams(Item, AFont, ABackgrnd, State);
                uItemState := Word(State);
                SetTextColor(hdc, ColorToRGB(AFont.Color));
                Windows.SetBkColor(hdc, ColorToRGB(ABackgrnd));
                SelectObject(hdc, AFont.Handle);
              finally
                AFont.Free;
              end;
              Message.Result := CDRF_DODEFAULT;
            END;
        else
          Message.Result := 0;
        end;
      end;
  else
    inherited;
  end;
end;

procedure TCustomExplorerListView.Edit(const Item: TLVItem);
var
  S: String;
  EditItem: TListItem;
begin
  with Item do
  begin
    S := pszText;
    EditItem := GetListItemFromItem(Self, Item);
    if Assigned(OnEdited) then OnEdited(Self, EditItem, S);
    if Assigned(EditItem) then
      ExplorerSource.DoEdit((EditItem as TExplorerListItem).ExplorerNodes, S);
  end;
end;

function TCustomExplorerListView.GetExplorerSource: TExplorerSource;
begin
  Result := FExplorerLink.ExplorerSource;
end;

function TCustomExplorerListView.GetNodeTypes: TExplorerNodeTypes;
begin
  Result := FExplorerLink.NodeTypes;
end;

function TCustomExplorerListView.GetOnAcceptNode: TExplorerAcceptNodeEvent;
begin
  Result := FExplorerLink.OnAcceptNode;
end;

procedure TCustomExplorerListView.SetBkColor(Value: TColor);
begin
  ListView_SetBkColor(Handle, ColorToRGB(Value));
end;

procedure TCustomExplorerListView.SetExplorerSource(Value: TExplorerSource);
begin
  if (csLoading in ComponentState) then
    FStreamedExplorerSource := Value
  else
    FExplorerLink.ExplorerSource := Value;
  if Assigned(Value) then FreeNotification(Value);
end;

procedure TCustomExplorerListView.SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
begin
  FExplorerLink.OnAcceptNode := Value;
end;

procedure TCustomExplorerListView.DblClick;
var
  Item: TListItem;
begin
  inherited;
  Item := Selected;
  if Assigned(Item) then ExplorerSource.DoDblClick((Item as TExplorerListItem).ExplorerNodes);
end;

procedure TCustomExplorerListView.DestroyWnd;
begin
  if Assigned(ExplorerSource) then FExplorerLink.ExplorerEvent(nil, eeActiveChange, []);
  inherited;
end;

procedure TCustomExplorerListView.DoStartDrag(var DragObject: TDragObject);
var
  I: Integer;
  Item: TListItem;
  Nodes: TExplorerNodes;
begin
  inherited;
  if not Assigned(DragObject) then
  begin
    DragObject := TExplorerDragObject.Create(Self);
    try
      if SelCount > 0 then
      begin
        for I := 0 to Items.Count - 1 do
        begin
          Item := Items[I];
          if Item.Selected then
          begin
            Nodes := (Item as TExplorerListItem).ExplorerNodes;
            if Nodes.CanDrag then TExplorerDragObject(DragObject).Items.AddItem(Nodes);
          end;
        end;
      end else begin
        Item := Selected;
        if Assigned(Item) then
        begin
          Nodes := (Item as TExplorerListItem).ExplorerNodes;
          if Nodes.CanDrag then TExplorerDragObject(DragObject).Items.AddItem(Nodes);
        end;
      end;
      if TExplorerDragObject(DragObject).Items.Count = 0 then
      begin
        DragObject.Free;
        DragObject := nil;
      end;
    except
      DragObject.Free;
      DragObject := nil;
      raise;
    end;
  end;
end;

procedure TCustomExplorerListView.DragDrop(Source: TObject; X, Y: Integer);
var
  Item: TListItem;
  Dest: TExplorerNodes;
begin
  if Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    Item := GetItemAt(X, Y);
    if Assigned(Item) then
      Dest := (Item as TExplorerListItem).ExplorerNodes else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      ExplorerSource.DoDragDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
  inherited;
end;

procedure TCustomExplorerListView.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  Item: TListItem;
  Dest: TExplorerNodes;
begin
  inherited;
  if not Accept and Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    Item := GetItemAt(X, Y);
    if Assigned(Item) then
      Dest := (Item as TExplorerListItem).ExplorerNodes else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      Accept := ExplorerSource.CanDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
end;

function TCustomExplorerListView.FindItem(ExplorerNodes: TExplorerNodes): TListItem;
begin
  Result := FExplorerLink.FindReference(ExplorerNodes);
end;

procedure TCustomExplorerListView.GetItemParams(Item: TListItem; AFont: TFont;
  var Background: TColor; var State: TCustomDrawState);
begin
  if Assigned(FOnGetItemParams) then FOnGetItemParams(Self, Item, AFont, Background, State);
end;

function TCustomExplorerListView.GetSelectedExplorerNodes: TExplorerNodes;
var
  Node: TListItem;
begin
  Node := Selected;
  if Assigned(Node) then
    Result := (Node as TExplorerListItem).ExplorerNodes else
    Result := nil;
end;

function TCustomExplorerListView.InternalCreateItem(AExplorerNodes: TExplorerNodes): TListItem;
var
  IsNew: Boolean;
  I: Integer;
begin
  Result := FindItem(AExplorerNodes);
  {$IFDEF _D3_}
  FCreating := True;
  try
  {$ENDIF}
    if not Assigned(Result) then
    begin
      Result := Items.Add;
      IsNew := True;
    end else
      IsNew := False;

    with (Result as TExplorerListItem) do
    begin
      if IsNew or (Caption <> AExplorerNodes.Text) then
        Caption := AExplorerNodes.Text;
      SetExplorerNodes(AExplorerNodes);
      I := ExplorerSource.GetImageIndex(AExplorerNodes, ViewStyle = vsIcon);
      if IsNew or (ImageIndex <> I) then
        ImageIndex := I;
      I := ExplorerSource.GetOverlayIndex(AExplorerNodes);
      if IsNew or (OverlayIndex <> I) then
        OverlayIndex := I;
      {$IFDEF _D3_}
      if CheckBoxes then
      begin
        if (IsNew or (Checked <> AExplorerNodes.Checked)) then
          Checked := AExplorerNodes.Checked;
      end else
      {$ENDIF}
      begin
        I := ExplorerSource.GetStateIndex(AExplorerNodes);
        if IsNew or (StateIndex <> I) then
          StateIndex := I;
      end;
      if IsNew or (SubItems.Text <> AExplorerNodes.SubItems.Text) then
        SubItems := AExplorerNodes.SubItems;
    end;
  {$IFDEF _D3_}
  finally
    FCreating := False;
  end;
  {$ENDIF}
end;

procedure TCustomExplorerListView.InternalNotifyChange(AExplorerNodes: TExplorerNodes);
begin
  if not Assigned(AExplorerNodes) then
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end else if (AExplorerNodes.Parent = ExplorerSource.ExplorerRoot) and
    FExplorerLink.AcceptsNodes(Self, AExplorerNodes) then
      InternalCreateItem(AExplorerNodes);
end;

procedure TCustomExplorerListView.InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
var
  I, J, Count: Integer;
  Item: TListItem;
  Nodes: TExplorerNodes;
  ExplorerRoot: TExplorerNodes;
begin
  ExplorerRoot := ExplorerSource.ExplorerRoot;
  if (AExplorerNodes <> ExplorerRoot) then Exit;
  Items.BeginUpdate;
  try
    FChildrenChanging := True;
    try
      SaveSelection;
      try
        I := 0; Count := Items.Count;
        while I < Count do
        begin
          Item := Items[I];
          Nodes := (Item as TExplorerListItem).ExplorerNodes;
          if Assigned(Nodes.Parent) then
            J := FExplorerLink.AcceptIndex(Self, Nodes) else
            J := -1;
          if (Nodes.Parent <> ExplorerRoot) or (J <> I) then
            begin
              if (Nodes = FSaveFocused) and ((J < 0) or (Nodes.Parent <> ExplorerRoot))then
              begin
                if (I < Count - 1) then
                  FSaveFocused := (Items[I + 1] as TExplorerListItem).ExplorerNodes
                else if (I > 0) then
                  FSaveFocused := (Items[I - 1] as TExplorerListItem).ExplorerNodes
                else
                  FSaveFocused := nil;
              end;
              Item.Delete;
              Dec(Count);
            end else
              Inc(I);
        end;

        ExplorerSource.DoExpanding(ExplorerRoot);
        for I := 0 to ExplorerRoot.Count - 1 do
          if FExplorerLink.AcceptsNodes(Self, ExplorerRoot[I]) then
            InternalCreateItem(ExplorerRoot[I]);
      finally
        RestoreSelection;
      end;
    finally
      FChildrenChanging := False;
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TCustomExplorerListView.KeyDown(var Key: Word; ShiftState: TShiftState);
var
  I, Count: Integer;
  Item: TListItem;
  Nodes: TExplorerNodes;
  List: TExplorerNodesList;
begin
  inherited;
  if not (csDesigning in ComponentState)
    and Assigned(ExplorerSource) and Assigned(ExplorerSource.ExplorerRoot) and not IsEditing then
  begin
    List := TExplorerNodesList.Create(False);
    try
      if SelCount > 0 then
      begin
        for I := 0 to Items.Count - 1 do
        begin
          Item := Items[I];
          if Item.Selected then List.AddItem((Item as TExplorerListItem).ExplorerNodes);
        end;
      end;
      Nodes := ExplorerSource.ExplorerRoot;
      with FShortCuts do
        if IsAction(Key, ShiftState, caCopy) then
        begin
          if ExplorerSource.CanCopy(List) then
            ExplorerClipboard.Copy(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caCut) then
        begin
          if ExplorerSource.CanCut(List) then
            ExplorerClipboard.Cut(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caDelete) then
        begin
          if ExplorerSource.CanDelete(List) then
            ExplorerSource.DoDelete(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caPaste) then
        begin
          if Assigned(Nodes) and ExplorerSource.CanPaste(Nodes) then
            ExplorerClipboard.Paste(Nodes);
          FSkipKeyPress := True;
        end else if MultiSelect and IsAction(Key, ShiftState, caSelectAll) then
        begin
          Items.BeginUpdate;
          try
            Count := Items.Count - 1;
            for I := 0 to Count do Items[I].Selected := True;
          finally
            Items.EndUpdate;
          end;
          FSkipKeyPress := True;
        end else begin
          inherited;
          Exit;
        end;
      Key := 0;
    finally
      List.Free;
    end;
  end;
end;

procedure TCustomExplorerListView.KeyUp(var Key: Word; ShiftState: TShiftState);
begin
  if not IsEditing then with FShortCuts do
    if IsAction(Key, ShiftState, caCopy) or IsAction(Key, ShiftState, caCut) or
       IsAction(Key, ShiftState, caDelete) or  IsAction(Key, ShiftState, caPaste) or
       IsAction(Key, ShiftState, caSelectAll) then
    FSkipKeyPress := False;
  inherited;
end;

procedure TCustomExplorerListView.Loaded;
begin
  inherited;
  SetExplorerSource(FStreamedExplorerSource);
end;

procedure TCustomExplorerListView.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = ExplorerSource) then
      SetExplorerSource(nil)
    else if Assigned(FSelection) then
    begin
      I := FSelection.IndexOf(AComponent);
      if I >= 0 then FSelection.Delete(I);
    end else if (AComponent = FSaveFocused) then
      FSaveFocused := nil;
  end;
end;

procedure TCustomExplorerListView.NotifyChange(AExplorerNodes: TExplorerNodes);
begin
  if HandleAllocated then InternalNotifyChange(AExplorerNodes);
end;

procedure TCustomExplorerListView.NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
begin
  if not FChildrenChanging and HandleAllocated then InternalNotifyChangeChildren(AExplorerNodes);
end;

procedure TCustomExplorerListView.RestoreSelection;
var
  I, Count: Integer;
  Item, FocusItem: TListItem;
  Nodes: TExplorerNodes;
begin
  try
    Count := Items.Count - 1;
    FocusItem := nil;
    for I := 0 to Count do
    begin
      Item := Items[I];
      Nodes := (Item as TExplorerListItem).ExplorerNodes;
      if ListIndexOf(FSelection, Nodes) >= 0 then Item.Selected := True;
      if FSaveFocused = Nodes then FocusItem := Item;
    end;
    if Assigned(FocusItem) then SelectItem(FocusITem);
  finally
    FSelection.Free;
    FSelection := nil;
  end;
end;

procedure TCustomExplorerListView.SaveSelection;
var
  I: Integer;
  Item: TListItem;
  Nodes: TExplorerNodes;
begin
  FSelection.Free;
  FSelection := nil;
  try
    FSaveFocused := nil;
    for I := 0 to Items.Count - 1 do
    begin
      Item := Items[I];
      if Item.Selected then
      begin
        Nodes := (Item as TExplorerListItem).ExplorerNodes;
        ListAdd(FSelection, Nodes);
        FreeNotification(Nodes);
        if Item.Focused then FSaveFocused := Nodes;
      end;
    end;
  except
    FSelection.Free;
    FSelection := nil;
    raise;
  end;
end;

procedure TCustomExplorerListView.SelectItem(Item: TListItem);
begin
  Selected := Item;
  if Assigned(Item) then Item.Focused := True;
end;

procedure TCustomExplorerListView.SetNodeTypes(Value: TExplorerNodeTypes);
begin
  FExplorerLink.NodeTypes := Value;
end;

procedure TCustomExplorerListView.SetSelectedExplorerNodes(AExplorerNodes: TExplorerNodes);
var
  Item: TListItem;
begin
  if Assigned(ExplorerSource) and Assigned(AExplorerNodes) and
    (ExplorerSource.ExplorerRoot = AExplorerNodes.Parent) then
    Item := FindItem(AExplorerNodes) else Item := nil;

  Selected := Item;
  if Assigned(Item) then Item.Focused := True;
end;

procedure TCustomExplorerListView.SetShortCuts(Value: TClipboardShortCuts);
begin
  FShortCuts.Assign(Value);
end;

procedure TCustomExplorerListView.UpdateImageLists;
begin
  if Assigned(ExplorerSource) then
  begin
    if LargeImages <> ExplorerSource.GetLargeImages then
      LargeImages := ExplorerSource.GetLargeImages;
    if SmallImages <> ExplorerSource.GetSmallImages then
      SmallImages := ExplorerSource.GetSmallImages;
    if StateImages <> ExplorerSource.GetStateImages then
      StateImages := ExplorerSource.GetStateImages;
  end else begin
    if LargeImages <> nil then LargeImages := nil;
    if SmallImages <> nil then SmallImages := nil;
    if StateImages <> nil then StateImages := nil;
  end;
end;

procedure TCustomExplorerListView.WMRButtonDown(var Msg: TWMRButtonDown);
var
  Item: TListItem;
  Menu: TPopupMenu;
  P: TPoint;
begin
  Item := GetItemAt(Msg.XPos, Msg.YPos);
  if Assigned(Item) then
  begin
    SelectItem(Item);
    Menu := (Item as TExplorerListItem).ExplorerNodes.PopupMenu;
    if Assigned(Menu) then
    begin
      P := ClientToScreen(Point(Msg.XPos, Msg.YPos));
      Menu.Popup(P.X, P.Y);
    end;
  end;
  inherited;
end;

{$IFDEF _D3_}

type
{ TExplorerListBoxLink }
  TExplorerListBoxLink = class(TExplorerLink)
  private
    FExpandingNodes: TExplorerNodes;
    FListBox: TCustomExplorerListBox;
  public
    procedure ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes); override;
  end;

procedure TExplorerListBoxLink.ExplorerEvent(ExplorerNodes: TExplorerNodes; Event: Integer; NodeTypes: TExplorerNodeTypes);
var
  I: Integer;
begin
  case Event of
    eeActiveChange:
      begin
        if Assigned(ExplorerNodes) then
        begin
          FExpandingNodes := ExplorerNodes;
          try
            ExplorerSource.DoExpanding(ExplorerNodes);
            FListBox.NotifyChangeChildren(ExplorerNodes);
          finally
            FExpandingNodes := nil;
          end;
        end else
          FListBox.NotifyChange(nil);
      end;
    eeNodesChange:
      if AcceptsNodes(FListBox, ExplorerNodes) then
        FListBox.NotifyChange(ExplorerNodes);
    eeNodesChangeChildren:
      if (FExpandingNodes <> ExplorerNodes) and (NodeTypes * Self.NodeTypes <> []) then
        FListBox.NotifyChangeChildren(ExplorerNodes);
    eeDisableControls:
      FListBox.Items.BeginUpdate;
    eeEnableControls:
      FListBox.Items.EndUpdate;
    eeSetSelected:
      if (ExplorerNodes.Parent = ExplorerSource.ExplorerRoot) and FListBox.HandleAllocated then
      begin
        I := FListBox.FindItem(ExplorerNodes);
        if I >= 0 then FListBox.ItemIndex := I;
      end;
  end;
end;

type
{ TExplorerListBoxReference }
  TExplorerListBoxReference = class
  private
    FDeleting: Boolean;
    FListBox: TCustomExplorerListBox;
    FExplorerNodes: TExplorerNodes;
    procedure SetExplorerNodes(Value: TExplorerNodes);
  public
    constructor Create(AListBox: TCustomExplorerListBox; AExplorerNodes: TExplorerNodes);
    destructor Destroy; override;
    property ExplorerNodes: TExplorerNodes read FExplorerNodes;
  end;

constructor TExplorerListBoxReference.Create(AListBox: TCustomExplorerListBox; AExplorerNodes: TExplorerNodes);
begin
  FListBox := AListBox;
  SetExplorerNodes(AExplorerNodes);
  ListAdd(FListBox.FRefs, Self);
end;

destructor TExplorerListBoxReference.Destroy;
begin
  ListRemove(FListBox.FRefs, Self);
  SetExplorerNodes(nil);
  inherited;
end;

procedure TExplorerListBoxReference.SetExplorerNodes(Value: TExplorerNodes);
var
  I: Integer;
begin
  if (FExplorerNodes <> Value) then
  begin
    if Assigned(FExplorerNodes) then
    begin
      FListBox.FExplorerLink.RemoveReference(FExplorerNodes);
      if not FDeleting and FListBox.HandleAllocated then
      begin
        I := FListBox.FindItem(FExplorerNodes);
        if (I >= 0) then FListBox.Items.Delete(I);
      end;
    end;
    FExplorerNodes := Value;
    if Assigned(FExplorerNodes) then FListBox.FExplorerLink.InsertReference(FExplorerNodes, Self);
  end;
end;

{ TCustomExplorerListBox }
constructor TCustomExplorerListBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csDisplayDragImage];
  FDragImage := {$IFDEF _D4_} TDragImageList {$ELSE} TImageList {$ENDIF}.Create(nil);
  FExplorerLink := TExplorerListBoxLink.Create(False);
  TExplorerListBoxLink(FExplorerLink).FListBox := Self;
  FShortCuts := TClipboardShortCuts.Create;
end;

destructor TCustomExplorerListBox.Destroy;
begin
  SetExplorerSource(nil);
  ListDestroyAll(FRefs);
  FExplorerLink.Free;
  FDragImage.Free;
  FShortCuts.Free;
  inherited;
end;

procedure TCustomExplorerListBox.CreateWnd;
begin
  inherited;
  if Assigned(ExplorerSource) then FExplorerLink.ExplorerEvent(ExplorerSource.ExplorerRoot, eeActiveChange, []);
end;

procedure TCustomExplorerListBox.DblClick;
var
  Nodes: TExplorerNodes;
begin
  inherited;
  Nodes := SelectedExplorerNodes;
  if Assigned(Nodes) then ExplorerSource.DoDblClick(Nodes);
end;

procedure TCustomExplorerListBox.DeleteString(Index: Integer);
var
  I: Integer;
  Ref: TExplorerListBoxReference;
begin
  for I := 0 to ListCount(FRefs) - 1 do
  begin
    Ref := FRefs[I];
    if Ref.ExplorerNodes = ExplorerNodes[Index] then
    begin
      Ref.FDeleting := True;
      Ref.Free;
      Break;
    end;
  end;
  inherited;
end;

procedure TCustomExplorerListBox.DestroyWnd;
begin
  if Assigned(ExplorerSource) then FExplorerLink.ExplorerEvent(nil, eeActiveChange, []);
  ListDestroyAll(FRefs);
  inherited;
end;

procedure TCustomExplorerListBox.DoStartDrag(var DragObject: TDragObject);
var
  I, W, H: Integer;
  Bmp: TBitmap;
  Nodes: TExplorerNodes;
begin
  inherited;
  if not Assigned(DragObject) then
  begin
    DragObject := TExplorerDragObject.Create(Self);
    try
      if MultiSelect and (SelCount > 0) then
      begin
        for I := 0 to Items.Count - 1 do
        begin
          if Selected[I] then
          begin
            Nodes := ExplorerNodes[I];
            if Nodes.CanDrag then TExplorerDragObject(DragObject).Items.AddItem(Nodes);
          end;
        end;
      end else begin
        Nodes := SelectedExplorerNodes;
        if Assigned(Nodes) and Nodes.CanDrag then
          TExplorerDragObject(DragObject).Items.AddItem(Nodes);
      end;
      if TExplorerDragObject(DragObject).Items.Count = 0 then
      begin
        DragObject.Free;
        DragObject := nil;
      end else begin
        with TExplorerDragObject(DragObject) do
        begin
          Bmp := TBitmap.Create;
          try
            for I := 0 to Items.Count - 1 do
            begin
              Nodes := Items[I];
              W := Bmp.Canvas.TextWidth(Nodes.Text);
              H := Bmp.Canvas.TextHeight(Nodes.Text);
              if Bmp.Width < W then Bmp.Width := W;
              Bmp.Height := Bmp.Height + H;
              Bmp.Canvas.TextOut(0, Bmp.Height - H, Nodes.Text);
            end;
            FDragImage.Width := Bmp.Width;
            FDragImage.Height := Bmp.Height;
            FDragImage.Clear;
            FDragImage.AddMasked(Bmp, clWhite);
            FDragImage.SetDragImage(0, Bmp.Width div 2, Bmp.Height div 2);
          finally
            Bmp.Free;
          end;
        end;
    end;
    except
      DragObject.Free;
      DragObject := nil;
      raise;
    end;
  end;
end;

procedure TCustomExplorerListBox.DragDrop(Source: TObject; X, Y: Integer);
var
  I: Integer;
  Dest: TExplorerNodes;
begin
  if Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    I := ItemAtPos(Point(X, Y), True);
    if I >= 0 then
      Dest := ExplorerNodes[I] else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      ExplorerSource.DoDragDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
  inherited;
end;

procedure TCustomExplorerListBox.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
  var Accept: Boolean);
var
  I: Integer;
  Dest: TExplorerNodes;
begin
  inherited;
  if not Accept and Assigned(ExplorerSource) and (Source is TExplorerDragObject) then
  begin
    I := ItemAtPos(Point(X, Y), True);
    if I >= 0 then
      Dest := ExplorerNodes[I] else
      Dest := ExplorerSource.ExplorerRoot;
    if Assigned(Dest) then
      Accept := ExplorerSource.CanDrop(Dest, (Source as TExplorerDragObject).Items);
  end;
end;

function TCustomExplorerListBox.FindItem(ExplorerNodes: TExplorerNodes): Integer;
begin
  for Result := 0 to Items.Count - 1 do
    if GetExplorerNodes(Result) = ExplorerNodes then Exit;
  Result := -1;
end;

{$IFDEF _D4_}
function TCustomExplorerListBox.GetDragImages: TDragImageList;
{$ELSE}
function TCustomExplorerListBox.GetDragImages: TCustomImageList;
{$ENDIF}
begin
  if FDragImage.Count > 0 then Result := FDragImage else Result := nil;
end;

function TCustomExplorerListBox.GetExplorerNodes(Index: Integer): TExplorerNodes;
begin
  Result := TExplorerNodes(inherited GetItemData(Index));
end;

function TCustomExplorerListBox.GetExplorerSource: TExplorerSource;
begin
  Result := FExplorerLink.ExplorerSource;
end;

function TCustomExplorerListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := Integer(ExplorerNodes[Index].Data);
end;

function TCustomExplorerListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: string;
begin
  S := Items[Index] + 'x';
  if TabWidth > 0 then begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S),
      1, ATabWidth));
  end
  else Result := Canvas.TextWidth(S);
end;

function TCustomExplorerListBox.GetNodeTypes: TExplorerNodeTypes;
begin
  Result := FExplorerLink.NodeTypes;
end;

function TCustomExplorerListBox.GetSelectedExplorerNodes: TExplorerNodes;
var
  I: Integer;
begin
  I := ItemIndex;
  if (I >= 0) and (Items.Count > 0) then Result := ExplorerNodes[I] else Result := nil;
end;

function TCustomExplorerListBox.GetOnAcceptNode: TExplorerAcceptNodeEvent;
begin
  Result := FExplorerLink.OnAcceptNode;
end;

procedure TCustomExplorerListBox.InternalCreateItem(AExplorerNodes: TExplorerNodes);
var
  I: Integer;
begin
  I := FindItem(AExplorerNodes);
  if I < 0 then
  begin
    I := Items.Add(AExplorerNodes.Text);
    TExplorerListBoxReference.Create(Self, AExplorerNodes);
  end else
    Items[I] := AExplorerNodes.Text;
  inherited SetItemData(I, Integer(AExplorerNodes));
end;

procedure TCustomExplorerListBox.InternalNotifyChange(AExplorerNodes: TExplorerNodes);
begin
  if not Assigned(AExplorerNodes) then
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
    finally
      Items.EndUpdate;
    end;
  end else if (AExplorerNodes.Parent = ExplorerSource.ExplorerRoot) and
    FExplorerLink.AcceptsNodes(Self, AExplorerNodes) then
      InternalCreateItem(AExplorerNodes);
end;

procedure TCustomExplorerListBox.InternalNotifyChangeChildren(AExplorerNodes: TExplorerNodes);
var
  I, J, Count: Integer;
  Nodes: TExplorerNodes;
  ExplorerRoot: TExplorerNodes;
begin
  ExplorerRoot := ExplorerSource.ExplorerRoot;
  if (AExplorerNodes <> ExplorerRoot) then Exit;
  Items.BeginUpdate;
  try
    FChildrenChanging := True;
    try
      SaveSelection;
      try
        I := 0; Count := Items.Count;
        while I < Count do
        begin
          Nodes := ExplorerNodes[I];
          if Assigned(Nodes) and Assigned(Nodes.Parent) then
            J := FExplorerLink.AcceptIndex(Self, Nodes) else
            J := -1;
          if (Nodes.Parent <> ExplorerRoot) or (J <> I) then
          begin
            if (J < 0) and (Nodes = FSaveFocused) then
            begin
              if (I < Count - 1) then
                FSaveFocused := ExplorerNodes[I + 1]
              else if (I > 0) then
                FSaveFocused := ExplorerNodes[I - 1]
              else
                FSaveFocused := nil;
            end;
            Items.Delete(I);
            Dec(Count);
          end else
            Inc(I);
        end;

        ExplorerSource.DoExpanding(ExplorerRoot);
        for I := 0 to ExplorerRoot.Count - 1 do
          if FExplorerLink.AcceptsNodes(Self, ExplorerRoot[I]) then
            InternalCreateItem(ExplorerRoot[I]);
      finally
        RestoreSelection;
      end;
    finally
      FChildrenChanging := False;
    end;
  finally
    Items.EndUpdate;
  end;
end;

procedure TCustomExplorerListBox.KeyDown(var Key: Word; ShiftState: TShiftState);
var
  I, Count: Integer;
  Nodes: TExplorerNodes;
  List: TExplorerNodesList;
begin
  if not (csDesigning in ComponentState)
    and Assigned(ExplorerSource) and Assigned(ExplorerSource.ExplorerRoot) then
  begin
    List := TExplorerNodesList.Create(False);
    try
      if MultiSelect then
      begin
        for I := 0 to Items.Count - 1 do
          if Selected[I] then List.AddItem(ExplorerNodes[I])
      end else begin
        Nodes := SelectedExplorerNodes;
        if Assigned(Nodes) then List.AddItem(Nodes);
      end;
      Nodes := ExplorerSource.ExplorerRoot;
      with FShortCuts do
        if IsAction(Key, ShiftState, caCopy) then
        begin
          if ExplorerSource.CanCopy(List) then
            ExplorerClipboard.Copy(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caCut) then
        begin
          if ExplorerSource.CanCut(List) then
            ExplorerClipboard.Cut(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caDelete) then
        begin
          if ExplorerSource.CanDelete(List) then
            ExplorerSource.DoDelete(List);
          FSkipKeyPress := True;
        end else if IsAction(Key, ShiftState, caPaste) then
        begin
          if Assigned(Nodes) and ExplorerSource.CanPaste(Nodes) then
            ExplorerClipboard.Paste(Nodes);
          FSkipKeyPress := True;
        end else if MultiSelect and IsAction(Key, ShiftState, caSelectAll) then
        begin
          Items.BeginUpdate;
          try
            Count := Items.Count - 1;
            for I := 0 to Count do Selected[I] := True;
          finally
            Items.EndUpdate;
          end;
          FSkipKeyPress := True;
        end else begin
          inherited;
          Exit;
        end;
      Key := 0;
    finally
      List.Free;
    end;
  end;
  inherited;
end;

procedure TCustomExplorerListBox.KeyPress(var Key: Char);
begin
  if not FSkipKeyPress then inherited else Key := #0;
end;

procedure TCustomExplorerListBox.KeyUp(var Key: Word; ShiftState: TShiftState);
begin
  with FShortCuts do
    if IsAction(Key, ShiftState, caCopy) or IsAction(Key, ShiftState, caCut) or
       IsAction(Key, ShiftState, caDelete) or  IsAction(Key, ShiftState, caPaste) or
       IsAction(Key, ShiftState, caSelectAll) then
    FSkipKeyPress := False;
  inherited;
end;

procedure TCustomExplorerListBox.Loaded;
begin
  inherited;
  SetExplorerSource(FStreamedExplorerSource);
end;

procedure TCustomExplorerListBox.Notification(AComponent: TComponent; Operation: TOperation);
var
  I: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    if (AComponent = ExplorerSource) then
      SetExplorerSource(nil)
    else if Assigned(FSelection) then
    begin
      I := ListIndexOf(FSelection, AComponent);
      if I >= 0 then ListDelete(FSelection, I);
    end else if (AComponent = FSaveFocused) then
      FSaveFocused := nil;
  end;
end;

procedure TCustomExplorerListBox.NotifyChange(AExplorerNodes: TExplorerNodes);
begin
  if HandleAllocated then InternalNotifyChange(AExplorerNodes);
end;

procedure TCustomExplorerListBox.NotifyChangeChildren(AExplorerNodes: TExplorerNodes);
begin
  if not FChildrenChanging and HandleAllocated then InternalNotifyChangeChildren(AExplorerNodes);
end;

procedure TCustomExplorerListBox.ResetContent;
begin
  ListDestroyAll(FRefs);
  inherited;
end;

procedure TCustomExplorerListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TCustomExplorerListBox.RestoreSelection;
var
  I, Count: Integer;
  Nodes: TExplorerNodes;
begin
  try
    if Assigned(FSelection) then
    begin
      Count := Items.Count - 1;
      for I := 0 to Count do
      begin
        Nodes := ExplorerNodes[I];
        if ListIndexOf(FSelection, Nodes) >= 0 then Selected[I] := True;
      end;
    end;
    if not MultiSelect then SelectedExplorerNodes := FSaveFocused;
  finally
    ListDestroy(FSelection);
  end;
end;

procedure TCustomExplorerListBox.SaveSelection;
var
  I: Integer;
  Nodes: TExplorerNodes;
begin
  ListDestroy(FSelection);
  try
    FSaveFocused := nil;
    if MultiSelect then
    begin
      for I := 0 to Items.Count - 1 do
      begin
        if Selected[I] then
        begin
          Nodes := ExplorerNodes[I];
          ListAdd(FSelection, Nodes);
          FreeNotification(Nodes);
        end;
      end;
    end;
    FSaveFocused := SelectedExplorerNodes;
  except
    ListDestroy(FSelection);
    raise;
  end;
end;

procedure TCustomExplorerListBox.SetExplorerSource(Value: TExplorerSource);
begin
  if (csLoading in ComponentState) then
    FStreamedExplorerSource := Value
  else if ExplorerSource <> Value then
  begin
    FExplorerLink.ExplorerSource := Value;
    if Assigned(Value) then FreeNotification(Value);
  end;
end;


procedure TCustomExplorerListBox.SetItemData(Index: Integer; AData: LongInt);
var
  Nodes: TExplorerNodes;
begin
  Nodes := ExplorerNodes[Index];
  if Assigned(Nodes) then Nodes.Data := Pointer(AData);
end;

procedure TCustomExplorerListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

procedure TCustomExplorerListBox.SetNodeTypes(Value: TExplorerNodeTypes);
begin
  FExplorerLink.NodeTypes := Value;
end;

procedure TCustomExplorerListBox.SetSelectedExplorerNodes(Value: TExplorerNodes);
var
  I: Integer;
begin
  I := FindItem(Value);
  if I >= 0 then ItemIndex := I;
end;

procedure TCustomExplorerListBox.SetShortCuts(Value: TClipboardShortCuts);
begin
  FShortCuts.Assign(Value);
end;

procedure TCustomExplorerListBox.SetOnAcceptNode(Value: TExplorerAcceptNodeEvent);
begin
  FExplorerLink.OnAcceptNode := Value;
end;

procedure TCustomExplorerListBox.WndProc(var Message: TMessage);
var
  I: Integer;
  Menu: TPopupMenu;
  P: TPoint;
begin
  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        inherited WndProc(Message);
        FMaxWidth := Max(FMaxWidth, GetItemWidth(Message.Result));
        SetHorizontalExtent;
      end;
    LB_DELETESTRING:
      begin
        if GetItemWidth(Message.wParam) >= FMaxWidth then begin
          Perform(WM_HSCROLL, SB_TOP, 0);
          inherited WndProc(Message);
          ResetHorizontalExtent;
        end
        else inherited WndProc(Message);
      end;
    LB_RESETCONTENT:
      begin
        FMaxWidth := 0;
        SetHorizontalExtent;
        Perform(WM_HSCROLL, SB_TOP, 0);
        inherited WndProc(Message);
      end;
    WM_RBUTTONDOWN:
      begin
        P := Point(Lo(Message.lParam), Hi(Message.lParam));
        I := ItemAtPos(P, True);
        if I >= 0 then
        begin
          ItemIndex := I;
          Menu := ExplorerNodes[I].PopupMenu;
          if Assigned(Menu) then
          begin
            P := ClientToScreen(P);
            Menu.Popup(P.X, P.Y);
          end;
        end;
        inherited;
      end;
    WM_SETFONT:
      begin
        inherited WndProc(Message);
        Canvas.Font.Assign(Self.Font);
        ResetHorizontalExtent;
        Exit;
      end;
    else inherited WndProc(Message);
  end;
end;
{$ENDIF}

{ TComboExplorerTreeView }
type
  TComboExplorerTreeView = class(TExplorerTreeView)
  private
    FCombo: TCustomExplorerTreeCombo;
  protected
    procedure Change(Node: TTreeNode); override;
    function CreateNode: TTreeNode; override;
    procedure CreateWnd; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  end;

procedure TComboExplorerTreeView.Change(Node: TTreeNode);
begin
  inherited;
  FCombo.Invalidate;
end;

function TComboExplorerTreeView.CreateNode: TTreeNode;
begin
  Result := inherited CreateNode;
  if not Assigned(Selected) then Selected := Result;
end;

procedure TComboExplorerTreeView.CreateWnd;
begin
  inherited;
  if not Assigned(Selected) then Selected := Items.GetFirstNode;
end;

procedure TComboExplorerTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  R: TRect;
  Node: TTreeNode;
begin
  inherited;
  if (Button = mbLeft) then
  begin
    Node := GetNodeAt(X, Y);
    if Assigned(Node) then
    begin
      R := Node.DisplayRect(True);
      if PtInRect(R, Point(X, Y)) then
        FCombo.CloseUp(True);
    end;
  end;
end;

{ TCustomExplorerTreeCombo }
constructor TCustomExplorerTreeCombo.Create(AOwner: TComponent);
begin
  inherited;
  Caret := False;
  ReadOnly := True;
  TreeView.BorderStyle := bsNone;
end;

destructor TCustomExplorerTreeCombo.Destroy;
begin
  FCanvas.Free;
  inherited;
end;

procedure TCustomExplorerTreeCombo.CreatePopupControl(var Control: TWinControl);
begin
  Control := TComboExplorerTreeView.Create(Self);
  TComboExplorerTreeView(Control).FCombo := Self;
end;

function TCustomExplorerTreeCombo.GetTreeView: TExplorerTreeView;
begin
  Result := TExplorerTreeView(PopupControl);
end;

function TCustomExplorerTreeCombo.GetExploreRoot: Boolean;
begin
  Result := TreeView.ExploreRoot;
end;

function TCustomExplorerTreeCombo.GetExplorerSource: TExplorerSource;
begin
  Result := TreeView.ExplorerSource;
end;

function TCustomExplorerTreeCombo.GetNodeTypes: TExplorerNodeTypes;
begin
  Result := TreeView.NodeTypes;
end;

procedure TCustomExplorerTreeCombo.Loaded;
begin
  inherited;
  SetExplorerSource(FStreamedExplorerSource);
end;

procedure TCustomExplorerTreeCombo.SetExploreRoot(Value: Boolean);
begin
  TreeView.ExploreRoot := Value;
end;

procedure TCustomExplorerTreeCombo.SetExplorerSource(Value: TExplorerSource);
begin
  if (csLoading in ComponentState) then
    FStreamedExplorerSource := Value
  else
    TreeView.ExplorerSource := Value;
end;

procedure TCustomExplorerTreeCombo.SetNodeTypes(Value: TExplorerNodeTypes);
begin
  TreeView.NodeTypes := Value;
end;

procedure TCustomExplorerTreeCombo.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETFOCUS, WM_KILLFOCUS:
      begin
        inherited;
        Invalidate;
      end;
  else
    inherited;
  end;
end;

procedure TCustomExplorerTreeCombo.WMPaint(var Message: TWMPaint);
var
  Margins: TPoint;
  R, ImageRect: TRect;
  DC: HDC;
  PS: TPaintStruct;
  Node: TTreeNode;
  S: string;
begin
  if FCanvas = nil then
  begin
    FCanvas := TControlCanvas.Create;
    TControlCanvas(FCanvas).Control := Self;
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

      ImageRect.Right := 0;

      Node := TreeView.Selected;

      if Assigned(Node) then
        S := Node.Text else S := DisplayEmpty;

      if Assigned(TreeView.Images) and Assigned(Node) then
      begin
        ImageRect := R;
        ImageRect.Left := ImageRect.Left + 2;
        ImageRect.Right := ImageRect.Left + TreeView.Images.Width + 2;
        R.Left := ImageRect.Right;
        ImageList_DrawEx(TreeView.Images.Handle, Node.SelectedIndex, FCanvas.Handle,
          ImageRect.Left, ImageRect.Top, 0, 0, CLR_NONE, CLR_NONE, ILD_NORMAL);
      end;

      Margins := GetTextMargins;

      if Focused then
      begin
        Font.Color := clHighlightText;
        Brush.Color := clHighlight;
      end else
        Brush.Color := Color;
      InflateRect(R, -1, -1);
      TextRect(R, ImageRect.Right + Margins.X, Margins.Y, S);
    end;
  finally
    FCanvas.Handle := 0;
    if Message.DC = 0 then EndPaint(Handle, PS);
  end;
end;

{ TreeView properties }
function TCustomExplorerTreeCombo.GetTVShowButtons: Boolean;
begin
  Result := TreeView.ShowButtons;
end;

procedure TCustomExplorerTreeCombo.SetTVShowButtons(Value: Boolean);
begin
  TreeView.ShowButtons := Value;
end;

function TCustomExplorerTreeCombo.GetTVShowLines: Boolean;
begin
  Result := TreeView.ShowLines;
end;

procedure TCustomExplorerTreeCombo.SetTVShowLines(Value: Boolean);
begin
  TreeView.ShowLines := Value;
end;

function TCustomExplorerTreeCombo.GetTVShowRoot: Boolean;
begin
  Result := TreeView.ShowRoot;
end;

procedure TCustomExplorerTreeCombo.SetTVShowRoot(Value: Boolean);
begin
  TreeView.ShowRoot := Value;
end;

function TCustomExplorerTreeCombo.GetTVReadOnly: Boolean;
begin
  Result := TreeView.ReadOnly;
end;

procedure TCustomExplorerTreeCombo.SetTVReadOnly(Value: Boolean);
begin
  TreeView.ReadOnly := Value;
end;

function TCustomExplorerTreeCombo.GetTVIndent: Integer;
begin
  Result := TreeView.Indent;
end;

procedure TCustomExplorerTreeCombo.SetTVIndent(Value: Integer);
begin
  TreeView.Indent := Value;
end;

function TCustomExplorerTreeCombo.GetTVShortCuts: TClipboardShortCuts;
begin
  Result := TreeView.ShortCuts;
end;

procedure TCustomExplorerTreeCombo.SetTVShortCuts(Value: TClipboardShortCuts);
begin
  TreeView.ShortCuts := Value;
end;
{
function TCustomExplorerTreeCombo.GetTVAutoExpand: Boolean;
begin
  Result := TreeView.AutoExpand;
end;

procedure TCustomExplorerTreeCombo.SetTVAutoExpand(Value: Boolean);
begin
  TreeView.AutoExpand := Value;
end;
}
function TCustomExplorerTreeCombo.GetTVHotTrack: Boolean;
begin
  Result := TreeView.HotTrack;
end;

procedure TCustomExplorerTreeCombo.SetTVHotTrack(Value: Boolean);
begin
  TreeView.HotTrack := Value;
end;

function TCustomExplorerTreeCombo.GetTVRowSelect: Boolean;
begin
  Result := TreeView.RowSelect;
end;

procedure TCustomExplorerTreeCombo.SetTVRowSelect(Value: Boolean);
begin
  TreeView.RowSelect := Value;
end;

function TCustomExplorerTreeCombo.GetTVToolTips: Boolean;
begin
  Result := TreeView.ToolTips;
end;

procedure TCustomExplorerTreeCombo.SetTVToolTips(Value: Boolean);
begin
  TreeView.ToolTips := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnClick: TNotifyEvent;
begin
  Result := TreeView.OnClick;
end;

procedure TCustomExplorerTreeCombo.SetTVOnClick(Value: TNotifyEvent);
begin
  TreeView.OnClick := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnDragDrop: TDragDropEvent;
begin
  Result := TreeView.OnDragDrop;
end;

procedure TCustomExplorerTreeCombo.SetTVOnDragDrop(Value: TDragDropEvent);
begin
  TreeView.OnDragDrop := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnDragOver: TDragOverEvent;
begin
  Result := TreeView.OnDragOver;
end;

procedure TCustomExplorerTreeCombo.SetTVOnDragOver(Value: TDragOverEvent);
begin
  TreeView.OnDragOver := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnStartDrag: TStartDragEvent;
begin
  Result := TreeView.OnStartDrag;
end;

procedure TCustomExplorerTreeCombo.SetTVOnStartDrag(Value: TStartDragEvent);
begin
  TreeView.OnStartDrag := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnEndDrag: TEndDragEvent;
begin
  Result := TreeView.OnEndDrag;
end;

procedure TCustomExplorerTreeCombo.SetTVOnEndDrag(Value: TEndDragEvent);
begin
  TreeView.OnEndDrag := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnMouseDown: TMouseEvent;
begin
  Result := TreeView.OnMouseDown;
end;

procedure TCustomExplorerTreeCombo.SetTVOnMouseDown(Value: TMouseEvent);
begin
  TreeView.OnMouseDown := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnMouseMove: TMouseMoveEvent;
begin
  Result := TreeView.OnMouseMove;
end;

procedure TCustomExplorerTreeCombo.SetTVOnMouseMove(Value: TMouseMoveEvent);
begin
  TreeView.OnMouseMove := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnMouseUp: TMouseEvent;
begin
  Result := TreeView.OnMouseUp;
end;

procedure TCustomExplorerTreeCombo.SetTVOnMouseUp(Value: TMouseEvent);
begin
  TreeView.OnMouseUp := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnDblClick: TNotifyEvent;
begin
  Result := TreeView.OnDblClick;
end;

procedure TCustomExplorerTreeCombo.SetTVOnDblClick(Value: TNotifyEvent);
begin
  TreeView.OnDblClick := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnKeyDown: TKeyEvent;
begin
  Result := TreeView.OnKeyDown;
end;

procedure TCustomExplorerTreeCombo.SetTVOnKeyDown(Value: TKeyEvent);
begin
  TreeView.OnKeyDown := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnKeyPress: TKeyPressEvent;
begin
  Result := TreeView.OnKeyPress;
end;

procedure TCustomExplorerTreeCombo.SetTVOnKeyPress(Value: TKeyPressEvent);
begin
  TreeView.OnKeyPress := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnKeyUp: TKeyEvent;
begin
  Result := TreeView.OnKeyUp;
end;

procedure TCustomExplorerTreeCombo.SetTVOnKeyUp(Value: TKeyEvent);
begin
  TreeView.OnKeyUp := Value;
end;

{ TreeView events }
function TCustomExplorerTreeCombo.GetTVOnEditing: TTVEditingEvent;
begin
  Result := TreeView.OnEditing;
end;

procedure TCustomExplorerTreeCombo.SetTVOnEditing(Value: TTVEditingEvent);
begin
  TreeView.OnEditing := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnEdited: TTVEditedEvent;
begin
  Result := TreeView.OnEdited;
end;

procedure TCustomExplorerTreeCombo.SetTVOnEdited(Value: TTVEditedEvent);
begin
  TreeView.OnEdited := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnExpanding: TTVExpandingEvent;
begin
  Result := TreeView.OnExpanding;
end;

procedure TCustomExplorerTreeCombo.SetTVOnExpanding(Value: TTVExpandingEvent);
begin
  TreeView.OnExpanding := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnExpanded: TTVExpandedEvent;
begin
  Result := TreeView.OnExpanded;
end;

procedure TCustomExplorerTreeCombo.SetTVOnExpanded(Value: TTVExpandedEvent);
begin
  TreeView.OnExpanded := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnCollapsing: TTVCollapsingEvent;
begin
  Result := TreeView.OnCollapsing;
end;

procedure TCustomExplorerTreeCombo.SetTVOnCollapsing(Value: TTVCollapsingEvent);
begin
  TreeView.OnCollapsing := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnCompare: TTVCompareEvent;
begin
  Result := TreeView.OnCompare;
end;

procedure TCustomExplorerTreeCombo.SetTVOnCompare(Value: TTVCompareEvent);
begin
  TreeView.OnCompare := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnCollapsed: TTVExpandedEvent;
begin
  Result := TreeView.OnCollapsed;
end;

procedure TCustomExplorerTreeCombo.SetTVOnCollapsed(Value: TTVExpandedEvent);
begin
  TreeView.OnCollapsed := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnChanging: TTVChangingEvent;
begin
  Result := TreeView.OnChanging;
end;

procedure TCustomExplorerTreeCombo.SetTVOnChanging(Value: TTVChangingEvent);
begin
  TreeView.OnChanging := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnChange: TTVChangedEvent;
begin
  Result := TreeView.OnChange;
end;

procedure TCustomExplorerTreeCombo.SetTVOnChange(Value: TTVChangedEvent);
begin
  TreeView.OnChange := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnDeletion: TTVExpandedEvent;
begin
  Result := TreeView.OnDeletion;
end;

procedure TCustomExplorerTreeCombo.SetTVOnDeletion(Value: TTVExpandedEvent);
begin
  TreeView.OnDeletion := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnGetImageIndex: TTVExpandedEvent;
begin
  Result := TreeView.OnGetImageIndex;
end;

procedure TCustomExplorerTreeCombo.SetTVOnGetImageIndex(Value: TTVExpandedEvent);
begin
  TreeView.OnGetImageIndex := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnGetSelectedIndex: TTVExpandedEvent;
begin
  Result := TreeView.OnGetSelectedIndex;
end;

procedure TCustomExplorerTreeCombo.SetTVOnGetSelectedIndex(Value: TTVExpandedEvent);
begin
  TreeView.OnGetSelectedIndex := Value;
end;

{$IFDEF _D4_}
function TCustomExplorerTreeCombo.GetTVOnCustomDraw: TTVCustomDrawEvent;
begin
  Result := TreeView.OnCustomDraw;
end;

procedure TCustomExplorerTreeCombo.SetTVOnCustomDraw(Value: TTVCustomDrawEvent);
begin
  TreeView.OnCustomDraw := Value;
end;

function TCustomExplorerTreeCombo.GetTVOnCustomDrawItem: TTVCustomDrawItemEvent;
begin
  Result := TreeView.OnCustomDrawItem;
end;

procedure TCustomExplorerTreeCombo.SetTVOnCustomDrawItem(Value: TTVCustomDrawItemEvent);
begin
  TreeView.OnCustomDrawItem := Value;
end;
{$ENDIF}

end.


