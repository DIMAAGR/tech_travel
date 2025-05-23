import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_alt_button.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_loading.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/components/untold_modal.dart';
import 'package:tech_travel/src/presentation/components/untold_page_title.dart';
import 'package:tech_travel/src/presentation/components/untold_snackbar.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';
import 'package:tech_travel/src/presentation/onboarding/onboarding_view_model.dart';

class OnboardingView extends StatefulWidget {
  final OnboardingViewModel viewModel;
  const OnboardingView({
    super.key,
    required this.viewModel,
  });

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final yourNameController = TextEditingController();

  late ReactionDisposer _imageReactionDisposer;
  late ReactionDisposer _updateUserReactionDisposer;

  final UntoldLoading untoldLoading = UntoldLoading();

  void setupReactions() {
    yourNameController.addListener(() => widget.viewModel.setName(yourNameController.text));

    _imageReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.imageState,
      (state) {
        if (state is ErrorState<Failure, File>) {
          untoldLoading.hideLoadingPage(context);
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            message: state.error.message.tr(),
          );
        } else if (state is LoadingState) {
          untoldLoading.showLoadingPage(context);
        }
      },
    );

    _updateUserReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.updateState,
      (state) {
        if (state is ErrorState<Failure, void>) {
          untoldLoading.hideLoadingPage(context);
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            message: state.error.message.tr(),
          );
        } else if (state is SuccessState) {
          untoldLoading.hideLoadingPage(context);
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (_) => false);
        }
      },
    );
  }

  @override
  void initState() {
    setupReactions();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _imageReactionDisposer();
    _updateUserReactionDisposer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const UntoldLogo(),
      ),
      body: UntoldViewBody(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          UntoldPageTitle(
            title: 'tellUsMore'.tr(),
            subtitle: 'completeYourProfile'.tr(),
          ),
          const SizedBox(height: 64),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(32),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return UntoldModal(
                              title: 'chooseImage'.tr().toUpperCase(),
                              children: [
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      UntoldAltButton(
                                        icon: UntoldIcons.camera,
                                        iconColor: AppColors.purple1,
                                        title: 'takePhoto'.tr(),
                                        backgroundColor: AppColors.purple3,
                                        borderColor: AppColors.purple1,
                                        onPressed: () {
                                          widget.viewModel.getImageFromCamera();
                                        },
                                      ),
                                      UntoldAltButton(
                                        icon: UntoldIcons.gallery,
                                        iconColor: AppColors.mediumGrey4,
                                        title: 'chooseFromGallery'.tr(),
                                        backgroundColor: AppColors.mediumGrey3,
                                        borderColor: AppColors.mediumGrey2,
                                        onPressed: () {
                                          widget.viewModel.getImageFromGallery();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                              ],
                            );
                          });
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        color: AppColors.purple3,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: UntoldIcon(
                        icon: UntoldIcons.camera,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 104,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'chooseImage'.tr().toUpperCase(),
                          style: AppTextStyle.subtitle1.copyWith(fontSize: 12),
                        ),
                        Text(
                          'imageFormatInfo'.tr(),
                          style: AppTextStyle.labelSmall,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 88),
              UntoldTextFormField(
                hintText: 'yourName'.tr(),
                controller: yourNameController,
                useShadow: false,
              ),
              const SizedBox(height: 56),
              UntoldButton(
                horizontalPadding: 40,
                title: 'continue'.tr(),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.viewModel.updateUser();
                },
              ),
              UntoldTextButton(
                title: 'back'.tr(),
                height: 40,
                width: 192,
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
