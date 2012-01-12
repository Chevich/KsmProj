unit EtvContr;

interface

uses Graphics, Classes, Controls, DBCtrls, Forms, DB, dbGrids;

{$I Etv.Inc}

type
TEtvDBEdit=class(TDBEdit)
protected
  procedure Loaded; override;
  procedure KeyDown(var Key: Word; Shift: TShiftState); override;
end;

TEtvScrollBoxForGrid=Class(TScrollBox)
protected
  fGrid:TCustomDBGrid;
  fSimpleControls:boolean;
  procedure PutFocus;
  procedure CreateRecordControls;
  procedure SetGrid(aValue:TCustomDBGrid);
  procedure Notification(AComponent: TComponent;
                         Operation: TOperation); override;
public
  procedure RefreshRecord;
  procedure ChangeControls;
  property Grid:TCustomDBGrid read fGrid write SetGrid;
end;

Function DBEditForField(Owner:TComponent; Field:TField; DS:TDataSource;
                      aWidth:Integer):TControl;
Function EditForField(Owner:TComponent; Field:TField; aWidth:Integer;
                      aLookSource:TDataSource):TControl;

function ValueFromEditForField(aControl:TControl; aField:TField;
                               aNullControl,aHide:boolean):variant;
procedure ValueToEditForField(aControl:TControl; aField:TField; aValue:variant);

function ControlRequiredParent(aControl:TControl):Boolean;

