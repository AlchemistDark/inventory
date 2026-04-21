/// Base exception class for application exceptions
class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => message;
}

/// Exception thrown when category validation fails
class CategoryValidationException extends AppException {
  CategoryValidationException({required String message})
    : super(message: message, code: 'CATEGORY_VALIDATION_ERROR');
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
