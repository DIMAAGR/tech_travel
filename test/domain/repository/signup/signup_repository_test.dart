// test/data/repositories/signup_repository_impl_test.dart

// ignore_for_file: null_argument_to_non_null_type

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/already_registered_failure.dart';
import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/signup_model.dart';
import 'package:tech_travel/src/data/repositories/signup_repository_impl.dart';

import 'signup_repository_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late SignupRepositoryImpl repository;
  const model = SignupModel(
    email: 'foo@bar.com',
    username: 'foobar',
    password: 'secret123',
    firebaseUid: 'uid',
  );

  setUp(() {
    mockApiClient = MockApiClient();
    repository = SignupRepositoryImpl(mockApiClient);
  });

  group('SignupRepositoryImpl.signup', () {
    test('returns Left(NetworkFailure) on SocketException', () async {
      when(mockApiClient.registerUser(model.toJson())).thenThrow(SocketException('no internet'));

      final result = await repository.signup(model);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<NetworkFailure>()),
        (_) => fail('Expected NetworkFailure'),
      );
    });

    test('returns Left(AlreadyRegisteredFailure) when API reports email/username taken', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          'error': {'message': 'Email or Username are already taken'}
        },
        statusCode: 409,
      );
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: response,
      );

      when(mockApiClient.registerUser(model.toJson())).thenThrow(dioError);

      final result = await repository.signup(model);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<AlreadyRegisteredFailure>()),
        (_) => fail('Expected AlreadyRegisteredFailure'),
      );
    });

    test('returns Left(ApiFailure) when DioException for other API error', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {'statusCode': 500},
        statusCode: 500,
      );
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: response,
      );

      when(mockApiClient.registerUser(model.toJson())).thenThrow(dioError);

      final result = await repository.signup(model);

      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        final msg = (l as ApiFailure).message;
        expect(msg, contains('Error code:'));
      }, (_) => fail('Expected ApiFailure'));
    });

    test('returns Left(ApiFailure) on any other exception', () async {
      when(mockApiClient.registerUser(model.toJson())).thenThrow(Exception('kaboom'));

      final result = await repository.signup(model);

      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, isA<ApiFailure>()),
        (_) => fail('Expected ApiFailure'),
      );
    });
  });
}
