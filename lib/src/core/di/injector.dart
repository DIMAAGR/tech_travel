import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';
import 'package:tech_travel/src/data/repositories/login_repository_impl.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view_model.dart';

final getIt = GetIt.instance;

void setupInjector() {
  // Services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService(FirebaseAuth.instance));
  getIt.registerLazySingleton<PermissionService>(() => PermissionService());
  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  // Repositories
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      getIt<FirebaseAuthService>(),
    ),
  );

  // View-Models
  getIt.registerLazySingleton<SignupViewModel>(
    () => SignupViewModel(),
  );
  getIt.registerLazySingleton<OnboardingViewModel>(
    () => OnboardingViewModel(
      getIt<PermissionService>(),
      getIt<ImagePickerService>(),
    ),
  );

  // UseCases
  getIt.registerFactory(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithAppleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithEmailUseCase(getIt()));
}
