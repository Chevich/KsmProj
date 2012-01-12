unit Misc;

interface
Uses Forms;

// расширяет форму на всю рабочую область
procedure AMScaleForm(MForm: TForm; WithPanel: boolean);

(*
AP> Hедавно пришлось столкнуться с "особенностями" работы
AP> функции Round при включенной опции $N+ (к примеру, Round(0.5)=0).
В свое вpемя тоже наткнyлся на этy пpоблемy. Hасколько я понимаю, это BUG сопpоцессоpа.
Дело в том, что Round пpи N+ pеализyется (см. we87.asm из RTL) командой FISTP, котоpая по
непонятным (для меня) пpичинам непpавильно окpyгляет числа +/- 0.5, 2.5, 4.5 и т.д.
Лечится это пpинyдительной yстановкой наименее значащего бита мантиссы
(тогда какое-нибyдь 0.49999999 тоже "окpyглится" до 1, но это скоpее всего не опасно):
*)
Function MRound(E: Extended { любой вещ. тип, кpоме Real } ): Int64;

{ **** UBPFD *********** by delphibase.endimus.com ****
>> Быстрые функции сжатия пробелов и управляющих символов в строке.

Функции удаляют из строки начальные и конечные пробелы и управляющие символы (меньшие пробела).
Идущие подряд пробелы и управляющие символы в середине строки заменяются одним пробелом.

Зависимости: нет
Автор:       Александр Шарахов, alsha@mailru.com, Москва
Copyright:   Александр Шарахов
Дата:        2 февраля 2003 г.
***************************************************** }

// SpaceCompress удаляет из Ansi-строки начальные и конечные пробелы
// и управляющие символы (меньшие пробела). Идущие подряд пробелы
// и управляющие символы в середине строки заменяются одним пробелом.
// Исходная строка при этом не изменяется. Эта функция работает
// медленнее, чем Sha_SpaceCompressInplace. С целью ускорения работы
// освобождение неиспользуемой памяти за пределами строки не производится.
// Если это критично, после вызова данной функции можно освободить память
// следующим образом: s2:=Sha_SpaceCompress(s1); SetLength(s2,Length(s2));
// Функция не работает, если нарушен формат Ansi-строки, в частности,
// если в конце строки отсутствует терминатор.
Function SpaceCompress(const s: string): string;

// SpaceCompressInplace удаляет из Ansi-строки начальные и конечные пробелы
// и управляющие символы (меньшие пробела). Идущие подряд пробелы
// и управляющие символы в середине строки заменяются одним пробелом.
// Результат замещает исходную строку. С целью ускорения работы
// освобождение неиспользуемой памяти за пределами строки не производится.
// Если это критично, после вызова данной функции можно освободить память
// следующим образом: SpaceCompressInpace(s); SetLength(s,Length(s));
// Процедура не работает, если нарушен формат Ansi-строки, в частности,
// если в конце строки отсутствует терминатор.
Procedure SpaceCompressInplace(var s: string);

// SpaceCompressPChar удаляет из null-terminated строки начальные
// и конечные пробелы и управляющие символы (меньшие пробела), за исключением
// терминатора. Идущие подряд пробелы и управляющие символы в середине строки
// заменяются одним пробелом. Результат замещает исходную строку.
// Никакое перераспределения памяти не производится.
// Функция не работает с read-only строкой.
Function SpaceCompressPChar(p: pchar): pchar;

Function GetLocalIP: String;
Function IPAddressToNetworkName(IPAddr: string): string;
Function GetSystemComputerName: string;

Implementation
Uses Windows,Winsock,SysUtils,Classes,Controls,ExtCtrls,Math,DBGrids;
type PInteger=^integer;
     TCClass = class(TControl); //used to resize

procedure AMScaleForm(MForm: TForm; WithPanel: boolean);
const
  cPixelsPerInch: integer = 96; //designtime PPI
  cFontHeight: integer = -11; //designtime Font.Height
