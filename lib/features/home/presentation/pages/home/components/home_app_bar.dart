import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/cubits/cubits.dart';
import '../delegates/search_community_delegate.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void _openDrawer(BuildContext ctx) => Scaffold.of(ctx).openDrawer();

  void _openEndDrawer(BuildContext ctx) => Scaffold.of(ctx).openEndDrawer();

  void _showSearch(BuildContext ctx) {
    final SearchCommunityCubit searchCommunityCubit =
        ctx.read<SearchCommunityCubit>();

    showSearch(
      context: ctx,
      delegate: SearchCommunityDelegate(
        searchCommunityCubit: searchCommunityCubit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => _openDrawer(context),
      ),
      actions: [
        IconButton(
          onPressed: () => _showSearch(context),
          icon: const Icon(Icons.search),
        ),
        IconButton(
          icon: BlocBuilder<AuthBloc, AuthState>(
            builder: (ctx, state) => CircleAvatar(
              backgroundImage: NetworkImage(state.user!.profilePic),
            ),
          ),
          onPressed: () => _openEndDrawer(context),
        ),
      ],
    );
  }
}
