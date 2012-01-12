program Transfer;
{$APPTYPE CONSOLE}
uses
  SysUtils, Windows, Classes,FileCtrl;

var
  inDir,XOutDir,Mask:String;
  Found,i:Integer;
  SearchRec:TSearchRec;
  FileDate,MaxDate:TDateTime;
  MAxFile:TFileName;

procedure PrepareFile(FileName:TFileName;StringLength:Integer);
var
  F: TextFile;
  S: string;
  SL:TStringList;
  MAx, i: Integer;
Begin
  SL:=TStringList.Create(); SL.Clear;
  AssignFile(F, FileName);
  Reset(F); Max:=0;
  while not eof(f) do
    begin
      Readln(F, S); SL.ADD(s);
      if Length(s)>MAX then Max:=Length(s)
    end;
  if StringLength<>0 then Max:=StringLength;
  CloseFile(F);
  AssignFile(F, FileName);
  ReWrite(F);
  for i:=0 to SL.Count-1 do
    begin
      s:=sl.Strings[i];
      s:=s+StringOfChar(' ',Max-Length(s));
      WriteLn(F,s);
    end;
  CloseFile(F);
end;

function Oem(inString:String):String ;
var Msg:array [1..255] of char;
    PMsg:PChar;
begin
  PMsg:=@Msg;
  CharToOem(PChar(inString),PMsg);
  result:=String(PMsg);
end;

function RunISQL(CommandString:String):Boolean;
var
  PI:TPROCESSINFORMATION;
  SI:TSTARTUPINFO;
begin
  Result:=false;
  writeln(OEM('������ ISQL'));
  ZeroMemory(@si,sizeof(si));
  si.cb:=SizeOf(si);
  if not CreateProcess(nil,PChar('dbisqlc.exe -c "DSN=gksm;CharSet=cp866;UID=sta;PWD=ksm" -q '+CommandString),nil,nil,false,0,nil,nil,si,pi)
    then writeln('Error creation ISQ '+SysErrorMessage(GetLastError))
    else Result:=true;
  WaitForSingleObject(pi.hProcess,INFINITE);
  CloseHandle(pi.hProcess);
  CloseHandle(pi.hThread);
end;

procedure TransferS8();
begin
  writeln(Oem('��������� ����� �����'));
  try
    Found := FindFirst(inDir+'s8*.*', faArchive, SearchRec);
    while Found=0 do
      Begin
        if (FileExists(XOutDir+'Cur.txt'))and (not SysUtils.DeleteFile(XOutDir+'Cur.txt')) then begin
          Writeln(Oem('�� ���� ������� ����!'+XOutDir+'Cur.txt'));
          raise EInOutError.CreateFmt('�� ��������� %s',[xOutDir+'Cur.txt'])
        end;
        if not RenameFile(inDir+SearchRec.Name, XOutDir+'Cur.txt') then
          begin
            writeln(OEM(SearchRec.Name+' - �� ����������������� - '+xOutDir+'Cur.txt'));
            raise EInOutError.CreateFmt('%s - �� ����������������� - � %s',[inDir+SearchRec.Name,xOutDir+'Cur.txt'])
          end;
        if Not(FileExists(XOutDir+'Cur.Txt')) then Halt(1);
        PrepareFile(XOutDir+'cur.txt',0);
        RunISQL('c:\GKSMDB\SQL\Bank\tempcur.sql');
        Found := FindNext(SearchRec);
      end;
  sysutils.findclose(SearchRec);
  except
    on E:Exception do
      writeln(Oem(E.Message));
  end;
end;

procedure TransferRat();
begin
  try
   writeln(Oem('������������� ����� �����'));
    try
      StrToDate(ParamStr(i+1));
      inc(i);
      Mask:=ParamStr(i)[1]+ParamStr(i)[2]+
           ParamStr(i)[4]+ParamStr(i)[5]+
           copy(ParamStr(i),7,4)+'.rat';
    except
      Mask:='*.rat'
    end;
   Found := FindFirst(xOutDir+'*.rat', faArchive, SearchRec);
    while Found=0 do
      begin
        if (FileExists(XOutDir+'rat.txt'))and (not SysUtils.DeleteFile(XOutDir+'Rat.txt')) then begin
          Writeln(Oem('�� ���� ������� ����!'+XOutDir+'rat.txt'));
          raise EInOutError.CreateFmt('�� ��������� %s',[xOutDir+'rat.txt'])
        end;
        if not RenameFile(XoutDir+SearchRec.Name, XOutDir+'rat.txt') then
          begin
            writeln(OEM(SearchRec.Name+' - �� ����������������� - '+inDir+'rat.txt'));
            raise EInOutError.CreateFmt('%s - �� ����������������� - � %s',[xoutDir+SearchRec.Name,xOutDir+'rat.txt'])
          end;
        if Not(FileExists(XOutDir+'rat.Txt')) then Halt(1);
        PrepareFile(XOutDir+'rat.txt',0);
        RunISQL('c:\GKSMDB\SQL\Bank\tempcurend.sql');
        Found := FindNext(SearchRec);
      end;
  sysutils.findclose(SearchRec);
  except
    on E:Exception do
      writeln(Oem(E.Message));
  end;
