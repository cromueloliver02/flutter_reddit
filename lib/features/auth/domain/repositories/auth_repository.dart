import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/entities.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signInWithGoogle();
}
