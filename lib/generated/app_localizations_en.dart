// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeAppBarTitle => 'Inventory Management';

  @override
  String get menuUnderDevelopment => 'Menu (under development)';

  @override
  String get searchTitle => 'Find Item';

  @override
  String get scanButton => 'Scan';

  @override
  String get searchFieldLabel => 'Enter name or number';

  @override
  String get searchButton => 'Search';

  @override
  String get barcodeDialogTitle => 'Barcode Scan';

  @override
  String get barcodeDialogHint =>
      'Point camera at barcode or enter manually below';

  @override
  String get barcodeFieldLabel => 'Barcode or Inv. number';

  @override
  String get scannerUnavailableMessage =>
      'Camera unavailable. Use manual input.';

  @override
  String get scannerPermissionDeniedMessage =>
      'Camera permission denied. Use manual input.';

  @override
  String get scannerReadButton => 'Scan with camera';

  @override
  String get scannerScanningLabel => 'Scanning...';

  @override
  String get saveButton => 'Save';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get searchButtonDialog => 'Search';

  @override
  String get notFoundDialogTitle => 'Item Not Found';

  @override
  String notFoundDialogContent(String query) {
    return 'Item with number \"$query\" was not found in database.';
  }

  @override
  String get createButton => 'Create';

  @override
  String get inventoryButton => 'Inventory';

  @override
  String get employeesButton => 'Employees';

  @override
  String get roomsButton => 'Rooms';
}
