import 'package:get/get.dart';

class SplashPresenter {
  static const Duration duration = Duration(milliseconds: 2000);
  static void toRoute() => Get.offAllNamed('/login');
}