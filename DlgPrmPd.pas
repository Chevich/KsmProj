unit DlgPrmPd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DiDate, StdCtrls, Buttons, Mask, ToolEdit, RXCtrls, ExtCtrls, MdCommon,
  MdOrgs, DBCtrls, EtvLook, XECtrls, Db;

type
  TDialParamPayDoc = class(TDialDate)
    RxLabel3: TRxLabel;
    LookupCurrency: TXEDBLookupCombo;
    CurrencySource: TDataSource;
    LookupBCount: TXEDBLookupCombo;
    BCountSource: TDataSource;
    RxLabel4: TRxLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialParamPayDoc: TDialParamPayDoc;

implementation

{$R *.DFM}

end.
