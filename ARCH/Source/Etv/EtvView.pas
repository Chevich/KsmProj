unit EtvView; (* Igo *)

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls, Buttons, ComCtrls, Spin, Dialogs;

type
  TFormView = class(TForm)
    Panel1: TPanel;
    SpeedButtonPrint: TSpeedButton;
    RichEdit: TRichEdit;
    SpeedButton1: TSpeedButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    SpinEditSize: TSpinEdit;
    LabelPrinter: TLabel;
    procedure SpeedButtonPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpinEditSizeChange(Sender: TObject);
  public
    FirstActive:boolean;
    function ShowReport(aModal:boolean):integer;
  end;

var
  FormView: TFormView;

implementation
uses Printers, EtvPrint,DiPrint,EtvForms;
{$R *.DFM}

procedure TFormView.SpeedButtonPrintClick(Sender: TObject);
var Cycle,EndCycle:integer; 
begin
  if DialPrint.Execute(EtvPrintSet) then begin
    if EtvPrintSet.Mode=pmText then EndCycle:=EtvPrintSet.Copies
    else EndCycle:=1;
    for Cycle:=1 to EndCycle do
      if EtvPrinter.BeginDoc(EtvPrintSet) then
        try
          EtvPrinter.PrintStrings(RichEdit.Lines);
          EtvPrinter.EndDoc;
        except
          EtvPrinter.Abort;
          Raise;
        end
      else break;
  end;    
end;

procedure TFormView.FormCreate(Sender: TObject);
begin
  RichEdit.Lines.Clear;
  FirstActive:=true;
end;

procedure TFormView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TFormView.FormActivate(Sender: TObject);
begin
  if FirstActive then begin
    RichEdit.SelStart:=0;
    FirstActive:=false;
  end;
  LabelPrinter.caption:=Printer.Printers[Printer.PrinterIndex];
end;

procedure TFormView.SpeedButton1Click(Sender: TObject);
begin
  if PrinterSetupDialog1.execute then
    LabelPrinter.caption:=Printer.Printers[Printer.PrinterIndex];
end;

function TFormView.ShowReport(aModal:boolean):integer;
const TWidth=7;
      AddWidth=30;
var i,n,MaxWidth:integer;
begin
  Result:=0;
  MaxWidth:=0;
  n:=30;
  if RichEdit.Lines.Count<n then n:=RichEdit.Lines.Count;
  for i:=0 to n-1 do
    if Length(RichEdit.Lines[i])*TWidth>MaxWidth then begin
      MaxWidth:=Length(RichEdit.Lines[i])*TWidth;
      if MaxWidth+AddWidth>Screen.Width then break;
    end;
  MaxWidth:=MaxWidth+AddWidth;
  if MaxWidth>Screen.Width then MaxWidth:=Screen.Width;
  Width:=MaxWidth;
  if aModal then Result:=ShowModal
  else Show;
end;

procedure TFormView.SpinEditSizeChange(Sender: TObject);
var i:integer;
begin
  if SpinEditSize.text='' then Exit;
  i:=trunc(SpinEditSize.Value);
  if i<6 then i:=6;
  if i>32 then i:=32;
  Richedit.Font.size:=i;
end;

end.
