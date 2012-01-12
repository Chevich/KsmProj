unit DModPr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, EtvTable, EtvDB;

type
  TDMPrint = class(TDataModule)
    QTaxYear: TEtvQuery;
    QTaxYearKod: TSmallintField;
    QTaxYearName: TStringField;
    QTaxYearBCount: TStringField;
    QTaxYearTOp: TSmallintField;
    QTaxYearM1: TFloatField;
    QTaxYearM2: TFloatField;
    QTaxYearM3: TFloatField;
    QTaxYearQ1: TFloatField;
    QTaxYearM4: TFloatField;
    QTaxYearM5: TFloatField;
    QTaxYearM6: TFloatField;
    QTaxYearQ2: TFloatField;
    QTaxYearM7: TFloatField;
    QTaxYearM8: TFloatField;
    QTaxYearM9: TFloatField;
    QTaxYearQ3: TFloatField;
    QTaxYearM10: TFloatField;
    QTaxYearM11: TFloatField;
    QTaxYearM12: TFloatField;
    QTaxYearQ4: TFloatField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMPrint: TDMPrint;

implementation
uses DataMod1;
{$R *.DFM}

end.
