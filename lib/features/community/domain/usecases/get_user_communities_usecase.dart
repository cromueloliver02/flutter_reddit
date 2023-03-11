import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchUserCommunities {
  final CommunityRepository _communityRepository;

  const FetchUserCommunities({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  Either<Failure, Stream<List<Community>>> call(String userId) {
    return _communityRepository.fetchUserCommunities(userId);
  }
}
