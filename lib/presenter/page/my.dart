import 'dart:math' as math;

import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/presenter/model/user.dart';
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
        actions: <Widget>[
          TextButton(
            child: const Text("갤러리"),
            onPressed: () {
            },
          ),
          TextButton(
            child: const Text("카메라"),
            onPressed: () {
            },
          )
        ],
      ),
    );
  }

  void typeChanged(PeriodType type) {
    this.type = type;
    update();
  }

}