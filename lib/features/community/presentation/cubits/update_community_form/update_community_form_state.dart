part of 'update_community_form_cubit.dart';

enum PickImageStatus { initial, loading, success, failure }

class UpdateCommunityFormState extends Equatable {
  final XFile? avatarImageFile;
  final XFile? bannerImageFile;
  final PickImageStatus pickImageStatus;
  final Failure error;

  const UpdateCommunityFormState({
    required this.avatarImageFile,
    required this.bannerImageFile,
    required this.pickImageStatus,
    required this.error,
  });

  factory UpdateCommunityFormState.initial() {
    return const UpdateCommunityFormState(
      avatarImageFile: null,
      bannerImageFile: null,
      pickImageStatus: PickImageStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object?> get props =>
      [avatarImageFile, bannerImageFile, pickImageStatus, error];

  @override
  String toString() {
    return 'UpdateCommunityFormState(avatarImageFile: $avatarImageFile, bannerImageFile: $bannerImageFile, pickImageStatus: $pickImageStatus, error: $error)';
  }

  UpdateCommunityFormState copyWith({
    XFile? Function()? avatarImageFile,
    XFile? Function()? bannerImageFile,
    PickImageStatus Function()? pickImageStatus,
    Failure Function()? error,
  }) {
    return UpdateCommunityFormState(
      avatarImageFile:
          avatarImageFile != null ? avatarImageFile() : this.avatarImageFile,
      bannerImageFile:
          bannerImageFile != null ? bannerImageFile() : this.bannerImageFile,
      pickImageStatus:
          pickImageStatus != null ? pickImageStatus() : this.pickImageStatus,
      error: error != null ? error() : this.error,
    );
  }
}
