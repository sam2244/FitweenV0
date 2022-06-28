import 'package:fitween1/global/palette.dart';
import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/view/page/main/trainer/trainer.dart';
import 'package:fitween1/view/page/main/trainee/trainee.dart';
import 'package:fitween1/view/page/scheduler/scheduler.dart';
import 'package:fitween1/view/page/chat/chat.dart';
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
            shape: role == Role.trainer ? const Border(
              bottom: BorderSide(
                color: Palette.dark,
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
                        FWText(controller.user.nickname ?? '', size: 24.0),
                        IconButton(
                          onPressed: () {
                            Get.dialog(const ToggleRoleDialog());
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Palette.dark,
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
                icon: const Icon(
                  Icons.chat,
                  color: Palette.dark,
                ),
              ),
              const IconButton(
                onPressed: MainPresenter.logoutButtonPressed,
                icon: Icon(
                  Icons.logout,
                  color: Palette.dark,
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed('/scheduler'),
                icon: const Icon(
                  Icons.calendar_month,
                  color: Palette.dark,
                ),
              ),
              IconButton(
                onPressed: () => Get.toNamed('/addPlan'),
                icon: const Icon(
                  Icons.person,
                  color: Palette.dark,
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

// 텍스트 파티션 위젯
class TextPartition extends StatelessWidget {
  const TextPartition(this.data, {
    Key? key,
    required this.index,
  }) : super(key: key);

  final String data;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      SizedBox(
        height: 20.0,
        child: Stack(
          children: [
            const Divider(
              color: Palette.grey,
              thickness: 1.0,
            ),
            Positioned(
              left: defaultMargin.width,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Palette.light,
                child: FWText(data, size: 20.0, color: Palette.grey),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: FWText(
          data, size: 14.0,
          weight: FWFontWeight.thin,
          color: Palette.grey,
        ),
      ),
    ];

    return widgets[index];
  }
}

// 메인페이지 하단 바
class MainBottomBar extends StatefulWidget {
  const MainBottomBar({Key? key}) : super(key: key);

  @override
  State<MainBottomBar> createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  late int _selectedIndex = 1;
  static const _pages = <Widget>[
    SchedulerPage(),//this is a stateful widget on a separate file
    TrainerMainPage(),//this is a stateful widget on a separate file
    ChatPage(),//this is a stateful widget on a separate file
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        Get.toNamed('/scheduler');
        //widget = SchedulerPage();
        break;
      case 1:
        Get.toNamed('/main/trainee');
        //widget = TrainerMainPage();
        break;
      case 2:
        Get.toNamed('/chat');
        //widget = ChatPage();
        break;
    }

    return BottomNavigationBar(
      iconSize: 40.0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: '달력',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: '메시지',
        ),
      ],
    );
  }
}
