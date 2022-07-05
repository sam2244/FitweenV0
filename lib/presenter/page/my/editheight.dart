import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 설정 페이지 프리젠터
class SettingPresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();

  void profileImageChange(context, ThemeData themeData) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context) {
        return Container(
          height: 175,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)
              )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 7.5),
                  width: 311,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: FWText(
                      '갤러리',
                      size: 15.0,
                      style: Theme.of(context).textTheme.titleMedium,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 7.5, 0.0, 10.0),
                  width: 311,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: FWText(
                      '카메라',
                      size: 15.0,
                      style: Theme.of(context).textTheme.titleMedium,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    Get.offAllNamed('/my');
  }

  static void editNamePressed() {
    Get.toNamed('/editName');
  }

  static void editHeightPressed() {
    Get.toNamed('/editHeight');
  }

  static void logoutPressed() {
    LoginPresenter.fitweenGoogleLogout();
    Get.offAllNamed('/login');
  }

  static void deletePressed() {
    LoginPresenter.fitweenUserDelete();
    Get.offAllNamed('/login');
  }

  static void AskDelete(ThemeData themeData) {
    Get.dialog(
      FWDialog(
        rightLabel: '삭제',
        rightPressed: () {
          deletePressed();
        },
        child: const Text(
          "계정을 정말 삭제하시겠습니까?",
        ),
      ),
    );
  }
}