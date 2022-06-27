import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/firebase/firebase.dart';
import 'package:fitween1/presenter/page/register.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/page/login/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

// 로그인 페이지 프리젠터
class LoginPresenter {
  static final a = FirebasePresenter.a;
  static final userPresenter = Get.find<UserPresenter>();
  static final registerPresenter = Get.find<RegisterPresenter>();

  // 로그인 버튼 클릭 트리거
  static VoidCallback loginButtonPressed(LoginType type) {
    registerPresenter.pageIndex = 0;
    if (type == LoginType.google) { return LoginPresenter.googleLoginButtonPressed; }
    else if (type == LoginType.apple) { return LoginPresenter.appleLoginButtonPressed; }
    return () {};
  }

  // 구글 로그인 버튼 클릭 트리거
  static void googleLoginButtonPressed() async {
    await fitweenGoogleLogin();

    // 로그인 성공
    if (userPresenter.logged) {
      // 닉네임 없으면 회원가입으로 이동
      if (userPresenter.isNewUser()) { Get.toNamed('/register'); }
      else { Get.offAllNamed('/main/${userPresenter.user.role.name}'); }
    }
  }

  // 애플 로그인 버튼 클릭 트리거
  static void appleLoginButtonPressed() => print('Not implemented Yet');

  // 구글 로그인
  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    if (googleAuth == null) return null;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await a.signInWithCredential(credential);
  }

  // 구글 로그아웃
  static void signOutWithGoogle() => a.signOut();

  // 구글 아이디로 피트윈 로그인
  static Future fitweenGoogleLogin() async {
    UserCredential? userCredential = await signInWithGoogle();

    if (userCredential == null) { userPresenter.logout(); }
    else {
      User? loggedUser = userCredential.user;
      await userPresenter.loadDB(loggedUser!.uid);

      // firebase 에 사용자 정보가 존재하지 않는 경우
      if (userPresenter.user.uid == null) {
        Map<String, dynamic> map = userPresenter.user.toMap();
        Map<String, dynamic> updateMap = {
          'uid': loggedUser.uid,
          'name': loggedUser.displayName,
          'email': loggedUser.email,
          'imageUrl': UserPresenter.defaultProfile,
          'role': Role.trainee,
        };
        map.updateAll((key, value) => updateMap[key]);

        userPresenter.user.fromMap(map);
        userPresenter.updateDB();
      }

      userPresenter.login();
    }
  }

  // 구글 아이디로 피트윈 로그아웃
  static void fitweenGoogleLogout() {
    signOutWithGoogle();
    userPresenter.user = FWUser();
  }

}