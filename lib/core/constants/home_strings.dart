/// String constants for the home screen

class AppStrings {
  AppStrings();

  static Home home = Home();
}

class Home {
  Home();

  // App Bar
  final String appBarTitle = 'Inventory Management';
  final String menuUnderDevelopment = 'Menu (under development)';

  // Search Section
  final String searchTitle = 'Search for item';
  final String scanButton = 'Scan';
  final String searchFieldLabel = 'Enter name or number';
  final String searchButton = 'Search';

  // Barcode Dialog
  final String barcodeDialogTitle = 'Barcode Scanning / Manual Input';
  final String barcodeFieldLabel = 'Barcode or inventory number';
  final String cancelButton = 'Cancel';
  final String searchButtonDialog = 'Search';

  // Not Found Dialog
  final String notFoundDialogTitle = 'Inventory Item Not Found';
  final String notFoundDialogContent =
      'Item with number "%s" not found in database.';
  final String createButton = 'Create';

  // Create Inventory Dialog
  final String createInventoryDialogTitle = 'Create New Item';
  final String createInventoryDialogContent =
      'Navigate to "Inventory" section to create a new item?';
  final String creatingItemMessage = 'Creating item with barcode: %s';

  // Item Details Dialog
  final String itemDetailsTitle = 'Item Details';
  final String nameLabel = 'Name:';
  final String barcodeLabel = 'Barcode:';
  final String inventoryNumberLabel = 'Inventory #:';
  final String quantityLabel = 'Quantity:';
  final String descriptionLabel = 'Description:';
  final String registrationDateLabel = 'Registration date:';
  final String notSpecified = 'Not specified';
  final String closeDialogButton = 'Close';
  final String editButton = 'Edit';
  final String editUnderDevelopment = 'Edit item (under development)';

  // Search Results
  final String foundItemsTitle = 'Found %d items:';
  final String quantityPrefix = 'Quantity: ';

  // Navigation Section
  final String sectionsTitle = 'Sections';
  final String inventoryButton = 'Inventory';
  final String employeesButton = 'Employees';
  final String roomsButton = 'Rooms';
  final String inventoryUnderDevelopment =
      'Inventory section (under development)';
  final String employeesUnderDevelopment =
      'Employees section (under development)';
  final String roomsUnderDevelopment =
      'Rooms section (under development)';

  // Error Messages
  final String errorPrefix = 'Error: ';
}
