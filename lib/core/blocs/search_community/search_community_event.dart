part of 'search_community_bloc.dart';

abstract class SearchCommunityEvent extends Equatable {
  const SearchCommunityEvent();

  @override
  List<Object> get props => [];
}

class SearchCommunityRequested extends SearchCommunityEvent {
  final String query;

  const SearchCommunityRequested({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
