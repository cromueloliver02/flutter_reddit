import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/repositories.dart';

class CreateCommunity implements UseCase<void, String> {
  final CommunityRepository _communityRepository;

  const CreateCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  FutureEitherVoid call(String name) {
    return _communityRepository.createCommunity(name);
  }
}
