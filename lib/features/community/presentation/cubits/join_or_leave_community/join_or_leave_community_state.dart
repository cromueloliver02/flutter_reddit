part of 'join_or_leave_community_cubit.dart';

enum JoinOrLeaveCommunityStatus { initial, loading, success, failure }

class JoinOrLeaveCommunityState extends Equatable {
  final JoinOrLeaveCommunityStatus status;
  final Failure error;

  const JoinOrLeaveCommunityState({
    required this.status,
    required this.error,
  });

  factory JoinOrLeaveCommunityState.initial() {
    return const JoinOrLeaveCommunityState(
      status: JoinOrLeaveCommunityStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() =>
      'JoinOrLeaveCommunityState(status: $status, error: $error)';

  JoinOrLeaveCommunityState copyWith({
    JoinOrLeaveCommunityStatus Function()? status,
    Failure Function()? error,
  }) {
    return JoinOrLeaveCommunityState(
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
