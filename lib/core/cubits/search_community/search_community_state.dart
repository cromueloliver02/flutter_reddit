part of 'search_community_cubit.dart';

enum SearchCommunityStatus { initial, loading, success, failure }

class SearchCommunityState extends Equatable {
  final List<Community> results;
  final SearchCommunityStatus status;
  final Failure error;

  const SearchCommunityState({
    required this.results,
    required this.status,
    required this.error,
  });

  factory SearchCommunityState.initial() {
    return const SearchCommunityState(
      results: <Community>[],
      status: SearchCommunityStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [results, status, error];

  @override
  String toString() =>
      'SearchCommunityState(results: $results, status: $status, error: $error)';

  SearchCommunityState copyWith({
    List<Community> Function()? results,
    SearchCommunityStatus Function()? status,
    Failure Function()? error,
  }) {
    return SearchCommunityState(
      results: results != null ? results() : this.results,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
