import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';

abstract class FirebaseAuthDataSource {
  Future<fb_auth.UserCredential> signInWithCredential(
    fb_auth.OAuthCredential oAuthCredential,
  );
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final fb_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSourceImpl({
    required fb_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  @override
  Future<fb_auth.UserCredential> signInWithCredential(
    fb_auth.OAuthCredential oAuthCredential,
  ) async {
    try {
      final fb_auth.UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oAuthCredential);

      return userCredential;
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
