import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../auth/domain/entities/entities.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<AuthBloc>().state.user!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(user.profilePic)),
          ],
        ),
      ),
    );
  }
}
