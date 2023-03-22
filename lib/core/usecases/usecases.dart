import '../typedefs.dart';

abstract class FutureUseCase<T, P> {
  FutureEither<T> call(P params);
}

abstract class StreamUseCase<T, P> {
  StreamEither<T> call(P params);
}

class NoParams {}
