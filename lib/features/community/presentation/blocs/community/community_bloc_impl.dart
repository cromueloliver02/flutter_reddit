import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/blocs/blocs.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

class CommunityBlocImpl extends Bloc<CommunityEvent, CommunityState>
    implements CommunityBloc {
  late final StreamSubscription _communitiesStreamSubscription;
  final GetUserCommunities _getUserCommunities;
  final CreateCommunity _createCommunity;

  CommunityBlocImpl({
    required GetUserCommunities getUserCommunities,
    required CreateCommunity createCommunity,
  })  : _getUserCommunities = getUserCommunities,
        _createCommunity = createCommunity,
        super(CommunityState.initial()) {
    on<CommunityUserGetRequested>(_onCommunityUserGetRequested);
    on<CommunityStreamed>(_onCommunityStreamed);
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

        _communitiesStreamSubscription =
            communitiesStream.listen((List<Community> communities) {
          add(CommunityStreamed(communities: communities));
        });
      },
    );
  }

  void _onCommunityStreamed(
    CommunityStreamed event,
    Emitter<CommunityState> emit,
  ) {
    emit(state.copyWith(communities: () => event.communities));
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

  @override
  Future<void> close() {
    _communitiesStreamSubscription.cancel();
    return super.close();
  }
}