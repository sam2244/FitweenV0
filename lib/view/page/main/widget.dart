import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// 메인 페이지의 위젯 모음

// 메인 페이지 AppBar
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: GetBuilder<UserPresenter>(
        builder: (controller) {
          return AppBar(
              shape: role == Role.trainee ? Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor,
                )
            ) : const Border(),
            leadingWidth: 600.0,
            leading:
            Padding(
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(FWLogo.asset),
                ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.calendar_month_outlined),
                padding: EdgeInsets.only(right: 20.0),
                onPressed: () {
                  print("Not ready yet!");
                },
              ),
            ],
          );
        },
      ),
    );
  }
}


// 메인 페이지 Bottom NavigationBar
class MainBottomBar extends StatelessWidget {
  const MainBottomBar({Key? key, required this.role}) : super(key: key);

  final Role role;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_rounded),
            label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'MyPage'),
      ],);
  }
}
