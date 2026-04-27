// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get home_appBarTitle => 'Управление Инвентарем';

  @override
  String get home_menuUnderDevelopment => 'Меню (в разработке)';

  @override
  String get home_searchTitle => 'Поиск предмета';

  @override
  String get home_scanButton => 'Скан';

  @override
  String get home_searchFieldLabel => 'Введите название или номер';

  @override
  String get home_searchButton => 'Найти';

  @override
  String get home_barcodeDialogTitle => 'Сканирование штрихкода';

  @override
  String get home_barcodeDialogHint =>
      'Наведите камеру на штрихкод или введите его вручную ниже';

  @override
  String get home_barcodeFieldLabel => 'Штрихкод или инв. номер';

  @override
  String get home_scannerUnavailableMessage =>
      'Камера недоступна. Используйте ручной ввод.';

  @override
  String get home_scannerPermissionDeniedMessage =>
      'Нет доступа к камере. Используйте ручной ввод.';

  @override
  String get home_scannerReadButton => 'Сканировать камерой';

  @override
  String get home_scannerScanningLabel => 'Сканирование...';

  @override
  String get home_saveButton => 'Сохранить';

  @override
  String get home_cancelButton => 'Отмена';

  @override
  String get home_searchButtonDialog => 'Поиск';

  @override
  String get home_notFoundDialogTitle => 'Предмет не найден';

  @override
  String home_notFoundDialogContent(String query) {
    return 'Предмет с номером \"$query\" не найден в базе данных.';
  }

  @override
  String get home_createButton => 'Создать';

  @override
  String get home_createInventoryDialogTitle => 'Создать новый предмет';

  @override
  String get home_createInventoryDialogContent =>
      'Перейти в раздел \"Инвентарь\" для создания нового предмета?';

  @override
  String home_creatingItemMessage(String barcode) {
    return 'Создание предмета со штрихкодом: $barcode';
  }

  @override
  String get home_itemDetailsTitle => 'Детали предмета';

  @override
  String get home_nameLabel => 'Название:';

  @override
  String get home_barcodeLabel => 'Штрихкод:';

  @override
  String get home_inventoryNumberLabel => 'Инв. номер:';

  @override
  String get home_quantityLabel => 'Количество:';

  @override
  String get home_descriptionLabel => 'Описание:';

  @override
  String get home_registrationDateLabel => 'Дата регистрации:';

  @override
  String get home_notSpecified => 'Не указано';

  @override
  String get home_closeDialogButton => 'Закрыть';

  @override
  String get home_editButton => 'Изменить';

  @override
  String get home_editUnderDevelopment => 'Редактирование (в разработке)';

  @override
  String home_foundItemsTitle(int count) {
    return 'Найдено предметов: $count';
  }

  @override
  String get home_quantityPrefix => 'Кол-во: ';

  @override
  String get home_sectionsTitle => 'Разделы';

  @override
  String get home_inventoryButton => 'Инвентарь';

  @override
  String get home_employeesButton => 'Сотрудники';

  @override
  String get home_roomsButton => 'Помещения';

  @override
  String get home_inventoryUnderDevelopment =>
      'Раздел \"Инвентарь\" (в разработке)';

  @override
  String get home_employeesUnderDevelopment =>
      'Раздел \"Сотрудники\" (в разработке)';

  @override
  String get home_roomsUnderDevelopment =>
      'Раздел \"Помещения\" (в разработке)';

  @override
  String get home_errorPrefix => 'Ошибка: ';

  @override
  String get home_categoriesButton => 'Категории';

  @override
  String get home_positionsButton => 'Должности';

  @override
  String get invList_appBarTitle => 'Список инвентаря';

  @override
  String get invList_emptyStateMessage => 'Список инвентаря пуст';

  @override
  String get invList_emptySearchMessage =>
      'По данному запросу ничего не найдено';

  @override
  String get invList_noBarcode => 'Нет кода';

  @override
  String get invList_noInventoryNumber => 'Б/Н';

  @override
  String get invList_inventoryNumberPrefix => 'Инв. №: ';

  @override
  String get invList_itemAddedMessage => 'Предмет добавлен';

  @override
  String get invList_filterByCategoryLabel => 'Фильтр по категории';

  @override
  String get invList_showAllCategories => 'Все категории';

  @override
  String get invList_searchHint =>
      'Поиск по штрихкоду, инвентарному номеру или названию';

  @override
  String get invList_notSpecified => 'Не указано';

  @override
  String get invList_notSpecifiedMale => 'Не указан';

  @override
  String get invList_notSpecifiedFemale => 'Не указана';

  @override
  String get invList_closeButton => 'Закрыть';

  @override
  String get invList_noItemsFilterMessage =>
      'Нет предметов, удовлетворяющих фильтуру';

  @override
  String get invList_errorMessagePrefix => 'Ошибка: ';

  @override
  String get invList_detailNameLabel => 'Название:';

  @override
  String get invList_detailBarcodeLabel => 'Штрихкод:';

  @override
  String get invList_detailInventoryNumberLabel => 'Инвентарный №:';

  @override
  String get invList_detailQuantityLabel => 'Количество:';

  @override
  String get invList_detailRoomLabel => 'Помещение:';

  @override
  String get invList_detailResponsibleLabel => 'Ответственный:';

  @override
  String get invList_detailCategoryLabel => 'Категория:';

  @override
  String get invList_detailDateLabel => 'Дата постановки:';

  @override
  String get invList_detailDescriptionLabel => 'Описание:';

  @override
  String get invForm_appBarCreateTitle => 'Создание предмета';

  @override
  String get invForm_appBarEditTitle => 'Редактирование предмета';

  @override
  String get invForm_barcodeLabel => 'Штрихкод';

  @override
  String get invForm_noBarcode => 'Нет кода';

  @override
  String get invForm_scanOrInputTooltip => 'Сканировать/Ввести';

  @override
  String get invForm_nameFieldLabel => 'Название *';

  @override
  String get invForm_nameRequiredError => 'Введите название';

  @override
  String get invForm_minLength3Error => 'Минимум 3 символа';

  @override
  String get invForm_maxLength50Error => 'Максимум 50 символов';

  @override
  String get invForm_inventoryNumberFieldLabel => 'Инвентарный номер';

  @override
  String get invForm_quantityFieldLabel => 'Количество';

  @override
  String get invForm_quantityRequiredError => 'Введите количество';

  @override
  String get invForm_quantityRangeError => 'От 1 до 999';

  @override
  String get invForm_responsibleLabel => 'Ответственный';

  @override
  String get invForm_categoryLabel => 'Категория';

  @override
  String get invForm_roomLabel => 'Помещение';

  @override
  String get invForm_notSelected => 'Не выбрано';

  @override
  String get invForm_descriptionFieldLabel => 'Описание';

  @override
  String get invForm_maxLength500Error => 'Максимум 500 символов';

  @override
  String get invForm_dateAddedLabel => 'Дата постановки на учёт *';

  @override
  String get invForm_saveButton => 'Сохранить';

  @override
  String get invForm_cancelButton => 'Отмена';

  @override
  String get invForm_barcodeDialogTitle => 'Ввод штрихкода';

  @override
  String get invForm_barcodeFieldInDialog => 'Штрихкод';

  @override
  String get invForm_cameraScanText => 'Или отсканируйте камерой:';

  @override
  String get invForm_resetScannerButton => 'Сбросить сканер';

  @override
  String get invForm_scannedSuccessMessage => 'Отсканировано!';

  @override
  String get categories_emptyList => 'Список категорий пуст';

  @override
  String get categories_newTitle => 'Новая категория';

  @override
  String get categories_editTitle => 'Редактировать категорию';

  @override
  String get categories_nameLabel => 'Название';

  @override
  String get categories_descriptionLabel => 'Описание';

  @override
  String get positions_emptyList => 'Список должностей пуст';

  @override
  String get positions_newTitle => 'Новая должность';

  @override
  String get positions_editTitle => 'Редактировать должность';

  @override
  String get positions_nameLabel => 'Название';

  @override
  String get rooms_emptyList => 'Список помещений пуст';

  @override
  String get rooms_newTitle => 'Новое помещение';

  @override
  String get rooms_editTitle => 'Редактировать помещение';

  @override
  String get rooms_nameLabel => 'Название';

  @override
  String get rooms_descriptionLabel => 'Описание';

  @override
  String common_error(String message) {
    return 'Ошибка: $message';
  }

  @override
  String get common_cancel => 'Отмена';

  @override
  String get common_delete => 'Удалить';

  @override
  String get common_save => 'Сохранить';

  @override
  String get common_create => 'Создать';

  @override
  String get common_all => 'Все';

  @override
  String get common_notSelected => 'Не выбрано';

  @override
  String get common_notDefined => 'Не определено';

  @override
  String get common_inventoryNumberPrefix => 'Инв. №: ';

  @override
  String common_deleteConfirmTitle(String itemType) {
    return 'Удалить $itemType?';
  }

  @override
  String common_deleteConfirmContent(String name) {
    return 'Вы уверены, что хотите удалить \"$name\"?';
  }

  @override
  String get employees_searchHint => 'Поиск сотрудника...';

  @override
  String get employees_notFound => 'Сотрудники не найдены';

  @override
  String get employees_unknownPosition => 'Неизвестная должность';

  @override
  String get employees_createTitle => 'Создание сотрудника';

  @override
  String get employees_editTitle => 'Редактирование сотрудника';

  @override
  String get employees_created => 'Сотрудник создан';

  @override
  String get employees_updated => 'Данные обновлены';

  @override
  String get employees_nameLabel => 'ФИО';

  @override
  String get employees_positionLabel => 'Должность';

  @override
  String get employees_roomLabel => 'Помещение';

  @override
  String get employees_assignedInventory => 'Прикрепленный инвентарь';

  @override
  String get employees_noInventory => 'За сотрудником не закреплен инвентарь';

  @override
  String get employees_selectPosition => 'Выберите должность';

  @override
  String get employees_minLength3 => 'Минимум 3 символа';

  @override
  String get employees_maxLength50 => 'Максимум 50 символов';

  @override
  String get rooms_inventoryTab => 'Инвентарь';

  @override
  String get rooms_employeesTab => 'Сотрудники';

  @override
  String get rooms_noInventory => 'В этом помещении нет инвентаря';

  @override
  String get rooms_noEmployees => 'В этом помещении нет сотрудников';

  @override
  String get error_database => 'Ошибка доступа к базе данных';

  @override
  String get error_notFound => 'Ресурс не найден';

  @override
  String get error_validation => 'Ошибка валидации данных';

  @override
  String get error_unknown => 'Произошла неизвестная ошибка';
}
