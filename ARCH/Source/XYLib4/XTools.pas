{$I XLib.inc }
Unit XTools;

Interface

Uses Classes, Controls, WinTypes, Forms, ExtCtrls;

Const tcDefaultClass ='tcDefault';

type

{ TXToolForm }

  TXToolClass = class of TXToolForm;

  TXToolForm = class(TForm)
  private
    Moving   : Boolean;
    FHorizontal: Boolean;
    FIsLinkVisible: Boolean;
    {Mouse support}
    OldX,
    OldY,
    OldLeft,
    OldTop   : Integer;
    ScreenDC : HDC;
    MoveRect : TRect;
    { Current  TFormControl }
    FCurrentControl: TComponent;
    FMainPanel: TPanel;
    procedure MouseDowni(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    procedure MouseMovei(Sender: TObject; Shift: TShiftState; X,
              Y: Integer);
    procedure MouseUpi(Sender: TObject; Button: TMouseButton;
              Shift: TShiftState; X, Y: Integer);
    procedure MainPanelDblClick(Sender: TObject);
    procedure MainPanelSetName(Reader: TReader; Component: TComponent;
                              var Name: string);
    procedure SetBorderStyle(AStyle:TFormBorderStyle);
    procedure ReadState(Reader: TReader); override;
  protected
    procedure Activate; override;
    procedure Deactivate; override;
    procedure FormCreate(Sender: TObject);
  public
    isDouble: Boolean;
    IsBtnClick: Boolean;
    constructor Create(AOwner: TComponent); override;
    procedure SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);virtual;
    procedure ChangeHint(ATag: Integer; AHint: String); virtual;
    procedure SubClick(Sender: TObject);
    procedure SubExit;
    procedure SubClose;
    procedure ReturnSubClose;
    procedure ReturnSubOpen;
    procedure SubSetFocus;
    property Horizontal: Boolean read FHorizontal write FHorizontal;
    property IsLinkVisible: Boolean read FIsLinkVisible write FIsLinkVisible;
    property CurrentFormControl: TComponent read FCurrentControl write FCurrentControl;
  end;
{ TXToolForm }

Implementation

Uses XTFC, LnkSet;

{ TXToolForm }

Constructor TXToolForm.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  isDouble:=False;
  FHorizontal:=False;
  Moving:=False;
end;

Procedure TXToolForm.FormCreate(Sender: TObject);
begin
{  Width:=MainPanel.Width+5;
  Height:=MainPanel.Height;}
end;

Procedure TXToolForm.MainPanelSetName(Reader: TReader; Component: TComponent; var Name: string);
begin
  if Name='MainPanel' then FMainPanel:=TPanel(Component);
end;

Procedure TXToolForm.ReadState(Reader: TReader);
var SavSetName: TSetNameEvent;
begin
  SavSetName:=Reader.OnSetName;
  Reader.OnSetName:=MainPanelSetName;
  FMainPanel:=nil;
  Inherited ReadState(Reader);
  Reader.OnSetName:=SavSetName;
  if Assigned(FMainPanel) then begin
    OnMouseUp:=MouseUpi;
    with FMainPanel do begin
      OnMouseUp:=MouseUpi;
      OnMouseDown:=MouseDowni;
      OnMouseMove:=MouseMovei;
      OnDblClick:=MainPanelDblClick;
    end;
    SetBorderStyle(BorderStyle);
  end;
  Left:=574;
  Top:=60;
end;

Procedure TXToolForm.SetBorderStyle(AStyle:TFormBorderStyle);
var
{  DeltaTop,
  DeltaLeft,}
  TitleHeight,
  BorderWidth,
  BorderHeight : Integer;
begin
  TitleHeight := GetSystemMetrics(SM_CYCAPTION);
  BorderWidth := GetSystemMetrics(SM_CXBORDER)+GetSystemMetrics(SM_CXFRAME)-1;
  BorderHeight := GetSystemMetrics(SM_CYBORDER)+GetSystemMetrics(SM_CYFRAME)-2;
  BorderStyle:=AStyle;
  if AStyle <> bsNone then begin
    Top := Top-TitleHeight-BorderHeight;
    Height := Height+TitleHeight+2*BorderHeight;
    Left := Left-BorderWidth;
    Width := Width+2*BorderWidth;
  end else begin
{    MainPanel.BorderStyle:=bsSingle;}
{    DeltaTop:=MainPanel.Top;
    DeltaLeft:=MainPanel.Left;
    }
    Top := Top+TitleHeight+BorderHeight+FMainPanel.Top;
    FMainPanel.Top:=0;
    Height := FMainPanel.Height;
    {Для всей формы Height:=Height-TitleHeight-2*BorderHeight;}
    Left := Left+BorderWidth+FMainPanel.Left;
    FMainPanel.Left:=0;
    Width := FMainPanel.Width;
    {Для всей формы Width:=Width-2*BorderWidth };
  end;
end;

Procedure TXToolForm.Activate;
begin
  FIsLinkVisible:=True;
  Inherited Activate;
end;

Procedure TXToolForm.Deactivate;
begin
  Inherited Deactivate;
end;

