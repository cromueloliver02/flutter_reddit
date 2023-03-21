class CorruptedImageException implements Exception {
  final Object error;
  final StackTrace? stackTrace;

  const CorruptedImageException({
    required this.error,
    this.stackTrace,
  });

  @override
  String toString() =>
      'CorruptedImageException(error: $error, stackTrace: $stackTrace)';
}
