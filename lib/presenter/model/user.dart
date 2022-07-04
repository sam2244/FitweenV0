import 'package:cloud_firestore/cloud_firestore.dart';
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
  double defaultWeight = FWUser.defaultWeight;
  double defaultHeight = FWUser.defaultHeight;

  FWUser user = FWUser();

  List<String> getNullData() {
    return toJson().entries.where(
      (entry) => FWUser.isRequired(entry.key) && entry.value == null
    ).map((entry) => entry.key).toList();
  }

  // json 데이터를 user 객체에 주입
  Future fromJson(Map<String, dynamic> json) async {
    Map<String, dynamic> map = toJson();
    map.addAll(json);
    map['role'] = FWUser.toRole(json['role']);
    map['sex'] = FWUser.toSex(json['sex']);
    map['height'] = json['height'] ?? defaultHeight;
    map['weights'] = <DateTime, double>{
      if (json['weights'] != null)
      for (var data in json['weights'].map((data) => MapEntry<DateTime, double>(
        data['date'].toDate(), data['weight'],
      ))) data.key : data.value,
    };
    map['trainerPlans'] ??= await planPresenter.loadDB(json['trainerUid']);
    map['traineePlans'] ??= await planPresenter.loadDB(json['traineeUid']);
    map['friends'] ??= await loadDB(json['friends']);
    map['dateOfBirth'] = json['dateOfBirth']?.toDate();
    map['categories'] = json['categories'] ?? <String>[];
    user.fromMap(map);
    update();
  }

  // user 객체에서 json 데이터 추출
  Map<String, dynamic> toJson() => {
    'uid': user.uid,
    'email': user.email,
    'nickname': user.nickname,
    'imageUrl': user.imageUrl,
    'role': user.role.name,
    'sex': user.sex?.name,
    'height': user.height,
    'weights': user.weights?.entries.map((data) => {
      'date': Timestamp.fromDate(data.key),
      'weight': data.value,
    }).toList(),
    'dateOfBirth': user.dateOfBirth == null
        ? null : Timestamp.fromDate(user.dateOfBirth!),
    'friends': FWUser.toUids(user.friends),
    'trainerPlanIds': Plan.toIds(user.trainerPlans),
    'traineePlanIds': Plan.toIds(user.traineePlans),
  };

  // 닉네임 설정
  set nickname(String nickname) { user.nickname = nickname; update(); }

  // 역할 변경
  void toggleRole() { user.toggleRole(); update(); }

  // 성별 변경
  void setSex(Sex sex) { user.setSex(sex); update(); }

  // 생년월일 설정
  void setDateOfBirth(String string) {
    user.dateOfBirth = DateTime.parse(
      '${int.parse(string.substring(2)) > 50 ? '19' : '20'}$string'
    );
  }

  // 로그인, 로그아웃
  void login() { logged = true; update(); }
  void logout() { logged = false; update(); }

  // 신규 사용자 여부
  bool isNewUser() => user.nickname == null;

  // 본인 여부
  bool isMe(FWUser stranger) => stranger.uid == user.uid;

  void setInitWeight() {
    user.weights = {};
    user.weights![Plan.today] = defaultWeight;
    update();
  }

  // firebase 에서 로드된 데이터 가공 후 user 객체로 반환
  Future<FWUser?> loadDB(String? uid) async {
    if (uid == null) return null;
    var data = await FirebasePresenter.f.collection('users').doc(uid).get();
    Map<String, dynamic> json = data.data() ?? toJson();

    if (data.exists) await fromJson(json);

    return user;
  }

  // 로컬 데이터로 firebase 최신화
  void updateDB() => FirebasePresenter.f.collection('users').doc(user.uid).set(toJson());
}