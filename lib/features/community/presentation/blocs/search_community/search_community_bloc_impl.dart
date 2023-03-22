import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class SearchCommunityBlocImpl extends SearchCommunityBloc {
  final SearchCommunity _searchCommunity;

  SearchCommunityBlocImpl({
    required SearchCommunity searchCommunity,
  })  : _searchCommunity = searchCommunity,
        super(SearchCommunityState.initial()) {
    on<SearchCommunityRequested>(onSearchCommunityRequested);
  }

  @override
  void onSearchCommunityRequested(
    SearchCommunityRequested event,
    Emitter<SearchCommunityState> emit,
  ) async {
    emit(state.copyWith(status: () => SearchCommunityStatus.loading));

    final StreamEither<List<Community>> eitherCommunitiesStream =
        _searchCommunity(event.query);

    await emit.forEach<SyncEither<List<Community>>>(
      eitherCommunitiesStream,
      onData: (SyncEither<List<Community>> eitherCommunities) {
        if (eitherCommunities.isLeft()) {
          late final Failure error;
          eitherCommunities.leftMap((Failure failure) => error = failure);

          debugPrint(error.toString());

          return state.copyWith(
            status: () => SearchCommunityStatus.failure,
            error: () => error,
          );
        }

        final List<Community> results = eitherCommunities.getOrElse(() => []);

        return state.copyWith(
          results: () => results,
          status: () => SearchCommunityStatus.success,
        );
      },
      onError: (error, stackTrace) {
        debugPrint(error.toString());

        return state.copyWith(
          status: () => SearchCommunityStatus.failure,
          error: () => Failure(
            message: kDefaultErrorMsg,
            exception: error,
          ),
        );
      },
    );
  }
}
