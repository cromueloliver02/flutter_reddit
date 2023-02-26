part of 'auth_bloc.dart';

enum UserAuthStatus { unknown, authenticated, unauthenticated }

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final UserAuthStatus userAuthStatus;
  final AuthStatus status;
  final Failure error;

  const AuthState({
    required this.userAuthStatus,
    required this.status,
    required this.error,
  });

  factory AuthState.initial() {
    return AuthState(
      userAuthStatus: UserAuthStatus.unknown,
      status: AuthStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object?> get props => [userAuthStatus, status, error];

  @override
  String toString() {
    return 'AuthState(userAuthStatus: $userAuthStatus, status: $status, error: $error)';
  }

  AuthState copyWith({
    UserAuthStatus Function()? userAuthStatus,
    AuthStatus Function()? status,
    Failure Function()? error,
  }) {
    return AuthState(
      userAuthStatus:
          userAuthStatus != null ? userAuthStatus() : this.userAuthStatus,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
