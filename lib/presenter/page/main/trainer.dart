import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/page/main/trainer/widget.dart';

// 트레이너 페이지 프리젠터
class TrainerPresenter extends GetxController {
  int pageIndex = 0;

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);
  static final carouselCont = CarouselController();

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < TrainerView.widgetCount) {
      pageIndex++;
    } else {
      pageIndex = 0;
    }
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) {
      pageIndex--;
    } else {
      pageIndex = TrainerView.widgetCount;
    }
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  // 다음 버튼 클릭 트리거
  void indexChanged(int index) {
    pageIndex = index;
    update();
  }
}
