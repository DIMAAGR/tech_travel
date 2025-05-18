import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:tech_travel/src/core/errors/camera_access_failure.dart';
import 'package:tech_travel/src/core/errors/image_not_captured_failure.dart';
import 'package:tech_travel/src/core/errors/permission_denied_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';

@GenerateMocks([PermissionService, ImagePickerService])
import 'onboarding_view_model_test.mocks.dart';

void main() {
  late OnboardingViewModel viewModel;
  late MockPermissionService mockPermissionService;
  late MockImagePickerService mockImagePickerService;
  final fakeImage = File('path/to/fake_image.jpg');

  setUp(() {
    mockPermissionService = MockPermissionService();
    mockImagePickerService = MockImagePickerService();
    viewModel = OnboardingViewModel(mockPermissionService, mockImagePickerService);
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
}
