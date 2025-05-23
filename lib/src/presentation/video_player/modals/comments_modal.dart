import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tech_travel/src/core/errors/failure.dart';
import 'package:tech_travel/src/core/extensions/format_extensions.dart';
import 'package:tech_travel/src/core/state/view_model_state.dart';
import 'package:tech_travel/src/core/theme/app_colors.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/domain/entities/comments_entity.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon.dart';
import 'package:tech_travel/src/presentation/components/icon/untold_icon_data.dart';
import 'package:tech_travel/src/presentation/components/untold_text_button.dart';
import 'package:tech_travel/src/presentation/components/untold_text_form_field.dart';
import 'package:tech_travel/src/presentation/video_player/modals/comments_option_modal.dart';
import 'package:tech_travel/src/presentation/video_player/video_player_view_model.dart';

class CommentsModal extends StatefulWidget {
  final VideoPlayerViewModel viewModel;
  final VoidCallback onClosePressed;
  const CommentsModal({
    super.key,
    required this.viewModel,
    required this.onClosePressed,
  });

  @override
  State<CommentsModal> createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  final TextEditingController commentController = TextEditingController();

  @override
  initState() {
    commentController.addListener(() => widget.viewModel.setComment(commentController.text));

    super.initState();
  }

  List<CommentsEntity> comments = [];

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      String commentsLength = widget.viewModel.commentsState is SuccessState<Failure, List<CommentsEntity>>
          ? (widget.viewModel.commentsState as SuccessState<Failure, List<CommentsEntity>>).success.length.toThousands()
          : '';
      bool isSuccess = widget.viewModel.commentsState is SuccessState<Failure, List<CommentsEntity>>;

      if (isSuccess) {
        comments = (widget.viewModel.commentsState as SuccessState<Failure, List<CommentsEntity>>).success;
        comments.sort((a, b) => b.date!.compareTo(a.date!));
      }
      return Container(
        padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 16),
        color: AppColors.background,
        height: MediaQuery.of(context).size.width,
        width: 352,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$commentsLength comments'.tr(),
                  style: AppTextStyle.videoSubtitlesTitle,
                ),
                UntoldTextButton(title: 'close'.tr(), onPressed: widget.onClosePressed)
              ],
            ),
            const SizedBox(height: 24),
            comments.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (_, index) => userComment(comments[index]),
                    ),
                  )
                : Text(
                    'noComments'.tr(),
                    style: AppTextStyle.videoSubtitlesButton,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: 48,
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
                        imageUrl: widget.viewModel.profilePhotoURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 0),
                  SizedBox(
                    width: 224,
                    child: UntoldTextFormField(
                      controller: commentController,
                      hintText: 'addReply'.tr(),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (commentController.text.isNotEmpty) {
                        if (context.mounted) {
                          FocusScope.of(context).unfocus();
                        }

                        await widget.viewModel.addComment();
                        commentController.clear();
                        widget.viewModel.clearComment();
                        await widget.viewModel.getAllComments();
                      }
                    },
                    child: ClipOval(
                      child: UntoldIcon(
                        icon: UntoldIcons.send,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  userComment(CommentsEntity comment) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          height: 40,
          width: 40,
          child: comment.user?.photoUrl == null
              ? const SizedBox()
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: comment.user!.photoUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 232,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.user?.name ?? 'Unknown User',
                        style: AppTextStyle.commentsTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comment.date?.timeAgo() ?? ''.tr(),
                        style: AppTextStyle.commentsDate,
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        barrierDismissible: true,
                        builder: (context) {
                          return CommentsOptionModal(
                            isMyComment: int.parse(widget.viewModel.userId) == comment.user!.id,
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 232,
              child: Text(
                comment.comment ?? ''.tr(),
                style: AppTextStyle.commentsBody,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UntoldIcon(
                  icon: UntoldIcons.arrow_down,
                  size: 10,
                ),
                const SizedBox(width: 4),
                Text(
                  'viewReplies'.tr(),
                  style: AppTextStyle.replyTitle,
                ),
                const SizedBox(width: 8),
                Text(
                  'reply'.tr(),
                  style: AppTextStyle.replyButton,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
