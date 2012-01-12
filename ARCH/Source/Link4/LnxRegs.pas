{$I XLib.inc }
Unit LnxRegs;

Interface

Procedure Register;

Implementation

Uses Classes, DB, DsgnIntf, LnxProps, LnTables, LnkSet, XApps,
     SrcIndex, ColnEdit, UsersSet, LnkMisc;

Procedure Register;
begin
  RegisterComponents('XAccess', [TLnDatabase, TLnTable, TLnQuery, TLnStoredProc,
                                TLinkSource, TUserSource, TXAppControl]);
  RegisterComponents('XControls', [TSrcLinkCombo]);
  RegisterNoIcon([TLinkTable, TLinkQuery, TLinkStoredProc, TLinkSubSource]);

  RegisterComponentEditor(TLinkSource, TLinkSourceEditor);

  RegisterPropertyEditor(TypeInfo(string), TLnTable, 'TableName', TLnTableNameProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TLinkSource, 'LinkSets', TLinkSetsProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkSource, 'DatabaseName', TLinkDatabaseNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkSource, 'SessionName', TSessionNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkSource, 'TableName', TLinkTableNameProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkSource, 'UniqueIFN', TUniqueIFNProperty);
  RegisterPropertyEditor(TypeInfo(string), TUserSource, 'UserField', TUserFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TUserSource, 'PatternField', TUserFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TUserSource, 'NameField', TUserFieldProperty);

  RegisterPropertyEditor(TypeInfo(TLinkFilters), Nil, '', TLinkFiltersProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkSetItem, 'ModelIFN', TIFNLinkProperty);
  RegisterPropertyEditor(TypeInfo(string), TLinkMaster, 'ModelIFN', TIFNLinkLinkProperty);
  RegisterPropertyEditor(TypeInfo(TDataSet), TLinkSetItem, 'DataSet', TLinkSetCompProperty);
  RegisterPropertyEditor(TypeInfo(TComponent), TLinkSetItem, 'Source', TLinkSetCompProperty);
  RegisterPropertyEditor(TypeInfo(TIFNLink), Nil, 'IFNLink', TIFNLinkCollProperty);
end;

end.
