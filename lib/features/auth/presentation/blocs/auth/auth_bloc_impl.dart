import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/entities/entities.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

class AuthBlocImpl extends AuthBloc {
  final GetAuthStateChanges _getAuthStateChanges;
  final SignOut _signOut;

  AuthBlocImpl({
    required GetAuthStateChanges getAuthStateChanges,
    required SignOut signOut,
  })  : _getAuthStateChanges = getAuthStateChanges,
        _signOut = signOut,
        super(AuthState.initial()) {
    on<AuthStarted>(onAuthStarted);
    on<AuthSignOutRequested>(onAuthSignOutRequested);
  }

  @override
  void onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: () => AuthStatus.loading));

    final StreamEither<User?> eitherAuthStream =
        _getAuthStateChanges(NoParams());

    await emit.onEach<SyncEither<User?>>(
      eitherAuthStream,
      onData: (SyncEither<User?> eitherUser) => eitherUser.fold(
        (Failure error) {
          emit(state.copyWith(
            status: () => AuthStatus.failure,
            error: () => error,
          ));

          debugPrint(error.toString());
        },
        (User? user) {
          if (user == null) {
            emit(state.copyWith(
              user: () => null,
              status: () => AuthStatus.success,
              userAuthStatus: () => UserAuthStatus.unauthenticated,
            ));
          }

          if (user != null) {
            emit(state.copyWith(
              user: () => user,
              status: () => AuthStatus.success,
              userAuthStatus: () => UserAuthStatus.authenticated,
            ));
          }
        },
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => AuthStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }

  @override
  void onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: () => AuthStatus.loading));

    final SyncEither<void> eitherVoid = await _signOut(NoParams());

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => AuthStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        status: () => AuthStatus.success,
      )),
    );
  }
}
