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
  Stream<Either<Failure, User?>> get authStateChanges async* {
    try {
      final Stream<fb_auth.User?> userStream =
          _firebaseAuthDataSource.authStateChanges;

      await for (final fb_auth.User? user in userStream) {
        if (user != null) {
          final User userEntity =
              await _userRemoteDataSource.getById(user.uid).first;

          yield Right(userEntity);
        } else {
          yield const Right(null);
        }
      }
    } catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEither<User?> signInWithGoogle() async {
    try {
      final fb_auth.OAuthCredential oAuthCredential =
          await _googleSignInDataSource.getOAuthCredential();

      final fb_auth.UserCredential userCredential =
          await _firebaseAuthDataSource.signInWithCredential(oAuthCredential);

      if (userCredential.additionalUserInfo!.isNewUser) {
        final UserModel payload = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user?.displayName ?? 'No name',
          profilePic: userCredential.user?.photoURL ?? kAvatarDefault,
          banner: kBannerDefault,
          isAuthenticated: true,
          karma: 0,
          awards: const <String>[],
        );

        await _userRemoteDataSource.post(payload);
      }

      final User user =
          await _userRemoteDataSource.getById(userCredential.user!.uid).first;

      return Right(user);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on GoogleSignInCancelledException {
      return const Right(null);
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } on NetworkException catch (err) {
      return Left(NetworkFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  void signOut() {
    _firebaseAuthDataSource.signOut();
    _googleSignInDataSource.signOut();
  }
}
