unit MServiceUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TMServiceForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lSklad: TLabel;
    lName: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lKod: TLabel;
    lPrice: TLabel;
    lAmount: TLabel;
    lSumma: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MServiceForm: TMServiceForm;

implementation

{$R *.DFM}

end.
