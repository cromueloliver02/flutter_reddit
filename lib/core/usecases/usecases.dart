import 'package:dartz/dartz.dart';

import '../errors/failures/failures.dart';

abstract class UseCase<T, P> {
  Either<Failure, T> call(P params);
}

abstract class FutureUseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

abstract class StreamUseCase<T, P> {
  Stream<Either<Failure, T>> call(P params);
}

class NoParams {}
