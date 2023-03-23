import 'dart:io';

import '../../../../core/typedefs.dart';
import '../../../auth/domain/entities/entities.dart';
import '../../data/models/models.dart';
import '../entities/entities.dart';

abstract class CommunityRepository {
  StreamEither<Community> getCommunityById(String communityId);

  StreamEither<List<Community>> getCommunitiesByUserId(String userId);

  StreamEither<List<User>> getCommunityMembersById(String communityId);

  FutureEither<void> createCommunity(CommunityModel community);

  FutureEither<void> updateCommunity({
    required CommunityModel community,
    required File? avatarImageFile,
    required File? bannerImageFile,
  });

  StreamEither<List<Community>> searchCommunity(String query);

  FutureEither<void> joinCommunity({
    required String communityId,
    required String userId,
  });

  FutureEither<void> leaveCommunity({
    required String communityId,
    required String userId,
  });

  FutureEither<void> saveModerators({
    required String communityId,
    required List<String> moderatorIds,
  });
}
