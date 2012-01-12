unit MInvoice;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ABEForms, StdCtrls, SrcIndex, XDBForms, ExtCtrls, Grids, DBGrids, DB,
  EtvGrid, XECtrls, ComCtrls, EtvPages, RXSplit, ToolEdit, RXDBCtrl,
  EtvRXCtl, Mask, DBCtrls, EtvContr, RXCtrls, XCtrls, EtvLook, XMisc, ETVDB;

type
  TMInvoiceForm = class(TABEForm)
    LabelNumInvoice: TXLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    EditNumDoc: TXEDBEdit;
    LabelDateDoc: TXLabel;
    EditDateDoc: TXEDBDateEdit;
    XEDbGrid1: TXEDbGrid;
    LabelSourceDepot: TXLabel;
    LookupEditClientName: TXEDBLookupCombo;
    LabelRecipient: TXLabel;
    LookupEditDestDepotName: TXEDBLookupCombo;
    LabelKreditName: TXLabel;
    LookupEditKreditName: TXEDBLookupCombo;
    LabelNameDoc: TXLabel;
    LookupEditOperationName: TXEDBLookupCombo;
    LookupEditSourceDepotName: TXEDBLookupCombo;
    LookupEditRecipientName: TXEDBLookupCombo;
    LabelGroupBox: TGroupBox;
    LookupEditCurrencyName: TXEDBLookupCombo;
    LabelCourse: TXLabel;
    LabelCourse1: TXLabel;
    EditNumInvoice: TXEDBEdit;
    EditInfo: TXEDBEdit;
    LabelInfo: TXLabel;
    Panel3: TPanel;
    DBText_sUser: TEtvDBText;
    DBText_sTime: TEtvDBText;
    DBText_IDInvoice: TEtvDBText;
    Button1: TButton;
    PrintButton: TButton;
    pnlAllower: TPanel;
    XLabel1: TXLabel;
    LookupEditAllowerName: TXEDBLookupCombo;
    pnlContract: TPanel;
    XLabel2: TXLabel;
    LookupEditContractName: TXEDBLookupCombo;
    EditContractName: TXEDBEdit;
    pnlStatRash: TPanel;
    XLabel2Rash: TXLabel;
    LookupEditStatRashName: TXEDBLookupCombo;
    pnlObjZatr: TPanel;
    XLabel2Zatr: TXLabel;
    LookupEditObjZatrName: TXEDBLookupCombo;
    procedure Panel1Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure XEDbGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    GlobalMode : integer;
    procedure ChangeFormFace(ChangedOperation: boolean = False);
  end;

var
  MInvoiceForm: TMInvoiceForm;

implementation
{$R *.DFM}
Uses MdMaterials, MdInvc, XApps, ETVRus;

procedure TMInvoiceForm.ChangeFormFace;
  procedure ChangeAccount(Account: string);
  begin
    if ChangedOperation then
      LookupEditOperationName.DataSource.DataSet.FieldByName('Kredit').AsString:=Account;
  end;
