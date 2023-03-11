import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

// service locator
final GetIt sl = GetIt.instance;

void setup() {
  // external services
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

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

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        googleSignInDataSource: sl<GoogleSignInDataSource>(),
        firebaseAuthDataSource: sl<FirebaseAuthDataSource>(),
        userRemoteDataSource: sl<UserRemoteDataSource>(),
      ));
  sl.registerLazySingleton<CommunityRepository>(() => CommunityRepositoryImpl(
        communityRemoteDataSource: sl<CommunityRemoteDataSource>(),
      ));

  // use cases
  sl.registerLazySingleton<LoginWithGoogle>(
    () => LoginWithGoogle(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthStateChanges>(
    () => GetAuthStateChanges(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<CreateCommunity>(
    () => CreateCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<FetchUserCommunities>(
    () => FetchUserCommunities(communityRepository: sl<CommunityRepository>()),
  );

  // blocs
  sl.registerFactory<AuthBlocImpl>(
    () => AuthBlocImpl(getAuthStateChanges: sl<GetAuthStateChanges>()),
  );
  sl.registerFactory<CommunityListBlocImpl>(
    () => CommunityListBlocImpl(
      getUserCommunities: sl<FetchUserCommunities>(),
    ),
  );

  // cubits
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(loginWithGoogle: sl<LoginWithGoogle>()),
  );
  sl.registerFactory<CommunityFormCubit>(() => CommunityFormCubit());
  sl.registerFactory<CreateCommunityCubit>(() => CreateCommunityCubit(
        createCommunity: sl<CreateCommunity>(),
      ));

  // utilities
}
