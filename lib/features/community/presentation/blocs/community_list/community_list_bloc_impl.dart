import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class CommunityListBlocImpl extends CommunityListBloc {
  late final StreamSubscription _communitiesStreamSubscription;
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

    final Either<Failure, Stream<List<Community>>> eitherCommunitiesStream =
        _fetchUserCommunities(event.userId);

    eitherCommunitiesStream.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => CommunityListStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (Stream<List<Community>> communitiesStream) async {
        emit(state.copyWith(
          status: () => CommunityListStatus.success,
        ));

        _communitiesStreamSubscription =
            communitiesStream.listen((List<Community> communityList) {
          add(CommunityListChanged(communityList: communityList));
        });
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

  @override
  Future<void> close() {
    _communitiesStreamSubscription.cancel();
    return super.close();
  }
}
