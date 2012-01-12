Unit DiReplace;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TDialReplace = class(TForm)
    BtnYes: TButton;
    BtnCancel: TButton;
    BtnNo: TButton;
    BtnAll: TButton;
    Label1: TLabel;
    LabelText: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialReplace: TDialReplace;

implementation

{$R *.DFM}
   
end.
