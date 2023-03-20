part of 'update_community_form_cubit.dart';

class UpdateCommunityFormState extends Equatable {
  final XFile? avatarImageFile;
  final XFile? bannerImageFile;

  const UpdateCommunityFormState({
    required this.avatarImageFile,
    required this.bannerImageFile,
  });

  factory UpdateCommunityFormState.initial() {
    return const UpdateCommunityFormState(
      avatarImageFile: null,
      bannerImageFile: null,
    );
  }

  @override
  List<Object?> get props => [avatarImageFile, bannerImageFile];

  @override
  String toString() =>
      'UpdateCommunityFormState(avatarImageFile: $avatarImageFile, bannerImageFile: $bannerImageFile)';

  UpdateCommunityFormState copyWith({
    XFile? Function()? avatarImageFile,
    XFile? Function()? bannerImageFile,
  }) {
    return UpdateCommunityFormState(
      avatarImageFile:
          avatarImageFile != null ? avatarImageFile() : this.avatarImageFile,
      bannerImageFile:
          bannerImageFile != null ? bannerImageFile() : this.bannerImageFile,
    );
  }
}
