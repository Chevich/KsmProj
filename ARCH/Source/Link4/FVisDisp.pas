{*******************************************************}
{                                                       }
{   Create group of controls                            }
{                                                       }
{   Last corrections 11.02.99                           }
{                                                       }
{*******************************************************}

Unit FVisDisp;

Interface

Uses Classes, Controls, DB;

const

  DFGetDBEdit: Function(AOwner: TComponent): TWinControl = Nil;
  DFGetLookCombo: Function(aOwner: TComponent): TWinControl = Nil;
  DFSetLookField: Procedure(AControl: TWinControl; AField: TField;
                            ADataSource: TDataSource) = Nil;
  DFSetLookKeyValue: Procedure(AControl: TWinControl; AValue: String) = Nil;

  DFSetDBEditField: Procedure(AControl: TWinControl; AField: TField;
                              ADataSource: TDataSource) = Nil;
  DFSetDBEditKeyValue: Procedure(AControl: TWinControl; AValue: String) = Nil;

  IsLookupFormCloseQueryProc: Function (AControl: TWinControl) : Boolean = Nil;

function GetDispDBEdit(aOwner: TComponent): TWinControl;
function GetDispLookCombo(aOwner: TComponent): TWinControl;
procedure SetDispDBEditField(aControl: TWinControl; aField: TField; aDataSource: TDataSource;
                             aValue: String; isKey: Boolean);
procedure SetDispLookField(aControl: TWinControl; aField: TField; aDataSource: TDataSource;
                           aValue: String; isKey: Boolean);

Implementation

Uses DBCtrls;

function GetDispDBEdit(aOwner: TComponent): TWinControl;
begin
  if Assigned(DFGetDBEdit) then Result:=DFGetDBEdit(aOwner)
  else Result:=TDBEdit.Create(aOwner);
end;

function GetDispLookCombo(aOwner: TComponent): TWinControl;
begin
  if Assigned(DFGetLookCombo) then Result:=DFGetLookCombo(aOwner)
  else Result:=GetDispDBEdit(aOwner);
end;

procedure SetDispDBEditField(aControl: TWinControl; aField: TField; aDataSource: TDataSource;
                             aValue: String; isKey: Boolean);
begin
  if Assigned(DFSetDBEditKeyValue)and isKey then DFSetDBEditKeyValue(aControl, aValue);
  if Assigned(DFSetDBEditField) then DFSetDBEditField(aControl, aField, aDataSource);
end;

procedure SetDispLookField(aControl: TWinControl; aField: TField; aDataSource: TDataSource;
                           aValue: String; isKey: Boolean);
begin
  if Assigned(DFSetLookField) then DFSetLookField(aControl, aField, aDataSource);
  if Assigned(DFSetLookKeyValue)and isKey then DFSetLookKeyValue(aControl, aValue);
end;

end.