end;

procedure TransferVba();
begin
  try
    writeln(Oem('��������� ���������'));
    MaxDate:=0;
    try
      StrToDate(ParamStr(i+1));
      inc(i);
      Mask:=ParamStr(i)[1]+ParamStr(i)[2]+
           ParamStr(i)[4]+ParamStr(i)[5]+
           copy(ParamStr(i),7,4)+'.vba';
    except
      Mask:='*.vba'
    end;
    Found := FindFirst(XOutDir+Mask, faArchive, SearchRec);
    while Found=0 do
      begin
        FileDate:=FileDateToDateTime(SearchRec.Time);
        if MaxDate<FileDate then begin
          MaxDate:=FileDate;
          MaxFile:=SearchRec.Name;
        end;
        Found := FindNext(SearchRec);
      end;
    if MaxFile<>'' then begin
      if (FileExists(XOutDir+'vba.txt'))and (not SysUtils.DeleteFile(XOutDir+'vba.txt')) then begin
        Writeln(Oem('�� ���� ������� ����!'+XOutDir+'vba.txt'));
        raise EInOutError.CreateFmt('�� ��������� %s',[xOutDir+'vba.txt'])
      end;
      CopyFile(PChar(xOutDir+MaxFile),PChar(xOutDir+'vba.txt'),false);
      if Not(FileExists(XOutDir+'vba.txt')) then
        raise EInOutError.CreateFmt('%s - �� ����������������� - � %s',[xoutDir+SearchRec.Name,xOutDir+'vba.txt']);
      PrepareFile(XOutDir+'vba.txt',0);
      RunISQL('c:\GKSMDB\SQL\Bank\tempkart.sql');
    end;
    sysutils.findclose(SearchRec);
  except
    on E:Exception do
      writeln(Oem(E.Message));
  end;
end;

procedure TransferPay(Count:String);
begin
  try
  writeln(Oem('��������� �������'));
  if Count<>'' then inc(i);
  try
    StrToDate(ParamStr(i+1));
    Mask:=ParamStr(i+1)[1]+ParamStr(i+1)[2]+
         ParamStr(i+1)[4]+ParamStr(i+1)[5]+
         copy(ParamStr(i+1),7,4)+'.out';
  except
    Mask:='*.out'
  end;
  Found := FindFirst(XOutDir+Mask, faArchive, SearchRec);
  while Found=0 do
    begin
      if (FileExists(XOutDir+Mask))and (not SysUtils.DeleteFile(XOutDir+'out.txt')) then begin
        Writeln(Oem('�� ���� ������� ����!'+XOutDir+'out.txt'));
        raise EInOutError.CreateFmt('�� ��������� %s',[xOutDir+'out.txt'])
      end;
      if not RenameFile(XoutDir+SearchRec.Name, XOutDir+'out.txt') then
        begin
          writeln(OEM(SearchRec.Name+' - �� ����������������� - '+inDir+'out.txt'));
          raise EInOutError.CreateFmt('%s - �� ����������������� - � %s',[xoutDir+SearchRec.Name,xOutDir+'vba.txt']);
        end;
      if Not(FileExists(XOutDir+'out.Txt')) then Halt(1);
      PrepareFile(XOutDir+'out.txt',219);
      RunISQL('c:\GKSMDB\SQL\Bank\temppay.sql');
      Found := FindNext(SearchRec);
    end;
  sysutils.findclose(SearchRec);

  writeln(Oem('������� �� ������'));
    try
      StrToDate(ParamStr(i+1));
      inc(i);
      Mask:=ParamStr(i)[1]+ParamStr(i)[2]+
           ParamStr(i)[4]+ParamStr(i)[5]+
           copy(ParamStr(i),7,4)+'.rst';
    except
      Mask:='*.rst'
    end;
  Found := FindFirst(XOutDir+Mask, faArchive, SearchRec);
  while Found=0 do
    begin
      if (FileExists(XOutDir+'rst.txt'))and (not SysUtils.DeleteFile(XOutDir+'rst.txt')) then begin
        Writeln(Oem('�� ���� ������� ����!'+XOutDir+'rst.txt'));
        raise EInOutError.CreateFmt('�� ��������� %s',[xOutDir+'rst.txt'])
      end;
      if not RenameFile(XoutDir+SearchRec.Name, XOutDir+'rst.txt') then
        begin
          writeln(OEM(SearchRec.Name+' - �� ����������������� - '+inDir+'rst.txt'));
          raise EInOutError.CreateFmt('%s - �� ����������������� - � %s',[xoutDir+SearchRec.Name,xOutDir+'rst.txt']);
        end;
      if Not(FileExists(XOutDir+'rst.Txt')) then Halt(1);
      PrepareFile(XOutDir+'rst.txt',219);
      RunISQL('c:\GKSMDB\SQL\Bank\temprst.sql');
      Found := FindNext(SearchRec);
    end;
  sysutils.findclose(SearchRec);
  except
    on E:Exception do
      writeln(Oem(E.Message));
  end;
