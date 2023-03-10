import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/widgets.dart';
import '../../../blocs/blocs.dart';
import '../../../cubits/cubits.dart';

class CreateCommunityForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const CreateCommunityForm({
    super.key,
    required this.formKey,
  });

  void _createCommunity(
    BuildContext ctx, {
    required GlobalKey<FormState> formKey,
  }) {
    final CommunityFormCubit communityFormCubit =
        ctx.read<CommunityFormCubit>();

    communityFormCubit.toggleAutovalidateMode();

    final FormState? formState = formKey.currentState;

    if (formState != null && formState.validate()) {
      final String name = communityFormCubit.state.name;

      ctx.read<CommunityBloc>().add(CommunityCreated(name: name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CommunityBloc, CommunityState, CommunityFormStatus>(
      selector: (state) => state.formStatus,
      builder: (ctx, formStatus) =>
          BlocBuilder<CommunityFormCubit, CommunityFormState>(
        builder: (ctx, state) => Form(
          key: formKey,
          autovalidateMode: state.autovalidateMode,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Community Name'),
              ),
              const SizedBox(height: 10),
              RDTTextFormField(
                hintText: 'r/Community_name',
                enabled: formStatus != CommunityFormStatus.loading,
                maxLength: 21,
                validator:
                    context.read<CommunityFormCubit>().communityNameValidator,
                onChanged:
                    context.read<CommunityFormCubit>().onCommunityNameChanged,
              ),
              const SizedBox(height: 30),
              RDTElevatedButton(
                title: 'Create Community',
                isBlock: true,
                loading: formStatus == CommunityFormStatus.loading,
                onPressed: () => _createCommunity(context, formKey: formKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}