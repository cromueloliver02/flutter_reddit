import '../../constants/constants.dart';
import 'failure.dart';

class CommunityNameAlreadyExistFailure extends Failure {
  CommunityNameAlreadyExistFailure({
    super.message = kCommunityNameAlreadyExistFailureMsg,
    super.exception,
  });

  @override
  String toString() =>
      'CommunityNameAlreadyExistFailure(message: $message, exception: $exception)';
}
