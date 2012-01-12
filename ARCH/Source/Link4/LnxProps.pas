{$I XLib.inc }
Unit LnxProps;

Interface

Uses Classes, DsgnIntf, LnTables, LnkSet, DBReg, ColnEdit;

{ TLnTableNameProperty }

type
  TLnTableNameProperty = class(TDBStringProperty)
  protected
    function GetTable: TLnTable; virtual;
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TLinkSourceEditor }

  TLinkSourceEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TLinkSetsProperty }

  TLinkSetsProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TLinkSetCompProperty }

  TLinkSetCompProperty = class(TPropertyEditor)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

{ TSessionNameProperty }

  TSessionNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;


{ TIFNLinkCollProperty }

  TIFNLinkCollProperty = class(TCollectionProperty)
  public
    procedure Edit; override;
  end;

{ TIFNLinkProperty }

  TUniqueIFNProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TIFNLinkProperty }

  TIFNLinkProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TIFNLinkLinkProperty }

  TIFNLinkLinkProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TLinkDatabaseNameProperty }

  TLinkDatabaseNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TLinkTableNameProperty }

  TLinkTableNameProperty = class(TLnTableNameProperty)
  protected
    function GetTable: TLnTable; override;
  end;

{ TUserFieldProperty }

  TUserFieldProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TLinkFiltersProperty }

  TLinkFiltersProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

Implementation

Uses Windows, Forms, DB, DBTables, LibIntf, DsDesign, DBXplor, Dialogs, Controls, SysUtils,
     Clipbrd, EtvDBFun, XEFields, UsersSet, LnkMisc, DSLnkSet;

{ TLnTableNameProperty }

Function TLnTableNameProperty.GetTable: TLnTable;
begin
  Result:= GetComponent(0) as TLnTable;
end;

Procedure TLnTableNameProperty.GetValueList(List: TStrings);
const
  Masks: array[TTableType] of string[5] = ('', '*.DB', '*.DBF', '*.TXT', '*.DBF');
  {Type TTableType = (ttDefault, ttParadox, ttDBase, ttASCII, ttFoxPro);}
var
  Table: TTable;
  S, S1: String;
  i: Integer;
  DTB: TDatabase;
begin
  Table:=GetTable;
  Table.DBSession.GetTableNames(Table.DatabaseName, Masks[Table.TableType],
    Table.TableType = ttDefault, False, List);
  DTB:=Table.DBSession.FindDatabase(Table.DatabaseName);
  if Assigned(DTB) and (DTB is TLnDatabase) and
  (TLnDatabase(DTB).PrefixName<>'') then begin
    S:=TLnDatabase(DTB).PrefixName;
    for i:=0 to List.Count-1 do
      if Pos(S,List.Strings[i])=1 then begin
        S1:=List.Strings[i];
        Delete(S1,1,Length(S));
        List.Strings[i]:=S1;
      end;
  end;
end;

{ TLinkSourceEditor }

Procedure ShowLinkSourceEditor(aLinkSource: TLinkSource; aDesigner: IFormDesigner);
var F: TLinkSourceEditorForm;
    i: Integer;
    Priz: Boolean;
begin
  Priz:=False;
  F:=nil;
  for i:=0 to Screen.FormCount-1 do
    if (Screen.Forms[i] is TLinkSourceEditorForm) and
    (TLinkSourceEditorForm(Screen.Forms[i]).LinkSourceComp=aLinkSource) then begin
      F:=TLinkSourceEditorForm(Screen.Forms[i]);
      F.Show;
      Priz:=True;
      Break;
    end;

  if not Priz then begin
    F:=TLinkSourceEditorForm.Create(Application);
    try
      F.Designer:= aDesigner;
      F.LinkSourceComp:= aLinkSource;
      F.Show;
    except
      F.Free;
    raise;
    end;
  end;
end;

Procedure TLinkSourceEditor.ExecuteVerb(Index: Integer);

Procedure LShowDataSet(ADataSet: TDataSet);
var F: TDatasetEditor;
    i: Integer;
    Priz: Boolean;
