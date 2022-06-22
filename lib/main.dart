import 'package:fitween1/firebase_options.dart';
import 'package:fitween1/page/home.dart';
import 'package:fitween1/page/login.dart';
import 'package:fitween1/page/register.dart';
import 'package:fitween1/page/splash.dart';
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
    return GetMaterialApp(
      title: 'Fitween',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const SplashPage(),
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
      ],
    );
  }
}