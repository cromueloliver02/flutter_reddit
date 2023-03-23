part of 'community_members_bloc.dart';

abstract class CommunityMembersEvent extends Equatable {
  const CommunityMembersEvent();

  @override
  List<Object> get props => [];
}

class CommunityMembersFetched extends CommunityMembersEvent {
  final String communityId;

  const CommunityMembersFetched({
    required this.communityId,
  });

  @override
  List<Object> get props => [communityId];
}
