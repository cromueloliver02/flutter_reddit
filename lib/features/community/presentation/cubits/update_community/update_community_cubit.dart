import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../data/models/models.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'update_community_state.dart';

class UpdateCommunityCubit extends Cubit<UpdateCommunityState> {
  final UpdateCommunity _updateCommunity;

  UpdateCommunityCubit({
    required UpdateCommunity updateCommunity,
  })  : _updateCommunity = updateCommunity,
        super(UpdateCommunityState.initial());

  void updateCommunity({
    required Community community,
    required File? avatarImageFile,
    required File? bannerImageFile,
  }) async {
    emit(state.copyWith(status: () => UpdateCommunityStatus.loading));

    final SyncEither<void> eitherVoid =
        await _updateCommunity(UpdateCommunityParams(
      community: community as CommunityModel,
      avatarImageFile: avatarImageFile,
      bannerImageFile: bannerImageFile,
    ));

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => UpdateCommunityStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        status: () => UpdateCommunityStatus.success,
      )),
    );
  }
}
