unit TrLabel;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Gauges, RXCtrls, ComCtrls;

type
  TFormLabel = class(TForm)
    Bevel1: TBevel;
    Image1: TImage;
    RxLabel1: TRxLabel;
    RxLabel2: TRxLabel;
    LabelWork: TLabel;
    ProgressBar1: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inc(n:integer);
    procedure IncL(n:integer; s:string);
  end;

var
  FormLabel: TFormLabel;

implementation

{$R *.DFM}

procedure TFormLabel.Inc(n: integer);
begin
  ProgressBar1.StepBy(n);
  Update;
end;

procedure TFormLabel.IncL(n: integer; s:string);
begin
  LabelWork.Caption:=s;
  Inc(n);
end;

end.
