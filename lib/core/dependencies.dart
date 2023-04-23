import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import '../features/user/data/datasources/datasources.dart';
import '../features/user/data/repositories/repositories.dart';
import '../features/user/domain/repositories/repositories.dart';
import '../features/user/domain/usecases/usecases.dart';
import '../features/user/presentation/blocs/blocs.dart';
import '../features/user/presentation/cubits/cubits.dart';
import 'blocs/blocs.dart';
import 'datasources/datasources.dart';

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
        userRemoteDataSource: sl<UserRemoteDataSource>(),
      ));
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(
        imageLocalDataSource: sl<ImageLocalDataSource>(),
      ));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userRemoteDataSource: sl<UserRemoteDataSource>(),
      ));

  // use cases
  sl.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthStateChanges>(
    () => GetAuthStateChanges(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetUserCommunities>(
    () => GetUserCommunities(communityRepository: sl<CommunityRepository>()),
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
  sl.registerLazySingleton<SignOut>(
    () => SignOut(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<JoinOrLeaveCommunity>(
    () => JoinOrLeaveCommunity(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<GetCommunityMembers>(
    () => GetCommunityMembers(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<SaveModerators>(
    () => SaveModerators(communityRepository: sl<CommunityRepository>()),
  );
  sl.registerLazySingleton<GetUserProfile>(
    () => GetUserProfile(userRepository: sl<UserRepository>()),
  );

  // blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBlocImpl(
      getAuthStateChanges: sl<GetAuthStateChanges>(),
      signOut: sl<SignOut>(),
    ),
  );
  sl.registerFactory<CommunityListBloc>(
    () => CommunityListBlocImpl(getUserCommunities: sl<GetUserCommunities>()),
  );
  sl.registerFactory<SearchCommunityBloc>(
    () => SearchCommunityBlocImpl(searchCommunity: sl<SearchCommunity>()),
  );
  sl.registerFactory<CommunityMembersBloc>(
    () => CommunityMembersBloc(
      getCommunityMembers: sl<GetCommunityMembers>(),
    ),
  );
  sl.registerLazySingleton<CommunityDetailsBloc>(
    () => CommunityDetailsBloc(getCommunity: sl<GetCommunity>()),
  );
  sl.registerLazySingleton<UserDetailsBloc>(
    () => UserDetailsBloc(getUserProfile: sl<GetUserProfile>()),
  );

  // cubits
  sl.registerFactory<SignInCubit>(
    () => SignInCubit(signInWithGoogle: sl<SignInWithGoogle>()),
  );
  sl.registerFactory<CreateCommunityFormCubit>(
    () => CreateCommunityFormCubit(),
  );
  sl.registerFactory<CreateCommunityCubit>(
    () => CreateCommunityCubit(createCommunity: sl<CreateCommunity>()),
  );
  sl.registerFactory<UpdateCommunityFormCubit>(
    () => UpdateCommunityFormCubit(pickImage: sl<PickImage>()),
  );
  sl.registerFactory<UpdateCommunityCubit>(
    () => UpdateCommunityCubit(updateCommunity: sl<UpdateCommunity>()),
  );
  sl.registerFactory<JoinOrLeaveCommunityCubit>(
    () => JoinOrLeaveCommunityCubit(
      joinOrLeaveCommunity: sl<JoinOrLeaveCommunity>(),
    ),
  );
  sl.registerFactory<AddModeratorCubit>(
    () => AddModeratorCubit(saveModerators: sl<SaveModerators>()),
  );
  sl.registerFactory<EditUserFormCubit>(
    () => EditUserFormCubit(pickImage: sl<PickImage>()),
  );

  // utilities
}
