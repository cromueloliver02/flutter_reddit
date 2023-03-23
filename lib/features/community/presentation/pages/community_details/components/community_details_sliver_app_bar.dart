import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../domain/entities/entities.dart';
import '../../../blocs/blocs.dart';

class CommunityDetailsSliverAppBar extends StatelessWidget {
  final Community? community;
  final CommunityDetailsStatus status;

  const CommunityDetailsSliverAppBar({
    super.key,
    required this.community,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      floating: true,
      snap: true,
      flexibleSpace: Builder(
        builder: (ctx) {
          if (status == CommunityDetailsStatus.initial) {
            return const SizedBox.shrink();
          }

          if (status == CommunityDetailsStatus.loading) {
            return const RDTLoaderCard();
          }

          if (status == CommunityDetailsStatus.failure) {
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
                  community?.banner ?? kBannerDefault,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
