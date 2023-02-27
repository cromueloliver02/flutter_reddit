// ignore_for_file: override_on_non_overriding_member

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/usecases/usecases.dart';

class AuthBlocImpl extends Bloc<AuthEvent, AuthState> implements AuthBloc {
  final GetAuthStateChanges _getAuthStateChanges;

  AuthBlocImpl({
    required GetAuthStateChanges getAuthStateChanges,
  })  : _getAuthStateChanges = getAuthStateChanges,
        super(AuthState.initial()) {
    on<AuthStarted>(_onAuthStarted);
  }

  @override
  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: () => AuthStatus.loading));

    final StreamEither<fb_auth.User?> eitherAuthStream = _getAuthStateChanges();

    await emit.forEach<Either<Failure, fb_auth.User?>>(
      eitherAuthStream,
      onData: (Either<Failure, fb_auth.User?> eitherUser) {
        if (eitherUser.isLeft()) {
          late final Failure error;
          eitherUser.leftMap((Failure failure) => error = failure);

          debugPrint(error.toString());

          return state.copyWith(
            status: () => AuthStatus.failure,
            error: () => error,
          );
        }

        final fb_auth.User? user = eitherUser.getOrElse(() => null);

        if (user == null) {
          return state.copyWith(
            status: () => AuthStatus.success,
            userAuthStatus: () => UserAuthStatus.unauthenticated,
          );
        }

        return state.copyWith(
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
