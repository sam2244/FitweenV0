import 'package:fitween1/view/page/add_info/add_info.dart';
import 'package:fitween1/view/page/add_plan/add_diet.dart';
import 'package:fitween1/view/page/add_plan/add_plan.dart';
import 'package:fitween1/view/page/add_plan/add_todo.dart';
import 'package:fitween1/view/page/chat/chat.dart';
import 'package:fitween1/view/page/chatroom/chatroom.dart';
import 'package:fitween1/view/page/detail/detail.dart';
import 'package:fitween1/view/page/developer.dart';
import 'package:fitween1/view/page/login/login.dart';
import 'package:fitween1/view/page/main/trainee/trainee.dart';
import 'package:fitween1/view/page/main/trainer/trainer.dart';
import 'package:fitween1/view/page/my/my.dart';
import 'package:fitween1/view/page/onboarding/onboarding.dart';
import 'package:fitween1/view/page/register/register.dart';
import 'package:fitween1/view/page/scheduler/scheduler.dart';
import 'package:fitween1/view/page/my/setting/setting.dart';
import 'package:fitween1/view/page/my/editName/editName.dart';
import 'package:fitween1/view/page/my/editHeight/editHeight.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FWRoute {
  static Map<String, Widget> get pages => {
    '/login': const LoginPage(),
    '/register': const RegisterPage(),
    '/main/trainer': const TrainerMainPage(),
    '/main/trainee': const TraineeMainPage(),
    '/chat': const ChatPage(),
    '/chatroom': const ChatroomPage(),
    '/scheduler': const SchedulerPage(),
    '/addPlan': const AddPlanPage(),
    '/addInfo': const AddInfoPage(),
    '/my': const MyPage(),
    '/developer': const DeveloperPage(),
    '/setting': const SettingPage(),
    '/editHeight': const EditHeightPage(),
    '/editName': const EditNamePage(),
    '/detail/trainer': const TrainerDetailPage(),
    '/onboarding': const OnboardingPage(),
    '/addTodo': const AddTodoPage(),
    '/addDiet': const AddDietPage(),
  };

  static const Transition transition = Transition.fadeIn;
  static const Duration duration = Duration.zero;

  static List<GetPage> get getPages => pages.entries.map((page) => GetPage(
    name: page.key,
    page: () => page.value,
    transition: transition,
    transitionDuration: duration,
  )).toList();
}
