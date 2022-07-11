import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/firebase/firebase.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:get/get.dart';

// 사용자 모델 프리젠터
class UserPresenter extends GetxController {
  static final planPresenter = Get.find<PlanPresenter>();
  static const String defaultProfile = 'https://firebasestorage.googleapis.com/v0/b/fitween-v1.appspot.com/o/users%2Fguest.png?alt=media&token=906ce482-e8ce-47e9-814a-6da7e3d5365c';
  bool logged = false;
  double currentWeight = FWUser.defaultWeight;
  double currentHeight = FWUser.defaultHeight;

  FWUser user = FWUser();

  List<String> getNullData() {
    return user.toJson().entries.where(
      (entry) => FWUser.isRequired(entry.key) && entry.value == null
    ).map((entry) => entry.key).toList();
  }

  // 닉네임 설정
  set nickname(String nickname) { user.nickname = nickname; update(); }

  // 신장 설정
  set height(double height) { user.height = height; update(); }

  // 역할 변경
  void toggleRole() { user.toggleRole(); update(); }

  // 성별 변경
  void setSex(Sex sex) { user.setSex(sex); update(); }

  // 로그인, 로그아웃
  void login() { logged = true; update(); }
  void logout() { logged = false; update(); }

  // 신규 사용자 여부
  bool isNewUser() => user.nickname == null;

  // 본인 여부
  bool isMe(FWUser stranger) => stranger.uid == user.uid;

  void setInitWeight() {
    user.weights = {};
    user.weights![Plan.today] = currentWeight;
    update();
  }

  List<String> get allCategories {
    List<String> categories = [];
    for (Plan plan in user.trainerPlans ?? []) {
      if (plan.group != null) categories.add(plan.group!);
    }
    return categories;
  }


  Future loadFriends() async {
    user.friends = [];
    for (String uid in user.friendUids) {
      user.friends!.add((await UserPresenter.loadDB(uid)));
    }
    update();
  }

  Future loadPlans() async {
    user.trainerPlans = [];
    user.traineePlans = [];
    for (String id in user.trainerPlanIds) {
      user.trainerPlans!.add((await PlanPresenter.loadDB(id)));
    }
    for (String id in user.traineePlanIds) {
      user.traineePlans!.add((await PlanPresenter.loadDB(id)));
    }
    update();
  }

  // firebase 에서 로드된 데이터 가공 후 user 객체로 반환
  static Future<FWUser> loadDB(String uid) async {
    FWUser user = FWUser();

    var data = await FirebasePresenter.f.collection('users').doc(uid).get();
    Map<String, dynamic> json = data.data() ?? {};

    if (data.exists) await user.fromJson(json);

    return user;
  }

  // 로컬 데이터로 firebase 최신화
  static void updateDB(FWUser user) => FirebasePresenter.f.collection('users').doc(user.uid).set(user.toJson());

  static void deleteDB(FWUser user) => FirebasePresenter.f.collection('users').doc(user.uid).delete();
}