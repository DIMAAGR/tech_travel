import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/errors/camera_access_failure.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/errors/image_not_captured_failure.dart';
import 'package:tech_travel/src/core/errors/permission_denied_failure.dart';
import 'package:tech_travel/src/core/errors/username_required_failure.dart';
import 'package:tech_travel/src/core/services/image_picker_service.dart';
import 'package:tech_travel/src/core/services/permission_services.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/data/models/update_me_model.dart';
import 'package:tech_travel/src/data/services/user_service.dart';
import 'package:tech_travel/src/domain/usecases/update_user_use_case.dart';
import 'package:tech_travel/src/domain/usecases/user_use_case.dart';

part 'onboarding_view_model.g.dart';

class OnboardingViewModel = OnboardingViewModelBase with _$OnboardingViewModel;

abstract class OnboardingViewModelBase with Store {
  final PermissionService permissionService;
  final ImagePickerService imagePickerService;
  final UserService userService;

  final GetUserDataUseCase getUserDataUseCase;
  final UpdateUserUseCase updateUserUseCase;

  OnboardingViewModelBase({
    required this.getUserDataUseCase,
    required this.imagePickerService,
    required this.permissionService,
    required this.updateUserUseCase,
    required this.userService,
  });

  String username = '';

  @observable
  ViewModelState<Failure, File> imageState = InitialState();

  @observable
  ViewModelState<Failure, void> updateState = InitialState();

  setName(String value) => username = value;

  @action
  Future<void> getImageFromCamera() async {
    try {
      final permission = await permissionService.requestGalleryPermission();
      if (permission) {
        final image = await imagePickerService.pickFromCamera();
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
      final permission = await permissionService.requestGalleryPermission();
      if (permission) {
        final image = await imagePickerService.pickFromGallery();
        imageState = image != null ? SuccessState<Failure, File>(image) : ErrorState<Failure, File>(ImageNotCapturedFailure());
      } else {
        imageState = ErrorState<Failure, File>(PermissionDeniedFailure());
      }
    } catch (e) {
      imageState = ErrorState<Failure, File>(CameraAccessFailure());
    }
  }

  @action
  Future<void> updateUser() async {
    if (username.isEmpty) {
      updateState = ErrorState<Failure, void>(UsernameRequiredFailure());
      return;
    }

    updateState = LoadingState<Failure, void>();

    final result = await updateUserUseCase(UpdateMeModel(
      username: username,
      finishedOnboarding: 'true',
    ));

    result.fold(
      (failure) => updateState = ErrorState(failure),
      (success) => updateState = SuccessState(null),
    );
  }

  @action
  Future<void> getUserData() async {
    final result = await getUserDataUseCase();
    result.fold(
      (failure) => updateState = ErrorState(failure),
      (user) {
        userService.setUserData(user);
        updateState = SuccessState(null);
      },
    );
  }
}
