{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Explorer library: component editor            }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}
{$WARNINGS OFF}

unit ExplEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  vgItemEd, Menus, StdCtrls;

type
  TExplorerNodesEditorForm = class(TItemEditorForm)
    miLine: TMenuItem;
    miNewItem: TMenuItem;
    procedure miNewItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TExplorerNodesEditor = class(TItemListEditor)
  public
    function GetFormClass: TItemEditorFormClass; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

var
  ExplorerForms: TList = nil;

implementation

uses vgUtils, Explorer, ExplAdd, ExplNvgt;

{$R *.DFM}

function FindExplorerForm(ExplorerNodes: TExplorerNodes): TExplorerNodesNavigatorForm;
var
  I: Integer;
begin
  if Assigned(ExplorerForms) then
  begin
    for I := 0 to ExplorerForms.Count - 1 do
    begin
      Result := ExplorerForms[I];
      if Result.ExplorerNodes = ExplorerNodes then Exit;
    end;
  end;
  Result := nil;
end;

function TExplorerNodesEditor.GetFormClass: TItemEditorFormClass;
begin
  Result := TExplorerNodesEditorForm;
end;

function TExplorerNodesEditor.GetVerb(Index: Integer): string;
begin
  if Index > 0 then
    Result := inherited GetVerb(Index - 1) else
    Result := 'Explore...';
end;

function TExplorerNodesEditor.GetVerbCount: Integer;
begin
  Result := inherited GetVerbCount + 1;
end;

procedure TExplorerNodesEditor.ExecuteVerb(Index: Integer);
var
  Form: TExplorerNodesNavigatorForm;
begin
  if Index > 0 then
    inherited ExecuteVerb(Index - 1)
  else begin
    Form := FindExplorerForm(Component as TExplorerNodes);
    if Assigned(Form) then
      Form.BringToFront
    else begin
      Form := TExplorerNodesNavigatorForm.Create(nil);
      with Form do
      try
        FormDesigner := Self.Designer;
        ExplorerNodes := Component as TExplorerNodes;
        Show;
      except
        Free;
        raise;
      end;
    end;
  end;
end;

procedure TExplorerNodesEditorForm.miNewItemClick(Sender: TObject);
var
  Nodes: TExplorerNodes;
  NodesClass: TExplorerNodesClass;
begin
  NodesClass := GetExplorerNodesClass;
  if Assigned(NodesClass) then
  begin
    Nodes := TExplorerNodes(FormDesigner.CreateComponent(NodesClass, TExplorerNodes(ItemList), 0, 0, 0, 0));
    try
      Nodes.DesignInfo := 0;
      Nodes.Parent := TExplorerNodes(ItemList);
      UpdateItems;
    except
      Nodes.Free;
      raise;
    end;
  end;
end;

end.
