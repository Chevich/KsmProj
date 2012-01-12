{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         Explorer library: explorer navigator          }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit ExplNvgt;

interface

uses
  Windows, Messages, Classes, SysUtils, Controls, Forms, DsgnIntf,
  DsgnWnds, {$IFNDEF _D3_}LibMain, {$ENDIF}LibIntf, Explorer, ComCtrls, ExplCtrl,
  Menus;

type
{$IFDEF _D4_}
  TFormDesigner = IFormDesigner;
{$ENDIF}

  TExplorerNodesNavigatorForm = class(TDesignWindow)
    etTree: TExplorerTreeView;
    es: TExplorerSource;
    puPopup: TPopupMenu;
    miNew: TMenuItem;
    miDel: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure etTreeChange(Sender: TObject; Node: TTreeNode);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miDelClick(Sender: TObject);
    procedure miNewClick(Sender: TObject);
  private
    { Private declarations }
    FExplorerNodes: TExplorerNodes;
    FFormDesigner: TFormDesigner;
    procedure SetExplorerNodes(Value: TExplorerNodes);
  public
    { Public declarations }
    {$IFDEF _D4_}
    procedure ComponentDeleted(AComponent: IPersistent); override;
    {$ELSE}
    procedure ComponentDeleted(AComponent: TComponent); override;
    {$ENDIF}
    property ExplorerNodes: TExplorerNodes read FExplorerNodes write SetExplorerNodes;
    procedure FormClosed(Form: {$IFDEF _D3_}TCustomForm{$ELSE}TForm{$ENDIF}); override;
    procedure FormModified; override;
    property FormDesigner: TFormDesigner read FFormDesigner write FFormDesigner;
  end;

implementation
uses vgUtils, ExplEdit, ExplAdd;

{$R *.DFM}

{$IFDEF _D4_}
procedure TExplorerNodesNavigatorForm.ComponentDeleted(AComponent: IPersistent);
begin
  if ExtractPersistent(AComponent) = FExplorerNodes then
{$ELSE}
procedure TExplorerNodesNavigatorForm.ComponentDeleted(AComponent: TComponent);
begin
  if AComponent = FExplorerNodes then
{$ENDIF}
  begin
    SetExplorerNodes(nil);
    Close;
  end;
end;

procedure TExplorerNodesNavigatorForm.FormModified;
begin
  if Assigned(FExplorerNodes) and Assigned(FExplorerNodes.Owner) then
    Caption := Format('%s.%s', [FExplorerNodes.Owner.Name, FExplorerNodes.Name]);
end;

procedure TExplorerNodesNavigatorForm.SetExplorerNodes(Value: TExplorerNodes);
begin
  if (FExplorerNodes <> Value) then
  begin
    FExplorerNodes := Value;
    if Assigned(FExplorerNodes) then
      FormModified else FFormDesigner := nil;
    ES.ExplorerRoot := FExplorerNodes;
  end;
end;

procedure TExplorerNodesNavigatorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  SetExplorerNodes(nil);
end;

procedure TExplorerNodesNavigatorForm.FormClosed(Form: {$IFDEF _D3_}TCustomForm{$ELSE}TForm{$ENDIF});
begin
  if Form = FormDesigner.Form then
  begin
    SetExplorerNodes(nil);
    Close;
  end;
end;

procedure TExplorerNodesNavigatorForm.FormCreate(Sender: TObject);
begin
  ListAdd(ExplorerForms, Self);
end;

procedure TExplorerNodesNavigatorForm.FormDestroy(Sender: TObject);
begin
  ListRemove(ExplorerForms, Self);
end;

procedure TExplorerNodesNavigatorForm.miNewClick(Sender: TObject);
var
  Nodes: TExplorerNodes;
  NodesClass: TExplorerNodesClass;
begin
  NodesClass := GetExplorerNodesClass;
  if Assigned(NodesClass) then
  begin
    Nodes := TExplorerNodes(FormDesigner.CreateComponent(NodesClass, FormDesigner.Form, 0, 0, 0, 0));
    try
      Nodes.DesignInfo := 0;
      Nodes.Parent := TExplorerNodes(etTree.SelectedExplorerNodes);
    except
      Nodes.Free;
      raise;
    end;
  end;
end;

procedure TExplorerNodesNavigatorForm.miDelClick(Sender: TObject);
begin
  etTree.SelectedExplorerNodes.Free;
end;

procedure TExplorerNodesNavigatorForm.etTreeChange(Sender: TObject;
  Node: TTreeNode);
var
  List: TComponentList;
  Nodes: TExplorerNodes;
begin
  List := TComponentList.Create;
  try
    if Assigned(FFormDesigner) then
    begin
      if Active and Assigned(FExplorerNodes) then
      begin
        Node := etTree.Selected;
        if Assigned(Node) then
        begin
          Nodes := (Node as TExplorerTreeNode).ExplorerNodes;
          if Assigned(Nodes) and not Nodes.IsRunTime then List.Add(Nodes);
        end;
        if List.Count > 0 then
          FFormDesigner.SetSelections(List)
      end;
    end;
    miNew.Enabled := List.Count > 0;
    miDel.Enabled := (es.ExplorerRoot <> etTree.SelectedExplorerNodes) and (List.Count > 0);
  finally
    List.Free;
  end;
end;

end.
