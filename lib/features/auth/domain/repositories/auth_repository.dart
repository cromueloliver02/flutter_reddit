import '../../../../core/entities/entities.dart';
import '../../../../core/typedefs.dart';

abstract class AuthRepository {
  StreamEither<User?> get authStateChanges;

  FutureEither<User?> signInWithGoogle();

  FutureEither<void> signOut();
}
