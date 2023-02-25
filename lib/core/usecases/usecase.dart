import 'package:dartz/dartz.dart';

import '../errors/failures/failures.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

class NoParams {}
