import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:get/get.dart';

class TraineePresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();
  static final addPlanPresenter = Get.find<AddPlanPresenter>();
  static void addPlanButtonPressed() {
    Get.toNamed('/addPlan');
    addPlanPresenter.initialize();
  }
}