import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class CommunityRepository {
  FutureEitherVoid createCommunity(CommunityModel community);
  Either<Failure, Stream<List<Community>>> getUserCommunities(String userId);
}
