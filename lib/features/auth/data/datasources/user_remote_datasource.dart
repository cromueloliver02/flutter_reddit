import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/entities.dart';
import '../models/models.dart';

abstract class UserRemoteDataSource {
  Stream<User> getById(String userId);
  Future<void> post(UserModel user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  const UserRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Stream<User> getById(String userId) {
    try {
      final Stream<User> userStream = _firestore
          .collection(kUsersCollection)
          .doc(userId)
          .snapshots()
          .map((DocumentSnapshot userDoc) => UserModel.fromDoc(userDoc));

      return userStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

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
