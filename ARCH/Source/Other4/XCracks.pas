{*******************************************************}
{                                                       }
{   10.05.97   						}
{                                                       }
{   Borland Delphi cracks                               }
{                                                       }
{*******************************************************}

Unit XCracks;

Interface

Uses Windows, Classes, Controls, BDE, DB, DBTables, Grids, Forms, Graphics,
     StdCtrls, DBCtrls, DBGrids, Menus;

Type

{ From Classes}

  TComponentBorland = class(TPersistent)
  public
    FOwner: TComponent;
    FName: TComponentName;
    FTag: Longint;
    FComponents: TList;
    FFreeNotifies: TList;
    FDesignInfo: Longint;
    FVCLComObject: Pointer;
    FComponentState: TComponentState;
  end;

  TComponentSelf = class(TComponent)
  public
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

{ From Forms}

  TCustomFormBorland = class(TScrollingWinControl)
  public
    FActiveControl: TWinControl;
    FFocusedControl: TWinControl;
    FBorderIcons: TBorderIcons;
    FBorderStyle: TFormBorderStyle;
    FSizeChanging: Boolean;
    FWindowState: TWindowState;
    FShowAction: TShowAction;
    FKeyPreview: Boolean;
    FActive: Boolean;
    FFormStyle: TFormStyle;
    FPosition: TPosition;
    FDefaultMonitor: TDefaultMonitor;
    FTileMode: TTileMode;
    FDropTarget: Boolean;
    FOldCreateOrder: Boolean;
    FPrintScale: TPrintScale;
    FCanvas: TControlCanvas;
    FHelpFile: string;
    FIcon: TIcon;
    FInCMParentBiDiModeChanged: Boolean;
    FMenu: TMainMenu;
    FModalResult: TModalResult;
    FDesigner: IDesigner;
    FClientHandle: HWND;
    FWindowMenu: TMenuItem;
    FPixelsPerInch: Integer;
    FObjectMenuItem: TMenuItem;
    FOleForm: IOleForm;
    FClientWidth: Integer;
    FClientHeight: Integer;
    FTextHeight: Integer;
    FDefClientProc: TFarProc;
    FClientInstance: TFarProc;
    FActiveOleControl: TWinControl;
    FSavedBorderStyle: TFormBorderStyle;
    FOnActivate: TNotifyEvent;
    FOnClose: TCloseEvent;
    FOnCloseQuery: TCloseQueryEvent;
    FOnDeactivate: TNotifyEvent;
    FOnHelp: THelpEvent;
    FOnHide: TNotifyEvent;
    FOnPaint: TNotifyEvent;
    FOnShortCut: TShortCutEvent;
    FOnShow: TNotifyEvent;
    FOnCreate: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
  end;

  TControlBorland = class(TComponent)
  public
    FParent: TWinControl;
    FWindowProc: TWndMethod;
    FLeft: Integer;
    FTop: Integer;
    FWidth: Integer;
    FHeight: Integer;
  end;

  TWinControlSelf = class(TWinControl)
  public
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure SetZOrder(TopMost: Boolean); override;
    property OnKeyDown;
    property OnExit;
    property OnClick;
  end;

