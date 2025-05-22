// test/data/repositories/user_repository_impl_test.dart

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import 'package:tech_travel/src/core/errors/api_failure.dart';
import 'package:tech_travel/src/core/errors/network_failure.dart';
import 'package:tech_travel/src/core/services/firebase_services.dart';
import 'package:tech_travel/src/data/api/api_client.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/data/models/user_model.dart';
import 'package:tech_travel/src/data/repositories/user_repository_impl.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([ApiClient, FirebaseAuthService, UserModel])
void main() {
  late MockApiClient mockApi;
  late MockFirebaseAuthService mockAuth;
  late UserRepositoryImpl repo;
  late UserModel dummyUser;

  setUp(() {
    mockApi = MockApiClient();
    mockAuth = MockFirebaseAuthService();
    repo = UserRepositoryImpl(mockApi, mockAuth);
    dummyUser = MockUserModel();
  });

  group('updateUser', () {
    final model = UpdateMeModel(username: 'foo');

    test('→ NetworkFailure on SocketException', () async {
      when(mockApi.updateMe(model.toJson())).thenThrow(SocketException('no net'));

      final result = await repo.updateUser(model);
      expect(result.isLeft(), isTrue);
      result.fold((l) => expect(l, isA<NetworkFailure>()), (_) => fail('error'));
    });

    test('→ ApiFailure("Invalid update data") on 400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 400);
      when(mockApi.updateMe(model.toJson())).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.updateUser(model);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Invalid update data');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure("Error code: 500") on non-400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 500);
      when(mockApi.updateMe(model.toJson())).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.updateUser(model);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Error code: 500');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure(e.toString()) on other Exception', () async {
      when(mockApi.updateMe(model.toJson())).thenThrow(Exception('kaboom'));

      final result = await repo.updateUser(model);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, contains('kaboom'));
      }, (_) => fail('error'));
    });
  });

  group('logout', () {
    test('→ Right(true) on success', () async {
      when(mockAuth.logout()).thenAnswer((_) async => Future.value());

      final result = await repo.logout();
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('error'), (r) => expect(r, isTrue));
    });

    test('→ NetworkFailure on SocketException', () async {
      when(mockAuth.logout()).thenThrow(SocketException('oops'));

      final result = await repo.logout();
      expect(result.isLeft(), isTrue);
      result.fold((l) => expect(l, isA<NetworkFailure>()), (_) => fail('error'));
    });

    test('→ ApiFailure on other Exception', () async {
      when(mockAuth.logout()).thenThrow(Exception('err'));

      final result = await repo.logout();
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, contains('Exception: err'));
      }, (_) => fail('error'));
    });
  });

  group('deleteAccount', () {
    const userId = '123';

    test('→ NetworkFailure on SocketException', () async {
      when(mockApi.deleteUser(userId)).thenThrow(SocketException('nope'));

      final result = await repo.deleteAccount(userId);
      expect(result.isLeft(), isTrue);
      result.fold((l) => expect(l, isA<NetworkFailure>()), (_) => fail('error'));
    });

    test('→ ApiFailure("Unable to delete account") on 400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 400);
      when(mockApi.deleteUser(userId)).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.deleteAccount(userId);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Unable to delete account');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure("Error code: 404") on non-400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 404);
      when(mockApi.deleteUser(userId)).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.deleteAccount(userId);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Error code: 404');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure(e.toString()) on other Exception', () async {
      when(mockApi.deleteUser(userId)).thenThrow(Exception('boom'));

      final result = await repo.deleteAccount(userId);
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, contains('boom'));
      }, (_) => fail('error'));
    });
  });

  group('getUserData', () {
    test('→ Right(UserEntity) on success', () async {
      when(mockApi.getCurrentUser()).thenAnswer((_) async => Future.value(dummyUser));

      final result = await repo.getUserData();
      expect(result.isRight(), isTrue);
      result.fold((_) => fail('error'), (u) => expect(u, dummyUser));
    });

    test('→ NetworkFailure on SocketException', () async {
      when(mockApi.getCurrentUser()).thenThrow(SocketException('no net'));

      final result = await repo.getUserData();
      expect(result.isLeft(), isTrue);
      result.fold((l) => expect(l, isA<NetworkFailure>()), (_) => fail('error'));
    });

    test('→ ApiFailure("Unable to delete account") on 400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 400);
      when(mockApi.getCurrentUser()).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.getUserData();
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Unable to delete account');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure("Error code: 503") on non-400 DioException', () async {
      final resp = Response(requestOptions: RequestOptions(path: ''), statusCode: 503);
      when(mockApi.getCurrentUser()).thenThrow(DioException(requestOptions: RequestOptions(path: ''), response: resp));

      final result = await repo.getUserData();
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, 'Error code: 503');
      }, (_) => fail('error'));
    });

    test('→ ApiFailure(e.toString()) on other Exception', () async {
      when(mockApi.getCurrentUser()).thenThrow(Exception('uh-oh'));

      final result = await repo.getUserData();
      expect(result.isLeft(), isTrue);
      result.fold((l) {
        expect(l, isA<ApiFailure>());
        expect((l as ApiFailure).message, contains('uh-oh'));
      }, (_) => fail('error'));
    });
  });
}
