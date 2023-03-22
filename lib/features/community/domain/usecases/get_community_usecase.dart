import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetCommunity implements FutureUseCase<Community?, String> {
  final CommunityRepository _communityRepository;

  const GetCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEither<Community?> call(String communityId) {
    return _communityRepository.getCommunity(communityId);
  }
}
