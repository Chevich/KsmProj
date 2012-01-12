{$I XLib.inc}

Unit XETrees;

Interface

Uses Classes, Messages, DB, VG, XMisc;

type

  TXEDBTreeView = class(TvgDBTreeView)
  private
    FIsStoredDataSource: Boolean;
    FStoredDataSource: TDataSource;
    FStoredBookmark: TBookmark;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMChangePageSource(var Msg: TMessage); message WM_ChangePageSource;
    procedure ReadDataSource(Reader: TReader);
    procedure WriteDataSource(Writer: TWriter);
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    procedure ReadIsDataSource(Reader: TReader);
    procedure WriteIsDataSource(Writer: TWriter);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler);override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DataSource read GetDataSource write SetDataSource stored False;
  end;

Implementation

Uses Forms, LnkSet{, XDBTFC};

var XNotifyEvent: TXNotifyEvent;

{ TXEDBTreeView }

Constructor TXEDBTreeView.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  FStoredDataSource:=nil;
  FIsStoredDataSource:=False;
  FStoredBookmark:=nil;
end;

Procedure TXEDBTreeView.WMSetFocus(var Message: TWMSetFocus);
begin
  Inherited;
  XNotifyEvent.GoSpellChild(GetParentForm(Self), xeChangeParams, DataSource, opInsert);
end;

Procedure TXEDBTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if AComponent is TXNotifyEvent then
    case TXNotifyEvent(AComponent).SpellEvent of
      xeSetSource:
        begin
          if not Assigned(DataSource) then begin
            DataSource:=TDataSource(TXNotifyEvent(AComponent).SpellChild);
            if Assigned(DataSource.DataSet) then DataSource.DataSet.Active:=Operation=opInsert;
          end;
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
        end;
      xeGetFirstXControl: TXNotifyEvent(AComponent).GoEqual(Self, Operation);
      xeIsThisLink:
        if Assigned(DataSource)and
        (DataSource=TXNotifyEvent(AComponent).SpellChild) then
          TXNotifyEvent(AComponent).SpellEvent:=xeNone;
    end
  else Inherited;
end;

Function TXEDBTreeView.GetDataSource: TDataSource;
begin
  if FIsStoredDataSource then Result:=FStoredDataSource
  else Result:=Inherited DataSource;
end;

Procedure TXEDBTreeView.SetDataSource(Value: TDataSource);
begin
  if FIsStoredDataSource then FStoredDataSource:=Value
  else Inherited DataSource:=Value;
end;

Procedure TXEDBTreeView.ReadIsDataSource(Reader: TReader);
begin
  FIsStoredDataSource:=Reader.ReadBoolean;
end;

Procedure TXEDBTreeView.WriteIsDataSource(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsStoredDataSource);
end;

Procedure TXEDBTreeView.ReadDataSource(Reader: TReader);
begin
  Reader.ReadIdent;
end;

Procedure TXEDBTreeView.WriteDataSource(Writer: TWriter);
var S: String;
begin
  if DataSource.Owner<>Owner then S:=DataSource.Owner.Name+'.' else S:='';
  Writer.WriteIdent(S+DataSource.Name);
end;

Procedure TXEDBTreeView.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('IsStoredDataSource', ReadIsDataSource, WriteIsDataSource, True{FIsStoredDataSource});
  Filer.DefineProperty('DataSource', ReadDataSource, WriteDataSource, Assigned(DataSource));
  Inherited;
end;

Procedure TXEDBTreeView.WMChangePageSource(var Msg: TMessage);
begin
{
  if Msg.WParam=0 then begin
     if Not Assigned(FStoredDataSource) then begin
        FStoredDataSource:=DataSource;
        if Assigned(DataSource.DataSet) then begin
           FStoredBookmark:=DataSource.DataSet.GetBookmark;
           end;
        inherited DataSource:=Nil;
        end;
     FIsStoredDataSource:=True;
     end else begin
     FIsStoredDataSource:=False;
     if Assigned(FStoredDataSource) then begin
        DataSource:=FStoredDataSource;
        if Assigned(DataSource.DataSet) then begin
           DataSource.DataSet.GotoBookMark(FStoredBookmark);
           DataSource.DataSet.FreeBookmark(FStoredBookmark);
           FStoredBookmark:=Nil;
           end;
        FStoredDataSource:=Nil;
        end;
     end;
     }
end;

Initialization
  XNotifyEvent:=TXNotifyEvent.Create(nil);

finalization
  XNotifyEvent.Free;
  XNotifyEvent:=nil;
end.