begin
{
  ShowDatasetDesigner(Designer, ADataSet);
  }
  Priz:=False;
  F:=Nil;
  for i:=0 to Screen.FormCount-1 do
    if (Screen.Forms[i] is TDataSetEditor) and
    (TDataSetEditor(Screen.Forms[i]).DataSet=ADataSet) then begin
      F:=TDatasetEditor(Screen.Forms[i]);
      F.Show;
      Priz:=True;
      Break;
    end;

  if not Priz then begin
    F:=TDataSetEditor.Create(Application);
    try
      F.Designer:=Designer;
      F.DataSet:=ADataSet;
      F.Show;
    except
      F.Free;
    raise;
    end;
  end;
  DelphiIDE.ModalEdit(#0,F{nil});
end;

var i: Integer;
    aLink: TLinkSetItem;
begin
  case Index of
    0: if (GetKeyState(VK_CONTROL) and 128)<>0 then begin
         TLinkSource(Component).Active:=not TLinkSource(Component).Active;
         Designer.Modified;
       end else ShowLinkSourceEditor(TLinkSource(Component), Designer);
    else begin
      i:= Index-1;
      if i<TLinkSource(Component).LinkSets.Count then begin
        aLink:= TLinkSource(Component).LinkSets[i];
        if Assigned(aLink.Dataset) then begin
          if (GetKeyState(VK_CONTROL) and 128)<>0 then
            aLink.Dataset.Active:= Not aLink.Dataset.Active
          else LShowDataSet(aLink.Dataset);
        end else Designer.SelectComponent(aLink);
      end else begin
        i:= i-TLinkSource(Component).LinkSets.Count;
        case i of
          1: ExploreDataSet(TLinkSource(Component).Inner);
          2: if Assigned(FieldsInfoProc) then
               Clipboard.SetTextBuf(PChar(FieldsInfoProc(TLinkSource(Component).Declar)));
          3: begin
               for i:=0 to TLinkSource(Component).LinkSets.Count-1 do begin
                 aLink:= TLinkSource(Component).LinkSets[i];
                 if Assigned(aLink.Dataset) then DataSetAutoCorrect(aLink.Dataset);
               end;
               Designer.Modified;
             end;
        end;
      end;
    end;
  end;
end;

Function TLinkSourceEditor.GetVerb(Index: Integer): string;
var i: Integer;
    aLink: TLinkSetItem;
begin
  case Index of
    0: begin
         Result := 'Link Editor '+Component.Name+' / Active=';
         if TLinkSource(Component).Active then Result := Result+'True'
         else Result := Result+'False';
       end;
    else begin
      i:= Index-1;
      if i< TLinkSource(Component).LinkSets.Count then begin
        Result:= IntToStr(i)+'.';
        aLink:= TLinkSource(Component).LinkSets[i];
        case aLink.Style of
          ldNone: Result:= Result+'/none/';
          ldDeclar: Result:= Result+'/declar/';
          ldLookup: Result:= Result+'/lookup/';
          ldProcess: Result:= Result+'/process/';
        end;
        if Assigned(aLink.Dataset) then begin
          case aLink.LinkState of
            ltTable: Result:= Result+'Table';
            ltQuery: Result:= Result+'Query';
            ltStoredProc: Result:= Result+'StoredProc';
          end;
          Result:= Result+' Fields / Active=';
          if aLink.Dataset.Active then Result:= Result+'True'
          else Result:= Result+'False';
        end else Result:= Result+'(no Dataset)';
      end else begin
        i:= i-TLinkSource(Component).LinkSets.Count;
        case i of
          0: Result := '-';
          1: Result := 'Explore';
          2: Result:='Copy list of fields to clipboard';
          3: Result := 'Auto correct';
        end;
      end;
    end;
  end;
end;

Function TLinkSourceEditor.GetVerbCount: Integer;
begin
  Result:= TLinkSource(Component).LinkSets.Count+5;
end;

{ TLinkSetsProperty }

Function TLinkSetsProperty.GetAttributes: TPropertyAttributes;
begin
  Result:= [paReadOnly, paDialog];
end;

Function TLinkSetsProperty.GetValue: string;
begin
  if TCollection(GetOrdValue).Count>0 then
    if TCollection(GetOrdValue).Count=1 then FmtStr(Result, '(%s)', ['One link'])
    else FmtStr(Result, '(%s)', ['Some links'])
  else FmtStr(Result, '(%s)', ['Not links']);
end;

Procedure TLinkSetsProperty.Edit;
begin
  ShowLinkSourceEditor(TLinkSource(GetComponent(0)), Designer);
{  ShowCollectionEditorClass(Designer,TLinkSetEditor,TComponent(GetComponent(0)),
                            TLinkSource(GetComponent(0)).LinkSets, 'LinkSets');}
end;

{ TLinkSetCompProperty }

Function TLinkSetCompProperty.GetAttributes: TPropertyAttributes;
begin
  if Pointer(GetOrdValue)<>nil then Result:=Inherited GetAttributes
  else Result:=[paReadOnly];
end;

Function TLinkSetCompProperty.GetValue: string;
begin
  if Pointer(GetOrdValue)<>nil then Result:=TComponent(GetOrdValue).Name
  else FmtStr(Result, '(%s)', ['Not Active']);
end;

Procedure TLinkSetCompProperty.SetValue(const Value: string);
var CurValue: string;
begin
  CurValue:= GetValue;
  if (CurValue <> Value) then TComponent(GetOrdValue).Name:=Value;
end;

{ TSessionNameProperty }

procedure TSessionNameProperty.GetValueList(List: TStrings);
begin
  Sessions.GetSessionNames(List);
end;

{ TIFNLinkCollProperty }

type TSelfPersistent = class(TPersistent)
     end;

Procedure TIFNLinkCollProperty.Edit;
var AOwner: TPersistent;
begin
  AOwner:= TSelfPersistent(GetOrdValue).GetOwner;
  AOwner:= TSelfPersistent(AOwner).GetOwner;
  ShowCollectionEditorClass(Designer,TCollectionEditor,
                            TComponent(AOwner),
                            TIFNLink(GetOrdValue), 'IFNLink');
end;

{ TUniqueIFNProperty }

Procedure TUniqueIFNProperty.GetValueList(List: TStrings);
var AMode: TIFNMode;
begin
  TLinkSource(GetComponent(0)).LinkMaster.FillIndexListCurrent;
  AMode:= TLinkSource(GetComponent(0)).LinkMaster.IFNLink.Mode;
  if AMode=imFieldLabels then AMode:=imFieldNames;
  if AMode=imDisplayName then AMode:=imName;
  GetIndexNames(nil, List,
    TLinkSource(GetComponent(0)).LinkMaster.CurrentIFNLink, AMode, True);
end;

{ TIFNLinkProperty }

Procedure TIFNLinkProperty.GetValueList(List: TStrings);
var AMode: TIFNMode;
begin
  TLinkSetItem(GetComponent(0)).FillIndexListCurrent;
  AMode:= TLinkSetItem(GetComponent(0)).IFNLink.Mode;
  if AMode=imFieldLabels then AMode:=imFieldNames;
  if AMode=imDisplayName then AMode:=imName;
  GetIndexNames(nil, List, TLinkSetItem(GetComponent(0)).CurrentIFNLink, AMode, False);
end;

{ TIFNLinkLinkProperty }

Procedure TIFNLinkLinkProperty.GetValueList(List: TStrings);
var AMode: TIFNMode;
begin
  TLinkMaster(GetComponent(0)).FillIndexListCurrent;
  AMode:= TLinkMaster(GetComponent(0)).IFNLink.Mode;
  if AMode=imFieldLabels then AMode:=imFieldNames;
  if AMode=imDisplayName then AMode:=imName;
  GetIndexNames(nil, List, TLinkMaster(GetComponent(0)).CurrentIFNLink, AMode, False);
end;

{ TLinkDatabaseNameProperty }

Procedure TLinkDatabaseNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TLinkSource).Inner.DBSession.GetDatabaseNames(List);
end;

