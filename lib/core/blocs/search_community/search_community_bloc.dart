import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/community/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'search_community_event.dart';
part 'search_community_state.dart';

abstract class SearchCommunityBloc
    extends Bloc<SearchCommunityEvent, SearchCommunityState> {
  SearchCommunityBloc(super.initialState);

  void onSearchCommunityRequested(
    SearchCommunityRequested event,
    Emitter<SearchCommunityState> emit,
  );
}
