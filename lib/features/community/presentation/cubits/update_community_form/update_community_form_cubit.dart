import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/errors/failures/failures.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';

part 'update_community_form_state.dart';

class UpdateCommunityFormCubit extends Cubit<UpdateCommunityFormState> {
  final PickImage _pickImage;

  UpdateCommunityFormCubit({
    required PickImage pickImage,
  })  : _pickImage = pickImage,
        super(UpdateCommunityFormState.initial());

  void pickAvatarImage() async {
    final Either<Failure, XFile?> eitherAvatarImageFile =
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
    final Either<Failure, XFile?> eitherBannerImageFile =
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
