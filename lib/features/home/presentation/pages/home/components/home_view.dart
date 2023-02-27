import 'package:flutter/material.dart';

import 'community_list_drawer.dart';
import 'home_app_bar.dart';

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
      body: Center(
        child: Text('REDDIT CLONE APP'),
      ),
    );
  }
}
