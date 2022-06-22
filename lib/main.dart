import 'package:fitween1/page/home.dart';
import 'package:fitween1/page/login.dart';
import 'package:fitween1/page/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      ],
      // initialRoute: '/',
      // routes: {
      //   '/login': (context) => const LoginPage(),
      //   '/home' : (context) => const MainScreen(title: ''),
      //   //'/chat' : (context) => const ChatScreen(title: ''),
      //   //'/chatting' : (context) => ChatPage(),
      //   //'explore' : (context) => const ExploreScreen(title: ''),
      // },
      // onGenerateRoute: _getRoute,
    );
  }
  //
  // Route<dynamic>? _getRoute(RouteSettings settings) {
  //   if (settings.name != '/login') {
  //     return null;
  //   }
  //
  //   return MaterialPageRoute<void>(
  //     settings: settings,
  //     builder: (BuildContext context) => const LoginPage(),
  //     fullscreenDialog: true,
  //   );
  // }
}