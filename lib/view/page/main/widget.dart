import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 메인 페이지의 위젯 모음

// 메인 페이지 AppBar
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: role == Role.trainee ? Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ) : const Border(),
          leadingWidth: 600.0,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: MainPresenter.toggleRole,
              child: const FWLogo(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              padding: const EdgeInsets.only(right: 20.0),
              onPressed: () {
                print("Not ready yet!");
              },
            ),
          ],
        );
      },
    );
  }
}