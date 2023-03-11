import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/community/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'community_list_event.dart';
part 'community_list_state.dart';

abstract class CommunityListBloc
    extends Bloc<CommunityListEvent, CommunityListState> {
  CommunityListBloc(super.initialState);

  void onCommunityListUserGetRequested(
    CommunityListUserFetched event,
    Emitter<CommunityListState> emit,
  );

  void onCommunityListChanged(
    CommunityListChanged event,
    Emitter<CommunityListState> emit,
  );
}
