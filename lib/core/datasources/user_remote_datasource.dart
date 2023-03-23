import '../../features/auth/data/models/models.dart';
import '../../features/auth/domain/entities/entities.dart';

abstract class UserRemoteDataSource {
  Stream<User?> getUserById(String userId);

  Stream<List<User?>> getUsersByIds(List<String> userIds);

  Future<void> createUser(UserModel user);
}
