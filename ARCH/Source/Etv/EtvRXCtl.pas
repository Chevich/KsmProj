unit EtvRXCtl;     (* Igo *)

interface

uses Classes,Controls,Mask,ToolEdit,RxDBCtrl,db,dbGrids;

type

TEtvDBDateEdit=class(TDBDateEdit)
protected
  procedure Loaded; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  procedure KeyPress(var Key: Char); override;
public
  property AutoSize;
  constructor Create(AOwner: TComponent); override;
end;

function CreateRXDateEdit(aOwner:TComponent):TControl;
function CreateRXDBDateEdit(aOwner:TComponent):TControl;

function CreateRXDBGridDateEdit(aOwner:TDBGrid; Field:TField; c:Char):TWinControl;

IMPLEMENTATION

uses Windows,Messages,Menus,
     EtvPas,EtvDBFun,EtvPopup;

constructor TEtvDBDateEdit.Create(AOwner: TComponent);
begin
 inherited;
 ClickKey:=ShortCut(Vk_Return,[ssCtrl]);
end;

procedure TEtvDBDateEdit.Loaded;
var MyRect: TRect;
begin
  inherited;
  if (not(csDesigning in ComponentState)) and (PopupMenu=nil) then begin
    PopupMenu:=PopupMenuEtvDBFieldControls;
    AutoSize:=true;
  end;
end;

procedure TEtvDBDateEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  KeyReturn(Self,Key,Shift);
end;

procedure TEtvDBDateEdit.KeyPress(var Key: Char);
begin
  {if Key<>#13 then} inherited;
end;

function CreateRXDateEdit(aOwner:TComponent):TControl;
begin
  Result:=TDateEdit.Create(aOwner);
end;

function CreateRXDBDateEdit(aOwner:TComponent):TControl;
begin
  Result:=TEtvDBDateEdit.Create(aOwner);
end;

type
TEtvDBInplaceDateEdit=class(TDBDateEdit) (* For EtvList*)
  private
    FGrid: TWinControl;
  protected
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var fGridDateEdit:TEtvDBInplaceDateEdit;

constructor TEtvDBInplaceDateEdit.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Visible:=False;
  Ctl3D:=false;
  ParentCtl3D:=false;
  {BorderStyle:=bsNone;}
end;

destructor TEtvDBInplaceDateEdit.Destroy;
begin
  fGridDateEdit:=nil;
  inherited;
end;

procedure TEtvDBInplaceDateEdit.CNKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode=VK_TAB then begin
    fGrid.Setfocus;
    Message.CharCode:=0;
    PostMessage(fGrid.Handle,WM_KeyDown,VK_Tab,0);
  end;
  inherited;
end;

type TWinControlSelf=class(TWinControl) end;

procedure TEtvDBInplaceDateEdit.DoExit;
begin
  Inherited;
  Visible:=False;
  if Assigned(TWinControlSelf(FGrid).OnClick) then TWinControlSelf(FGrid).OnClick(Self);
end;

procedure TEtvDBInplaceDateEdit.KeyPress(var Key: Char);
var WKey: Word;
begin
  WKey:=Integer(Key);
  Inherited;
  if WKey in [vk_Return, vk_Escape] then begin
    Visible:=False;
    FGrid.SetFocus;
    if WKey=vk_Return then begin
      TWinControlSelf(FGrid).KeyDown(WKey,[]);
      Key:=#0;
    end;
  end;
end;

function CreateRXDBGridDateEdit(aOwner:TDBGrid; Field:TField; c:Char):TWinControl;
begin
  Result:=nil;
  if Field is TDateField then begin
    if not Assigned(fGridDateEdit) then
      fGridDateEdit:=TEtvDBInplaceDateEdit.Create(nil);
    fGridDateEdit.fGrid:=aOwner;
    fGridDateEdit.PopupMenu:=aOwner.PopupMenu;
    if fGridDateEdit.DataSource<>aOwner.DataSource then begin
      fGridDateEdit.DataField:='';
      fGridDateEdit.DataSource:=aOwner.DataSource;
    end;
    fGridDateEdit.DataField:=Field.FieldName;
    Result:=fGridDateEdit;
  end;
end;

end.


