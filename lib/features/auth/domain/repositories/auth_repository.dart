import '../../../../core/typedefs.dart';
import '../entities/entities.dart';

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

abstract class AuthRepository {
  Stream<fb_auth.User?> get user;
  FutureEither<User?> signInWithGoogle();
}
