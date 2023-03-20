import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/entities.dart';

class CommunityModel extends Community {
  CommunityModel({
    required super.id,
    required super.name,
    required super.banner,
    required super.avatar,
    required super.members,
    required super.mods,
    super.createdAt,
    super.updatedAt,
  });

  @override
  CommunityModel copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? banner,
    String Function()? avatar,
    List<String> Function()? members,
    List<String> Function()? mods,
    DateTime Function()? createdAt,
    DateTime Function()? updatedAt,
  }) {
    return CommunityModel(
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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'banner': banner});
    result.addAll({'avatar': avatar});
    result.addAll({'members': members});
    result.addAll({'mods': mods});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'updatedAt': updatedAt.millisecondsSinceEpoch});

    return result;
  }

  factory CommunityModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return CommunityModel(
      id: doc.id,
      name: map['name'] ?? '',
      banner: map['banner'] ?? '',
      avatar: map['avatar'] ?? '',
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }
}
