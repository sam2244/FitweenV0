import 'package:carousel_slider/carousel_controller.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/view/page/add_plan/widget.dart';
import 'package:fitween1/view/page/main/trainee/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/page/main/trainee/trainee.dart';

class AddPlanPresenter extends GetxController {
  int pageIndex = 0;
  List<bool> invalids = [false, false];
  String hintText = Plan.purposes.first;
  bool fieldActive = false;
  int period = 1;

  static const int max = 999;

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static final purposeCont = TextEditingController();
  static final carouselCont = CarouselController();

  static final planPresenter = Get.find<PlanPresenter>();


  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < CarouselView.widgetCount - 1) pageIndex++;
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) pageIndex--;
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    if (pageIndex == 0) {
      Get.back();
    }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
      carouselCont.nextPage(
        curve: transitionCurve,
        duration: transitionDuration,
      );
      pageIndexIncrease();
  }

  void purposeSelected(String purpose) {
    planPresenter.plan.purpose = purpose;
    purposeCont.clear();
    hintText = purpose == '기타' ? '직접입력' : purpose;
    fieldActive = purpose == '기타';
    update();
  }

  void dietSelected(bool isDiet) {
    planPresenter.plan.isDiet = isDiet;
    update();
  }

  void initDates() {
    if (planPresenter.plan.startDate == null) {
      if (planPresenter.plan.endDate == null) {
        planPresenter.plan.startDate = Plan.today;
      }
      else {
        planPresenter.plan.startDate = planPresenter.plan.endDate;
      }
    }
    if (planPresenter.plan.endDate == null) {
      if (planPresenter.plan.startDate == null) {
        planPresenter.plan.endDate = Plan.today;
      }
      else {
        planPresenter.plan.endDate = planPresenter.plan.startDate;
      }
    }

  }

  void setPeriod() {
    period = planPresenter.plan.endDate!
        .difference(planPresenter.plan.startDate!).inDays + 1;

    update();
  }

  void syncStart() {
    if (planPresenter.plan.endDate!.isBefore(planPresenter.plan.startDate!)) {
      planPresenter.plan.startDate = planPresenter.plan.endDate;
    }
  }

  void syncEnd() {
    if (planPresenter.plan.startDate!.isAfter(planPresenter.plan.endDate!)) {
      planPresenter.plan.endDate = planPresenter.plan.startDate;
    }
  }

  void startDateSelected() async {
    initDates();

    Future<DateTime?> date = showDatePicker(
      context: Get.context!,
      initialDate: planPresenter.plan.startDate!,
      firstDate: Plan.today.subtract(const Duration(days: 30)),
      lastDate: Plan.today.add(const Duration(days: max)),
    );
    planPresenter.plan.startDate = await date;
    if (planPresenter.plan.startDate == null) return;

    syncEnd();
    setPeriod();
    update();
  }

  void startDateIncreased() {
    initDates();

    planPresenter.plan.startDate = planPresenter
        .plan.startDate!.add(const Duration(days: 1));

    syncEnd();
    setPeriod();
  }

  void startDateDecreased() {
    initDates();

    planPresenter.plan.startDate = planPresenter
        .plan.startDate!.subtract(const Duration(days: 1));

    setPeriod();
  }

  void endDateSelected() async {
    initDates();

    Future<DateTime?> date = showDatePicker(
      context: Get.context!,
      initialDate: planPresenter.plan.endDate!,
      firstDate: Plan.today.subtract(const Duration(days: 30)),
      lastDate: Plan.today.add(const Duration(days: max)),
    );
    planPresenter.plan.endDate = await date;
    if (planPresenter.plan.endDate == null) return;

    syncStart();
    setPeriod();
  }

  void endDateIncreased() {
    initDates();

    planPresenter.plan.endDate = planPresenter
        .plan.endDate!.add(const Duration(days: 1));

    setPeriod();
  }

  void endDateDecreased() {
    initDates();

    planPresenter.plan.endDate = planPresenter
        .plan.endDate!.subtract(const Duration(days: 1));

    syncStart();
    setPeriod();
  }

  void periodSelected(int period) {
    initDates();

    this.period = period;
    planPresenter.plan.endDate = planPresenter
        .plan.startDate!.add(Duration(days: period - 1));

    update();
  }

  void periodIncreased() { if (period < max) period++; update(); }
  void periodDecreased() { if (period > 1) period--; update(); }

}