{ From DB }
type
  TFieldBorland = class(TComponent)
  public
    FDataSet: TDataSet;
    FFieldName: string;
    FFields: TFields;
    FDataType: TFieldType;
    FReadOnly: Boolean;
    FFieldKind: TFieldKind;
    FAlignment: TAlignment;
    FVisible: Boolean;
    FRequired: Boolean;
    FValidating: Boolean;
    FSize: Word;
    FOffset: Word;
    FFieldNo: Integer;
    FDisplayWidth: Integer;
    FDisplayLabel: string;
    FEditMask: string;
    FValueBuffer: Pointer;
    FLookupDataSet: TDataSet;
    FKeyFields: string;
    FLookupKeyFields: string;
    FLookupResultField: string;
    FLookupCache: Boolean;
    FLookupList: TLookupList;
    FAttributeSet: string;
    FCustomConstraint: string;
    FImportedConstraint: string;
    FConstraintErrorMessage: string;
    FDefaultExpression: string;
    FOrigin: string;
    FProviderFlags: TProviderFlags;
    FParentField: TObjectField;
    FValidChars: TFieldChars;
    FOnChange: TFieldNotifyEvent;
    FOnValidate: TFieldNotifyEvent;
    FOnGetText: TFieldGetTextEvent;
    FOnSetText: TFieldSetTextEvent;
  end;

  TDataSetBorland = class(TComponent)
  public
    FFields: TFields;
    FAggFields: TFields;
    FFieldDefs: TFieldDefs;
    FFieldDefList: TFieldDefList;
    FFieldList: TFieldList;
    FDataSources: TList;
    FFirstDataLink: TDataLink;
    FBufferCount: Integer;
    FRecordCount: Integer;
    FActiveRecord: Integer;
    FCurrentRecord: Integer;
    FBuffers: TBufferList;
    FCalcBuffer: PChar;
    FBookmarkSize: Integer;
    FCalcFieldsSize: Integer;
    FDesigner: TDataSetDesigner;
    FDisableCount: Integer;
    FBlobFieldCount: Integer;
    FFilterText: string;
    FBlockReadSize: Integer;
    FConstraints: TCheckConstraints;
    FDataSetField: TDataSetField;
    FNestedDataSets: TList;
    FNestedDatasetClass: TClass;
    FReserved: Pointer;
    FFieldNoOfs: Integer;
    { Byte sized data members (for alignment) }
    FFilterOptions: TFilterOptions;
    FState: TDataSetState;
    FEnableEvent: TDataEvent;
    FDisableState: TDataSetState;
    FBOF: Boolean;
    FEOF: Boolean;
    FModified: Boolean;
    FStreamedActive: Boolean;
    FInternalCalcFields: Boolean;
    FFound: Boolean;
    FDefaultFields: Boolean;
    FAutoCalcFields: Boolean;
    FFiltered: Boolean;
    FObjectView: Boolean;
    FSparseArrays: Boolean;
    FOpenOK: Boolean;
    { Events }
    FBeforeOpen: TDataSetNotifyEvent;
    FAfterOpen: TDataSetNotifyEvent;
    FBeforeClose: TDataSetNotifyEvent;
    FAfterClose: TDataSetNotifyEvent;
    FBeforeInsert: TDataSetNotifyEvent;
    FAfterInsert: TDataSetNotifyEvent;
    FBeforeEdit: TDataSetNotifyEvent;
    FAfterEdit: TDataSetNotifyEvent;
    FBeforePost: TDataSetNotifyEvent;
    FAfterPost: TDataSetNotifyEvent;
    FBeforeCancel: TDataSetNotifyEvent;
    FAfterCancel: TDataSetNotifyEvent;
    FBeforeDelete: TDataSetNotifyEvent;
    FAfterDelete: TDataSetNotifyEvent;
    FBeforeScroll: TDataSetNotifyEvent;
    FAfterScroll: TDataSetNotifyEvent;
    FOnNewRecord: TDataSetNotifyEvent;
    FOnCalcFields: TDataSetNotifyEvent;
    FOnEditError: TDataSetErrorEvent;
    FOnPostError: TDataSetErrorEvent;
    FOnDeleteError: TDataSetErrorEvent;
    FOnFilterRecord: TFilterRecordEvent;
  end;

  TDataSourceBorland = class(TComponent)
  public
    FDataSet: TDataSet;
    FDataLinks: TList;
    FEnabled: Boolean;
    FAutoEdit: Boolean;
    FState: TDataSetState;
    FOnStateChange: TNotifyEvent;
    FOnDataChange: TDataChangeEvent;
    FOnUpdateData: TNotifyEvent;
  end;

{ From DBTables }
type
  TBDEDataSetBorland = class(TDataSet)
  public
    FHandle: HDBICur;
    FStmtHandle: HDBIStmt;
    FRecProps: RecProps;
    FLocale: TLocale;
    FExprFilter: HDBIFilter;
    FFuncFilter: HDBIFilter;
    FFilterBuffer: PChar;
    FIndexFieldMap: DBIKey;
    FExpIndex: Boolean;
    FCaseInsIndex: Boolean;
    FCachedUpdates: Boolean;
    FInUpdateCallback: Boolean;
    FCanModify: Boolean;
    FCacheBlobs: Boolean;
    FKeySize: Word;
    FUpdateCBBuf: PDELAYUPDCbDesc;
    FUpdateCallback: TBDECallback;
    FKeyBuffers: array[TKeyIndex] of PKeyBuffer;
    FKeyBuffer: PKeyBuffer;
    FRecNoStatus: TRecNoStatus;
    FIndexFieldCount: Integer;
    FConstDisableCount: Integer;
    FRecordSize: Word;
    FBookmarkOfs: Word;
    FRecInfoOfs: Word;
    FBlobCacheOfs: Word;
    FRecBufSize: Word;
    FConstraintLayer: Boolean;
    FBlockBufSize: Integer;
    FBlockBufOfs: Integer;
    FBlockBufCount: Integer;
    FBlockReadCount: Integer;
    FBlockReadBuf: PChar;
{   FProvIntf: IProvider;
    FParentDataSet: TBDEDataSet;
    FUpdateObject: TDataSetUpdateObject;
    FOnUpdateError: TUpdateErrorEvent;
    FOnUpdateRecord: TUpdateRecordEvent; }
    property BookmarkSize;
    property CalcFieldsSize;
    property BlobFieldCount;
    property Constraints;
  end;

  TDBDataSetBorland = class(TBDEDataSet)
  public
    FDBFlags: TDBFlags;
    FUpdateMode: TUpdateMode;
    FDatabase: TDatabase;
    FDatabaseName: string;
    FSessionName: string;
  end;

