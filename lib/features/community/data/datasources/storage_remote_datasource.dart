import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/errors/exceptions/exceptions.dart';

abstract class StorageRemoteDataSource {
  Future<String> storeFile({
    required String path,
    required String id,
    required File file,
  });
}

class StorageRemoteDataSourceImpl implements StorageRemoteDataSource {
  final FirebaseStorage _storage;

  const StorageRemoteDataSourceImpl({
    required FirebaseStorage storage,
  }) : _storage = storage;

  @override
  Future<String> storeFile({
    required String path,
    required String id,
    required File file,
  }) async {
    try {
      final Reference ref = _storage.ref().child(path).child(id);
      final TaskSnapshot taskSnapshot = await ref.putFile(file);
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }
}
