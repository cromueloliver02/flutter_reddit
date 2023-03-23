part of 'community_members_bloc.dart';

enum CommunityMembersStatus { initial, loading, success, failure }

class CommunityMembersState extends Equatable {
  final List<User> communityMembers;
  final CommunityMembersStatus status;
  final Failure error;

  const CommunityMembersState({
    required this.communityMembers,
    required this.status,
    required this.error,
  });

  factory CommunityMembersState.initial() {
    return const CommunityMembersState(
      communityMembers: <User>[],
      status: CommunityMembersStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [communityMembers, status, error];

  @override
  String toString() =>
      'CommunityMembersState(communityMembers: $communityMembers, status: $status, error: $error)';

  CommunityMembersState copyWith({
    List<User> Function()? communityMembers,
    CommunityMembersStatus Function()? status,
    Failure Function()? error,
  }) {
    return CommunityMembersState(
      communityMembers:
          communityMembers != null ? communityMembers() : this.communityMembers,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
