class NetworkException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const NetworkException({
    required this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      'NetworkException(error: $error, stackTrace: $stackTrace)';
}
