part of 'edit_community_form_cubit.dart';

class EditCommunityFormState extends Equatable {
  final XFile? avatarImageFile;
  final XFile? bannerImageFile;

  const EditCommunityFormState({
    required this.avatarImageFile,
    required this.bannerImageFile,
  });

  factory EditCommunityFormState.initial() {
    return const EditCommunityFormState(
      avatarImageFile: null,
      bannerImageFile: null,
    );
  }

  @override
  List<Object?> get props => [avatarImageFile, bannerImageFile];

  @override
  String toString() =>
      'EditCommunityFormState(avatarImageFile: $avatarImageFile, bannerImageFile: $bannerImageFile)';

  EditCommunityFormState copyWith({
    XFile? Function()? avatarImageFile,
    XFile? Function()? bannerImageFile,
  }) {
    return EditCommunityFormState(
      avatarImageFile:
          avatarImageFile != null ? avatarImageFile() : this.avatarImageFile,
      bannerImageFile:
          bannerImageFile != null ? bannerImageFile() : this.bannerImageFile,
    );
  }
}
