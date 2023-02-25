import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignInDataSource _googleSignInDataSource;
  final FirebaseAuthDataSource _firebaseAuthDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  AuthRepositoryImpl({
    required GoogleSignInDataSource googleSignInDataSource,
    required FirebaseAuthDataSource firebaseAuthDataSource,
    required UserRemoteDataSource userRemoteDataSource,
  })  : _googleSignInDataSource = googleSignInDataSource,
        _firebaseAuthDataSource = firebaseAuthDataSource,
        _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<void> signInWithGoogle() async {
    try {
      final fb_auth.OAuthCredential oAuthCredential =
          await _googleSignInDataSource.getOAuthCredential();

      final fb_auth.UserCredential userCredential =
          await _firebaseAuthDataSource.signInWithCredential(oAuthCredential);

      if (!userCredential.additionalUserInfo!.isNewUser) return;

      final UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? 'No name',
        profilePic: userCredential.user?.photoURL ?? kAvatarDefault,
        banner: kBannerDefault,
        isAuthenticated: true,
        karma: 0,
        awards: const <String>[],
      );

      await _userRemoteDataSource.post(user);
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
