{$I XLib.inc }
Unit XForms;

Interface

Uses Classes, Controls, Forms, Messages, XMisc, Misc;

Const fcDefaultClass ='fcDefault';

type

{ TXForm }
  TSysCommandEvent = procedure (var Message: TWMSysCommand) of object;

  TXFormClass = class of TXForm;

  TXForm = class(TForm)
  private
{    FXFormLink: TFormLink;}
    FFormControl: TXLibControl;
    FSysEvent: TSysCommandEvent;
    FOnClose: TCloseEvent;
    FOnCloseQuery: TCloseQueryEvent;
    function GetCaption: TCaption;
    procedure SetCaption(Const Value: TCaption);
    function IsStoredCaption: Boolean;
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure FormCreate(AControl: TComponent);
    procedure FormDestroy;
    procedure FormLinkSetName(Reader: TReader; Component: TComponent;
                              var Name: string);
    procedure FormClose(var Action: TCloseAction);
    procedure SelfClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(var CanClose: Boolean);
    procedure SelfCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SetFormControl(Value: TXLibControl);
  protected
{    procedure CreateParams(VAR Params: TCreateParams); override;}
    procedure InsideFormLinkSetName(Component: TComponent; var Name: string);dynamic;
    procedure Activate; override;
    procedure Deactivate; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadState(Reader: TReader); override;
    function DefaultXControl: TWinControl; virtual;
{    property XFormLink: TFormLink read FXFormLink write FXFormLink;}
    property SysEvent: TSysCommandEvent read FSysEvent write FSysEvent;
  published
    property Caption: TCaption read GetCaption write SetCaption stored isStoredCaption;
    property FormControl: TXLibControl read FFormControl write SetFormControl;
    property OnClose: TCloseEvent read FOnClose write FOnClose;
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
  end;
{ TXForm }

Implementation

Uses Dialogs, XTFC, EtvBor;

{ TXForm }

Constructor TXForm.Create(AOwner: TComponent);
var AControl: TComponent;
begin
  if AOwner is TFormControl then begin
    AControl:=AOwner;
    AOwner:=Application{Nil};
  end else AControl:=nil;
  {FormCreate(AControl);}
  Inherited Create(AOwner);
  FormCreate(AControl);
end;

Procedure TXForm.InsideFormLinkSetName(Component: TComponent; var Name: string);
begin
{
  if Name='FormLink' then begin
     XFormLink:=TFormLink(Component);
     end;}
end;

Procedure TXForm.FormLinkSetName(Reader: TReader; Component: TComponent;
    var Name: string);
begin
  InsideFormLinkSetName(Component,Name);
end;

Procedure TXForm.ReadState(Reader: TReader);
var SavSetName: TSetNameEvent;
begin
  SavSetName:=Reader.OnSetName;
  Reader.OnSetName:=FormLinkSetName;
  inherited ReadState(Reader);
  Reader.OnSetName:=SavSetName;
end;

Destructor TXForm.Destroy;
begin
  FormDestroy;
  Inherited Destroy;
end;

Procedure TXForm.SetFormControl(Value: TXLibControl);
begin
  if Value<>FFormControl then begin
    FFormControl:=Value;
    if Value <> nil then begin
      TFormControl(Value).Form:=Self;
      Caption:=TFormControl(Value).Caption;
      Value.FreeNotification(Self);
    end;
  end;
end;

Function TXForm.GetCaption: TCaption;
begin
  if Assigned(FFormControl) then
    Result:=TFormControl(FFormControl).Caption
  else Result:= Inherited Caption;
end;

Procedure TXForm.SetCaption(Const Value: TCaption);
begin
  if Assigned(FFormControl) then
    TFormControl(FFormControl).Caption:=Value
  else Inherited Caption:=Value;
end;

Function TXForm.IsStoredCaption: Boolean;
begin
  Result:=(Caption<>'') and (not Assigned(FFormControl));
end;

