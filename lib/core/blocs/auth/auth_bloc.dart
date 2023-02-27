// ignore_for_file: unused_element

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'auth_event.dart';
part 'auth_state.dart';

abstract class AuthBloc {
  void _onAuthStarted(AuthStarted event, Emitter<AuthState> emit);
}
