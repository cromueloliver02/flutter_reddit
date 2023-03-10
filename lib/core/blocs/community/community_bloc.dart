// ignore_for_file: unused_element

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/community/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'community_event.dart';
part 'community_state.dart';

abstract class CommunityBloc {
  void _onCommunityUserGetRequested(
    CommunityUserGetRequested event,
    Emitter<CommunityState> emit,
  );

  void _onCommunityCreated(
    CommunityCreated event,
    Emitter<CommunityState> emit,
  );
}
