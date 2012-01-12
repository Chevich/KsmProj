{*******************************************************}
{                                                       }
{            X-library v.03.00                          }
{                                                       }
{   02.07.98                   				}
{                                                       }
{   Indexes editor form                                 }
{                                                       }
{   Last corrections 06.07.98                           }
{                                                       }
{*******************************************************}
{$I XLib.inc}
Unit FEdIFNs;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, LnkMisc;

type
  TEdIFNsForm = class(TForm)
    IFNsBox: TListBox;
    AddBtn: TButton;
    DelBtn: TButton;
    CaptionEdit: TEdit;
    ChangeBtn: TButton;
    NameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    FieldsLab: TLabel;
    procedure IFNsBoxClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure ChangeBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    FIFNLink: TIFNLink;
    FCurrentSource: TDataSource;
    procedure SetIFNLink(AItems: TIFNLink);
    procedure GetCurrentItem;
    procedure SetCurrentItem;
  public
    property IFNLink: TIFNLink read FIFNLink write SetIFNLink;
    property CurrentSource: TDataSource read FCurrentSource write FCurrentSource;
  end;

var
  EdIFNsForm: TEdIFNsForm;

Implementation

Uses EtvDBFun, XDBMisc;

{$R *.DFM}

{ TEdIFNsForm }

Procedure TEdIFNsForm.SetIFNLink(AItems: TIFNLink);
var i: Integer;
begin
  FIFNLink:= AItems;
  IFNsBox.Items.Clear;
  for i:=0 to FIFNLink.Count-1 do
    IFNsBox.Items.AddObject(FIFNLink[i].DisplayName, FIFNLink[i]);
  if FIFNLink.Count>0 then IFNsBox.ItemIndex:=0;
end;

Procedure TEdIFNsForm.GetCurrentItem;
begin
  if FIFNLink.Count=0 then begin
    DelBtn.Enabled:=False;
    ChangeBtn.Enabled:=False;
    CaptionEdit.Text:='';
    NameEdit.Text:='';
    FieldsLab.Caption:= '';
  end else begin
    DelBtn.Enabled:=True;
    ChangeBtn.Enabled:=True;
    CaptionEdit.Text:=FIFNLink[IFNsBox.ItemIndex].DisplayName;
    NameEdit.Text:=FIFNLink[IFNsBox.ItemIndex].Name;
    FieldsLab.Caption:= FIFNLink[IFNsBox.ItemIndex].Fields;
  end;
end;

Procedure TEdIFNsForm.SetCurrentItem;
begin
  if FIFNLink.Count>0 then begin
    FIFNLink[IFNsBox.ItemIndex].DisplayName:= CaptionEdit.Text;
    FIFNLink[IFNsBox.ItemIndex].Name:= NameEdit.Text;
  end;
end;

Procedure TEdIFNsForm.IFNsBoxClick(Sender: TObject);
begin
  GetCurrentItem;
end;

Procedure TEdIFNsForm.AddBtnClick(Sender: TObject);
var Ind: Integer;
begin
  Ind:=FIFNLink.Add.Index;
  FIFNLink[Ind].DisplayName:= 'Индекс № '+IntToStr(IFNLink.Count);
  FIFNLink[Ind].Name:= 'Name'+IntToStr(IFNLink.Count);
  IFNsBox.Items.AddObject(FIFNLink[Ind].DisplayName, FIFNLink[Ind]);
  IFNsBox.Itemindex:=Ind;
  GetCurrentItem;
end;

Procedure TEdIFNsForm.DelBtnClick(Sender: TObject);
var Ind: Integer;
begin
  if MessageDlg('Удалить индекс?', mtInformation, [mbYes, mbNo], 0)=mrYes then begin
    FIFNLink[IFNsBox.ItemIndex].Free;
    Ind:=IFNsBox.ItemIndex;
    if (FIFNLink.Count=IFNsBox.ItemIndex)and(IFNsBox.ItemIndex>0) then Dec(Ind);
    IFNsBox.Items.Delete(IFNsBox.ItemIndex);
    IFNsBox.ItemIndex:=Ind;
    GetCurrentItem;
  end;
end;

Procedure TEdIFNsForm.ChangeBtnClick(Sender: TObject);
var SSrc, SDst: String;
begin
  if Assigned(FCurrentSource) and Assigned(FCurrentSource.DataSet) then begin
    SDst:= FIFNLink[IFNsBox.ItemIndex].Fields;
    SSrc:=GetAddFieldNames(FCurrentSource.DataSet, SDst, False, False, True);
    if ChooseFieldList(FCurrentSource.DataSet, SDst, SSrc,
    'Порядок сортировки', 'Поля сортировки','Остальные поля',False, ';') then
       FIFNLink[IFNsBox.ItemIndex].Fields:=SDst;
    GetCurrentItem;
  end;
end;

Procedure TEdIFNsForm.FormActivate(Sender: TObject);
begin
  GetCurrentItem;
end;

end.
