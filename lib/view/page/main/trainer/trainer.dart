import 'package:fitween1/model/user/user.dart';
import 'package:fitween1/presenter/page/main/trainer.dart';
import 'package:fitween1/view/page/main/trainer/widget.dart';
import 'package:fitween1/view/page/main/widget.dart';
import 'package:fitween1/view/widget/container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 트레이너 메인 페이지
class TrainerMainPage extends StatelessWidget {
  const TrainerMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const MainAppBar(role: Role.trainer),
      body: TrainerView(),
      bottomNavigationBar: GetBuilder<TrainerPresenter>(
        builder: (controller) {
          return controller.selectMode == false
              ? const FWBottomBar()
              : const SelectModeBottomBar();
        },
      ),
    );
  }
}