{Etv-Igo!}
{ From DBCtrls}
Type

  TDBComboBoxBorland = class(TCustomComboBox)
  public
    FDataLink: TFieldDataLink;
  end;

  TDataSourceLinkBorland = class(TDataLink)
  public
    FDBLookupControl: TDBLookupControl;
  end;

Type
  TListSourceLinkBorland = class(TDataLink)
  public
    FDBLookupControl: TDBLookupControl;
  end;

  TDBLookupListBoxBorland = class(TDBLookupControl)
  {private}
  public
    FRecordIndex: Integer;
    FRecordCount: Integer;
    FRowCount: Integer;
    FBorderStyle: TBorderStyle;
    FPopup: Boolean;
    FKeySelected: Boolean;
    FTracking: Boolean;
    FTimerActive: Boolean;
    FLockPosition: Boolean;
    FMousePos: Integer;
    FSelectedItem: string;
  end;

  TDBLookupControlBorland = class(TCustomControl)
  public
    FLookupSource: TDataSource;
    FDataLink: TDataSourceLink;
    FListLink: TListSourceLink;
    FDataFieldName: string;
    FKeyFieldName: string;
    FListFieldName: string;
    FListFieldIndex: Integer;
    FDataField: TField;
    FMasterField: TField;
    FKeyField: TField;
    FListField: TField;
    FListFields: TList;
    FKeyValue: Variant;
    FSearchText: string;
    FLookupMode: Boolean;
    FListActive: Boolean;
    FHasFocus: Boolean;
  end;

  TDBLookupComboBoxBorland = class(TDBLookupControl)
  public
    FDataList: TPopupDataList;
    FButtonWidth: Integer;
    FText: string;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible: Boolean;
    FPressed: Boolean;
    FTracking: Boolean;
    FAlignment: TAlignment;
    FLookupMode: Boolean;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
  end;
{Etv-Igo}

{ From Grids}
Type
  TCustomGridBorland = class(TCustomControl)
  public
    FAnchor: TGridCoord;
    FBorderStyle: TBorderStyle;
    FCanEditModify: Boolean;
    FColCount: Longint;
    FColWidths: Pointer;
    FTabStops: Pointer;
    FCurrent: TGridCoord;
    FDefaultColWidth: Integer;
    FDefaultRowHeight: Integer;
    FFixedCols: Integer;
    FFixedRows: Integer;
    FFixedColor: TColor;
    FGridLineWidth: Integer;
    FOptions: TGridOptions;
    FRowCount: Longint;
    FRowHeights: Pointer;
    FScrollBars: TScrollStyle;
    FTopLeft: TGridCoord;
    FSizingIndex: Longint;
    FSizingPos, FSizingOfs: Integer;
    FMoveIndex, FMovePos: Longint;
    FHitTest: TPoint;
    FInplaceEdit: TInplaceEdit;
    FInplaceCol, FInplaceRow: Longint;
    FColOffset: Integer;
    FDefaultDrawing: Boolean;
    FEditorMode: Boolean;
  end;

{ From DBGrids}
type
  TGridDataLinkBorland = class(TDataLink)
  public
    FGrid: TCustomDBGrid;
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;
  end;

  TCustomDBGridBorland = class(TCustomGrid)
  public
    FIndicators: TImageList;
    FTitleFont: TFont;
    FReadOnly: Boolean;
    FOriginalImeName: TImeName;
    FOriginalImeMode: TImeMode;
    FUserChange: Boolean;
    FIsESCKey: Boolean;
    FLayoutFromDataset: Boolean;
    FOptions: TDBGridOptions;
    FTitleOffset, FIndicatorOffset: Byte;
    FUpdateLock: Byte;
    FLayoutLock: Byte;
    FInColExit: Boolean;
    FDefaultDrawing: Boolean;
    FSelfChangingTitleFont: Boolean;
    FSelecting: Boolean;
    FSelRow: Integer;
    FDataLink: TGridDataLink;
    FOnColEnter: TNotifyEvent;
    FOnColExit: TNotifyEvent;
    FOnDrawDataCell: TDrawDataCellEvent;
    FOnDrawColumnCell: TDrawColumnCellEvent;
    FEditText: string;
    FColumns: TDBGridColumns;
    FVisibleColumns: TList;
    FBookmarks: TBookmarkList;
    FSelectionAnchor: TBookmarkStr;
    FOnEditButtonClick: TNotifyEvent;
    FOnColumnMoved: TMovedEvent;
    FOnCellClick: TDBGridClickEvent;
    FOnTitleClick:TDBGridClickEvent;
    FDragCol: TColumn;
  end;

{end cracks from Borland units}

Implementation

{ TComponentSelf }

Procedure TComponentSelf.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited;
end;

{ TWinControlSelf }

Procedure TWinControlSelf.KeyDown(var Key: Word; Shift: TShiftState);
begin
  Inherited;
end;

Procedure TWinControlSelf.SetZOrder(TopMost: Boolean);
begin
  Inherited;
end;

end.
