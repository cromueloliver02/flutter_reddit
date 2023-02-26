import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetAuthUser _getAuthUser;

  AuthBloc({
    required GetAuthUser getAuthUser,
  })  : _getAuthUser = getAuthUser,
        super(AuthState.initial()) {
    on<AuthStarted>(_onAuthStarted);
  }

  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: () => AuthStatus.loading));

    final StreamEither<fb_auth.User?> eitherAuthStream = _getAuthUser();

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
