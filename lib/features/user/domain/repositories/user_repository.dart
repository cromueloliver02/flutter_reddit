import '../../../../core/entities/entities.dart';
import '../../../../core/typedefs.dart';

abstract class UserRepository {
  StreamEither<User> getUserProfile(String userId);
}
