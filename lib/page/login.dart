import 'package:fitween1/config/palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Get.put(FitweenUser());

    return Scaffold(
      body: Container(
        color: Palette.dark,
        child: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: SvgPicture.asset('asset/img/logo/fitween.svg'),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: SizedBox()),
                    FitweenButton(
                      onPressed: () async {
                        await user.fitweenGoogleLogin();
                        if (user.logged && user.nickname == null) {
                          Get.toNamed('/register');
                        }
                      },
                      darkTheme: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'asset/img/logo/google.svg',
                            width: 23.0,
                            height: 23.0,
                          ),
                          const SizedBox(width: 16.0),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Palette.light,
                              fontFamily: 'Noto_Sans_KR',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    FitweenButton(
                      onPressed: () {},
                      darkTheme: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'asset/img/logo/apple.svg',
                            width: 23.0,
                            height: 23.0,
                          ),
                          const SizedBox(width: 16.0),
                          const Text(
                            'Continue with Apple',
                            style: TextStyle(
                              color: Palette.light,
                              fontFamily: 'Noto_Sans_KR',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 77.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}