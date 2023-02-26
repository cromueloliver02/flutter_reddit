import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

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
  Stream<Either<Failure, fb_auth.User?>> user() {
    try {
      return _firebaseAuthDataSource.user.handleError((error) {
        return Stream.value(Left(UnexpectedFailure(exception: error)));
      }).map((fb_auth.User? user) {
        return Right(user);
      });
    } catch (err) {
      return Stream.value(Left(UnexpectedFailure(exception: err)));
    }
  }

  @override
  FutureEither<User?> signInWithGoogle() async {
    try {
      final fb_auth.OAuthCredential oAuthCredential =
          await _googleSignInDataSource.getOAuthCredential();

      final fb_auth.UserCredential userCredential =
          await _firebaseAuthDataSource.signInWithCredential(oAuthCredential);

      final UserModel user = UserModel(
        id: userCredential.user!.uid,
        name: userCredential.user?.displayName ?? 'No name',
        profilePic: userCredential.user?.photoURL ?? kAvatarDefault,
        banner: kBannerDefault,
        isAuthenticated: true,
        karma: 0,
        awards: const <String>[],
      );

      if (userCredential.additionalUserInfo!.isNewUser) {
        await _userRemoteDataSource.post(user);
      }

      return Right(user);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on GoogleSignInCancelledException {
      return const Right(null);
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }
}
