import '../../constants/constants.dart';
import 'failure.dart';

class CorruptedImageFailure extends Failure {
  const CorruptedImageFailure({
    super.message = kCorruptedImageFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'CorruptedImageFailure(message: $message, exception: $exception)';
}
