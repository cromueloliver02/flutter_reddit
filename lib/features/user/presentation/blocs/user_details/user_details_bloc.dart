import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/entities/entities.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/usecases/usecases.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final GetUserProfile _getUserProfile;

  UserDetailsBloc({
    required GetUserProfile getUserProfile,
  })  : _getUserProfile = getUserProfile,
        super(UserDetailsState.initial()) {
    on<UserDetailsGetRequested>(_onUserDetailsGetRequested);
  }

  void _onUserDetailsGetRequested(
    UserDetailsGetRequested event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(state.copyWith(status: () => UserDetailsStatus.loading));

    final StreamEither<User> eitherUserStream = _getUserProfile(event.userId);

    // a hack to fix the builder skipping the loading status
    await Future.delayed(const Duration(milliseconds: 250));

    await emit.onEach<SyncEither<User>>(
      eitherUserStream,
      onData: (SyncEither<User> eitherUser) => eitherUser.fold(
        (Failure error) {
          emit(state.copyWith(
            status: () => UserDetailsStatus.failure,
            error: () => error,
          ));

          debugPrint(error.toString());
        },
        (User user) => emit(state.copyWith(
          user: () => user,
          status: () => UserDetailsStatus.success,
        )),
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => UserDetailsStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }
}
