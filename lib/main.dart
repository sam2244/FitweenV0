import 'package:fitween1/firebase_options.dart';
import 'package:fitween1/presenter/page/chat.dart';
import 'package:fitween1/presenter/page/register.dart';
import 'package:fitween1/presenter/model/plan.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/route.dart';
import 'package:fitween1/view/page/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'fitween',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserPresenter());
    Get.put(PlanPresenter());
    Get.put(RegisterPresenter());
    Get.put(ChatPresenter());

    return GetMaterialApp(
      title: 'Fitween',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashPage(),
      getPages: FWRoute.getPages,
    );
  }
}