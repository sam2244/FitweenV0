import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/my/setting.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 신장 수정 페이지의 위젯 모음

// 신장 수정 페이지 앱바
class EditHeightAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditHeightAppBar({Key? key}) : super(key: key);

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
                  onPressed: controller.backPressedEditHeight,
                );
              }
          ),
          actions: [
            GetBuilder<SettingPresenter>(
                builder: (controller) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: controller.editHeightDone,
                  );
                }
            ),
          ],
          elevation: 0.0,
        )
    );
  }
}

class HeightTextField extends StatelessWidget {
  const HeightTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingPresenter>(
        builder: (controller) {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                child: FWText(
                  "신장",
                  style: Theme.of(context).textTheme.headlineSmall,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: FWCard(
                  height: 156.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FWNumberPicker(
                        onChanged: (value) => controller.heightSelected(value * .1),
                        value: controller.defaultHeight,
                        step: .1,
                        minValue: FWUser.weightRange.start,
                        maxValue: FWUser.weightRange.end,
                      ),
                      const SizedBox(width: 5.0),
                      FWText('cm', style: Theme.of(context).textTheme.labelLarge),
                    ],
                  ),
                ),
              )
            ],
          );
        },
    );
  }
}