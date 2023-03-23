import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_details_event.dart';
part 'community_details_state.dart';

class CommunityDetailsBloc
    extends Bloc<CommunityDetailsEvent, CommunityDetailsState> {
  final GetCommunity _getCommunity;

  CommunityDetailsBloc({
    required GetCommunity getCommunity,
  })  : _getCommunity = getCommunity,
        super(CommunityDetailsState.initial()) {
    on<CommunityDetailsGetRequested>(onCommunityDetailsGetRequested);
  }

  void onCommunityDetailsGetRequested(
    CommunityDetailsGetRequested event,
    Emitter<CommunityDetailsState> emit,
  ) async {
    emit(state.copyWith(status: () => CommunityDetailsStatus.loading));

    final StreamEither<Community> eitherCommunity =
        _getCommunity(event.communityId);

    // a hack to fix the builder skipping the loading status
    await Future.delayed(const Duration(milliseconds: 250));

    await emit.onEach<SyncEither<Community>>(
      eitherCommunity,
      onData: (SyncEither<Community> eitherCommunity) => eitherCommunity.fold(
        (Failure error) {
          emit(state.copyWith(
            status: () => CommunityDetailsStatus.failure,
            error: () => error,
          ));

          debugPrint(error.toString());
        },
        (Community community) => emit(state.copyWith(
          community: () => community,
          status: () => CommunityDetailsStatus.success,
        )),
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => CommunityDetailsStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }
}
