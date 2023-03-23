import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/datasources/datasources.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../auth/domain/entities/entities.dart';
import '../../../auth/data/models/models.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;

  const UserRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Stream<User?> getUserById(String userId) {
    try {
      final Stream<User?> userStream = _firestore
          .collection(kUsersCollection)
          .doc(userId)
          .snapshots()
          .map((DocumentSnapshot doc) {
        if (!doc.exists) return null;

        return UserModel.fromDoc(doc);
      });

      return userStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<User?>> getUsersByIds(List<String> userIds) {
    try {
      final Stream<List<User?>> usersStream = _firestore
          .collection(kUsersCollection)
          .where(FieldPath.documentId, whereIn: userIds)
          .snapshots()
          .map((QuerySnapshot snapshot) =>
              snapshot.docs.map((DocumentSnapshot doc) {
                if (!doc.exists) return null;

                return UserModel.fromDoc(doc);
              }).toList());

      return usersStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
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
