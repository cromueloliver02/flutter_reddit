import '../../../../core/constants/constants.dart';
import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class CreateCommunity implements UseCase<void, CreateCommunityParams> {
  final CommunityRepository _communityRepository;

  const CreateCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEitherVoid call(CreateCommunityParams params) {
    final CommunityModel community = CommunityModel(
      id: params.name, // name of community is the same as the id
      name: params.name,
      banner: kBannerDefault,
      avatar: kAvatarDefault,
      members: <String>[params.userId],
      mods: const <String>[],
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
