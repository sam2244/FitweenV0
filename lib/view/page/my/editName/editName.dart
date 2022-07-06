import 'package:fitween1/presenter/page/my/setting.dart';
import 'package:fitween1/view/page/my/editName/widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 이름 수정 페이지
class EditNamePage extends StatelessWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: const EditNameAppBar(),
          body: Center(
            child: Column(
              children: const [
                NameTextField(),
              ],
            ),
          ),
        );
      }
    );
  }
}
