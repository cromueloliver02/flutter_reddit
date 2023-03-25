import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/entities/entities.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_members_event.dart';
part 'community_members_state.dart';

class CommunityMembersBloc
    extends Bloc<CommunityMembersEvent, CommunityMembersState> {
  final GetCommunityMembers _getCommunityMembers;

  CommunityMembersBloc({
    required GetCommunityMembers getCommunityMembers,
  })  : _getCommunityMembers = getCommunityMembers,
        super(CommunityMembersState.initial()) {
    on<CommunityMembersFetched>(_onFetchCommunityMembers);
  }

  void _onFetchCommunityMembers(
    CommunityMembersFetched event,
    Emitter<CommunityMembersState> emit,
  ) async {
    emit(state.copyWith(status: () => CommunityMembersStatus.loading));

    final StreamEither<List<User>> eitherUsersStream =
        _getCommunityMembers(event.communityId);

    // a hack to fix the builder skipping the loading status
    await Future.delayed(const Duration(milliseconds: 250));

    await emit.onEach<SyncEither<List<User>>>(
      eitherUsersStream,
      onData: (SyncEither<List<User>> eitherUsers) => eitherUsers.fold(
        (Failure error) => emit(state.copyWith(
          status: () => CommunityMembersStatus.failure,
          error: () => error,
        )),
        (List<User> users) => emit(state.copyWith(
          communityMembers: () => users,
          status: () => CommunityMembersStatus.success,
        )),
      ),
      onError: (Object error, StackTrace stackTrace) {
        emit(state.copyWith(
          status: () => CommunityMembersStatus.failure,
          error: () => Failure(message: kDefaultErrorMsg, exception: error),
        ));

        debugPrint(error.toString());
      },
    );
  }
}
