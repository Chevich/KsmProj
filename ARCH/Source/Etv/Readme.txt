		Etv Library v3.3   Shareware


	DB component pack for Borland Delphi 3-5. 
	Rapid development of powerful db applications.


	CONTENTS
	========
	What's new
	Installation and tunning
	Overview
	Thanks
	Contact us


		WHAT'S NEW
		==========

Version 3.3
- All units are remaked, library has been divided into base package 
  and separate parts, each part can work independently; user may register
  whole Etv Library or separate its parts.   
- Etv Library has been tested with Delphi 5.0 Update Pack 1. 
- FieldQuotes property is added to TEtvFilter and TEtvSortingCombo;
- Caption and ExternalInfo properties are added to TEtvFilter and its 
  SubDataSets;
- NotUseOldFilter property is added to TEtvFilter; 
- Quotes parameter is added to AllFieldNames, SortingToDataSet and
  SortingToSQL procedures;
- Value AutoWidth is added to the Options property of TFormDB;
- Some bugs have been fixed. 

Version 3.2
- TEtvDBLookupCombo can change LookupDataSet sorting criteria;
- Popup menu of TEtvDBLookupCombo has been added;
- Some bugs have been fixed. 

Version 3.1
- Delphi 5 is now supported; 
- Library can work without BDE, see file Etv.inc;
- TEtvFilter works with any dataset;
- Edit Forms Calling Mechanism works with any dataset. The OnEditData 
  event has been added to TEtvDBLookupCombo and TEtvLookField;
- TotalFont property has been added to the TEtvDBGrid component;
- StoreLookupData property has been added to the TEtvLookField field 
  for compatibility with different datasets. If TEtvLookField doesn't
  work with some datasets when StoreLookupData=true, set this property 
  to false. For example, this is required for ADO datasets from Delphi 5.
  Otherwise set this property to true to increase speed. For example, 
  this works for all descendants of TBDEDataset. If you upgraded from 
  previous versions of Etv library, now all EtvLookField will have 
  StoreLookupData=false.  
 

		INSTALLATION and TUNNING
		========================

   1. Installation

     1.0. Check options in Etv.inc (version with source code)
- Use of BDE
- Use of Midas
- Etv dataset editor (popup menu in designer) to TTable, TQuery
- Calc autoincremental fields at client
- Insert and Delete record by PopupMenu
- Visibility operations first, previos, next, last in the DB controls 
  popup menus
- etc.

     1.1. Installation for Delphi 3 without source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages. Install design-time package DclEtv.dpl

     1.2. Installation for Delphi 3 with source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages. 
   Open Delphi. Close current project. Compile run-time package RtlEtv.dpk
and put compiled files into directory that is accessible through the PATH.
Open and install design-time package DclEtv.dpk
   After it restart Delphi NECESSARILY.
   Note: If you use Rx Library, you must delete redefinition of VerInfo 
unit on installation time: Menu Tools - Environment options - Library - 
Unit Aliases - VerInfo=RxVerInf

     1.3. Installation for Delphi 4 without source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages. Install design-time package DclEtv4.bpl 

     1.4. Installation for Delphi 4 with source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages.
   Open Delphi. Close current project. Compile run-time package RtlEtv4.dpk
and put compiled files into directory that is accessible through the PATH. 
Open and install design-time package DclEtv4.dpk
   After it restart Delphi NECESSARILY.

     1.5. Installation for Delphi 5 without source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages. Install design-time package DclEtv5.bpl 

     1.6. Installation for Delphi 5 with source code
   Uninstall previous installed version of Etv Library and remove all 
compiled ETV Library packages.
   Open Delphi. Close current project. Compile run-time package RtlEtv5.dpk
and put compiled files into directory that is accessible through the PATH. 
Open and install design-time package DclEtv5.dpk
   After it restart Delphi NECESSARILY.

   2. Tunning

- Redefinition in EtvOther.pas
- Constants in EtvConst.pas
- Options in Etv.inc (version with source code)

   3. Use of T[DB]DateEdit from RX inside Etv library.
Install package EtvRX in Delphi3 or EtvRx4 in Delphi4. Attach unit
EtvRXAdd to your project.

   4. For representation save lookup values in ReportBuilder install
package EtvPP in Delphi3 or EtvPP4 in Delphi4.

   5. Demostration program is in subdirectory Example. For design-time
