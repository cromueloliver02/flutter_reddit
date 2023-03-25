import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/entities/entities.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';

class UserDetailsSliverAppBar extends StatelessWidget {
  final User? user;
  final UserDetailsStatus status;

  const UserDetailsSliverAppBar({
    super.key,
    required this.user,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      floating: true,
      snap: true,
      flexibleSpace: Builder(
        builder: (ctx) {
          if (status == UserDetailsStatus.initial) {
            return const SizedBox.shrink();
          }

          if (status == UserDetailsStatus.loading) {
            return const RDTLoaderCard();
          }

          if (status == UserDetailsStatus.failure) {
            return Center(
              child: Icon(
                Icons.error,
                size: 50,
                color: AppTheme.redColor,
              ),
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  user?.banner ?? kBannerDefault,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.profilePic),
                  radius: 35,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
