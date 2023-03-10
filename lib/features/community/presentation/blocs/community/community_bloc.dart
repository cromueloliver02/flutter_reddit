import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  final GetUserCommunities _getUserCommunities;
  final CreateCommunity _createCommunity;

  CommunityBloc({
    required GetUserCommunities getUserCommunities,
    required CreateCommunity createCommunity,
  })  : _getUserCommunities = getUserCommunities,
        _createCommunity = createCommunity,
        super(CommunityState.initial()) {
    on<CommunityUserGetRequested>(_onCommunityUserGetRequested);
    on<CommunityCreated>(_onCommunityCreated);
  }

  void _onCommunityUserGetRequested(
    CommunityUserGetRequested event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(loadStatus: () => CommunityLoadStatus.loading));

    final Either<Failure, Stream<List<Community>>> eitherCommunitiesStream =
        _getUserCommunities(event.userId);

    eitherCommunitiesStream.fold(
      (Failure error) {
        emit(state.copyWith(
          loadStatus: () => CommunityLoadStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (Stream<List<Community>> communitiesStream) async {
        emit(state.copyWith(
          loadStatus: () => CommunityLoadStatus.success,
        ));

        await emit.forEach<List<Community>>(
          communitiesStream,
          onData: (List<Community> communities) {
            return state.copyWith(communities: () => communities);
          },
        );
      },
    );
  }

  void _onCommunityCreated(
    CommunityCreated event,
    Emitter<CommunityState> emit,
  ) async {
    emit(state.copyWith(formStatus: () => CommunityFormStatus.loading));

    final Either<Failure, void> eitherVoid = await _createCommunity(
      CreateCommunityParams(
        userId: event.userId,
        name: event.name,
      ),
    );

    eitherVoid.fold(
      (Failure error) {
        emit(state.copyWith(
          formStatus: () => CommunityFormStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (_) => emit(state.copyWith(
        formStatus: () => CommunityFormStatus.success,
      )),
    );
  }
}
