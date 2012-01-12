var OldValues:Variant;
{$R *.DFM}

procedure TForm1.Grid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const MaxRows=25;
      LimRows:integer=-1; { Кол-во выделенных строк }
      First:boolean=true;
      Si:string='';
var i:byte;
    MyBookMark:TBookMark;
begin
  if (Shift=[ssCtrl]) and (Key=VK_INSERT) and (TDBGrid(Sender).Name='Grid1') then begin
    LimRows:=Grid1.SelectedRows.Count-1;
    if LimRows>MaxRows then begin
      ShowMessage('Слишком много выделенных строк');
      Exit;
    end;
    if First then begin
      OldValues:=VarArrayCreate([0, MaxRows],varVariant);
      First:=false;
    end;
    with Table1 do begin
      Si:='';
      for i:=0 to FieldCount-1 do Si:=Si+';'+Fields[i].FieldName;
      System.Delete(Si,1,1);
      DisableControls;
      MyBookMark:=GetBookMark;
      for i:=0 to LimRows do begin
        GotoBookMark(Pointer(Grid1.SelectedRows[i]));
        OldValues[i]:=FieldValues[Si];
      end;
      Grid1.SelectedRows.Clear;
      GotoBookMark(MyBookMark);
      FreeBookMark(MyBookMark);
      EnableControls;
    end;
  end;
  if (Shift=[ssShift,ssCtrl]) and (Key=VK_INSERT) and (LimRows>-1)
  and (TDBGrid(Sender).Name='Grid2') then begin
    with Table2 do begin
      DisableControls;
      MyBookMark:=GetBookMark;
      for i:=0 to LimRows do begin
        Insert;
        FieldValues[Si]:=OldValues[i];
        Post;
      end;
      GotoBookMark(MyBookMark);
      FreeBookMark(MyBookMark);
      EnableControls;
    end;
    LimRows:=-1;
  end;
end;
