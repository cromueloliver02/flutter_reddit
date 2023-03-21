import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_reddit/features/community/domain/usecases/pick_image_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../features/auth/data/datasources/datasources.dart';
import '../features/auth/data/repositories/repositories.dart';
import '../features/auth/domain/repositories/repositories.dart';
import '../features/auth/domain/usecases/usecases.dart';
import '../features/auth/presentation/blocs/blocs.dart';
import '../features/auth/presentation/cubits/cubits.dart';
import '../features/community/data/datasources/datasources.dart';
import '../features/community/data/repositories/repositories.dart';
import '../features/community/domain/repositories/repositories.dart';
import '../features/community/domain/usecases/usecases.dart';
import '../features/community/presentation/blocs/blocs.dart';
import '../features/community/presentation/cubits/cubits.dart';
import 'blocs/blocs.dart';
import 'cubits/cubits.dart';

// service locator
final GetIt sl = GetIt.instance;

void setup() {
  // external services
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());

  // data sources
  sl.registerLazySingleton<GoogleSignInDataSource>(
    () => GoogleSignInDataSourceImpl(googleSignIn: sl<GoogleSignIn>()),
  );
  sl.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<CommunityRemoteDataSource>(
    () => CommunityRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<StorageRemoteDataSource>(
    () => StorageRemoteDataSourceImpl(storage: sl<FirebaseStorage>()),
  );
  sl.registerLazySingleton<ImageLocalDataSource>(
    () => ImageLocalDataSourceImpl(imagePicker: sl<ImagePicker>()),
  );

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        googleSignInDataSource: sl<GoogleSignInDataSource>(),
        firebaseAuthDataSource: sl<FirebaseAuthDataSource>(),
        userRemoteDataSource: sl<UserRemoteDataSource>(),
      ));
  sl.registerLazySingleton<CommunityRepository>(() => CommunityRepositoryImpl(
        communityRemoteDataSource: sl<CommunityRemoteDataSource>(),
        storageRemoteDataSource: sl<StorageRemoteDataSource>(),
      ));
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
        imageLocalDataSource: sl<ImageLocalDataSource>(),
      ));

  // use cases
  sl.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthStateChanges>(
    () => GetAuthStateChanges(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<FetchUserCommunities>(
    () => FetchUserCommunities(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<CreateCommunity>(
    () => CreateCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<GetCommunity>(
    () => GetCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<UpdateCommunity>(
    () => UpdateCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<SearchCommunity>(
    () => SearchCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<PickImage>(
    () => PickImage(imageRepository: sl<ImageRepository>()),
  );

  // blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBlocImpl(getAuthStateChanges: sl<GetAuthStateChanges>()),
  );
  sl.registerFactory<CommunityListBloc>(
    () => CommunityListBlocImpl(getUserCommunities: sl<FetchUserCommunities>()),
  );

  // cubits
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(loginWithGoogle: sl<LoginWithGoogle>()),
  );
  sl.registerFactory<CreateCommunityFormCubit>(
    () => CreateCommunityFormCubit(),
  );
  sl.registerFactory<CreateCommunityCubit>(
    () => CreateCommunityCubit(createCommunity: sl<CreateCommunity>()),
  );
  sl.registerFactory<UpdateCommunityFormCubit>(
    () => UpdateCommunityFormCubit(),
  );
  sl.registerLazySingleton<CommunityDetailsCubit>(
    () => CommunityDetailsCubit(getCommunity: sl<GetCommunity>()),
  );
  sl.registerFactory<UpdateCommunityCubit>(
    () => UpdateCommunityCubit(updateCommunity: sl<UpdateCommunity>()),
  );
  sl.registerFactory<SearchCommunityCubit>(
    () => SearchCommunityCubitImpl(searchCommunity: sl<SearchCommunity>()),
  );

  // utilities
}
