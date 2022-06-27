import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 메인 페이지 프리젠터
class MainPresenter {
  static final userPresenter = Get.put(UserPresenter());

  // 역할 선택 트리거
  static VoidCallback roleSelected(Role role) {
    return () {
      Get.back();
      Get.offAllNamed('/main/${role.name}');
    };
  }

  // dialog 닫기 버튼 클릭 트리거
  static void dialogClosed() => Get.back();

  // 로그아웃 버튼 클릭 트리거
  static void logoutButtonPressed() { userPresenter.logout(); Get.offAllNamed('/login'); }
}