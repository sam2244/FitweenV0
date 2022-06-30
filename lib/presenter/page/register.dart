import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/page/register/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 회원가입 페이지 프리젠터
class RegisterPresenter extends GetxController {
  int pageIndex = 0;
  bool invalid = false;

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static final userPresenter = Get.put(UserPresenter());
  static final nicknameCont = TextEditingController();
  static final carouselCont = CarouselController();

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < CarouselView.widgetCount - 1) pageIndex++;
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) pageIndex--;
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    LoginPresenter.fitweenGoogleLogout();
    nicknameCont.clear();
    if (pageIndex == 0) Get.back();
    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() async {
    if (pageIndex == 0) {
      if (nicknameCont.text == '') {
        validateInput();
        return;
      }
      nicknameSubmitted(nicknameCont.text);
    }
    else if (pageIndex == CarouselView.widgetCount - 1) {
      Get.offAllNamed('/main/${userPresenter.user.role.name}');
      userPresenter.updateDB();
      return;
    }

    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  // 입력값 검사 후 잘못되었을 때 효과 트리거
  void validateInput() async {
    invalid = true; update();
    await Future.delayed(shakeDuration, () {
      invalid = false; update();
    });
  }

  // 닉네임 제출 버튼 클릭 트리거 (닉네임 인풋 박스에서 Enter 버튼 클릭 트리거)
  void nicknameSubmitted(String value) {
    userPresenter.nickname = value;
  }

  // 역할 선택 버튼 트리거
  void roleSelected(Role role) {
    if (role != userPresenter.user.role) userPresenter.toggleRole();
    update();
  }

  //
}