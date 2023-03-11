part of 'community_list_bloc.dart';

abstract class CommunityListEvent extends Equatable {
  const CommunityListEvent();

  @override
  List<Object> get props => [];
}

class CommunityListUserFetched extends CommunityListEvent {
  final String userId;

  const CommunityListUserFetched({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class CommunityListChanged extends CommunityListEvent {
  final List<Community> communityList;

  const CommunityListChanged({
    required this.communityList,
  });

  @override
  List<Object> get props => [communityList];
}
