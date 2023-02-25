import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class GoogleSignInDataSource {
  Future<fb_auth.OAuthCredential> getOAuthCredential();
}

class GoogleSignInDataSourceImpl extends GoogleSignInDataSource {
  final GoogleSignIn _googleSignIn;

  GoogleSignInDataSourceImpl({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  @override
  Future<fb_auth.OAuthCredential> getOAuthCredential() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // if (googleAuth == null) return;

      final fb_auth.OAuthCredential oAuthCredential =
          fb_auth.GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      return oAuthCredential;
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
