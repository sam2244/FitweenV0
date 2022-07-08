import 'package:fitween1/model/plan/diet.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDietPresenter extends GetxController {
  static List<String> types = const ['아침', '점심', '저녁'];

  int updateIndex = -1;
  Diet? diet;

  static final dietCont = TextEditingController();
  static final addPlanPresenter = Get.find<AddPlanPresenter>();

  void backPressed() {
    Get.back();
    initialize();
  }

  void nextPressed() {
    if (diet == null) return;
    diet!.description = dietCont.text;
    dietCont.clear();
    if (updateIndex < 0) { addPlanPresenter.addDiet(diet!); }
    else { addPlanPresenter.updateDiet(diet!); }
    backPressed();
  }

  void initialize([Diet? diet]) {
    this.diet = diet ?? Diet(
      description: '',
      type: '시간',
      selectedDays: [...addPlanPresenter.selectedDays],
    );
    dietCont.text = this.diet?.description ?? '';
  }

  void typeSelected(String type) {
    diet?.type = type; update();
  }

}