Procedure TXToolForm.MouseUpi(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

Procedure Transp(Control: TWinControl);
var i: Integer;
    D: Integer;
    C: TControl;
begin
  with Control do begin
    D:=Width;
    Width:=Height;
    Height:=D;
    D:=Left;
    Left:=Top;
    Top:=D;
    if TControl(Control) is TWinControl then
      for i:=0 to ControlCount-1 do begin
        C:=Controls[i];
        Transp(TWinControl(C));
      end;
  end;
end;

var i,j: Integer;

begin
  if isDouble then begin
    isDouble:=False;
    if Moving then begin
      DrawFocusRect(ScreenDC,MoveRect);
      ReleaseCapture;
      ReleaseDC(0,ScreenDC);
      Moving:=False;
    end;
    Visible:=False;
    if FHorizontal then begin
      with FMainPanel do begin
        Height:=Height-4;
        j:=Height;
        Height:=2*Height;
        Width:=Width div 2;
        for i:=0 to ControlCount-1 do
          with Controls[i] do
            if Left>=FMainPanel.Width then begin
              Top:=j+Top-4;
              Left:=Left-FMainPanel.Width;
            end;
      end;
      Height:=FMainPanel.Height;
      Width:=FMainPanel.Width;
      Transp(Self);
{     Left:=574; Top:=60;}
      if Assigned(TFormControl(FCurrentControl).Form) then begin
        Left:=TFormControl(FCurrentControl).Form.Left+TFormControl(FCurrentControl).Form.Width-5;
        Top:=TFormControl(FCurrentControl).Form.Top;
      end;
    end else begin
      Transp(Self);
      with FMainPanel do begin
        Height:=Height div 2;
        j:=Width;
        Width:=2*Width;
        for i:=0 to ControlCount-1 do
          with Controls[i] do
            if Top>=FMainPanel.Height-2 then begin
              Top:=Top-FMainPanel.Height+4;
              Left:=j+Left;
            end;
        Height:=Height+4;
      end;
      Height:=FMainPanel.Height;
      Width:=FMainPanel.Width;
      Top:=0; Left:=0;
    end;
    Visible:=True;
    FHorizontal:=not FHorizontal;
    if Assigned(TFormControl(FCurrentControl).Form) then TFormControl(FCurrentControl).Form.SetFocus;
    Exit;
  end;
  if Button = mbLeft then begin
    ReleaseCapture;
    DrawFocusRect(ScreenDC,MoveRect);
    Left:=Left+X-OldLeft;
    Top:=Top+Y-OldTop;
    ReleaseDC(0,ScreenDC);
    Moving:=False;
  end;
  if Assigned(TFormControl(FCurrentControl).Form) then TFormControl(FCurrentControl).Form.SetFocus;
end;

Procedure TXToolForm.MouseMovei(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if isDouble then Exit;
  if Moving then begin
    DrawFocusRect(ScreenDC,MoveRect);
    OldX := X;
    OldY := Y;
    MoveRect := Rect(Left+OldX-OldLeft,Top+OldY-OldTop,
                     Left+Width+OldX-OldLeft,Top+Height+OldY-OldTop);
    DrawFocusRect(ScreenDC,MoveRect);
  end;
end;

Procedure TXToolForm.MouseDowni(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then begin
    SetCapture(FMainPanel.Handle);
    ScreenDC := GetDC(0);
    OldX := X;
    OldY := Y;
    OldLeft := X;
    OldTop := Y;
    MoveRect := BoundsRect;
    DrawFocusRect(ScreenDC,MoveRect);
    Moving := True;
  end;
end;

Procedure TXToolForm.MainPanelDblClick(Sender: TObject);
begin
  isDouble:=True;
end;

Procedure TXToolForm.SubClick(Sender: TObject);
{var TSB: TSpeedButton;}
begin
  if Assigned(TFormControl(FCurrentControl).Form) then
     TToolsControl(Owner).SubClick(Sender);
{  IsBtnClick:=true;
  TSB:=TSpeedButton(Sender);
  if (CurControl.Tag<>-1) or (TSB.Tag=0) then
      TFormControl(FCurrentControl).FTools.FBtnSender:=TSB
     else if (TSB.Name='TempBtn') or (TSB.Name='FilterBtn') then
          TSB.Down:=not TSB.Down;
  CurControl.SetFocus;}
end;

Procedure TXToolForm.ChangeHint(ATag: Integer; AHint: String);
begin
end;

Procedure TXToolForm.SubExit;
begin
  Application.MainForm.Close;
end;

Procedure TXToolForm.SubClose;
begin
  if Assigned(TFormControl(FCurrentControl).Form) then begin
    TFormControl(FCurrentControl).Form.Close;
{     Hide;}
  end;
end;

Procedure TXToolForm.ReturnSubClose;
begin
  if Assigned(FCurrentControl) then TFormControl(FCurrentControl).ReturnSubClose;
end;

Procedure TXToolForm.ReturnSubOpen;
begin
  if Assigned(TFormControl(FCurrentControl).Form) then
    with TFormControl(FCurrentControl) do begin
      if Assigned(OpenReturnControl) then OpenReturnControl.ReturnExecute;
    end;
end;

Procedure  TXToolForm.SubSetFocus;
begin
  if Assigned(TFormControl(FCurrentControl).Form) then TFormControl(FCurrentControl).Form.SetFocus;
end;

Procedure TXToolForm.SetConfigParams(IsReturnClose, IsReturnOpen: Boolean);
begin
end;

end.
