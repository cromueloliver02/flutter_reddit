import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../models/models.dart';

abstract class UserRemoteDataSource {
  Future<void> post(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  const UserRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<void> post(UserModel user) async {
    try {
      await _firestore
          .collection(kUsersCollection)
          .doc(user.id)
          .set(user.toMap());
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }
}
