import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final List<String> members;
  final List<String> mods;

  const Community({
    required this.id,
    required this.name,
    required this.banner,
    required this.avatar,
    required this.members,
    required this.mods,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      banner,
      avatar,
      members,
      mods,
    ];
  }

  @override
  String toString() {
    return 'Community(id: $id, name: $name, banner: $banner, avatar: $avatar, members: $members, mods: $mods)';
  }

  Community copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? banner,
    String Function()? avatar,
    List<String> Function()? members,
    List<String> Function()? mods,
  }) {
    return Community(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      banner: banner != null ? banner() : this.banner,
      avatar: avatar != null ? avatar() : this.avatar,
      members: members != null ? members() : this.members,
      mods: mods != null ? mods() : this.mods,
    );
  }
}
