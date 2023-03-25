import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String profilePic;
  final String banner;
  final bool isAuthenticated;
  final int karma;
  final List<String> awards;

  const User({
    required this.id,
    required this.name,
    required this.profilePic,
    required this.banner,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  factory User.empty() {
    return const User(
      id: '',
      name: '',
      profilePic: '',
      banner: '',
      isAuthenticated: false,
      karma: 0,
      awards: <String>[],
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      profilePic,
      banner,
      isAuthenticated,
      karma,
      awards,
    ];
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, profilePic: $profilePic, banner: $banner, isAuthenticated: $isAuthenticated, karma: $karma, awards: $awards)';
  }

  User copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? profilePic,
    String Function()? banner,
    bool Function()? isAuthenticated,
    int Function()? karma,
    List<String> Function()? awards,
  }) {
    return User(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      profilePic: profilePic != null ? profilePic() : this.profilePic,
      banner: banner != null ? banner() : this.banner,
      isAuthenticated:
          isAuthenticated != null ? isAuthenticated() : this.isAuthenticated,
      karma: karma != null ? karma() : this.karma,
      awards: awards != null ? awards() : this.awards,
    );
  }
}
