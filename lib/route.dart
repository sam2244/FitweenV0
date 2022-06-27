import 'package:fitween1/view/page/add_plan/addPlan.dart';
import 'package:fitween1/view/page/chat/chat.dart';
import 'package:fitween1/view/page/login/login.dart';
import 'package:fitween1/view/page/main/trainee/trainee.dart';
import 'package:fitween1/view/page/main/trainer/trainer.dart';
import 'package:fitween1/view/page/register/register.dart';
import 'package:fitween1/view/page/scheduler/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FWRoute {
  static Map<String, Widget> get pages => const {
    '/login': LoginPage(),
    '/register': RegisterPage(),
    '/main/trainer': TrainerMainPage(),
    '/main/trainee': TraineeMainPage(),
    '/chat': ChatPage(),
    '/scheduler': SchedulerPage(),
    '/addPlan': AddPlanPage2(),
  };

  static const Transition transition = Transition.native;

  static List<GetPage> get getPages => pages.entries.map((page) => GetPage(
    name: page.key,
    page: () => page.value,
    transition: transition,
  )).toList();
}