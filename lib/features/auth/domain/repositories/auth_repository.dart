import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/typedefs.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  StreamEither<fb_auth.User?> get authStateChanges;
  FutureEither<User?> signInWithGoogle();
}
