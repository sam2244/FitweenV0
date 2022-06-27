import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/login.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// 로그인 페이지 관련 위젯 모음

// 로그인 타입
enum LoginType { google, apple }

// 로그인 버튼
class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.type,
    required this.theme,
    this.fill = false,
  }) : super(key: key);

  final LoginType type;
  final FWTheme theme;
  final bool fill;

  @override
  Widget build(BuildContext context) {
    return FWButton(
      onPressed: LoginPresenter.loginButtonPressed(type),
      theme: theme,
      fill: fill,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/img/logo/${type.name}.svg',
            width: 23.0,
            height: 23.0,
          ),
          const SizedBox(width: 16.0),
          FWText(
            'Continue with ${toBeginningOfSentenceCase(type.name)}',
            color: fill ? theme.backgroundColor : theme.color,
          ),
        ],
      ),
    );
  }
}
