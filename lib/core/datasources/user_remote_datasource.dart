import '../../features/auth/data/models/models.dart';
import '../../features/auth/domain/entities/entities.dart';

abstract class UserRemoteDataSource {
  Stream<User?> getById(String userId);

  Stream<List<User?>> getByIds(List<String> userIds);

  Future<void> post(UserModel user);
}
