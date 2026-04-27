import 'package:inventory_p_shalaev/generated/app_localizations.dart';

/// Types of failures that can occur in the application
enum AppFailure {
  /// General unknown error
  unknown,

  /// Error during database operations
  database,

  /// Resource not found
  notFound,

  /// Data validation failed (business logic)
  validation,
}

extension AppFailureExtension on AppFailure {
  /// Converts the failure to a user-friendly localized string
  String toLocalizedString(AppLocalizations l10n) {
    switch (this) {
      case AppFailure.database:
        return l10n.error_database;
      case AppFailure.notFound:
        return l10n.error_notFound;
      case AppFailure.validation:
        return l10n.error_validation;
      case AppFailure.unknown:
        return l10n.error_unknown;
    }
  }
}
