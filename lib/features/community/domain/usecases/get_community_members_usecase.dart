import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../auth/domain/entities/entities.dart';
import '../repositories/repositories.dart';

class GetCommunityMembers implements StreamUseCase<List<User>, String> {
  final CommunityRepository _communityRepository;

  const GetCommunityMembers({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  StreamEither<List<User>> call(String communityId) {
    return _communityRepository.getCommunityMembersById(communityId);
  }
}
