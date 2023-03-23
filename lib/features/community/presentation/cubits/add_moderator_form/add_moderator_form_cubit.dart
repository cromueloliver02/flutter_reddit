import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_moderator_form_state.dart';

class AddModeratorFormCubit extends Cubit<AddModeratorFormState> {
  AddModeratorFormCubit() : super(AddModeratorFormState.initial());

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
