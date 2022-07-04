import 'dart:math' as math;

import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 마이 페이지 프리젠터
class MyPresenter extends GetxController {
  PeriodType type = PeriodType.days;
  late Chart weightChart;

  static final userPresenter = Get.find<UserPresenter>();
  static Map<DateTime, double>? weights = userPresenter.user.weights;

  void initChart(ThemeData themeData) {
    weightChart = Chart(
      data: userPresenter.user.weights ?? {},
      themeData: themeData,
      type: type,
    );
  }

  void AddWeight(ThemeData themeData) {
    Get.dialog(
      AlertDialog(
        title: FWText(
          '체중을 입력하세요',
          style: themeData.textTheme.titleLarge,
          color: themeData.colorScheme.primary,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "체중 입력 텍스트 필드",
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("취소"),
            onPressed: () {},
          ),
          TextButton(
            child: const Text("확인"),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void typeChanged(PeriodType type) {
    this.type = type;
    update();
  }

  static void logoutPressed() {
    LoginPresenter.fitweenGoogleLogout();
    Get.offAllNamed('/login');
  }
  static void settingPressed() {
    Get.offAllNamed('/setting');
  }
}