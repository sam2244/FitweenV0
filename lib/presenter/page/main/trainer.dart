import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 트레이너 페이지 프리젠터
class TrainerPresenter extends GetxController {
  int pageIndex = 0;
  bool selectMod = false;

  static List<String> categories() => ['삼손', '암스트롱', '청풍'];

  static List<Trainee> trainees() => const [
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 2),
        Trainee(category: '삼손', name: '정윤석', total: 5, completed: 5),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 3),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 0),
        Trainee(category: '암스트롱', name: '정윤석', total: 5, completed: 2),
        Trainee(category: '청풍', name: '정윤석', total: 5, completed: 4),
        Trainee(category: '청풍', name: '정윤석', total: 5, completed: 5),
      ];
  static int widgetCount = categories().length;
  static int traineeCount = trainees().length;
  static List<bool> traineeCheck = List.filled(traineeCount, false);

  static Curve transitionCurve = Curves.fastOutSlowIn;
  static const Duration transitionDuration = Duration(milliseconds: 300);
  static final carouselCont = CarouselController();

  // 현재 페이지 인덱스 증가
  void pageIndexIncrease() {
    if (pageIndex < widgetCount) {
      pageIndex++;
    } else {
      pageIndex = 0;
    }
    update();
  }

  // 현재 페이지 인덱스 감소
  void pageIndexDecrease() {
    if (pageIndex > 0) {
      pageIndex--;
    } else {
      pageIndex = widgetCount;
    }
    update();
  }

  // 뒤로가기 버튼 클릭 트리거
  void backPressed() {
    carouselCont.previousPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexDecrease();
  }

  // 다음 버튼 클릭 트리거
  void nextPressed() {
    carouselCont.nextPage(
      curve: transitionCurve,
      duration: transitionDuration,
    );
    pageIndexIncrease();
  }

  // 다음 버튼 클릭 트리거
  void indexChanged(int index) {
    pageIndex = index;
    update();
  }

  void modChange(bool mod) {
    selectMod = mod;
    update();
  }

  void toggleSelectState(int index) {
    traineeCheck[index] = !traineeCheck[index];
    update();
  }

  void resetSelectState() {
    traineeCheck = List.filled(traineeCount, false);
    update();
  }
}

class Trainee {
  final String category;
  final String name;
  final int total;
  final int completed;

  const Trainee({
    required this.category,
    required this.name,
    required this.total,
    required this.completed,
  });
}
