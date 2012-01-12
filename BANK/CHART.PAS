unit chart;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, chartfx3;

type
  TForm1 = class(TForm)
    Chart1: TChartFX;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Chart1.OpenDataEx(COD_VALUES,2,3);
  Chart1.ThisSerie := 0;
  
  Chart1.Value[0] := 30;
  Chart1.Value[1] := 20;
  Chart1.Value[2] := 120;
  Chart1.ThisSerie := 1;
  Chart1.Value[0] := 45;
  Chart1.Value[1] := 60;
  Chart1.Value[2] := 20;
  Chart1.CloseData(COD_VALUES);
  Chart1.SerLeg[0] :='Rub';
  Chart1.SerLeg[1] := 'Product B';
end;

end.
