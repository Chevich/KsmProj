unit EtvPas;

interface

uses Classes, Windows, Graphics, Forms;
{$I Etv.Inc}

Function SForm(const s:string; n:integer; Align:TAlignment
     {$IFDEF Delphi4}; aNumber:boolean=false {$ENDIF} ):string;
function NForm(const S:string; N:integer):string;
function SymbRepeat(const S:string; N:integer):string;
type CharSet=Set of char;
const RussianCharSet=['а'..'я','А'..'Я'];
      FiguresCharSet=['0'..'9'];
      Letters=['a'..'z','A'..'Z']+RussianCharSet;
function CutFirstWord(Str:string; ExtSymbols:CharSet):string;
function CutFirstWordExt(var Num:integer; Str:string; ExtSymbols:CharSet):string;
function ToWord(Num:integer; Str:string; ExtSymbols:CharSet):string;
function ChangeSymbol(Str:string;Source,Target:Char):string;
(* Translate "Surname Firs_Name Second_Name" в "Surname F.S."*)
function SmallFio(fio:string):string;

function Oem2Char(const s:string):string;

procedure KeyReturn(Sender: TObject; var Key: Word; Shift: TShiftState);

procedure ChangeKeyBoardLayout(ALayout:string);
function CreateEtvProcess(Name,Info:string; Wait,Hide:boolean):dWord;
Function  GetOwnerForm(aComponent: TComponent): TForm;

function ObjectStrProp(aObject:TObject; aProperty:string):string;
function SetObjectStrProp(aObject:TObject; aProperty,aValue:string):boolean;
procedure CopyObjectMethodProps(aSource,aTarget:TObject);

procedure GetFontSizes(aFont: TFont; var aWidth, aHeight: Integer; Text:string);

function CloneComponent(aComp:TComponent):TComponent;

Function GetBitsPerPixel:smallint;

IMPLEMENTATION

uses TypInfo, SysUtils, Controls, Messages,
     EtvConst;

Function SForm(const s:string; n:integer; Align:TAlignment
     {$IFDEF Delphi4}; aNumber:boolean=false {$ENDIF} ):string;
var L:integer;
begin
  if n=0 then begin Result:=''; exit; end;
  L:=Length(s);
  if L>=N then
    {$IFDEF Delphi4}
    if aNumber and (L>N) then Result:=sForm('*****',n,taCenter)
    else
    {$ENDIF}
    Result:=Copy(S,1,n)
  else begin
    SetLength(Result,n);
    fillChar(Result[1],n,' ');
    if L>0 then
      case Align of
        taLeftJustify: Move(s[1],Result[1],L);
        taRightJustify: Move(S[1],Result[n-Length(s)+1],L);
        taCenter: Move(S[1],Result[(n-Length(s)) div 2+1],L);
      end;
  end;
end;

function NForm;
begin
  if n=0 then begin Result:=''; exit; end;
  Result:=s;
  while Length(Result)<n do
    Result:='0'+Result;
  if Length(Result)>n then
    Result:=copy(Result,Length(Result)-n+1,n);
end;

function SymbRepeat;
begin
  if n=0 then begin Result:=''; exit; end;
  Result:=s;
  while Length(Result)<n do
    Result:=Result+s;
  if Length(Result)>n then
    Result:=copy(Result,1,n);
end;

function CutFirstWordExt(var Num:integer; Str:string; ExtSymbols:CharSet):string;
begin
  while (Num<=Length(Str)) and (Str[Num]<=' ') do Inc(Num);
  Result:=CutFirstWord(copy(Str,Num,length(Str)),ExtSymbols);
  Num:=Num+Length(Result);
end;

function CutFirstWord(Str:string; ExtSymbols:CharSet):string;
var i:smallint;
begin
  for i:=1 to length(Str) do
    if Not ((Str[i] in ['_','a'..'z','A'..'Z']) or
            (Str[i] in ExtSymbols)) then begin
      Result:=copy(Str,1,i-1);
      Exit;
  end;
  Result:=copy(Str,1,Length(str));
end;

function ToWord(Num:integer; Str:string; ExtSymbols:CharSet):string;
begin
  Result:='';
  while (Num<=Length(Str)) and
        ((Str[Num]<=' ') or (Str[Num] in ExtSymbols)) do begin
    Result:=Result+Str[Num];
    Inc(Num);
  end;
end;

function ChangeSymbol(Str:string;Source,Target:Char):string;
var i:integer;
begin
  Result:=Str;
  if Source<>Target then
    for i:=1 to length(Result) do
      if Result[i]=Source then Result[i]:=Target;
end;

function SmallFio(fio:string):string;
var i:integer;
    s:string;
begin
  i:=1;
  Result:=CutFirstWordExt(i,fio,RussianCharSet);
  ToWord(i,s,['.']);
  s:=CutFirstWordExt(i,fio,RussianCharSet);
  if Length(s)>0 then begin
    Result:=Result+' '+s[1]+'.';
    ToWord(i,s,['.']);
    s:=CutFirstWordExt(i,fio,RussianCharSet);
    if Length(s)>0 then Result:=Result+s[1]+'.';
  end;
end; (* of SmallFio *)

