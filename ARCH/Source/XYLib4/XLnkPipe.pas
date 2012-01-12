Unit XLnkPipe;

Interface

Uses Classes, Forms, DB, ppEndUsr, XReports;

type

{ TXLinkReport}

{  TXReportItem = class;}

  TXLinkReport = class(TXDBReport)
  private
    FControl: TComponent; {?+TXReportItem or Index?}
    FReportItem: TCollectionItem;
    procedure SetControl(AControl: TComponent);
  protected
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;
    procedure SetParentComponent(AParent: TComponent); override;
    procedure ReadState(Reader: TReader); override;
    function GetPreviewCaption: String; override;
  public
    destructor Destroy; override;
    procedure Print; override;
    property Control: TComponent read FControl write FControl;
    property ReportItem: TCollectionItem read FReportItem write FReportItem;
  end;

{ TppXDesigner}

  TppXDesigner = class(TppDesigner)
  private
    FOnCloseQuery: TCloseQueryEvent;
    procedure SelfCloseQuery(Sender: TObject; var CanClose: Boolean);
    function ppSaveReport: Boolean;
  protected
    procedure DoOnCloseQuery(var CanClose: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
  end;

Implementation

Uses SysUtils, Controls, Dialogs, UsersSet, LnkSet, XDBTFC;

{ TXLinkReport }

destructor TXLinkReport.Destroy;
var i: Integer;
    RepItem: TXReportItem;
begin
  if Assigned(FControl) and (not (csDestroying in Control.ComponentState)) then begin
    i:=TDBFormControl(FControl).Reports.IndexOfReport(Name);
    if i<>-1 then begin
      RepItem:= TDBFormControl(FControl).Reports[i];
      RepItem.Report:=nil;
    end;
{     FControl.FppXReports.Remove(Self);}
  end;
  Inherited Destroy;
end;

Procedure TXLinkReport.Print;
begin
  if Assigned(ReportItem) then
    PrintLink:= TXReportItem(ReportItem).PrintLink;
{   PrintType:= TXReportItem(ReportItem).TypePrint;}
  Inherited;
end;

Function TXLinkReport.GetPreviewCaption: String;
var AItem: TXReportItem;
    i: Integer;
begin
  Result:= '';
  if Assigned(Control) and Assigned(ReportItem) then begin
    Result:= TXReportItem(ReportItem).Caption;
{
    i:= Control.Reports.IndexOfReport(Name);
    if i<>-1 then begin
      AItem:= Control.Reports[i];
      PreviewForm.Caption:= AItem.Caption;
    end;}
  end;
end;

Function TXLinkReport.HasParent: Boolean;
begin
  HasParent := True;
end;

Function TXLinkReport.GetParentComponent: TComponent;
begin
  Result := Control;
end;

Procedure TXLinkReport.SetControl(AControl: TComponent);
begin
  Control:= AControl;
{  Control.FppXReports.Add(Self);}
end;

Procedure TXLinkReport.SetParentComponent(AParent: TComponent);
begin
  if not (csLoading in ComponentState) then SetControl(AParent as TDBFormControl);
end;

Procedure TXLinkReport.ReadState(Reader: TReader);
begin
  Inherited ReadState(Reader);
  if Reader.Parent is TLinkSource then SetControl(TDBFormControl(Reader.Parent));
end;

{ TppXDesigner }

Constructor TppXDesigner.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
  Inherited OnCloseQuery:=SelfCloseQuery;
end;

Procedure TppXDesigner.SelfCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Sender, CanClose)
  else DoOnCloseQuery(CanClose);
end;

Function TppXDesigner.ppSaveReport: Boolean;
var ASource: TUserSource;
    SavPriz: Boolean;
begin
  Result:= False;
  with TDBFormControl(TXLinkReport(Report).Control) do
  case TDBFormTools(FormTools).ReportType of
    fcSelf:
      begin
        ASource:= TDBFormTools(FormTools).ReportSource;
        if Assigned(ASource) then
        try
          SavPriz:= Report.SaveAsTemplate;
          Report.SaveAsTemplate:=False;
          ASource.PatternName:= Report.Name;
          Result:= ASource.SaveToSource(Report, {Self}Owner);
          Report.SaveAsTemplate:=SavPriz;
          if Result then Exit;
        except
          Report.SaveAsTemplate:=SavPriz;
          raise;
        end;
      end;
    fcTools:
      if Assigned(FormTools.Tools) then begin
        ASource:= TDBToolsControl(FormTools.Tools).ReportSource;
        if Assigned(ASource) then
        try
          SavPriz:= Report.SaveAsTemplate;
          Report.SaveAsTemplate:=False;
          ASource.PatternName:= Report.Name;
          Result:= ASource.SaveToSource(Report, {Self}Owner);
          Report.SaveAsTemplate:=SavPriz;
          if Result then Exit;
        except
          Report.SaveAsTemplate:=SavPriz;
          raise;
        end;
      end;
  end;
  ShowMessage('Не определено куда записывать '+Report.Name);
end;

Procedure TppXDesigner.DoOnCloseQuery(var CanClose: Boolean);
begin
  if Report is TXLinkReport then
    if Report.Modified then begin
      case MessageDlg('Сохранить отчет?', mtConfirmation,[mbYes, mbNo, mbCancel],0) of
        mrYes:
          begin
            if Assigned(TXLinkReport(Report).Control) then
              if {TXLinkReport(Report).Control.}
                ppSaveReport{(TXLinkReport(Report))} then Report.Modified:= False;
          end;
        mrCancel: CanClose:=False;
      end;
    end;
end;

Initialization
  RegisterClasses([TXLinkReport]);
end.
