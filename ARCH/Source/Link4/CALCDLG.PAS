unit CalcDlg;

interface

uses
  Forms, StdCtrls, Buttons, Controls, ExtCtrls, Classes;

type
  TLnCalcDlg = class(TForm)
    Bevel1: TBevel;
    Panel: TPanel;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    HelpBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LnCalcDlg: TLnCalcDlg;

implementation

Uses Messages, DBTables, Dialogs;

{$R *.DFM}

end.
