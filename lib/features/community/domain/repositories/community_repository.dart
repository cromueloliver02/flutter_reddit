import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class CommunityRepository {
  Either<Failure, Stream<Community?>> getCommunityById(String communityId);
  Either<Failure, Stream<List<Community>>> fetchUserCommunities(String userId);
  FutureEitherVoid createCommunity(CommunityModel community);
}
