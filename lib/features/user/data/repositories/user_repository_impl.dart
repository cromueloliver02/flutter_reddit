import 'package:dartz/dartz.dart';

import '../../../../core/datasources/datasources.dart';
import '../../../../core/entities/entities.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../domain/repositories/repositories.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _userRemoteDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  @override
  StreamEither<User> getUserProfile(String userId) async* {
    try {
      final Stream<User> userStream = _userRemoteDataSource.getUserById(userId);

      await for (final User user in userStream) {
        yield Right(user);
      }
    } on ServerException catch (err) {
      yield Left(ServerFailure(exception: err));
    } on NotFoundException catch (err) {
      yield Left(NotFoundFailure(
        exception: err,
        message: 'User not found',
      ));
    } on UnexpectedException catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    } catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }
}
