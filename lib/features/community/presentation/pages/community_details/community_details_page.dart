import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import 'components/community_details_view.dart';

class CommunityDetailsPage extends StatefulWidget {
  final String communityId;

  const CommunityDetailsPage({
    super.key,
    required this.communityId,
  });

  static const String name = 'community-details';
  static const String path = 'community/:communityId';

  @override
  State<CommunityDetailsPage> createState() => _CommunityDetailsPageState();
}

class _CommunityDetailsPageState extends State<CommunityDetailsPage> {
  @override
  Widget build(BuildContext context) => const CommunityDetailsView();

  @override
  void initState() {
    super.initState();

    context.read<CommunityDetailsCubit>().getCommunity(widget.communityId);
  }
}
