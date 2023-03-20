import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/utils.dart';

part 'update_community_form_state.dart';

class UpdateCommunityFormCubit extends Cubit<UpdateCommunityFormState> {
  UpdateCommunityFormCubit() : super(UpdateCommunityFormState.initial());

  void pickAvatarImage() async {
    final XFile? avatarImageFile = await pickImage();

    emit(state.copyWith(avatarImageFile: () => avatarImageFile));
  }

  void pickBannerImage() async {
    final XFile? bannerImageFile = await pickImage();

    emit(state.copyWith(bannerImageFile: () => bannerImageFile));
  }
}
