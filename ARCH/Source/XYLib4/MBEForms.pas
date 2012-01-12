unit MBEForms;

Interface

Uses Forms, BBEForms, StdCtrls, DBIndex, ExtCtrls,
     Controls, Grids, DBGrids, EtvGrid, XECtrls, ComCtrls, Classes, XMisc,
     XDBForms, SrcIndex, EtvContr, Menus, EtvPages, DBCtrls;

type
  TMBEForm = class(TBBEForm)
    AddSheet: TTabSheet;
    AddGrid: TXEDbGrid;
    EtvDbGrid1: TXEDbGrid;
    procedure FormCreate(Sender: TObject);
    procedure TabControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Implementation

{$R *.DFM}

Procedure TMBEForm.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePage:=FormSheet;
end;

Procedure TMBEForm.TabControlChange(Sender: TObject);
begin
{  inherited;}
{!!!  Case TabControl.TabIndex of
       0: begin
          with DetailSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          with MasterSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          PageControl1.ActivePage:=GridSheet;
          end;
       1: begin
          with GridSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          with MasterSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          PageControl2.ActivePage:=FormSheet1;
          PageControl1.ActivePage:=FormSheet;
          end;
       2: begin
          with GridSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          with MasterSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          PageControl2.ActivePage:=GridSheet1;
          PageControl1.ActivePage:=FormSheet;
          end;
       3: begin
          with GridSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          with DetailSource do
          if Assigned(DataSet)and(DataSet.Active) then
             DataSet.Refresh;
          PageControl1.ActivePage:=DetailSheet;
          end;
  end;}
end;

Procedure TMBEForm.FormActivate(Sender: TObject);
begin
  inherited;
{}
end;

Procedure TMBEForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
{}
end;

Procedure TMBEForm.FormDeactivate(Sender: TObject);
begin
  inherited;
{}
end;

Initialization
  RegisterXForm(TMBEForm);
Finalization
  UnRegisterXForm(TMBEForm);
end.
