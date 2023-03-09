import '../../../../core/typedefs.dart';

abstract class CommunityRepository {
  FutureEitherVoid createCommunity(String name);
}