Procedure TXForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
(*** TEST!!! Writeln(FFFF,'TXForm.Notification #1 :',AComponent.Name); ***)
  Inherited Notification(AComponent, Operation);
(*** TEST!!! Writeln(FFFF,'TXForm.Notification #2 :',AComponent.Name); ***)
  if (Operation = opRemove) and (AComponent is TFormControl) and
  (AComponent=FFormControl) then begin
    FFormControl:=nil;
  end;
(*** TEST!!! Writeln(FFFF,'TXForm.Notification #3 :',AComponent.Name); ***)
end;

{
procedure TLForm.CreateParams(VAR Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  Params.WndParent := GetDesktopWindow;
end;
}

Procedure TXForm.WMSysCommand(var Message: TWMSysCommand);
begin
  Inherited;
  if Assigned(FSysEvent) then FSysEvent(Message);
end;

Function TXForm.DefaultXControl: TWinControl;
begin
  Result:=nil;
end;

Procedure TXForm.FormCreate(AControl: TComponent);
var Priz: Boolean;
begin
  Inherited OnClose:=SelfClose;
  Inherited OnCloseQuery:=SelfCloseQuery;
  Priz:=True;
{  if Assigned(XFormLink) then }
  begin
    if AControl=nil then begin
  {   AControl:=XFormLink.LinkControl;}
      AControl:=FormControl;
    end;
    if Assigned(AControl) then
      with TFormControl(AControl) do begin
        try
  {       if Not Assigned(FormLink) then begin
          FormLink:=Self.XFormLink;
          Self.XFormLink.LinkControl:=AControl;
          end else Priz:=False;}
          if Assigned(Form) then Priz:=False;
        except;
          ShowMessage('Error create XForm!');
          raise;
        end;
      end;
  end;
  if Assigned(AControl) then
    with TFormControl(AControl) do begin
      if Priz then with FormRect do
        if Active then begin
          Left:=FormLeft;
          Top:=FormTop;
          Width:=FormWidth;
          Height:=FormHeight;
        end else AMScaleForm(Self, True);
      Form:=Self;
      FormControl:=TXLibControl(AControl);
      CreateLink;
      CreateForms;
    end;
end;

procedure TXForm.FormDestroy;
begin
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
     TFormControl(XFormLink.LinkControl).DestroyForms;}
  if Assigned(FormControl) then
    TFormControl(FormControl).DestroyForms;
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then TFormControl(XFormLink.LinkControl).Form:=Nil;}
  if Assigned(FormControl) then TFormControl(FormControl).Form:=nil;
end;

Procedure TXForm.FormClose(var Action: TCloseAction);
begin
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
     TFormControl(XFormLink.LinkControl).CloseForm(Action);}
  if Assigned(FormControl) then TFormControl(FormControl).CloseForm(Action);
end;

Procedure TXForm.SelfClose(Sender: TObject; var Action: TCloseAction);
begin
  FormClose(Action);
  if Assigned(FOnClose) then FOnClose(Self, Action);
end;

Procedure TXForm.FormCloseQuery(var CanClose: Boolean);
begin
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
     TFormControl(XFormLink.LinkControl).CloseQueryForm(CanClose);}
  if Assigned(FormControl) then
     TFormControl(FormControl).CloseQueryForm(CanClose);
end;

Procedure TXForm.SelfCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FormCloseQuery(CanClose);
  if Assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

Procedure TXForm.Activate;
begin
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
     TFormControl(XFormLink.LinkControl).ActivateForm;}
  if Assigned(FormControl) and not Application.Terminated then
    TFormControl(FormControl).ActivateForm;
  Inherited Activate;
end;

Procedure TXForm.Deactivate;
begin
  Inherited Deactivate;
{  if Assigned(XFormLink) and Assigned(XFormLink.LinkControl) then
     TFormControl(XFormLink.LinkControl).DeactivateForm;}
  if Assigned(FormControl) then TFormControl(FormControl).DeactivateForm;
end;

Initialization
  RegisterClasses([TXForm]);
end.
