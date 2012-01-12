{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Report components for MS Word: TDataSet       }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}
{$I VG.INC }
{$D-,L-}

unit vgWPCDS;

interface
uses Classes, vgWP, DB, vgDB, vgWPDB, DBClient;

type
  TUpdateDBParamEvent = procedure(Sender: TObject; Group: TWordBookmark;
    DataSet: TDataSet; Param: TDBParam; Macro: Boolean) of object;

{ TvgCDSWordPrint }
  TvgCDSWordPrint = class(TvgDBWordPrint)
  private
    FRemoteServer: TCustomRemoteServer;
    FOnUpdateDBParam: TUpdateDBParamEvent;
    procedure SetRemoteServer(Value: TCustomRemoteServer);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DefaultCreateDataSet(Group: TWordBookmark; var DataSet: TDataSet); override;
    procedure DefaultUpdateDBParam(Group: TWordBookmark; DataSet: TDataSet;
      Param: TDBParam); virtual;
    procedure DefaultUpdateParams(Group: TWordBookmark; DataSet: TDataSet); override;
  published
    property RemoteServer: TCustomRemoteServer read FRemoteServer write SetRemoteServer;
    property OnUpdateDBParam: TUpdateDBParamEvent read FOnUpdateDBParam write FOnUpdateDBParam;
  end;

implementation
uses SysUtils, vgCDS;

{ TvgCDSWordPrint }
constructor TvgCDSWordPrint.Create(AOwner: TComponent);
begin
  inherited;
  DataSetClass := TvgClientDataSet;
end;

procedure TvgCDSWordPrint.DefaultCreateDataSet(Group: TWordBookmark; var DataSet: TDataSet);
begin
  inherited DefaultCreateDataSet(Group, DataSet);
  try
    if (DataSet is TClientDataSet) and Assigned(FRemoteServer) then
    with TClientDataSet(DataSet) do
    begin
      RemoteServer := FRemoteServer;
      ProviderName := Group.BookmarkSQL.SQL;
      if (DataSet is TvgClientDataSet) then
      with TvgClientDataSet(DataSet) do
      begin
        FetchDBParams;
        FetchDBMacros;
      end;
    end;
  except
    Free;
    raise;
  end;
end;

procedure TvgCDSWordPrint.DefaultUpdateDBParam(Group: TWordBookmark; DataSet: TDataSet; Param: TDBParam);
var
  MasterField: TField;
begin
  MasterField := FindMasterField(Param.Name, Group);
  if Assigned(MasterField) then Param.Value := MasterField.Value;
end;

procedure TvgCDSWordPrint.DefaultUpdateParams(Group: TWordBookmark; DataSet: TDataSet);
  procedure DoUpdateDBParams(Params: TDBParams; Macro: Boolean);
  var
    I: Integer;
    Param: TDBParam;
  begin
    Params.BeginUpdate;
    try
      for I := 0 to Params.Count - 1 do
      begin
        Param := Params[I];
        if Assigned(FOnUpdateDBParam) then
          FOnUpdateDBParam(Self, Group, DataSet, Param, Macro) else
          DefaultUpdateDBParam(Group, DataSet, Param);
      end;
    finally
      Params.EndUpdate;
    end;
  end;
begin
  if (DataSet is TvgClientDataSet) then
  with TvgClientDataSet(DataSet) do
  begin
    DoUpdateDBParams(DBParams, False);
    DoUpdateDBParams(DBMacros, True);
  end;
end;

procedure TvgCDSWordPrint.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FRemoteServer) then SetRemoteServer(nil);
end;

procedure TvgCDSWordPrint.SetRemoteServer(Value: TCustomRemoteServer);
begin
  if (FRemoteServer <> Value) then
  begin
    if Assigned(Value) then FreeNotification(Value);
    FRemoteServer := Value;
  end;
end;

end.
