import 'package:get/get.dart';

class SplashPresenter {
  static const Duration duration = Duration(milliseconds: 1000);
  static void toRoute() => Get.offAllNamed('/login');
}