need define alias "EtvExample" for paradox to it directory.



		OVERVIEW
		========

	Components for supporting lookup information
	--------------------------------------------

TEtvLookField, TEtvDBLookupCombo, TEtvDBGrid, etc. 

The lookup components include lookup combo box, dbgrid, lookup field and 
other auxiliary components. They allow for the following features: 
- Display of several fields in the closed lookup combo box and in the grid 
- Setting filters on the lookup drop-down list 
- Multi-level lookup combo box with fixed levels and trees 
- Advanced incremental search with displayed input string; can work with 
  numbers 
- Calling LookupDataset edit form and getting values from it 
- Direct editing KeyField in the LookupComboBox and in the Grid 
- Toggling search/input column 
- Toggling between lookup dataset sorting criteria 
- Special lookup field with support of all lookup features, including 
  determination of several fields in the LookupResultField property 
- Saving lookup information for later use (from lookupResultField and other 
  special properties) 
- Components for displaying saved lookup information 
- Defining TFont for any line from lookup drop-down list 
- Lookup list headers. These display field names or other user-defined 
  information 
- Automatic choice of input column (for "Number;Text" fields) 
- Possibility of working inside the TDBCtrlGrid
- Possibility of setting values not present in the LookupDataSet 
- Other properties and options 

 
	DBGrid 
	------

TEtvDBGrid is descendant of TDBGrid with: 
- Powerful lookup fields (see above), supporting all of Etv Lookup features 
- Multi-line headers, changing number of header rows depending on the column 
  size 
- "Total" row at the bottom of the grid which can show any information such 
  as column sums, quantity of records, etc. 
- Fixed list fields 
- Font and color settings for any cell including in the editing mode 
- User-defined visibility and sequence of fields in a special dialog window. 
  Some fields may be marked as internal and always-hidden 
- Possibility to print out a table or one record in the text or graphics 
  mode with title, page setup, numbering, fonts choice, line spacing, etc.,
  as well as to save in a text file 
- Toggling between keyboard layouts 
- Records cloning 
- Generation of one-record editing window 
- User-defined substitution of controls for any field types. For example, 
  descendant of TDateEdit from RX library may be used as date editor 
- Other functions and options 
 

	Query and filter builder, sorting and search for records
	--------------------------------------------------------

TEtvFilter component allows the end-user to define queries and filters 
for single datasets and groups of datasets linked as master-detail or 
differently. It automatically substitutes the dataset for the generated 
query and vice versa; may set a filter to the dataset in simple cases. 
Defining conditions in a special dialog window, user may easily define 
any extracts of information. Information can be saved to stream and
to disk. One can create (recommended) one's own procedure for saving 
information to one's database or anywhere else.
It is simple in use, user needs only to set DataSource and call the 
Execute method. 

TEtvDBSortingCombo component allows to change the order of records in 
the dataset, including SQL datasets (such as TQuery). The user can 
define the list of sorting criteria. List of available sorting criteria 
may be taken from:
- Items property, when property SelfList=true.
- Index list - for the TTable and similar datasets with the IndexFields 
  property or other descendant of TDBDataSet with TableName property 
  (TEtvQuery has that property)
- SortingList property of dataset. Etv datasets have that property, 
  one can define it in one's own datasets.

TEtvFindDlg component can search for records by using sorting fields, 
including SQL datasets (such as TQuery). It shows a dialog with controls 
for input of search values. Parameters "Case sensitive" and "Full coincidence" 
are used. It can look for nearest records.
It is simple in use, user needs only to set DataSource and call the Execute 
method.

	Fixed list fields
	-----------------

These are TEtvListField, TEtvDBCombo and other components for short fixed 
lists. Text values from the list correspond to smallint values from the 
database. For example, "small/middle/large" in the application will 
correspond to "0/1/2" in the database. The user describes text values in 
the TEtvListField and they are used everywhere.


	Edit Forms Calling Mechanism & Base DB Form 
	-------------------------------------------

Direct calling of edit form for any dataset displayed on a form, transfer 
of values to the edit form, setting of the dataset position, return of 
values from the edit form. Most useful for editing lookup datasets. 

Definition of "OnEditData" events in the data-aware controls and in the 
datasets  allows to proceed from data to their edit forms (Such events 
exist in the TEtvDBLookupCombo and TEtvLookField components). Components 
TEtvDBLookupCombo and TEtvDbGrid can use this event, send current key value 
(KeyField.Name and KeyField.Value) there, assign the returned value and 
refresh lookup information. TFormBase form can obtain, use and return these 
values.  

