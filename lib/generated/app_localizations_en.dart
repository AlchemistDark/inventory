// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home_appBarTitle => 'Inventory Management';

  @override
  String get home_menuUnderDevelopment => 'Menu (under development)';

  @override
  String get home_searchTitle => 'Find Item';

  @override
  String get home_scanButton => 'Scan';

  @override
  String get home_searchFieldLabel => 'Enter name or number';

  @override
  String get home_searchButton => 'Search';

  @override
  String get home_barcodeDialogTitle => 'Barcode Scan';

  @override
  String get home_barcodeDialogHint =>
      'Point camera at barcode or enter manually below';

  @override
  String get home_barcodeFieldLabel => 'Barcode or Inv. number';

  @override
  String get home_scannerUnavailableMessage =>
      'Camera unavailable. Use manual input.';

  @override
  String get home_scannerPermissionDeniedMessage =>
      'Camera permission denied. Use manual input.';

  @override
  String get home_scannerReadButton => 'Scan with camera';

  @override
  String get home_scannerScanningLabel => 'Scanning...';

  @override
  String get home_saveButton => 'Save';

  @override
  String get home_cancelButton => 'Cancel';

  @override
  String get home_searchButtonDialog => 'Search';

  @override
  String get home_notFoundDialogTitle => 'Item Not Found';

  @override
  String home_notFoundDialogContent(String query) {
    return 'Item with number \"$query\" was not found in database.';
  }

  @override
  String get home_createButton => 'Create';

  @override
  String get home_createInventoryDialogTitle => 'Create new item';

  @override
  String get home_createInventoryDialogContent =>
      'Go to \"Inventory\" section to create a new item?';

  @override
  String home_creatingItemMessage(String barcode) {
    return 'Creating item with barcode: $barcode';
  }

  @override
  String get home_itemDetailsTitle => 'Item Details';

  @override
  String get home_nameLabel => 'Name:';

  @override
  String get home_barcodeLabel => 'Barcode:';

  @override
  String get home_inventoryNumberLabel => 'Inv. number:';

  @override
  String get home_quantityLabel => 'Quantity:';

  @override
  String get home_descriptionLabel => 'Description:';

  @override
  String get home_registrationDateLabel => 'Registration date:';

  @override
  String get home_notSpecified => 'Not specified';

  @override
  String get home_closeDialogButton => 'Close';

  @override
  String get home_editButton => 'Edit';

  @override
  String get home_editUnderDevelopment => 'Editing (under development)';

  @override
  String home_foundItemsTitle(int count) {
    return 'Found items: $count';
  }

  @override
  String get home_quantityPrefix => 'Qty: ';

  @override
  String get home_sectionsTitle => 'Sections';

  @override
  String get home_inventoryButton => 'Inventory';

  @override
  String get home_employeesButton => 'Employees';

  @override
  String get home_roomsButton => 'Rooms';

  @override
  String get home_inventoryUnderDevelopment =>
      'Inventory section (under development)';

  @override
  String get home_employeesUnderDevelopment =>
      'Employees section (under development)';

  @override
  String get home_roomsUnderDevelopment => 'Rooms section (under development)';

  @override
  String get home_errorPrefix => 'Error: ';

  @override
  String get home_categoriesButton => 'Categories';

  @override
  String get home_positionsButton => 'Positions';

  @override
  String get invList_appBarTitle => 'Inventory List';

  @override
  String get invList_emptyStateMessage => 'Inventory list is empty';

  @override
  String get invList_emptySearchMessage => 'Nothing found for this request';

  @override
  String get invList_noBarcode => 'No code';

  @override
  String get invList_noInventoryNumber => 'N/A';

  @override
  String get invList_inventoryNumberPrefix => 'Inv. №: ';

  @override
  String invList_itemQuantity(int count) {
    return '($count) ';
  }

  @override
  String get invList_itemAddedMessage => 'Item added';

  @override
  String get invList_itemUpdatedMessage => 'Item updated';

  @override
  String get invList_filterByCategoryLabel => 'Filter by category';

  @override
  String get invList_showAllCategories => 'All categories';

  @override
  String get invList_searchHint =>
      'Search by barcode, inventory number or name';

  @override
  String get invList_notSpecified => 'Not specified';

  @override
  String get invList_notSpecifiedMale => 'Not specified';

  @override
  String get invList_notSpecifiedFemale => 'Not specified';

  @override
  String get invList_closeButton => 'Close';

  @override
  String get invList_noItemsFilterMessage => 'No items matching filter';

  @override
  String get invList_errorMessagePrefix => 'Error: ';

  @override
  String get invList_detailNameLabel => 'Name:';

  @override
  String get invList_detailBarcodeLabel => 'Barcode:';

  @override
  String get invList_detailInventoryNumberLabel => 'Inventory №:';

  @override
  String get invList_detailQuantityLabel => 'Quantity:';

  @override
  String get invList_detailRoomLabel => 'Room:';

  @override
  String get invList_detailResponsibleLabel => 'Responsible:';

  @override
  String get invList_detailCategoryLabel => 'Category:';

  @override
  String get invList_detailDateLabel => 'Registration date:';

  @override
  String get invList_detailDescriptionLabel => 'Description:';

  @override
  String get invForm_appBarCreateTitle => 'Create Item';

  @override
  String get invForm_appBarEditTitle => 'Edit Item';

  @override
  String get invForm_barcodeLabel => 'Barcode';

  @override
  String get invForm_noBarcode => 'No code';

  @override
  String get invForm_scanOrInputTooltip => 'Scan/Input';

  @override
  String get invForm_nameFieldLabel => 'Name *';

  @override
  String get invForm_nameRequiredError => 'Enter name';

  @override
  String get invForm_minLength3Error => 'Minimum 3 characters';

  @override
  String get invForm_maxLength50Error => 'Maximum 50 characters';

  @override
  String get invForm_inventoryNumberFieldLabel => 'Inventory number *';

  @override
  String get invForm_inventoryNumberRequiredError => 'Enter inventory number';

  @override
  String get invForm_quantityFieldLabel => 'Quantity';

  @override
  String get invForm_quantityRequiredError => 'Enter quantity';

  @override
  String get invForm_quantityRangeError => 'From 1 to 999';

  @override
  String get invForm_responsibleLabel => 'Responsible';

  @override
  String get invForm_categoryLabel => 'Category';

  @override
  String get invForm_roomLabel => 'Room';

  @override
  String get invForm_notSelected => 'Not selected';

  @override
  String get invForm_descriptionFieldLabel => 'Description';

  @override
  String get invForm_maxLength500Error => 'Maximum 500 characters';

  @override
  String get invForm_dateAddedLabel => 'Registration date *';

  @override
  String get invForm_saveButton => 'Save';

  @override
  String get invForm_cancelButton => 'Cancel';

  @override
  String get invForm_barcodeDialogTitle => 'Barcode Input';

  @override
  String get invForm_barcodeFieldInDialog => 'Barcode';

  @override
  String get invForm_cameraScanText => 'Or scan with camera:';

  @override
  String get invForm_resetScannerButton => 'Reset scanner';

  @override
  String get invForm_scannedSuccessMessage => 'Scanned!';

  @override
  String get categories_emptyList => 'Categories list is empty';

  @override
  String get categories_newTitle => 'New Category';

  @override
  String get categories_editTitle => 'Edit Category';

  @override
  String get categories_nameLabel => 'Name';

  @override
  String get categories_descriptionLabel => 'Description';

  @override
  String get categories_created => 'Category created';

  @override
  String get categories_updated => 'Category updated';

  @override
  String get positions_emptyList => 'Positions list is empty';

  @override
  String get positions_newTitle => 'New Position';

  @override
  String get positions_editTitle => 'Edit Position';

  @override
  String get positions_nameLabel => 'Name';

  @override
  String get positions_created => 'Position created';

  @override
  String get positions_updated => 'Position updated';

  @override
  String get rooms_emptyList => 'Rooms list is empty';

  @override
  String get rooms_newTitle => 'New Room';

  @override
  String get rooms_editTitle => 'Edit Room';

  @override
  String get rooms_nameLabel => 'Name';

  @override
  String get rooms_descriptionLabel => 'Description';

  @override
  String get rooms_defaultDescription => 'Default room';

  @override
  String get rooms_created => 'Room created';

  @override
  String get rooms_updated => 'Room updated';

  @override
  String get common_position => 'position';

  @override
  String get common_room => 'room';

  @override
  String get common_category => 'category';

  @override
  String get common_employee => 'employee';

  @override
  String get common_item => 'item';

  @override
  String common_error(String message) {
    return 'Error: $message';
  }

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_delete => 'Delete';

  @override
  String get common_save => 'Save';

  @override
  String get common_create => 'Create';

  @override
  String get common_all => 'All';

  @override
  String get common_notSelected => 'Not selected';

  @override
  String get common_noItems => 'No items found';

  @override
  String get common_notDefined => 'Not defined';

  @override
  String get common_administrator => 'Administrator';

  @override
  String get common_inventoryNumberPrefix => 'Inv. №: ';

  @override
  String common_deleteConfirmTitle(String itemType) {
    return 'Delete $itemType?';
  }

  @override
  String common_deleteConfirmContent(String name) {
    return 'Are you sure you want to delete \"$name\"?';
  }

  @override
  String get employees_searchHint => 'Search employee...';

  @override
  String get employees_notFound => 'No employees found';

  @override
  String get employees_unknownPosition => 'Unknown position';

  @override
  String get employees_createTitle => 'Create Employee';

  @override
  String get employees_editTitle => 'Edit Employee';

  @override
  String get employees_created => 'Employee created';

  @override
  String get employees_updated => 'Data updated';

  @override
  String get employees_nameLabel => 'Full Name';

  @override
  String get employees_positionLabel => 'Position';

  @override
  String get employees_roomLabel => 'Room';

  @override
  String get employees_assignedInventory => 'Assigned Inventory';

  @override
  String get employees_noInventory => 'This employee has no assigned inventory';

  @override
  String get employees_selectPosition => 'Select a position';

  @override
  String get employees_minLength3 => 'Minimum 3 characters';

  @override
  String get employees_maxLength50 => 'Maximum 50 characters';

  @override
  String get rooms_inventoryTab => 'Inventory';

  @override
  String get rooms_employeesTab => 'Employees';

  @override
  String get rooms_noInventory => 'No inventory in this room';

  @override
  String get rooms_noEmployees => 'No employees in this room';

  @override
  String get error_database => 'Database access error';

  @override
  String get error_notFound => 'Resource not found';

  @override
  String get error_validation => 'Data validation error';

  @override
  String get error_unknown => 'An unknown error occurred';
}
