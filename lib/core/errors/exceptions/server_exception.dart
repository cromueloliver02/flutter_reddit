class ServerException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const ServerException({
    required this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      'ServerException(error: $error, stackTrace: $stackTrace)';
}
