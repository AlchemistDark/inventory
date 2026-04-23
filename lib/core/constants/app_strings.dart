// String constants for the home screen.

class AppStrings {
  AppStrings();

  static Home home = Home();
  static InventoryList inventoryList = InventoryList();
  static CreateInventory createInventory = CreateInventory();
}

class Home {
  Home();

  // App Bar
  final String appBarTitle = 'Управление Инвентарем';
  final String menuUnderDevelopment = 'Меню (в разработке)';

  // Search Section
  final String searchTitle = 'Поиск предмета';
  final String scanButton = 'Скан';
  final String searchFieldLabel = 'Введите название или номер';
  final String searchButton = 'Найти';

  // Barcode Dialog
  final String barcodeDialogTitle = 'Сканирование штрихкода';
  final String barcodeDialogHint =
      'Наведите камеру на штрихкод или введите его вручную ниже';
  final String barcodeFieldLabel = 'Штрихкод или инв. номер';
  final String scannerUnavailableMessage =
      'Камера недоступна. Используйте ручной ввод.';
  final String scannerPermissionDeniedMessage =
      'Нет доступа к камере. Используйте ручной ввод.';
  final String scannerReadButton = 'Сканировать камерой';
  final String scannerScanningLabel = 'Сканирование...';
  final String saveButton = 'Сохранить';
  final String cancelButton = 'Отмена';
  final String searchButtonDialog = 'Поиск';

  // Not Found Dialog
  final String notFoundDialogTitle = 'Предмет не найден';
  final String notFoundDialogContent =
      'Предмет с номером "%s" не найден в базе данных.';
  final String createButton = 'Создать';

  // Create Inventory Dialog
  final String createInventoryDialogTitle = 'Создать новый предмет';
  final String createInventoryDialogContent =
      'Перейти в раздел "Инвентарь" для создания нового предмета?';
  final String creatingItemMessage = 'Создание предмета со штрихкодом: %s';

  // Item Details Dialog
  final String itemDetailsTitle = 'Детали предмета';
  final String nameLabel = 'Название:';
  final String barcodeLabel = 'Штрихкод:';
  final String inventoryNumberLabel = 'Инв. номер:';
  final String quantityLabel = 'Количество:';
  final String descriptionLabel = 'Описание:';
  final String registrationDateLabel = 'Дата регистрации:';
  final String notSpecified = 'Не указано';
  final String closeDialogButton = 'Закрыть';
  final String editButton = 'Изменить';
  final String editUnderDevelopment = 'Редактирование (в разработке)';

  // Search Results
  final String foundItemsTitle = 'Найдено предметов: %d';
  final String quantityPrefix = 'Кол-во: ';

  // Navigation Section
  final String sectionsTitle = 'Разделы';
  final String inventoryButton = 'Инвентарь';
  final String employeesButton = 'Сотрудники';
  final String roomsButton = 'Помещения';
  final String inventoryUnderDevelopment =
      'Раздел "Инвентарь" (в разработке)';
  final String employeesUnderDevelopment =
      'Раздел "Сотрудники" (в разработке)';
  final String roomsUnderDevelopment =
      'Раздел "Помещения" (в разработке)';

  // Error Messages
  final String errorPrefix = 'Ошибка: ';
}

class InventoryList {
  InventoryList();

  final String appBarTitle = 'Список инвентаря';
  final String emptyStateMessage = 'Список инвентаря пуст';
  final String emptySearchMessage = 'По данному запросу ничего не найдено';
  final String noBarcode = 'Нет кода';
  final String noInventoryNumber = 'Б/Н';
  final String inventoryNumberPrefix = 'Инв. №: ';
  final String itemAddedMessage = 'Предмет добавлен';
  final String filterByCategoryLabel = 'Фильтр по категории';
  final String showAllCategories = 'Все категории';
  
  final String searchHint = 'Поиск по штрихкоду, инвентарному номеру или названию';
  final String notSpecified = 'Не указано';
  final String notSpecifiedMale = 'Не указан';
  final String notSpecifiedFemale = 'Не указана';
  final String closeButton = 'Закрыть';
  final String noItemsFilterMessage = 'Нет предметов, удовлетворяющих фильтру';
  final String errorMessagePrefix = 'Ошибка: ';
  
  final String detailNameLabel = 'Название:';
  final String detailBarcodeLabel = 'Штрихкод:';
  final String detailInventoryNumberLabel = 'Инвентарный №:';
  final String detailQuantityLabel = 'Количество:';
  final String detailRoomLabel = 'Помещение:';
  final String detailResponsibleLabel = 'Ответственный:';
  final String detailCategoryLabel = 'Категория:';
  final String detailDateLabel = 'Дата постановки:';
  final String detailDescriptionLabel = 'Описание:';
}

class CreateInventory {
  CreateInventory();

  final String appBarCreateTitle = 'Создание предмета';
  final String appBarEditTitle = 'Редактирование предмета';
  
  final String barcodeLabel = 'Штрихкод';
  final String noBarcode = 'Нет кода';
  final String scanOrInputTooltip = 'Сканировать/Ввести';

  final String nameFieldLabel = 'Название *';
  final String nameRequiredError = 'Введите название';
  final String minLength3Error = 'Минимум 3 символа';
  final String maxLength50Error = 'Максимум 50 символов';

  final String inventoryNumberFieldLabel = 'Инвентарный номер';
  final String quantityFieldLabel = 'Количество';
  final String quantityRequiredError = 'Введите количество';
  final String quantityRangeError = 'От 1 до 999';

  final String responsibleLabel = 'Ответственный';
  final String categoryLabel = 'Категория';
  final String roomLabel = 'Помещение';
  final String notSelected = 'Не выбрано';

  final String descriptionFieldLabel = 'Описание';
  final String maxLength500Error = 'Максимум 500 символов';

  final String dateAddedLabel = 'Дата постановки на учёт *';
  
  final String saveButton = 'Сохранить';
  final String cancelButton = 'Отмена';
  
  // Barcode Input Dialog
  final String barcodeDialogTitle = 'Ввод штрихкода';
  final String barcodeFieldInDialog = 'Штрихкод';
  final String cameraScanText = 'Или отсканируйте камерой:';
  final String resetScannerButton = 'Сбросить сканер';
  final String scannedSuccessMessage = 'Отсканировано!';
}
