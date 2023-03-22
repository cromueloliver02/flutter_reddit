part of 'community_details_bloc.dart';

abstract class CommunityDetailsEvent extends Equatable {
  const CommunityDetailsEvent();

  @override
  List<Object> get props => [];
}

class CommunityDetailsGetRequested extends CommunityDetailsEvent {
  final String communityId;

  const CommunityDetailsGetRequested({
    required this.communityId,
  });

  @override
  List<Object> get props => [communityId];
}
