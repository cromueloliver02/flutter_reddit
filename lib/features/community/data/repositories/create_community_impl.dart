import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource _communityRemoteDataSource;

  const CommunityRepositoryImpl({
    required CommunityRemoteDataSource communityRemoteDataSource,
  }) : _communityRemoteDataSource = communityRemoteDataSource;

  @override
  FutureEitherVoid createCommunity(CommunityModel community) async {
    try {
      final Community? existingCommunity =
          await _communityRemoteDataSource.getById(community.id);

      if (existingCommunity != null) {
        throw CommunityNameAlreadyExistException();
      }

      await _communityRemoteDataSource.post(community);

      return const Right(null);
    } on CommunityNameAlreadyExistException {
      return Left(CommunityNameAlreadyExistFailure());
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on NetworkException catch (err) {
      return Left(NetworkFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }
}
