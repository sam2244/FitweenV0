import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 설정 페이지 프리젠터
class SettingPresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    Get.offAllNamed('/my');
  }
}