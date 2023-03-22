import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class JoinOrLeaveCommunity
    implements FutureUseCase<void, JoinOrLeaveCommunityParams> {
  final CommunityRepository _communityRepository;

  const JoinOrLeaveCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEither<void> call(JoinOrLeaveCommunityParams params) {
    if (params.community.members.contains(params.userId)) {
      return _communityRepository.leaveCommunity(
        communityId: params.community.id,
        userId: params.userId,
      );
    } else {
      return _communityRepository.joinCommunity(
        communityId: params.community.id,
        userId: params.userId,
      );
    }
  }
}

class JoinOrLeaveCommunityParams {
  final Community community;
  final String userId;

  const JoinOrLeaveCommunityParams({
    required this.community,
    required this.userId,
  });
}
