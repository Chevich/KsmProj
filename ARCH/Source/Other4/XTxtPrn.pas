Unit XTxtPrn;

Interface

Uses Classes, Windows, WinSpool, ppPrintr, Dialogs;

Const MaxLengthStr=272; { ¬ режиме сжатой элиты }
type
  TXTextPrinter = class;
{ TXTextCanvas }
  TXTextCanvas = class(TObject)
  private
    FBounds: TPoint;
    FPenPos: TPoint;
    FLines: TStrings;
    procedure SetLines(ALines: TStrings);
    function GetHeight: Integer;
    function GetWidth: Integer;
    function NewLine(aFillChar: Char): String;
    procedure AddLine(aFillChar: Char);
    function CheckHorzChar(X, Y: Integer; InpChar: Char): Char;
    function CheckVertChar(X, Y: Integer; InpChar: Char): Char;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ClearPage;
    procedure SetBounds(aWidth, aHeight: Integer);
    procedure MoveTo(X, Y: Integer);
    procedure TextOut(X, Y: Integer; const Text: string);
    procedure TextOutAlign(X1, X2, Y: Integer; const Text: String; Align: TAlignment);
    procedure TextDown(X, Y: Integer; const Text: string);
    procedure TextDownAlign(X, Y1, Y2: Integer; const Text: String; Align: TAlignment);
    procedure LineTo(X, Y: Integer; C: Char);
    property Height: Integer read GetHeight;
    property Width: Integer read GetWidth;
    property PenPos: TPoint read FPenPos write FPenPos;
    property Lines: TStrings read FLines write SetLines;
  end;
{ TXTextCanvas }

{ TXPrinterSetupDialog }

{Lev}
  {TXTextGetPrinterEvent = procedure(Sender: TObject; var aPrinter: TppPrinter) of object;}
{Lev}

  TXPrinterSetupDialog = class(TCommonDialog)
    private
      FPrinter: TXTextPrinter;
    public
      constructor Create(aOwner: TComponent); override;
      function Execute: Boolean; override;
      property Printer: TXTextPrinter read FPrinter write FPrinter;
    end;

{ TXTextPrinter }

  TXTextPrinter = class({TppCustomPrinter}TObject{TppPrinter})
  private
    FAborted: Boolean;
    FPrinting: Boolean;
    FStartPage: Boolean;
    FPageNumber: Longint;
    FIC: HDC;
    FDevMode: THandle;
    FPrinterHandle: THandle;
    FPDevMode: PDeviceMode;
    FPrinterName: String;
    FDocumentName: String;
    FPageGutters: TRect;
    FPixelsPerInch: TPoint;
    FPaperWidth: Longint;
    FPaperHeight: Longint;
    FPrintableHeight: Longint;
    FPrintableWidth: Longint;
    FPrinterSetup: TppPrinterSetup;
    FSizePrinterInfo2: Integer;
    FPrinterInfo2: PPrinterInfo2;
    FOnSetupChange: TNotifyEvent;
    FInitLine, FDoneLine: String;

    FBufferStr: Pointer;
    FCanvas: TXTextCanvas;

    procedure FreePrinterHandle;
    procedure FreeDevMode;
    function GetIC: HDC;
    function GetPDevMode: PDevMode;
    procedure FreeIC;
    procedure FreePrinterResources;
    function GetPrinterSetup: TppPrinterSetup;
    procedure SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
    procedure SetPrinterName(aPrinterName: String);
    function GetPrinterCapabilities: TppPrinterCapabilities;
{ Lev }
    procedure PrinterSetupChangeEvent(Sender: TObject);
(*
    procedure PrinterSetupGetPrinterEvent(Sender: TObject; var aPrinter: TppPrinter);
*)
{ Lev }
    procedure PrinterSetupToDevMode;
    function GetDocumentProperties: THandle;
    function GetPrinterDescription: String;
    function GetStockPaperSize: Word;
    function GetPaperDimensions: TPoint;
    function GetPrinterHandle: THandle;
    procedure PaperNameToDimensions(const aPaperName: String; var aPaperWidth, aPaperHeight: Single);
    procedure PaperDimensionsToName(aPaperWidth, aPaperHeight: Single; var aPaperName: String);
    function GetPageGutters: TRect;
    function GetPrinterInfo: TppPrinterInfo;
  protected
    property PDevMode: PDevMode read GetPDevMode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetDevMode(var aDevMode: THandle);
    procedure SetDevMode(aDevMode: THandle);
    procedure UpdateForm(const aFormName: String; aDimensions: TPoint; aPrintArea: TRect);
    procedure CalcPageDimensions;
    function ShowSetupDialog: Boolean;

    procedure BeginDoc;
    procedure EndDoc;
    procedure EndPage;
    procedure StartPage;
    procedure PrintStr(Str:string);
    procedure PrintAnsiStr(aStr:string; InitOrDownLine:boolean);
    procedure PrintAnsiStrings(Strings:TStrings);
    {Lev ”становка кол-ва копий на основе принт-диалога. ¬ыкручивалс€. }
    {¬роде теперь уже не нужна. 28.03.00}
 {Procedure SetDevModeCopies(aCopies:integer);}
    {}
    Property Canvas: TXTextCanvas read FCanvas;
    property PrinterHandle: THandle read GetPrinterHandle;
    property PrinterName: String read FPrinterName write SetPrinterName;
    property PrinterSetup: TppPrinterSetup read GetPrinterSetup write SetPrinterSetup;
    property PrinterCapabilities: TppPrinterCapabilities read GetPrinterCapabilities;
    property Printing: Boolean read FPrinting;
    property PrinterDescription: String read GetPrinterDescription;
    property DocumentName: String read FDocumentName write FDocumentName;
    property PageGutters: TRect read GetPageGutters;
    property IC: HDC read GetIC;
    property PrinterInfo: TppPrinterInfo read GetPrinterInfo;
    property InitLine: String read FInitLine write FInitLine;
    property DoneLine: String read FDoneLine write FDoneLine;
    property OnChange: TNotifyEvent read FOnSetupChange write FOnSetupChange;
  end;
{ TXTextPrinter }

var AAA: array[0..30] of string[162];
Implementation

Uses Messages, SysUtils, Controls, Printers, ppTypes, ppUtils, Forms, CommDlg;

