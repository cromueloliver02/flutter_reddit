import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/errors/failures/failures.dart';
import '../repositories/repositories.dart';

class GetAuthStateChanges {
  final AuthRepository _authRepository;

  const GetAuthStateChanges({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Stream<Either<Failure, fb_auth.User?>> call() {
    return _authRepository.authStateChanges;
  }
}