unit AEForms;

interface

uses
  XForms, XMisc;

type
  TAEForm = class(TXForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AEForm: TAEForm;

implementation

{$R *.DFM}


initialization
  RegisterAliasXForm(fcDefaultClass, TAEForm);
finalization
  UnRegisterXForm(TAEForm)
end.
