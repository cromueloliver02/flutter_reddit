import 'package:flutter/material.dart';

import 'components/community_details_view.dart';

class CommunityDetailsPage extends StatelessWidget {
  final String communityId;

  static const String name = 'community-details';
  static const String path = 'community/:communityId';

  const CommunityDetailsPage({
    super.key,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) => const CommunityDetailsView();
}