var
  vMaxFormWidth, vMaxFormHeight, vOldFormWidth, vOldFormHeight, i: integer;
  vWidthRatio, vHeightRatio: double;
  rcWork:TRect;
  vPanelWidth, vGridFontSize: byte;
  vPanel: TPanel;
  vOnResize: TNotifyEvent;

begin
  vPanelWidth := 64; // Panel width
  vOnResize:=MForm.OnResize;
  if not WithPanel then vPanelWidth:=0;
  MForm.OnResize:=nil;

  //get workarea
  SystemParametersInfo (SPI_GETWORKAREA, 0, @rcWork, 0);
  vOldFormWidth := MForm.ClientWidth;
  vOldFormHeight := MForm.ClientHeight;
  vMaxFormWidth := rcWork.Right - rcWork.Left - vPanelWidth - (MForm.Width - MForm.ClientWidth) {- Round(Power(Byte(MForm.BorderStyle),4)*1.6)};
  vMaxFormHeight := rcWork.Bottom - rcWork.Top - (MForm.Height - MForm.ClientHeight) - Round(Power(Byte(MForm.BorderStyle),3.5)*1.00) { Поправка на ветер :)};

  {vWidthRatio := vMaxFormWidth/MForm.Width;
  vHeightRatio := vMaxFormHeight/MForm.Height;}

  vWidthRatio := vMaxFormWidth/vOldFormWidth;
  vHeightRatio := vMaxFormHeight/vOldFormHeight;

  // Дополнительная корректировка Lev 23.02.2010
  {vMaxFormWidth := Round(vMaxFormWidth+(MForm.Width - MForm.ClientWidth)*(1-vWidthRatio));}
  {vMaxFormHeight :=Round(vMaxFormHeight+(MForm.Height - MForm.ClientHeight)*(1-vHeightRatio));}

  //move left-top
  MForm.Left := rcWork.Left;
  MForm.Top := rcWork.Top;

  //resize form
  if (vOldFormWidth <> vMaxFormWidth) or (vOldFormHeight <> vMaxFormHeight) or
     (Screen.PixelsPerInch <> cPixelsPerInch) then begin
     //count new size of form
     MForm.Scaled := True;

     // screen dimensions are changed unproportional
     if (vWidthRatio < vHeightRatio) then begin
        MForm.ScaleBy(vMaxFormWidth, vOldFormWidth);
        MForm.ClientWidth := vMaxFormWidth;
        MForm.ClientHeight := Floor(vOldFormHeight*vWidthRatio);
     end else begin
        MForm.ScaleBy(vMaxFormHeight, vOldFormHeight);
        MForm.ClientHeight := vMaxFormHeight;
        MForm.ClientWidth := Floor(vOldFormWidth*vHeightRatio);
        {MForm.ClientHeight := vMaxFormHeight;}
     end;
  end;

  // Установка шрифта в Grid'ах в зависимости от разрешения экрана
  case Screen.Width of
    640..799: vGridFontSize:=8;
    800..1151: vGridFontSize:=9;
    1152..1439: vGridFontSize:=10;
    1440..1599: vGridFontSize:=10;
    1600..2000: vGridFontSize:=11;
  end;

  for i:= MForm.ComponentCount - 1 downto 0 do begin
    if (MForm.Components[i] is TDBGrid) then with TDBGrid(MForm.Components[i]) do begin
       Font.Size:=vGridFontSize;
       Font.Name := 'Arial';
       TitleFont.Size:=vGridFontSize-1;
       TitleFont.Name := 'Arial Narrow';
       TitleFont.Color := $00A00000;
    end;
  end;
  //resize font height
  if (Screen.PixelsPerInch <> cPixelsPerInch) then begin
     for i := MForm.ControlCount - 1 downto 0 do begin
           TCClass(MForm.Controls[i]).Font.Height :=
                (MForm.Font.Height div cFontHeight) * TCClass(MForm.Controls[i]).Font.Height;
     end;
  end;
  MForm.OnResize:=vOnResize;
end;

Function MRound(E: Extended { любой вещ. тип, кpоме Real } ): Int64;
var E1: Extended;
begin
(*
  asm
    or byte ptr E, 1
  end;
*)
  //E1:=E+(Byte(E>0)-1/2)*2*0.0001;
  if E>0 then
    E1:=E+0.0001
  else E1:=E-0.0001;
  MRound:=Round(E1);
