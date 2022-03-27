class ServerException implements Exception {}

class ShareException implements Exception {
  final String message;

  ShareException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}
