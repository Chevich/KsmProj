{******************************************************************************}
{                                                                              }
{                   ReportBuilder Report Component Library                     }
{                                                                              }
{             Copyright (c) 1996-1998 Digital Metaphors Corporation            }
{                                                                              }
{******************************************************************************}

Unit XPrevDlg;

Interface

Uses

{$IFDEF WIN32}
  Windows, ComCtrls,
{$ELSE}
  WinTypes, WinProcs,
{$ENDIF}


  SysUtils, Messages, Classes, Graphics, Controls, Forms, ExtCtrls, StdCtrls, Mask, Buttons,
  ppForms, ppTypes, ppProd, ppDevice, ppViewr, Dialogs;

type
  TXPrintPreview = class(TppCustomPreviewer)
    pnlPreviewBar: TPanel;
    spbPreviewPrint: TSpeedButton;
    spbPreviewWhole: TSpeedButton;
    spbPreviewFirst: TSpeedButton;
    spbPreviewPrior: TSpeedButton;
    spbPreviewNext: TSpeedButton;
    spbPreviewLast: TSpeedButton;
    mskPreviewPage: TMaskEdit;
    spbPreviewWidth: TSpeedButton;
    spbPreview100Percent: TSpeedButton;
    spbPreviewClose: TSpeedButton;
    Bevel1: TBevel;
    ppViewer1: TppViewer;
    mskPreviewPercentage: TMaskEdit;
    procedure spbPreviewPrintClick(Sender: TObject);
    procedure spbPreviewWholeClick(Sender: TObject);
    procedure spbPreviewFirstClick(Sender: TObject);
    procedure spbPreviewPriorClick(Sender: TObject);
    procedure spbPreviewNextClick(Sender: TObject);
    procedure spbPreviewLastClick(Sender: TObject);
    procedure mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewerPageChange(Sender: TObject);
    procedure ppViewerStatusChange(Sender: TObject);
    procedure spbPreviewWidthClick(Sender: TObject);
    procedure spbPreview100PercentClick(Sender: TObject);
    procedure spbPreviewCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
    procedure ppViewer1PrintStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlPreviewBarClick(Sender: TObject);
  private
    FStatusBar: TStatusBar;
  protected
    {overriden from TppForm}
    procedure Activate; override;
    procedure LanguageChanged; override;
    procedure ReportAssigned; override;
    function  GetViewer: TObject; override;

  public

  end;
{ TXPrintPreview }

var XPrintPreview: TXPrintPreview;

Implementation

{$R *.DFM}

Uses XReports;

{ TppPrintPreview }

Procedure TXPrintPreview.FormCreate(Sender: TObject);
begin
  FStatusBar := TStatusBar.Create(Self);
  FStatusBar.Parent := Self;
  FStatusBar.SimplePanel := True;
  FStatusBar.Align  := alBottom;
  WindowState := wsMaximized;
  TppViewer(Viewer).ZoomSetting :=zsPageWidth;
  if (Owner is TXDBReport) and Assigned(TXDBReport(Owner).PrintLink) then
    with TXDBReport(Owner).PrintLink do begin
      if ZoomView>0 then begin
{       TppViewer(Viewer).ZoomSetting :=zsPercentage;}
        ppViewer1.ZoomPercentage := ZoomView;
      end;
    end;
end;

Procedure TXPrintPreview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

