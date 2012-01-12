Unit XPDlg;

Interface

Uses Windows, ComCtrls, Classes, SysUtils, Graphics, Forms, Controls, Buttons,
     StdCtrls, ExtCtrls, Spin, Dialogs, Mask, Printers,
     ppTypes, ppUtils, ppForms, ppProd, ppPrintr, XTxtPrn, DB, XReports;

Type
  TXPrintDialog = class(TppCustomPrintDialog)
    btnOK: TButton;
    btnCancel: TButton;
    SaveDialog1: TSaveDialog;
    tbnDevice: TPageControl;
    lblPrintToFile: TLabel;
    cbxPrintToFile: TCheckBox;
    btnFile: TButton;
    pnlFileDevice: TPanel;
    rdbTextFile: TRadioButton;
    rdbArchiveFile: TRadioButton;
    bvlFileSettings: TBevel;
    lblFileDesc: TLabel;
    lblFileSettings: TLabel;
    lblPrinterDesc: TLabel;
    lblCopies: TLabel;
    edtCopies: TEdit;
    spnCopies: TSpinButton;
    CommonPage: TTabSheet;
    FilePage: TTabSheet;
    Label14: TLabel;
    SpeedButton4: TSpeedButton;
    PagesPanel: TPanel;
    lblPageRange: TLabel;
    rdbAll: TRadioButton;
    rdbCurrentPage: TRadioButton;
    rdbPages: TRadioButton;
    edtPages: TEdit;
    lblDescription: TLabel;
    cbxFFPage: TCheckBox;
    procedure btnPrinterClick(Sender: TObject);
    procedure spnCopiesDownClick(Sender: TObject);
    procedure spnCopiesUpClick(Sender: TObject);
    procedure rdbAllClick(Sender: TObject);
    procedure rdbCurrentPageClick(Sender: TObject);
    procedure rdbPagesClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtCopiesExit(Sender: TObject);
    procedure edtPagesClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure cbxPrintToFileClick(Sender: TObject);
    procedure lblPrintToFileClick(Sender: TObject);
    procedure rdbTextFileClick(Sender: TObject);
    procedure rdbArchiveFileClick(Sender: TObject);

  private
    FppPrinter: TppPrinter;
    FTextPrinter: TXTextPrinter;
    FReportParams: TPrintLink;
    procedure AdjustPositions;
    procedure UpdateFileSettings;
  protected
    procedure Activate; override;
    procedure LanguageChanged; override;
  public
    property ReportParams: TPrintLink read FReportParams write FReportParams;
  end;
{ TXPrintDialog }

var XPrintDialog: TXPrintDialog;
    IsCommonPrintSetup: Boolean = False;

Implementation

{$R *.DFM}

Procedure TXPrintDialog.Activate;
var
  liSpacer: Integer;
