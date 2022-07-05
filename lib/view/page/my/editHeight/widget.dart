import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/page/my/editHeight.dart';
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
          leading: GetBuilder<EditHeightPresenter>(
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

class HeightTextField extends StatelessWidget {
  static final _heightController = TextEditingController();
  const HeightTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditHeightPresenter>(
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
                    TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: '신장을 입력하세요',
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