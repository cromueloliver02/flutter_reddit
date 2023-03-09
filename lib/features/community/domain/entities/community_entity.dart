import 'package:equatable/equatable.dart';

class Community extends Equatable {
  final String id;
  final String name;
  final String banner;
  final String avatar;
  final List<String> members;
  final List<String> mods;
  final DateTime createdAt;
  final DateTime updatedAt;

  Community({
    required this.id,
    required this.name,
    required this.banner,
    required this.avatar,
    required this.members,
    required this.mods,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  List<Object> get props {
    return [
      id,
      name,
      banner,
      avatar,
      members,
      mods,
      createdAt,
      updatedAt,
    ];
  }

  @override
  String toString() {
    return 'Community(id: $id, name: $name, banner: $banner, avatar: $avatar, members: $members, mods: $mods, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  Community copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? banner,
    String Function()? avatar,
    List<String> Function()? members,
    List<String> Function()? mods,
    DateTime Function()? createdAt,
    DateTime Function()? updatedAt,
  }) {
    return Community(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
      banner: banner != null ? banner() : this.banner,
      avatar: avatar != null ? avatar() : this.avatar,
      members: members != null ? members() : this.members,
      mods: mods != null ? mods() : this.mods,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      updatedAt: updatedAt != null ? updatedAt() : this.updatedAt,
    );
  }
}
