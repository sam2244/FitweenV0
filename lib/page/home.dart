import 'package:fitween1/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.put(FitweenUser());

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.role} ${user.nickname}!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            user.fitweenGoogleLogout();
            Get.offAllNamed('login');
          },
          child: const Text('logout'),
        ),
      ),
    );
  }
}