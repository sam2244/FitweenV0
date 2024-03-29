import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/add_info.dart';
import 'package:fitween1/presenter/page/add_plan/add_diet.dart';
import 'package:fitween1/presenter/page/add_plan/add_plan.dart';
import 'package:fitween1/presenter/page/add_plan/add_todo.dart';
import 'package:fitween1/presenter/page/before_main/onboarding.dart';
import 'package:fitween1/presenter/page/before_main/register.dart';
import 'package:fitween1/presenter/page/detail.dart';
import 'package:fitween1/presenter/page/main/trainee.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/presenter/page/chat/chat.dart';
import 'package:fitween1/presenter/page/chat/chatroom.dart';
import 'package:fitween1/presenter/page/my/my.dart';
import 'package:fitween1/presenter/page/my/setting.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/popup.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalPresenter extends GetxController {
  int navIndex = 0;
  bool loading = false;

  static final userPresenter = Get.find<UserPresenter>();
  static final planPresenter = Get.find<PlanPresenter>();
  static final trainerPresenter = Get.find<TrainerPresenter>();
  static final traineePresenter = Get.find<TraineePresenter>();

  void navigate(int index) async {
    navIndex = index;
    Get.offAllNamed(
      [
        '/main/${userPresenter.user.role.name}',
        '/chat',
        '/my',
      ][navIndex],
    );

    trainerPresenter.initialize();
    traineePresenter.initialize();

    await Future.delayed(const Duration(milliseconds: 1000), () {
      loading = true;
      update();
    });
    loading = false;
    await userPresenter.loadPlans();
    await userPresenter.loadFriends();
    update();
  }

  static void profilePressed(FWUser user) {
    ThemeData themeData = Theme.of(Get.context!);

    Get.dialog(
      FWDialog(
        rightLabel: '채팅',
        rightPressed: () {
          Get.back();
          Get.toNamed('/chatroom');
        },
        child: Row(
          children: [
            ProfileImageRect(user: user),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FWText(
                  user.nickname!,
                  style: themeData.textTheme.labelLarge,
                  color: themeData.colorScheme.onSurface,
                ),
                const SizedBox(height: 4.0),
                FWText(
                  user.statusMessage ?? '',
                  style: themeData.textTheme.labelSmall,
                  color: themeData.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void imageUpload(context, ThemeData themeData) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context) {
        return Container(
          height: 175,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)
              )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 7.5),
                  width: 311,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: FWText(
                      '갤러리',
                      size: 15.0,
                      style: Theme.of(context).textTheme.titleMedium,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0.0, 7.5, 0.0, 10.0),
                  width: 311,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary,
                      side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: FWText(
                      '카메라',
                      size: 15.0,
                      style: Theme.of(context).textTheme.titleMedium,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void initControllers() {
    Get.put(GlobalPresenter());
    Get.put(FWTheme());
    Get.put(OnboardingPresenter());
    Get.put(UserPresenter());
    Get.put(PlanPresenter());
    Get.put(RegisterPresenter());
    Get.put(ChatPresenter());
    Get.put(ChatroomPresenter());
    Get.put(AddInfoPresenter());
    Get.put(AddPlanPresenter());
    Get.put(AddTodoPresenter());
    Get.put(AddDietPresenter());
    Get.put(MyPresenter());
    Get.put(SettingPresenter());
    Get.put(TrainerPresenter());
    Get.put(TraineePresenter());
    Get.put(TrainerDetailPresenter());
  }
}
