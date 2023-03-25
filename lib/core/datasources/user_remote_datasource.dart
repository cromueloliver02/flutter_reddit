import '../entities/entities.dart';
import '../models/models.dart';

abstract class UserRemoteDataSource {
  Stream<User> getUserById(String userId);

  Stream<List<User>> getUsersByIds(List<String> userIds);

  Future<void> createUser(UserModel user);
}
