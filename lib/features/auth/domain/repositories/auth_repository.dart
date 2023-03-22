import '../../../../core/typedefs.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  StreamEither<User?> get authStateChanges;

  FutureEither<User?> signInWithGoogle();

  FutureEither<void> signOut();
}
