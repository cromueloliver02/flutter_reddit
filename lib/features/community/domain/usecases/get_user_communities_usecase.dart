import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetUserCommunities {
  final CommunityRepository _communityRepository;

  const GetUserCommunities({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  Either<Failure, Stream<List<Community>>> call(String userId) {
    return _communityRepository.getUserCommunities(userId);
  }
}
