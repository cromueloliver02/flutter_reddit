import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/constants/constants.dart';
import '../delegates/search_community_delegate.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void _openDrawer(BuildContext ctx) => Scaffold.of(ctx).openDrawer();

  void _openEndDrawer(BuildContext ctx) => Scaffold.of(ctx).openEndDrawer();

  void _showSearch(BuildContext ctx) {
    final SearchCommunityBloc searchCommunityBloc =
        ctx.read<SearchCommunityBloc>();

    showSearch(
      context: ctx,
      delegate: SearchCommunityDelegate(
        searchCommunityBloc: searchCommunityBloc,
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
              backgroundImage: NetworkImage(
                state.user?.profilePic ?? kAvatarDefault,
              ),
            ),
          ),
          onPressed: () => _openEndDrawer(context),
        ),
      ],
    );
  }
}
