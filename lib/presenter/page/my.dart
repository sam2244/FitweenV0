import 'package:fitween1/view/page/my/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 마이 페이지 프리젠터
class MyPresenter extends GetxController {
  int pageIndex = 0;
  bool invalid = false;

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    if (pageIndex == 0) Get.back();
  }
}