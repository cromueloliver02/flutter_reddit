import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/errors/exceptions/exceptions.dart';

abstract class GoogleSignInDataSource {
  Future<fb_auth.OAuthCredential> getOAuthCredential();

  void signOut();
}

class GoogleSignInDataSourceImpl implements GoogleSignInDataSource {
  final GoogleSignIn _googleSignIn;

  const GoogleSignInDataSourceImpl({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  @override
  Future<fb_auth.OAuthCredential> getOAuthCredential() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        // null googleAuth is a false alert exception, this happens when the
        // user cancelled the authentication process, throw
        // GoogleSignInCancelledException to avoid crashing the app
        throw GoogleSignInCancelledException();
      }

      final fb_auth.OAuthCredential oAuthCredential =
          fb_auth.GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      return oAuthCredential;
    } on GoogleSignInCancelledException {
      rethrow;
    } on PlatformException catch (err, stackTrace) {
      throw NetworkException(error: err, stackTrace: stackTrace);
    } catch (err, stackTrace) {
      throw UnexpectedException(error: err, stackTrace: stackTrace);
    }
  }

  @override
  void signOut() => _googleSignIn.signOut();
}
