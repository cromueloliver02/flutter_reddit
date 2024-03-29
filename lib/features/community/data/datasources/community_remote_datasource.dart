import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/firebase_constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/entities.dart';
import '../models/models.dart';

abstract class CommunityRemoteDataSource {
  Stream<Community> getCommunityById(String communityId);

  Stream<List<Community>> getCommunitiesByUserId(String userId);

  Future<void> createCommunity(CommunityModel community);

  Future<void> updateCommunity(CommunityModel community);

  Stream<List<Community>> searchCommunity(String query);

  Future<bool> checkCommunityExists(String communityId);
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final FirebaseFirestore _firestore;

  const CommunityRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Stream<Community> getCommunityById(String communityId) {
    try {
      final Stream<Community> communityStream = _firestore
          .collection(kCommunitiesCollection)
          .doc(communityId)
          .snapshots()
          .map((DocumentSnapshot communityDoc) {
        if (!communityDoc.exists) {
          throw const NotFoundException(
            error: 'CommunityRemoteDataSource.getCommunityById()',
          );
        }

        return CommunityModel.fromDoc(communityDoc);
      });

      return communityStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } on NotFoundException catch (err, stackTrace) {
      throw NotFoundException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<Community>> getCommunitiesByUserId(String userId) {
    try {
      final Stream<List<Community>> communitiesStream = _firestore
          .collection(kCommunitiesCollection)
          .where('members', arrayContains: userId)
          .snapshots()
          .map((snapshot) {
        final List<Community> communities = [];

        for (final DocumentSnapshot communityDoc in snapshot.docs) {
          if (communityDoc.exists) {
            final Community community = CommunityModel.fromDoc(communityDoc);
            communities.add(community);
          }
        }

        return communities;
      });

      return communitiesStream;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Future<void> createCommunity(CommunityModel community) async {
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

  @override
  Future<void> updateCommunity(CommunityModel community) async {
    try {
      await _firestore
          .collection(kCommunitiesCollection)
          .doc(community.id)
          .update(community.toMap());
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  Stream<List<Community>> searchCommunity(String query) {
    try {
      final Object isGreaterThanOrEqualTo = query.isEmpty ? 0 : query;
      final String? isLessThan = query.isEmpty
          ? null
          : query.substring(0, query.length - 1) +
              String.fromCharCode(query.codeUnitAt(query.length - 1) + 1);

      final Stream<List<Community>> communitiesStream = _firestore
          .collection(kCommunitiesCollection)
          .where(
            'name',
            isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
            isLessThan: isLessThan,
          )
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
  Future<bool> checkCommunityExists(String communityId) async {
    try {
      final DocumentSnapshot communityDoc = await _firestore
          .collection(kCommunitiesCollection)
          .doc(communityId)
          .get();

      return communityDoc.exists;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }
}
