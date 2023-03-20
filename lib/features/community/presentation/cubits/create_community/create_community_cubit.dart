import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/usecases/usecases.dart';

part 'create_community_state.dart';

class CreateCommunityCubit extends Cubit<CreateCommunityState> {
  final CreateCommunity _createCommunity;

  CreateCommunityCubit({
    required CreateCommunity createCommunity,
  })  : _createCommunity = createCommunity,
        super(CreateCommunityState.initial());

  void createCommunity({
    required String userId,
    required String name,
  }) async {
    emit(state.copyWith(status: () => CreateCommunityStatus.loading));

    final Either<Failure, void> eitherVoid = await _createCommunity(
      CreateCommunityParams(
        userId: userId,
        name: name,
      ),
    );

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          status: () => CreateCommunityStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        status: () => CreateCommunityStatus.success,
      )),
    );
  }
}