begin
  Inherited Activate;
  if (Printer=nil) then Exit;
  if Printer is TppPrinter then begin
    FppPrinter:=TppPrinter(Printer);
    FTextPrinter:=nil;
    tbnDevice.ActivePage:=tbnDevice.Pages[0];
    {copy controls from property values}
    edtCopies.Text:=IntToStr(FppPrinter.PrinterSetup.Copies);
    lblPrinterDesc.Caption:={LoadStr(LanguageIndex + ppMsgPrinter)}'Принтер'
                             + '   ' + FppPrinter.PrinterDescription;
    {print to file settings}
    if (Report<>nil) and (Report is TppProducer) and (TppProducer(Report).Device=dvArchive) then
      rdbArchiveFile.Checked:=True
    else rdbTextFile.Checked:=True;
    if rdbTextFile.Checked and not(AllowPrintToFile) then
      rdbArchiveFile.Checked:=AllowPrintToArchive
    else if rdbArchiveFile.Checked and not(AllowPrintToArchive) then
      rdbTextFile.Checked:=AllowPrintToFile;
    UpdateFileSettings;
    if not(AllowPrintToArchive and AllowPrintToFile) then begin
      pnlFileDevice.Visible:=False;
      bvlFileSettings.Height:=bvlFileSettings.Height - pnlFileDevice.Height;
    end;
    {hide file tab, if print to file disallowed}
    if not(AllowPrintToFile) and not(AllowPrintToArchive) then begin
      FilePage.TabVisible:=False;
{     btnOK.Left := btnPrinter.Left;
      btnCancel.Left := btnPrinter.Left;
      liSpacer := Round(0.15625 * Screen.PixelsPerInch);
      btnCancel.Top := btnPrinter.Top - liSpacer - btnCancel.Height;
      btnOK.Top := btnCancel.Top - btnCancel.Height - 2;}
    end;
  end else if Printer is TXTextPrinter then begin
    FppPrinter:=nil;
    FTextPrinter:=TXTextPrinter(Printer);
    tbnDevice.ActivePage:=tbnDevice.Pages[0];
    {copy controls from property values}
    edtCopies.Text:=IntToStr(FTextPrinter.PrinterSetup.Copies);
    lblPrinterDesc.Caption:={LoadStr(LanguageIndex + ppMsgPrinter)}'Принтер'
                            + '   ' + FTextPrinter.PrinterDescription;
    {print to file settings}
    if (Report<>nil) and (Report is TppProducer) and (TppProducer(Report).Device = dvArchive) then
      rdbArchiveFile.Checked:=True
    else rdbTextFile.Checked:=True;
    if rdbTextFile.Checked and not(AllowPrintToFile) then
      rdbArchiveFile.Checked:=AllowPrintToArchive
    else if rdbArchiveFile.Checked and not(AllowPrintToArchive) then
      rdbTextFile.Checked:=AllowPrintToFile;
    UpdateFileSettings;
    if not(AllowPrintToArchive and AllowPrintToFile) then begin
      pnlFileDevice.Visible:=False;
      bvlFileSettings.Height:=bvlFileSettings.Height - pnlFileDevice.Height;
    end;
    {hide file tab, if print to file disallowed}
    if not(AllowPrintToFile) and not(AllowPrintToArchive) then begin
      FilePage.TabVisible:=False;
{     btnOK.Left := btnPrinter.Left;
      btnCancel.Left := btnPrinter.Left;
      liSpacer := Round(0.15625 * Screen.PixelsPerInch);
      btnCancel.Top := btnPrinter.Top - liSpacer - btnCancel.Height;
      btnOK.Top := btnCancel.Top - btnCancel.Height - 2;}
    end;
  end else Exit;
end;

