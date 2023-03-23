part of 'add_moderator_cubit.dart';

enum AddModeratorStatus { initial, loading, success, failure }

class AddModeratorState extends Equatable {
  final Set<String> moderatorIds;
  final AddModeratorStatus status;
  final Failure error;

  const AddModeratorState({
    required this.moderatorIds,
    required this.status,
    required this.error,
  });

  factory AddModeratorState.initial() {
    return const AddModeratorState(
      moderatorIds: <String>{},
      status: AddModeratorStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [moderatorIds, status, error];

  @override
  String toString() =>
      'AddModeratorState(moderatorIds: $moderatorIds, status: $status, error: $error)';

  AddModeratorState copyWith({
    Set<String> Function()? moderatorIds,
    AddModeratorStatus Function()? status,
    Failure Function()? error,
  }) {
    return AddModeratorState(
      moderatorIds: moderatorIds != null ? moderatorIds() : this.moderatorIds,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
