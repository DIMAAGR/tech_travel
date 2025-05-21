import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/subscription_entity.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_back_button.dart';
import 'package:tech_travel/src/presentation/components/untold_large_button.dart';
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

class UserProfileView extends StatefulWidget {
  final UserProfileViewModel viewModel;
  const UserProfileView({super.key, required this.viewModel});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
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
                          nameController: TextEditingController(),
                          username: 'Eva Mendes'.tr(),
                          onUpdateProfile: () {
                            Navigator.pop(context);
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
            UserProfileHeader(imageUrl: widget.viewModel.profilePhotoURL, username: 'Eva Mendes'),
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
                                Navigator.pop(context);
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
                          onConfirm: () {},
                          confirmText: 'deleteAccount'),
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
                      builder: (context) => const SubscriptionModal(),
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
            Center(child: LogoutButton(onPressed: () {})),
          ],
        ));
  }
}
