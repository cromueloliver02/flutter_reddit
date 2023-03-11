// ignore_for_file: unused_element

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/community/domain/entities/entities.dart';
import '../../errors/failures/failures.dart';

part 'community_list_event.dart';
part 'community_list_state.dart';

abstract class CommunityListBloc {
  void _onCommunityListUserGetRequested(
    CommunityListUserGetRequested event,
    Emitter<CommunityListState> emit,
  );
}
