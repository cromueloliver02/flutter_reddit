import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../auth/domain/entities/entities.dart';
import '../repositories/repositories.dart';

class FetchCommunityMembers implements StreamUseCase<List<User>, String> {
  final CommunityRepository _communityRepository;

  const FetchCommunityMembers({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  StreamEither<List<User>> call(String communityId) {
    return _communityRepository.fetchCommunityMembers(communityId);
  }
}