{ TXTextCanvas }

Constructor TXTextCanvas.Create;
begin
  inherited;
  FLines:= TStringList.Create;
  FBounds.X:= 70;
  FBounds.Y:= 120;
  FPenPos.X:= 0;
  FPenPos.Y:= 0;
end;

Destructor TXTextCanvas.Destroy;
begin
  FLines.Free;
  FLines:=nil;
  Inherited;
end;

Procedure TXTextCanvas.SetLines(ALines: TStrings);
begin
  FLines.Assign(ALines);
end;

Function TXTextCanvas.GetHeight: Integer;
begin
  Result:=FBounds.Y;
end;

Function TXTextCanvas.GetWidth: Integer;
begin
  Result:=FBounds.X;
end;

Procedure TXTextCanvas.SetBounds(aWidth, aHeight: Integer);
{var i: Integer;}
begin
{  if (FBounds.X<>Value.X)or(FBounds.Y<>Value.Y) then begin
     end;}
{  if FBounds.Y<Value.Y then
     for i:= FBounds.Y+1 to Value.Y do AddLine
     else if FBounds.Y>Value.Y then
     for i:=Value.Y+1 to FBounds.Y do FLines.Delete(Value.Y+1);}
  FBounds.X:=aWidth;
  FBounds.Y:=aHeight;
end;

Function TXTextCanvas.NewLine(aFillChar: Char): String;
begin
  SetLength(Result, FBounds.X);
{Lev!!!} { ѕо-моему здесь можно ускорить, если присвоить Result:=—“–ќ ј »« ѕ–ќЅ≈Ћќ¬,}
         { которую расчитали где-то один раз                                        }
  {for i:=1 to FBounds.X do Result[i]:=aFillChar;}
  FillChar(Result[1],FBounds.X, aFillChar);
end;

Procedure TXTextCanvas.AddLine(aFillChar: Char);
begin
  FLines.Add(NewLine(aFillChar));
end;

Procedure TXTextCanvas.ClearPage;
begin
  FLines.Clear;
  {for i:=1 to FBounds.Y do AddLine;}
end;

Procedure TXTextCanvas.MoveTo(X, Y: Integer);
begin
  FPenPos.X:= X;
  FPenPos.Y:= Y;
end;

Function TXTextCanvas.CheckHorzChar(X, Y: Integer; InpChar: Char): Char;
var aUp, aDown: Boolean;
    aLeft, aRight: Boolean;
begin
  if InpChar<>'-' then Result:=InpChar
  else begin
    {while FLines.Count-1<Y+1 do AddLine;}
    aUp:=(Y>0) and (FLines[Y-1][X]='|');
    aLeft:=(X>1) and (FLines[Y][X-1]='-');
    aDown:=(Y+1<FBounds.Y) and (FLines.Count>=Y+2) and (FLines[Y+1][X]='|');
    aRight:=(X+1<FBounds.X) and (FLines[Y][X+1]='-');
    if aUp and aDown and aLeft and aRight then Result:= '+'
    else if aUp and aDown and aLeft then Result:='-'
         else if aUp and aDown and aRight then Result:='-'
              else if aUp and aDown then Result:='-'
                   else if aUp then Result:= '-'
                        else if aDown then Result:= '-'
                             else Result:='-';
  end;
end;

Function TXTextCanvas.CheckVertChar(X, Y: Integer; InpChar: Char): Char;
var aUp, aDown: Boolean;
    aLeft, aRight: Boolean;
begin
  if InpChar<>'|' then Result:= InpChar
  else begin
    {while FLines.Count-1<Y+1 do AddLine;}
    aUp:=(Y>0) and (FLines[Y-1][X]='|');
    aLeft:=(X>1) and (FLines[Y][X-1]='-');
    aDown:=(Y+1<FBounds.Y) and (FLines.Count>=Y+2) and (FLines[Y+1][X]='|');
    aRight:=(X+1<FBounds.X) and (FLines[Y][X+1]='-');
    if aUp and aDown and aLeft and aRight then Result:='+'
    else if aLeft and aRight and aUp then Result:= '-'
         else if aLeft and aRight and aDown then Result:= '-'
              else if aLeft and aRight then Result:= '-'
                   else if aLeft then Result:= '-'
                        else if aRight then Result:= '-'
                             else Result:='|';
  end;
end;

Procedure TXTextCanvas.TextOut(X, Y: Integer; const Text: string);
var S: String;
    i, X1: Integer;
begin
  if X=0 then X:=1;
  if (X < 1) or (X > FBounds.X) then Exit;
  while FLines.Count-1<Y+1 do AddLine(' ');
  S:=FLines[Y];
  X1:= X;
  for i:= 1 to Length(Text) do begin
    if Text[i]<>' ' then S[X1]:= Text[i];
    Inc(X1);
    if X1 > FBounds.X then Break;
  end;
  FLines[Y]:=S;
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
(*  AAA[Y]:=S; *)
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
  X1:=X;
  for i:= 1 to Length(Text) do begin
    if Text[i]<>' ' then S[X1]:=CheckHorzChar(X1, Y, Text[i]);
    Inc(X1);
    if X1 > FBounds.X then Break;
  end;
  FLines[Y]:=S;
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
(*  AAA[Y]:=S; *)
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
  Dec(X1);
  MoveTo(X1, Y);
end;

Procedure TXTextCanvas.TextOutAlign(X1, X2, Y: Integer; const Text: String; Align: TAlignment);
var S: String;
begin
  S:=ppFixText(Text, Abs(X2-X1+1), Align);
  TextOut(X1, Y, S);
end;

Procedure TXTextCanvas.TextDown(X, Y: Integer; const Text: string);
var S: String;
    i, Y1: Integer;
