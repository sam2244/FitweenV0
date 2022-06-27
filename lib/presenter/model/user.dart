import 'package:fitween1/model/plan/plan.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/firebase/firebase.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:get/get.dart';

// 사용자 모델 프리젠터
class UserPresenter extends GetxController {
  static final planPresenter = Get.find<PlanPresenter>();
  static const String defaultProfile = '';
  bool logged = false;

  FWUser user = FWUser();

  // json 데이터를 user 객체에 주입
  Future fromJson(Map<String, dynamic> json) async {
    Map<String, dynamic> map = {...json};
    map['role'] = FWUser.toRole(json['role']);
    map['sex'] = FWUser.toSex(json['sex']);
    map['trainerPlans'] ??= await planPresenter.loadDB(json['trainerUid']);
    map['traineePlans'] ??= await planPresenter.loadDB(json['traineeUid']);
    user.fromMap(map);
    update();
  }

  // user 객체에서 json 데이터 추출
  Map<String, dynamic> toJson() => {
    'uid': user.uid,
    'name': user.name,
    'email': user.email,
    'nickname': user.nickname,
    'imageUrl': user.imageUrl,
    'statusMessage': user.statusMessage,
    'role': user.role.name,
    'sex': user.sex?.name,
    'height': user.height,
    'weight': user.weight,
    'trainerPlanIds': Plan.toIds(user.trainerPlans),
    'traineePlanIds': Plan.toIds(user.traineePlans),
  };

  // 닉네임 설정
  set nickname(String nickname) { user.nickname = nickname; update(); }

  // 역할 변경
  void toggleRole() { user.toggleRole(); update(); }

  // 로그인, 로그아웃
  void login() { logged = true; update(); }
  void logout() { logged = false; update(); }

  // 신규 사용자 여부
  bool isNewUser() => user.nickname == null;

  // 본인 여부
  bool isMe(FWUser stranger) => stranger.uid == user.uid;

  // firebase 에서 로드된 데이터 가공 후 user 객체로 반환
  Future<FWUser?> loadDB(String uid) async {
    var data = await FirebasePresenter.f.collection('users').doc(uid).get();
    Map<String, dynamic> json = data.data() ?? toJson();
    if (data.exists) await fromJson(json);

    return user;
  }

  // 로컬 데이터로 firebase 최신화
  void updateDB() => FirebasePresenter.f.collection('users').doc(user.uid).set(toJson());
}