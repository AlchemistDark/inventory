import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @home_appBarTitle.
  ///
  /// In ru, this message translates to:
  /// **'Управление Инвентарем'**
  String get home_appBarTitle;

  /// No description provided for @home_menuUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Меню (в разработке)'**
  String get home_menuUnderDevelopment;

  /// No description provided for @home_searchTitle.
  ///
  /// In ru, this message translates to:
  /// **'Поиск предмета'**
  String get home_searchTitle;

  /// No description provided for @home_scanButton.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать'**
  String get home_scanButton;

  /// No description provided for @home_searchFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Введите название или номер'**
  String get home_searchFieldLabel;

  /// No description provided for @home_searchButton.
  ///
  /// In ru, this message translates to:
  /// **'Найти'**
  String get home_searchButton;

  /// No description provided for @home_barcodeDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Сканирование штрихкода'**
  String get home_barcodeDialogTitle;

  /// No description provided for @home_barcodeDialogHint.
  ///
  /// In ru, this message translates to:
  /// **'Наведите камеру на штрихкод или введите его вручную ниже'**
  String get home_barcodeDialogHint;

  /// No description provided for @home_barcodeFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод или инв. номер'**
  String get home_barcodeFieldLabel;

  /// No description provided for @home_scannerUnavailableMessage.
  ///
  /// In ru, this message translates to:
  /// **'Камера недоступна. Используйте ручной ввод.'**
  String get home_scannerUnavailableMessage;

  /// No description provided for @home_scannerPermissionDeniedMessage.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступа к камере. Используйте ручной ввод.'**
  String get home_scannerPermissionDeniedMessage;

  /// No description provided for @home_scannerReadButton.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать камерой'**
  String get home_scannerReadButton;

  /// No description provided for @home_scannerScanningLabel.
  ///
  /// In ru, this message translates to:
  /// **'Сканирование...'**
  String get home_scannerScanningLabel;

  /// No description provided for @home_saveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get home_saveButton;

  /// No description provided for @home_cancelButton.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get home_cancelButton;

  /// No description provided for @home_searchButtonDialog.
  ///
  /// In ru, this message translates to:
  /// **'Поиск'**
  String get home_searchButtonDialog;

  /// No description provided for @home_notFoundDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Предмет не найден'**
  String get home_notFoundDialogTitle;

  /// No description provided for @home_notFoundDialogContent.
  ///
  /// In ru, this message translates to:
  /// **'Предмет с номером \"{query}\" не найден в базе данных.'**
  String home_notFoundDialogContent(String query);

  /// No description provided for @home_createButton.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get home_createButton;

  /// No description provided for @home_createInventoryDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создать новый предмет'**
  String get home_createInventoryDialogTitle;

  /// No description provided for @home_createInventoryDialogContent.
  ///
  /// In ru, this message translates to:
  /// **'Перейти в раздел \"Инвентарь\" для создания нового предмета?'**
  String get home_createInventoryDialogContent;

  /// No description provided for @home_creatingItemMessage.
  ///
  /// In ru, this message translates to:
  /// **'Создание предмета со штрихкодом: {barcode}'**
  String home_creatingItemMessage(String barcode);

  /// No description provided for @home_itemDetailsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Детали предмета'**
  String get home_itemDetailsTitle;

  /// No description provided for @home_nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название:'**
  String get home_nameLabel;

  /// No description provided for @home_barcodeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод:'**
  String get home_barcodeLabel;

  /// No description provided for @home_inventoryNumberLabel.
  ///
  /// In ru, this message translates to:
  /// **'Инв. номер:'**
  String get home_inventoryNumberLabel;

  /// No description provided for @home_quantityLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество:'**
  String get home_quantityLabel;

  /// No description provided for @home_descriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание:'**
  String get home_descriptionLabel;

  /// No description provided for @home_registrationDateLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата регистрации:'**
  String get home_registrationDateLabel;

  /// No description provided for @home_notSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Не указано'**
  String get home_notSpecified;

  /// No description provided for @home_closeDialogButton.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get home_closeDialogButton;

  /// No description provided for @home_editButton.
  ///
  /// In ru, this message translates to:
  /// **'Изменить'**
  String get home_editButton;

  /// No description provided for @home_editUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование (в разработке)'**
  String get home_editUnderDevelopment;

  /// No description provided for @home_foundItemsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Найдено предметов: {count}'**
  String home_foundItemsTitle(int count);

  /// No description provided for @home_quantityPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Кол-во: '**
  String get home_quantityPrefix;

  /// No description provided for @home_sectionsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Разделы'**
  String get home_sectionsTitle;

  /// No description provided for @home_inventoryButton.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарь'**
  String get home_inventoryButton;

  /// No description provided for @home_employeesButton.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get home_employeesButton;

  /// No description provided for @home_roomsButton.
  ///
  /// In ru, this message translates to:
  /// **'Помещения'**
  String get home_roomsButton;

  /// No description provided for @home_inventoryUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Раздел \"Инвентарь\" (в разработке)'**
  String get home_inventoryUnderDevelopment;

  /// No description provided for @home_employeesUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Раздел \"Сотрудники\" (в разработке)'**
  String get home_employeesUnderDevelopment;

  /// No description provided for @home_roomsUnderDevelopment.
  ///
  /// In ru, this message translates to:
  /// **'Раздел \"Помещения\" (в разработке)'**
  String get home_roomsUnderDevelopment;

  /// No description provided for @home_errorPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: '**
  String get home_errorPrefix;

  /// No description provided for @home_categoriesButton.
  ///
  /// In ru, this message translates to:
  /// **'Категории'**
  String get home_categoriesButton;

  /// No description provided for @home_positionsButton.
  ///
  /// In ru, this message translates to:
  /// **'Должности'**
  String get home_positionsButton;

  /// No description provided for @invList_appBarTitle.
  ///
  /// In ru, this message translates to:
  /// **'Список инвентаря'**
  String get invList_appBarTitle;

  /// No description provided for @invList_emptyStateMessage.
  ///
  /// In ru, this message translates to:
  /// **'Список инвентаря пуст'**
  String get invList_emptyStateMessage;

  /// No description provided for @invList_emptySearchMessage.
  ///
  /// In ru, this message translates to:
  /// **'По данному запросу ничего не найдено'**
  String get invList_emptySearchMessage;

  /// No description provided for @invList_noBarcode.
  ///
  /// In ru, this message translates to:
  /// **'Нет кода'**
  String get invList_noBarcode;

  /// No description provided for @invList_noInventoryNumber.
  ///
  /// In ru, this message translates to:
  /// **'Б/Н'**
  String get invList_noInventoryNumber;

  /// No description provided for @invList_inventoryNumberPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Инв. №: '**
  String get invList_inventoryNumberPrefix;

  /// No description provided for @invList_itemQuantity.
  ///
  /// In ru, this message translates to:
  /// **'({count}) '**
  String invList_itemQuantity(int count);

  /// No description provided for @invList_itemAddedMessage.
  ///
  /// In ru, this message translates to:
  /// **'Предмет добавлен'**
  String get invList_itemAddedMessage;

  /// No description provided for @invList_itemUpdatedMessage.
  ///
  /// In ru, this message translates to:
  /// **'Предмет обновлен'**
  String get invList_itemUpdatedMessage;

  /// No description provided for @invList_filterByCategoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Фильтр по категории'**
  String get invList_filterByCategoryLabel;

  /// No description provided for @invList_showAllCategories.
  ///
  /// In ru, this message translates to:
  /// **'Все категории'**
  String get invList_showAllCategories;

  /// No description provided for @invList_searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по штрихкоду, инвентарному номеру или названию'**
  String get invList_searchHint;

  /// No description provided for @invList_notSpecified.
  ///
  /// In ru, this message translates to:
  /// **'Не указано'**
  String get invList_notSpecified;

  /// No description provided for @invList_notSpecifiedMale.
  ///
  /// In ru, this message translates to:
  /// **'Не указан'**
  String get invList_notSpecifiedMale;

  /// No description provided for @invList_notSpecifiedFemale.
  ///
  /// In ru, this message translates to:
  /// **'Не указана'**
  String get invList_notSpecifiedFemale;

  /// No description provided for @invList_closeButton.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get invList_closeButton;

  /// No description provided for @invList_noItemsFilterMessage.
  ///
  /// In ru, this message translates to:
  /// **'Нет предметов, удовлетворяющих фильтуру'**
  String get invList_noItemsFilterMessage;

  /// No description provided for @invList_errorMessagePrefix.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: '**
  String get invList_errorMessagePrefix;

  /// No description provided for @invList_detailNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название:'**
  String get invList_detailNameLabel;

  /// No description provided for @invList_detailBarcodeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод:'**
  String get invList_detailBarcodeLabel;

  /// No description provided for @invList_detailInventoryNumberLabel.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарный №:'**
  String get invList_detailInventoryNumberLabel;

  /// No description provided for @invList_detailQuantityLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество:'**
  String get invList_detailQuantityLabel;

  /// No description provided for @invList_detailRoomLabel.
  ///
  /// In ru, this message translates to:
  /// **'Помещение:'**
  String get invList_detailRoomLabel;

  /// No description provided for @invList_detailResponsibleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Ответственный:'**
  String get invList_detailResponsibleLabel;

  /// No description provided for @invList_detailCategoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Категория:'**
  String get invList_detailCategoryLabel;

  /// No description provided for @invList_detailDateLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата постановки:'**
  String get invList_detailDateLabel;

  /// No description provided for @invList_detailDescriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание:'**
  String get invList_detailDescriptionLabel;

  /// No description provided for @invForm_appBarCreateTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создание предмета'**
  String get invForm_appBarCreateTitle;

  /// No description provided for @invForm_appBarEditTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование предмета'**
  String get invForm_appBarEditTitle;

  /// No description provided for @invForm_barcodeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод'**
  String get invForm_barcodeLabel;

  /// No description provided for @invForm_noBarcode.
  ///
  /// In ru, this message translates to:
  /// **'Нет кода'**
  String get invForm_noBarcode;

  /// No description provided for @invForm_scanOrInputTooltip.
  ///
  /// In ru, this message translates to:
  /// **'Сканировать/Ввести'**
  String get invForm_scanOrInputTooltip;

  /// No description provided for @invForm_nameFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название *'**
  String get invForm_nameFieldLabel;

  /// No description provided for @invForm_nameRequiredError.
  ///
  /// In ru, this message translates to:
  /// **'Введите название'**
  String get invForm_nameRequiredError;

  /// No description provided for @invForm_minLength3Error.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 3 символа'**
  String get invForm_minLength3Error;

  /// No description provided for @invForm_maxLength50Error.
  ///
  /// In ru, this message translates to:
  /// **'Максимум 50 символов'**
  String get invForm_maxLength50Error;

  /// No description provided for @invForm_inventoryNumberFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарный номер'**
  String get invForm_inventoryNumberFieldLabel;

  /// No description provided for @invForm_quantityFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Количество'**
  String get invForm_quantityFieldLabel;

  /// No description provided for @invForm_quantityRequiredError.
  ///
  /// In ru, this message translates to:
  /// **'Введите количество'**
  String get invForm_quantityRequiredError;

  /// No description provided for @invForm_quantityRangeError.
  ///
  /// In ru, this message translates to:
  /// **'От 1 до 999'**
  String get invForm_quantityRangeError;

  /// No description provided for @invForm_responsibleLabel.
  ///
  /// In ru, this message translates to:
  /// **'Ответственный'**
  String get invForm_responsibleLabel;

  /// No description provided for @invForm_categoryLabel.
  ///
  /// In ru, this message translates to:
  /// **'Категория'**
  String get invForm_categoryLabel;

  /// No description provided for @invForm_roomLabel.
  ///
  /// In ru, this message translates to:
  /// **'Помещение'**
  String get invForm_roomLabel;

  /// No description provided for @invForm_notSelected.
  ///
  /// In ru, this message translates to:
  /// **'Не выбрано'**
  String get invForm_notSelected;

  /// No description provided for @invForm_descriptionFieldLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get invForm_descriptionFieldLabel;

  /// No description provided for @invForm_maxLength500Error.
  ///
  /// In ru, this message translates to:
  /// **'Максимум 500 символов'**
  String get invForm_maxLength500Error;

  /// No description provided for @invForm_dateAddedLabel.
  ///
  /// In ru, this message translates to:
  /// **'Дата постановки на учёт *'**
  String get invForm_dateAddedLabel;

  /// No description provided for @invForm_saveButton.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get invForm_saveButton;

  /// No description provided for @invForm_cancelButton.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get invForm_cancelButton;

  /// No description provided for @invForm_barcodeDialogTitle.
  ///
  /// In ru, this message translates to:
  /// **'Ввод штрихкода'**
  String get invForm_barcodeDialogTitle;

  /// No description provided for @invForm_barcodeFieldInDialog.
  ///
  /// In ru, this message translates to:
  /// **'Штрихкод'**
  String get invForm_barcodeFieldInDialog;

  /// No description provided for @invForm_cameraScanText.
  ///
  /// In ru, this message translates to:
  /// **'Или отсканируйте камерой:'**
  String get invForm_cameraScanText;

  /// No description provided for @invForm_resetScannerButton.
  ///
  /// In ru, this message translates to:
  /// **'Сбросить сканер'**
  String get invForm_resetScannerButton;

  /// No description provided for @invForm_scannedSuccessMessage.
  ///
  /// In ru, this message translates to:
  /// **'Отсканировано!'**
  String get invForm_scannedSuccessMessage;

  /// No description provided for @categories_emptyList.
  ///
  /// In ru, this message translates to:
  /// **'Список категорий пуст'**
  String get categories_emptyList;

  /// No description provided for @categories_newTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новая категория'**
  String get categories_newTitle;

  /// No description provided for @categories_editTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать категорию'**
  String get categories_editTitle;

  /// No description provided for @categories_nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get categories_nameLabel;

  /// No description provided for @categories_descriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get categories_descriptionLabel;

  /// No description provided for @categories_created.
  ///
  /// In ru, this message translates to:
  /// **'Категория создана'**
  String get categories_created;

  /// No description provided for @categories_updated.
  ///
  /// In ru, this message translates to:
  /// **'Данные категории обновлены'**
  String get categories_updated;

  /// No description provided for @positions_emptyList.
  ///
  /// In ru, this message translates to:
  /// **'Список должностей пуст'**
  String get positions_emptyList;

  /// No description provided for @positions_newTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новая должность'**
  String get positions_newTitle;

  /// No description provided for @positions_editTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать должность'**
  String get positions_editTitle;

  /// No description provided for @positions_nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get positions_nameLabel;

  /// No description provided for @positions_created.
  ///
  /// In ru, this message translates to:
  /// **'Должность создана'**
  String get positions_created;

  /// No description provided for @positions_updated.
  ///
  /// In ru, this message translates to:
  /// **'Данные должности обновлены'**
  String get positions_updated;

  /// No description provided for @rooms_emptyList.
  ///
  /// In ru, this message translates to:
  /// **'Список помещений пуст'**
  String get rooms_emptyList;

  /// No description provided for @rooms_newTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новое помещение'**
  String get rooms_newTitle;

  /// No description provided for @rooms_editTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактировать помещение'**
  String get rooms_editTitle;

  /// No description provided for @rooms_nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get rooms_nameLabel;

  /// No description provided for @rooms_descriptionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Описание'**
  String get rooms_descriptionLabel;

  /// No description provided for @rooms_created.
  ///
  /// In ru, this message translates to:
  /// **'Помещение создано'**
  String get rooms_created;

  /// No description provided for @rooms_updated.
  ///
  /// In ru, this message translates to:
  /// **'Данные помещения обновлены'**
  String get rooms_updated;

  /// No description provided for @common_error.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка: {message}'**
  String common_error(String message);

  /// No description provided for @common_cancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get common_cancel;

  /// No description provided for @common_delete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить'**
  String get common_delete;

  /// No description provided for @common_save.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get common_save;

  /// No description provided for @common_create.
  ///
  /// In ru, this message translates to:
  /// **'Создать'**
  String get common_create;

  /// No description provided for @common_all.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get common_all;

  /// No description provided for @common_notSelected.
  ///
  /// In ru, this message translates to:
  /// **'Не выбрано'**
  String get common_notSelected;

  /// No description provided for @common_notDefined.
  ///
  /// In ru, this message translates to:
  /// **'Не определено'**
  String get common_notDefined;

  /// No description provided for @common_administrator.
  ///
  /// In ru, this message translates to:
  /// **'Администратор'**
  String get common_administrator;

  /// No description provided for @common_inventoryNumberPrefix.
  ///
  /// In ru, this message translates to:
  /// **'Инв. №: '**
  String get common_inventoryNumberPrefix;

  /// No description provided for @common_deleteConfirmTitle.
  ///
  /// In ru, this message translates to:
  /// **'Удалить {itemType}?'**
  String common_deleteConfirmTitle(String itemType);

  /// No description provided for @common_deleteConfirmContent.
  ///
  /// In ru, this message translates to:
  /// **'Вы уверены, что хотите удалить \"{name}\"?'**
  String common_deleteConfirmContent(String name);

  /// No description provided for @employees_searchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск сотрудника...'**
  String get employees_searchHint;

  /// No description provided for @employees_notFound.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники не найдены'**
  String get employees_notFound;

  /// No description provided for @employees_unknownPosition.
  ///
  /// In ru, this message translates to:
  /// **'Неизвестная должность'**
  String get employees_unknownPosition;

  /// No description provided for @employees_createTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создание сотрудника'**
  String get employees_createTitle;

  /// No description provided for @employees_editTitle.
  ///
  /// In ru, this message translates to:
  /// **'Редактирование сотрудника'**
  String get employees_editTitle;

  /// No description provided for @employees_created.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудник создан'**
  String get employees_created;

  /// No description provided for @employees_updated.
  ///
  /// In ru, this message translates to:
  /// **'Данные обновлены'**
  String get employees_updated;

  /// No description provided for @employees_nameLabel.
  ///
  /// In ru, this message translates to:
  /// **'ФИО'**
  String get employees_nameLabel;

  /// No description provided for @employees_positionLabel.
  ///
  /// In ru, this message translates to:
  /// **'Должность'**
  String get employees_positionLabel;

  /// No description provided for @employees_roomLabel.
  ///
  /// In ru, this message translates to:
  /// **'Помещение'**
  String get employees_roomLabel;

  /// No description provided for @employees_assignedInventory.
  ///
  /// In ru, this message translates to:
  /// **'Прикрепленный инвентарь'**
  String get employees_assignedInventory;

  /// No description provided for @employees_noInventory.
  ///
  /// In ru, this message translates to:
  /// **'За сотрудником не закреплен инвентарь'**
  String get employees_noInventory;

  /// No description provided for @employees_selectPosition.
  ///
  /// In ru, this message translates to:
  /// **'Выберите должность'**
  String get employees_selectPosition;

  /// No description provided for @employees_minLength3.
  ///
  /// In ru, this message translates to:
  /// **'Минимум 3 символа'**
  String get employees_minLength3;

  /// No description provided for @employees_maxLength50.
  ///
  /// In ru, this message translates to:
  /// **'Максимум 50 символов'**
  String get employees_maxLength50;

  /// No description provided for @rooms_inventoryTab.
  ///
  /// In ru, this message translates to:
  /// **'Инвентарь'**
  String get rooms_inventoryTab;

  /// No description provided for @rooms_employeesTab.
  ///
  /// In ru, this message translates to:
  /// **'Сотрудники'**
  String get rooms_employeesTab;

  /// No description provided for @rooms_noInventory.
  ///
  /// In ru, this message translates to:
  /// **'В этом помещении нет инвентаря'**
  String get rooms_noInventory;

  /// No description provided for @rooms_noEmployees.
  ///
  /// In ru, this message translates to:
  /// **'В этом помещении нет сотрудников'**
  String get rooms_noEmployees;

  /// No description provided for @error_database.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка доступа к базе данных'**
  String get error_database;

  /// No description provided for @error_notFound.
  ///
  /// In ru, this message translates to:
  /// **'Ресурс не найден'**
  String get error_notFound;

  /// No description provided for @error_validation.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка валидации данных'**
  String get error_validation;

  /// No description provided for @error_unknown.
  ///
  /// In ru, this message translates to:
  /// **'Произошла неизвестная ошибка'**
  String get error_unknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
