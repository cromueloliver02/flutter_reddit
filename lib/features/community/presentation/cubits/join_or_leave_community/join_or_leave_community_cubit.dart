import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'join_or_leave_community_state.dart';

class JoinOrLeaveCommunityCubit extends Cubit<JoinOrLeaveCommunityState> {
  final JoinOrLeaveCommunity _joinOrLeaveCommunity;

  JoinOrLeaveCommunityCubit({
    required JoinOrLeaveCommunity joinOrLeaveCommunity,
  })  : _joinOrLeaveCommunity = joinOrLeaveCommunity,
        super(JoinOrLeaveCommunityState.initial());

  void joinOrLeaveCommunity({
    required Community community,
    required String userId,
  }) async {
    emit(state.copyWith(status: () => JoinOrLeaveCommunityStatus.loading));

    final SyncEither<void> eitherVoid = await _joinOrLeaveCommunity(
      JoinOrLeaveCommunityParams(
        community: community,
        userId: userId,
      ),
    );

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => JoinOrLeaveCommunityStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        status: () => JoinOrLeaveCommunityStatus.success,
      )),
    );
  }
}
