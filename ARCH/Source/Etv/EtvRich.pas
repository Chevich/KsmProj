unit EtvRich;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls,
     Buttons, StdCtrls,comctrls,dbctrls,Menus,EtvPopup;

const RtfMin='{}';

type
  TEtvDBRichEdit=class(TDBRichEdit)
  protected
    fSearchGlobal:boolean;
    fRecordName:string;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
  Public
    procedure BeginEditing;
  published
    property RecordName:string read fRecordName write fRecordName;
    property SearchGlobal:boolean read fSearchGlobal write fSearchGlobal;
  end;

  TScopeFind=(sfFromFirst,sfFromCurrent,sfCurrent,sfSelected);
  TSearchType=(stSearch,stReplace,stReplaceAll);

  TRichEditSearch = class(TForm)
    BtnFind: TButton;
    BtnCancel: TButton;
    GroupBoxOptions: TGroupBox;
    CheckBoxCase: TCheckBox;
    CheckBoxWhole: TCheckBox;
    ComboBoxFind: TComboBox;
    GroupBoxScope: TGroupBox;
    RadioButtonGlobal: TRadioButton;
    RadioButtonFromCurrent: TRadioButton;
    RadioButtonOnlyCurrent: TRadioButton;
    RadioButtonSelected: TRadioButton;
    GroupBoxOrigin: TGroupBox;
    RadioButtonEntire: TRadioButton;
    RadioButtonFromCursor: TRadioButton;
    LabelFind: TLabel;
    LabelReplace: TLabel;
    ComboBoxReplace: TComboBox;
    CheckBoxPrompt: TCheckBox;
    BtnReplace: TButton;
    BtnReplaceAll: TButton;
    procedure BtnFindClick(Sender: TObject);
    procedure BtnReplaceClick(Sender: TObject);
    procedure BtnReplaceAllClick(Sender: TObject);
    procedure RadioButtonSelectedClick(Sender: TObject);
  protected
    SearchType:TSearchType;
    ScopeFind:TScopeFind;
    FromCursor:boolean;
    SearchTypes:TSearchTypes;
    Prompt:Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Execute(aReplace:boolean; RichEdit:TDBRichEdit);
    procedure SearchAgain(RichEdit:TDBRichEdit);
  end;

var RichEditSearch: TRichEditSearch;


function RichEditFindText(RichEdit:TCustomRichEdit; aText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext:boolean):integer;

function DBRichEditFindText(RichEdit:TDBRichEdit; aText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext,aMessage:boolean):integer;

function DBRichEditReplaceText(RichEdit:TDBRichEdit; aText,aNewText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext,aMessage,aPrompt:boolean):integer;