begin
  if (Y < 0) or (Y > FBounds.Y-1) then Exit;
  if X=0 then X:=1;
  while FLines.Count-1<Y+1 do AddLine(' ');
  Y1:= Y;
  for i:= 1 to Length(Text) do begin
    if Text[i]<>' ' then begin
      S:=FLines[Y1];
      S[X]:=Text[i];
      FLines[Y1]:=S;
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
(*    AAA[Y1]:=S; *)
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
    end;
    Inc(Y1);
    if Y1 > FBounds.Y then Break;
    while FLines.Count-1<Y1+1 do AddLine(' ');
  end;
  Y1:= Y;
  for i:= 1 to Length(Text) do begin
    if Text[i]<>' ' then begin
      S:=FLines[Y1];
      S[X]:=CheckVertChar(X, Y1, Text[i]);
      FLines[Y1]:=S;
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
(*    AAA[Y1]:=S; *)
(**** ƒЋя ќ“Ћјƒ »!!! ”ƒјЋ»“№ —“–” “”–” AAA!!! ****)
    end;
    Inc(Y1);
    if Y1 > FBounds.Y then Break;
  end;
  Dec(Y1);
  MoveTo(X, Y1);
end;

Procedure TXTextCanvas.TextDownAlign(X, Y1, Y2: Integer; const Text: String; Align: TAlignment);
var S: String;
begin
  S:=ppFixText(Text, Abs(Y2-Y1+1), Align);
  TextDown(X, Y1, S);
end;

Procedure TXTextCanvas.LineTo(X, Y: Integer; C: Char);
begin
end;

{ TXPrinterSetupDialog }

Constructor TXPrinterSetupDialog.Create(aOwner: TComponent);
begin
  Inherited Create(Application);
  FPrinter:=nil;
end;

var
{  FPrinters: TppPrinterList = nil;
  FPrinter: TppPrinter = nil;
  FNoPrinterInfo: TppPrinterInfo = nil;}
  HookCtl3D: Boolean;

