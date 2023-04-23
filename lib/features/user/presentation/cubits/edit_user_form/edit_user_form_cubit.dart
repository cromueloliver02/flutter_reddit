import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/typedefs.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../../community/domain/usecases/usecases.dart';

part 'edit_user_form_state.dart';

class EditUserFormCubit extends Cubit<EditUserFormState> {
  final PickImage _pickImage;

  EditUserFormCubit({
    required PickImage pickImage,
  })  : _pickImage = pickImage,
        super(EditUserFormState.initial());

  void pickAvatarImage() async {
    emit(state.copyWith(pickImageStatus: () => PickImageStatus.loading));

    final SyncEither<XFile?> eitherAvatarImageFile =
        await _pickImage(NoParams());

    eitherAvatarImageFile.fold(
      (Failure error) {
        emit(state.copyWith(
          pickImageStatus: () => PickImageStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (XFile? avatarImageFile) => emit(state.copyWith(
        pickImageStatus: () => PickImageStatus.success,
        avatarImageFile: () => avatarImageFile,
      )),
    );
  }

  void pickBannerImage() async {
    emit(state.copyWith(pickImageStatus: () => PickImageStatus.loading));

    final SyncEither<XFile?> eitherBannerImageFile =
        await _pickImage(NoParams());

    eitherBannerImageFile.fold(
      (Failure error) {
        emit(state.copyWith(
          pickImageStatus: () => PickImageStatus.failure,
          error: () => error,
        ));

        debugPrint(error.toString());
      },
      (XFile? bannerImageFile) => emit(state.copyWith(
        pickImageStatus: () => PickImageStatus.success,
        bannerImageFile: () => bannerImageFile,
      )),
    );
  }
}
