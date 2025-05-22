import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/core/const/api_constants.dart';
import 'package:tech_travel/src/core/services/comments_serivce.dart';
import 'package:tech_travel/src/core/services/dio_service.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/repositories/comments_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/forgot_password_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/get_movie_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/likes_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/signup_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/user_repository_impl.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/repositories/comments_repository.dart';
import 'package:tech_travel/src/domain/repositories/forgot_password_repository.dart';
import 'package:tech_travel/src/domain/repositories/get_movie_repository.dart';
import 'package:tech_travel/src/domain/repositories/likes_repository.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';
import 'package:tech_travel/src/data/repositories/login_repository_impl.dart';
import 'package:tech_travel/src/domain/repositories/signup_repository.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';
import 'package:tech_travel/src/domain/usecases/comments_use_case.dart';
import 'package:tech_travel/src/domain/usecases/forgot_password_use_case.dart';
import 'package:tech_travel/src/domain/usecases/get_movie_use_case.dart';
import 'package:tech_travel/src/domain/usecases/likes_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_up_use_case.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:tech_travel/src/presentation/home/home_view_model.dart';
import 'package:tech_travel/src/presentation/login/login_view_model.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view_model.dart';
import 'package:tech_travel/src/presentation/user_profile/user_profile_view_model.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt.registerLazySingleton<Dio>(() => createDio());

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(
      getIt<Dio>(),
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  ///
  ///
  /// Services
  ///
  ///
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService(FirebaseAuth.instance));
  getIt.registerLazySingleton<CommentService>(() => CommentService(FirebaseFirestore.instance));
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  getIt.registerLazySingleton<UserService>(() => UserService(FirebaseAuth.instance));

  ///
  ///
  /// Repositories
  ///
  ///
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      getIt<FirebaseAuthService>(),
    ),
  );
  getIt.registerLazySingleton<SignupRepository>(
    () => SignupRepositoryImpl(
      getIt<ApiClient>(),
    ),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      getIt<ApiClient>(),
      getIt<FirebaseAuthService>(),
    ),
  );
  getIt.registerLazySingleton<ForgotPasswordRepository>(
    () => ForgotPasswordRepositoryImpl(
      getIt<FirebaseAuthService>(),
    ),
  );
  getIt.registerLazySingleton<GetMovieRepository>(
    () => GetMovieRepositoryImpl(
      getIt<ApiClient>(),
    ),
  );
  getIt.registerLazySingleton<CommentsRepository>(
    () => CommentsRepositoryImpl(
      getIt<CommentService>(),
    ),
  );
  getIt.registerLazySingleton<LikesRepository>(
    () => LikesRepositoryImpl(
      getIt<ApiClient>(),
    ),
  );

  ///
  ///
  /// View-Models
  ///
  ///

  // ===================================================
  // Signup View
  // ===================================================
  getIt.registerLazySingleton<SignupViewModel>(
    () => SignupViewModel(
      withGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
      withAppleUseCase: getIt<SignInWithAppleUseCase>(),
      withEmailUseCase: getIt<SignUpWithEmailUseCase>(),
      getUserDataUseCase: getIt<GetUserDataUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
      userService: getIt<UserService>(),
    ),
  );

  // ===================================================
  // Onboarding View
  // ===================================================
  getIt.registerLazySingleton<OnboardingViewModel>(
    () => OnboardingViewModel(
      getUserDataUseCase: getIt<GetUserDataUseCase>(),
      imagePickerService: getIt<ImagePickerService>(),
      permissionService: getIt<PermissionService>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
      userService: getIt<UserService>(),
    ),
  );

  // ===================================================
  // Login View
  // ===================================================
  getIt.registerLazySingleton<LoginViewModel>(
    () => LoginViewModel(
      withAppleUseCase: getIt<SignInWithAppleUseCase>(),
      withEmailUseCase: getIt<SignInWithEmailUseCase>(),
      withGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
      getUserDataUseCase: getIt<GetUserDataUseCase>(),
      userService: getIt<UserService>(),
    ),
  );

  // ===================================================
  // Forgot Password
  // ===================================================
  getIt.registerLazySingleton<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(
      forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    ),
  );

  // ===================================================
  // Home View
  // ===================================================
  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(
      getMovieUseCase: getIt<GetMovieUseCase>(),
      getAllLikesUseCase: getIt<GetAllLikesUseCase>(),
      getLastCommentUseCase: getIt<GetAllCommentsUseCase>(),
      addLikeUseCase: getIt<LikeUseCase>(),
      removeLikeUseCase: getIt<UnlikeUseCase>(),
      userService: getIt<UserService>(),
    ),
  );

  // ===================================================
  // Home View
  // ===================================================
  getIt.registerLazySingleton<UserProfileViewModel>(
    () => UserProfileViewModel(
      logoutUseCase: getIt<LogoutUseCase>(),
      deleteAccountUseCase: getIt<DeleteAccountUseCase>(),
      userService: getIt<UserService>(),
      updateUserUseCase: getIt<UpdateUserUseCase>(),
    ),
  );

  ///
  ///
  /// UseCases
  ///
  ///
  getIt.registerFactory(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithAppleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithEmailUseCase(getIt()));
  getIt.registerFactory(() => SignUpWithEmailUseCase(getIt()));
  getIt.registerFactory(() => UpdateUserUseCase(getIt()));
  getIt.registerFactory(() => LogoutUseCase(getIt()));
  getIt.registerFactory(() => SignUpUseCase(getIt()));
  getIt.registerFactory(() => DeleteAccountUseCase(getIt()));
  getIt.registerFactory(() => GetUserDataUseCase(getIt()));
  getIt.registerFactory(() => ForgotPasswordUseCase(getIt()));
  getIt.registerFactory(() => GetMovieUseCase(getIt()));
  getIt.registerFactory(() => GetAllCommentsUseCase(getIt()));
  getIt.registerFactory(() => LikeUseCase(getIt()));
  getIt.registerFactory(() => UnlikeUseCase(getIt()));
  getIt.registerFactory(() => GetAllLikesUseCase(getIt()));
  getIt.registerFactory(() => GetLastCommentUseCase(getIt()));
  getIt.registerFactory(() => AddCommentUseCase(getIt()));
}
