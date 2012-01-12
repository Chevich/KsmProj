unit EtvMidas;

interface

{$I Etv.inc}

uses Classes, DBClient,
     EtvDB;

type
TEtvClientDataSet=class(TClientDataSet)
  protected
    fActions:TEtvDataSetActions;
    fCaption:String;
    fSortingList:TStrings;
    fUniqueFields:string;
    fEditData:TOnEditDataEvent;
    fOnAction:TOnDataSetActionEvent;
    procedure SetCaption(ACaption:string);
    procedure SetSortingList(Value: TStrings);
    procedure InternalOpen; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Actions:TEtvDataSetActions read fActions write fActions default DefaultEtvDataSetAction;
    property Caption:String read fCaption Write SetCaption;
    property SortingList:TStrings read fSortingList Write SetSortingList;
    property UniqueFields:String read fUniqueFields Write fUniqueFields;
    property OnEditData:TOnEditDataEvent read fEditData Write fEditData;
    property OnAction:TOnDataSetActionEvent read fOnAction write fOnAction;
  end;


IMPLEMENTATION

uses DB;

Constructor TEtvClientDataSet.Create(AOwner: TComponent);
begin
  inherited;
  fSortingList:=TStringList.Create;
  fActions:=DefaultEtvDataSetAction;
end;

Destructor TEtvClientDataSet.Destroy;
begin
 fSortingList.free;
 inherited;
end;

procedure TEtvClientDataSet.SetCaption(ACaption:String);
begin
  fCaption:=ACaption;
end;

procedure TEtvClientDataSet.SetSortingList(Value: TStrings);
begin
  fSortingList.Assign(Value);
  DataEvent(deDataSetChange,0);
end;

procedure TEtvClientDataSet.InternalOpen;
begin
  inherited InternalOpen;
  {$IFNDEF Delphi4}
  if Assigned(EtvInternalOpen) then EtvInternalOpen(self);
  {$ENDIF}
end;

end.
