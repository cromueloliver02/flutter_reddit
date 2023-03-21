import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  void _signOut(BuildContext ctx) {
    ctx.read<AuthBloc>().add(AuthSignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (prev, curr) => prev.user != curr.user,
              builder: (ctx, state) => Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      state.user?.profilePic ?? kAvatarDefault,
                    ),
                    radius: 70,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'u/${state.user?.name ?? 'Anonymous Guest'}',
                    style: textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Dark Mode'),
              leading: const Icon(Icons.dark_mode),
              trailing: Switch.adaptive(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: Icon(
                Icons.logout,
                color: AppTheme.redColor,
              ),
              onTap: () => _signOut(context),
            ),
            const Spacer(),
            Text(
              'Developed by:',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Cromuel D. Barut',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
