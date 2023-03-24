class NotFoundException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const NotFoundException({
    required this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      'NotFoundException(error: $error, stackTrace: $stackTrace)';
}
