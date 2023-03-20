part of 'create_community_form_cubit.dart';

class CreateCommunityFormState extends Equatable {
  final AutovalidateMode autovalidateMode;
  final String name;

  const CreateCommunityFormState({
    required this.autovalidateMode,
    required this.name,
  });

  factory CreateCommunityFormState.initial() {
    return const CreateCommunityFormState(
      autovalidateMode: AutovalidateMode.disabled,
      name: '',
    );
  }

  @override
  List<Object> get props => [autovalidateMode, name];

  @override
  String toString() =>
      'CreateCommunityFormState(autovalidateMode: $autovalidateMode, name: $name)';

  CreateCommunityFormState copyWith({
    AutovalidateMode Function()? autovalidateMode,
    String Function()? name,
  }) {
    return CreateCommunityFormState(
      autovalidateMode:
          autovalidateMode != null ? autovalidateMode() : this.autovalidateMode,
      name: name != null ? name() : this.name,
    );
  }
}
