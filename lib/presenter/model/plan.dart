import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/presenter/firebase/firebase.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:get/get.dart';

// 플랜 모델 프리젠터
class PlanPresenter extends GetxController {
  static final userPresenter = Get.find<UserPresenter>();
  Plan plan = Plan();

  // json 데이터를 plan 객체에 주입
  Future fromJson(Map<String, dynamic> json) async {
    Map<String, dynamic> map = {...json};
    map['trainer'] ??= await userPresenter.loadDB(json['trainerUid']);
    map['trainee'] ??= await userPresenter.loadDB(json['traineeUid']);
    map['startDate'] = json['startDate'] as DateTime;
    map['endDate'] = json['endDate'] as DateTime;
    plan.fromMap(map);
    update();
  }

  // plan 객체에서 json 데이터 추출
  Map<String, dynamic> toJson() => {
    'id': plan.id,
    'state': plan.state.toString(),
    'trainerUid': plan.trainer?.uid,
    'trainee': plan.trainee?.uid,
    'startDate': plan.startDate as Timestamp,
    'endDate': plan.endDate as Timestamp,
  };

  // firebase 에서 로드된 데이터 가공 후 plan 객체로 반환
  Future<Plan?> loadDB(String? id) async {
    if (id == null) return null;
    var data = await FirebasePresenter.f.collection('plans').doc(id).get();
    Map<String, dynamic> json = data.data() ?? {};
    if (data.exists) await fromJson(json);

    return plan;
  }

  // 로컬 데이터로 firebase 최신화
  void updateDB() {
    FirebasePresenter.f.collection('plans').doc(plan.id).set(toJson());
  }
}