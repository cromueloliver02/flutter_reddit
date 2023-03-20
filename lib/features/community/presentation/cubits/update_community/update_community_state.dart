part of 'update_community_cubit.dart';

enum UpdateCommunityStatus { initial, loading, success, failure }

class UpdateCommunityState extends Equatable {
  final UpdateCommunityStatus status;
  final Failure error;

  const UpdateCommunityState({
    required this.status,
    required this.error,
  });

  factory UpdateCommunityState.initial() {
    return const UpdateCommunityState(
      status: UpdateCommunityStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'UpdateCommunityState(status: $status, error: $error)';

  UpdateCommunityState copyWith({
    UpdateCommunityStatus Function()? status,
    Failure Function()? error,
  }) {
    return UpdateCommunityState(
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
