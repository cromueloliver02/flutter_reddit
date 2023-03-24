import '../../constants/constants.dart';
import 'failure.dart';

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = kNotFoundFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'NotFoundFailure(message: $message, exception: $exception)';
}
