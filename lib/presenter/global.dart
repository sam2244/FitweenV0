import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_info.dart';
import 'package:fitween1/presenter/page/add_plan.dart';
import 'package:fitween1/presenter/page/chat.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/presenter/page/register.dart';
import 'package:fitween1/presenter/page/setting.dart';
import 'package:get/get.dart';

class Global extends GetxController {
  int navIndex = 0;

  static final userPresenter = Get.find<UserPresenter>();

  void navigate(int index) {
    navIndex = index;
    Get.offAllNamed(
      [
        '/main/${userPresenter.user.role.name}',
        '/chat',
        '/my',
      ][navIndex],
    );
    update();
  }

  static void initControllers() {
    Get.put(Global());
    Get.put(FWTheme());
    Get.put(UserPresenter());
    Get.put(PlanPresenter());
    Get.put(RegisterPresenter());
    Get.put(ChatPresenter());
    Get.put(AddInfoPresenter());
    Get.put(AddPlanPresenter());
    Get.put(MyPresenter());
    Get.put(SettingPresenter());
    Get.put(TrainerPresenter());
  }
}
