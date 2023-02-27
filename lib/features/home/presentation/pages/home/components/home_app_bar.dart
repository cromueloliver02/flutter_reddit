import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../auth/presentation/blocs/blocs.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          icon: BlocBuilder<AuthBlocImpl, AuthState>(
            builder: (ctx, state) => CircleAvatar(
              backgroundImage: NetworkImage(state.user!.profilePic),
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
