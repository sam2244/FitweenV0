import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/setting.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 설정 페이지의 위젯 모음

// 설정 페이지 앱바
class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: GetBuilder<SettingPresenter>(
              builder: (controller) {
                return IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: controller.backPressed,
                );
              }
          ),
          title: FWText(
            "환경설정", size: 20.0,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            // 확정이 아닙니다. 편의상 놓은 로그아웃 버튼입니다!
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: SettingPresenter.logoutPressed,
            ),
          ],
          elevation: 0.0,
        )
    );
  }
}

class MyProfileImageButton extends StatelessWidget {
  const MyProfileImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Column(
          children: [
            FWText(
              SettingPresenter.userPresenter.user.nickname!, size: 20.0,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        );
      }
    );
  }
}