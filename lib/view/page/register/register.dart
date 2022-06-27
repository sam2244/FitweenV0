import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/register.dart';
import 'package:fitween1/view/page/register/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 회원가입 페이지
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key, this.theme = FWTheme.primaryLight}) : super(key: key);

  final FWTheme theme;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RegisterPresenter>();

    return Scaffold(
      appBar: RegisterAppBar(
        theme: theme,
        onBackPressed: controller.backPressed,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        color: theme.backgroundColor,
        child: CarouselView(theme: theme),
      ),
    );
  }
}
