import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/widgets/widgets.dart';
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
    final AuthBloc authBloc = ctx.read<AuthBloc>();
    final CommunityFormCubit communityFormCubit =
        ctx.read<CommunityFormCubit>();

    communityFormCubit.toggleAutovalidateMode();

    final FormState? formState = formKey.currentState;

    if (formState != null && formState.validate()) {
      final String userId = authBloc.state.user!.id;
      final String name = communityFormCubit.state.name;

      ctx.read<CreateCommunityCubit>().createCommunity(
            userId: userId,
            name: name,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CreateCommunityCubit, CreateCommunityState,
        CreateCommunityStatus>(
      selector: (state) => state.status,
      builder: (ctx, status) =>
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
                enabled: status != CreateCommunityStatus.loading,
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
                loading: status == CreateCommunityStatus.loading,
                onPressed: () => _createCommunity(context, formKey: formKey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
