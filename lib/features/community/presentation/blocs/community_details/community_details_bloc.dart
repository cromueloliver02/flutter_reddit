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

    await emit.forEach<SyncEither<Community>>(
      eitherCommunity,
      onData: (SyncEither<Community> eitherCommunity) {
        if (eitherCommunity.isLeft()) {
          late final Failure error;
          eitherCommunity.leftMap((Failure failure) => error = failure);

          debugPrint(error.toString());

          return state.copyWith(
            status: () => CommunityDetailsStatus.failure,
            error: () => error,
          );
        }

        final Community community =
            eitherCommunity.getOrElse(() => Community.empty());

        return state.copyWith(
          community: () => community,
          status: () => CommunityDetailsStatus.success,
        );
      },
      onError: (error, stackTrace) {
        debugPrint(error.toString());

        return state.copyWith(
          status: () => CommunityDetailsStatus.failure,
          error: () => Failure(
            message: kDefaultErrorMsg,
            exception: error,
          ),
        );
      },
    );
  }
}
