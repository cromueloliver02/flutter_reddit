import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../community/domain/entities/entities.dart';
import '../../../../../community/presentation/pages/pages.dart';

class CommunityListDrawer extends StatelessWidget {
  const CommunityListDrawer({super.key});

  void _goToCreateCommunityPage(BuildContext ctx) {
    Navigator.pop(ctx);
    ctx.pushNamed(CreateCommunityPage.name);
  }

  void _goToCommunityPage(
    BuildContext ctx, {
    required String communityId,
  }) {
    ctx.goNamed(
      CommunityDetailsPage.name,
      params: {'communityId': communityId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a community'),
              leading: const Icon(Icons.add),
              onTap: () => _goToCreateCommunityPage(context),
            ),
            Expanded(
              child: BlocBuilder<CommunityListBloc, CommunityListState>(
                builder: (ctx, state) {
                  final List<Community> communityList = state.communityList;

                  return ListView.builder(
                    itemCount: communityList.length,
                    itemBuilder: (ctx, idx) {
                      final Community community = communityList[idx];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(community.avatar),
                        ),
                        title: Text('r/${community.name}'),
                        onTap: () => _goToCommunityPage(
                          context,
                          communityId: community.id,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