Function Oem2Char(const S:string):string;
var p:pointer;
begin
  if s<>'' then begin
    GetMem(P,length(S)+1);
    OEMToChar(PChar(s),P);
    Result:=StrPas(P);
    freeMem(P,length(S)+1);
  end else Result:='';
end;

type TWinControlSelf = class(TWinControl);

procedure KeyReturn(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key=VK_Return) then
    PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_Tab,0);
(*
  { Обработчик для случая наличия события NewRecord и позиционирования в определенный столбец при работе с Grid'ом Lev 12.02.2010 }
  { Позже решил этот код оставить в EtvGrid, так будет лучше 18.02.2010 }
  { Появились проблемы при работе с фильтрами }
  if (Sender is TDBGrid) and (Key=VK_DOWN) then
    PostMessage(TWinControl(Sender).Handle,WM_KeyDown,VK_DOWN,0);
*)
end;

procedure ChangeKeyBoardLayout(ALayout:string);
var Layout: array[0.. KL_NAMELENGTH] of char;
begin
  if ALayout<>'' then
    LoadKeyboardLayout(StrPCopy(Layout,ALayout),KLF_ACTIVATE);
end;

function CreateEtvProcess(Name,Info:string; Wait,hide:boolean):dword;
Var
  StartupInfo: TStartupInfo;
  ProcessInformation: TProcessInformation;
begin
  Result:=0;
  fillChar(StartupInfo,Sizeof(StartupInfo),0);
  StartupInfo.cb:=sizeof(StartupInfo);
  StartupInfo.dwFlags:= StartupInfo.dwFlags or STARTF_USESHOWWINDOW;
  if hide then StartupInfo.wShowWindow:= SW_Hide
  else StartupInfo.wShowWindow:= SW_show;

  if not CreateProcess(nil, pchar(Name),nil,nil,false,
    HIGH_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation)
  then raise Exception.Create(SCantRun+' '+Info+' / '+Name);
  if wait then with ProcessInformation do begin
   WaitForSingleObject(hProcess, INFINITE);
   GetExitCodeProcess(hProcess, Result);
  end;
end;

function  GetOwnerForm(aComponent : TComponent) : TForm;
var Tmp:TComponent;
begin
  Tmp := aComponent;
  while (not (Tmp.Owner is TForm)) and (Tmp.Owner<>nil) do
    Tmp := Tmp.Owner;
  Result := pointer(Tmp.Owner);
end;

function ObjectStrProp(AObject:TObject; aProperty:string):string;
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(AObject.ClassInfo,aProperty);
  if (PropInfo<>nil) then
    Result:=GetStrProp(AObject,PropInfo)
  else Result:='';
end;

function SetObjectStrProp(AObject:TObject; aProperty,aValue:string):boolean;
var PropInfo: PPropInfo;
begin
  PropInfo := GetPropInfo(AObject.ClassInfo,aProperty);
  if (PropInfo<>nil) then begin
    SetStrProp(AObject,PropInfo,aValue);
    Result:=true;
  end else Result:=false;
end;

procedure CopyObjectMethodProps(aSource,aTarget:TObject);
var i,PropCount:integer;
    PropInfo:PPropInfo;
    PropList:PPropList;
    Method:TMethod;
begin
  PropCount:=GetTypeData(aSource.ClassInfo)^.PropCount;
  GetMem(PropList,PropCount*SizeOf(PPropInfo));
  try
    GetPropInfos(aSource.ClassInfo,PropList);
    for i:=0 to PropCount-1 do begin
      PropInfo:=PropList^[i];
      if PropInfo^.PropType^.Kind=tkMethod then begin
        Method:=GetMethodProp(aSource, PropInfo);
        PropInfo:=GetPropInfo(aTarget.ClassInfo,PropInfo^.Name);
        if PropInfo<>nil then SetMethodProp(aTarget,PropInfo,Method);
      end;
    end;
  finally
    FreeMem(PropList,PropCount*SizeOf(PPropInfo));
  end;
end;

procedure GetFontSizes(aFont: TFont; var aWidth, aHeight: Integer; Text:string);
var lBitmap: Graphics.TBitmap;
begin
  lBitmap := Graphics.TBitmap.Create;
  lBitmap.Canvas.Font := aFont;
  if Text='' then begin
    aWidth   := lBitmap.Canvas.TextWidth('0');
    aHeight  := lBitmap.Canvas.TextHeight('W');
  end else begin
    aWidth   := lBitmap.Canvas.TextWidth(Text);
    aHeight  := lBitmap.Canvas.TextHeight(Text);
  end;
  lBitmap.Free;
end;

function CloneComponent(aComp:TComponent):TComponent;
var Stream:TStream;
begin
  Stream:=TMemoryStream.Create;
  try
    Stream.WriteComponent(aComp);
    Classes.RegisterClass(TComponentClass(aComp.ClassType));
    Stream.Position:=0;
    Result:=Stream.ReadComponent(nil);
  finally
    Stream.Free;
  end;
end;

Function GetBitsPerPixel:smallint;
var DC:HDC;
begin
  DC := GetDC(0);
  try
    Result:=GetDeviceCaps(DC, BITSPIXEL);
  finally
    ReleaseDC(0, DC);
  end;
end;

end.
