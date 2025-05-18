import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/camera_access_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/image_not_captured_failure.dart';
import 'package:tech_travel/src/core/errors/permission_denied_failure.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';

part 'onboarding_view_model.g.dart';

class OnboardingViewModel = OnboardingViewModelBase with _$OnboardingViewModel;

abstract class OnboardingViewModelBase with Store {
  final PermissionService _permissionService;
  final ImagePickerService _imagePickerService;

  OnboardingViewModelBase(
    this._permissionService,
    this._imagePickerService,
  );

  @observable
  ViewModelState<Failure, File> imageState = InitialState();

  @action
  Future<void> getImageFromCamera() async {
    try {
      final permission = await _permissionService.requestGalleryPermission();
      if (permission) {
        final image = await _imagePickerService.pickFromCamera();
        imageState = image != null ? SuccessState<Failure, File>(image) : ErrorState<Failure, File>(ImageNotCapturedFailure());
      } else {
        imageState = ErrorState<Failure, File>(PermissionDeniedFailure());
      }
    } catch (e) {
      imageState = ErrorState<Failure, File>(CameraAccessFailure());
    }
  }

  @action
  Future<void> getImageFromGallery() async {
    try {
      final permission = await _permissionService.requestGalleryPermission();
      if (permission) {
        final image = await _imagePickerService.pickFromGallery();
        imageState = image != null ? SuccessState<Failure, File>(image) : ErrorState<Failure, File>(ImageNotCapturedFailure());
      } else {
        imageState = ErrorState<Failure, File>(PermissionDeniedFailure());
      }
    } catch (e) {
      imageState = ErrorState<Failure, File>(CameraAccessFailure());
    }
  }
}
