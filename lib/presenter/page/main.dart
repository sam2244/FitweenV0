import 'package:fitween1/presenter/model/user.dart';
import 'package:get/get.dart';

// 메인 페이지 프리젠터
class MainPresenter {
  static final userPresenter = Get.put(UserPresenter());

  // 역할 선택 트리거
  static void toggleRole() {
    userPresenter.toggleRole();
    Get.offAllNamed('/main/${userPresenter.user.role.name}');
  }

  // dialog 닫기 버튼 클릭 트리거
  static void dialogClosed() => Get.back();

  // 로그아웃 버튼 클릭 트리거
  static void logoutButtonPressed() { userPresenter.logout(); Get.offAllNamed('/login'); }
}
