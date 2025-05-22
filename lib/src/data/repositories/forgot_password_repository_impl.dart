import 'package:dartz/dartz.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/forgot_password_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/domain/repositories/forgot_password_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final FirebaseAuthService _authService;

  ForgotPasswordRepositoryImpl(this._authService);
  @override
  Future<Either<Failure, bool>> sendPasswordResetEmail(String email) async {
    try {
      await _authService.forgotPassword(email);
      return const Right(true);
    } on Exception catch (_) {
      return Left(ForgotPasswordFailure());
    }
  }
}
