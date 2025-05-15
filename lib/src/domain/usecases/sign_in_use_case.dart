import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/domain/repositories/login_repository.dart';

class SignInWithGoogleUseCase {
  SignInWithGoogleUseCase(this._repository);

  final LoginRepository _repository;

  Future<Either<Failure, void>> call() async {
    return _repository.signInWithGoogle();
  }
}

class SignInWithAppleUseCase {
  SignInWithAppleUseCase(this._repository);

  final LoginRepository _repository;

  Future<Either<Failure, void>> call() async {
    return _repository.signInWithApple();
  }
}

class SignInWithEmailUseCase {
  SignInWithEmailUseCase(this._repository);

  final LoginRepository _repository;

  Future<Either<Failure, void>> call(String email, String password) async {
    return _repository.signInWithEmail(email, password);
  }
}
