import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entitties/entities.dart';

class CommunityModel extends Community {
  const CommunityModel({
    required super.id,
    required super.name,
    required super.banner,
    required super.avatar,
    required super.members,
    required super.mods,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'banner': banner});
    result.addAll({'avatar': avatar});
    result.addAll({'members': members});
    result.addAll({'mods': mods});

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
    );
  }
}
