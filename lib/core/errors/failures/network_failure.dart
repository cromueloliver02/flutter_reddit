import '../../constants/constants.dart';
import 'failure.dart';

class NetworkFailure extends Failure {
  NetworkFailure({
    super.message = kNetworkFailureMsg,
    super.exception,
  });

  @override
  List<Object?> get props => [message, exception];

  @override
  String toString() =>
      'NetworkFailure(message: $message, exception: $exception)';
}
