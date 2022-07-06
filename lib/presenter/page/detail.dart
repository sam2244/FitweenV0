import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view/page/main/trainer/widget.dart';

// 트레이너 디테일 페이지 프리젠터
class TrainerDetailPresenter extends GetxController {
  DateTime selectedDay = DateTime.now();
  bool checkedState = false;

  // 날짜 변경 트리거
  void indexChanged(DateTime selected) {
    selectedDay = selected;
    update();
  }

  void checkboxToggle(bool toggle) {
    checkedState = toggle;
    update();
  }
}
