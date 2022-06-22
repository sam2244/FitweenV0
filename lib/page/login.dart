import 'package:fitween1/config/Palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.put(FitweenUser());

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 10.0),
              child: Column(
                children: <Widget>[
                  Image.asset('img/fitweenV1.png'),
                  const SizedBox(height: 80.0),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
            //const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.background, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          await user.fitweenLogin();
                          if (user.name != null) Get.toNamed('/home');
                        },
                        child: const Text('Google Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}