Procedure TXPrintPreview.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then spbPreviewCloseClick(Sender);
  with ppViewer1 do
    if not(ssCtrl in Shift) then begin
      if Assigned(ppViewer1.ScrollBox.VertScrollBar) then
        with ScrollBox.VertScrollBar do
          case Key of
            { Вниз }
            VK_Down:  Position:=Position+7;
            VK_Next:  NextPage;
            VK_End:   Position:=Range;
            { Вверх }
            VK_Up:    Position:=Position-7;
            VK_Prior: PriorPage;
            VK_Home:  Position:=0;
          end;

      if Assigned(ppViewer1.ScrollBox.HorzScrollBar) then
        with ScrollBox.HorzScrollBar do
          case Key of
            { Вправо }
            VK_Right: Position:=Position+7;
            { Влево }
            VK_Left:  Position:=Position-7;
          end;
    end else
      case Key of
        VK_Down:
          with ScrollBox.VertScrollBar do begin
            if Position<Range-ScrollBox.ClientHeight then begin
              {ScrollBox.Hide;}
              {ScrollBox.AutoScroll:=false;}
              {ScrollBox.VertScrollBar.Visible:=false;}
              {ScrollBox.ScrollBy(0,-ClientHeight);}
              {ScrollBox.VertScrollBar.Visible:=true;}
              Position:=Position+ScrollBox.ClientHeight;
              {SetScrollPos(ScrollBox.Handle,SB_VERT,Position+ClientHeight,True);}
              {ScrollBox.Invalidate;}
            end else begin
              NextPage;
              Position:=0;
            end;
          end;
        VK_Up:
          with ScrollBox.VertScrollBar do begin
            if Position>0 then Position:=Position-ScrollBox.ClientHeight
            else
              if AbsolutePageNo>1 then begin
                PriorPage;
                Position:=Range-ScrollBox.ClientHeight;
              end;
          end;
        VK_Left: ScrollBox.HorzScrollBar.Position:=
                   ScrollBox.HorzScrollBar.Position-ScrollBox.ClientWidth;
        VK_Right:ScrollBox.HorzScrollBar.Position:=
                   ScrollBox.HorzScrollBar.Position+ScrollBox.ClientWidth;
        VK_Home:  FirstPage;
        VK_End:   LastPage;
      end;
end;

Procedure TXPrintPreview.ReportAssigned;
begin
  if Report is TppProducer then ppViewer1.Report := TppProducer(Report);
end;

Procedure TXPrintPreview.Activate;
begin
  Inherited Activate;
  spbPreviewWhole.Down:=(ppViewer1.ZoomSetting=zsWholePage);
  spbPreviewWidth.Down:=(ppViewer1.ZoomSetting=zsPageWidth);
  spbPreview100Percent.Down := (ppViewer1.ZoomSetting=zs100Percent);
end;

{ Разобраться попозже с языком }
Procedure TXPrintPreview.LanguageChanged;
var lBitMap: TBitMap;
begin
  {
  spbPreviewPrint.Hint:=LoadStr(LanguageIndex + ppMsgPrint);
  spbPreviewWhole.Hint:=LoadStr(LanguageIndex + ppMsgWhole);
  spbPreviewWidth.Hint:=LoadStr(LanguageIndex + ppMsgPageWidth);
  spbPreview100Percent.Hint:=LoadStr(LanguageIndex + ppMsg100Percent);
  spbPreviewFirst.Hint:=LoadStr(LanguageIndex + ppMsgFirst);
  spbPreviewPrior.Hint:=LoadStr(LanguageIndex + ppMsgPrior);
  spbPreviewNext.Hint:=LoadStr(LanguageIndex + ppMsgNext);
  spbPreviewLast.Hint:=LoadStr(LanguageIndex + ppMsgLast);
  }
  {spbPreviewClose.Caption:=LoadStr(LanguageIndex + ppMsgClose);}

  spbPreviewClose.Caption:='Закрыть';
  {
  lBitMap:=TBitMap.Create;
  spbPreviewClose.Width:=lBitMap.Canvas.TextWidth(spbPreviewClose.Caption) + 30;
  lBitMap.Free;
  Caption:=LoadStr(LanguageIndex + ppMsgPrintPreview);
  }
end;

Function TXPrintPreview.GetViewer: TObject;
begin
  Result := ppViewer1;
end;

