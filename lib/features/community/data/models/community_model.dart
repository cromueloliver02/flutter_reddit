import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entitties/entities.dart';

class CommunityModel extends Community {
  CommunityModel({
    required super.id,
    required super.name,
    required super.banner,
    required super.avatar,
    required super.members,
    required super.mods,
    required super.createdAt,
    required super.updatedAt,
  });

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
