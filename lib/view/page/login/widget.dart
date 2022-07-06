import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 로그인 페이지 관련 위젯 모음

// 로그인 타입
enum LoginType { google, apple }

class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: GetBuilder<FWTheme>(
          builder: (controller) {
            return IconButton(
              icon: Icon(
                controller.mode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              color: Theme.of(context).colorScheme.primary,
              onPressed: controller.toggleMode,
            );
          }
      ),
      actions: [
        TextButton(
          onPressed: () => Get.toNamed('/developer'),
          child: Align(child: FWText('개발')),
        ),
      ],
    );
  }
}


// 로그인 버튼
class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.type,
  }) : super(key: key);

  final LoginType type;

  @override
  Widget build(BuildContext context) {

    const Map<LoginType, Color> fillColor = {
      LoginType.google: FWTheme.white,
      LoginType.apple: FWTheme.dark,
    };

    const Map<LoginType, Color> textColor = {
      LoginType.google: FWTheme.dark,
      LoginType.apple: FWTheme.white,
    };

    return SizedBox(
      width: 285.0,
      child: ElevatedButton(
        onPressed: LoginPresenter.loginButtonPressed(type),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(fillColor[type]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/img/logo/${type.name}.svg',
              width: 23.0,
              height: 23.0,
            ),
            const SizedBox(width: 16.0),
            Text(
              'Continue with ${toBeginningOfSentenceCase(type.name)}',
              style: TextStyle(
                color: textColor[type],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
