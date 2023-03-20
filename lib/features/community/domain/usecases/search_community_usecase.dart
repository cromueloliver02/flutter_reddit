import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class SearchCommunity implements UseCase<Stream<List<Community>>, String> {
  final CommunityRepository _communityRepository;

  const SearchCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  Either<Failure, Stream<List<Community>>> call(String query) {
    return _communityRepository.searchCommunity(query);
  }
}
