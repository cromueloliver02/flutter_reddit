import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import 'community_details_post_list.dart';
import 'community_details_sliver_app_bar.dart';
import 'community_details_sliver_header.dart';

class CommunityDetailsView extends StatelessWidget {
  const CommunityDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CommunityDetailsBloc, CommunityDetailsState>(
        builder: (ctx, state) => NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
            CommunityDetailsSliverAppBar(community: state.community),
            if (state.community == null)
              const SliverToBoxAdapter(child: SizedBox.shrink()),
            if (state.community != null)
              CommunityDetailsSliverHeader(state: state),
          ],
          body: CommunityDetailsPostList(state: state),
        ),
      ),
    );
  }
}
