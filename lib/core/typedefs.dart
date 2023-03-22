import 'package:dartz/dartz.dart';

import 'errors/failures/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef StreamEither<T> = Stream<Either<Failure, T>>;
typedef SyncEither<T> = Either<Failure, T>;
