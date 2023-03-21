import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/community/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'search_community_state.dart';

abstract class SearchCommunityCubit extends Cubit<SearchCommunityState> {
  SearchCommunityCubit(super.initialState);

  void searchCommunity(String query);
}
