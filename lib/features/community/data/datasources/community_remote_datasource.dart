import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/entities.dart';
import '../models/models.dart';

abstract class CommunityRemoteDataSource {
  Stream<Community?> getById(String id);
  Stream<List<Community>> fetchCommunitiesByUserId(String userId);
  Future<void> post(CommunityModel community);
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final FirebaseFirestore _firestore;

  const CommunityRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  @override
  Stream<Community?> getById(String communityId) {
    try {
      final Stream<Community?> communityStream = _firestore
          .collection(kCommunitiesCollection)
          .doc(communityId)
          .snapshots()
          .map((DocumentSnapshot communityDoc) {
        if (!communityDoc.exists) return null;

        return CommunityModel.fromDoc(communityDoc);
      });

      return communityStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<Community>> fetchCommunitiesByUserId(String userId) {
    try {
      final Stream<List<Community>> communitiesStream = _firestore
          .collection(kCommunitiesCollection)
          .where('members', arrayContains: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((DocumentSnapshot doc) => CommunityModel.fromDoc(doc))
              .toList());

      return communitiesStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> post(CommunityModel community) async {
    try {
      await _firestore
          .collection(kCommunitiesCollection)
          .doc(community.id)
          .set(community.toMap());
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }
}
