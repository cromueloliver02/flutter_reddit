part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

class UserDetailsGetRequested extends UserDetailsEvent {
  final String userId;

  const UserDetailsGetRequested({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
