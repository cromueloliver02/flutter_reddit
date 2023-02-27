import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetAuthStateChanges {
  final AuthRepository _authRepository;

  const GetAuthStateChanges({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  Stream<Either<Failure, User?>> call() {
    return _authRepository.authStateChanges;
  }
}
