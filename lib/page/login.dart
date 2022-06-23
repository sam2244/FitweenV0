import 'package:fitween1/config/palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/widget/button.dart';
import 'package:fitween1/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FitweenUser user = Get.find<FitweenUser>();

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

                        // 로그인 성공
                        if (user.logged) {
                          // 닉네임 없으면 회원가입으로 이동
                          if (user.nickname == null) {
                            Get.toNamed('/register');
                          }
                          else {
                            Get.offAllNamed('/main');
                          }
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
                          const FitweenText(
                            'Continue with Google',
                            color: Palette.light,
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
                          const FitweenText(
                            'Continue with apple',
                            color: Palette.light,
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