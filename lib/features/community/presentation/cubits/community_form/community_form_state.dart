part of 'community_form_cubit.dart';

class CommunityFormState extends Equatable {
  final AutovalidateMode autovalidateMode;
  final String name;

  const CommunityFormState({
    required this.autovalidateMode,
    required this.name,
  });

  factory CommunityFormState.initial() {
    return const CommunityFormState(
      autovalidateMode: AutovalidateMode.disabled,
      name: '',
    );
  }

  @override
  List<Object> get props => [autovalidateMode, name];

  @override
  String toString() =>
      'CommunityFormState(autovalidateMode: $autovalidateMode, name: $name)';

  CommunityFormState copyWith({
    AutovalidateMode Function()? autovalidateMode,
    String Function()? name,
  }) {
    return CommunityFormState(
      autovalidateMode:
          autovalidateMode != null ? autovalidateMode() : this.autovalidateMode,
      name: name != null ? name() : this.name,
    );
  }
}
