import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/subscription_entity.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_back_button.dart';
import 'package:tech_travel/src/presentation/components/untold_large_button.dart';
import 'package:tech_travel/src/presentation/components/untold_loading.dart';
import 'package:tech_travel/src/presentation/components/untold_snackbar.dart';
import 'package:tech_travel/src/presentation/components/untold_view_body.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/change_password_modal.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/edit_profile_modal.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/subscription_modal.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/warning_modal.dart';
import 'package:tech_travel/src/presentation/user_profile/user_profile_view_model.dart';
import 'package:tech_travel/src/presentation/user_profile/widgets/edit_profile_button.dart';
import 'package:tech_travel/src/presentation/user_profile/widgets/history_movie_button.dart';
import 'package:tech_travel/src/presentation/user_profile/widgets/logout_button.dart';
import 'package:tech_travel/src/presentation/user_profile/widgets/subscription_button.dart';
import 'package:tech_travel/src/presentation/user_profile/widgets/user_profile_header.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class UserProfileView extends StatefulWidget {
  final UserProfileViewModel viewModel;
  const UserProfileView({super.key, required this.viewModel});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final UntoldLoading untoldLoading = UntoldLoading();
  late ReactionDisposer _exitableReactionDisposer;
  late ReactionDisposer _userNameReactionDisposer;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    nameController.addListener(() => widget.viewModel.setName(nameController.text));
    passwordController.addListener(() => widget.viewModel.setPassword(passwordController.text));
    newPasswordController.addListener(() => widget.viewModel.setNewPassword(newPasswordController.text));
    confirmNewPasswordController.addListener(() => widget.viewModel.setConfirmNewPassword(confirmNewPasswordController.text));

    _initReactorDisposer();
    super.initState();
  }

  _initReactorDisposer() {
    _exitableReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.exitableState,
      (state) {
        if (state is ErrorState) {
          untoldLoading.hideLoadingPage(context);
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            message: state.error.message.tr(),
          );
        } else if (state is LoadingState) {
          untoldLoading.showLoadingPage(context);
        } else if (state is SuccessState) {
          untoldLoading.hideLoadingPage(context);
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
        }
      },
    );

    _userNameReactionDisposer = reaction<ViewModelState>(
      (_) => widget.viewModel.userProfileState,
      (state) {
        if (state is ErrorState<Failure, void>) {
          untoldLoading.hideLoadingPage(context);
          UntoldSnackbar.showMessage(
            context,
            useBorder: true,
            topPadding: 256,
            message: state.error.message.tr(),
          );
        } else if (state is LoadingState) {
          untoldLoading.showLoadingPage(context);
        } else if (state is SuccessState) {
          untoldLoading.hideLoadingPage(context);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    _exitableReactionDisposer();
    _userNameReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const UntoldBackButton(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: EditProfileButton(onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => EditProfileModal(
                          imageUrl: widget.viewModel.profilePhotoURL,
                          nameController: nameController,
                          username: widget.viewModel.userService.userName!,
                          onUpdateProfile: () {
                            widget.viewModel.updateName();
                          },
                        ));
              }),
            ),
          ],
        ),
        body: UntoldViewBody(
          crossAxisAlignment: CrossAxisAlignment.start,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Observer(builder: (context) {
              return UserProfileHeader(
                imageUrl: widget.viewModel.profilePhotoURL,
                username: widget.viewModel.userService.userName ?? '',
              );
            }),
            Column(
              children: [
                UntoldLargerButton(
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => ChangePasswordModal(
                              passwordController: TextEditingController(),
                              confirmNewPasswordController: TextEditingController(),
                              newPasswordController: TextEditingController(),
                              onUpdatePassword: () {
                                widget.viewModel.updatePassword();
                              },
                            ));
                  },
                  icon: UntoldIcons.shield,
                  title: 'changePassword'.tr(),
                ),
                const SizedBox(height: 8),
                UntoldLargerButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => WarningModal(
                          title: 'deleteAccountConfirmTitle'.tr(),
                          subtitle: 'deleteAccountConfirmDescription'.tr(),
                          onConfirm: () {
                            widget.viewModel.deleteAccount();
                          },
                          confirmText: 'deleteAccount'.tr()),
                    );
                  },
                  icon: UntoldIcons.trash,
                  title: 'deleteMyAccount'.tr(),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'subscriptions'.tr(),
                  style: AppTextStyle.subtitle4,
                ),
                const SizedBox(height: 16),
                SubscriptionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SubscriptionModal(
                        onConfirm: () {
                          Navigator.pop(context);
                          widget.viewModel.terminateSubscriptionPlan();
                        },
                      ),
                    );
                  },
                  subscription: SubscriptionEntity(
                    expireIn: ExpireTime.soon,
                    inscriptionDate: DateTime(2023, 01, 22),
                    type: SubscriptionType.premium,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'history'.tr(),
                  style: AppTextStyle.subtitle4,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HistoryMovieButton(
                      imageUrl: 'https://upload.wikimedia.org/wikipedia/pt/8/82/Barbie_%282023%29.jpg',
                      movieName: 'Barbie',
                      movieYear: DateTime(2023),
                      onPressed: () {},
                    ),
                    HistoryMovieButton(
                      imageUrl: 'https://upload.wikimedia.org/wikipedia/en/1/1e/Everything_Everywhere_All_at_Once.jpg',
                      movieName: 'Everything everywhere all at once',
                      movieYear: DateTime(2022),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            Center(child: LogoutButton(onPressed: () {
              widget.viewModel.logout();
            })),
          ],
        ));
  }
}
