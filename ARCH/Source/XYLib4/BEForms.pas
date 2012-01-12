Unit BEForms;

Interface

Uses
  XDBForms, XMisc, StdCtrls, ExtCtrls, Controls, Grids, DBGrids, EtvGrid,
  XECtrls, ComCtrls, Classes, Forms, EtvContr, EtvPages,SrcIndex, Menus, Graphics,
  Buttons, DB, DBCtrls;

(*
Const
  а)Все возможные красивые значения Color для выделения ЦВЕТА ФОНА строк в Gride.
  б)Все возможные красивые значения Color для выделения ЦВЕТА ШРИФТА строк в Gride.
  Идентификаторы констант должны примерно отображать значение цветового оттенка
  http://www.colorfor.narod.ru/ - калькулятор цветов
  То, что калькулятор насчитал в 16-ричном виде берем для цвета запись наоборот побайтно
  и впереди добавляем 00, т.е., например, там есть цвет:
  Вишневый - d6|2b|60, а мы берем: Color:=$00|60|2b|d6 { Разделители "|" для лучшего визуального восприятия} 
  типа Светло-зеленый light-green=$XXXXXXXXX...
                     
  Цвета для Grid'а
  ligth-turquoise=$00FAFEE7 { Светло-Бирюзовый }
  $0099ff99 { Салатовый }
  $00DEEDDF { Серо-салатовый }
  $00E1FAFA { Светло-лимонный }
  $00FFDDDD { Сиреневый - для ячейки Grid'а }
  $00b5295a { Сиреневый - для шрифта }
  $00DDE1F3 { Светло-розовый }
  $00FEFAE7 { Светло-серо-голубой}
  $0099CCFF {  RGB 255,204,153 - персиковый }
  $00BBF8FD { Светло-лимонный еще один }
  $00CDE1EB { Мой любимый кофе с молоком }
*)

Type

{ TBForm }

  TBEForm = class(TXDBForm)
    PageControl1: TXDBPageControl;
    Grid: TXEDbGrid;
    GridSheet: TEtvTabSheet;
    PageControl1Panel: TLinkPanel;
    PageControl1PanelIndexCombo: TLinkIndexCombo;
    PageControl1PanelNavigator: TLinkNavigator;
    PageControl1TabPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormResize(Sender: TObject);
    procedure FormDblClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
(*
    procedure SetDefaultGridColor(Sender: TObject; Field: TField; var Color: TColor);
    procedure SetDefaultGridFont(Sender: TObject; Field: TField; Font: TFont);
*)
{    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);}

  private
  public
    Scroll:TScrollBox;
    GridColor:TColor;
  end;
  var BitsPerPixel:smallint;
(*
      MarkGridColor: TColor;
      MarkGridFontColor: TColor;
*)
Implementation

Uses Windows, SysUtils, Dialogs, XTFC, EtvPas, Misc;

{$R *.DFM}

{ TBEForm }

Procedure TBEForm.FormCreate(Sender: TObject);
begin
  Inherited;
  {Еще один колор для грида $00E4FDC4 - светло-бирюзовый}
  if BitsPerPixel>=16 then GridColor:=$00CDE1EB else GridColor:=clInfoBk;
  Grid.Color:=GridColor;
  { Открываем на весь экран независимо от разрешения }
  { Эта механизма работает, если }
  if Sender.ClassName='TBEForm' then begin
    Left:=0;
    Top:=0;
    Width:=Screen.Width-60;
    Height:=Screen.Height;
  end;
  {Grid.OnSetColor:=SetGridColor;}
(*
  // Установка шрифта в Grid в зависимости от разрешения экрана
  case Screen.Width of
    640: Grid.Font.Size:=8;
    800: Grid.Font.Size:=9;
    1024:Grid.Font.Size:=9;
    1152:Grid.Font.Size:=10;
    1280:Grid.Font.Size:=10;
  end;
  Grid.TitleFont.Size:=Grid.Font.Size-1;
*)
  {AMScaleForm(self);}
End;

Procedure TBEForm.FormActivate(Sender: TObject);
var Tabs:TTabSheet;
    OnlyVisibleFields:boolean;
    LabelFont:TFont;
Function CreateLabelFont:TFont;
begin
  Result:=TFont.Create;
  with Result do begin
    Name:='Arial';
    Size:=9;
    Style:=[fsItalic];
  end;
end;

Begin
  Inherited;
  {Exit;}
