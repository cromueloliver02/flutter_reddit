import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';
import '../../pages.dart';

class UserDetailsSliverHeader extends StatelessWidget {
  final String userId;
  final UserDetailsState state;

  const UserDetailsSliverHeader({
    super.key,
    required this.userId,
    required this.state,
  });

  void _goToEditUserPage(BuildContext ctx, {required String userId}) {
    ctx.goNamed(
      EditUserPage.name,
      params: {'userId': userId},
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'u/${state.user!.name}',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              RDTOutlinedButton(
                title: 'Edit Profile',
                onPressed: () => _goToEditUserPage(context, userId: userId),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text('${state.user!.karma} karma'),
          const SizedBox(height: 10),
          const Divider(thickness: 2),
        ]),
      ),
    );
  }
}
