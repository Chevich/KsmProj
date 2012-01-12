unit EtvMem;

interface
uses Classes;

Type

TListObj=class(TList)
public
  destructor Destroy; override;
  procedure ClearFull;
  procedure DeleteFull(Index:integer);
end;

IMPLEMENTATION

Destructor TListObj.Destroy;
begin
  ClearFull;
  Inherited Destroy;
end;

Procedure TListObj.ClearFull;
var i:integer;
begin
  for i:=0 to Count-1 do begin
    TObject(Items[i]).Free;
  end;
  Clear;
end;

Procedure TListObj.DeleteFull(Index:integer);
begin
  try
    TObject(Items[index]).Free;
  finally
    Delete(Index);
  end;
end;

end.
