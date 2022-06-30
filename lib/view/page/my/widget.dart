import 'package:fitween1/global/global.dart';
import 'package:flutter/material.dart';

// 마이 페이지의 위젯 모음

// 마이 페이지 AppBar

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(),
    );
  }
}