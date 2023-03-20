import 'dart:io';

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
  final StorageRemoteDataSource _storageRemoteDataSource;

  const CommunityRepositoryImpl({
    required CommunityRemoteDataSource communityRemoteDataSource,
    required StorageRemoteDataSource storageRemoteDataSource,
  })  : _communityRemoteDataSource = communityRemoteDataSource,
        _storageRemoteDataSource = storageRemoteDataSource;

  @override
  Future<Either<Failure, Community?>> getCommunity(String communityId) async {
    try {
      final Community? community =
          await _communityRemoteDataSource.getById(communityId).first;

      return Right(community);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  Either<Failure, Stream<List<Community>>> fetchUserCommunities(String userId) {
    try {
      final Stream<List<Community>> communitiesStream =
          _communityRemoteDataSource.fetchCommunitiesByUserId(userId);

      return Right(communitiesStream);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEitherVoid createCommunity(CommunityModel community) async {
    try {
      final Community? existingCommunity =
          await _communityRemoteDataSource.getById(community.id).first;

      if (existingCommunity != null) {
        throw CommunityNameAlreadyExistException();
      }

      await _communityRemoteDataSource.post(community);

      return const Right(null);
    } on CommunityNameAlreadyExistException {
      return const Left(CommunityNameAlreadyExistFailure());
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEitherVoid updateCommunity({
    required CommunityModel community,
    File? avatarImageFile,
    File? bannerImageFile,
  }) async {
    try {
      late final String? avatarDownloadUrl;
      late final String? bannerDownloadUrl;

      if (avatarImageFile != null) {
        avatarDownloadUrl = await _storageRemoteDataSource.storeFile(
          path: 'communities/avatars',
          id: community.id,
          file: avatarImageFile,
        );
      }

      if (bannerImageFile != null) {
        bannerDownloadUrl = await _storageRemoteDataSource.storeFile(
          path: 'communities/banners',
          id: community.id,
          file: bannerImageFile,
        );
      }

      community = community.copyWith(
        avatar: avatarDownloadUrl == null ? null : () => avatarDownloadUrl!,
        banner: bannerDownloadUrl == null ? null : () => bannerDownloadUrl!,
      ) as CommunityModel;

      await _communityRemoteDataSource.update(community);

      return const Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }
}
