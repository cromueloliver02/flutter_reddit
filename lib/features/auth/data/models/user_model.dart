import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/entities.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.profilePic,
    required super.banner,
    required super.isAuthenticated,
    required super.karma,
    required super.awards,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'profilePic': profilePic});
    result.addAll({'banner': banner});
    result.addAll({'isAuthenticated': isAuthenticated});
    result.addAll({'karma': karma});
    result.addAll({'awards': awards});

    return result;
  }

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: doc.id,
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      banner: map['banner'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }
}