(*
  if Assigned(FormControl) and not(csDesigning in FormControl.ComponentState) then
    TFormControl(FormControl).FormTools.Update;
*)
  if Self.ClassName<>'TBEForm' then Exit;
{  if ((Not AutoWidth(EtvDBGrid.Canvas.TextWidth('0'),45)) and}
  LabelFont:=CreateLabelFont;
  try
    if (PageControl1.PageCount=1) then begin
      { (foPageOneRecord in Options) then begin}
      GridSheet.TabVisible:=true;
      Tabs:=TTabSheet.Create(Self);
      Tabs.Caption:='Форма';
      Tabs.PageControl:=PageControl1;
      Tabs.Width:=PageControl1.Width;
      Tabs.Name:='FormSheet';
      Scroll:=TScrollBox.Create(Self);
      Scroll.Align:=alClient;
      Scroll.Width:=PageControl1.Width-8;
      Scroll.ParentFont:=false;
      with Scroll.Font do begin
        {Name:='';}
        Size:=10;
        Style:=[];
      end;
      Tabs.InsertControl(Scroll);
      ConstructOneRecordEdit(Scroll, Grid.DataSource, LabelFont, GridColor, false, true);
      { Чтобы при активизации активной была форма }
      {PageControl1.ActivePage:=Tabs;}
      {Grid.Columns.RebuildColumns;}
    end;
    if Self.Tag>0 then begin
      { Перестраиваем страничку "Форма" }
      Scroll.DestroyComponents;
      if Self.Tag=8 then OnlyVisibleFields:=true
      else OnlyVisibleFields:=false;
      ConstructOneRecordEdit(Scroll, Grid.DataSource, LabelFont, GridColor, false, OnlyVisibleFields);
      Self.Tag:=0;
    end;
  finally
    LabelFont.free;
  end;
  {}
end;

procedure TBEForm.FormDeactivate(Sender: TObject);
begin
  inherited;
{}
end;

procedure TBEForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
{}
end;

{
procedure TBEForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Assigned(Scroll) and Scroll.Focused then begin
    DataSrcKeyDown(Grid.DataSource,Key,Shift);
  end;
end;
}

procedure TBEForm.FormResize(Sender: TObject);
begin
  if PageControl1.TabHeight < PageControl1TabPanel.Height then
    PageControl1.TabHeight := PageControl1TabPanel.Height;
  PageControl1PanelNavigator.Height:=PageControl1PanelIndexCombo.Height;
  PageControl1PanelIndexCombo.Width:=Self.Width div 2;
  PageControl1PanelNavigator.Left:=PageControl1PanelIndexCombo.Width+1;
  PageControl1PanelNavigator.Width:=PageControl1Panel.Width-PageControl1PanelIndexCombo.Width;
  if Assigned(FormControl) and not(csDesigning in FormControl.ComponentState) then
    TFormControl(FormControl).FormTools.Update;
end;

procedure TBEForm.FormDblClick(Sender: TObject);
begin
  if Assigned(FormControl) and not(csDesigning in FormControl.ComponentState) then
    TFormControl(FormControl).FormTools.Update;
end;

procedure TBEForm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var i:integer;

function KeyPressed(VKey: Integer): LongBool;
asm
  push eax
  call GetKeyState
  and eax, 0080h
  shr al, 7
end;

begin
(*
  for i:=0 to 255 do
    if not (i in[16,17,18,160..165]) and KeyPressed(i) then ShowMessage('Ку-ку '+IntToStr(i));
*)
  case Key of
    190: {Обработка комбинации Ctrl+Shift+'>'}
      if Shift=[ssCtrl,ssShift] then begin
        with Grid do begin
          if Font.Size<30 then Font.Size:=Font.Size+1;
          if TitleFont.Size<30 then TitleFont.Size:=TitleFont.Size+1;
        end;
      end;
    188: {Комбинация Ctrl+Shift+'<'}
      if Shift=[ssCtrl,ssShift] then begin
        with Grid do begin
          if Font.Size>6 then Font.Size:=Font.Size-1;
          if TitleFont.Size>6 then TitleFont.Size:=TitleFont.Size-1;
        end;
      end;
  end;
end;
(*
procedure TBEForm.SetDefaultGridColor(Sender: TObject; Field: TField; var Color: TColor);
Const MaxChars=70;
var aCharBuffer: array[0..MaxChars] of Char;
    i: integer;
begin
  {FillChar(aCharBuffer,MaxChars,#0);}
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxChars);
  {Заменяем символ #0 на пробел }
  for i:=0 to MaxChars do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i],32);
  if Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0 then Color:=$00B4FEFE
    else if Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0 then Color:=$00D5FFFE
      else if Pos('+ ',aCharBuffer)>0 then Color:=$00D2F2F7//$00F4F5D8
        else Color:=TDBGrid(Sender).Color;
  {if Copy(ClientBuildingGrodnoRealDeclarClientName.AsString,1,5)='Всего' then Color:=$00D5FFFE;}
  // $00FFF8E6; //$00CCEACC;//$00C6FDD8;//$00C6CDFD;//$00A0CD8F;//$00C6DDA4
end;

procedure TBEForm.SetDefaultGridFont(Sender: TObject; Field: TField; Font: TFont);
Const MaxChars=255;
var aCharBuffer: array[0..MaxChars] of Char;
    i: byte;
begin
  Move(Field.DataSet.ActiveBuffer^,aCharBuffer,MaxChars);
  {Заменяем символ #0 на пробел }
  for i:=0 to MaxChars do if aCharBuffer[i]=#0 then Inc(aCharBuffer[i],32);
  if (Pos('ИТОГО',AnsiUpperCase(aCharBuffer))>0) or (Pos('ВСЕГО',AnsiUpperCase(aCharBuffer))>0) then begin
    Font.Style:=[fsBold];
    Font.Color:=MarkGridFontColor;
  end
end;
*)
Initialization
  RegisterAliasXForm(fcDBDefaultClass, TBEForm);
  BitsPerPixel:=GetBitsPerPixel;
  (*MarkGridFontColor:=clPurple;*)
Finalization
  UnRegisterXForm(TBEForm);
end.
