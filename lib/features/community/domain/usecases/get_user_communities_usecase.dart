import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetUserCommunities implements StreamUseCase<List<Community>, String> {
  final CommunityRepository _communityRepository;

  const GetUserCommunities({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  StreamEither<List<Community>> call(String userId) {
    return _communityRepository.getCommunitiesByUserId(userId);
  }
}
