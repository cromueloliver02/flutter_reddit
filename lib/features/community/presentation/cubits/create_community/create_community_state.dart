part of 'create_community_cubit.dart';

enum CreateCommunityStatus { initial, loading, success, failure }

class CreateCommunityState extends Equatable {
  final Community community;
  final CreateCommunityStatus status;
  final Failure error;

  const CreateCommunityState({
    required this.community,
    required this.status,
    required this.error,
  });

  factory CreateCommunityState.initial() {
    return CreateCommunityState(
      community: Community.empty(),
      status: CreateCommunityStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [community, status, error];

  @override
  String toString() =>
      'CreateCommunityState(community: $community, status: $status, error: $error)';

  CreateCommunityState copyWith({
    Community Function()? community,
    CreateCommunityStatus Function()? status,
    Failure Function()? error,
  }) {
    return CreateCommunityState(
      community: community != null ? community() : this.community,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
