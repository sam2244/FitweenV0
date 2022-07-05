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
  List<bool> invalids = [false, false];

  static const Duration shakeDuration = Duration(milliseconds: 500);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);

  static final userPresenter = Get.find<UserPresenter>();
  static final nicknameCont = TextEditingController();
  static final dateOfBirthCont = TextEditingController();
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
    if (pageIndex == 0) {
      LoginPresenter.fitweenGoogleLogout();
      Get.back();
    }

    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    if (pageIndex == 0) {
      if (nicknameCont.text == '') {
        validate(0);
        return;
      }
      nicknameSubmitted(nicknameCont.text);
    }
    else if (pageIndex == 2) {
      if (userPresenter.user.sex == null) { validate(0); return; }
      if (int.tryParse(dateOfBirthCont.text) == null) { validate(1); return; }
      if (dateOfBirthCont.text.length != 6) { validate(1); return; }

      userPresenter.setDateOfBirth(dateOfBirthCont.text);
    }
    else if (pageIndex == CarouselView.widgetCount - 1) {
      userPresenter.setInitWeight();
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

  // 잘못되었을 때 효과 트리거
  void validate(index) async {
    invalids[index] = true; update();
    await Future.delayed(shakeDuration, () {
      invalids[index] = false; update();
    });
  }

  // 닉네임 제출 버튼 클릭 트리거 (닉네임 인풋 박스에서 Enter 버튼 클릭 트리거)
  void nicknameSubmitted(String value) {
    userPresenter.nickname = value; update();
  }

  // 역할 선택 버튼 트리거
  void roleSelected(Role role) {
    if (role != userPresenter.user.role) userPresenter.toggleRole();
    update();
  }

  // 성별 선택 버튼 트리거
  void sexSelected(Sex sex) {
    userPresenter.setSex(sex); update();
  }

  // 생년월일 변경 트리거
  void dateOfBirthChanged(DateTime dateOfBirth) {
    userPresenter.user.dateOfBirth = dateOfBirth;
    update();
  }

  // 체중 변경 트리거
  void weightChanged(double weight) {
    userPresenter.currentWeight = weight;
    update();
  }

  // 신장 변경 트리거
  void heightChanged(double height) {
    userPresenter.user.height = height;
    update();
  }
}