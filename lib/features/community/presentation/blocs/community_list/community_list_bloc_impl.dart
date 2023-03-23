import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class CommunityListBlocImpl extends CommunityListBloc {
  final FetchUserCommunities _fetchUserCommunities;

  CommunityListBlocImpl({
    required FetchUserCommunities getUserCommunities,
  })  : _fetchUserCommunities = getUserCommunities,
        super(CommunityListState.initial()) {
    on<CommunityListUserFetched>(onCommunityListUserGetRequested);
    on<CommunityListChanged>(onCommunityListChanged);
  }

  @override
  void onCommunityListUserGetRequested(
    CommunityListUserFetched event,
    Emitter<CommunityListState> emit,
  ) async {
    emit(state.copyWith(status: () => CommunityListStatus.loading));

    final StreamEither<List<Community>> eitherCommunitiesStream =
        _fetchUserCommunities(event.userId);

    // a hack to fix the builder skipping the loading status
    await Future.delayed(const Duration(milliseconds: 250));

    await emit.onEach<SyncEither<List<Community>>>(
      eitherCommunitiesStream,
      onData: (SyncEither<List<Community>> eitherCommunities) =>
          eitherCommunities.fold(
        (Failure error) {
          emit(state.copyWith(
            status: () => CommunityListStatus.failure,
            error: () => error,
          ));

          debugPrint(error.toString());
        },
        (List<Community> communityList) => emit(state.copyWith(
          communityList: () => communityList,
          status: () => CommunityListStatus.success,
        )),
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => CommunityListStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }

  @override
  void onCommunityListChanged(
    CommunityListChanged event,
    Emitter<CommunityListState> emit,
  ) {
    emit(state.copyWith(communityList: () => event.communityList));
  }
}
