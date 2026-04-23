/// Base exception class for application exceptions
///
/// Used as a parent class for all custom exceptions in the app
class AppException implements Exception {
  /// Error message describing the exception
  final String message;

  /// Optional error code for programmatic handling
  final String? code;

  /// Creates [AppException] with a message and optional code
  AppException({required this.message, this.code});

  @override
  String toString() => message;
}

/// Exception thrown when category validation fails
class CategoryValidationException extends AppException {
  CategoryValidationException({required super.message})
    : super(code: 'CATEGORY_VALIDATION_ERROR');
}

/// Exception thrown when category is not found
class CategoryNotFoundException extends AppException {
  CategoryNotFoundException({required int id})
    : super(
        message: 'Category with id $id not found',
        code: 'CATEGORY_NOT_FOUND',
      );
}

/// Exception thrown when category already exists
class CategoryAlreadyExistsException extends AppException {
  CategoryAlreadyExistsException({required String name})
    : super(
        message: 'Category with name "$name" already exists',
        code: 'CATEGORY_ALREADY_EXISTS',
      );
}
