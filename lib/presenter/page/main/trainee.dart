import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:get/get.dart';

class TraineePresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();
  static final planPresenter = Get.find<PlanPresenter>();
  static final traineePresenter = Get.find<TraineePresenter>();
  static final codeCont = TextEditingController();

  late List<Plan> plans;

  void initialize() {
    plans = userPresenter.user.traineePlans ?? [];
    for (Plan plan in plans) {
      planPresenter.plan = plan;
      planPresenter.loadTrainee();
    }
  }

  static void joinPlanButtonPressed() {
    Get.dialog(
      FWDialog(
        rightPressed: codeSubmitted,
        title: '플랜의 코드를 입력하세요.',
        child: Center(
          child: FWInputField(
            controller: codeCont,
            hintText: '6자리 코드',
          ),
        ),
      ),
    );
  }

  static void codeSubmitted() async {
    Plan plan = await PlanPresenter.loadDB(codeCont.text);
    FWUser user = FWUser.fromMap(userPresenter.user.toMap());
    plan.trainee = FWUser.fromMap(user.toMap());
    plan.trainee!.traineePlanIds.add(plan.id!);
    plan.traineeUid = user.uid;
    UserPresenter.updateDB(plan.trainee!);
    PlanPresenter.updateDB(plan);
    planPresenter.plan = plan;
    await userPresenter.loadPlans();
    await planPresenter.loadTrainee();
    traineePresenter.initialize();
    Get.back();
  }

  static void addMorePlanButtonPressed() {
    Get.dialog(
      FWDialog(
        rightPressed: additionalCodeSubmitted,
        title: '플랜의 코드를 입력하세요.',
        child: Center(
          child: FWInputField(
            controller: codeCont,
            hintText: '6자리 코드',
          ),
        ),
      ),
    );
  }

  static void additionalCodeSubmitted() async {
    Plan plan = await PlanPresenter.loadDB(codeCont.text);
    FWUser user = FWUser.fromMap(userPresenter.user.toMap());
    plan.trainee = FWUser.fromMap(user.toMap());
    plan.trainee!.traineePlanIds.add(plan.id!);
    plan.traineeUid = user.uid;
    UserPresenter.updateDB(plan.trainee!);
    PlanPresenter.updateDB(plan);
    planPresenter.plan = plan;
    await userPresenter.loadPlans();
    await planPresenter.loadTrainee();
    traineePresenter.initialize();
    Get.back();
  }
}

