import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import 'components/user_details_view.dart';

class UserDetailsPage extends StatefulWidget {
  final String userId;

  const UserDetailsPage({
    super.key,
    required this.userId,
  });

  static const String name = 'user/:userId';
  static const String path = name;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return UserDetailsView(userId: widget.userId);
  }

  @override
  void initState() {
    super.initState();

    context
        .read<UserDetailsBloc>()
        .add(UserDetailsGetRequested(userId: widget.userId));
  }
}
