import '../../constants/constants.dart';
import 'failure.dart';

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = kUnexpectedFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'UnexpectedFailure(message: $message, exception: $exception)';
}
