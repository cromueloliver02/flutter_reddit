part of 'add_moderator_form_cubit.dart';

class AddModeratorFormState extends Equatable {
  final Set<String> moderatorIds;

  const AddModeratorFormState({
    required this.moderatorIds,
  });

  factory AddModeratorFormState.initial() {
    return const AddModeratorFormState(
      moderatorIds: <String>{},
    );
  }

  @override
  List<Object> get props => [moderatorIds];

  @override
  String toString() => 'AddModeratorFormState(moderatorIds: $moderatorIds)';

  AddModeratorFormState copyWith({
    Set<String> Function()? moderatorIds,
  }) {
    return AddModeratorFormState(
      moderatorIds: moderatorIds != null ? moderatorIds() : this.moderatorIds,
    );
  }
}
