import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/widgets/widgets.dart';
import 'create_community_app_bar.dart';

class CreateCommunityView extends StatefulWidget {
  const CreateCommunityView({super.key});

  @override
  State<CreateCommunityView> createState() => _CreateCommunityViewState();
}

class _CreateCommunityViewState extends State<CreateCommunityView> {
  late final TextEditingController _communityNameController;

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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Community Name'),
              ),
              const SizedBox(height: 10),
              RDTTextField(
                controller: _communityNameController,
                hintText: 'r/Community_name',
                maxLength: 21,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _communityNameController = TextEditingController();
  }

  @override
  void dispose() {
    _communityNameController.dispose();
    super.dispose();
  }
}
