import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  Stream<Either<Failure, fb_auth.User?>> user();
  FutureEither<User?> signInWithGoogle();
}
