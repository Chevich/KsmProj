Var BitsPerPixel:byte;

Procedure InitBitsPerPixel;
var R:TRegistry;
begin
  R:=TRegistry.Create;
  with R do begin
    RootKey:=HKEY_CURRENT_USER;
    if not R.OpenKey('Display\Settings',False) then begin {если flase то пытается откpыть не создавая}
      RootKey:=HKEY_CURRENT_CONFIG;
      R.OpenKey('Display\Settings', False);
    end;
    BitsPerPixel:=StrToInt(ReadString('BitsPerPixel'));
  end;
  R.Free;
End;
