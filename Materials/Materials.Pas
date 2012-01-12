unit Materials;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, RXSplit, ComCtrls, Vg, XETrees, StdCtrls, SrcIndex, XDBForms,
  ExtCtrls, Grids, DBGrids, EtvGrid, XECtrls, EtvPages, XMisc, Db,
  DBTables, DBCtrls, EtvLook, RXCtrls, XCtrls, Mask, EtvContr, ImgList;

type
  TFormMat = class(TABEForm)
    MaterialsTree: TXEDBTreeView;
    Panel1: TPanel;
    eName: TXEDBEdit;
    XLabel1: TXLabel;
    eKOD: TXEDBEdit;
    XLabel2: TXLabel;
    RxSplitter1: TRxSplitter;
    eKodUp: TXEDBEdit;
    XLabel13: TXLabel;
    ImageList1: TImageList;
    procedure DepotLookUpCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MaterialsTreeCancelRange(Sender: TObject; DataSet: TDataSet);
    procedure MaterialsTreeSetRange(Sender: TObject; DataSet: TDataSet;
      ParentID: String);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; aState: TGridDrawState);
  private
    { Private declarations }
    procedure DisableAllControls(Control: TWinControl; State : boolean);
  public
    { Public declarations }
  end;

var
  FormMat: TFormMat;

implementation

Uses MdMaterials, mdBase;

{$R *.DFM}

procedure TFormMat.DepotLookUpCloseUp(Sender: TObject);
begin
  inherited;
  Grid.DataSource.DataSet.Refresh;
end;

procedure TFormMat.FormCreate(Sender: TObject);
begin
{  inherited;}
{  if not mdMat.dsDepot.DataSet.Active then mdMat.dsDepot.DataSet.Open;}
end;

procedure TFormMat.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift=[ssCtrl]) then begin
    case Key of
      VK_DOWN: if Grid.DataSource.DataSet.FieldByName('AmountDown').AsInteger<>0 then
        MaterialsTree.GotoNode(Grid.DataSource.DataSet.FieldByName('Kod').AsVariant)
        else MaterialsTree.Selected.Expand(false);
      VK_UP: if MaterialsTree.DataSource.DataSet.FieldByName('KodUp').AsVariant<>Null
        then MaterialsTree.GotoNode(MaterialsTree.DataSource.DataSet.FieldByName('KodUp').AsVariant)
    end;
    // key:=0; {Заккоментарил Лев 06.03.02}
  end;
end;

procedure TFormMat.FormClose(Sender: TObject; var Action: TCloseAction);
var i:integer;
begin
  inherited;
  // Отключаем дерево, чтобы не глючило
  if TFormMat(Sender).Tag=1 then begin
    MaterialsTree.DataSource:=nil;
  end;
end;

procedure TFormMat.FormActivate(Sender: TObject);
begin
  inherited;
  if TFormMat(Sender).Tag=1 then
    begin
      TFormMat(Sender).Tag:=0
    end;
end;

procedure TFormMat.DisableAllControls(Control: TWinControl;
  State: boolean);
  var i: integer;
begin
  for i:=0 to Control.ControlCount -1 do
    begin
      Control.Controls[i].Enabled:=State;
      if Control.Controls[i] is TWinControl then
      DisableAllControls(TWinControl(Control.Controls[i]), State);
    end;
end;

procedure TFormMat.PageControl1Change(Sender: TObject);
begin
  inherited;
  PageControl1PanelNavigator.Visible:= not (PageControl1.ActivePage = FormSheet);
end;

procedure TFormMat.FormShow(Sender: TObject);
begin
  if not Assigned(MaterialsTree.DataSource) then MaterialsTree.DataSource:=mdMat.MaterialsView;
  MaterialsTree.DataSource.DataSet.DisableControls;
  MaterialsTree.DataSource.DataSet.EnableControls;
  inherited;
  PageControl1Change(Sender);
end;

procedure TFormMat.MaterialsTreeCancelRange(Sender: TObject;
  DataSet: TDataSet);
begin
  inherited;
  DataSet.Filtered:=False;
end;

procedure TFormMat.MaterialsTreeSetRange(Sender: TObject;
  DataSet: TDataSet; ParentID: String);
begin
  inherited;
  if ParentID='' then
    Dataset.Filter:='kodup is NULL'
  else
    Dataset.Filter:='kodup = '+ParentID;
  Dataset.Filtered:=True;
end;

procedure TFormMat.GridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; aState: TGridDrawState);
begin
  inherited;
  with TDBGrid(Sender).DataSource.Dataset do
    if(FieldByName('Gold').IsNull) and
        (FieldByName('Platinum').IsNull) and
        (FieldByName('Silver').IsNull) and          
        (FieldByName('Palladium').IsNull) and
        (FieldByName('Rutenium').IsNull) and
        (FieldByName('Rodium').IsNull) and
        (FieldByName('Iridium').IsNull) then
      begin
        if (gdSelected in aState) and (gdFocused in aState) then
          TDBGrid(Sender).Canvas.Font.Color := clHighlightText
        else
          TDBGrid(Sender).Canvas.Font.Color := clWindowText;
      end
    else
      begin
        if (gdSelected in aState) and (gdFocused in aState) then
          TDBGrid(Sender).Canvas.Font.Color := clYellow
        else
          TDBGrid(Sender).Canvas.Font.Color := clBlue;
      end;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,aState);
end;

Initialization
  RegisterAliasXForm('FormMat', TFormMat);
Finalization
  UnRegisterXForm(TFormMat);
end.
  