Procedure TXPrintPreview.ppViewer1PrintStateChange(Sender: TObject);
var lPosition: TPoint;
begin
  if ppViewer1.Busy then begin
    mskPreviewPercentage.Enabled:=False;
    mskPreviewPage.Enabled:=False;
    pnlPreviewBar.Cursor:=crHourGlass;
    ppViewer1.PaintBox.Cursor:=crHourGlass;
    FStatusbar.Cursor := crHourGlass;
    spbPreviewClose.Cursor := crArrow;
    spbPreviewClose.Caption := LoadStr(LanguageIndex + ppMsgCancel);
  end else begin
    mskPreviewPercentage.Enabled := True;
    mskPreviewPage.Enabled := True;
    pnlPreviewBar.Cursor := crDefault;
    ppViewer1.PaintBox.Cursor := crDefault;
    FStatusbar.Cursor := crDefault;
    spbPreviewClose.Cursor := crDefault;
    spbPreviewClose.Caption := LoadStr(LanguageIndex + ppMsgClose);
  end;
  {this code will force the cursor to update}
  GetCursorPos(lPosition);
  SetCursorPos(lPosition.X, lPosition.Y);
end;

Procedure TXPrintPreview.spbPreviewCloseClick(Sender: TObject);
begin
  if TppProducer(Report).Printing then ppViewer1.Cancel
  else Close;
end;

Procedure TXPrintPreview.ppViewerStatusChange(Sender: TObject);
begin
{$IFDEF WIN32}
  FStatusbar.SimpleText := ppViewer1.Status;
{$ELSE}
  FStatusbar.Caption := ppViewer1.Status;
{$ENDIF}
end;

Procedure TXPrintPreview.ppViewerPageChange(Sender: TObject);
begin
  mskPreviewPage.Text:=IntToStr(ppViewer1.AbsolutePageNo);
  mskPreviewPercentage.Text:=IntToStr(ppViewer1.CalculatedZoom);
end;

Procedure TXPrintPreview.spbPreviewPrintClick(Sender: TObject);
begin
  ppViewer1.Print;
end;

Procedure TXPrintPreview.spbPreviewFirstClick(Sender: TObject);
begin
  ppViewer1.FirstPage;
end;

Procedure TXPrintPreview.spbPreviewPriorClick(Sender: TObject);
begin
  ppViewer1.PriorPage;
end;

Procedure TXPrintPreview.spbPreviewNextClick(Sender: TObject);
begin
  ppViewer1.NextPage;
end;

Procedure TXPrintPreview.spbPreviewLastClick(Sender: TObject);
begin
  ppViewer1.LastPage;
end;

Procedure TXPrintPreview.mskPreviewPageKeyPress(Sender: TObject; var Key: Char);
var
  liPage: Longint;
begin
  if (Key = #13) then begin
    liPage:=StrToInt(mskPreviewPage.Text);
    ppViewer1.GotoPage(liPage);
  end; {if, carriage return pressed}
end;

Procedure TXPrintPreview.spbPreviewWholeClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsWholePage;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  {pnlPreviewBar.SetFocus;}
end;

Procedure TXPrintPreview.spbPreviewWidthClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zsPageWidth;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  {pnlPreviewBar.SetFocus;}
end;

Procedure TXPrintPreview.spbPreview100PercentClick(Sender: TObject);
begin
  ppViewer1.ZoomSetting := zs100Percent;
  mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  {pnlPreviewBar.SetFocus;}
end;

Procedure TXPrintPreview.mskPreviewPercentageKeyPress(Sender: TObject; var Key: Char);
var liPercentage: Integer;
begin
  if (Key = #13) then begin
    liPercentage:=StrToIntDef(mskPreviewPercentage.Text, 100);
    ppViewer1.ZoomPercentage:=liPercentage;
    spbPreviewWhole.Down:=False;
    spbPreviewWidth.Down:=False;
    spbPreview100Percent.Down:=False;
    mskPreviewPercentage.Text := IntToStr(ppViewer1.CalculatedZoom);
  end; {if, carriage return pressed}
end;

{
Initialization
  ppRegisterForm(TppCustomPreviewer, TXPrintPreview);}

Procedure TXPrintPreview.pnlPreviewBarClick(Sender: TObject);
begin
  ActiveControl:=nil;
end;

end.
