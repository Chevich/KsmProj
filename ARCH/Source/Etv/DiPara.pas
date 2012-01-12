unit DiPara;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Spin,comctrls;

type
  TDialParagraph = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    SpinEditFirst: TSpinEdit;
    SpinEditLeft: TSpinEdit;
    SpinEditRight: TSpinEdit;
    SpeedButtonLeft: TSpeedButton;
    SpeedButtonCenter: TSpeedButton;
    SpeedButtonRight: TSpeedButton;
    SpeedButtonBullets: TSpeedButton;
    LabelFirst: TLabel;
    LabelLeft: TLabel;
    LabelRight: TLabel;
    procedure FormCreate(Sender: TObject);
  public
    function Execute(RichEdit:TCustomRichEdit):boolean;
  end;

implementation
uses EtvConst,EtvRich;

{$R *.DFM}

function TDialParagraph.Execute(RichEdit:TCustomRichEdit):boolean;
begin
  Result:=false;
  with RichEdit.Paragraph do begin
    SpinEditFirst.Value:=FirstIndent;
    SpinEditLeft.Value:=LeftIndent;
    SpinEditRight.Value:=RightIndent;
    case Alignment of
      taLeftJustify: SpeedButtonLeft.Down:=true;
      taRightJustify: SpeedButtonRight.Down:=true;
      taCenter: SpeedButtonCenter.Down:=true;
    end;
    SpeedButtonBullets.Down:=Numbering=nsBullet;
    if ShowModal<>idCancel then begin
      if (RichEdit is TEtvDBRichEdit) then
        TEtvDBRichEdit(RichEdit).BeginEditing;
      FirstIndent:=SpinEditFirst.Value;
      LeftIndent:=SpinEditLeft.Value;
      RightIndent:=SpinEditRight.Value;
      if SpeedButtonLeft.Down then Alignment:=taLeftJustify
      else if SpeedButtonRight.Down then Alignment:=taRightJustify
      else Alignment:=taCenter;
      if SpeedButtonBullets.Down then
        Numbering:=nsBullet
      else Numbering:=nsNone;
      Result:=true;
    end;
  end;
end;

procedure TDialParagraph.FormCreate(Sender: TObject);
begin
  Caption:=sParagraphName;
  LabelFirst.Caption:=sParagraphFirstIndent;
  LabelLeft.Caption:=sParagraphLeftIndent;
  LabelRight.Caption:=sParagraphRightIndent;
  SpeedButtonLeft.Hint:=sParagraphLeftAlignmentHint;
  SpeedButtonCenter.Hint:=sParagraphCenterAlignmentHint;
  SpeedButtonRight.Hint:=sParagraphRightAlignmentHint;
  SpeedButtonBullets.Hint:=sParagraphBulletHint;
end;

end.
