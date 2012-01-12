Unit DiDate;

Interface

Uses Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Mask, ToolEdit, RXCtrls;

type
  TDialDate = class(TForm)
    Bevel1: TBevel;
    LabelDateBeg: TRxLabel;
    LabelDateEnd: TRxLabel;
    EditDateBeg: TDateEdit;
    EditDateEnd: TDateEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure VisibleSecondDate(aVisible:boolean; aHeight: integer);
    { Public declarations }
  end;

var DialDate: TDialDate;

Implementation
Uses EtvLook;

{$R *.DFM}

Procedure TDialDate.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_Return) and not(TDialDate(Sender).ActiveControl is TEtvDBLookupCombo)
  and not(TDialDate(Sender).ActiveControl is TEtvLookupEdit) then
    PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_Tab,0);
end;

procedure TDialDate.VisibleSecondDate(aVisible:boolean; aHeight: integer);
begin
  Height:=40; { Сброс высоты формы }
  LabelDateEnd.Visible:=aVisible;
  EditDateEnd.Visible:=aVisible;
  if aHeight=0 then begin
    if aVisible then Bevel1.Height:=153 else Bevel1.Height:=45
  end else Bevel1.Height:=aHeight;
  if aVisible then LabelDateBeg.Caption:='От даты'
  else LabelDateBeg.Caption:='На дату';
  BitBtn1.Top:=Bevel1.Height+15;
  BitBtn2.Top:=Bevel1.Height+15;
  Height:=Bevel1.Height+70; { Установка высоты формы }
end;

end.
