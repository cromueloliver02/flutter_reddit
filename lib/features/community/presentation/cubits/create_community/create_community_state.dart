part of 'create_community_cubit.dart';

enum CreateCommunityStatus { initial, loading, success, failure }

class CreateCommunityState extends Equatable {
  final CreateCommunityStatus status;
  final Failure error;

  const CreateCommunityState({
    required this.status,
    required this.error,
  });

  factory CreateCommunityState.initial() {
    return const CreateCommunityState(
      status: CreateCommunityStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'CreateCommunityState(status: $status, error: $error)';

  CreateCommunityState copyWith({
    CreateCommunityStatus Function()? status,
    Failure Function()? error,
  }) {
    return CreateCommunityState(
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
