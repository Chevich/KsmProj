Unit XAbout;

Interface

Uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, StdCtrls,
     Buttons, ExtCtrls, Dsgnintf;

type

  TAboutBoxEditor = class(TPropertyEditor)
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    Button1: TButton;
    Label1: TLabel;
    WinVersion: TLabel;
    Label4: TLabel;
    CPU: TLabel;
    Label8: TLabel;
    UserName: TLabel;
    Label10: TLabel;
    ComputerName: TLabel;
    Label9: TLabel;
    FreeDisk: TLabel;
    Label2: TLabel;
    TotalSpace: TLabel;
    Label3: TLabel;
    PercentUse: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var AboutBox: TAboutBox = Nil;

Implementation

{$R *.DFM}

{---------------------------------------------------------------}
Function TAboutBoxEditor.GetAttributes;
begin
  Result:=inherited GetAttributes+[paDialog]+[paReadOnly];
end;
{---------------------------------------------------------------}
function TAboutBoxEditor.GetValue: string;
begin
  { This is the caption displayed in the Object Inspector }
  Result:='Click on...for About box';
end;
{----------------------------------------------------------------}
Procedure TAboutBoxEditor.Edit;
var AboutBox: TAboutBox;
begin
  AboutBox := TAboutBox.Create(Application);
  try
    MessageBeep(0);
    AboutBox.ShowModal;
  finally
    AboutBox.Free;
  end;
End;
{---------------------------------------------------------------}

Procedure TAboutBox.Button1Click(Sender: TObject);
begin
  Close
end;

end.
