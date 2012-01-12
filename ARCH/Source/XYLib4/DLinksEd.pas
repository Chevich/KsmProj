Unit DLinksEd;

Interface

Uses Classes, ColnEdit;

type

{ TXInquiriesEditor }

  TXInquiriesEditor = class(TCollectionEditor)
  protected
    procedure ReadState(Reader: TReader); override;
  public
    procedure Activate; override;
    procedure Deactivate; override;
  end;

Implementation

Uses SysUtils, Dialogs, XDBTFC;

{ TDataLinksEditor }

Procedure TXInquiriesEditor.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
{  Showmessage('Hello Links.Count='+IntToStr(Collection.Count));}
end;

Procedure TXInquiriesEditor.Activate;
begin
  Inherited Activate;
{  Showmessage('Hello Links.Count='+IntToStr(Collection.Count));}
end;

Procedure TXInquiriesEditor.Deactivate;
begin
{  Showmessage('QHello Links.Count='+IntToStr(Collection.Count));}
  Inherited Deactivate;
end;

end.
