import '../../../../core/constants/constants.dart';
import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class CreateCommunity implements FutureUseCase<void, CreateCommunityParams> {
  final CommunityRepository _communityRepository;

  const CreateCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEither<void> call(CreateCommunityParams params) {
    final String name = params.name.replaceAll(' ', '');

    final CommunityModel community = CommunityModel(
      id: name, // name of community is the same as the id
      name: name,
      banner: kBannerDefault,
      avatar: kAvatarDefault,
      members: <String>[params.userId],
      mods: <String>[params.userId],
    );

    return _communityRepository.createCommunity(community);
  }
}

class CreateCommunityParams {
  final String userId;
  final String name;

  const CreateCommunityParams({
    required this.userId,
    required this.name,
  });
}
