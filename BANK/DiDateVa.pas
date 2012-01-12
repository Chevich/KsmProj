unit DiDateVa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DiDate, StdCtrls, Buttons, Mask, ToolEdit, RXCtrls, ExtCtrls, DBCtrls,
  EtvLook;

type
  TDialDateVa = class(TDialDate)
    DBLCVa: TEtvDBLookupCombo;
    RxLabel3: TRxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialDateVa: TDialDateVa;

implementation
uses datamod1;
{$R *.DFM}


end.
