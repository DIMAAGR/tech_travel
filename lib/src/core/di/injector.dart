import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/core/const/api_constants.dart';
import 'package:tech_travel/src/core/services/dio_service.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/repositories/signup_repository_impl.dart';
import 'package:tech_travel/src/data/repositories/user_repository_impl.dart';
import 'package:tech_travel/src/data/services/user_services_impl.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';
import 'package:tech_travel/src/data/repositories/login_repository_impl.dart';
import 'package:tech_travel/src/domain/repositories/signup_repository.dart';
import 'package:tech_travel/src/domain/repositories/user_repository.dart';
import 'package:tech_travel/src/domain/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/domain/usecases/sign_up_use_case.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/presentation/forgot_password/forgot_password_view_model.dart';
import 'package:tech_travel/src/presentation/login/login_view_model.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view_model.dart';

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
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  getIt.registerLazySingleton<UserService>(() => UserServicesImpl(FirebaseAuth.instance));

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
      withAppleUseCase: getIt<SignInWithAppleUseCase>(),
      withGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
      withEmailUseCase: getIt<SignInWithEmailUseCase>(),
      signUpUseCase: getIt<SignUpUseCase>(),
      userService: getIt<UserService>(),
    ),
  );

  // ===================================================
  // Onboarding View
  // ===================================================
  getIt.registerLazySingleton<OnboardingViewModel>(
    () => OnboardingViewModel(
      getIt<PermissionService>(),
      getIt<ImagePickerService>(),
    ),
  );

  // ===================================================
  // Login View
  // ===================================================
  getIt.registerLazySingleton<LoginViewModel>(
    () => LoginViewModel(),
  );

  // ===================================================
  // Forgot Password
  // ===================================================
  getIt.registerLazySingleton<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(),
  );

  ///
  ///
  /// UseCases
  ///
  ///
  getIt.registerFactory(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithAppleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithEmailUseCase(getIt()));
  getIt.registerFactory(() => SignUpUseCase(getIt()));
  getIt.registerFactory(() => UpdateUserUseCase(getIt()));
}
