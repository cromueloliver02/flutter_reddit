import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

abstract class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(super.initialState);

  void onAuthStarted(AuthStarted event, Emitter<AuthState> emit);

  void onAuthSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  );
}
