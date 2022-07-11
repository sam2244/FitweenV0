import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/main/trainee.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class GreetingPresenter {
  static const asset = 'assets/image/page/greeting/greeting.svg';
  static final picture = SvgPicture.asset(asset);
  static final userPresenter = Get.find<UserPresenter>();
  static final trainerPresenter = Get.find<TrainerPresenter>();
  static final traineePresenter = Get.find<TraineePresenter>();

  static void nextPressed(bool isNewUser) {
    trainerPresenter.initialize();
    traineePresenter.initialize();
    Get.offAllNamed(
      isNewUser ? '/register' : '/main/${userPresenter.user.role.name}',
    );
  }
}