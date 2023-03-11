import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class CommunityListBlocImpl extends Bloc<CommunityListEvent, CommunityListState>
    implements CommunityListBloc {
  late final StreamSubscription _communitiesStreamSubscription;
  final GetUserCommunities _getUserCommunities;

  CommunityListBlocImpl({
    required GetUserCommunities getUserCommunities,
  })  : _getUserCommunities = getUserCommunities,
        super(CommunityListState.initial()) {
    on<CommunityListUserGetRequested>(_onCommunityListUserGetRequested);
    on<CommunityListChanged>(_onCommunityListChanged);
  }

  void _onCommunityListUserGetRequested(
    CommunityListUserGetRequested event,
    Emitter<CommunityListState> emit,
  ) async {
    emit(state.copyWith(status: () => CommunityListStatus.loading));

    final Either<Failure, Stream<List<Community>>> eitherCommunityListStream =
        _getUserCommunities(event.userId);

    eitherCommunityListStream.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => CommunityListStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (Stream<List<Community>> communityListStream) async {
        emit(state.copyWith(
          status: () => CommunityListStatus.success,
        ));

        _communitiesStreamSubscription =
            communityListStream.listen((List<Community> communityList) {
          add(CommunityListChanged(communityList: communityList));
        });
      },
    );
  }

  void _onCommunityListChanged(
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
