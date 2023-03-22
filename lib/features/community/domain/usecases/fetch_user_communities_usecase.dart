import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class FetchUserCommunities implements StreamUseCase<List<Community>, String> {
  final CommunityRepository _communityRepository;

  const FetchUserCommunities({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  Stream<Either<Failure, List<Community>>> call(String userId) {
    return _communityRepository.fetchUserCommunities(userId);
  }
}