type
  TPopupMenuEtvDBRichEdit=class(TPopupMenuEtvDBMemo)
  protected
    fRichEditLineCount:smallint;
    procedure ProcOnPopup(Sender: TObject; LineAdd:smallint); override;
    procedure ChangeFont(Sender: TObject);
    procedure SetBaseFont(Sender: TObject);
    procedure ChangeParagraph(Sender: TObject);
    procedure SearchReplace(Sender: TObject);
    procedure SearchReplaceAgain(Sender: TObject);
    procedure Print(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
end;
function PopupMenuEtvDBRichEdit:TPopupMenu;

IMPLEMENTATION

uses Messages,DB,TypInfo,Dialogs,
     EtvDB,EtvDBFun,EtvConst,EtvBor,EtvPas,DiPara,DiReplace;
{$R *.DFM}

{TEtvDBRichEdit}
procedure TEtvDBRichEdit.KeyPress(var Key: Char);
begin
  with TDBRichEditBorland(self) do
    if fMemoLoaded and (Key in [#32..#255]) and
       (fDataLink.Field <> nil) and
       fDataLink.Field.IsValidChar(Key) then BeginEditing;
  inherited;
end;

procedure TEtvDBRichEdit.Loaded;
begin
  inherited;
  if (not(csDesigning in ComponentState)) and (PopupMenu=nil) then
    PopupMenu:=PopupMenuEtvDBRichEdit;
end;

procedure TEtvDBRichEdit.BeginEditing;
begin
  with TDBRichEditBorland(Self) do
    if not FDataLink.Editing then try
      if FDataLink.Field.IsBlob then
        FDataSave := FDataLink.Field.AsString;
      if FDataSave='' then begin
        {DefAttributes.Assign(Font);}
        FDataSave:=RtfMin;
      end;
      FDataLink.Edit;
    finally
      FDataSave := '';
    end;
end;

function RichEditFindText(RichEdit:TCustomRichEdit; aText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext:boolean):integer;
var iBeg,iLength:integer;
begin
  with RichEdit do begin
    if ScopeFind=sfSelected then begin
      iBeg:=SelStart;
      iLength:=SelLength;
    end else begin
      if fromCursor then
        if aNext then iBeg:=SelStart+SelLength
        else iBeg:=SelStart
      else iBeg:=0;
      iLength:=Length(Text)-iBeg;
    end;
    Result:=FindText(aText,iBeg,iLength,SearchTypes);
    if Result<>-1 then begin
      SetFocus;
      SelStart:=Result;
      SelLength:=Length(aText);
    end;
  end;
end;

function DBRichEditFindText(RichEdit:TDBRichEdit; aText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext,aMessage:boolean):integer;
var B:TBookMark;
begin
  Result:=-1;
  if Assigned(RichEdit) and Assigned(RichEdit.Field) then
   with RichEdit.DataSource.DataSet do begin
    b:=nil;
    if (ScopeFind=sfFromFirst) and (Not aNext) and (not BOF) then begin
      B:=GetBookMark;
      First;
    end;
    Result:=RichEditFindText(RichEdit,aText,SearchTypes,ScopeFind,FromCursor,aNext);
    if (Result=-1) and (ScopeFind in [sfFromFirst,sfFromCurrent]) then begin
      if b=nil then B:=GetBookMark;
      while (Not EOF) and (Result=-1) do begin
        Next;
        Result:=RichEditFindText(RichEdit,aText,SearchTypes,ScopeFind,FromCursor,aNext);
      end;
    end;
    if (Result=-1) then begin
      if b<>nil then GotoBookMarkWOExcept(RichEdit.DataSource.DataSet,B);
      if aMessage then EtvApp.ShowMessage(Format(sSearchTextNotFound,[aText]));
    end;
    if b<>nil then FreeBookMark(B);
  end;
end;

function DBRichEditReplaceText(RichEdit:TDBRichEdit; aText,aNewText:string;
  SearchTypes:TSearchTypes; ScopeFind:TScopeFind; FromCursor,aNext,aMessage,
  aPrompt:boolean):integer;
var iFind:integer;
begin
  Result:=mrCancel;
  if Assigned(RichEdit) and Assigned(RichEdit.Field) and (RichEdit.Field.CanModify)then begin
    iFind:=DBRichEditFindText(RichEdit,aText,SearchTypes,ScopeFind,
       FromCursor,aNext,aMessage);
    if iFind<>-1 then begin
      if not (RichEdit.Field.DataSet.State in [dsInsert,dsEdit]) then
        if RichEdit is TEtvDBRichEdit then TEtvDBRichEdit(RichEdit).BeginEditing
        else begin
          RichEdit.Field.DataSet.Edit;
          RichEdit.SelStart:=Result;
          RichEdit.SelLength:=Length(aText);
        end;
      if aPrompt then begin
        if Not Assigned(DialReplace) then DialReplace:=TDialReplace.Create(nil);
        Result:=DialReplace.ShowModal;
      end else Result:=mrYes;
      if Result in [mrYes,mrAll] then RichEdit.SetSelTextBuf(PChar(aNewText));
    end;
  end;
end;

constructor TRichEditSearch.Create(AOwner: TComponent);
begin
  inherited;
  LabelFind.Caption:=sSearchLabelFind;
  LabelReplace.Caption:=sSearchLabelReplace;
  GroupBoxOptions.Caption:=sSearchOptions;
  BtnFind.Caption:=SFindBtnCaption;
  BtnCancel.Caption:=SCancelCaption;
  BtnReplace.Caption:=sSearchReplaceCaption;
  BtnReplaceAll.Caption:=sSearchReplaceAllCaption;
  CheckBoxCase.Caption:=SCaseSensitive;
  CheckBoxWhole.Caption:=sSearchWholeWord;
  CheckBoxPrompt.Caption:=sSearchPromtReplace;
  GroupBoxScope.Caption:=sSearchScope;
  RadioButtonGlobal.Caption:=sSearchGlobal;
  RadioButtonSelected.Caption:=sSearchSelected;
  GroupBoxOrigin.Caption:=sSearchOrigin;
  RadioButtonFromCursor.Caption:=sSearchFromCursor;
  RadioButtonEntire.Caption:=sSearchEntire;
end;

procedure TRichEditSearch.Execute(aReplace:boolean; RichEdit:TDBRichEdit);
var i:integer;
    lRecordName:string;
    PropInfo: PPropInfo;
    lSearchGlobal:boolean;
begin
  Caption:=sSearchSearchCaption;
  LabelReplace.visible:=aReplace;
  ComboBoxReplace.visible:=aReplace;
  BtnReplace.Visible:=aReplace;
  BtnReplaceAll.Visible:=aReplace;
  CheckBoxPrompt.visible:=aReplace;
  if aReplace then begin
    Caption:=Caption+' \ '+sSearchReplaceCaption;
    BtnCancel.left:=BtnReplaceAll.left+BtnReplaceAll.Width+8
  end else BtnCancel.left:=BtnFind.left+BtnFind.Width+8;

  lSearchGlobal:=true;
  PropInfo := GetPropInfo(RichEdit.ClassInfo,'SearchGlobal');
  if (PropInfo<>nil) then lSearchGlobal:=Boolean(GetOrdProp(RichEdit,PropInfo));
  RadioButtonGlobal.Enabled:=lSearchGlobal;
  RadioButtonFromCurrent.Enabled:=lSearchGlobal;
  RadioButtonSelected.Enabled:=RichEdit.SelLength>0;
  if ((not RadioButtonSelected.Enabled) and RadioButtonSelected.Checked) or
     ((not lSearchGlobal) and
      (RadioButtonGlobal.Checked or RadioButtonFromCurrent.Checked)) then
    RadioButtonOnlyCurrent.Checked:=true;

  lRecordName:=ObjectStrProp(RichEdit,'RecordName');
  if lRecordName='' then begin
    RadioButtonFromCurrent.Caption:=sSearchFrom+' '+sSearchCurrentRecordName;
    RadioButtonOnlyCurrent.Caption:=sSearchOnly+' '+sSearchCurrentRecordName;
  end else begin
    RadioButtonFromCurrent.Caption:=sSearchFrom+' '+lRecordName;
    RadioButtonOnlyCurrent.Caption:=sSearchOnly+' '+lRecordName;
  end;
  ActiveControl:=ComboBoxFind;
  i:=ShowModal;
  if (ComboBoxFind.Text<>'') and (i in [mrOk,mrYes,mrAll]) then
    case SearchType of
      stSearch: DBRichEditFindText(RichEdit,ComboBoxFind.Text,
        SearchTypes,ScopeFind,FromCursor,false,true);
      stReplace:
        DBRichEditReplaceText(RichEdit,ComboBoxFind.Text,
          ComboBoxReplace.Text,SearchTypes,ScopeFind,FromCursor,false,true,Prompt);
      stReplaceAll: begin
        i:=DBRichEditReplaceText(RichEdit,ComboBoxFind.Text,
          ComboBoxReplace.Text,SearchTypes,ScopeFind,FromCursor,false,true,Prompt);
        if i=mrAll then Prompt:=false;
        while i<>mrCancel do begin
          i:=DBRichEditReplaceText(RichEdit,ComboBoxFind.Text,
            ComboBoxReplace.Text,SearchTypes,ScopeFind,true,true,false,Prompt);
          if i=mrAll then Prompt:=false;
        end;
      end;
    end;
end;

procedure TRichEditSearch.SearchAgain(RichEdit:TDBRichEdit);
var i:integer;
    lMessage:boolean;
begin
  if (ComboBoxFind.Text<>'') then
    case SearchType of
      stSearch: DBRichEditFindText(RichEdit,ComboBoxFind.Text,
        SearchTypes,ScopeFind,true,true,true);
      stReplace: DBRichEditReplaceText(RichEdit,ComboBoxFind.Text,
        ComboBoxReplace.Text,SearchTypes,ScopeFind,true,true,true,Prompt);
      stReplaceAll: begin
        lMessage:=true;
        repeat
          i:=DBRichEditReplaceText(RichEdit,ComboBoxFind.Text,
            ComboBoxReplace.Text,SearchTypes,ScopeFind,true,true,lMessage,Prompt);
          if i=mrAll then Prompt:=false;
          lMessage:=false;
        until i=mrCancel;
      end;
    end;
end;

procedure TRichEditSearch.BtnFindClick(Sender: TObject);
var i:integer;
begin
  if ComboBoxFind.Text<>'' then begin
    i:=ComboBoxFind.Items.IndexOf(ComboBoxFind.Text);
    if i>=0 then ComboBoxFind.Items.Delete(i);
    ComboBoxFind.Items.Insert(0,ComboBoxFind.Text);
    if RadioButtonGlobal.Checked then ScopeFind:=sfFromFirst
    else if RadioButtonFromCurrent.Checked then ScopeFind:=sfFromCurrent
    else if RadioButtonOnlyCurrent.Checked then ScopeFind:=sfCurrent
    else ScopeFind:=sfSelected;
    SearchTypes:=[];
    if CheckBoxCase.Checked then SearchTypes:=[stMatchCase];
    if CheckBoxWhole.Checked then SearchTypes:=SearchTypes+[stWholeWord];
    FromCursor:=RadioButtonFromCursor.Checked;
    SearchType:=stSearch;
  end;
end;

procedure TRichEditSearch.BtnReplaceClick(Sender: TObject);
var i:integer;
begin
  if ComboBoxReplace.Text<>'' then begin
    BtnFindClick(Sender);
    i:=ComboBoxReplace.Items.IndexOf(ComboBoxReplace.Text);
    if i>=0 then ComboBoxReplace.Items.Delete(i);
    ComboBoxReplace.Items.Insert(0,ComboBoxReplace.Text);
    Prompt:=CheckBoxPrompt.Checked;
    SearchType:=stReplace;
  end;
end;

procedure TRichEditSearch.BtnReplaceAllClick(Sender: TObject);
begin
  if ComboBoxReplace.Text<>'' then begin
    BtnReplaceClick(Sender);
    SearchType:=stReplaceAll;
  end;
end;

procedure TRichEditSearch.RadioButtonSelectedClick(Sender: TObject);
begin
  BtnReplaceAll.Enabled:=not RadioButtonSelected.Checked;
end;

{TPopupMenuEtvDBRichEdit}
constructor TPopupMenuEtvDBRichEdit.Create(AOwner: TComponent);
begin
  inherited;
  InsertItem(0,SPopupFont,ChangeFont,0);
  InsertItem(1,SPopupBaseFont,SetBaseFont,ShortCutBaseFont);
  InsertItem(2,SPopupParagraph,ChangeParagraph,0);
  InsertItem(3,'-',nil,0);
  InsertItem(4,SPopupSearchReplace,SearchReplace,ShortCutSearch);
  InsertItem(5,SPopupSearchReplaceAgain,SearchReplaceAgain,ShortCutSearchAgain);
  InsertItem(6,'-',nil,0);
  InsertItem(7,SPopupPrint,Print,0);
  InsertItem(8,'-',nil,0);
  fRichEditLineCount:=9;
end;

procedure TPopupMenuEtvDBRichEdit.ProcOnPopup(Sender: TObject; LineAdd:smallint);
begin
  inherited ProcOnPopup(Sender,LineAdd+fRichEditLineCount);
  if Assigned(fDataSet) and (PopupComponent is TDBRichEdit) then
   with TDBRichEdit(PopupComponent) do begin
    if Assigned(Field) then begin
      if Field.CanModify then begin
        Items[LineAdd].Enabled:=(fDataSet.State in [dsInsert,dsEdit])
          or (PopupComponent is TEtvDBRichEdit);
        Items[LineAdd+1].Enabled:=Items[LineAdd].Enabled;
        Items[LineAdd+2].Enabled:=Items[LineAdd].Enabled;
      end;
      Items[LineAdd+4].Enabled:=true;
      if Assigned(RichEditSearch) and
         (RichEditSearch.ComboBoxFind.Text<>'') then
        Items[LineAdd+5].Enabled:=true;
      Items[LineAdd+7].Enabled:=true;
    end;
  end;
end;

procedure TPopupMenuEtvDBRichEdit.ChangeFont(Sender: TObject);
var FontDialog:TFontDialog;
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) and
     ((fDataSet.State in [dsEdit,dsInsert]) or
      (PopupComponent is TEtvDBRichEdit)) then begin
    FontDialog:=TFontDialog.Create(nil);
    try
      FontDialog.Font.Assign(TDBRichEdit(PopupComponent).SelAttributes);
      if FontDialog.Execute then begin
        if not (fDataSet.State in [dsEdit,dsInsert]) then
          TEtvDBRichEdit(PopupComponent).BeginEditing;
        TDBRichEdit(PopupComponent).SelAttributes.Assign(FontDialog.Font);
      end;
    finally
      FontDialog.Free;
    end;
  end;
end;

procedure TPopupMenuEtvDBRichEdit.SetBaseFont(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) and
     ((fDataSet.State in [dsEdit,dsInsert]) or
      (PopupComponent is TEtvDBRichEdit)) then begin
    if not (fDataSet.State in [dsEdit,dsInsert]) then
      TEtvDBRichEdit(PopupComponent).BeginEditing;
    TDBRichEdit(PopupComponent).SelAttributes.Assign(TDBRichEdit(PopupComponent).Font);
  end;
end;

procedure TPopupMenuEtvDBRichEdit.ChangeParagraph(Sender: TObject);
var ParaDialog:TDialParagraph;
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) and
     ((fDataSet.State in [dsEdit,dsInsert]) or
      (PopupComponent is TEtvDBRichEdit)) then begin
    ParaDialog:=TDialParagraph.Create(nil);
    try
      ParaDialog.Execute(TCustomRichEdit(PopupComponent));
    finally
      ParaDialog.Free;
    end;
  end;
end;

procedure TPopupMenuEtvDBRichEdit.SearchReplace(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) then begin
    if Not Assigned(RichEditSearch) then
      RichEditSearch:=TRichEditSearch.Create(nil);
    if fDataSet.CanModify then
      RichEditSearch.Execute(true,TDBRichEdit(PopupComponent))
    else RichEditSearch.Execute(false,TDBRichEdit(PopupComponent));
  end;
end;

procedure TPopupMenuEtvDBRichEdit.SearchReplaceAgain(Sender: TObject);
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) and Assigned(RichEditSearch) then
    RichEditSearch.SearchAgain(TDBRichEdit(PopupComponent))
end;

procedure TPopupMenuEtvDBRichEdit.Print(Sender: TObject);
var F:TField;
begin
  if Assigned(PopupComponent) and (PopupComponent is TDBRichEdit) and
     Assigned(fDataSet) then
    with TDBRichEdit(PopupComponent) do begin
      F:=fDataSet.FindField('Name');
      if Assigned(F) then Print(F.AsString) else Print('');
    end;
end;

var fPopupMenuEtvDBRichEdit:TPopupMenu;
function PopupMenuEtvDBRichEdit:TPopupMenu;
begin
  if Not Assigned(fPopupMenuEtvDBRichEdit) then begin
    fPopupMenuEtvDBRichEdit:=TPopupMenuEtvDBRichEdit.Create(nil);
  end;
  Result:=fPopupMenuEtvDBRichEdit;
end;

initialization
finalization
  if Assigned(RichEditSearch) then RichEditSearch.Free;
  if Assigned(DialReplace) then DialReplace.Free;
  if Assigned(fPopupMenuEtvDBRichEdit) then fPopupMenuEtvDBRichEdit.Free;
end.
