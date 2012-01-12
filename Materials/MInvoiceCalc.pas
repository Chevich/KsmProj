unit MInvoiceCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Mask, ToolEdit, CurrEdit;

type
  TMInvoiceCalcForm = class(TForm)
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;                                    
    Bevel4: TBevel;
    eSum_itg: TRxCalcEdit;
    eSum_vat: TRxCalcEdit;
    eSum_all: TRxCalcEdit;
    eSum_itg2: TRxCalcEdit;
    eSum_vat2: TRxCalcEdit;
    eSum_all2: TRxCalcEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Sum1, Sum2, Sum3: extended;
    Itg1, Itg2, Itg3: extended;
  end;

function CalculateOTKL(iSum1, iSum2, iSum3: extended; var iNew1, iNew2: extended; Sender: TComponent): boolean;

var
  MInvoiceCalcForm: TMInvoiceCalcForm;

implementation

function CalculateOTKL(iSum1, iSum2, iSum3: extended; var iNew1, iNew2: extended; Sender: TComponent): boolean;
begin
  if not Assigned(MInvoiceCalcForm) then
    MInvoiceCalcForm:=TMInvoiceCalcForm.Create(Sender);
  with MInvoiceCalcForm do
    begin
      //----------------------------------
      Sum1:=iSum1;
      Sum2:=iSum2;
      Sum3:=iSum3;
      //----------------------------------
      Itg1:=iSum1;
      Itg2:=iSum2;
      Itg3:=iSum3;
      //----------------------------------
      eSum_itg.Value:=Sum1;
      eSum_vat.Value:=Sum2;
      eSum_all.Value:=Sum3;
      eSum_itg2.Value:=Itg1;
      eSum_vat2.Value:=Itg2;
      eSum_all2.Value:=Itg3;
      //----------------------------------
      Result := ShowModal = mrOk;
      if Result then
        begin
          Itg1:=eSum_itg2.Value;
          Itg2:=eSum_vat2.Value;
          Itg3:=eSum_all2.Value;
          iNew1:=Itg1-Sum1;
          iNew2:=Itg3-Itg2-Itg3;
        end;
    end;
end;

{$R *.DFM}

procedure TMInvoiceCalcForm.BitBtn1Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TMInvoiceCalcForm.BitBtn2Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.
 