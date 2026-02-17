/// Base class for all exceptions in the data layer
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Exception thrown when server returns an error
class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred']);
}

/// Exception thrown when cache/local data access fails
class CacheException extends AppException {
  CacheException([super.message = 'Cache error occurred']);
}

/// Exception thrown when network connection is unavailable
class NetworkException extends AppException {
  NetworkException([super.message = 'No internet connection']);
}

/// Exception thrown when data validation fails
class ValidationException extends AppException {
  ValidationException([super.message = 'Validation error']);
}

/// Exception thrown when authentication fails
class AuthException extends AppException {
  AuthException([super.message = 'Authentication failed']);
}

/// Exception thrown when a resource is not found
class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found']);
}
