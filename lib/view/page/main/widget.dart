import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 메인 페이지의 위젯 모음

// 메인페이지 AppBar
class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: GetBuilder<UserPresenter>(
        builder: (controller) {
          return AppBar();
        }
      ),
    );
  }
}