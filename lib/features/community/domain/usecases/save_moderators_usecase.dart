import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/repositories.dart';

class SaveModerators implements FutureUseCase<void, SaveModeratorsParams> {
  final CommunityRepository _communityRepository;

  const SaveModerators({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEither<void> call(SaveModeratorsParams params) {
    return _communityRepository.saveModerators(
      communityId: params.communityId,
      moderatorIds: params.moderatorIds,
    );
  }
}

class SaveModeratorsParams {
  final String communityId;
  final List<String> moderatorIds;

  const SaveModeratorsParams({
    required this.communityId,
    required this.moderatorIds,
  });
}
