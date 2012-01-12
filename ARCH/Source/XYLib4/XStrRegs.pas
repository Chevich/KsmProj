Unit XStrRegs;

Interface

Uses EtvProps;

{ TSessionNameProperty }

type
  TSessionNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TXDatabaseNameProperty }

type
  TXDatabaseNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TXTableNameProperty }

type
  TXTableNameProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TIndexFieldNamesProperty }

type
  TIndexFieldNamesProperty = class(TDBStringProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

Implementation

{ TSessionNameProperty }

Procedure TSessionNameProperty.GetValueList(List: TStrings);
begin
  Sessions.GetSessionNames(List);
end;

{ TXDatabaseNameProperty }

Procedure TXDatabaseNameProperty.GetValueList(List: TStrings);
begin
  (GetComponent(0) as TLinkDataSet).Inner.DBSession.GetDatabaseNames(List);
end;

{ TXTableNameProperty }

Procedure TXTableNameProperty.GetValueList(List: TStrings);
const
  Masks: array[TTableType] of string[5] = ('', '*.DB', '*.DBF', '*.TXT');
var
  Table: TTable;
begin
  Table:=(GetComponent(0) as TLinkDataSet).Inner;
  Table.DBSession.GetTableNames(Table.DatabaseName, Masks[Table.TableType],
  Table.TableType = ttDefault, False, List);
end;

procedure TIndexFieldNamesProperty.GetValueList(List: TStrings);
var i: Integer;
begin
  with (GetComponent(0) as TLinkDataSet).Inner do begin
    IndexDefs.Update;
    for i:=0 to IndexDefs.Count-1 do
      with IndexDefs[i] do
        if not (ixExpression in Options) then List.Add(Fields);
  end;
end;

end.
