part of 'community_list_bloc.dart';

enum CommunityListStatus { initial, loading, success, failure }

class CommunityListState extends Equatable {
  final List<Community> communityList;
  final CommunityListStatus status;
  final Failure error;

  const CommunityListState({
    required this.communityList,
    required this.status,
    required this.error,
  });

  factory CommunityListState.initial() {
    return CommunityListState(
      communityList: const <Community>[],
      status: CommunityListStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [communityList, status, error];

  @override
  String toString() {
    return 'CommunityListState(communityList: $communityList, status: $status, error: $error)';
  }

  CommunityListState copyWith({
    List<Community> Function()? communityList,
    CommunityListStatus Function()? status,
    Failure Function()? error,
  }) {
    return CommunityListState(
      communityList:
          communityList != null ? communityList() : this.communityList,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
