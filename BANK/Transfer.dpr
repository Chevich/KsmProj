program Transfer;

uses
  Forms,
  EtvForms,
  EtvDB,
  Dialogs,
  SysUtils,
  TrLabel in 'TrLabel.pas' {FormLabel},
  Datamod1 in 'Datamod1.pas' {DM1: TDataModule},
  DatamodV in 'DatamodV.pas' {DMV: TDataModule},
  DatamVT in 'DatamVT.pas' {DMVT: TDataModule},
  datamod2 in 'datamod2.pas' {DM2: TDataModule},
  DatamodC in 'DatamodC.pas' {DMC: TDataModule},
  DModCT in 'DModCT.pas' {DMCT: TDataModule};

var i,CodeError:integer;
{$R *.RES}

begin
  if LowerCase(ParamStr(1))<>'nogui' then begin
  Application.Initialize;
  FormLabel:=TFormLabel.Create(Application);
  FormLabel.Show;
  FormLabel.Update;

  Application.CreateForm(TDM1, DM1);
  DM1.SetOptions;
  FormLabel.IncL(1,'Загрузка');
  Application.CreateForm(TDMVT, DMVT);
  FormLabel.Inc(1);
  Application.CreateForm(TDM2, DM2);
  FormLabel.Inc(1);
  Application.CreateForm(TDMCT, DMCT);
  FormLabel.Inc(1);
  CreateEtvApp(True);
  FormLabel.Inc(1);
  if ParamStr(1)='' then begin
    FormLabel.IncL(0,'Курсы валют');
    {dmVT.txt2db;}
    dmVT.PeregonValutFromBelBank;
    FormLabel.IncL(4,'Картотека');
    dm2.PeregonFromBelText('');
    {dm2.Dbf2db;}
    FormLabel.IncL(4,'Валютные выписки');
    {dmct.PeregonCountsVa('');}
    FormLabel.Inc(4);
    FormLabel.IncL(0,'Выписки');
    dmct.PeregonCountsFromBelBank;
  end else begin
    {$R-}
    val(ParamStr(1),i,CodeError);
    {$R+}
    case i of
      1: begin
        FormLabel.IncL(0,'Курсы валют');
        {dmVT.txt2db;}
        dmVT.PeregonValutFromBelBank;
      end;
      2: begin
        FormLabel.IncL(0,'Картотека');
        {dm2.Dbf2db;}
        dm2.PeregonFromBelText(ParamStr(2));
      end;
      3: begin
        FormLabel.IncL(0,'Валютные выписки ');
        {dmct.PeregonCountsVa(ParamStr(2));}
      end;
      4: begin
        FormLabel.IncL(0,'Выписки');
        {dmct.PeregonCounts(ParamStr(2));}
        dmct.PeregonCountsFromBelBank;
      end;
      else ShowMessage('  А чего это Вы навводили?'+
                 #10+'  Ничего такого народу не надо,'+
                 #10+'поэтому ничего и не обрабатывалось!'+
                 #10+'  Понимается нижеследующие: '+
                 #10+'   1 - курсы валют'+
                 #10+'   2 [имя_файла] - картотека'+
                 #10+'   3 [имя_файла] - валютные выписки / NOT USED'+
                 #10+'   4 [имя_каталога]  - выписки');
    end;
  end;

  FormLabel.IncL(4,'Конец');
  FormLabel.Hide;
  FormLabel.Free;
  Application.terminate;
  end
  else begin
      try
        //writeln('Начало');
        DM1:=TDM1.Create(nil);
        DM1.SetOptions;
        DMVT:=TDMVT.Create(nil);
        DM2:=TDM2.Create(nil);
        DMCT:=TDMCT.Create(nil);
        CreateEtvApp(true);
        //
        dmVT.PeregonValutFromBelBank;
        dm2.PeregonFromBelText('');
        dmct.PeregonCountsFromBelBank;
        //
        DMCT.free; DM2.free; DMVT.free; DM1.free;
      except
        Halt(1);
      end;
  end;
end.