Procedure TXPrintDialog.btnOKClick(Sender: TObject);
begin
  if IsCommonPrintSetup then begin
    ModalResult:= mrYes;
    Exit;
  end;
  {set page list}
  if rdbPages.Checked then begin
    ppTextToPageList(edtPages.Text, PageList, False);
    if (PageList.Count > 0) then begin
      ModalResult:=mrOK;
      PageSetting:=psPageList;
    end else
      {message: 'No pages entered.'}
      ShowMessage(LoadStr(LanguageIndex + 32));
  end else
    if ((AllowPrintToFile) or (AllowPrintToArchive)) and (cbxPrintToFile.Checked) and
    (SaveDialog1.FileName = '') then
    {message: 'Please specify file name before continuing.'}
    ShowMessage(LoadStr(LanguageIndex + 33))
  else ModalResult:=mrOK;
  {set property values based on controls}
  if (ModalResult=mrOK) then begin
    if rdbCurrentPage.Checked then PageSetting := psSinglePage;
    if Assigned(FppPrinter) then FppPrinter.PrinterSetup.Copies:=StrToInt(edtCopies.Text);
    if Assigned(FTextPrinter) then with FTExtPrinter do begin
{Lev. Копии не устанавливались, пока не завел событие при TXTextPrinter.Create PrinterSetupChangeEvent}
      {SetDevModeCopies(StrToInt(edtCopies.Text));}
      PrinterSetup.Copies:=StrToInt(edtCopies.Text);
      { Прогон страницы, если установлено }
      if (cbxFFPage.Checked) and (Pos(#12,DoneLine)=0) then DoneLine:=DoneLine+#12;
    end;
    if (AllowPrintToFile) or (AllowPrintToArchive) then begin
      if (cbxPrintToFile.Checked) and (SaveDialog1.FileName <> '') then begin
        PrintToFile:=rdbTextFile.Checked;
        PrintToArchive:=rdbArchiveFile.Checked;
      end else begin
        PrintToFile := False;
        PrintToArchive := False;
      end;
    end;
    if not PrintToFile and not PrintToArchive and
    (Assigned(FppPrinter) and (FppPrinter.DC = 0)
    {or({and Assigned(FTextPrinter)or(FTextPrinter.IC=0))}) then begin
      {message: Windows cannot print due to a problem with the current printer setup.}
      MessageDlg(LoadStr(LanguageIndex + 459), mtWarning, [mbOK], 0);
      ModalResult := 0;
    end;
  end;
end;

Procedure TXPrintDialog.btnPrinterClick(Sender: TObject);
begin
  if Assigned(FppPrinter) then begin
    if FppPrinter.ShowSetupDialog then begin
         {get name of printer}
      lblPrinterDesc.Caption:={LoadStr(LanguageIndex + ppMsgPrinter)}'Принтер'
                                + '   ' + FppPrinter.PrinterDescription;
      PrinterChanged := True;
    end;
  end else if Assigned(FTextPrinter) then begin
    if FTextPrinter.ShowSetupDialog then begin
      {get name of printer}
      lblPrinterDesc.Caption:={LoadStr(LanguageIndex + ppMsgPrinter)}'Принтер'
                              + '   ' + FTextPrinter.PrinterDescription;
      PrinterChanged := True;
    end;
  end;
end;

Procedure TXPrintDialog.lblPrintToFileClick(Sender: TObject);
begin
  cbxPrintToFile.Checked:=not(cbxPrintToFile.Checked);
  UpdateFileSettings;
end;

Procedure TXPrintDialog.cbxPrintToFileClick(Sender: TObject);
begin
  UpdateFileSettings;
end;

Procedure TXPrintDialog.btnFileClick(Sender: TObject);
begin
  SaveDialog1.Execute;
  if rdbTextFile.Checked then TextFileName:=SaveDialog1.FileName
  else if rdbArchiveFile.Checked then ArchiveFileName := SaveDialog1.FileName;
  UpdateFileSettings;
end;

Procedure TXPrintDialog.edtCopiesExit(Sender: TObject);
begin
  edtCopies.Text:=IntToStr(StrToIntDef(edtCopies.Text,1));
end;

Procedure TXPrintDialog.spnCopiesDownClick(Sender: TObject);
begin
  if edtCopies.Text<>'1' then edtCopies.Text:=IntToStr(StrToIntDef(edtCopies.Text,1)-1);
end;

Procedure TXPrintDialog.spnCopiesUpClick(Sender: TObject);
begin
  if edtCopies.Text<>'999' then edtCopies.Text:=IntToStr(StrToIntDef(edtCopies.Text, 1)+1);
end;

Procedure TXPrintDialog.rdbAllClick(Sender: TObject);
begin
  rdbCurrentPage.Checked:=False;
  rdbPages.Checked:=False;
  edtPages.Text:='';
end;

Procedure TXPrintDialog.edtPagesClick(Sender: TObject);
begin
  rdbCurrentPage.Checked:=False;
  rdbAll.Checked:=False;
  rdbPages.Checked:=True;
end;

Procedure TXPrintDialog.rdbCurrentPageClick(Sender: TObject);
begin
  rdbAll.Checked:=False;
  rdbPages.Checked:=False;
  edtPages.Text:='';
end;

Procedure TXPrintDialog.rdbPagesClick(Sender: TObject);
begin
  rdbAll.Checked:=False;
  rdbCurrentPage.Checked:=False;
end;

Procedure TXPrintDialog.LanguageChanged;
begin
{!
  lblCopies.Caption :=  LoadStr(LanguageIndex + ppMsgCopies);
  lblPageRange.Caption :=  LoadStr(LanguageIndex + ppMsgPageRange);
  rdbAll.Caption :=  LoadStr(LanguageIndex + ppMsgAll);
  rdbCurrentPage.Caption :=  LoadStr(LanguageIndex + ppMsgCurrentPage);
  rdbPages.Caption := LoadStr(LanguageIndex + ppMsgPages);
  lblDescription.Caption := LoadStr(LanguageIndex + ppMsgEnterPage);
  btnPrinter.Caption :=  LoadStr(LanguageIndex + ppMsgPrinter);
  btnOK.Caption := LoadStr(LanguageIndex + ppMsgOK);
  btnCancel.Caption := LoadStr(LanguageIndex + ppMsgCancel);
  btnFile.Caption :=  LoadStr(LanguageIndex + ppMsgFile);
  tbnDevice.Pages[0] := LoadStr(LanguageIndex + ppMsgPrinter);
  tbnDevice.Pages[1] := LoadStr(LanguageIndex + ppMsgFile);
  Caption := LoadStr(LanguageIndex + ppMsgPrint);
  lblFileSettings.Caption := LoadStr(LanguageIndex + ppMsgSettings);
  rdbTextFile.Caption := LoadStr(LanguageIndex + ppMsgTextFile);
  rdbArchiveFile.Caption := LoadStr(LanguageIndex + ppMsgArchiveFile);}
  AdjustPositions;
end;

Procedure TXPrintDialog.AdjustPositions;
var liBottomSpacer: Integer;
begin
{  liBottomSpacer := Trunc(ppFromMMThousandths(2381, utScreenPixels, pprtVertical, nil));
  bvlPageRange.Height := (lblDescription.Top + lblDescription.Height + liBottomSpacer) - bvlPageRange.Top;
  tbnDevice.Height := (bvlPageRange.Top + bvlPageRange.Height + liBottomSpacer * 4);}
end;

Procedure TXPrintDialog.rdbTextFileClick(Sender: TObject);
begin
  UpdateFileSettings;
end;

Procedure TXPrintDialog.rdbArchiveFileClick(Sender: TObject);
begin
  UpdateFileSettings;
end;

Procedure TXPrintDialog.UpdateFileSettings;
begin
  if rdbTextFile.Checked then begin
    SaveDialog1.FileName := TextFileName;
    SaveDialog1.DefaultExt := 'txt';
    SaveDialog1.Filter := 'Text files|*.TXT|All files|*.*';
    lblPrintToFile.Caption := LoadStr(LanguageIndex + ppMsgPrintToFile);
    lblFileDesc.Caption := {LoadStr(LanguageIndex + ppMsgFile)}'Файл'
                             + '   ' + TextFileName;
  end else
    if rdbArchiveFile.Checked then begin
      SaveDialog1.FileName := ArchiveFileName;
      SaveDialog1.DefaultExt := 'raf';
      SaveDialog1.Filter := 'Archive files|*.RAF|All files|*.*';
      lblPrintToFile.Caption := LoadStr(LanguageIndex + ppMsgPrintToArchive);
      lblFileDesc.Caption := {LoadStr(LanguageIndex + ppMsgFile)}'Файл'
                             + '   ' + ArchiveFileName;
    end;
  if (SaveDialog1.FileName <> '') then
    SaveDialog1.InitialDir := ppStripOffPath(SaveDialog1.FileName);
  btnFile.Enabled := cbxPrintToFile.Checked;
  rdbTextFile.Enabled := cbxPrintToFile.Checked;
  rdbArchiveFile.Enabled := cbxPrintToFile.Checked;
end;

end.
  