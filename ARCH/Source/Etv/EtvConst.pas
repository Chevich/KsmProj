Unit EtvConst;

interface
uses Windows, Classes, Graphics;

const
  DefaultHeadColor=TCOLOR($A6CAF0); {=10930928=clCream - use as lookup datalist head color}
  clCream=DefaultHeadColor;
  ShortCutHome=16420; {Ctrl+Home}
  ShortCutPrior=VK_PRIOR;
  ShortCutNext=VK_NEXT;
  ShortCutEnd=16419; {Ctrl+End}
  ShortCutIns=16491; {Ctrl+Vk_Add(Gray_Plus)}
  ShortCutDel=16493; {Ctrl+Vk_Subtract(Gray_Minus)}
  ShortCutPost=16470; {Ctrl+V}
  ShortCutCancel=0;
  ShortCutRefresh=vk_F5;
  ShortCutClone=scCtrl+vk_F12;
  ShortCutSearch=16454; {Ctrl+F}
  ShortCutSearchAgain=16460; {Ctrl+L}
  ShortCutBaseFont=16450; {Ctrl+B}

resourcestring
  {For programmer}
  SNeedQueryClass='Необходимо определить "OtherQueryClass" из юнита EtvOther'+#13+
                  'или включить опцию "BDE_IS_USED" в файле Etv.Inc'+#13+
                  'для генерации Query';
  SPropSQLAbsent='Свойство "SQL" отсутствует в датасете';

  {Common}
  SCancelCaption='Отмена';
  SCaseSensitive='Учитывать регистр';
  SFindBtnCaption='Найти';
  SPrinterSetup='Установки принтера';

  {EtvTable}
  SError='Ошибка ';
  SAutoCorrectInit='Этап инициализации';
  SAutoCorrectFieldProcess='Этап обработки поля ';
  SAutoCorrectFieldLengthProcess='Расчет длины для поля ';
  SAutoCorrectFieldOtherProcess='Расчет DisplayWidth и .. для поля ';
  SAutoCorrectSetTableParams='Установка параметров таблицы';
  SLabelPump='Перекачка меток';
  SLabelPumpTableMissing='Отсутствует имя таблицы';
  SLabelPumpAidTables='Этап организации вспомомательных таблиц';
  SLabelPumpTableProcess='Этап обработки выбранной таблицы';
  SLabelPumpFieldProcess='Этап обработки поля';
  SLabelPumpFieldCheckLength='Проверка длины для поля';
  SLabelPumpFieldLabel='Присвоение DisplayLabels для поля';
  SLabelPumpTableNotFound='Таблица %s не найдена';
  SLabelPumpView='Перекачка меток для View';
  SLabelPumpViewFieldsProcess='Этап обработки полей выбранной таблицы';
  SSetLengthFieldsByDataError='Ошибка при расчете длин полей';

  {EtvGrid}
  SDialVisibleFields='Видимость полей';
  SVisibleFields='Видимые поля';
  SInvisibleFields='Невидимые поля';
  SGridPrintError='Ошибка при печати таблицы';
  SGridPrintRecord='Печать записи';
  SGridPrintRecordError='Ошибка при печати записи';
  SGridSetLengthFieldsByDataScan='Подбор длин полей';

  {EtvLook}
  SInvalidValue='Неверное значение';
  SInvalidInformation='Некорректная информация';

  {EtvTabSheet}
  SGridOrRecord='Таблица - Одна запись';

  {EtvPopup}
  sCloneRecord='Клонировать запись';
  sPopupFont='Шрифт';
  sPopupBaseFont='Основной шрифт';
  sPopupParagraph='Абзац';
  sPopupSearchReplace='Поиск / замена';
  sPopupSearchReplaceAgain='Поиск / замена далее';
  sPopupCopy='Копировать';
  sPopupPaste='Вставить';
  sPopupSelectAll='Выделить все';
  sPopupPrint='Печать';
  SPopupClear='Очистить';
  SPopupClearField='Очистить поле';
{sPopupPicFilter='Графические файлы|*.bmp;*.emf;*.ico|Все файлы|*.*';}
  SLoadFromFile='Загрузить из файла';
  SSaveToFile='Записать в файл';
  SPopupStretch='Масштаб';
  SPopupSearch='Поиск по';
  SPopupOrder='Сортировка по';
  SPopupSearchOrder='Поиск и сортировка по';

  {fBase}
  SOneRecordTabs='Карта';
  SGridTabs='Таблица';
  SListOfFilter='Список фильтров';
  SCurrentFilter='Текущий фильтр: ';
  SfBaseCaption='Справочник';
  SButtonReturn='Возврат';
  SButtonReturnHint='Возврат значения';
  SSortingComboHint='Сортировка';
  SFindKeyDialogHint='Поиск по полям сортировки';
  SButtonFilterPanelHint='Фильтры';
  SButtonFilterEditHint='Редактирование фильтров';
  SComboFilterListHint='Список фильтров';
  SFilterDlgBtnExternalSetHint='Установка основного фильтра';
  SItemRefresh='Обновление всей информации';

  SNavFirst='Первая запись';
  SNavPrior='Предыдущая запись';
  SNavNext='Следующая запись';
  SNavLast='Последняя запись';
  SNavInsert='Добавить запись';
  SNavDelete='Удалить запись';
  SNavEdit='Редактировать запись';
  SNavPost='Зафиксировать';
  SNavCancel='Отмена';
  SNavRefresh='Пересчитать';

  {EtvFilt}
  S_Or='ИЛИ';
  S_And='И';
  S_Not='НЕ';
  S_Number='№';
  S_Null='Пусто';
  S_Like='~';
  SFilterInvalid='Выражение фильтра некорректно';
  SFilterNumber='Фильтр #';
  SChangeFilterSetAsError='Изменение допустимо только при отключенном фильтре';
  SFilterLoadError='Ошибка при открытии данных фильтра';

  {Filter - dialog}
  SFilterDlgCaption='Определение фильтров';
  SFilterDlgBtnPredHint='Предыдущий фильтр';
  SFilterDlgBtnNextHint='Следующий фильтр';
  SFilterDlgBtnAddHint='Добавить фильтр';
  SFilterDlgBtnDeleteHint='Удалить фильтр';
  SFilterDlgBtnRestoreHint='Отмена текущих изменений';
  SFilterDlgFilterNameHint='Название фильтра';

  SFilterDlgBtnAddCondCaption='Добавить';
  SFilterDlgBtnAddCondHint='Добавить условие (Ctrl+Серый_плюс)';
  SFilterDlgBtnDeleteCondCaption='Удалить';
  SFilterDlgBtnDeleteCondHint='Удалить условие (Ctrl+серый_минус)';
  SFilterDlgAutoTotalCaption='"И" для всех условий';

  SFilterDlgBtnSetCaption='Установить выборку';
  SFilterDlgBtnSetHint='Установка фильтра (выборки)';
  SFilterDlgBtnNoneCaption='Отключить';
  SFilterDlgBtnNoneHint='Отключение установленного фильтра';
  SFilterDlgBtnCancelHint='Отмена введенных изменений';
  SFilterDlgTotalHint=' Описание связей между условиями. Например,'+#10+
                      ' №1 и (№2 или №4), где №1 - первое условие';
  SFilterDlgSubTotalHint=' Символ '' | '' - разделитель групп условий';
  SFilterDlgAllOrAnyCaption='Для всех';
  SFilterDlgAllOrAnyHint='Условие должно выполниться для всех записей';

  {KeyDld}
  SKeyDlgSortingMissing='Поля сортировки неопределены! Поиск невозможен';
  SKeyDlgRecordNotFound='Такая запись не найдена!';
  SKeyDlgGotoNearest='Найти ближайшее?';
  SKeyDlgFieldsEmpty='Ни одного значения не определено! Поиск невозможен!';
  SKeyDlgCaption='Поиск по полям сортировки';
  SKeyDlgNoPartialKey='Полное совпадение';

  {EtvPrint}
  SPrinterError='Ошибка при подключении к принтеру';
  SPrinterOpenDocError='Ошибка при открытии документа для принтера';
  SPrinterOpenFileError='Ошибка при открытии файла документа';
  SPrinterCloseDocError='Ошибка при закрытии документа';
  SPrinterProcessDocError='Ошибка при выводе документа на принтер';
  SPrinterProcessFileError='Ошибка при выводе документа в файл';
  SPrinterNothingToPrintError='Печатать нечего';

  {EtvDataBase}
  SDBPasswordIncorrect='Пароль неправилен!';
  SProgramDown='Программа завершается!';
  SCancelDialPassword='Отмена ввода пароля';

  {EtvPas}
  SCantRun='Hевозможно запустить';

  {EtvMisc}
  SCloneRecordQuestion='Клонировать?';

  {DiPara}
  sParagraphName='Абзац';
  sParagraphFirstIndent='Первая строка';
  sParagraphLeftIndent='Отступ слева';
  sParagraphRightIndent='Отступ справа';
  sParagraphLeftAlignmentHint='По левому краю';
  sParagraphCenterAlignmentHint='По центру';
  sParagraphRightAlignmentHint='По правому краю';
  sParagraphBulletHint='Список';

  {DiSearch}
  sSearchSearchCaption='Поиск';
  sSearchReplaceCaption='Замена';
  sSearchReplaceAllCaption='Заменить все';
  sSearchLabelFind='Найти';
  sSearchLabelReplace='Заменить на';
  sSearchOptions='Параметры';
  sSearchWholeWord='Только слово целиком';
  sSearchPromtReplace='Запрос на замену';
  sSearchScope='Диапазон';
  sSearchGlobal='Все';
  sSearchSelected='Выбранный текст';
  sSearchFrom='Начиная с';
  sSearchOnly='Только для';
  sSearchCurrentRecordName='текущей записи';
  sSearchOrigin='Начать';
  sSearchFromCursor='С позиции курсора';
  sSearchEntire='С начала диапазона';
  sSearchTextNotFound='Строка ''%s'' не найдена';

  {DiPrint}
  sDiPrintCaption='Установки печати';
  sDiPrintCommonTabs='Общие';
  sDiPrintTitle='Заголовок';
  sDiPrintCopies='Число копий';
  sDiPrintMode='Режим печати';
  sDiPrintTextMode='Текстовый';
  sDiPrintGraphicsMode='Графический';
  sDiPrintFileMode='Файл';
  sDiPrintPrintRange='Страницы';
  sDiPrintExample='Например: 1,3,5-12';
  sDiPrintAll='Все';
  sDiPrintPages='Номера';
  sDiPrintPrinter='Принтер';
  sDiPrintFilenameHint='Имя файла';
  sDiPrintPageTabs='Страница';
  sDiPrintMargins='Поля';
  sDiPrintTop='Верхнее';
  sDiPrintLeft='Левое';
  sDiPrintRight='Правое';
  sDiPrintBottom='Нижнее';
  sDiPrintPaperSize='Размер бумаги';
  sDiPrintPaperWidth='Ширина';
  sDiPrintPaperHeight='Высота';
  sDiPrintOrientation='Ориентация';
  sDiPrintPortrait='Книжная';
  sDiPrintLandscape='Альбомная';
  sDiPrintWOPages='Без страниц (режим текстовый и файл)';
  sDiPrintNumberingTabS='Нумерация';
  sDiPrintNumberingPosition='Положение';
  sDiPrintNumberFirst='Номер первой страницы';
  sDiPrintNumberFormat='Формат';
  sDiPrintNumberFirstPage='Номер на первой странице';
  sDiPrintNumberTemplate='- # -';
  sDiPrintNumberFont='Шрифт (графический режим)';
  sDiPrintTextTabS='Параметры текста';
  sDiPrintGroupTextMode='Текстовый режим';
  sDiPrintGroupGraphicsMode='Графический режим';
  sDiPrintInterval='Межстрочный интервал';
  sDiPrintFontDefault='По умолчанию';
  sDiPrintFontNormal='Пайка';
  sDiPrintFontElite='Элита';
  sDiPrintFontCond='Сжатый';
  sDiPrintFontCondElite='Сжатая элита';
  sDiPrintFontTitle='Шрифт заголовка';
  sDiPrintFontText='Шрифт текста';

  {DiAdv}
  sDetail='Подробности';

implementation

end.


