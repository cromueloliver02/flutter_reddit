import 'package:flutter/material.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../domain/entities/entities.dart';

class CommunityDetailsSliverAppBar extends StatelessWidget {
  final Community? community;

  const CommunityDetailsSliverAppBar({
    super.key,
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      floating: true,
      snap: true,
      flexibleSpace: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              community?.banner ?? kNotFoundDefault,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
