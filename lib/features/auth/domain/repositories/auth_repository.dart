import '../../../../core/typedefs.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  FutureEither<User?> signInWithGoogle();
}
