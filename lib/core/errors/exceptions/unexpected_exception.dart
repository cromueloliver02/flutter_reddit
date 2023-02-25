class UnexpectedException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const UnexpectedException({
    required this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      'UnexpectedException(error: $error, stackTrace: $stackTrace)';
}