{ TLinkTableNameProperty }

Function TLinkTableNameProperty.GetTable: TLnTable;
begin
  Result:= (GetComponent(0) as TLinkSource).Inner;
end;

{ TUserFieldProperty }

Procedure TUserFieldProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with GetComponent(0) as TUserSource do
    if DataSet<>nil then
      for i:=0 to DataSet.FieldCount-1 do begin
        List.Add(DataSet.Fields[i].FieldName);
      end;
end;

{ TLinkFiltersProperty }

Procedure TLinkFiltersProperty.Edit;
begin
  if Pointer(GetOrdValue)<>nil then
    if Assigned(TLinkFilters(GetOrdValue).Data.DataSource) and
    Assigned(TLinkFilters(GetOrdValue).Data.DataSource.DataSet) then begin
      if not TLinkFilters(GetOrdValue).Data.DataSource.DataSet.Active then
        if MessageDlg('Неактивная таблица. Открыть?',
        mtInformation, [mbYes, mbNo], 0)=mrYes then
          TLinkFilters(GetOrdValue).Data.DataSource.DataSet.Active:= True
        else Exit;
      TLinkFilters(GetOrdValue).Data.Execute;
      Modified;
    end;
end;

Function TLinkFiltersProperty.GetValue: string;
begin
  if Pointer(GetOrdValue)<>nil then FmtStr(Result, '(%s)', ['Filters'])
  else FmtStr(Result, '(%s)', ['Not Active']);
end;

Function TLinkFiltersProperty.GetAttributes: TPropertyAttributes;
begin
  Result:=[paReadOnly, paDialog];
end;

end.
