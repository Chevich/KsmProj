{*******************************************************}
{  		X-Components library,  1997 		}
{*******************************************************}
{$I XLib.inc }

Unit XLibRegs;

{$D-,L-,S-}

Interface

Procedure Register;

Implementation

Uses Windows, Dialogs, Classes, Controls, Graphics, DsgnIntf, ExtCtrls, Menus,
     DB, Forms, XCtrls, XTFC, XDBTFC, XForms, XDBForms,
     TFCProps, XLbProps, ExptIntf, XECtrls, XEFields, XETrees, LnkSet,
     AEForms, BEForms, ABEForms, BBEForms, MBEForms, Splash, TlsForm
{$IFDEF Report_Builder}
     , ppDsIntf, XReports, XLnkPipe{, ppXForms}
{$ENDIF}
     ;

Procedure Register;
begin
  RegisterComponents('XAccess', [TXDataBase,TFormControl, TDBFormControl,
                                 TToolsControl, TDBToolsControl]);
  RegisterComponents('XAccess', [TControlMenu, TControlMainMenu]);
  RegisterComponents('XControls', [TXPageControl, TXDBPageControl]);
  RegisterComponents('XControls', [TXLabel,{ TXDBNavigator,} TXDBLabel, TXCheckBox, TXCheckListBox, TXEDBCheckBox,
    TXEDBRadioGroup
{$IFDEF Report_Builder}
                     , TXDBReport
{$ENDIF}
                     ]);

  RegisterNoIcon([TLinkIndexCombo,TLinkNavigator,TLinkPanel]);
  RegisterNoIcon([TLinkMenuItem, TUserMenuItem]);
  RegisterNoIcon([TLinkTable, TLinkQuery, TLinkStoredProc,
                  TLinkSubSource, TProcSubSource]);

{$IFDEF Report_Builder}
  RegisterComponents('XAccess', [TppXDesigner]);
  RegisterNoIcon([TXLinkReport]);
{$ENDIF}

  RegisterComponents('XControls', [TXEDBEdit,TXEDBDateEdit,TXEDBGrid,TXEDBCombo,
                               TXEDBLookupCombo, TXEDBTreeView]);
  RegisterFields([TXEListField, TXELookField]);

  RegisterComponentEditor(TToolsControl, TToolsControlEditor);
  RegisterComponentEditor(TFormControl, TFormControlEditor);
  RegisterComponentEditor(TDBFormControl, TDBFormControlEditor);

  RegisterPropertyEditor(TypeInfo(String), TFormControl, 'FormName', TXFormClassProperty);
{
  RegisterPropertyEditor(TypeInfo(TXDataLinks),
       TDBFormControl,
       'DataLinks',
       TDataLinksProperty);
}
  RegisterPropertyEditor(TypeInfo(TDataSource),TDBFormControl,'DefSource',TXControlSourceProperty);
  RegisterPropertyEditor(TypeInfo(TDataSource),TXInquiryItem,'Source',TXControlSourceProperty);
  RegisterPropertyEditor(TypeInfo(TCollection),TDBFormControl,'Sources',TXLinkSourcesProperty);
  RegisterPropertyEditor(TypeInfo(String),TFormControl,'Caption',TCaptionProperty);
  RegisterPropertyEditor(TypeInfo(String),TToolsControl,'FormName',TXToolClassProperty);
  RegisterPropertyEditor(TypeInfo(String),TToolsControl,'SplashClass',TXSplashClassProperty);
  RegisterPropertyEditor(TypeInfo(TWinControl),TFormControl,'ActiveControl',TInnerComponentProperty);
  RegisterPropertyEditor(TypeInfo(TDataSource),nil,'DataSource',TFormSourceProperty);
  RegisterPropertyEditor(TypeInfo(string),TMenuItem,'Caption',TMenuItemCaptionProperty);
  RegisterPropertyEditor(TypeInfo(TLinkMenuItem),TFormControl,'MenuItem',TLinkMenuItemProperty);
  RegisterPropertyEditor(TypeInfo(string),TXDatabase,'LogField',TLogFieldProperty);
  RegisterPropertyEditor(TypeInfo(string),TXInquiryItem,'UserName',TUserNameLinkProperty);
  RegisterPropertyEditor(TypeInfo(string),TXReportItem,'UserName',TUserNameReportProperty);
  RegisterPropertyEditor(TypeInfo(TComponent),TXReportItem,'Report',TXReportItemProperty);
  RegisterPropertyEditor(TypeInfo(TPrintLink),nil,'PrintLink',TPrintInquiryProperty);
end;

end.
