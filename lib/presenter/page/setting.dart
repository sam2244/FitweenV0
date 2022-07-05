import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 설정 페이지 프리젠터
class SettingPresenter extends GetxController {

  static final userPresenter = Get.find<UserPresenter>();

  void profileImagePressed(ThemeData themeData) {
    Get.dialog(
      AlertDialog(
        title: FWText(
          '이미지 선택',
          style: themeData.textTheme.titleLarge,
          color: themeData.colorScheme.primary,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "이미지를 가져올 곳을 선택해주세요.",
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("갤러리"),
            onPressed: () {},
          ),
          TextButton(
            child: const Text("카메라"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    Get.offAllNamed('/my');
  }

  static void logoutPressed() {
    LoginPresenter.fitweenGoogleLogout();
    Get.offAllNamed('/login');
  }

  static void deletePressed() {
    LoginPresenter.fitweenUserDelete();
    Get.offAllNamed('/login');
  }
}