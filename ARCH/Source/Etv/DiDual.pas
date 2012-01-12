unit DiDual;

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons;

type
  TEtvDualListDlg = class(TForm)
    SrcList: TListBox;
    DstList: TListBox;
    SrcLabel: TLabel;
    DstLabel: TLabel;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure SetButtons;
    procedure ListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ListKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure MoveItem(List:TListBox; Index:integer);
  end;

implementation
{$R *.DFM}

procedure TEtvDualListDlg.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

procedure TEtvDualListDlg.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

procedure TEtvDualListDlg.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I], 
      SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
end;

procedure TEtvDualListDlg.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
end;

procedure TEtvDualListDlg.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then
    begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

procedure TEtvDualListDlg.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
end;

function TEtvDualListDlg.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then Exit;
  Result := LB_ERR;
end;

procedure TEtvDualListDlg.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  with List do
  begin
    SetFocus;
    MaxIndex := List.Items.Count - 1;
    if Index = LB_ERR then Index := 0
    else if Index > MaxIndex then Index := MaxIndex;
    Selected[Index] := True;
  end;
  SetButtons;
end;

procedure TEtvDualListDlg.ListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if TListBox(Source).SelCount=0 then Accept:=false
  else
    if TListBox(Source).SelCount>1 then begin
      if Source<>Sender then TListBox(Source).DragCursor := crMultiDrag
      else Accept:=false;
    end else TListBox(Source).DragCursor := crDrag;
end;

procedure TEtvDualListDlg.MoveItem(List:TListBox; Index:integer);
begin
  if List.SelCount=1 then begin
    if Index<0 then Index:=List.Items.Count-1;
    if Index>List.Items.Count-1 then Index:=0;
    if Index <> GetFirstSelection(List) then begin
      List.Items.Move(GetFirstSelection(List), Index);
      SetItem(List, Index);
    end;
  end;  
end;

procedure TEtvDualListDlg.ListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if Sender=Source then
    MoveItem(TListBox(Source),TListBox(Source).ItemAtPos(Point(X, Y),true))
  else if Source=DstList then ExcludeBtnClick(SrcList)
    else IncludeBtnClick(DstList);
end;

procedure TEtvDualListDlg.ListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and ((Key=VK_DOWN) or (Key=VK_UP)) then begin
    if Key=VK_UP then
      MoveItem(TListBox(Sender),TListBox(Sender).ItemIndex-1)
    else MoveItem(TListBox(Sender),TListBox(Sender).ItemIndex+1);
    Key:=0;
  end;
end;

procedure TEtvDualListDlg.FormActivate(Sender: TObject);
begin
  SetButtons;
end;

procedure TEtvDualListDlg.ListKeyPress(Sender: TObject; var Key: Char);
var FSearchText: string;
    ll:Longint;
begin
  case Key of
    #32..#255:
      begin
(*
        FSearchText:=Key;
        ll:=Longint(PChar(FSearchText));
*)
        {SendMessage(DstList.Handle, LB_SelectString,-1,LL);}
        {DstList.Perform(LB_SELECTSTRING,-1,LongInt(Pchar(FSearchText)));}
        with TListBox(Sender) do
          ItemIndex:=Perform(LB_FINDSTRING,ItemIndex,Longint(PChar(String(Key))));
        Key := #0;
      end;
  end;
end;

end.
