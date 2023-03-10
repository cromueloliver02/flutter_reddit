part of 'community_bloc.dart';

enum CommunityLoadStatus { initial, loading, success, failure }

enum CommunityFormStatus { initial, loading, success, failure }

class CommunityState extends Equatable {
  final List<Community> communities;
  final CommunityLoadStatus loadStatus;
  final CommunityFormStatus formStatus;
  final Failure error;

  const CommunityState({
    required this.communities,
    required this.loadStatus,
    required this.formStatus,
    required this.error,
  });

  factory CommunityState.initial() {
    return CommunityState(
      communities: const <Community>[],
      loadStatus: CommunityLoadStatus.initial,
      formStatus: CommunityFormStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [communities, loadStatus, formStatus, error];

  @override
  String toString() {
    return 'CommunityState(communities: $communities, loadStatus: $loadStatus, formStatus: $formStatus, error: $error)';
  }

  CommunityState copyWith({
    List<Community> Function()? communities,
    CommunityLoadStatus Function()? loadStatus,
    CommunityFormStatus Function()? formStatus,
    Failure Function()? error,
  }) {
    return CommunityState(
      communities: communities != null ? communities() : this.communities,
      loadStatus: loadStatus != null ? loadStatus() : this.loadStatus,
      formStatus: formStatus != null ? formStatus() : this.formStatus,
      error: error != null ? error() : this.error,
    );
  }
}
