import 'package:fitween1/presenter/page/my.dart';
import 'package:fitween1/view/page/setting/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 세팅 페이지
class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const SettingAppBar(),
          body: Center(
            child: Column(
              children: const [
                MyProfileImageButton(),
                NameTextField(),
                HeightTextField(),
                LogOutButton(),
                DeleteUserButton(),
              ],
            ),
          ),
          bottomNavigationBar: const FWBottomBar(),
        );
      }
    );
  }
}