function CreateEtvText(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
function CreateEtvEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
function CreateEtvDateEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
function CreateEtvIntEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
function CreateEtvMemo(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
function CreateEtvLookupComboBox(aOwner:TComponent; Field:TField; aWidth:Integer; LS:TDataSource):TControl;

function CreateEtvDBText(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBDateEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBIntEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBMemo(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBImage(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
function CreateEtvDBLookupComboBox(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;

procedure ConstructOneRecordEdit(Scroll:TWinControl; aDataSource:TDataSource;
                                 aLabelFont:TFont; aEditColor:TColor; OneColumn,OnlyVisible:boolean);

IMPLEMENTATION

uses SysUtils,Windows,TypInfo,StdCtrls,
     EtvPas,EtvDB,EtvOther,EtvPopup,
     {Lev}
     EtvTemp;
     {Lev}

procedure TEtvDBEdit.Loaded;
begin
  inherited;
  if (not(csDesigning in ComponentState)) and (PopupMenu=nil) then
    PopupMenu:=PopupMenuEtvDBFieldControls;
end;

procedure TEtvDBEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  {DataSrcKeyDown(DataSource,Key,Shift);}
  KeyReturn(Self,Key,Shift);
end;

{TEtvScrollBoxForGrid}
procedure TEtvScrollBoxForGrid.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (AComponent=fGrid) then Grid:=nil;
end;

procedure TEtvScrollBoxForGrid.PutFocus;
var i:integer;
begin
  for i:=0 to ControlCount-1 do
    if (Controls[i] is TWinControl) and
       TWinControl(Controls[i]).TabStop then begin
      TWinControl(Controls[i]).SetFocus;
      break;
    end;
end;

type TCustomDBGridSelf=class(TCustomDBGrid);

procedure TEtvScrollBoxForGrid.CreateRecordControls;
var LabelFont:TFont;
begin
  if not TCustomDBGridSelf(fGrid).DataSource.DataSet.CanModify then begin
    LabelFont:=TFont.Create;
    Font.Style:=[fsBold];
  end else LabelFont:=nil;
  ConstructOneRecordEdit(Self,TCustomDBGridSelf(fGrid).DataSource,
                         LabelFont,TCustomDBGridSelf(fGrid).Color,false,true);
  if Assigned(LabelFont) then LabelFont.Free;
end;

procedure TEtvScrollBoxForGrid.RefreshRecord;
var lFocus:boolean;
    i:integer;
begin
  if fSimpleControls then begin
    lFocus:=false;
    for i:=0 to ControlCount-1 do
      if (Controls[i] is TWinControl) and
         TWinControl(Controls[i]).Focused then begin
        lFocus:=true;
        break;
      end;
    DestroyComponents;
    CreateRecordControls;
    if lFocus then PutFocus;
  end;
end;

procedure TEtvScrollBoxForGrid.SetGrid(aValue:TCustomDBGrid);
begin
  if aValue<>fGrid then begin
    fGrid:=aValue;
    if assigned(aValue) then begin
      aValue.FreeNotification(Self);
      BoundsRect:=fGrid.BoundsRect;
      Align:=fGrid.Align;
      {$IFDEF Delphi4}
      Anchors:=fGrid.Anchors;
      {$ENDIF}
      {ParentFont:=false;}
      Font.Assign(TCustomDBGridSelf(fGrid).Font);
    end;
  end;
end;

procedure TEtvScrollBoxForGrid.ChangeControls;
var lFocus:boolean;
    i:integer;
begin
  if fSimpleControls then begin
    lFocus:=false;
    for i:=0 to ControlCount-1 do
      if (Controls[i] is TWinControl) and
          TWinControl(Controls[i]).Focused then begin
        lFocus:=true;
        break;
      end;
    Hide;
    if Assigned(fGrid) then begin
      fGrid.Visible:=true;
      if lFocus then fGrid.SetFocus;
    end;
    fSimpleControls:=false;
  end else begin
    if Assigned(fGrid) and Assigned(TCustomDBGridSelf(fGrid).DataSource) and
       Assigned(TCustomDBGridSelf(fGrid).DataSource.DataSet) then begin
      lFocus:=fGrid.focused;
      fGrid.Visible:=false;
      fGrid.Parent.InsertControl(Self);
      CreateRecordControls;
      if lFocus then PutFocus;
      fSimpleControls:=true;
    end;
  end;
end;

Function DBEditForField(Owner:TComponent; Field:TField; DS:TDataSource;
                        aWidth:Integer):TControl;
const fWidth=6;
begin
  if aWidth<=0 then aWidth:=fWidth;
  Result:=nil;
  case Field.FieldKind of
    fkData: begin
      if Field is TMemoField then
        Result:=CreateEtvDBMemo(Owner,Field,DS,aWidth)
      else if Field is TGraphicField then
        Result:=CreateEtvDBImage(Owner,Field,DS,aWidth)
      else if Not Field.CanModify then
        Result:=CreateEtvDBText(Owner,Field,DS,aWidth)
      else if Field is TIntegerField {TEtvListField} then
        Result:=CreateEtvDBIntEdit(Owner,Field,DS,aWidth)
      else if (Field is TDateField) and (not(csDesigning in Field.ComponentState)) then
        Result:=CreateEtvDBDateEdit(Owner,Field,DS,aWidth)
      else
        Result:=CreateEtvDBEdit(Owner,Field,DS,aWidth)
    end;
    fkCalculated: Result:=CreateEtvDBText(Owner,Field,DS,aWidth);
    fkLookup:begin
      if (Not Field.DataSet.CanModify) or Field.ReadOnly then
        Result:=CreateEtvDBText(Owner,Field,DS,aWidth)
      else Result:=CreateEtvDBLookupComboBox(Owner,Field,DS,aWidth);
    end;
  end;
end;

Function EditForField(Owner:TComponent; Field:TField; aWidth:Integer;aLookSource:TDataSource):TControl;
const fWidth=6;
begin
  if aWidth<=0 then aWidth:=fWidth;
  Result:=nil;
  case Field.FieldKind of
    fkData: begin
      if Field is TIntegerField{TEtvListField} then
        Result:=CreateEtvIntEdit(Owner,Field,aWidth)
      else if Field is TDateField then
        Result:=CreateEtvDateEdit(Owner,Field,aWidth)
      else if Field is TMemoField then
        Result:=CreateEtvMemo(Owner,Field,aWidth)
      else Result:=CreateEtvEdit(Owner,Field,aWidth);
    end;
    fkCalculated: Result:=CreateEtvText(Owner,Field,aWidth);
    fkLookup: Result:=CreateEtvLookupComboBox(Owner,Field,aWidth,aLookSource);
  end;
end;

function ControlRequiredParent(aControl:TControl):Boolean;
begin
  Result:=false;
  if (aControl is TCustomComboBox) or (aControl is TCustomMemo) then
    Result:=True;
end;

Procedure SetControl(aControl:TControl; Field:TField; aWidth:Integer);
begin
  if aWidth>0 then begin
    aControl.Width:=(Field.DisplayWidth+2)*aWidth;
    if (Field is TDateField) or (aControl is TCustomComboBox) or
       (aControl is TDBLookupComboBox) then
      aControl.Width:=aControl.Width+GetSystemMetrics(SM_CXVSCROLL);
  end;
end;

Procedure SetDBControl(aControl:TControl; Field:TField; DS:TDataSource; aWidth:Integer);
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(aControl.ClassInfo, 'DataSource');
  if PropInfo <> nil then
    SetOrdProp(aControl, PropInfo, Integer(DS));
  if Assigned(Field) and (Not ControlRequiredParent(aControl)) then begin
    PropInfo := GetPropInfo(aControl.ClassInfo, 'DataField');
    if PropInfo <> nil then
      SetStrProp(aControl, PropInfo, Field.FieldName);
  end;
  if aWidth>0 then begin
    aControl.Width:=(Field.DisplayWidth+2)*aWidth;
    if (Field is TDateField) or (aControl is TCustomComboBox) or
       (aControl is TDBLookupComboBox) then
      aControl.Width:=aControl.Width+GetSystemMetrics(SM_CXVSCROLL);
  end;
end;

function CreateEtvText(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherText) then
    Result:=CreateOtherText(aOwner,Field);
  if Result=nil then Result:=TLabel.Create(aOwner);
  SetControl(Result,Field,aWidth);
end;

function CreateEtvEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherEdit) then
    Result:=CreateOtherEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEdit.Create(aOwner);
    TEdit(Result).OnKeyDown:=EtvApp.EditKeyDown;
  end;
  SetControl(Result,Field,aWidth);
end;

function CreateEtvDateEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDateEdit) then
    Result:=CreateOtherDateEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEdit.Create(aOwner);
    TEdit(Result).OnKeyDown:=EtvApp.EditKeyDown;
  end;
  SetControl(Result,Field,aWidth);
end;

function CreateEtvIntEdit(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherIntEdit) then
    Result:=CreateOtherIntEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEdit.Create(aOwner);
    TEdit(Result).OnKeyDown:=EtvApp.EditKeyDown;
  end;
  SetControl(Result,Field,aWidth);
end;

function CreateEtvMemo(aOwner:TComponent; Field:TField; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherMemo) then
    Result:=CreateOtherMemo(aOwner,Field);
  if Result=nil then begin
    Result:=TEdit{TMemo}.Create(aOwner);
    TEdit(Result).OnKeyDown:=EtvApp.EditKeyDown;
  end;
  SetControl(Result,Field,aWidth);
end;

type TControlSelf=class(TControl) end;

function CreateEtvLookupComboBox(aOwner:TComponent; Field:TField; aWidth:Integer; LS:TDataSource):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherLookupComboBox) then
    Result:=CreateOtherLookupComboBox(aOwner,Field);
  if Result=nil then begin
    Result:=TDBLookupComboBox.Create(aOwner);
    TDBLookupComboBox(Result).OnKeyDown:=EtvApp.EditKeyDown;
  end;
  SetControl(Result,Field,aWidth);
  if (Result is TDBLookupComboBox) and (Field.FieldKind=fkLookup) then begin
    TDBLookupComboBox(Result).ListSource:=LS;
    TDBLookupComboBox(Result).ListField:=ObjectStrProp(Field,'LookupResultField');
    TDBLookupComboBox(Result).KeyField:=Field.LookupKeyFields;
  end;
end;

function CreateEtvDBText(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if assigned(CreateOtherDBText) then
    Result:=CreateOtherDBText(aOwner,Field);
  if Result=nil then Result:=TDBText.Create(aOwner);
  SetDBControl(Result,Field,DS,aWidth);
end;

function CreateEtvDBEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBEdit) then
    Result:=CreateOtherDBEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEtvDBEdit.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
  end;
  SetDBControl(Result,Field,DS,aWidth);
end;

function CreateEtvDBDateEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBDateEdit) then
    Result:=CreateOtherDBDateEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEtvDBEdit.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
  end;
  SetDBControl(Result,Field,DS,aWidth);
end;

function CreateEtvDBIntEdit(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBIntEdit) then
    Result:=CreateOtherDBIntEdit(aOwner,Field);
  if Result=nil then begin
    Result:=TEtvDBEdit.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;
  end;
  SetDBControl(Result,Field,DS,aWidth);
end;

type TCustomMemoSelf=class(TCustomMemo) end;

function CreateEtvDBMemo(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBMemo) then
    Result:=CreateOtherDBMemo(aOwner,Field);
  if Result=nil then begin
    Result:=TDBMemo.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBMemo;
  end;
  TDBMemo(Result).ScrollBars:=ssVertical;
  SetDBControl(Result,Field,DS,aWidth);
  if Not Field.CanModify and (Result is TCustomMemo) then begin
    TCustomMemoSelf(Result).ReadOnly:=true;
    TCustomMemoSelf(Result).color:=clBtnFace;
  end;
end;

function CreateEtvDBImage(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBImage) then
    Result:=CreateOtherDBImage(aOwner,Field);
  if Result=nil then begin
    Result:=TDBImage.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBImage;
  end;
  SetDBControl(Result,Field,DS,aWidth);
  if Not Field.CanModify and (Result is TDBImage) then
    TDBImage(Result).ReadOnly:=true;
end;

function CreateEtvDBLookupComboBox(aOwner:TComponent; Field:TField; DS:TDataSource; aWidth:Integer):TControl;
begin
  Result:=nil;
  if Assigned(CreateOtherDBLookupComboBox) then
    Result:=CreateOtherDBLookupComboBox(aOwner,Field);
  if Result=nil then begin
    Result:=TDBLookupComboBox.Create(aOwner);
    TControlSelf(Result).PopupMenu:=PopupMenuEtvDBFieldControls;;
  end;
  SetDBControl(Result,Field,DS,aWidth);
end;


function ValueFromEditForField(aControl:TControl; aField:TField;
                               aNullControl,aHide:boolean):variant;
Var PropInfo: PPropInfo;
    Exist:boolean;
    lText:string;
begin
  Result:=null;
  if aControl is TDBLookupComboBox then
    Result:=TDBLookupComboBox(aControl).KeyValue
  else begin
    if aControl is TComboBox then
      if TComboBox(aControl).ItemIndex>=0 then begin
        Result:=TComboBox(aControl).ItemIndex;
        PropInfo:=GetPropInfo(aField.ClassInfo,'Values');
        try (* For EtvListField *)
          if (PropInfo<>nil) and
             (TStrings(GetOrdProp(aField, PropInfo))[Result]='') then
            Result:=Null;
        except
        end;
      end else Result:=Null
    else begin
      Exist:=false;
      if aField is TDateField then begin
        PropInfo := GetPropInfo(aControl.ClassInfo, 'Date');
        if PropInfo <> nil then begin
          Result:=GetFloatProp(aControl,PropInfo);
          Exist:=true;
        end;
      end;
      if Not Exist then begin
        lText:=ObjectStrProp(aControl,'Text');
        if lText<>'' then begin
          Try
            if aField is TDateField then
{ Lev }
              Result:=StrToDate_(lText)
{ Lev }
            else if aField is TFloatField then
              Result:=StrToFloat(lText)
            else if aField is TIntegerField then
              Result:=StrToInt(lText)
            else Result:=lText;
          except
            if aNullControl then begin
              PropInfo := GetPropInfo(aControl.ClassInfo, 'Text');
              if PropInfo <> nil then
                SetStrProp(aControl,PropInfo,'');
            end;
            if Not aHide then Raise;
          end;
        end else Result:=Null;
      end;
    end;
  end;
end;

procedure ValueToEditForField(aControl:TControl; aField:TField; aValue:variant);
var Exist:boolean;
    PropInfo:PPropInfo;
begin
  if (aControl is TComboBox) then begin
    PropInfo:=GetPropInfo(aField.ClassInfo,'Values');
    try
      if (PropInfo<>nil) then
        TComboBox(aControl).Items.Assign(TStrings(GetOrdProp(aField, PropInfo)));
    except
    end;
  end;

  if aControl is TDBLookupComboBox then begin
    TDBLookupComboBox(aControl).KeyValue:=aValue
  end else if aControl is TCustomComboBox then
    if aValue<>null then TCustomComboBox(aControl).ItemIndex:=aValue
    else TCustomComboBox(aControl).ItemIndex:=-1
  else begin
    Exist:=false;
    if aValue<>null then begin
      PropInfo:=GetPropInfo(aControl.ClassInfo, 'Date');
      if PropInfo <> nil then begin
        SetFloatProp(aControl,PropInfo,aValue);
        Exist:=true;
      end;
    end;
    if Not Exist then begin
      PropInfo := GetPropInfo(aControl.ClassInfo, 'Text');
      if PropInfo <> nil then
        if aValue<>null then SetStrProp(aControl,PropInfo,VarToStr(aValue))
        else SetStrProp(aControl,PropInfo,'');
    end;
  end;
end;

type TWinControlSelf=class(TWinControl) end;

procedure ConstructOneRecordEdit(Scroll:TWinControl; aDataSource:TDataSource;
            aLabelFont:TFont; aEditColor:TColor; OneColumn,OnlyVisible:boolean);
var i,l,ind,aTop,aLeft,ofs:integer;
    Ed: TControl;
    Field:TField;
    Lab:TLabel;
    labelFont:TFont;
    labelWidth,labelHeight,lWidth,lHeight:integer;
    PropInfo:PPropInfo;
function GoodField(aField:TField):boolean;
begin
  if (aField.Tag mod 10<>8) and
     ((aField.Visible) or (Not OnlyVisible)) then Result:=true
  else Result:=false;
end;
begin
  if Not assigned(aDataSource.DataSet) then Exit;
  GetFontSizes(TWinControlSelf(Scroll).Font,lWidth,lHeight,'');
  if Assigned(aLabelFont) then LabelFont:=aLabelFont
  else LabelFont:=TWinControlSelf(Scroll).Font;

  if OneColumn then begin
    l:=0; ind:=0;
    For i:=0 to aDataSource.DataSet.FieldCount - 1 do
      if GoodField(aDataSource.DataSet.Fields[i]) and
         (length(aDataSource.DataSet.Fields[i].DisplayLabel)>l) then begin
        l:=length(aDataSource.DataSet.Fields[i].DisplayLabel);
        ind:=i;
      end;
    GetFontSizes(LabelFont,LabelWidth,LabelHeight,aDataSource.DataSet.Fields[ind].DisplayLabel);
  end;

  aTop:=3;
  aLeft:=5;
  ofs:=0;
  For i:=0 to aDataSource.DataSet.FieldCount - 1 do
    if GoodField(aDataSource.DataSet.Fields[i]) then begin
      Field:=aDataSource.DataSet.Fields[i];
      Ed:=DBEditForField(Scroll,Field,aDataSource,lWidth);
      if Assigned(Ed) then begin
        if aEditColor<>0 then TControlSelf(Ed).Color:=aEditColor;

        Lab:=TLabel.Create(Scroll);
        Lab.ParentFont:=false;
        Lab.Font:=LabelFont;
        Lab.Caption:=Field.DisplayLabel;

        if OneColumn or
           (aLeft+Lab.Width+4+Ed.Width>=Scroll.ClientWidth) then begin
          aTop:=aTop+ofs;
          aLeft:=5;
          ofs:=0;
        end;

        Lab.Top:=aTop+3;
        Lab.Left:=aLeft;
        if Ed is TCustomLabel then Ed.Top:=aTop+3
        else Ed.Top:=aTop;
        if OneColumn then
          Ed.Left:=Lab.Left+LabelWidth+8
        else Ed.Left:=Lab.Left+Lab.Width+4;

        Scroll.InsertControl(Ed);
        if ControlRequiredParent(Ed) then begin
          PropInfo := GetPropInfo(Ed.ClassInfo, 'DataField');
          if PropInfo <> nil then
          SetStrProp(Ed, PropInfo, Field.FieldName);
        end;
        if Ed is TWinControl then Lab.FocusControl:=TWinControl(Ed);
        Scroll.InsertControl(Lab);
        if ofs<Ed.Height+5 then ofs:=Ed.Height+5;
        aLeft:=Ed.Left+Ed.Width+5;
      end;
    end;
End;
  
end.


