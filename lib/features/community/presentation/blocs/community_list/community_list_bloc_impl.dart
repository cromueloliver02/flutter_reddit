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

    await emit.forEach<SyncEither<List<Community>>>(
      eitherCommunitiesStream,
      onData: (SyncEither<List<Community>> eitherCommunities) {
        if (eitherCommunities.isLeft()) {
          late final Failure error;
          eitherCommunities.leftMap((Failure failure) => error = failure);

          debugPrint(error.toString());

          return state.copyWith(
            status: () => CommunityListStatus.failure,
            error: () => error,
          );
        }

        final List<Community> communityList =
            eitherCommunities.getOrElse(() => []);

        return state.copyWith(
          communityList: () => communityList,
          status: () => CommunityListStatus.success,
        );
      },
      onError: (error, stackTrace) {
        debugPrint(error.toString());

        return state.copyWith(
          status: () => CommunityListStatus.failure,
          error: () => Failure(
            message: kDefaultErrorMsg,
            exception: error,
          ),
        );
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
