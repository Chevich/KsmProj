Var BitsPerPixel:byte;

Procedure InitBitsPerPixel;
var R:TRegistry;
begin
  R:=TRegistry.Create;
  with R do begin
    RootKey:=HKEY_CURRENT_USER;
    if not R.OpenKey('Display\Settings',False) then begin {���� flase �� �������� ���p��� �� ��������}
      RootKey:=HKEY_CURRENT_CONFIG;
      R.OpenKey('Display\Settings', False);
    end;
    BitsPerPixel:=StrToInt(ReadString('BitsPerPixel'));
  end;
  R.Free;
End;
