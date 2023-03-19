import '../../constants/constants.dart';
import 'failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = kNetworkFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'NetworkFailure(message: $message, exception: $exception)';
}
