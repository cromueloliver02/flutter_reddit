import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../../core/constants/constants.dart';
import 'create_community_app_bar.dart';
import 'create_community_form.dart';

class CreateCommunityView extends StatelessWidget {
  const CreateCommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: kDismissKeyboardGestures,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CreateCommunityAppBar(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: CreateCommunityForm(formKey: GlobalKey<FormState>()),
        ),
      ),
    );
  }
}
