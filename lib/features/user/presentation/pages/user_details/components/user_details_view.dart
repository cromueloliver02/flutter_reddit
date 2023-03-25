import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/blocs.dart';
import 'user_details_post_list.dart';
import 'user_details_sliver_app_bar.dart';
import 'user_details_sliver_header.dart';

class UserDetailsView extends StatelessWidget {
  final String userId;

  const UserDetailsView({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
        builder: (ctx, state) => NestedScrollView(
          headerSliverBuilder: (ctx, innerBoxIsScrolled) => [
            UserDetailsSliverAppBar(
              user: state.user,
              status: state.status,
            ),
            if (state.status == UserDetailsStatus.success)
              UserDetailsSliverHeader(state: state),
          ],
          body: UserDetailsPostList(state: state),
        ),
      ),
    );
  }
}
