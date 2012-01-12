unit EtvBor;

interface
uses Windows,classes,graphics,controls,grids,stdctrls,forms,comctrls,Printers,
db,dbctrls,dbgrids,DBTables,DBCommon;

{$I Etv.inc}

type

  TControlBorland = class(TComponent)
  {private}
  public
    FParent: TWinControl;
    FWindowProc: TWndMethod;
    FLeft: Integer;
    FTop: Integer;
    FWidth: Integer;
    FHeight: Integer;
  end;

  TDBComboBoxBorland = class(TCustomComboBox)
  {private}
  public
    FDataLink: TFieldDataLink;
  end;

  TDataSourceLinkBorland = class(TDataLink)
  public
    FDBLookupControl: TDBLookupControl;
  end;

  TListSourceLinkBorland = class(TDataLink)
  {private}
  public
    FDBLookupControl: TDBLookupControl;
  end;

  TDBLookupControlBorland = class(TCustomControl)
  {private}
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
    {$IFNDEF Delphi4}
    FFocused: Boolean;
    {$ENDIF}
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

  TDBLookupComboBoxBorland = class(TDBLookupControl)
  {private}
  public
    FDataList: TPopupDataList;
    FButtonWidth: Integer;
    FText: string;
    FDropDownRows: Integer;
    FDropDownWidth: Integer;
    FDropDownAlign: TDropDownAlign;
    FListVisible: Boolean;
    FPressed: Boolean;
  end;

  TGridDataLinkBorland = class(TDataLink)
  public
    FGrid: TCustomDBGrid;
  end;

  TCustomDBGridBorland = class(TCustomGrid)
   {private}
   public
    FIndicators: TImageList;
    FTitleFont: TFont;
    FReadOnly: Boolean;
    FOriginalImeName: TImeName;
    FOriginalImeMode: TImeMode;
    FUserChange: Boolean;
    {$IFDEF Delphi4}
    FIsESCKey: Boolean;
    {$ENDIF}
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
  end;

  TFieldBorland = class(TComponent)
  {private}
  public
    {$IFDEF Delphi5}
    FAutoGenerateValue: TAutoRefreshFlag;
    {$ENDIF}
    FDataSet: TDataSet;
    FFieldName: string;
    {$IFDEF Delphi4}
    FFields: TFields;
    {$ENDIF}
    FDataType: TFieldType;
    FReadOnly: Boolean;
    FFieldKind: TFieldKind;
    FAlignment: TAlignment;
    FVisible: Boolean;
    FRequired: Boolean;
    FValidating: Boolean;
    FSize: {$IFDEF Delphi5} Integer; {$ELSE} Word; {$ENDIF}
    FOffset: {$IFDEF Delphi5} Integer; {$ELSE} Word; {$ENDIF}
    FFieldNo: Integer;
    FDisplayWidth: Integer;
    FDisplayLabel: string;
    FEditMask: string;
    FValueBuffer: Pointer;
    FLookupDataSet: TDataSet;
    FKeyFields: string;
    FLookupKeyFields: string;
    FLookupResultField: string;
{ Lev добавил 20.06.2006 }
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
    procedure CalcLookupValue;
  end;

  {$IFNDEF Delphi4}
  TCustomFormBorland = class(TScrollingWinControl)
  public
    FActiveControl: TWinControl;
    FFocusedControl: TWinControl;
    FBorderIcons: TBorderIcons;
    FBorderStyle: TFormBorderStyle;
    FWindowState: TWindowState;
    FShowAction: TShowAction;
    FKeyPreview: Boolean;
    FActive: Boolean;
    FFormStyle: TFormStyle;
    FPosition: TPosition;
    FTileMode: TTileMode;
    FFormState: TFormState;
  end;
  {$ENDIF}

  TDBRichEditBorland=class(TRichEdit)
  public
    FDataLink: TFieldDataLink;
    FAutoDisplay: Boolean;
    FFocused: Boolean;
    FMemoLoaded: Boolean;
    FDataSave: string;
  end;

  TTableBorland = class(TDBDataSet)
  public
    FStoreDefs: Boolean;
    FIndexDefs: TIndexDefs;
    FMasterLink: TMasterDataLink;
  end;

  TBorlandDataSet = class(TComponent)
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
  end;

IMPLEMENTATION

  Procedure TFieldBorland.CalcLookupValue;
  begin
    if FLookupCache then
      TField(Self).Value := TField(Self).LookupList.ValueOfKey(FDataSet.FieldValues[FKeyFields])
    else if (FLookupDataSet <> nil) and FLookupDataSet.Active then
      TField(Self).Value := FLookupDataSet.Lookup(FLookupKeyFields,
        FDataSet.FieldValues[FKeyFields], FLookupResultField);
  end;
end.
