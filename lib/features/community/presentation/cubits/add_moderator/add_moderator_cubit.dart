import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/usecases/usecases.dart';

part 'add_moderator_state.dart';

class AddModeratorCubit extends Cubit<AddModeratorState> {
  final SaveModerators _saveModerators;

  AddModeratorCubit({
    required SaveModerators saveModerators,
  })  : _saveModerators = saveModerators,
        super(AddModeratorState.initial());

  void saveModerators(String communityId) async {
    emit(state.copyWith(status: () => AddModeratorStatus.loading));

    final SyncEither<void> eitherVoid =
        await _saveModerators(SaveModeratorsParams(
      communityId: communityId,
      moderatorIds: state.moderatorIds.toList(),
    ));

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => AddModeratorStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        status: () => AddModeratorStatus.success,
      )),
    );
  }

  void setSelectedModerators(List<String> existingModeratorIds) {
    emit(state.copyWith(
      moderatorIds: () => existingModeratorIds.toSet(),
    ));
  }

  void toggleModerator(String userId) {
    Set<String> moderatorIds = state.moderatorIds;

    if (moderatorIds.contains(userId)) {
      moderatorIds = moderatorIds.where((d) => d != userId).toSet();
    } else {
      moderatorIds = {...state.moderatorIds, userId};
    }

    emit(state.copyWith(moderatorIds: () => moderatorIds));
  }
}
