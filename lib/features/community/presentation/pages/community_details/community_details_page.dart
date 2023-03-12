import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/utils.dart';
import '../../cubits/cubits.dart';
import 'components/community_details_view.dart';

class CommunityDetailsPage extends StatelessWidget {
  final String communityId;

  static const String name = 'community-details';
  static const String path = 'community/:communityId';

  const CommunityDetailsPage({
    super.key,
    required this.communityId,
  });

  void _communityDetailsListener(
    BuildContext ctx,
    CommunityDetailsState state,
  ) {
    if (state.status == CommunityDetailsStatus.failure) {
      showErrorDialog(ctx, message: state.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityDetailsCubit, CommunityDetailsState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: _communityDetailsListener,
      child: CommunityDetailsView(communityId: communityId),
    );
  }
}
