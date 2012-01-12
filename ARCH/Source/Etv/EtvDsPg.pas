unit EtvDsPg;

interface
uses dsgnintf;

type
  TEtvPageControlEditor = class(TComponentEditor)
    function GetVerbCount:integer; override;
    function GetVerb(Index:integer):string; override;
    procedure ExecuteVerb(Index:Integer); override;
  end;

implementation
uses EtvPages;

{TEtvPageControlEditor}
function TEtvPageControlEditor.GetVerbCount:integer;
begin
  Result:=4;
end;

function TEtvPageControlEditor.GetVerb(Index:integer):string;
begin
  Case Index of
    0: Result:='New page';
    1: Result:='Next page';
    2: Result:='Previous page';
    3: Result:='Current page';
  end;
end;

procedure TEtvPageControlEditor.ExecuteVerb(Index:Integer);
var Tabs:TEtvTabSheet;
    lPageControl:TEtvPageControl;
begin
  if Component is TEtvPageControl then lPageControl:=TEtvPageControl(Component)
  else lPageControl:=TEtvPageControl(TEtvTabSheet(Component).PageControl);
  With lPageControl do begin
    case Index of
      0: begin
        Tabs:=TEtvTabSheet(Designer.CreateComponent(TEtvTabSheet,nil,0,0,0,0));
        Tabs.PageControl:=lPageControl;
        ActivePage:=Tabs;
      end;
      1: SelectNextPage(true);
      2: SelectNextPage(false);
    end;
    if Assigned(ActivePage) then Designer.SelectComponent(ActivePage);
  end;
end;

end.
