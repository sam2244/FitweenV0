import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingCarousel extends StatelessWidget {
  const OnboardingCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> carouselWidgets = [
      const OnboardingCard(svgName: 'onboarding4', text: '비싼 PT 비용,\n부담으로 느끼신 적 있나요?', ),
      const OnboardingCard(svgName: 'onboarding5', text: '친구들끼리 서로를\n코칭하며 운동하고 싶으신가요?',),
      const OnboardingCard(svgName: 'onboarding3', text: '피트윈은 비전문가도 트레이너가 되어\n서로를 관리해 줄 수 있어요!', width: 250.0, height: 350.0,),
      const OnboardingCard(svgName: 'onboarding2', text: '피트윈과 함께\n건강해져볼까요?',),
    ];

    final double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: carouselWidgets.length > 1,
        height: height,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        // autoPlay: false,
      ),
      items: carouselWidgets
          .map((widget) => Container(
        padding: EdgeInsets.zero,
        child: widget,
      ))
          .toList(),
    );
  }
}


//온보딩 카드
class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    Key? key,
    required this.svgName,
    required this.text,
    this.width = 350.0,
    this.height = 350.0,
  }) : super(key: key);

  final String svgName;
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.zero,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/img/$svgName.svg',
            width: width,
            height: height,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
      ],
    ),
      );
  }
}


