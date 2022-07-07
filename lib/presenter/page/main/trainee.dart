import 'package:fitween1/presenter/model/user.dart';
import 'package:get/get.dart';

class TraineePresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();
  static void addPlanButtonPressed() => Get.toNamed('/addPlan');
}