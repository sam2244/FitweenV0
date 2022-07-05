import 'package:fitween1/firebase_options.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/global.dart';
import 'package:fitween1/route.dart';
import 'package:fitween1/view/page/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'fitween',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Fitween());
}

class Fitween extends StatelessWidget {
  const Fitween({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalPresenter.initControllers();

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<FWTheme>(
          builder: (controller) {
            return GetMaterialApp(
              title: 'Fitween',
              debugShowCheckedModeBanner: false,
              themeMode: controller.mode,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: FWTheme.lightScheme,
                textTheme: FWTheme.textTheme,
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: FWTheme.darkScheme,
                textTheme: FWTheme.textTheme,
              ),
              home: const SplashPage(),
              // home: const DeveloperPage(),
              getPages: FWRoute.getPages,
            );
          }
        );
      }
    );
  }
}