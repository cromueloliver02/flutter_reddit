import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'community_form_state.dart';

class CommunityFormCubit extends Cubit<CommunityFormState> {
  CommunityFormCubit() : super(CommunityFormState.initial());

  void onCommunityNameChanged(String value) {
    emit(state.copyWith(name: () => value));
  }

  String? communityNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter community name';
    }

    if (value.length <= 6) {
      return 'Community name must be at least 6 characters long';
    }

    return null;
  }

  void toggleAutovalidateMode() {
    emit(state.copyWith(autovalidateMode: () => AutovalidateMode.always));
  }
}
