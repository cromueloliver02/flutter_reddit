import '../../../../core/entities/entities.dart';
import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repositories.dart';

class GetUserProfile implements StreamUseCase<User, String> {
  final UserRepository _userRepository;

  GetUserProfile({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  StreamEither<User> call(String userId) {
    return _userRepository.getUserProfile(userId);
  }
}
