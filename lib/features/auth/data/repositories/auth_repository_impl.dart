import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignInDataSource _googleSignInDataSource;
  final FirebaseAuthDataSource _firebaseAuthDataSource;

  AuthRepositoryImpl({
    required GoogleSignInDataSource googleSignInDataSource,
    required FirebaseAuthDataSource firebaseAuthDataSource,
  })  : _googleSignInDataSource = googleSignInDataSource,
        _firebaseAuthDataSource = firebaseAuthDataSource;

  @override
  Future<void> signInWithGoogle() async {
    try {
      final fb_auth.OAuthCredential oAuthCredential =
          await _googleSignInDataSource.getOAuthCredential();

      final fb_auth.UserCredential userCredential =
          await _firebaseAuthDataSource.signInWithCredential(oAuthCredential);

      final User user = User(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? 'No name',
        profilePic: userCredential.user?.photoURL ?? kAvatarDefault,
        banner: kBannerDefault,
        isAuthenticated: true,
        karma: 0,
        awards: const <String>[],
      );
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
