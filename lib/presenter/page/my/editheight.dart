import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 신장 수정 페이지 프리젠터
class EditHeightPresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    Get.offAllNamed('/setting');
  }
}