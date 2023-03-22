import '../../../../core/typedefs.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class SearchCommunity implements StreamUseCase<List<Community>, String> {
  final CommunityRepository _communityRepository;

  const SearchCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  StreamEither<List<Community>> call(String query) {
    return _communityRepository.searchCommunity(query);
  }
}
