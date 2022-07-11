import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPresenter extends GetxController {
  static PageController pageCont = PageController(initialPage: 0);

  bool buttonVisible = false;
  double pageOffset = 1.0;

  //페이지에 들어갈 리스트
  static const List<Map<String, String>> screens = [{
      'svgName': 'assets/image/page/onboarding/carousel_04.svg',
      'text': '비싼 PT 비용,\n부담으로 느끼신 적 있나요?'
    }, {
      'svgName': 'assets/image/page/onboarding/carousel_03.svg',
      'text': '친구들끼리 서로를\n코칭하며 운동하고 싶으신가요?',
    }, {
      'svgName': 'assets/image/page/onboarding/carousel_02.svg',
      'text': '피트윈은 비전문가도 트레이너가 되어\n서로를 관리해 줄 수 있어요!',
    }, {
      'svgName': 'assets/image/page/onboarding/carousel_01.svg',
      'text': '피트윈과 함께\n건강해져볼까요?',
    },
  ];

  void pageScroll() async {
    pageOffset = pageCont.page ?? 0;
    if (pageOffset == 3.0) {
      await Future.delayed(const Duration(milliseconds: 1000), () {
        buttonVisible = true;
      });
    }
    update();
  }

  static void startPressed() => Get.offAllNamed('/splash');

}