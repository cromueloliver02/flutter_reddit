part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
}

class CommunityUserGetRequested extends CommunityEvent {
  final String userId;

  const CommunityUserGetRequested({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class CommunityStreamed extends CommunityEvent {
  final List<Community> communities;

  const CommunityStreamed({
    required this.communities,
  });

  @override
  List<Object> get props => [communities];
}

class CommunityCreated extends CommunityEvent {
  final String userId;
  final String name;

  const CommunityCreated({
    required this.userId,
    required this.name,
  });

  @override
  List<Object> get props => [userId, name];
}
