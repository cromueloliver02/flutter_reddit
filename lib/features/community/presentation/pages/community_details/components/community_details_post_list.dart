import 'package:flutter/material.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../cubits/cubits.dart';

class CommunityDetailsPostList extends StatelessWidget {
  final CommunityDetailsState state;

  const CommunityDetailsPostList({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      if (state.status == CommunityDetailsStatus.initial) {
        return const SizedBox.shrink();
      }

      if (state.status == CommunityDetailsStatus.loading) {
        return const RDTLoaderCard();
      }

      if (state.status == CommunityDetailsStatus.failure) {
        return RDTErrorCard(message: state.error.message);
      }

      if (state.community == null) {
        return const RDTNotFoundCard(
          message:
              'Community not found, either the community is hidden or has been deleted.',
        );
      }

      return const Center(
        child: Text('DISPLAY POSTS'),
      );
    });
  }
}
