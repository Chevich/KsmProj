�
 TMODULEPAYS 0P�  TPF0TModulePays
ModulePaysOldCreateOrderLeftTopHeight� Width TControlMenuPopupLeftTop 	TMenuItemN1Caption������� TLinkMenuItemPayDoc1Caption��������� ���������FormControlPayDocC  TLinkMenuItemTDoc1Caption���� ����������FormControlTDocC  TLinkMenuItemTOp1Caption���� ��������FormControlTOpC  TLinkMenuItemImpPay1Caption���������� ��������FormControlImpPayC  TLinkMenuItemMoneyUseGroup1Caption%������ ������������� �������� �������FormControlMoneyUseGroupC  TLinkMenuItem	MoneyUse1Caption#���� ������������� �������� �������FormControl	MoneyUseC  TLinkMenuItem
MoneyUseV1Caption(������������� �������� ������� c �/�����OnClickMoneyUseV1ClickFormControl
MoneyUseVC  TLinkMenuItemSprPayDocStateAccept1Caption��������� ��������� ����������FormControlSprPayDocStateAcceptC    TLinkSourceMoneyUseNameMoneyUseLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetMoneyUseDeclarSourceMoneyUse IFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSetMoneyUseLookup  Active		TableNameSTA.SprMoneyUseDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left� Top4 
TLinkTableMoneyUseDeclarDatabaseNameAO_GKSM_InProgram	IndexNameSprMoneyUse(primary key)	TableNameSTA.SprMoneyUseCaption#���� ������������� �������� ������� TSmallintFieldMoneyUseDeclarKodDisplayLabel���DisplayWidth	FieldNameKodRequired	  TStringFieldMoneyUseDeclarNameDisplayLabel������������	FieldNameNameRequired	Size  TSmallintFieldMoneyUseDeclarGroupDisplayLabel������DisplayWidth	FieldNameGroupRequired	   
TLinkQueryMoneyUseLookupDatabaseNameAO_GKSM_InProgramSQL.Strings;Select Kod, Name, "Group" from STA.SprMoneyUse order by Kod UniDirectional	
UpdateModeupWhereKeyOnly	TableNameSTA.SprMoneyUse TSmallintFieldMoneyUseLookupGroup	FieldNameGroup  TSmallintFieldMoneyUseLookupKodDisplayLabel���DisplayWidth	FieldNameKod  TStringFieldMoneyUseLookupNameDisplayLabel������������	FieldNameNameOriginSprMoneyUse.NameSize    TLinkSourceTOpNameTOpLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.NameSprTOp(primary key)IFNItem.FieldsKodIFNItem.OptionsixUnique Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSet	TOpDeclarSourceTOp IFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSet	TOpLookup  Active		TableName
STA.SprTOpDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left^Top3 
TLinkTable	TOpDeclarDatabaseNameAO_GKSM_InProgram	IndexNameSprTOp(primary key)	TableName
STA.SprTOpCaption���� �������� TIntegerFieldTOpDeclarKodDisplayLabel���DisplayWidth	FieldNameKodRequired	  TStringFieldTOpDeclarNameDisplayLabel������������ ���� ��������	FieldNameNameSize7  TSmallintFieldTOpDeclarPGNIDisplayLabel������� ���DisplayWidth	FieldNamePGNI  TSmallintFieldTOpDeclarPTamDisplayLabel�������DisplayWidth	FieldNamePTam   
TLinkQuery	TOpLookupDatabaseNameAO_GKSM_InProgramSQL.Strings,select Kod,Name from STA.SprTOp order by Kod UniDirectional	
UpdateModeupWhereKeyOnly	TableName
STA.SprTOp TIntegerFieldTOpLookupKodDisplayLabel���DisplayWidth	FieldNameKodOrigin
SprTOp.Kod  TStringFieldTOpLookupNameDisplayLabel������������	FieldNameNameSize7    TLinkSourceTDocNameTDocLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.NameSprTDoc(primary key)IFNItem.FieldsKodIFNItem.OptionsixUnique Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSet
TDocDeclarSourceTDoc IFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSet
TDocLookup  Active		TableNameSTA.SprTDocDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left� Top4 
TLinkTable
TDocDeclarDatabaseNameAO_GKSM_InProgram	IndexNameSprTDoc(primary key)	TableNameSTA.SprTDocCaption���� ���������� TSmallintFieldTDocDeclarKodDisplayLabel���DisplayWidth	FieldNameKodRequired	  TStringFieldTDocDeclarNameDisplayLabel������������ ���� ���������	FieldNameNameSize(  TStringFieldTDocDeclarStrictDisplayLabel������� ���	FieldNameStrictSize
   
TLinkQuery
TDocLookupDatabaseNameAO_GKSM_InProgramSQL.Strings4select Kod,Name,Strict from STA.SprTDoc order by Kod UniDirectional	
UpdateModeupWhereKeyOnly	TableNameSTA.SprTDoc TSmallintFieldTDocLookupKodDisplayLabel���DisplayWidth	FieldNameKod  TStringFieldTDocLookupNameDisplayLabel������������ ���� ���������	FieldNameNameSize(  TStringFieldTDocLookupStrict	FieldNameStrictOriginSprTDoc.StrictSize
    TLinkSourcePayDocNamePayDocOnDataChangePayDocDataChangeLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.FieldsAutoIncIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetPayDocSSourcePayDoc IFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltTableDataSetPayDocLookup IFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options Style	ldProcess	LinkStateltQueryDataSetPayDocProcessSourcePayDocP1  Active		TableName
STA.PayDocDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left� Top4 
TLinkTablePayDocS
BeforeEditPayDocSBeforeEdit
BeforePostPayDocSBeforePost	AfterPostPayDocSAfterPostOnCalcFieldsPayDocSCalcFieldsOnNewRecordPayDocSNewRecordDatabaseNameAO_GKSM_InProgram	IndexNamePayDoc(primary key)	TableName
STA.PayDocCaption��������� ��������� TAutoIncFieldPayDocAutoIncDisplayLabel��DisplayWidth
	FieldNameAutoIncReadOnly	Required	  TSmallintField
PayDocTDocTagDisplayLabel��� ���������DisplayWidth	FieldNameTDocVisible  TXELookFieldPayDocTDocNameDisplayLabel��� ���������DisplayWidth-	FieldKindfkLookup	FieldNameTDocNameLookupDataSet
TDocLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsTDocSize-ListFieldIndex LookupAddFieldsStrictLookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TIntegerFieldPayDocNumDocDisplayLabel�����DisplayWidth	FieldNameNumDoc  
TDateFieldPayDocDateDocDisplayLabel	���� ���.DisplayWidth
	FieldNameDateDocOnChangePayDocDateDocChangeEditMask!99/99/00;1;_  TIntegerField
PayDocOrgDTagDisplayLabel��� �����������	FieldNameOrgDVisibleOnChangePayDocOrgDChange  TXELookFieldPayDocOrgDNameDisplayLabel
����������DisplayWidth1	FieldKindfkLookup	FieldNameOrgDNameLookupDataSetModuleOrgs.OrgLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsOrgDSize0ListFieldIndex LookupAddFieldsFullName;INNLookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocSOrgDStrDisplayWidthd	FieldNameOrgDStrSized  TStringField
PayDocMfoDDisplayLabel	���� ����	FieldNameMfoDSize	  TStringFieldPayDocBCountDTagDisplayLabel�/���� ��������	FieldNameBCountDVisibleOnChangePayDocBCountDChangeSize  TXELookFieldPayDocBCountDNameDisplayLabel�/���� ����.DisplayWidth	FieldKindfkLookup	FieldNameBCountDNameLookupDataSetModuleOrgs.OrgBankLookupLookupKeyFieldsBCountLookupResultFieldBCount;KodBn;CBS;Org	KeyFieldsBCountDListFieldIndex LookupFilterFieldOrgLookupFilterKeyOrgDLookupAddFieldsID;BankName;PlaceName;RKCHeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEditfoValueNotInLookup StoreLookupData	Lookup	  TIntegerFieldPayDocBankIdDTagDisplayLabel
ID ���� ��DisplayWidth	FieldNameBankIdDVisibleOnChangePayDocBankIdDChange  TXELookFieldPayDocBankNameDDisplayLabel������������ ����� �����������DisplayWidth,	FieldKindfkLookup	FieldName	BankNameDLookupDataSetModuleCommon.BankLookupLookupKeyFieldsIDLookupResultFieldKod;CBS;Name;ID	KeyFieldsBankIdDReadOnly	Size+ListFieldIndex LookupAddFieldsKodOtd;PlaceNameLookupResultIndexHeadLine		HeadColor�ʦ OptionsfoAutoDropDownfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TFloatFieldPayDocSummaDisplayLabel�����DisplayWidth
	FieldNameSumma
EditFormat############.##  TSmallintFieldPayDocCurrencyTagDisplayLabel
��� ������DisplayWidth	FieldNameCurrencyVisibleOnChangePayDocDateDocChange  TXELookFieldPayDocSCurrencyNameDisplayLabel������������ ������DisplayWidth#	FieldKindfkLookup	FieldNameCurrencyNameLookupDataSetModuleCommon.CurrencyLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsCurrencyListFieldIndex LookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TFloatFieldPayDocSCourseDisplayLabel���� ������DisplayWidth
	FieldNameCourse  TIntegerField
PayDocOrgKTagDisplayLabel��� ����������	FieldNameOrgKVisibleOnChangePayDocOrgKChange  TXELookFieldPayDocOrgKNameDisplayLabel
����������DisplayWidth1	FieldKindfkLookup	FieldNameOrgKNameLookupDataSetModuleOrgs.OrgLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsOrgKSize0ListFieldIndex LookupAddFieldsFullName;INN;CountryLookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocSOrgKStr	FieldNameOrgKStrSized  TStringFieldPayDocSInnK	FieldNameInnKSize  TStringField
PayDocMfoKDisplayLabel	���� ����	FieldNameMfoKSize	  TStringFieldPayDocBCountKTagDisplayLabel�/���� ���������	FieldNameBCountKVisibleOnChangePayDocBCountKChangeSize  TXELookFieldPayDocBCountKNameDisplayLabel�/���� ����������DisplayWidth	FieldKindfkLookup	FieldNameBCountKNameLookupDataSetModuleOrgs.OrgBankLookupLookupKeyFieldsBCountLookupResultFieldBCount;KodBn;CBS	KeyFieldsBCountKListFieldIndex LookupFilterFieldOrgLookupFilterKeyOrgKLookupAddFieldsOrg;ID;BankName;PlaceName;RKCHeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEditfoValueNotInLookup StoreLookupData	Lookup	  TIntegerFieldPayDocBankIdKTagDisplayLabel
ID ���� ��DisplayWidth	FieldNameBankIdKVisibleOnChangePayDocBankIdKChange  TXELookFieldPayDocBankNameKDisplayLabel������������ ����� ����������DisplayWidth,	FieldKindfkLookup	FieldName	BankNameKLookupDataSetModuleCommon.BankLookupLookupKeyFieldsIDLookupResultFieldKod;CBS;Name;ID	KeyFieldsBankIdKReadOnly	Size+ListFieldIndex LookupAddFieldsKodOtd;PlaceNameHeadLine		HeadColor�ʦ OptionsfoAutoDropDownfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocSummaNameDisplayLabel����� ��������DisplayWidth� 	FieldKindfkCalculated	FieldName	SummaNameSize� 
Calculated	  
TDateFieldPayDocSDateGetDisplayLabel���� ��������� ������DisplayWidth	FieldNameDateGet  TStringFieldPayDocSDateGetTextDisplayLabel���� ��������� ������ /�����	FieldNameDateGetTextSize  TIntegerFieldPayDocTOperTagDisplayLabel��� ��������DisplayWidth	FieldNameTOperVisible  TXELookFieldPayDocTOperNameDisplayLabel��� ��������DisplayWidth7	FieldKindfkLookup	FieldName	TOperNameLookupDataSet	TOpLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsTOperSize<ListFieldIndex LookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocDestinationDisplayLabel���������� �������DisplayWidthd	FieldNameDestinationSize�   TStringFieldPayDocSImpPayTag	FieldNameImpPayVisibleSize  TXELookFieldPayDocImpPayNameDisplayLabel����������� �������DisplayWidth	FieldKindfkLookup	FieldName
ImpPayNameLookupDataSetImpPayLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsImpPaySizeListFieldIndex LookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  
TDateFieldPayDocDatePayDisplayLabel���� ������.DisplayWidth	FieldNameDatePayEditMask!99/99/00;1;_  
TDateFieldPayDocDateComingDisplayLabel��������� ������DisplayWidth	FieldName
DateComingEditMask!99/99/00;1;_  TStringFieldPayDocContractDisplayLabel� ���������	FieldNameContractSize  TStringFieldPayDocSsUserDisplayLabel������������	FieldNamesUserSize  TDateTimeFieldPayDocSsTimeDisplayLabel����� ���������	FieldNamesTime  TStringFieldPayDocSCountryNameKDisplayLabel������ ����������	FieldKindfkCalculated	FieldNameCountryNameK
Calculated	  TXEListFieldPayDocSNote	AlignmenttaLeftJustifyDisplayLabel
����������DisplayWidth2	FieldNameNoteValues.Strings ������� ������� ���� ���������� ����� ���� ������������ ��������   TSmallintFieldPayDocSAuto	FieldNameAuto  TSmallintFieldPayDocSMoneyUseGroup	FieldNameMoneyUseGroup  TEtvLookFieldPayDocSMoneyUseGroupName	FieldKindfkLookup	FieldNameMoneyUseGroupNameLookupDataSetMoneyUseGroupLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsMoneyUseGroupListFieldIndex HeadLine		HeadColor�ʦ StoreLookupData	Lookup	  TSmallintFieldPayDocMoneyUseTagDisplayLabel��� ���. �����DisplayWidth	FieldNameMoneyUseVisible  TXELookFieldPayDocMoneyUseNameDisplayLabel������������� �������� �������	FieldKindfkLookup	FieldNameMoneyUseNameLookupDataSetMoneyUseLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsMoneyUseSize!ListFieldIndex LookupFilterFieldGroupLookupFilterKeyMoneyUseGroupLookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TIntegerFieldPayDocSSectionTag	FieldNameSectionVisible  TXELookFieldPayDocSectionNameDisplayLabel�����, ������� ��������DisplayWidth 	FieldKindfkLookup	FieldNameSectionNameLookupDataSetModuleBase.SectionLookupLookupKeyFieldsSectionLookupResultFieldSection;Name	KeyFieldsSectionSizeListFieldIndex LookupResultIndex�HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TXEListFieldPayDocSPenalty	AlignmenttaLeftJustifyDisplayLabel������� �� ��������	FieldNamePenaltyValues.Strings�� ���� ������������� ���� ������������������ �����-�������������������� �����������   TXEListFieldPayDocSSendToBank	AlignmenttaLeftJustifyDisplayLabel������� ��������	FieldName
SendToBankValues.Strings0 - ��������� � ����1 - ���������� � ����   TDateTimeFieldPayDocSTimeSendToBankDisplayLabel����/����� ��������	FieldNameTimeSendToBankReadOnly	  TIntegerFieldPayDocSPacketDisplayLabel� �����	FieldNamePacketReadOnly	  TXEListFieldPayDocSConversion	AlignmenttaLeftJustifyDisplayLabel	���������DisplayWidth	FieldName
ConversionValues.Strings0 - �� ���������1 - ���������2 - ������� 3 - �������4 - ������������ �������   TSmallintFieldPayDocSCurrencyConversionTagDisplayLabel��� ������ ���������	FieldNameCurrencyConversionVisible  TXELookFieldPayDocSCurrencyConversionNameDisplayLabel������ ���������	FieldKindfkLookup	FieldNameCurrencyConversionNameLookupDataSetModuleCommon.CurrencyLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsCurrencyConversionSize#ListFieldIndex HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocSCourseConversionDisplayLabel���� ���������	FieldNameCourseConversionSize(  TIntegerFieldPayDocSNumSendOfDateDisplayLabel� �/� �� ����DisplayWidth	FieldNameNumSendOfDateReadOnly	  TFloatFieldPayDocSSummaConversionDisplayLabel����� ���������	FieldNameSummaConversion
EditFormat############.##  TStringFieldPayDocSPassDNDisplayLabel���� � � �������� ������	FieldNamePassDNSized  TStringFieldPayDocSPayDetailDisplayLabel������ �������	FieldName	PayDetailSize�   TStringFieldPayDocSCountKKDisplayLabel���.���� �����-����������	FieldNameCountKK  TStringFieldPayDocSCountKKK	FieldNameCountKKK  TSmallintField
PayDocCbsDDisplayLabel��� ��DisplayWidth	FieldNameCbsD  TSmallintField
PayDocCbsKDisplayLabel��� ��DisplayWidth	FieldNameCbsK  TIntegerFieldPayDocSBankIdKK	FieldNameBankIdKK  TEtvLookFieldPayDocSBankNameKKDisplayLabel!������������ ����� ��������������DisplayWidth,	FieldKindfkLookup	FieldName
BankNameKKLookupDataSetModuleCommon.BankLookupLookupKeyFieldsIDLookupResultFieldKod;CBS;Name;ID	KeyFieldsBankIdKKReadOnly	ListFieldIndex LookupAddFieldsKodOtd;PlaceNameHeadLine		HeadColor�ʦ OptionsfoAutoDropDownfoEditWindowfoKeyFieldEditfoUpDownInClose StoreLookupData	Lookup	   
TLinkTablePayDocLookupDatabaseNameAO_GKSM_InProgramIndexFieldNamesAutoInc	TableName
STA.PayDoc TIntegerFieldPayDocLookupAutoIncDisplayLabel��DisplayWidth	FieldNameAutoInc  TIntegerFieldPayDocLookupNumDocDisplayLabel
����� ���.DisplayWidth	FieldNameNumDoc   
TLinkQueryPayDocProcessDatabaseNameAO_GKSM_InProgramSQL.Strings7call STA.PayBankKreditToPayDoc(:InDateBeg, :InDateEnd, Y                                                        :InCurrency, :InBCountEnterprise) UniDirectional	
UpdateModeupWhereKeyOnly	ParamDataDataTypeftDateName	InDateBeg	ParamType	ptUnknown DataTypeftDateName	InDateEnd	ParamType	ptUnknown DataType	ftIntegerName
InCurrency	ParamType	ptUnknown DataTypeftStringNameInBCountEnterprise	ParamType	ptUnknown    TProcSubSourcePayDocP1DataSetPayDocProcess   TDBFormControlImpPayCActive	HelpContext FormName	dbDefaultFormRect.FormLeft FormRect.FormTop�FormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption���������� ����������� ��������	DefSourceImpPaySourcesSourceImpPay  Left6Top  TDBFormControlTOpCActive	HelpContext FormName	dbDefaultFormRect.FormLeft FormRect.FormTop FormRect.FormWidth*FormRect.FormHeight�FormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption���������� ����� ��������	DefSourceTOpSourcesSourceTOp  Left^Top  TDBFormControlTDocCActive	HelpContext FormName	dbDefaultFormRect.FormLeftFormRect.FormTop FormRect.FormWidth�FormRect.FormHeight�FormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption���� ����������	DefSourceTDocSourcesSourceTDoc  Left� Top  TDBFormControlPayDocCActive	HelpContext FormName
FormPayDocFormRect.ActiveFormRect.FormLeftFormRect.FormTopFormRect.FormWidth+FormRect.FormHeight�FormTools.PopupMenuPopupFormTools.UserType
fcAutoNoneFormTools.ReportType
fcAutoNoneFormTools.ReporterType
fcAutoNoneFormTools.UserSourceModuleBase.RepsSrcFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneOnCreateFormPayDocCCreateFormCaption��������� ���������	DefSourcePayDocSourcesSourcePayDoc SourceModuleCommon.TransactD SourcePayDocStateAccept  Left� Top  TRxMemoryDataPayDocAddSetActive		FieldDefsName	FullNameKDataTypeftStringSized NameNoteDataTypeftStringSize3 Name
DateDocStrDataTypeftStringSize NamePenaltyDataTypeftStringSized Name	FullNameDDataTypeftStringSized NameInnKDataTypeftStringSize  LeftJTop TStringFieldPayDocAddSetFullNameK	FieldName	FullNameKSized  TStringFieldPayDocAddSetNote	FieldNameNoteSize3  TStringFieldPayDocAddSetDateDocStr	FieldName
DateDocStrSize  TStringFieldPayDocAddSetPenalty	FieldNamePenaltySized  TStringFieldPayDocAddSetFullNameD	FieldName	FullNameDSized  TStringFieldPayDocAddSetInnK	FieldNameInnKSize   TLinkSourceImpPayNameImpPayLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetImpPayDeclarSourceImpPay IFNLink IFNItem.FieldsKodIFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSetImpPayLookup  Active		TableNameSTA.SprImpPayDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left5Top3 
TLinkTableImpPayDeclarDatabaseNameAO_GKSM_InProgram	IndexNameSprImpPay(primary key)	TableNameSTA.SprImpPayCaption���������� �������� TStringFieldImpPayDeclarKodDisplayLabel���	FieldNameKodRequired	Size  TStringFieldImpPayDeclarNameDisplayLabel������������DisplayWidth2	FieldNameNameSized   
TLinkQueryImpPayLookupDatabaseNameAO_GKSM_InProgramSQL.Strings1select  Kod, Name from STA.SprImpPay order by Kod UniDirectional	
UpdateModeupWhereKeyOnly	TableNameSTA.SprImpPay TStringFieldImpPayLookupKodDisplayLabel���	FieldNameKodOriginSprImpPay.KodSize  TStringFieldImpPayLookupNameDisplayLabel������������DisplayWidth2	FieldNameNameOriginSprImpPay.KodSized    TDBFormControl	MoneyUseCActive	HelpContext FormName	dbDefaultFormRect.FormLeft	FormRect.FormTopFormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption#���� ������������� �������� �������	DefSourceMoneyUseSourcesSourceMoneyUse  Left� Top  TppBDEPipelinePLPayDoc
DataSourcePayDocMoveBy RangeEndreCountRangeEndCount
RangeBeginrbCurrentRecordUserNamePLPayDocLeftTopd TppFieldppField1	AlignmenttaRightJustify
FieldAliasAutoInc	FieldNameAutoIncFieldLength DataType	dtLongintDisplayWidth
Position   TppFieldppField2	AlignmenttaRightJustify
FieldAliasTDoc	FieldNameTDocFieldLength DataType	dtIntegerDisplayWidthPosition  TppFieldppField3
FieldAliasTDocName	FieldNameTDocNameFieldLength-DisplayWidth-Position  TppFieldppField4	AlignmenttaRightJustify
FieldAliasNumDoc	FieldNameNumDocFieldLength DataType	dtIntegerDisplayWidthPosition  TppFieldppField5
FieldAliasDateDoc	FieldNameDateDocFieldLength DataTypedtDateDisplayWidth
Position  TppFieldppField6	AlignmenttaRightJustify
FieldAliasOrgD	FieldNameOrgDFieldLength DataType	dtIntegerDisplayWidth
Position  TppFieldppField7
FieldAliasOrgDName	FieldNameOrgDNameFieldLength0DisplayWidth1Position  TppFieldppField8
FieldAliasOrgDStr	FieldNameOrgDStrFieldLengthdDisplayWidthdPosition  TppFieldppField9
FieldAliasMfoD	FieldNameMfoDFieldLength	DisplayWidth	Position  TppField	ppField10
FieldAliasBCountD	FieldNameBCountDFieldLengthDisplayWidthPosition	  TppField	ppField11
FieldAliasBCountDName	FieldNameBCountDNameFieldLengthDisplayWidthPosition
  TppField	ppField12	AlignmenttaRightJustify
FieldAliasBankIdD	FieldNameBankIdDFieldLength DataType	dtIntegerDisplayWidthPosition  TppField	ppField13
FieldAlias	BankNameD	FieldName	BankNameDFieldLength+DisplayWidth,Position  TppField	ppField14	AlignmenttaRightJustify
FieldAliasSumma	FieldNameSummaFieldLength DataTypedtDoubleDisplayWidth
Position  TppField	ppField15	AlignmenttaRightJustify
FieldAliasCurrency	FieldNameCurrencyFieldLength DataType	dtIntegerDisplayWidthPosition  TppField	ppField16
FieldAliasCurrencyName	FieldNameCurrencyNameFieldLengthDisplayWidth#Position  TppField	ppField17	AlignmenttaRightJustify
FieldAliasCourse	FieldNameCourseFieldLength DataTypedtDoubleDisplayWidth
Position  TppField	ppField18	AlignmenttaRightJustify
FieldAliasOrgK	FieldNameOrgKFieldLength DataType	dtIntegerDisplayWidth
Position  TppField	ppField19
FieldAliasOrgKName	FieldNameOrgKNameFieldLength0DisplayWidth1Position  TppField	ppField20
FieldAliasOrgKStr	FieldNameOrgKStrFieldLengthdDisplayWidthdPosition  TppField	ppField21
FieldAliasInnK	FieldNameInnKFieldLengthDisplayWidthPosition  TppField	ppField22
FieldAliasMfoK	FieldNameMfoKFieldLength	DisplayWidth	Position  TppField	ppField23
FieldAliasBCountK	FieldNameBCountKFieldLengthDisplayWidthPosition  TppField	ppField24
FieldAliasBCountKName	FieldNameBCountKNameFieldLengthDisplayWidthPosition  TppField	ppField25	AlignmenttaRightJustify
FieldAliasBankIdK	FieldNameBankIdKFieldLength DataType	dtIntegerDisplayWidthPosition  TppField	ppField26
FieldAlias	BankNameK	FieldName	BankNameKFieldLength+DisplayWidth,Position  TppField	ppField27
FieldAlias	SummaName	FieldName	SummaNameFieldLength� DisplayWidth� Position  TppField	ppField28
FieldAliasDateGet	FieldNameDateGetFieldLength DataTypedtDateDisplayWidthPosition  TppField	ppField29
FieldAliasDateGetText	FieldNameDateGetTextFieldLengthDisplayWidthPosition  TppField	ppField30	AlignmenttaRightJustify
FieldAliasTOper	FieldNameTOperFieldLength DataType	dtIntegerDisplayWidthPosition  TppField	ppField31
FieldAlias	TOperName	FieldName	TOperNameFieldLength<DisplayWidth7Position  TppField	ppField32
FieldAliasDestination	FieldNameDestinationFieldLength� DisplayWidthdPosition  TppField	ppField33
FieldAliasImpPay	FieldNameImpPayFieldLengthDisplayWidthPosition   TppField	ppField34
FieldAlias
ImpPayName	FieldName
ImpPayNameFieldLengthDisplayWidthPosition!  TppField	ppField35
FieldAliasDatePay	FieldNameDatePayFieldLength DataTypedtDateDisplayWidthPosition"  TppField	ppField36
FieldAlias
DateComing	FieldName
DateComingFieldLength DataTypedtDateDisplayWidthPosition#  TppField	ppField37
FieldAliasContract	FieldNameContractFieldLengthDisplayWidthPosition$  TppField	ppField38
FieldAliassUser	FieldNamesUserFieldLengthDisplayWidthPosition%  TppField	ppField39
FieldAliassTime	FieldNamesTimeFieldLength DataType
dtDateTimeDisplayWidthPosition&  TppField	ppField40
FieldAliasCountryNameK	FieldNameCountryNameKFieldLengthDisplayWidthPosition'  TppField	ppField41	AlignmenttaRightJustify
FieldAliasNote	FieldNameNoteFieldLength DataType	dtIntegerDisplayWidth2Position(  TppField	ppField42	AlignmenttaRightJustify
FieldAliasAuto	FieldNameAutoFieldLength DataType	dtIntegerDisplayWidth
Position)  TppField	ppField43	AlignmenttaRightJustify
FieldAliasMoneyUseGroup	FieldNameMoneyUseGroupFieldLength DataType	dtIntegerDisplayWidth
Position*  TppField	ppField44
FieldAliasMoneyUseGroupName	FieldNameMoneyUseGroupNameFieldLengthDisplayWidthPosition+  TppField	ppField45	AlignmenttaRightJustify
FieldAliasMoneyUse	FieldNameMoneyUseFieldLength DataType	dtIntegerDisplayWidthPosition,  TppField	ppField51
FieldAliasMoneyUseName	FieldNameMoneyUseNameFieldLength!DisplayWidth!Position-  TppField	ppField52	AlignmenttaRightJustify
FieldAliasSection	FieldNameSectionFieldLength DataType	dtIntegerDisplayWidth
Position.  TppField	ppField53
FieldAliasSectionName	FieldNameSectionNameFieldLengthDisplayWidth Position/  TppField	ppField54	AlignmenttaRightJustify
FieldAliasPenalty	FieldNamePenaltyFieldLength DataType	dtIntegerDisplayWidth
Position0  TppField	ppField55	AlignmenttaRightJustify
FieldAlias
SendToBank	FieldName
SendToBankFieldLength DataType	dtIntegerDisplayWidth
Position1  TppField	ppField56
FieldAliasTimeSendToBank	FieldNameTimeSendToBankFieldLength DataType
dtDateTimeDisplayWidthPosition2  TppField	ppField57	AlignmenttaRightJustify
FieldAliasPacket	FieldNamePacketFieldLength DataType	dtIntegerDisplayWidth
Position3  TppField	ppField58	AlignmenttaRightJustify
FieldAlias
Conversion	FieldName
ConversionFieldLength DataType	dtIntegerDisplayWidthPosition4  TppField	ppField59	AlignmenttaRightJustify
FieldAliasCurrencyConversion	FieldNameCurrencyConversionFieldLength DataType	dtIntegerDisplayWidth
Position5  TppField	ppField60
FieldAliasCurrencyConversionName	FieldNameCurrencyConversionNameFieldLength#DisplayWidth#Position6  TppField	ppField62
FieldAliasCourseConversion	FieldNameCourseConversionFieldLength(DisplayWidth(Position7  TppField	ppField63	AlignmenttaRightJustify
FieldAliasNumSendOfDate	FieldNameNumSendOfDateFieldLength DataType	dtIntegerDisplayWidthPosition8  TppField	ppField64	AlignmenttaRightJustify
FieldAliasSummaConversion	FieldNameSummaConversionFieldLength DataTypedtDoubleDisplayWidth
Position9  TppField	ppField65
FieldAliasPassDN	FieldNamePassDNFieldLengthdDisplayWidthdPosition:  TppField	ppField66
FieldAlias	PayDetail	FieldName	PayDetailFieldLength<DisplayWidth<Position;  TppField	ppField67
FieldAliasCountKK	FieldNameCountKKFieldLengthDisplayWidthPosition<  TppField	ppField68
FieldAliasCountKKK	FieldNameCountKKKFieldLengthDisplayWidthPosition=  TppField	ppField69	AlignmenttaRightJustify
FieldAliasCbsD	FieldNameCbsDFieldLength DataType	dtIntegerDisplayWidthPosition>  TppField	ppField70	AlignmenttaRightJustify
FieldAliasCbsK	FieldNameCbsKFieldLength DataType	dtIntegerDisplayWidthPosition?  TppField	ppField71	AlignmenttaRightJustify
FieldAliasBankIdKK	FieldNameBankIdKKFieldLength DataType	dtIntegerDisplayWidth
Position@  TppField	ppField72
FieldAlias
BankNameKK	FieldName
BankNameKKFieldLengthDisplayWidth,PositionA   	TppReport	RepPayDocAutoStopDataPipelinePLPayDocPrinterSetup.BinNameDefaultPrinterSetup.DocumentNameReportPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeftPrinterSetup.mmMarginRightPrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight�� PrinterSetup.mmPaperWidth�4 Template.FileName"X:\APPS\REAL\SHB\RepPayDoc2002.rtmUnitsutMillimetersUserNameReport
DeviceTypeScreenLeftTop� Version4.1 PrommColumnWidth  TppHeaderBandppHeaderBand1mmBottomOffset mmHeight mmPrintPosition   TppDetailBandppDetailBand1DataPipelinePLPayDoc
PrintCountmmBottomOffset mmHeight^j mmPrintPosition  TppShape	ppShape53UserNameShape53mmHeight�mmLeft8� mmTop � mmWidth�>BandType  TppShape	ppShape52UserNameShape52mmHeight�mmLeft mmTop � mmWidth(�  BandType  TppShape	ppShape26UserNameShape23mmHeightXmmLeft � mmTop'mmWidth�:BandType  TppShape	ppShape22UserNameShape4mmHeightXmmLeft�* mmTop'mmWidth�2BandType  TppShape	ppShape21UserNameShape2mmHeightXmmLeft�:mmTop'mmWidth`g BandType  TppShape	ppShape15UserNameShape15mmHeightXmmLeft �  mmTop�� mmWidth��  BandType  	TppDBTextDBTextNumDocUserNameDBTextNumDoc	AlignmenttaCenter	DataFieldNumDocDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic ParentDataPipelineTransparent	mmHeight�mmLeft�I mmTopq,mmWidth.CBandType  TEtvPpDBTextDBTextStrictUserNameDBTextStrict	AlignmenttaCenter	DataFieldTDocNameDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.Style ParentDataPipelineTransparent		LookFieldStrictmmHeightxmmLeftֿ mmTopz-mmWidth�;BandType  TEtvPpDBTextEtvPpDBText12UserNamevPpDBText101	AlignmenttaCenter	DataFieldImpPayDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�� mmTopC� mmWidth�.BandType  TEtvPpDBTextEtvPpDBText14UserNamevPpDBText14	OnGetTextEtvPpDBText14GetText	AlignmenttaCenter	DataFieldTOperDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeftjV mmTopL� mmWidth�.BandType  TppLineppLine10UserNameLine10	Pen.StylepsDotParentWidth	PositionlpBottomWeight       ��?mmHeight"mmLeft mmTopa mmWidths BandType  TppLabel	ppLabel29UserNameLabel29Caption������� �����������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.Style Transparent	mmHeight�mmLeft>mmTopc- mmWidthS�  BandType  TppLabel	ppLabel30UserNameLabel30Caption�. �.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeight�mmLeft_mmTop\K mmWidth5%BandType  TppLabel	ppLabel10UserNameLabel10Caption6������� ����������� ���� ���������� ������ ����� �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.Style Transparent	WordWrap	mmHeight�.mmLeft�� mmTop[, mmWidth��  BandType  TEtvPpDBTextEtvPpDBText10UserName
vPpDBText7	DataFieldNoteDataPipelinePLPayDocAddSetFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic ParentDataPipelineTransparent	mmHeight�mmLeft�) mmTop�mmWidth��  BandType  TppLabel	ppLabel15UserNameLabel15Caption�������Font.CharsetRUSSIAN_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeight^mmLeft. mmTop�/mmWidthq,BandType  TppShape	ppShape13UserNameShape13mmHeightXmmLeft�:mmTop�� mmWidth��  BandType  TppLabel	ppLabel36UserNameLabel36	AlignmenttaCenterCaption����� �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft/bmmTop�� mmWidth?EBandType  TppLabelppLabel9UserNameLabel9	AlignmenttaCenterCaption������ �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft��  mmTop�� mmWidthsKBandType  TppShape	ppShape17UserNameShape17mmHeightXmmLeft�[ mmTop�� mmWidth�2BandType  TppLabel	ppLabel37UserNameLabel37	AlignmenttaCenterCaption
��� ������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	WordWrap	mmHeight�mmLeftU] mmTop�� mmWidthq,BandType  TppShape	ppShape19UserNameShape19mmHeightXmmLeftp� mmTop�� mmWidth(�  BandType  TppLabel	ppLabel38UserNameLabel38	AlignmenttaCenterCaption����� ��������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft� mmTop�� mmWidth'aBandType  TEtvPpDBTextPpDBTextTypeDocUserNamePpDBTextTypeDoc	AlignmenttaRightJustify	DataFieldTDocNameDataPipelinePLPayDocFont.CharsetRUSSIAN_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic ParentDataPipelineTransparent		LookFieldNamemmHeight�mmLeft�;mmTopi+mmWidth��  BandType  TppLabelppLabel1UserNameLabel1Caption�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�. mmTopi+mmWidth�BandType  TppShapeppShape3UserNameShape3mmHeightXmmLeft�� mmTop'mmWidth��  BandType  TEtvPpDBTextEtvPpDBText1UserName
vPpDBText1	AlignmenttaRightJustifyBlankWhenZero		DataFieldDateDocDataPipelinePLPayDocDisplayFormatdd/mm/yyyy �.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic ParentDataPipelineTransparent	mmHeight�mmLeft�� mmTopi+mmWidthliBandType  TppLabel	ppLabel18UserNameLabel18Caption����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft�� mmTopz-mmWidth�BandType  TppShape	ppShape23UserNameShape21mmHeightXmmLeftx] mmTop'mmWidth�BandType  TppShape	ppShape24UserNameShape22mmHeightXmmLeft q mmTop'mmWidth�:BandType  TppLabel	ppLabel40UserNameLabel40Caption	���������Font.CharsetRUSSIAN_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeight^mmLeftRr mmTop�.mmWidth�6BandType  TppShape	ppShape25UserNameShape25mmHeightXmmLeft�� mmTop'mmWidth�BandType  TppLabel	ppLabel41UserNameLabel41Caption�Font.CharsetRUSSIAN_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeight�mmLeftD� mmTopW)mmWidthpBandType  TppShape	ppShape35UserNameShape24mmHeight�UmmLeft�:mmTophBmmWidth � BandType  TppLabelppLabel5UserNameLabel5	AlignmenttaCenterCaption����� � ������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft>mmTop7DmmWidth'aBandType  TEtvPpDBTextEtvPpDBText9UserName
vPpDBText6	DataField	SummaNameDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	WordWrap	mmHeight�3mmLeft]�  mmTop.CmmWidthHR BandType  TppShape	ppShape36UserNameShape26mmHeightXmmLeftȩ mmTop }mmWidth�2BandType  TppShape	ppShape37UserNameShape37mmHeightXmmLeft�� mmTop }mmWidth�2BandType  TppShape	ppShape38UserNameShape38mmHeightXmmLeftX mmTop }mmWidth�>BandType  TppShape	ppShape39UserNameShape39mmHeightXmmLeft�I mmTop }mmWidthȯ  BandType  TEtvPpDBTextEtvPpDBText2UserName
vPpDBText2	AlignmenttaCenter	DataFieldSummaDataPipelinePLPayDocDisplayFormat##########.##=Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�_ mmTop mmWidthv�  BandType  TppLabel	ppLabel42UserNameLabel42	AlignmenttaCenterAutoSizeCaption
��� ������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	WordWrap	mmHeightXmmLeftȩ mmTop|mmWidth�2BandType  TppLabel	ppLabel43UserNameLabel43	AlignmenttaCenterCaption����� �������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	WordWrap	mmHeight�mmLeft4 mmTop|mmWidth�4BandType  TppShape	ppShape40UserNameShape27mmHeighthBmmLeft�:mmTopX�  mmWidth � BandType  TppLabelppLabel2UserNameLabel2Caption
����������ColorclBlueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft?mmTop�  mmWidthsKBandType  TEtvPpDBTextDBTextOrgDNameFullNameUserNameDBTextOrgDNameFullName	DataField	FullNameDDataPipelinePLPayDocAddSetFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic ParentDataPipelineTransparent	WordWrap		LookFieldFullNamemmHeight$#mmLeft��  mmTop��  mmWidthj BandType  TppShape	ppShape41UserNameShape28mmHeightXmmLeft�� mmToph�  mmWidth( BandType  TppShape	ppShape42UserNameShape42mmHeightXmmLeftȩ mmToph�  mmWidth�2BandType  TppLabelppLabel7UserNameLabel7	AlignmenttaCenterCaption���� �Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft� mmToph�  mmWidthi+BandType  TEtvPpDBTextBCountDTextUserNameBCountDText	OnGetTextBCountDTextGetText	AlignmenttaCenter	DataFieldBCountDDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft� mmTopV�  mmWidth��  BandType  TppShape	ppShape43UserNameShape43mmHeight�2mmLeft�:mmTop��  mmWidth � BandType  TppLabel	ppLabel23UserNameLabel23Caption����-�����������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft>mmTop�  mmWidth�mBandType  TEtvPpDBTextEtvPpDBText16UserNamevPpDBText12	DataField	BankNameDDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent		LookFieldNamemmHeight�mmLeft��  mmTop�  mmWidth�E BandType  TppLabel	ppLabel31UserNameLabel31Caption� �.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft��  mmTop��  mmWidth�BandType  TEtvPpDBTextEtvPpDBText17UserNamevPpDBText17	DataField	BankNameDDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent		LookField	PlaceNamemmHeight�mmLeft��  mmTop��  mmWidth`�  BandType  TppShapeppShape1UserNameShape1mmHeightXmmLeft�� mmTopH�  mmWidth�2BandType  TppShape	ppShape44UserNameShape44mmHeightXmmLeft�I mmTopH�  mmWidth }BandType  TppShape	ppShape45UserNameShape45mmHeight�mmLeft( mmTopH�  mmWidth�2BandType  TppLabel	ppLabel17UserNameLabel17	AlignmenttaCenterCaption	��� �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeightmmLeft�  mmTop��  mmWidth$#BandType  TEtvPpDBTextEtvPpDBText7UserName
vPpDBText5	AlignmenttaCenter	DataFieldMfoDDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent		LookFieldKodOtdmmHeight�mmLeftsW mmTop��  mmWidthIeBandType  TppShape	ppShape10UserNameShape10mmHeight�2mmLeft�:mmTop�	 mmWidth � BandType  TppShape	ppShape27UserNameShape35mmHeightXmmLeft( mmTop! mmWidth�2BandType  TppShape	ppShape28UserNameShape36mmHeightXmmLeft�I mmTop! mmWidth }BandType  TppShape	ppShape46UserNameShape46mmHeightXmmLeft�� mmTop! mmWidth�2BandType  TppLabelppLabel3UserNameLabel3Caption����-����������ColorclBlueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeight�mmLeft�<mmTop� mmWidthchBandType  TppLabel	ppLabel44UserNameLabel44	AlignmenttaCenterCaption	��� �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeightmmLeft� mmTopR mmWidth$#BandType  TEtvPpDBTextEtvPpDBText8UserName
vPpDBText8	AlignmenttaCenter	DataFieldMfoKDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent		LookFieldKodOtdmmHeight�mmLeft{X mmTop�& mmWidthIeBandType  TEtvPpDBTextEtvPpDBText19UserNamevPpDBText19	DataField	BankNameKDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent		LookFieldNamemmHeight�mmLefto�  mmTop� mmWidthL BandType  TppLabel	ppLabel24UserNameLabel24Caption� �.Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLefto�  mmTopA mmWidth�BandType  TEtvPpDBTextEtvPpDBText18UserNamevPpDBText18	DataField	BankNameKDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent		LookField	PlaceNamemmHeight�mmLeftE�  mmTopA mmWidthK�  BandType  TppShape	ppShape32UserNameShape32mmHeighthBmmLeft�:mmToph< mmWidth � BandType  TppShape	ppShape47UserNameShape47mmHeight�mmLeftu� mmTop�c mmWidthA BandType  TppShape	ppShape48UserNameShape48mmHeight�mmLeftѩ mmTop�c mmWidth�2BandType  TppLabel	ppLabel32UserNameLabel32Caption
����������ColorclBlueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTopT> mmWidth�MBandType  TppLabel	ppLabel45UserNameLabel45	AlignmenttaCenterCaption���� �Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft� mmTop�i mmWidthi+BandType  TEtvPpDBTextEtvPpDBText5UserNameDBTextOrgDNameFullName1	DataField	FullNameKDataPipelinePLPayDocAddSetFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic ParentDataPipelineTransparent	WordWrap		LookFieldFullNamemmHeight,$mmLeft��  mmTopT> mmWidthi BandType  TEtvPpDBTextBCountKTextUserNameBCountKText	OnGetTextBCountDTextGetText	AlignmenttaCenter	DataFieldBCountKDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft� mmTop�g mmWidth`�  BandType  TppShape	ppShape49UserNameShape40mmHeight�ammLeft�:mmTop�~ mmWidth � BandType  TppLabelppLabel6UserNameLabel6	AlignmenttaCenterCaption���������� �������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTopy� mmWidth BandType  TEtvPpDBTextEtvPpDBText11UserName
vPpDBText9	DataFieldDestinationDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	WordWrap	mmHeight�XmmLeft4�  mmTop�� mmWidthi7 BandType  TppShapeppShape2UserNameShape29mmHeight�mmLeft�:mmTopx� mmWidth(�  BandType  TppLabelppLabel4UserNameLabel4Caption��� �����������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�SmmTop�� mmWidth�lBandType  TppShape	ppShape29UserNameShape30mmHeight�mmLeft��  mmTopx� mmWidth(�  BandType  TppLabel	ppLabel34UserNameLabel34Caption��� �����������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft��  mmTop�� mmWidth�oBandType  TppShape	ppShape30UserNameShape301mmHeight�mmLeft�z mmTopx� mmWidth(�  BandType  TppLabel	ppLabel19UserNameLabel19Caption��� �������� ����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft� mmTop�� mmWidth�pBandType  TppShape	ppShape31UserNameShape31mmHeight�mmLeft mmTopx� mmWidth(�  BandType  TppLabel	ppLabel14UserNameLabel14	AlignmenttaCenterCaption��� �������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�F mmTop�� mmWidth�MBandType  TppShape	ppShape33UserNameShape33mmHeight�mmLeft8� mmTopx� mmWidth�>BandType  TppLabel	ppLabel33UserNameLabel33	AlignmenttaCenterCaption�������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�� mmTop�� mmWidth�5BandType  TppShape	ppShape34UserNameShape34mmHeight�mmLeft�:mmTop � mmWidth(�  BandType  TppShape	ppShape50UserNameShape302mmHeight�mmLeft��  mmTop � mmWidth(�  BandType  TppShape	ppShape51UserNameShape51mmHeight�mmLeft�z mmTop � mmWidth(�  BandType  TEtvPpDBTextINNDUserNameINND	AlignmenttaCenter	DataFieldOrgDNameDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent		LookFieldINNmmHeight�mmLeft^mmTopL� mmWidth�YBandType  TEtvPpDBTextEtvPpDBText6UserNameINND1	AlignmenttaCenter	DataFieldInnKDataPipelinePLPayDocAddSetFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic ParentDataPipelineTransparent		LookFieldINNmmHeight�mmLeftH�  mmTopL� mmWidth�YBandType  TppShapeppShape4UserNameShape101mmHeight�2mmLeft�:mmTop� mmWidth � BandType  TppLabel	ppLabel21UserNameLabel21Caption������������� �����-����������ColorclBlueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeightmmLeft>mmTop�	 mmWidth�nBandType  TppShapeppShape5UserNameShape5mmHeightXmmLeft�� mmTop� mmWidth( BandType  TppShape	ppShape54UserNameShape54mmHeightXmmLeftȩ mmTop� mmWidth�2BandType  TppLabel	ppLabel13UserNameLabel13	AlignmenttaCenterCaption���� �Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBold Transparent	mmHeightxmmLeft� mmTop mmWidthi+BandType  TppShape	ppShape55UserNameShape55mmHeightXmmLeft �  mmTop� mmWidth�2BandType  TppShape	ppShape56UserNameShape56mmHeightXmmLeft�, mmTop� mmWidth }BandType  TppLabel	ppLabel46UserNameLabel46	AlignmenttaCenterCaption	��� �����Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeightmmLeftb mmTop� mmWidth$#BandType  TppShape	ppShape57UserNameShape57mmHeight�mmLeft�:mmTopP: mmWidth��  BandType  TppLabelppLabel8UserNameLabel8	AlignmenttaCenterCaption������� �� ��������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�;mmTop�< mmWidth\�  BandType  TppShapeppShape6UserNameShape6mmHeight�mmLeftP�  mmTopP: mmWidth@�  BandType  TppShape	ppShape58UserNameShape58mmHeight�mmLeft�_ mmTopP: mmWidthP�  BandType  TEtvPpDBTextEtvPpDBText13UserNamevPpDBText10	AlignmenttaCenter	DataFieldPenaltyDataPipelinePLPayDocAddSetFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBoldfsItalic ParentDataPipelineTransparent	mmHeight�mmLeftp�  mmTop�< mmWidthԔ  BandType  TppLabel	ppLabel47UserNameLabel47	AlignmenttaCenterCaption�������� ������� �� ����� �Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�d mmTop�< mmWidth�  BandType  TppShape	ppShape59UserNameShape59mmHeight�mmLeft�" mmTopP: mmWidth��  BandType  TppShape	ppShape60UserNameShape41mmHeightXmmLeft�:mmTop�M mmWidth � BandType  TppLabel	ppLabel48UserNameLabel48	AlignmenttaCenterCaption���� � ����� �������� ������:Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�;mmTop7P mmWidth#�  BandType  TppShape	ppShape61UserNameShape61mmHeightXmmLeftymmTop0i mmWidth�� BandType  TppShape	ppShape62UserNameShape49mmHeightXmmLeft�:mmTop0i mmWidth�>BandType  TppLabel	ppLabel49UserNameLabel49Caption������ �������ColorclBlueFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	WordWrap	mmHeightmmLeft@mmTop�f mmWidth�3BandType  TppShape	ppShape63UserNameShape50mmHeight�mmLeft�:mmTop�� mmWidth � BandType  TppLabel	ppLabel50UserNameLabel50Caption����������� ������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTop�� mmWidth~BandType  TppShape	ppShape64UserNameShape501mmHeight'mmLeft�:mmTop� mmWidth � BandType  TppLabel	ppLabel51UserNameLabel51Caption����� � ������������/��������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTop�� mmWidth��  BandType  TppShapeppShape7UserNameShape7mmHeight�:mmLeft�:mmTop � mmWidth � BandType  TppLabel	ppLabel25UserNameLabel25Caption!���� �������������_______________Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTop�� mmWidth��  BandType  TppLabel	ppLabel28UserNameLabel28Caption*______________________           (�������)Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	WordWrap	mmHeight�mmLeft�� mmTop�� mmWidth�qBandType  TppLabel	ppLabel27UserNameLabel27Caption������������� �����-�����������Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size	
Font.StylefsBold Transparent	mmHeight�mmLeft�<mmTop�� mmWidth��  BandType  TppShapeppShape8UserNameShape8mmHeightXmmLeft�. mmTop�� mmWidth �  BandType  TppShapeppShape9UserNameShape9mmHeight�mmLeft�:mmTop mmWidth��  BandType  TppShape	ppShape12UserNameShape12mmHeight�mmLeft �  mmTop mmWidth��  BandType  TppShape	ppShape14UserNameShape14mmHeight�mmLeft�[ mmTop mmWidth�2BandType  TppShape	ppShape16UserNameShape16mmHeight�mmLeftp� mmTop mmWidth(�  BandType  TppShape	ppShape18UserNameShape18mmHeight�mmLeft�. mmTop mmWidth �  BandType  TEtvPpDBTextEtvPpDBText3UserName
vPpDBText3	AlignmenttaCenter	DataFieldCurrencyDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�� mmTop1�  mmWidthz-BandType  TppLabel	ppLabel11UserNameLabel11Caption�/�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�I mmTopA mmWidth�BandType  	TppDBText	ppDBText1UserNameDBText1	DataFieldCountKKKDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLefto` mmTopA mmWidthͲ  BandType  	TppDBText	ppDBText2UserNameDBText2	DataFieldPassDNDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeftQ  mmTopYT mmWidth�M BandType  	TppDBText	ppDBText3UserNameDBText3	DataField	PayDetailDataPipelinePLPayDocFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name	Arial Cyr	Font.Size

Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft(�  mmTop/n mmWidthl BandType  	TppDBText	ppDBText5UserNameDBText5	AlignmenttaCenter	DataFieldCountKKDataPipelinePLPayDocFont.CharsetANSI_CHARSET
Font.ColorclBlack	Font.Name	Arial CYR	Font.Size
Font.StylefsBoldfsItalic Transparent	mmHeight�mmLeft�� mmTop  mmWidth� BandType  TEtvPpDBTextEtvPpDBText4UserName
vPpDBText4	AlignmenttaCenter	DataField
BankNameKKDataPipelinePLPayDocFont.CharsetANSI_CHARSET
Font.ColorclBlack	Font.Name	Arial CYR	Font.Size
Font.StylefsBoldfsItalic Transparent		LookFieldKodmmHeight�mmLeft�/ mmTop  mmWidth�vBandType  TEtvPpDBTextEtvPpDBText15UserNamevPpDBText11	DataField
BankNameKKDataPipelinePLPayDocFont.CharsetANSI_CHARSET
Font.ColorclBlack	Font.Name	Arial CYR	Font.Size

Font.StylefsBoldfsItalic Transparent		LookFieldNamemmHeight�mmLeft�<mmTop�( mmWidth�� BandType   TppFooterBandppFooterBand1VisiblemmBottomOffset mmHeight mmPrintPosition    TppBDEPipelinePLPayDocAddSet
DataSourcePayDocAddSetSRangeEndreCurrentRecord
RangeBeginrbCurrentRecordUserNamePLPayDocAddSetLeftWTope TppField	ppField46
FieldAlias	FullNameK	FieldName	FullNameKFieldLengthdDisplayWidthdPosition   TppField	ppField47
FieldAliasNote	FieldNameNoteFieldLength3DisplayWidth3Position  TppField	ppField48
FieldAlias
DateDocStr	FieldName
DateDocStrFieldLengthDisplayWidthPosition  TppField	ppField49
FieldAliasPenalty	FieldNamePenaltyFieldLengthdDisplayWidthdPosition  TppField	ppField50
FieldAlias	FullNameD	FieldName	FullNameDFieldLengthdDisplayWidthdPosition  TppField	ppField61
FieldAliasInnK	FieldNameInnKFieldLengthDisplayWidthPosition   TDataSourcePayDocAddSetSDataSetPayDocAddSetLeftKTop2  TLinkSource	MoneyUseVName	MoneyUseVLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetMoneyUseVDeclarSource	MoneyUseV  Active		TableNameSTA.MoneyUseVDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left� Top�  
TLinkTableMoneyUseVDeclarDatabaseNameAO_GKSM_InProgramIndexFieldNames
sGroup;KodReadOnly		TableNameSTA.MoneyUseVCaption������������� �������� �������UniqueFields
sGroup;Kod TIntegerFieldMoneyUseVDeclarKodDisplayLabel���DisplayWidth	FieldNameKod  TStringFieldMoneyUseVDeclarNameDisplayLabel������ ��������	FieldNameNameSize  TSmallintFieldMoneyUseVDeclarsGroupTagDisplayLabel������DisplayWidth	FieldNamesGroupVisible  TXELookFieldMoneyUseVDeclarsGroupNameDisplayLabel������DisplayWidth	FieldKindfkLookup	FieldName
sGroupNameLookupDataSetMoneyUseGroupLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldssGroupSizeListFieldIndex HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TFloatFieldMoneyUseVDeclarSummaDisplayLabel�����	FieldNameSummaDisplayFormat### ### ###    TDBFormControl
MoneyUseVCActive	HelpContext FormName	dbDefaultFormRect.FormLeftFormRect.FormTopFormRect.FormWidth'FormRect.FormHeightfFormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption������������� �������� �������	DefSource	MoneyUseVSourcesSource	MoneyUseV  Left� Topc  TLinkSourceMoneyUseGroupNameMoneyUseGroupLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetMoneyUseGroupDeclarSourceMoneyUseGroup IFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSetMoneyUseGroupLookup  Active		TableNameSTA.SprMoneyUseGroupDatabaseNameAO_GKSM_InProgramIFNUnique.Options LeftNTop�  
TLinkTableMoneyUseGroupDeclarDatabaseNameAO_GKSM_InProgram	TableNameSTA.SprMoneyUseGroupCaption%������ ������������� �������� ������� TSmallintFieldMoneyUseGroupDeclarKodDisplayLabel���DisplayWidth	FieldNameKodRequired	  TStringFieldMoneyUseGroupDeclarNameDisplayLabel������	FieldNameName   
TLinkQueryMoneyUseGroupLookupDatabaseNameAO_GKSM_InProgramSQL.Strings7select Kod, Name from STA.SprMoneyUseGroup order by Kod UniDirectional	
UpdateModeupWhereKeyOnly TSmallintFieldMoneyUseGroupLookupKodDisplayWidth	FieldNameKodOriginSprMoneyUseGroup.Kod  TStringFieldMoneyUseGroupLookupName	FieldNameNameOriginSprMoneyUseGroup.Name    TDBFormControlMoneyUseGroupCActive	HelpContext FormName	dbDefaultFormRect.FormLeft� FormRect.FormTopFormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption%������ ������������� �������� �������	DefSourceMoneyUseGroupSourcesSourceMoneyUseGroup  LeftNTope  TLinkSourceSprPayDocStateAcceptNameSprPayDocStateAcceptLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.Name!SprPayDocStateAccept(primary key)IFNItem.FieldsKodIFNItem.OptionsixUnique Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetSprPayDocStateAcceptDeclarSourceSprPayDocStateAccept IFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldLookup	LinkStateltQueryDataSetSprPayDocStateAcceptLookup  Active		TableNameSTA.SprPayDocStateAcceptDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left�Top2 
TLinkTableSprPayDocStateAcceptDeclarDatabaseNameAO_GKSM_InProgramIndexFieldNamesKodReadOnly		TableNameSTA.SprPayDocStateAcceptCaption)���������� ��������� ��������� ���������� TSmallintFieldSprPayDocStateAcceptDeclarKodDisplayLabel���DisplayWidth	FieldNameKodRequired	  TStringFieldSprPayDocStateAcceptDeclarNameDisplayLabel������������ ���������	FieldNameNameRequired	Size   
TLinkQuerySprPayDocStateAcceptLookupDatabaseNameAO_GKSM_InProgramSQL.Strings;select Kod, Name from STA.SprPayDocStateAccept order by Kod UniDirectional	
UpdateModeupWhereKeyOnly	TableNameSTA.SprPayDocStateAcceptUniqueFieldsKod TSmallintFieldSprPayDocStateAcceptLookupKodDisplayWidth	FieldNameKodOriginSprPayDocStateAccept.Kod  TStringFieldSprPayDocStateAcceptLookupName	FieldNameNameOriginSprPayDocStateAccept.NameSize    TDBFormControlSprPayDocStateAcceptCActive	HelpContext FormName	dbDefaultFormTools.PopupMenuPopupFormTools.TypePrintpdNoneFormTools.TypeDevice	dvPrinterFormTools.TypeToolsfcNoneCaption)���������� ��������� ��������� ����������	DefSourceSprPayDocStateAcceptSourcesSourceSprPayDocStateAccept  Left�Top  TLinkSourcePayDocStateAcceptNamePayDocStateAcceptLinkMaster.IFNLink LinkMaster.IFNItem.Options LinkMaster.Find.IFNItem.Options !LinkMaster.Find.IFNUnique.Options LinkSetsIFNLink IFNItem.Options Find.IFNItem.Options Find.IFNUnique.Options StyleldDeclar	LinkStateltTableDataSetPayDocStateAcceptDeclarSourcePayDocStateAccept  Active		TableNameSTA.PayDocStateAcceptDatabaseNameAO_GKSM_InProgramIFNUnique.Options Left�Tope 
TLinkTablePayDocStateAcceptDeclarDatabaseNameAO_GKSM_InProgramIndexFieldNamessDate;IDMasterFieldsDateDoc;NumSendOfDateMasterSourcePayDocReadOnly		TableNameSTA.PayDocStateAccept 
TDateFieldPayDocStateAcceptDeclarsDateDisplayLabel���� ���DisplayWidth	FieldNamesDateRequired	  TSmallintFieldPayDocStateAcceptDeclarIDDisplayLabel� ���DisplayWidth	FieldNameIDRequired	  TSmallintFieldPayDocStateAcceptDeclarStateTagDisplayLabel��� ����DisplayWidth	FieldNameStateRequired	Visible  TXELookField PayDocStateAcceptDeclarStateNameDisplayLabel��������� ���������DisplayWidth	FieldKindfkLookup	FieldName	StateNameLookupDataSetSprPayDocStateAcceptLookupLookupKeyFieldsKodLookupResultFieldKod;Name	KeyFieldsStateSizeListFieldIndex HeadLine		HeadColor�ʦ OptionsfoEditWindowfoKeyFieldEdit StoreLookupData	Lookup	  TStringFieldPayDocStateAcceptDeclarTextDisplayLabel��������� ���������DisplayWidth7	FieldNameTextSize�      