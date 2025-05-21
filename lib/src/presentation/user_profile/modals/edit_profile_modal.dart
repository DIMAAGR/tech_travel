import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_alt_button.dart';
import 'package:tech_travel/src/presentation/components/untold_button.dart';
import 'package:tech_travel/src/presentation/components/untold_modal.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';
import 'package:tech_travel/src/presentation/user_profile/modals/scaffold_modal.dart';

class EditProfileModal extends StatefulWidget {
  final TextEditingController nameController;
  final VoidCallback onUpdateProfile;
  final String imageUrl;
  final String username;
  const EditProfileModal({
    super.key,
    required this.nameController,
    required this.username,
    required this.onUpdateProfile,
    required this.imageUrl,
  });

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  bool isPassObscure = true;
  bool isNewPassObscure = true;
  bool isConfirmPassObscure = true;

  @override
  Widget build(BuildContext context) {
    return ScaffoldModal(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 48),
        Text(
          'editProfileTitle'.tr(),
          style: AppTextStyle.title,
        ),
        const SizedBox(height: 64),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
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
                                    // widget.viewModel.getImageFromCamera();
                                  },
                                ),
                                UntoldAltButton(
                                  icon: UntoldIcons.gallery,
                                  iconColor: AppColors.mediumGrey4,
                                  title: 'chooseFromGallery'.tr(),
                                  backgroundColor: AppColors.mediumGrey3,
                                  borderColor: AppColors.mediumGrey2,
                                  onPressed: () {
                                    // widget.viewModel.getImageFromGallery();
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
              child: Stack(
                children: [
                  Container(
                    height: 144,
                    width: 144,
                    decoration: const BoxDecoration(
                      color: AppColors.mediumGrey3,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.purple2,
                          ),
                        ),
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(
                        color: AppColors.charcoalGrey,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: UntoldIcon(
                          icon: UntoldIcons.camera,
                          size: 32,
                          color: AppColors.purple1,
                        ),
                      ),
                    ),
                  )
                ],
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
        const SizedBox(height: 48),
        UntoldTextFormField(
          padding: EdgeInsets.zero,
          controller: widget.nameController,
          hintText: widget.username,
        ),
      ]),
      const Expanded(
        child: SizedBox(height: 32),
      ),
      Align(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: UntoldButton(
            title: 'updateProfile'.tr(),
            onPressed: widget.onUpdateProfile,
          ),
        ),
      ),
    ]);
  }
}
