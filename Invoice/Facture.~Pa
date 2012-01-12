unit Facture;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, XMisc, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, Mask, EtvContr, XCtrls,
  RXCtrls, ToolEdit, RXDBCtrl, EtvLook, EtvRXCtl;

type
  TFormFacture = class(TBBEForm)
    XEDbGrid1: TXEDbGrid;
    Panel1: TPanel;
    XLabel1: TXLabel;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    XDBLabel1: TXDBLabel;
    EditNumFacture: TXEDBEdit;
    EditsDate: TXEDBDateEdit;
    EditClientName: TXEDBLookupCombo;
    CalcServiceButton: TRxSpeedButton;
    XLabel5: TXLabel;
    DBTextClientINN: TEtvDBText;
    DBTextClientAddress: TEtvDBText;
    XLabel6: TXLabel;
    EditClientStr: TXEDBEdit;
    XLabel7: TXLabel;
    XLabel8: TXLabel;
    DBTextSumma: TEtvDBText;
    XLabel9: TXLabel;
    DBTextSummaVAT: TEtvDBText;
    EtvDBText1: TEtvDBText;
    EtvDBText2: TEtvDBText;
    XEDBLookupCombo1: TXEDBLookupCombo;
    XLabel10: TXLabel;
    XLabel11: TXLabel;
    XLabel12: TXLabel;
    EtvDBText3: TEtvDBText;
    XLabel13: TXLabel;
    EtvDBText4: TEtvDBText;
    EtvDBText5: TEtvDBText;
    EtvDBText6: TEtvDBText;
    XLabel14: TXLabel;
    EtvDBText7: TEtvDBText;
    XLabel15: TXLabel;
    procedure CalcServiceButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormFacture: TFormFacture;

implementation
uses MdInvc;
{$R *.DFM}

procedure TFormFacture.CalcServiceButtonClick(Sender: TObject);
begin
  inherited;
  with ModuleInvoice.RepFacture do begin
    Template.LoadFromFile;
    Print;
  end;
end;

procedure TFormFacture.FormCreate(Sender: TObject);
var TheRect: TRect;
begin
(*
  inherited;
  EtvDBText8.ControlStyle:=EtvDBText8.ControlStyle+[csFramed];
  with EtvDBText8 do begin
    ControlStyle:=ControlStyle+[csFramed];
    {Brush.Style:=bsSolid;}
    TheRect := Rect(0,0,Width,Height);
    {Canvas.Brush.Color := clBlack;}
    Canvas.Brush.Color := clTeal;
    Canvas.Pen.Color := clBlack;
    Canvas.PenPos:=Point(0,10);
    Canvas.LineTo(100,10);
*)    
(*
    Canvas.Polygon([Point(-1,-1), Point(-1,Height+2),
      Point(Width+2,Height+2),Point(Width+2,-1)]);
*)
    {Canvas.FrameRect(TheRect)}


(*
     := CreateSolidBrush(ColorToRGB(clBtnShadow));
    FrameRect(DC, Rect(Left - 1, Top - 1, Left + Width, Top + Height),FrameBrush);
    DeleteObject(FrameBrush);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnHighlight));
    FrameRect(DC, Rect(Left, Top, Left + Width + 1, Top + Height + 1),FrameBrush);
    DeleteObject(FrameBrush);
  end;
*)    
  {EtvDBText7.Color:=clWhite;}
end;

Initialization
  RegisterAliasXForm('FormFacture', TFormFacture);
Finalization
  UnRegisterXForm(TFormFacture);
end.
