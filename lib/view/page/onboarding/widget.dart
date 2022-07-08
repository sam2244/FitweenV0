import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Onboarding Page Parallax로 구현
class Parallax extends StatefulWidget {
  const Parallax({Key? key}) : super(key: key);

  @override
  _ParallaxState createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  late PageController _pageController;
  late double _pageOffset;

  @override
  void initState() {
    super.initState();
    _pageOffset = 0;
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(
      () => setState(() => _pageOffset = _pageController.page ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage( //배경이미지 변경되는 페이지에 따라 인덱스 값 설정
          pageCount: screens.length + 1,
          screenSize: MediaQuery.of(context).size,
          offset: _pageOffset,
        ),
        PageView(
          controller: _pageController,
          children: [
            ...screens
                .map((screen) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          child: SvgPicture.asset(
                            screen.svgName,
                            height: 300.0,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          //color: Colors.black.withOpacity(0.4),
                          child: Text(
                            screen.text,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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

  /// Currnet page position
  final double offset;

  @override
  Widget build(BuildContext context) {
    // Image alignment goes from -1 to 1.
    // We convert page number range, 0..6 into the image alignment range -1..1
    int lastPageIdx = pageCount - 1;
    int firstPageIdx = 0;
    int alignmentMax = 1;
    int alignmentMin = -1;
    int pageRange = (lastPageIdx - firstPageIdx) - 1;
    int alignmentRange = (alignmentMax - alignmentMin);
    double alignment =
        (((offset - firstPageIdx) * alignmentRange) / pageRange) + alignmentMin;

    return SizedBox(
      height: 500.0,
      width: screenSize.width,
      child: SvgPicture.asset(
        'assets/img/onboarding_background.svg',
        alignment: Alignment(alignment, 0),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

//스크린 위젯
class Screen {
  const Screen({required this.svgName, required this.text});

  final String svgName;
  final String text;
}

//페이지에 들어갈 리스트
const List<Screen> screens = [
  Screen(
    svgName: 'assets/img/onboarding4.svg',
    text: '비싼 PT 비용,\n부담으로 느끼신 적 있나요?',
  ),
  Screen(
    svgName: 'assets/img/onboarding3.svg',
    text: '친구들끼리 서로를\n코칭하며 운동하고 싶으신가요?',
  ),
  Screen(
      svgName: 'assets/img/onboarding2.svg',
      text: '피트윈은 비전문가도 트레이너가 되어\n서로를 관리해 줄 수 있어요!'),
  Screen(
    svgName: 'assets/img/onboarding1.svg',
    text: '피트윈과 함께\n건강해져볼까요?',
  ),
];
