# inventory-p-shalaev

## Inventory Management Application

Mobile Flutter application for local inventory tracking with barcode scanning support, employee and room management. All data is stored locally on the device.

## Features

- **Barcode Scanning** - Scan barcodes or enter manually
- **Inventory Management** - CRUD operations for inventory items
- **Employee Management** - Track responsible persons
- **Room Management** - Manage locations
- **Categories & Positions** - Organize items and employees
- **Local Storage** - SQLite database for offline operation

## Getting Started

### Prerequisites

- Flutter SDK ^3.11.1
- Dart SDK

### Installation

```bash
# Clone the repository
git clone https://git.evapps.ru/mkazantsev/inventory-p-shalaev.git

# Navigate to project directory
cd inventory-p-shalaev

# Install dependencies
flutter pub get

# Run the application
flutter run
```

### Build Configuration

The application displays the current Git commit hash in the side drawer. To inject the actual hash during build or run, use the `GIT_SHA` environment variable:

**PowerShell (Windows):**
```powershell
flutter run --dart-define=GIT_SHA=$(git rev-parse --short HEAD)
```

**Bash (macOS/Linux):**
```bash
flutter run --dart-define=GIT_SHA=$(git rev-parse --short HEAD)
```

If not provided, the application uses a default hardcoded value.

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

### Code Analysis

```bash
# Run analyzer
flutter analyze

# Format code
dart format .
```

## Architecture

This project follows Clean Architecture principles with three main layers:

- **Presentation Layer** - UI, BLoC, widgets
- **Domain Layer** - Entities, Use Cases, Repository interfaces
- **Data Layer** - Repositories implementations, Data Sources, Models

## Dependencies

- `flutter_bloc` - State management
- `sqflite` - SQLite database
- `get_it` - Dependency injection
- `go_router` - Navigation
- `mobile_scanner` - Barcode scanning
- `package_info_plus` - App version info
- `intl` - Localization

## Project Structure

```
lib/
├── core/                    # Core utilities, database, exceptions
│   ├── database/
│   ├── exceptions/
│   └── ...
├── features/                # Feature modules
│   ├── home/
│   ├── inventory/
│   ├── employees/
│   ├── rooms/
│   ├── categories/
│   └── positions/
└── main.dart
```

## License

This project is developed for internal use.
