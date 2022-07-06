import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/my/setting.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 이름 수정 페이지의 위젯 모음

// 이름 수정 페이지 앱바
class EditNameAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditNameAppBar({Key? key}) : super(key: key);

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
          actions: [
            GetBuilder<SettingPresenter>(
                builder: (controller) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: controller.backPressed,
                  );
                }
            ),
          ],
          elevation: 0.0,
        )
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({Key? key}) : super(key: key);
  static final _nameController = TextEditingController();

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
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: '이름을 입력하세요',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '신장을 입력하세요';
                        }
                        return null;
                      },
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