Base Etv DB Form is TFormBase with automatic page generation for editing 
one record, defining and setting of filters and queries, opening, sorting, 
searching and refreshing of information, auto calculation of its width by 
main dataset grid, procedures for quick creation, searching and calling of 
forms, other properties that can be visible in the Object Inspector at the 
design-time, other functions and options.


	Popup menus
	-----------

	RUN-TIME. 
Popup menus of data-aware controls contain functions of navigation, records 
cloning, plus many others depending on the type of controls. 
Popup menus are auto attached to all etv controls without them; they have 
fully functional shortcuts. Only one instance of popup menu of each type 
is created and used for all corresponding controls. 

Functions for different controls:

EtvDBLookupCombo. Changing search/input column, toggling between lookup 
dataset sorting criteria. 
DBGrid/EtvDBGrid. fields visibility, printing of current record, printing 
of grid, one record/grid toggling, calculation of field length. 
DBMemo. Copying, inserting, selecting all. 
DBRichEdit/EtvDBRichEdit. Font, basic font, paragraph setting; 
searching/replacing, printing, copying, inserting, selecting all. 
DBImage. Copying, inserting, loading from file, saving to file, clearing, 
scaling. 

	DESIGN-TIME. 

Dataset popup menu allows: 
- Data browsing, editing and other operations in the designer 
- Copying information to clipboard 
- Copying labels from database remarks.  
- Auto correcting 
- Info about dataset and its fields 

Popup menus of data-aware controls allow proceeding to dataset and 
datafield. EtvDBLookupCombo also allows width auto sizing, proceeding 
to lookup dataset.

Choice of active TabSheet is added to Popup menu of TEtvPageControl, as  
it is complicated seldom from other controls.


	Controls for db fields & User controls substitution into the library
	--------------------------------------------------------------------

Certain library components, such as TEtvFilter, TEtvFindDlg, TFormBase, 
TEtvDbGrid, etc., while running, create controls (data-aware or data-unaware)
for different field types. A set of functions is used to adapt these controls 
to the fields and attach multifunction popup menus to them.

Creation of controls may be re-determined for any field type, including 
controls using in the TEtvDbGrid component. For this, the required variable 
in your project or library should simply be assigned the function of creation. 
Redefined controls will be used by etv components.


	Other components and mechanisms
	-------------------------------

- Etv datasets  
	- Editing data in design-time; You may call "Base DB form" and  
	  edit, sort, search data, get extracts of information there.   
	- Popup menu in designer consists copying to the clipboard, 
	  pumping labels from the database remarks, field auto correction, 
	  info about dataset and its fields. 
	- Checking a mastersource by inserting a record, i.e. master record 
	  must exist and if one is in the insert mode it call post. 
	- Autoincrement fields calculation from Delphi for single user 
	  applications. 
	- Other properties and events 
- TPageControl+TTabSheet. Turn off the data on inactive pages to increase 
  speed. It can turn off dbaware control from datasource and detail dataset 
  from master. 
- Automatic opening/refreshing datasets in the run-time. This mechanism may 
  open datasets in datamodules (not all, optionally) when project opening, 
  opening or refreshing some datasets represented on a form then one become 
  active. 
- TEtvPrinter and auxiliary components. Printing in the text and graphics 
  mode, output to the file, page setup, numbering, fonts choice, including 
  text mode, line spacing and etc. 
- TEtvRecordCloner Records cloning for the one dataset or for the group of 
  datasets linked as master-detail or differently. Cloning confirmation and 
  confirmation on each detail-dataset, events for finishing fill for each 
  record. 
- TEtvDBRichEdit. Transparent (record-by-record) search and replacing, i.e.
  it can process from record to record, dialog for it. Search and replacing 
  again. Popup menu with font, basic font, paragraph, search/replacing, print,
  copying, inserting, selecting all. 
- Various functions for design and run time, property and component editors. 


		Thanks
		======

Special thanks for Valery Poputhevich for assist in development of first 
version of Etv library.

Thanks to Alex Plas for assist in development of TFormDB, Alexander Gerus,
Alex Kogan for interesting ideas. 
        
       
		Contact us
		==========

Etv Software	http://www.etvsoft.com
home page	

support		support@etvsoft.com
e-mail		info@etvsoft.com

Igor Kravchenko
