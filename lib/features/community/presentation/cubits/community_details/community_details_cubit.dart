import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_details_state.dart';

class CommunityDetailsCubit extends Cubit<CommunityDetailsState> {
  final GetCommunity _getCommunity;

  CommunityDetailsCubit({
    required GetCommunity getCommunity,
  })  : _getCommunity = getCommunity,
        super(CommunityDetailsState.initial());

  void getCommunity(String communityId) async {
    emit(state.copyWith(status: () => CommunityDetailsStatus.loading));

    final SyncEither<Community?> eitherCommunity =
        await _getCommunity(communityId);

    eitherCommunity.fold(
      (Failure error) {
        emit(state.copyWith(
          error: () => error,
          status: () => CommunityDetailsStatus.failure,
        ));

        debugPrint(error.toString());
      },
      (Community? community) => emit(state.copyWith(
        community: () => community,
        status: () => CommunityDetailsStatus.success,
      )),
    );
  }
}
