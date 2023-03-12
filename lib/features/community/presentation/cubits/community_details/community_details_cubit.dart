import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_details_state.dart';

class CommunityDetailsCubit extends Cubit<CommunityDetailsState> {
  late final StreamSubscription _communitySubscription;
  final GetCommunity _getCommunity;

  CommunityDetailsCubit({
    required GetCommunity getCommunity,
  })  : _getCommunity = getCommunity,
        super(CommunityDetailsState.initial());

  void getCommunity(String communityId) {
    emit(state.copyWith(status: () => CommunityDetailsStatus.loading));

    final Either<Failure, Stream<Community?>> eitherCommunity =
        _getCommunity(communityId);

    eitherCommunity.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => CommunityDetailsStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (Stream<Community?> communityStream) async {
        emit(state.copyWith(status: () => CommunityDetailsStatus.success));

        _communitySubscription = communityStream.listen((Community? community) {
          emit(state.copyWith(community: () => community));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _communitySubscription.cancel();
    return super.close();
  }
}
