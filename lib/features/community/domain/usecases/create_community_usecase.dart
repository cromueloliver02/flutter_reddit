import '../../../../core/constants/constants.dart';
import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/models.dart';
import '../repositories/repositories.dart';

class CreateCommunity implements UseCase<void, String> {
  final CommunityRepository _communityRepository;

  const CreateCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEitherVoid call(String name) {
    final CommunityModel community = CommunityModel(
      id: name, // name of community is the same as the id
      name: name,
      banner: kBannerDefault,
      avatar: kAvatarDefault,
      members: const <String>[],
      mods: const <String>[],
    );

    return _communityRepository.createCommunity(community);
  }
}
