{*******************************************************}
{                                                       }
{         Vladimir Gaitanoff Delphi VCL Library         }
{         TConverterEditor                              }
{                                                       }
{         Copyright (c) 1997, 1999                      }
{                                                       }
{*******************************************************}

{$I VG.INC }
{$D-,L-}

unit vgConvEd;

interface

uses
  Classes, Graphics, Controls, Forms, vgItemEd, vgDBConv, Menus,
  StdCtrls;

type
  TConverterEditorForm = class(TItemEditorForm)
    miAdditems: TMenuItem;
    miNewItem: TMenuItem;
    miLine: TMenuItem;
    procedure miAdditemsClick(Sender: TObject);
    procedure miNewItemClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TConverterEditor = class(TItemListEditor)
  public
    function GetFormClass: TItemEditorFormClass; override;
  end;

var
  ConvertItems: TStrings = nil;
  
implementation
uses ConvAdd;

{$R *.DFM}

function TConverterEditor.GetFormClass: TItemEditorFormClass;
begin
  Result := TConverterEditorForm;
end;

procedure RegisterConvertClasses(const ConvertClasses: array of TDBConvertItemClass);
var
  I: Integer;
begin
  for I := Low(ConvertClasses) to High(ConvertClasses) do
    ConvertItems.AddObject(ConvertClasses[I].ClassName, TObject(ConvertClasses[I]));
end;


procedure TConverterEditorForm.miAdditemsClick(Sender: TObject);
begin
  EditConverter(TDBConverter(ItemList), FormDesigner);
end;

procedure TConverterEditorForm.miNewItemClick(Sender: TObject);
var
  Item: TDBConvertItem;
begin
  Item := TDBConvertItem(FormDesigner.CreateComponent(TDBConvertItem, TDBConverter(ItemList), 0, 0, 0, 0));
  try
    Item.DesignInfo := 0;
    Item.Converter := TDBConverter(ItemList);
    UpdateItems;
  except
    Item.Free;
    raise;
  end;
end;

initialization
  RegisterConvertItemsProc := RegisterConvertClasses;

  ConvertItems := TStringList.Create;

finalization
  ConvertItems.Free;

end.
