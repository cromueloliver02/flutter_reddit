part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
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
