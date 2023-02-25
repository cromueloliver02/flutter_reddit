import 'package:dartz/dartz.dart';

import 'errors/failures/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
