import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/chart.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// 마이 페이지 프리젠터
class MyPresenter extends GetxController {
  PeriodType type = PeriodType.days;
  late Chart weightChart;
  double defaultWeight = userPresenter
      .user.weights?.values.last ?? FWUser.defaultWeight;

  static ThemeData themeData = Theme.of(Get.context!);
  static final userPresenter = Get.find<UserPresenter>();
  static final weightController = TextEditingController();
  static Map<DateTime, double>? weights = userPresenter.user.weights;

  void initChart() {
    weightChart = Chart(
      data: userPresenter.user.weights ?? {},
      themeData: themeData,
      type: type,
    );
  }

  void weightSelected(double weight) {
    defaultWeight = weight;
    update();
  }

  void addWeightPressed() {
    defaultWeight = userPresenter.user.weights!.values.last;
    Get.dialog(
      FWDialog(
        maxHeight: 150.0,
        rightPressed: () {
          userPresenter.user.weights![Plan.today] = defaultWeight;
          update(); Get.back();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('체중을 입력하세요.'),
            GetBuilder<MyPresenter>(
              builder: (controller) {
                return Expanded(
                  child: FWNumberPicker(
                    onChanged: (value) => controller.weightSelected(value * .1),
                    value: controller.defaultWeight,
                    step: .1,
                    minValue: FWUser.weightRange.start,
                    maxValue: FWUser.weightRange.end,
                  ),
                );
              },
            ),
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
    Get.toNamed('/setting');
  }
}