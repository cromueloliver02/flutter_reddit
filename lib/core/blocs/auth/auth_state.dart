part of 'auth_bloc.dart';

enum UserAuthStatus { unknown, authenticated, unauthenticated }

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final User? user;
  final UserAuthStatus userAuthStatus;
  final AuthStatus status;
  final Failure error;

  const AuthState({
    required this.user,
    required this.userAuthStatus,
    required this.status,
    required this.error,
  });

  factory AuthState.initial() {
    return AuthState(
      user: null,
      userAuthStatus: UserAuthStatus.unknown,
      status: AuthStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object?> get props => [user, userAuthStatus, status, error];

  @override
  String toString() {
    return 'AuthState(user: $user, userAuthStatus: $userAuthStatus, status: $status, error: $error)';
  }

  AuthState copyWith({
    User? Function()? user,
    UserAuthStatus Function()? userAuthStatus,
    AuthStatus Function()? status,
    Failure Function()? error,
  }) {
    return AuthState(
      user: user != null ? user() : this.user,
      userAuthStatus:
          userAuthStatus != null ? userAuthStatus() : this.userAuthStatus,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
