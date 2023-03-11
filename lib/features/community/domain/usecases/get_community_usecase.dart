import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetCommunity implements UseCase<Stream<Community?>, String> {
  final CommunityRepository _communityRepository;

  const GetCommunity({
    required CommunityRepository communityRepository,
  }) : _communityRepository = communityRepository;

  @override
  Either<Failure, Stream<Community?>> call(String communityId) {
    return _communityRepository.getCommunityById(communityId);
  }
}
