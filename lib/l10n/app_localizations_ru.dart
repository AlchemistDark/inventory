// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get homeAppBarTitle => 'Управление Инвентарем';

  @override
  String get menuUnderDevelopment => 'Меню (в разработке)';

  @override
  String get searchTitle => 'Поиск предмета';

  @override
  String get scanButton => 'Скан';

  @override
  String get searchFieldLabel => 'Введите название или номер';

  @override
  String get searchButton => 'Найти';

  @override
  String get barcodeDialogTitle => 'Сканирование штрихкода';

  @override
  String get barcodeDialogHint =>
      'Наведите камеру на штрихкод или введите его вручную ниже';

  @override
  String get barcodeFieldLabel => 'Штрихкод или инв. номер';

  @override
  String get scannerUnavailableMessage =>
      'Камера недоступна. Используйте ручной ввод.';

  @override
  String get scannerPermissionDeniedMessage =>
      'Нет доступа к камере. Используйте ручной ввод.';

  @override
  String get scannerReadButton => 'Сканировать камерой';

  @override
  String get scannerScanningLabel => 'Сканирование...';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get searchButtonDialog => 'Поиск';

  @override
  String get notFoundDialogTitle => 'Предмет не найден';

  @override
  String notFoundDialogContent(String query) {
    return 'Предмет с номером \"$query\" не найден в базе данных.';
  }

  @override
  String get createButton => 'Создать';

  @override
  String get inventoryButton => 'Инвентарь';

  @override
  String get employeesButton => 'Сотрудники';

  @override
  String get roomsButton => 'Помещения';
}
