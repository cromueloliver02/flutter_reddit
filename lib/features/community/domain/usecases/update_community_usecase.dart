import 'dart:io';

import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class UpdateCommunity implements FutureUseCase<void, UpdateCommunityParams> {
  final CommunityRepository _communityRepository;

  const UpdateCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEitherVoid call(UpdateCommunityParams params) {
    return _communityRepository.updateCommunity(
      community: params.community,
      avatarImageFile: params.avatarImageFile,
      bannerImageFile: params.bannerImageFile,
    );
  }
}

class UpdateCommunityParams {
  final CommunityModel community;
  final File? avatarImageFile;
  final File? bannerImageFile;

  const UpdateCommunityParams({
    required this.community,
    this.avatarImageFile,
    this.bannerImageFile,
  });
}
