import 'package:flutter/material.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';

class UserDetailsPostList extends StatelessWidget {
  final UserDetailsState state;

  const UserDetailsPostList({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      if (state.status == UserDetailsStatus.initial) {
        return const SizedBox.shrink();
      }

      if (state.status == UserDetailsStatus.loading) {
        return const RDTLoaderCard();
      }

      if (state.status == UserDetailsStatus.failure) {
        return RDTErrorCard(message: state.error.message);
      }

      if (state.user == null) {
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
