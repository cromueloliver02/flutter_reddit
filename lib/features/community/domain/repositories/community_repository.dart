import 'dart:io';

import '../../../../core/typedefs.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class CommunityRepository {
  FutureEither<Community?> getCommunity(String communityId);

  StreamEither<List<Community>> fetchUserCommunities(String userId);

  FutureEither<void> createCommunity(CommunityModel community);

  FutureEither<void> updateCommunity({
    required CommunityModel community,
    required File? avatarImageFile,
    required File? bannerImageFile,
  });

  StreamEither<List<Community>> searchCommunity(String query);
}
