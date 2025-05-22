import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/camera_access_failure.dart';
import 'package:tech_travel/src/core/errors/image_not_captured_failure.dart';
import 'package:tech_travel/src/core/errors/permission_denied_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/username_required_failure.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';

import 'onboarding_view_model_test.mocks.dart';

@GenerateMocks([
  PermissionService,
  ImagePickerService,
  UpdateUserUseCase,
  UserService,
  GetUserDataUseCase,
])
void main() {
  late OnboardingViewModel viewModel;
  late MockPermissionService mockPermissionService;
  late MockImagePickerService mockImagePickerService;
  late MockUpdateUserUseCase mockUpdateUserUseCase;
  late MockUserService mockUserService;
  late MockGetUserDataUseCase mockGetUserDataUseCase;

  final fakeImage = File('path/to/fake_image.jpg');

  setUp(() {
    mockPermissionService = MockPermissionService();
    mockImagePickerService = MockImagePickerService();
    mockUpdateUserUseCase = MockUpdateUserUseCase();
    mockUserService = MockUserService();
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    viewModel = OnboardingViewModel(
      getUserDataUseCase: mockGetUserDataUseCase,
      userService: mockUserService,
      imagePickerService: mockImagePickerService,
      permissionService: mockPermissionService,
      updateUserUseCase: mockUpdateUserUseCase,
    );
  });

  group('getImageFromCamera', () {
    test('should emit SuccessState when permission is granted and image is returned', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => true);
      when(mockImagePickerService.pickFromCamera()).thenAnswer((_) async => fakeImage);

      await viewModel.getImageFromCamera();

      expect(viewModel.imageState, isA<SuccessState<Failure, File>>());
      expect((viewModel.imageState as SuccessState).success, fakeImage);
    });

    test('should emit ErrorState with PermissionDeniedFailure when permission is denied', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => false);

      await viewModel.getImageFromCamera();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<PermissionDeniedFailure>());
    });

    test('should emit ErrorState with ImageNotCapturedFailure when image is null', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => true);
      when(mockImagePickerService.pickFromCamera()).thenAnswer((_) async => null);

      await viewModel.getImageFromCamera();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<ImageNotCapturedFailure>());
    });

    test('should emit ErrorState with CameraAccessFailure when an exception is thrown', () async {
      when(mockPermissionService.requestGalleryPermission()).thenThrow(Exception('unexpected error'));

      await viewModel.getImageFromCamera();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<CameraAccessFailure>());
    });
  });

  group('getImageFromGallery', () {
    test('should emit SuccessState when permission is granted and image is returned', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => true);
      when(mockImagePickerService.pickFromGallery()).thenAnswer((_) async => fakeImage);

      await viewModel.getImageFromGallery();

      expect(viewModel.imageState, isA<SuccessState<Failure, File>>());
      expect((viewModel.imageState as SuccessState).success, fakeImage);
    });

    test('should emit ErrorState with PermissionDeniedFailure when permission is denied', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => false);

      await viewModel.getImageFromGallery();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<PermissionDeniedFailure>());
    });

    test('should emit ErrorState with ImageNotCapturedFailure when image is null', () async {
      when(mockPermissionService.requestGalleryPermission()).thenAnswer((_) async => true);
      when(mockImagePickerService.pickFromGallery()).thenAnswer((_) async => null);

      await viewModel.getImageFromGallery();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<ImageNotCapturedFailure>());
    });

    test('should emit ErrorState with CameraAccessFailure when an exception is thrown', () async {
      when(mockPermissionService.requestGalleryPermission()).thenThrow(Exception('unexpected error'));

      await viewModel.getImageFromGallery();

      expect(viewModel.imageState, isA<ErrorState<Failure, File>>());
      expect((viewModel.imageState as ErrorState).error, isA<CameraAccessFailure>());
    });
  });

  group('updateUser', () {
    test('should emit ErrorState<UsernameRequiredFailure> when username is empty', () async {
      await viewModel.updateUser();

      expect(viewModel.updateState, isA<ErrorState<Failure, void>>());
      final err = (viewModel.updateState as ErrorState).error;
      expect(err, isA<UsernameRequiredFailure>());

      verifyNever(mockUpdateUserUseCase(any));
    });

    test('should emit ErrorState when useCase retorna falha', () async {
      viewModel.setName('fulano');
      final failure = CameraAccessFailure();
      when(mockUpdateUserUseCase(
        const UpdateMeModel(username: 'fulano', finishedOnboarding: 'true'),
      )).thenAnswer((_) async => Left(failure));

      await viewModel.updateUser();

      expect(viewModel.updateState, isA<ErrorState<Failure, void>>());
      expect((viewModel.updateState as ErrorState).error, equals(failure));
    });

    test('should emit SuccessState when useCase retorna sucesso', () async {
      viewModel.setName('fulano');
      when(mockUpdateUserUseCase(any)).thenAnswer((_) async => const Right(true));

      await viewModel.updateUser();

      expect(viewModel.updateState, isA<SuccessState<Failure, void>>());
      expect((viewModel.updateState as SuccessState), isA<SuccessState<Failure, void>>());
    });
  });
}
