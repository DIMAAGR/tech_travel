import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';
import 'package:tech_travel/src/data/repositories/login_repository_impl.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';

final getIt = GetIt.instance;

void setupInjector() {
  // Services
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService(FirebaseAuth.instance));

  // Repositories
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(getIt<FirebaseAuthService>()),
  );

  // UseCases
  getIt.registerFactory(() => SignInWithGoogleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithAppleUseCase(getIt()));
  getIt.registerFactory(() => SignInWithEmailUseCase(getIt()));
}
