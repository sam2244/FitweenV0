import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/firebase/firebase.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:get/get.dart';

// 플랜 모델 프리젠터
class PlanPresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();
  Plan plan = Plan();

  Future loadTrainer() async {
    if (plan.trainerUid == null) return;
    plan.trainer = await UserPresenter.loadDB(plan.trainerUid!);
    update();
  }
  Future loadTrainee() async {
    if (plan.traineeUid == null) return;
    plan.trainee = await UserPresenter.loadDB(plan.traineeUid!);
    update();
  }

  // firebase 에서 로드된 데이터 가공 후 plan 객체로 반환
  static Future<Plan> loadDB(String id) async {
    Plan plan = Plan(id: id);
    var data = await FirebasePresenter.f.collection('plans').doc(plan.id).get();
    Map<String, dynamic> json = data.data() ?? {};
    if (data.exists) plan.fromJson(json);

    return plan;
  }

  // 로컬 데이터로 firebase 최신화
  static void updateDB(Plan plan) {
    FirebasePresenter.f.collection('plans').doc(plan.id).set(plan.toJson());
  }
}