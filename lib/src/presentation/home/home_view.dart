import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/theme/app_text_style.dart';
import 'package:tech_travel/src/data/models/movie_model.dart';
import 'package:tech_travel/src/presentation/components/untold_logo.dart';
import 'package:tech_travel/src/presentation/home/home_view_model.dart';
import 'package:tech_travel/src/presentation/home/widgets/blurred_video_background.dart';
import 'package:tech_travel/src/presentation/home/widgets/user_button.dart';
import 'package:tech_travel/src/presentation/home/widgets/video_card.dart';

class HomeView extends StatefulWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const UntoldLogo(),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: UserButton(
              onPressed: () {},
              userFirstLetter: 'U',
            ),
          ),
        ],
      ),
      body: BlurredVideoBackground(
          videoUrl:
              'https://s3-figma-videos-production-sig.figma.com/video/1137114552518648666/TEAM/6ebd/23b4/-cd4c-432a-8374-98cbe9c3af35?Expires=1748822400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ApWSjRuuY-AZHPDkgKeX-jgc2~rc8KNt4XZBB1mdTKCKM40KGPGuMdRXZQrai1DPnxMLl08X4TuiE~ZO7X1rJxQwIsB6GQndPxQOaLAymSNJYYm5yicbW5cfiJI0OLVK7hirEGY4xRd5ffxxhc6G87209tqMAvEPTPkf4~eqiY9bUyfbeCK1QZ69KLYn1zw3uwkKPxi3TlP5ZZufQKlzYMpKd9IM61HPL~ory-xH3--qmCVwkHcUxD8UZYBJKC384YE9dxTeLrk0oui7U3i6MtIX0OA8BZPd9s8BqGDkTBzbB~eHNQzl~itQx96eyAo2qidnOBSO80-Qnr~v5POEJA__',
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Now Showing',
                      style: AppTextStyle.h2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  VideoCard(
                    entity: MovieModel.fromJson(
                      {
                        'trailer_url':
                            'https://s3-figma-videos-production-sig.figma.com/video/1137114552518648666/TEAM/6ebd/23b4/-cd4c-432a-8374-98cbe9c3af35?Expires=1748822400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=ApWSjRuuY-AZHPDkgKeX-jgc2~rc8KNt4XZBB1mdTKCKM40KGPGuMdRXZQrai1DPnxMLl08X4TuiE~ZO7X1rJxQwIsB6GQndPxQOaLAymSNJYYm5yicbW5cfiJI0OLVK7hirEGY4xRd5ffxxhc6G87209tqMAvEPTPkf4~eqiY9bUyfbeCK1QZ69KLYn1zw3uwkKPxi3TlP5ZZufQKlzYMpKd9IM61HPL~ory-xH3--qmCVwkHcUxD8UZYBJKC384YE9dxTeLrk0oui7U3i6MtIX0OA8BZPd9s8BqGDkTBzbB~eHNQzl~itQx96eyAo2qidnOBSO80-Qnr~v5POEJA__',
                        'genre': 'Musical',
                        'title': 'Barbie',
                        'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore',
                        'last_comment': 'Lorem ipsum dolor sit amet, consect...',
                        'release_date': DateTime(2023, 2, 29).toIso8601String(),
                        'comments_count': 1322,
                        'share_link': 'https://example.com/',
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          )),
    );
  }
}
