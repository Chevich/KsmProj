{*******************************************************}
{                                                       }
{            X-library v.03.00                          }
{                                                       }
{   02.06.98                   				}
{                                                       }
{   TSrcLinkCombo - Combo of TSrcLinks                  }
{   RxLib analog TDBIndexCombo, but not only for TTable }
{         and not only Dataset's Indexes                }
{                                                       }
{   Last corrections 05.11.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}

Unit SrcIndex;

Interface

Uses Classes, SysUtils, Windows, Messages, Controls, Forms,
     Graphics, Menus, StdCtrls, ExtCtrls, XMisc;

Type

{ TSrcLinkCombo }

  TSrcLinkCombo = class(TCustomComboBox)
  private
    FUpdate: Boolean;
    FChanging: Boolean;
    FIsKeyReturn: Boolean; { В КОМБЕ нажали <ENTER>, т.е. подтвердили ВЫБОР }
    FSrcLinkItem: TSrcLinkItem;
    FSrcLinks: TSrcLinks;
    procedure SetSrcLinkItem(Value: TSrcLinkItem);
    procedure SetSrcLinks(Value: TSrcLinks);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    procedure Change; override;
    procedure UpdateList; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ActiveChanged;
    property SrcLinkItem: TSrcLinkItem read FSrcLinkItem write SetSrcLinkItem;
    property SrcLinks: TSrcLinks read FSrcLinks write SetSrcLinks;
    property IsKeyReturn: Boolean read FIsKeyReturn write FIsKeyReturn;
  published
    property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property DropDownCount;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  end;
{ TSrcLinkCombo }

Implementation

{uses LnkSet;}
uses Dialogs;

{ TSrcLinkCombo }

Constructor TSrcLinkCombo.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Style := csDropDownList;
  FUpdate := False;
end;

Destructor TSrcLinkCombo.Destroy;
begin
  inherited Destroy;
end;

Procedure TSrcLinkCombo.SetSrcLinkItem(Value: TSrcLinkItem);
begin
  FSrcLinkItem:= Value;
  if not (csLoading in ComponentState) then ActiveChanged;
end;

Procedure TSrcLinkCombo.SetSrcLinks(Value: TSrcLinks);
begin
  FSrcLinks:= Value;
  if not (csLoading in ComponentState) then ActiveChanged;
end;

Procedure TSrcLinkCombo.ActiveChanged;
begin
  if not Assigned(FSrcLinks) or (not Enabled) then begin
    Clear;
    ItemIndex := -1;
  end else UpdateList;
end;

Procedure TSrcLinkCombo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_Return) and (Shift=[]) then begin
    FIsKeyReturn:=true;
    Change;
    FIsKeyReturn:=false;
  end;
  Inherited;
end;

Procedure TSrcLinkCombo.Loaded;
begin
  inherited Loaded;
  ActiveChanged;
end;

Procedure TSrcLinkCombo.Notification(aComponent: TComponent; Operation: TOperation);
begin
  (*** TEST!!! Writeln(FFFF,'TSrcLinkCombo.Notification #1 :',AComponent.Name); ***)
  inherited Notification(aComponent, Operation);
  (*** TEST!!! Writeln(FFFF,'TSrcLinkCombo.Notification #2 :',AComponent.Name); ***)
end;

Procedure TSrcLinkCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then ActiveChanged;
end;

Procedure TSrcLinkCombo.Change;
begin
  if Enabled and Assigned(FSrcLinks) and not FChanging and
  not (csLoading in ComponentState) and (not DroppedDown or FIsKeyReturn) then begin
    if ItemIndex<FSrcLinks.Count then FSrcLinks.CurrentIndex:=ItemIndex;
  end;
  Inherited Change;
end;

Procedure TSrcLinkCombo.UpdateList;
var i: Integer;
begin
  if Enabled and Assigned(FSrcLinks) then
    try
      Items.BeginUpdate;
      try
        Items.Clear;
        if Assigned(FSrcLinks) then begin
          FSrcLinks.GetStrings(Items);
          ItemIndex:= FSrcLinks.CurrentIndex;
        end;
        if Assigned(FSrcLinkItem) then begin
          i:= FSrcLinkItem.GetString(Items, FSrcLinks);
          if i<>-1 then ItemIndex:= i;
        end;
        FChanging := True;
      finally
        Items.EndUpdate;
      end;
    finally
      FChanging := False;
    end;
end;

end.