end;

procedure ShowHelp();
begin
  writeln(Oem('���������� ������: transfer [switches]'));
  writeln(Oem('switches ����� ���� ���������:'));
  writeln(Oem('dir path -��������� �������� path'));
  writeln(Oem('s8 -��������� ��������� ������ �����'));
  writeln(Oem('rat [date]-��������� ������������� ������ �����'));
  writeln(Oem('vba [date]-��������� ���������'));
  writeln(Oem('pay [date]-��������� �������'));
//  writeln(Oem('filename -��������� ����� � ������ � filename'));
  writeln(Oem('��� ���x ����������, ����� vba,'));
  writeln(Oem('�� ���������, ���� ����� ��������� �� ������� ����,'));
  writeln(Oem('�� �������������� ��� ��������� �����'));
  writeln(Oem('��� vba �������������� ��������� �� ���� ����'));
  writeln(Oem('������: transfer pay -���������� ��� �������'));
  writeln(Oem('        transfer pay 01.04.2007 -���������� ������� �� 01.04.2007'));
  writeln(Oem('        transfer dir x:\bank_must_die\ ���������� ������� x:\bank_must_die\'))
end;

begin
  //������ ���������� ������
  inDir:='c:\Client\In\'; XOutDir:='c:\Client\Xout\';
  writeln(Oem('������ ������!')); I:=1;

  if ParamCount=0 then begin
    TransferS8();
    TransferRat();
    TransferVBA();
    TransferPay('');
  end
  else
    while i<=ParamCount do
      begin
        if ParamStr(i)='?' then begin ShowHelp; exit; end
        else if Pos('rat',LowerCase(ParamStr(i)))<>0
          then TransferRat()
        else if LowerCase(ParamStr(i))='s8' then TransferS8
        else if Pos('vba',LowerCase(ParamStr(i)))<>0
          then TransferVba()
        else if Pos('pay',LowerCase(ParamStr(i)))<>0
          then TransferPay('')
        else if Pos('count',LowerCase(ParamStr(i)))<>0
          then TransferPay(ParamStr(i+1))
        else if LowerCase(ParamStr(i))='dir' then
             if DirectoryExists(ParamStr(i+1)) then begin
                inDir:=ParamStr(i+1);
                XOutDir:=ParamStr(i+1);
                TransferS8();
                TransferRat();
                TransferVBA();
                TransferPay('');
                exit
             end
             else begin
               writeln(Oem('�������� �������: ')+ParamStr(i+1));
               exit;
             end
        Else
          Begin writeln(Oem('�������� �����!')); ShowHelp; exit; end;
        inc(i);
      end;

  writeln(Oem('�������� ��������� ���'));
  Found := FindFirst(inDir+'ENDOFDAY', faArchive, SearchRec);
  if found=0 then begin
    //���� ����� �������� ������ (����������� � 06.06.2006), �� �������� � sta.BankProtocols �� ��������� ���
    SysUtils.DeleteFile(inDir+SearchRec.Name);
  end;
  sysutils.findclose(SearchRec);
end.
