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
  List<String> planIds = [];

  FitweenUser({
    this.uid,
    this.name,
    this.email,
    this.nickname,
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
    planIds = json['planIds'];
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'nickname': nickname,
    'imageUrl': imageUrl,
    'statusMsg': statusMsg,
    'planIds': planIds,
  };

  // 피트윈 로그인
  Future fitweenGoogleLogin() async {
    UserCredential userCredential;
    try { userCredential = await signInWithGoogle(); }
    catch (e) { return; }

    User? user = userCredential.user;
    if (user == null) return;

    uid = user.uid;
    name = user.displayName;
    email = user.email;
    imageUrl = user.photoURL ?? FitweenUser.defaultProfile;

    var instance = FirebaseFirestore.instance;
    var json = await instance.collection('users').doc(uid).get();
    var jsonData = json.data();

    if (jsonData == null) return;

    // 기존 회원
    if (json.exists) {
      nickname = jsonData['nickname'];
    }

    fromJson(jsonData);
    instance.collection('users').doc(uid).set(toJson());
    logged = true;
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
}
