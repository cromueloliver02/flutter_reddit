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

    final StreamEither<List<Community>> eitherResultsStream =
        _searchCommunity(event.query);

    await emit.onEach<SyncEither<List<Community>>>(
      eitherResultsStream,
      onData: (SyncEither<List<Community>> eitherResults) => eitherResults.fold(
        (Failure error) {
          emit(state.copyWith(
            status: () => SearchCommunityStatus.failure,
            error: () => error,
          ));

          debugPrint(error.toString());
        },
        (List<Community> results) => emit(state.copyWith(
          results: () => results,
          status: () => SearchCommunityStatus.success,
        )),
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => SearchCommunityStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }
}
