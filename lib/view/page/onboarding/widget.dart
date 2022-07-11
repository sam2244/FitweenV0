import 'package:fitween1/presenter/page/before_main/onboarding.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

//Onboarding Page Parallax 로 구현
class Parallax extends StatelessWidget {
  const Parallax({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingPresenter>(
      builder: (controller) {
        OnboardingPresenter.pageCont.addListener(controller.pageScroll);
        return Stack(
          children: [
            //배경이미지 변경되는 페이지에 따라 인덱스 값 설정
            BackgroundImage(
              pageCount: OnboardingPresenter.screens.length + 1,
              screenSize: MediaQuery.of(context).size,
              offset: controller.pageOffset,
            ),
            PageView(
              controller: OnboardingPresenter.pageCont,
              children: OnboardingPresenter.screens.map((screen) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    child: SvgPicture.asset(screen['svgName']!,
                      height: 300.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  FWText(screen['text']!,
                    align: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(height: 10.0),
                ],
              )).toList(),
            ),
            if (controller.pageOffset == 3.0)
            AnimatedOpacity(
              opacity: controller.buttonVisible ? 1.0 : 0.0,
              duration: Duration.zero,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 150.0),
                child: const FWButton(
                  onPressed: OnboardingPresenter.startPressed,
                  text: '시작하기',
                  width: 200.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//배경이미지 크기 조절
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.pageCount,
    required this.screenSize,
    required this.offset,
  }) : super(key: key);

  /// Size of page
  final Size screenSize;

  /// Number of pages
  final int pageCount;

  /// Current page position
  final double offset;

  @override
  Widget build(BuildContext context) {
    // Image alignment goes from -1 to 1.
    // We convert page number range, 0..6 into the image alignment range -1..1
    int lastPageIdx = pageCount - 1;
    int firstPageIdx = 0;
    int alignmentMax = 1;
    int alignmentMin = -1;
    int pageRange = lastPageIdx - firstPageIdx - 1;
    int alignmentRange = alignmentMax - alignmentMin;
    double alignment = (offset - firstPageIdx) * alignmentRange / pageRange + alignmentMin;

    return SizedBox(
      height: 500.0,
      width: screenSize.width,
      child: SvgPicture.asset(
        'assets/image/page/onboarding/background.svg',
        alignment: Alignment(alignment, 0),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}