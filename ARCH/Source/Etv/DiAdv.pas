unit DiAdv;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDlgErrorAdv = class(TForm)
    ButtonOk: TButton;
    LabelError: TLabel;
    ButtonDetail: TButton;
    MemoDetail: TMemo;
    ImageError: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ButtonDetailClick(Sender: TObject);
  public
    ViewDetail:boolean;
  end;

Function DlgErrorAdv: TDlgErrorAdv;

implementation
uses Consts,EtvConst;
{$R *.DFM}

procedure TDlgErrorAdv.FormCreate(Sender: TObject);
begin
  Caption:=SMsgDlgError;
  ButtonOk.Caption:=SMsgDlgOK;
  ButtonDetail.Caption:=SDetail;
  ViewDetail:=false;
  ImageError.Picture.Icon.Handle:=LoadIcon(0,IDI_HAND);
end;

procedure TDlgErrorAdv.ButtonDetailClick(Sender: TObject);
begin
  ViewDetail:=not ViewDetail;
  MemoDetail.Visible:=ViewDetail;
  if ViewDetail then Height:=170
  else Height:=85;
end;

var fDlgErrorAdv: TDlgErrorAdv;
Function DlgErrorAdv: TDlgErrorAdv;
begin
  if not Assigned(fDlgErrorAdv) then
    fDlgErrorAdv:=TDlgErrorAdv.Create(nil);
  Result:=fDlgErrorAdv;
end;

initialization
finalization
  if Assigned(fDlgErrorAdv) then fDlgErrorAdv.Free;
end.
