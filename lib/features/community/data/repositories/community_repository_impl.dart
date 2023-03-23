import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/datasources/datasources.dart';
import '../../../../core/errors/exceptions/exceptions.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/typedefs.dart';
import '../../../auth/domain/entities/entities.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource _communityRemoteDataSource;
  final StorageRemoteDataSource _storageRemoteDataSource;
  final UserRemoteDataSource _userRemoteDataSource;

  const CommunityRepositoryImpl({
    required CommunityRemoteDataSource communityRemoteDataSource,
    required StorageRemoteDataSource storageRemoteDataSource,
    required UserRemoteDataSource userRemoteDataSource,
  })  : _communityRemoteDataSource = communityRemoteDataSource,
        _storageRemoteDataSource = storageRemoteDataSource,
        _userRemoteDataSource = userRemoteDataSource;

  @override
  StreamEither<Community> getCommunity(String communityId) async* {
    try {
      final Stream<Community?> communityStream =
          _communityRemoteDataSource.getById(communityId);

      await for (final Community? community in communityStream) {
        if (community != null) {
          yield Right(community);
        } else {
          yield const Left(ServerFailure(message: kDefaultNotFoundMsg));
        }
      }
    } on ServerException catch (err) {
      yield Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  StreamEither<List<Community>> fetchUserCommunities(
    String userId,
  ) async* {
    try {
      final Stream<List<Community>> communitiesStream =
          _communityRemoteDataSource.fetchCommunitiesByUserId(userId);

      await for (final List<Community> communities in communitiesStream) {
        yield Right(communities);
      }
    } on ServerException catch (err) {
      yield Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    } catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEither<void> createCommunity(CommunityModel community) async {
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
  FutureEither<void> updateCommunity({
    required CommunityModel community,
    required File? avatarImageFile,
    required File? bannerImageFile,
  }) async {
    try {
      if (avatarImageFile != null) {
        final String avatarUrl = await _storageRemoteDataSource.storeFile(
          path: 'communities/avatars',
          id: community.id,
          file: avatarImageFile,
        );

        community = community.copyWith(avatar: () => avatarUrl);
      }

      if (bannerImageFile != null) {
        final String bannerUrl = await _storageRemoteDataSource.storeFile(
          path: 'communities/banners',
          id: community.id,
          file: bannerImageFile,
        );

        community = community.copyWith(banner: () => bannerUrl);
      }

      await _communityRemoteDataSource.update(community);

      return const Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  StreamEither<List<Community>> searchCommunity(String query) async* {
    try {
      final Stream<List<Community>> communitiesStream =
          _communityRemoteDataSource.searchCommunity(query);

      await for (final List<Community> communities in communitiesStream) {
        yield Right(communities);
      }
    } on ServerException catch (err) {
      yield Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    } catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEither<void> joinCommunity({
    required String communityId,
    required String userId,
  }) async {
    try {
      final Community? community =
          await _communityRemoteDataSource.getById(communityId).first;

      if (community == null) {
        return const Left(ServerFailure(message: kDefaultNotFoundMsg));
      }

      final Community newCommunity =
          community.copyWith(members: () => [...community.members, userId]);

      await _communityRemoteDataSource.update(newCommunity as CommunityModel);

      return const Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  FutureEither<void> leaveCommunity({
    required String communityId,
    required String userId,
  }) async {
    try {
      final Community? community =
          await _communityRemoteDataSource.getById(communityId).first;

      if (community == null) {
        return const Left(ServerFailure(message: kDefaultNotFoundMsg));
      }

      final Community newCommunity = community.copyWith(
          members: () => community.members.where((d) => d != userId).toList());

      await _communityRemoteDataSource.update(newCommunity as CommunityModel);

      return const Right(null);
    } on ServerException catch (err) {
      return Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      return Left(UnexpectedFailure(exception: err));
    } catch (err) {
      return Left(UnexpectedFailure(exception: err));
    }
  }

  @override
  StreamEither<List<User>> fetchCommunityMembers(String communityId) async* {
    try {
      final Community? community =
          await _communityRemoteDataSource.getById(communityId).first;

      if (community == null) {
        yield const Left(ServerFailure(message: kDefaultNotFoundMsg));
      } else {
        final List<String> userIds = community.members;

        final Stream<List<User?>> usersStream =
            _userRemoteDataSource.getByIds(userIds);

        await for (final List<User?> users in usersStream) {
          final List<User> communityMembers =
              List<User>.from(users.where((d) => d != null).toList());

          yield Right(communityMembers);
        }
      }
    } on ServerException catch (err) {
      yield Left(ServerFailure(exception: err));
    } on UnexpectedException catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    } catch (err) {
      yield Left(UnexpectedFailure(exception: err));
    }
  }
}
