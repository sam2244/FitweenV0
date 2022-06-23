import 'package:fitween1/config/palette.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/widget/button.dart';
import 'package:fitween1/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    FitweenUser user = Get.put(FitweenUser());
    TextEditingController nicknameCont = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 45.0),
        color: Palette.dark,
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            if (user.nickname == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FitweenText(
                  '별명을 입력하세요.',
                  size: 15.0,
                  color: Palette.light,
                ),
                const SizedBox(height: 8.0),
                FitweenInputField(
                  controller: nicknameCont,
                  onSubmitted: (nickname) {
                    setState(() => user.setNickname(nickname));
                  },
                  hintText: '별명',
                  darkTheme: true,
                ),
              ],
            ),
            if (user.nickname != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FitweenText(
                  '${user.nickname}님은 무엇을 하고 싶으신가요?',
                  size: 15.0,
                  color: Palette.light,
                ),
                const SizedBox(height: 8.0),
                FitweenButton(
                  text: '트레이너로 참여하기',
                  width: double.infinity,
                  darkTheme: true,
                  fill: true,
                  onPressed: () {
                    Get.offAllNamed('/home');
                    user.toggleRole();
                  },
                ),
                const SizedBox(height: 15.0),
                FitweenButton(
                  text: '피트위너로 도전하기',
                  width: double.infinity,
                  darkTheme: true,
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
