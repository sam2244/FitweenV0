import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 트레이너 페이지 프리젠터
class TrainerPresenter extends GetxController {
  int pageIndex = 0;
  String currentGroup = '전체 보기';
  bool selectMode = false;

  late List<Plan> plans;
  late List<String> categories;
  late int planCount;
  late List<bool> planSelected;

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);
  static final carouselCont = CarouselController();

  static final userPresenter = Get.find<UserPresenter>();
  static final planPresenter = Get.find<PlanPresenter>();
  static final addPlanPresenter = Get.find<AddPlanPresenter>();

  static void addPlanButtonPressed() {
    Get.toNamed('/addPlan');
    addPlanPresenter.initialize();
  }

  void initialize() async {
    await userPresenter.loadPlans();
    plans = userPresenter.user.trainerPlans ?? [];
    categories = userPresenter.allCategories;
    planCount = plans.length;
    planSelected = List.filled(planCount, false);
    for (Plan plan in plans) {
      planPresenter.plan = plan;
      await planPresenter.loadTrainer();
      await planPresenter.loadTrainee();
    }
    update();
  }

  void countPlans() {
    planCount = plans.where((plan) => plan.group == currentGroup).length;
    update();
  }

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (categories.isEmpty) return;
    pageIndex = (pageIndex + 1) % categories.length;
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (categories.isEmpty) return;
    pageIndex = (pageIndex - 1) % categories.length;
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    if (categories.isEmpty) return;
    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    if (categories.isEmpty) return;
    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  void planTilePressed({Plan? plan, int? index}) {
    if (selectMode) {
      toggleSelectState(index!);
    } else {
      // 트레이너가 피트위너를 등록하는 방법
      initialize();
      Get.toNamed('/detail/trainer', arguments: plan);
    }
  }

  void pageChanged(int index) {
    pageIndex = index;
    update();
  }

  void changeMode(bool mode) {
    selectMode = mode;
    update();
  }

  void toggleSelectState(int index) {
    planSelected[index] = !planSelected[index];
    update();
  }

  void resetSelectState() {
    planSelected = List.filled(planCount, false);
    update();
  }
}

class Trainee {
  final String category;
  final String name;
  final int total;
  final int completed;

  const Trainee({
    required this.category,
    required this.name,
    required this.total,
    required this.completed,
  });
}
