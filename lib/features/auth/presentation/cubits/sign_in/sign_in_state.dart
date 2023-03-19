part of 'sign_in_cubit.dart';

enum SignInStatus { initial, loading, success, failure }

class SignInState extends Equatable {
  final SignInStatus status;
  final Failure error;

  const SignInState({
    required this.status,
    required this.error,
  });

  factory SignInState.initial() {
    return const SignInState(
      status: SignInStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'SignInState(status: $status)';

  SignInState copyWith({
    SignInStatus Function()? status,
    Failure Function()? error,
  }) {
    return SignInState(
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
