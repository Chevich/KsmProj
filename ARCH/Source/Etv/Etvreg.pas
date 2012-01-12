unit EtvReg;

interface

{$I Etv.inc}

procedure Register;

implementation
uses Classes,DsgnIntf,DB,
  {$IFDEF BDE_IS_USED}
  DBTables,
  EtvTable,
  {$ENDIF}
  {$IFDEF DBCLIENT_IS_USED}
  EtvMidas,
  {$ENDIF}
  EtvDBFun,EtvDB,
  EtvLook,EtvContr,EtvClone,EtvGrid,EtvSort,EtvPages,EtvRich,EtvList,EtvFind,EtvForms,EtvFilt,
  fBase,EtvDsgn,EtvDsSt,EtvDsLk,EtvDsPg,EtvExp,
  EtvShb;

procedure Register;
begin
  RegisterFields([TEtvListField, TEtvLookField]);

  {$IFDEF BDE_IS_USED}
  RegisterComponents('D:\B\Etv\EtvDB', [TEtvTable,TEtvQuery]);
  RegisterComponentEditor(TEtvTable, TEtvDataSetEditor);
  RegisterComponentEditor(TEtvQuery, TEtvDataSetEditor);
    {$IFDEF TTableUseEtvComponentEditor}
    RegisterComponentEditor(TTable, TEtvDataSetEditor);
    {$ENDIF}
    {$IFDEF TQueryUseEtvComponentEditor}
    RegisterComponentEditor(TQuery, TEtvDataSetEditor);
    {$ENDIF}
  {$ENDIF}
  {$IFDEF DBCLIENT_IS_USED}
  RegisterComponents('D:\B\Etv\EtvDB', [TEtvClientDataSet]);
  {$ENDIF}

  RegisterComponents('D:\B\Etv\EtvDB', [TEtvPageControl,TEtvDBGrid,TEtvDBEdit,TEtvDBCombo,TEtvDBLookupCombo,TEtvDBText,TEtvDBRichEdit]);
  RegisterComponents('D:\B\Etv\EtvDB', [TEtvDMInfo,TEtvDBSortingCombo,TEtvFindDlg,TEtvFilter,TEtvRecordCloner]);

  RegisterClasses([TEtvTabSheet]);

  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupFilterField',TEtvLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupLevelUp',TEtvLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupLevelDown',TEtvLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupFilterKey',TEtvFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupAddFields',TEtvLookupFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TField, 'LookupGridFields',TEtvLookupFieldProperty);

  RegisterPropertyEditor(TypeInfo(string), TEtvCustomDBLookupCombo, 'LookupFilterField',TEtvLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TEtvCustomDBLookupCombo, 'LookupLevelUp',TEtvLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TEtvCustomDBLookupCombo, 'LookupLevelDown',TEtvLookupProperty);
  RegisterPropertyEditor(TypeInfo(string), TEtvCustomDBLookupCombo, 'LookupFilterKey',TEtvLookProperty);


  RegisterPropertyEditor(TypeInfo(string), TEtvDBText, 'LookField',TEtvLookupResultProperty);
  RegisterPropertyEditor(TypeInfo(Word), TEtvLookField, 'Size',nil);

  RegisterPropertyEditor(TypeInfo(string), TEtvLookupLevelItem, 'FilterField',TEtvLookupLevelFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TEtvLookupLevelItem, 'KeyField',TEtvLookupLevelFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TEtvLookupLevelItem, 'ResultFields',TEtvLookupLevelFieldProperty);

  {RegisterPropertyEditor(TypeInfo(TDataSetCol), TEtvFilter, 'SubDataSets',TDataSetListProperty);}
  RegisterPropertyEditor(TypeInfo(TDataSetCol), TEtvRecordCloner, 'SubDataSets',TDataSetListProperty);

  RegisterComponentEditor(TEtvDMInfo, TEtvDMEditor);

  RegisterComponentEditor(TEtvDBLookupCombo, TEtvDBLookupComboEditor);

  RegisterComponentEditor(TEtvDBCombo, TEtvDBFieldControlEditor);
  RegisterComponentEditor(TEtvDBEdit, TEtvDBFieldControlEditor);
  RegisterComponentEditor(TEtvDBText, TEtvDBFieldControlEditor);

  RegisterComponentEditor(TEtvDBSortingCombo, TEtvDBControlEditor);
  RegisterComponentEditor(TEtvFilter, TEtvDBControlEditor);
  RegisterComponentEditor(TEtvFindDlg, TEtvDBControlEditor);
  RegisterComponentEditor(TEtvRecordCloner, TEtvDBControlEditor);
  RegisterComponentEditor(TEtvPageControl, TEtvPageControlEditor);
  RegisterComponentEditor(TEtvTabSheet, TEtvPageControlEditor);

  RegisterComponentEditor(TDataSource, TEtvDataSourceEditor);

  RegisterComponents('D:\B\Etv\EtvDB',[{TEtvDataBase,}TEtvShb]);

  EtvExp.RegisterExp;
end;

end.
