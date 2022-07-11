import 'package:fitween1/global/global.dart';
import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/presenter/page/main/main.dart';
import 'package:fitween1/presenter/page/main/trainee.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/view/widget/button.dart';
import 'package:fitween1/view/widget/image.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// 메인 페이지의 위젯 모음

// 메인 페이지 AppBar
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Size get preferredSize => const Size.fromHeight(appbarHeight);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserPresenter>(
      builder: (controller) {
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leadingWidth: 600.0,
          leading: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: MainPresenter.toggleRole,
              child: const FWLogo(),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              padding: const EdgeInsets.only(right: 20.0),
              onPressed: () {
                print("Not ready yet!");
              },
            ),
          ],
        );
      },
    );
  }
}

class NoPlanWidget extends StatelessWidget {
  final Role role;
  const NoPlanWidget({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/image/page/add_plan/etc.svg',
            height: 300.0.h,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FWText(
              '현재 진행중인 플랜이 없습니다.',
              style: Theme.of(context).textTheme.bodyMedium,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          PlanAddButton(role: role),
        ],
      ),
    );
  }
}

class PlanAddButton extends StatelessWidget {
  const PlanAddButton({Key? key, required this.role}) : super(key: key);

  final Role role;

  @override
  Widget build(BuildContext context) {
    return FWButton(
      width: 193.0.w,
      height: 52.0.h,
      onPressed: {
        Role.trainer: TrainerPresenter.addPlanButtonPressed,
        Role.trainee: TraineePresenter.joinPlanButtonPressed,
      }[role]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Row(
              children: [
                const Icon(Icons.add),
                SizedBox(width: 10.0.w),
                FWText({
                  Role.trainer: '새 플랜 추가하기',
                  Role.trainee: '새 플랜 가입하기',
                }[role]!,
                  style: Theme.of(context).textTheme.labelLarge,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
