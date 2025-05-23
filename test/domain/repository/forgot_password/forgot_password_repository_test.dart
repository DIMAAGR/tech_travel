// test/data/repositories/forgot_password_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/forgot_password_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/data/repositories/forgot_password_repository_impl.dart';

import 'forgot_password_repository_test.mocks.dart';

@GenerateMocks([FirebaseAuthService])
void main() {
  late MockFirebaseAuthService mockAuthService;
  late ForgotPasswordRepositoryImpl repository;

  const testEmail = 'user@example.com';

  setUp(() {
    mockAuthService = MockFirebaseAuthService();
    repository = ForgotPasswordRepositoryImpl(mockAuthService);
  });

  group('sendPasswordResetEmail', () {
    test('returns Right(null) when forgotPassword succeeds', () async {
      // Stub the service to succeed (no exception)
      when(mockAuthService.forgotPassword(testEmail)).thenAnswer((_) async => Future.value(true));

      final result = await repository.sendPasswordResetEmail(testEmail);

      expect(result.isRight(), isTrue);
      result.fold(
        (_) => fail('Expected Right(null)'),
        (r) => expect(r, isTrue),
      );
      verify(mockAuthService.forgotPassword(testEmail)).called(1);
    });

    test('returns Left(ForgotPasswordFailure) on exception', () async {
      // Stub the service to throw an exception
      when(mockAuthService.forgotPassword(testEmail)).thenThrow(Exception('network error'));

      final result = await repository.sendPasswordResetEmail(testEmail);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<ForgotPasswordFailure>()),
        (_) => fail('Expected Left(ForgotPasswordFailure)'),
      );
      verify(mockAuthService.forgotPassword(testEmail)).called(1);
    });
  });
}
