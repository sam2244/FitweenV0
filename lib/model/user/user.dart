import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/google_login.dart';
import 'package:get/get.dart';

class FitweenUser extends GetxController {
  static const String defaultProfile = '';

  bool logged = true;

  String? uid;
  String? name;
  String? email;
  String? nickname;
  String imageUrl = defaultProfile;
  String? statusMsg;
  late String role;
  List<String> trainerPlanIds = [];
  List<String> traineePlanIds = [];

  FitweenUser({
    this.uid,
    this.name,
    this.email,
    this.role = 'trainee',
    this.imageUrl = defaultProfile,
    this.statusMsg,
  });

  FitweenUser.fromJson(Map<String, dynamic> json) {
    fromJson(json);
  }

  void fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    nickname = json['nickname'];
    imageUrl = json['imageUrl'];
    statusMsg = json['statusMsg'];
    role = json['role'];
    trainerPlanIds = json['trainerPlanIds'].cast<String>();
    traineePlanIds = json['traineePlanIds'].cast<String>();
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'statusMsg': statusMsg,
    'role': role,
    'trainerPlanIds': trainerPlanIds,
    'traineePlanIds': traineePlanIds,
  };

  // 닉네임 설정
  void setNickname(String? value) {
    nickname = value; update();
  }

  // 역할 변경
  void toggleRole() {
    role = role == 'trainer' ? 'trainee' : 'trainer';
  }

  /// firebase

  // 피트윈 로그인
  Future fitweenGoogleLogin() async {
    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential == null) {
      logged = false;
    }
    else {
      User? user = userCredential.user;

      var json = await loadDB(user!.uid);
      Map<String, dynamic>? jsonData = json.data();

      if (jsonData == null) {
        uid = user.uid;
        name = user.displayName;
        email = user.email;

        updateDB();
        return;
      }
      fromJson(jsonData);

      // 기존 회원
      if (json.exists) {
        nickname = json['nickname'];
        imageUrl = jsonData['imageUrl'] ?? FitweenUser.defaultProfile;
        role = jsonData['role'];
      }

      uid = user.uid;
      name = user.displayName;
      email = user.email;

      updateDB();

      fromJson(jsonData);
      updateDB();
      logged = true;
    }

    update();
  }

  // 피트윈 로그아웃
  void fitweenGoogleLogout() {
    signOutWithGoogle();
    logged = false;
    uid = null;
    name = null;
    email = null;
    imageUrl = FitweenUser.defaultProfile;
    nickname = null;
  }

  // firebase 에서 데이터 불러오기
  Future loadDB(String uid) async {
    return (await instance.collection('users').doc(uid).get());
  }

  // firebase 에 데이터 최신화
  void updateDB() {
    instance.collection('users').doc(uid).set(toJson());
  }
}
