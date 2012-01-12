{            }
{ SplashForm }
{            }
Unit Splash;

Interface

Uses SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
     Forms, Dialogs, StdCtrls, Gauges, ExtCtrls, XCtrls,
     XSplash, RXCtrls;

type
  TSplashForm = class(TXSplashForm)
    Panel1: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Image1: TImage;
    TaskLabel: TXLabel;
    AutsLabel: TXLabel;
    HardLabel: TXLabel;
    Bevel2: TBevel;
    Progress: TGauge;
    ProgressBevel: TBevel;
  protected
    function  GetHardLabel: String;override;
    procedure SetHardLabel(Const Value: String);override;
    function  GetTaskLabel: String;override;
    procedure SetTaskLabel(Const Value: String);override;
    function  GetAutsLabel: String;override;
    procedure SetAutsLabel(Const Value: String);override;
    function  GetImage: TImage;override;
    function  GetVisProgress: Boolean;override;
    procedure SetVisProgress(Value: Boolean);override;
    function  GetProgress: Integer;override;
    procedure SetProgress(Value: Integer);override;
    procedure SetProgressCount(Value: Integer);override;
  public
{    Procedure Init(ACount: Integer; Const ABmp, AHard, ATask,
              Auts: String);}
  end;

Var SplashForm: TSplashForm=nil;

Implementation

Uses XMisc, XTFC;

{$R *.DFM}

Function TSplashForm.GetHardLabel: String;
begin
  Result:=HardLabel.Caption;
end;

Procedure TSplashForm.SetHardLabel(Const Value: String);
begin
  HardLabel.Caption:=Value;
end;

Function TSplashForm.GetTaskLabel: String;
begin
  Result:=TaskLabel.Caption;
end;

Procedure TSplashForm.SetTaskLabel(Const Value: String);
begin
  TaskLabel.Caption:=Value;
end;

Function TSplashForm.GetAutsLabel: String;
begin
  Result:=AutsLabel.Caption;
end;

Procedure TSplashForm.SetAutsLabel(Const Value: String);
begin
  AutsLabel.Caption:=Value;
end;

Function TSplashForm.GetImage: TImage;
begin
  Result:=Image1;
end;

Function TSplashForm.GetVisProgress: Boolean;
begin
  Result:=Progress.Visible;
end;

Procedure TSplashForm.SetVisProgress(Value: Boolean);
begin
  if Value then begin
    Progress.Visible:=True;
    ProgressBevel.Visible:=True;
  end else begin
    Progress.Visible:=False;
    ProgressBevel.Visible:=False;
  end;
end;

Function TSplashForm.GetProgress: Integer;
begin
  Result:=Progress.Progress;
end;

Procedure TSplashForm.SetProgress(Value: Integer);
begin
  Progress.Progress:=Value;
  Update;
end;

Procedure TSplashForm.SetProgressCount(Value: Integer);
begin
  Inherited;
  Progress.MaxValue:=GetProgressCount*10;
  Show;
end;

{
Procedure TSplashForm.Init(ACount: Integer; Const ABmp, AHard, ATask,
              Auts: String);
begin
  if AHard<>'' then
  HardLab.Caption:=AHard;
  if ATask<>'' then
  TaskLab.Caption:=ATask;
  if Auts<>'' then
  AutsLab.Caption:=Auts;
  if ABmp<>'' then Image1.Picture.LoadFromFile(ABmp);
  XProgressCount:=ACount;
end;
}

Initialization
  RegisterAliasXSplash(scDefaultClass, TSplashForm);
Finalization
  UnRegisterXSplash(TSplashForm);
end.
 