import '../../../../core/typedefs.dart';
import '../../data/models/models.dart';

abstract class CommunityRepository {
  FutureEitherVoid createCommunity(CommunityModel community);
}
