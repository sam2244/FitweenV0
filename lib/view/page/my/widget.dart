import 'package:fitween1/global/global.dart';
import 'package:flutter/material.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:get/get.dart';
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
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0.0,
      )
    );
  }
}