begin
  if not Assigned(self) then begin
     MdMat.MInvoiceC.Execute;
     Exit;
  end;
  if (PageControl1.ActivePage.Name='FormSheet') then
  begin
    if mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger<>GlobalMode then
      begin
        GlobalMode:=mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger;
        PrintButton.Enabled:=mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger=3;
        if (mdMat.MInvoiceHDeclarCurrency.AsInteger<>974) and ChangedOperation then
          mdMat.MInvoiceHDeclarCurrency.AsInteger:=974;
        case mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger of
          3,14: begin // ПРИХОД
               case mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger of
                  3: begin
                       LabelNameDoc.Caption:='Приходный ордер №';
                       ChangeAccount('60.00');
                     end;
                 14: begin
                       LabelNameDoc.Caption:='Внерелизац. доход №';
                     end;
               end;
               LabelNumInvoice.Show; EditNumInvoice.Show;
               LabelSourceDepot.Show;
               LookupEditClientName.Show;
               LookupEditDestDepotName.Show;
               pnlAllower.Show;
               pnlContract.Show;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LookupEditContractName.Hide;
               EditContractName.Show;
               LabelGroupBox.Hide;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options+[foValueNotInLookUp];
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               LookupEditKreditName.Show;
               mdMat.ShowFields([0,1,3,4,8,10,11,13,15,17,18]);
               mdMat.DrawInputFields([0,1,3,4,7,8,11]);
             end;
          16: begin // ПРИХОД ПО РОЗНИЦЕ
               LabelNameDoc.Caption:='Приходный ордер №';
               ChangeAccount('60.00');
               LabelNumInvoice.Show; EditNumInvoice.Show;
               LabelSourceDepot.Show;
               LookupEditClientName.Show;
               LookupEditDestDepotName.Show;
               pnlAllower.Show;
               pnlContract.Show;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LookupEditContractName.Hide;
               EditContractName.Show;
               LabelGroupBox.Hide;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options+[foValueNotInLookUp];
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               LookupEditKreditName.Show;
               mdMat.ShowFields([0,1,3,4,8,10,11,13,15,17,18]);
               mdMat.DrawInputFields([0,1,4,11,17]);
             end;
          4,6,8,9:
             begin // 4 - РАСХОД, 6 - СПИСАНИЕ, 8 - СПИСАНИЕ НА СЕБЕСТОИМОСТЬ, 9 - ВЗЯТИЕ НА БАЛАНС
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               case mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger of
                 4: begin
                      LabelNameDoc.Caption:='Внутр. перемещение №';
                      ChangeAccount('10.02');
                      pnlObjZatr.Show;
                      pnlStatRash.Show;
                    end;
                 6: LabelNameDoc.Caption:='Накладная списания №';
                 8: LabelNameDoc.Caption:='На себестоимость №';
                 9: LabelNameDoc.Caption:='Взятие на баланс №';
               end;
               LabelNumInvoice.Hide; EditNumInvoice.Hide;
               LookupEditClientName.Hide;
               LookupEditDestDepotName.Show;
               LabelGroupBox.Hide;
               LabelSourceDepot.Show;
               pnlAllower.Show;
               pnlContract.Hide;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options-[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options-[foValueNotInLookUp];
               LookupEditRecipientName.Hide;
               LookupEditSourceDepotName.Show;
               LookupEditKreditName.Show;
               mdMat.ShowFields([0,1,8,17]);
               mdMat.DrawInputFields([0,1,8]);
             end;
          7, 15: begin
               case mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger of
                  7: begin
                        LabelNameDoc.Caption:='Продажа';
                        ChangeAccount('91.04');
                     end;
                 15: begin
                        LabelNameDoc.Caption:='Внерелизац. расход №';
                        ChangeAccount('92.00');
                     end;
               end;
               LookupEditClientName.Hide;
               LookupEditDestDepotName.Hide;
               LabelSourceDepot.Show;
               pnlAllower.Show;
               pnlContract.Show;
               LookupEditContractName.Hide;
               EditContractName.Show;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LabelGroupBox.Hide; 
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options-[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options-[foValueNotInLookUp];
               LookupEditSourceDepotName.Show;
               LookupEditRecipientName.Show;
               LookupEditKreditName.Show;
               mdMat.ShowFields([0,1,8,10,11,13,17]);
               mdMat.DrawInputFields([0,1,8,11]);
             end;
          10: begin
               LabelNameDoc.Caption:='Акт приемки №';
               LabelNumInvoice.Show; EditNumInvoice.Show;
               LookupEditClientName.Show;
               LookupEditDestDepotName.Show;
               LabelSourceDepot.Show;
               pnlAllower.Show;
               pnlContract.Hide;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LabelGroupBox.Hide;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options-[foValueNotInLookUp];
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               mdMat.ShowFields([0..2,5,6,8,10,11,13,15,17,18]);
               mdMat.DrawInputFields([]);
             end;
          11: begin
               LabelNameDoc.Caption:='Валютная накладная №';
               LabelNumInvoice.Show; EditNumInvoice.Show;
               LookupEditClientName.Show;
               LookupEditDestDepotName.Show;
               LabelSourceDepot.Show;
               pnlAllower.Show;
               pnlContract.Show;
               LookupEditContractName.Show;
               EditContractName.Hide;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LabelGroupBox.Show; 
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options+[foValueNotInLookUp];
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               mdMat.ShowFields([0,1,3,4,7..13,15,16,17]);
               mdMat.DrawInputFields([0,1,3,4,7,8,11]);
             end;
    {      12: begin
               LabelNameDoc.Caption:='Валютная накладная №';
               LookupEditClientName.Show;
               LookupEditDestDepotName.Show;
               LabelSourceDepot.Show;
               LabelGroupBox.Show; //LookupEditCurrencyName.Show;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options+[foValueNotInLookUp];
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               mdMat.ShowFields([0,1,3..14])
             end;}
          13: begin
               LabelNameDoc.Caption:='Занесение остатков №';
               LabelNumInvoice.Hide; EditNumInvoice.Hide;
               LabelSourceDepot.Hide;
               pnlAllower.Show;
               pnlContract.Hide;
               LookupEditSourceDepotName.Hide;
               LookupEditRecipientName.Hide;
               LookupEditClientName.Hide;
               pnlObjZatr.Hide;
               pnlStatRash.Hide;
               LookupEditDestDepotName.Show;
               LabelGroupBox.Hide;
               mdMat.MInvoiceTdeclarPriceName.Options:=mdMat.MInvoiceTdeclarPriceName.Options+[foValueNotInLookUp];
               mdMat.MInvoiceTdeclarPriceNameBy.Options:=mdMat.MInvoiceTdeclarPriceNameBY.Options+[foValueNotInLookUp];
               mdMat.ShowFields([0,1,8,10,17]);
               mdMat.DrawInputFields([]);
             end;
      end;
    end; //end case
    LookupEditCurrencyName.Enabled:=mdMat.MInvoiceHDeclar.FieldByName('Operation').AsInteger=11;
  end;
end;

procedure TMInvoiceForm.Panel1Exit(Sender: TObject);
begin
  inherited;
  if not (mdMat.MInvoiceTDeclar.State in dsEditModes) then
    mdMat.MInvoiceTDeclar.Refresh;
end;

procedure TMInvoiceForm.PageControl1Change(Sender: TObject);
begin
  inherited;
  ChangeFormFace
end;

procedure TMInvoiceForm.PrintButtonClick(Sender: TObject);
 var aDeviceType: String;
    aNumCopies:integer;
begin
   with mdMat do
   begin
     aDeviceType:='Screen';
     aNumCopies:=1;
     mdMat.PLMInOrderT.RangeEndCount:=aNumCopies;
     with MReport do begin
       Template.FileName:=DirShb+'\MInOrder.rtm';
       Template.LoadFromFile;
       Bands[0].Objects[0].Caption:='Приходный ордер № '+
         MInvoiceHDeclar.FieldByName('NumDoc').AsString+' по накладной '+
         MInvoiceHDeclar.FieldByName('InvoiceNum').AsString;
       Bands[0].Objects[2].Caption:=DateToStrEtv(MInvoiceHDeclar.FieldByName('DateDoc').AsDateTime);
       DeviceType:=aDeviceType;
       Print;
     end;
   end;
end;

procedure TMInvoiceForm.Button1Click(Sender: TObject);
begin
  inherited;
  MdMaterials.mdMat.MAmountsC.Execute;
end;

procedure TMInvoiceForm.FormCreate(Sender: TObject);
begin
  inherited;
  Self.Left:=0;
  Self.Top:=0;
  GlobalMode:=-9;
end;

procedure TMInvoiceForm.FormActivate(Sender: TObject);
begin
  inherited;
  with ModuleInvoice.AllowerLookup do
    begin
      Filtered := False;
      Filter :='(TASK=0) or (TASK=2)';
      Filtered := True;
    end;
end;

procedure TMInvoiceForm.XEDbGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
    if Column.Field.Tag = 0 then
      begin
        if (gdSelected in State) and (gdFocused in State) then
//            TDBGrid(Sender).Canvas.Brush.Color:=clYellow;
        else
            TDBGrid(Sender).Canvas.Brush.Color:=clWindow
      end;
  TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

Initialization
  RegisterAliasXForm('MInvoiceForm', TMInvoiceForm);
Finalization
  UnRegisterXForm(TMInvoiceForm);
end.