Function ppDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
var lRect: TRect;
begin
  Result:=0;
  case Msg of
    WM_INITDIALOG:
      begin
        if HookCtl3D then begin
          Subclass3DDlg(Wnd, CTL3D_ALL);
          SetAutoSubClass(True);
        end;
        {center the window}
        GetWindowRect(Wnd, lRect);
        SetWindowPos(Wnd, 0, (GetSystemMetrics(SM_CXSCREEN) - lRect.Right  + lRect.Left) div 2,
                     (GetSystemMetrics(SM_CYSCREEN) - lRect.Bottom + lRect.Top)  div 3,
                     0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
      end;
    WM_DESTROY:
      if HookCtl3D then SetAutoSubClass(False);
  end;
end;

Function TXPrinterSetupDialog.Execute: Boolean;
var lPrintDlgRec: TPrintDlg;
    lPDevNames: PDevNames;
    lpDevice: PChar;
    lsPrinterName: String;
begin
  Result:=False;
  if (FPrinter=nil) then Exit;
  {initialize printer setup dialog info }
  FillChar(lPrintDlgRec, SizeOf(lPrintDlgRec), 0);
  {size of dialog structure}
  lPrintDlgRec.lStructSize:=SizeOf(lPrintDlgRec);
  {owner of dialog}
  lPrintDlgRec.hWndOwner:=Application.Handle;
  {printer DevMode}
  FPrinter.GetDevMode(lPrintDlgRec.hDevMode);
  {device, driver, port stuff }
  if (FPrinter.PrinterInfo <> nil) then
    FPrinter.PrinterInfo.GetDevNames(lPrintDlgRec.hDevNames);
  {set flags for printer setup dialog and for dialog hook}
  lPrintDlgRec.Flags:=PD_PRINTSETUP or PD_ENABLESETUPHOOK;
  {dialog hook - processes messages such as WM_INITDIALOG}
  lPrintDlgRec.lpfnSetupHook:=ppDialogHook;
{!Delphi3}
  lPrintDlgRec.hInstance:=SysInit.HInstance;
  HookCtl3D:=Ctl3D;
  {show printer setup dialog }
  Result:=TaskModalDialog(@PrintDlg, lPrintDlgRec);
  if Result then begin
    lPDevNames:=GlobalLock(lPrintDlgRec.hDevNames);
    try
      {get the name of the device returned}
      lpDevice:=PChar(lPDevNames)+lPDevNames^.wDeviceOffset;
      {get the printer name for this device }
      lsPrinterName:=ppPrinters.GetPrinterNameForDevice(StrPas(lpDevice));
      {set the new printer name
      note: PrinterName may be 'Default' so compare to PrinterDescription }
      if FPrinter.PrinterDescription<>lsPrinterName then
        FPrinter.PrinterName := lsPrinterName;
    finally
      GlobalUnLock(lPrintDlgRec.hDevNames);
      GlobalFree(lPrintDlgRec.hDevNames);
    end; {try, finally }
    if lPrintDlgRec.hDevMode<>0 then begin
      {update the printer's devmode }
      FPrinter.SetDevMode(lPrintDlgRec.hDevMode);
      GlobalFree(lPrintDlgRec.hDevMode);
    end;
  end else begin
    if lPrintDlgRec.hDevMode <> 0 then GlobalFree(lPrintDlgRec.hDevMode);
    if lPrintDlgRec.hDevNames <> 0 then GlobalFree(lPrintDlgRec.hDevNames);
  end;
end;

{ TXTextPrinter }

Function ppCopyHandle(aHandle: THandle): THandle;
var lpSource, lpDest: PChar;
    llSize: LongInt;
    lHandle: THandle;
begin
  Result:=0;
  if aHandle=0 then Exit;
  llSize:=GlobalSize(aHandle);
  lHandle:=GlobalAlloc(GHND, llSize);
  if lHandle <> 0 then
  try
    lpSource:=GlobalLock(aHandle);
    lpDest:=GlobalLock(lHandle);
    if (lpSource <> nil) and (lpDest <> nil) then
      Move(lpSource^, lpDest^, llSize);
  finally
    GlobalUnlock(aHandle);
    GlobalUnlock(lHandle);
  end;
  Result := lHandle;
end;

type
  TppPrinterSetupSelf = class(TPersistent)
  public
    FActive: Boolean;
    FBinName: String;
    FCollation: Boolean;
    FCopies: Integer;
    FDocumentName: String;
    FDuplex: TppDuplexType;
    FNewPageDef: TppPageDef;
    FOnGetPrinter: TppGetPrinterEvent;
    FOnPageDefChangeQuery: TppPageDefChangeQueryEvent;
    FOnPageDefChange: TNotifyEvent;
    FOnPrintJobChange: TNotifyEvent;
    FOrientation: TPrinterOrientation;
    FPageDef: TppPageDef;
    FPaperName: String;
    FPrinterName: String;
    FPrinterInfo: TppPrinterInfo;
    FOwner: TComponent;
    FUnits: TppUnitType;
  end;

Constructor TXTextPrinter.Create;
begin
  inherited Create;
  FPrinting:=False;
  FPrinterName:=cDefault;
  FDocumentName:='';
  FIC:=0;
  FDevMode:=0;
  FPDevMode:=nil;
  FPrinterHandle:=0;
  FPrinterSetup:=TppPrinterSetup.Create(nil);
  FPrinterSetup.Units:=utMillimeters;
  FOnSetupChange:=nil;

  FCanvas:=TXTextCanvas.Create;
  GetMem(FBufferStr,255);
  FInitLine:='';
  FDoneLine:='';
{ Lev }
(* — такими вот установками вроде работает более корректно, но *)

  FPrinterSetup.OnPageDefChange  := PrinterSetupChangeEvent;
  FPrinterSetup.OnPrintJobChange := PrinterSetupChangeEvent;
(*
  Ёто установить не удалось, т.к. нужно наследование от TppPrinter
  FPrinterSetup.FOnGetPrinter := PrinterSetupGetPrinterEvent;
*)
{ Lev }
end;

{ Lev 28.03.00 }
Procedure TXTextPrinter.PrinterSetupChangeEvent(Sender: TObject);
begin
  PrinterSetupToDevMode;
end; {procedure, PrinterSetupChangeEvent }

(*
Procedure TXTextPrinter.PrinterSetupGetPrinterEvent(Sender: TObject; var aPrinter: TppPrinter);
begin
  aPrinter := Self;
end; {procedure, PrinterSetupGetPrinterEvent }
*)

Destructor TXTextPrinter.Destroy;
begin
  FreeMem(FBufferStr,255);
  FCanvas.Free;
  FreePrinterResources;
  FPrinterSetup.Free;
  Inherited Destroy;
end;

Procedure TXTextPrinter.FreeDevMode;
begin
  if FDevMode=0 then Exit;
  GlobalUnlock(FDevMode);
  GlobalFree(FDevMode);
  FDevMode:=0;
  FPDevMode:=nil;
end;

Procedure TXTextPrinter.FreePrinterHandle;
begin
  if FPrinterHandle<>0 then begin
    ClosePrinter(FPrinterHandle);
    FPrinterHandle := 0;
  end;
end;

Procedure TXTextPrinter.FreeIC;
begin
  if FIC = 0 then Exit;
  DeleteDC(FIC);
  FIC := 0;
end;

Function TXTextPrinter.GetDocumentProperties: THandle;
var lStubDevMode: TDeviceMode;
    lPrinterInfo: TppPrinterInfo;
    llSizeDevMode: Longint;
begin
  Result:=0;
  if (FDevMode = 0) then begin
    {get printer info}
    lPrinterInfo:=ppPrinters.PrinterInfo[FPrinterName];
    if (lPrinterInfo=nil) then Exit;
    {get size of DevMode for this printer}
    llSizeDevMode:=DocumentProperties(0,PrinterHandle,lPrinterInfo.Device,lStubDevMode,lStubDevMode,0);
    {allocate gobal memory for DevMode }
    FDevMode:=GlobalAlloc(GHND, llSizeDevMode);
    if FDevMode<>0 then begin
      {lock the DevMode structure }
      FPDevMode:=GlobalLock(FDevMode);
      {get the current DevMode from the Printer}
      if (DocumentProperties(0,PrinterHandle,lPrinterInfo.Device,FPDevMode^,FPDevMode^,DM_OUT_BUFFER)<0) then
        FreeDevMode;
    end;
  end;
  Result:=FDevMode;
end;

Function TXTextPrinter.GetPDevMode: PDevMode;
begin
  GetDocumentProperties;
  Result := FPDevMode;
end;

Function TXTextPrinter.GetPrinterDescription: String;
begin
  if (FPrinterName=cDefault) then Result:=ppPrinters.DefaultPrinterName
  else Result:=FPrinterName;
end;

Function TXTextPrinter.GetStockPaperSize: Word;
var liIndex: Integer;
    lsPaperName: String;
begin
  FPrinterSetup.Active:=False;
  {search for the paper name}
  liIndex:=PrinterCapabilities.PaperNames.IndexOf(FPrinterSetup.PaperName);
  {if paper name not found, call PaperDimensionsToName which can search based on paper dimensions
   and return the PaperName if it finds a match }
  if liIndex < 0 then begin
    {FPrinterSetup.}PaperDimensionsToName(FPrinterSetup.PaperWidth, FPrinterSetup.PaperHeight, lsPaperName);
    FPrinterSetup.PaperName:=lsPaperName;
    if (lsPaperName='Custom') and (Win32Platform=VER_PLATFORM_WIN32_WINDOWS) then
      liIndex:=PrinterCapabilities.PaperSizes.Count-1
    else liIndex := PrinterCapabilities.PaperNames.IndexOf(FPrinterSetup.PaperName);
  end;
  {return the paper size}
  if (liIndex>=0) and (liIndex<PrinterCapabilities.PaperSizes.Count) then
    Result:=StrToInt(PrinterCapabilities.PaperSizes[liIndex])
  else Result:=256; {custom}
  FPrinterSetup.Active:=True;
end;

Function TXTextPrinter.GetPaperDimensions: TPoint;
begin
  FPrinterSetup.Active:=False;
  if FPrinterSetup.Orientation=poPortrait then begin
    Result.X:=Trunc(ppToMMTenths(FPrinterSetup.PaperWidth, FPrinterSetup.Units,
                    pprtHorizontal, Self));
    Result.Y:=Trunc(ppToMMTenths(FPrinterSetup.PaperHeight, FPrinterSetup.Units,
                    pprtVertical, Self));
  end else begin
    Result.X:=Trunc(ppToMMTenths(FPrinterSetup.PaperHeight, FPrinterSetup.Units,
                    pprtHorizontal, Self));
    Result.Y:=Trunc(ppToMMTenths(FPrinterSetup.PaperWidth, FPrinterSetup.Units,
                    pprtVertical, Self));
  end;
  FPrinterSetup.Active:=True;
end;

Function TXTextPrinter.GetPrinterHandle: THandle;
var lPrinterInfo: TppPrinterInfo;
begin
  if FPrinterHandle = 0 then begin
    lPrinterInfo:=ppPrinters.PrinterInfo[FPrinterName];
    if lPrinterInfo<>nil then
      OpenPrinter(lPrinterInfo.Device, FPrinterHandle, nil);
  end;
  Result:=FPrinterHandle;
end;

Procedure TXTextPrinter.FreePrinterResources;
begin
  if FPrinting then Exit;
  {free device context}
  FreeIC;
  {free device mode}
  FreeDevMode;
  {free printer handle}
  FreePrinterHandle;
end;

Function TXTextPrinter.GetIC: HDC;
var lPrinterInfo: TppPrinterInfo;
begin
  if FIC = 0 then begin
    lPrinterInfo:=ppPrinters.PrinterInfo[FPrinterName];
    if (lPrinterInfo <> nil) then begin
      FIC:=CreateIC(lPrinterInfo.Driver, lPrinterInfo.Device, lPrinterInfo.Port, PDevMode);
    {if FIC = 0 then
      RaiseError(SInvalidPrinter);  }
      CalcPageDimensions;
    end;
  end;
  Result := FIC;
end;

Function TXTextPrinter.GetPrinterCapabilities: TppPrinterCapabilities;
var lPrinterInfo: TppPrinterInfo;
begin
  lPrinterInfo:=ppPrinters.PrinterInfo[FPrinterName];
  if lPrinterInfo<>nil then Result := lPrinterInfo.Capabilities
  else Result:=nil;
end;

Procedure TXTextPrinter.PaperNameToDimensions(const aPaperName: String;
                                              var aPaperWidth, aPaperHeight: Single);
const Koef=1;
var llHeightInMM: Longint;
    llWidthInMM: Longint;
    liPaperIndex: Integer;
begin
  with TppPrinterSetupSelf(FPrinterSetup), FPrinterSetup do begin
    if (FPrinterInfo=nil) or (aPaperName=cCustom) then Exit;
    {set stock paper sizes for this paper name }
    liPaperIndex:=FPrinterInfo.Capabilities.PaperNames.IndexOf(aPaperName);
    if liPaperIndex>=0 then begin
      llWidthInMM:=StrToInt(FPrinterInfo.Capabilities.PaperWidths[liPaperIndex])*koef;
      llHeightInMM:=StrToInt(FPrinterInfo.Capabilities.PaperHeights[liPaperIndex]);
      if FOrientation=poPortrait then begin
        aPaperWidth:=ppFromMMTenths(llWidthInMM, FUnits, pprtHorizontal, Self);
        aPaperHeight:=ppFromMMTenths(llHeightInMM, FUnits, pprtVertical, Self);
      end else begin
        aPaperWidth:=ppFromMMTenths(llHeightInMM, FUnits, pprtHorizontal, Self);
        aPaperHeight:=ppFromMMTenths(llWidthInMM, FUnits, pprtVertical, Self)
      end;
    end;
  end;
end;

Procedure TXTextPrinter.PaperDimensionsToName(aPaperWidth, aPaperHeight: Single; var aPaperName: String);
var llHeightInMM: Longint;
    llWidthInMM: Longint;
    lbPaperFound: Boolean;
    lPrinterCapabilities: TppPrinterCapabilities;
    liPaperIndex: Integer;
begin
  with TppPrinterSetupSelf(PrinterSetup), PrinterSetup do begin
    if (FPrinterInfo = nil) then Exit;
    lPrinterCapabilities:=FPrinterInfo.Capabilities;
    {determine whether paper size is a stock size supported by the printer}
    lbPaperFound:=False;
    liPaperIndex:=0;
    llWidthInMM:=Trunc(ppToMMTenths(aPaperWidth,  FUnits, pprtHorizontal, Self));
    llHeightInMM:=Trunc(ppToMMTenths(aPaperHeight, FUnits, pprtVertical, Self));
    while not lbPaperFound and (liPaperIndex <= lPrinterCapabilities.PaperHeights.Count-1) do
    begin
      if (Abs((llHeightInMM-StrToInt(lPrinterCapabilities.PaperHeights[liPaperIndex])))<=10)
      and (Abs((llWidthInMM-StrToInt(lPrinterCapabilities.PaperWidths[liPaperIndex])))<=10) then
        lbPaperFound:=True
        {some printers (like dot matrix are reversed}
      else
        if (Abs((llWidthInMM-StrToInt(lPrinterCapabilities.PaperHeights[liPaperIndex])))<=10)
        and (Abs((llHeightInMM-StrToInt(lPrinterCapabilities.PaperWidths[liPaperIndex])))<=10) then
          lbPaperFound:=True
        else Inc(liPaperIndex);
    end;
    {set paper name}
    if lbPaperFound and (liPaperIndex<lPrinterCapabilities.PaperNames.Count) then
      aPaperName:=lPrinterCapabilities.PaperNames[liPaperIndex]
    else aPaperName:=cCustom;
  end;
end;

Procedure TXTextPrinter.CalcPageDimensions;
var lPrintableSize, lOffSet: TPoint;
begin
  if FIC=0 then Exit;
  FPixelsPerInch.X:=GetDeviceCaps(FIC, LOGPIXELSX);
  FPixelsPerInch.Y:=GetDeviceCaps(FIC, LOGPIXELSY);
  FPaperWidth:=GetDeviceCaps(FIC, HorzRes);
  FPaperHeight:=GetDeviceCaps(FIC, VertRes);

  lPrintableSize.X:=GetDeviceCaps(FIC, PHYSICALWIDTH);
  lPrintableSize.Y:=GetDeviceCaps(FIC, PHYSICALHEIGHT);
  lOffSet.X:=GetDeviceCaps(FIC, PHYSICALOFFSETX);
  lOffSet.Y:=GetDeviceCaps(FIC, PHYSICALOFFSETY);
  FPrintableWidth:=lPrintableSize.X;
  FPrintableHeight:=lPrintableSize.Y;
  {compute gutters }
  FPageGutters.Left:=lOffSet.X;
  FPageGutters.Top:=lOffSet.Y;
  FPageGutters.Right:=FPaperWidth-FPageGutters.Left-FPrintableWidth;
  FPageGutters.Bottom:=FPaperHeight-FPageGutters.Top-FPrintableHeight;
end;

Procedure TXTextPrinter.SetPrinterName(aPrinterName: String);
begin
  if FPrinting then Exit;
  if (ppPrinters.PrinterInfo[FPrinterName]=ppPrinters.PrinterInfo[aPrinterName]) then Exit;
  FreePrinterResources;
  FPrinterName:=aPrinterName;
end;

{ ”становка кол-ва копий на основе принт-диалога }
{¬роде теперь уже не нужна. 28.03.00}
(*
Procedure TXTextPrinter.SetDevModeCopies(aCopies:integer);
var lDevMode: THandle;
    lPDevMode: PDeviceMode;
begin
  FPrinterSetup.Active:=False;
  GetDevMode(lDevMode);
  lPDevMode:=GlobalLock(lDevMode);
  if (lpDevMode=nil) then Exit;
  lPDevMode^.dmCopies:=aCopies;
  GlobalUnlock(lDevMode);
  SetDevMode(lDevMode);
  GlobalFree(lDevMode);
  FPrinterSetup.Active:=True;
end;
*)

Function TXTextPrinter.GetPrinterSetup: TppPrinterSetup;
var liIndex: Integer;
    lDevMode: THandle;
    lPDevMode: PDeviceMode;
    lrPaperWidth,
    lrPaperHeight: Single;
begin
  Result:=FPrinterSetup;
  FPrinterSetup.Active:=False;
  GetDevMode(lDevMode);
  lPDevMode:=GlobalLock(lDevMode);
  if (lpDevMode=nil) then Exit;
  if PrinterName<>FPrinterSetup.PrinterName then
    FPrinterSetup.PrinterName:=PrinterName;
  {if collating copies, report engine has to manually print multiple copies }
  if ((lPDevMode^.dmFields and DM_COPIES)>0) and not FPrinterSetup.Collation then
    FPrinterSetup.Copies:=lPDevMode^.dmCopies;
  {set duplex }
  if (lPDevMode^.dmFields and DM_DUPLEX)>0 then
    FPrinterSetup.Duplex:=TppDuplexType(lPDevMode^.dmDuplex-1);
  {set orientation}
  if (lPDevMode^.dmFields and DM_ORIENTATION)>0 then
    FPrinterSetup.Orientation:=TPrinterOrientation(lPDevMode^.dmOrientation-1);
   {set paper size}
  if (lPDevMode^.dmFields and DM_PAPERSIZE)>0 then begin
    liIndex:=PrinterCapabilities.PaperSizes.IndexOf(InttoStr(lPDevMode^.dmPaperSize));
    if (liIndex >= 0) and (liIndex < PrinterCapabilities.PaperNames.Count) then begin
      FPrinterSetup.PaperName:=PrinterCapabilities.PaperNames[liIndex];
      if FPrinterSetup.Orientation=poPortrait then begin
        lrPaperWidth:=lPDevMode^.dmPaperWidth;
        lrPaperHeight:=lPDevMode^.dmPaperLength;
      end else begin
        lrPaperWidth:=lPDevMode^.dmPaperLength;
        lrPaperHeight:=lPDevMode^.dmPaperWidth;
      end;
      {
      lrPaperWidth:=lPDevMode^.dmPaperWidth;
      lrPaperHeight:=lPDevMode^.dmPaperLength;
      }
      PaperNameToDimensions(FPrinterSetup.PaperName, lrPaperWidth, lrPaperHeight);
      FPrinterSetup.PaperWidth:=lrPaperWidth;
      FPrinterSetup.PaperHeight:=lrPaperHeight;
    end;
  end;
  {if custom, set PaperLength, PaperWidth}
  if (lPDevMode^.dmPaperSize>=256) then
    if FPrinterSetup.Orientation=poPortrait then begin
      FPrinterSetup.PaperWidth:=ppFromMMTenths(lPDevMode^.dmPaperWidth,FPrinterSetup.Units,
                                               pprtHorizontal, Self);
      FPrinterSetup.PaperHeight:=ppFromMMTenths(lPDevMode^.dmPaperLength,FPrinterSetup.Units,
                                               pprtVertical, Self);
    end else begin
      FPrinterSetup.PaperWidth:=ppFromMMTenths(lPDevMode^.dmPaperLength,FPrinterSetup.Units,
                                               pprtHorizontal, Self);
      FPrinterSetup.PaperHeight:=ppFromMMTenths(lPDevMode^.dmPaperWidth,FPrinterSetup.Units,
                                               pprtVertical, Self);
    end;
  {set paper bin, if needed}
  if (lPDevMode^.dmFields and DM_DEFAULTSOURCE)>0 then begin
    liIndex:=PrinterCapabilities.Bins.IndexOf(IntToStr(lPDevMode^.dmDefaultSource));
    if (liIndex>=0) and (liIndex<PrinterCapabilities.BinNames.Count) then
      FPrinterSetup.BinName:=PrinterCapabilities.BinNames[liIndex];
  end;
  GlobalUnlock(lDevMode);
  GlobalFree(lDevMode);
  FPrinterSetup.Active:=True;
end;

Procedure TXTextPrinter.SetPrinterSetup(aPrinterSetup: TppPrinterSetup);
begin
  {optimization}
  if FPrinterSetup.IsEqual(aPrinterSetup) then Exit;
  FPrinterSetup.Active:=False;
  {when printing, do not allow printername to change}
  if Printing and (FPrinterSetup.PrinterDescription <> aPrinterSetup.PrinterDescription) then
    aPrinterSetup.PrinterName:=FPrinterSetup.PrinterName;
  FPrinterSetup.Assign(aPrinterSetup);
  {translate to printer device mode settings}
  PrinterSetupToDevMode;
  FPrinterSetup.Active:=True;
end;

Procedure TXTextPrinter.GetDevMode(var aDevMode: THandle);
begin
  aDevMode:=ppCopyHandle(GetDocumentProperties);
end;

Procedure TXTextPrinter.SetDevMode(aDevMode: THandle);
begin
  {update the printer with the latest DevMode info }
  FreeDevMode;
  FDevMode:=ppCopyHandle(aDevMode);
  FPDevMode:=GlobalLock(FDevMode);
end;

Procedure TXTextPrinter.PrinterSetupToDevMode;
var lPaperDimensions: TPoint;
    lImageableArea: TRect;
    liIndex: Integer;
    lDevMode: THandle;
    lPDevMode: PDeviceMode;
    Savi: Integer;
begin
  FPrinterSetup.Active:=False;
  if (PrinterDescription<>FPrinterSetup.PrinterDescription) then
    PrinterName:=FPrinterSetup.PrinterName;
  DocumentName:=FPrinterSetup.DocumentName;
  GetDevMode(lDevMode);
  lPDevMode:=GlobalLock(lDevMode);
  if (lPDevMode=nil) then Exit;
  {for Custom size paper on WinNT, need to add/modify a Form named Custom}
  if (Win32Platform=VER_PLATFORM_WIN32_NT) and (FPrinterSetup.PaperName = cCustom) then begin
    {convert paper dimensions to MMThousandths }
    if FPrinterSetup.Orientation = poPortrait then begin
      lPaperDimensions.X:=ppToMMThousandths(FPrinterSetup.PaperWidth, FPrinterSetup.Units,
                                            pprtHorizontal, Self);
      lPaperDimensions.Y:=ppToMMThousandths(FPrinterSetup.PaperHeight, FPrinterSetup.Units,
                                            pprtVertical, Self);
    end else begin
      lPaperDimensions.X:=ppToMMThousandths(FPrinterSetup.PaperHeight, FPrinterSetup.Units,
                                            pprtHorizontal, Self);
      lPaperDimensions.Y:=ppToMMThousandths(FPrinterSetup.PaperWidth, FPrinterSetup.Units,
                                            pprtVertical, Self);
    end;
    lImageableArea.Left:=0;
    lImageableArea.Top:=0;
    lImageableArea.Right:=lPaperDimensions.X;
    lImageableArea.Bottom:=lPaperDimensions.Y;
    UpdateForm(FPrinterSetup.PaperName,lPaperDimensions,lImageableArea);
  end;
     { WIN95 }            {'–азмеры, определ€емые пользователем'}
  if (Win32Platform=VER_PLATFORM_WIN32_WINDOWS) and
  (FPrinterSetup.PaperName=cCustom) then begin
    PrinterCapabilities.PaperWidths[PrinterCapabilities.PaperSizes.Count-1]:=
      IntToStr(Round(FPrinterSetup.PaperWidth/InchPerMM)*10);
    PrinterCapabilities.PaperHeights[PrinterCapabilities.PaperSizes.Count-1]:=
      IntToStr(Round(FPrinterSetup.PaperHeight/InchPerMM)*10);
  end;
  {set dmFields}
  lPDevMode^.dmFields:=DM_COPIES or DM_DUPLEX or DM_ORIENTATION or DM_PAPERSIZE;
  {if collating copies, report engine has to manually print multiple copies }
  if FPrinterSetup.Collation then lPDevMode^.dmCopies:=1
  else lPDevMode^.dmCopies:=FPrinterSetup.Copies;
{Lev ќ“Ћјƒ ј}
{lPDevMode^.dmCopies:=2;}
{Lev ќ“Ћјƒ ј}
  {set duplex & orientation}
  lPDevMode^.dmDuplex:=Ord(FPrinterSetup.Duplex)+1;
  lPDevMode^.dmOrientation:=(Ord(FPrinterSetup.Orientation)+1);
  {set paper size}
  lPDevMode^.dmPaperSize:=GetStockPaperSize;
  {if custom, set PaperLength, PaperWidth}
  if {(lPDevMode^.dmPaperSize >= 256)or}(FPrinterSetup.PaperName = cCustom) then begin
    Savi:=lPDevMode^.dmPaperSize;
    lPDevMode^.dmPaperSize := 256;
    lPDevMode^.dmFields:=lPDevMode^.dmFields or DM_PAPERLENGTH or DM_PAPERWIDTH;
    lPaperDimensions:=GetPaperDimensions;
    lPDevMode^.dmPaperWidth:=lPaperDimensions.X;
    lPDevMode^.dmPaperLength:=lPaperDimensions.Y;
{   lPDevMode^.dmPaperSize := Savi;}
  end;
  {set paper bin, if needed}
  if (FPrinterSetup.BinName <> cCurrent) then begin
    liIndex:=PrinterCapabilities.BinNames.IndexOf(FPrinterSetup.BinName);
    if (liIndex>= 0) and (liIndex<PrinterCapabilities.Bins.Count) then begin
      lPDevMode^.dmDefaultSource:=StrToInt(PrinterCapabilities.Bins[liIndex]);
      lPDevMode^.dmFields:=lPDevMode^.dmFields or DM_DEFAULTSOURCE;
    end;
  end;
  GlobalUnlock(lDevMode);
  SetDevMode(lDevMode);
  GlobalFree(lDevMode);
  FPrinterSetup.Active:=True;
end;

Procedure TXTextPrinter.UpdateForm(const aFormName: String; aDimensions: TPoint;
                                   aPrintArea: TRect);
const FormLevel: Byte=1;
var liSizeOfInfo: DWord;
    lFormInfo: TFormInfo1;
    lpNewFormInfo, lpCurrentFormInfo: PFormInfo1;
begin
  if not (Win32Platform in [VER_PLATFORM_WIN32_NT]) then Exit;
  {initialize the FormInfo data structure}
  with lFormInfo do begin
    Flags:=0; {indicates form is not built-in}
    pName:=PChar(aFormName);
    Size.cx:=aDimensions.X;
    Size.cy:=aDimensions.Y;
    ImageableArea.Left:=aPrintArea.Left;
    ImageableArea.Top:=aPrintArea.Top;
    ImageableArea.Right:=aPrintArea.Right;
    ImageableArea.Bottom:=aPrintArea.Bottom;
  end;
  lpNewFormInfo:=@lFormInfo;
  liSizeOfInfo:=0;
  {get size of PrinterInfo buffer needed }
  GetForm(PrinterHandle, PChar(aFormName), FormLevel, nil, 0, liSizeOfInfo);
  {allocate required memory}
  GetMem(lpCurrentFormInfo, liSizeOfInfo);
  try
    {get form info}
    if GetForm(PrinterHandle, PChar(aFormName), FormLevel, lpCurrentFormInfo, liSizeOfInfo, liSizeOfInfo) then
      {set existing form's dimensions}
      Winspool.SetForm(PrinterHandle, PChar(aFormName), FormLevel, lpNewFormInfo)
    else
      {add a new form with required dimensions }
      Winspool.AddForm(PrinterHandle, FormLevel, lpNewFormInfo);
  finally
    FreeMem(lpCurrentFormInfo, liSizeOfInfo);
  end;
end;

Procedure TXTextPrinter.BeginDoc;
var AJobName: array[0..31] of Char;
    ADocInfo1: TDocInfo1;
begin
  if FPrinting then Exit;
  FPrinting:=True;
  FAborted:=False;
  FPageNumber:=0;
  FStartPage:=False;
  if PrinterHandle=0 then raise EInOutError.Create('ќшибка при подключении к принтеру');
  WinSpool.GetPrinter(FPrinterHandle,2,nil,0,@FSizePrinterInfo2);
  GetMem(FPrinterInfo2, FSizePrinterInfo2);
  if not WinSpool.GetPrinter(FPrinterHandle,2,FPrinterInfo2,FSizePrinterInfo2,
    @FSizePrinterInfo2) then raise EInOutError.Create('ќшибка при подключении к принтеру');
  StrPLCopy(AJobName, FDocumentName, SizeOf(AJobName) - 1);
  ADocInfo1.pDocName:=AJobName;
  ADocInfo1.pOutPutFile:=nil;
  ADocInfo1.pDatatype:=nil;
  if WinSpool.StartDocPrinter(FPrinterHandle,1,@ADocInfo1)=0 then
    raise EInOutError.Create('ќшибка при открытии документа дл€ принтера');
  GetIC;
  StartPage;
end;

Procedure TXTextPrinter.EndDoc;
begin
  if not FPrinting then Exit;
  EndPage;
  {if FDoneLine<>'' then PrintStr(FDoneLine);}
  if not FAborted then
    if not EndDocPrinter(FPrinterHandle) then
      raise EInOutError.Create('ќшибка при закрытии документа');
  FreePrinterHandle;
  FreeIC;
  FPrinting:=False;
  FStartPage:=False;
  FAborted:=False;
  FPageNumber:=0;
end;

Procedure TXTextPrinter.StartPage;
begin
  if not FPrinting or FStartPage then Exit;
  FStartPage:=True;
  Inc(FPageNumber);
  Canvas.ClearPage;
end;

{ Lev 21.12.98 параметр BegI устанавливаетс€ в 1 если InitLine=''   }
{ что позвол€ет избежать вывода 1-й пустой строки при печати бланка }
{ автотранспортной накладной                                        }
Procedure TXTextPrinter.EndPage;
var PLen: DWord;
    Rez: Boolean;
    Str: String;
    i: Integer;
    BegI:byte;
begin
  if not FPrinting or not FStartPage then Exit;
  FStartPage:=False;
  if FInitLine<>'' then begin
    PrintAnsiStr(FInitLine,true);
    {FInitLine:='';}
    BegI:=0;
  end else BegI:=1;
  { ѕри i=0 печатаем FInitLine }
  for i:=BegI{0} to Canvas.Lines.Count-{1}2 do PrintAnsiStr(Canvas.Lines[i], false);
  {if Canvas.Lines[Canvas.Lines.Count-1]}
  { ѕри i=Count-1 печатаем FDoneLine }
  if FDoneLine<>'' then
    if FDoneLine=#12 then PrintAnsiStr(FDoneLine,true)
    else PrintAnsiStr(FDoneLine+#13#10,true);
  {else Str:=#12;}
  if not WritePrinter(FPrinterHandle, PChar(Str), Length(Str), PLen) then
    raise EInOutError.Create('ќшибка конца страницы');
end;

Procedure TXTextPrinter.PrintStr(Str:string);
var StrT:string;
    PLen:dword;
begin
  StrT:=Str{+#13#10};
  if not WritePrinter(FPrinterHandle, PChar(StrT), Length(StrT), PLen) then begin
{!?    Ultimate;}
    raise EInOutError.Create('ќшибка при печати на принтер');
  end;
end;

Procedure TXTextPrinter.PrintAnsiStr(aStr:string; InitOrDownLine:boolean);
var StrT:string; plen:dword;
    N: Integer;

  procedure Char2OEM;
  begin
    if not InitOrDownLine then begin
      if Length(aStr)>MaxLengthStr then CharToOEMBuff(PChar(aStr),FBufferStr,MaxLengthStr)
      else CharToOEM(PChar(aStr),FBufferStr);
      StrT:=StrPas(FBufferStr)+#13#10;
    end else StrT:=aStr;
    {
    if FInitLine<>'' then begin
      StrT:= FInitLine;
      FInitLine:='';
    end;
    if FDoneLine<>'' then begin
      StrT:= FDoneLine;
      FDoneLine:='';
    end;
    }
  end;

begin
  N:= Length(aStr);
  while (N>0) and (aStr[N]=' ') do Dec(N);
  SetLength(aStr, N);
  Char2OEM;
  if not WritePrinter(FPrinterHandle, PChar(StrT), Length(StrT), PLen) then begin
{    Ultimate;}
    raise EInOutError.Create('ќшибка при печати на принтер');
  end;
end;

Procedure TXTextPrinter.PrintAnsiStrings(Strings:TStrings);
var i:integer;
begin
  for i:=0 to Strings.Count-1 do PrintAnsiStr(Strings[i],false);
end;

Function TXTextPrinter.GetPageGutters: TRect;
begin
  {call GetIC which will create a IC and CalcPageDimensions, if needed }
  GetIC;
  Result := FPageGutters;
end;

Function TXTextPrinter.ShowSetupDialog: Boolean;
var lSetupDlg: TXPrinterSetupDialog;
begin
  lSetupDlg:=TXPrinterSetupDialog.Create(Application);
  lSetupDlg.Printer:=Self;
  Result:=lSetupDlg.Execute;
  lSetupDlg.Free;
  if Result and Assigned(FOnSetupChange) then FOnSetupChange(Self);
end;

Function TXTextPrinter.GetPrinterInfo: TppPrinterInfo;
begin
  Result:=ppPrinters.PrinterInfo[FPrinterName];
end;

end.
