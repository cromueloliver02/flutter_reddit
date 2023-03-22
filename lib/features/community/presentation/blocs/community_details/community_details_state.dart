part of 'community_details_bloc.dart';

enum CommunityDetailsStatus { initial, loading, success, failure }

class CommunityDetailsState extends Equatable {
  final Community? community;
  final CommunityDetailsStatus status;
  final Failure error;

  const CommunityDetailsState({
    required this.community,
    required this.status,
    required this.error,
  });

  factory CommunityDetailsState.initial() {
    return const CommunityDetailsState(
      community: null,
      status: CommunityDetailsStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object?> get props => [community, status, error];

  @override
  String toString() =>
      'CommunityDetailsState(community: $community, status: $status, error: $error)';

  CommunityDetailsState copyWith({
    Community? Function()? community,
    CommunityDetailsStatus Function()? status,
    Failure Function()? error,
  }) {
    return CommunityDetailsState(
      community: community != null ? community() : this.community,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
