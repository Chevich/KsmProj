unit Person2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  BBEForms, StdCtrls, SrcIndex, XDBForms, DBCtrls, ExtCtrls, Grids,
  DBGrids, EtvGrid, XECtrls, ComCtrls, EtvPages, XCtrls, RXCtrls, Mask,
  EtvContr, CheckLst, Buttons;
  
type
  TFormPerson2 = class(TBBEForm)
    EditsType: TXEDBRadioGroup;
    EditYear: TXEDBEdit;
    XLabel1: TXLabel;
    XDBLabel1: TXDBLabel;
    XLabel2: TXLabel;
    XLabel3: TXLabel;
    XLabel4: TXLabel;
    XLabel5: TXLabel;
    XLabel6: TXLabel;
    XEDBEdit1: TXEDBEdit;
    EditQuarter: TXCheckListBox;
    XLabel7: TXLabel;
    XEDbGrid1: TXEDbGrid;
    XLabel8: TXLabel;
    XDBLabel2: TXDBLabel;
    XLabel9: TXLabel;
    XDBLabel3: TXDBLabel;
    XEDbGrid2: TXEDbGrid;
    Panel1: TPanel;
    ButtonLockOpen: TSpeedButton;
    ButtonLockClose: TSpeedButton;
    procedure EditQuarterClickCheck(Sender: TObject);
    procedure ButtonLockOpenClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPerson2: TFormPerson2;

implementation
uses DB, EtvDBFun, XMisc, MdWorkers, DlgUnLOck;

{$R *.DFM}

procedure TFormPerson2.EditQuarterClickCheck(Sender: TObject);
begin
  inherited;
  with ModuleWorkers do begin
    PersonForm2BannerDeclar.Edit;
  end;
end;

procedure TFormPerson2.ButtonLockOpenClick(Sender: TObject);
begin
  inherited;
  with ModuleWorkers do begin
    if (PersonForm2BannerDeclar.State<>dsBrowse) or (PersonForm2Declar.State<>dsBrowse) then begin
      ShowMessage('������� ������ ���������� � ��������� ���������'+#13+
                  '���������, ��������� �� ��������� ��������� � ���������');
      Exit;
    end;
    if TSpeedButton(Sender).Name='ButtonLockOpen' then begin
      { ������ ��������� �� ����� }
      { ������ ��������� �������������� }
      if MessageDlg('��������! ��������� �����!!! �������������� �1'+#13+
        '�������� ���������� �� ��������� ����� ����������!'+#13+
        '����� ����� - �� ������'+#13+
        '�� - ����������� ��������� �����   ��� - ������'
          , mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
        { ��������� ��������� �������������� }
        if MessageDlg('��������! ��������� �����!!! �������������� �2'+#13+
          '�������� ���������� �� ������ ����� ����������!'+#13+
          '����� ����� - �� ������'+#13+
          '�� - ����������� ��������� �����   ��� - ������'
          , mtConfirmation,[mbYes,mbNo],0)=mrYes then begin
        end else Exit;
      end else Exit;
      ExecSQLText(PersonForm2BannerDeclar.DataBaseName,
        'Update STA.PersonForm2Banner set IsLock=1 where ID='+PersonForm2BannerDeclarID.AsString,false);
      ShowMessage('����� �� ������ � '+
        PersonForm2BannerDeclarID.AsString+' �� '+PersonForm2BannerDeclarDateFill.AsString+' ����������')
    end else begin
      { ������� ����� � ������ }
      try
        FormDlgUnLock:=TFormDlgUnLock.Create(Application);
        with FormDlgUnLock do begin
          LabelNum.Caption:='����� ������';
          LabelDate.Caption:='���� ���������� ������';
          if (ShowModal in [idOk,idYes]) then begin
            if (NumInvoice.Text<>PersonForm2BannerDeclarID.AsString) or
               (DateInvoice.Text<>PersonForm2BannerDeclarDateFill.AsString) then begin
              ShowMessage('������� ��������� ����������� ������');
              Exit;
            end;
            {
            if (InvoiceDeclarsUser.Value<>UserName) then begin
              ShowMessage('�� �� ������� ����� - �� ��� ��� � ���������!');
              Exit;
            end;
            }
          end else Exit;
        end;
        ExecSQLText(PersonForm2BannerDeclar.DataBaseName,
          'Update STA.PersonForm2Banner set IsLock=0 where ID='+PersonForm2BannerDeclarID.AsString,false);
        ShowMessage('����� � ������ � '+
          PersonForm2BannerDeclarID.AsString+' �� '+PersonForm2BannerDeclarDateFill.AsString+' ����')
      finally
        FormDlgUnLock.Release;
      end;
    end;
    PersonForm2BannerDeclar.Refresh;
  end;
end;

Initialization
  RegisterAliasXForm('FormPerson2', TFormPerson2);
Finalization
  UnRegisterXForm(TFormPerson2);
end.
    