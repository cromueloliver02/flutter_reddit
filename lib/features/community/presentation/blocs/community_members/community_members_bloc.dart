import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../../auth/domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

part 'community_members_event.dart';
part 'community_members_state.dart';

class CommunityMembersBloc
    extends Bloc<CommunityMembersEvent, CommunityMembersState> {
  final FetchCommunityMembers _fetchCommunityMembers;

  CommunityMembersBloc({
    required FetchCommunityMembers fetchCommunityMembers,
  })  : _fetchCommunityMembers = fetchCommunityMembers,
        super(CommunityMembersState.initial()) {
    on<CommunityMembersFetched>(_onFetchCommunityMembers);
  }

  void _onFetchCommunityMembers(
    CommunityMembersFetched event,
    Emitter<CommunityMembersState> emit,
  ) async {
    emit(state.copyWith(status: () => CommunityMembersStatus.loading));

    final StreamEither<List<User>> eitherUsersStream =
        _fetchCommunityMembers(event.communityId);

    await Future.delayed(const Duration(milliseconds: 500));

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
