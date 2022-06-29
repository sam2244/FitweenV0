import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 메인 페이지의 위젯 모음

// 메인페이지 AppBar
class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({Key? key, required this.role}) : super(key: key);

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
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            shape: role == Role.trainer ? Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor,
                width: .5,
              )
            ) : const Border(),
            titleSpacing: 0.0,
            title: Row(
              children: [
                SizedBox(width: defaultMargin.width),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FWText(controller.user.nickname!, size: 24.0),
                        IconButton(
                          onPressed: () {
                            Get.dialog(const ToggleRoleDialog());
                          },
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    FWText(role.kr, size: 12.0, weight: FWFontWeight.thin),
                    const SizedBox(height: 6.5),
                  ],
                ),
                Expanded(child: Container()),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => Get.toNamed('/chat'),
                icon: Icon(
                  Icons.chat,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: MainPresenter.logoutButtonPressed,
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed('/scheduler'),
                icon: Icon(
                  Icons.calendar_month,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed('/addPlan'),
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

// 역할 변경 팝업 위젯
class ToggleRoleDialog extends StatelessWidget {
  const ToggleRoleDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('역할 변경'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Role.values.map((role) => InkWell(
          onTap: MainPresenter.roleSelected(role),
          child: ListTile(
            title: FWText(role.kr),
          ),
        )).toList(),
      ),
      actions: const [
        TextButton(
          onPressed: MainPresenter.dialogClosed,
          child: Text('Close'),
        ),
      ],
    );
  }
}