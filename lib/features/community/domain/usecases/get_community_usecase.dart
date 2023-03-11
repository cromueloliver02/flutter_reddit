import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetCommunity {
  final CommunityRepository _communityRepository;

  const GetCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  Either<Failure, Stream<Community?>> call(String communityId) {
    return _communityRepository.getCommunityById(communityId);
  }
}
