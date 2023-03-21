import 'package:flutter/material.dart';

import 'community_list_drawer.dart';
import 'home_app_bar.dart';
import 'profile_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: HomeAppBar(),
      ),
      drawer: CommunityListDrawer(),
      endDrawer: ProfileDrawer(),
      body: Center(
        child: Text('REDDIT CLONE APP'),
      ),
    );
  }
}
