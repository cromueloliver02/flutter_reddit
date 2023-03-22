import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class CommunityRepository {
  Future<Either<Failure, Community?>> getCommunity(String communityId);

  Stream<Either<Failure, List<Community>>> fetchUserCommunities(String userId);

  FutureEitherVoid createCommunity(CommunityModel community);

  FutureEitherVoid updateCommunity({
    required CommunityModel community,
    required File? avatarImageFile,
    required File? bannerImageFile,
  });

  Stream<Either<Failure, List<Community>>> searchCommunity(String query);
}
