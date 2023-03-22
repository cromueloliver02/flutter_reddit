import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginWithGoogle _loginWithGoogle;

  SignInCubit({
    required LoginWithGoogle loginWithGoogle,
  })  : _loginWithGoogle = loginWithGoogle,
        super(SignInState.initial());

  void signInWithGoogle() async {
    emit(state.copyWith(status: () => SignInStatus.loading));

    final SyncEither<User?> eitherUser = await _loginWithGoogle(NoParams());

    eitherUser.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => SignInStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (User? user) => emit(state.copyWith(
        status: () => SignInStatus.success,
      )),
    );
  }
}
