import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/errors/exceptions/exceptions.dart';

abstract class FirebaseAuthDataSource {
  Stream<fb_auth.User?> get user;
  Future<fb_auth.UserCredential> signInWithCredential(
    fb_auth.OAuthCredential oAuthCredential,
  );
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final fb_auth.FirebaseAuth _firebaseAuth;

  const FirebaseAuthDataSourceImpl({
    required fb_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Stream<fb_auth.User?> get user => _firebaseAuth.authStateChanges();

  @override
  Future<fb_auth.UserCredential> signInWithCredential(
    fb_auth.OAuthCredential oAuthCredential,
  ) async {
    try {
      final fb_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oAuthCredential);

      return userCredential;
    } on fb_auth.FirebaseAuthException catch (err, stackTrace) {
      throw ServerException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }
}
