import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/cubits.dart';

class CommunityDetailsView extends StatefulWidget {
  final String communityId;

  const CommunityDetailsView({
    super.key,
    required this.communityId,
  });
  @override
  State<CommunityDetailsView> createState() => _CommunityDetailsViewState();
}

class _CommunityDetailsViewState extends State<CommunityDetailsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('COMMUNITY DETAILS PAGE'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    context.read<CommunityDetailsCubit>().getCommunity(widget.communityId);
  }
}
