import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class AuthBlocImpl extends AuthBloc {
  final GetAuthStateChanges _getAuthStateChanges;

  AuthBlocImpl({
    required GetAuthStateChanges getAuthStateChanges,
  })  : _getAuthStateChanges = getAuthStateChanges,
        super(AuthState.initial()) {
    on<AuthStarted>(onAuthStarted);
  }

  @override
  void onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: () => AuthStatus.loading));

    final StreamEither<User?> eitherAuthStream = _getAuthStateChanges();

    await emit.forEach<Either<Failure, User?>>(
      eitherAuthStream,
      onData: (Either<Failure, User?> eitherUser) {
        if (eitherUser.isLeft()) {
          late final Failure error;
          eitherUser.leftMap((Failure failure) => error = failure);

          debugPrint(error.toString());

          return state.copyWith(
            status: () => AuthStatus.failure,
            error: () => error,
          );
        }

        final User? user = eitherUser.getOrElse(() => null);

        if (user == null) {
          return state.copyWith(
            user: () => null,
            status: () => AuthStatus.success,
            userAuthStatus: () => UserAuthStatus.unauthenticated,
          );
        }

        return state.copyWith(
          user: () => user,
          status: () => AuthStatus.success,
          userAuthStatus: () => UserAuthStatus.authenticated,
        );
      },
      onError: (error, stackTrace) {
        debugPrint(error.toString());

        return state.copyWith(
          status: () => AuthStatus.failure,
          error: () => error as Failure,
        );
      },
    );
  }
}
