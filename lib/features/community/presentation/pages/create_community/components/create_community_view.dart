import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';
import 'create_community_app_bar.dart';

class CreateCommunityView extends StatefulWidget {
  const CreateCommunityView({super.key});

  @override
  State<CreateCommunityView> createState() => _CreateCommunityViewState();
}

class _CreateCommunityViewState extends State<CreateCommunityView> {
  late final TextEditingController _controller;

  void _createCommunity(String name) {
    context.read<CommunityBloc>().add(CommunityCreated(name: name));
  }

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
          child:
              BlocSelector<CommunityBloc, CommunityState, CommunityFormStatus>(
            selector: (state) => state.formStatus,
            builder: (ctx, formStatus) => Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Community Name'),
                ),
                const SizedBox(height: 10),
                RDTTextField(
                  controller: _controller,
                  hintText: 'r/Community_name',
                  enabled: formStatus != CommunityFormStatus.loading,
                  maxLength: 21,
                ),
                const SizedBox(height: 30),
                RDTElevatedButton(
                  title: 'Create Community',
                  isBlock: true,
                  loading: formStatus == CommunityFormStatus.loading,
                  onPressed: () => _createCommunity(_controller.text.trim()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
