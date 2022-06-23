import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    this.nickname,
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

  // 피트윈 로그인
  Future fitweenGoogleLogin() async {
    var instance = FirebaseFirestore.instance;

    UserCredential? userCredential = await signInWithGoogle();
    if (userCredential == null) {
      logged = false;
    }
    else {
      User? user = userCredential.user;

      var json = await instance.collection('users').doc(user!.uid).get();
      Map<String, dynamic>? jsonData = json.data();

      if (jsonData == null) return;
      fromJson(jsonData);

      // 기존 회원
      if (json.exists) {
        nickname = jsonData['nickname'];
        imageUrl = jsonData['imageUrl'] ?? FitweenUser.defaultProfile;
        role = jsonData['role'];
      }

      uid = user.uid;
      name = user.displayName;
      email = user.email;

      instance.collection('users').doc(uid).set(toJson());

      fromJson(jsonData);
      instance.collection('users').doc(uid).set(toJson());
      logged = true;
    }
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

  void setNickname(String value) => nickname = value;
  void toggleRole() {
    role = role == 'trainer' ? 'trainee' : 'trainer';

    var instance = FirebaseFirestore.instance;
    instance.collection('users').doc(uid).set(toJson());
  }
}
