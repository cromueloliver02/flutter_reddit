part of 'user_details_bloc.dart';

enum UserDetailsStatus { initial, loading, success, failure }

class UserDetailsState extends Equatable {
  final User? user;
  final UserDetailsStatus status;
  final Failure error;

  const UserDetailsState({
    required this.user,
    required this.status,
    required this.error,
  });

  factory UserDetailsState.initial() {
    return UserDetailsState(
      user: User.empty(),
      status: UserDetailsStatus.initial,
      error: const Failure(),
    );
  }

  @override
  List<Object?> get props => [user, status, error];

  @override
  String toString() =>
      'UserDetailsState(user: $user, status: $status, error: $error)';

  UserDetailsState copyWith({
    User? Function()? user,
    UserDetailsStatus Function()? status,
    Failure Function()? error,
  }) {
    return UserDetailsState(
      user: user != null ? user() : this.user,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
