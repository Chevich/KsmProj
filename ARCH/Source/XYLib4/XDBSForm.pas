unit XDBSForm;

interface

uses
  XForms, ComCtrls, ToolWin, XPages, Menus, XTFC, StdCtrls, Mask, ToolEdit,
  Controls, Buttons, RXCtrls, XCtrls, Classes, ExtCtrls, Dialogs, XDBCtrls;

type

{ TXSDBForm }

  TXSDBForm = class(TXDBForm)
    StartPC: TXDBPageControl;
    StartSheet: TTabSheet;
    ImageList1: TImageList;
    CoolBar1: TCoolBar;
    PrinterSetupDialog1: TPrinterSetupDialog;
    MainMenu1: TControlMainMenu;
    N22: TMenuItem;
    N24: TMenuItem;
    N32: TMenuItem;
    TabSheet1: TTabSheet;
    HotImageList1: TImageList;
    TaskToolBar: TToolBar;
    TabSheet2: TTabSheet;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    CoolBar2: TCoolBar;
    ToolBar1: TToolBar;
    CoolBar3: TCoolBar;
    ToolBar2: TToolBar;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel1: TPanel;
    MainDate: TDateEdit;
    CurrDateBtn: TSpeedButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    XLabel1: TXLabel;
    XDBLabel1: TXDBLabel;
    procedure CurrDateBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var XSDBForm: TXSDBForm;

implementation

Uses SysUtils;

{$R *.DFM}

procedure TXSDBForm.CurrDateBtnClick(Sender: TObject);
begin
  inherited;
  MainDate.Date:=Date;
end;

procedure TXSDBForm.FormCreate(Sender: TObject);
begin
  inherited;
  MainDate.Date:=Date;
end;

Initialization
  RegisterXForm('XDBSForm', TXSDBForm);
Finalization
  UnRegisterXForm(TXSDBForm);
end.
