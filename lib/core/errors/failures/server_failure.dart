import '../../constants/constants.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({
    super.message = kServerFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'ServerFailure(message: $message, exception: $exception)';
}