end;

Function SpaceCompress(const s: string): string;
var
  p, q, t: pchar;
  ch: char;
label
  rt;
begin;
  p:=pointer(s);
  q:=nil;
  if p<>nil then begin;
    t:=p+(pinteger(p-4))^;
    if p<t then begin;
      repeat;
        dec(t);
        if p>t then goto rt;
      until (t^>#32);
      SetString(Result,nil,(t-p)+1);
      q:=pchar(pointer(Result));
      repeat;
        repeat;
          ch:=p^;
          inc(p);
        until ch>#32;
        repeat;
          q^:=ch;
          ch:=p^;
          inc(q);
          inc(p);
        until ch<=#32;
        q^:=#32;
        inc(q);
      until p>t;
    end;
  end;
rt:
  if q<>nil then begin;
    dec(q);
    q^:=#0;
    (pinteger(pchar(pointer(Result))-4))^:=q-pointer(Result);
  end
  else Result:='';
end;

Procedure SpaceCompressInplace(var s: string);
var
  p, q, t: pchar;
  ch: char;
label
  rt;
begin;
  UniqueString(s);
  p:=pointer(s);
  if p<>nil then begin;
    t:=p+(pinteger(p-4))^;
    if p<t then begin;
      q:=p;
      repeat;
        dec(t);
        if p>t then goto rt;
        until (t^>#32);
      repeat;
        repeat;
          ch:=p^;
          inc(p);
          until ch>#32;
        repeat;
          q^:=ch;
          ch:=p^;
          inc(q);
          inc(p);
          until ch<=#32;
        q^:=#32;
        inc(q);
        until p>t;
      dec(q);
rt: q^:=#0;
      (pinteger(pchar(pointer(s))-4))^:=q-pointer(s);
      end;
    end;
end;

Function SpaceCompressPChar(p: pchar): pchar;
var
  q: pchar;
  ch: char;
label
  rt;
begin;
  Result:=p;
  if (p<>nil) and (p^<>#0) then begin;
    q:=p-1;
    repeat;
      repeat;
        ch:=p^;
        inc(p);
        if ch=#0 then goto rt;
        until ch>#32;
      inc(q);
      repeat;
        q^:=ch;
        ch:=p^;
        inc(q);
        inc(p);
        until ch<=#32;
      q^:=#32;
      until ch=#0;
rt: if q<Result then inc(q);
    q^:=#0;
    end;
end;

Function GetLocalIP: String; // http://www.sql.ru/forum/actualthread.aspx?tid=290959 Спасибо людям добрым
const WSVer = $101;
var
  WSAData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result:= '';
  if WSAStartup(WSVer, wsaData) = 0 then begin
    if GetHostName(@Buf, 128) = 0 then begin
      P:= GetHostByName(@Buf);
      if P <> nil then Result:= iNet_ntoa(PInAddr(p^.h_addr_list^)^);
    end;
    WSACleanup;
  end;
end;

Function IPAddressToNetworkName(IPAddr: string): string;
var
  SockAddrIn: TSockAddrIn;
  HostEnt: PHostEnt;
  WSAData: TWSAData;
begin
  WSAStartup($101, WSAData);
  SockAddrIn.sin_addr.s_addr := inet_addr(PChar(IPAddr));
  HostEnt:= gethostbyaddr(@SockAddrIn.sin_addr.S_addr, 4, AF_INET);
  if HostEnt <> nil then
    Result:= StrPas(Hostent^.h_name)
  else Result:= '';
end;
// Пример: ShowMessage(IPAddressToNetworkName('ХХХ.ХХХ.ХХХ.ХХХ'));

Function GetSystemComputerName: string;
var ComputerName: array[0..60] of Char;
    ComputerNameSize: DWORD;
begin
  ComputerNameSize:= 60;
  if Windows.GetComputerName(@ComputerName, ComputerNameSize) then
    Result:= string(ComputerName)
  else
    Result:= '';
end;

end.

