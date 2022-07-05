import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/my/setting.dart';
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
              ProfileImageCircle(
                size: 100.0,
                user: SettingPresenter.userPresenter.user,
                //onPressed: () => controller.profileImagePressed(Theme.of(context)),
                onPressed: () => controller.profileImageChange(context,Theme.of(context)),
              ),
              FWText(
                "사진 변경", size: 20.0,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          );
        }
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                      child: FWText(
                        "이름",
                        style: Theme.of(context).textTheme.headlineSmall,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => null,
                      child: Stack(
                        children: const <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.keyboard_arrow_right_outlined)
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "이름",
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}

class HeightTextField extends StatelessWidget {
  static final _heightController = TextEditingController();
  const HeightTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
                      child: FWText(
                        "신장",
                        style: Theme.of(context).textTheme.headlineSmall,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => null,
                      child: Stack(
                        children: const <Widget>[
                          Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.keyboard_arrow_right_outlined)
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "신장",
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
                width: 343,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.outline)
                  ),
                  //onPressed: () => controller.AddWeight(Theme.of(context)),
                  onPressed: SettingPresenter.logoutPressed,
                  child: FWText(
                    '로그아웃',
                    size: 15.0,
                    style: Theme.of(context).textTheme.titleMedium,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                width: 343,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.error,
                  ),
                  //onPressed: () => controller.AddWeight(Theme.of(context)),
                  onPressed: () => SettingPresenter.AskDelete(Theme.of(context)),
                  child: FWText(
                    '계정 삭제하기',
                    size: 15.0,
                    style: Theme.of(context).textTheme.titleMedium,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
}