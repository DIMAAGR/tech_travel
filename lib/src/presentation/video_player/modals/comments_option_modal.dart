import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_modal.dart';

class CommentsOptionModal extends StatelessWidget {
  final bool isMyComment;
  const CommentsOptionModal({super.key, required this.isMyComment});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: AppColors.background,
          child: SizedBox(
            width: 352,
            height: isMyComment ? 224 : 150,
            child: UntoldModal(
              title: 'comments'.tr(),
              titleStyle: AppTextStyle.commentsEditTitle,
              backSize: 24,
              children: [
                const SizedBox(height: 10),
                if (isMyComment) ...[
                  _action(icon: UntoldIcons.edit, title: 'edit'.tr(), onPressed: () => Navigator.pop(context)),
                  const SizedBox(height: 16),
                  _action(icon: UntoldIcons.trash, title: 'delete'.tr(), onPressed: () => Navigator.pop(context)),
                  const SizedBox(height: 16),
                ],
                _action(icon: UntoldIcons.flag, title: 'report'.tr(), onPressed: () => Navigator.pop(context), color: AppColors.purple1),
              ],
            ),
          ),
        ));
  }

  InkWell _action({
    required String title,
    required UntoldIconData icon,
    required VoidCallback onPressed,
    Color? color,
  }) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        width: 352,
        child: Row(
          children: [
            UntoldIcon(icon: icon, color: color ?? Colors.white, size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTextStyle.commentsEditButtons.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
