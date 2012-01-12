unit EtvPages;

interface
uses Classes,Controls,ComCtrls,db;

type

TEtvTabSheet=class(TTabSheet)
protected
  fTurnSource:boolean;
  fTurnMasterSource:boolean;
  fControlDataSource:TDataSource;
  fMasterSource:TDataSource;
  fControl:TControl;
  function GetControlDataSource:TDataSource;
  procedure SetControlDataSource(aValue:TDataSource);
  procedure SetControl(aValue:TControl);
  procedure Loaded; override;
  procedure EnableControl;
  procedure DisableControl;
  procedure Notification(AComponent: TComponent;
                         Operation: TOperation); override;
public
published
  property TurnControl:TControl read fControl write SetControl;
  property TurnMasterSource:boolean read fTurnMasterSource
             write fTurnMasterSource default false;
  property TurnSource:boolean read fTurnSource write fTurnSource default false;
end;

TEtvPageControl=Class(TPageControl)
protected
  function CanChange: Boolean; override;
  procedure Change; override;
  function GetActivePage:TTabSheet;
  procedure SetActivePage(Page:TTabSheet);
public
  procedure EnableControl;
  procedure DisableControl;
published
  property ActivePage:TTabSheet read GetActivePage write SetActivePage;
end;

IMPLEMENTATION

uses TypInfo,dbgrids;


{TEtvTabSheet}
procedure TEtvTabSheet.Loaded;
var i:smallint;
begin
  inherited;
  if Not(csDesigning in ComponentState) then begin
    if Not Assigned(fControl) then
      for i:=0 to ControlCount-1 do
        if (Controls[i] is TCustomDBGrid) then begin
          fControl:=Controls[i];
          Break;
        end;
    if Assigned(fControl) then
      if PageControl.ActivePage<>self then DisableControl;
  end;
end;

procedure TEtvTabSheet.SetControl(aValue:TControl);
begin
  {if csDesigning in ComponentState then begin}
  if fControl<>aValue then begin
    fControl:=aValue;
    if assigned(aValue) then aValue.FreeNotification(Self);
  end;
end;

function TEtvTabSheet.GetControlDataSource:TDataSource;
var PropInfo: PPropInfo;
begin
  Result:=nil;
  if Assigned(fControl) then begin
    PropInfo := GetPropInfo(fControl.ClassInfo,'DataSource');
    if PropInfo <> nil then
      Result:=TDataSource(GetOrdProp(fControl, PropInfo));
  end;
end;

procedure TEtvTabSheet.SetControlDataSource(aValue:TDataSource);
var PropInfo: PPropInfo;
begin
  if Assigned(fControl) then begin
    PropInfo := GetPropInfo(fControl.ClassInfo,'DataSource');
    if PropInfo <> nil then
      SetOrdProp(fControl,PropInfo,integer(aValue));
  end;
end;

procedure TEtvTabSheet.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation=opRemove then
    if AComponent=fControl then fControl:=nil
    else if AComponent=fControlDataSource then fControlDataSource:=nil
    else if AComponent=fMasterSource then fMasterSource:=nil;
end;

procedure TEtvTabSheet.DisableControl;
var LSource:TDataSource;
  function CheckMaster(aProp:string):boolean;
  var MSource:TDataSource;
      PropInfo: PPropInfo;
  begin
    PropInfo:=GetPropInfo(LSource.DataSet.ClassInfo, aProp);
    if PropInfo <> nil then begin
      Result:=true;
      MSource:=TDataSource(GetOrdProp(LSource.DataSet, PropInfo));
      if Assigned(MSource) then begin
        fMasterSource:=MSource;
        MSource.FreeNotification(Self);
        SetOrdProp(LSource.DataSet, PropInfo, integer(nil));
      end
    end else Result:=false;
  end;
  procedure DisableInnerControls(aOwner:TWinControl);
  var i:integer;
  begin
    for i:=1 to aOwner.ControlCount-1 do
      if aOwner.Controls[i] is TEtvPageControl then
        TEtvPageControl(aOwner.Controls[i]).DisableControl
      else if aOwner.Controls[i] is TWinControl then
        DisableInnerControls(TWinControl(aOwner.Controls[i]));
  end;
begin
  if Assigned(fControl) then begin
    LSource:=GetControlDataSource;
    if Assigned(LSource) then begin
      if fTurnSource then begin
        fControlDataSource:=LSource;
        LSource.FreeNotification(Self);
        SetControlDataSource(nil);
        {fControl.Enabled:=false;}
      end;
      if fTurnMasterSource and Assigned(LSource.DataSet) then
        if not CheckMaster('MasterSource') then CheckMaster('DataSource');
    end;
  end;
  DisableInnerControls(Self);
end;

procedure TEtvTabSheet.EnableControl;
var lSource:TDataSource;
  function SetMaster(aProp:string):boolean;
  var PropInfo: PPropInfo;
  begin
    PropInfo:=GetPropInfo(lSource.DataSet.ClassInfo,aProp);
    if PropInfo <> nil then begin
      Result:=true;
      SetOrdProp(lSource.DataSet,PropInfo,integer(fMasterSource));
    end else Result:=false;
  end;
  procedure EnableInnerControls(aOwner:TWinControl);
  var i:integer;
  begin
    for i:=1 to aOwner.ControlCount-1 do
      if aOwner.Controls[i] is TEtvPageControl then
        TEtvPageControl(aOwner.Controls[i]).EnableControl
      else if aOwner.Controls[i] is TWinControl then
        EnableInnerControls(TWinControl(aOwner.Controls[i]));
  end;
begin
  if Assigned(fControlDataSource) and
     (GetControlDataSource=nil) then begin
    SetControlDataSource(fControlDataSource);
    fControlDataSource:=nil;
    {fControl.Enabled:=true;}
  end;
  if Assigned(fMasterSource) then begin
    lSource:=GetControlDataSource;
    if Not SetMaster('MasterSource') then SetMaster('DataSource');
    fMasterSource:=nil;
  end;
  EnableInnerControls(Self);
end;

{TEtvPageControl}
Function TEtvPageControl.CanChange:boolean;
begin
  Result:=inherited CanChange;
  if Result then DisableControl;
end;

Procedure TEtvPageControl.Change;
begin
  Inherited Change;
  EnableControl;
end;

Function TEtvPageControl.GetActivePage:TTabSheet;
begin
  Result:=inherited ActivePage;
end;

procedure TEtvPageControl.SetActivePage(Page:TTabSheet);
begin
  if (Page<>nil) and (Page.PageControl<>Self) then Exit;
  if ActivePage<>Page then begin
    DisableControl;
    inherited ActivePage:=Page;
    EnableControl;
  end else inherited ActivePage:=Page;
end;

procedure TEtvPageControl.EnableControl;
begin
  if (Not(csDesigning in ComponentState)) and
     Assigned(ActivePage) and (ActivePage is TEtvTabSheet) then
    TEtvTabSheet(ActivePage).EnableControl;
end;

procedure TEtvPageControl.DisableControl;
begin
  if (Not(csDesigning in ComponentState)) and
     Assigned(ActivePage) and (ActivePage is TEtvTabSheet) then
    TEtvTabSheet(ActivePage).DisableControl;
end;

end.
