import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/cubits/cubits.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class SearchCommunityCubitImpl extends SearchCommunityCubit {
  late final StreamSubscription _communitiesStreamSubscription;
  final SearchCommunity _searchCommunity;

  SearchCommunityCubitImpl({
    required SearchCommunity searchCommunity,
  })  : _searchCommunity = searchCommunity,
        super(SearchCommunityState.initial());

  @override
  void searchCommunity(String query) {
    emit(state.copyWith(status: () => SearchCommunityStatus.loading));

    final Either<Failure, Stream<List<Community>>> eitherCommunitiesStream =
        _searchCommunity(query);

    eitherCommunitiesStream.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => SearchCommunityStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (Stream<List<Community>> communitiesStream) async {
        final List<Community> communities = await communitiesStream.first;

        emit(state.copyWith(
          status: () => SearchCommunityStatus.success,
          results: () => communities,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _communitiesStreamSubscription.cancel();
    return super.close();
  }
}
