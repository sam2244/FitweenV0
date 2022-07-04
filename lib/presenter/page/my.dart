//import 'dart:math' as math;

import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// 마이 페이지 프리젠터
class MyPresenter extends GetxController {
  static final _weightController = TextEditingController();
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

  static void AddWeightPressed(ThemeData themeData) {
    final _weightController = TextEditingController();
    Get.dialog(
      FWDialog(
        rightLabel: '확인',
        rightPressed: () {},
        child: Column(
          children: [
            Row(
              children: [
                // ProfileImageRect(),
                Column(
                  children: [
                    const Text(
                      "체중을 입력하세요.",
                    ),
                    /*FWInputField(
                      width: 200.0,
                      controller: _weightController,
                      hintText: "체중",
                    ),*/
                    FWText(
                      '체중 입력 텍스트 필드',
                      //style: themeData.textTheme.titleLarge,
                      //color: themeData.colorScheme.primary,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
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